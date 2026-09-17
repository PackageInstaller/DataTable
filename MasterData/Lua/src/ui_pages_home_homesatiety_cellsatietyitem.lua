local this = class("cellSatietyItem", G_UIModuleBase)
local foodTpl = L_GameTpl:getFoodTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()

function this.bind()
  return {
    active_itemIcon = false,
    active_empty = true,
    itemIcon = "",
    img_iconFilter = "",
    satiety = "",
    itemNum = 0,
    qulaityColor = C_Color.white
  }
end

function this.methods()
  return {
    onClick_item = function(self)
      if not self._itemData or table.isEmpty(self._itemData) then
        return
      end
      self:emit("onClick_item", self._itemData)
    end,
    onClick_minus = function(self)
      if not self._itemData or table.isEmpty(self._itemData) then
        return
      end
      self:emit("onClick_minus", self._itemData)
    end
  }
end

function this:open()
  self:refreshByItem(self._itemData)
end

function this:getCellRect()
  if not self.isBind then
    return nil
  end
  if not self.bindComponents then
    return nil
  end
  return self.bindComponents.cellRect
end

function this:refreshByItem(itemData, isPlayingAnim)
  self._itemData = itemData
  if not self.isBind then
    return
  end
  if not self._itemData or table.isEmpty(self._itemData) then
    self.bind.active_itemIcon = false
    self.bind.active_empty = true
    return
  end
  local fTpl = foodTpl:getTplById(self._itemData.itemid)
  local conf = L_ItemTplManager:getItemConfig(L_Const.resType.commonItem, self._itemData.itemid)
  local commonItemTpl = _commonItemTpl:getTplById(self._itemData.itemid)
  self.bind.active_itemIcon = true
  self.bind.active_empty = false
  self.bind.itemNum = self._itemData.itemnum
  self.bind.satiety = string.format("+%d", foodTpl:getSatietyScore(fTpl))
  self.bind.img_iconFilter = commonItemTpl and _commonItemTpl:getFilterIcon(commonItemTpl) or ""
  self.bind.itemIcon = conf.icon
  if conf.quality then
    local _, color = C_ColorUtility.TryParseHtmlString(L_RarityTpl:getColorCircle(L_RarityTpl:getTplById(conf.quality)))
    self.bind.qulaityColor = color
  end
  if isPlayingAnim and self.bindComponents.anim then
    self.bindComponents.anim:Stop()
    self.bindComponents.anim:Play("anim_cellsatietyitem_open")
  end
end

return this
