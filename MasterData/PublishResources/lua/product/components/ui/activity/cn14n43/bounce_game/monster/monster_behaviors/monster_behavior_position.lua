require("monster_behavior_base")
_class("MonsterBeHaviorPosition", MonsterBeHaviorBase)
MonsterBeHaviorPosition = MonsterBeHaviorPosition

function MonsterBeHaviorPosition:Name()
  return "MonsterBeHaviorPosition"
end

function MonsterBeHaviorPosition:SetData(initPosition)
  self._initPosition = Vector2:New()
  self._initPosition.x = initPosition[1]
  self._initPosition.y = initPosition[2]
  self:SetPosition(self._initPosition)
end

function MonsterBeHaviorPosition:GetPosition()
  return self._curPostion
end

function MonsterBeHaviorPosition:SetPosition(poistion)
  self._curPostion = poistion
  self:GetBehavior(MonsterBeHaviorView:Name()):SetPosition(poistion)
end

function MonsterBeHaviorPosition:ResetPosition()
  self:SetPosition(self._curPostion)
end

function MonsterBeHaviorPosition:OnInit(param)
end

function MonsterBeHaviorPosition:OnShow()
end

function MonsterBeHaviorPosition:OnReset()
end

function MonsterBeHaviorPosition:OnRelease()
end
