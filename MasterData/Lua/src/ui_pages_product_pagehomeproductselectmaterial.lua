local this = class("pageHomeProductSelectMaterial", G_UIPageBase)

function this.bind()
  return {
    list_item = L_Const.ModuleInfo.CellIconBag,
    txt_desc = "",
    moduleCommonTipMedium = L_Const.ModuleInfo.ModuleCommonTip
  }
end

function this.methods()
  return {
    moduleCommonTipMedium = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_confirm = function(self)
        self:onClickConfirm()
      end,
      onClick_bg = function(self)
        L_UI:close(self.pageName)
      end
    }
  }
end

function this:preOpen(options)
  local groupData = options.groupData
  local select = options.select
  local selectNum = options.selectNum
  local dataList = {}
  if groupData == nil or next(groupData) == nil then
    error("pageHomeProductSelectMaterial:界面未传入groupData参数或groupData参数内容为空，请检查！")
    self:close()
    return
  end
  for i, itemData in pairs(groupData) do
    local itemHasNum = L_ItemTplManager:getItemNum(itemData.itemType, itemData.itemId)
    local itemNeedNum = itemData.itemNum * selectNum
    local dataListItem = {
      callback = function()
        self:onClickItem(itemData.itemId, itemData.itemType, i)
      end,
      itemType = itemData.itemType,
      itemId = itemData.itemId
    }
    if itemHasNum < itemNeedNum then
      dataListItem.itemNumTxt = string.format("<color=#ef5743>%d</color>/%d", itemHasNum, itemNeedNum)
    else
      dataListItem.itemNumTxt = string.format("%d/%d", itemHasNum, itemNeedNum)
    end
    table.insert(dataList, dataListItem)
  end
  self:updateContentLayout(#dataList)
  self.bind.list_item:clear()
  self.bind.list_item:insert_array(dataList)
  self._callback = options.callback
  self:onClickItem(groupData[select].itemId, groupData[select].itemType, select)
  self:initCommonTipModule()
end

function this:updateContentLayout(showNum)
  local cellSize = 184
  local padding = -2.3
  local maxShowingWidth = 1018
  local trans = self.bindComponents.trans_Content
  if maxShowingWidth < cellSize * showNum + padding * (showNum - 1) then
    trans.pivot = C_Vector2(0, 1)
  else
    trans.pivot = C_Vector2(0.5, 1)
  end
  local pos = trans.anchoredPosition
  pos.x = 0
  trans.anchoredPosition = pos
end

function this:onClickItem(id, type, rar)
  for i, module in ipairs(self.modules.list_item) do
    module:setSel(id == module.bind.itemId)
  end
  self._selectedRar = rar
  if type == L_Const.resType.currency then
    local _currencyTpl = L_GameTpl:getCurrencyTpl()
    local tpl = _currencyTpl:getTplById(id)
    self.bind.txt_desc = _currencyTpl:getSpecialDesc(tpl)
  else
    local _itemTpl = L_GameTpl:getCommonItemTpl()
    local tpl = _itemTpl:getTplById(id)
    self.bind.txt_desc = _itemTpl:getSpecialDesc(tpl)
  end
end

function this:onClickConfirm()
  if self._selectedRar then
    self._callback(self._selectedRar)
    L_UI:close("pageHomeProductSelectMaterial")
  end
end

function this:close()
end

function this:initCommonTipModule()
  local moduleTip = self.modules.moduleCommonTipMedium
  moduleTip:initModule({
    txtTitle = L_WordsTpl:getValue("home_product_material_select"),
    txtConfirm = L_WordsTpl:getValue("residual_code_pagehomeproductselectmaterial_01")
  })
end

return this
