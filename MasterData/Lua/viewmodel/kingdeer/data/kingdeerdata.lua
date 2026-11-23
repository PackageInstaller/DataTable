







KingDeerData = {}

KingDeerData.PictureBookStatus = {
Lock = 1,
CanActive = 2,
Actived = 3
}

KingDeerData.GetRewardStatus = {
None = 1,
CanGet = 2,
Got = 3
}

local this = {
    mainActGroupId = 3040,
    zoneActGroupId = 3046,
    randomShopGroupID = "group.3041",
    questShopKey = "KingDeerShop",
    questPictureBookKey = "PictureBook",
    questPictureBookReward = "PictureBookReward",
    questBattleKey = "KingDeerZone",
    headNovelID = "E026001",
    pictureBookNovelID = "E026006",
    randomShopShelfKey = "ActivityShop1",
    ZoneNames = {
        LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7308"),
        LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7309"),
        LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7310"),
        LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7311")
    },
    activityMapID = 70,
questShopDatas = {},
    questShopDataDic = {},
questPictureBookDatas = {},
    questPictureBookDic = {},
questPictureBookRewardData = {},
randomShopGoodsDatas = {},
findDatas = {},
eventMapDataDic = {},
novelDatas = {},
    novelDataDic = {}
}























KingDeerData.Init = function()
    this.questShopDatas = {}
    this.questPictureBookDatas = {}
    this.novelDatas = {}
    this.findDatas = {}
    local questEvents = DataExHelper.Check_ConfigQuestEventByGroupId(this.mainActGroupId)
    for key, value in pairs(questEvents) do
        local data = {}
        data.config = value
        if value.text == this.questShopKey then
            this.questShopDataDic[value.id] = data
            table.insert(this.questShopDatas, data)
        elseif value.text == this.questPictureBookKey then
            this.questPictureBookDic[value.id] = data
            table.insert(this.questPictureBookDatas, data)
        elseif value.text == this.questPictureBookReward then
            this.questPictureBookRewardData = data
        end
    end
    questEvents = DataExHelper.Check_ConfigQuestEventByGroupId(this.zoneActGroupId)
    for key, value in pairs(questEvents) do
        local tempData = {}
        tempData.progressConfig = value
        local tempKey = #this.findDatas + 1
        tempData.zoneName = this.ZoneNames[tempKey]
        this.findDatas[tempKey] = tempData
    end
    KingDeerData.InitMapConfig()
end

KingDeerData.InitMapConfig = function()
    local activityMap = nil
    for key, value in pairs(ConfigMgr.Config.activityMapList) do
        if value.sortNum == this.activityMapID then
            activityMap = table.Copy(value)
            break
        end
    end
    if activityMap == nil then
        LuaDebug.error("KingDeerData.Init Error. Line 58")
        return
    end
    local groupList = DataExHelper.EX_GetGroupListByArea(activityMap.area)
    if groupList == nil or type(groupList) == "function" then
        LuaDebug.error("KingDeerData.Init Error. 63")
        return
    end
    local eventMapDic = DataExHelper.EX_GetEventMapByArea(activityMap.area)
    if eventMapDic == nil or type(eventMapDic) == "function" then
        LuaDebug.error("KingDeerData.Init Error. Line 68")
        return
    end
    local idOffset = 1200
    this.eventMapDataDic = {}
    for _, value in pairs(groupList) do
        local eventMapGroupDatas = eventMapDic[value.id]
        local findDataKey = value.id - idOffset
        local findData = this.findDatas[findDataKey]
        if eventMapGroupDatas == nil or findData == nil then
            LuaDebug.error("KingDeerData.Init Error. Line 76")
        else
            findData.eventMapData = {}
            local index = 1
            for __, value1 in pairs(eventMapGroupDatas) do
                local mapData = {}
                mapData.config = value1
                mapData.isUnLock = value1.unlockType == 0
                mapData.rating = 0
                mapData.index = index
                mapData.isNovel = mapData.config.type == 1
                index = index + 1
                if mapData.isNovel == true then
                    local novelData = KingDeerData.AddNovelDatas(#this.novelDatas + 1, value1.id, false, false)
                    novelData.name = LuaMgr.GetLangText(value1.namelan)
                end
                table.insert(findData.eventMapData, mapData)
                this.eventMapDataDic[value1.id] = mapData
            end
            table.sort(findData.eventMapData, KingDeerData.SortPassData)
            findData.mapGroupConfig = value
            findData.mapGroupID = value.id
            findData.area = value.area
            findData.status = KingDeerData.GetRewardStatus.None
            findData.progressNum = 0
            findData.isUnLock = value.unlockType == 0
        end
    end
    local novelData = KingDeerData.AddNovelDatas(1, this.headNovelID, false, false)
    novelData.name = LuaMgr.GetLangText("operatorLan_activityMapEvent_namelan_E026001")
    novelData = KingDeerData.AddNovelDatas(#this.novelDatas + 1, this.pictureBookNovelID, false, false)
    novelData.name = LuaMgr.GetLangText("operatorLan_activityMapEvent_namelan_E026006")
end

KingDeerData.SortPassData = function(data1, data2)
    return data1.index < data2.index
end

KingDeerData.Clear = function()
end


KingDeerData.GetShopData = function()
    return this.questShopDatas
end



KingDeerData.GetRandomShopData = function()
    local data = DataMgr.Player.randShop[this.randomShopShelfKey]
    if LuaMgr.Timestamp() >= DataMgr.Player.variables[this.randomShopGroupID].delTime then
        return nil, data.expiredtime
    end
    local goodsData = {}
    this.randomShopGoodsDatas = {}
    local randomGoodsCfg = ConfigMgr.Config.RandGoodsMap
    for i = 1, #data.goods do
        local tempData = {}
        tempData.itemData = {}
        tempData.Id = data.goods[i]
        tempData.buyCnt = data.buycnt[i]
        local config = randomGoodsCfg[tempData.Id]
        tempData.showDiscount = config.OriginalPrice > config.Price
        tempData.discount = config.Price / config.OriginalPrice
        tempData.sellout = tempData.buyCnt >= config.LimitCount
        tempData.Price = config.Price
        tempData.limitCount = config.LimitCount
        tempData.RefreshCount = config.LimitCount
        tempData.Item = config.Item[1].id
        tempData.Stack = config.Item[1].count
        tempData.Currency = config.Currency
        tempData.isRandom = true
tempData.index = i - 1

        tempData.shelfId = this.randomShopShelfKey
        table.insert(goodsData, tempData)
        this.randomShopGoodsDatas[tempData.Id] = tempData
    end
    return goodsData, data.expiredtime
end

KingDeerData.BuyRandomShopData = function(itemID)
    local data = this.randomShopGoodsDatas[itemID]
    if data == nil then
        LuaDebug.error("KingDeerData.BuyRandomShopData itemID error:" .. itemID)
        return 0
    end
    data.buyCnt = data.buyCnt + 1
    data.sellout = data.buyCnt >= data.limitCount
end


KingDeerData.AddNovelDatas = function(index, novelID, isUnLock, isLook)
    local temoNovelData = {}
    temoNovelData.ID = novelID
    temoNovelData.isUnLock = isUnLock
    temoNovelData.isLook = isLook
    temoNovelData.unlockText = ""
    table.insert(this.novelDatas, index, temoNovelData)
    this.novelDataDic[temoNovelData.ID] = temoNovelData
    return temoNovelData
end

KingDeerData.SetNovelData = function(novelID, isUnLock, isLook, unlockText)
    local data = this.novelDataDic[novelID]
    if data == nil then
        return
    end
    data.isUnLock = isUnLock
    data.isLook = isLook
    data.unlockText = unlockText
end

KingDeerData.GetNovelDatas = function()
    return this.novelDatas
end

KingDeerData.GetNovelID = function(index)
    return this.novelDatas[index].ID
end

KingDeerData.GetNovelIsLook = function(novelID)
    if type(DataMgr.Player.completedChapters) ~= "table" then
        return false
    end
    for key, value in pairs(DataMgr.Player.completedChapters) do
        if value == novelID then
            return true
        end
    end
    return false
end

KingDeerData.CheckFindDataValid = function()
    if this.findDatas == nil or type(this.findDatas) ~= "table" or #this.findDatas == 0 then
        return false
    end
    return true
end


KingDeerData.GetZoneData = function(index)
    local findData = this.findDatas[index]
    local activityMaps = DataMgr.Player.activityMaps[findData.area]
    local firstActivityEvent = nil
    if activityMaps ~= nil and type(activityMaps) == "table" and type(activityMaps.activityEvents) == "table" then
        for key, value in pairs(findData.eventMapData) do
            value.rating = DataExHelper.GetDungeonDecordRating(value.config.id)
            if value.isUnLock ~= true then
                local conditionRaring = DataExHelper.GetDungeonDecordRating(value.config.unlockParam)
                value.isUnLock = conditionRaring > 0 and true or false
            end
            if value.isUnLock ~= true then
                value.isUnLock = KingDeerData.GetNovelIsLook(value.config.unlockParam)
            end
            local isLookNovel = KingDeerData.GetNovelIsLook(value.config.id)
            local tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7320")
            if value.config.type == 1 then
                tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7319")
            end
            local unlockStr = nil
            if value.config.unlockParam ~= nil and value.config.unlockParam ~= "" then
                local unlockConfig = KingDeerData.GetPassData(value.config.unlockParam).config
                local name = LuaMgr.GetLangText(unlockConfig.namelan)
                unlockStr = string.format(tips, name)
            end
            KingDeerData.SetNovelData(value.config.id, value.isUnLock, isLookNovel, unlockStr)

            value.isComplete = value.rating == 1 or isLookNovel
            if firstActivityEvent == nil then
                firstActivityEvent = value
            end
        end
    end
    local questData = DataMgr.Player.quests[findData.progressConfig.id]
    if type(questData) == "table" then
        findData.progressNum = questData.progress
        if questData.progress == findData.progressConfig.progress then
            if questData.state == 2 then
                findData.status = KingDeerData.GetRewardStatus.CanGet
            else
                findData.status = KingDeerData.GetRewardStatus.Got
            end
        end
    end


    if firstActivityEvent then
        findData.isUnLock = firstActivityEvent.isUnLock
    end
    if findData.isUnLock == false and findData.mapGroupConfig.unlockType == 1 then
        findData.isUnLock = KingDeerData.GetNovelIsLook(findData.mapGroupConfig.unlockParam)
    end
    local frontData = KingDeerData.GetPassData(findData.mapGroupConfig.unlockParam)
    if frontData ~= nil then
        local frontConfig = frontData.config
        local tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7320")
        if frontConfig.type == 1 then
            tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7319")
        end
        local frontEventName = LuaMgr.GetLangText(frontConfig.namelan)
        findData.unlockTips = string.format(tips, frontEventName)
    else
        findData.unlockTips = ""
    end
    KingDeerData.SetNovelData(this.headNovelID, true, KingDeerData.GetNovelIsLook(this.headNovelID), findData.unlockTips)
    local pictureBookIsunlock = KingDeerData.PictureLookNovelIsUnlock()
    local progressData = KingDeerData.GetTotalProgress()
    local tipsStr = LuaMgr.GetLangText(progressData.config.remarksLan)
    KingDeerData.SetNovelData(this.pictureBookNovelID, pictureBookIsunlock, KingDeerData.GetNovelIsLook(this.pictureBookNovelID), tipsStr)
    return findData
end

KingDeerData.GetPassData = function(id)
    local data = this.eventMapDataDic[id]
    return data
end



KingDeerData.GetPictureBookDatas = function()
    local pictureBookDatas = {}
    for i = 1, #this.questPictureBookDatas do
        local tempData = this.questPictureBookDatas[i]
        local questData = DataMgr.Player.quests[tempData.config.id]
        tempData.questData = questData
        tempData.progress = questData ~= nil and questData.progress or 0
        if tempData.progress >= tempData.config.progress then
            tempData.status = KingDeerData.PictureBookStatus.Actived
        else
            tempData.status = KingDeerData.PictureBookStatus.CanActive
            for key, value in pairs(tempData.config.cost) do
                if DataHelper.GetItemCountById(value.id) < value.count then
                    tempData.status = KingDeerData.PictureBookStatus.Lock
                    break
                end
            end
        end
        table.insert(pictureBookDatas, tempData)
    end
    table.sort(pictureBookDatas, KingDeerData.SortPictureBookDatas)
    return pictureBookDatas
end

KingDeerData.SortPictureBookDatas = function(data1, data2)
    return data1.config.id < data2.config.id
end

KingDeerData.GetTotalProgress = function()
    local tempData = this.questPictureBookRewardData
    local questData = DataMgr.Player.quests[tempData.config.id]
    tempData.questData = questData
    return tempData
end

KingDeerData.PictureLookNovelIsUnlock = function()
    local progressData = KingDeerData.GetTotalProgress()
    if type(progressData.questData) ~= "table" or progressData.questData.progress < progressData.config.progress then
        return false
    end
    return true
end


KingDeerData.CheckRedDot = function(noInit)
    if ActivityMgr.ActivityRuning(ActivityKey.KingDeerActivity) == false then
        return
    end
    if KingDeerData.CheckFindDataValid() == false then
        KingDeerData.Init()
    end
    local rewardRed, taskRedNum = HeroRedDataHelper.GetPassesRed()
    local passNum = rewardRed + taskRedNum
    local zoneNum = KingDeerData.GetZondRedpointNum()
    local pictureBookCount = KingDeerData.GetPictureRedpointNum()
    RedMgr.Singleton:UpdateClientRedData("15070", passNum + pictureBookCount + zoneNum)
    RedMgr.Singleton:UpdateClientRedData("15071", passNum)
    RedMgr.Singleton:UpdateClientRedData("15074", zoneNum)
    RedMgr.Singleton:UpdateClientRedData("15076", pictureBookCount)
end

KingDeerData.GetZondRedpointNum = function()
    local zoneNum = 0
    for i = 1, 4 do
        local data = KingDeerData.GetZoneData(i)
        if data.status == KingDeerData.GetRewardStatus.CanGet then
            zoneNum = zoneNum + 1
        end
    end
    return zoneNum
end

KingDeerData.GetPictureRedpointNum = function()
    KingDeerData.GetPictureBookDatas()
    local num = 0
    for key, value in pairs(this.questPictureBookDatas) do
        if value.status == KingDeerData.PictureBookStatus.CanActive then
            num = num + 1
        end
    end
    local progressData = KingDeerData.GetTotalProgress()
    if (progressData.questData.progress < progressData.config.progress or KingDeerData.GetNovelIsLook(KingDeerData.GetNovelID(6)) == true) == false then
        num = 1
    end
    return num
end

KingDeerData.SetLastZoneIndex = function(index)
    this.lastZoneIndex = index
end

KingDeerData.GetlastZoneIndex = function()
    return this.lastZoneIndex
end