require("monster_behavior_base")
_class("MonsterBeHaviorAttack", MonsterBeHaviorBase)
MonsterBeHaviorAttack = MonsterBeHaviorAttack

function MonsterBeHaviorAttack:Name()
  return "MonsterBeHaviorAttack"
end

function MonsterBeHaviorAttack:OnInit(param)
  self.attack = param.Attack
end

function MonsterBeHaviorAttack:Exec()
  local behaviorDestory = self:GetBehavior(MonsterBeHaviorDestroyAfterAttack:Name())
  if behaviorDestory then
    behaviorDestory:Exec()
  end
end

function MonsterBeHaviorAttack:OnShow()
end

function MonsterBeHaviorAttack:OnReset()
end

function MonsterBeHaviorAttack:OnRelease()
end
