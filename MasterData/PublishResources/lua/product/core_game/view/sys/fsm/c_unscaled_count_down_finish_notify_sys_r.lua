require("unscaled_count_down_finish_notify_system")
_class("ClientUnscaledCountDownFinishNotifySystem_Render", UnscaledCountDownFinishNotifySystem)
ClientUnscaledCountDownFinishNotifySystem_Render = ClientUnscaledCountDownFinishNotifySystem_Render

function ClientUnscaledCountDownFinishNotifySystem_Render:_DoRenderNotifyCountDownFinish(TT)
  local group = self._world:GetGroup(self._world.BW_WEMatchers.UnscaledCountDownRender)
  for i, e in ipairs(group:GetEntities()) do
    local cmpt = e:UnscaledCountDownRender()
    if cmpt:GetWaitPlayNotify() then
      local flagID = cmpt:GetFlagID()
      self:_PlayNotify(TT, flagID)
      cmpt:SetWaitPlayNotify(false)
      break
    end
  end
end

function ClientUnscaledCountDownFinishNotifySystem_Render:_PlayNotify(TT, flagID)
  local notify = NTClientUnscaledCountDownFinish:New(flagID)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, notify)
end
