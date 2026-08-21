_class("LLMonsterConfigData", Object)
LLMonsterConfigData = LLMonsterConfigData

function LLMonsterConfigData:Constructor(monsterID)
  self._cfg = Cfg.cfg_luckland_client_enemy[monsterID]
  if not self._cfg then
    Log.fatal("LLMonsterConfigData not find monsterID:", monsterID)
  end
end

function LLMonsterConfigData:GetMonsterID()
  return self._cfg.ID
end

function LLMonsterConfigData:GetMonsterHPBase()
  return self._cfg.EnemyHp
end

function LLMonsterConfigData:GetMonsterHPHardRate()
  return self._cfg.HPHardRate
end

function LLMonsterConfigData:GetMonsterAtkBase()
  return self._cfg.EnemyAtk
end

function LLMonsterConfigData:GetMonsterAtkHardRate()
  return self._cfg.AtkHardRate
end

function LLMonsterConfigData:GetBuffIDList()
  return self._cfg.BuffIDList
end

function LLMonsterConfigData:GetCountDown()
  return self._cfg.EnemyLifeCount
end
