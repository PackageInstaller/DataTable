local UINLogicPreviewNode = class("UINLogicPreviewNode", UIBaseNode)
local base = UIBaseNode
local UINKeyExertionRewardItem = require("Game.ActivityKeyExertion.UI.UINKeyExertionRewardItem")

function UINLogicPreviewNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__itemPool = UIItemPool.New(UINKeyExertionRewardItem, self.ui.rewardItem)
  self.ui.rewardItem:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self.OnClickClose)
end

function UINLogicPreviewNode:InitLogicPreviewNode(keyExertionData)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack(true)
  self._data = keyExertionData
  self:UpdateCurrentNode()
end

function UINLogicPreviewNode:UpdateCurrentNode()
  if self._data == nil then
    return
  end
  local allrewardIds, allrewardNums = self._data:GetKeyExertionAllReward()
  self.__itemPool:HideAll()
  self.ui.tex_Name.text = self._data:GetKeyExertionAllRewardDes()
  for iIndex, vRewardId in ipairs(allrewardIds) do
    local rewardNum = allrewardNums[iIndex]
    local item = self.__itemPool:GetOne()
    local isShowAllPicked = self._data:GetBigRewardId() == vRewardId and self._data:GetIsBigRewardAllPicked()
    item:InitKeyExertionRewardItem(ConfigData.item[vRewardId], rewardNum, isShowAllPicked)
    item:Show()
  end
end

function UINLogicPreviewNode:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UINLogicPreviewNode:BackAction()
  self:Hide()
end

function UINLogicPreviewNode:OnDelete()
  self.__itemPool:DeleteAll()
  base.OnDelete(self)
end

return UINLogicPreviewNode
