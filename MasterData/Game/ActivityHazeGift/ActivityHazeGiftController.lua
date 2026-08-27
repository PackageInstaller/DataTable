local ActivityHazeGiftController = class("ActivityHazeGiftController", ControllerBase)
local base = ControllerBase
local ActivityHazeGiftData = require("Game.ActivityHazeGift.Data.ActivityHazeGiftData")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")

function ActivityHazeGiftController:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_hazegift_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_hazegift_reward)
  ConfigData:LoadDynCfg(eDynConfigData.activity_hazegift_task_group)
  self._dataDic = {}
  self.__TaskChangeCallback = BindCallback(self, self.TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
end

function ActivityHazeGiftController:InitHazeGiftData(msg)
  local data = ActivityHazeGiftData.New()
  self._dataDic[msg.actId] = data
  data:InitHazeGiftData(msg)
end

function ActivityHazeGiftController:GetOneActHazeGiftData()
  for k, v in pairs(self._dataDic) do
    return v
  end
end

function ActivityHazeGiftController:GetHazeGiftDataByActId(actId)
  return self._dataDic[actId]
end

function ActivityHazeGiftController:RemoveHazeGiftDataByActId(actId)
  self._dataDic[actId] = nil
end

function ActivityHazeGiftController:IsHaveHazeGiftActivity()
  return table.IsEmptyTable(self._dataDic)
end

function ActivityHazeGiftController:TaskProcessUpdate()
  for k, v in pairs(self._dataDic) do
    v:__RefreshHazeGiftRedHasTask()
  end
end

function ActivityHazeGiftController:RefreshHazeGiftFlush()
  for k, v in pairs(self._dataDic) do
    v:RefreshHazeGiftFlush()
  end
end

function ActivityHazeGiftController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_hazegift_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_hazegift_reward)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_hazegift_task_group)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
end

return ActivityHazeGiftController
