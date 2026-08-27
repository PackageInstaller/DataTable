local UINShopLeftPageWithSub = class("UINShopLeftPageWithSub", UIBaseNode)
local base = UIBaseNode
local UINShopLeftPageSub = require("Game.ShopMain.UINShopLeftPageSub")
local ShopEnum = require("Game.Shop.ShopEnum")

function UINShopLeftPageWithSub:OnInit()
  self.shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.subPool = UIItemPool.New(UINShopLeftPageSub, self.ui.obj_btn_Sub)
  self.ui.obj_btn_Sub:SetActive(false)
  self.__OnTimerRefresh = BindCallback(self, self.RefreshPageTime)
  UIUtil.AddButtonListener(self.ui.btn_Main, self, self.OnClickPage)
end

function UINShopLeftPageWithSub:InitPage(groupCfg, clickShopFunc, resloader, uishop, isBeforeUnlockShop, subIds)
  self.leftPageCfg = groupCfg
  self.clickShopFunc = clickShopFunc
  self.ui.obj_RedDot:SetActive(false)
  self.subIds = subIds
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self.leftPageCfg.name)
  self.ui.tex_NameEn.text = LanguageUtil.GetLocaleText(self.leftPageCfg.name_en)
  self.subPool:HideAll()
  self.payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  for _, shopId in ipairs(self.subIds) do
    if (not isBeforeUnlockShop or ConfigData.game_config.shopShowBeforeUnlockDic[shopId]) and self.shopCtrl:ShopIsUnlock(shopId) then
      local isHaveTime, _, limitTime = self.shopCtrl:GetIsThisShopHasTimeLimit(shopId)
      if isHaveTime then
        uishop:SetNeedRefreshTm(limitTime)
      end
      local item = self.subPool:GetOne(true)
      item.gameObject:SetActive(true)
      item.transform:SetParent(self.ui.subList.transform)
      item:InitPageSub(shopId, self.clickShopFunc, self)
      item.gameObject.name = shopId
    end
  end
  if #self.subPool.listItem <= 0 then
    self:Hide()
    return nil
  end
  self:RefreshRedDotState()
  self.ui.img_Icon.sprite = AtlasUtil.GetSpriteFromAtlas("UI_Shop", self.leftPageCfg.icon, resloader)
  self.ui.img_Buttom:SetIndex(1)
  self.ui.tex_Name.color = self.ui.color_selectedText
  self.ui.tex_NameEn.color = self.ui.color_selectedText
  self.ui.subList:SetActive(false)
  self:RefreshState(false)
  return self.subPool.listItem
end

function UINShopLeftPageWithSub:OnClickPage()
  if self.ui.subList.activeSelf then
    self.ui.subList:SetActive(false)
  else
    self.ui.subList:SetActive(true)
    self.subPool.listItem[1]:OnClickPage()
  end
end

function UINShopLeftPageWithSub:RefreshState(isSelected)
  self.ui.subList:SetActive(isSelected)
  if isSelected then
    self.ui.img_Buttom:SetIndex(1)
    self.ui.tex_Name.color = self.ui.color_selectedText
    self.ui.tex_NameEn.color = self.ui.color_selectedText
    self.ui.img_Icon.color = self.ui.color_selectedText
  else
    self.ui.img_Buttom:SetIndex(0)
    self.ui.tex_Name.color = self.ui.color_unSelectText
    self.ui.tex_NameEn.color = self.ui.color_unSelectText
    self.ui.img_Icon.color = self.ui.color_unSelectText
  end
  if not isSelected then
    for i, shopId in ipairs(self.subIds) do
      if self.payGiftCtrl:CheckPageIdIsGiftShop(shopId) then
        self:RefreshRedDotState()
        break
      end
    end
  end
end

function UINShopLeftPageWithSub:RefreshRedDotState()
  self.ui.obj_RedDot:SetActive(false)
  self.ui.blueDot:SetActive(false)
  local flag = false
  local isBlue = true
  for i, v in ipairs(self.subPool.listItem) do
    local tempFlag, tempIsBlue = v:RefreshPageSubRedDotState()
    if tempFlag then
      flag = true
      if not tempIsBlue then
        isBlue = false
      end
    end
  end
  self.redDotIsOpen = false
  if flag then
    local reddotObj = isBlue and self.ui.blueDot or self.ui.obj_RedDot
    reddotObj:SetActive(true)
    self.redDotIsOpen = true
  end
  self:RefreshNewGiftTag4Page(flag)
end

function UINShopLeftPageWithSub:RefreshTimelimitTag4PageWithSub()
  local ishaveTimeLimit = false
  local now = PlayerDataCenter.timestamp
  local latestTime = math.maxinteger
  local isPayGift = false
  for i, shopId in ipairs(self.subIds) do
    local hav, inTime, outTime = self.shopCtrl:GetIsThisShopHasTimeLimit(shopId)
    if hav then
      latestTime = math.min(latestTime, outTime)
      ishaveTimeLimit = true
    end
    isPayGift = self.payGiftCtrl:CheckPageIdIsGiftShop(shopId)
  end
  if ishaveTimeLimit then
    if self.updateTagTimerId ~= nil then
      TimerManager:StopTimer(self.updateTagTimerId)
      self.updateTagTimerId = nil
    end
    self.updateTagTimerId = TimerManager:StartTimer(latestTime - now + 1, function()
      local shopWindow = UIManager:GetWindow(UIWindowTypeID.ShopMain)
      if shopWindow == nil then
        return
      end
      shopWindow.autoJumpPageId = shopWindow.seletecPageId
      shopWindow:InitShop(shopWindow.seletecShopId)
    end, self, true, false, false)
  end
  self.shopCtrl:RemoveShopTimerCallback(self.__OnTimerRefresh)
  self.ui.obj_GiftTimeLimit:SetActive(false)
  if isPayGift then
    if not self.redDotIsOpen and not self.isHaveNewGift and ishaveTimeLimit then
      self.ui.obj_GiftTimeLimit:SetActive(true)
      self.latestTime = latestTime
      self:RefreshPageTime()
      self.shopCtrl:AddShopTimerCallback(self.__OnTimerRefresh, "pageWithSub")
    end
  else
    self.ui.img_TimeIcon:SetActive(ishaveTimeLimit)
  end
end

function UINShopLeftPageWithSub:RefreshPageTime()
  if self.latestTime == nil or IsNull(self.ui.tex_GiftTimeLimit) then
    return
  end
  local remaindTime = self.latestTime - PlayerDataCenter.timestamp
  if remaindTime < 0 then
    remaindTime = 0
  end
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
  if 0 < d then
    self.ui.tex_GiftTimeLimit:SetIndex(0, tostring(d))
  elseif 0 < h then
    self.ui.tex_GiftTimeLimit:SetIndex(1, tostring(h))
  elseif 0 < m then
    self.ui.tex_GiftTimeLimit:SetIndex(2, tostring(m))
  else
    self.ui.tex_GiftTimeLimit:SetIndex(3, tostring(s))
  end
end

function UINShopLeftPageWithSub:RefreshNewGiftTag4Page(isHaveRed)
  self.isHaveNewGift = false
  self.ui.obj_NewGift:SetActive(false)
  for i, shopId in ipairs(self.subIds) do
    if self.payGiftCtrl:CheckPageIdIsGiftShop(shopId) then
      local isHaveNewGift = self.payGiftCtrl:IsHaveNewGiftInShop(shopId)
      if not IsNull(self.ui.obj_NewGift) then
        self.ui.obj_NewGift:SetActive(isHaveNewGift and not isHaveRed)
      end
      if isHaveNewGift then
        self.ui.blueDot:SetActive(false)
        self.isHaveNewGift = true
        break
      end
    end
  end
  self:RefreshTimelimitTag4PageWithSub()
end

function UINShopLeftPageWithSub:OnDelete()
  if self.updateTagTimerId ~= nil then
    TimerManager:StopTimer(self.updateTagTimerId)
    self.updateTagTimerId = nil
  end
  self.shopCtrl:RemoveShopTimerCallback(self.__OnTimerRefresh)
  self.subPool:DeleteAll()
  base.OnDelete(self)
end

return UINShopLeftPageWithSub
