local UINLtrPoolUpRate = class("UINLtrPoolUpRate", UIBaseNode)
local base = UIBaseNode
local UINLtrPoolUpHero = require("Game.Lottery.UI.PoolDetail.UpRate.UINLtrPoolUpHero")

function UINLtrPoolUpRate:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.obj_rateHeroItem:SetActive(false)
  self.heroItemPool = UIItemPool.New(UINLtrPoolUpHero, self.ui.obj_rateHeroItem)
end

function UINLtrPoolUpRate:InitLtrPoolUpRate(heroRewardList, resLoader)
  local rewardDataList = {}
  for k, rewardData in ipairs(heroRewardList) do
    local star = rewardData.rankCfg.star
    local count = math.ceil(star / 2)
    if 3 <= count then
      table.insert(rewardDataList, rewardData)
    end
  end
  table.sort(rewardDataList, function(a, b)
    if a.upHero ~= b.upHero then
      return false
    end
    return a.heroCfg.id < b.heroCfg.id
  end)
  self.heroItemPool:HideAll()
  for k, v in ipairs(rewardDataList) do
    local heroItem = self.heroItemPool:GetOne()
    heroItem:InitLtrPoolUpHero(v, resLoader)
  end
end

function UINLtrPoolUpRate:OnDelete()
  self.heroItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINLtrPoolUpRate
