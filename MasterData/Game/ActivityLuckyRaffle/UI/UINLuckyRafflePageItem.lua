local UINLuckyRafflePageItem = class("UINLuckyRafflePageItem", UIBaseNode)
local base = UIBaseNode

function UINLuckyRafflePageItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_pageItem, self, self.OnClickRafflePageItem)
end

function UINLuckyRafflePageItem:InitLuckyRafflePageItem(luckyRaffleCfg, luckyRaffleData, clickCallback)
  self.luckyRaffleCfg = luckyRaffleCfg
  self.luckyRaffleData = luckyRaffleData
  self.clickCallback = clickCallback
  self:RefreshRafflePageNormalInfo()
end

function UINLuckyRafflePageItem:GetRafflePagePoolId()
  return self.luckyRaffleCfg.raffle_id
end

function UINLuckyRafflePageItem:RefreshRafflePageNormalInfo()
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self.luckyRaffleCfg.raffle_name)
end

function UINLuckyRafflePageItem:SetRafflePercent(nowNum, totalNum)
  local targetNum = 0
  if totalNum ~= 0 then
    targetNum = nowNum / totalNum * 100
  end
  self.ui.tex_NumberItem:SetIndex(0, string.format("%.2f", targetNum))
end

function UINLuckyRafflePageItem:SetRafflePageSelected(bool)
  self.ui.obj_selected:SetActive(bool)
  if bool then
    self.ui.tex_Name.color = self.ui.selectedFontColor
    self.ui.tex_NumberText.color = self.ui.selectedFontColor
  else
    self.ui.tex_Name.color = self.ui.normalFontColor
    self.ui.tex_NumberText.color = self.ui.numFontColor
  end
end

function UINLuckyRafflePageItem:OnClickRafflePageItem()
  if self.clickCallback then
    self.clickCallback(self.luckyRaffleCfg.raffle_id)
  end
end

return UINLuckyRafflePageItem
