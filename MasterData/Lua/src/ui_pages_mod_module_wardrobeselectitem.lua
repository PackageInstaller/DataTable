local module = class("wardrobeSelectItem", G_UIModuleBase)

function module.bind()
  return {
    isSelect = false,
    icon = "",
    active_none = false,
    anim_onClick = ""
  }
end

function module.methods()
  return {
    onClick = function(self)
      if not self.bind.isSelect then
        self:emit("selectWardrobe", self.bind.wardrobeId)
        self.bind.anim_onClick = "anim_mod_avatar_skin_cell_show"
      end
    end
  }
end

function module:open()
  self.bind.active_none = string.isEmpty(self.bind.icon)
end

return module
