local this = class("cellBoxItem", G_UIModuleBase)

function this.bind()
  return {
    text_level = "",
    petAvatarIcon = "",
    go_lock = false,
    go_content = true,
    go_normal = false,
    go_select = false,
    go_now = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind)
    end
  }
end

function this:refresh()
end

function this:playAnim(index)
  if not (index ~= 0 and self.isBind) or not self.bindComponents then
    return
  end
  if index == 1 then
    self.bindComponents.normal:Play("anim_petbox_select_item_close")
  elseif index == 2 then
    self.bindComponents.now:Play("anim_petbox_select_item_open")
  end
end

return this
