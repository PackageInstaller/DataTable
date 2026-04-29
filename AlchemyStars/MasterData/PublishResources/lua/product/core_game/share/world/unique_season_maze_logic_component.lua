_class("SeasonMazeLogicComponent", Object)
SeasonMazeLogicComponent = SeasonMazeLogicComponent

function SeasonMazeLogicComponent:Constructor(world)
  self._world = world
  self._outside_attr = {}
  self._ms = 0
  self._awardMS = 0
  self._relicList = {}
  self._suitRelicList = {}
  self._waveRandoms = {}
end

function SeasonMazeLogicComponent:Initialize()
  local createInfo = self._world.BW_WorldInfo:GetSeasonMazeCreateInfo()
  if createInfo == nil then
    createInfo = SeasonMazeMissionCreateInfo:New()
    createInfo.outside_attr[SeasonMazeAttrType.SMAT_Ms] = 8
    Log.fatal("use for test season maze ---------------------")
  end
  self._relicList = table.clone(createInfo.relic_list)
  self._suitRelicList = table.clone(createInfo.suit_relic_list)
  self._outside_attr = table.clone(createInfo.outside_attr)
  self._ms = self._outside_attr[SeasonMazeAttrType.SMAT_Ms]
  Log.info("SeasonMaze RelicBegin")
  for relic, counter in pairs(createInfo.relic_list) do
    Log.info("Season RelicID:", relic, " Counter:", counter)
  end
  Log.info("SeasonMaze RelicEnd")
  Log.info("SeasonMaze SuitBegin:")
  for _, relic in pairs(createInfo.suit_relic_list) do
    Log.info("Season SuitRelicID:", relic)
  end
  Log.info("SeasonMaze SuitEnd")
  Log.info("SeasonMaze OutSideAttrBegin")
  for attrType, count in pairs(createInfo.outside_attr) do
    Log.info("Season Attr:", attrType, " Count:", count)
  end
  Log.info("SeasonMaze OutSideAttrEnd")
  self._waveRandoms = table.clone(createInfo.wave_randoms)
end

function SeasonMazeLogicComponent:GetRoundCount()
  local createInfo = self._world.BW_WorldInfo:GetSeasonMazeCreateInfo()
  return createInfo.world_boss_round_cnt
end

function SeasonMazeLogicComponent:AddRelicCount(relicID)
  if self._relicList[relicID] then
    self._relicList[relicID] = self._relicList[relicID] + 1
  end
  return self._relicList[relicID]
end

function SeasonMazeLogicComponent:GetRelicCounter(relicID)
  return self._relicList[relicID]
end

function SeasonMazeLogicComponent:CheckRelicCounter(relicID)
  local cfg = Cfg.cfg_item_relic[relicID]
  local cnt = self._relicList[relicID]
  if not cnt or cfg.OutGameTriggerCount == 0 or cnt < cfg.OutGameTriggerCount then
    return true
  end
  return false
end

function SeasonMazeLogicComponent:GetRelicAndCounter()
  return self._relicList
end

function SeasonMazeLogicComponent:GetRelicsCount()
  local count = table.count(self._relicList)
  return count
end

function SeasonMazeLogicComponent:GetAllRelic()
  local allRelic = {}
  for relic, count in pairs(self._relicList) do
    table.insert(allRelic, relic)
  end
  for i, relic in ipairs(self._suitRelicList) do
    table.insert(allRelic, relic)
  end
  return allRelic
end

function SeasonMazeLogicComponent:GetSuitRelic()
  return self._suitRelicList
end

function SeasonMazeLogicComponent:GetTotalGoldCoin()
  return self:GetGoldCoin() + self:GetRewardGoldCoin()
end

function SeasonMazeLogicComponent:GetOutsideAttributeByType(type)
  return self._outside_attr[type]
end

function SeasonMazeLogicComponent:GetOutsideAttribute()
  return self._outside_attr
end

function SeasonMazeLogicComponent:AddOutsideAttribute(type, count)
  if self._outside_attr[type] then
    self._outside_attr[type] = self._outside_attr[type] + count
  else
    self._outside_attr[type] = count
  end
  return self._outside_attr[type]
end

function SeasonMazeLogicComponent:GetGoldCoin()
  return self:GetOutsideAttributeByType(SeasonMazeAttrType.SMAT_Gold)
end

function SeasonMazeLogicComponent:GetRewardGoldCoin()
  if self:GetOutsideAttributeByType(SeasonMazeAttrType.SMAT_Gold) then
    return self:GetOutsideAttributeByType(SeasonMazeAttrType.SMAT_Gold)
  else
    return 0
  end
end

function SeasonMazeLogicComponent:AddRewardGoldCoin(count)
  self:AddOutsideAttribute(SeasonMazeAttrType.SMAT_Gold, count)
end

function SeasonMazeLogicComponent:GetMS()
  return self:GetOutsideAttributeByType(SeasonMazeAttrType.SMAT_Ms)
end

function SeasonMazeLogicComponent:SubMS(count)
  self:AddOutsideAttribute(SeasonMazeAttrType.SMAT_Ms, count * -1)
end

function SeasonMazeLogicComponent:AddMS(count)
  self._rewardMS = self._rewardMS + count
  return self:AddOutsideAttribute(SeasonMazeAttrType.SMAT_Ms, count)
end

function SeasonMazeLogicComponent:SubAutoBeadEnergy(energy)
  return self:AddOutsideAttribute(SeasonMazeAttrType.SMAT_AutoBeadEnergy, energy * -1)
end

function SeasonMazeLogicComponent:AddAutoBeadEnergy(energy)
  return self:AddOutsideAttribute(SeasonMazeAttrType.SMAT_AutoBeadEnergy, energy)
end

function SeasonMazeLogicComponent:GetAutoBeadEnergy()
  return self:GetOutsideAttributeByType(SeasonMazeAttrType.SMAT_AutoBeadEnergy)
end

function SeasonMazeLogicComponent:GetWaveRandoms()
  return self._waveRandoms
end

function SeasonMazeLogicComponent:GetInitAUOEValue()
  return self:GetOutsideAttributeByType(SeasonMazeAttrType.SMAT_AlgorithmUpEnergy) or 0
end

function MainWorld:SeasonMazeLogic()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.SeasonMazeLogic)
end

function MainWorld:HasSeasonMazeLogic()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.SeasonMazeLogic) ~= nil
end

function MainWorld:AddSeasonMazeLogic(world)
  local index = self.BW_UniqueComponentsEnum.SeasonMazeLogic
  local component = SeasonMazeLogicComponent:New(self)
  component:Initialize()
  self:SetUniqueComponent(index, component)
end

function MainWorld:RemoveSeasonMazeLogic()
  if self:HasSeasonMazeLogic() then
    self:SetUniqueComponent(self.BW_UniqueComponentsEnum.SeasonMazeLogic, nil)
  end
end
