local UIEpRewardPreview = class("UIEpRewardPreview", UIBaseWindow)
local base = UIBaseWindow
local UINEpRewardPreviewItem = require("Game.Exploration.UI.EpRewardPreview.UINEpRewardPreviewItem")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local EpRewardBagUtil = require("Game.Exploration.UI.EpRewardBag.EpRewardBagUtil")

function UIEpRewardPreview:OnInit()
  self.resourceGroup = UINResourceGroup.New()
  self.resourceGroup:Init(self.ui.gameResourceGroup)
  self.ui.obj_PreviewItem:SetActive(false)
  self.previewItemPool = UIItemPool.New(UINEpRewardPreviewItem, self.ui.obj_PreviewItem)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnCloseClick)
  UIUtil.AddButtonListener(self.ui.background, self, self._OnCloseClick)
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, true)
end

function UIEpRewardPreview:InitEpRewardPreview(itemList, epModuleId, stageId)
  local totalPrice, previewDataList = self:_InitData(itemList, epModuleId, stageId)
  self:_RefreshUI(totalPrice, previewDataList)
end

function UIEpRewardPreview:_InitData(itemList, epModuleId, stageId)
  local totalPrice = 0
  local currencyId
  local previewDataList = {}
  for __, StmGoodElem in ipairs(itemList) do
    local itemId = StmGoodElem.itemId
    local itemNum = StmGoodElem.num
    local itemCfg = ConfigData.item[StmGoodElem.itemId]
    if itemCfg == nil then
      error("Cant get item cfg, id = " .. tostring(itemId))
    else
      local price, thisCurrencyId = EpRewardBagUtil.GetEpRewardItemPrice(itemId, epModuleId, stageId, itemNum)
      local previewData = {
        itemId = itemId,
        itemCfg = itemCfg,
        itemNum = itemNum,
        priceStr = EpRewardBagUtil:GetEpRewardItemPriceStr(price)
      }
      table.insert(previewDataList, previewData)
      totalPrice = totalPrice + price
      if currencyId == nil then
        currencyId = thisCurrencyId
      elseif currencyId ~= thisCurrencyId then
        error("reward bag has not same currencyId reward id:" .. tostring(itemId))
      end
    end
  end
  local moneyIcon
  local isKey = ConstGlobalItem.SKey == currencyId
  if not isKey then
    local itemCfg = ConfigData.item[currencyId]
    if itemCfg ~= nil then
      moneyIcon = CRH:GetSprite(itemCfg.small_icon)
      self.ui.img_CurrencyIcon.sprite = moneyIcon
    end
  end
  self.resourceGroup:SetResourceIds({currencyId})
  for _, previewData in pairs(previewDataList) do
    previewData.moneyIcon = moneyIcon
  end
  return totalPrice, previewDataList
end

function UIEpRewardPreview:_RefreshUI(totalPrice, previewDataList)
  local isDataEmpty = #previewDataList <= 0
  local isEmpty = false
  local setColor = Color.white
  if totalPrice == 0 and isDataEmpty then
    isEmpty = true
    setColor = self.ui.col_TPriceEmptyCol
  end
  local totalPriceStr = tostring(math.ceil(totalPrice / ConfigData.game_config.staminaDividend))
  self.ui.tex_TotalPrice.text = totalPriceStr
  self.ui.obj_Empty:SetActive(isEmpty)
  self.ui.obj_PreviewList:SetActive(not isEmpty)
  self:_SetTotalPriceEmptyUIColor(setColor)
  self:_RefreshPreviewItem(previewDataList)
end

function UIEpRewardPreview:_SetTotalPriceEmptyUIColor(color)
  for _, compoment in ipairs(self.ui.totalPriceColArr) do
    compoment.color = color
  end
end

function UIEpRewardPreview:_RefreshPreviewItem(previewDataList)
  self.previewItemPool:HideAll()
  for index, previewData in ipairs(previewDataList) do
    local item = self.previewItemPool:GetOne()
    item:InitEpRewardPreviewItem(index, previewData)
  end
end

function UIEpRewardPreview:_OnCloseClick()
  UIUtil.OnClickBackByUiTab(self)
end

function UIEpRewardPreview:OnDelete()
  self.resourceGroup:Delete()
  self.resourceGroup = nil
  self.previewItemPool:DeleteAll()
  base.OnDelete(self)
end

return UIEpRewardPreview
