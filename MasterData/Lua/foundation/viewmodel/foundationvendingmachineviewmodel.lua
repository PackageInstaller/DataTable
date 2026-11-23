local this = {
    vm = nil,
    buildingConfig = nil,
};

local data = {
    damage = "",
    damageValue = 0.0,
    isConsume = false,
    consume = "",
    consumeIcon = DefaultTexture,
    count = "",
    aniName = "",
};


this.SetData = function()
    this.vm.data.isConsume = false;
    this.buildingConfig = PlayerFoundationMgr.GetBuildingConfigByType(4);
    if (this.buildingConfig == nil) then return end
    
    local config = ConfigMgr.Config.VendingMachineList[this.buildingConfig.Level];
    if (config ~= nil) then
        local interaction = DataMgr.Player.interactions[this.buildingConfig.Id];
        if (interaction ~= nil) then
            local current, total = ConfigFoundationMgr.GetVendingMachineDamage(interaction.Count);
            this.vm.data.damage = string.format("%s<color=#ffffff><size=30>%d</size></color>/%d", LuaMgr.GetLangText("FoundationVendingMachineViewModel_0"), current, total);
            this.vm.data.damageValue = current / total;
            if (#config.Cost > 0) then
                local cost = config.Cost[1];
                local item = DataMgr.Player.items[cost.id];
                local itemCount = item ~= nil and item.count0 or 0;
                this.vm.data.consume = string.format("<color=%s>X%d</color>", itemCount >= cost.count and "#c2b49d" or "#c31f36", cost.count);
                this.vm.data.consumeIcon = GetItemTexture(cost.id);
                this.vm.data.isConsume = true;
            end
            this.vm.data.count = string.format(LuaMgr.GetLangText("FoundationVendingMachineViewModel_1"), config.Frequency - interaction.TodayCount);
        end
    end
end


this.OnClose = function()
    LuaMgr.HidePanel(UIName.FoundationVendingMachineViewModel);
end

local command = {
    OnClickClose = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.NextFrame(this.OnClose);
        end
    },
    OnClickDraw = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (this.buildingConfig ~= nil) then
                local config = ConfigMgr.Config.VendingMachineList[this.buildingConfig.Level];
                if (config ~= nil) then
                    if (#config.Cost > 0) then
                        local cost = config.Cost[1];
                        local item = DataMgr.Player.items[cost.id];
                        local itemCount = item ~= nil and item.count0 or 0;
                        if (itemCount >= cost.count) then
                            PlayerFoundationMgr.VendingBuy(this.buildingConfig.Id);
                        else
                            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["6957"].NameLan));
                        end
                    end
                end
            end
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH .. "newUI/foundation_VMdrop.mp3");
        this.SetData();
        vm.data.aniName = "UIFoundationVendingMachinePanel";
    end,
    before_deactive = function(vm)
        this.buildingConfig = nil;
        vm.data.aniName = "";
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})