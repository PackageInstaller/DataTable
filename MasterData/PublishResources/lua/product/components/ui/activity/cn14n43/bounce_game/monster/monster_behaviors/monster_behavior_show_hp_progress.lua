require("monster_behavior_base")
_class("MonsterBeHaviorShowHpProgress", MonsterBeHaviorBase)
MonsterBeHaviorShowHpProgress = MonsterBeHaviorShowHpProgress

function MonsterBeHaviorShowHpProgress:Name()
  return "MonsterBeHaviorShowHpProgress"
end

function MonsterBeHaviorShowHpProgress:SetProgress(hp)
  local bounceController = self:GetCoreController()
  bounceController:HPProgressChange(self.monster:GetPstId(), hp, self.monster.monsterData.initHp)
end

function MonsterBeHaviorShowHpProgress:OnInit(param)
end

function MonsterBeHaviorShowHpProgress:OnShow()
  local bounceController = self:GetCoreController()
  bounceController:ShowHPProgress(self.monster:GetPstId(), self.monster.monsterData.initHp)
end

function MonsterBeHaviorShowHpProgress:OnReset()
  local bounceController = self:GetCoreController()
  bounceController:HideHPProgress(self.monster:GetPstId())
end

function MonsterBeHaviorShowHpProgress:OnRelease()
end
