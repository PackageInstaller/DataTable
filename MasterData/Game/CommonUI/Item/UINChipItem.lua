local UINChipItem = class("UINChipItem", UIBaseNode)
local base = UIBaseNode
local UINChipLevel = require("Game.CommonUI.Chip.UINChipLevel")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")

function UINChipItem:ctor()
  self.isUnlock = false
end

function UINChipItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btnRoot, self, self.OnClickChipEvent)
  self.level = UINChipLevel.New()
  self.level:Init(self.ui.obj_Level)
  self.ui.obj_Level:SetActive(false)
end

function UINChipItem:InitChipItem(chipData, showCount, onClickEvent, isNotAsLastSibling)
  self.chipData = chipData
  self.showCount = showCount or false
  self.__onClickEvent = onClickEvent
  self.ui.btnRoot.interactable = onClickEvent ~= nil
  local color = chipData:GetColor()
  self.ui.quality.color = color
  self.ui.img_LevelCol.color = color
  if chipData:IsConsumeSkillChip() then
    self.ui.img_skill.gameObject:SetActive(true)
    self.ui.img_skill.color = color
    self.ui.icon.sprite = CRH:GetSprite(chipData:GetIcon(), CommonAtlasType.SkillIcon)
  else
    self.ui.img_skill.gameObject:SetActive(false)
    self.ui.icon.sprite = CRH:GetSprite(chipData:GetIcon())
  end
  self:Show()
  isNotAsLastSibling = isNotAsLastSibling or false
  if not isNotAsLastSibling then
    self.transform:SetAsLastSibling()
  end
  self:UpdateChipItem()
  if not IsNull(self.ui.canvasGroup) then
    self.ui.canvasGroup:DOKill(true)
  end
  if chipData:GetChipType() == ChipEnum.eChipType.Rain then
    self.ui.uiimg_Buttom:SetIndex(1)
    self.ui.img_Buttom.color = self.ui.color_rainButtom
    self.ui.img_Quality:SetIndex(1)
    self.ui.quality.color = Color.white
  else
    self.ui.uiimg_Buttom:SetIndex(0)
    self.ui.img_Buttom.color = self.ui.color_normalButtom
    self.ui.img_Quality:SetIndex(0)
  end
end

function UINChipItem:BindDefaultClickEvent()
  local onClickEvent = BindCallback(self, self.__DefaultClickEvent)
  self.__onClickEvent = onClickEvent
  self.ui.btnRoot.interactable = onClickEvent ~= nil
end

function UINChipItem:__DefaultClickEvent(chipData)
  local heroList = ExplorationManager:GetDynPlayer().heroList
  local window = UIManager:ShowWindow(UIWindowTypeID.GlobalChipDetail)
  window:InitChipItemDetail(chipData, heroList, true)
end

function UINChipItem:UpdateChipItem(dynPlayer)
  local office = self.showCount and -8 or 0
  self.ui.icon.transform.localPosition = Vector3.New(0, office, 0)
  if not self.showCount then
    self.ui.obj_Level:SetActive(self.showCount)
    return
  end
  self.level:InitChipLevel(self.chipData, dynPlayer)
  self.ui.obj_Level:SetActive(self.showCount)
end

function UINChipItem:OnClickChipEvent()
  if self.__onClickEvent ~= nil then
    self.__onClickEvent(self.chipData, self)
  end
end

function UINChipItem:ChipItemButtonEnable(enable)
  self.ui.btnRoot.enabled = enable
end

function UINChipItem:UnlockChipItem(isUnlock)
  self.isUnlock = isUnlock
  self.ui.icon.color = isUnlock and Color.white or Color.gray
  local color = self.ui.quality.color
  color.a = isUnlock and 1 or 0.4
  self.ui.quality.color = color
end

function UINChipItem:IsUnlock()
  return self.isUnlock
end

function UINChipItem:GetChipData()
  return self.chipData
end

function UINChipItem:RefreshLevelTween()
  self.level:RefreshFlashTween()
end

function UINChipItem:OnDelete()
  base.OnDelete(self)
end

return UINChipItem
