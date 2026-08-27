local UINFairyUpgradeTipItem = class("UINFairyUpgradeTipItem", UIBaseNode)
local base = UIBaseNode

function UINFairyUpgradeTipItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFairyUpgradeTipItem:InitFairyUpgradeTipItem(tipIndex, fairyData, isComplete, fromLv, skillNum)
  self.ui.tex_Text:SetIndex(tipIndex)
  self.ui.tex_lvlUpBefore.gameObject:SetActive(false)
  self.ui.obj_arrow:SetActive(false)
  if tipIndex == 0 then
    self.ui.tex_lvlUpBefore.gameObject:SetActive(true)
    self.ui.obj_arrow:SetActive(true)
    local lastLevel = isComplete and fairyData:GetLastMaxLevel() or fairyData:GetFairyCurLevel()
    if fromLv ~= nil then
      lastLevel = fromLv
    end
    local nextLevel = isComplete and fairyData:GetCurStarMaxLevel() or fairyData:GetNextMaxLevel()
    self.ui.tex_lvlUpBefore.text = lastLevel
    self.ui.tex_lvlUpAfter.text = nextLevel
  else
    self.ui.tex_lvlUpAfter.text = "+" .. tostring(skillNum or 1)
  end
end

function UINFairyUpgradeTipItem:OnDelete()
  base.OnDelete(self)
end

return UINFairyUpgradeTipItem
