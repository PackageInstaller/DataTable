local module = class("cellSortWay", G_UIModuleBase)

function module.bind()
  return {
    txt_normal = "",
    txt_active = "",
    go_normal = false,
    go_active = false
  }
end

function module.methods()
  return {
    onClick_select = function(self)
      self:emit("onClick_select", self.bind)
    end,
    onClick_order = function(self)
      if self.bind.order == L_Const.sortOrder.ASC then
        self.bind.order = L_Const.sortOrder.DESC
        self.bindComponents.img_arrow_normal.localScale = C_Vector3(1, -1, 1)
        self.bindComponents.img_arrow_active.localScale = C_Vector3(1, -1, 1)
      else
        self.bind.order = L_Const.sortOrder.ASC
        self.bindComponents.img_arrow_normal.localScale = C_Vector3(1, 1, 1)
        self.bindComponents.img_arrow_active.localScale = C_Vector3(1, 1, 1)
      end
      self:emit("onClick_order", self.bind)
    end
  }
end

function module:refresh()
  if self.bind.order == L_Const.sortOrder.DESC then
    self.bindComponents.img_arrow_normal.localScale = C_Vector3(1, -1, 1)
    self.bindComponents.img_arrow_active.localScale = C_Vector3(1, -1, 1)
  else
    self.bindComponents.img_arrow_normal.localScale = C_Vector3(1, 1, 1)
    self.bindComponents.img_arrow_active.localScale = C_Vector3(1, 1, 1)
  end
end

return module
