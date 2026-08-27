local UINLtrPoolBaseRule = class("UINLtrPoolBaseRule", UIBaseNode)
local base = UIBaseNode
local UINLtrPoolBaseConvertItem = require("Game.Lottery.UI.PoolDetail.BaseRule.UINLtrPoolBaseConvertItem")

function UINLtrPoolBaseRule:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLtrPoolBaseRule:InitLtrPoolBaseRule(ltrGroupData, fromLtrData)
  local poolCfg = fromLtrData.ltrCfg
  self.ui.tex_Des1Title.text = LanguageUtil.GetLocaleText(poolCfg.title1)
  self.ui.tex_Des1Rule.text = LanguageUtil.GetLocaleText(poolCfg.des1)
  self.ui.tex_Des3Title.text = LanguageUtil.GetLocaleText(poolCfg.title3)
  self.ui.tex_Des3Rule.text = LanguageUtil.GetLocaleText(poolCfg.des3)
  if #self.ui.tex_Des1Title.text == 0 then
    self.ui.tex_Des1Title.gameObject:SetActive(false)
  end
  if #self.ui.tex_Des3Title.text == 0 then
    self.ui.tex_Des3Title.gameObject:SetActive(false)
  end
  local convertItem = UINLtrPoolBaseConvertItem.New()
  convertItem:Init(self.ui.blendRuleVItem)
  local ltrData = ltrGroupData.ltrPoolData
  convertItem:InitLtrPoolBaseConvertItem(ltrGroupData.ltrPoolData, fromLtrData == ltrData)
  if self.convertItemList ~= nil then
    self.convertItemList:HideAll()
  end
  if ltrGroupData:HasLtrMoreGroup() then
    self.convertItemList = self.convertItemList or UIItemPool.New(UINLtrPoolBaseConvertItem, self.ui.blendRuleVItem)
    local ltrDataList = ltrGroupData:GetLtrInGroupDataList()
    local rootIndex = convertItem.transform:GetSiblingIndex()
    for i = 2, #ltrDataList do
      convertItem = self.convertItemList:GetOne()
      convertItem.transform:SetSiblingIndex(rootIndex + i - 1)
      ltrData = ltrDataList[i]
      convertItem:InitLtrPoolBaseConvertItem(ltrData, ltrData == fromLtrData)
    end
  end
end

function UINLtrPoolBaseRule:OnDelete()
  base.OnDelete(self)
end

return UINLtrPoolBaseRule
