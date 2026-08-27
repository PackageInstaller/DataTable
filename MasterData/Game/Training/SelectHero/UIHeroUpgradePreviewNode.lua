local UIHeroUpgradePreviewNode = class("UIHeroUpgradePreviewNode", UIBaseNode)
local base = UIBaseNode
local UINHeroAttrItem = require("Game.Hero.Common.UINHeroAttrItem")

function UIHeroUpgradePreviewNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.attriDetail_Item:SetActive(false)
  self.listAttr = {}
end

function UIHeroUpgradePreviewNode:InitHeroData(heroData)
  self.heroData = heroData
  self:RefreshHeroData()
  self:RefreshNextExp(0)
end

function UIHeroUpgradePreviewNode:RefreshHeroData()
  for k, v in ipairs(eHeroShowAttrList) do
    local value = self.heroData:GetAttr(v)
    local item = self.listAttr[v]
    if item == nil then
      local go = self.ui.attriDetail_Item:Instantiate()
      go:SetActive(true)
      item = UINHeroAttrItem.New()
      item:Init(go.transform)
      self.listAttr[v] = item
    end
    item:InitAttr(v, value)
  end
  self.ui.img_Exp.fillAmount = self.heroData.expRatio
  self.ui.tex_Level:SetIndex(0, tostring(self.heroData.level))
end

function UIHeroUpgradePreviewNode:RefreshNextExp(addExp)
  if 0 < addExp then
    self.ui.tex_ExpNum.text = "+" .. tostring(addExp)
  else
    self.ui.tex_ExpNum.text = ""
  end
  local curLevel = self.heroData.level
  local nextLevel, nextExp, nextTotalExp = self.heroData:AddTestExp(addExp)
  local totalExp = self.heroData:GetLevelTotalExp()
  local fillAmount = 0
  if curLevel < nextLevel then
    self.ui.tex_Level:SetIndex(1, tostring(nextLevel))
    fillAmount = 1
  else
    self.ui.tex_Level:SetIndex(0, tostring(curLevel))
    fillAmount = nextExp / totalExp
  end
  self.ui.img_ExpAdd.fillAmount = fillAmount
end

function UIHeroUpgradePreviewNode:OnDelete()
  base.OnDelete(self)
end

return UIHeroUpgradePreviewNode
