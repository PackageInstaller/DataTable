local base = UIBaseNode
local UINFmtSaveChipDetail = class("UINFmtSaveChipDetail", base)
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINBaseChipDetail")

function UINFmtSaveChipDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self._OnClickBg)
  self.panel = UINChipDetailPanel.New()
  self.panel:Init(self.ui.UINChipItemDetail)
end

function UINFmtSaveChipDetail:InitFmtSaveChipDetail(chipData, dynChipSuitMgr, resloader)
  self.panel:SetBaseChipDetailDynChipSuitMgr(dynChipSuitMgr)
  self.panel:InitBaseChipDetail(nil, chipData, nil, resloader)
  self:Show()
end

function UINFmtSaveChipDetail:_OnClickBg()
  self:Hide()
end

function UINFmtSaveChipDetail:OnDelete()
  self.panel:Delete()
  base.OnDelete(self)
end

return UINFmtSaveChipDetail
