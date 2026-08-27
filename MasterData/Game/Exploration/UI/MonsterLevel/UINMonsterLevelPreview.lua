local base = require("Game.CommonUI.LogicPreviewNode.UILogicPreviewNodeBase")
local UINMonsterLevelPreview = class("UINMonsterLevelPreview", base)
local UINMonsterLevelPreviewItem = require("Game.Exploration.UI.MonsterLevel.UINMonsterLevelPreviewItem")

function UINMonsterLevelPreview:OnInit()
  base.OnInit(self)
  base.InitWithClass(self, nil, UINMonsterLevelPreviewItem)
end

function UINMonsterLevelPreview:OnShow()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  local dungeonStateInfo = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateInfo ~= nil then
    dungeonStateInfo:SetHeroListActive(false)
  end
  base.OnShow(self)
end

function UINMonsterLevelPreview:OnHide()
  local dungeonStateInfo = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateInfo ~= nil and not self.isJustOpen then
    dungeonStateInfo:SetHeroListActive(true)
  end
  base.OnHide(self)
end

function UINMonsterLevelPreview:InitMonsterLevelPreview(curLevel, onCloseCallback, justOpen)
  self._onCloseCallback = onCloseCallback
  self.isJustOpen = justOpen
  self.ui.tex_SkillName:SetIndex(3)
  self.ui.obj_Current.gameObject:SetActive(true)
  self.headAttrPool:HideAll()
  self.rowItemPool:HideAll()
  local attrItem = self.headAttrPool:GetOne()
  attrItem:InitAttrItem(ConfigData:GetTipContent(1105))
  attrItem = self.headAttrPool:GetOne()
  attrItem:InitAttrItem(ConfigData:GetTipContent(1106))
  attrItem = self.headAttrPool:GetOne()
  attrItem:InitAttrItem(ConfigData:GetTipContent(1107))
  attrItem = self.headAttrPool:GetOne()
  attrItem:InitAttrItem(ConfigData:GetTipContent(1108))
  local cellingAdd = 0
  local monsterLevelCfgs = ExplorationManager:GetMonsterLevelCfgs()
  if monsterLevelCfgs == nil then
    error("monsterLevelCfgs is nil")
    return
  end
  local maxLevel = monsterLevelCfgs.maxLevel
  for level = 1, maxLevel do
    local monsterStrengthCfg = monsterLevelCfgs[level]
    local logicList = {}
    table.insert(logicList, tostring(level))
    table.insert(logicList, tostring(monsterStrengthCfg.hp_amplify / 10) .. "%")
    table.insert(logicList, tostring(monsterStrengthCfg.pow_amplify / 10) .. "%")
    table.insert(logicList, tostring(monsterStrengthCfg.skill_amplify / 10) .. "%")
    local isCurLevel = curLevel == level
    local rowItem = self.rowItemPool:GetOne()
    rowItem:InitWithClass()
    rowItem:InitMonsterLevelPreviewRowItem(level, isCurLevel, logicList)
    if isCurLevel then
      self.ui.obj_Current:SetParent(rowItem.transform)
      self.ui.obj_Current.anchoredPosition = Vector2.zero
      self.ui.obj_Current:SetAsFirstSibling()
    end
  end
  self.ui.scrollRect.verticalNormalizedPosition = 1 - (curLevel - 1) / (maxLevel - 1)
end

function UINMonsterLevelPreview:BackAction()
  self:Hide()
  if self._onCloseCallback ~= nil then
    self._onCloseCallback()
  end
end

function UINMonsterLevelPreview:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UINMonsterLevelPreview:OnDelete()
  base.OnDelete(self)
end

return UINMonsterLevelPreview
