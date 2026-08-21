_class("MonsterDropConfigData", Object)
MonsterDropConfigData = MonsterDropConfigData

function MonsterDropConfigData:Constructor()
end

function MonsterDropConfigData:GetMonsterDropItemID(dropID)
  local monsterDropConfig = Cfg.cfg_monster_drop[dropID]
  return monsterDropConfig.DropItem
end

function MonsterDropConfigData:GetMonsterDropMinCount(dropID)
  local monsterDropConfig = Cfg.cfg_monster_drop[dropID]
  return monsterDropConfig.MinCount
end

function MonsterDropConfigData:GetMonsterDropMaxCount(dropID)
  local monsterDropConfig = Cfg.cfg_monster_drop[dropID]
  return monsterDropConfig.MaxCount
end

function MonsterDropConfigData:GetMonsterDropProbability(dropID)
  local monsterDropConfig = Cfg.cfg_monster_drop[dropID]
  return monsterDropConfig.Probability
end
