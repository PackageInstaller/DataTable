local UINLevelChipQualityItem = class("UINLevelChipQualityItem", UIBaseNode)
local base = UIBaseNode
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")

function UINLevelChipQualityItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.chipItemPool = UIItemPool.New(UINChipItem, self.ui.uINChipItem)
  self.ui.uINChipItem:SetActive(false)
  self._OnChipClick = BindCallback(self, self.OnChipClick)
end

function UINLevelChipQualityItem:InitChipQualityItem(quality, chipDataList, OnChipClickCallback, isInitChip)
  self.OnChipClickCallback = OnChipClickCallback
  if isInitChip then
    self.ui.img_tileLine.color = ItemQualityColor[quality]
    self.ui.texInfo_Quailty:SetIndex(quality)
    self.chipItemPool:HideAll()
  else
    self.ui.img_tileLine.color = ItemQualityColor[quality]
    self.ui.texInfo_Quailty:SetIndex(quality - 1)
    self.chipItemPool:HideAll()
  end
  for _, chipData in ipairs(chipDataList) do
    local chipItem = self.chipItemPool:GetOne()
    chipItem:InitChipItem(chipData, false, self._OnChipClick)
    chipItem.ui.img_lock = chipItem.transform:FindComponent("Img_isLock", eUnityComponentID.Image).gameObject
    chipItem.ui.img_lock:SetActive(chipData.isLock)
  end
end

function UINLevelChipQualityItem:OnChipClick(chipData, chipItem)
  if chipData.isLock then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.exploration_Level_Chip_Unlock))
    self.OnChipClickCallback()
    return
  end
  if self.OnChipClickCallback ~= nil then
    self.OnChipClickCallback(chipData, chipItem)
  end
end

function UINLevelChipQualityItem:OnDelete()
  base.OnDelete(self)
end

return UINLevelChipQualityItem
