local base = UIBaseNode
local UINReinforceCardSetDiffNode = class("UINReinforceCardSetDiffNode", base)
local UINReinforceCardSetDiffItem = require("Game.Reinforce.UI.CardSet.DiffSelect.UINReinforceCardSetDiffItem")

function UINReinforceCardSetDiffNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self.__OnClickClose)
  self.clickItem = BindCallback(self, self.__OnClickDiffItem)
  self.itemPool = UIItemPool.New(UINReinforceCardSetDiffItem, self.ui.obj_diffItem, false)
end

function UINReinforceCardSetDiffNode:InitReinforceCSDN(actFrameId, curDiff, selectDiffCallback)
  self.diffCfgList = ConfigData.reinforce_exploration_continue_diff[actFrameId]
  self.curDiff = curDiff
  self.selectDiffCallback = selectDiffCallback
  self:__RefreshAllDiff()
end

function UINReinforceCardSetDiffNode:__RefreshAllDiff()
  self.itemPool:HideAll()
  for diffIndex, diffCfg in ipairs(self.diffCfgList) do
    local diffItem = self.itemPool:GetOne()
    local isSelected = diffIndex == self.curDiff
    diffItem:InitReinforceCSDNDiffItem(diffCfg, isSelected, self.clickItem)
  end
end

function UINReinforceCardSetDiffNode:__OnClickDiffItem(diffCfg)
  self.curDiff = diffCfg.diff_id
  self:__RefreshAllDiff()
  if self.selectDiffCallback ~= nil then
    self.selectDiffCallback(diffCfg.diff_id)
  end
end

function UINReinforceCardSetDiffNode:__OnClickClose()
  self:Hide()
end

function UINReinforceCardSetDiffNode:OnDelete()
  self.itemPool:DeleteAll()
  base.OnDelete(self)
end

return UINReinforceCardSetDiffNode
