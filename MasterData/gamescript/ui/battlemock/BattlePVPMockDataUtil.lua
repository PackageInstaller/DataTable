local BattleMockDataUtil = {}

function BattleMockDataUtil.CalcInitProperty(awakerConfig, propertyName)
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

function BattleMockDataUtil.LoadAwakerConfigProperties(tid)
  local properties = {}
  local awakerConfig = DT.AwakerConfig[tid]
  properties[bc.BattleProperty.hp] = math.ceil(awakerConfig.PVPHP)
  properties[bc.BattleProperty.max_hp] = properties[bc.BattleProperty.hp]
  properties[bc.BattleProperty.ulti_energy_max] = bc.UltiEnergyPerSkill
  properties.ulti_energy_init = 0
  properties.ulti_energy = 0
  return properties
end

function BattleMockDataUtil.MockDataToBattleData(mockData)
  local role = {}
  local cards = {}
  local schoolConfigId
  for i, tid in ipairs(mockData.Awakers) do
    tid = tonumber(tid)
    local level = tonumber(mockData.Levels[i])
    local slotCards = {}
    local breakLevel = mockData.BreakLevels[i]
    local potencyLevel = mockData.Potencies[i]
    local awakerData = {
      tid = tid,
      level = level,
      properties = BattleMockDataUtil.LoadAwakerConfigProperties(tid),
      slotCards = slotCards,
      breakLevel = breakLevel,
      breakSkillLevel = breakLevel,
      potencyLevel = potencyLevel
    }
    table.insert(role, awakerData)
    local awakerConfig = DT.AwakerConfig[tid]
    local skillLevel = mockData.SkillLevels[i]
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
    playerName = "测试",
    schoolConfigId = schoolConfigId
  }
  playerInfo.cards = cards
  playerInfo.roleData = role
  playerInfo.lives = 1
  playerInfo.playerLevel = mockData.playerLevel or 1
  playerInfo.copyProperties = {
    hp = mockData.Hp,
    max_hp = mockData.MaxHp
  }
  playerInfo.playerId = 1
  playerInfo.weaponList = mockData.weaponList
  playerInfo.keeperSkillList = mockData.keeperSkillList
  playerInfo.gameplayType = bc.BattleGameplayType.PVP
  local playerInfo2 = table.deepclone(playerInfo)
  playerInfo2.playerId = playerInfo2.playerId + 1
  local tidList = DT.GetOriginalConstant("PVPBattleConfigList")
  local battleInfo = {
    svrRunBattle = false,
    isMock = true,
    battleTid = tidList[math.random(1, #tidList)],
    stageId = mockData.StageID or DT.GetConstant("ProloguePhiloStoneBlock"),
    battleUid = 100000,
    randomseed = os.time(),
    pvpDir = mockData.pvpDir,
    isIntro = false,
    isLogin = true,
    gameplayType = bc.BattleGameplayType.PVP,
    gameLogBattleUid = "gameLogBattleUid",
    [bc.BattleCamp.Camp1] = playerInfo,
    [bc.BattleCamp.Camp2] = playerInfo2,
    skipTimer = true
  }
  return battleInfo
end

return BattleMockDataUtil
