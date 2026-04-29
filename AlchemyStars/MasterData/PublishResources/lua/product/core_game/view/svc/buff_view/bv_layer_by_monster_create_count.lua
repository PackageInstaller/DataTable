_class("BuffViewAddLayerByMonsterCreateCount", BuffViewBase)
BuffViewAddLayerByMonsterCreateCount = BuffViewAddLayerByMonsterCreateCount

function BuffViewAddLayerByMonsterCreateCount:PlayView(TT, notify, trace)
  local res = self._buffResult
  local curLayer = res:GetLayer()
  local buffseq = res:GetBuffSeq()
  local addLayer = res:GetAddLayer()
  local buffView = self._entity:BuffView()
  local viewInstance = buffView:GetBuffViewInstance(buffseq)
  if not viewInstance then
    Log.error("BuffViewAddLayerByMonsterCreateCount not find viewInstance! entity=", self._entity:GetID(), " layer=", curLayer)
    return
  end
  Log.debug("BuffViewAddLayerByMonsterCreateCount entity=", self._entity:GetID(), " layer=", curLayer)
  local casterEntity = self:BuffViewInstance():GetBuffViewContext() and self:BuffViewInstance():GetBuffViewContext().casterEntity or nil
  viewInstance:SetLayerCount(TT, curLayer, res.totalLayerCount, casterEntity)
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
  if res:IsDontDisplay() then
    return
  end
  local buffEffectEntityID = viewInstance:GetBuffEffectEntityID()
  local effectAnimList = viewInstance:GetBuffEffectLayerAnimList()
  local buffEffectEntity = self._world:GetEntityByID(buffEffectEntityID)
  if effectAnimList and buffEffectEntity then
    local effectGameObj = buffEffectEntity:View().ViewWrapper.GameObject
    local anim = effectGameObj:GetComponentInChildren(typeof(UnityEngine.Animation))
    if anim then
      Log.info("CurLayer ", curLayer, " totalLayer ", res.totalLayerCount)
      local animName = effectAnimList[curLayer]
      Log.info(" CurAnim ", animName)
      anim:Play(animName)
    else
      Log.fatal("Can not find view layer animation cmpt")
    end
  end
end
