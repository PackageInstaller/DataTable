local BuffLogicChangeFeatureCoinCountType = {Value = 1, Bonus = 2}
_enum("BuffLogicChangeFeatureCoinCountType", BuffLogicChangeFeatureCoinCountType)
_class("BuffLogicChangeFeatureCoinCount", BuffLogicBase)
BuffLogicChangeFeatureCoinCount = BuffLogicChangeFeatureCoinCount

function BuffLogicChangeFeatureCoinCount:Constructor(buffInstance, logicParam)
  self._modifyValue = logicParam.modifyValue or 0
  self._modifyType = logicParam.modifyType or 1
end

function BuffLogicChangeFeatureCoinCount:DoLogic(notify)
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if not lsvcFeature:HasFeatureType(FeatureType.Shop) then
    return
  end
  local modifyValue = self._modifyValue
  if self._modifyType == BuffLogicChangeFeatureCoinCountType.Value then
    modifyValue = self._modifyValue
  elseif self._modifyType == BuffLogicChangeFeatureCoinCountType.Bonus then
    local baseParam = self._modifyValue
    local curCoin = lsvcFeature:GetShopCoinCount()
    if baseParam <= 0 then
      return
    end
    modifyValue = math.floor(curCoin / baseParam)
  end
  local oldCount = lsvcFeature:GetShopCoinCount()
  lsvcFeature:AddShopCoinCount(modifyValue)
  local curCount = lsvcFeature:GetShopCoinCount()
  local buffResult = BuffResultChangeFeatureCoinCount:New(curCount, oldCount, modifyValue)
  if notify then
    if notify:GetNotifyType() == NotifyType.PlayerEachMoveStart or notify:GetNotifyType() == NotifyType.PlayerEachMoveEnd or notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
      buffResult:SetMovePos(notify:GetPos())
    end
    if notify:GetNotifyType() == NotifyType.TrapSkillStart then
      buffResult:SetMovePos(notify:GetPos())
    end
  end
  local ntCoinCountChange = NTFeatureShopCoinCountChange:New(curCount, oldCount)
  self._world:GetService("Trigger"):Notify(ntCoinCountChange)
  return buffResult
end

function BuffLogicChangeFeatureCoinCount:DoOverlap()
  return self:DoLogic()
end
