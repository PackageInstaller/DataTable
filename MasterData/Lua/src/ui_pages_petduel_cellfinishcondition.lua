local this = class("cellFinishCondition", G_UIModuleBase)

function this.bind()
  return {
    txt_content = "",
    img_reward = "",
    txt_reward = "",
    active_on = true,
    active_off = true,
    go_reward = true
  }
end

function this.methods()
  return {}
end

function this:open(options)
  self:initCondition()
end

function this:initCondition()
  if not self.bind.duelTime then
    return
  end
  self.bind.txt_content = self.bind.descShow
  if self.bind.img_reward == nil or self.bind.img_reward == string.empty then
    self.bind.go_reward = false
  else
    self.bind.go_reward = true
  end
end

function this:refreshCondition(leftTime)
  if not self.bind.duelTime then
    return
  end
  if self.bind.duelTime - leftTime > self.bind.time then
    if self.bind.isFail == false then
      self.bind.isFail = true
      self:playCellAnimation("anim_petduel_condition_cell_off")
      L_TimerManager:newOrResetTimer(self, "wait", function()
        self.bind.active_on = false
        self.bind.active_off = true
      end, 0.2)
    end
  else
    self:playCellAnimation("anim_petduel_condition_cell_init_on")
    self.bind.active_on = true
    self.bind.active_off = false
  end
end

function this:playCellAnimation(aniName)
  if not self.isBind or not self.bindComponents.cellAnimation then
    return
  end
  self.bindComponents.cellAnimation:Play(aniName)
end

return this
