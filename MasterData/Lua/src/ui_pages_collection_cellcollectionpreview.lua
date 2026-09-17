local this = class("cellCollectionPreview", G_UIModuleBase)
local _productsTpl = L_GameTpl:getProductsCollectionTpl()
local _productsCollectionTypeTpl = L_GameTpl:getProductsCollectionTypeTpl()
local qualityColor = {
  [1] = "#A0AEB7",
  [2] = "#27AE89",
  [3] = "#3AB3FF",
  [4] = "#A264FF",
  [5] = "#FFBF35"
}

function this.bind()
  return {
    img_icon = nil,
    txt_name = nil,
    txt_desc = nil,
    go_lock = false,
    color_lock = C_Color(1, 1, 1, 1),
    go_rare = false,
    img_rare = nil,
    go_line = false,
    go_mask = false,
    canvasGroup = 1
  }
end

function this.methods()
  return {
    onClick_icon = function(self)
      L_ItemTplManager:showInfoTip(self.bind.itemType, self.bind.itemId)
    end,
    onClick_name = function(self)
      L_ItemTplManager:showInfoTip(self.bind.itemType, self.bind.itemId)
    end
  }
end

function this:open()
  if self.isBind then
    self:CheckNameLen()
  end
end

function this:CheckNameLen()
  if not string.isEmpty(self.bind.name) then
    local txt = self.bind.name
    if string.len(txt) > 15 then
      txt = string.format("%s...", string.sub(txt, 1, 15))
    end
    self.bind.txt_name = txt
  end
end

function this:refresh()
end

function this:setMaskActive(active)
  if self.bind.go_rare and self.bind.go_lock then
    self.bind.go_mask = active
  end
end

function this:SetDataByCSharp(index, luaTableData)
  local itemType = luaTableData.itemType
  local itemId = luaTableData.itemId
  local descStr = luaTableData.descStr
  local isLock = luaTableData.bLock
  local unlockLevel = luaTableData.unlockLevel
  local sortIndex = luaTableData.sortIndex
  local showRare = luaTableData.showRare
  local rareIconStr = luaTableData.rareIcon
  self.bind.itemType = itemType
  self.bind.itemId = itemId
  self.bind.txt_desc = descStr
  local configData = L_ItemTplManager:getItemConfig(itemType, itemId)
  self.bind.img_icon = configData.icon
  self.bind.quality = configData.quality
  self.bind.name = configData.name
  self.bind.go_lock = isLock
  self.bind.unlockLevel = unlockLevel
  self.bind.sortId = sortIndex
  self.bind.lockStatus = isLock and 1 or 0
  self.bind.go_rare = showRare
  self.bind.img_rare = rareIconStr
  self.bind.go_mask = isLock and showRare
  self.bind.canvasGroup = isLock and 0.5 or 1
  self.bind.go_line = (index + 1) % 2 == 0
  self:CheckNameLen()
end

return this
