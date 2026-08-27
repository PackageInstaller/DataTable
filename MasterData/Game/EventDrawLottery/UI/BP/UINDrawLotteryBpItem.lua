local UINDrawLotteryBpItem = class("UINDrawLotteryBpItem", UIBaseNode)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local base = UIBaseNode

function UINDrawLotteryBpItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived, false)
  UIUtil.AddButtonListener(self.ui.btn_bk, self, self.OnClickBk)
end

function UINDrawLotteryBpItem:InitDrawLotteryBpItem(cfg, isPicked, canPick, callback, nextCfg, nowNum, lastCfg)
  self.cfg = cfg
  self.isPicked = isPicked
  self.canPick = canPick
  self.callback = callback
  self.nextCfg = nextCfg
  self.nowNum = nowNum
  self.lastCfg = lastCfg
  self:RefreshDrawLotteryBpItem()
end

function UINDrawLotteryBpItem:RefreshDrawLotteryBpItem()
  self.ui.img_Bottom.color = not (not self.canPick or self.isPicked) and self.ui.col_picked or self.ui.col_noPicked
  self.ui.tex_Num.text = tostring(self.cfg.stage_score)
  self.ui.tex_Num.color = self.canPick and self.ui.col_complete or self.ui.col_noComplete
  self.ui.img_Arrow.color = self.canPick and self.ui.col_complete or self.ui.col_noComplete
  self.ui.obj_Selected:SetActive(self.canPick and not self.isPicked)
  self.rewardPool:HideAll()
  for id, num in pairs(self.cfg.stage_reward) do
    local item = self.rewardPool:GetOne(true)
    local itemCfg = ConfigData.item[id]
    item:InitItemWithCount(itemCfg, num, nil, self.isPicked)
  end
  local fillAmountLeft, fillAmountRight = self:__GetDivergentFillAmount()
  self.ui.img_FillLeft.fillAmount = fillAmountLeft
  self.ui.obj_rightBar:SetActive(0 <= fillAmountRight)
  if 0 <= fillAmountRight then
    self.ui.img_FillRight.fillAmount = fillAmountRight
  end
end

function UINDrawLotteryBpItem:__GetDivergentFillAmount()
  if self.nowNum >= self.cfg.stage_score and self.nextCfg and self.nowNum >= self.nextCfg.stage_score then
    return 1, 1
  end
  local lastNum = self.lastCfg and self.lastCfg.stage_score or 0
  local nextNum = self.nextCfg and self.nextCfg.stage_score or self.cfg.stage_score
  local leftEdge, rightEdge = self:__GetDivergentProgressBarEdge(lastNum, nextNum)
  local fillAmountLeft = (self.nowNum - leftEdge) / (self.cfg.stage_score - leftEdge)
  local fillAmountRight = self.cfg.stage_score == rightEdge and -1 or self.nowNum < self.cfg.stage_score and 0 or (self.nowNum - self.cfg.stage_score) / (rightEdge - self.cfg.stage_score)
  return fillAmountLeft, fillAmountRight
end

function UINDrawLotteryBpItem:__GetDivergentProgressBarEdge(lastNum, nextNum)
  local leftEdge = 0
  local rightEdge = 0
  local leftRate = lastNum == 0 and 0 or 0.5
  leftEdge = (self.cfg.stage_score - lastNum) * leftRate + lastNum
  rightEdge = nextNum == self.cfg.stage_score and nextNum or (nextNum - self.cfg.stage_score) * 0.5 + self.cfg.stage_score
  return leftEdge, rightEdge
end

function UINDrawLotteryBpItem:OnClickBk()
  if self.callback then
    self.callback(self.cfg.stage)
  end
end

function UINDrawLotteryBpItem:OnDelete()
  self.rewardPool:DeleteAll()
end

return UINDrawLotteryBpItem
