require("monster_behavior_base")
_class("MonsterBeHaviorTransformationWithHp", MonsterBeHaviorBase)
MonsterBeHaviorTransformationWithHp = MonsterBeHaviorTransformationWithHp

function MonsterBeHaviorTransformationWithHp:Constructor()
  self._sharps = nil
end

function MonsterBeHaviorTransformationWithHp:Name()
  return "MonsterBeHaviorTransformationWithHp"
end

function MonsterBeHaviorTransformationWithHp:FindSharpIdByHp(hp)
  if self._sharps == nil then
    return
  end
  local sharpId
  for i = 1, #self._sharps do
    local sharpHp = self._sharps[i].HP
    if hp <= sharpHp then
      sharpId = self._sharps[i].ResId
      break
    end
  end
  return sharpId
end

function MonsterBeHaviorTransformationWithHp:CheckTransformation(hp)
  local sharpId = self:FindSharpIdByHp(hp)
  if not sharpId then
    return
  end
  local view = self:GetBehavior("MonsterBeHaviorView")
  if not view then
    return
  end
  local animation = self:GetBehavior("MonsterBeHaviorAnimation")
  if animation then
    animation:PlayAnimation(BounceConst.MonsterBeAttackedAniName)
  end
  self.monster:SetTransformation(view:GetAttackedLength(), function()
    view:ChgRes(sharpId)
  end)
end

function MonsterBeHaviorTransformationWithHp:ChgResImmediatelyBy(hp)
  local sharpId = self:FindSharpIdByHp(hp)
  if not sharpId then
    return
  end
  local view = self:GetBehavior("MonsterBeHaviorView")
  if not view then
    return
  end
  view:ChgRes(sharpId)
end

function MonsterBeHaviorTransformationWithHp:OnInit(param)
  self._sharps = param.Sharps
end

function MonsterBeHaviorTransformationWithHp:OnShow()
end

function MonsterBeHaviorTransformationWithHp:OnReset()
end

function MonsterBeHaviorTransformationWithHp:OnRelease()
  self._sharps = nil
end
