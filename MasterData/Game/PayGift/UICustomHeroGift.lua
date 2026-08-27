local UICustomHeroGift = class("UICustomHeroGift", UIBaseWindow)
local base = UIBaseWindow
local UINCustomHeroGiftNode = require("Game.PayGift.UINCustomHeroGiftNode")
local UINChipGiftRewardItem = require("Game.PayGift.UINChipGiftRewardItem")
local CS_MessageCommon = CS.MessageCommon
local CS_Resloader = CS.ResLoader

function UICustomHeroGift:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnBackHeroSelectGift)
  UIUtil.AddButtonListener(self.ui.background, self, self.OnBackHeroSelectGift)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnClickBuy)
  UIUtil.AddValueChangedListener(self.ui.tog_Popup, self, self.OnTogIgnore)
  self._rewardPool = UIItemPool.New(UINChipGiftRewardItem, self.ui.rewardItem)
  self.ui.rewardItem:SetActive(false)
  self._selectHeroItem = UINCustomHeroGiftNode.New()
  self._selectHeroItem:Init(self.ui.heroSelectItem)
  self._selectHeroItem:BindGiftHeroSelectCallback(BindCallback(self, self.OnClickSelectHero))
end

function UICustomHeroGift:InitCustomHeroGift(giftInfo, callback)
  self._giftInfo = giftInfo
  self._callback = callback
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.resloader = CS_Resloader.Create()
  self._isHeroSelct = self._giftInfo:IsSelfSelectHeroGift()
  local flag, _, times = self._giftInfo:GetLimitBuyCount()
  self.ui.limit:SetActive(flag)
  if flag then
    self.ui.tex_limit:SetIndex(0, tostring(times))
  end
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  local flag, _, endTime = self._giftInfo:IsUnlockTimeCondition()
  if flag and 0 < endTime then
    self.ui.time:SetActive(true)
    self._timerId = TimerManager:StartTimer(1, function()
      self:__RefreshTime()
    end, self)
    self:__RefreshTime()
  else
    self.ui.time:SetActive(false)
  end
  self.ui.tex_giftName.text = LanguageUtil.GetLocaleText(self._giftInfo.groupCfg.name)
  self.ui.tex_des.text = LanguageUtil.GetLocaleText(self._giftInfo.groupCfg.des)
  if self._giftInfo:IsUseItemPay() then
    self.ui.img_icon.gameObject:SetActive(true)
    CRH:GetSpriteByItemId(self._giftInfo.defaultCfg.costId)
    self.ui.tex_price.text = tostring(self._giftInfo.defaultCfg.costCount)
  else
    self.ui.img_icon.gameObject:SetActive(false)
    local payId = self._giftInfo.defaultCfg.payId
    local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay)
    local priceStr, priceNum = payCtrl:GetPayPriceShow(payId)
    self.ui.tex_price.text = priceStr
  end
  self:__GenRewardList()
  local path = self._giftInfo.groupCfg.pop_bg_res
  if not string.IsNullOrEmpty(path) then
    self.ui.bg.gameObject:SetActive(false)
    self.resloader:LoadABAssetAsync(PathConsts:GetGiftPopBg(path), function(texture)
      if not IsNull(self.transform) then
        self.ui.bg.texture = texture
        self.ui.bg.gameObject:SetActive(true)
      end
    end)
  end
end

function UICustomHeroGift:__RefreshTime()
  local _, _, endTime = self._giftInfo:IsUnlockTimeCondition()
  local diff = endTime - PlayerDataCenter.timestamp
  if diff <= 0 then
    if self.timerId ~= nil then
      TimerManager:StopTimer(self.timerId)
      self.timerId = nil
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

function UICustomHeroGift:__GenRewardList()
  self:RefreshcCustomNode()
  local rewardIds = self._giftInfo.defaultCfg.awardIds
  local rewardCounts = self._giftInfo.defaultCfg.awardCounts
  self._rewardPool:HideAll()
  for i, itemId in ipairs(rewardIds) do
    local count = rewardCounts[i]
    local item = self._rewardPool:GetOne()
    item:InitChipGiftReward(itemId, count)
  end
end

function UICustomHeroGift:OnClickBuy()
  if not self._giftInfo:IsUnlock() then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(7208))
    return
  end
  if not self._giftInfo:GetSelfSelectGiftIsSelected() then
    if self._isHeroSelct then
      CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(418))
    else
      CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(419))
    end
    return
  end
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
  local paramList = self._giftInfo:GetSelfSelectGiftParams()
  payGiftCtrl:SendBuyGifit(self._giftInfo.defaultCfg, paramList, function()
    if not IsNull(self.transform) then
      UIUtil.OnClickBackByUiTab(self)
    end
  end)
end

function UICustomHeroGift:OnClickSelectHero()
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
  payGiftCtrl:SelfSelectGift(self._giftInfo.defaultCfg, self._giftInfo, function()
    self:RefreshcCustomNode()
  end)
end

function UICustomHeroGift:RefreshcCustomNode()
  local params = self._giftInfo:GetSelfSelectGiftParams()
  local selectHeroId = params ~= nil and params[1].param or nil
  if self._isHeroSelct then
    self._selectHeroItem:RefreshCustomHeroGiftSelect(selectHeroId)
  else
    local selfSelectCfg = ConfigData.customized_gift[self._giftInfo.defaultCfg.param]
    self._selectHeroItem:RefreshCustomChipGiftSelect(selectHeroId, selfSelectCfg)
  end
end

function UICustomHeroGift:OnTogIgnore(value)
  self.ui.img_Select:SetActive(value)
end

function UICustomHeroGift:BackAction()
  if self.ui.tog_Popup.isOn then
    local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    userData:SetChipGiftPopIgnore(self._giftInfo.groupCfg.id, PlayerDataCenter.timestamp)
  end
  self._giftInfo:CleanSelfSelectInfo()
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UICustomHeroGift:OnBackHeroSelectGift()
  UIUtil.OnClickBackByUiTab(self)
end

function UICustomHeroGift:OnDelete()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UICustomHeroGift
