require("ViewModel/Rogue/Rogue_ExploreEventItem")

local this = {
    vm = nil,
    eventUIList={},
    eventItemObj=nil;
    
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Middle = uiLink:Get("Middle");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.txtTitle = uiLink:Get("txtTitle"):GetComponent("Text");
    ui.txtInfo = uiLink:Get("txtInfo"):GetComponent("Text");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");
    ui.rawIcon = uiLink:Get("rawIcon"):GetComponent("RawImage");

    this.AddRegister(uiLink)
end


this.ClearUI = function()
    ui = nil
end


this.AddRegister=function(uiLink)
    
end


local data = {

}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        print("before_awake");
        this.InitUI(vm.behaviour)
        this.eventUIList = UIListView.New(ui.tranContent);
        this.eventItemObj = vm.behaviour.transform:Find("template/eventItem").gameObject
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            if vm.behaviour.Params.Length>1 then
                this.cfgEvent=vm.behaviour.Params[0];
                this.callBack=vm.behaviour.Params[1];
                LuaMgr.RemoveUIEventListener(UIEventConst.RogueUpdateEventOption,this.UpdateEventInfo)
                LuaMgr.AddUIEventListener(UIEventConst.RogueUpdateEventOption,this.UpdateEventInfo)
                this.ParseData();
            end
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if this.eventUIList~= nil then
            this.eventUIList:Clear();
        end
        LuaMgr.RemoveUIEventListener(UIEventConst.RogueUpdateEventOption,this.UpdateEventInfo)
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Rogue_ExploreEventItem")
    end
}


this.UpdateEventInfo=function(params)
    if params.Length>1 then
        this.cfgEvent=params[0];
        this.callBack=params[1];
        this.SetEventInfo(this.cfgEvent);
    end
end


this.ParseData=function()
   this.SetEventInfo(this.cfgEvent)
end

this.SetEventInfo=function(cfgEvent)
this.isWaiting=false;
    ui.rawIcon.texture=LuaMgr.GetTexture(string.format("Images/Rogue/%s.png",this.cfgEvent.Icon));
    ui.txtTitle.text=LuaMgr.GetLangText(cfgEvent.NameLan);
    ui.txtInfo.text=LuaMgr.GetLangText(cfgEvent.DescLan);
    local optionName=LuaMgr.GetLangText(cfgEvent.OptionNameLan);
    local options=NumTool.split(optionName,"_")
    if #options>0 then
        this.SetOptionList(options);
    end
end

this.SetOptionList=function(options)
    this.eventUIList:Clear();
    local list={}
    for i,v in ipairs(options) do
        local optionItem={
            index=i,
            title=v,
            callBack=this.OptionCallBack,
        }
        local optionData=UIListData.GetData(this.eventItemObj,"Rogue_ExploreEventItem",optionItem);
        table.insert(list,optionData);
    end
    this.eventUIList:SetData(list);
end

this.OptionCallBack=function(optionIndex)
    if this.callBack~=nil and not this.isWaiting then
        this.isWaiting=true;
        this.callBack(optionIndex);
    end
end


return vm({
    data = data,
    command = command,
    hook = hook
})