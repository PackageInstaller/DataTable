local UINLevelChallengeTask = class("UINLevelChallengeTask", UIBaseNode)
local base = UIBaseNode
local UINLvChallengeTaskItem = require("Game.Sector.SectorLevelDetail.Nodes.ChallengeTask.UINLvChallengeTaskItem")

function UINLevelChallengeTask:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  if not IsNull(self.ui.btn_root) then
    UIUtil.AddButtonListener(self.ui.btn_root, self, self._OnClickShowInfo)
  end
  self.taskItemPool = UIItemPool.New(UINLvChallengeTaskItem, self.ui.callTaskItem, false)
end

function UINLevelChallengeTask:InitLevelChallengeTask(stageCfg)
  self.stageCfg = stageCfg
  self.taskItemPool:HideAll()
  for k, taskId in ipairs(stageCfg.hard_task) do
    local taskCfg = ConfigData.task[taskId]
    local isComplete = PlayerDataCenter.sectorAchievementDatas:IsChallengeTaskComplete(stageCfg.id, taskId)
    local taskItem = self.taskItemPool:GetOne()
    taskItem:InitLvChallengeTaskItem(taskCfg, isComplete)
  end
end

function UINLevelChallengeTask:_OnClickShowInfo()
  local sctPowerLimitCfg = ConfigData.power_limit[self.stageCfg.power_limit]
  if sctPowerLimitCfg == nil then
    error("Cant get power_limit, id = " .. tostring(self.stageCfg.power_limit))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FmtChallengeInfo, function(win)
    if win == nil then
      return
    end
    win:InitFmtChallengeInfo(sctPowerLimitCfg)
  end)
end

function UINLevelChallengeTask:OnDelete()
  self.taskItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINLevelChallengeTask
