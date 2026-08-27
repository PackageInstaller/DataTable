local UINShopFntTitleItem = class("UINShopFntTitleItem", UIBaseNode)
local base = UIBaseNode
local UINFntThemeTag = require("Game.Shop.Dorm.UINFntThemeTag")
local resloader = CS.ResLoader

function UINShopFntTitleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_buy, self, self.OnClickBuy)
  self.tagPool = UIItemPool.New(UINFntThemeTag, self.ui.obj_tagItem, false)
  self.resloader = resloader.Create()
end

function UINShopFntTitleItem:InitFntItem(goodData, baseObj)
  self.goodData = goodData
  self.type = goodData.type
  self.shopGoodsDic = goodData.shopGoodsDic
  self.themeItem = self.shopGoodsDic[1]
  self.dormTheme = ConfigData.dorm_theme[self.themeItem.shelfCfg.theme_id]
  self.resloader:LoadABAssetAsync(PathConsts:GetShopFurnitureThemePath(self.dormTheme.theme_pic2), function(texture)
    self.ui.img_BK.texture = texture
  end)
  self.ui.tex_ThemeName.text = LanguageUtil.GetLocaleText(self.dormTheme.theme_name)
  local currencyItemCfg = ConfigData.item[self.themeItem.currencyId]
  local smallIcon = currencyItemCfg.small_icon
  self.ui.img_money.gameObject:SetActive(true)
  self.ui.img_money.sprite = CRH:GetSprite(smallIcon)
  self.tagPool:HideAll()
  CommonUIUtil.CreateFntThemeTags(self.dormTheme, self.tagPool)
  local totalCost = 0
  local requiredCost = 0
  for i, itemData in pairs(self.shopGoodsDic) do
    local limitCount = itemData.totallimitTime ~= nil and itemData.totallimitTime or itemData.limitTime
    local tempCost = (limitCount - itemData.purchases) * itemData.newCurrencyNum
    local rTempCost = limitCount * itemData.newCurrencyNum
    totalCost = totalCost + tempCost
    requiredCost = requiredCost + rTempCost
  end
  self.totalCost = totalCost
  if totalCost == 0 then
    self.ui.obj_cost:SetActive(false)
    self.ui.btn_buy.interactable = false
    self.ui.tex_buy.gameObject:SetActive(false)
    self.ui.obj_soldOut:SetActive(true)
  else
    self.ui.tex_Cost.text = tostring(totalCost)
    self.ui.btn_buy.interactable = true
    self.ui.obj_cost:SetActive(true)
    self.ui.tex_buy.gameObject:SetActive(true)
    self.ui.obj_soldOut:SetActive(false)
    if totalCost == requiredCost then
      self.ui.tex_buy:SetIndex(0)
    else
      self.ui.tex_buy:SetIndex(1)
    end
  end
end

function UINShopFntTitleItem:OnClickBuy()
  if self.totalCost == 0 then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
    if win == nil then
      return
    end
    local resIds = {}
    table.insert(resIds, self.themeItem.currencyId)
    table.insert(resIds, 1, ConstGlobalItem.PaidSubItem)
    table.insert(resIds, 1, ConstGlobalItem.PaidItem)
    win:SlideIn()
    win:InitBuyRoomTheme(self.shopGoodsDic, true, resIds)
  end)
end

function UINShopFntTitleItem:RefreshGoods()
end

function UINShopFntTitleItem:RefreshLeftSellTime()
end

function UINShopFntTitleItem:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.tagPool:DeleteAll()
end

return UINShopFntTitleItem
