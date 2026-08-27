local UINEpEventPartProductItem = class("UINEpEventPartProductItem", UIBaseNode)
local ChipData = require("Game.PlayerData.Item.ChipData")

function UINEpEventPartProductItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_product, self, self.__OnEventPartProductClicked)
  self.__notHaveAlpha = self.ui.cg_product.alpha
end

function UINEpEventPartProductItem:InitEventPartProduct(index, chipId, hasChip, clickEvent)
  self.__index = index
  self.__clickEvent = clickEvent
  local chipData = ChipData.NewChipForLocal(chipId)
  self.__chipData = chipData
  if chipData:IsConsumeSkillChip() then
    self.ui.img_SkillIcon.sprite = CRH:GetSprite(chipData:GetIcon(), CommonAtlasType.SkillIcon)
  else
    self.ui.img_SkillIcon.sprite = CRH:GetSprite(chipData:GetIcon())
  end
  self.ui.tex_Name.text = chipData:GetName()
  self.ui.img_ItemIcon:SetIndex(self.__index - 1)
  if hasChip then
    self.ui.cg_product.alpha = 1
    self.ui.img_Buttom:SetIndex(1)
  else
    self.ui.cg_product.alpha = self.__notHaveAlpha
    self.ui.img_Buttom:SetIndex(0)
  end
end

function UINEpEventPartProductItem:__OnEventPartProductClicked()
  if self.__clickEvent ~= nil then
    self.__clickEvent(self, self.__index)
  end
  AudioManager:PlayAudioById(1157)
end

return UINEpEventPartProductItem
