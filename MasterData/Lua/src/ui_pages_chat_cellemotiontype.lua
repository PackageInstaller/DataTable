local this = class("cellEmotionType", G_UIModuleBase)
local COLLECT_EMOJI_GROUP = 1

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    img_icon = "",
    go_select = false,
    txt_name_normal = "",
    sizeDelta = C_Vector2(50, 50),
    active_shoucang = false,
    active_icon = true,
    img_heart_icon = ""
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      self:emit("onClick_select", self.bind)
      if self.bind.go_select then
        L_AudioUtil.playSound("Play_SFX_System_UI_Chat_Meme_Switch")
      end
    end,
    onPointerEnter_notSelect = function(self)
      if not self.bind.go_select then
        L_AudioUtil.playSound("Play_SFX_System_UI_Chat_Meme_Hover")
      end
    end
  }
end

function this:open()
  this.super.open(self)
  local id = self.bind.type
  self:registerReddot(self.bindComponents.reddotNew, string.format(L_ReddotManager.DotDef.NewEmojiType, id))
end

function this:refresh()
  if self.bind.type == COLLECT_EMOJI_GROUP then
    self.bind.sizeDelta = C_Vector2(50, 50)
  else
    self.bind.sizeDelta = C_Vector2(66, 66)
  end
  self:setAnimActive(not self.bind.go_select)
end

function this:setFirst(isFirst)
  if isFirst then
    self.bind.active_shoucang = true
    self.bind.active_icon = false
  end
end

function this:setAnimActive(isActive)
  if self.bindComponents.anim then
    self.bindComponents.anim.enabled = isActive
    self.bindComponents.animBtn.interactable = isActive
    if isActive then
      self.bindComponents.anim:Play("Normal", 0, 0)
    end
  end
end

return this
