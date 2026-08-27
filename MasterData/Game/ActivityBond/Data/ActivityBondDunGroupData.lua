local ActivityBondDunGroupData = class("ActivityBondDunGroupData")

function ActivityBondDunGroupData:ctor(dunGroupId, dunGropCfg)
  self.dunGroupId = dunGroupId
  self.dunGroupCfg = dunGropCfg
  self.dunDataList = {}
  self.dunDataDic = {}
  self.groupScore = 0
end

function ActivityBondDunGroupData:ActBond_AddDunData(dunData)
  table.insert(self.dunDataList, dunData)
  self.dunDataDic[dunData:GetDungeonLevelStageId()] = dunData
end

function ActivityBondDunGroupData:ActBond_RefreshByMsg(groupMsg)
  if groupMsg == nil then
    return
  end
  self.groupScore = groupMsg.stageScore or 0
  for dunId, dunMsg in pairs(groupMsg.stageElem) do
    local dunData = self.dunDataDic[dunId]
    if dunData ~= nil then
      dunData:ActBond_RefreshDunByMsg(dunMsg)
    end
  end
end

function ActivityBondDunGroupData:ActBond_GetTitle()
  return LanguageUtil.GetLocaleText(self.dunGroupCfg.group_name)
end

function ActivityBondDunGroupData:ActBond_GetScore()
  return self.groupScore
end

function ActivityBondDunGroupData:ActBond_GetIndex()
  return self.dunGroupId
end

function ActivityBondDunGroupData:ActBond_GetUnlockTime()
  return self.dunGroupCfg.time_unlock
end

function ActivityBondDunGroupData:ActBond_GetIsAllCleared()
  for _, dunData in ipairs(self.dunDataList) do
    if not dunData:GetIsClear() then
      return false
    end
  end
  return true
end

function ActivityBondDunGroupData:ActBond_GetGroupScore()
  local score = 0
  for _, dunData in ipairs(self.dunDataList) do
    score = score + dunData:GetBondDunScore()
  end
  return score
end

function ActivityBondDunGroupData:ActBond_GetBuffList()
  return self.dunGroupCfg.buff_id
end

function ActivityBondDunGroupData:ActBond_GetTransferBuffId()
  return self.dunGroupCfg.transfer_buff_id
end

function ActivityBondDunGroupData:ActBond_GetRankId()
  return self.dunGroupCfg.rank_id
end

function ActivityBondDunGroupData:ActBond_GetDunDataList()
  return self.dunDataList
end

return ActivityBondDunGroupData
