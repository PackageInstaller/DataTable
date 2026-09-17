local this = class("cellScienceTreeItem", G_UIModuleBase)
local colorBgLock = C_LuaUtility.ParseHtmlStringColor("#656565")
local colorBgCanUpgrade = C_LuaUtility.ParseHtmlStringColor("#DDB661")
local colorBgMaxLevel = C_LuaUtility.ParseHtmlStringColor("#7AC26A")
local alphaBgLock = 0.1
local alphaBgOther = 0.25
local _homeTechnologyTreeTpl = L_GameTpl:getHomeTechnologyTreeTpl()
local _homeTechnologyTpl = L_GameTpl:getHomeTechnologyTpl()

function this.bind()
  return {
    anchoredPosition = nil,
    activeIcon = false,
    activeIcon2 = false,
    imgIcon = "",
    imgIcon2 = "",
    desaturateImgIcon = false,
    desaturateImgIcon2 = false,
    desaturateImgIconBg = false,
    color_bg = nil,
    alpha_bg = 0.25,
    txtName = "",
    activeSelect = false,
    activeRed = false,
    activeUpgradeLock = false,
    activeUpgradeStudy = false,
    activeUpgradeUp = false,
    activeUpgradeMaxLevel = false,
    alpha_iconConstruct = 1,
    alpha_iconEffect = 1,
    alpha_iconConstructBg = 1,
    img_effectIcon = nil,
    activeAllLineUp = false,
    activeLineUp = false,
    activeLineDashedUp = false,
    activeAllLineDown = false,
    activeLineDown = false,
    activeLineDashedDown = false,
    colorLineUp = nil,
    colorLineDashedUp = nil,
    colorLineDown = nil,
    colorLineDashedDown = nil
  }
end

function this.methods()
  return {
    click = function(self)
      if self.activeSelect then
        return
      end
      self:emit("selectItem", self.bind.techTreeId)
    end
  }
end

function this:open()
  self.super.open(self)
  self.gameObject.name = tostring(self.bind.techTreeId)
  self.curLevel = nil
  self.isSatisfied = nil
  self.bindComponents.scienceAnim:Rewind("anim_scienceitem_change")
  self:refresh()
end

function this:refresh()
  if not self.isBind then
    return
  end
  if self.bind.techTreeId then
    self.bind.activeRed = L_TechnologyStore:GetTechnologyRedByTreeId(self.bind.techTreeId)
  end
  self:refreshLine()
  self:refreshSmallIcons()
end

function this:hide()
end

function this:setWidth(trans, width)
  local y = trans.sizeDelta.y
  trans.sizeDelta = C_Vector2(width, y)
end

function this:setPivotX(trans, pivotX, isRot)
  local y = trans.pivot.y
  trans.pivot = C_Vector2(pivotX, y)
  local pos = trans.anchoredPosition
  if isRot then
    pos.y = 0
  else
    pos.x = 0
  end
  trans.anchoredPosition = pos
end

function this:onSelect(techTreeId)
  self.bind.activeSelect = techTreeId == self.bind.techTreeId
end

function this:refreshLine()
  if self.bind.widthLineVertical then
    if self.bind.activeAllLineUp then
      self:setWidth(self.bindComponents.transLineUp, self.bind.widthLineVertical)
    end
    if self.bind.activeAllLineDown then
      self:setWidth(self.bindComponents.transLineDown, self.bind.widthLineVertical)
    end
  end
  local color = self.bind.lineColor
  self.bind.colorLineUp = color
  self.bind.colorLineDown = color
end

function this:setWidth(trans, width)
  local y = trans.sizeDelta.y
  trans.sizeDelta = C_Vector2(width, y)
end

function this:refreshSmallIcons()
  if not self.bind.techTreeId then
    return
  end
  local curTechLevel = L_TechnologyStore:getCurTechnologyLevelById(self.bind.techTreeId)
  if self.bind.pendingLevel then
    curTechLevel = self.bind.pendingLevel
  end
  local homeTechnologyTreeTpl = _homeTechnologyTreeTpl:getTplById(self.bind.techTreeId)
  local maxLevel = curTechLevel == 0 and 1 or L_TechnologyStore:getCurTechnologyMaxLevelById(self.bind.techTreeId)
  local homeTechnologyTplId = _homeTechnologyTpl:getHomeTechnologyTplIdByTechtreeIdAndTechLevel(self.bind.techTreeId, curTechLevel)
  local homeTechnologyTpl = _homeTechnologyTpl:getTplById(homeTechnologyTplId)
  local upgradeCondition = _homeTechnologyTpl:getUnlockCondi1(homeTechnologyTpl)
  local isSatisfied, _ = L_ConditionManager:isComplete(upgradeCondition)
  if self.bind.shouldLock then
    isSatisfied = false
  end
  if not isSatisfied or curTechLevel == maxLevel then
    self.bind.activeRed = false
  end
  if self.curLevel == curTechLevel and self.isSatisfied == isSatisfied then
    return
  end
  self.bind.activeUpgradeLock = false
  self.bind.activeUpgradeStudy = false
  self.bind.activeUpgradeUp = false
  self.bind.activeUpgradeMaxLevel = false
  if curTechLevel == maxLevel then
    self.bind.activeUpgradeMaxLevel = true
    self.bind.color_bg = colorBgMaxLevel
    self.bind.alpha_bg = alphaBgOther
  elseif 0 < curTechLevel then
    self.bind.activeUpgradeUp = true
    self.bind.color_bg = colorBgCanUpgrade
    self.bind.alpha_bg = alphaBgOther
  elseif isSatisfied then
    self.bind.activeUpgradeStudy = true
    self.bind.color_bg = colorBgCanUpgrade
    self.bind.alpha_bg = alphaBgOther
  else
    self.bind.activeUpgradeLock = true
    self.bind.color_bg = colorBgLock
    self.bind.alpha_bg = alphaBgLock
  end
  self.bind.img_effectIcon = _homeTechnologyTreeTpl:getMarkIcon(homeTechnologyTreeTpl)
  local iconState = 0 < curTechLevel or isSatisfied
  self.bind.alpha_iconConstruct = iconState and 1 or 0.5
  self.bind.alpha_iconEffect = iconState and 1 or 0.5
  self.bind.alpha_iconConstructBg = iconState and 1 or 0.3
  if self.curLevel and curTechLevel > self.curLevel then
    if curTechLevel == maxLevel then
      self.bindComponents.scienceAnim:Play("anim_scienceitem_finish")
    else
      self.bindComponents.scienceAnim:Play("anim_scienceitem_change")
    end
  elseif self.isSatisfied ~= nil and self.isSatisfied ~= isSatisfied then
    self.bindComponents.scienceAnim:Play("anim_scienceitem_change")
  end
  self.curLevel = curTechLevel
  self.isSatisfied = isSatisfied
end

return this
