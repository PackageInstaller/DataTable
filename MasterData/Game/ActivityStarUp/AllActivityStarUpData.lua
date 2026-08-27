local AllActivityStarUpData = class("AllActivityStarUpData")
local ActivityStarUpEnum = require("Game.ActivityStarUp.ActivityStarUpEnum")
local ActivityStarUpData = require("Game.ActivityStarUp.ActivityStarUpData")

function AllActivityStarUpData:InitActivityStarUp(msg)
  self.__isInited = true
  self.dataDic = {}
  for _, msgData in ipairs(msg) do
    local cfg = ConfigData.rookie_star[msgData.actId]
    if cfg ~= nil then
      local data = ActivityStarUpData.New()
      data:InitStarUp(cfg, msgData)
      self.dataDic[msgData.actId] = data
    end
  end
end

function AllActivityStarUpData:UpdateStage(taskId)
  for k, v in pairs(self.dataDic) do
    if v.curStageId ~= nil then
      if v.cfg.phase[v.curStageId].task == taskId then
        v:RefreshStage()
      elseif v:ContainsTask(taskId) then
        v:UpdateStarUpRedddot()
      end
    end
  end
end

function AllActivityStarUpData:UpdateTask(taskData)
  if not taskData:CheckComplete() then
    return
  end
  if not self.__isInited then
    return
  end
  for k, v in pairs(self.dataDic) do
    if v.curStageId ~= nil and v:ContainsTask(taskData.id) then
      v:UpdateStarUpRedddot()
    end
  end
end

function AllActivityStarUpData:GetInfo(activityId)
  return self.dataDic[activityId]
end

return AllActivityStarUpData
