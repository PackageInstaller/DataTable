local UINFairyRecommendNode = class("UINFairyRecommendNode", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")

function UINFairyRecommendNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, function()
    self:Hide()
    UIUtil.ReShowTopStatus()
  end)
  self.heroHeadPool = UIItemPool.New(UINHeroHeadItem, self.ui.obj_heroHeadItem, false)
end

function UINFairyRecommendNode:InitNFairyRecommendNode(fairyData, resloader)
  self:Show()
  self.ui.tex_recommendTitle:SetIndex(0, fairyData:GetFairyCurName(true))
  local heroIdList = {}
  for heroId, v in pairs(ConfigData.hero_data.totalFairySuggestDic[fairyData:GetFairyID()]) do
    table.insert(heroIdList, heroId)
  end
  table.sort(heroIdList)
  for i, heroId in ipairs(heroIdList) do
    local heroItem = self.heroHeadPool:GetOne()
    local isHas = PlayerDataCenter.heroDic[heroId] ~= nil
    heroItem:InitHeroHeadItemWithId(heroId)
    heroItem:SetHeroHeadLock(not isHas)
  end
end

function UINFairyRecommendNode:OnHide()
  self.heroHeadPool:HideAll()
end

function UINFairyRecommendNode:OnDelete()
end

return UINFairyRecommendNode
