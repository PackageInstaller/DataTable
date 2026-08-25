local AwakerTalentExtModel, Super = NewClass("AwakerTalentExtModel", BaseModel)

function AwakerTalentExtModel:OnInit()
  self:OnReset()
  self.talentTable = self:_GenTalentTableFromCfg()
end

function AwakerTalentExtModel:OnReset()
  Super.OnReset(self)
  self.awakerTid = nil
  self.cfgTalentList = nil
  self.selectedIndex = nil
  self.talentTid = nil
  self.level = nil
end

function AwakerTalentExtModel:GetTalentCfgList(awakerTid)
  local talentCfgList = self.talentTable[awakerTid]
  if not talentCfgList then
    return talentCfgList
  end
  table.sort(talentCfgList, function(a, b)
    return a.BaseSortID < b.BaseSortID
  end)
  return talentCfgList
end

function AwakerTalentExtModel:GetDefaultTalentLvMap(awakerTid, talents)
  local talentCfgList = self:GetTalentCfgList(awakerTid)
  local map = {}
  for index, cfg in ipairs(talentCfgList) do
    local lv = 1
    local talentCfg = cfg.data_list and cfg.data_list[1]
    local talentName = talentCfg and talentCfg.TalentName or ""
    if TalentDataUtils.IsAttrTalent(talentCfg.ID) then
      lv = cfg.data_list and #cfg.data_list or 1
    end
    for i = 1, #CommonDefine.AwakerTalentOrderedType do
      local talentType = CommonDefine.AwakerTalentOrderedType[i]
      if string.contains(talentName, cd.AwakerTalentName[talentType]) then
        if talents then
          lv = talents[talentType] or lv
        end
        break
      end
    end
    map[cfg.ID] = {lv = lv}
  end
  return map
end

function AwakerTalentExtModel:_GenTalentTableFromCfg()
  local talentMap = {}
  local firstData, awakerId, baseSortId, copyCfg
  for talentId, cfg in pairs(DT.AwakerTalent) do
    firstData = cfg.data_list[1]
    if firstData then
      awakerId, baseSortId = firstData.AwakerID, firstData.BaseSortID
      copyCfg = table.clone(cfg)
      copyCfg.BaseSortID = baseSortId
      local list = talentMap[awakerId] or {}
      table.insert(list, copyCfg)
      talentMap[awakerId] = list
    end
  end
  return talentMap
end

function AwakerTalentExtModel:CheckTalentDefaultActivation(talentTid)
  local talentCfg = DT.AwakerTalent[talentTid]
  if not talentCfg then
    return false
  end
  local firstData = talentCfg.data_list[1] or {}
  if firstData.DefaultActivation and firstData.DefaultActivation == "TRUE" then
    return true
  end
  return false
end

function AwakerTalentExtModel:SetAwakerTid(awakerTid, defaultIndex)
  self.awakerTid = awakerTid
  self.cfgTalentList = self:GetTalentCfgList(awakerTid)
  self:SetSelectedIndex(defaultIndex)
end

function AwakerTalentExtModel:SetSelectedIndex(index)
  self.selectedIndex = index
  if not index or 0 == index then
    return
  end
  self.talentTid = self:GetTalentIdByIndex(index)
  self.level = self:GetTalentLevelByIndex(index)
end

function AwakerTalentExtModel:UpdateLevel(level)
  local awakerData = AwakerDataUtils.GetAwakerData(self.awakerTid)
  local talentInfo = awakerData.talents and awakerData.talents[self.talentTid] or {}
  talentInfo.lv = level
  self.level = level
end

function AwakerTalentExtModel:GetSelectedIndex()
  return self.selectedIndex
end

function AwakerTalentExtModel:GetAwakerTid()
  return self.awakerTid
end

function AwakerTalentExtModel:GetTalentIdByIndex(index, level)
  local cfg = self.cfgTalentList[index]
  return cfg and cfg.ID
end

function AwakerTalentExtModel:GetTalentCfgByIndex(index, level)
  level = level or self:GetTalentLevelByIndex(index)
  if 0 == level then
    level = 1
  end
  local cfg = self.cfgTalentList[index]
  local levelCfg = cfg and cfg.data_list[level]
  return levelCfg
end

function AwakerTalentExtModel:GetTalentLevelByID(talentId, level)
  local cfg = DT.AwakerTalent[talentId]
  local levelCfg = cfg and cfg.data_list[level]
  return levelCfg
end

function AwakerTalentExtModel:GetTalentNameByIndex(index)
  local level = self:GetTalentLevelByIndex(index)
  local talentCfg = self:GetTalentCfgByIndex(index, level)
  return talentCfg and talentCfg.TalentName
end

function AwakerTalentExtModel:GetBelongStageChapter(index)
  local level = self:GetTalentLevelByIndex(index)
  local talentCfg = self:GetTalentCfgByIndex(index, level)
  return talentCfg and talentCfg.Season
end

function AwakerTalentExtModel:GetTalentNameById(id, lv)
  local talentCfg = self:GetTalentCfg(id, lv)
  return talentCfg and talentCfg.TalentName
end

function AwakerTalentExtModel:GetTalentIconByIndex(index)
  local talentCfg = self:GetTalentCfgByIndex(index)
  return talentCfg and talentCfg.TalentIcon
end

function AwakerTalentExtModel:GetTalentDescByIndex(index, level, argsColor)
  local talentId = self:GetTalentIdByIndex(index)
  level = level or self:GetTalentLevelByIndex(index)
  do return SkillUtils.GetAwakerTalentDesc, talentId, level end
  return SkillUtils.GetAwakerTalentDesc, talentId, level, argsColor
end

function AwakerTalentExtModel:GetTalentDescById(id, lv)
  do return SkillUtils.GetAwakerTalentDesc, id end
  return SkillUtils.GetAwakerTalentDesc, id, lv
end

function AwakerTalentExtModel:GetTalentLevelByIndex(index)
  local awakerData = AwakerDataUtils.GetAwakerData(self.awakerTid)
  local talentTid = self:GetTalentIdByIndex(index)
  if not talentTid then
    return 0
  end
  local talentInfo = awakerData.talents and awakerData.talents[talentTid] or {}
  return talentInfo.lv or 0
end

function AwakerTalentExtModel:GetTalentMaxLevelByIndex(index)
  local cfg = self.cfgTalentList[index]
  return #(cfg and cfg.data_list or {})
end

function AwakerTalentExtModel:IsMaxLevel(index)
  if not index or 0 == index then
    return
  end
  local level = self:GetTalentLevelByIndex(index)
  local maxLevel = self:GetTalentMaxLevelByIndex(index)
  return level >= maxLevel
end

function AwakerTalentExtModel:IsAllTalentMaxLevel()
  local awakerData = AwakerDataUtils.GetAwakerData(self.awakerTid)
  local talents = awakerData.talents
  local talentCfgList = self.talentTable[self.awakerTid]
  if talents and talentCfgList then
    for _, talentCfg in ipairs(talentCfgList) do
      local talentTid = talentCfg.ID
      if talents[talentTid] then
        local maxLevel = #talentCfg.data_list
        local level = talents[talentTid].lv
        if maxLevel > level then
          return false
        end
      else
        return false
      end
    end
  end
  return true
end

function AwakerTalentExtModel:GetRequireItemByIndex(index)
  local level = self:GetTalentLevelByIndex(index)
  local upgradeLevel = level + 1
  local talentCfg = self:GetTalentCfgByIndex(index, upgradeLevel)
  return talentCfg and talentCfg.RequireItem
end

function AwakerTalentExtModel:IsUpgradeItemEnough(index)
  if not index or 0 == index then
    return
  end
  local requireItems = self:GetRequireItemByIndex(index)
  local isItemEnough = true
  for itemTid, num in table.iteraDouble(requireItems or {}) do
    local ownNum = ItemDataUtils.GetItemNum(itemTid)
    if num > ownNum then
      isItemEnough = false
      break
    end
  end
  return isItemEnough
end

function AwakerTalentExtModel:IsUpgradeMoneyEnough(index)
  if not index or 0 == index then
    return
  end
  local requireItems = self:GetRequireItemByIndex(index)
  for itemTid, num in table.iteraDouble(requireItems or {}) do
    local ownNum = ItemDataUtils.GetItemNum(itemTid)
    if itemTid == DT.GetConstant("GoldItemTid") then
      return num <= ownNum
    end
  end
  return true
end

function AwakerTalentExtModel:GetUpgradeNeedMoney(index)
  if not index or 0 == index then
    return
  end
  local requireItems = self:GetRequireItemByIndex(index)
  for itemTid, num in table.iteraDouble(requireItems or {}) do
    if itemTid == DT.GetConstant("GoldItemTid") then
      return num or 0
    end
  end
  return 0
end

function AwakerTalentExtModel:GetUnlockTaskId(index)
  local talentCfg = self:GetTalentCfgByIndex(index)
  return talentCfg and talentCfg.TaskCondition
end

function AwakerTalentExtModel:GetTalentCfg(talentTid, lv)
  local talentCfg = DT.AwakerTalent[talentTid] or {}
  local talentDataList = talentCfg.data_list or {}
  local firstCfg = talentDataList[1]
  if not firstCfg then
    return
  end
  local awakerTid = firstCfg.AwakerID
  local curLevel = lv or self:GetTalentLevel(awakerTid, talentTid)
  if 0 == curLevel then
    curLevel = 1
  end
  local cfg = talentDataList[curLevel] or {}
  return cfg
end

function AwakerTalentExtModel:GetNextTalentCfg(talentTid)
  local talentCfg = DT.AwakerTalent[talentTid] or {}
  local talentDataList = talentCfg.data_list or {}
  local firstCfg = talentDataList[1]
  if not firstCfg then
    return
  end
  local awakerTid = firstCfg.AwakerID
  local curLevel = self:GetTalentLevel(awakerTid, talentTid)
  local nextLevel = curLevel + 1
  local cfg = talentDataList[nextLevel] or {}
  return cfg
end

function AwakerTalentExtModel:IsUnlockedByIndex(index)
  local talentTid = self:GetTalentIdByIndex(index)
  do return self.IsUnlocked, self end
  return self.IsUnlocked, self, talentTid
end

function AwakerTalentExtModel:IsHaveUnlockTask(talentTid)
  local nextCfg = self:GetNextTalentCfg(talentTid)
  local taskList = nextCfg and nextCfg.TaskCondition
  return nil ~= taskList
end

function AwakerTalentExtModel:IsUnlocked(talentTid)
  local nextCfg = self:GetNextTalentCfg(talentTid)
  local taskList = nextCfg and nextCfg.TaskCondition
  local isUnlocked = true
  local unlockDesc, jumpTo
  for _, taskTid in ipairs(taskList or {}) do
    if not unlockDesc then
      local taskCfg = DT.Task[taskTid]
      unlockDesc = LT.Text(taskCfg.Desc)
    end
    if not TaskDataUtils.IsTaskDoneByTaskId(taskTid) then
      isUnlocked = false
      local taskCfg = DT.Task[taskTid]
      jumpTo = taskCfg.JumpTo
    end
  end
  return isUnlocked, unlockDesc, jumpTo
end

function AwakerTalentExtModel:GetTalentUpdateItems(talentTid)
  local nextCfg = self:GetNextTalentCfg(talentTid)
  return nextCfg and nextCfg.RequireItem
end

function AwakerTalentExtModel:GetTalentLevel(awakerTid, talentId)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  local talentInfo = awakerData.talents[talentId]
  return talentInfo and talentInfo.lv or 0
end

return AwakerTalentExtModel
