local UINDungeonChipItem = class("UINDungeonChipItem", UIBaseNode)
local base = UIBaseNode
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local cs_MessageCommon = CS.MessageCommon

function UINDungeonChipItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__showAlpha = 1
  self.chipItem = UINChipItem.New()
  self.chipItem:Init(self.ui.obj_propGlobalItem)
  self.__OnItemClick = BindCallback(self, self.OnItemClick)
end

function UINDungeonChipItem:InitChipItem(chipData, index, selectCallback)
  self.chipData = chipData
  self.index = index
  self.selectCallback = selectCallback
  self.chipItem:InitChipItem(chipData, true, self.__OnItemClick)
  self:SetTransplanet(false)
  local isShowTemp = chipData:IsShowTemp()
  self.ui.obj_TemporaryMark:SetActive(isShowTemp)
  self.ui.obj_count:SetActive(not isShowTemp)
  self.ui.obj_TemporaryMark.transform:SetAsLastSibling()
  if isShowTemp then
    self.ui.obj_TemporaryMark.transform:SetAsLastSibling()
  end
end

function UINDungeonChipItem:OnItemClick()
  if self.selectCallback ~= nil then
    self.selectCallback(self.index)
  end
end

function UINDungeonChipItem:SetSelect(bool)
  self.ui.img_OnSelect.gameObject:SetActive(bool)
end

function UINDungeonChipItem:SetTransplanet(bool)
  if bool then
    self.ui.canvasGroup.alpha = 0
  else
    self.ui.canvasGroup.alpha = self.__showAlpha
  end
end

function UINDungeonChipItem:SetDungeonChipItemShowAlpha(alpha)
  self.__showAlpha = alpha
  self.ui.canvasGroup.alpha = alpha
end

function UINDungeonChipItem:GetChipItemWorldPos()
  return self.chipItem.transform.position
end

function UINDungeonChipItem:OnDelete()
  base.OnDelete(self)
end

return UINDungeonChipItem
