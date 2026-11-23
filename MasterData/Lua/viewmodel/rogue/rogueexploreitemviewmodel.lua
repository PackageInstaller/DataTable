require("ViewModel/Rogue/Rogue_ExploreEventItem")

local this = {
    vm = nil,
    itemUIList={},
};


local ui ={}

this.InitUI= function(prefab)
    ui.tarGameObject = prefab
    ui.tarRect = prefab.gameObject:GetComponent("RectTransform")
    local uiLink = prefab.gameObject:GetComponent("UILinkLua");
    ui.root = uiLink:Get("root");
    ui.Left = uiLink:Get("Left");
    ui.Right = uiLink:Get("Right");
    ui.Middle = uiLink:Get("Middle");
    ui.btnClose = uiLink:Get("btnClose"):GetComponent("Button");
    ui.ScrollView = uiLink:Get("ScrollView"):GetComponent("ScrollRect");
    ui.tranContent = uiLink:Get("tranContent"):GetComponent("RectTransform");

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
        this.itemUIList = UIListView.New(ui.tranContent);
        this.eventItemObj = vm.behaviour.transform:Find("template/eventItem").gameObject
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then           
            this.ParseData();
        end
    end,
    before_deactive = function(vm)
        print("before_deactive");
        if this.itemUIList~= nil then
            this.itemUIList:Clear();
        end
    end,
    before_destroy = function()
        this.ClearUI()
    end
}

this.ParseData=function()
    
end

return vm({
    data = data,
    command = command,
    hook = hook
})