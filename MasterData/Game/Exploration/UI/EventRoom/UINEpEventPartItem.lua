local UINEpEventPartItem = class("UINEpEventPartItem", UIBaseNode)
local ChipData = require("Game.PlayerData.Item.ChipData")

function UINEpEventPartItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btnPlus_Root, self, self.__OnEpPartItemClick)
  self.ui.btnPlus_Root.onPress:AddListener(BindCallback(self, self.__OnChipLongPress))
  self.ui.btnPlus_Root.onPressUp:AddListener(BindCallback(self, self.__OnChipPressUp))
end

function UINEpEventPartItem:InitEpEventPartItem(chipId, index, hasChip)
  self.ui.obj_empty:SetActive(false)
  self.ui.obj_normal:SetActive(true)
  self.__partIndex = index
  self.__isEmpty = false
  self.__hasChip = hasChip
  local chipData = ChipData.NewChipForLocal(chipId)
  self.__chipData = chipData
  if chipData:IsConsumeSkillChip() then
    self.ui.img_SkillIcon.sprite = CRH:GetSprite(chipData:GetIcon(), CommonAtlasType.SkillIcon)
  else
    self.ui.img_SkillIcon.sprite = CRH:GetSprite(chipData:GetIcon())
  end
  self.ui.tex_Name.text = chipData:GetName()
  if self.__hasChip then
    self.ui.cg_Root.alpha = 1
  else
    self.ui.cg_Root.alpha = 0.5
  end
end

function UINEpEventPartItem:BindEventPartBtnEvent(clickEvent, longPressFunc, pressUpFunc)
  self.__clickEvent = clickEvent
  self.__longPressFunc = longPressFunc
  self.__pressUpFunc = pressUpFunc
end

function UINEpEventPartItem:InitEpEventEmpty(index)
  self.__partIndex = index
  self.__isEmpty = true
  self.__hasChip = false
  self.ui.cg_Root.alpha = 1
  self.ui.obj_empty:SetActive(true)
  self.ui.obj_normal:SetActive(false)
end

function UINEpEventPartItem:GetEventPartIndex()
  return self.__partIndex
end

function UINEpEventPartItem:GetEventPartChip()
  return self.__chipData
end

function UINEpEventPartItem:IsEventPartEmpty()
  return not self.__hasChip
end

function UINEpEventPartItem:SetPartItemypeLineColor(color)
  self.ui.img_TypeLine.image.color = color
end

function UINEpEventPartItem:SetPartItemLineType(index)
  self.ui.img_TypeLine:SetIndex(index)
end

function UINEpEventPartItem:__OnEpPartItemClick()
  if self.__isEmpty then
    return
  end
  if self.__clickEvent ~= nil then
    self.__clickEvent(self)
  end
  AudioManager:PlayAudioById(1156)
end

function UINEpEventPartItem:__OnChipLongPress()
  if self.__isEmpty then
    return
  end
  if self.__longPressFunc ~= nil then
    self.__longPressFunc(self.__chipData, self)
  end
end

function UINEpEventPartItem:__OnChipPressUp()
  if self.__isEmpty then
    return
  end
  if self.__pressUpFunc ~= nil then
    self.__pressUpFunc(self.__chipData, self)
  end
end

return UINEpEventPartItem
