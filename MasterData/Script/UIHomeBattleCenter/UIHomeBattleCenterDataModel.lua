local View = require("UIHomeBattleCenter/UIHomeBattleCenterView")
local NPCDialog = require("Common/NPCDialog")
local ActivitySafeDataModel = require("UIActivitySafe/UIActivitySafeDataModel")
local FastBattleDataModel = require("UIFastBattle/UIFastBattleDataModel")
local DataModel = {
  param = "",
  StationId = 0,
  BuildingId = 0,
  NpcId = 0,
  BgPath = "",
  BgColor = "FFFFFF",
  levels = {},
  refreshChecked = false,
  DayRefreshTime = 0,
  CurStationRepLv = 0,
  NPCDialogEnum = {
    talkText = "talkText",
    enterText = "enterText",
    tabOrderText = "tabOrderText",
    tabBattleText = "tabBattleText",
    orderSuccessText = "orderSuccessText",
    notEnoughText = "notEnoughText",
    signText = "signText",
    cancelSignText = "cancelSignText",
    discardText = "discardText",
    enterExchangeText = "enterExchangeText",
    enterSaleText = "enterSaleText",
    exchangeSuccessText = "exchangeSuccessText",
    saleSuccessText = "saleSuccessText"
  },
  DifficultyTextWithColorId = {
    80601782,
    80601783,
    80601784,
    80601785,
    80601786,
    80601787
  },
  DifficultyNumPath = {
    "UI/Home/HomeSafe/Difficulty/icon_num_1",
    "UI/Home/HomeSafe/Difficulty/icon_num_2",
    "UI/Home/HomeSafe/Difficulty/icon_num_3",
    "UI/Home/HomeSafe/Difficulty/icon_num_4",
    "UI/Home/HomeSafe/Difficulty/icon_num_5",
    "UI/Home/HomeSafe/Difficulty/icon_num_6"
  },
  DifficultyBtnImgPath = {
    "UI/Home/HomeSafe/Difficulty/btn_grade_old_1",
    "UI/Home/HomeSafe/Difficulty/btn_grade_old_2",
    "UI/Home/HomeSafe/Difficulty/btn_grade_old_3",
    "UI/Home/HomeSafe/Difficulty/btn_grade_old_4",
    "UI/Home/HomeSafe/Difficulty/btn_grade_old_5",
    "UI/Home/HomeSafe/Difficulty/btn_grade_old_6"
  },
  CacheEventList = {},
  isHomeBattleMax = false,
  constAutoBattleTime = 3,
  remainAutoBattleTime = 3,
  monsterLevelAutoBattle = false
}

function DataModel:Init(first)
  View.timer:Start()
  NPCDialog.SetNPC(View.Group_NPC, DataModel.NpcId)
  if first then
    View.self:PlayAnim("Main")
    NPCDialog.SetNPCTextByEnum(View.Group_NPC, DataModel.NPCDialogEnum.enterText)
    View.Group_Main.self:SetActive(true)
    View.Group_Battle.self:SetActive(false)
    View.Group_Order.self:SetActive(false)
    View.Group_Ticket.self:SetActive(false)
    View.Group_Zhu.self:SetActive(false)
    View.Group_Exchange:SetActive(false)
    View.Group_Sale:SetActive(false)
  end
  DataModel:CheckQuestProcess(false)
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  DataModel.StationCA = stationCA
  View.Group_Main.Btn_Battle.Txt_:SetText(stationCA.battleTabName)
  View.Group_Main.Btn_Order.Txt_:SetText(stationCA.orderTabName)
  View.Img_BG:SetSprite(DataModel.BgPath)
  View.Img_BG:SetColor(DataModel.BgColor)
  DataModel.battleLevelList = DataModel.StationCA.battleLevelList
  View.Group_Main.StaticGrid_List.grid.self:SetDataCount(#DataModel.StationCA.openPageList)
  View.Group_Main.StaticGrid_List.grid.self:RefreshAllElement()
  View.Group_Main.Group_NpcInfo.Group_Dingwei.Txt_Station:SetText(DataModel.StationCA.name)
  View.Group_Main.Group_NpcInfo.Txt_Name:SetText(DataModel.StationName)
  View.Group_Main.Group_NpcInfo.Img_Icon:SetSprite(DataModel.StationCA.buildingIconPath)
  if self.noConstruction ~= true then
    Net:SendProto("station.construction_info", function()
      DataModel.StationList = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)]
      DataModel.StationState = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].state
      DataModel:RefreshLeftData(first)
    end)
  end
  local highRecyclableMap = {}
  local recyclableList = PlayerData:GetHomeInfo().recyclable[tostring(stationCA.id)].recyclable
  for i = 1, #recyclableList do
    highRecyclableMap[recyclableList[i]] = true
  end
  table.sort(recyclableList, function(e1, e2)
    local ca1 = PlayerData:GetFactoryData(e1)
    local ca2 = PlayerData:GetFactoryData(e2)
    if ca1.qualityInt ~= ca2.qualityInt then
      return ca1.qualityInt > ca2.qualityInt
    else
      return e1 < e2
    end
  end)
  DataModel.recyclableList = recyclableList
  DataModel.highRecyclableMap = highRecyclableMap
  local tagId = stationCA.battleTypeId
  DataModel.tagCfg = PlayerData:GetFactoryData(tagId)
  DataModel:RefreshSafeBtnShow()
  if DataModel.StationId == 83000046 then
    View.Group_Zhu.Group_Construct:SetActive(false)
  end
end

function DataModel.GetMonthText(index)
  local text = GetText(80608635)
  if index == 1 then
    text = GetText(80611655)
  elseif index == 2 then
    text = GetText(80611656)
  elseif index == 3 then
    text = GetText(80611657)
  elseif index == 4 then
    text = GetText(80611658)
  elseif index == 5 then
    text = GetText(80611659)
  elseif index == 6 then
    text = GetText(80611660)
  elseif index == 7 then
    text = GetText(80611661)
  elseif index == 8 then
    text = GetText(80611662)
  elseif index == 9 then
    text = GetText(80611663)
  elseif index == 10 then
    text = GetText(80611664)
  elseif index == 11 then
    text = GetText(80611665)
  elseif index == 12 then
    text = GetText(80611666)
  end
  return text
end

function DataModel:CheckQuestProcess(isRefresh)
  if isRefresh == nil then
    isRefresh = true
  end
  local params = {}
  params.url = View.self.url
  local status = {
    Current = "Chapter",
    squadIndex = PlayerData.BattleInfo.squadIndex,
    hasOpenThreeView = false
  }
  local t = {}
  t = Clone(DataModel.param)
  status.extraUIParamData = t
  params.status = status
  DataModel.CacheEventList = QuestProcess.CheckEventOpen(DataModel.BuildingId, params)
  local count = #DataModel.CacheEventList
  if 0 < count then
    QuestProcess.AddQuestCallBack(View.self.url, DataModel.CheckQuestProcess)
  end
  if isRefresh then
    View.Group_Main.StaticGrid_List.grid.self:RefreshAllElement()
  end
end

function DataModel:RefreshResource(showType)
  local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
  local maxEnergy = PlayerData:GetUserInfo().max_energy or initConfig.energyMax
  UIManager:LoadSplitPrefab(View, "UI/HomeBattleCenter/HomeBattleCenter", "Group_Battle")
  View.Group_Battle.Group_Ding.Btn_Energy.Txt_Num:SetText(PlayerData:GetGoodsById(11400006).num .. "/" .. maxEnergy)
end

DataModel.difficultyBg = {
  [1] = "UI/HomeBattleCenter/easy",
  [2] = "UI/HomeBattleCenter/normal",
  [3] = "UI/HomeBattleCenter/difficult"
}

function DataModel:GetNewLevel()
  local count = 1
  for k, v in pairs(DataModel.ShowBattleLevelList) do
    local row = DataModel.ShowBattleLevelList[k]
    if DataModel.ShowBattleLevelList[k - 1] then
      local last_row = DataModel.ShowBattleLevelList[k - 1]
      row.isBattle = PlayerData:GetLevelPass(last_row.id)
      if row.isBattle == true then
        count = k
      end
    end
  end
  DataModel.Index_Init = count
  if count == table.count(DataModel.ShowBattleLevelList) then
    DataModel.isHomeBattleMax = true
  end
  if DataModel.isHomeBattleMax and PlayerData:GetPlayerPrefs("int", "BattleCenterIndex" .. DataModel.StationId) ~= 0 then
    DataModel.Index_Init = PlayerData:GetPlayerPrefs("int", "BattleCenterIndex" .. DataModel.StationId)
  end
  if PlayerData.TempCache.isAutoBattleCenter ~= nil then
    DataModel.isInitAuto = true
    DataModel.Index_Init = PlayerData.TempCache.curIndex
    PlayerData.TempCache.isAutoBattleCenter = nil
    PlayerData.TempCache.curIndex = nil
  else
    DataModel.isInitAuto = false
  end
end

function DataModel:ChooseBattleLevel(index)
  if DataModel.Index_Battle and index and DataModel.Index_Battle == index then
    return
  end
  if DataModel.Index_Battle and DataModel.ShowBattleLevelList[DataModel.Index_Battle] then
    local old_element = View.Group_Battle.Group_1.ScrollGrid_List.grid.self:GetElementByIndex(DataModel.Index_Battle - 1)
    if old_element then
      old_element.Img_Select:SetActive(false)
    end
  end
  local row = DataModel.ShowBattleLevelList[index]
  local element = View.Group_Battle.Group_1.ScrollGrid_List.grid.self:GetElementByIndex(index - 1)
  if element then
    element.Img_Select:SetActive(true)
  end
  local Group_Information = View.Group_Battle.Group_1.Group_Information
  Group_Information.Txt_Name:SetText(row.ca.levelName)
  Group_Information.Txt_Dec:SetText(row.ca.description)
  local isShowPrisonLogo = FastBattleDataModel.GetLevelIsShowPrisonLogo(row.ca.id)
  print(row.ca.levelName .. " \230\152\175\229\144\166\230\152\190\231\164\186\231\155\145\231\139\177\229\155\190\230\160\135\239\188\154" .. tostring(isShowPrisonLogo))
  Group_Information.Img_Prisoner:SetActive(isShowPrisonLogo)
  local difficulty = 1
  local isCustomDifficulty = row.ca.isCustomDifficulty and row.isBattle
  local groupDifficult = Group_Information.Group_Difficult
  groupDifficult.self:SetActive(isCustomDifficulty)
  if isCustomDifficulty then
    difficulty = PlayerData:GetLevelDifficulty(row.ca.id)
    groupDifficult.Btn_Difficult.Txt_Difficult:SetText(GetText(DataModel.DifficultyTextWithColorId[difficulty]))
    groupDifficult.Img_Difficult.Img_Num:SetSprite(DataModel.DifficultyNumPath[difficulty])
    groupDifficult.Img_Difficult:SetSprite(DataModel.DifficultyBtnImgPath[difficulty])
  end
  local firstPassAward = row.ca.firstPassAward
  local dropListNew = PlayerData:GetLevelDropList(row.ca, difficulty)
  local state = PlayerData:GetLevelPass(row.id)
  Group_Information.Group_Auto.self:SetActive(row.isBattle)
  DataModel.ChooseRewardList = {}
  for i = 1, 20 do
    if firstPassAward[i] then
      table.insert(DataModel.ChooseRewardList, {
        num = firstPassAward[i].num,
        id = firstPassAward[i].itemId,
        type = 1,
        isFinish = state,
        index = #DataModel.ChooseRewardList
      })
    end
    if dropListNew[i] then
      table.insert(DataModel.ChooseRewardList, {
        num = dropListNew[i].num,
        id = dropListNew[i].id,
        type = 2,
        index = #DataModel.ChooseRewardList
      })
    end
  end
  if state == true then
    table.sort(DataModel.ChooseRewardList, function(a, b)
      if a.type == b.type then
        return a.index < b.index
      end
      return a.type > b.type
    end)
    DataModel:RefreshAutoBtn(DataModel.isInitAuto)
    if DataModel.isInitAuto then
      DataModel:RefreshRemainTime()
    end
    DataModel.isInitAuto = false
  else
    table.sort(DataModel.ChooseRewardList, function(a, b)
      if a.type == b.type then
        return a.index < b.index
      end
      return a.type < b.type
    end)
    DataModel:RefreshAutoBtn(false)
  end
  Group_Information.ScrollGrid_Reward.grid.self:SetDataCount(#DataModel.ChooseRewardList)
  Group_Information.ScrollGrid_Reward.grid.self:RefreshAllElement()
  Group_Information.ScrollGrid_Reward.grid.self:MoveToTop()
  local costEnergy = row.ca.energyEnd + row.ca.extraEnergy * (difficulty - 1)
  if DataManager:GetFactoryNameById(tonumber(row.id)) == "AbyssFactory" then
    local abyssCA = PlayerData:GetFactoryData(row.id)
    costEnergy = 0
    for i = 1, #abyssCA.levelList do
      local ca = PlayerData:GetFactoryData(abyssCA.levelList[i].id, "LevelFactory")
      costEnergy = costEnergy + ca.energyStart + ca.energyEnd + ca.extraEnergy * (difficulty - 1)
    end
    Group_Information.Img_Tuijian:SetActive(false)
  else
    Group_Information.Img_Tuijian:SetActive(true)
    local level = PlayerData:GetUserInfo().lv
    if not row.ca.isEnemyLvEquilsPlayer then
      level = row.ca.recomGrade + row.ca.extraLevelOffset * (difficulty - 1)
    end
    Group_Information.Img_Tuijian.Txt_Grade:SetText(level)
  end
  Group_Information.Group_TZ.Txt_Cost:SetText(costEnergy)
  Group_Information.Group_TZ.self:SetActive(row.isBattle)
  Group_Information.Group_Limit.self:SetActive(not row.isBattle)
  DataModel.Index_Battle = index
end

function DataModel:OpenBattlePage()
  DataModel.Index_OutSide = 1
  NPCDialog.SetNPCTextByEnum(View.Group_NPC, DataModel.NPCDialogEnum.tabBattleText)
  DataModel.Index_Battle = nil
  DataModel.Index_Init = nil
  DataModel.isHomeBattleMax = false
  View.Group_Main.self:SetActive(false)
  UIManager:LoadSplitPrefab(View, "UI/HomeBattleCenter/HomeBattleCenter", "Group_Battle")
  View.Group_Battle.self:SetActive(true)
  View.Group_Zhu.self:SetActive(true)
  View.self:PlayAnim("Battle")
  local user_info = PlayerData:GetUserInfo()
  View.Group_Battle.Group_Ding.Btn_Energy.Txt_Num:SetText(user_info.energy .. "/" .. user_info.max_energy or 0)
  DataModel.ShowBattleLevelList = {}
  local count = 1
  for k, v in pairs(DataModel.battleLevelList) do
    local ca = PlayerData:GetFactoryData(v.id)
    if DataManager:GetFactoryNameById(tonumber(ca.id)) == "AbyssFactory" then
      ca = PlayerData:GetFactoryData(ca.levelList[#ca.levelList].id)
    end
    if ca.constructLimit <= PlayerData:GetConstructionProportion(DataModel.StationId) then
      DataModel.ShowBattleLevelList[count] = Clone(v)
      count = count + 1
    end
  end
  DataModel:GetNewLevel()
  View.Group_Battle.Group_1.ScrollGrid_List.grid.self:SetDataCount(#DataModel.ShowBattleLevelList)
  View.Group_Battle.Group_1.ScrollGrid_List.grid.self:RefreshAllElement()
  View.Group_Battle.Group_1.Group_Top.Txt_Name:SetText(DataModel.StationCA.battleLevelName)
  View.Group_Battle.Group_1.Group_Top.Img_Icon:SetSprite(DataModel.StationCA.battleIconPath)
  if DataModel.Index_Init == nil or DataModel.ShowBattleLevelList[DataModel.Index_Init] == nil then
    DataModel.Index_Init = 1
  end
  View.Group_Battle.Group_1.ScrollGrid_List.grid.self:MoveToPos(DataModel.Index_Init)
  DataModel:ChooseBattleLevel(DataModel.Index_Init)
  DataModel:RefreshResource(1)
  if DataModel.tagCfg then
    View.Group_Battle.Group_1.Img_:SetSprite(DataModel.tagCfg.battlePage)
  end
end

function DataModel:RefreshRemainTime()
  if DataModel.remainAutoBattleTime <= 0 then
    DataModel.monsterLevelAutoBattle = false
    DataModel.remainAutoBattleTime = DataModel.constAutoBattleTime
    PlayerData.SquadsTempData = nil
    DataModel:TryBattle(true)
    return
  end
  View.Group_Battle.Group_1.Group_Information.Group_Auto.Txt_Time:SetText(string.format(GetText(80607112), math.ceil(DataModel.remainAutoBattleTime)))
end

function DataModel:RefreshAutoBtn(isAuto)
  PlayerData.TempCache.MonsterLevelAutoBattle = isAuto
  DataModel.monsterLevelAutoBattle = PlayerData.TempCache.MonsterLevelAutoBattle
  View.Group_Battle.Group_1.Group_Information.Group_Auto.Btn_Auto.Group_Off.self:SetActive(not DataModel.monsterLevelAutoBattle)
  View.Group_Battle.Group_1.Group_Information.Group_Auto.Btn_Auto.Group_On.self:SetActive(DataModel.monsterLevelAutoBattle)
  View.Group_Battle.Group_1.Group_Information.Group_Auto.Txt_Time:SetActive(DataModel.monsterLevelAutoBattle)
end

function DataModel:TryBattle(isAutoBattle)
  local info = DataModel.ShowBattleLevelList[tonumber(DataModel.Index_Battle)]
  local levelId = info.id
  local levelCA = info.ca
  local isAbyss = false
  if DataManager:GetFactoryNameById(tonumber(levelId)) == "AbyssFactory" then
    levelId = info.ca.id
    isAbyss = true
  end
  local levelDifficulty = PlayerData:GetLevelDifficulty(levelId)
  
  local function doDoubleTeam()
    local holdNum = PlayerData.ServerData.user_info.energy
    local abyssCA = PlayerData:GetFactoryData(info.id)
    local costEnergyNum = 0
    for i = 1, #abyssCA.levelList do
      local ca = PlayerData:GetFactoryData(abyssCA.levelList[i].id, "LevelFactory")
      costEnergyNum = costEnergyNum + ca.energyStart + ca.energyEnd + ca.extraEnergy * (levelDifficulty - 1)
    end
    if holdNum < costEnergyNum then
      local recordTime = PlayerData:GetPlayerPrefs("int", "battleEnergy")
      local severTime = TimeUtil:GetServerTimeStamp()
      local reallyTime = recordTime == 0 and severTime or recordTime
      local newDate = os.date("*t", reallyTime)
      local resetTime = os.time({
        year = newDate.year,
        month = newDate.month,
        day = newDate.day,
        hour = 0,
        minute = 0,
        second = 0
      })
      local days = (severTime - resetTime) / 24 / 60 / 60
      if 1 <= days or recordTime == 0 then
        UIManager:Open("UI/Energy/EnergyBuyTips", nil, function()
          UIManager:Open("UI/Energy/Energy", nil, nil, nil)
        end, nil)
      else
        UIManager:Open("UI/Energy/Energy", nil, nil, nil)
      end
      return
    end
    local status = {
      callBackPage = "UI/HomeBattleCenter/HomeBattleCenter",
      abyssId = info.id,
      isDoubleTeam = true,
      difficulty = levelDifficulty,
      isAutoBattle = isAutoBattle,
      pathBtnBattle = 88300031,
      numText = 80607079
    }
    local extraParam = {
      hasOpenThreeView = false,
      stationId = DataModel.StationId,
      npcId = DataModel.NpcId,
      bgPath = DataModel.BgPath,
      autoShowLevel = 1,
      name = DataModel.StationName,
      difficulty = levelDifficulty,
      isAutoBattle = isAutoBattle
    }
    status.extraUIParamData = extraParam
    if isAutoBattle then
      PlayerData.TempCache.isAutoBattleCenter = isAutoBattle
      PlayerData.TempCache.curIndex = tonumber(DataModel.Index_Battle)
    else
      PlayerData.TempCache.isAutoBattleCenter = nil
      PlayerData.TempCache.curIndex = nil
    end
    if DataModel.isHomeBattleMax then
      PlayerData:SetPlayerPrefs("int", "BattleCenterIndex" .. DataModel.StationId, DataModel.Index_Battle)
    end
    UIManager:Open("UI/Chapter/Battle_Abyss/Team_Double", Json.encode(status))
  end
  
  local function doSquad()
    if CommonTips.OpenBuyEnergyTips(levelId, nil, nil, nil, levelDifficulty) then
      return
    end
    local status = {
      Current = "Chapter",
      squadIndex = PlayerData.BattleInfo.squadIndex,
      hasOpenThreeView = false,
      stationId = DataModel.StationId,
      npcId = DataModel.NpcId,
      bgPath = DataModel.BgPath,
      autoShowLevel = 1,
      name = DataModel.StationName,
      isBattleCenter = true,
      difficulty = levelDifficulty,
      isAutoBattle = isAutoBattle
    }
    if isAutoBattle then
      PlayerData.TempCache.isAutoBattleCenter = isAutoBattle
      PlayerData.TempCache.curIndex = tonumber(DataModel.Index_Battle)
    else
      PlayerData.TempCache.isAutoBattleCenter = nil
      PlayerData.TempCache.curIndex = nil
    end
    PlayerData.BattleInfo.battleStageId = levelId
    PlayerData.BattleCallBackPage = "UI/HomeBattleCenter/HomeBattleCenter"
    if DataModel.isHomeBattleMax then
      PlayerData:SetPlayerPrefs("int", "BattleCenterIndex" .. DataModel.StationId, DataModel.Index_Battle)
    end
    UIManager:Open("UI/Squads/Squads", Json.encode(status))
  end
  
  local function detailDo()
    if isAbyss then
      doDoubleTeam()
    else
      doSquad()
    end
  end
  
  if not levelCA.isEnemyLvEquilsPlayer and levelCA.recomGrade + levelCA.extraLevelOffset * (levelDifficulty - 1) - PlayerData:GetPlayerLevel() >= 5 then
    local checkTipParam = {}
    checkTipParam.isCheckTip = true
    checkTipParam.checkTipKey = "HomeBattleCenterHardTip"
    checkTipParam.checkTipType = 1
    checkTipParam.showDanger = true
    CommonTips.OnPrompt(80601227, nil, nil, detailDo, nil, nil, nil, nil, checkTipParam)
  else
    detailDo()
  end
end

function DataModel:OnClickBtnAuto()
  local info = DataModel.ShowBattleLevelList[tonumber(DataModel.Index_Battle)]
  local levelId = info.id
  if not PlayerData:GetLevelPass(levelId) then
    CommonTips.OpenTips(80607473)
    return
  end
  local isAbyss = false
  if DataManager:GetFactoryNameById(tonumber(levelId)) == "AbyssFactory" then
    levelId = info.ca.id
    isAbyss = true
  end
  local levelCA = PlayerData:GetFactoryData(levelId)
  local levelData = PlayerData.ServerData.chapter_level[tostring(levelId)]
  if levelCA.limitNum > 0 and levelData ~= nil and levelData.challenge_times ~= nil and levelData.challenge_times >= levelCA.limitNum then
    CommonTips.OpenTips(80607474)
    return
  end
  if not PlayerData.TempCache.MonsterLevelAutoBattle then
    if isAbyss then
      local holdNum = PlayerData.ServerData.user_info.energy
      local abyssCA = PlayerData:GetFactoryData(info.id)
      local costEnergy = 0
      local difficulty = PlayerData:GetLevelDifficulty(levelId)
      for i = 1, #abyssCA.levelList do
        local ca = PlayerData:GetFactoryData(abyssCA.levelList[i].id, "LevelFactory")
        costEnergy = costEnergy + ca.energyStart + ca.energyEnd + ca.extraEnergy * (difficulty - 1)
      end
      if holdNum < costEnergy then
        local recordTime = PlayerData:GetPlayerPrefs("int", "battleEnergy")
        local severTime = TimeUtil:GetServerTimeStamp()
        local reallyTime = recordTime == 0 and severTime or recordTime
        local newDate = os.date("*t", reallyTime)
        local resetTime = os.time({
          year = newDate.year,
          month = newDate.month,
          day = newDate.day,
          hour = 0,
          minute = 0,
          second = 0
        })
        local days = (severTime - resetTime) / 24 / 60 / 60
        if 1 <= days or recordTime == 0 then
          UIManager:Open("UI/Energy/EnergyBuyTips", nil, function()
            UIManager:Open("UI/Energy/Energy", nil, nil, nil)
          end, nil)
        else
          UIManager:Open("UI/Energy/Energy", nil, nil, nil)
        end
        CommonTips.OpenTips(80607116)
        return
      end
    elseif CommonTips.OpenBuyEnergyTips(levelId, nil, nil, nil, nil, true) then
      CommonTips.OpenTips(80607116)
      return
    end
  end
  DataModel.remainAutoBattleTime = DataModel.constAutoBattleTime
  DataModel:RefreshAutoBtn(not PlayerData.TempCache.MonsterLevelAutoBattle)
  DataModel:RefreshRemainTime()
end

function DataModel:ClickOrderListQuestInfo(index)
  local row = DataModel.orderList[tonumber(DataModel.Index_Order)].config.requireItemList[index]
  if row == nil then
    return
  end
  CommonTips.OpenPreRewardDetailTips(row.id, nil, true)
end

function DataModel:ChooseOrder(index)
  if DataModel.Index_Order and index and DataModel.Index_Order == index then
    return
  end
  if DataModel.Index_Order and DataModel.orderList[DataModel.Index_Order] then
    local old_element = View.Group_Order.Group_1.ScrollGrid_List.grid.self:GetElementByIndex(DataModel.Index_Order - 1)
    if old_element then
      old_element.Group_On:SetActive(false)
    end
  end
  local row = DataModel.orderList[index]
  local element = View.Group_Order.Group_1.ScrollGrid_List.grid.self:GetElementByIndex(index - 1)
  local Group_Reward = View.Group_Order.Group_1.Group_Dec.Group_Reward
  Group_Reward.Btn_Delivery:SetActive(false)
  Group_Reward.Btn_QuestSign:SetActive(false)
  Group_Reward.Btn_NotDelivery:SetActive(false)
  Group_Reward.Btn_NotQuestSign:SetActive(false)
  Group_Reward.Btn_Exchange:SetActive(true)
  element.Group_On:SetActive(true)
  if row.isSubmit == true then
    element.Group_Submit:SetActive(true)
    Group_Reward.Btn_Delivery:SetActive(true)
  elseif row.is_mark == false then
    Group_Reward.Btn_QuestSign:SetActive(true)
  else
    Group_Reward.Btn_NotQuestSign:SetActive(true)
  end
  local Group_Dec = View.Group_Order.Group_1.Group_Dec
  DataModel.ChooseBattleRewardList = row.config.rewardsList
  Group_Dec.ScrollGrid_Reward.self:SetActive(true)
  Group_Dec.ScrollGrid_Reward.grid.self:SetDataCount(#DataModel.ChooseBattleRewardList)
  Group_Dec.ScrollGrid_Reward.grid.self:RefreshAllElement()
  Group_Dec.ScrollGrid_Reward.grid.self:MoveToTop()
  DataModel.Index_Order = index
end

function DataModel:DeleteOreder()
  if DataModel.Index_Order == nil then
    CommonTips.OpenTips("")
    return
  end
  NPCDialog.SetNPCTextByEnum(View.Group_NPC, DataModel.NPCDialogEnum.discardText)
  local row = DataModel.orderList[DataModel.Index_Order]
  Net:SendProto("station.refresh_order", function(Json)
    DataModel.StationList.orders = Json.change_order
    if Json.construction then
      DataModel.StationList.construction = Json.construction
    end
    DataModel:OpenOrderPage(1)
    DataModel:RefreshLeftData()
    QuestTrace.CancelQuest(row.oid)
  end, DataModel.Index_Order - 1)
end

function DataModel:OpenOrderPage(state)
  if not state then
    NPCDialog.SetNPCTextByEnum(View.Group_NPC, DataModel.NPCDialogEnum.tabOrderText)
  end
  DataModel.Index_OutSide = 2
  DataModel.Index_Order = nil
  View.Group_Main.self:SetActive(false)
  View.Group_Battle.self:SetActive(false)
  UIManager:LoadSplitPrefab(View, "UI/HomeBattleCenter/HomeBattleCenter", "Group_Order")
  View.Group_Order.self:SetActive(true)
  View.Group_Zhu.self:SetActive(true)
  View.self:PlayAnim("Order")
  local user_info = PlayerData:GetUserInfo()
  View.Group_Order.Group_Ding.Btn_YN.Txt_Num:SetText(user_info.gold)
  DataModel.orderList = {}
  DataModel.isAllRefreshCount = 0
  local count = 0
  for k, v in pairs(DataModel.StationList.orders) do
    local refresh_time = v.refresh_time
    if v.is_unlock == 1 and v.refresh_time == -1 then
      if count == 0 then
        count = k
      else
        count = math.min(k, count)
      end
    end
    if v.refresh_time ~= -1 then
      refresh_time = v.refresh_time + DataModel.StationCA.refreshTime
      if 0 >= refresh_time - TimeUtil:GetServerTimeStamp() then
        if count == 0 then
          count = k
        else
          count = math.min(k, count)
        end
      end
    end
    table.insert(DataModel.orderList, {
      oid = v.oid,
      refresh_time = refresh_time,
      is_unlock = v.is_unlock,
      ca = DataModel.StationCA.createOrderList[k],
      is_mark = v.is_mark ~= nil and true or false
    })
  end
  View.Group_Order.Group_1.ScrollGrid_List.grid.self:SetDataCount(#DataModel.orderList)
  View.Group_Order.Group_1.ScrollGrid_List.grid.self:RefreshAllElement()
  View.Group_Order.Group_1.ScrollGrid_List.grid.self:MoveToTop()
  if count ~= 0 then
    View.Group_Order.Group_1.ScrollGrid_List.grid.self:MoveToPos(count)
    DataModel:ChooseOrder(count)
  end
  if DataModel.isAllRefreshCount == 0 then
    View.Group_Order.Group_1.Group_Dec.Group_Reward.Btn_Exchange:SetActive(false)
    View.Group_Order.Group_1.Group_Dec.Group_Reward.Btn_Delivery:SetActive(false)
    View.Group_Order.Group_1.Group_Dec.Group_Reward.Btn_QuestSign:SetActive(false)
    View.Group_Order.Group_1.Group_Dec.Group_Reward.Btn_NotDelivery:SetActive(false)
    View.Group_Order.Group_1.Group_Dec.Group_Reward.Btn_NotQuestSign:SetActive(false)
    View.Group_Order.Group_1.Group_Dec.ScrollGrid_Reward.self:SetActive(false)
    return
  end
  DataModel:RefreshResource(2)
  if DataModel.tagCfg then
    View.Group_Order.Group_1.Img_:SetSprite(DataModel.tagCfg.orderPage)
  end
end

DataModel.park = {
  current_reward = 0,
  maxTicket = 0,
  ticket = 0,
  psg_num = 0,
  total_reward = 0,
  divide = 0,
  record = {},
  maxProfitMonthIndex = 1,
  investmentNum = 0,
  pond = {},
  tax = 0,
  gold = 0
}

function DataModel:GetMaxTicket()
  return self.StationCA.parkTicketMax + self.StationCA.parkTicket
end

function DataModel:JudgeParkDataLimit()
  local maxTicket = self:GetMaxTicket()
  if maxTicket < self.park.ticket then
    self.park.ticket = maxTicket
  end
  if self.park.divide > self.StationCA.maxDivide then
    self.park.divide = self.StationCA.maxDivide
  end
  if self.park.tax < 0 then
    self.park.tax = 0
  end
end

function DataModel:RefreshParkDivide(divide)
  self.park.divide = divide > self.StationCA.maxDivide and self.StationCA.maxDivide or divide
end

function DataModel:RefreshParkInfo(json)
  if json then
    if json.current_reward then
      self.park.current_reward = json.current_reward
    end
    if json.psg_num then
      self.park.psg_num = json.psg_num
    end
    if json.earnings then
      self.park.total_reward = json.earnings
    end
    if json.divide then
      self.park.divide = json.divide
    end
    if json.add then
      self.park.ticket = self.StationCA.parkTicket
      for i, v in pairs(json.add) do
        self.park.ticket = self.park.ticket + v
      end
    end
    if json.record then
      self.park.record = json.record
      local maxProfit = 0
      for i, v in ipairs(json.record) do
        if v > maxProfit then
          maxProfit = v
          self.park.maxProfitMonthIndex = i
        end
      end
    end
    if json.donate_num then
      self.park.investmentNum = json.donate_num
    end
    if json.pond then
      self.park.pond = json.pond
    end
    if json.tax then
      self.park.tax = json.tax
    end
    if json.gold then
      self.park.gold = json.gold
    end
  end
  self:JudgeParkDataLimit()
end

function DataModel:DonateRefreshParkInfo(pondCfg)
  self.park.investmentNum = self.park.investmentNum - 1
  self.park.tax = self.park.tax + pondCfg.tax
  self.park.divide = self.park.divide + pondCfg.divide
  self.park.ticket = self.park.ticket + pondCfg.ticket
  self:JudgeParkDataLimit()
  local stationFairyLand = PlayerData:GetHomeInfo().stations[tostring(self.StationId)].fairyland
  stationFairyLand.donate_num = self.park.investmentNum
  stationFairyLand.tax = self.park.tax
  stationFairyLand.divide = self.park.divide
  stationFairyLand.add.donate = stationFairyLand.add.donate + pondCfg.ticket
  for i, v in ipairs(pondCfg.item) do
    if v.id == 11400001 then
      self.park.gold = self.park.gold + v.num
    end
  end
  stationFairyLand.gold = self.park.gold
end

function DataModel:OpenTicketPage()
  View.Group_Main.self:SetActive(false)
  UIManager:LoadSplitPrefab(View, "UI/HomeBattleCenter/HomeBattleCenter", "Group_Ticket")
  View.Group_Ticket.self:SetActive(true)
  View.Group_Ticket.Group_StageReward:SetActive(false)
  View.Group_Ticket.Group_CommonTopLeft:SetActive(true)
  self.curStage = self.StationCA.constructStageList[DataModel.Index_Construct]
  self:RefreshBySelectType(1)
  DataModel.park.maxTicket = self:GetMaxTicket()
end

DataModel.curSelectType = 1

function DataModel:RefreshBySelectType(type)
  if self.curSelectType ~= type then
    View.Group_Ticket.Group_StageReward:SetActive(false)
  end
  self.curSelectType = type
  View.Group_Zhu.self:SetActive(true)
  self:RefreshLeftData()
  self:ShowTicketProfit(type == 1)
  self:ShowInvestment(type == 2)
  View.Group_Ticket.Group_TapBattle.GroupGold.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
end

DataModel.ticketPriceTexts = {
  80601637,
  80601638,
  80601639,
  8060140,
  8060141
}

function DataModel:ShowTicketProfit(state)
  View.Group_Ticket.Group_TicketProfit:SetActive(state)
  View.Group_Ticket.Group_TapBattle.Group_TicketProfit.Btn_on:SetActive(state)
  View.Group_Ticket.Group_TapBattle.Group_TicketProfit.Btn_off:SetActive(not state)
  if state and self.curStage then
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_profit.Img_today.Img_jinbi.Txt_num:SetText(self.park.ticket)
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_profit.Img_nextday.Img_jinbi.Txt_num:SetText(self.StationCA.added)
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_profit.Img_tax.Txt_num:SetText(ClearFollowZero((self.park.tax < 0 and 0 or self.park.tax) * 100) .. "%")
    local curDay = PlayerData:GetFactoryData(self.StationId, "HomeStationFactory").travelDay
    View.Group_Ticket.Group_TicketProfit.Group_title.Img_fate.Txt_num1:SetText(math.floor(curDay / 10))
    View.Group_Ticket.Group_TicketProfit.Group_title.Img_fate.Txt_num2:SetText(curDay % 10)
    View.Group_Ticket.Group_TicketProfit.Group_title.Group_Psg.Txt_day:SetText(string.format(GetText(80607712), self.park.psg_num))
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Txt_money:SetText(self.park.total_reward)
    local baseDivide = self.StationCA.divide
    local maxDivide = self.StationCA.maxDivide
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_circle.Group_maximum.Txt_:SetText(string.format(GetText(80607713), maxDivide * 100))
    View.Group_Ticket.Group_TicketProfit.Group_information.Img_divide.Txt_num:SetText(ClearFollowZero(self.park.divide * 100) .. "%")
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_circle.Group_original.Txt_num:SetText(ClearFollowZero(baseDivide * 100) .. "%")
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_circle.Group_added.Txt_num:SetText(ClearFollowZero((self.park.divide - baseDivide) * 100) .. "%")
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_circle.Group_original.Img_original:SetFilledImgAmount(baseDivide / maxDivide)
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_circle.Group_added.Img_added:SetFilledImgAmount((self.park.divide - baseDivide) / maxDivide)
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_circle.Group_added.Img_added.transform.localRotation = Quaternion.Euler(0, 0, 360 * baseDivide / maxDivide)
    local base = self.curStage.basisNum
    local over = self.curStage.overNum
    local upper = self.curStage.upperNum
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Txt_num1:SetText(base)
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Txt_num2:SetText(over)
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Group_basic1.Img_decide:SetActive(over > self.park.total_reward)
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_npc.Img_talk.Txt_talk1:SetActive(over > self.park.total_reward)
    local textCA = PlayerData:GetFactoryData(80601644, "TextFactory")
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_npc.Img_talk.Txt_talk1:SetText(textCA.text)
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Group_basic2.Img_decide:SetActive(over <= self.park.total_reward and upper > self.park.total_reward)
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_npc.Img_talk.Txt_talk2:SetActive(over <= self.park.total_reward and upper > self.park.total_reward)
    textCA = PlayerData:GetFactoryData(80601636, "TextFactory")
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_npc.Img_talk.Txt_talk2:SetText(textCA.text)
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Group_basic3.Img_decide:SetActive(upper <= self.park.total_reward)
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_npc.Img_talk.Txt_talk3:SetActive(upper <= self.park.total_reward)
    textCA = PlayerData:GetFactoryData(80601646, "TextFactory")
    View.Group_Ticket.Group_TicketProfit.Group_income.Group_npc.Img_talk.Txt_talk3:SetText(textCA.text)
    local baseX = View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Slider_progressBg.Img_needle1.Rect.anchoredPosition.x
    local overX = View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Slider_progressBg.Img_needle2.Rect.anchoredPosition.x
    local curX = 0
    local totalX = View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Slider_progressBg.Rect.rect.width
    if base > self.park.total_reward then
      curX = self.park.total_reward / base * baseX
      View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Slider_progressBg:SetSliderValue(curX / totalX)
    elseif base <= self.park.total_reward and over > self.park.total_reward then
      curX = baseX + (self.park.total_reward - base) / (over - base) * (overX - baseX)
      View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Slider_progressBg:SetSliderValue(curX / totalX)
    elseif over <= self.park.total_reward and upper > self.park.total_reward then
      curX = overX + (self.park.total_reward - over) / (upper - over) * (totalX - overX)
      View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Slider_progressBg:SetSliderValue(curX / totalX)
    else
      View.Group_Ticket.Group_TicketProfit.Group_income.Group_progress.Slider_progressBg:SetSliderValue(1)
    end
    View.Group_Ticket.Group_TicketProfit.Img_ticketprofit.Group_profit.Txt_money:SetText(self.park.current_reward)
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_profit.Group_Incomedata.Group_PriceShow.ScrollGrid_LIst.grid.self:SetDataCount(table.count(self.park.record))
    View.Group_Ticket.Group_TicketProfit.Group_information.Group_profit.Group_Incomedata.Group_PriceShow.ScrollGrid_LIst.grid.self:RefreshAllElement()
  end
end

DataModel.donateRewardItemObjList = nil

function DataModel:ShowInvestment(state)
  DataModel.donateRewardItemObjList = DataModel.donateRewardItemObjList or {}
  local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
  local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
  local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
  local targetTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s)
  View.Group_Ticket.Group_Investment:SetActive(state)
  View.Group_Ticket.Group_TapBattle.Group_Investment.Btn_on:SetActive(state)
  View.Group_Ticket.Group_TapBattle.Group_Investment.Btn_off:SetActive(not state)
  if not state then
    return
  end
  local stationCA = PlayerData:GetFactoryData(self.StationId, "HomeStationFactory")
  View.Group_Ticket.Group_Investment.Group_information.Group_grossInvestment.Txt_num:SetText(self.park.gold)
  View.Group_Ticket.Group_Investment.Group_information.Group_divide.Txt_num:SetText(ClearFollowZero((self.park.divide - stationCA.divide) * 100) .. "%")
  local tax = 0
  if self.park.tax >= stationCA.tax then
    tax = self.park.tax - stationCA.tax
  else
    tax = math.abs(self.park.tax - stationCA.tax) > stationCA.tax and -stationCA.tax or self.park.tax - stationCA.tax
  end
  View.Group_Ticket.Group_Investment.Group_information.Group_tax.Txt_num:SetText(ClearFollowZero(tax * 100) .. "%")
  View.Group_Ticket.Group_Investment.Group_information.Group_ticket.Txt_num:SetText(self.park.ticket - stationCA.parkTicket)
  View.Group_Ticket.Group_Investment.Img_investmenticon.Txt_investmentTime:SetText(string.format(GetText(80608634), self.park.investmentNum))
  View.Group_Ticket.Group_Investment.ScrollGrid_List.grid.self:SetDataCount(table.count(self.park.pond))
  View.Group_Ticket.Group_Investment.ScrollGrid_List.grid.self:RefreshAllElement()
end

function DataModel.IsInvestTipsShow(pondId)
  local time = PlayerData:GetPlayerPrefs("int", "ParkInvest")
  if time == 0 or time < PlayerData:GetSeverTime() then
    local pondCfg = PlayerData:GetFactoryData(pondId, "PondFactory")
    local addConstructNum = 0
    if pondCfg.build and pondCfg.build[1] then
      addConstructNum = pondCfg.build[1].num
    end
    local constructMax = addConstructNum ~= 0 and PlayerData.GetConstructionProportionByStage(DataModel.StationId, DataModel.Index_Construct) >= DataModel.curStage.constructNum
    if constructMax then
      return 80602598
    end
    local ticketMax = pondCfg.ticket ~= 0 and DataModel.park.ticket >= DataModel.park.maxTicket
    if ticketMax then
      return 80602599
    end
    local taxMax = pondCfg.tax ~= 0 and 0 >= DataModel.park.tax
    if taxMax then
      return 80602600
    end
    local divideMax = pondCfg.divide ~= 0 and DataModel.park.divide >= DataModel.StationCA.maxDivide
    if divideMax then
      return 80602601
    end
  end
  return 0
end

function DataModel:OpenConstructStage()
  local row = {}
  row.stationId = DataModel.StationId
  CommonTips.OpenConstructStage(row)
end

function DataModel:RefreshLeftData(first)
  DataModel.ConstructMaxNum = 0
  DataModel.ConstructNowNum = 0
  DataModel.ConstructNowCA = {}
  for k, v in pairs(DataModel.StationList.construction) do
    DataModel.ConstructNowNum = DataModel.ConstructNowNum + v.proportion
  end
  local count = 0
  for i = 1, #DataModel.StationCA.constructStageList do
    local row = DataModel.StationCA.constructStageList[i]
    DataModel.ConstructMaxNum = DataModel.ConstructMaxNum + row.constructNum
    DataModel.ConstructNowCA = row
    count = i
    if row.state and row.state ~= -1 and DataModel.ConstructNowNum >= DataModel.ConstructMaxNum and DataModel.StationState < row.state then
      DataModel.StationState = row.state
      PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].state = row.state
    end
    if DataModel.ConstructNowNum < DataModel.ConstructMaxNum then
      break
    end
  end
  DataModel.Index_Construct = count
  local Group_Zhu = View.Group_Zhu
  local row_config = DataModel.StationCA.constructStageList[count]
  local row_server = DataModel.StationList.construction[count]
  Group_Zhu.Group_Dingwei.Txt_Station:SetText(DataModel.StationCA.name)
  Group_Zhu.Txt_Name:SetText(DataModel.StationName)
  Group_Zhu.Img_Icon:SetSprite(DataModel.StationCA.buildingIconPath)
  local Group_Construct = Group_Zhu.Group_Construct
  Group_Construct.Txt_Num:SetText(row_server.proportion .. "/" .. row_config.constructNum)
  Group_Construct.Txt_Dec:SetText(DataModel.ConstructNowCA.name)
  Group_Construct.Img_PB:SetFilledImgAmount(row_server.proportion / row_config.constructNum)
  Group_Construct.Btn_Construct:SetSprite(DataModel.StationCA.constructIconPath)
  Group_Construct.Img_RedPoint:SetActive(PlayerData:GetConstructStageRewardState(DataModel.StationId))
end

function DataModel:OpenStorePage(isReopen)
  local storeList = self.StationCA.exchangeStoreList
  local storeId, remainTime, isOpen
  for i = 1, #storeList do
    isOpen, remainTime = PlayerData:IsStoreOpen(storeList[i].id)
    if isOpen then
      storeId = storeList[i].id
      break
    end
  end
  if not isOpen then
    return
  end
  if isReopen then
    self:RefreshStoreInfo(storeId, remainTime)
    self:RefreshStoreLeftData()
  else
    Net:SendProto("shop.info", function(json)
      self:RefreshStoreInfo(storeId, remainTime)
    end, storeId)
    Net:SendProto("station.construction_info", function()
      self:RefreshStoreLeftData()
    end)
  end
end

function DataModel:RefreshStoreInfo(storeId, remainTime)
  NPCDialog.SetNPCTextByEnum(View.Group_NPC, self.NPCDialogEnum.enterExchangeText)
  View.Group_Main.self:SetActive(false)
  View.Group_Zhu.self:SetActive(true)
  UIManager:LoadSplitPrefab(View, "UI/HomeBattleCenter/HomeBattleCenter", "Group_Exchange")
  local groupStore = View.Group_Exchange
  groupStore.self:SetActive(true)
  View.self:PlayAnim("Exchange")
  local storeCA = PlayerData:GetFactoryData(storeId, "StoreFactory")
  self.exchangeStoreCA = storeCA
  local isTime = storeCA.isTime
  local storeTop = groupStore.Group_Ding.Group_Top
  storeTop.StaticGrid_Coin.grid.self:SetDataCount(#storeCA.currencyShow)
  storeTop.StaticGrid_Coin.grid.self:RefreshAllElement()
  storeTop.Group_Time:SetActive(isTime)
  if isTime then
    storeTop.Group_Time.Txt_Time:SetText(string.format(GetText(80601093), math.floor(remainTime / 86400)))
  end
  local storeMid = groupStore.Group_Middle
  storeMid.Group_Title.Txt_Title:SetText(self.StationCA.exchangeName)
  if DataModel.StationCA.exchangeIconPath ~= nil and DataModel.StationCA.exchangeIconPath ~= "" then
    storeMid.Group_Title.Img_Title:SetSprite(DataModel.StationCA.exchangeIconPath)
  end
  if DataModel.StationCA.exchangePagePath ~= nil and DataModel.StationCA.exchangePagePath ~= "" then
    storeMid.Img_Di:SetSprite(DataModel.StationCA.exchangePagePath)
  end
  local serverItems = PlayerData.ServerData.shops[tostring(storeCA.id)].items
  local itemBuyCount = {}
  for k, v in pairs(serverItems) do
    itemBuyCount[tonumber(v.id)] = v.py_cnt
  end
  self.itemBuyCount = itemBuyCount
  local shopList = storeCA.shopList
  local itemList = {}
  for i = 1, #shopList do
    local itemCA = PlayerData:GetFactoryData(shopList[i].id, "CommondityFactory")
    if itemCA.isTime then
      if TimeUtil:IsActive(itemCA.startTime, itemCA.endTime) then
        itemList[#itemList + 1] = shopList[i]
      end
    else
      itemList[#itemList + 1] = shopList[i]
    end
    itemList[#itemList].idx = #itemList
    itemList[#itemList].commodityIndex = i
  end
  table.sort(itemList, function(e1, e2)
    local w1 = self:GetItemWeight(e1.id)
    local w2 = self:GetItemWeight(e2.id)
    if w1 ~= w2 then
      return w1 > w2
    else
      return e1.idx < e2.idx
    end
  end)
  self.itemList = itemList
  self.notEnoughMap = {}
  storeMid.ScrollGrid_List.grid.self:SetDataCount(#itemList)
  storeMid.ScrollGrid_List.grid.self:RefreshAllElement()
  storeMid.ScrollGrid_List.grid.self:MoveToTop()
  if DataModel.InitItem ~= nil then
    local initIndex
    for i = 1, #DataModel.itemList do
      if tostring(DataModel.itemList[i].id) == tostring(DataModel.InitItem) then
        initIndex = i
      end
    end
    DataModel.InitItem = nil
    if initIndex ~= nil then
      DataModel:OnClickItem(initIndex)
    end
  end
end

function DataModel:OnSetCoinGrid(element, elementIndex)
  local coinData = self.exchangeStoreCA.currencyShow[elementIndex]
  local coinId = coinData.id
  local coinCA = PlayerData:GetFactoryData(coinId)
  element.Img_Icon:SetSprite(coinCA.buyPath)
  element.Txt_Num:SetText(PlayerData:GetGoodsById(coinId).num)
  if coinData.click == "Tips" then
    element.Btn_GoldCoin:SetClickParam(coinId)
  end
end

function DataModel:RefreshStoreLeftData()
  DataModel.StationList = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)]
  DataModel.StationState = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].state
  DataModel:RefreshLeftData()
end

function DataModel:SetGroupConsume(groupConsume, moneyData, elementIndex)
  local moneyCA = PlayerData:GetFactoryData(moneyData.moneyID)
  groupConsume.Group_Item.Img_Item:SetSprite(moneyCA.iconPath or moneyCA.imagePath)
  local quality = moneyCA.qualityInt + 1
  groupConsume.Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality])
  groupConsume.Group_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[quality])
  groupConsume.Group_Item.Btn_Item:SetClickParam(moneyCA.id)
  local groupCost = groupConsume.Group_Cost
  local needNum = moneyData.moneyNum
  groupCost.Txt_Need.Txt.text = PlayerData:NumToFormatString(needNum, 1)
  local haveNum = PlayerData:GetGoodsById(moneyData.moneyID).num
  groupCost.Txt_Have.Txt.text = PlayerData:NumToFormatString(haveNum, 1)
  if needNum > haveNum then
    groupCost.Txt_Have:SetColor(UIConfig.Color.Red)
    if DataModel.notEnoughMap[tonumber(elementIndex)] ~= true then
      DataModel.notEnoughMap[tonumber(elementIndex)] = true
    end
  else
    groupCost.Txt_Have:SetColor(UIConfig.Color.White)
  end
end

function DataModel:GetItemWeight(itemId)
  local ca = PlayerData:GetFactoryData(itemId)
  if ca.isBuyCondition then
    local gradeCondition = ca.gradeCondition
    if gradeCondition > PlayerData:GetUserInfo().lv then
      return 1
    end
  end
  if ca.purchase then
    local StoreDataModel = require("UIStore/UIStoreDataModel")
    local maxNum = StoreDataModel:GetPurchaseNum(ca)
    if maxNum - (self.itemBuyCount[tonumber(itemId)] or 0) <= 0 then
      return 0
    end
  end
  return 2
end

DataModel.SALE_STATUS = {batch = 1, single = 2}

function DataModel:OpenSalePage(initStatu)
  NPCDialog.SetNPCTextByEnum(View.Group_NPC, self.NPCDialogEnum.enterSaleText)
  UIManager:LoadSplitPrefab(View, "UI/HomeBattleCenter/HomeBattleCenter", "Group_Sale")
  local groupSale = View.Group_Sale
  View.Group_Main.self:SetActive(false)
  if self.noConstruction ~= true then
    View.Group_Zhu.self:SetActive(true)
  else
    View.Group_Zhu.self:SetActive(false)
  end
  groupSale.self:SetActive(true)
  View.self:PlayAnim("Sale")
  groupSale.Group_Ding.Group_GoldCoin.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
  groupSale.Group_Middle.Img_Di:SetSprite(self.StationCA.exchangePagePath)
  groupSale.Group_Middle.Group_Title.Img_Title:SetSprite(self.StationCA.exchangeIconPath)
  groupSale.Group_Middle.Group_Title.Txt_Title:SetText(self.StationCA.saleName)
  groupSale.Group_Middle.Group_Up.Img_RedPoint:SetActive(PlayerData:IsHighRecycleClicked(self.StationCA.id))
  self.selectedCount = 0
  self.totalItemCount = 0
  self.selectedPrice = 0
  DataModel.nowActivity = require("UIGroup_EventWeek/WeekActivityData").FindNowWeekActivity()
  DataModel.activityStart = next(DataModel.nowActivity) ~= nil
  DataModel.isTargetCity = false
  if DataModel.activityStart then
    local materialList, priceRate = require("UIGroup_EventWeek/WeekActivityData").GetRecycleCityList(DataModel.nowActivity, DataModel.StationId)
    DataModel.isTargetCity = next(materialList) ~= nil
    DataModel.activityPriceRate = priceRate
    if DataModel.isTargetCity then
      local recyclableList = {}
      local highRecyclableMap = {}
      for i, v in ipairs(materialList) do
        table.insert(recyclableList, v.id)
        highRecyclableMap[tostring(v.id)] = true
      end
      table.sort(recyclableList, function(e1, e2)
        local ca1 = PlayerData:GetFactoryData(e1)
        local ca2 = PlayerData:GetFactoryData(e2)
        if ca1.qualityInt ~= ca2.qualityInt then
          return ca1.qualityInt > ca2.qualityInt
        else
          return e1 < e2
        end
      end)
      DataModel.recyclableList = recyclableList
      DataModel.highRecyclableMap = highRecyclableMap
    end
  end
  self:RefreshSaleList()
  self:SetSaleStatus(initStatu or self.SALE_STATUS.batch)
  self:RefreshSelectNumAndPrice()
  self:SetAllSaleItemSelected(false, true)
  if self.noConstruction ~= true then
    Net:SendProto("station.construction_info", function()
      DataModel.StationList = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)]
      DataModel.StationState = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].state
      DataModel:RefreshLeftData()
    end)
  end
end

function DataModel:RefreshSaleList()
  local saleList = {}
  local caList = self.StationCA.materialRecycleList
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  for i = 1, #caList do
    local itemId = caList[i].id
    local haveNum = PlayerData:GetGoodsById(itemId).num
    local priceRate = self.highRecyclableMap[tostring(itemId)] == true and homeConfig.highCoefficient or 1
    if 0 < haveNum then
      local itemCA = PlayerData:GetFactoryData(itemId)
      local saleFVO = {
        id = itemId,
        quality = itemCA.qualityInt + 1,
        num = haveNum,
        isSelected = false,
        priceRate = priceRate
      }
      if DataModel.activityStart and DataModel.isTargetCity then
        saleFVO.priceRate = self.highRecyclableMap[tostring(itemId)] and DataModel.activityPriceRate or 1
      end
      saleFVO.priceRate = saleFVO.priceRate * (PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddRecycleReward, DataModel.StationId) + 1)
      saleList[#saleList + 1] = saleFVO
    end
  end
  table.sort(saleList, function(e1, e2)
    if e1.quality ~= e2.quality then
      return e1.quality > e2.quality
    else
      return e1.id < e2.id
    end
  end)
  self.saleList = saleList
  View.Group_Sale.Group_Middle.ScrollGrid_List.grid.self:SetDataCount(#saleList)
  View.Group_Sale.Group_Middle.ScrollGrid_List.grid.self:RefreshAllElement()
  View.Group_Sale.Group_Middle.ScrollGrid_List.grid.self:MoveToTop()
  View.Group_Sale.Group_Middle.Group_Empty.self:SetActive(#saleList <= 0)
end

function DataModel:SetSaleItemSelected(index, isSelected, refreshElement)
  local itemFVO = self.saleList[index]
  if itemFVO.isSelected == isSelected then
    return
  end
  itemFVO.isSelected = isSelected
  local itemCA = PlayerData:GetFactoryData(itemFVO.id)
  if isSelected then
    self.selectedCount = self.selectedCount + 1
    self.totalItemCount = self.totalItemCount + itemFVO.num
    self.selectedPrice = self.selectedPrice + math.floor(itemCA.rewardList[1].num * itemFVO.priceRate) * itemFVO.num
  else
    self.selectedCount = math.max(0, self.selectedCount - 1)
    self.totalItemCount = math.max(0, self.totalItemCount - itemFVO.num)
    self.selectedPrice = math.max(0, self.selectedPrice - math.floor(itemCA.rewardList[1].num * itemFVO.priceRate) * itemFVO.num)
  end
  if refreshElement == true then
    View.Group_Sale.Group_Middle.ScrollGrid_List.grid.self:RefreshAllElement()
  end
end

function DataModel:SetAllSaleItemSelected(isSelected, ignoreScrollGrid)
  for i = 1, #self.saleList do
    self:SetSaleItemSelected(i, isSelected)
  end
  if ignoreScrollGrid ~= true then
    View.Group_Sale.Group_Middle.ScrollGrid_List.grid.self:RefreshAllElement()
  end
  local groupBottom = View.Group_Sale.Group_Middle.Group_Di
  groupBottom.Group_SelectAll.Group_On.self:SetActive(isSelected)
  groupBottom.Group_SelectSSR.Group_On.self:SetActive(isSelected)
  groupBottom.Group_SelectSR.Group_On.self:SetActive(isSelected)
  groupBottom.Group_SelectR.Group_On.self:SetActive(isSelected)
  groupBottom.Group_SelectN.Group_On.self:SetActive(isSelected)
end

function DataModel:SetSaleItemsSelectedByQuality(quality, isSelected)
  for i = 1, #self.saleList do
    if quality == self.saleList[i].quality then
      self:SetSaleItemSelected(i, isSelected)
    end
  end
  View.Group_Sale.Group_Middle.ScrollGrid_List.grid.self:RefreshAllElement()
  local groupBottom = View.Group_Sale.Group_Middle.Group_Di
  groupBottom.Group_SelectAll.Group_On.self:SetActive(DataModel.selectedCount == #DataModel.saleList)
  self:GetSelectBtnByQuality(quality):SetActive(isSelected)
end

function DataModel:RefreshSelectNumAndPrice()
  local groupBottom = View.Group_Sale.Group_Middle.Group_Di
  groupBottom.Img_SelectNum.Txt_SelectNum:SetText(self.totalItemCount)
  groupBottom.Group_Earnings.Txt_Num:SetText(self.selectedPrice)
end

function DataModel:SetSaleStatus(status)
  self.saleStatus = status
  local groupMid = View.Group_Sale.Group_Middle
  local groupSwitch = groupMid.Group_Switch
  groupSwitch.Group_Single.Group_On.self:SetActive(status == self.SALE_STATUS.single)
  groupSwitch.Group_Batch.Group_On.self:SetActive(status == self.SALE_STATUS.batch)
  if status == self.SALE_STATUS.single then
    self:SetAllSaleItemSelected(false)
    self:RefreshSelectNumAndPrice()
  end
end

function DataModel:GetSelectBtnByQuality(quality)
  local groupBottom = View.Group_Sale.Group_Middle.Group_Di
  if quality == 4 then
    return groupBottom.Group_SelectSSR.Group_On.self
  elseif quality == 3 then
    return groupBottom.Group_SelectSR.Group_On.self
  elseif quality == 2 then
    return groupBottom.Group_SelectR.Group_On.self
  elseif quality == 1 then
    return groupBottom.Group_SelectN.Group_On.self
  end
end

function DataModel:SetUptipsShow(isShow)
  local group = View.Group_Sale.Group_Middle.Group_UpTips
  group.self:SetActive(isShow)
  if not isShow then
    return
  end
  group.Img_Di:SetSprite(self.StationCA.saleHighPricePath)
  local recyclableList = DataModel.recyclableList
  group.Img_Up.Txt_Num:SetText(PlayerData:GetFactoryData(99900014, "ConfigFactory").highCoefficient)
  group.ScrollGrid_List.grid.self:SetDataCount(#recyclableList)
  group.ScrollGrid_List.grid.self:RefreshAllElement()
  group.ScrollGrid_List.grid.self:MoveToTop()
  if DataModel.isTargetCity then
    group.Img_Up.Txt_Num:SetText(DataModel.activityPriceRate)
  end
end

function DataModel:OnClickItem(str)
  local itemId = DataModel.itemList[tonumber(str)].id
  local ca = PlayerData:GetFactoryData(itemId, "CommondityFactory")
  if ca.isBuyCondition then
    local gradeCondition = ca.gradeCondition
    if gradeCondition > PlayerData:GetUserInfo().lv then
      return
    end
  end
  if DataModel.notEnoughMap[tonumber(str)] then
    CommonTips.OpenTips(80601871)
    return
  end
  local isPurchase = ca.purchase
  local StoreDataModel = require("UIStore/UIStoreDataModel")
  local maxNum = StoreDataModel:GetPurchaseNum(ca)
  if isPurchase then
    local itemBuyCount = DataModel.itemBuyCount[tonumber(itemId)] or 0
    local remainCount = math.max(0, maxNum - itemBuyCount)
    if remainCount <= 0 then
      CommonTips.OpenTips(80609925)
      return
    end
  end
  local remainBuyNum = ca.purchase ~= true and -1 or math.max(0, maxNum - (DataModel.itemBuyCount[tonumber(itemId)] or 0))
  UIManager:Open("UI/Common/ExchangeTips", Json.encode({
    commodityId = itemId,
    remainNum = remainBuyNum,
    shopId = DataModel.exchangeStoreCA.id,
    index = DataModel.itemList[tonumber(str)].commodityIndex
  }), function()
    DataModel:OpenStorePage(true)
    NPCDialog.SetNPCTextByEnum(View.Group_NPC, DataModel.NPCDialogEnum.exchangeSuccessText)
  end)
end

function DataModel:RefreshSafeBtnShow()
  if not ActivitySafeDataModel or not FastBattleDataModel then
    return
  end
  if ActivitySafeDataModel.GetSafeIsUnlock() then
    View.Group_Main.Btn_Safe:SetActive(true)
    View.Group_Main.Btn_Safe.Img_RedPoint:SetActive(FastBattleDataModel.GetAllLeverRewardRedDotState())
  else
    View.Group_Main.Btn_Safe:SetActive(false)
  end
end

return DataModel
