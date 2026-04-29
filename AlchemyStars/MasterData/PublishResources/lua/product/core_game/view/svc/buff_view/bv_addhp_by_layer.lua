_class("BuffViewAddHPByLayer", BuffViewBase)
BuffViewAddHPByLayer = BuffViewAddHPByLayer

function BuffViewAddHPByLayer:Constructor()
end

function BuffViewAddHPByLayer:IsNotifyMatch(notify)
  local result = self._buffResult
  local n = notify
  if notify:GetLayerName() ~= result:GetLayerName() then
    return false
  end
  if result:GetLayerTotalCount() ~= n:GetTotalCount() then
    return false
  end
  return true
end

function BuffViewAddHPByLayer:PlayView(TT)
  local res = self._buffResult
  local damageInfo = res:GetDamageInfo()
  local entity = self._world:GetEntityByID(res:GetEntityID())
  local curLayer = res:GetLayer()
  local buffseq = res:GetBuffSeq()
  local buffView = self._entity:BuffView()
  local viewInstance = buffView:GetBuffViewInstance(buffseq)
  if not viewInstance then
    Log.error("BuffViewAddHPByLayer not find viewInstance! entity=", self._entity:GetID(), " layer=", curLayer)
    return
  end
  Log.debug("BuffViewAddHPByLayer entity=", self._entity:GetID(), " layer=", curLayer)
  local casterEntity = self:BuffViewInstance():GetBuffViewContext() and self:BuffViewInstance():GetBuffViewContext().casterEntity or nil
  viewInstance:SetLayerCount(TT, curLayer, res.totalLayerCount, casterEntity)
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
  if self._entity:HasPetPstID() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, self._entity:PetPstID():GetPstID(), curLayer)
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
  local buffConfigData = viewInstance:BuffConfigData()
  local viewParams = buffConfigData:GetViewParams() or {}
  if viewParams.IsHPEnergy then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateHPEnergy, self._entity:GetID(), curLayer)
  end
  YIELD(TT)
  local materialAnimationComponent = entity:MaterialAnimationComponent()
  if materialAnimationComponent then
    materialAnimationComponent:PlayCure()
  end
  local playDamageService = self._world:GetService("PlayDamage")
  playDamageService:AsyncUpdateHPAndDisplayDamage(entity, damageInfo)
end
