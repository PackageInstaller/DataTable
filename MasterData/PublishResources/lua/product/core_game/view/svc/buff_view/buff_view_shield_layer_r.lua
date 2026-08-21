_class("BuffViewAddLayerShield", BuffViewBase)
BuffViewAddLayerShield = BuffViewAddLayerShield

function BuffViewAddLayerShield:PlayView(TT)
  local layer = self._buffResult:GetLayer()
  self._viewInstance:SetLayerCount(TT, layer)
  Log.debug("View_AddLayerShield ", "entityID=", self._entity:GetID(), " layerCount=", layer)
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    YIELD(TT)
    self._entity:PlayMaterialAnim("common_shield")
  end)
end

_class("BuffViewRemoveLayerShield", BuffViewBase)
BuffViewRemoveLayerShield = BuffViewRemoveLayerShield

function BuffViewRemoveLayerShield:PlayView(TT)
  local layer = self._buffResult:GetLayer()
  self._viewInstance:SetLayerCount(TT, layer)
  self._entity:PlayMaterialAnim("common_shieldactive")
  Log.debug("View_RemoveLayerShield ", "entityID=", self._entity:GetID(), " layerCount=", layer)
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
  if layer == 0 then
    self._viewInstance:SetUnload()
    local e = self._viewInstance:Entity()
    local effectService = self._world:GetService("Effect")
    local effectList = {}
    table.insert(effectList, BattleConst.AircraftHoldShieldEffect)
    effectService:DestroyEntityEffectByID(e, effectList)
    local playBuffSvc = self._world:GetService("PlayBuff")
    playBuffSvc:DetachBuffEffect(self._viewInstance)
  end
end

function BuffViewRemoveLayerShield:IsNotifyMatch(notify)
  if not notify.GetNotifyLayer then
    return true
  end
  return notify:GetNotifyLayer() == self._buffResult:GetLayer() and notify:GetNotifyEntity() == self._viewInstance:Entity()
end
