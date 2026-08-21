require("base_service")
_class("PopStarProServiceLogic", BaseService)
PopStarProServiceLogic = PopStarProServiceLogic

function PopStarProServiceLogic:Constructor(world)
  self._world = world
  self._getCountFunc = {}
  self._getCountFunc[BuffPopStarProModifyType.CampPetCount] = self.GetCampPetCount
  self._getCountFunc[BuffPopStarProModifyType.FettersPetCount] = self.GetFettersPetCount
  self._getCountFunc[BuffPopStarProModifyType.FettersPetGroupCount] = self.GetFettersPetGroupCount
  self._getCountFunc[BuffPopStarProModifyType.PopGridCount] = self.GetPopGridCount
  self._getCountFunc[BuffPopStarProModifyType.RelicCount] = self.GetRelicCount
end

function PopStarProServiceLogic:GetPopStarLogicComponent()
  local component = self._world:GetBoardEntity():PopStarLogic()
  return component
end

function PopStarProServiceLogic:GetPopGridNum()
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  return component:GetPopGridNum()
end

function PopStarProServiceLogic:GetLastPopGridNum()
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  return component:GetLastPopGridNum()
end

function PopStarProServiceLogic:AddPopGridNum(num)
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  component:AddPopGridNum(num)
end

function PopStarProServiceLogic:CalculatePopStarConnectPieces(gridPos)
  local utilDataSvc = self._world:GetService("UtilData")
  local pieceType = utilDataSvc:GetPieceType(gridPos)
  local pieces = utilDataSvc:GetReplicaBoardPieces()
  local connMap = {}
  for x, _ in pairs(pieces) do
    connMap[x] = {}
  end
  local connectPieces = {}
  table.insert(connectPieces, gridPos)
  connMap[gridPos.x][gridPos.y] = true
  
  local function searchConnectPiece(center, next)
    for _, offset in ipairs(Offset8) do
      local pos = Vector2(center.x + offset[1], center.y + offset[2])
      if utilDataSvc:IsValidPiecePos(pos) then
        local connectPieceType = utilDataSvc:GetPieceType(pos)
        local pieceMatch = PopStarCanMatchPieceType(pieceType, connectPieceType)
        if not connMap[pos.x][pos.y] and pieceMatch then
          table.insert(connectPieces, pos)
          connMap[pos.x][pos.y] = true
          next(pos, next)
        end
      end
    end
  end
  
  searchConnectPiece(gridPos, searchConnectPiece)
  return connectPieces
end

function PopStarProServiceLogic:GetPopConnectPieces()
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  return component:GetPopConnectPieces()
end

function PopStarProServiceLogic:SetPopConnectPieces(connectPieces)
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  component:SetPopConnectPieces(connectPieces)
end

function PopStarProServiceLogic:CalculatePopPieces(connectPieces)
  local result = DataPopStarResult:New()
  result:SetPopConnectPieces(connectPieces)
  local affixSvc = self._world:GetService("Affix")
  local refreshType, fallingDir = affixSvc:ReplacePieceRefreshType()
  fallingDir = refreshType == PieceRefreshType.FallingDown and fallingDir or Vector2(0, -1)
  local popNum = #connectPieces
  local destroyTrapList = self:_DestroyMaintainColorTrap(connectPieces)
  popNum = popNum + #destroyTrapList
  self:_HandleAddFeatureEnergy(popNum)
  popNum = self:_HandlePopNum(popNum)
  self:AddPopGridNum(popNum)
  result:SetPopNum(popNum)
  result:SetTotalPopNum(self:GetPopGridNum())
  local ntChange = NTPopStarScoreChange:New()
  ntChange:SetPopChangeNum(popNum)
  local triggerSvc = self._world:GetService("Trigger")
  triggerSvc:Notify(ntChange)
  self:_TriggerTrap(connectPieces, result)
  local boardLogicSvc = self._world:GetService("BoardLogic")
  boardLogicSvc:SyncGridTilesColor()
  local delSet, newSet, moveSet = boardLogicSvc:PopStarGridByFallDir(connectPieces, fallingDir)
  result:SetDelSet(delSet)
  result:SetMoveSet(moveSet)
  result:SetNewSet(newSet)
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  for _, v in ipairs(newSet) do
    boardLogicSvc:SetPieceTypeLogic(v.color, Vector2(v.pos.x, v.pos.y))
  end
  for _, v in ipairs(moveSet) do
    boardLogicSvc:SetPieceTypeLogic(v.color, Vector2(v.to.x, v.to.y))
  end
  
  local function filter(e)
    return e:HasTrapID() and e:Trap():FallWithGrid() and not e:HasDeadMark()
  end
  
  local moveTraps = {}
  for _, v in ipairs(moveSet) do
    local es = boardCmpt:GetPieceEntities(v.from, filter)
    for i, e in ipairs(es) do
      moveTraps[#moveTraps + 1] = {
        entity = e,
        from = v.from,
        to = v.to
      }
      e:SetGridPosition(v.to)
      boardLogicSvc:UpdateEntityBlockFlag(e, v.from, v.to)
    end
  end
  result:SetMoveTrapList(moveTraps)
  local triggerSvc = self._world:GetService("Trigger")
  triggerSvc:Notify(NTPopStarEnd:New(popNum))
  return result
end

function PopStarProServiceLogic:_DestroyMaintainColorTrap(connectPieces)
  local utilDataSvc = self._world:GetService("UtilData")
  local destroyTrapList = {}
  for _, pos in ipairs(connectPieces) do
    local maintainColorTrapList = utilDataSvc:FindMaintainColorTrapByPos(pos)
    if 0 < #maintainColorTrapList then
      table.appendArray(destroyTrapList, maintainColorTrapList)
    end
  end
  return destroyTrapList
end

function PopStarProServiceLogic:_TriggerTrap(connectPieces, result)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local trapLSvc = self._world:GetService("TrapLogic")
  for _, pos in ipairs(connectPieces) do
    local trapList, trapResList = trapLSvc:TriggerTrapOnPosByEntity(pos, teamEntity, TrapTriggerOrigin.Move)
    for i, e in ipairs(trapList) do
      local trapEntity = e
      local skillEffectResultContainer = trapResList[i]
      local aiResult = AISkillResult:New()
      aiResult:SetResultContainer(skillEffectResultContainer)
      result:AddTrapSkillResult(trapEntity:GetID(), aiResult, teamEntity:GetID())
    end
  end
end

function PopStarProServiceLogic:Initialize()
  if self._world:MatchType() ~= MatchType.MT_PopStarPro then
    return
  end
  local triggerSvc = self:GetService("Trigger")
  local triggerHandler = TriggerCallbackOwner:New(self, self.InitRelics)
  local trigger = triggerSvc:CreateTrigger(triggerHandler, {
    {
      NotifyType.GameStart
    },
    {
      TriggerType.Always
    }
  }, self._world)
  triggerSvc:Attach(trigger)
  trigger:SetActive(true)
  self._trigger = trigger
end

function PopStarProServiceLogic:Dispose()
  if self._world:MatchType() ~= MatchType.MT_PopStarPro then
    return
  end
  local triggerSvc = self:GetService("Trigger")
  triggerSvc:Detach(self._trigger)
end

function PopStarProServiceLogic:GetTeamHPPercent()
  local createInfo = self._world.BW_WorldInfo:GetPopStarProCreateInfo()
  return createInfo.team_blood
end

function PopStarProServiceLogic:GetLeftRoundCount()
  local createInfo = self._world.BW_WorldInfo:GetPopStarProCreateInfo()
  return createInfo.left_turn
end

function PopStarProServiceLogic:GetWaveRandoms()
  local createInfo = self._world.BW_WorldInfo:GetPopStarProCreateInfo()
  return createInfo.wave_randoms
end

function PopStarProServiceLogic:GetRelics()
  if self._world:MatchType(GetMatchTypeType.PopStarProNoRelic) ~= MatchType.MT_PopStarPro then
    return {}
  end
  local createInfo = self._world.BW_WorldInfo:GetPopStarProCreateInfo()
  return createInfo.relics
end

function PopStarProServiceLogic:GetFeatureRelics()
  local createInfo = self._world.BW_WorldInfo:GetPopStarProCreateInfo()
  return createInfo.skill_relics
end

function PopStarProServiceLogic:GetRelicCounters()
  local createInfo = self._world.BW_WorldInfo:GetPopStarProCreateInfo()
  return createInfo.relic_counters
end

function PopStarProServiceLogic:GetInitFeaturePower(featureType, featureData)
  if self._world:MatchType(GetMatchTypeType.PopStarProNoRelic) ~= MatchType.MT_PopStarPro then
    return 0
  end
  local createInfo = self._world.BW_WorldInfo:GetPopStarProCreateInfo()
  local power = createInfo.feature_info_list[featureType]
  if not power then
    local useCfgInitPower = false
    if featureData and featureData.GetFirstUseInitPower then
      local fistUseInitPower = featureData:GetFirstUseInitPower()
      if fistUseInitPower then
        power = fistUseInitPower
        useCfgInitPower = true
      end
    end
    if not useCfgInitPower then
      power = 0
    end
  end
  return power
end

function PopStarProServiceLogic:CheckRelicCounter(relicID)
  local cfg = Cfg.cfg_item_relic[relicID]
  local relicCounters = self:GetRelicCounters()
  local cnt = relicCounters[relicID]
  if not cnt or cfg.OutGameTriggerCount == 0 or cnt < cfg.OutGameTriggerCount then
    return true
  end
  return false
end

function PopStarProServiceLogic:CalculateRelicInnerEff(relicID)
  local relics = self:GetRelics()
  local cfg = Cfg.cfg_item_relic[relicID]
  if cfg.InnerGameType == RelicInnerGameEffType.ReplaceRelicID then
    local param = cfg.InnerGameTypeParam
    local needRelicID = param.needRelicID
    if table.icontains(relics, needRelicID) then
      return param.replaceID
    end
  end
  return relicID
end

function PopStarProServiceLogic:CheckSuite(suiteID)
  local relics = self:GetRelics()
  local suiteCfgList = Cfg.cfg_item_relic({SuiteID = suiteID})
  for _, cfg in pairs(suiteCfgList) do
    if not table.icontains(relics, cfg.ID) then
      return false
    end
    if not self:CheckRelicCounter(cfg.ID) then
      return false
    end
  end
  return true
end

function PopStarProServiceLogic:InitRelics()
  if self._world:MatchType(GetMatchTypeType.PopStarProNoRelic) ~= MatchType.MT_PopStarPro then
    return {}
  end
  local relics = table.cloneconf(self:GetRelics())
  local featureRelics = self:GetFeatureRelics()
  table.appendArray(relics, featureRelics)
  local validRelics = {}
  for _, relicID in ipairs(relics) do
    local cfg = Cfg.cfg_item_relic[relicID]
    if self:CheckRelicCounter(relicID) then
      if cfg.SuiteID > 0 and self:CheckSuite(cfg.SuiteID) then
        if not table.icontains(validRelics, cfg.SuiteID) then
          table.insert(validRelics, cfg.SuiteID)
        end
        if cfg.Coexist then
          table.insert(validRelics, relicID)
        end
      elseif cfg.InnerGameType and 0 < cfg.InnerGameType then
        local id = self:CalculateRelicInnerEff(relicID)
        table.insert(validRelics, id)
      else
        table.insert(validRelics, relicID)
      end
    end
  end
  table.sort(validRelics, function(a, b)
    local oa = Cfg.cfg_item_relic[a].ShowOrder
    local ob = Cfg.cfg_item_relic[b].ShowOrder
    if oa == ob then
      return a < b
    else
      return oa < ob
    end
  end)
  for _, relic in ipairs(validRelics) do
    self:ApplyRelic(relic)
  end
end

function PopStarProServiceLogic:ApplyRelic(relicID)
  local buffLSvc = self._world:GetService("BuffLogic")
  local cfg = Cfg.cfg_item_relic[relicID]
  if #cfg.BuffID > 0 then
    for _, buffID in ipairs(cfg.BuffID) do
      if 0 < buffID then
        Log.notice("[PopStarPro ApplyRelic] add buff:", buffID, " relic:", relicID)
        local buffIns = buffLSvc:AddBuffByTargetType(buffID, cfg.BuffTargetType, cfg.BuffTargetParam)
        for _, buffIn in ipairs(buffIns) do
          buffIn:SetRelicID(relicID)
        end
      end
    end
  end
end

function PopStarProServiceLogic:_HandlePopNum(popNum)
  local tmpNum = popNum
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local buffCmpt = teamEntity:BuffComponent()
  local val = buffCmpt:GetBuffValue(PopStarConst.PopOnceMoreKey)
  if val and 0 < val then
    local randomLSvc = self._world:GetService("RandomLogic")
    local random = randomLSvc:LogicRand()
    if val >= random then
      tmpNum = tmpNum + popNum
    end
  end
  return tmpNum
end

function PopStarProServiceLogic:AddRelicCounter(relicID)
  local createInfo = self._world.BW_WorldInfo:GetPopStarProCreateInfo()
  local cnt = createInfo.relic_counters[relicID]
  if not cnt then
    createInfo.relic_counters[relicID] = 1
  else
    createInfo.relic_counters[relicID] = cnt + 1
  end
end

function PopStarProServiceLogic:GetRelicCounter(relicID)
  local createInfo = self._world.BW_WorldInfo:GetPopStarProCreateInfo()
  return createInfo.relic_counters[relicID]
end

function PopStarProServiceLogic:GetPopStarProFeatureInfoList()
  local svc = self:GetService("FeatureLogic")
  return svc:GetPopStarProFeatureInfoList()
end

function PopStarProServiceLogic:_HandleAddFeatureEnergy(popNum)
  local tmpNum = popNum
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local buffCmpt = teamEntity:BuffComponent()
  local val = buffCmpt:GetBuffValue(PopStarConst.BVK_AddEnergyOnceMore)
  if val and 0 < val then
    local randomLSvc = self._world:GetService("RandomLogic")
    local random = randomLSvc:LogicRand()
    if val >= random then
      tmpNum = tmpNum + popNum
    end
  end
  local ntAdd = NTPopStarProAddFeatureEnergy:New()
  ntAdd:SetAddNum(tmpNum)
  local triggerSvc = self._world:GetService("Trigger")
  triggerSvc:Notify(ntAdd)
end

function PopStarProServiceLogic:GetCampPetCount()
  local count = 0
  local campID = self:GetCampID()
  if campID == 0 then
    return count
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamMembers = teamEntity:Team():GetTeamPetEntities()
  for _, pet in ipairs(teamMembers) do
    local component = pet:MatchPet()
    local matchPet = component:GetMatchPet()
    if matchPet:GetPetCamp() == campID then
      count = count + 1
    end
  end
  return count
end

function PopStarProServiceLogic:GetFettersPetCount()
  local count = 0
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamMembers = teamEntity:Team():GetTeamPetEntities()
  for _, pet in ipairs(teamMembers) do
    if pet:HasFetters() then
      count = count + 1
    end
  end
  return count
end

function PopStarProServiceLogic:GetFettersPetGroupCount()
  local count = self:GetFettersPetCount()
  count = math.floor(count / 2)
  return count
end

function PopStarProServiceLogic:GetPopGridCount()
  local count = self:GetLastPopGridNum()
  return count
end

function PopStarProServiceLogic:GetRelicCount()
  local relics = self:GetRelics()
  return table.count(relics)
end

function PopStarProServiceLogic:GetCountByModifyType(modifyType)
  local count = 0
  local func = self._getCountFunc[modifyType]
  if func then
    count = func(self)
  end
  return count
end

function PopStarProServiceLogic:ActiveCamp()
  local campDic = {}
  local activeCampID
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamMembers = teamEntity:Team():GetTeamPetEntities()
  for _, pet in ipairs(teamMembers) do
    local component = pet:MatchPet()
    local matchPet = component:GetMatchPet()
    local campID = matchPet:GetPetCamp()
    if campDic[campID] then
      campDic[campID] = campDic[campID] + 1
      if campDic[campID] >= PopStarConst.ActiveCampPetCount then
        activeCampID = campID
        break
      end
    else
      campDic[campID] = 1
    end
  end
  if activeCampID then
    local component = self:GetPopStarLogicComponent()
    if component then
      component:SetCampID(activeCampID)
    end
  end
end

function PopStarProServiceLogic:GetCampID()
  local component = self:GetPopStarLogicComponent()
  if not component then
    return
  end
  return component:GetCampID()
end

function PopStarProServiceLogic:GetCampSkillIDByLevel(level)
  local campID = self:GetCampID()
  if campID == 0 then
    return
  end
  local cfg = Cfg.cfg_camp_skill({CampID = campID, SkillLevel = level})
  if not cfg then
    Log.error("[CampSkill] skill id is not exist, campID = ", campID, ", level = ", level)
    return
  end
  return cfg[1].SkillID
end
