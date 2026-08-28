local DataModel = {
  envIDs = 70400001,
  startHeight = 0,
  roomID = {},
  roomUCid = {},
  roomSkinIds = {},
  screenshot = {x = 800, y = 653},
  camOffsetX = 0,
  camOffsetY = -1.25,
  coachWornCost = 0,
  coachWornToCityName = "",
  tempHockReward = {},
  camTimeEffect = {},
  curTimeEffect = "",
  todayZeroTimeStamp = 0,
  oneDayTimeStamp = 86400,
  cameraTween = false,
  isOpenView = false,
  isPosterGirlShow = false,
  UIShowEnum = {
    OutSide = 1,
    Coach = 2,
    Adjutant = 3,
    Passenger = 4
  },
  CurSceneName = "",
  SceneNameEnum = {Main = "Main", Home = "Home"},
  nowSoundId = 0,
  IsDrinkBuffShow = false,
  CacheQuestAwardCo = nil,
  passengerCoroutine = nil,
  FixedTime = 0,
  CurShowSceneInfo = {},
  FirstFrame = false,
  MaxCoachNum = 0,
  CurBanEnterCoachCount = 0,
  JumpRoomCtrList = {},
  SelectJumpRoomCtr = nil,
  MainToESC = false,
  TrainRushEffectPath = "UI/UIEffect/particle/UI_train_rush_ele/UI_train_rush_ele_01",
  RushTimeBtnEffectPath = "UI/UIEffect/particle/UI_rushTimeBtn/UI_rushTimeBtn_01",
  RushBuyBtnEffectPath = "UI/UIEffect/particle/UI_rushBuyBtn/UI_rushBuyBtn",
  MainRushEffectPath = "UI/UIEffect/particle/UI_mainRush/UI_mainRush",
  TrainStrikeEffectPath = "UI/UIEffect/particle/UI_train_strike/UI_train_strike",
  WarningEffectPath = "UI/UIEffect/particle/UI_Warning/UI_Warning_Particle",
  MaxDashBoardSpeed = 240,
  RushServerTime = 0,
  justArrived = false,
  IsActivity = false,
  mapStationList = {},
  activeBtnList = {},
  mainQuestStationId = 0,
  bannerDay = 0
}
local ChangePosterGirlDataModel = require("UIChangePosterGirl/UIChangePosterGirlDataModel")
local HomeTradeUpgradeDataModel = require("UIHomeTradeUpgrade/UIHomeTradeUpgradeDataModel")

function DataModel.InitModel()
  DataModel.CurrLineId = nil
  DataModel.CurrLineInfo = nil
  DataModel.AreaTipIndex = 0
  DataModel.AttractionTipIndex = 0
  DataModel.IsEvent = false
  DataModel.IsShow = nil
  DataModel.SetIsArrivingState()
  DataModel.SetTrainEventBasicId()
  DataModel.SetIsRushClick()
  DataModel.SetStrikePercent()
  DataModel.SetIsStrikeStart()
end

function DataModel.RefreshData(data)
  DataModel.roomUCid = {}
  DataModel.roomID = {}
  DataModel.roomSkinIds = {}
  for i, v in ipairs(data) do
    local coachCA = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
    local tagCA = PlayerData:GetFactoryData(coachCA.coachType)
    if not tagCA.stopCarriage then
      table.insert(DataModel.roomUCid, PlayerData:GetHomeInfo().coach_template[i])
      table.insert(DataModel.roomID, v.id)
    end
    local skinId = tonumber(v.skin)
    if skinId == nil then
      skinId = coachCA.defaultSkin
    end
    if i == #data then
      local skinCA = PlayerData:GetFactoryData(skinId)
      local defaultCfg = PlayerData:GetFactoryData(99900044)
      for m, n in pairs(defaultCfg.skinList) do
        if skinCA.skinTag == n.tag then
          skinId = n.trainTail
          break
        end
      end
    end
    table.insert(DataModel.roomSkinIds, skinId)
  end
end

function DataModel.AutoCompleteOrder()
  local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
  if TradeDataModel.GetIsTravel() then
    return
  end
  local completeQuests = {}
  local idStr = ""
  for k, v in pairs(PlayerData:GetHomeInfo().stations) do
    if v.quests ~= nil then
      for k1, v1 in pairs(v.quests) do
        for k2, v2 in pairs(v1) do
          if v2.time ~= -1 and k1 == "Send" and TradeDataModel.CurStayCity == v2.sid then
            if idStr == "" then
              idStr = idStr .. k2
            else
              idStr = idStr .. "," .. k2
            end
            local t = {}
            t.stationId = k
            t.questId = k2
            table.insert(completeQuests, t)
          end
        end
      end
    end
  end
  if idStr ~= "" then
    Net:SendProto("station.complete_quest", function(json)
      CommonTips.OpenShowItem(json.reward)
      local showQuests = {}
      for k1, v1 in pairs(completeQuests) do
        table.insert(showQuests, tonumber(v1.questId))
        PlayerData:GetHomeInfo().stations[v1.stationId].quests.Send[v1.questId] = nil
        local questConfig = PlayerData:GetFactoryData(v1.questId, "QuestFactory")
        for k, v in pairs(questConfig.goodsList) do
          if PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)] ~= nil then
            local num = PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)].num
            num = num - v.num
            if num <= 0 then
              PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)].num = 0
            else
              PlayerData.ServerData.user_home_info.warehouse[tostring(v.id)].num = num
            end
          end
        end
      end
      CommonTips.OpenQuestsCompleteTip(showQuests)
      QuestTrace.CompleteQuest(showQuests)
    end, idStr)
  end
end

function DataModel:GetNextSoundTime()
  math.randomseed(os.time())
  local TrustConfig = PlayerData:GetFactoryData(99900039)
  self.nextDelay = TrustConfig.talkIntervalMin + math.random(0, TrustConfig.talkIntervalRandom)
  self.nextPlaySoundTime = self.nextDelay + os.time()
end

function DataModel:InitRoleTrustData()
  self.soundEndTime = 0
  self.roleAudioList = {}
  self.roleAudioCount = {}
  self.weightAllCount = {}
  local roleIds = ChangePosterGirlDataModel.SetRoleId(false, true)
  for k, v in ipairs(roleIds) do
    if v == "" then
      break
    end
    local roleId = v
    local roleConfig = PlayerData:GetFactoryData(roleId)
    local file_id = roleConfig.fileList[1].file
    local nowSkinId = roleConfig.viewId
    local tempView = ChangePosterGirlDataModel.GetViewId(roleId, k)
    if tempView ~= 0 then
      nowSkinId = tempView
    end
    for i, m in ipairs(roleConfig.fileList) do
      if m.skinId == nowSkinId then
        file_id = m.file
        break
      end
    end
    local file_cfg = PlayerData:GetFactoryData(file_id)
    local tempList = {}
    local has_gender_sound = file_cfg.AudioM and next(file_cfg.AudioM)
    if has_gender_sound then
      local gender = PlayerData:GetUserInfo().gender or 1
      local gender_list = gender == 1 and file_cfg.AudioM or file_cfg.AudioF
      local normal_list = file_cfg.TrustAudio
      local normal_indx = 1
      local gender_indx = 1
      while normal_list[normal_indx] or gender_list[gender_indx] do
        if gender_list[gender_indx] == nil then
          table.insert(tempList, normal_list[normal_indx])
          normal_indx = normal_indx + 1
        elseif normal_list[normal_indx] == nil then
          table.insert(tempList, gender_list[gender_indx])
          gender_indx = gender_indx + 1
        elseif normal_list[normal_indx].UnlockLevel <= gender_list[gender_indx].UnlockLevel then
          table.insert(tempList, normal_list[normal_indx])
          normal_indx = normal_indx + 1
        else
          table.insert(tempList, gender_list[gender_indx])
          gender_indx = gender_indx + 1
        end
      end
    else
      for m, n in pairs(file_cfg.TrustAudio) do
        table.insert(tempList, n)
      end
    end
    for i, j in pairs(file_cfg.roleTalkAudio) do
      local _audioCfg = PlayerData:GetFactoryData(j.audioList, "ListFactory")
      local hasRole = true
      for x, y in pairs(_audioCfg.roleList) do
        if not table.contains(roleIds, tostring(y.id)) then
          hasRole = false
        end
      end
      if hasRole then
        table.insert(tempList, j)
      end
    end
    if roleId then
      local trust_lv = PlayerData:GetRoleById(roleId).trust_lv or 1
      self.roleAudioCount[k] = 0
      self.roleAudioList[k] = {}
      for n, p in pairs(tempList) do
        if p.UnlockLevel and trust_lv >= p.UnlockLevel then
          table.insert(self.roleAudioList[k], p)
          self.roleAudioCount[k] = self.roleAudioCount[k] + 1
        elseif p.audioList then
          table.insert(self.roleAudioList[k], p)
          self.roleAudioCount[k] = self.roleAudioCount[k] + 1
        end
      end
    end
    self.weightAllCount[k] = 0
    for i = 3, self.roleAudioCount[k] do
      self.weightAllCount[k] = self.weightAllCount[k] + (self.roleAudioList[k][i].weight or 0)
    end
  end
end

function DataModel.RandomRoleSoundId(index)
  local soudId = -1
  local listIdx = 1
  math.randomseed(os.time())
  local totleWeight = DataModel.weightAllCount[index]
  if 0 < totleWeight then
    local randomWeight = math.random(0, totleWeight)
    for i = 3, DataModel.roleAudioCount[index] do
      randomWeight = randomWeight - (DataModel.roleAudioList[index][i].weight or 0)
      if randomWeight <= 0 then
        soudId = DataModel.roleAudioList[index][i].Audio2 or DataModel.roleAudioList[index][i].audioList
        listIdx = i
        break
      end
    end
  end
  return soudId, listIdx
end

function DataModel.GetCurShowSceneInfo(stationId)
  if not stationId then
    stationId = 0
    local stop_info = PlayerData:GetHomeInfo().station_info.stop_info
    if stop_info ~= nil and stop_info[2] == -1 then
      stationId = stop_info[1]
    else
      stationId = 83000020
    end
  end
  local homeCommon = require("Common/HomeCommon")
  DataModel.CurShowSceneInfo = homeCommon.GetCurShowSceneInfo(stationId)
end

function DataModel.SetTrainEventBasicId(eventId, levelId, lineId, areaId)
  DataModel.TrainEventId = eventId
  DataModel.TrainLevelId = levelId
  DataModel.TrainLineId = lineId
  if areaId ~= 0 then
    DataModel.TrainEventAreaId = areaId
  else
    DataModel.TrainEventAreaId = nil
  end
end

function DataModel.GetTrainEventAreaId()
  return DataModel.TrainEventAreaId
end

function DataModel.SetTrainEventBgmId(bgmId)
  DataModel.TrainEventBgmId = bgmId
end

function DataModel.SetIsRushClick(state)
  DataModel.IsRushClick = state
end

function DataModel.GetIsRushClick()
  return DataModel.IsRushClick
end

function DataModel.GetStrikeSuccessPercent(eventId, lineId)
  local strike = PlayerData.GetStrike()
  if not strike.id then
    return 0
  end
  local strikeCfg = PlayerData:GetFactoryData(strike.id)
  local ratioA = strikeCfg.configWinPercent
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local speedRatio = homeConfig.speedRatio
  local eventCfg = PlayerData:GetFactoryData(eventId)
  local lineCfg = PlayerData:GetFactoryData(lineId, "HomeLineFactory")
  local hpRatio = lineCfg and lineCfg.eventHpRatio or 1
  local eventHp = eventCfg.hp * hpRatio
  local successRatio = ratioA + (TrainManager.TargetSpeed * speedRatio + strikeCfg.power - eventHp) / eventHp
  successRatio = math.min(100, math.max(1, math.floor(successRatio * 100)))
  return successRatio
end

function DataModel.SetRushNumber(rushNumber)
  DataModel.RushNumber = rushNumber
end

function DataModel.GetRushNumber()
  return DataModel.RushNumber
end

function DataModel.SetIsStrikeStart(state)
  DataModel.IsStrikeStart = state
end

function DataModel.GetIsStrikeStart()
  return DataModel.IsStrikeStart
end

function DataModel.GetTrainEventId()
  return DataModel.TrainEventId
end

function DataModel.GetTrainLineId()
  return DataModel.TrainLineId
end

function DataModel.SetStrikePercent(percent)
  DataModel.StrikePercent = percent
end

function DataModel.GetStrikePercent()
  return DataModel.StrikePercent
end

function DataModel.SetIsRushing(state)
  DataModel.IsRushing = state
end

function DataModel.GetIsRushing()
  return DataModel.IsRushing
end

function DataModel.SetWeaponRushDuration(duration)
  DataModel.WeaponRushDuration = duration
end

function DataModel.GetWeaponRushDuration()
  return DataModel.WeaponRushDuration
end

function DataModel.SetIsWeaponRushShow(isShow)
  DataModel.IsWeaponRushShow = isShow
end

function DataModel.GetIsWeaponRushShow()
  return DataModel.IsWeaponRushShow
end

function DataModel.SetIsArrivingState(state)
  DataModel.IsArriving = state
end

function DataModel.GetIsArrivingState()
  return DataModel.IsArriving
end

function DataModel.SetTrainEventLv(lv)
  DataModel.TrainEventLv = lv
end

function DataModel.GetTrainEventLv()
  return DataModel.TrainEventLv
end

function DataModel.SetRushRemainTime(remainTime)
  DataModel.TrainRushRemainTime = remainTime
end

function DataModel.GetRushRemainTime()
  return DataModel.TrainRushRemainTime
end

function DataModel.ShowHomeBuffTips()
  local buff = PlayerData:GetCurStationStoreBuff(PlayerData:GetCurTrainBuffType())
  local drinkBuff = PlayerData:GetCurDrinkBuff()
  local battleBuff = PlayerData:GetCurStationStoreBuff(EnumDefine.HomeSkillEnum.HomeBattleBuff)
  if buff ~= nil or drinkBuff ~= nil or battleBuff ~= nil then
    local t = {}
    t.posX = -479
    t.posY = -409
    t.drinkBuff = drinkBuff
    t.stationStoreBuff = buff
    t.battleBuff = battleBuff
    UIManager:Open("UI/Common/HomeBuff", Json.encode(t))
  end
end

function DataModel.GetRoomIndexByUCid(ucid)
  for i, v in ipairs(CommonCoachData.roomUCid) do
    if v == ucid then
      return i - 1
    end
  end
end

function DataModel:GetPosterGirlChangeSpine(index, spineIndex, viewCA)
  local spineUrl
  if spineIndex == 0 then
    spineUrl = viewCA.spineUrl
    if DataModel.Live2DState[index] == false then
      if DataModel.SkinBgState[index] or viewCA.SpineBackground == "" then
        spineUrl = viewCA.resUrl
      else
        spineUrl = viewCA.singleUrl
      end
    end
  else
    local extraInfo = viewCA.extraSpineList[spineIndex]
    local unitViewCA = PlayerData:GetFactoryData(extraInfo.id, "UnitViewFactory")
    spineUrl = unitViewCA.spineUrl
    if DataModel.Live2DState[index] == false then
      if DataModel.SkinBgState[index] or unitViewCA.SpineBackground == "" then
        spineUrl = unitViewCA.resUrl
      else
        spineUrl = unitViewCA.singleUrl
      end
    end
  end
  if spineUrl == "" then
  end
  return spineUrl
end

function DataModel.InitMapStationList()
  local homeConfig = PlayerData:GetFactoryData(99900014)
  DataModel.mapStationList = {}
  for i, v in ipairs(homeConfig.stationList) do
    local stationCA = PlayerData:GetFactoryData(v.id)
    local t = {
      id = v.id,
      isShowInMap = stationCA.isShowInMap
    }
    DataModel.mapStationList[i] = t
  end
end

local FuncDic = {}

function DataModel.GetTFunc(classType, methodName, TType)
  if FuncDic[methodName] and FuncDic[methodName][tostring(TType)] then
    return FuncDic[methodName][tostring(TType)]
  end
  local genFunc = xlua.get_generic_method(classType, methodName)
  local realFunc = genFunc(TType)
  FuncDic[methodName] = FuncDic[methodName] or {}
  FuncDic[methodName][tostring(TType)] = realFunc
  return realFunc
end

local GetRes = DataModel.GetTFunc(CS.ResManager, "GetRes", typeof(CS.UnityEngine.Texture2D))
do
  local GachaNewDataModel = require("UIGachaNew/UIGachaNewDataModel")
  
  function DataModel.GetAdInfo(adBoard, Index)
    if DataModel.AdInfoList == nil then
      DataModel.UpdateAdvList(adBoard)
    end
    return DataModel.AdInfoList[Index]
  end
  
  function DataModel.UpdateAdvList(adBoard)
    DataModel.AdInfoList = {}
    local caId = adBoard.caId
    local boardCA = PlayerData:GetFactoryData(caId)
    if boardCA ~= nil and #boardCA.adList > 0 then
      adBoard.imgList:Clear()
      for i = 1, #boardCA.adList do
        adBoard.imgList:Add(GetRes(ResManager, boardCA.adList[i].imageURL, "#AdBoardView"))
      end
    end
    adBoard:OnStart()
    if caId <= 0 then
      return
    end
    local ca = PlayerData:GetFactoryData(caId)
    for i = 1, #ca.adList do
      table.insert(DataModel.AdInfoList, ca.adList[i])
    end
    GachaNewDataModel:GetCardPool()
    do
      local availableGacha = GachaNewDataModel.CardPool[GachaNewDataModel.TabType.Activaty]
      for i = 1, #availableGacha do
        local gachaData = availableGacha[i].data
        if gachaData.adPath ~= nil and gachaData.adPath ~= "" then
          local adIndex = math.min(gachaData.adSerial + 1, #DataModel.AdInfoList + 1)
          local infoItem = {
            uiURL = "UI/Gacha/GachaNew",
            uiParam = Json.encode({
              poolId = gachaData.id
            })
          }
          table.insert(DataModel.AdInfoList, adIndex, infoItem)
          adBoard:AddImg(gachaData.adPath, gachaData.adSerial)
        end
      end
    end
  end
end

function DataModel.GetCityGoldCountAndIcon(stationId)
  local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
  stationId = stationId or TradeDataModel.CurStayCity
  local goldNum = 0
  local icon = ""
  local currencyId = 0
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if not stationCA then
    return goldNum, icon
  end
  local isTravel = TradeDataModel.GetIsTravel()
  if isTravel or not stationCA.isExCity then
    currencyId = 11400001
    local user_info = PlayerData:GetUserInfo()
    if user_info then
      goldNum = user_info.gold or 0
    end
  else
    currencyId = stationCA.currency or 11400001
    goldNum = PlayerData:GetGoodsById(currencyId).num or 0
  end
  local itemCa = PlayerData:GetFactoryData(currencyId, "ItemFactory")
  if itemCa and not string.nilorempty(itemCa.buyPath) then
    icon = itemCa.buyPath
  end
  return goldNum, icon
end

return DataModel
