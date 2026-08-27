local UIEventOptionalGift = class("UIEventOptionalGift", UIBaseWindow)
local base = UIBaseWindow
local UINEventOptionalGift = require("Game.EventOptionalGift.UINEventOptionalGift")
local UINEventOptionGiftSelect = require("Game.EventOptionalGift.UINEventOptionGiftSelect")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")

function UIEventOptionalGift:OnInit()
  UIUtil.AddButtonListener(self.ui.tip, self, self.OnClickTip)
  self._itemPool = UIItemPool.New(UINEventOptionalGift, self.ui.giftItem)
  self.ui.giftItem:SetActive(false)
  self.__OnSelectCallback = BindCallback(self, self.__OnSelect)
  self.__RefreshGiftChangeCallback = BindCallback(self, self.__RefreshGiftChange)
  MsgCenter:AddListener(eMsgEventId.PayGiftChange, self.__RefreshGiftChangeCallback)
end

function UIEventOptionalGift:InitEventOptionalGift(id)
  local eventMainWin = UIManager:GetWindow(UIWindowTypeID.ActivityFrameMain)
  if eventMainWin then
    UIUtil.RefreshTopResId({
      ConstGlobalItem.PaidItem,
      ConstGlobalItem.PaidSubItem
    }, nil, nil, eventMainWin)
  end
  self._actGiftCfg = ConfigData.activity_gift[id]
  local actFrame = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._actInfo = actFrame:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.Gift, id)
  self.ui.tex_GiftName.text = tostring(self._actInfo:GetActivityFrameName())
  self.ui.tex_Number:SetIndex(0, ConfigData:GetTipContent(self._actGiftCfg.subtitle))
  self.ui.tex_Des.text = ConfigData:GetTipContent(self._actGiftCfg.desc)
  local _, timeStr = ActivityFrameUtil.GetShowEndTimeStr(self._actInfo)
  self.ui.tex_Time.text = timeStr
  self._itemPool:HideAll()
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
  for i, giftId in ipairs(self._actGiftCfg.giftlist) do
    local payGiftInfo = payGiftCtrl:GetPayGiftDataById(giftId)
    local item = self._itemPool:GetOne()
    payGiftInfo:CleanSelfSelectInfo()
    item:InitOptionalGift(payGiftInfo, self.__OnSelectCallback)
  end
  self._ruleId = ConfigData.activity[self._actInfo:GetActivityFrameId()].rule_id
end

function UIEventOptionalGift:OnClickTip()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(win)
    if win ~= nil then
      win:InitCommonInfoByRule(self._ruleId, true)
    end
  end)
end

function UIEventOptionalGift:__OnSelect(payGiftInfo, item)
  if self._selectWindow == nil then
    self.ui.window:SetActive(true)
    self._selectWindow = UINEventOptionGiftSelect.New()
    self._selectWindow:Init(self.ui.window)
  end
  self._selectWindow:Show()
  self._selectWindow:InitEventOptionGiftSelect(payGiftInfo, function(payGiftInfo, itemIds, itemNums)
    local params = {}
    for i, itemId in ipairs(itemIds) do
      table.insert(params, {param = itemId})
    end
    payGiftInfo:SetSelfSelectInfo(itemIds, itemNums, params)
    item:RefreshOptionalGift()
  end)
end

function UIEventOptionalGift:__RefreshGiftChange()
  local reddot = self._actInfo:GetActivityReddotNode()
  local reddoutCount = 0
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
  for i, giftid in ipairs(self._actGiftCfg.giftlist) do
    local gift = payGiftCtrl:GetPayGiftDataById(giftid)
    if gift ~= nil and not gift:IsSoldOut() and gift:IsFreeGift() then
      reddoutCount = 1
      break
    end
  end
  reddot:SetRedDotCount(reddoutCount)
end

function UIEventOptionalGift:OnDelete()
  local eventMainWin = UIManager:GetWindow(UIWindowTypeID.ActivityFrameMain)
  if eventMainWin then
    UIUtil.RefreshTopResId(nil, nil, nil, eventMainWin)
  end
  MsgCenter:RemoveListener(eMsgEventId.PayGiftChange, self.__RefreshGiftChangeCallback)
  base.OnDelete(self)
end

return UIEventOptionalGift
