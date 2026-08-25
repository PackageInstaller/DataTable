local AbyssExtChallengeModel, Super = NewClass("AbyssExtChallengeModel", BaseModel)

function AbyssExtChallengeModel:OnInit()
  self:OnReset()
end

function AbyssExtChallengeModel:OnReset()
  self.abyssStageGroupMap = nil
  self:ResetViewSelectData()
end

function AbyssExtChallengeModel:ResetViewSelectData()
  self.passedStageTid = 0
  self.curSelectStageTid = 0
  self.curSelectMonsterTid = nil
  self.team = nil
end

function AbyssExtChallengeModel:GetCurSelectStageTid()
  return self.curSelectStageTid
end

function AbyssExtChallengeModel:GetPassedStageTid()
  return self.passedStageTid
end

function AbyssExtChallengeModel:GetAbyssStageDataList(stageGroupTid)
  local stageTids = self:GetChildStageTids(stageGroupTid)
  local stageList = {}
  if not stageTids then
    return stageList
  end
  for _, tid in ipairs(stageTids) do
    local stageConfig = CopyDataUtils.GetStageConfig(tid)
    if stageConfig then
      table.insert(stageList, {
        tid = tid,
        name = LT.Text(stageConfig.Name),
        recommendLv = stageConfig.RecLevel,
        dailyChallengeMadnessDifficulty = stageConfig.DailyChallengeMadnessDifficulty
      })
    end
  end
  return stageList
end

function AbyssExtChallengeModel:GetChildStageTids(stageGroupTid)
  if not stageGroupTid then
    return {}
  end
  if self.abyssStageGroupMap then
    return self.abyssStageGroupMap[stageGroupTid] or {}
  end
  self.abyssStageGroupMap = {}
  local abyssStageGroups = {}
  for tid, cfg in pairs(DT.StageGroup) do
    if cfg.Type == CommonDefine.StageGroupType.AbyssChallenge then
      abyssStageGroups[tid] = true
    end
  end
  for stageTid, cfg in pairs(DT.Stage) do
    if cfg and cfg.BelongGroup and abyssStageGroups[cfg.BelongGroup] then
      if not self.abyssStageGroupMap[cfg.BelongGroup] then
        self.abyssStageGroupMap[cfg.BelongGroup] = {}
      end
      if not table.contains(self.abyssStageGroupMap[cfg.BelongGroup], stageTid) then
        table.insert(self.abyssStageGroupMap[cfg.BelongGroup], stageTid)
      end
    end
  end
  
  local function StageSorter(a, b)
    local cfgA = CopyDataUtils.GetStageConfig(a)
    local cfgB = CopyDataUtils.GetStageConfig(b)
    return cfgA.StageLevel < cfgB.StageLevel
  end
  
  for _stageGroupTid, _ in pairs(self.abyssStageGroupMap) do
    table.sort(self.abyssStageGroupMap[_stageGroupTid], StageSorter)
  end
  return self.abyssStageGroupMap[stageGroupTid] or {}
end

function AbyssExtChallengeModel:GetInitRelicList(stageTid)
  local list = {}
  stageTid = stageTid or self.curSelectStageTid
  local config = CopyDataUtils.GetStageConfig(stageTid)
  if config and config.InitRelic then
    list = config.InitRelic
  end
  return list
end

function AbyssExtChallengeModel:GetMonsterTidList(stageTid, isSort)
  stageTid = stageTid or self.curSelectStageTid
  if nil == isSort then
    isSort = true
  end
  do return CopyDataUtils.GetStageMonsterWithAffixList, stageTid end
  return CopyDataUtils.GetStageMonsterWithAffixList, stageTid, isSort
end

function AbyssExtChallengeModel:GetPassedAwakerDataList(stageTid)
  if not self:IsPassedStage(stageTid) then
    return {}
  end
  return self.team and self.team.awakers or {}
end

function AbyssExtChallengeModel:GetChallengeScore(stageTid)
  local stageConfig = CopyDataUtils.GetStageConfig(stageTid) or {}
  if tonumber(stageConfig.AbyssChallengeScore) then
    do return tonumber end
    return tonumber, stageConfig.AbyssChallengeScore
  end
  do return table.unpack end
  return table.unpack, stageConfig.AbyssChallengeScore or {}
end

function AbyssExtChallengeModel:GetChallengeExtraScore(stageTid)
  local stageConfig = CopyDataUtils.GetStageConfig(stageTid) or {}
  if tonumber(stageConfig.AbyssChallengeScore) then
    return 0
  end
  local _, extraScore = table.unpack(stageConfig.AbyssChallengeScore or {})
  return extraScore or 0
end

function AbyssExtChallengeModel:GetChallengeTotalScore(stageTid)
  local stageConfig = CopyDataUtils.GetStageConfig(stageTid) or {}
  if tonumber(stageConfig.AbyssChallengeScore) then
    do return tonumber end
    return tonumber, stageConfig.AbyssChallengeScore, nil, nil
  end
  local normalScore, extraScore = table.unpack(stageConfig.AbyssChallengeScore or {})
  return (normalScore or 0) + (extraScore or 0)
end

function AbyssExtChallengeModel:GetPassedExtraAwakerDataList(stageTid)
  if not self:IsPassedStage(stageTid) then
    return {}
  end
  if not self:IsPassExtraChallenge(stageTid) then
    return {}
  end
  return self.teamExtra and self.teamExtra.awakers or {}
end

function AbyssExtChallengeModel:IsPassNormalChallenge(stageTid)
  if self.passedStageTid == stageTid and table.next(self.team and self.team.awakers or {}) then
    return true
  end
end

function AbyssExtChallengeModel:IsPassExtraChallenge(stageTid)
  if self.passedStageTid == stageTid and self.extraPass and table.next(self.teamExtra and self.teamExtra.awakers or {}) then
    return true
  end
end

function AbyssExtChallengeModel:IsHaveExtraChallenge(stageTid)
  local extraScore = self:GetChallengeExtraScore(stageTid)
  if not extraScore or extraScore <= 0 then
    return false
  end
  return true
end

function AbyssExtChallengeModel:IsStageGroupHaveExtraChallenge(stageGroupTid)
  local stageTids = self:GetChildStageTids(stageGroupTid)
  local stageTid = stageTids[1]
  return stageTid and self:IsHaveExtraChallenge(stageTid)
end

function AbyssExtChallengeModel:IsExtraChallenge(stageTid)
  if not self:IsHaveExtraChallenge(stageTid) then
    return false
  end
  return self:IsPassNormalChallenge(stageTid) and not self:IsPassExtraChallenge(stageTid)
end

function AbyssExtChallengeModel:IsPassedStage(stageTid)
  if not self.passedStageTid or self.passedStageTid <= 0 then
    return false
  end
  stageTid = stageTid or self.curSelectStageTid
  return stageTid == self.passedStageTid
end

function AbyssExtChallengeModel:IsSelectMonsterValid(monsterTid)
  if type(monsterTid) == "number" then
    return monsterTid and monsterTid > 0
  end
  if type(monsterTid) == "string" then
    return monsterTid and "" ~= monsterTid
  end
end

function AbyssExtChallengeModel:UpdateData(abyssStageGroupData)
  self.team = abyssStageGroupData and abyssStageGroupData.team or {}
  self.teamExtra = abyssStageGroupData and abyssStageGroupData.teamExtra or {}
  self.extraPass = abyssStageGroupData and abyssStageGroupData.extraPass or false
  self.passedStageTid = abyssStageGroupData and abyssStageGroupData.stageTid
end

function AbyssExtChallengeModel:SetCurSelectStageTid(stageTid)
  self.curSelectStageTid = stageTid or 0
  self:LocalNotify(NotifyId.OnSelectAbyssStage, self.curSelectStageTid)
end

function AbyssExtChallengeModel:SetPassedStageTid(stageTid)
  self.passedStageTid = stageTid or 0
end

function AbyssExtChallengeModel:SetSelectMonsterTid(monsterTid)
  self.curSelectMonsterTid = monsterTid
  self:LocalNotify(NotifyId.OnChooseMonster, self.curSelectMonsterTid)
end

return AbyssExtChallengeModel
