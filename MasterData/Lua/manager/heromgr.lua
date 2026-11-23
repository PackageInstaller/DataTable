HeroMgr = {}

CharacterMsgType = {
LoginMain=1,
SelectCharacter=2,
ClickCharacter=3,
Time=4,
Idel=5,
UpLevel=6,
JoinTeam=7,
UpStar=8,
Equip=9,
DropLine = 10,
HappyBirthdayLine=11,
    VictoryLine_1=12,
    VictoryLine_2=13,
    LoseLine_1=14,
    LoseLine_2=15,
};

HeroMgr.IconJobPath = {
    "ui_yc_sw_",
    "ui_yc_qr_",
    "ui_yc_yj_",
    "ui_yc_gs_",
    "ui_yc_zl_",
}


HeroMgr.SkillList = {"skill1", "skill6", "skill2", "skill3", "skill4", "skill5"}
HeroMgr.SkillList2 = {"Skill1", "Skill6", "Skill2", "Skill3", "Skill4", "Skill5"}


HeroMgr.GetCharacterZZ = function(characterId)
    local level = -1
    if characterId == nil then return level end
    local data = DataMgr.Player.characters[characterId]
    if data == nil then return level end
    if data.star > 0 then level = data.star end
    return level
end


HeroMgr.GetCharacterZZWithBadge = function(characterId)
    local level = -1
    if characterId == nil then return level end
    local cfg = ConfigCharacterMgr.GetCharacter(characterId)
    local data = DataMgr.Player.characters[characterId]
    if data ~= nil then
        level = data.star
    end
    
    if cfg ~= nil then
        local count = PlayerItemMgr.GetItemCountById(cfg.crystalItemId)
        level = level + math.ceil(count / cfg.crystalCount)
    end
    
    return level
end


HeroMgr.GetNumStr = function(num)
    if num == 1 then return LuaMgr.GetLangText("HeroManager_0") end
    if num == 2 then return LuaMgr.GetLangText("HeroManager_1") end
    if num == 3 then return LuaMgr.GetLangText("HeroManager_2") end
    if num == 4 then return LuaMgr.GetLangText("HeroManager_3") end
    if num == 5 then return LuaMgr.GetLangText("HeroManager_4") end
    if num == 6 then return LuaMgr.GetLangText("HeroManager_5") end
    if num == 7 then return LuaMgr.GetLangText("HeroManager_6") end
    if num == 8 then return LuaMgr.GetLangText("HeroManager_7") end
    if num == 9 then return LuaMgr.GetLangText("HeroManager_8") end
    if num == 10 then return LuaMgr.GetLangText("HeroManager_9") end
    return ""
end

local TableInsert = table.insert
HeroMgr.GetLearnTalents = function(characterId)
    local data = DataMgr.Player.characters[characterId]
    if data == nil then return end
    local talents = {}
    local config = {}
    for i, v in pairs(data.talents) do
        if v.status == 2 then
            config = ConfigMgr.Config.characterTalentMap[i]
            if config ~= nil then
                TableInsert(talents,config.talentBankId)
            end
        end
    end
    return talents
end

HeroMgr.GetMainAttrList = function()
    local list = {}
    for _, attr in pairs(ConfigMgr.Config.attrDesMap) do
        if attr.index > 0 and attr.index < 7 then
            table.insert(list, attr)
        end
    end
    table.sort(list, function(a, b)
        return a.index < b.index
    end)
    return list
end

HeroMgr.GetOtherAttrList = function()
    local list = {}
    for _, attr in pairs(ConfigMgr.Config.attrDesMap) do
        if attr.index > 6 then
            table.insert(list, attr)
        end
    end
    table.sort(list, function(a, b)
        return a.index < b.index
    end)
    return list
end

HeroMgr.GetCharacterSkin = function(characterId)
    local characterData = DataMgr.Player.characters[characterId]
    if characterData ~= nil then
        return characterData.curSkin
    end
    return characterId.."001"
end

HeroMgr.GetCharacterCard = function(characterId,skinId)
    if skinId == nil or skinId == "" then
        skinId = HeroMgr.GetCharacterSkin(characterId)
    end
    local path = string.format("%s%s/Cards/%s.png",Path.Monster_PATH,characterId,skinId)
    if LuaMgr.HasAsset(path) then return path end
    return string.format("%s%s/Cards/%s%s.png",Path.Monster_PATH,characterId,characterId,"001")
end
HeroMgr.GetHeroRareStr = function(rare)
    local str = ""
    if rare == CharacterRare.R then
        str = "lan"
    end
    if rare == CharacterRare.SR then
        str = "cheng"
    end
    if rare == CharacterRare.SSR then
        str = "hong"
    end
    return str
end

HeroMgr.GetHeroJobRareIcon1 = function(job, rare)
    local iconName = HeroMgr.IconJobPath[job]
    if IsNullOrEmpty(iconName) then
        return DefaultSprite
    end

    local str = ""
    if rare == CharacterRare.R then
        str = "blue"
    elseif rare == CharacterRare.SR then
        str = "yellow"
    elseif rare == CharacterRare.SSR then
        str = "red"
    end
    return LuaMgr.GetSprite("HeroRes", iconName .. str)
end

HeroMgr.GetHeroJobRareIcon = function(characterConfig)
    return HeroMgr.GetHeroJobRareIcon1(characterConfig.job, characterConfig.rare)
end


HeroMgr.GetHeroNowRare = function(characterId, uid)
    local tempConfig = ConfigCharacterMgr.GetInfo(characterId)
    if not TableIsNull(tempConfig) then
        local rare = tempConfig.rare
        local tempData = DataMgr.Player.characters[characterId]

        if not IsNullOrEmpty(uid) then 
            tempData = PlayerAssistMgr.GetAssist_Character(uid,characterId)
        end

        if not TableIsNull(tempData) and type(tempData.brilliant) ~= "function" and not TableIsNull(tempData.brilliant) then
            rare = rare + tempData.brilliant.RareLevel
        end
        return rare
    end
    return 0
end


HeroMgr.GetHeroMsgUsingID = function(characterId)
    if TableIsNull(DataMgr.Player.DialogFrame.items) or IsNullOrEmpty(characterId) then
        return "1000"
    end
    if DataMgr.Player.DialogFrame.items[characterId] ~= nil then
        return DataMgr.Player.DialogFrame.items[characterId]
    end
    if DataMgr.Player.DialogFrame.items["all"] ~= nil then
        return DataMgr.Player.DialogFrame.items["all"]
    end
    return "1000"
end


HeroMgr.GetMsgConfig = function(msgID)
    local color = ""
    if IsNullOrEmpty(msgID) then
        color = ""
    end
    if TableIsNull(ConfigMgr.Config.DialogFrameMap) then
        color = ""
    end
    if ConfigMgr.Config.DialogFrameMap[msgID] ~= nil then
        color = ConfigMgr.Config.DialogFrameMap[msgID].RGB
    end
    return color
end

HeroMgr.GetCharacterRareStar = function(rare)
    local list = ConfigMgr.Config.constants.CharacterRareSymbol
    if list == nil then
        return 0
    end

    local rareStr = tostring(rare)
    for i, item in ipairs(list) do
        if item[0] == rareStr then
            local value = tonumber(item[1])
            return value
        end
    end
    return 0
end


HeroMgr.CompareLevel = function(a, b)
    if a.level == b.level then
        if a.star == b.star then
            if a.time == b.time then
                return a.id > b.id
            end
            return a.time > b.time
        end
        return a.star > b.star
    end
    return a.level > b.level
end


HeroMgr.CompareStar = function(a, b)
    if a.star == b.star then
        if a.level == b.level then
            if a.time == b.time then
                return a.id > b.id
            end
            return a.time > b.time
        end
        return a.level > b.level
    end
    return a.star > b.star
end


HeroMgr.CompareTime = function(a, b)
    if a.time == b.time then
        if a.level == b.level then
            if a.star == b.star then
                return a.id > b.id
            end
            return a.star > b.star
        end
        return a.level > b.level
    end
    return a.time > b.time
end


HeroMgr.GetActorCultivationConfig = function(actorId)
    local cultivationData = {}
    local actorCfg = ConfigMgr.Config.actor[actorId]
    if actorCfg ~= nil then
        if not IsNull(actorCfg.Talents) then
            cultivationData.Talents = actorCfg.Talents
        end
        if not IsNull(actorCfg.Style) and actorCfg.Style ~= 0 then
            cultivationData.Style = actorCfg.Style
        end
        if not IsNull(actorCfg.Sector) then
            cultivationData.Sector = actorCfg.Sector
        end
        if not IsNull(actorCfg.GoodFeel) then
            cultivationData.GoodFeel = actorCfg.GoodFeel
        end
        if not IsNull(actorCfg.WeaponAtt) then
            cultivationData.WeaponAttIds = {}
            cultivationData.WeaponAttLevels = {}
            for i, v in ipairs(actorCfg.WeaponAtt) do
                table.insert(cultivationData.WeaponAttIds, v[1])
                table.insert(cultivationData.WeaponAttLevels, v[2])
            end
        end
    end
    local jsonStr = json.encode(cultivationData)
    return jsonStr
end



HeroMgr.LevelSortBigToSmall = function(element1,element2)
    return element1.level > element2.level
end

HeroMgr.LevelSortSmallToBig = function(element1,element2)
    return element1.level < element2.level
end


HeroMgr.StarSortBigToSmall = function(element1,element2)
    return element1.star > element2.star
end

HeroMgr.StarSortSmallToBig = function(element1,element2)
    return element1.star < element2.star
end


HeroMgr.RareSortBigToSmall = function(element1,element2)
    local elementRare1 = HeroMgr.GetHeroRareSort(element1.id)
    local elementRare2 = HeroMgr.GetHeroRareSort(element2.id)
    return elementRare1 > elementRare2
end

HeroMgr.RareSortSmallToBig = function(element1,element2)
    local elementRare1 = HeroMgr.GetHeroRareSort(element1.id)
    local elementRare2 = HeroMgr.GetHeroRareSort(element2.id)
    return elementRare1 < elementRare2
end


HeroMgr.TimeSortEarlyToLate = function(element1,element2)
    return element1.createTime < element2.createTime
end

HeroMgr.TimeSortLateToEarly = function(element1,element2)
    return element1.createTime > element2.createTime
end


HeroMgr.FriendlySortBigToSmall = function(element1,element2)
    return element1.prestigeLevel > element2.prestigeLevel
end

HeroMgr.FriendlySortSmallToBig = function(element1,element2)
    return element1.prestigeLevel < element2.prestigeLevel
end

HeroMgr.FriendlyExpSortBigToSmall = function(element1,element2)
    return element1.prestige > element2.prestige
end

HeroMgr.FriendlyExpSortSmallToBig = function(element1,element2)
    return element1.prestige < element2.prestige
end


HeroMgr.HeroIdSort = function(element1,element2)
    return element1.id > element2.id
end


HeroMgr.GetHeroRareSort = function(characterId)
    local tempConfig = ConfigCharacterMgr.GetInfo(characterId)
    if not TableIsNull(tempConfig) then
        local rare = tempConfig.rare
        local tempData = DataMgr.Player.characters[characterId]
        if not TableIsNull(tempData) and type(tempData.brilliant) ~= "function" and not TableIsNull(tempData.brilliant) then
            rare = rare + tempData.brilliant.RareLevel
        end
        if rare > 4 then rare = 4 end
        return rare
    end
    return 0
end


HeroMgr.SetSpineFile=function(data)
    local spineFile=UnityEngine.Application.persistentDataPath.."/spineFile.txt"
    if data~=nil and data~="" then
        local jsonStr=json.encode(data);
        LuaMgr.WriteFile(spineFile,jsonStr);
    end
end

HeroMgr.GetSpineFile=function()
    local spineFile=UnityEngine.Application.persistentDataPath.."/spineFile.txt"
    local jsonStr=LuaMgr.ReadFile(spineFile)
    if jsonStr~=nil and jsonStr~="" then
        return json.decode(jsonStr);
    end
    return nil;
end