local this = class("cellChallenge", G_UIModuleBase)

function this.bind()
  return {
    txt_content = nil,
    color_txtContent = nil,
    selectId_statusIcon = nil
  }
end

function this.methods()
  return {}
end

function this:open()
  self:playShowVFX()
  self._playingOut = false
end

function this:close()
  L_TimerManager:clearTimer(self)
end

function this:refreshView(params)
  self:playVFX(self.bind.state, params.state)
  table.merge(self.bind, params)
end

function this:playVFX(lastState, curState)
  if not self.isBind then
    return
  end
  if lastState == curState then
    return
  end
  if self.bind.type == C_EChallengeType.TimeLimited then
    if curState == C_EChallengeState.Success then
      self.bindComponents.ani_cellChallenge:Stop()
      self.bindComponents.ani_cellChallenge:Play("anim_challenge_chanllengeContent_cell_complete")
    elseif curState == C_EChallengeState.Fail then
      self.bindComponents.ani_cellChallenge:Stop()
      self.bindComponents.ani_cellChallenge:Play("anim_challenge_chanllengeContent_cell_fail")
    end
  elseif self.bind.type == C_EChallengeType.Temporary then
    if curState == C_EChallengeState.Success then
      self.bindComponents.ani_cellChallenge:Stop()
      self.bindComponents.ani_cellChallenge:Play("anim_challenge_chanllengeContent_cell_running_complete")
      self._playingOut = true
      L_TimerManager:newOrResetTimer(self, "VFX_success", function()
        self._playingOut = false
        if self.bind.delayRefreshCallback then
          self.bind.delayRefreshCallback()
        end
      end, 1.833)
    elseif curState == C_EChallengeState.Fail then
      self.bindComponents.ani_cellChallenge:Stop()
      self.bindComponents.ani_cellChallenge:Play("anim_challenge_chanllengeContent_cell_running_fail")
      L_TimerManager:newOrResetTimer(self, "VFX_success", function()
        self._playingOut = false
        if self.bind.delayRefreshCallback then
          self.bind.delayRefreshCallback()
        end
      end, 1.5)
    end
  end
end

function this:playShowVFX()
  if not self.isBind then
    return
  end
  if self.bind.type == C_EChallengeType.Temporary and self.bind.needShowInVFX then
    self.bindComponents.ani_cellChallenge:Stop()
    self.bindComponents.ani_cellChallenge:Play("anim_challenge_chanllengeContent_cell_running_show")
  end
end

return this
