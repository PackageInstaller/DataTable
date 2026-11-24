require("ViewModel/FriendChat/FriendChat_FaceItem")
require("ViewModel/FriendChat/FriendChat_FaceBarItem")

local this = {vm = nil,
              faceBarUIList=nil;
              faceItemUIList=nil;
              faceBarItemObj=nil;
              faceItemObj=nil;
}
local callBack=nil;
local emotesMapList={};
local emotesKeyList={}

local barIndex=nil;
local cfgFriendEmotes=nil;



local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local btnClose = nil;
local tranFaces = nil;
local tranFaceContent = nil;
local tranFaceBarContent = nil;
local txtTip = nil;
local ScrollView = nil;
local imgBG=nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    tranFaces = uiLink:Get("tranFaces"):GetComponent("RectTransform");
    tranFaceContent = uiLink:Get("tranFaceContent"):GetComponent("RectTransform");
    tranFaceBarContent = uiLink:Get("tranFaceBarContent"):GetComponent("RectTransform");
    txtTip = uiLink:Get("txtTip"):GetComponent("Text");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    imgBG=uiLink:Get("imgBG"):GetComponent("Image");
    uiLink:AddClickEvent("btnClose",function()
        LuaMgr.HidePanel(UIName.GuildChatFaceViewModel)
    end)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    btnClose = nil;
    tranFaces = nil;
    tranFaceContent = nil;
    tranFaceBarContent = nil;
    txtTip = nil;
    ScrollView = nil;
    imgBG=nil;
end



local data = {
}

local command = {
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.Init(vm.behaviour);
        this.faceBarUIList=UIListView.New(tranFaceBarContent);
        this.faceItemUIList=UIListView.New(tranFaceContent);
        this.faceBarItemObj=vm.behaviour.transform:Find("template/faceBarItem").gameObject;
        this.faceItemObj=vm.behaviour.transform:Find("template/faceItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        callBack=vm.behaviour.Params[0];
        cfgFriendEmotes=ConfigMgr.Config.FriendEmotes;
        barIndex=1;
        this.ParseCfg();
        this.ParseData();

    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.faceBarUIList:Clear();
        this.faceItemUIList:Clear();
    end,
    before_destroy=function()
        UIListView.ClearItem("FriendChat_FaceItem")
        UIListView.ClearItem("FriendChat_FaceBarItem")
        this.Clear();
    end
}

this.ParseCfg=function()
    emotesMapList={};
    emotesKeyList={};
    for i,v in ipairs(cfgFriendEmotes) do
        if LuaMgr.Timestamp()>=v.Open and v.State=="1" then
            if emotesMapList[v.Group]==nil then
                emotesMapList[v.Group]={};
                table.insert(emotesKeyList,v.Group);
            end
            table.insert(emotesMapList[v.Group],v);
        end
    end
    table.sort(emotesKeyList,function(a, b) return a<b end);
end

this.ParseData=function()

    this.SetBarUIList();
    this.SetFacesList();
end

this.SetBarUIList=function()
    local list={}
    for i,v in ipairs(emotesKeyList) do
        local barItem={
            index=i,
            barSprite=LuaMgr.GetSprite("FriendChatFace",emotesMapList[v][1].Picture),
            isOn=i==barIndex,
            barCallBack=this.BarCallBack,
        }
        local barItemData=UIListData.GetData(this.faceBarItemObj,"FriendChat_FaceBarItem",barItem);
        table.insert(list,barItemData);
    end
    this.faceBarUIList:SetData(list);
end

this.BarCallBack=function(index)
    if barIndex==index then return end;
    for i,v in ipairs(this.faceBarUIList.itemList) do
        v:SetIsOn(i==index);
    end
    barIndex=index;
    this.SetFacesList();
end


this.SetFacesList=function()
    local list={}
    local key=emotesKeyList[barIndex]
    if key==nil then return end;
    local emoteFaces=emotesMapList[key];
    if emoteFaces==nil then return end;
    txtTip.text=LuaMgr.GetLangText(emoteFaces[1].TitleLan);
    for i,v in ipairs(emoteFaces) do
        local faceItem={
            index=i,
            faceSprite=LuaMgr.GetSprite("FriendChatFace",v.Picture),
            faceCallBack=this.FaceCallBack,
        }
        local faceData=UIListData.GetData(this.faceItemObj,"FriendChat_FaceItem",faceItem);
        table.insert(list,faceData);
    end
    this.faceItemUIList:SetData(list);

end

this.FaceCallBack=function(index)
    if callBack~=nil then
        callBack(emotesMapList[barIndex][index].Picture)
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})