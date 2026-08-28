local DataModel = require("UISquads/UISquadsDataModel")
local DataController = require("UISquads/UISquadsDataController")

local function _BattleStartCallback()
  local WitchMainController = require("UIWitchMain/UIWitchMainDataController")
  WitchMainController:Clear()
  WitchMainController = nil
  PlayerData.BattleInfo.squadIndex = DataModel.curSquadIndex
  SafeReleaseScene(false)
  PlayerData:SetPlayerPrefs("int", "LastBattleSquadIndex", DataModel.curSquadIndex)
  CBus:ChangeScene("Battle")
  GameSetting:LoadPlayerSetting()
end

local function BattleFinishCallback(isPrologue)
  local battleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
  local info = battleControlManager.currentPlayerTeamData.battleData.BattleResult
  PlayerData.BattleInfo.BattleResult = info
  local roleList = battleControlManager.teamDataDic[1].roleList
  local roleCount = roleList.Count
  local levelCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.battleStageId, "LevelFactory")
  local hpPercentList = {}
  if levelCA.saleLevelType == "CubeRogue" then
    for i = 0, roleCount - 1 do
      local role = roleList[i]
      local curHP = LuaSafeMath.SafeNumToFloat(role.property:GetHpPercentSN())
      hpPercentList[tostring(role.ca.id)] = {hp = curHP}
    end
  end
  PlayerData.BattleInfo.HpPercentList = hpPercentList
  local checkAttrDic = {}
  if levelCA.isDisplayLeaderBoard == true and levelCA.leaderBoardSortType == "damage" then
    local battleConfig = PlayerData:GetFactoryData(99900008, "ConfigFactory")
    local attrList = battleConfig.judgeAttributeList
    for i = 0, roleCount - 1 do
      local role = roleList[i]
      local curDic = {}
      for j = 1, #attrList do
        local attrName = attrList[j].name
        curDic[attrName] = LuaSafeMath.SafeNumToFloat(role.property:GetValueSN(attrName))
      end
      checkAttrDic[tostring(role.ca.id)] = curDic
    end
  end
  PlayerData.BattleInfo.checkAttrDic = checkAttrDic
  local enemyIds = ""
  local enemyIdList = string.split(info.enemy_ids, ",")
  for i = 1, #enemyIdList do
    enemyIds = enemyIds .. enemyIdList[i] .. ":" .. 1
    if i ~= #enemyIdList then
      enemyIds = enemyIds .. ","
    end
  end
  if isPrologue == true then
    Net:SendProto("battle.end_battle", function(json)
      Train.EventBattleFinish(json)
      CBus:ChangeScene("Main")
    end, PlayerData.BattleInfo.levelUid, 1, Json.encode({
      enemyIds = enemyIds,
      enemy_Ids = info.enemy_ids,
      enemy_level_min = info.enemy_level_min,
      enemy_level = info.enemy_level,
      weather_id = info.weather_id,
      second_weather_id = info.second_weather_id,
      bgId = info.bgId,
      duration_time = info.duration
    }), nil, nil, nil, info.cores)
  else
    CommonTips.OpenSettlement()
  end
end

local function BattleTestFinishCallback()
  if MapNeedleEventData.scene then
    SafeReleaseScene(false)
    CBus:ChangeScene(MapNeedleEventData.scene, function()
      local SortType = {
        pluckList = {},
        isIncr = false
      }
      local data = {
        currentRoleId = DataModel.BattleResultTestID,
        fromView = EnumDefine.CommonFilterType.OtherSort,
        sortType = SortType
      }
      UIManager:Open("UI/CharacterInfo/CharacterInfo", Json.encode(data))
      UIManager:SetHistory("UI/InsZone/InsZone")
    end)
    return
  end
  CBus:ChangeScene("Main", function()
    local SortType = {
      pluckList = {},
      isIncr = false
    }
    local data = {
      currentRoleId = DataModel.BattleResultTestID,
      fromView = EnumDefine.CommonFilterType.OtherSort,
      sortType = SortType
    }
    UIManager:Open("UI/CharacterInfo/CharacterInfo", Json.encode(data))
    local status = {btn = "Member"}
    UIManager:SetHistory("UI/CharacterList/CharacterList", Json.encode(status))
  end)
end

local function InitBattle(levelId, roleDataList, randomSeed, isBattleTest, battleFinishCallback, enemyLevelMin, difficulty, bgId, enemyLevel, enemyRn, weatherIdList, weatherRateSN, enemyLevelOffset, secondWeatherList, secondWeatherRateSN, secondWeatherCount, enemy_ids, trainWeaponSkill)
  local isLevelFinish = PlayerData.IsLevelFinished(levelId)
  local playerLv = PlayerData:GetUserInfo().lv
  local weatherCount = weatherIdList ~= nil and #weatherIdList or 0
  ReplayManager:InitBattle(levelId, randomSeed, playerLv, isLevelFinish, isBattleTest, 1, enemyLevelMin or 1, difficulty or 1, bgId or -1, enemyLevel or -1, enemyRn or -1, weatherIdList, weatherRateSN or -1 or 0, enemyLevelOffset or 0, secondWeatherList, secondWeatherRateSN or -1, secondWeatherCount or 0, weatherCount or 0, enemy_ids or "", trainWeaponSkill or "")
  local equipData = DataModel:GetUrEquipData()
  if isBattleTest then
    equipData = nil
  else
    PlayerData.BattleInfo.UrEquipData = equipData
  end
  for k, v in pairs(roleDataList) do
    if next(v) ~= nil and (v.isBlocked ~= true or v.isLevelRole) then
      local petProp = PlayerData:GetRolePetProperty(v.unitId)
      local useEquip1 = true
      local useEquip2 = true
      local useEquip3 = true
      if equipData and next(equipData) ~= nil then
        useEquip1 = equipData and equipData[tostring(v.unitId)] and equipData[tostring(v.unitId)][1] and equipData[tostring(v.unitId)][1].isUse
        useEquip2 = equipData and equipData[tostring(v.unitId)] and equipData[tostring(v.unitId)][2] and equipData[tostring(v.unitId)][2].isUse
        useEquip3 = equipData and equipData[tostring(v.unitId)] and equipData[tostring(v.unitId)][3] and equipData[tostring(v.unitId)][3].isUse
      end
      local equip1Id = 0 <= tonumber(v.equip1Id) and useEquip1 and tonumber(v.equip1Id) or 11800220
      local e1Lv = 0 <= tonumber(v.equip1Id) and useEquip1 and v.equip1Lv or 1
      local e1s1Id = 0 <= tonumber(v.equip1Id) and useEquip1 and v.e1s1Id or -1
      local e1s2Id = 0 <= tonumber(v.equip1Id) and useEquip1 and v.e1s2Id or -1
      local e1s3Id = 0 <= tonumber(v.equip1Id) and useEquip1 and v.e1s3Id or -1
      local e1s4Id = 0 <= tonumber(v.equip1Id) and useEquip1 and v.e1s4Id or -1
      local equip2Id = 0 <= tonumber(v.equip2Id) and useEquip2 and tonumber(v.equip2Id) or 11800220
      local e2Lv = 0 <= tonumber(v.equip2Id) and useEquip2 and v.equip2Lv or 1
      local e2s1Id = 0 <= tonumber(v.equip2Id) and useEquip2 and v.e2s1Id or -1
      local e2s2Id = 0 <= tonumber(v.equip2Id) and useEquip2 and v.e2s2Id or -1
      local e2s3Id = 0 <= tonumber(v.equip2Id) and useEquip2 and v.e2s3Id or -1
      local e2s4Id = 0 <= tonumber(v.equip2Id) and useEquip2 and v.e2s4Id or -1
      local equip3Id = 0 <= tonumber(v.equip3Id) and useEquip3 and tonumber(v.equip3Id) or -1
      if useEquip1 then
        if v.extraSkills == nil then
          v.extraSkills = ""
        end
        if v.extraSkills ~= "" then
          if v.attrStr1 and v.attrStr1 ~= "" then
            v.attrStr1 = "|" .. v.attrStr1
          end
          v.extraSkills = v.extraSkills .. v.attrStr1
        elseif v.attrStr1 then
          v.extraSkills = v.extraSkills .. v.attrStr1
        end
      end
      if useEquip2 then
        if v.extraSkills == nil then
          v.extraSkills = ""
        end
        if v.extraSkills ~= "" then
          if v.attrStr2 and v.attrStr2 ~= "" then
            v.attrStr2 = "|" .. v.attrStr2
          end
          v.extraSkills = v.extraSkills .. v.attrStr2
        elseif v.attrStr2 then
          v.extraSkills = v.extraSkills .. v.attrStr2
        end
      end
      if useEquip2 then
        if v.extraSkills == nil then
          v.extraSkills = ""
        end
        if v.extraSkills ~= "" then
          if v.attrStr3 and v.attrStr3 ~= "" then
            v.attrStr3 = "|" .. v.attrStr3
          end
          v.extraSkills = v.extraSkills .. v.attrStr3
        elseif v.attrStr3 then
          v.extraSkills = v.extraSkills .. v.attrStr3
        end
      end
      ReplayManager:AddRole(tonumber(v.unitId), tonumber(v.unitViewId), tonumber(v.skill1Lv), tonumber(v.skill2Lv), tonumber(v.skill3Lv), tonumber(v.lv), tonumber(v.awakeLv), tonumber(v.resonanceLv), tonumber(v.trustLv), tonumber(equip1Id), tonumber(e1Lv), tonumber(e1s1Id), math.floor(tonumber(v.e1s1NumSN)), tonumber(e1s2Id), math.floor(tonumber(v.e1s2NumSN)), tonumber(e1s3Id), math.floor(tonumber(v.e1s3NumSN)), tonumber(e1s4Id), math.floor(tonumber(v.e1s4NumSN)), tonumber(12300776), math.floor(tonumber(petProp.atk * SafeMath.safeNumberTime)), tonumber(12300777), math.floor(tonumber(petProp.def) * SafeMath.safeNumberTime), tonumber(equip2Id), tonumber(e2Lv), tonumber(e2s1Id), math.floor(tonumber(v.e2s1NumSN)), tonumber(e2s2Id), math.floor(tonumber(v.e2s2NumSN)), tonumber(e2s3Id), math.floor(tonumber(v.e2s3NumSN)), tonumber(e2s4Id), math.floor(tonumber(v.e2s4NumSN)), tonumber(v.e2s5Id), math.floor(tonumber(v.e2s5NumSN)), tonumber(12300771), math.floor(tonumber(petProp.hp * SafeMath.safeNumberTime)), tonumber(equip3Id), tonumber(v.equip3Lv), tonumber(v.e3s1Id), math.floor(tonumber(v.e3s1NumSN)), tonumber(v.e3s2Id), math.floor(tonumber(v.e3s2NumSN)), tonumber(v.e3s3Id), math.floor(tonumber(v.e3s3NumSN)), tonumber(v.e3s4Id), math.floor(tonumber(v.e3s4NumSN)), tonumber(v.e3s5Id), math.floor(tonumber(v.e3s5NumSN)), tonumber(v.e3s6Id), math.floor(tonumber(v.e3s6NumSN)), tonumber(v.cardNum1), tonumber(v.cardNum2), -1, 1, v.extraSkills or "", v.squadIndex or k)
    end
  end
  if battleFinishCallback == nil then
    ReplayManager:RegBattleFinishCallback(BattleFinishCallback)
  else
    ReplayManager:RegBattleFinishCallback(battleFinishCallback)
  end
  _BattleStartCallback()
  local level_difficulty = difficulty or 1
  SdkReporter.TrackBattleStart(levelId, level_difficulty)
end

local module = {
  IsPrologueCleared = function(levelId)
    return PlayerData.ServerData.chapter_level[tostring(levelId)] ~= nil
  end
}

function module:StartBattle(levelId, levelType, roleDataList, squadIndex, levelIndexStr, isBattleTest, eventId, levelKey, battleFinishCallback, failCb, enemyLevelMin, difficulty, bgId, enemyLevel, enemyRn, weatherIdList, weatherRateSN, enemyLevelOffset, secondWeatherList, secondWeatherRateSN, secondWeatherCount, enemy_ids, trainWeaponSkill, ttbSid, ttbIndex, ttbId, dialogId, friendId, gridId, csActivityId, csIndex)
  local function callback(randomSeed, waveStr)
    if waveStr == nil or waveStr == "" then
      waveStr = enemy_ids
    end
    InitBattle(levelId, roleDataList, randomSeed, isBattleTest, battleFinishCallback, enemyLevelMin, difficulty, bgId, enemyLevel, enemyRn, weatherIdList, weatherRateSN, enemyLevelOffset, secondWeatherList, secondWeatherRateSN, secondWeatherCount, waveStr, trainWeaponSkill)
  end
  
  local roleMap = {}
  for i = 1, #roleDataList do
    if roleDataList[i].unitId ~= nil and roleDataList[i].unitId ~= "" and PlayerData:GetFactoryData(roleDataList[i].unitId) ~= nil then
      if roleMap[tostring(roleDataList[i].unitId)] ~= true then
        roleMap[tostring(roleDataList[i].unitId)] = true
      else
        CommonTips.OpenTips(80607587)
        return
      end
    end
  end
  if PlayerData.curSelectedHelpRole ~= nil then
    levelType = 2
  end
  PlayerData.BattleInfo.battleStageId = levelId
  PlayerData.BattleInfo.levelType = levelType
  PlayerData.BattleInfo.roleDataList = roleDataList
  PlayerData.BattleInfo.squadIndex = squadIndex - 1
  PlayerData.BattleInfo.levelIndexStr = levelIndexStr
  PlayerData.BattleInfo.isBattleTest = isBattleTest
  PlayerData.BattleInfo.battleFinishCallback = battleFinishCallback
  PlayerData.BattleInfo.isPassed = PlayerData:GetLevelPass(levelId)
  PlayerData.BattleInfo.eventId = eventId
  PlayerData.BattleInfo.levelKey = levelKey
  PlayerData.BattleInfo.enemyLevelMin = enemyLevelMin
  PlayerData.BattleInfo.difficulty = difficulty
  PlayerData.BattleInfo.bgId = bgId
  PlayerData.BattleInfo.enemyLevel = enemyLevel
  PlayerData.BattleInfo.enemyRn = enemyRn
  PlayerData.BattleInfo.weatherIdList = weatherIdList
  PlayerData.BattleInfo.weatherRateSN = weatherRateSN
  PlayerData.BattleInfo.enemyLevelOffset = enemyLevelOffset
  PlayerData.BattleInfo.secondWeatherList = secondWeatherList
  PlayerData.BattleInfo.secondWeatherRateSN = secondWeatherRateSN
  PlayerData.BattleInfo.secondWeatherCount = secondWeatherCount
  PlayerData.BattleInfo.enemy_ids = enemy_ids
  PlayerData.BattleInfo.trainWeaponSkill = trainWeaponSkill
  PlayerData.BattleInfo.ttbSid = ttbSid
  PlayerData.BattleInfo.ttbIndex = ttbIndex
  PlayerData.BattleInfo.ttbId = ttbId
  PlayerData.BattleInfo.dialogId = dialogId
  PlayerData.BattleInfo.friendId = friendId
  PlayerData.BattleInfo.gridId = gridId
  PlayerData.BattleInfo.csActivityId = csActivityId
  PlayerData.BattleInfo.csIndex = csIndex
  PlayerData.BattleInfo.serverIndex = DataModel.serverIdx
  if failCb == nil then
    function failCb()
    end
  end
  PlayerData.BattleInfo.coreId = nil
  if PlayerData.SquadsTempData then
    PlayerData.BattleInfo.coreId = PlayerData.SquadsTempData.coreId
  end
  local pgUniqueId, pgUid
  if PlayerData.SquadsTempData then
    pgUniqueId = PlayerData.SquadsTempData.pgUniqueId
    pgUid = PlayerData.SquadsTempData.pgUid
  end
  BugLogReporter:AddKeyValueTail(BugLogReporter.ReportNames.TrainLineEvents, "\232\175\183\230\177\130\232\191\155\229\133\165\230\136\152\230\150\151", eventId)
  local ca = PlayerData:GetFactoryData(levelId, "LevelFactory")
  local autoDiff = 0
  if not DataModel.isLockDiff and ca.isAutoDifficulty then
    autoDiff = 1
  end
  local isCardAIOff = PlayerData:GetPlayerPrefs("int", "CardAIOn", true) == 0
  if ca.isBanAutoBattle and not isCardAIOff then
    PlayerData:SetPlayerPrefs("int", "CardAIBan", 1, true)
  elseif not ca.isBanAutoBattle and PlayerData:GetPlayerPrefs("int", "CardAIBan", true) == 1 then
    PlayerData:SetPlayerPrefs("int", "CardAIBan", 0, true)
    PlayerData:SetPlayerPrefs("int", "CardAIOn", 1, true)
  end
  Net:SendProto("battle.start_battle", function(json)
    if json.world_bosses then
      PlayerData.ServerData.all_activities.ing[PlayerData.TempCache.tempWorldBossActivityId].world_bosses = json.world_bosses
      UIManager:GoBack()
      CommonTips.OpenTips(80611355)
      return
    end
    local MainDataModel = require("UIMainUI/UIMainUIDataModel")
    MainDataModel.CurBattleEventID = eventId
    PlayerData.TempCache.GuideNoUpdateLimitData[EnumDefine.GuideNoUpdateLimitDataEnum.LevelId] = levelId
    local levelCA = PlayerData:GetFactoryData(levelId, "LevelFactory")
    local loadingPng = ""
    local loadingStr = ""
    if levelCA ~= nil then
      loadingPng = levelCA.loadingPng
      loadingStr = levelCA.loadingTips
    end
    if json.levelUid ~= nil then
      PlayerData.BattleInfo.levelUid = json.levelUid
      
      local function CallBack()
        local enemyWaveStr = ""
        if json.waves ~= nil then
          for i = 1, #json.waves do
            if 3 < i then
              break
            end
            if enemyWaveStr ~= "" then
              enemyWaveStr = enemyWaveStr .. ","
            end
            enemyWaveStr = enemyWaveStr .. json.waves[i]
          end
        end
        callback(json.server_now, enemyWaveStr)
      end
      
      CommonTips.OpenLoading(nil, "", loadingPng, CallBack, loadingStr)
      LoadingManager:SetLoadingPercent(0.75)
    else
      UIManager:GoHome()
      CommonTips.OpenTips(80602114)
    end
    if PlayerData.ServerData.record_level == nil then
      PlayerData.ServerData.record_level = {}
    end
    if levelCA ~= nil then
      PlayerData.ServerData.record_level[levelCA.mod] = levelId
    end
    PlayerData.LevelData = levelCA
    if ttbId ~= nil then
      local itemCost = levelCA.itemCost
      if itemCost[1] then
        PlayerData:RefreshUseItems({
          [itemCost[1].id] = itemCost[1].num
        })
      end
    end
    if levelCA.mod == "\230\183\177\230\184\138\229\133\179\229\141\161" then
      local itemCost = levelCA.itemCost
      local itemMap = {}
      for i = 1, #itemCost do
        itemMap[itemCost[i].id] = itemCost[i].num
      end
      if table.count(itemMap) > 0 then
        PlayerData:RefreshUseItems(itemMap)
      end
    end
  end, levelId, eventId, squadIndex - 1, levelType, levelIndexStr, eventId and 1 or 0, DataModel.InitParams and DataModel.InitParams.EventIndex or nil, DataModel.InitParams and DataModel.InitParams.Sid or nil, levelKey, failCb, difficulty or 1, DataModel.InitParams and DataModel.InitParams.NextDistance or nil, DataModel.InitParams and DataModel.InitParams.areaId or nil, PlayerData.BattleInfo.coreId, ttbSid, ttbIndex, ttbId, PlayerData.BattleInfo.rids, pgUniqueId, autoDiff, dialogId, friendId, gridId, PlayerData.BattleInfo.rbIndex, csActivityId, csIndex, pgUid, PlayerData.BattleInfo.activityId, DataModel.serverIdx, PlayerData.curSelectedHelpRole)
end

function module:AgainBattle(isOpenPrompt, noCallBack, yesCb)
  local function yesCallBack()
    if yesCb ~= nil then
      yesCb()
    end
    module:StartBattle(PlayerData.BattleInfo.battleStageId, PlayerData.BattleInfo.levelType, PlayerData.BattleInfo.roleDataList, PlayerData.BattleInfo.squadIndex, PlayerData.BattleInfo.levelIndexStr, PlayerData.BattleInfo.isBattleTest, PlayerData.BattleInfo.eventId, PlayerData.BattleInfo.levelKey, PlayerData.BattleInfo.battleFinishCallback, noCallBack, PlayerData.BattleInfo.enemyLevelMin, PlayerData.BattleInfo.difficulty, PlayerData.BattleInfo.bgId, PlayerData.BattleInfo.enemyLevel, PlayerData.BattleInfo.enemyRn, PlayerData.BattleInfo.weatherIdList, PlayerData.BattleInfo.weatherRateSN, PlayerData.BattleInfo.enemyLevelOffset, PlayerData.BattleInfo.secondWeatherList, PlayerData.BattleInfo.secondWeatherRateSN, PlayerData.BattleInfo.secondWeatherCount, PlayerData.BattleInfo.enemy_ids, PlayerData.BattleInfo.trainWeaponSkill)
  end
  
  if isOpenPrompt == true then
    CommonTips.OnPrompt(80600280, nil, nil, yesCallBack, noCallBack)
  else
    yesCallBack()
  end
end

function module:NextLevelBattle(isOpenPrompt, noCallBack)
  local function yesCallBack()
    local levelCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.battleStageId, "LevelFactory")
    
    if levelCA.nextLevel ~= nil and levelCA.nextLevel > 0 then
      local levelId = levelCA.nextLevel
      module:StartBattle(levelId, PlayerData.BattleInfo.levelType, PlayerData.BattleInfo.roleDataList, PlayerData.BattleInfo.squadIndex, nil, true, nil, PlayerData.BattleInfo.battleFinishCallback, noCallBack)
    else
      noCallBack()
    end
  end
  
  if isOpenPrompt == true then
    CommonTips.OnPrompt(80600279, nil, nil, yesCallBack, noCallBack)
  else
    yesCallBack()
  end
end

function module:StartBattleTest(levelId, roleDataList)
  DataModel.BattleResultTestID = {}
  
  local function callback()
    DataModel.BattleResultTestID = roleDataList[1].unitId
    PlayerData.SetIsTest(true)
    InitBattle(levelId, roleDataList, CBus.currentFrame, true, BattleTestFinishCallback)
  end
  
  PlayerData.BattleInfo.battleStageId = levelId
  CommonTips.OpenLoading(nil, nil, nil, callback)
end

function module:StartAbyssBattle(levelId, roleIdList, difficulty)
  difficulty = difficulty or 1
  PlayerData.BattleInfo.rids = ""
  if PlayerData.SquadsTempData then
    PlayerData.SquadsTempData.coreId = nil
  end
  DataModel.InitParams = {}
  for i = 1, #roleIdList do
    if PlayerData.BattleInfo.rids ~= "" then
      PlayerData.BattleInfo.rids = PlayerData.BattleInfo.rids .. ","
    end
    PlayerData.BattleInfo.rids = PlayerData.BattleInfo.rids .. roleIdList[i].id
  end
  module:StartBattle(levelId, 2, DataController:GetRoleDataList(roleIdList), -1, nil, false, nil, nil, nil, nil, nil, difficulty)
  PlayerData.BattleInfo.rids = nil
end

function module:StartEndlessBattle(levelId, roleIdList, activityId, prog, extraLv)
  PlayerData.BattleInfo.rids = ""
  if PlayerData.SquadsTempData then
    PlayerData.SquadsTempData.coreId = nil
  end
  DataModel.InitParams = {}
  for i = 1, #roleIdList do
    if PlayerData.BattleInfo.rids ~= "" then
      PlayerData.BattleInfo.rids = PlayerData.BattleInfo.rids .. ","
    end
    PlayerData.BattleInfo.rids = PlayerData.BattleInfo.rids .. roleIdList[i].id
  end
  local roleList = DataController:GetRoleDataList(roleIdList)
  local str = roleList[1].extraSkills
  if str ~= "" then
    str = str .. "|"
  end
  roleList[1].extraSkills = str .. 12303433 .. ",LoseHp," .. 1 - prog
  for i = 1, #roleList do
    roleList[i].lv = roleList[i].lv + extraLv
  end
  PlayerData.BattleInfo.activityId = activityId
  module:StartBattle(levelId, 2, roleList, -1, nil, false)
  PlayerData.BattleInfo.activityId = nil
  PlayerData.BattleInfo.rids = nil
end

function module:StartRandomBattle(levelId, roleList, difficulty, rbIndex)
  local difficulty = difficulty or 1
  PlayerData.BattleInfo.rids = ""
  if PlayerData.SquadsTempData then
    PlayerData.SquadsTempData.coreId = nil
  end
  DataModel.InitParams = {}
  for i = 1, #roleList do
    if PlayerData.BattleInfo.rids ~= "" then
      PlayerData.BattleInfo.rids = PlayerData.BattleInfo.rids .. ","
    end
    PlayerData.BattleInfo.rids = PlayerData.BattleInfo.rids .. roleList[i].unitId
  end
  PlayerData.BattleInfo.rbIndex = rbIndex
  module:StartBattle(tonumber(levelId), 2, roleList, -1, nil, false, nil, nil, nil, nil, nil, difficulty)
  if PlayerData.TempCache == nil then
    PlayerData.TempCache = {}
  end
  if PlayerData.TempCache.rbData == nil then
    PlayerData.TempCache.rbData = {}
  end
  PlayerData.TempCache.rbData.rids = PlayerData.BattleInfo.rids
  PlayerData.TempCache.rbData.rbIndex = PlayerData.BattleInfo.rbIndex
  PlayerData.BattleInfo.rids = nil
  PlayerData.BattleInfo.rbIndex = nil
end

function module:StartCubeBattle(levelId, roleIdList, difficulty, weaponSkill)
  difficulty = difficulty or 1
  PlayerData.BattleInfo.rids = ""
  if PlayerData.SquadsTempData then
    PlayerData.SquadsTempData.coreId = nil
  end
  DataModel.InitParams = {}
  for i = 1, #roleIdList do
    if PlayerData.BattleInfo.rids ~= "" then
      PlayerData.BattleInfo.rids = PlayerData.BattleInfo.rids .. ","
    end
    PlayerData.BattleInfo.rids = PlayerData.BattleInfo.rids .. roleIdList[i].unitId
  end
  PlayerData.BattleInfo.TeamKey = "Cube"
  PlayerData.BattleInfo.UrEquipData = nil
  module:StartBattle(levelId, 2, roleIdList, -1, nil, false, nil, nil, nil, nil, nil, 1, nil, difficulty, nil, nil, nil, nil, nil, nil, nil, nil, weaponSkill)
  PlayerData.BattleInfo.rids = nil
end

return module
