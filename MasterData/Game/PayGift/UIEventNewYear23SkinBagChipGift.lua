local UIChipGift = require("Game.PayGift.UIChipGift")
local UIEventNewYear23SkinBagChipGift = class("UIEventNewYear23SkinBagChipGift", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local CS_Resloader = CS.ResLoader
local CS_MessageCommon = CS.MessageCommon
local JumpManager = require("Game.Jump.JumpManager")

function UIEventNewYear23SkinBagChipGift:OnInit()
  UIUtil.SetTopStatus(self, self.OnBackChipGift, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickCloseBtn)
  UIUtil.AddButtonListener(self.ui.backGround, self, self.OnClickCloseBtn)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnClickBuy)
  UIUtil.AddValueChangedListener(self.ui.tog_Popup, self, self.OnTogIgnore)
  self._itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.obj_item)
  self.ui.obj_item:SetActive(false)
  self._lastCouldUseItemJump = JumpManager.couldUseItemJump
  JumpManager.couldUseItemJump = false
end

function UIEventNewYear23SkinBagChipGift:InitSkinBag(giftInfo, callback)
  self._giftInfo = giftInfo
  self._callback = callback
  self.rewardIds = self._giftInfo.defaultCfg.awardIds
  self.rewardCounts = self._giftInfo.defaultCfg.awardCounts
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  local flag, _, endTime = self._giftInfo:IsUnlockTimeCondition()
  if flag and 0 < endTime then
    self.ui.time:SetActive(true)
    self.timerId = TimerManager:StartTimer(1, function()
      self:__RefreshTime()
    end, self)
    self:__RefreshTime()
  else
    self.ui.time:SetActive(false)
  end
  local payId = self._giftInfo.defaultCfg.payId
  local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay)
  local priceStr, priceNum = payCtrl:GetPayPriceShow(payId)
  self.ui.tex_Price.text = priceStr
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(self._giftInfo.groupCfg.des)
  self._itemPool:HideAll()
  local itemId = 0
  local itemNum = 0
  for iIndex = 1, #self.rewardIds do
    itemId = self.rewardIds[iIndex]
    itemNum = self.rewardCounts[iIndex]
    local itemCfg = ConfigData.item[itemId]
    local item = self._itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemNum, nil)
  end
end

function UIEventNewYear23SkinBagChipGift:__RefreshTime()
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

function UIEventNewYear23SkinBagChipGift:OnClickBuy()
  if not self._giftInfo:IsUnlock() then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(7208))
    return
  end
  local giftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  giftCtrl:SendBuyGifit(self._giftInfo.defaultCfg, nil, function()
    self:OnClickCloseBtn()
  end)
end

function UIEventNewYear23SkinBagChipGift:OnTogIgnore(value)
  self.ui.img_Select:SetActive(value)
end

function UIEventNewYear23SkinBagChipGift:OnClickCloseBtn()
  UIUtil.OnClickBackByUiTab(self)
end

function UIEventNewYear23SkinBagChipGift:OnBackChipGift()
  if self.ui.tog_Popup.isOn then
    local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    userData:SetChipGiftPopIgnore(self._giftInfo.groupCfg.id, PlayerDataCenter.timestamp)
  end
  self:Delete()
  if self._callback ~= nil then
    self._callback()
  end
end

function UIEventNewYear23SkinBagChipGift:OnDelete()
  base.OnDelete(self)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  JumpManager.couldUseItemJump = self._lastCouldUseItemJump
end

return UIEventNewYear23SkinBagChipGift
