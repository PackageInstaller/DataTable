local base = UIBaseNode
local UINComRankReward = class("UINComRankReward", base)
local UINComRankRewardItem = require("Game.CommonUI.Rank.Reward.UINComRankRewardItem")

function UINComRankReward:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._rewardItemPool = UIItemPool.New(UINComRankRewardItem, self.ui.obj_rank, false)
  self._resLoader = CS.ResLoader.Create()
end

function UINComRankReward:InitComRankReward(rankRewardCfg, rankPercent)
  local curRankItem
  self._rewardItemPool:HideAll()
  for idx, cfg in ipairs(rankRewardCfg) do
    local item = self._rewardItemPool:GetOne()
    item:InitComRankRewardItem(cfg, self._resLoader)
    if curRankItem == nil and rankPercent ~= nil and 0 < rankPercent and rankPercent / 100 <= cfg.percent then
      curRankItem = item
    end
  end
  if curRankItem then
    curRankItem:ShowComRankRewardItemIsCur(true)
  end
end

function UINComRankReward:OnDelete()
  self._rewardItemPool:DeleteAll()
  self._resLoader:Put2Pool()
  self._resLoader = nil
  base.OnDelete(self)
end

return UINComRankReward
