local Animator = CS.UnityEngine.Animator
local RespawnPanel, Super = System.NewComponent("RespawnPanel")

function RespawnPanel:ctor(uiNode, isRespawning)
  Super.ctor(self)
  self.ui = UI_Level_Panel_RespawnResource(uiNode)
end

function RespawnPanel:OnBind(binder)
  self.binder = binder
  binder:BindEvent(EventMgr.Instance.LostLifeAudio, function(data)
    self:UpdateAudio(data)
  end)
  binder:BindToText(self.ui.Text4, function()
    do return LT.Text end
    return LT.Text, "Revive_Tips"
  end)
end

function RespawnPanel:Respawn(isRespawning, callback)
  AudioManager.Instance:PostSoundEvent("Play_UI_Lost_Life")
  if not isRespawning then
    self.ui.Start:SetActive(false)
    self.ui.Loop:SetActive(true)
    if callback then
      callback()
    end
  else
    self.ui.Start:SetActive(true)
    self.ui.Loop:SetActive(false)
    local behavior = self.ui.Start:GetComponent(typeof(Animator)):GetAnimatorStateBehavior()
    AnimatorUtils.SetBehaviorOnStateEnd(behavior, function()
      self.ui.Start:SetActive(false)
      self.ui.Loop:SetActive(true)
      if callback then
        callback()
      end
    end)
  end
end

function RespawnPanel:OnUnbind()
  AudioManager.Instance:PostSoundEvent("Stop_UI_Lost_Life")
end

function RespawnPanel:UpdateAudio(data)
  Logger.Info("RespawnPanel:", table.tostring(data))
  if data.play then
    AudioManager.Instance:PostSoundEvent("Play_UI_Lost_Life")
  else
    AudioManager.Instance:PostSoundEvent("Stop_UI_Lost_Life")
  end
end

return RespawnPanel
