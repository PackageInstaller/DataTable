local UILogicPreviewNodeBase = require("Game.CommonUI.LogicPreviewNode.UILogicPreviewNodeBase")
local UINAttrOutLineWindow = class("UINHeroStateSkillItem", UILogicPreviewNodeBase)
local base = UILogicPreviewNodeBase
local UINAttrIntroItem = require("Game.Formation.UI.Common.UINHeroAttrIntroItem")
local UINAttrOutLineRowItem = require("Game.CommonUI.Hero.Attr.UINAttrOutLineRowItem")

function UINAttrOutLineWindow:OnInit()
  base.OnInit(self)
  base.InitWithClass(self, nil, UINAttrOutLineRowItem)
  self.headAttrPool:HideAll()
  self.rowItemPool:HideAll()
end

function UINAttrOutLineWindow:OnShow()
  UIUtil.SetTopStatus(self, base._Close)
  base.OnShow(self)
  self.ui.scrollRect.verticalNormalizedPosition = 1
  UIUtil.HideTopStatus()
end

function UINAttrOutLineWindow:OnHide()
  base.Hide(self)
  UIUtil.ReShowTopStatus()
  AudioManager:PlayAudioById(1068)
  local heroStateWin = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if heroStateWin ~= nil and heroStateWin.active then
    heroStateWin:AddAllTouch()
  end
end

function UINAttrOutLineWindow:UpdateSkillName(name)
  self.ui.tex_SkillName:SetIndex(2, name)
end

function UINAttrOutLineWindow:OnUpdateAttrData(name, attrDataList)
  self.ui.tex_SkillName:SetIndex(2, name)
  if attrDataList == nil then
    return
  end
  self.attrDataList = attrDataList
  self.rowItemPool:HideAll()
  for index = 1, #self.attrDataList do
    local rowItem = self.rowItemPool:GetOne()
    local curData = self.attrDataList[index]
    local iconSprite = CRH:GetSprite(curData.icon)
    rowItem:InitAttrOutLineRowItem(curData.name, iconSprite, curData.attrValueStrs[1], curData.attrValueStrs[2], curData.isRecommend)
    rowItem:InjectPressAndUpFunc(BindCallback(self, self.__onAttrPressDown, curData.attrId, iconSprite, rowItem.transform), BindCallback(self, self.__onAttrPressUp))
  end
end

function UINAttrOutLineWindow:__onAttrPressDown(valueId, iconSprite, itemTrans)
  local velocitySqr = self.ui.scrollRect.velocity.sqrMagnitude
  if 0 < velocitySqr then
    return
  end
  if self.uiAttrIntro == nil then
    self.uiAttrIntro = UINAttrIntroItem.New()
    self.uiAttrIntro:Init(self.ui.uINAttrPopDetail)
  end
  self.uiAttrIntro:ShowAttrPopIntro(valueId, iconSprite)
  self.uiAttrIntro.transform:SetParent(itemTrans, false)
  self.uiAttrIntro:Show()
end

function UINAttrOutLineWindow:__onAttrPressUp()
  if self.uiAttrIntro ~= nil then
    self.uiAttrIntro:Hide()
  end
end

function UINAttrOutLineWindow:OnDelete()
  if self.uiAttrIntro ~= nil then
    self.uiAttrIntro:Hide()
    self.uiAttrIntro:OnDelete()
  end
  base.OnDelete(self)
end

return UINAttrOutLineWindow
