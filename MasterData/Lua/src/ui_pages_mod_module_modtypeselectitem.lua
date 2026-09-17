local module = class("modTypeSelectItem", G_UIModuleBase)

function module.bind()
  return {
    isSelect = false,
    txt_name1 = "",
    txt_name2 = ""
  }
end

function module.methods()
  return {
    onClick = function(self)
      if not self.bind.isSelect then
        self:emit("onClick_select", self.bind.wardrobeType)
      end
    end
  }
end

function module:refresh()
  self.bind.txt_name1 = L_WordsTpl:getValue(L_ModStore.modTypeText[self.bind.wardrobeType])
  self.bind.txt_name2 = L_WordsTpl:getValue(L_ModStore.modTypeText[self.bind.wardrobeType])
end

return module
