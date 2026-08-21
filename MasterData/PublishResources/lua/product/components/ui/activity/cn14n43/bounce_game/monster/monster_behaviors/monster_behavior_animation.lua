require("monster_behavior_base")
_class("MonsterBeHaviorAnimation", MonsterBeHaviorBase)
MonsterBeHaviorAnimation = MonsterBeHaviorAnimation

function MonsterBeHaviorAnimation:Constructor()
  self._animator = nil
end

function MonsterBeHaviorAnimation:Name()
  return "MonsterBeHaviorAnimation"
end

function MonsterBeHaviorAnimation:GetAnimation()
  if self._animator then
    return self._animator
  end
  local view = self.monster:GetBehavior("MonsterBeHaviorView")
  if view == nil then
    return nil
  end
  local go = view:GetGameObject()
  if not go then
    return nil
  end
  self._animator = go:GetComponent("Animator")
  return self._animator
end

function MonsterBeHaviorAnimation:PlayAnimation(animName)
  local animator = self:GetAnimation()
  if animator then
    animator:Play(animName)
  end
end

function MonsterBeHaviorAnimation:OnInit(param)
end

function MonsterBeHaviorAnimation:OnShow()
end

function MonsterBeHaviorAnimation:OnReset()
end

function MonsterBeHaviorAnimation:OnRelease()
  self._animator = nil
end
