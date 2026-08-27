local SectorAchievementData = class("SectorAchievementData")

function SectorAchievementData.CreateAchivSectorData(sectorData)
  local data = SectorAchievementData.New()
  data:__InitData(sectorData)
  data:InitSectorAchivRedDot()
  return data
end

function SectorAchievementData:ctor()
  self.sectorDataDic = nil
end

function SectorAchievementData:__InitData(sectorData)
  self.sectorDataDic = sectorData
  self.stageChallengeQuestDic = {}
  for sectorId, sector in pairs(sectorData) do
    for k, v in pairs(sector.challengeQuest) do
      self.stageChallengeQuestDic[k] = v
    end
  end
end

function SectorAchievementData:UpdAllStageChallengeQuest(challengeQuestDic)
  for k, v in pairs(challengeQuestDic) do
    self.stageChallengeQuestDic[k] = v
  end
end

function SectorAchievementData:GetIsPicked(sectorId, achivId)
  if self.sectorDataDic == nil or self.sectorDataDic[sectorId] == nil or self.sectorDataDic[sectorId].boxPicked == nil then
    return false
  end
  return self.sectorDataDic[sectorId].boxPicked[achivId]
end

function SectorAchievementData:GetIsComplete(sectorId, taskId)
  if self.sectorDataDic == nil or self.sectorDataDic[sectorId] == nil or self.sectorDataDic[sectorId].completed == nil then
    return false
  end
  return self.sectorDataDic[sectorId].completed[taskId]
end

function SectorAchievementData:GetCompletedTask(sectorId)
  if self.sectorDataDic == nil or self.sectorDataDic[sectorId] == nil then
    return
  end
  return self.sectorDataDic[sectorId].completed
end

function SectorAchievementData:UpdateCompleteTaskData(sectorId, taskId)
  if self.sectorDataDic[sectorId] == nil then
    self.sectorDataDic[sectorId] = {}
  end
  if self.sectorDataDic[sectorId].completed == nil then
    self.sectorDataDic[sectorId].completed = {}
  end
  self.sectorDataDic[sectorId].completed[taskId] = true
end

function SectorAchievementData:UpdateAchivData(msg)
  local sectorId = msg.sectorId
  local achivId = msg.id
  if self.sectorDataDic[sectorId] == nil then
    self.sectorDataDic[sectorId] = {}
  end
  if self.sectorDataDic[sectorId].boxPicked == nil then
    self.sectorDataDic[sectorId].boxPicked = {}
  end
  self.sectorDataDic[sectorId].boxPicked[achivId] = true
  self:UpdateSectorAchivRedDot(sectorId)
end

function SectorAchievementData:InitSectorAchivRedDot()
  for _, id in ipairs(ConfigData.sector.id_sort_list) do
    local sectorCfg = ConfigData.sector[id]
    local achivCfgs = ConfigData.sectorAchievement[sectorCfg.id]
    local sectorId = sectorCfg.id
    local node = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.SectorItemTaskAchivPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, sectorId, RedDotStaticTypeId.SectorTaskBtn, RedDotStaticTypeId.SectorTaskAchiv)
    local count = 0
    if achivCfgs ~= nil then
      for i = 1, #achivCfgs do
        local achivCfg = achivCfgs[i]
        if not self:GetIsPicked(sectorId, achivCfg.id) and self:CheckAchivCondition(achivCfg) then
          count = count + 1
        end
      end
    end
    node:SetRedDotCount(count)
  end
end

function SectorAchievementData:UpdateSectorAchivRedDot(sectorId)
  local OK, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, sectorId, RedDotStaticTypeId.SectorTaskBtn, RedDotStaticTypeId.SectorTaskAchiv)
  if OK then
    local sectorCfg = ConfigData.sector[sectorId]
    local achivCfgs = ConfigData.sectorAchievement[sectorCfg.id]
    local count = 0
    if achivCfgs ~= nil then
      for i = 1, #achivCfgs do
        local achivCfg = achivCfgs[i]
        if not self:GetIsPicked(sectorId, achivCfg.id) and self:CheckAchivCondition(achivCfg) then
          count = count + 1
        end
      end
    end
    node:SetRedDotCount(count)
  end
end

function SectorAchievementData:CheckAchivCondition(achivCfg)
  for i = 1, #achivCfg.conditionIds do
    local conditionId = achivCfg.conditionIds[i]
    local conditionNum = achivCfg.conditionNums[i]
    local itemCount = PlayerDataCenter:GetItemCount(conditionId)
    if conditionNum > itemCount then
      return false
    end
  end
  return true
end

function SectorAchievementData:IsChallengeTaskComplete(stageId, questId)
  local key = stageId << 32 | questId
  return self.stageChallengeQuestDic[key] ~= nil
end

function SectorAchievementData:SetChallengeTaskComplete(stageId, questId)
  local key = stageId << 32 | questId
  self.stageChallengeQuestDic[key] = true
  MsgCenter:Broadcast(eMsgEventId.OnChallengeTaskComplete, stageId, questId)
end

function SectorAchievementData:IsStageChallengeTaskCompleteAll(stageId)
  local sectorStageCfg = ConfigData.sector_stage[stageId]
  if sectorStageCfg == nil then
    error("Cant get sector_stage cfg, id = " .. tostring(stageId))
    return false
  end
  local completeAll = true
  for k, taskId in ipairs(sectorStageCfg.hard_task) do
    if not self:IsChallengeTaskComplete(stageId, taskId) then
      completeAll = false
      break
    end
  end
  return completeAll
end

function SectorAchievementData:HasStageChallengeTask(stageId)
  local sectorStageCfg = ConfigData.sector_stage[stageId]
  if sectorStageCfg == nil then
    error("Cant get sector_stage cfg, id = " .. tostring(stageId))
    return false
  end
  local sectorCfg = ConfigData.sector[sectorStageCfg.sector]
  if sectorCfg.task_is_open and #sectorStageCfg.hard_task > 0 then
    return true
  end
  return false
end

function SectorAchievementData:IsStageChallengeTaskOpen(stageId)
  if not self:HasStageChallengeTask(stageId) then
    return false
  end
  if PlayerDataCenter.sectorStage:IsStageComplete(stageId) then
    return true
  end
  local sectorStageCfg = ConfigData.sector_stage[stageId]
  if sectorStageCfg == nil then
    error("Cant get sector_stage cfg, id = " .. tostring(stageId))
    return false
  end
  if sectorStageCfg.hard_task_unlock ~= 0 then
    return PlayerDataCenter.sectorStage:IsStageComplete(sectorStageCfg.hard_task_unlock)
  end
  return false
end

function SectorAchievementData:GetStageChallengeTaskOpenDes(stageId)
  local sectorStageCfg = ConfigData.sector_stage[stageId]
  if sectorStageCfg == nil then
    error("Cant get sector_stage cfg, id = " .. tostring(stageId))
    return
  end
  if sectorStageCfg.hard_task_unlock == 0 then
    return ConfigData:GetTipContent(963)
  else
    local stageName = ConfigData:GetSectorStageName(sectorStageCfg.hard_task_unlock)
    local msg = ConfigData:GetTipContent(965)
    return string.format(msg, stageName)
  end
end

function SectorAchievementData:GetStageChallengeTaskCompleteNum(stageId)
  local sectorStageCfg = ConfigData.sector_stage[stageId]
  if sectorStageCfg == nil then
    error("Cant get sector_stage cfg, id = " .. tostring(stageId))
    return 0
  end
  local num = 0
  for k, taskId in ipairs(sectorStageCfg.hard_task) do
    if self:IsChallengeTaskComplete(stageId, taskId) then
      num = num + 1
    end
  end
  return num
end

function SectorAchievementData:GetStageChallengeTaskNum(stageId)
  local sectorStageCfg = ConfigData.sector_stage[stageId]
  if sectorStageCfg == nil then
    error("Cant get sector_stage cfg, id = " .. tostring(stageId))
    return 0
  end
  return #sectorStageCfg.hard_task
end

return SectorAchievementData
