local data = {
    buildingName = "",
    heroCount = "",
    heroList = {{isHero=false,heroPic=DefaultTexture,heroRare=DefaultSprite,isNone=false,isAdd=false,isLock=false,heroName=""}},
    isYield = false,
    buildingYield = "",
    aniName = "",
};

local this = {
    vm = nil,
    id = "",
};

this.OnClose = function()
    LuaMgr.HidePanel(UIName.FoundationBuildingHeroViewModel);
end


this.SetData = function()
    local data = DataMgr.Player.interactions[this.id];
    if (data ~= nil) then
        local config = ConfigFoundationMgr.GetInteractionById(this.id);
        if (config ~= nil) then
            this.vm.data.buildingName = LuaMgr.GetLangText(config.NameLan);
            local item;
            local heroConfig;
            local characterTable = ConfigMgr.Config.characterTable;
            local heroCount = IsNull(data.Characters) and 0 or #data.Characters;
            this.vm.data.heroCount = string.format("<size=22>%d</size>/<color=#bf9585>%d</color>", heroCount, config.Cap);
            if (heroCount > 0 and not IsNull(config.Tips)) then
                local num = tonumber(config.Tips[2]) * heroCount;
                this.vm.data.buildingYield = string.format(LuaMgr.GetLangText(config.Tips[1]), num);
                this.vm.data.isYield = true;
            else
                this.vm.data.isYield = false;
            end
            local list = {};
            for i = 1, 3 do
                item = {isHero=false,heroPic=DefaultTexture,heroRare=DefaultSprite,isNone=true,isAdd=true,isLock=false,heroName=""};
                if (i > heroCount) then
                    item.isHero = false;
                    if (i > config.Cap) then
                        item.isAdd = false;
                        item.isLock = true;
                    else
                        item.isAdd = true;
                        item.isLock = false;
                    end
                    item.heroName = "";
                else
                    heroConfig = characterTable[data.Characters[i]];
                    if (heroConfig ~= nil) then
                        item.heroPic = LuaMgr.GetTexture(HeroManager.GetCharacterCard(heroConfig.id));
                        item.heroRare = nil;
                        item.isHero = true;
                        item.isNone = false;
                        item.isAdd = false;
                        item.heroName = LuaMgr.GetLangText(heroConfig.namelan);
                    end
                    local tempRare = HeroMgr.GetHeroNowRare(heroConfig.id)
                    local imageRare = tempRare >= 5 and 4 or tempRare
                    item.heroRare = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_"..imageRare)
                end
                table.insert(list, item);
            end
            this.vm.data.heroList = list;
        end
    end
end


this.OnHeroChoice = function(args)
    this.SetData();
end

local command = {
    OnClickMask = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.NextFrame(this.OnClose);
        end
    },
    OnClickItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local config = ConfigFoundationMgr.GetInteractionById(this.id);
            if (config ~= nil) then
                local data = DataMgr.Player.interactions[this.id];
                if (data ~= nil) then
                    LuaMgr.ShowLuaPanel(UIName.FoundationHeroChoiceViewModel, config.Id, data.Characters, config.Cap);
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

        LuaMgr.AddUIEventListener(UIEventConst.FoundationHeroChoice, this.OnHeroChoice);
        this.id = this.vm.behaviour.Params[0];
        this.SetData();
        this.vm.data.aniName = "UI_FoundationBuildingHeroPanel";
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.FoundationHeroChoice, this.OnHeroChoice);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})