local UILotteryExchange = class("UILotteryExchange", UIBaseWindow)
local base = UIBaseWindow
local UINLtrPtNode = require("Game.Lottery.UI.PtNode.UINLtrPtNode")
local UINLtrSHNode = require("Game.Lottery.UI.SelectHero.UINLtrSHNode")
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease

function UILotteryExchange:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction)
  self.ltrPtNode = UINLtrPtNode.New()
  self.ltrPtNode:Init(self.ui.exchangeNode)
  self.ltrPtNode:Hide()
  self.ltrSHNode = UINLtrSHNode.New()
  self.ltrSHNode:Init(self.ui.selectHeroNode)
  self.ltrSHNode:Hide()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.Close)
end

function UILotteryExchange:ShowLtrPtNode(curPoolData, ltrCtrl)
  self.ltrPtNode:InitLtrPtNode(curPoolData, ltrCtrl)
  self.ui.resourceItem:SetActive(true)
  self.ltrPtNode:Show()
  self.ltrPtNode:BindCloseFun(function()
    self:Close()
  end)
end

function UILotteryExchange:HideLtrPtNode()
  self.ltrPtNode:Hide()
end

function UILotteryExchange:ShowLtrSHNode(itemId, curHeroCfg, ltrCfg, ltrCtrl)
  self.ltrSHNode:InitLtrSHNode(itemId, curHeroCfg, ltrCfg, ltrCtrl)
  self.ui.resourceItem:SetActive(false)
  self.ltrSHNode:Show()
  self.ltrSHNode:BindCloseFun(function()
    self:Close()
  end)
end

function UILotteryExchange:HideLtrSHNode()
  self.ltrSHNode:Hide()
end

function UILotteryExchange:BackAction()
  self:Delete()
end

function UILotteryExchange:Close()
  UIUtil.OnClickBackByUiTab(self.ltrPtNode)
  UIUtil.OnClickBackByUiTab(self.ltrSHNode)
  UIUtil.OnClickBackByUiTab(self)
end

function UILotteryExchange:OnDelete()
  if self.ltrPtNode ~= nil then
    self.ltrPtNode:Delete()
  end
  if self.ltrSHNode ~= nil then
    self.ltrSHNode:Delete()
  end
  base.Delete(self)
end

return UILotteryExchange
