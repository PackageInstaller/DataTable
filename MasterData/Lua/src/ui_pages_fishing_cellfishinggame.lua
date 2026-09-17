local this = class("cellFishingGame", G_UIModuleBase)
local HIT_TIME = 500
local END_SCALE = 0.3
local SCALE_RATE = 0.2

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    go_content = true,
    scale_nodeRing = L_Vector3.one,
    localPos_cell = L_Vector3.zero
  }
end

function this.methods()
  return {
    onClick_ring = function(self)
      if not self._canClick then
        return
      end
      self._canClick = false
      local sumTime = self.bind.disappearTime / 1000
      local curTime = self._doTween:Elapsed()
      local res = sumTime >= curTime and curTime >= sumTime - 0.5
      if res then
        C_AudioManager.Play("Play_SFX_System_Fishing_Tap_Hit")
        self.bindComponents.ani_cellFishingGame:Stop()
        self.bindComponents.ani_cellFishingGame:Play("anim_fishing_game_node_2hit")
      else
        C_AudioManager.Play("Play_SFX_System_Fishing_Tap_Miss")
        self.bindComponents.ani_cellFishingGame:Stop()
        self.bindComponents.ani_cellFishingGame:Play("anim_fishing_game_node_2miss")
      end
      self:emit("onClick_ring", res, self.bind.localPos_cell)
      self:removeSelf()
    end
  }
end

function this:open(options)
  this.super.open(self, options)
  C_AudioManager.Play("Play_SFX_System_Fishing_Tap_Appear")
  self:initCell()
end

function this:close(options)
  this.super.close(self, options)
  self:removeDOTween()
  L_TimerManager:clearTimer(self)
end

function this:initCell()
  if not self.isBind then
    return
  end
  self._initScale = SCALE_RATE / HIT_TIME * self.bind.disappearTime + END_SCALE
  self.bind.scale_nodeRing = L_Vector3.new(self._initScale, self._initScale, 1)
  self._canClick = true
  self:setDisappearTime()
end

function this:setDisappearTime()
  local function getter()
    return self._initScale
  end
  
  local function setter(r)
    self.bind.scale_nodeRing = L_Vector3.new(r, r, 1)
    self._curTime = self._doTween:Elapsed()
  end
  
  self._doTween = DOTween.To(getter, setter, END_SCALE, self.bind.disappearTime / 1000)
  
  function self._doTween.onComplete()
    self._canClick = false
    self:emit("onClick_ring", false)
    if self.bindComponents.ani_cellFishingGame then
      self.bindComponents.ani_cellFishingGame:Stop()
      self.bindComponents.ani_cellFishingGame:Play("anim_fishing_game_node_2miss")
    end
    C_AudioManager.Play("Play_SFX_System_Fishing_Tap_Miss")
    self:removeSelf()
  end
  
  self._doTween:SetEase(Tweening.Ease.Linear)
end

function this:removeSelf()
  if self._canClick then
    self.bind.go_content = false
  else
    L_TimerManager:newOrResetTimer(self, "delayCloseSelf", function()
      self.bind.go_content = false
    end, 0.666)
  end
  self:removeDOTween()
end

function this:removeDOTween()
  if L_CommonUtil.isValid(self._doTween) then
    self._doTween:Kill()
    self._doTween = nil
  end
end

return this
