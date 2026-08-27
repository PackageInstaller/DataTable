local UINActivityExplorationFundPageEntryItem = class("UINActivityExplorationFundPageEntryItem", UIBaseNode)
local base = UIBaseNode

function UINActivityExplorationFundPageEntryItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Bottom, self, self.__OnClickPageEntry)
end

function UINActivityExplorationFundPageEntryItem:InitExplorationFundPageEntryItem(singleFundData, pageIndex, fundId, isSelecting, isLast, onClickPageCallback)
  self._singleFundData = singleFundData
  self._pageIndex = pageIndex
  self._fundId = fundId
  self.ui.tex_Stage.color = isSelecting and self.ui.color_TextSelecting or self.ui.color_TextUnSelecting
  self.ui.img_Bottom:SetIndex(isSelecting and 0 or 1)
  self.ui.obj_Line:SetActive(not isLast)
  local uiCfg = singleFundData:GetSingleFundDataFundCfg()
  self.ui.tex_Stage.text = LanguageUtil.GetLocaleText(uiCfg.name)
  self.ui.obj_RedDot:SetActive(singleFundData:GetSingleFundDataHasCompleteReward())
  self._onClickPageCallback = onClickPageCallback
end

function UINActivityExplorationFundPageEntryItem:__OnClickPageEntry()
  if self._onClickPageCallback ~= nil then
    self._onClickPageCallback(self._fundId, self._pageIndex)
  end
end

return UINActivityExplorationFundPageEntryItem
