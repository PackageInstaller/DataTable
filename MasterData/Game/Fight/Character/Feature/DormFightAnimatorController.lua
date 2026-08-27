local DormFightCharacterFeatureBase = require("Game.Fight.Character.Feature.DormFightCharacterFeatureBase")
local WalkAnimationName = "party_walk"
local IdleAnimationName = "party_stand"
local AttackAnimationNames = {
  "party_attack1",
  "party_attack2"
}
local RunAnimationName = "party_run"
local ReviveAnimationName = "party_revive"
local DormFightAnimatorController = class("DormFightAnimatorController", DormFightCharacterFeatureBase)

function DormFightAnimatorController:ctor()
  self._animator = nil
end

function DormFightAnimatorController:OnInit()
  self._animator = self._owner.animator
end

function DormFightAnimatorController:PlayWalkAnimation()
  if IsNull(self._animator) then
    return
  end
  self._animator:Play(WalkAnimationName)
end

function DormFightAnimatorController:PlayRunAnimation()
  if IsNull(self._animator) then
    return
  end
  self._animator:Play(RunAnimationName)
end

function DormFightAnimatorController:PlayReviveAnimation()
  if IsNull(self._animator) then
    return
  end
  self._animator:Play(ReviveAnimationName)
end

function DormFightAnimatorController:PlayIdleAnimation()
  if IsNull(self._animator) then
    return
  end
  self._animator:Play(IdleAnimationName)
end

function DormFightAnimatorController:PlayAttackAnimation()
  if IsNull(self._animator) then
    return
  end
  local animationName = AttackAnimationNames[math.random(#AttackAnimationNames)]
  self._animator:Play(animationName, 0, 0.0)
end

function DormFightAnimatorController:SetEnabled(enabled)
  if IsNull(self._animator) then
    return
  end
  self._animator.enabled = enabled
end

return DormFightAnimatorController
