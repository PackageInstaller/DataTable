_class("HomelandPetComponentPlayAnimation", HomelandPetComponentBase)
HomelandPetComponentPlayAnimation = HomelandPetComponentPlayAnimation

function HomelandPetComponentPlayAnimation:Constructor(componentType, pet, behavior)
  HomelandPetComponentPlayAnimation.super.Constructor(self, componentType, pet, behavior)
  self._animation = self._pet:GetAnimation()
  self._animationName = nil
  self._fadeLength = 0.3
end

function HomelandPetComponentPlayAnimation:ReLoadPetComponent()
  self._animation = self._pet:GetAnimation()
end

function HomelandPetComponentPlayAnimation:OnExcute()
  if self.state == HomelandPetComponentState.Resting then
    if not self._animationName then
      return
    end
    if not self._animation or self._animation == null then
      self._animation = self._pet:GetAnimation()
    end
    if self._animation then
      self._animation:CrossFade(self._animationName, self._fadeLength)
    end
    self.state = HomelandPetComponentState.Success
  end
end

function HomelandPetComponentPlayAnimation:Play(animationName)
  self._animationName = animationName
end

function HomelandPetComponentPlayAnimation:PlayStand()
  if self._pet:GetMotionType() == HomelandPetMotionType.Swim then
    self._animationName = HomelandPetAnimName.Float
  else
    self._animationName = HomelandPetAnimName.Stand
  end
end

function HomelandPetComponentPlayAnimation:Exit()
  HomelandPetComponentPlayAnimation.super.Exit(self)
  self._animationName = nil
end
