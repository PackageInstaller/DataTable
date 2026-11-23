local this = {
    vm=nil,
};

local data = {
    curChaName = "",
    curChaDesc = "",
    chaList = {
        {
            id = "",
            icon = DefaultTexture,
            level = "",
            isSelected = false,
        }
    },
}

local command = {
    chaCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = param + 1
            this.OnClickCharacter(index)
        end
    },
    closeBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            LuaMgr.HidePanel(UIName.MiniBattle4HelpCharactersPopup);
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm=vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        local seriesId = vm.behaviour.Params[0]
        local seriesCfg = MiniBattle4Mgr.GetSeriesCfg(seriesId)
        
        local tempList = {}
        for i, v in ipairs(seriesCfg.ActorList) do
            local monsterInfo = MiniBattle4Mgr.GetMonsterInfo(v)
            table.insert(tempList, {
                id = v,
                icon = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(monsterInfo.charecterId)),
                level = tostring(monsterInfo.level),
                isSelected = false,
            })
        end
        this.vm.data.chaList = tempList
        
        this.OnClickCharacter(1)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
    before_destroy=function(vm)
        this = nil;
    end
}

this.OnClickCharacter = function(index)
    local characterId = ""
    for i = 1, 6 do
        this.vm.data.chaList[i].isSelected = i == index
        if i == index then
            characterId = this.vm.data.chaList[i].id
        end
    end
    
    local monsterInfo = MiniBattle4Mgr.GetMonsterInfo(characterId)
    local characterCfg = ConfigCharacterMgr.GetCharacter(monsterInfo.charecterId)
    local actorBuffs = monsterInfo.dualBattleCfg.ActorBuff
    local buffDescStr = LuaMgr.GetLangText("MiniBattle4HelpCharactersPopup_0")
    for i, v in ipairs(actorBuffs) do
        local buffDescCfg = MiniBattle4Mgr.GetBuffDescCfg(v)
        local buffName = LuaMgr.GetLangText(buffDescCfg.BuffNamelan)
        local buffdesc = LuaMgr.GetLangText(buffDescCfg.BuffDeslan)
        buffDescStr = string.format("%s\n——%s：%s\n", buffDescStr, buffName, buffdesc)
    end
    buffDescStr = string.format("%s\n%s", buffDescStr, ConfigMgr.LangGlobal("29523"))
    this.vm.data.curChaName = LuaMgr.GetLangText(characterCfg.namelan)
    this.vm.data.curChaDesc = buffDescStr
end

return vm({
    data = data,
    command = command,
    hook = hook
})