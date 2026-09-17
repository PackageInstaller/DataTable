local module = class("modColorSelectItem", G_UIModuleBase)

function module.bind()
  return {
    color = Unity.Color.white,
    isSelect = false,
    anim_onClick = ""
  }
end

function module.methods()
  return {
    OnClick = function(self)
      if not self.bind.isSelect then
        self:emit("selectColor", self.bind.colorId, self.bind.wardrobeId)
        self.bind.anim_onClick = "anim_mod_avatar_skin_cell_show"
      end
    end
  }
end

function module:refresh()
  self.bind.color = C_LuaUtility.ParseHtmlStringColor(self.bind.colorValue)
end

return module
