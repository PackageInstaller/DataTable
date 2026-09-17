local module = class("cellCostItem", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {}
end

function module.bind()
  return {icon = "", itemNumTxt = ""}
end

function module.methods()
  return {
    onClick_detail = function(self)
      L_ItemTplManager:showInfoTip(self.bind.itemType, self.bind.itemId)
    end
  }
end

function module:open()
  local item = L_ItemTplManager:getItemConfig(self.bind.itemType, self.bind.itemId)
  self.bind.icon = item.icon
  if L_ItemTplManager:getItemNum(self.bind.itemType, self.bind.itemId) < tonumber(self.bind.itemNumTxt) then
    self.bind.itemNumTxt = L_GameUtil.fillColor(self.bind.itemNumTxt, "#FFA6A6")
  else
    self.bind.itemNumTxtt = tostring(self.bind.itemNumTxt)
  end
end

function module:refreshInfo()
end

function module:close()
end

return module
