_class("BouncePlayerBeHaviorBase", BeHaviorBase)
BouncePlayerBeHaviorBase = BouncePlayerBeHaviorBase

function BouncePlayerBeHaviorBase:SetPlayer(player)
  self.player = player
end

function BouncePlayerBeHaviorBase:GetBehavior(behaviorName)
  return self.player:GetBehavior(behaviorName)
end

function BouncePlayerBeHaviorBase:Release()
  self:OnRelease()
end

function BouncePlayerBeHaviorBase:OnRelease()
end
