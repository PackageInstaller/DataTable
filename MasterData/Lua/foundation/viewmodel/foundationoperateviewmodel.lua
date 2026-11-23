local data = {
    isUpLvBtn = false,
    isHeroBtn = false,
    isMakeBtn = false,
    isComposeBtn = false,
    isDecomposeBtn = false,
    isBgmBtn = false,
    isZBZZBtn = false,
    isVendingMachineBtn = false,
    isArrangeBtn = false,
    isTeamWeapon = false,
    infoPos = Vector3(0,0,0),
    upLvPos = Vector3(0,0,0),
    heroPos = Vector3(0,0,0),
    makePos = Vector3(0,0,0),
    composePos = Vector3(0,0,0),
    decomposePos = Vector3(0,0,0),
    bgmPos = Vector3(0,0,0),
    zbzzPos = Vector3(0,0,0),
    vendingMachinePos = Vector3(0,0,0),
    arrangePos = Vector3(0,0,0),
    teamWeaponPos = Vector3(0,0,0),
};

local this = {
    vm = nil,
    container = nil,
    operateView = nil,
    operatePos = Vector3(0,0,0),
    building = nil,
    posList = {
        {Vector3(59,0,0)},
        {Vector3(59,53,0),Vector3(59,-53,0)},
        {Vector3(59,80,0),Vector3(129,0,0),Vector3(59,-80,0)},
        {Vector3(59,133,0),Vector3(129,53,0),Vector3(129,-53,0),Vector3(59,-133,0)},
        {Vector3(59,160,0),Vector3(129,80,0),Vector3(199,0,0),Vector3(129,-80,0),Vector3(59,-160,0)},
        {Vector3(59,213,0),Vector3(129,133,0),Vector3(199,53,0),Vector3(199,-53,0),Vector3(129,-133,0),Vector3(59,-213,0)}},
};


this.Refresh = function()
    if (this.vm.behaviour.Params == nil) then return end

    this.building = this.vm.behaviour.Params[0];
    if (this.building == nil or this.building.config == nil) then return end

    local config = this.building.config;
    this.SetButtons(config);
    local camera = this.vm.behaviour.Params[1];
    local screenRatioOffset = FoundationMgr.ScreenRatioOffset();
    local pos = RectTransformTool.ToContainer(camera, this.building.transform, this.container);
    this.operatePos.x = pos.x + config.MenuPos[1];
    this.operatePos.y = pos.y + config.MenuPos[2] + screenRatioOffset * 300;
    this.operateView.localPosition = this.operatePos;
end


this.SetButtons = function(config)
    local count = 1;
    local isUpLevel = PlayerFoundationMgr.IsUpLevel(config.Id);
    if (isUpLevel) then
        this.vm.data.isUpLvBtn = false;
    else
        local nextConfig = ConfigFoundationMgr.GetInteractionByGroupLevel(config.Group, config.Level + 1);
        if (nextConfig ~= nil) then
            this.vm.data.isUpLvBtn = true;
            count = count + 1;
        else
            this.vm.data.isUpLvBtn = false;
        end
    end
    this.vm.data.isHeroBtn = false;
    this.vm.data.isMakeBtn = false;
    this.vm.data.isComposeBtn = false;
    this.vm.data.isDecomposeBtn = false;
    this.vm.data.isBgmBtn = false;
    this.vm.data.isZBZZBtn = false;
    this.vm.data.isVendingMachineBtn = false;
    this.vm.data.isArrangeBtn = false;
    this.vm.data.isTeamWeapon = false;
if (config.Type == 1) then
        if (not isUpLevel) then
            this.vm.data.isHeroBtn = true;
            count = count + 1;
        end
elseif (config.Type == 2) then
        if (not isUpLevel) then
            this.vm.data.isHeroBtn = true;
            if (config.Group == "303") then
                this.vm.data.isArrangeBtn = true;
            else
                this.vm.data.isMakeBtn = true;
            end
            count = count + 2;
        end
elseif (config.Type == 3) then
        
elseif (config.Type == 4) then
        if (not isUpLevel and not PlayerFoundationMgr.IsVendingMachineInStock(config.Id) and PlayerFoundationMgr.IsVendingMachineCount(config.Id)) then
            this.vm.data.isVendingMachineBtn = true;
            count = count + 1;
        end
elseif (config.Type == 5) then
        if (not isUpLevel) then
            this.vm.data.isBgmBtn = true;
            count = count + 1;
        end
elseif (config.Type == 6) then
        
elseif (config.Type == 7) then
        if (not isUpLevel) then
            this.vm.data.isZBZZBtn = true;
            count = count + 1;
        end
elseif (config.Type == 8) then
        
elseif (config.Type == 9) then
        if (not isUpLevel) then
            this.vm.data.isComposeBtn = true;
            count = count + 1;
        end
elseif (config.Type == 14) then
        if (not isUpLevel) then
            this.vm.data.isTeamWeapon = true;
            count = count + 1;
        end
    end
    this.SetButtonPos(count);
end


this.SetButtonPos = function(count)
    local posList = this.posList[count];
    local index = 1;
    this.vm.data.infoPos = posList[index];
    index = index + 1;
    if (this.vm.data.isUpLvBtn) then
        this.vm.data.upLvPos = posList[index];
        index = index + 1;
    end
    if (this.vm.data.isHeroBtn) then
        this.vm.data.heroPos = posList[index];
        index = index + 1;
    end
    if (this.vm.data.isMakeBtn) then
        this.vm.data.makePos = posList[index];
        index = index + 1;
    end
    if (this.vm.data.isArrangeBtn) then
        this.vm.data.arrangePos = posList[index];
        index = index + 1;
    end
    if (this.vm.data.isComposeBtn) then
        this.vm.data.composePos = posList[index];
        index = index + 1;
    end
    if (this.vm.data.isDecomposeBtn) then
        this.vm.data.decomposePos = posList[index];
        index = index + 1;
    end
    if (this.vm.data.isBgmBtn) then
        this.vm.data.bgmPos = posList[index];
        index = index + 1;
    end
    if (this.vm.data.isZBZZBtn) then
        this.vm.data.zbzzPos = posList[index];
        index = index + 1;
    end
    if (this.vm.data.isVendingMachineBtn) then
        this.vm.data.vendingMachinePos = posList[index];
        index = index + 1;
    end
    if (this.vm.data.isTeamWeapon) then
        this.vm.data.teamWeaponPos = posList[index];
        index = index + 1;
    end
end


this.ClosePanel = function()
    LuaMgr.HidePanel(UIName.FoundationOperateViewModel);
end

local command = {
    OnClickInfo = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.FoundationBuildingInfoViewModel, this.building.config.Id);
            LuaMgr.NextFrame(this.ClosePanel);
        end
    },
    OnClickUpLv = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.FoundationUpLevelViewModel, this.building.config.Id);
            LuaMgr.NextFrame(this.ClosePanel);
        end
    },
    OnClickHero = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.FoundationBuildingHeroViewModel, this.building.config.Id);
            LuaMgr.NextFrame(this.ClosePanel);
        end
    },
    OnClickMake = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FoundationMgr.SetMakeId(nil);
            LuaMgr.ShowLuaPanel(UIName.FoundationMakeViewModel, this.building.config.Id);
            LuaMgr.NextFrame(this.ClosePanel);
        end
    },
    OnClickArrange = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FoundationMgr.SetMakeId(nil);
            LuaMgr.ShowLuaPanel(UIName.FoundationMakeViewModel, this.building.config.Id);
            LuaMgr.NextFrame(this.ClosePanel);
        end
    },
    OnClickCompose = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            FoundationMgr.SetComposeId(nil);
            LuaMgr.ShowLuaPanel(UIName.FoundationComposeViewModel, this.building.config.Id);
            LuaMgr.NextFrame(this.ClosePanel);
        end
    },
    OnClickDecompose = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            
        end
    },
    OnClickBgm = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.FoundationBgmViewModel);
            LuaMgr.NextFrame(this.ClosePanel);
        end
    },
    OnClickZBZZ = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (FeatureManager.GotoPanel("1031")) then
                RedMgr.Singleton:FrushRedCondition("1020_main");
            end
            LuaMgr.NextFrame(this.ClosePanel);
        end
    },
    OnClickVendingMachine = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.FoundationVendingMachineViewModel);
            LuaMgr.NextFrame(this.ClosePanel);
        end
    },
    OnClickTeamWeapon = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.TeamWeaponViewModel);
            LuaMgr.NextFrame(this.ClosePanel);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.container = vm.behaviour.transform:Find("root/Middle");
        this.operateView = vm.behaviour.transform:Find("root/Middle/OperateView");
    end,
    before_active = function(vm)
        this.Refresh();
    end,
    refresh = function(vm)
        this.Refresh();
    end,
    before_deactive = function(vm)
        this.building = nil;
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})