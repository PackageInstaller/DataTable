local UIEpMonsterLevelUp = class("UIEpMonsterLevelUp", UIBaseWindow)
local base = UIBaseWindow
local UIEpMonsterLevelUpAttrItem = require("Game.Exploration.UI.MonsterLevel.UIEpMonsterLevelUpAttrItem")

function UIEpMonsterLevelUp:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  self.attrPool = UIItemPool.New(UIEpMonsterLevelUpAttrItem, self.ui.obj_attriItem)
  self.ui.obj_attriItem:SetActive(false)
end

function UIEpMonsterLevelUp:InitEpMonsterLevelUp(curLevel, nextLevel, closeFunc)
  self.closeFunc = closeFunc
  local monsterLevelCfgs = ExplorationManager:GetMonsterLevelCfgs()
  if monsterLevelCfgs == nil then
    error("monsterLevelCfgs is nil")
    return
  end
  local curCfg = monsterLevelCfgs[curLevel]
  local nextCfg = monsterLevelCfgs[nextLevel]
  if curCfg == nil or nextCfg == nil then
    return
  end
  self.ui.uiAdapter:AdaptBgUI()
  self.ui.tex_CurLevel.text = tostring(curLevel or 0)
  if nextLevel < monsterLevelCfgs.maxLevel then
    self.ui.tex_NextLevel:SetIndex(0, tostring(nextLevel))
  else
    self.ui.tex_NextLevel:SetIndex(1)
  end
  self._autoCloseTimerId = TimerManager:StartTimer(3, self.OnClickClose, self)
  self:GenLevelUpAttrItems(curCfg, nextCfg)
end

function UIEpMonsterLevelUp:_CleatTimer()
  TimerManager:StopTimer(self._autoCloseTimerId)
end

function UIEpMonsterLevelUp:GenLevelUpAttrItems(curCfg, nextCfg)
  self.attrPool:HideAll()
  if curCfg.hp_amplify ~= nextCfg.hp_amplify then
    local item = self.attrPool:GetOne()
    item:InitMonsterLevelPreviewRowItem(0, curCfg.hp_amplify, nextCfg.hp_amplify)
  end
  if curCfg.pow_amplify ~= nextCfg.pow_amplify then
    local item = self.attrPool:GetOne()
    item:InitMonsterLevelPreviewRowItem(1, curCfg.pow_amplify, nextCfg.pow_amplify)
  end
  if curCfg.skill_amplify ~= nextCfg.skill_amplify then
    local item = self.attrPool:GetOne()
    item:InitMonsterLevelPreviewRowItem(2, curCfg.skill_amplify, nextCfg.skill_amplify)
  end
end

function UIEpMonsterLevelUp:OnClickClose()
  self:_CleatTimer()
  if self.closeFunc ~= nil then
    self.closeFunc()
  end
  self:Delete()
end

function UIEpMonsterLevelUp:OnDelete()
  self:_CleatTimer()
  base.OnDelete(self)
end

return UIEpMonsterLevelUp
