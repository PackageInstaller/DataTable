local data = {
    buildingName = "",
    isLevel = false,
    buildingLevel = "",
    effectList = {{text="",text1=""}},
    descText = "",
    aniName = "",
};

local this = {
    vm = nil,
    id = "",
};


this.SetData = function()
    local config = ConfigFoundationMgr.GetInteractionById(this.id);
    if (config ~= nil) then
        this.vm.data.buildingName = LuaMgr.GetLangText(config.NameLan);
        this.vm.data.isLevel = config.Hide == 0;
        this.vm.data.buildingLevel = "LV" .. config.Level;
        this.vm.data.descText = LuaMgr.GetLangText(config.DescribeLan);
        this.SetEffect(config);
    end
end


this.SetEffect = function(config)
    local item;
    local obj;
    local list = {};
    local len = #config.Effect;
    for i = 1, len do
        obj = config.Effect[i];
        item = {text=LuaMgr.GetLangText(obj[1]),text1=obj[2]};
        table.insert(list, item);
    end
    this.vm.data.effectList = list;
end

this.OnClose = function()
    LuaMgr.HidePanel(UIName.FoundationBuildingInfoViewModel);
end

local command = {
    OnClickMask = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.NextFrame(this.OnClose);
        end
    },
    OnClickConfirm = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.NextFrame(this.OnClose);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (this.vm.behaviour.Params == nil) then return end
        
        this.id = this.vm.behaviour.Params[0];
        this.SetData();
        this.vm.data.aniName = "UI_FoundationBuildingHeroPanel";
    end,
    before_deactive = function(vm)

    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})