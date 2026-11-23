local this = {
    vm = nil,
};

local data = {
    isRoot = false,
    isQuickBar = false,
    isUpArrow = false,
    isDownArrow = false,
    isWeaponLock = false,
    isTeamWeaponLock = false,
    isTeamWeaponRedAcitve = false,
    isExpLock = false,
    isItemLock = false,
    isComposeLock = false,
};


this.OnBack = function()
    LuaMgr.GoToHome(nil, nil, false);
end


this.OnHideRoot = function(args)
    this.vm.data.isRoot = false;
end


this.CheckUpLevel = function(id)
    if (PlayerFoundationMgr.IsUpLevel(id)) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("6118"));
        return true;
    end
    return false;
end

local command = {
    OnClickQuick = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local isQuickBar = not vm.data.isQuickBar;
            vm.data.isQuickBar = isQuickBar;
            vm.data.isUpArrow = not isQuickBar;
            vm.data.isDownArrow = isQuickBar;
        end
    },
    OnClickCompose = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (not FoundationMgr.IsOutsideClick()) then return end
            
            local config = PlayerFoundationMgr.GetBuildingConfigByGroup("201");
            if (config == nil) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("6117"));
                return;
            end
            if (this.CheckUpLevel(config.Id)) then return end
            
            FoundationMgr.Enter(FoundationMgr.Working);
            FoundationMgr.SetComposeId(nil);
            LuaMgr.ShowLuaPanel(UIName.FoundationComposeViewModel, config.Id);
        end
    },
    OnClickExp = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (not FoundationMgr.IsOutsideClick()) then return end
            
            local config = PlayerFoundationMgr.GetBuildingConfigByGroup("303");
            if (config == nil) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("6117"));
                return;
            end
            if (this.CheckUpLevel(config.Id)) then return end
            
            PlayerItemMgr.SetTipsItem("2101");
            FoundationMgr.Enter(FoundationMgr.Office);
            LuaMgr.ShowLuaPanel(UIName.FoundationMakeViewModel, config.Id);
        end
    },
    OnClickItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (not FoundationMgr.IsOutsideClick()) then return end
            
            local config = PlayerFoundationMgr.GetBuildingConfigByGroup("202");
            if (config == nil) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("6117"));
                return;
            end
            if (this.CheckUpLevel(config.Id)) then return end
            
            FoundationMgr.Enter(FoundationMgr.Working);
            FoundationMgr.SetMakeId(nil);
            LuaMgr.ShowLuaPanel(UIName.FoundationMakeViewModel, config.Id);
        end
    },
    OnClickWeapon = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (not FoundationMgr.IsOutsideClick()) then return end
            
            if (FeatureManager.IsLock("1031")) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("1031"));
                return;
            end
            FoundationMgr.Enter(FoundationMgr.Working);
            LuaMgr.ShowLuaPanel(UIName.WeaponMakeViewModel);
        end
    },
    OnClickTeamWeapon = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (not FoundationMgr.IsOutsideClick()) then return end
            
            if (FeatureManager.IsLock("33001")) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, FeatureManager.TipStr("33001"));
                return;
            end
            FoundationMgr.Enter(FoundationMgr.Office);
            LuaMgr.ShowLuaPanel(UIName.TeamWeaponViewModel);
        end
    },
    OnClickReceive = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            PlayerFoundationMgr.GetAllRewards(0);
        end
    },
    OnClickFriendly = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            PlayerFoundationMgr.GetAllPrestige();
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        RedMgr.Singleton:RegisterViewModel(UIName.FoundationViewModel)
        LuaMgr.AddUIEventListener(UIEventConst.FoundationHideRoot, this.OnHideRoot);
        vm.behaviour:UpdateTopBar("FoundationOutside", this.OnBack);
        vm.data.isRoot = true;
        vm.data.isQuickBar = true;
        vm.data.isUpArrow = false;
        vm.data.isDownArrow = true;
        vm.data.isWeaponLock = FeatureManager.IsLock("1031");
        vm.data.isTeamWeaponLock = FeatureManager.IsLock("33001");
        vm.data.isExpLock = FeatureManager.IsLock("1322");
        vm.data.isItemLock = FeatureManager.IsLock("1321");
        vm.data.isComposeLock = PlayerFoundationMgr.GetBuildingConfigByGroup("201") == nil;

        HeroRedDataHelper.RefreshMiniGameRed();

        local cultivateRed = TeamWeaponMgr.CheckAllTeamWeaponCultivateRed()
        local totalLevelRed = TeamWeaponMgr.CheckTotalLevelRed()
        vm.data.isTeamWeaponRedAcitve = (cultivateRed + totalLevelRed) > 0
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.FoundationHideRoot, this.OnHideRoot);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})