local UINFormationBondItem = class("UINFormationBondItem", UIBaseNode)
local base = UIBaseNode

function UINFormationBondItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_item, self, self.OnClickItem)
end

function UINFormationBondItem:InitBondItem(bondStageData, bondIcon, resloader, clickFunc)
  self.ui.img_pic.sprite = AtlasUtil.GetSpriteFromAtlas("BondIcon", bondIcon, resloader)
  self.ui.tex_count.text = tostring(bondStageData.curCount) .. "/" .. tostring(bondStageData.nextCount)
  local stage = 0
  if bondStageData.curStageCfg ~= nil then
    stage = bondStageData.curStageCfg.stage
  end
  self.ui.img_dot.color = self.ui.color_bg[stage + 1]
  self.ui.img_quality.color = self.ui.color_bg[stage + 1]
  self.clickFunc = clickFunc
  self.bondStageData = bondStageData
end

function UINFormationBondItem:OnClickItem()
  if self.bondStageData.stage == 0 then
    return
  end
  if self.clickFunc ~= nil then
    self.clickFunc(self, self.bondStageData)
  end
end

function UINFormationBondItem:OnDelete()
  self.clickFunc = nil
  self.bondStageData = nil
  base.OnDelete(self)
end

return UINFormationBondItem
