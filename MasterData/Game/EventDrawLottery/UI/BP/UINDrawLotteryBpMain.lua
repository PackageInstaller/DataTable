local UINDrawLotteryBpMain = class("UINDrawLotteryBpMain", UIBaseNode)
local UINDrawLotteryBpItem = require("Game.EventDrawLottery.UI.BP.UINDrawLotteryBpItem")
local base = UIBaseNode

function UINDrawLotteryBpMain:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.bpItemPool = UIItemPool.New(UINDrawLotteryBpItem, self.ui.bpItem, false)
end

function UINDrawLotteryBpMain:InitDrawLotteryBpMain(actData, clickCallback)
  self.actData = actData
  self.clickCallback = clickCallback
end

function UINDrawLotteryBpMain:RefreshDrawLotteryBpList()
  local nowNum = self.actData:GetDrawLotteryScore()
  local maxNum = self.actData:GetDrawLotteryMaxScore()
  self.bpItemPool:HideAll()
  local cfgList = self.actData:GetDrawLotteryRewardCfg()
  for id, cfg in ipairs(cfgList) do
    local item = self.bpItemPool:GetOne()
    item:InitDrawLotteryBpItem(cfg, self.actData:GetDrawLotteryStageIsPicked(id), nowNum >= cfg.stage_score, self.clickCallback, cfgList[id + 1], nowNum, cfgList[id - 1])
  end
  local itemId = self.actData:GetDrawLotteryScoreItemId()
  self.ui.img_IconPic.sprite = CRH:GetSpriteByItemId(itemId)
  self.ui.tex_Num.text = nowNum < maxNum and tostring(nowNum) or "MAX"
end

function UINDrawLotteryBpMain:OnDelete()
  self.bpItemPool:DeleteAll()
end

return UINDrawLotteryBpMain
