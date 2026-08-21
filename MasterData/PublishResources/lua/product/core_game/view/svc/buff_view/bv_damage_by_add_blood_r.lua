require("_buff_view_base_r")
_class("BuffViewDamageByAddBlood", BuffViewBase)
BuffViewDamageByAddBlood = BuffViewDamageByAddBlood

function BuffViewDamageByAddBlood:PlayView(TT)
  local viewParams = self._viewInstance:BuffConfigData():GetViewParams()
  local playBuffSvc = self._world:GetService("PlayBuff")
  local effectService = self._world:GetService("Effect")
  local taskID = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    if viewParams and viewParams.playDelay then
      YIELD(TT, viewParams.playDelay)
    end
    playBuffSvc:PlayDamageBuff(TT, self)
    if viewParams and viewParams.damageEffectID then
      effectService:CreateEffect(viewParams.damageEffectID, self._entity)
    end
    if viewParams and viewParams.audioID then
      AudioHelperController.PlayInnerGameSfx(viewParams.audioID)
    end
    if viewParams and viewParams.finishDelay then
      YIELD(TT, viewParams.finishDelay)
    end
  end)
  while not TaskHelper:GetInstance():IsTaskFinished(taskID) do
    YIELD(TT)
  end
end
