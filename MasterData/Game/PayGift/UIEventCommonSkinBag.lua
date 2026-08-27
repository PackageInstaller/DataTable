local UIChipGift = require("Game.PayGift.UIChipGift")
local UIEventCommonSkinBagChipGift = class("UIEventCommonSkinBagChipGift", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local CS_ResLoader = CS.ResLoader
local CS_MessageCommon = CS.MessageCommon
local JumpManager = require("Game.Jump.JumpManager")

function UIEventCommonSkinBagChipGift:OnInit()
  UIUtil.SetTopStatus(self, self.OnBackChipGift, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_close, self, self.OnClickBtnClose)
  UIUtil.AddButtonListener(self.ui.background, self, self.OnClickBtnClose)
  UIUtil.AddButtonListener(self.ui.btn_buy, self, self.OnClickBtnBuy)
  UIUtil.AddValueChangedListener(self.ui.tog_popup, self, self.OnToggleIgnore)
  self._itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.obj_item)
  self.ui.obj_item:SetActive(false)
  self.resLoader = CS_ResLoader.Create()
  self._lastCouldUseItemJump = JumpManager.couldUseItemJump
  JumpManager.couldUseItemJump = false
end

function UIEventCommonSkinBagChipGift:InitSkinBag(giftInfo, callback)
  self._giftInfo = giftInfo
  self._callback = callback
  self._rewardIds = self._giftInfo.defaultCfg.awardIds
  self._rewardCounts = self._giftInfo.defaultCfg.awardCounts
  local giftName = LanguageUtil.GetLocaleText(self._giftInfo.groupCfg.name)
  local strLen = string.len(giftName)
  local nameStr1 = string.sub(giftName, 1, strLen - ConfigData.game_config.skinBagTitleSplitNum)
  local nameStr2 = string.sub(giftName, string.len(nameStr1) + 1, strLen)
  self.ui.tex_bagName.text = nameStr1 .. "\n" .. nameStr2
  local path = self._giftInfo.groupCfg.pop_bg_res
  if not string.IsNullOrEmpty(path) then
    self.ui.bg.gameObject:SetActive(false)
    self.resLoader:LoadABAssetAsync(PathConsts:GetGiftPopBg(path), function(texture)
      if not IsNull(self.transform) then
        self.ui.bg.texture = texture
        self.ui.bg.gameObject:SetActive(true)
      end
    end)
  end
  local colorStr = self._giftInfo.groupCfg.pop_color
  if not string.IsNullOrEmpty(colorStr) then
    local color = ColorUtil.FromHexUnit(colorStr)
    self.ui.img_artWord.color = color
    self.ui.img_frame.color = color
    self.ui.img_buy.color = color
    self.ui.img_topBg.color = color
    self.ui.img_line1.color = color
    local alpha = self.ui.img_line2.color.a
    color.a = alpha
    self.ui.img_line2.color = color
    alpha = self.ui.img_line3.color.a
    color.a = alpha
    self.ui.img_line3.color = color
  end
  if self._timer ~= nil then
    TimerManager:StopTimer(self._timer)
    self._timer = nil
  end
  local flag, _, endTime = self._giftInfo:IsUnlockTimeCondition()
  if flag and 0 < endTime then
    self.ui.time:SetActive(true)
    self._timer = TimerManager:StartTimer(1, function()
      self:__RefreshTime()
    end, self)
    self:__RefreshTime()
  else
    self.ui.time:SetActive(false)
  end
  local limitType = self._giftInfo.defaultCfg.limit_type
  if type(limitType) ~= "number" or limitType < 1 or 4 < limitType then
    self.ui.obj_limitTag:SetActive(false)
  else
    self.ui.obj_limitTag:SetActive(true)
    local _, times, limitTimes = self._giftInfo:GetLimitBuyCount()
    self.ui.text_limitTimes:SetIndex(0, tostring(limitTimes - times))
  end
  local isUseItemPay = self._giftInfo:IsUseItemPay()
  self.ui.tex_useCurrencyPrice.gameObject:SetActive(not isUseItemPay)
  self.ui.obj_itemPrice:SetActive(isUseItemPay)
  if isUseItemPay then
    local costId = self._giftInfo.defaultCfg.costId
    local costCount = self._giftInfo.defaultCfg.costCount
    local itemCfg = ConfigData.item[costId]
    self.ui.img_item.sprite = CRH:GetSprite(itemCfg.small_icon)
    self.ui.tex_useItemPrice.text = tostring(costCount)
  else
    local payId = self._giftInfo.defaultCfg.payId
    local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay)
    local priceStr, priceNum = payCtrl:GetPayPriceShow(payId)
    self.ui.tex_useCurrencyPrice.text = priceStr
  end
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(self._giftInfo.groupCfg.des)
  self._itemPool:HideAll()
  local itemId = 0
  local itemNum = 0
  for iIndex = 1, #self._rewardIds do
    itemId = self._rewardIds[iIndex]
    itemNum = self._rewardCounts[iIndex]
    local itemCfg = ConfigData.item[itemId]
    local item = self._itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemNum, nil)
  end
end

function UIEventCommonSkinBagChipGift:__RefreshTime()
  local _, _, endTime = self._giftInfo:IsUnlockTimeCondition()
  local diff = endTime - PlayerDataCenter.timestamp
  if diff <= 0 then
    if self._timer ~= nil then
      TimerManager:StopTimer(self._timer)
      self._timer = nil
    end
    self.ui.tex_Time:SetIndex(3, "0")
    return
  end
  local d = math.floor(diff / 86400)
  diff = diff % 86400
  local h = math.floor(diff / 3600)
  diff = diff % 3600
  local m = math.floor(diff / 60)
  local s = math.floor(diff % 60)
  if 0 < d then
    self.ui.tex_Time:SetIndex(0, tostring(d), tostring(h), tostring(m))
  elseif 0 < h then
    self.ui.tex_Time:SetIndex(1, tostring(h), tostring(m))
  elseif 0 < m then
    self.ui.tex_Time:SetIndex(2, tostring(m), tostring(s))
  else
    self.ui.tex_Time:SetIndex(3, tostring(s))
  end
end

function UIEventCommonSkinBagChipGift:OnClickBtnBuy()
  if not self._giftInfo:IsUnlock() then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(7208))
    return
  end
  local giftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  giftCtrl:SendBuyGifit(self._giftInfo.defaultCfg, nil, function()
    self:OnClickBtnClose()
  end)
end

function UIEventCommonSkinBagChipGift:OnToggleIgnore(value)
  self.ui.img_Select:SetActive(value)
end

function UIEventCommonSkinBagChipGift:OnClickBtnClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIEventCommonSkinBagChipGift:OnBackChipGift()
  if self.ui.tog_popup.isOn then
    local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    userData:SetChipGiftPopIgnore(self._giftInfo.groupCfg.id, PlayerDataCenter.timestamp)
  end
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UIEventCommonSkinBagChipGift:OnDelete()
  base.OnDelete(self)
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  if self._timer ~= nil then
    TimerManager:StopTimer(self._timer)
    self._timer = nil
  end
  JumpManager.couldUseItemJump = self._lastCouldUseItemJump
end

return UIEventCommonSkinBagChipGift
