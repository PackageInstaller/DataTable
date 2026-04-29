_class("BuffViewChangeFeatureStepPoint", BuffViewBase)
BuffViewChangeFeatureStepPoint = BuffViewChangeFeatureStepPoint

function BuffViewChangeFeatureStepPoint:IsNotifyMatch(notify)
  return true
end

function BuffViewChangeFeatureStepPoint:PlayView(TT)
  local result = self._buffResult
  local featureSvcRender = self._world:GetService("FeatureRender")
  if featureSvcRender then
    featureSvcRender:NotifyStepPointChange(result:GetCurCount(), result:GetOldCount())
  end
end

_class("BuffViewChangeFeatureMaxStepPoint", BuffViewBase)
BuffViewChangeFeatureMaxStepPoint = BuffViewChangeFeatureMaxStepPoint

function BuffViewChangeFeatureMaxStepPoint:IsNotifyMatch(notify)
  return true
end

function BuffViewChangeFeatureMaxStepPoint:PlayView(TT)
  local result = self._buffResult
  local featureSvcRender = self._world:GetService("FeatureRender")
  if featureSvcRender then
    featureSvcRender:NotifyMaxStepPointChange(result:GetCurCount(), result:GetOldCount())
  end
end

_class("BuffViewChangeFeatureRecoverStepPoint", BuffViewBase)
BuffViewChangeFeatureRecoverStepPoint = BuffViewChangeFeatureRecoverStepPoint

function BuffViewChangeFeatureRecoverStepPoint:IsNotifyMatch(notify)
  return true
end

function BuffViewChangeFeatureRecoverStepPoint:PlayView(TT)
  local result = self._buffResult
  local featureSvcRender = self._world:GetService("FeatureRender")
  if featureSvcRender then
    featureSvcRender:NotifyRecoverStepPointChange(result:GetCurCount(), result:GetOldCount())
  end
end

_class("BuffViewChangeFeatureRecoverStepPointForLinkUI", BuffViewBase)
BuffViewChangeFeatureRecoverStepPointForLinkUI = BuffViewChangeFeatureRecoverStepPointForLinkUI

function BuffViewChangeFeatureRecoverStepPointForLinkUI:IsNotifyMatch(notify)
  return true
end

function BuffViewChangeFeatureRecoverStepPointForLinkUI:PlayView(TT)
  local result = self._buffResult
  local featureSvcRender = self._world:GetService("FeatureRender")
  if featureSvcRender then
    local flagID = result:GetFlagID()
    local isRevert = result:GetIsRevert()
    if isRevert and isRevert == 1 then
      featureSvcRender:RemoveExtraRecoverStepPointForLinkUI(flagID)
    else
      featureSvcRender:AddExtraRecoverStepPointForLinkUI(flagID, result:GetStepMin(), result:GetStepMax(), result:GetModifyValue())
    end
  end
end
