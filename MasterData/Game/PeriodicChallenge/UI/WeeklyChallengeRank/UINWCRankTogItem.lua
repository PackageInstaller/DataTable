local UINWCRankTogItem = class("UINWCRankTogItem", UIBaseNode)
local base = UIBaseNode
UINWCRankTogItem.eTogType = {
  curTermRankList = 1,
  previousTermRankList = 2,
  rankRewardList = 3,
  activityOldRankList = 4
}

function UINWCRankTogItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_Page, self, self.__OnClick)
  self.ui.tex_PageName.text.color = self.ui.col_NameUnSel
end

function UINWCRankTogItem:InitWCRankTogItem(eTogType, clickCallback)
  self.ui.tex_PageName:SetIndex(eTogType - 1)
  self.clickCallback = clickCallback
end

function UINWCRankTogItem:__OnClick(bool)
  if bool then
    if self.clickCallback ~= nil then
      self.clickCallback()
    end
    self.ui.img_PageBG:SetIndex(1)
  else
    self.ui.img_PageBG:SetIndex(0)
  end
  local col = bool == true and self.ui.col_NameSel or self.ui.col_NameUnSel
  self.ui.tex_PageName.text.color = col
end

function UINWCRankTogItem:OnDelete()
  base.OnDelete(self)
end

return UINWCRankTogItem
