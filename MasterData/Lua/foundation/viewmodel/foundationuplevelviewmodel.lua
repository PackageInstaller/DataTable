local data = {
    buildingName = "",
    buildingLevel = "",
    effectList = {{text="",text1="",text2="",isArrow=false}},
    consumeList = {{consume="", goods={
        id="",count="",isCount=false,
        rare=DefaultSprite,
        icon=DefaultTexture,
        scale=Vector3.zero,
        sizeDelta=Vector2.zero,
        isClick=true}}},
    isCondition = false,
    condition = "",
    isConfirm = false,
    isConfirm2 = false,
    aniName = "",
};

local this = {
    vm = nil,
    id = "",
};

this.OnClose = function()
    LuaMgr.HidePanel(UIName.FoundationUpLevelViewModel);
end


this.SetData = function()
    local config = ConfigFoundationMgr.GetInteractionById(this.id);
    if (config == nil) then return end
    
    this.vm.data.buildingName = LuaMgr.GetLangText(config.NameLan);
    this.vm.data.buildingLevel = "LV" .. config.Level;
    this.SetCondition(config);
    this.SetEffect(config);
    this.SetConsume(config);
end


this.SetCondition = function(config)
    local nextConfig = ConfigFoundationMgr.GetInteractionByGroupLevel(config.Group, config.Level + 1);
    if (nextConfig ~= nil and not IsNullOrEmpty(nextConfig.UnlockCond)) then
        local areaEvent = DataMgr.Player.completedAreaEvents[nextConfig.UnlockCond];
        if (areaEvent == nil) then
            this.vm.data.condition = LuaMgr.GetLangText(nextConfig.UnloctipsLan);
            this.vm.data.isCondition = true;
            this.vm.data.isConfirm = false;
            this.vm.data.isConfirm2 = true;
        else
            this.vm.data.condition = "";
            this.vm.data.isCondition = false;
            this.vm.data.isConfirm = true;
            this.vm.data.isConfirm2 = false;
        end
        return;
    end
    local mainConfig = PlayerFoundationMgr.GetMainInteraction();
    if (mainConfig ~= nil and mainConfig.Id ~= this.id) then
        nextConfig = ConfigFoundationMgr.GetInteractionByGroupLevel(config.Group, config.Level + 1);
        if (nextConfig ~= nil) then
            if (mainConfig.Level >= nextConfig.Unlock) then
                this.vm.data.condition = "";
                this.vm.data.isCondition = false;
                this.vm.data.isConfirm = true;
                this.vm.data.isConfirm2 = false;
            else
                local str = LuaMgr.GetLangText("FoundationUpLevelViewModel_12");
                str = string.format(str, LuaMgr.GetLangText(mainConfig.NameLan), "", nextConfig.Unlock, "");
                this.vm.data.condition = str;
                this.vm.data.isCondition = true;
                this.vm.data.isConfirm = false;
                this.vm.data.isConfirm2 = true;
            end
            return;
        end
    end
    this.vm.data.condition = "";
    this.vm.data.isCondition = false;
    this.vm.data.isConfirm = true;
    this.vm.data.isConfirm2 = false;
end


this.SetEffect = function(config)
    local item;
    local obj;
    local arrow;
    local list = {};
    local len = #config.UpEffect;
    for i = 1, len do
        obj = config.UpEffect[i];
        arrow = obj[2] ~= "" and obj[3] ~= "";
        item = {text=LuaMgr.GetLangText(obj[1]),text1=obj[2],text2=obj[3],isArrow=arrow};
        table.insert(list, item);
    end
    this.vm.data.effectList = list;
end


this.SetConsume = function(config)
    local list = {};
    local nextConfig = ConfigFoundationMgr.GetInteractionByGroupLevel(config.Group, config.Level + 1);
    if (nextConfig ~= nil) then
        if (not IsNull(nextConfig.Cost)) then
            local item;
            local obj;
            local itemData;
            local itemConfig;
            local itemCount;
            local consumeStr;
            local items = DataMgr.Player.items;
            local itemMap = ConfigMgr.Config.itemMap;
            local len = #nextConfig.Cost;
            for i = 1, len do
                obj = nextConfig.Cost[i];
                itemData = items[obj.id];
                itemCount = itemData ~= nil and itemData.count0 or 0;
                if (itemCount >= obj.count) then
                    consumeStr = LuaMgr.NumFormat(obj.count);
                else
                    consumeStr = string.format("<color=#ff0000>%s</color>", LuaMgr.NumFormat(obj.count));
                end
                itemConfig = itemMap[obj.id];
                if (itemConfig ~= nil) then
                    item = {consume=consumeStr,
                            goods={id=itemConfig.id,count="",
                                   sizeDelta=Vector2(90,90),scale=Vector3(0.7,0.7,1),isCount=false,
                                   rare=GetRareSprite(itemConfig.rare),
                                   icon=GetItemTexture(itemConfig.id),
                                   isClick=true}};
                    table.insert(list, item);
                end
            end
        end
    end
    this.vm.data.consumeList = list;
end


this.UpLevel = function()
    local config = ConfigFoundationMgr.GetInteractionById(this.id);
    if (config == nil) then return end
    
    local nextConfig = ConfigFoundationMgr.GetInteractionByGroupLevel(config.Group, config.Level + 1);
    if (nextConfig == nil) then return end

    local mainConfig = PlayerFoundationMgr.GetMainInteraction();
    if (mainConfig == nil) then return end

    if (mainConfig.Level < nextConfig.Unlock) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText(mainConfig.NameLan) .. LuaMgr.GetLangText("FoundationUpLevelViewModel_13"));
        return;
    end
    if (nextConfig.Cost ~= nil and #nextConfig.Cost > 0) then
        local cost;
        local item;
        local len = #nextConfig.Cost;
        for i = 1, len do
            cost = nextConfig.Cost[i];
            item = DataMgr.Player.items[cost.id];
            if (item == nil or item.count0 < cost.count) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("FoundationUpLevelViewModel_14"));
                return;
            end
        end
    end
    PlayerFoundationMgr.UpLevel(this.id);
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
            local config = ConfigFoundationMgr.GetInteractionById(this.id);
            if (config ~= nil) then
                if (config.Type == 2) then
                    if (PlayerFoundationMgr.IsMake(this.id)) then
                        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, LuaMgr.GetLangText("FoundationUpLevelViewModel_15"), this.UpLevel, nil);
                        return;
                    end
                end
                this.UpLevel();
            end
        end
    },
    OnClickConfirm2 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local config = ConfigFoundationMgr.GetInteractionById(this.id);
            if (config ~= nil) then
                local nextConfig = ConfigFoundationMgr.GetInteractionByGroupLevel(config.Group, config.Level + 1);
                if (nextConfig ~= nil and not IsNullOrEmpty(nextConfig.UnlockCond)) then
                    local areaEvent = DataMgr.Player.completedAreaEvents[nextConfig.UnlockCond];
                    if (areaEvent == nil) then
                        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText(nextConfig.UnloctipsLan));
                        return;
                    end
                end
                local mainConfig = PlayerFoundationMgr.GetMainInteraction();
                if (mainConfig ~= nil and mainConfig.Id ~= this.id) then
                    nextConfig = ConfigFoundationMgr.GetInteractionByGroupLevel(config.Group, config.Level + 1);
                    if (nextConfig ~= nil) then
                        if (mainConfig.Level < nextConfig.Unlock) then
                            local str = LuaMgr.GetLangText("FoundationUpLevelViewModel_12");
                            str = string.format(str, LuaMgr.GetLangText(mainConfig.NameLan), "<color=#9e1111>", nextConfig.Unlock, "</color>");
                            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, str);
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