_class("LLEntityMonster", LuckLandEntity)
LLEntityMonster = LLEntityMonster

function LLEntityMonster:InitData(templateID)
  self._entityType = LuckLandEntityType.Monster
  local cfgData = self._configMng:GetMonsterConfigData(templateID)
  self._cfg = cfgData
  local levelCfgData = self._configMng:GetLevelConfigData()
  local roundHardRate = 1
  self._resType = LuckLandCardResType.Attack
  local baseAtk = cfgData:GetMonsterAtkBase()
  local atkHardRate = cfgData:GetMonsterAtkHardRate()
  self._resBase = baseAtk + atkHardRate * roundHardRate
  local baseHP = cfgData:GetMonsterHPBase()
  local hpHardRate = cfgData:GetMonsterHPHardRate()
  self._maxHP = baseHP + hpHardRate * roundHardRate
  self._curHP = self._maxHP
  self._countDown = cfgData:GetCountDown()
end

function LLEntityMonster:SetDemandRound(round)
  self._demandRound = round
end

function LLEntityMonster:GetDemandRound()
  return self._demandRound
end

function LLEntityMonster:DecreaseDemandRound()
  self._demandRound = self._demandRound - 1
end

function LLEntityMonster:SetDemandMoney(money)
  self._demandMoney = money
end

function LLEntityMonster:GetDemandMoney()
  return self._demandMoney
end

function LLEntityMonster:DecreaseDemandMoney(money)
  self._demandMoney = self._demandMoney - money
end

function LLEntityMonster:SetEntryRound(roundCount)
  self._entryRound = roundCount
end

function LLEntityMonster:SetDead(isDead)
  self._isDead = isDead
end

function LLEntityMonster:IsDead()
  return self._isDead
end

function LLEntityMonster:AddCountDownNum(addVal)
  if addVal == nil then
    return
  end
  self._countDown = self._countDown + addVal
end

function LLEntityMonster:SetCurHP(curHP)
  self._curHP = curHP
end

function LLEntityMonster:MaxHp()
  return self._maxHP
end

function LLEntityMonster:GetCurHP()
  return self._curHP
end

function LLEntityMonster:AddHP(add)
  if self._curHP + add > self._maxHP then
    self._curHP = self._maxHP
  else
    self._curHP = self._curHP + add
  end
end

function LLEntityMonster:GetEnemyAtk()
  return self:CalculateRes()
end
