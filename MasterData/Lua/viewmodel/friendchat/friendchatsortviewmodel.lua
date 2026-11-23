





require("ViewModel/FriendChat/FriendChat_SortItem")

local this = {vm = nil,
              sortUIList=nil;
              sortItemObj=nil;
}
local sortNames={};
local callBack=nil;

local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local btnMask = nil;
local btnClose = nil;
local btnConfirm = nil;
local tranListView = nil;


this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    btnConfirm = uiLink:Get("btnConfirm"):GetComponent("Button");
    tranListView = uiLink:Get("tranListView"):GetComponent("RectTransform");
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.FriendChatSortViewModel)
    end)
    uiLink:AddClickEvent("btnClose",function()
        LuaMgr.HidePanel(UIName.FriendChatSortViewModel)
    end)
    uiLink:AddClickEvent("btnConfirm",function()
        if callBack~=nil then
            callBack();
        end
        LuaMgr.HidePanel(UIName.FriendChatSortViewModel)
    end)
   
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    btnMask = nil;
    btnClose = nil;
    btnConfirm = nil;
    tranListView = nil;

end




local data = {
}

local command = {
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.Init(vm.behaviour);
        sortNames={LuaMgr.GetLangText("FriendChatSortViewModel_0"),LuaMgr.GetLangText("FriendChatSortViewModel_1"),LuaMgr.GetLangText("FriendChatSortViewModel_2")}
        this.sortUIList=UIListView.New(tranListView);
        this.sortItemObj=vm.behaviour.transform:Find("template/sortItem").gameObject;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        callBack=vm.behaviour.Params[0];
        this.ParseData();
      
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
    before_destroy=function()
        UIListView.ClearItem("FriendChat_SortItem")
        this.Clear();
    end
}


this.ParseData=function()
    this.SetSortList();
end

this.SetSortList=function()
    local list={};
    for i,v in ipairs(sortNames) do
        local sortItem={
            index=i,
            name=v;
            isOn=false;
            sortDir=0;
            callBack=this.ClickCallBack
        }
        if i==1 then
            sortItem.isOn=true;
            sortItem.sortDir=FriendChatMgr.SortType.CreateTime;
        elseif i==2 then
            sortItem.isOn=not FriendChatMgr.SortType.GroupChat;
        elseif i==3 then
            sortItem.isOn= FriendChatMgr.SortType.GroupChat;
        end
        local sortData=UIListData.GetData(this.sortItemObj,"FriendChat_SortItem",sortItem)
        table.insert(list,sortData);
    end
    this.sortUIList:SetData(list);
end

this.ClickCallBack=function(index)
    if index==1 then
        FriendChatMgr.SortType.CreateTime=FriendChatMgr.SortType.CreateTime>0 and -1 or 1;
    else
        FriendChatMgr.SortType.GroupChat=index==3;
    end
    this.SetSortList();
end

return vm({
    data = data,
    command = command,
    hook = hook
})