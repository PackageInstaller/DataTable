require("SeasonSLG/SeasonSLGConst")

SeasonSLGTechMgr = {}

local this = {

    allTechDataDic = nil,

    allSeasonTechDataDic = nil,

    curSeasonTechDic = nil,
    lastPlayerUID = nil,
    talentDataDic = {}
}

SeasonSLGTechMgr.InitData = function()
    SeasonSLGTechMgr.OnGetGuildTechData()
    local curPlayerUID = DataMgr.Player.uid
    if this.lastPlayerUID == curPlayerUID then
        return
    end
    this.lastPlayerUID = curPlayerUID
    local techConfigs = ConfigMgr.Config.SeasonalTechMap
    this.allSeasonTechDataDic = {}
    this.allTechDataDic = {}
    this.curSeasonTechDic = nil
    for key, config in pairs(techConfigs) do
        if this.allSeasonTechDataDic[config.SeasonId] == nil then
            this.allSeasonTechDataDic[config.SeasonId] = {}
        end
        local data = {}
        data.ID = config.Id
        data.Config = config
        data.TechType = config.Tab
        data.Status = SeasonSLGConst.TechStatus.Default
        data.ConsumeItems = {}
        data.PosX = 0
        data.PosY = 0
        data.Level = 0
        data.IconName = config.Img
        data.LevelTotalConsume = {}
        if type(config.Point) == "table" and #config.Point > 1 then
            data.PosX = config.Point[1]
            data.PosY = config.Point[2]
        end
        for i = 1, #data.Config.CostMatCount do
            data.ConsumeItems[i] = {}
            local consumeData = {}
            consumeData.ID = data.Config.CostMatID
            consumeData.IsEnough = false
            consumeData.OwnerCount = 0
            table.insert(data.ConsumeItems[i], #data.ConsumeItems[i] + 1, consumeData)
            consumeData.NeedCount = data.Config.CostMatCount[i]
            if i > 1 then
                consumeData.NeedCount = data.Config.CostMatCount[i] - data.Config.CostMatCount[i - 1]
            end
            consumeData.OnceNeedCount = consumeData.NeedCount
            data.LevelTotalConsume[i] = consumeData.NeedCount
        end
        table.insert(this.allSeasonTechDataDic[config.SeasonId], data)
        this.allTechDataDic[data.ID] = data
    end
end




SeasonSLGTechMgr.GetTechDatasBySeasonID = function(seasonID)
    local datas = this.allSeasonTechDataDic[seasonID] or {}
    for key, data in pairs(datas) do
        SeasonSLGTechMgr.RefreshTechData(data.ID)
    end
    return datas
end




SeasonSLGTechMgr.GetTechDataByID = function(techID)
    SeasonSLGTechMgr.RefreshTechData(techID)
    return this.allTechDataDic[techID]
end





SeasonSLGTechMgr.GetSeasonDatas = function(techType)
    if techType == SeasonSLGConst.TechType.Talent then
        return SeasonSLGTechMgr.GetSeasonTalentDatas()
    end
    local curSeasonData = SeasonSLGMapMgr.GetCurSeasonCfgData()
    if curSeasonData == nil then
        LuaDebug.error("SeasonSLGTechMgr.GetCurSeasonTechDatas 赛季数据错误")
        return nil, nil
    end
    local curSeasonID = curSeasonData.Id
    local curSeasonTechDatas = SeasonSLGTechMgr.GetTechDatasBySeasonID(curSeasonID)
    local groupDic = {}
    local groupIDs = {}
    local techTabDatas = {}
    local curTime = LuaMgr.Timestamp()
    for key, techData in pairs(curSeasonTechDatas) do
        if techData.TechType == techType then
            local techGroup = techData.Config.Group % 100
            if groupDic[techGroup] == nil then
                groupDic[techGroup] = {}
                table.insert(groupIDs, techGroup)
            end
            table.insert(groupDic[techGroup], techData)
            SeasonSLGTechMgr.RefreshTechData(techData.ID)
        end
    end
    table.sort(groupIDs)
    local techDic = {}
    for i = 1, #groupIDs do
        local techGroup = groupIDs[i]
        local groupDatas = groupDic[techGroup]
        table.sort(groupDatas, SeasonSLGTechMgr.SortTechData)
        techDic[i] = groupDatas
        local firstData = groupDatas[1]
        local unlockTime = curSeasonData.OpenTime + firstData.Config.UnlockTime * SeasonSLGConst.DailySecond
        local data = {}
        data.Group = techGroup
        data.IsUnlock = curTime >= unlockTime
        data.Name = LuaMgr.GetLangText(firstData.Config.TabNameLan)
        table.insert(techTabDatas, data)
    end
    return techDic, techTabDatas
end


SeasonSLGTechMgr.GetSeasonTalentDatas = function()
    local heroID = SeasonSLGMapMgr.curSeasonal and SeasonSLGMapMgr.curSeasonal.SeasonalHero
    local hero = heroID and ConfigCharacterMgr.GetSeasonalHeroConfig(heroID)
    if hero == nil then
        return {}, {}
    end
    local list = {}
    this.talentDataDic = {}
    for _, cfg in pairs(ConfigMgr.Config.SeasonalTalentMap or {}) do
        if cfg.CharacterId == heroID then
            local id = cfg.Id
            local config = {}
            for key, value in pairs(cfg) do
                config[key] = value
            end
            local data = {
                ID = id,
                OriginalID = cfg.Id,
                Config = config,
                TechType = SeasonSLGConst.TechType.Talent,
                Status = SeasonSLGConst.TechStatus.Default,
                Level = 0,
                CanUpgrade = false,
                PosX = config.Point[1],
                PosY = config.Point[2],
                IconName = config.Image,
                LevelTotalConsume = {},
                ConsumeItems = {}
            }
            config.Img = cfg.Image
            config.Tab = SeasonSLGConst.TechType.Talent
            config.Unlock = cfg.PrefixId or {}
            for level = 1, cfg.MaxLevel do
                local need = cfg.RequireItemsNum[level] or 0
                data.LevelTotalConsume[level] = need
                data.ConsumeItems[level] = {
                    {
                        ID = tostring(cfg.RequireItems),
                        NeedCount = need,
                        OnceNeedCount = need,
                        OwnerCount = 0,
                        IsEnough = false
                    }
                }
            end
            table.insert(list, data)
            this.talentDataDic[id] = data
        end
    end
    table.sort(
        list,
        function(a, b)
            return a.OriginalID < b.OriginalID
        end
    )
    for i, data in ipairs(list) do
        SeasonSLGTechMgr.RefreshTechData(data.ID)
    end
    local tabs = #list > 0 and {{Group = 1, IsUnlock = true, Name = LuaMgr.GetLangText("SeasonSLGTechMgr_0")}} or {}
    return {[1] = list}, tabs
end

SeasonSLGTechMgr.SortTechData = function(data1, data2)
    return data1.Config.Sort < data2.Config.Sort
end

SeasonSLGTechMgr.RefreshTechData = function(techID)
    if techID == nil then
        LuaDebug.error("SeasonSLGTechMgr.RefreshTechData 科技ID不能为空")
        return
    end
    local techData = this.allTechDataDic[techID] or this.talentDataDic[techID]
    if techData == nil then
        LuaDebug.error(string.format("SeasonSLGTechMgr.RefreshTechData 科技ID：%d数据不存在\n%s", techID, debug.traceback()))
        return
    end
    local unlockConfigs = techData.Config.Unlock
    techData.Level = SeasonSLGTechMgr.GetTechRealLevel(techID)
    techData.CanUpgrade = false
    techData.Status = SeasonSLGConst.TechStatus.Default
    if SeasonSLGTechMgr.GetTechIsActivate(techData.ID) == true then
        techData.Status = SeasonSLGConst.TechStatus.Activate
    end
    local isMaxLevel = SeasonSLGTechMgr.CheckTechIsMaxLevel(techID)
    if isMaxLevel == false then
        local isPreTechConditionFull = true
        if type(unlockConfigs) == "table" then
            for i = 1, #unlockConfigs do
                local tempTechID = unlockConfigs[i]
                local tempTechData = this.allTechDataDic[tempTechID] or this.talentDataDic[tempTechID]
                if tempTechData == nil then
                    isPreTechConditionFull = false
                    LuaDebug.error(string.format("SeasonSLGTechMgr.RefreshTechData 解锁条件ID：%s数据不存在", tostring(tempTechID)))
                elseif SeasonSLGTechMgr.GetTechIsActivate(tempTechData.ID) == false then
                    isPreTechConditionFull = false
                end
            end
        end
        local allEnough = true
        local consumeItems = techData.ConsumeItems[techData.Level + 1]
        for key, itemData in pairs(consumeItems) do
            local ownerCount = DataHelper.GetItemCountById(itemData.ID)
            if techData.TechType == SeasonSLGConst.TechType.Guild then
                ownerCount = this.TechPoint or 0
            end
            itemData.IsEnough = ownerCount >= itemData.OnceNeedCount
            itemData.OwnerCount = ownerCount
            if itemData.IsEnough == false then
                allEnough = false
            end
        end
        if techData.Status ~= SeasonSLGConst.TechStatus.Activate then
            if isPreTechConditionFull == true and allEnough == true then
                techData.Status = SeasonSLGConst.TechStatus.CanActivate
            elseif isPreTechConditionFull == true then
                techData.Status = SeasonSLGConst.TechStatus.Unlock
            else
                techData.Status = SeasonSLGConst.TechStatus.Default
            end
        elseif techData.Status == SeasonSLGConst.TechStatus.Activate then
            if isPreTechConditionFull == true and allEnough == true then
                techData.CanUpgrade = true
            end
        end
    end
end

SeasonSLGTechMgr.GetTechIsActivate = function(id)
    local techConfig = this.allTechDataDic[id] or this.talentDataDic[id]
    if techConfig == nil then
        return false
    end
    if techConfig.TechType == SeasonSLGConst.TechType.Talent then
        local hero = ConfigCharacterMgr.GetSeasonalHeroConfig(SeasonSLGMapMgr.curSeasonal.SeasonalHero)
        local data = hero and DataMgr.Player.SeasonalCharacters[hero.Id]
        return data ~= nil and data.Talents ~= nil and data.Talents[techConfig.OriginalID] ~= nil
    end
    local realLevel = SeasonSLGTechMgr.GetTechRealLevel(id)
    return realLevel > 0
end

SeasonSLGTechMgr.CheckPersonTechIsEnough = function(id)
    local techData = this.allTechDataDic[id] or this.talentDataDic[id]
    if techData == nil then
        LuaDebug.error(string.format("SeasonSLGTechMgr.CheckPersonTechIsEnough 科技ID：%s数据不存在", id))
        return false
    end
    local level = SeasonSLGTechMgr.GetTechRealLevel(id)
    local consumeItems = techData.ConsumeItems[level + 1]
    for key, itemData in pairs(consumeItems) do
        local ownerCount = DataHelper.GetItemCountById(itemData.ID)
        if ownerCount < itemData.NeedCount then
            return false
        end
    end
    return true
end

SeasonSLGTechMgr.GetTechRealLevel = function(id)
    local techConfigData = this.allTechDataDic[id] or this.talentDataDic[id]
    if techConfigData == nil then
        return 0
    end
    if techConfigData.TechType == SeasonSLGConst.TechType.Talent then
        local hero = ConfigCharacterMgr.GetSeasonalHeroConfig(SeasonSLGMapMgr.curSeasonal.SeasonalHero)
        local data = hero and DataMgr.Player.SeasonalCharacters[hero.Id]
        local serverLevel = data and data.Talents and (data.Talents[techConfigData.OriginalID] or 0) or 0
        if serverLevel == 0 then
            serverLevel = techConfigData.Config.DefaultLevel or 0
        end
        return serverLevel
    end
    if techConfigData.TechType == SeasonSLGConst.TechType.Person then
        local serverTechData = DataMgr.Player.SeasonalTech or {}
        local serverData = serverTechData[id]
        if serverData == nil then
            return 0
        end
        local totalCount = 0
        for i = 1, #techConfigData.LevelTotalConsume do
            local count = techConfigData.LevelTotalConsume[i]
            totalCount = totalCount + count
            if serverData == totalCount then
                return i
            end
        end
    else
        if type(this.GuildSeasonTech) ~= "table" or this.GuildSeasonTech[id] == nil then
            return 0
        end
        local serverData = this.GuildSeasonTech[id]
        return serverData
    end
    return 0
end

SeasonSLGTechMgr.CheckTechIsMaxLevel = function(id)
    local techConfigData = this.allTechDataDic[id] or this.talentDataDic[id]
    local realLevel = SeasonSLGTechMgr.GetTechRealLevel(id)
    if techConfigData.TechType == SeasonSLGConst.TechType.Talent then
        return realLevel >= techConfigData.Config.MaxLevel
    elseif techConfigData.Tab == SeasonSLGConst.TechType.Person then
        return realLevel >= #techConfigData.LevelTotalConsume
    else
        return realLevel >= #techConfigData.Config.CostMatCount
    end
end

SeasonSLGTechMgr.GetMaxDonateTimes = function(id)
    local techConfigData = this.allTechDataDic[id]
    if techConfigData == nil then
        return 0
    end
    local level = SeasonSLGTechMgr.GetTechRealLevel(id) + 1
    local needTotalCount = techConfigData.LevelTotalConsume[level]
    if level > #techConfigData.LevelTotalConsume then
        needTotalCount = techConfigData.LevelTotalConsume[#techConfigData.LevelTotalConsume]
    end
    local onceCostCount = techConfigData.Config.Consume[1].count
    return needTotalCount / onceCostCount
end

SeasonSLGTechMgr.GetMaxDonateMatCount = function(id)
    local techConfigData = this.allTechDataDic[id]
    if techConfigData == nil then
        return 0
    end
    local level = SeasonSLGTechMgr.GetTechRealLevel(id) + 1
    if level > #techConfigData.LevelTotalConsume then
        return techConfigData.LevelTotalConsume[#techConfigData.LevelTotalConsume]
    end
    return techConfigData.LevelTotalConsume[level]
end

SeasonSLGTechMgr.GetTechName = function(id, isUpAfter)
    local techConfigData = this.allTechDataDic[id] or this.talentDataDic[id]
    if techConfigData == nil then
        return nil
    end
    local shortName = LuaMgr.GetLangText(techConfigData.Config.NameLan)
    if techConfigData.TechType == SeasonSLGConst.TechType.Talent then
        local level = techConfigData.Level + (isUpAfter == true and 1 or 0)
        if level == 0 then
            return shortName
        end

        return string.format("%s<color=#FC26FF>%s</color>", shortName, level)
    end
    if isUpAfter == true then
        local level = techConfigData.Level + 1
        return string.format("%s%s", shortName, level)
    end
    if techConfigData.Level == 0 then
        return shortName
    end
    return string.format("%s<color=#FC26FF>%s</color>", shortName, techConfigData.Level)
end

SeasonSLGTechMgr.GetTechUpgradeInfoByID = function(id, level)
    local techConfigData = this.allTechDataDic[id] or this.talentDataDic[id]
    if techConfigData == nil then
        LuaDebug.error(string.format("276 SeasonSLGTechMgr.GetTechUpgradeInfoByID 科技ID：%s数据不存在", id))
        return nil
    end
    if techConfigData.TechType == SeasonSLGConst.TechType.Talent then
        local cfg = techConfigData.Config
        if cfg.TalentId ~= nil and #cfg.TalentId > 0 then
            local talentCfg = cfg.TalentId[level] and ConfigMgr.Config.talentBankMap[cfg.TalentId[level]]
            return talentCfg and talentCfg.DescriptionLan or "", SeasonSLGConst.TextType.TextLang
        end
        if cfg.BuffId == nil then
            return nil
        end
        local buff = ConfigMgr.Config.SeasonalBuffMap[cfg.BuffId[level]]
        if buff ~= nil then
            return buff.BuffDesLan or "", SeasonSLGConst.TextType.TextLang
        end
        local produceBuff = ConfigMgr.Config.SeasonalProduceBuffMap[cfg.BuffId[level]]
        if produceBuff ~= nil then
            return produceBuff.NameLan or "", SeasonSLGConst.TextType.TextLang
        end
        LuaDebug.error(string.format("413 SeasonSLGTechMgr.GetTechUpgradeInfoByID 天赋ID：%s等级：%d消耗数据不存在", id, level))
        return nil
    end
    local paramData = techConfigData.Config.Para[level]
    if paramData == nil then
        LuaDebug.error(string.format("281 SeasonSLGTechMgr.GetTechUpgradeInfoByID 科技ID：%s等级：%d消耗数据不存在", id, level))
        return nil
    end
    if techConfigData.Config.Type == SeasonSLGConst.TechBuffType.Dungeon then
        local buffConfig = ConfigMgr.Config.SeasonalBuffMap[paramData]
        if buffConfig == nil then
            LuaDebug.error(string.format("287 SeasonSLGTechMgr.GetTechUpgradeInfoByID 科技ID：%s等级：%dBuff数据不存在", id, level))
            return nil
        end
        return buffConfig.BuffDesLan, SeasonSLGConst.TextType.TextLang
    elseif techConfigData.Config.Type == SeasonSLGConst.TechBuffType.ProduceAddition then
        local buffConfig = ConfigMgr.Config.SeasonalProduceBuffMap[paramData]
        if buffConfig == nil then
            LuaDebug.error(string.format("294 SeasonSLGTechMgr.GetTechUpgradeInfoByID 科技ID：%s等级：%dBuff数据不存在", id, level))
            return nil
        end
        return buffConfig.NameLan, SeasonSLGConst.TextType.TextLang
    elseif techConfigData.Config.Type == SeasonSLGConst.TechBuffType.EngeryLimit then
        local totalEngery = 0
        for i = 1, level do
            local param = techConfigData.Config.Para[i]
            totalEngery = math.floor(totalEngery + param)
        end
        local lanStr = LuaMgr.GetLangText(techConfigData.Config.DescLan)
        return string.format(lanStr, tostring(totalEngery)), SeasonSLGConst.TextType.Text
    elseif techConfigData.Config.Type == SeasonSLGConst.TechBuffType.Talent then
        local talentConfig = ConfigMgr.Config.talentBankMap[paramData]
        if talentConfig == nil then
            LuaDebug.error(string.format("350 SeasonSLGTechMgr.GetTechUpgradeInfoByID 科技ID：%s等级：%d Talent数据不存在", id, level))
            return nil
        end
        return talentConfig.DescriptionLan, SeasonSLGConst.TextType.TextLang
    end
    return ""
end

SeasonSLGTechMgr.GetGuildTechProgress = function(id)
    if this.GuildSeasonTech == nil or this.GuildSeasonTech[id] == nil then
        return 0
    end
    local techConfigData = this.allTechDataDic[id]
    if techConfigData == nil then
        LuaDebug.error(string.format("276 SeasonSLGTechMgr.GetTechUpgradeInfoByID 科技ID：%s数据不存在", id))
        return 0
    end
    local serverCount = this.GuildSeasonTech[id]
    local tempCount = serverCount
    for i = 1, #techConfigData.LevelTotalConsume do
        local tempCount1 = tempCount - techConfigData.LevelTotalConsume[i]
        if tempCount1 < 0 then
            return tempCount
        end
        tempCount = tempCount1
    end
    return tempCount + techConfigData.LevelTotalConsume[#techConfigData.LevelTotalConsume]
end


SeasonSLGTechMgr.GetMaxEngery = function()
    local allEngerys = SeasonSLGTechMgr.GetTechBuffDatas(SeasonSLGConst.TechBuffType.EngeryLimit)
    local totalLimit = 0
    for i = 1, #allEngerys do
        local engeryLimit = tonumber(allEngerys[i]) or 0
        totalLimit = totalLimit + engeryLimit
    end
    return totalLimit
end



SeasonSLGTechMgr.GetDungeonBuffs = function()
    local allSeasonBuffIDs = SeasonSLGTechMgr.GetTechBuffDatas(SeasonSLGConst.TechBuffType.Dungeon)
    local allBuffIDDic = {}
    local allBuffIDs = {}
    for key, value in pairs(allSeasonBuffIDs) do
        local seasonBuffConfig = ConfigMgr.Config.SeasonalBuffMap[value]
        if seasonBuffConfig ~= nil then
            allBuffIDDic[seasonBuffConfig.BuffId] = true
        end
    end
    for dungeonBuffID, value in pairs(allBuffIDDic) do
        table.insert(allBuffIDs, dungeonBuffID)
    end
    return allBuffIDs
end

SeasonSLGTechMgr.GetProduceBuff = function()
    local produceBuffs = SeasonSLGTechMgr.GetTechBuffDatas(SeasonSLGConst.TechBuffType.ProduceAddition)
    local additionPersonDic = {}
    for key, buffID in pairs(produceBuffs) do
        local produceConfig = ConfigMgr.Config.SeasonalProduceBuffMap[buffID]
        if produceConfig ~= nil then
            for i = 1, #produceConfig.Type do
                local produceID = produceConfig.Type[i]
                local additionNum = produceConfig.Para1[1]
                if additionPersonDic[produceID] == nil then
                    additionPersonDic[produceID] = additionNum
                else
                    additionPersonDic[produceID] = additionPersonDic[produceID] + additionNum
                end
            end
        end
    end
    return additionPersonDic
end



SeasonSLGTechMgr.GetTalent = function()
    return SeasonSLGTechMgr.GetTechBuffDatas(SeasonSLGConst.TechBuffType.Talent) or {}
end


SeasonSLGTechMgr.GetTechBuffDatas = function(buffType)
    if this.lastPlayerUID == nil then
        SeasonSLGTechMgr.InitData()
    end
    local curSeasonData = SeasonSLGMapMgr.GetCurSeasonCfgData()
    if curSeasonData == nil then
        return {}
    end
    local allBuffIDs = {}
    local curSeasonID = curSeasonData.Id
    for techID, techData in pairs(this.allTechDataDic) do
        SeasonSLGTechMgr.RefreshTechData(techID)
        local config = techData.Config
        if config.Type == buffType then
            if curSeasonID == config.SeasonId and techData.Status == SeasonSLGConst.TechStatus.Activate then
                for i = 1, #config.Para do
                    if i <= techData.Level then
                        local param = config.Para[i]
                        if config.Type == SeasonSLGConst.TechBuffType.Dungeon then
                            local buffConfig = ConfigMgr.Config.SeasonalBuffMap[param]
                            if buffConfig ~= nil then
                                table.insert(allBuffIDs, buffConfig.BuffId)
                            end
                        else
                            table.insert(allBuffIDs, param)
                        end
                    end
                end
            end
        end
    end
    return allBuffIDs
end


SeasonSLGTechMgr.GetSpecialHeroTalent = function(characterId)
    if characterId ~= SeasonSLGMapMgr.curSeasonal.SeasonalHero then
        return {}
    end

    if SeasonSLGTechMgr.SeasonalTalentMapList == nil then
        SeasonSLGTechMgr.SeasonalTalentMapList = {}
        for i, v in pairs(ConfigMgr.Config.SeasonalTalentMap) do
            if SeasonSLGTechMgr.SeasonalTalentMapList[v.CharacterId] == nil then
                SeasonSLGTechMgr.SeasonalTalentMapList[v.CharacterId] = {}
            end
            table.insert(SeasonSLGTechMgr.SeasonalTalentMapList[v.CharacterId], v)
        end
    end
    if SeasonSLGTechMgr.SeasonalTalentMapList[characterId] == nil then
        return {}
    end
    local cfgTalentList = SeasonSLGTechMgr.SeasonalTalentMapList[characterId]
    local seasonHero = ConfigCharacterMgr.GetSeasonalHeroConfig(characterId)
    local dataSeasonalCharacter = DataMgr.Player.SeasonalCharacters[seasonHero.Id]
    if dataSeasonalCharacter == nil or IsNull(dataSeasonalCharacter.Talents) then
        return {}
    end
    local talentIds = {}
    for i, v in ipairs(cfgTalentList) do
        if not IsNull(v.TalentId) and #v.TalentId > 0 then
            local len = dataSeasonalCharacter.Talents[v.Id]
            if len ~= nil then
                for talentIndex = 1, len, 1 do
                    table.insert(talentIds, v.TalentId[talentIndex])
                end
            end
        end
    end
    return talentIds
end


SeasonSLGTechMgr.GetSpecialHeroTalentBuffs = function(characterId)
    if characterId ~= SeasonSLGMapMgr.curSeasonal.SeasonalHero then
        return {}, {}
    end

    if SeasonSLGTechMgr.SeasonalTalentBuffMapList == nil then
        SeasonSLGTechMgr.SeasonalTalentBuffMapList = {}
        for i, v in pairs(ConfigMgr.Config.SeasonalTalentMap) do
            if SeasonSLGTechMgr.SeasonalTalentBuffMapList[v.CharacterId] == nil then
                SeasonSLGTechMgr.SeasonalTalentBuffMapList[v.CharacterId] = {}
            end
            table.insert(SeasonSLGTechMgr.SeasonalTalentBuffMapList[v.CharacterId], v)
        end
    end
    if SeasonSLGTechMgr.SeasonalTalentBuffMapList[characterId] == nil then
        return {}, {}
    end
    local cfgTalentList = SeasonSLGTechMgr.SeasonalTalentBuffMapList[characterId]
    local seasonHero = ConfigCharacterMgr.GetSeasonalHeroConfig(characterId)
    local dataSeasonalCharacter = DataMgr.Player.SeasonalCharacters[seasonHero.Id]
    if dataSeasonalCharacter == nil or IsNull(dataSeasonalCharacter.Talents) then
        return {}, {}
    end
    local dungeonBuffIds = {}
    local produceBuffDic = {}
    for i, v in ipairs(cfgTalentList) do
        local isActivated = SeasonSLGTechMgr.GetTechIsActivate(v.Id)
        if not IsNull(v.BuffId) and #v.BuffId > 0 and isActivated == true then
            local level = SeasonSLGTechMgr.GetTechRealLevel(v.Id)
            local seasonBuff = ConfigMgr.Config.SeasonalBuffMap[v.BuffId[level]]
            local produceConfig = ConfigMgr.Config.SeasonalProduceBuffMap[v.BuffId[level]]
            if seasonBuff ~= nil then
                table.insert(dungeonBuffIds, seasonBuff.BuffId)
            elseif produceConfig ~= nil then
                for i = 1, #produceConfig.Type do
                    local produceID = produceConfig.Type[i]
                    local additionNum = produceConfig.Para1[1]
                    if produceBuffDic[produceID] == nil then
                        produceBuffDic[produceID] = additionNum
                    else
                        produceBuffDic[produceID] = produceBuffDic[produceID] + additionNum
                    end
                end
            end
        end
    end
    return dungeonBuffIds, produceBuffDic
end





SeasonSLGTechMgr.GetGuildUpPermission = function()
    return ConfigMgr.Config.constants.GuildTechUpPermission or SeasonSLGConst.GuildTechUpPermission
end


SeasonSLGTechMgr.OnAskTechActivate = function(techID, callBack)
    local talent = this.talentDataDic[techID]
    if talent ~= nil then
        local hero = ConfigCharacterMgr.GetSeasonalHeroConfig(SeasonSLGMapMgr.curSeasonal.SeasonalHero)
        if hero ~= nil then
            return SeasonSLGAPI.OnAskSeasonalCharacterTalent(
                hero.Id,
                talent.OriginalID,
                function()
                    if callBack ~= nil then
                        callBack(techID)
                    end
                end
            )
        end
    end
    local data = {}
    data.TechId = techID
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            LuaDebug.error("请求错误:" .. res.code)
            return
        end
        if callBack ~= nil then
            callBack(techID)
        end
    end
    ApiMgr.Request("seasonal/tech/unlock", data, true, onSucc, nil, false)
end

SeasonSLGTechMgr.OnAskTechDonate = function(techID, count, callBack)
    local data = {}
    data.TechId = techID
    data.Count = count
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            LuaDebug.error("请求错误:" .. res.code)
            return
        end
        if type(res.result.GuildTech.Contribute) == "table" then
            this.GuildSeasonTech = res.result.GuildTech.Contribute
        end
        if callBack ~= nil then
            callBack(techID)
        end
    end
    ApiMgr.Request("seasonal/tech/guild_contribute", data, true, onSucc, nil, false)
end

SeasonSLGTechMgr.OnAskGuildTechUpgrade = function(techID, callBack)
    local data = {}
    data.TechId = techID
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            LuaDebug.error("请求错误:" .. res.code)
            return
        end
        if type(res.result.GuildTech.TechLevel) == "table" then
            this.GuildSeasonTech = res.result.GuildTech.TechLevel
        end
        this.TechPoint = res.result.GuildTech.TechPoint
        if callBack ~= nil then
            callBack(techID)
        end
    end
    ApiMgr.Request("seasonal/tech/level_up", data, true, onSucc, nil, false)
end

SeasonSLGTechMgr.OnGetGuildTechData = function(callBack)
    if PlayerGuildMgr.HaveGuild() == false then
        this.GuildSeasonTech = nil
        return
    end
    local onSuccc = function()
        if PlayerGuildMgr.HaveGuild() == false then
            this.GuildSeasonTech = nil
            return
        end
        local data = {}
        local onSucc = function(result)
            local res = json.decode(result)
            if res.code ~= nil and res.code ~= 0 then
                LuaDebug.error("请求错误:" .. res.code)
                return
            end
            local guildInfo = PlayerGuildMgr.GuildInfo()
            if PlayerGuildMgr.HaveGuild() == false or guildInfo.guildId ~= res.result.GuildId then
                return
            end
            this.GuildSeasonTech = res.result.TechLevel
            this.TechPoint = res.result.TechPoint
            if callBack ~= nil then
                callBack()
            end
        end
        ApiMgr.Request("seasonal/tech/get_guild_tech", data, true, onSucc, nil, false)
    end

    local onFaild = function()
        this.GuildSeasonTech = nil
        this.TechPoint = 0
    end
    PlayerGuildMgr.RefreshGuildInfo(onSuccc, onFaild)
end

