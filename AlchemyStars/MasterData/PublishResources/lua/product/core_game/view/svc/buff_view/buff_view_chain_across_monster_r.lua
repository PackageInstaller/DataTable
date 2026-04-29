_class("BuffViewChainAcrossMonster", BuffViewBase)
BuffViewChainAcrossMonster = BuffViewChainAcrossMonster

function BuffViewChainAcrossMonster:PlayView(TT, notify)
  local result = self._buffResult
  local show = result:GetShow()
  local gridPos = result:GetPos()
  local entity = notify:GetNotifyEntity()
  local viewParams = self._viewInstance:BuffConfigData():GetViewParams()
  local moveEffectList = viewParams.moveEffect
  local moveEffectID = moveEffectList[2]
  local gridEffectID
  local effectHolderCmpt = entity:EffectHolder()
  if not effectHolderCmpt then
    entity:AddEffectHolder()
    effectHolderCmpt = entity:EffectHolder()
  end
  local gameObject = entity:View().ViewWrapper.GameObject
  local rootGO = gameObject.transform:Find("Root")
  rootGO.gameObject:SetActive(show)
  local effectService = self._world:GetService("Effect")
  if show then
    gridEffectID = moveEffectList[3]
    local effect
    local effectEntityIdList = effectHolderCmpt:GetEffectIDEntityDic()[moveEffectID]
    if effectEntityIdList then
      effect = self._world:GetEntityByID(effectEntityIdList[1])
    end
    if effect then
      self._world:DestroyEntity(effect)
      effectHolderCmpt:GetEffectIDEntityDic()[moveEffectID][1] = nil
    end
  else
    gridEffectID = moveEffectList[1]
    local effect = effectService:CreateEffect(moveEffectID, entity)
    effectHolderCmpt:AttachPermanentEffect(effect:GetID())
  end
  if gridEffectID then
    effectService:CreateWorldPositionEffect(gridEffectID, gridPos, true)
  end
end

function BuffViewChainAcrossMonster:IsNotifyMatch(notify)
  local notifyType = notify:GetNotifyType()
  if notifyType ~= NotifyType.PlayerEachMoveStart and notifyType ~= NotifyType.PlayerEachMoveEnd then
    return false
  end
  local result = self._buffResult
  local resultNotifyType = result:GetNotifyType()
  local resultChainIndex = result:GetChainIndex()
  local resultEntityID = result:GetEntityID()
  if resultEntityID ~= notify:GetNotifyEntity():GetID() then
    return false
  end
  if resultNotifyType ~= notifyType then
    return false
  end
  if resultChainIndex ~= notify:GetChainIndex() then
    return false
  end
  return true
end
