require("ViewModel/Rogue/Rogue_ExploreBuffItem")

local this = {
    vm = nil,
    buffUIList={},
    exploreBuffItemObj=nil;
    
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
    ui.btnMask = uiLink:Get("btnMask"):GetComponent("Button");
    ui.btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");

    this.AddRegister(uiLink)
end

this.ClearUI = function()
    ui = nil
end

this.AddRegister=function(uiLink)
    uiLink:AddClickEvent("btnMask",function()
        LuaMgr.HidePanel(UIName.RogueExploreBuffPopupViewModel)
    end)
    uiLink:AddClickEvent("btnClose",function()
        LuaMgr.HidePanel(UIName.RogueExploreBuffPopupViewModel)
    end)
end


local data = {

}
local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        RedMgr.Singleton:RegisterViewModel(UIName.KZRYExploreViewModel);
        print("before_awake");
        this.InitUI(vm.behaviour)
        this.buffUIList = UIListView.New(ui.tranContent);
        this.exploreBuffItemObj = vm.behaviour.transform:Find("template/buffItem").gameObject
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then           
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if this.buffUIList ~= nil then
            this.buffUIList:Clear();
        end
    end,
    before_destroy = function()
        this.ClearUI()
        UIListView.ClearItem("Rogue_ExploreBuffItem")
    end
}

this.ParseData=function()
    this.buffList={}
    if not IsNull(DataMgr.Player.Rogue) and not IsNull(DataMgr.Player.Rogue.GlobalBuffIds) then
        this.buffList=DataMgr.Player.Rogue.GlobalBuffIds;
    end
    this.SetBuffList();
end

this.SetBuffList=function()
    this.buffUIList:Clear();
    local list={}
    for i,v in ipairs(this.buffList) do
        local buffInfo=ConfigMgr.Config.RogueBuffDescMap[v];
        if buffInfo~=nil then
            local buffItem={
                icon=buffInfo.BuffIcon;
                name=LuaMgr.GetLangText(buffInfo.BuffNameLan),
                des=LuaMgr.GetLangText(buffInfo.BuffDesLan),
            }
            local buffData=UIListData.GetData(this.exploreBuffItemObj,"Rogue_ExploreBuffItem",buffItem);
            table.insert(list,buffData)
        end
    end
    this.buffUIList:SetData(list);
end

return vm({
    data = data,
    command = command,
    hook = hook
})