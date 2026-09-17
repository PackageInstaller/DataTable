local this = class("cellBuildingUpgradeCost", G_UIModuleBase)

function this.bind()
  return {
    img_icon = "",
    txt_have = "",
    txt_need = ""
  }
end

function this.methods()
  return {
    onClick = function(self)
      L_ItemTplManager:showInfoTip(self._item.itemType, self._item.itemId)
    end
  }
end

function this:open()
  local item = self.bind.item
  self._item = item
  if self._item then
    self:refreshItem()
  end
end

function this:show()
  if self._item and self.isShow then
    self:refreshItem()
  end
  self.isShow = true
end

function this:refreshItem()
  local itemConf = L_ItemTplManager:getItemConfig(self._item.itemType, self._item.itemId)
  self.bind.img_icon = itemConf.icon
  local haveNum = L_ItemTplManager:getItemNum(self._item.itemType, self._item.itemId)
  if haveNum < self._item.itemNum then
    haveNum = L_GameUtil.fillColor(haveNum, "#EF5743")
  else
    haveNum = L_GameUtil.fillColor(haveNum, "#5F4E2E")
  end
  self.bind.txt_have = tostring(haveNum)
  self.bind.txt_need = "/" .. self._item.itemNum
end

return this
