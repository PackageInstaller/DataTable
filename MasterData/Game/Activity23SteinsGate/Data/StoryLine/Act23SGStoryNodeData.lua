local Act23SGStoryNodeData = class("Act23SGStoryNodeData")
local Act23SteinsGateEnum = require("Game.Activity23SteinsGate.Data.Act23SteinsGateEnum")

function Act23SGStoryNodeData:ctor(sNodeId, sNodeCfg, sgData)
  self.__sNodeId = sNodeId
  self.__storyNodeCfg = sNodeCfg
  self.sgData = sgData
  self.__isCouldShown = nil
  self.__isOpenNode = nil
  self.__lineIndex = nil
  self.__lineGridIndex = nil
  self.__isBattleStage = nil
  self:InitAct23SGStoryNodeData()
end

function Act23SGStoryNodeData:InitAct23SGStoryNodeData()
  local posCfg = ConfigData.activity_23steinsgate_map.storyId2PosDic[self.__sNodeId]
  if posCfg ~= nil then
    self.__lineIndex = posCfg.line
    self.__lineGridIndex = posCfg.grid
  else
    self.__lineIndex = 0
    self.__lineGridIndex = 0
  end
  self.__isBattleStage = self.__storyNodeCfg.stage_id ~= nil and 0 < #self.__storyNodeCfg.stage_id
  self:Act23GSSN_UpdateIsCouldShow()
  self:RecordNodeDataState()
end

function Act23SGStoryNodeData:Act23GSSN_UpdateIsCouldShow()
  if self.__isCouldShown then
    return
  end
  self.__isCouldShown = self.__lineIndex ~= 0
  local interActId = self:Act23GSSN_GetNodeBindInteractId()
  if interActId ~= nil and interActId ~= 0 then
    local interactData = self.sgData:GetSteinsGateInteractData()
    local isInteractted = interactData:GetThisTalkStateById(interActId)
    if not isInteractted then
      self.__isCouldShown = false
    end
  end
  local orConditionList = self.__storyNodeCfg.show_or_condition
  if #orConditionList == 0 then
    self.__isCouldShown = self.__isCouldShown and true
    self.__isOpenNode = true
    return
  end
  for _, conditionData in ipairs(orConditionList) do
    local pre_condition = {}
    local pre_para1 = {}
    local pre_para2 = {}
    for index, id in ipairs(conditionData.c) do
      table.insert(pre_condition, id)
      table.insert(pre_para1, conditionData.a1[index] or 0)
      table.insert(pre_para2, conditionData.a2[index] or 0)
    end
    if CheckCondition.CheckLua(pre_condition, pre_para1, pre_para2) then
      self.__isCouldShown = self.__isCouldShown and true
      self.__isOpenNode = true
      return
    end
  end
  self.__isCouldShown = false
  self.__isOpenNode = false
end

function Act23SGStoryNodeData:Act23GSSN_GetNodeID()
  return self.__sNodeId
end

function Act23SGStoryNodeData:Act23GSSN_GetIsChoulShow()
  return self.__isCouldShown
end

function Act23SGStoryNodeData:Act23GSSN_GetIsOpen()
  return self.__isOpenNode
end

function Act23SGStoryNodeData:Act23GSSN_GetLineIndex()
  return self.__lineIndex
end

function Act23SGStoryNodeData:Act23GSSN_GetGridIndex()
  return self.__lineGridIndex
end

function Act23SGStoryNodeData:Act23GSSN_GetIsBattleNode()
  return self.__isBattleStage
end

function Act23SGStoryNodeData:Act23GSSN_GetIsHaveStageId(inStageId)
  for diff, stageId in pairs(self.__storyNodeCfg.stage_id) do
    if inStageId == stageId then
      return true, diff
    end
  end
  return false
end

function Act23SGStoryNodeData:Act23GSSN_GetStageId(diff)
  if self:Act23GSSN_GetIsBattleNode() then
    local stageId = self.__storyNodeCfg.stage_id[diff]
    if stageId == nil then
      error("stageId not exist sNodeId:" .. tostring(self.sNodeId) .. " diff:" .. tostring(diff))
    end
    return stageId
  else
    return self.__storyNodeCfg.story_id
  end
end

function Act23SGStoryNodeData:Act23GSSN_GetIsUnlock(diff)
  if (self.__storyNodeCfg.stage_id == nil or #self.__storyNodeCfg.stage_id == 0) and (self.__storyNodeCfg.story_id == nil or self.__storyNodeCfg.story_id == 0) then
    return false
  end
  if self:Act23GSSN_GetIsBattleNode() then
    if diff == nil then
      for _diff, stageId in pairs(self.__storyNodeCfg.stage_id) do
        if stageId == nil then
          error("stageId not exist sNodeId:" .. tostring(self.sNodeId) .. " diff:" .. tostring(diff))
          return false
        end
        local stageCfg = ConfigData.sector_stage[stageId]
        if stageCfg == nil then
          error("stageCfg not exist sNodeId:" .. tostring(self.sNodeId) .. " diff:" .. tostring(diff))
          return false
        end
        if CheckCondition.CheckLua(stageCfg.pre_condition, stageCfg.pre_para1, stageCfg.pre_para2) then
          return true
        end
      end
      return false
    end
    local stageId = self.__storyNodeCfg.stage_id[diff]
    if stageId == nil then
      error("stageId not exist sNodeId:" .. tostring(self.sNodeId) .. " diff:" .. tostring(diff))
      return false
    end
    local stageCfg = ConfigData.sector_stage[stageId]
    if stageCfg == nil then
      error("stageCfg not exist sNodeId:" .. tostring(self.sNodeId) .. " diff:" .. tostring(diff))
      return false
    end
    return CheckCondition.CheckLua(stageCfg.pre_condition, stageCfg.pre_para1, stageCfg.pre_para2)
  else
    local avgId = self.__storyNodeCfg.story_id
    if avgId == nil then
      error("stageId not exist sNodeId:" .. tostring(self.sNodeId) .. " avgId:" .. tostring(avgId))
      return false
    end
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
    return avgPlayCtrl:IsAvgUnlock(avgId)
  end
end

function Act23SGStoryNodeData:Act23GSSN_IsHidenNode()
  if (self.__storyNodeCfg.stage_id == nil or #self.__storyNodeCfg.stage_id == 0) and (self.__storyNodeCfg.story_id == nil or self.__storyNodeCfg.story_id == 0) then
    return true
  end
  return false
end

function Act23SGStoryNodeData:Act23GSSN_GetIsClear(diff)
  if (self.__storyNodeCfg.stage_id == nil or #self.__storyNodeCfg.stage_id == 0) and (self.__storyNodeCfg.story_id == nil or self.__storyNodeCfg.story_id == 0) then
    return false
  end
  if self:Act23GSSN_GetIsBattleNode() then
    if diff == nil then
      for _diff, stageId in pairs(self.__storyNodeCfg.stage_id) do
        if PlayerDataCenter.sectorStage:IsStageComplete(stageId) then
          return true
        end
      end
      return false
    end
    local stageId = self.__storyNodeCfg.stage_id[diff]
    if stageId == nil then
      error("stageId not exist sNodeId:" .. tostring(self.sNodeId) .. " diff:" .. tostring(diff))
      return false
    end
    return PlayerDataCenter.sectorStage:IsStageComplete(stageId)
  else
    local avgId = self.__storyNodeCfg.story_id
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
    return avgPlayCtrl:IsAvgPlayed(avgId)
  end
end

function Act23SGStoryNodeData:RecordNodeDataState()
  self.__NodeDataState = self:GetNodeDataState()
end

function Act23SGStoryNodeData:GetIsNewState()
  local nowNodeDataState = self:GetNodeDataState()
  local isNewState = self.__NodeDataState ~= nowNodeDataState
  self.curNodeData = nowNodeDataState
  return isNewState, nowNodeDataState
end

function Act23SGStoryNodeData:GetNodeDataState()
  if not self:Act23GSSN_GetIsOpen() then
    return Act23SteinsGateEnum.nodeType.isLocked
  elseif not self:Act23GSSN_GetIsClear() then
    return Act23SteinsGateEnum.nodeType.isUnlocked
  else
    return Act23SteinsGateEnum.nodeType.isCompleted
  end
end

function Act23SGStoryNodeData:Act23GSSN_GetNodeTitle(strConnect)
  strConnect = strConnect or " "
  local title = string.format("%s%s%s", self.__storyNodeCfg.code, strConnect, self.__storyNodeCfg.code_num)
  return title
end

function Act23SGStoryNodeData:Act23GSSN_GetNodeBindInteractId()
  return self.__storyNodeCfg.interact_id
end

function Act23SGStoryNodeData:Act23GSSN_GetNodeOutLookIndex()
  return self.__storyNodeCfg.special
end

function Act23SGStoryNodeData:Act23Gs_GetLevelAvgReview()
  return self.__storyNodeCfg.avg_preview, self.__storyNodeCfg.avg_code
end

function Act23SGStoryNodeData:Act23GSSN__IsNeedShowFx()
  return self.__storyNodeCfg.special == 2 and not self:Act23GSSN_GetIsBattleNode()
end

function Act23SGStoryNodeData:Act23GSSN_GetPreNodeId()
  return self.__storyNodeCfg.precursor
end

function Act23SGStoryNodeData:Act23GSSN_GetNextNodeId()
  return self.__storyNodeCfg.succeed
end

function Act23SGStoryNodeData:Act23GSSN_GetNodeCfg()
  return self.__storyNodeCfg
end

function Act23SGStoryNodeData:Act23GSSN_GetExtrReward(diff)
  local rewardList = {}
  if self:Act23GSSN_GetIsBattleNode() then
    local isHard = diff == Act23SteinsGateEnum.eStoryDiff.Hard
    if not isHard then
      return rewardList
    end
    local stageId = self.__storyNodeCfg.stage_id[Act23SteinsGateEnum.eStoryDiff.Normal]
    local stageCfg = ConfigData.sector_stage[stageId]
    local isComplete = PlayerDataCenter.sectorStage:IsStageComplete(stageId)
    for index, rewardId in ipairs(stageCfg.first_reward_ids) do
      local rewardNum = stageCfg.first_reward_nums[index]
      table.insert(rewardList, {
        id = rewardId,
        num = rewardNum,
        isForcePicked = isComplete
      })
    end
  else
    local interactId = self:Act23GSSN_GetNodeBindInteractId()
    if interactId == nil or interactId == 0 then
      return rewardList
    end
    local interactData = self.sgData:GetSteinsGateInteractData()
    local reward = interactData:GetInteractReward(interactId)
    local idList, numList = CommonUtil.SplitStrToDoubleNumber(reward, "|", "=")
    for index, rewardId in ipairs(idList) do
      local rewardNum = numList[index]
      table.insert(rewardList, {id = rewardId, num = rewardNum})
    end
  end
  return rewardList
end

return Act23SGStoryNodeData
