local AllLtrPoolData = class("AllLtrPoolData")
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local LotteryPoolData = require("Game.Lottery.Data.LotteryPoolData")
local LotteryPoolGroupData = require("Game.Lottery.Data.LotteryPoolGroupData")

function AllLtrPoolData:ctor()
  self._OnLtrDayNumUpdateFunc = BindCallback(self, self._OnLtrDayNumUpdate)
  self._fairyLtrPoolDataList = {}
  self:InitAllLtrPoolData()
end

function AllLtrPoolData:InitAllLtrPoolData()
  self.ltrDataDic = {}
  self.ltrRecords = {}
  self.ltrSpecial = {}
  self.ltrGroupSelectTagDic = {}
  self.__maxRecords = 20
end

function AllLtrPoolData:OpenLtrPoolData(activityFrameData)
  local ltrId = activityFrameData:GetActId()
  local ltrData = LotteryPoolData.New(ltrId)
  self.ltrDataDic[ltrId] = ltrData
  self:_UpdLtrPoolRedDot(ltrData)
end

function AllLtrPoolData:CloseLtrPoolData(activityFrameData)
  local ltrId = activityFrameData:GetActId()
  local ltrData = self.ltrDataDic[ltrId]
  if ltrData ~= nil then
    self:GetLtrRedDotNode():RemoveChild(ltrData.poolId)
  end
  self.ltrDataDic[ltrId] = nil
end

function AllLtrPoolData:GetLtrRedDotNode()
  if self._ltrRedNode == nil then
    local ok, ltrRedNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.LotteryPr)
    self._ltrRedNode = ltrRedNode
  end
  return self._ltrRedNode
end

function AllLtrPoolData:_UpdLtrPoolRedDot(ltrData)
  if ltrData:IsLtrHasTenPrior() then
    local poolNode = self:GetLtrRedDotNode():AddChildWithPath(ltrData.poolId, RedDotDynPath.LotteryPrPoolPath)
    local ltrTenNode = poolNode:AddChild(RedDotStaticTypeId.LotteryTen)
    local ltrTenPriorNode = ltrTenNode:AddChild(RedDotStaticTypeId.LotteryTenPrior)
    ltrTenPriorNode:SetRedDotCount(ltrData:LtrCurTenIsPrior() and 1 or 0)
  end
end

function AllLtrPoolData:UpdAllLtrPoolRedDot()
  for ltrId, ltrData in pairs(self.ltrDataDic) do
    self:_UpdLtrPoolRedDot(ltrData)
  end
end

function AllLtrPoolData:UpdSpecialAndRecordsData(specialMissFix, records)
  if specialMissFix ~= nil then
    for k, v in pairs(specialMissFix) do
      self.ltrSpecial[v.id] = v.miss
    end
  end
  if 0 < #records then
    local ltrRecords = {}
    for k, v in ipairs(records) do
      table.insert(ltrRecords, 1, v)
    end
    self.ltrRecords = ltrRecords
  end
end

function AllLtrPoolData:UpdGroupSelectTagData(tags)
  if tags == nil then
    return
  end
  for i, v in ipairs(tags) do
    local tempGroupPoolId = v >> 32
    local tempPoolId = v & CommonUtil.UInt32Max
    self.ltrGroupSelectTagDic[tempGroupPoolId] = tempPoolId
  end
end

function AllLtrPoolData:UpdAllLtrPoolData(detail)
  local addDayNumUpdEvent = false
  for ltrId, v in pairs(detail) do
    local ltrData = self.ltrDataDic[ltrId]
    if ltrData ~= nil then
      ltrData:UpdLtrPoolData(v)
      local ts = ltrData:GetLtrPoolDayNumUpdateTimestamp()
      if 0 < ts and (self._dayNumEarlistUpdateTs == nil or ts < self._dayNumEarlistUpdateTs) then
        self._dayNumEarlistUpdateTs = ts
        addDayNumUpdEvent = true
      end
    end
  end
  if addDayNumUpdEvent then
    local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
    timePassCtrl:RemoveEventTimer(self._updDayNumEventId)
    self._updDayNumEventId = timePassCtrl:AddEventTimer(self._dayNumEarlistUpdateTs, self._OnLtrDayNumUpdateFunc)
  end
end

function AllLtrPoolData:_OnLtrDayNumUpdate()
  self._dayNumEarlistUpdateTs = nil
  NetworkManager:GetNetwork(NetworkTypeID.Lottery):CS_LOTTERY_Detail()
end

function AllLtrPoolData:SetDrawHeroRankCount(drawHeroRankCount)
  self.drawHeroRankCount = drawHeroRankCount
end

function AllLtrPoolData:IsDrawHeroRankCountAboveZero()
  if PlayerDataCenter.allLtrData.drawHeroRankCount ~= nil and PlayerDataCenter.allLtrData.drawHeroRankCount > 0 then
    return true
  end
end

function AllLtrPoolData:GetOpeningLtrPoolDataList()
  local ltrDataList = {}
  for ltrId, ltrData in pairs(self.ltrDataDic) do
    if ltrData:IsLtrPoolOpen() then
      table.insert(ltrDataList, ltrData)
    end
  end
  return ltrDataList
end

function AllLtrPoolData:TryGetOpenLotteryGroup(letteryId)
  local groupId = self:TryGetLtrGroupId(letteryId)
  local ltrGroupCfg = ConfigData.lottery_group[groupId]
  local ltrGroupDataList = {}
  for idx, grpLtrId in ipairs(ltrGroupCfg.list) do
    if self:GetIsSpecificPoolOpen(grpLtrId) then
      table.insert(ltrGroupDataList, self.ltrDataDic[grpLtrId])
    end
  end
  return ltrGroupDataList
end

function AllLtrPoolData:GetOpeningLtrGroupPoolDataList(isIncludeFairy)
  local inGroupIdDic = {}
  local ltrGroupDataList = {}
  for ltrId, ltrData in pairs(self.ltrDataDic) do
    if ltrData:IsLtrPoolOpen() and (isIncludeFairy or ltrData:GetLotteryDataCfgPoolType() ~= LotteryEnum.eLotteryPoolLogicType.fairy) then
      local groupId = ConfigData.lottery_group.ltrGroupIdMap[ltrId]
      if groupId == nil then
        local ltrGroupData = LotteryPoolGroupData.New(ltrData)
        table.insert(ltrGroupDataList, ltrGroupData)
      elseif inGroupIdDic[groupId] == nil then
        inGroupIdDic[groupId] = true
        local ltrGroupCfg = ConfigData.lottery_group[groupId]
        local firstPoolData
        local inGroupNum = 0
        for idx, grpLtrId in ipairs(ltrGroupCfg.list) do
          if self:GetIsSpecificPoolOpen(grpLtrId) then
            inGroupNum = inGroupNum + 1
            if inGroupNum == 1 then
              firstPoolData = self.ltrDataDic[grpLtrId]
            end
          end
        end
        local ltrGroupData
        if 1 < inGroupNum then
          ltrGroupData = LotteryPoolGroupData.New(firstPoolData, groupId)
        else
          ltrGroupData = LotteryPoolGroupData.New(ltrData)
        end
        table.insert(ltrGroupDataList, ltrGroupData)
      end
    end
  end
  table.sort(ltrGroupDataList, function(a, b)
    return ConfigData.lottery_para[a.ltrPoolData.poolId].line < ConfigData.lottery_para[b.ltrPoolData.poolId].line
  end)
  return ltrGroupDataList
end

function AllLtrPoolData:GetIsOpenByGroupId(groupId)
  local poolGroupDataList = self:GetOpeningLtrGroupPoolDataList()
  for i, groupData in pairs(poolGroupDataList) do
    if groupData:GetLtrMoreGroupId() == groupId then
      local poolList = groupData:GetLtrInGroupDataList()
      if 0 < #poolList then
        return true
      end
    end
  end
  return false
end

function AllLtrPoolData:GetFairyLtrPoolDataList()
  table.clearmap(self._fairyLtrPoolDataList)
  for ltrId, ltrData in pairs(self.ltrDataDic) do
    if ltrData:IsLtrPoolOpen() and ltrData:GetLotteryDataCfgPoolType() == LotteryEnum.eLotteryPoolLogicType.fairy then
      table.insert(self._fairyLtrPoolDataList, ltrData)
    end
  end
  table.sort(self._fairyLtrPoolDataList, function(a, b)
    return a.poolId < b.poolId
  end)
  return self._fairyLtrPoolDataList
end

function AllLtrPoolData:TryGetLtrGroupId(ltrId)
  return ConfigData.lottery_group.ltrGroupIdMap[ltrId]
end

function AllLtrPoolData:GetIsSpecificPoolOpen(ltrId)
  local ltrData = self.ltrDataDic[ltrId]
  if ltrData == nil then
    return false
  end
  return ltrData:IsLtrPoolOpen()
end

function AllLtrPoolData:GetIsSelectByGroupId(groupPoolId)
  if self.ltrGroupSelectTagDic[groupPoolId] ~= nil then
    return self.ltrGroupSelectTagDic[groupPoolId]
  end
  return 0
end

function AllLtrPoolData:SetIsSelectSuccess(poolGroupId, newPoolId)
  self.ltrGroupSelectTagDic[poolGroupId] = newPoolId
end

function AllLtrPoolData:GetMaxPriorityLtrCfg()
  local maxNavTag, maxLtrCfg
  local openingLotteryPoolDatas = self:GetOpeningLtrPoolDataList()
  for _, lotteryPoolData in pairs(openingLotteryPoolDatas) do
    local navTag = lotteryPoolData:GetLotteryDataNavTag()
    if navTag ~= nil and navTag ~= 0 and (maxNavTag == nil or maxNavTag < navTag) then
      maxNavTag = navTag
      maxLtrCfg = lotteryPoolData:GetLtrPoolDataCfg()
    end
  end
  return maxLtrCfg
end

return AllLtrPoolData
