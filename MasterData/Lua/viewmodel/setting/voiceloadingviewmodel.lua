





require("ViewModel/Setting/VoiceLoading_VoiceItem")
local this = {
    vm=nil,
    loadUIList={},
};
local resLoadList={}
local loadDataMap={}
local loadItemObj=nil;
local data={}
local command={}


local tarGameObject = nil;
local tarRect = nil;
local root = nil;
local Left = nil;
local Middle = nil;
local Right = nil;
local ScrollView = nil;
local tranContent = nil;
local btnCancel = nil;
local btnJump = nil;

this.Init = function(prefab)
    tarGameObject = prefab
    tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILink");
    root = uiLink:Get("root");
    Left = uiLink:Get("Left");
    Middle = uiLink:Get("Middle");
    Right = uiLink:Get("Right");
    ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    btnCancel = uiLink:Get("btnCancel"):GetComponent("Button");
    btnJump = uiLink:Get("btnJump"):GetComponent("Button");
    uiLink:AddClickEvent("btnCancel",this.OnClickCancelCommand)
    uiLink:AddClickEvent("btnJump",this.OnClickJumpCommand)
end


this.Clear = function()
    tarGameObject = nil
    tarRect = nil
    root = nil;
    Left = nil;
    Middle = nil;
    Right = nil;
    ScrollView = nil;
    tranContent = nil;
    btnCancel = nil;
    btnJump = nil;

end

this.OnClickCancelCommand=function()
    LuaMgr.HidePanel(UIName.VoiceLoadingViewModel)
end

this.OnClickJumpCommand=function()
    
end

this.SelectLoadingCallback=function(id,isOn)
    if isOn then
        if loadDataMap[id]==nil then
            loadDataMap[id]=true
        else
            LuaDebug.error("error,voiceLoad select")
        end
    else
        if loadDataMap[id]~=nil then
            loadDataMap[id]=nil
        else
            LuaDebug.error("error,voiceLoad select")
        end
    end
end

local hook = {
    before_awake = function(vm)
        this.vm=vm;
        this.Init(vm.behaviour)
        loadItemObj=vm.behaviour.transform:Find("template/voiceItem").gameObject;
        this.loadUIList=UIListView.New(tranContent)
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        this.loadUIList:Clear();
    end,
    before_destroy=function()
        UIListView.ClearItem("VoiceLoading_VoiceItem")
        this.Clear()
    end
}

this.ParseData=function()
    resLoadList={}
    loadDataMap={}
    for i,v in pairs(ConfigMgr.Config.RESDownloadMap) do
        table.insert(resLoadList,v);
    end
    table.sort(resLoadList,function(a, b) return a.Id<b.Id end);
    this.SetLoadList();
end

this.SetLoadList=function()
    local dataList={}
    for i,v in ipairs(resLoadList) do
        if v.RESOn==1 then
            local loadItem={
                des1=LuaMgr.GetLangText(v.RESDescription2Lan);
                des2=LuaMgr.GetLangText(v.RESDescription3Lan);
                id=v.Id,
                isLoaded=false,
                callBack=this.SelectLoadingCallback;
            } 
            local loadData=UIListData.GetData(loadItemObj,"VoiceLoading_VoiceItem",loadItem)
            table.insert(dataList,loadData);
        end
       
    end
    this.loadUIList:SetData(dataList,true);
    local height=0;
    for i,v in ipairs(this.loadUIList.itemList) do
        v.transform.anchoredPosition=Vector2(0,height)
        height=height-v.height;
    end
    tranContent.sizeDelta=Vector2(624,-height-50)
end


return vm({
    data = data,
    command = command,
    hook = hook
})