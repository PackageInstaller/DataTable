require("behavior_base")
_class("MonsterBeHaviorBase", BeHaviorBase)
MonsterBeHaviorBase = MonsterBeHaviorBase

function MonsterBeHaviorBase:SetMonster(monster)
  self.monster = monster
end

function MonsterBeHaviorBase:GetMonster()
  return self.monster
end

function MonsterBeHaviorBase:GetMonsterData()
  return self.monster:GetMonsterData()
end

function MonsterBeHaviorBase:GetCfg()
  local monsterCfg = self:GetMonsterData().cfg
  return monsterCfg
end

function MonsterBeHaviorBase:GetBehavior(behaviorName)
  return self.monster:GetBehavior(behaviorName)
end

function MonsterBeHaviorBase:GetCoreController()
  return self.monster:GetCoreController()
end

function MonsterBeHaviorBase:GetBounceData()
  return self.monster:GetCoreController():GetData()
end

function MonsterBeHaviorBase:Exec()
end

function MonsterBeHaviorBase:ExecAsync(TT, finishCall)
  if finishCall then
    finishCall()
  end
end

function MonsterBeHaviorBase:Init(param)
  self:OnInit(param)
end

function MonsterBeHaviorBase:Show()
  self:OnShow()
end

function MonsterBeHaviorBase:Reset()
  self:OnReset()
end

function MonsterBeHaviorBase:Release()
  self:OnRelease()
end

function MonsterBeHaviorBase:OnShow()
end

function MonsterBeHaviorBase:OnInit(param)
end

function MonsterBeHaviorBase:OnReset()
end

function MonsterBeHaviorBase:OnRelease()
end
