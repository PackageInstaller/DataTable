local module = class("cellCatalogSpecial", G_UIModuleBase)

function module.bind()
  return {
    active_select = false,
    active_lock = false,
    active_default = false,
    active_index = false,
    txt_index = nil
  }
end

function module.methods()
  return {
    onClick = function(self)
      self:emit("onClick_specialIndex", self.bind.id)
    end,
    onClick_default = function(self)
      self:emit("onClick_specialIndex", self.bind.id)
    end,
    onClick_lock = function(self)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_iconography_specpet_lock"))
    end
  }
end

function module:refreshSelect(selectId)
  self.bind.active_select = selectId == self.bind.id
end

function module:playInAni()
  if self.isBind then
    self.bindComponents.ani:Rewind()
    self.bindComponents.ani:Play("anim_petcatalogdeta_cellCatalogSpecial")
  end
end

return module
