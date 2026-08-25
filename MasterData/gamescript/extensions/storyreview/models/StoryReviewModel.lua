local CMD_Story = "BEPlayStory"
local CMD_ExeCmd = "BEExecuteCmd"
local CMD_AddState = "BEAddState"
local CMD_ChangeSkill = "BEMonsterChangeSkill"
local StoryReviewModel = NewClass("StoryReviewModel", BaseModel)

function StoryReviewModel:OnInit()
  self:OnReset()
end

function StoryReviewModel:OnReset()
  self.isStoryReviewing = false
  self.reviewingStoryList = {}
  self.reviewingStoryMap = {}
  self.cacheCmds = {}
  self.cacheStates = {}
end

function StoryReviewModel:StartReviewStory()
  self.isStoryReviewing = true
end

function StoryReviewModel:IsReviewingStory()
  return self.isStoryReviewing
end

function StoryReviewModel:StopReviewStory()
  self.isStoryReviewing = false
end

function StoryReviewModel:ResetStoryByStageTid(stageTid)
  local stageCfg = DT.Stage[stageTid]
  self.reviewingStoryList = {}
  self.reviewingStoryMap = {}
  if not stageCfg then
    return
  end
  self.cacheCmds = {}
  self.cacheStates = {}
  if stageCfg.StartStory and 0 ~= stageCfg.StartStory then
    self:_PushReivewingStoryId(stageCfg.StartStory)
  end
  if stageCfg.StartDia and 0 ~= stageCfg.StartDia then
    self:_PushReivewingStoryId(stageCfg.StartDia)
  end
  if stageCfg.EndStory and 0 ~= stageCfg.EndStory then
    self:_PushReivewingStoryId(stageCfg.EndStory)
  end
  self:_ParseStoriesFromMaps(stageCfg.Map, stageCfg.DefaultMusic and stageCfg.DefaultMusic[1])
  table.sort(self.reviewingStoryList, function(xIdInfo, yIdInfo)
    local xId, yId = xIdInfo[1], yIdInfo[1]
    return DT.AvgDialog[xId].data_list[1].BaseSortID < DT.AvgDialog[yId].data_list[1].BaseSortID
  end)
  self:_DedupeExclusiveReviewStories()
  for _, v in pairs(self.reviewingStoryList) do
    self.reviewingStoryMap[v[1]] = true
  end
end

function StoryReviewModel:_DedupeExclusiveReviewStories()
  if not self._exclusiveStoryGroupMap then
    self._exclusiveStoryGroupMap = {}
    local exclusiveGroups = DT.GetOriginalConstant("ExclusiveStoryGroups", {}) or {}
    for groupIndex, group in ipairs(exclusiveGroups) do
      for _, storyId in ipairs(group or {}) do
        self._exclusiveStoryGroupMap[storyId] = groupIndex
      end
    end
  end
  if not next(self._exclusiveStoryGroupMap) then
    return
  end
  local groupCandidates = {}
  for _, info in ipairs(self.reviewingStoryList or {}) do
    local storyId = info[1]
    local groupIndex = self._exclusiveStoryGroupMap[storyId]
    if groupIndex then
      groupCandidates[groupIndex] = groupCandidates[groupIndex] or {}
      table.insert(groupCandidates[groupIndex], storyId)
    end
  end
  local removeSet = {}
  for _, storyIds in pairs(groupCandidates) do
    if #storyIds <= 1 then
    else
      local keepId = storyIds[1]
      local removedIds = {}
      for i = 1, #storyIds do
        if storyIds[i] ~= keepId then
          removeSet[storyIds[i]] = true
          table.insert(removedIds, storyIds[i])
        end
      end
      Logger.Info("[StoryReview] 溯梦互斥剧情, 保留:", keepId)
    end
  end
  if not next(removeSet) then
    return
  end
  local newList = {}
  for i = 1, #(self.reviewingStoryList or {}) do
    local info = self.reviewingStoryList[i]
    if not removeSet[info[1]] then
      table.insert(newList, info)
    end
  end
  self.reviewingStoryList = newList
end

function StoryReviewModel:IsStoryReviewingById(storyId)
  return self.reviewingStoryMap and self.reviewingStoryMap[storyId]
end

function StoryReviewModel:_ParseStoriesFromMaps(mapTids, mapAudio)
  if not mapTids or 0 == #mapTids then
    return
  end
  local nodeList = {}
  for i = 1, #mapTids do
    if DT.MapNode[mapTids[i]] then
      table.insert(nodeList, mapTids[i])
    else
      local mapCfg = DT.Map[mapTids[i]]
      if not mapCfg or not mapCfg.data_list then
      else
        for j = 1, #mapCfg.data_list do
          local nodeCfgs = mapCfg.data_list[j]
          for k, v in pairs(nodeCfgs) do
            if self:IsMapNodeKey(k) then
              table.append(nodeList, v)
            end
          end
        end
      end
    end
  end
  for i = 1, #nodeList do
    local mapNode = DT.MapNode[nodeList[i]]
    if mapNode and mapNode.Type then
      if mapNode.Type == CommonDefine.GearItemType.Story then
        self:_ParseStoryIdFromStoryGear(mapNode.Effect[1], mapAudio)
      elseif CommonDefine.GearBattleType[mapNode.Type] then
        self:_ParseStoriesFromBattle(mapNode.Effect[1])
      end
    end
  end
end

local MapNodeKeys = {}

function StoryReviewModel:IsMapNodeKey(key)
  if nil ~= MapNodeKeys[key] then
    return MapNodeKeys[key]
  end
  local isMapNodeKey = string.find(key, "OddXaxis") or string.find(key, "EvenXaxis")
  MapNodeKeys[key] = isMapNodeKey
  return isMapNodeKey
end

function StoryReviewModel:IsStoryHaveAudio(storyId)
  local storyCfg = DT.AvgDialog[storyId] or {}
  local firstDialog = storyCfg.data_list and storyCfg.data_list[1]
  return firstDialog and firstDialog.Audio
end

function StoryReviewModel:_ParseStoryIdFromStoryGear(storyId, mapAudio)
  if self:IsStoryHaveAudio(storyId) then
    self:_PushReivewingStoryId(storyId)
  else
    self:_PushReivewingStoryId(storyId, mapAudio)
  end
end

function StoryReviewModel:_ParseStoriesFromBattle(battleTid)
  local battleCfg = DT.BattleConfig[battleTid]
  if not battleCfg then
    return
  end
  if battleCfg.BattleBeginDialogueId and 0 ~= battleCfg.BattleBeginDialogueId then
    self:_PushReivewingStoryId(battleCfg.BattleBeginDialogueId)
  end
  if battleCfg.VictoryDialogueId and 0 ~= battleCfg.VictoryDialogueId then
    self:_PushReivewingStoryId(battleCfg.VictoryDialogueId)
  end
  local parseStardIdx = #self.reviewingStoryList
  for mstIndex = 1, 10 do
    local mst = battleCfg["Monster" .. mstIndex]
    if mst and 0 ~= mst then
      self:_ParseStoriesFromMonster(mst)
    end
  end
  local parseEndIdx = #self.reviewingStoryList
  if parseStardIdx < parseEndIdx and battleCfg.EnterAudioEvent then
    for i = parseStardIdx + 1, parseEndIdx do
      local info = self.reviewingStoryList[parseStardIdx + 1]
      if not self:IsStoryHaveAudio(info[1]) then
        info[2] = battleCfg.EnterAudioEvent[1]
      end
    end
  end
end

function StoryReviewModel:_ParseStoriesFromMonster(mstTid)
  local mstCfg = DT.MonsterConfig[mstTid]
  if not mstCfg then
    return
  end
  if mstCfg.InitSkillList then
    for i = 1, #mstCfg.InitSkillList do
      self:_ParseStoriesFromSkill(mstCfg.InitSkillList[i])
    end
  end
  for skillListIndex = 1, 10 do
    local key = "CycleSkillList" .. skillListIndex
    if mstCfg[key] then
      for i = 1, #mstCfg[key] do
        self:_ParseStoriesFromSkill(mstCfg[key][i])
      end
    end
  end
  if mstCfg.ExistState then
    for i = 1, #mstCfg.ExistState do
      self:_ParseStoriesFromState(mstCfg.ExistState[i])
    end
  end
end

function StoryReviewModel:_ParseStoriesFromSkill(skillTid)
  local skillCfg = DT.Skill[skillTid]
  if not skillCfg then
    return
  end
  if skillCfg.PreCmd then
    local tCmd = type(skillCfg.PreCmd)
    if "number" == tCmd then
      self:_ParseStoriesFromCmd(skillCfg.PreCmd)
    elseif "table" == tCmd then
      for _, cmdTid in pairs(skillCfg.PreCmd) do
        self:_ParseStoriesFromCmd(cmdTid)
      end
    end
  end
  if skillCfg.CmdList then
    local tCmd = type(skillCfg.CmdList)
    if "number" == tCmd then
      self:_ParseStoriesFromCmd(skillCfg.CmdList)
    elseif "table" == tCmd then
      for _, cmdTid in pairs(skillCfg.CmdList) do
        self:_ParseStoriesFromCmd(cmdTid)
      end
    end
  end
end

function StoryReviewModel:_ParseStoriesFromCmd(cmdTid)
  if self.cacheCmds[cmdTid] then
    return
  end
  self.cacheCmds[cmdTid] = true
  local cmdCfg = DT.Cmd[cmdTid]
  if not cmdCfg or not cmdCfg.data_list then
    return
  end
  for i = 1, #cmdCfg.data_list do
    local cmd = cmdCfg.data_list[i]
    if cmd.Type == CMD_Story then
      self:_PushReivewingStoryId(cmd.Para)
    elseif cmd.Type == CMD_ExeCmd then
      self:_ParseStoriesFromCmd(cmd.Para)
    elseif cmd.Type == CMD_AddState then
      local tPara = type(cmd.Para)
      if "number" == tPara then
        self:_ParseStoriesFromState(cmd.Para)
      elseif "string" == tPara then
        local skillIds = string.split(cmd.Para, ",")
        self:_ParseStoriesFromState(tonumber(skillIds[1] or 0))
      end
      self:_ParseStoriesFromState(cmd.Para)
    elseif cmd.Type == CMD_ChangeSkill then
      local tPara = type(cmd.Para)
      if "number" == tPara then
        self:_ParseStoriesFromSkill(cmd.Para)
      elseif "string" == tPara then
        local skillIds = string.split(cmd.Para, ",")
        self:_ParseStoriesFromSkill(tonumber(skillIds[1] or 0))
      end
    end
  end
end

function StoryReviewModel:_ParseStoriesFromState(stateTid)
  if not stateTid or self.cacheStates[stateTid] then
    return
  end
  self.cacheStates[stateTid] = true
  local stateCfg = DT.State[stateTid]
  if not stateCfg then
    return
  end
  if stateCfg.TriggerCmd1 and 0 ~= stateCfg.TriggerCmd1 then
    self:_ParseStoriesFromCmd(stateCfg.TriggerCmd1)
  end
  if stateCfg.TriggerCmd2 and 0 ~= stateCfg.TriggerCmd2 then
    self:_ParseStoriesFromCmd(stateCfg.TriggerCmd2)
  end
  if stateCfg.TriggerCmd3 and 0 ~= stateCfg.TriggerCmd3 then
    self:_ParseStoriesFromCmd(stateCfg.TriggerCmd3)
  end
  if stateCfg.TriggerCmd4 and 0 ~= stateCfg.TriggerCmd4 then
    self:_ParseStoriesFromCmd(stateCfg.TriggerCmd4)
  end
end

function StoryReviewModel:_PushReivewingStoryId(storyId, enterAudio)
  self.reviewingStoryList = self.reviewingStoryList or {}
  local avgCfg = DT.AvgDialog[storyId]
  if not avgCfg or not avgCfg.data_list then
    return
  end
  for i = 1, #avgCfg.data_list do
    if avgCfg.data_list[i].DialogType == CommonDefine.AvgDialogType.AvgBubble then
      return
    end
  end
  table.insert(self.reviewingStoryList, {storyId, enterAudio})
end

function StoryReviewModel:GetStoryByIndex(index)
  Logger.Info("GetStoryByIndex:", index, "total:", #(self.reviewingStoryList or {}))
  return self.reviewingStoryList and self.reviewingStoryList[index]
end

function StoryReviewModel:PopStory()
  if self.reviewingStoryList then
    do return table.remove, self.reviewingStoryList end
    return table.remove, self.reviewingStoryList, 1
  end
end

function StoryReviewModel:ExistsStory()
  if self.reviewingStoryList then
    return #self.reviewingStoryList > 0
  end
  return false
end

function StoryReviewModel:ClearStories()
  self.reviewingStoryList = nil
end

function StoryReviewModel:IsCopyStoryShouldReivew(stageGroupId)
  local groupData = DataCenter.MainCopyData.allPlots[stageGroupId]
  if not groupData then
    return false
  end
  local lastStage = groupData.stageList[#groupData.stageList]
  if not lastStage or not lastStage.unlocked then
    return false
  end
  local stageData = MainCopyDataUtils.GetStageData(lastStage.stageID)
  if not stageData or not stageData.firstRewardDraw then
    return false
  end
  return true
end

function StoryReviewModel:IsReviewStoryPlayed()
  local mainKey = CommonDefine.ClientDataMainKey.AVG_Review_Story
  local subKey = "1"
  local status = ClientDataUtils.GetData(mainKey, subKey, 0)
  if status and 1 == status then
    return true
  end
  return false
end

function StoryReviewModel:SetReviewStoryPlayed()
  local mainKey = CommonDefine.ClientDataMainKey.AVG_Review_Story
  local subKey = "1"
  ClientDataUtils.SetData(mainKey, subKey, 1, true)
  self:Notify(NotifyId.OnStoryReviewRedStatusChanged)
end

function StoryReviewModel:IsMainCopyReviewStoryUnlock()
  if not self._firstMainCopyGroupId then
    local mainGroupTids = CopyDataUtils.CalculateChapterIndex(CommonDefine.Difficulty.Normal)
    self._firstMainCopyGroupId = mainGroupTids[1] or 0
    if CopyDataUtils.IsPrologue(self._firstMainCopyGroupId) then
      self._firstMainCopyGroupId = mainGroupTids[2] or 0
    end
  end
  local isUnlocked = self:IsCopyStoryShouldReivew(self._firstMainCopyGroupId)
  return isUnlocked
end

function StoryReviewModel:IsExistMainCopyReviewStoryRedNew()
  if not self:IsMainCopyReviewStoryUnlock() then
    return false
  end
  return not self:IsReviewStoryPlayed()
end

return StoryReviewModel
