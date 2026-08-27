local UILogicPreviewNodeBase = require("Game.CommonUI.LogicPreviewNode.UILogicPreviewNodeBase")
local UINBuildLogicLvPreview = class("UINBuildLogicLvPreview", UILogicPreviewNodeBase)
local base = UILogicPreviewNodeBase
local UINBuildLogicLvRowItem = require("Game.StrategyOverview.UI.BuildLogicLvPreview.UINBuildLogicLvRowItem")

function UINBuildLogicLvPreview:OnInit()
  base.OnInit(self)
  base.InitWithClass(self, nil, UINBuildLogicLvRowItem)
end

function UINBuildLogicLvPreview:InitBuildLogicLvPreview(buildingData, withoutCurLevel)
  UIUtil.SetTopStatus(self, self._Close, nil, nil, nil, true)
  self.ui.tex_SkillName:SetIndex(0, buildingData.name)
  local showCurLevel = buildingData.isBuild and not withoutCurLevel
  self.ui.obj_Current.gameObject:SetActive(showCurLevel)
  local curLevel = buildingData.level
  self.headAttrPool:HideAll()
  self.rowItemPool:HideAll()
  for i = 1, buildingData.maxLevel do
    local logicList = buildingData.dynData:GetBuffItems(i, false, true)
    local customLogicList = buildingData:GetBuildCustomLogicInfo(i)
    if i == 1 then
      local attrItem = self.headAttrPool:GetOne()
      attrItem:InitAttrItem(ConfigData:GetTipContent(900))
      for k, v in ipairs(logicList) do
        local attrItem = self.headAttrPool:GetOne()
        attrItem:InitAttrItem(v.currentInfo)
      end
      for k, v in ipairs(customLogicList) do
        local attrItem = self.headAttrPool:GetOne()
        local info = ConfigData:GetTipContent(5003)
        attrItem:InitAttrItem(info)
      end
    end
    local isCurLevel = curLevel == i and showCurLevel
    local rowItem = self.rowItemPool:GetOne()
    rowItem:InitWithClass()
    rowItem:InitBuildLogicLvRowItem(i, logicList, customLogicList, isCurLevel)
    if isCurLevel then
      self.ui.obj_Current:SetParent(rowItem.transform)
      self.ui.obj_Current.anchoredPosition = Vector2.zero
      self.ui.obj_Current:SetAsFirstSibling()
    end
  end
  if showCurLevel then
    self.ui.scrollRect.verticalNormalizedPosition = 1 - (curLevel - 1) / (buildingData.maxLevel - 1)
  else
    self.ui.scrollRect.verticalNormalizedPosition = 1
  end
end

function UINBuildLogicLvPreview:OnHide()
end

function UINBuildLogicLvPreview:OnDelete()
  base.OnDelete(self)
end

return UINBuildLogicLvPreview
