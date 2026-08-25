local BattlePVPTrainMockDataUtil = {}

function BattlePVPTrainMockDataUtil.CalcInitProperty(awakerConfig, propertyName)
  if not awakerConfig then
    return
  end
  if "hp" == propertyName or "max_hp" == propertyName then
    do return math.ceil end
    return math.ceil, awakerConfig.PVPHP
  end
  if awakerConfig[propertyName] then
    do return math.ceil end
    return math.ceil, awakerConfig[propertyName]
  end
end

function BattlePVPTrainMockDataUtil.LoadAwakerConfigProperties(tid)
  local properties = {}
  local awakerConfig = DT.AwakerConfig[tid]
  properties[bc.BattleProperty.hp] = math.ceil(awakerConfig.PVPHP)
  properties[bc.BattleProperty.max_hp] = properties[bc.BattleProperty.hp]
  properties[bc.BattleProperty.ulti_energy_max] = bc.UltiEnergyPerSkill
  return properties
end

function BattlePVPTrainMockDataUtil.MockDataToBattleData(trainTid, draftRelicTid)
  local role = {}
  local cards = {}
  local schoolConfigId
  for i, tid in ipairs({trainTid}) do
    tid = tonumber(tid)
    local level = 1
    local slotCards = {}
    local breakLevel = 0
    local potencyLevel = 0
    local playerAwaker = AwakerDataUtils.GetAwakerData(tid)
    local awakerData = {
      tid = tid,
      level = level,
      properties = BattlePVPTrainMockDataUtil.LoadAwakerConfigProperties(tid),
      slotCards = slotCards,
      breakLevel = breakLevel,
      breakSkillLevel = breakLevel,
      potencyLevel = potencyLevel,
      curSkin = playerAwaker.curSkin
    }
    table.insert(role, awakerData)
    local awakerConfig = DT.AwakerConfig[tid]
    local skillLevel = 1
    awakerData.ultiSkill = {
      tid = awakerConfig.PVPSkillList[1],
      level = skillLevel
    }
    for j = 2, #awakerConfig.PVPSkillList do
      local cardData = {
        tid = awakerConfig.PVPSkillList[j],
        level = skillLevel
      }
      table.insert(cards, cardData)
      awakerData.slotCards[j] = {
        tid = awakerConfig.PVPSkillList[j],
        level = skillLevel
      }
    end
    awakerData.schoolConfigId = awakerConfig.School
    if not schoolConfigId and awakerConfig.School ~= bc.NeutralSchoolId then
      schoolConfigId = awakerConfig.School
    end
  end
  schoolConfigId = schoolConfigId or bc.NeutralSchoolId
  local playerInfo = {
    stageStar = 0,
    skillList = {},
    cards = cards,
    relics = {},
    roleData = role,
    curMoney = 0,
    stress = 0,
    lives = 1,
    respawnedNum = 0,
    stateList = {},
    statistics = {},
    playerLevel = 1,
    accountPower = 0,
    copyProperties = {},
    worldAttrs = {},
    dimensionCards = {},
    keeperSkill = 0,
    playerId = 0,
    gender = 1,
    icon = PlayerDataUtils.GetAvatarIconTid(),
    playerName = PlayerDataUtils.GetName(),
    schoolConfigId = schoolConfigId
  }
  playerInfo.cards = cards
  playerInfo.roleData = role
  playerInfo.lives = 1
  playerInfo.playerLevel = PlayerDataUtils.GetLevel()
  playerInfo.copyProperties = {hp = 100, max_hp = 100}
  playerInfo.playerId = 1
  playerInfo.weaponList = {}
  playerInfo.keeperSkillList = {}
  playerInfo.gameplayType = bc.BattleGameplayType.PVP_TRAIN
  local PVPTraning_EnemyHead = DT.GetOriginalConstant("PVPTraning_EnemyHead")
  local enemyName = PVPTraning_EnemyHead[1]
  local enemyIcon = PVPTraning_EnemyHead[2]
  local playerInfo2 = table.deepclone(playerInfo)
  playerInfo2.roleData = {}
  playerInfo2.cards = {}
  playerInfo2.playerId = playerInfo2.playerId + 1
  playerInfo2.playerName = LT.Text(enemyName)
  playerInfo2.icon = enemyIcon
  local tidList = DT.GetOriginalConstant("PVPBattleConfigList")
  local battleInfo = {
    svrRunBattle = false,
    isMock = true,
    battleTid = tidList[math.random(1, #tidList)],
    stageId = DT.GetConstant("ProloguePhiloStoneBlock"),
    battleUid = 100000,
    randomseed = os.time(),
    draftRelicTid = draftRelicTid,
    pvpDir = 1,
    isIntro = false,
    gameplayType = bc.BattleGameplayType.PVP_TRAIN,
    gameLogBattleUid = "gameLogBattleUid",
    [bc.BattleCamp.Camp1] = playerInfo,
    [bc.BattleCamp.Camp2] = playerInfo2,
    skipTimer = true
  }
  return battleInfo
end

return BattlePVPTrainMockDataUtil
