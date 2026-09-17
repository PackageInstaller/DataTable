local this = class("cellSlotDisplay", G_UIModuleBase)

function this.bind()
  return {
    go_item = false,
    cell_item = L_Const.ModuleInfo.CellIconUnit,
    go_add = false
  }
end

function this.methods()
  return {
    onClick_add = function(self)
      self:emit("onClick_add", self.bind)
    end
  }
end

function this:open()
  self:refreshView(self.bind)
end

function this:refreshView(params)
  self.bind.dataSrc = params.dataSrc
  self.bind.index = params.index
  self.bind.headUrl = params.headUrl
  if not self.isBind then
    return
  end
  local isEmpty = table.isEmpty(self.bind.dataSrc)
  self.bind.go_item = not isEmpty
  self.bind.go_add = true
  if not isEmpty then
    local cellItem = self.modules.cell_item
    cellItem:setHeroDataContent(L_HeroStore:getHeroGuid(self.bind.dataSrc), {
      dataSrc = self.bind.dataSrc,
      headUrl = self.bind.headUrl,
      callback = function(cell)
        self:emit("onClick_select", self.bind)
      end
    })
    self:setSelectIndex(self.bind.index)
  end
end

function this:setSelectIndex(index)
  if not self.isBind then
    return
  end
  self.bind.index = index
  local cellItem = self.modules.cell_item
  cellItem:setPosIndex(self.bind.index)
end

return this
