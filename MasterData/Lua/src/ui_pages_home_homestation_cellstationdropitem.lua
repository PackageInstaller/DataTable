local this = class("cellStationDropItem", G_UIModuleBase)

function this.bind()
  return {
    cell_item = L_Const.ModuleInfo.CellIconBag,
    go_mainDrop = false
  }
end

function this.methods()
  return {
    list_pet = {
      onClick_select = function(self, bind)
        self:emit("onClick_select", bind)
      end
    }
  }
end

function this:open()
  self:initCell()
end

function this:initCell()
  if not self.isBind then
    return
  end
  local cell = self.modules.cell_item
  cell:setGeneralContent(self.bind.itemType, self.bind.itemId, {bShowName = true})
end

function this:playShowAnim()
  if not self.isBind then
    return
  end
  if self.bindComponents.cellAnim then
    self.bindComponents.cellAnim:Play("anim_product_stationedManage_cell_Nget")
  end
end

return this
