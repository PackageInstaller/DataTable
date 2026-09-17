local this = class("cellPhotoHeroItem", G_UIModuleBase)

function this.bind()
  return {
    activeSel = false,
    activeDel = false,
    iconUnit = L_Const.ModuleInfo.CellIconUnit
  }
end

function this.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind.guid, function()
        self:playSelAnim()
      end)
    end,
    onClickRemove = function(self)
      self:emit("onClickRemove", self.bind.guid)
    end
  }
end

function this:init()
end

function this:open()
end

function this:refresh()
  self:refreshIcon()
  if self.isPut ~= nil and self.isControl ~= nil then
    self:refreshBtns(self.isPut, self.isControl)
  end
end

function this:refreshIcon()
  table.merge(self.modules.iconUnit.bind, self.bind.iconData)
  self.modules.iconUnit:refresh()
end

function this:refreshBtns(isPut, isControl)
  self.isPut = isPut
  self.isControl = isControl
  if not self.isBind then
    return
  end
  self.bind.activeDel = isPut and not isControl
  self.bind.activeSel = isPut and isControl
  self.bind.iconData.go_putMask = isPut and not isControl
  if self.modules.iconUnit then
    self.modules.iconUnit.bind.go_putMask = isPut and not isControl
  end
end

function this:close()
  self.isControl = nil
  self.isPut = nil
end

function this:playSelAnim()
  self.bindComponents.anim_sel:Play("anim_cellicon_select")
end

return this
