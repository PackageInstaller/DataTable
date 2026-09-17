local this = class("cellAccessoryPreviewStarUp", G_UIModuleBase)

function this.bind()
  return {
    go_empty = true,
    go_yellow = true,
    go_blue = true,
    go_preview = true
  }
end

function this.methods()
  return {}
end

function this:open()
  self:refreshUI()
end

function this:refresh()
  self:refreshUI()
end

function this:refreshUI()
  if self.bind.animRefreshStar then
    if self.bind.isPreview then
      self.bindComponents.anim:Play("anim_AStrength_cellAccessoryPreviewStarUp_cellPreviewStar_FadeIn")
    elseif self.bind.isEmpty then
      self.bindComponents.anim:Play("anim_AStrength_cellAccessoryPreviewStarUp_Disable")
    elseif self.bind.isYellow then
      self.bindComponents.anim:Play("anim_AStrength_cellAccessoryPreviewStarUp_cellYellowStar_2_FadeIn")
    elseif self.bind.isBlue then
      self.bindComponents.anim:Play("anim_AStrength_cellAccessoryPreviewStarUp_cellIconStar_FadeIn")
    end
  elseif self.bind.isPreview then
    self:animEnd("anim_AStrength_cellAccessoryPreviewStarUp_cellPreviewStar_FadeIn")
  elseif self.bind.isEmpty then
    self:animEnd("anim_AStrength_cellAccessoryPreviewStarUp_Disable")
  elseif self.bind.isYellow then
    self:animEnd("anim_AStrength_cellAccessoryPreviewStarUp_cellYellowStar_2_FadeIn")
  elseif self.bind.isBlue then
    self:animEnd("anim_AStrength_cellAccessoryPreviewStarUp_cellIconStar_FadeIn")
  end
end

function this:animEnd(animName)
  self.bindComponents.anim:Play(animName)
  local animationClip = self.bindComponents.anim:GetClip(animName)
  if animationClip then
    local animComp = self.bindComponents.anim
    local state = animComp.get_Item and animComp:get_Item(animName)
    if state then
      state.time = animationClip.length
    end
  end
end

function this:playLevelUpAnim(animName)
  self.bindComponents.anim:Stop()
  self.bindComponents.anim:Play(animName)
end

return this
