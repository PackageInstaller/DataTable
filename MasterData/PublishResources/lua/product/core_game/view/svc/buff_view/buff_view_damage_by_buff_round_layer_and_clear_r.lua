_class("BuffViewDamageByBuffRoundLayerAndClear", BuffViewBase)
BuffViewDamageByBuffRoundLayerAndClear = BuffViewDamageByBuffRoundLayerAndClear

function BuffViewDamageByBuffRoundLayerAndClear:PlayView(TT)
  local result = self._buffResult
  local targetBuffSeq = result:GetTargetBuffSeq()
  local playBuffSvc = self._world:GetService("PlayBuff")
  local buffView = self._entity:BuffView()
  for _, value in ipairs(targetBuffSeq) do
    local viewInstance = buffView:GetBuffViewInstance(value)
    if viewInstance then
      viewInstance:SetUnload()
      playBuffSvc:PlayRemoveBuff(TT, viewInstance, NTBuffUnload:New())
    end
  end
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
  local viewParams = self._viewInstance:BuffConfigData():GetViewParams()
  local playBuffSvc = self._world:GetService("PlayBuff")
  local effectService = self._world:GetService("Effect")
  local taskIDList = {}
  local taskID = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    YIELD(TT, viewParams.playDelay)
    playBuffSvc:PlayDamageBuff(TT, self)
    local effect = effectService:CreateEffect(viewParams.damageEffectID, self._entity)
    local audioID = viewParams.audioID
    if audioID then
      AudioHelperController.PlayInnerGameSfx(audioID)
    end
    YIELD(TT, viewParams.finishDelay)
  end)
  table.insert(taskIDList, taskID)
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function BuffViewDamageByBuffRoundLayerAndClear:IsNotifyMatch(notify)
  local result = self._buffResult
  return true
end
