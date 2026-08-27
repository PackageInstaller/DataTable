local UIDungeonStoryItem = class("UIDungeonStoryItem", UIBaseNode)
local base = UIBaseNode
local UICondition = require("Game.Friendship.PlotDungeon.UIDungeonStoryCondition")

function UIDungeonStoryItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_storyItem, self, self.__onClick)
end

function UIDungeonStoryItem:InitWithData(cfg)
  self.conditionTextDict = {}
  self.conditionLockedDict = {}
  self.cfg = cfg
  self.ui.tex_StoryName.text = LanguageUtil.GetLocaleText(cfg.name)
  self.gameObject.name = self.cfg.id
  self:UpdateUnLockCondition(cfg)
end

function UIDungeonStoryItem:UpdateUnLockCondition(cfg)
  self.isUnlock = true
  local conditionCount = #cfg.pre_condition
  if conditionCount <= 0 then
    self.ui.condition:SetActive(false)
    return
  end
  for i = 1, conditionCount do
    local isMeet = CheckCondition.CheckLua({
      cfg.pre_condition[i]
    }, {
      cfg.pre_para1[i]
    }, {
      cfg.pre_para2[i]
    })
    self.conditionTextDict[cfg.pre_condition[i]] = AvgUtil.GetConditionText(cfg.pre_condition[i], cfg.pre_para1[i], cfg.pre_para2[i])
    self.conditionLockedDict[cfg.pre_condition[i]] = isMeet
    if not isMeet and self.isUnlock then
      self.isUnlock = false
    end
  end
  if self.ui.condition.activeSelf == self.isUnlock then
    self.ui.condition:SetActive(not self.isUnlock)
  end
  if not self.isUnlock then
    if self.conditionPool == nil then
      self.conditionPool = UIItemPool.New(UICondition, self.ui.conditionItem)
    end
    self.conditionPool:HideAll()
    for i = 1, conditionCount do
      local conditionItem = self.conditionPool:GetOne()
      local condId = cfg.pre_condition[i]
      conditionItem:InitWithData(self.conditionTextDict[condId], self.conditionLockedDict[condId])
    end
  end
end

function UIDungeonStoryItem:__onClick()
  if not self.isUnlock then
    return
  end
  local agvCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
  agvCtrl:StartAvg(self.cfg.script_id)
end

function UIDungeonStoryItem:OnDelete()
  base.OnDelete(self)
end

return UIDungeonStoryItem
