local UINShopHeroGoodsItem = class("UINShopHeroGoodsItem", UIBaseNode)
local base = UIBaseNode
local cs_ResLoader = CS.ResLoader
local ShopEnum = require("Game.Shop.ShopEnum")
local UINHeroSkinTag = require("Game.Skin.UI.UINHeroSkinTag")
local UINHeroSkinSpTag = require("Game.Skin.UI.UINHeroSkinSpTag")
local UINShopHeroFreeGoodsList = require("Game.Shop.UINShopHeroFreeGoodsList")
local UIHeroSkinUpgradeTag = require("Game.Skin.UI.UIHeroSkinUpgradeTag")

function UINShopHeroGoodsItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_shopItem, self, self.OnClick)
  self._RefreshGoods = BindCallback(self, self.RefreshGoods)
  self.texItemList = {
    [1] = self.ui.tex_HeroName,
    [2] = self.ui.tex_currPrice,
    [3] = self.ui.text_subIntro
  }
  self.skinTagPool = UIItemPool.New(UINHeroSkinTag, self.ui.tagItem)
  self.ui.tagItem:SetActive(false)
  self.skinSpPool = UIItemPool.New(UINHeroSkinSpTag, self.ui.img_SpTag)
  self.ui.img_SpTag:SetActive(false)
end

function UINShopHeroGoodsItem:InitItem(resloader, OnClickGoodItem)
  self.resloader = resloader
  self.onClickGoodItem = OnClickGoodItem
end

function UINShopHeroGoodsItem:InitNormalGoodsItem(goodData, parentNode, purchaseRoot)
  self.goodData = goodData
  self.parentNode = parentNode
  self.purchaseRoot = purchaseRoot
  goodData:RefreshDataWithSeverMsg()
  local itemCfg = ConfigData.item[self.goodData.itemId]
  if itemCfg.type == eItemType.Resource and itemCfg.id == ConstGlobalItem.VowRing then
    self:ShowVowRingGoods()
  elseif itemCfg.type == eItemType.Skin then
    self:ShowSkinGoods()
  else
    self:ShowChipGoods()
  end
  self:RefreshCurrencyUI()
  self:RefreshLimitUI()
  for i = 1, #self.texItemList do
    self.texItemList[i]:StartScrambleTypeWriter()
  end
  if self.goodData.shelfCfg ~= nil and 0 < (self.goodData.shelfCfg.showdiscount or 0) then
    local showInt = self.goodData.shelfCfg.showdiscount - 100
    self.ui.img_Off:SetActive(true)
    self.ui.tex_Off:SetIndex(0, tostring(showInt))
  else
    self.ui.img_Off:SetActive(false)
  end
  self:InitSkinUpgradeTag()
end

function UINShopHeroGoodsItem:InitSkinUpgradeTag()
  local skinCfg = ConfigData.skin[self.goodData.itemId]
  if skinCfg ~= nil then
    local skinId = skinCfg.id
    local canUpGrade = PlayerDataCenter.skinData:IsSkinCanUpgrade(skinId)
    self.ui.obj_heroSkinUpgradeTag.gameObject:SetActive(canUpGrade)
    if canUpGrade and self.heroSkinUpgradeTag == nil then
      self.heroSkinUpgradeTag = UIHeroSkinUpgradeTag:New()
      self.heroSkinUpgradeTag:Init(self.ui.obj_heroSkinUpgradeTag)
    end
    if self.heroSkinUpgradeTag ~= nil then
      self.heroSkinUpgradeTag:InitHeroSkinUpgradeTag(skinId)
    end
  else
    self.ui.obj_heroSkinUpgradeTag.gameObject:SetActive(false)
  end
end

function UINShopHeroGoodsItem:ShowVowRingGoods()
  self.ui.chipNode:SetActive(false)
  self.ui.skinNode:SetActive(false)
  self.ui.skinSp:SetActive(false)
  self.ui.obj_shopSkinTime:SetActive(false)
  self.ui.tex_SeriesName.gameObject:SetActive(false)
  self.ui.tex_HeroName.gameObject:SetActive(false)
  self.ui.obj_info:SetActive(false)
  self.ui.obj_vowRing:SetActive(true)
  self.ui.obj_giftList:SetActive(false)
end

function UINShopHeroGoodsItem:ShowChipGoods()
  self.ui.chipNode:SetActive(true)
  self.ui.skinNode:SetActive(false)
  self.ui.skinSp:SetActive(false)
  self.ui.obj_shopSkinTime:SetActive(false)
  self.ui.tex_SeriesName.gameObject:SetActive(false)
  self.ui.tex_HeroName.gameObject:SetActive(false)
  self.ui.obj_vowRing:SetActive(false)
  self.ui.obj_info:SetActive(true)
  self.ui.obj_giftList:SetActive(false)
  local heroCfg = ConfigData.hero_data[self.goodData.goodCfg.hero]
  if heroCfg == nil then
    error("heroCfg null,id:" .. tostring(self.goodData.goodCfg.hero))
    return
  end
  local vowCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem, true)
  local heroName = vowCtrl:GetHeroName(heroCfg.id)
  self.ui.tex_HeroName.text = heroName
  self.ui.text_subIntroInfo:SetIndex(0)
  local resCfg = ConfigData.resource_model[heroCfg.src_id]
  if resCfg == nil then
    error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
    return
  end
  local campCfg = ConfigData.camp[heroCfg.camp]
  if campCfg == nil then
    error("campCfg is null,id:" .. tostring(heroCfg.camp))
    return
  end
  self:RefreshFreeGiftList()
  self._finialPicName = resCfg.res_Name
  local tempPicName = resCfg.res_Name
  self.resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(tempPicName), function(texture)
    if IsNull(self.transform) then
      return
    end
    if tempPicName == self._finialPicName then
      self.ui.img_Hero.texture = texture
    end
  end)
  self._fininalCampName = campCfg.icon
  local tempCampName = campCfg.icon
  self.resloader:LoadABAssetAsync(PathConsts:GetCampPicPath(tempCampName), function(texture)
    if IsNull(self.transform) then
      return
    end
    if tempCampName == self._fininalCampName then
      self.ui.img_Camp.texture = texture
    end
  end)
end

function UINShopHeroGoodsItem:ShowSkinGoods()
  self.ui.chipNode:SetActive(false)
  self.ui.skinNode:SetActive(true)
  self.ui.skinSp:SetActive(true)
  self.ui.tex_HeroName.gameObject:SetActive(true)
  self.ui.tex_SeriesName.gameObject:SetActive(true)
  self.ui.tex_skinHeroName.gameObject:SetActive(true)
  self.ui.obj_vowRing:SetActive(false)
  self.ui.obj_info:SetActive(true)
  self.ui.obj_giftList:SetActive(false)
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local heroId = skinCtr:GetHeroId(self.goodData.itemId)
  local modelRes = skinCtr:GetResModel(heroId, self.goodData.itemId)
  if modelRes == nil then
    self:Hide()
    return
  end
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg == nil then
    error("heroCfg null,id:" .. tostring(heroId))
    return
  end
  local campCfg = ConfigData.camp[heroCfg.camp]
  if campCfg == nil then
    error("campCfg null,id:" .. tostring(heroCfg.camp))
    return
  end
  self:RefreshFreeGiftList()
  self._finialPicName = modelRes.src_id_pic
  local tempPicName = modelRes.src_id_pic
  self.resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(tempPicName), function(texture)
    if IsNull(self.transform) then
      return
    end
    if tempPicName == self._finialPicName then
      self.ui.img_Hero.texture = texture
    end
  end)
  self._fininalCampName = campCfg.icon
  local tempCampName = campCfg.icon
  self.resloader:LoadABAssetAsync(PathConsts:GetCampPicPath(tempCampName), function(texture)
    if IsNull(self.transform) then
      return
    end
    if tempCampName == self._fininalCampName then
      self.ui.img_Camp.texture = texture
    end
  end)
  local skinCfg = ConfigData.skin[self.goodData.itemId]
  self.ui.tex_HeroName.text = LanguageUtil.GetLocaleText(skinCfg.name)
  local skinThem = ConfigData.skinTheme[skinCfg.theme]
  if skinThem ~= nil then
    self.ui.text_subIntroInfo:SetIndex(1, LanguageUtil.GetLocaleText(skinThem.name))
  else
    self.ui.text_subIntroInfo:SetIndex(1, "")
  end
  self.skinTagPool:HideAll()
  CommonUIUtil.CreateHeroSkinTags(skinCfg, self.skinTagPool)
  self.ui.tex_SeriesName:SetTextSafe(LanguageUtil.GetLocaleText(skinThem.name))
  self.ui.tex_skinHeroName:SetTextSafe(LanguageUtil.GetLocaleText(heroCfg.name))
  self:RefreshSkinLeftTime()
  self:RefreshSkinUpGrade()
  self.skinSpPool:HideAll()
  for _, tagId in ipairs(skinCfg.showlabel) do
    local item = self.skinSpPool:GetOne()
    item:InitSkinSpTag(tagId)
  end
  local isShowL2DComingSoon = skinCfg.temp_label
  self.ui.obj_L2DComingSoon:SetActive(isShowL2DComingSoon)
  self.ui.obj_L2DComingSoon.transform:SetAsLastSibling()
end

function UINShopHeroGoodsItem:RefreshFreeGiftList()
  if self.goodData.shelfCfg ~= nil and self.goodData.shelfCfg.freeItems ~= nil then
    self.ui.obj_giftList:SetActive(true)
    if self.freeItemList == nil then
      self.freeItemList = UINShopHeroFreeGoodsList.New()
      self.freeItemList:Init(self.ui.obj_giftList)
    end
    self.freeItemList:RefreshItemList(self.goodData.shelfCfg.freeItems, self.goodData.shelfCfg.freeItemNums)
  end
end

function UINShopHeroGoodsItem:RefreshSkinLeftTime()
  self.ui.obj_shopSkinTime:SetActive(false)
  if self.goodData.isSoldOut then
    return
  end
  local hasTimeLimit, inTime, startTime, endTime = self.goodData:GetStillTime()
  if not hasTimeLimit or not inTime then
    return
  end
  local remaindTime = endTime - PlayerDataCenter.timestamp
  if remaindTime <= 0 then
    return
  end
  self.ui.obj_shopSkinTime:SetActive(true)
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
  if 0 < d then
    self.ui.txt_shopSkinTime:SetIndex(0, tostring(d), tostring(h))
    return
  end
  if 0 < h then
    self.ui.txt_shopSkinTime:SetIndex(1, tostring(h), tostring(m))
    return
  end
  if 0 < s then
    m = m + 1
  end
  self.ui.txt_shopSkinTime:SetIndex(2, tostring(m))
end

function UINShopHeroGoodsItem:RefreshSkinUpGrade()
  if self.heroSkinUpgradeTag ~= nil then
    self.heroSkinUpgradeTag:OnTimerUpdate()
  end
end

function UINShopHeroGoodsItem:RefreshCurrencyUI()
  self.ui.tex_currPrice.text = self.goodData.newCurrencyNum
  local currencyItemCfg = ConfigData.item[self.goodData.currencyId]
  local smallIcon = currencyItemCfg.small_icon
  self.ui.img_priceIcon.sprite = CRH:GetSprite(smallIcon)
  if self.goodData.discount == 100 then
    self.ui.tex_oldPrice.gameObject:SetActive(false)
  else
    self.ui.tex_oldPrice.text = self.goodData.oldCurrencyNum
    self.ui.tex_oldPrice.gameObject:SetActive(true)
  end
end

function UINShopHeroGoodsItem:RefreshLimitUI()
  local fragItemNum = PlayerDataCenter:GetItemCount(self.goodData.itemId)
  self.ui.tex_HaseCount:SetIndex(0, tostring(fragItemNum))
  self.ui.obj_cantBuy:SetActive(self.goodData.isSoldOut)
end

function UINShopHeroGoodsItem:OnClick()
  local skinId = self.goodData.itemId
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    if self.goodData.isSoldOut then
      return
    end
  else
    local isInTimeRange = PlayerDataCenter.skinData:IsInSkinUpgradeTimeRange(skinId)
    local skinUpOpen = PlayerDataCenter.skinData:IsSkinCanUpgrade(skinId)
    skinUpOpen = isInTimeRange and skinUpOpen
    if self.goodData.isSoldOut and not skinUpOpen then
      return
    end
  end
  if self.onClickGoodItem ~= nil then
    self.onClickGoodItem(self.goodData)
  end
end

function UINShopHeroGoodsItem:RefreshGoods()
  self:RefreshCurrencyUI()
  self:RefreshLimitUI()
end

function UINShopHeroGoodsItem:RefreshFrgNum()
  self:RefreshLimitUI()
end

function UINShopHeroGoodsItem:OnDelete()
  if self.freeItemList then
    self.freeItemList:OnDelete()
  end
  if self.heroSkinUpgradeTag then
    self.heroSkinUpgradeTag:Delete()
    self.heroSkinUpgradeTag = nil
  end
  base.OnDelete(self)
end

return UINShopHeroGoodsItem
