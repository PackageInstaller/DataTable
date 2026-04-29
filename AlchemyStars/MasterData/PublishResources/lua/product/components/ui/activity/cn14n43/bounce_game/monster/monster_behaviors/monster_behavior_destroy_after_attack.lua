require("monster_behavior_base")
_class("MonsterBeHaviorDestroyAfterAttack", MonsterBeHaviorBase)
MonsterBeHaviorDestroyAfterAttack = MonsterBeHaviorDestroyAfterAttack

function MonsterBeHaviorDestroyAfterAttack:Name()
  return "MonsterBeHaviorDestroyAfterAttack"
end

function MonsterBeHaviorDestroyAfterAttack:Exec()
  self.monster:SetDeadWithDuration(0)
end

function MonsterBeHaviorDestroyAfterAttack:OnInit(param)
end

function MonsterBeHaviorDestroyAfterAttack:OnShow()
end

function MonsterBeHaviorDestroyAfterAttack:OnReset()
end

function MonsterBeHaviorDestroyAfterAttack:OnRelease()
end
