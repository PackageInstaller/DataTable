local UINActivityCollectFortuneGiftLotteryNode = class("UINActivityCollectFortuneGiftLotteryNode", UIBaseNode)
local base = UIBaseNode
local UINActivityCollectFortuneGiftNode = require("Game.ActivityCollectFortune.UI.UINActivityCollectFortuneGiftNode")
local UINActivityCollectFortuneLotteryNode = require("Game.ActivityCollectFortune.UI.UINActivityCollectFortuneLotteryNode")
local ActivityCollectFortuneEnum = require("Game.ActivityCollectFortune.Data.ActivityCollectFortuneEnum")

function UINActivityCollectFortuneGiftLotteryNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._giftNode = UINActivityCollectFortuneGiftNode.New()
  self._giftNode:Init(self.ui.GiftNode)
  self._lotteryNode = UINActivityCollectFortuneLotteryNode.New()
  self._lotteryNode:Init(self.ui.LotteryRateNode)
  UIUtil.AddButtonListener(self.ui.Btn_Close, self, self.OnClickBack)
end

function UINActivityCollectFortuneGiftLotteryNode:InitActCollectFortuneGiftLotteryNode(actData, openType, clickFunc, resLoader)
  UIUtil.SetTopStatus(self, self.OnClickBack, nil, nil, nil, true)
  self._actData = actData
  local mainCfg = self._actData:GetActCollectFortuneMainCfg()
  if mainCfg == nil then
    error("cant find activity collectfortune config!!")
    return
  end
  local titleStr = LanguageUtil.GetLocaleText(mainCfg.receive_des)
  self.ui.GiftNode:SetActive(false)
  self.ui.LotteryRateNode:SetActive(false)
  if openType == ActivityCollectFortuneEnum.eGiftLotteryNodeType.Gift then
    self._giftNode:InitCollectFortuneGiftNode(actData, clickFunc, resLoader)
    self.ui.GiftNode:SetActive(true)
  elseif openType == ActivityCollectFortuneEnum.eGiftLotteryNodeType.Lottery then
    self._lotteryNode:InitCollectFortuneLotteryNode(actData)
    self.ui.LotteryRateNode:SetActive(true)
    titleStr = LanguageUtil.GetLocaleText(mainCfg.pool_des)
  end
  self.ui.Tex_Title.text = titleStr
end

function UINActivityCollectFortuneGiftLotteryNode:BindCloseFunc(func)
  self._closeFunc = func
end

function UINActivityCollectFortuneGiftLotteryNode:OnClickBack()
  if self._closeFunc ~= nil then
    self._closeFunc(self.gameObject)
  end
  self:Hide()
  UIUtil.PopFromBackStackByUiTab(self)
end

function UINActivityCollectFortuneGiftLotteryNode:OnDelete()
  base.OnDelete(self)
end

return UINActivityCollectFortuneGiftLotteryNode
