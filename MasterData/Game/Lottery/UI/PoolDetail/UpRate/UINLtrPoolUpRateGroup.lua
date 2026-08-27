local UINLtrPoolUpRateGroup = class("UINLtrPoolUpRateGroup", UIBaseNode)
local base = UIBaseNode
local UINLtrPoolUpHero = require("Game.Lottery.UI.PoolDetail.UpRate.UINLtrPoolUpHero")

function UINLtrPoolUpRateGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.heroItem:SetActive(false)
  self.heroItemPool = UIItemPool.New(UINLtrPoolUpHero, self.ui.heroItem)
  self.ui.img_star.gameObject:SetActive(false)
  self.starItemList = {}
end

function UINLtrPoolUpRateGroup:InitLtrPoolUpRateGroup(rewardDataList, star, ratio, resLoader)
  self:__HideAllStar()
  self:__UpdateStar(star)
  self.ui.tex_Describe:SetIndex(0, tostring(star // 2), tostring(ratio // 100))
  table.sort(rewardDataList, function(a, b)
    return a.heroCfg.id < b.heroCfg.id
  end)
  self.heroItemPool:HideAll()
  for k, v in ipairs(rewardDataList) do
    local heroItem = self.heroItemPool:GetOne()
    heroItem:InitLtrPoolUpHero(v, resLoader)
  end
end

function UINLtrPoolUpRateGroup:__UpdateStar(starCount)
  local twoStarCount = starCount // 2
  local oneStarCount = starCount % 2
  for i = 1, twoStarCount do
    local starItem = self:__GetStar(i)
    starItem:SetIndex(0)
  end
  if oneStarCount ~= 0 then
    local starItem = self:__GetStar(twoStarCount + 1)
    starItem:SetIndex(1)
  end
end

function UINLtrPoolUpRateGroup:__GetStar(index)
  local starItem = self.starItemList[index]
  if starItem == nil then
    starItem = self.ui.img_star:Instantiate()
    self.starItemList[index] = starItem
  end
  starItem.gameObject:SetActive(true)
  return starItem
end

function UINLtrPoolUpRateGroup:__HideAllStar()
  for k, v in pairs(self.starItemList) do
    v.gameObject:SetActive(false)
  end
end

function UINLtrPoolUpRateGroup:OnDelete()
  self.heroItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINLtrPoolUpRateGroup
