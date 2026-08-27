local UINFairySkillItem = class("UINFairySkillItem", UIBaseNode)
local base = UIBaseNode
local UINFairyQualityItem = require("Game.Fairy.UI.UINFairyQualityItem")

function UINFairySkillItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_bk, self, self.OnClickBk)
  self.qualityItem = UINFairyQualityItem.New()
  self.qualityItem:Init(self.ui.uINFairyQualityItem)
  self.ui.obj_Selected:SetActive(false)
end

function UINFairySkillItem:InitFairySkillItem(fairySkillData, resloader, clickCallback)
  self.fairySkillData = fairySkillData
  self.ui.img_Pic.gameObject:SetActive(true)
  self.ui.img_Bk:SetIndex(0)
  if not IsNull(self.ui.obj_mask) then
    self.ui.obj_mask:SetActive(false)
  end
  self.qualityItem:InitFairyQualityItem(self.fairySkillData.fairySkillRare)
  self.ui.img_Pic.sprite = AtlasUtil.GetSpriteFromAtlas(fairySkillData:GetSkillAtlasName(), fairySkillData:GetFairySkillIcon(), resloader)
  self.clickCallback = clickCallback
  self:RefreshQuailtyOutline(false)
end

function UINFairySkillItem:InitFairySkillItemEmpty(isLock)
  self.fairySkillData = nil
  self.clickCallback = nil
  self.canSelectFunc = nil
  self.qualityItem:InitFairyQualityItem(nil)
  self.ui.img_Pic.gameObject:SetActive(false)
  self.ui.obj_mask:SetActive(false)
  self.ui.img_Bk:SetIndex(1)
  self:RefreshQuailtyOutline(true)
end

function UINFairySkillItem:RefreshQuailtyOutline(isEmpty)
  if self.ui.img_Quality == nil then
    return
  end
  local isUnique = not isEmpty and self.fairySkillData:IsUniqueSkill()
  self.ui.img_Quality.gameObject:SetActive(not isUnique)
  self.ui.img_QualityUnique.gameObject:SetActive(isUnique)
  if isEmpty then
    self.ui.img_Quality.color = Color.New(0.11, 0.11, 0.11, 0.1)
    self.ui.img_QualityUnique.color = Color.New(0.11, 0.11, 0.11, 0.1)
  else
    local level = self.fairySkillData.fairySkillRare
    self.ui.img_Quality.color = self.ui.qualityColor[level]
    self.ui.img_QualityUnique.color = self.ui.qualityColor[level]
  end
end

function UINFairySkillItem:RefreshSelectedByData(fairySkillData)
  if self.fairySkillData == fairySkillData and self.fairySkillData then
    self:SetSelected()
    return
  end
  if self.canSelectFunc then
    local canClick = self.canSelectFunc(self.fairySkillData, self.isSelected, true)
    self.ui.obj_mask:SetActive(not canClick)
  end
end

function UINFairySkillItem:SetCanSelectFunc(func)
  self.canSelectFunc = func
end

function UINFairySkillItem:ShowFySkillItemMask(show)
  self.ui.obj_mask:SetActive(show)
end

function UINFairySkillItem:SetSelected()
  self.isSelected = not self.isSelected
  self.ui.obj_Selected:SetActive(self.isSelected)
end

function UINFairySkillItem:OnClickBk()
  if self.clickCallback then
    local canClick = true
    if self.canSelectFunc then
      canClick = self.canSelectFunc(self.fairySkillData, self.isSelected)
    end
    if canClick then
      self.clickCallback(self.fairySkillData, self.isSelected, self)
    end
  end
end

function UINFairySkillItem:OnHide()
  self.isSelected = false
  self.ui.obj_Selected:SetActive(self.isSelected)
end

return UINFairySkillItem
