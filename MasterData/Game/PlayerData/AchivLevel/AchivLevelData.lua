local AchivLevelData = class("AchivLevelData")
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")

function AchivLevelData:ctor()
  self.pickedRewardLevels = {}
  self.pickedAchivsAll = {}
  self.pickedAchNum = nil
  self.pickedRewardAchivs = {}
  for k, v in ipairs(ConfigData.achievement) do
    self.pickedRewardAchivs[v.task_type] = {}
  end
end

function AchivLevelData:InitPickedLevels(dataTab)
  self.pickedRewardLevels = dataTab or {}
  self:__InitLevelRewardRedDot()
end

function AchivLevelData:InitPickedAchivs(dataTab)
  self.pickedAchivsAll = dataTab or {}
  for taskId, completedTimestamp in pairs(self.pickedAchivsAll) do
    local taskCfg = ConfigData.task[taskId]
    if taskCfg == nil then
      error("Cant't find task by id, id = " .. tostring(taskId))
    else
      local achivTab = self.pickedRewardAchivs[taskCfg.type]
      if achivTab == nil then
        error("Cant't find pickedRewardAchivs by type, type = " .. tostring(taskCfg.type))
      else
        local pickedAchivData = self:__NewPickedAchivData(taskId, completedTimestamp)
        table.insert(achivTab, pickedAchivData)
      end
    end
  end
end

function AchivLevelData:AddPickedAchivs(pickedTab)
  local update = false
  for taskId, completedTimestamp in pairs(pickedTab) do
    local taskCfg = ConfigData.task[taskId]
    if taskCfg == nil then
      error("Cant't find task by id, id = " .. tostring(taskId))
      return
    end
    local achivTab = self.pickedRewardAchivs[taskCfg.type]
    if achivTab == nil then
      error("Cant't find pickedRewardAchivs by type, type = " .. tostring(taskCfg.type))
      return
    end
    self.pickedAchivsAll[taskId] = completedTimestamp
    if self.pickedAchNum ~= nil then
      self.pickedAchNum = self.pickedAchNum + 1
    end
    local pickedAchivData = self:__NewPickedAchivData(taskId, completedTimestamp)
    table.insert(achivTab, pickedAchivData)
    update = true
  end
  if update then
    MsgCenter:Broadcast(eMsgEventId.UpdatePickedAchivTask)
  end
end

function AchivLevelData:__NewPickedAchivData(taskId, completedTimestamp)
  local pickedAchivData = {taskId = taskId, completedTimestamp = completedTimestamp}
  return pickedAchivData
end

function AchivLevelData:AddPickedLevel(levelTab)
  local update = false
  for id, bool in pairs(levelTab) do
    self.pickedRewardLevels[id] = bool
    update = true
  end
  if update then
    self:UpdateLevelRewardRedDot()
    MsgCenter:Broadcast(eMsgEventId.UpdatePickedRewardLevel, false, false)
  end
end

function AchivLevelData:__InitLevelRewardRedDot()
  local node = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.AchivLevelReward, RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel, RedDotStaticTypeId.AchivLevelReward)
  local count = self:__GenLevelRewardRedDotCount()
  node:SetRedDotCount(count)
end

function AchivLevelData:UpdateLevelRewardRedDot()
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel, RedDotStaticTypeId.AchivLevelReward)
  if ok then
    local count = self:__GenLevelRewardRedDotCount()
    node:SetRedDotCount(count)
  end
end

function AchivLevelData:__GenLevelRewardRedDotCount()
  local count = 0
  for i = 2, PlayerDataCenter.playerLevel.level do
    if self.pickedRewardLevels[i] == nil then
      count = count + 1
    end
  end
  return count
end

function AchivLevelData:GetPickedAchNum()
  if self.pickedAchNum == nil then
    self.pickedAchNum = table.count(self.pickedAchivsAll)
  end
  return self.pickedAchNum
end

function AchivLevelData:GetTotalAchNum()
  return self:GetPickedAchNum() + PlayerDataCenter.allTaskData.achievementTaskNum or 1
end

function AchivLevelData:GetLevelLogics(level)
  local cfg = ConfigData.achievement_level[level]
  local front_cfg = ConfigData.achievement_level[level - 1]
  return CommonLogicUtil.MinLogicCfg(cfg, front_cfg)
end

return AchivLevelData
