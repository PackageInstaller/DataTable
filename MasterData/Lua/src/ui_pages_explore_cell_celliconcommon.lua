local this = class("cellIconCommon", G_UIModuleBase)

function this.bind()
  return {
    cellIcon_item = L_Const.ModuleInfo.CellIconBag,
    go_received = false,
    go_item = true,
    go_bg = false,
    isEmpty = false,
    itemType = 0,
    itemId = 0,
    itemNum = 0
  }
end

function this.methods()
  return {}
end

function this:open()
  if self.isBind then
    self:initCell()
  end
end

function this:refresh()
  if self.isBind then
    self:initCell()
  end
end

function this:initCell()
  local isEmpty = self.bind.isEmpty or false
  if isEmpty then
    self.bind.go_item = false
    self.bind.go_bg = true
    if self.modules.cellIcon_item then
      if self.modules.cellIcon_item.clear then
        self.modules.cellIcon_item:clear()
      end
      if self.modules.cellIcon_item.setGeneralContent then
        self.modules.cellIcon_item:setGeneralContent(0, 0, {itemNum = 0})
      end
      if self.modules.cellIcon_item.gameObject then
        self.modules.cellIcon_item.gameObject:SetActive(false)
      end
    end
  else
    self.bind.go_item = true
    self.bind.go_bg = false
    if self.modules.cellIcon_item and self.modules.cellIcon_item.gameObject then
      self.modules.cellIcon_item.gameObject:SetActive(true)
    end
    local cellIcon = self.modules.cellIcon_item
    if cellIcon and cellIcon.setGeneralContent then
      cellIcon:setGeneralContent(self.bind.itemType or 0, self.bind.itemId or 0, {
        itemNum = self.bind.itemNum or 0
      })
    end
  end
end

return this
