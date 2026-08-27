local UILogicPreviewNodeBase = require("Game.CommonUI.LogicPreviewNode.UILogicPreviewNodeBase")
local UINAttrMiniWidget = class("UINAttrMiniWidget", UILogicPreviewNodeBase)
local base = UILogicPreviewNodeBase
local UINAttrIntroItem = require("Game.Formation.UI.Common.UINHeroAttrIntroItem")

function UINAttrMiniWidget:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  base.InitWithClass(self, nil, nil)
  self.rowItemPool:HideAll()
end

function UINAttrMiniWidget:OnShow()
  base.OnShow(self)
  self.ui.scrollRect.verticalNormalizedPosition = 1
end

function UINAttrMiniWidget:OnHide()
  base.Hide(self)
  AudioManager:PlayAudioById(1068)
end

function UINAttrMiniWidget:OnUpdateAttrData(name, attrDataList)
  if attrDataList == nil then
    return
  end
  self.attrDataList = attrDataList
  self.rowItemPool:HideAll()
  for index = 1, #self.attrDataList do
    local rowItem = self.rowItemPool:GetOne()
    rowItem:InitWithClass()
    local curData = self.attrDataList[index]
    local gridPool = rowItem.attrPool
    if gridPool ~= nil then
      gridPool:HideAll()
      local nameItem = gridPool:GetOne()
      nameItem:InitAttrItem(curData.name)
      local basicValueItem = gridPool:GetOne()
      basicValueItem:InitAttrItem(curData.attrValueStrs[1])
      basicValueItem.ui.tex_Attri.alignment = 5
    end
    local iconSprite = CRH:GetSprite(curData.icon)
    rowItem.ui.attrIcon.sprite = iconSprite
  end
end

function UINAttrMiniWidget:OnDelete()
  base.OnDelete(self)
end

return UINAttrMiniWidget
