local this = class("cellFishStamina", G_UIModuleBase)

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {go_active = true}
end

function this:playHideFX()
  self.bindComponents.ani_cellPlayerStamina:Stop()
  self.bindComponents.ani_cellPlayerStamina:Play("anim_fishing_game_heart_fade")
end

return this
