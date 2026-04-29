_class("UIShopRecommendOne", UICustomWidget)
UIShopRecommendOne = UIShopRecommendOne

function UIShopRecommendOne:OnShow()
  self.shopModule = GameGlobal.GetModule(ShopModule)
  self:GetComponents()
end

function UIShopRecommendOne:SetData(data)
  self.data = data
  local id = self.data:GetID(1)
  local icon = self.data:GetPic(1)
  self._Icon:LoadImage(icon)
  local price = self.shopModule:GetGoodsPrice(self.data:GetTabType(1), id)
  self._priceTex:SetText(price)
  local active
  if type(price) == "number" then
    active = 0 < price
  else
    active = not string.isnullorempty(price)
  end
  self._price:SetActive(active)
  local effIcon = self.data:GetEffIcon()
  self._eff_01.gameObject:SetActive(effIcon ~= nil)
  if effIcon then
    self._eff_01:LoadImage(effIcon)
  end
  local uitype = self.data:GetUIType()
  self._cardRoot:SetActive(uitype == UIShopRecommendUIType.Card)
  self._giftRoot:SetActive(uitype == UIShopRecommendUIType.Gift)
  self._petRoot:SetActive(uitype == UIShopRecommendUIType.Pet)
  self._skinRoot:SetActive(uitype == UIShopRecommendUIType.Skin)
  if uitype == UIShopRecommendUIType.None then
    Log.error("###[UIShopRecommendOne] 多图模式，使用对象错误")
  elseif uitype == UIShopRecommendUIType.Gift then
    self:SetGiftInfo()
  elseif uitype == UIShopRecommendUIType.Card then
    self:SetCardInfo()
  elseif uitype == UIShopRecommendUIType.Pet then
    self:SetPetInfo()
  elseif uitype == UIShopRecommendUIType.Skin then
    self:SetSkinInfo()
  end
end

function UIShopRecommendOne:SetGiftInfo()
  local params = self.data:GetGiftParams(1)
  local len = 0
  if params then
    len = #params
  end
  self._gift_desc_2_go:SetActive(1 < len)
  if 1 < len then
    local param2 = params[2]
    local desc2 = param2[1]
    local icon2 = param2[2]
    self._gift_icon_2.gameObject:SetActive(icon2 ~= nil)
    if icon2 then
      self._gift_icon_2.sprite = self.commonAtlas:GetSprite(icon2)
    end
    self._gift_desc_2:SetText(StringTable.Get(desc2))
  end
  self._gift_desc_1_go:SetActive(0 < len)
  if 0 < len then
    local param1 = params[1]
    local desc1 = param1[1]
    local icon1 = param1[2]
    self._gift_icon_1.gameObject:SetActive(icon1 ~= nil)
    if icon1 then
      self._gift_icon_1.sprite = self.commonAtlas:GetSprite(icon1)
    end
    self._gift_desc_1:SetText(StringTable.Get(desc1))
  end
  local giftName = self.data:GetName(1)
  self._gift_name_go:SetActive(giftName ~= nil)
  if giftName then
    self._giftName:SetText(StringTable.Get(giftName))
  end
end

function UIShopRecommendOne:SetCardInfo()
  local monthCardInfo = self.shopModule:GetMonthCardInfo()
  if not monthCardInfo then
    return
  end
  local itemData = GiftPackShopItem:New(monthCardInfo.ID)
  itemData:SetPrice(tonumber(monthCardInfo.NowPrice))
  itemData:SetPriceWithCurrencySymbol(ClientShop.PriceUnit() .. monthCardInfo.NowPrice)
  itemData:SetIsMonthCard(true)
  itemData:SetRefreshTime(monthCardInfo.DeadlineTime)
  itemData:SetBuyCount(monthCardInfo.selled_num)
  itemData:SetMaxBuyCount(monthCardInfo.maxBuyCount)
  itemData:SetMidasId(monthCardInfo.midasId)
  local saleType = monthCardInfo.saleType
  if saleType == SpecialNum.NeedPayMoney then
    itemData:SetType(GiftPackType.Currency)
    itemData:SetPriceIcon(nil)
    itemData:SetPriceItemId(nil)
  else
    if saleType == SpecialNum.FreeGiftSaleType then
      itemData:SetType(GiftPackType.Free)
      itemData:SetPriceItemId(nil)
    else
      if saleType == RoleAssetID.RoleAssetDiamond then
        itemData:SetType(GiftPackType.Yaojing)
      elseif saleType == RoleAssetID.RoleAssetGlow then
        itemData:SetType(GiftPackType.Guangpo)
      else
        itemData:SetType(GiftPackType.Item)
      end
      itemData:SetPriceIcon("toptoon_" .. saleType)
      itemData:SetPriceItemId(saleType)
    end
    
    local function l2g(lst)
      local items = {}
      for i, item in ipairs(lst) do
        local item = GiftPackShopItemAward:New(item.templateId, item.count)
        table.insert(items, item)
      end
      return items
    end
    
    local awardsImmediately = l2g(monthCardInfo.DirectAssetList)
    itemData:SetAwardsImmediately(awardsImmediately)
    local awardsDaily = l2g(monthCardInfo.CycleAcceptAssetList)
    itemData:SetAwardsDaily(awardsDaily)
  end
  if not itemData then
    return
  end
  local strCycleType = itemData:GetMonthCardCycleTypeStr(60)
  if not string.isnullorempty(strCycleType) then
    self._dayTex:SetText(strCycleType)
  end
  local tex = ""
  self._dayTex:SetText(tex)
end

function UIShopRecommendOne:SetPetInfo()
  local params = self.data:GetPetParams()
  local petid = tonumber(params[1])
  local desc = params[2]
  self._pet_desc_go:SetActive(desc ~= nil)
  if desc then
    self._pet_desc_tex:SetText(StringTable.Get(desc))
  end
  local cfg_pet = Cfg.cfg_pet[petid]
  local elem = cfg_pet.FirstElement
  self._element.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(Cfg.cfg_pet_element[elem].Icon))
  self._petName:SetText(StringTable.Get(cfg_pet.Name))
  local star = cfg_pet.Star
  for i = 1, 6 do
    local child = self._starts:GetChild(i - 1)
    local spName
    if i <= star then
      child.gameObject:SetActive(true)
    else
      child.gameObject:SetActive(false)
    end
  end
  local giftName = self.data:GetName(1)
  self._pet_gift_name_go:SetActive(giftName ~= nil)
  if giftName then
    self._pet_giftName:SetText(StringTable.Get(giftName))
  end
end

function UIShopRecommendOne:SetSkinInfo()
  local name = self.data:GetName(1)
  self._skin_name_go:SetActive(name ~= nil)
  if name then
    self._skinName:SetText(StringTable.Get(name))
  end
end

function UIShopRecommendOne:SetCallback(callback)
  self.callback = callback
end

function UIShopRecommendOne:IconOnClick(go)
  if self.callback then
    self.callback(self.data.list[1])
  end
end

function UIShopRecommendOne:BtnOnClick(go)
  if self.callback then
    self.callback(self.data.list[1])
  end
end

function UIShopRecommendOne:PetInfoBtnOnClick(go)
  local params = self.data:GetPetParams()
  local petid = tonumber(params[1])
  Log.error("###[UIShopRecommendOne] petid:", petid)
  self:ShowDialog("UIShopPetDetailController", petid)
end

function UIShopRecommendOne:GetComponents()
  self._Icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._price = self:GetGameObject("price")
  self._priceTex = self:GetUIComponent("UILocalizationText", "priceTex")
  self._eff_01 = self:GetUIComponent("RawImageLoader", "Eff_01")
  self._cardRoot = self:GetGameObject("card")
  self._giftRoot = self:GetGameObject("gift")
  self._petRoot = self:GetGameObject("pet")
  self._skinRoot = self:GetGameObject("skin")
  self._pet_desc_go = self:GetGameObject("pet_desc_go")
  self._pet_desc_tex = self:GetUIComponent("UILocalizationText", "pet_desc_tex")
  self._element = self:GetUIComponent("Image", "element")
  self._starts = self:GetUIComponent("Transform", "starts")
  self._petName = self:GetUIComponent("UILocalizationText", "petName")
  self._dayTex = self:GetUIComponent("UILocalizationText", "dayTex")
  self._gift_desc_2_go = self:GetGameObject("gift_desc_2_go")
  self._gift_desc_1_go = self:GetGameObject("gift_desc_1_go")
  self._gift_name_go = self:GetGameObject("gift_name_go")
  self._giftName = self:GetUIComponent("UILocalizedTMP", "giftName")
  self._gift_desc_2 = self:GetUIComponent("UILocalizationText", "gift_desc_2")
  self._gift_desc_1 = self:GetUIComponent("UILocalizationText", "gift_desc_1")
  self._gift_icon_1 = self:GetUIComponent("Image", "gift_icon_1")
  self._gift_icon_2 = self:GetUIComponent("Image", "gift_icon_2")
  self._pet_gift_name_go = self:GetGameObject("pet_gift_name_go")
  self._pet_giftName = self:GetUIComponent("UILocalizedTMP", "petGiftName")
  self._skin_name_go = self:GetGameObject("skin_name_go")
  self._skinName = self:GetUIComponent("UILocalizedTMP", "skinName")
  self.atlasProperty = self:RootUIOwner():GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self.commonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
end
