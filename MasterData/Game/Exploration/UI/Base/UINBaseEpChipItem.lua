local UINBaseEpChipItem = class("UINBaseEpChipItem", UIBaseNode)
local base = UIBaseNode
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")

function UINBaseEpChipItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINBaseEpChipItem:InitBaseEpChipUI(chipData, showCount)
  self.chipItem = UINChipItem.New()
  self.chipItem:Init(self.ui.chipItem)
  self.chipItem:InitChipItem(chipData, showCount)
  self.ui.img_QuailtyColor.color = chipData:GetColor()
  if chipData:GetChipType() == ChipEnum.eChipType.Rain then
    self.ui.obj_RainbowColor:SetActive(true)
    self.ui.img_QuailtyColor.gameObject:SetActive(false)
  else
    self.ui.obj_RainbowColor:SetActive(false)
    self.ui.img_QuailtyColor.gameObject:SetActive(true)
  end
  self:_ShowChipSuitIcon(chipData)
end

function UINBaseEpChipItem:_ShowChipSuitIcon(chipData)
  self.ui.img_SuitIcon.enabled = false
  local suitCfg = chipData:TryGetSuitCfg()
  if suitCfg == nil then
    return
  end
  self.ui.img_SuitIcon.enabled = true
  self.ui.img_SuitIcon.sprite = CRH:GetSprite(suitCfg.tag_icon, CommonAtlasType.ExplorationIcon)
end

function UINBaseEpChipItem:OnDelete()
  base.OnDelete(self)
end

return UINBaseEpChipItem
