local GoldenSpyLevelData = class("GoldenSpyLevelData")
local GoldenSpyFloorData = require("Game.UI.Activity.GoldenSpy.GoldenSpyFloorData")

function GoldenSpyLevelData:ctor()
end

function GoldenSpyLevelData:InitData()
  if self.floorData == nil then
    self.floorData = GoldenSpyFloorData.new()
  end
  self.floorData:InitData()
  self.nCurScore = 0
  self.nCurFloor = 1
  self.nCurFloorId = nil
  self.tbCatchItem = {}
  self.tbBuff = {}
  self.tbUsedSkill = {}
  self.tbSkillData = {}
  self.taskData = {
    nScore = 0,
    tbItems = {}
  }
  self.nCompleteTaskCount = 0
  self.nBuffRefreshCount = 0
  self.nLevelType = nil
  self.tbRandomPrefabName = {}
  self.tempPointData = nil
end

function GoldenSpyLevelData:StartLevel(levelId)
  self.levelId = levelId
  self.levelConfig = ConfigTable.GetData("GoldenSpyLevel", levelId)
  if self.levelConfig == nil then
    return
  end
  self.nCurFloorId = self.levelConfig.FloorList[self.nCurFloor]
  self.floorData:StartFloor(levelId, self.nCurFloorId)
  self.nLevelType = self.levelConfig.LevelType
  local tbSkillData = decodeJson(self.levelConfig.Skill)
  for _, v in ipairs(tbSkillData) do
    self.tbSkillData[v[1]] = v[2]
    self.tbUsedSkill[v[1]] = 0
  end
  self.nBuffRefreshCount = self.levelConfig.BuffRefeshCount
end

function GoldenSpyLevelData:RestartCurrentFloor()
  if self.tempPointData == nil then
    self:InitData()
    self:StartLevel(self.levelId)
    return
  end
  local tbCatchItem = {}
  for k, v in pairs(self.tempPointData.tbCatchItem) do
    tbCatchItem[k] = {
      itemId = k,
      itemCount = v.itemCount
    }
  end
  local tbBuff = {}
  for k, v in pairs(self.tempPointData.tbBuff) do
    tbBuff[k] = {
      buffId = v.buffId,
      tbActiveFloor = v.tbActiveFloor,
      bActive = v.bActive
    }
  end
  local tbUsedSkill = {}
  for k, v in pairs(self.tempPointData.tbUsedSkill) do
    tbUsedSkill[k] = v
  end
  local tbSkillData = {}
  for k, v in pairs(self.tempPointData.tbSkillData) do
    tbSkillData[k] = v
  end
  self.nCurScore = self.tempPointData.nCurScore
  self.tbCatchItem = tbCatchItem
  self.tbBuff = tbBuff
  self.tbUsedSkill = tbUsedSkill
  self.tbSkillData = tbSkillData
  self.nCompleteTaskCount = self.tempPointData.nCompleteTaskCount
  self.nBuffRefreshCount = self.tempPointData.nBuffRefreshCount
  local tbList = {}
  for i = 1, #self.tempPointData.tbRandomPrefabName do
    table.insert(tbList, self.tempPointData.tbRandomPrefabName[i])
  end
  self.tbRandomPrefabName = tbList
  self.floorData:InitData()
  self.floorData:StartFloor(self.levelId, self.nCurFloorId)
end

function GoldenSpyLevelData:NextFloor()
  self.nCurFloor = self.nCurFloor + 1
  self.nCurFloorId = self.levelConfig.FloorList[self.nCurFloor]
  self.floorData:InitData()
  self.floorData:StartFloor(self.levelId, self.nCurFloorId)
  local tbCatchItem = {}
  for k, v in pairs(self.tbCatchItem) do
    tbCatchItem[k] = {
      itemId = k,
      itemCount = v.itemCount
    }
  end
  local tbBuff = {}
  for k, v in pairs(self.tbBuff) do
    tbBuff[k] = {
      buffId = v.buffId,
      tbActiveFloor = v.tbActiveFloor,
      bActive = v.bActive
    }
  end
  local tbUsedSkill = {}
  for k, v in pairs(self.tbUsedSkill) do
    tbUsedSkill[k] = v
  end
  local tbSkillData = {}
  for k, v in pairs(self.tbSkillData) do
    tbSkillData[k] = v
  end
  local tbRandomPrefabName = {}
  for i = 1, #self.tbRandomPrefabName do
    table.insert(tbRandomPrefabName, self.tbRandomPrefabName[i])
  end
  self.tempPointData = {
    nCurScore = self.nCurScore,
    tbCatchItem = tbCatchItem,
    tbBuff = tbBuff,
    tbUsedSkill = tbUsedSkill,
    tbSkillData = tbSkillData,
    nCompleteTaskCount = self.nCompleteTaskCount,
    nBuffRefreshCount = self.nBuffRefreshCount,
    tbRandomPrefabName = tbRandomPrefabName
  }
end

function GoldenSpyLevelData:GetFloorData()
  return self.floorData
end

function GoldenSpyLevelData:GetCurScore()
  return self.nCurScore
end

function GoldenSpyLevelData:AddScore(nScore)
  self.nCurScore = self.nCurScore + nScore
end

function GoldenSpyLevelData:GetCurFloor()
  return self.nCurFloor
end

function GoldenSpyLevelData:GetTotalFloor()
  return #self.levelConfig.FloorList
end

function GoldenSpyLevelData:GetCurFloorId()
  return self.nCurFloorId
end

function GoldenSpyLevelData:GetLevelPrefabName()
  local floorCfg = ConfigTable.GetData("GoldenSpyFloor", self.nCurFloorId)
  if floorCfg == nil then
    return
  end
  local nPrefabName = floorCfg.PrefabName[1]
  if self.levelConfig.LevelType == GameEnum.GoldenSpyLevelType.Random then
    local tbPrefabPool = {}
    for i = 1, #floorCfg.PrefabName do
      table.insert(tbPrefabPool, floorCfg.PrefabName[i])
    end
    for i = #tbPrefabPool, 1, -1 do
      local index = table.indexof(self.tbRandomPrefabName, tbPrefabPool[i])
      if 0 < index then
        table.remove(tbPrefabPool, i)
      end
    end
    local nRandomIndex = math.random(1, #tbPrefabPool)
    nPrefabName = tbPrefabPool[nRandomIndex]
    table.insert(self.tbRandomPrefabName, nPrefabName)
  end
  return nPrefabName
end

function GoldenSpyLevelData:CatchedItem(tbItemCtrl)
  local nTotalScore = 0
  for _, itemCtrl in ipairs(tbItemCtrl) do
    local itemCfg = itemCtrl:GetItemCfg()
    if itemCfg ~= nil then
      local nScore = itemCfg.Score
      if itemCfg.ItemType == GameEnum.GoldenSpyItem.SafeBox then
        nScore = itemCtrl:GetScore()
      end
      if itemCfg.ItemType == GameEnum.GoldenSpyItem.Companion then
        nScore = nScore + itemCtrl:GetBagItemPrice()
      end
      for _, v in ipairs(self.tbBuff) do
        local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", v.buffId)
        if buffCfg ~= nil and buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddScore and buffCfg.Params[1] == itemCfg.ItemType and self:CheckBuffActive(v) then
          nScore = nScore + buffCfg.Params[2]
        end
      end
      nTotalScore = nTotalScore + nScore
    end
  end
  self.nCurScore = self.nCurScore + nTotalScore
  local bFinishTask = false
  for _, itemCtrl in ipairs(tbItemCtrl) do
    local itemCfg = itemCtrl:GetItemCfg()
    if itemCfg ~= nil then
      local nItemId = itemCfg.Id
      if self.tbCatchItem[nItemId] == nil then
        self.tbCatchItem[nItemId] = {itemId = nItemId, itemCount = 0}
      end
      self.tbCatchItem[nItemId].itemCount = self.tbCatchItem[nItemId].itemCount + 1
      self.floorData:DeleteItem(nItemId)
      bFinishTask = self:UpdateTask(nItemId) or bFinishTask
    end
  end
  if bFinishTask then
    self:RefreshTask()
  end
  return bFinishTask, nTotalScore
end

function GoldenSpyLevelData:GetCatchItemData()
  return self.tbCatchItem
end

function GoldenSpyLevelData:GetTaskData()
  return self.taskData
end

function GoldenSpyLevelData:RefreshTask()
  local nScore = 0
  local tbItems = {}
  self.taskData = {
    nScore = 0,
    tbItems = {}
  }
  local allItems = self.floorData:GetItems()
  local items = {}
  for _, v in pairs(allItems) do
    local itemCfg = ConfigTable.GetData("GoldenSpyItem", v.itemId)
    if itemCfg ~= nil and itemCfg.IsTask then
      table.insert(items, v)
    end
  end
  local nTotalItemCount = 0
  for _, v in pairs(items) do
    nTotalItemCount = nTotalItemCount + v.itemCount
  end
  if nTotalItemCount <= 0 then
    return
  end
  local nRandomMaxCount = math.min(nTotalItemCount, 3)
  local nExWeight = 0
  for _, v in ipairs(self.tbBuff) do
    local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", v.buffId)
    if buffCfg ~= nil and buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddTaskWeight and self:CheckBuffActive(v) then
      nExWeight = nExWeight + buffCfg.Params[1]
    end
  end
  local tbRandomTaskConfig = {}
  local nRandomTotalWeight = 0
  local mLogWeight = 0
  
  local function forEachLine_ExScore(mapLineData)
    if mapLineData.ItemCount <= nRandomMaxCount then
      table.insert(tbRandomTaskConfig, mapLineData)
      if mapLineData.ItemCount == 1 then
        nRandomTotalWeight = nRandomTotalWeight + mapLineData.Weight + nExWeight
        mLogWeight = mapLineData.Weight + nExWeight
      else
        nRandomTotalWeight = nRandomTotalWeight + mapLineData.Weight
      end
    end
  end
  
  ForEachTableLine(DataTable.GoldenSpyExtraScore, forEachLine_ExScore)
  if NovaAPI.IsEditorPlatform() then
    print("GoldenSpyLevelCtrl: 单个物品任务权重:", mLogWeight, "总权重:", nRandomTotalWeight)
  end
  if #tbRandomTaskConfig <= 0 then
    return
  end
  local nRandomWeight = math.random(1, nRandomTotalWeight)
  local tempWeight = 0
  local nRandomCount = 0
  for i, v in ipairs(tbRandomTaskConfig) do
    if v.ItemCount == 1 then
      tempWeight = tempWeight + v.Weight + nExWeight
    else
      tempWeight = tempWeight + v.Weight
    end
    if nRandomWeight <= tempWeight then
      nScore = v.Score
      nRandomCount = v.ItemCount
      break
    end
  end
  local tempNum = 0
  local tempItemList = {}
  for _, v in pairs(items) do
    for i = 1, v.itemCount do
      table.insert(tempItemList, v.itemId)
    end
  end
  for i = 1, nRandomCount do
    local nRandomNum = math.random(1, #tempItemList)
    table.insert(tbItems, {
      nItemId = tempItemList[nRandomNum],
      bFinish = false
    })
    table.remove(tempItemList, nRandomNum)
  end
  for _, v in ipairs(self.tbBuff) do
    local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", v.buffId)
    if buffCfg ~= nil and buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddExScoreFactor and self:CheckBuffActive(v) then
      nScore = nScore * (1 + buffCfg.Params[1] / 100.0)
      nScore = math.floor(nScore)
    end
  end
  self.taskData = {nScore = nScore, tbItems = tbItems}
end

function GoldenSpyLevelData:UpdateTask(nItemId)
  if self.taskData == nil or self.taskData.nScore == 0 then
    return false
  end
  for _, v in ipairs(self.taskData.tbItems) do
    if v.nItemId == nItemId and v.bFinish == false then
      v.bFinish = true
      break
    end
  end
  local bFinish = true
  for _, v in ipairs(self.taskData.tbItems) do
    if v.bFinish == false then
      bFinish = false
      break
    end
  end
  if bFinish then
    self:AddScore(self.taskData.nScore)
    self.nCompleteTaskCount = self.nCompleteTaskCount + 1
  end
  return bFinish
end

function GoldenSpyLevelData:GetCompleteTaskCount()
  return self.nCompleteTaskCount
end

function GoldenSpyLevelData:GetBuffData()
  return self.tbBuff
end

function GoldenSpyLevelData:AddBuff(nBuffId)
  local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", nBuffId)
  if buffCfg == nil then
    return
  end
  local buffEntity = {
    buffId = nBuffId,
    tbActiveFloor = {},
    bActive = false
  }
  if buffCfg.BuffType == GameEnum.GoldenSpyBuffType.TemporaryBuff then
    table.insert(buffEntity.tbActiveFloor, self.nCurFloor)
    buffEntity.bActive = true
    if buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddTimeInFloor then
      buffEntity.bActive = false
    end
  elseif buffCfg.BuffType == GameEnum.GoldenSpyBuffType.DelayBuff then
    table.insert(buffEntity.tbActiveFloor, self.nCurFloor + 1)
    buffEntity.bActive = true
  elseif buffCfg.BuffType == GameEnum.GoldenSpyBuffType.PermanentBuff then
    buffEntity.bActive = true
  elseif buffCfg.BuffType == GameEnum.GoldenSpyBuffType.SkillCountBuff then
    buffEntity.bActive = true
    if buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddSkillUseCount then
      self.tbSkillData[buffCfg.Params[1]] = (self.tbSkillData[buffCfg.Params[1]] or 0) + buffCfg.Params[2]
      EventManager.Hit("GoldenSpy_UpdateSkillCount", buffCfg.Params[1], self.tbSkillData[buffCfg.Params[1]])
    elseif buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddBuffRefreshCount then
      self.nBuffRefreshCount = self.nBuffRefreshCount + buffCfg.Params[1]
    end
  end
  table.insert(self.tbBuff, buffEntity)
  if self.taskData ~= nil and 0 < self.taskData.nScore and buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddExScoreFactor and self:CheckBuffActive(buffEntity) then
    self.taskData.nScore = self.taskData.nScore * (1 + buffCfg.Params[1] / 100.0)
    self.taskData.nScore = math.floor(self.taskData.nScore)
    EventManager.Hit("GoldenSpy_UpdateTaskScore", self.taskData.nScore)
  end
  if buffCfg.EffectType == GameEnum.GoldenSpyBuffEffect.AddScore then
    EventManager.Hit("GoldenSpy_ItemUpdateScore", self.tbBuff)
  end
end

function GoldenSpyLevelData:CheckBuffActive(buffEntity)
  local buffCfg = ConfigTable.GetData("GoldenSpyBuffCard", buffEntity.buffId)
  if buffCfg == nil then
    return false
  end
  local bActive = false
  if buffCfg.BuffType == GameEnum.GoldenSpyBuffType.TemporaryBuff then
    if buffEntity.bActive and table.indexof(buffEntity.tbActiveFloor, self.nCurFloor) > 0 then
      bActive = true
    end
  elseif buffCfg.BuffType == GameEnum.GoldenSpyBuffType.DelayBuff then
    if buffEntity.bActive and table.indexof(buffEntity.tbActiveFloor, self.nCurFloor) > 0 then
      bActive = true
    end
  elseif buffCfg.BuffType == GameEnum.GoldenSpyBuffType.PermanentBuff then
    if buffEntity.bActive then
      bActive = true
    end
  elseif buffCfg.BuffType == GameEnum.GoldenSpyBuffType.SkillCountBuff then
  end
  return bActive
end

function GoldenSpyLevelData:GetRefreshCount()
  return self.nBuffRefreshCount
end

function GoldenSpyLevelData:UseRefreshCount()
  if self.nBuffRefreshCount <= 0 then
    return false
  end
  self.nBuffRefreshCount = self.nBuffRefreshCount - 1
  return true
end

function GoldenSpyLevelData:AddRefreshCount(nCount)
  self.nBuffRefreshCount = self.nBuffRefreshCount + nCount
end

function GoldenSpyLevelData:GetSkillData()
  return self.tbSkillData
end

function GoldenSpyLevelData:GetUsedSkillData()
  return self.tbUsedSkill
end

function GoldenSpyLevelData:UseSkill(nSkillId)
  if self.tbSkillData[nSkillId] == nil or self.tbSkillData[nSkillId] <= 0 then
    return
  end
  self.tbSkillData[nSkillId] = self.tbSkillData[nSkillId] - 1
  self.tbUsedSkill[nSkillId] = self.tbUsedSkill[nSkillId] + 1
end

function GoldenSpyLevelData:AddSkill(nSkillId, nCount)
  if self.tbSkillData[nSkillId] == nil then
    return
  end
  self.tbSkillData[nSkillId] = self.tbSkillData[nSkillId] + nCount
  EventManager.Hit("GoldenSpy_UpdateSkillCount", nSkillId, self.tbSkillData[nSkillId])
end

return GoldenSpyLevelData
