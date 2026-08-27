local base = require("Game.Task.NewUI.UINTaskListItem")
local UINTaskVer2DayTaskItem = class("UINTaskVer2DayTaskItem", base)
local JumpManager = require("Game.Jump.JumpManager")
local TaskEnum = require("Game.Task.TaskEnum")
local UINTaskUnlockItem = require("Game.ActivityHeroGrow.UI.UINTaskUnlockItem")

function UINTaskVer2DayTaskItem:OnInit()
  base.OnInit(self)
  self._taskUnlockItemPool = UIItemPool.New(UINTaskUnlockItem, self.ui.taskUnlockItem)
  self.ui.taskUnlockItem:SetActive(false)
end

function UINTaskVer2DayTaskItem:BindCommitFunc(commitFunc)
  self._commitFunc = commitFunc
end

function UINTaskVer2DayTaskItem:RefreshRewards(isPick)
  self._taskUnlockItemPool:HideAll()
  base.RefreshRewards(self, isPick)
  local unlockCfg = ConfigData.task_unlock[self.taskData.id]
  if unlockCfg ~= nil then
    for _, singleCfg in pairs(unlockCfg) do
      local item = self._taskUnlockItemPool:GetOne()
      item:InitTaskUnlockItem(singleCfg.type, singleCfg.tips)
      item:SetIsTaskUnlockPicked(isPick)
    end
  end
end

function UINTaskVer2DayTaskItem:OnClickBtn()
  if self.state == TaskEnum.eTaskState.InProgress then
    local jumpId = self.taskCfg.jump_id
    local jumpArgs = self.taskCfg.jumpArgs
    if jumpId ~= nil and 0 < jumpId then
      JumpManager:Jump(jumpId, function(jumpCallback)
        if jumpCallback ~= nil then
          jumpCallback()
        end
      end, nil, jumpArgs)
    end
  elseif self.state == TaskEnum.eTaskState.Completed and self._commitFunc ~= nil then
    self._commitFunc(self.taskData, self)
  end
end

return UINTaskVer2DayTaskItem
