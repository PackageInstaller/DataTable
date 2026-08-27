local UIPie = class("UIPie", UIBaseNode)
local base = UIBaseNode
local UIPieItem = require("Game.BattleResult.Pie.UIPieItem")
local UIPieText = require("Game.BattleResult.Pie.UIPieText")

function UIPie:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.pieValueItem:SetActive(false)
  self.ui.tex_Rate:SetActive(false)
  self.pieItemPool = UIItemPool.New(UIPieItem, self.ui.pieValueItem)
  self.pieTextPool = UIItemPool.New(UIPieText, self.ui.tex_Rate)
end

function UIPie:InitPie(proportionTab)
  local showPie = 0 < #proportionTab
  self.ui.pie:SetActive(showPie)
  if not showPie then
    return
  end
  table.sort(proportionTab, function(a, b)
    return b < a
  end)
  self.pieItemPool:HideAll()
  self.pieTextPool:HideAll()
  if #proportionTab > self.ui.maxCount then
    local proportion = 0
    for i = self.ui.maxCount, #proportionTab do
      proportion = proportionTab[i] + proportion
      proportionTab[i] = nil
    end
    proportionTab[self.ui.maxCount] = proportionTab
  end
  local setShortBar = false
  local pieItemRot = Vector3.zero
  for k, v in ipairs(proportionTab) do
    local pieItem = self.pieItemPool:GetOne()
    local color = self:GetPieColor(k)
    pieItem:InitPieItem(v, true, color)
    pieItem:SetItemRot(pieItemRot)
    pieItemRot = pieItemRot + pieItem:GetPieRot()
    if k == 1 then
      pieItem:SetScaleToBig()
    end
    if v < self.ui.minProportion then
      pieItem:SetShortBar(setShortBar)
      setShortBar = not setShortBar
    end
    local pieText = self.pieTextPool:GetOne()
    local textPos = pieItem:GetTextNodePos()
    pieText:InitPieText(v, textPos)
  end
end

function UIPie:GetPieColor(index)
  if index > self.ui.maxCount then
    index = self.ui.maxCount
  end
  return self.ui["color" .. tostring(index)]
end

function UIPie:OnDelete()
  self.pieItemPool:DeleteAll()
  self.pieTextPool:DeleteAll()
  base.OnDelete(self)
end

return UIPie
