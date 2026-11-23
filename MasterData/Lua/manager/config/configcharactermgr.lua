ConfigCharacterMgr = {}

local this = {
    roleAttrDic = nil,
};

function ConfigCharacterMgr.Clear()
    this.roleAttrDic = nil;
end

function ConfigCharacterMgr.GetRoleAttr(characterId)
    if(this.roleAttrDic == nil) then
        local list;
        this.roleAttrDic = {};
        local roleattrMap = ConfigMgr.Config.roleattrMap;
        for _, v in pairs(roleattrMap) do
            list = this.roleAttrDic[v.id];
            if (list == nil) then
                list = {};
                this.roleAttrDic[v.id] = list;
            end
            table.insert(list, v);
        end
        for key,value in pairs(this.roleAttrDic) do
            table.sort(value,function(a,b)
                return a.star < b.star
            end)
        end
    end
    return this.roleAttrDic[characterId];
end

function ConfigCharacterMgr.GetCharacterRankUp(star, rare)
    if (ConfigMgr.Config.characterRankUpMap[tostring(rare)] == nil) then
        return nil
    end
    return ConfigMgr.Config.characterRankUpMap[tostring(rare)][tostring(star)]
end

function ConfigCharacterMgr.GetCharacterTalent(id)
    return ConfigMgr.Config.characterTalentMap[id]
end

function ConfigCharacterMgr.GetLevelUpCoinByRare(rare)
    return ConfigMgr.Config.constants.rareLevelUpCoin[tostring(rare)]
end

function ConfigCharacterMgr.GetInfo(id)
    return ConfigMgr.Config.characterTable[id]
end

function ConfigCharacterMgr.GetCharacterLevelByAddExp(level, curLevelExp, addExp)
    local exp = 0
    local curLevel = level
    while addExp >= exp do
        local curExp = ConfigMgr.Config.characterLevelUp[tostring(curLevel)]
        level = level + 1
        local nextExp = ConfigMgr.Config.characterLevelUp[tostring(level)]
        if nextExp == nil then
            return level - 1
        else
            exp = nextExp - curLevelExp
        end
    end
    return level - 1
end


function ConfigCharacterMgr.GetCharacterLevelUpExp(level)
    local exp = 0
    local curExp = ConfigMgr.Config.characterLevelUp[tostring(level)]
    local nextExp = ConfigMgr.Config.characterLevelUp[tostring(level + 1)]
    if nextExp ~= nil then
        exp = nextExp - curExp
    else
        LuaDebug.debug("卡牌升级表已达到最大等级" .. level)
    end
    return exp
end

function ConfigCharacterMgr.GetCharacterExpByLevel(level)
    local exp = ConfigMgr.Config.characterLevelUp[tostring(level)]
    if exp == nil then
        exp = ConfigMgr.Config.characterLevelUp[tostring(level - 1)]
    end
    return exp
end

function ConfigCharacterMgr.GetCharacter(id)
    return ConfigMgr.Config.characterTable[id]
end

function ConfigCharacterMgr.GetFriendlyText(level)
    local descCfg = ConfigMgr.Config.friendshipDescription[tostring(level)]
    if descCfg ~= nil then
        return LuaMgr.GetLangText(descCfg.iconDescriptionLan)
    end
    return ""
end


function ConfigCharacterMgr.IsShow(characterId)
    local characterConfig = ConfigMgr.Config.characterTable[characterId];
    if (characterConfig ~= nil) then
        return characterConfig.Switch == 0 and LuaMgr.Timestamp() > characterConfig.UnlockDate;
    end
    return false;
end


function ConfigCharacterMgr.IsShow2(characterId, sysTime)
    local characterConfig = ConfigMgr.Config.characterTable[characterId];
    if (characterConfig ~= nil) then
        return characterConfig.Switch == 0 and sysTime > characterConfig.UnlockDate;
    end
    return false;
end