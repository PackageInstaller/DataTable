local module = {}

local function setResourcesElementShow(element, curValue, maxValue)
  element.Txt_Num:SetText(curValue .. "/" .. maxValue)
  element.Img_PB:SetFilledImgAmount(curValue / maxValue)
end

function module.AutoSubMoveEnergy(changeCb)
  if PlayerData:GetUserInfo().move_energy == nil then
    return
  end
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  if PlayerData:GetUserInfo().move_energy <= 0 then
    return
  end
  local onceTime = homeConfig.homeEnergyAddCD
  local onceAdd = -homeConfig.homeEnergyAdd
  if TimeUtil:GetServerTimeStamp() >= PlayerData:GetUserInfo().move_energy_time + onceTime then
    PlayerData:GetUserInfo().move_energy_time = PlayerData:GetUserInfo().move_energy_time + onceTime
    PlayerData:GetUserInfo().move_energy = PlayerData:GetUserInfo().move_energy + onceAdd
    if PlayerData:GetUserInfo().move_energy < 0 then
      PlayerData:GetUserInfo().move_energy = 0
    end
    changeCb()
  end
end

function module.SetMoveEnergyElement(element)
  local curEnergy = PlayerData:GetUserInfo().move_energy
  setResourcesElementShow(element, curEnergy, module.GetMaxHomeEnergy())
end

function module.SetEnergyElement(element)
  local user_info = PlayerData:GetUserInfo()
  setResourcesElementShow(element, user_info.energy or 0, user_info.max_energy or 0)
end

function module.SetLoadageElement(element)
  local user_info = PlayerData:GetUserInfo()
  setResourcesElementShow(element, user_info.space_info.now_train_goods_num or 0, PlayerData.GetMaxTrainGoodsNum())
end

function module.SetPassengerElement(element)
  setResourcesElementShow(element, PlayerData:GetCurPassengerNum() or 0, PlayerData:GetMaxPassengerNum() or 0)
end

function module.SetPublicizePsgElement(element, playgroundId)
  setResourcesElementShow(element, PlayerData.GetVisitorsNum(playgroundId) or 0, PlayerData.GetMaxVisitorsNum(playgroundId) or 0)
end

function module.SetTradeElement(element)
  local curTotalTradeExp, totalTradeExp = module.GetTradeExpValue()
  setResourcesElementShow(element, curTotalTradeExp, totalTradeExp)
  local lv = PlayerData:GetHomeInfo().trade_lv
  if element.Txt_Lv then
    element.Txt_Lv:SetText(lv)
  end
end

function module.SetReputationElement(element, stationId, isShowRedPoint)
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if stationCA.attachedToCity > 0 then
    stationId = stationCA.attachedToCity
  end
  local serverStation = PlayerData:GetHomeInfo().stations[tostring(stationId)]
  local curTotalRep, totalRep = module.GetReputationValue(stationId)
  element.Txt_Grade:SetActive(true)
  local curLv = serverStation.rep_lv or 0
  element.Txt_Grade:SetText(string.format(GetText(80600542), curLv))
  if totalRep <= curTotalRep then
    element.Txt_Num:SetText(curTotalRep)
    element.Img_PB:SetFilledImgAmount(1)
  else
    element.Txt_Num:SetText(curTotalRep .. "/" .. totalRep)
    element.Img_PB:SetFilledImgAmount(curTotalRep / totalRep)
  end
  if isShowRedPoint == nil then
    isShowRedPoint = true
  end
  element.Img_RedPoint:SetActive(isShowRedPoint and not module.IsAllRepValueGet(stationId))
end

function module.ClickReputationBtn(stationId, posX, posY, yesCb)
  local stationCfg = PlayerData:GetFactoryData(stationId)
  if stationCfg.isSpecialRep then
    return
  end
  local t = {}
  t.stationId = stationId
  if posX ~= nil and posY ~= nil then
    t.posX = posX
    t.posY = posY
  end
  UIManager:Open(UIPath.UIHomeReputation, Json.encode(t), yesCb)
end

function module.GetReputationValue(stationId)
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if stationCA.attachedToCity > 0 then
    stationId = stationCA.attachedToCity
    stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  end
  local serverStation = PlayerData:GetHomeInfo().stations[tostring(stationId)]
  local curLv = serverStation.rep_lv or 0
  local curReputationValue = serverStation.rep_num or 0
  local rewardList = stationCA.repRewardList
  local totalValue = 0
  for i = 1, curLv do
    totalValue = totalValue + rewardList[i].repNum
  end
  local curTotalRep = 0
  if rewardList[curLv + 1] ~= nil then
    curTotalRep = totalValue
    curTotalRep = curTotalRep + rewardList[curLv + 1].repNum
  end
  if curLv + 1 == #rewardList then
    curTotalRep = 0
  end
  totalValue = totalValue + curReputationValue
  totalValue = math.modf(totalValue)
  return totalValue, math.modf(curTotalRep)
end

function module.GetTradeExpValue()
  local curLv = PlayerData:GetHomeInfo().trade_lv
  local curExp = PlayerData:GetHomeInfo().exp
  local tradeExpConfig = PlayerData:GetFactoryData(99900016, "ConfigFactory")
  local tradeList = tradeExpConfig.expList
  return curExp, tradeList[curLv].needExp
end

function module.GetCurLvRepData(stationId)
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if stationCA.attachedToCity > 0 then
    stationId = stationCA.attachedToCity
    stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  end
  local serverStation = PlayerData:GetHomeInfo().stations[tostring(stationId)]
  local curLv = (serverStation.rep_lv or 0) + 1
  local rewardList = stationCA.repRewardList or {}
  return rewardList[curLv]
end

function module.GetRepRewardList(stationId)
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if stationCA.attachedToCity > 0 then
    stationId = stationCA.attachedToCity
    stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  end
  return stationCA.repRewardList or {}
end

function module.GetRepLv(stationId)
  stationId = tonumber(stationId)
  if stationId == nil or stationId <= 0 then
    return 0
  end
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if stationCA == nil then
    return 0
  end
  if 0 < stationCA.attachedToCity then
    stationId = stationCA.attachedToCity
  end
  return PlayerData:GetHomeInfo().stations[tostring(stationId)].rep_lv
end

function module.GetDevDegree(stationId)
  local serverDevData = PlayerData:GetHomeInfo().dev_degree[tostring(stationId)]
  if serverDevData then
    return math.floor(serverDevData.dev_degree) or 0
  end
  return 0
end

function module.TimeCheckRefreshStationInfo(force, cb)
  local function refreshFunc()
    Net:SendProto("station.refresh", function(json)
      for k, v in pairs(json.stations) do
        for k1, v1 in pairs(v) do
          PlayerData:GetHomeInfo().stations[k][k1] = v1
        end
      end
      if cb ~= nil then
        cb()
      end
    end)
  end
  
  local curTime = TimeUtil:GetServerTimeStamp()
  if force or PlayerData.TempCache.stationRefresh == nil then
    PlayerData.TempCache.stationRefresh = curTime
    refreshFunc()
    return
  else
    local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
    local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
    local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
    local targetTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s, PlayerData.TempCache.stationRefresh)
    if curTime >= targetTime then
      PlayerData.TempCache.stationRefresh = curTime
      refreshFunc()
      return
    end
  end
  if cb ~= nil then
    cb()
  end
end

function module.OpenMoveEnergyUseItem(cb)
  local itemCA = PlayerData:GetFactoryData(11400064, "ItemFactory")
  local homeEnergyItemList = PlayerData:GetFactoryData(99900014).homeEnergyItemList
  local data = {}
  data.idList = {}
  for i, v in ipairs(homeEnergyItemList) do
    table.insert(data.idList, v.id)
  end
  table.insert(data.idList, 11400005)
  UIManager:Open("UI/MoveEnergy/MoveEnergy", Json.encode(data), cb)
end

function module.GetCurShowSceneInfo(stationId)
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  local stateInfo = module.GetCityStateInfo(stationId)
  if stateInfo == nil then
    stateInfo = stationCA.cityStateList[1]
  end
  local cityMapCA = PlayerData:GetFactoryData(stateInfo.cityMapId)
  local bgList = cityMapCA.bgList
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local scaleOneDaySecond = 86400 / homeConfig.dayScale
  local scaleTimeToday = (TimeUtil:GetServerTimeStamp() + PlayerData.TimeZone * 3600) % scaleOneDaySecond
  local todayZeroTimeStamp = scaleTimeToday / scaleOneDaySecond * 86400
  local idx = 1
  for k, v in pairs(bgList) do
    local h = tonumber(string.sub(v.changeTime, 1, 2))
    local m = tonumber(string.sub(v.changeTime, 4, 5))
    local s = tonumber(string.sub(v.changeTime, 7, 8))
    local time = h * 3600 + m * 60 + s
    if todayZeroTimeStamp < time then
      idx = k
      break
    end
  end
  idx = idx - 1
  if idx <= 0 then
    idx = #bgList
  end
  local detailInfo = bgList[idx]
  local sceneInfo
  local curDevDegree = PlayerData:GetHomeInfo().dev_degree[tostring(stationId)].dev_degree or 0
  local sceneCA = PlayerData:GetFactoryData(detailInfo.sceneId, "ListFactory")
  for k, v in pairs(sceneCA.stationSceneList) do
    if curDevDegree >= v.dev then
      sceneInfo = v
    end
  end
  if sceneInfo == nil then
    sceneInfo = sceneCA.stationSceneList[1]
  end
  local CurShowSceneInfo = {}
  CurShowSceneInfo.stationScene = sceneInfo.stationScene
  CurShowSceneInfo.postProcessingPath = sceneInfo.postProcessingPath
  CurShowSceneInfo.sceneWidth = sceneInfo.sceneWidth
  CurShowSceneInfo.bgmId = sceneInfo.bgmId
  CurShowSceneInfo.sceneGroup = sceneInfo.sceneGroup
  return CurShowSceneInfo
end

function module.GetMaxHomeEnergy()
  local userExpConfig = PlayerData:GetFactoryData(99900004, "ConfigFactory")
  local curLv = PlayerData:GetPlayerLevel()
  local count = #userExpConfig.expList
  if curLv > count then
    curLv = count
  end
  return userExpConfig.expList[curLv].homeEnergyMax + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseEnergyLimited)
end

function module.IsAllConstructionValueGet(stationId)
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  local stateInfo = module.GetCityStateInfo(stationId)
  local listCA = PlayerData:GetFactoryData(stateInfo.cityMapId, "CityMapFactory")
  if listCA.isShowConstruct then
    local ConstructMaxNum = 0
    local ConstructNowNum = 0
    local ConstructNowCA = {}
    local StationList = PlayerData:GetHomeInfo().stations[tostring(stationId)]
    local StationState = StationList.state
    for k, v in pairs(StationList.construction) do
      ConstructNowNum = ConstructNowNum + v.proportion
    end
    local construction_count = 0
    for i = 1, #stationCA.constructStageList do
      local row = stationCA.constructStageList[i]
      ConstructMaxNum = ConstructMaxNum + row.constructNum
      ConstructNowCA = row
      construction_count = i
      if row.state and row.state ~= -1 and ConstructNowNum >= ConstructMaxNum and StationState < row.state then
        StationState = row.state
        PlayerData:GetHomeInfo().stations[tostring(stationId)].state = row.state
      end
      if ConstructNowNum <= ConstructMaxNum then
        break
      end
    end
    return PlayerData:GetConstructStageRewardState(stationId)
  end
end

function module.IsAllRepValueGet(stationId)
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if stationCA.isSpecialRep then
    return true
  end
  if stationCA.attachedToCity > 0 then
    stationId = stationCA.attachedToCity
  end
  local serverStation = PlayerData:GetHomeInfo().stations[tostring(stationId)]
  local curLv = serverStation.rep_lv or 0
  local isGet = {}
  if serverStation.rep_reward ~= nil then
    for k, v in pairs(serverStation.rep_reward) do
      isGet[v] = 1
    end
  end
  for i = 1, curLv do
    if not isGet[i] then
      return false
    end
  end
  return true
end

function module.GetCityStateInfo(stationId)
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  local curStationServerData = PlayerData:GetHomeInfo().stations[tostring(stationId)]
  local curState = curStationServerData.state or 0
  for k, v in pairs(stationCA.cityStateList) do
    if v.state == curState then
      return v
    end
  end
  return nil
end

function module.CheckStationUnlock(stationId, detailCheckInfo)
  local stationCA = PlayerData:GetFactoryData(stationId)
  local isBanStop = stationCA.isBanStop
  local activityCheckOk = true
  local lvCheckOk = true
  local levelCheckOk = true
  local questCheckOk = true
  local itemCheckOk = true
  local isUnlock = not isBanStop
  if not isBanStop then
    if stationCA.constructionActivityId > 0 then
      local activityCA = PlayerData:GetFactoryData(stationCA.constructionActivityId)
      local curPcnt = PlayerData:GetActivityServerConstructionCstNum(stationCA.constructionActivityId)
      activityCheckOk = curPcnt >= activityCA.constructionLimit
    end
    lvCheckOk = PlayerData:GetUserInfo().lv >= stationCA.playerLevel
    levelCheckOk = 0 > stationCA.specifiedLevelId or PlayerData:GetLevelPass(stationCA.specifiedLevelId)
    questCheckOk = 0 > stationCA.questId or PlayerData.IsQuestComplete(stationCA.questId)
    itemCheckOk = 0 > stationCA.itemId or 0 < PlayerData:GetGoodsById(stationCA.itemId).num
    isUnlock = activityCheckOk and itemCheckOk and lvCheckOk and levelCheckOk and questCheckOk
  end
  if detailCheckInfo ~= nil and type(detailCheckInfo) == "table" then
    detailCheckInfo.activityCheckOk = activityCheckOk
    detailCheckInfo.lvCheckOk = lvCheckOk
    detailCheckInfo.levelCheckOk = levelCheckOk
    detailCheckInfo.questCheckOk = questCheckOk
    detailCheckInfo.itemCheckOk = itemCheckOk
  end
  return isUnlock
end

function module.TempFishErrorSolved(ufid)
  local updatesFurs = CS.FRef.getProperty(HomeCreatureManager, "lstUpdateFurs")
  local count = updatesFurs.Count
  for i = 0, count - 1 do
    local fur = updatesFurs[i]
    if fur and (ufid == nil or ufid == fur.ufid) then
      local serverFur = CommonCoachData.GetFurData()[fur.ufid]
      if serverFur then
        local ca = PlayerData:GetFactoryData(serverFur.id)
        if ca.functionType == 12600143 then
          local creatures = fur.viewPart.lstCreatures
          local creaturesCount = creatures.Count
          for j = 0, creaturesCount - 1 do
            local creatureInfo = creatures[j]
            local wallCollisionInfo = CS.FRef.getProperty(creatureInfo, "frameEnterWallCollision")
            if wallCollisionInfo ~= nil then
              wallCollisionInfo:Clear()
            end
            local otherCollisionInfo = CS.FRef.getProperty(creatureInfo, "frameEnterOtherCollision")
            if otherCollisionInfo ~= nil then
              otherCollisionInfo:Clear()
            end
          end
        end
        if ufid ~= nil then
          break
        end
      end
    end
  end
end

local function ResetPileUpFurnitureShow(room)
  local floorFurniture = room.floorFurniture
  local cnt = floorFurniture.Count
  local serverFurniture = CommonCoachData.GetFurData()
  for i = 0, cnt - 1 do
    local fur = floorFurniture[i]
    local furServerData = serverFurniture[fur.ufid]
    if furServerData ~= nil then
      local ca = PlayerData:GetFactoryData(furServerData.id)
      if not (0 < fur.furGroup.Count) and (not ca.pileUpList or #ca.pileUpList ~= 0) then
        local furs = {}
        local posX = fur.PosX
        local posY = fur.PosY
        for j = 0, cnt - 1 do
          fur = floorFurniture[j]
          furServerData = serverFurniture[fur.ufid]
          if furServerData ~= nil then
            ca = PlayerData:GetFactoryData(furServerData.id)
            if fur.PosX == posX and fur.PosY == posY and ca.pileUpList and 0 < #ca.pileUpList then
              table.insert(furs, fur)
            end
          end
        end
        if 0 < #furs then
          table.sort(furs, function(a, b)
            return a.PosZ < b.PosZ
          end)
          local fursLen = #furs
          for j = fursLen, 2, -1 do
            furs[j]:SetPileUpLayer(furs[j - 1], true)
          end
        end
      end
    end
  end
end

function module.TempRefreshRoomPileUpData()
  local rooms = HomeManager.rooms
  local length = rooms.Length
  for i = 0, length - 1 do
    ResetPileUpFurnitureShow(rooms[i])
  end
end

function module.TempRefreshSpecialRoomPileUpData(idx)
  local rooms = HomeManager.rooms
  local length = rooms.Length
  if idx < 0 or idx > length then
    return
  end
  ResetPileUpFurnitureShow(rooms[idx])
end

function module.DailyCheckBarStoreShopRedPoint()
  local function setNextRefreshTime()
    local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    
    local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
    local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
    local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
    PlayerData.TempCache.barStoreRedPointNextRefresh = TimeUtil:GetNextSpecialTimeStamp(h, m, s)
  end
  
  if PlayerData.TempCache.barStoreRedPointNextRefresh == nil then
    setNextRefreshTime()
  end
  local curTime = TimeUtil:GetServerTimeStamp()
  if curTime >= PlayerData.TempCache.barStoreRedPointNextRefresh then
    setNextRefreshTime()
    local shopId = 40300012
    local commodityId = 40200454
    local nodeName = RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity .. "|" .. shopId .. "|" .. commodityId
    RedpointTree:InsertNode(nodeName)
    RedpointTree:ChangeRedpointCnt(nodeName, 1)
    local date = os.date("!*t", curTime)
    local weekCommodityId = 40200293
    if date.wday == 1 and date.hour + PlayerData.TimeZone >= 24 or date.wday == 2 and date.hour + PlayerData.TimeZone < 24 then
      nodeName = RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity .. "|" .. shopId .. "|" .. weekCommodityId
      RedpointTree:InsertNode(nodeName)
      RedpointTree:ChangeRedpointCnt(nodeName, 1)
    end
    
    local function checkMonthFirstDay()
      if date.day == 1 and date.hour + PlayerData.TimeZone < 24 then
        return true
      end
      local isMonthLastDay = false
      if date.day == 31 and date.hour + PlayerData.TimeZone >= 24 then
        isMonthLastDay = true
      elseif date.day == 30 and (date.month == 4 or date.month == 6 or date.month == 9 or date.month == 11) then
        isMonthLastDay = true
      elseif (date.day == 29 or date.day == 28) and date.month == 2 then
        if date.year % 400 == 0 or date.year % 4 == 0 and date.year % 100 ~= 0 then
          isMonthLastDay = date.day == 29
        else
          isMonthLastDay = date.day == 28
        end
      end
      if isMonthLastDay and date.hour + PlayerData.TimeZone >= 24 then
        return true
      end
      return false
    end
    
    if checkMonthFirstDay() then
      do
        local monthCommodityId = 40200028
        nodeName = RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity .. "|" .. shopId .. "|" .. monthCommodityId
        RedpointTree:InsertNode(nodeName)
        RedpointTree:ChangeRedpointCnt(nodeName, 1)
      end
    end
  end
end

function module.GetHomeCharactersByIdx(idx)
  local roles = CS.FRef.getProperty(HomeCharacterManager, "_roles")
  local isFind = false
  if roles:ContainsKey(idx) then
    isFind = true
  end
  if not isFind then
    local spRoles = CS.FRef.getProperty(HomeCharacterManager, "_spRoles")
    if not spRoles:ContainsKey(idx) then
      return nil
    end
    roles = spRoles
  end
  return roles[idx]
end

function module.RemoveCharacter(character, tag)
  local roles = CS.FRef.getProperty(HomeCharacterManager, tag)
  if roles ~= nil and roles:ContainsKey(character.id) then
    roles:Remove(character.id)
    character.needRecycle = true
  end
end

function module.GetTotalFurScoreInfo(playgroundId)
  local roomData = CommonCoachData.GetRoomData(playgroundId, true)
  local totalScoreInfo = {
    pet = 0,
    fish = 0,
    comfort = 0,
    plant = 0,
    food = 0,
    play = 0,
    medical = 0
  }
  for i, v in ipairs(roomData) do
    for i1, v1 in ipairs(v.location) do
      local scoreInfo = PlayerData.GetFurScoreWithAllBuff(v1.id, 12601230)
      totalScoreInfo.pet = totalScoreInfo.pet + scoreInfo.pet
      totalScoreInfo.fish = totalScoreInfo.fish + scoreInfo.fish
      totalScoreInfo.comfort = totalScoreInfo.comfort + scoreInfo.comfort
      totalScoreInfo.plant = totalScoreInfo.plant + scoreInfo.plant
      totalScoreInfo.food = totalScoreInfo.food + scoreInfo.food
      totalScoreInfo.play = totalScoreInfo.play + scoreInfo.play
      totalScoreInfo.medical = totalScoreInfo.medical + scoreInfo.medical
    end
  end
  return totalScoreInfo
end

function module.CheckClientScoreQuest(totalScoreInfo, questCA, playgroundId)
  if questCA.isFURNQuest then
    local checkOk = true
    local curNum = 0
    local maxNum = 0
    for i1, condition in ipairs(questCA.conditionList) do
      local val = tonumber(condition.val)
      if condition.key == "groundId" then
        checkOk = checkOk and val == playgroundId
      elseif condition.key == "comfortScores" then
        checkOk = checkOk and val <= totalScoreInfo.comfort
        curNum = totalScoreInfo.comfort
      elseif condition.key == "foodScores" then
        checkOk = checkOk and val <= totalScoreInfo.food
        curNum = totalScoreInfo.food
      elseif condition.key == "playScores" then
        checkOk = checkOk and val <= totalScoreInfo.play
        curNum = totalScoreInfo.play
      elseif condition.key == "plantScores" then
        checkOk = checkOk and val <= totalScoreInfo.plant
        curNum = totalScoreInfo.plant
      elseif condition.key == "fishScores" then
        checkOk = checkOk and val <= totalScoreInfo.fish
        curNum = totalScoreInfo.fish
      elseif condition.key == "petScores" then
        checkOk = checkOk and val <= totalScoreInfo.pet
        curNum = totalScoreInfo.pet
      elseif condition.key == "medicalScores" then
        checkOk = checkOk and val <= totalScoreInfo.medical
        curNum = totalScoreInfo.medical
      end
      curNum = math.floor(curNum)
      if condition.key ~= "groundId" then
        maxNum = val
      end
    end
    return checkOk, curNum, maxNum
  end
  return true, 0, 0
end

function module.GetOutStationRandomChangeSkin()
  local isChange = PlayerData:GetPlayerPrefs("int", "OutStationRandomChangeSkin") == 1
  local isSpecial = PlayerData.CurTrainSkinIsSpecial()
  local coachSkins, completeCb
  if isChange and not isSpecial then
    local trainSkinDataModel = require("UIHomeCarriageeditor/UITrainSkinDataModel")
    trainSkinDataModel.InitTrainSkinData(true)
    if #trainSkinDataModel.coachData > 0 then
      local headCoachData = trainSkinDataModel.coachData[1]
      local randomMaxCount = headCoachData.unlockCount - 1
      if 1 <= randomMaxCount then
        do
          local randomSkinIdx = math.random(1, randomMaxCount)
          local curTypeIdx = 1
          for i = 1, #headCoachData.skins do
            local unlockCount = 0
            for j, skinInfo in ipairs(headCoachData.skins[i]) do
              if skinInfo.isUnlock then
                if not skinInfo.used then
                  unlockCount = unlockCount + 1
                end
              else
                break
              end
            end
            if 0 < randomSkinIdx - unlockCount then
              randomSkinIdx = randomSkinIdx - unlockCount
            else
              curTypeIdx = i
              break
            end
          end
          local curSkinTable = headCoachData.skins[curTypeIdx]
          if 0 < randomSkinIdx and curSkinTable and randomSkinIdx <= #curSkinTable then
            local skinInfo = curSkinTable[randomSkinIdx]
            local skinId = skinInfo.id
            local skinCA = PlayerData:GetFactoryData(skinId)
            local tagSkinIds = trainSkinDataModel.skinTagSkinIds[skinCA.skinTag]
            local cacheSameSkin = {}
            for i, v in ipairs(tagSkinIds) do
              cacheSameSkin[v] = 1
            end
            local cacheCoachUseSkin = {}
            for i, v in ipairs(trainSkinDataModel.coachData) do
              if i ~= 1 then
                local skinTable = v.skins[curTypeIdx]
                for i1, tempSkinInfo in ipairs(skinTable) do
                  if cacheSameSkin[tempSkinInfo.id] then
                    if tempSkinInfo.isUnlock and not tempSkinInfo.used then
                      cacheCoachUseSkin[v.uid] = tostring(tempSkinInfo.id)
                    end
                    break
                  end
                end
              end
            end
            coachSkins = ""
            if not skinInfo.used then
              coachSkins = headCoachData.uid .. ":" .. skinId
            end
            for k, v in pairs(cacheCoachUseSkin) do
              if coachSkins == "" then
                coachSkins = k .. ":" .. v
              else
                coachSkins = coachSkins .. "," .. k .. ":" .. v
              end
            end
            
            function completeCb()
              local serverSkinInfo = PlayerData:GetHomeInfo().coach_store[headCoachData.uid]
              serverSkinInfo.skin = tostring(skinId)
              for k, v in pairs(cacheCoachUseSkin) do
                local tempSeverSkinInfo = PlayerData:GetHomeInfo().coach_store[k]
                tempSeverSkinInfo.skin = v
              end
              local homeController = require("UIMainUI/UIMainUIController")
              homeController.InitTrain(false)
            end
          end
        end
      end
    end
  end
  return coachSkins, completeCb
end

return module
