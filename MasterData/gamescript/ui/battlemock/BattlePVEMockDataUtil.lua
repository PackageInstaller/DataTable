local BattleMockDataUtil = {}

function BattleMockDataUtil.MockDataToBattleData(mockData)
  local awakerList = {}
  local cards = {}
  local schoolMap = {}
  for i, tid in ipairs(mockData.Awakers) do
    tid = tonumber(tid)
    local talentCfgList = AwakerTalentExtModel.Instance:GetTalentCfgList(tid)
    local level = tonumber(mockData.Levels[i])
    local slotCards = {}
    local breakLevel = mockData.BreakLevels[i]
    local potencyLevel = mockData.Potencies[i]
    local awakerData = {
      tid = tid,
      level = level,
      attrs = {
        [bc.AwakerProperty.ulti_energy] = 100,
        [bc.AwakerProperty.ulti_energy_max_per] = 100
      },
      slotCards = slotCards,
      slots = {},
      breakLevel = breakLevel,
      breakSkillLevel = breakLevel,
      potencyLevel = potencyLevel,
      doubleUltiEnergy = true,
      talents = {},
      curSkin = mockData.SkinTids and mockData.SkinTids[i] or 0
    }
    print("---------MockDataToBattleData curSkin", awakerData.tid, awakerData.curSkin)
    table.insert(awakerList, awakerData)
    for _, talentCfg in ipairs(talentCfgList) do
      if AwakerTalentExtModel.Instance:CheckTalentDefaultActivation(talentCfg.ID) then
        awakerData.talents[talentCfg.ID] = {lv = 1}
      end
    end
    local awakerConfig = DT.AwakerConfig[tid]
    local skillLevel = mockData.SkillLevels[i]
    awakerData.ultiSkill = {
      tid = awakerConfig.SkillList[1],
      level = skillLevel
    }
    for j = 1, #awakerConfig.SkillList do
      if j >= 2 then
        local cardData = {
          tid = awakerConfig.SkillList[j],
          level = skillLevel
        }
        table.insert(cards, cardData)
        awakerData.slotCards[j] = {
          tid = awakerConfig.SkillList[j],
          level = skillLevel
        }
      end
      awakerData.slots[j] = {
        tid = awakerConfig.SkillList[j],
        level = skillLevel
      }
    end
    local school = awakerConfig.School
    schoolMap[school] = (schoolMap[school] or 0) + 1
  end
  local battleData = {}
  battleData.battleTid = mockData.BattleID
  battleData.stageId = mockData.StageID or DT.GetConstant("ProloguePhiloStoneBlock")
  battleData.cards = cards
  battleData.roleData = awakerList
  battleData.coverMonsters = mockData.coverMonsters
  battleData.scendId = mockData.BattleSceneID
  battleData.isMock = true
  battleData.mockScene = SceneMgr.Instance:GetSceneType()
  battleData.mockWeaponList = mockData.mockWeaponList
  battleData.lives = 1
  battleData.playerLevel = mockData.playerLevel or 1
  battleData.schoolMap = schoolMap
  battleData.copyProperties = {
    hp = mockData.Hp,
    max_hp = mockData.MaxHp,
    max_keeper_energy = 1000
  }
  if mockData.roleHp then
    battleData.copyProperties.hp = mockData.roleHp
    battleData.copyProperties.max_hp = mockData.roleHp
    battleData.roleHp = mockData.roleHp
  end
  local relics = {}
  local uid = 1
  for _, tid in ipairs(mockData.Relics or {}) do
    local relic = {
      uid = uid,
      tid = tid,
      stateUids = {}
    }
    table.insert(relics, relic)
    uid = uid + 1
  end
  battleData.relics = relics
  battleData.keeperSkill = mockData.keeperSkill
  battleData.gameplayType = bc.BattleGameplayType.PVE
  battleData.gender = mockData.gender
  battleData.selectedKeeperSkill = {}
  local unlockedKeeperSkillItems = {}
  for _, cfg in pairs(DT.Item) do
    if cfg.Type == "KeeperSkill" then
      table.insert(unlockedKeeperSkillItems, cfg.ID)
    end
  end
  battleData.unlockedKeeperSkillItems = unlockedKeeperSkillItems
  return battleData
end

return BattleMockDataUtil
