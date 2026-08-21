_class("MonsterDeadParam", Object)
MonsterDeadParam = MonsterDeadParam

function MonsterDeadParam:Constructor(monsterID, deadWave, deadRound)
  self._monsterID = monsterID
  self._deadWave = deadWave
  self._deadRound = deadRound
end

function MonsterDeadParam:GetMonsterID()
  return self._monsterID
end

function MonsterDeadParam:GetDeadWave()
  return self._deadWave
end

function MonsterDeadParam:GetDeadRound()
  return self._deadRound
end
