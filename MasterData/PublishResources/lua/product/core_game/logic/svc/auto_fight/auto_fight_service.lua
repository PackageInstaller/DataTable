require("base_service")
_class("AutoSkillCastData", Object)
AutoSkillCastData = AutoSkillCastData

function AutoSkillCastData:Constructor(pCaster, nSkillID, nPetID, listPickUpPos, selectTeamPos, pickExtraParam, clientSelectInfo)
  self.m_pCaster = pCaster
  self.m_nSkillID = nSkillID
  self.m_nPetID = nPetID
  self.m_listPickUpPos = listPickUpPos
  self.m_listSelectTeamPos = selectTeamPos
  self.m_pickExtraParam = pickExtraParam
  self.m_clientSelectInfo = clientSelectInfo
end

_class("AutoFightService", BaseService)
AutoFightService = AutoFightService

function AutoFightService:Constructor()
  self._scopeFilterDevice = SkillScopeFilterDevice:New()
  self._lastConvertColor = 0
  self._randPieceColor = false
  self._lastCastSkillPetIds = {}
  self._env = nil
  self._envPickUp = nil
  self._autoMoving = false
  self._castPetTrapSkillPetEntity = nil
  self._castActiveSkillCount = 0
  self._usePickCheck = true
  self:RegistPickUpPolicyCalculator()
end

function AutoFightService:Initialize()
  self._boardServiceLogic = self._world:GetService("BoardLogic")
  self._boardServiceRender = self._world:GetService("BoardRender")
  self._configService = self._world:GetService("Config")
  self._battleService = self._world:GetService("Battle")
  self._utilSvc = self._world:GetService("UtilData")
  self._utilScopeSvc = self._world:GetService("UtilScopeCalc")
end

function AutoFightService:EnableAutoMove(enabled)
  self._autoMoving = not enabled
end

function AutoFightService:IsRunning()
  return self._autoMoving
end

function AutoFightService:SetCastPetTrapSkillPetEntity(entity)
  self._castPetTrapSkillPetEntity = entity
end

function AutoFightService:GetCastActiveSkillCount()
  return self._castActiveSkillCount
end

function AutoFightService:SetCastActiveSkillCount(count)
  self._castActiveSkillCount = count
end

function AutoFightService:AutoFight(TT, teamEntity)
  if self._autoMoving then
    return
  end
  self:OnAutoFight_Begin(teamEntity)
  if DEBUG_AUTO_FIGHT then
    self:_AutoMovePath(TT, teamEntity)
  else
    self:_DoAutoFight(TT, teamEntity)
  end
  self:OnAutoFight_End(teamEntity)
end

function AutoFightService:_DoAutoFight(TT)
  local battleService = self._battleService
  if self:Handle_PickUpChainSkillTarget(TT) then
    return
  end
  local allMonsterDead = battleService:CheckAllMonstersDead(self._env.TeamEntity)
  if allMonsterDead then
    self:Handle_MovePath(TT)
    return
  end
  if self:Handle_NotifyClientUnscaledCountDown(TT) then
    return
  end
  if self:Handle_CastTrapSkill(TT) then
    return
  end
  if self._castPetTrapSkillPetEntity then
    local teamEntity = self._env.TeamEntity
    if not table.icontains(teamEntity:Team():GetTeamPetEntities(), self._castPetTrapSkillPetEntity) then
      self._castPetTrapSkillPetEntity = nil
    end
    if self:Handle_CastPetTrapSkill(TT, self._castPetTrapSkillPetEntity) then
      self._castPetTrapSkillPetEntity = nil
      return
    else
      self._castPetTrapSkillPetEntity = nil
    end
  elseif self:Handle_CastActiveSkill(TT) then
    return
  end
  self:ClearPetActiveSkillTempData()
  if self:Handle_CastPetTrapSkill(TT) then
    return
  end
  self:Handle_MovePath(TT)
end

function AutoFightService:OnAutoFight_Begin(teamEntity)
  self._autoMoving = true
  self._world:EventDispatcher():Dispatch(GameEventType.BanAutoFightBtn, true)
  self:_BuildMoveEnv(teamEntity)
  if self._world:MatchType(GetMatchTypeType.NoLinkLine) == MatchType.MT_PopStarPro then
    self:_BuildPopStarProPickUpEnv(teamEntity)
  end
end

function AutoFightService:OnAutoFight_End()
  self._env = nil
  self._envPickUp = nil
  self._autoMoving = false
  self._world:EventDispatcher():Dispatch(GameEventType.BanAutoFightBtn, false)
end

function AutoFightService:Handle_MovePath(TT)
  return self:_AutoMovePath(TT)
end

function AutoFightService:Handle_PickUpChainSkillTarget(TT)
  if GameStateID.PickUpChainSkillTarget == self:_GetFsmStateID() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIChainSkillPreview",
      input = "btnCancelOnClick",
      args = {nil}
    })
    YIELD(TT, 1000)
    return true
  end
end

function AutoFightService:Handle_CastTrapSkill(TT)
  local pSkillData = self:_FindTrapSkill()
  if nil == pSkillData then
    return
  end
  return self:_CastTrapSkill(TT, pSkillData.m_pCaster, pSkillData.m_nSkillID, pSkillData.m_listPickUpPos)
end

function AutoFightService:Handle_CastPetTrapSkill(TT, petEntity)
  local pSkillData = self:_FindPetTrapSkill(petEntity)
  if nil == pSkillData then
    return
  end
  return self:_CastTrapSkill(TT, pSkillData.m_pCaster, pSkillData.m_nSkillID, pSkillData.m_listPickUpPos)
end

function AutoFightService:Handle_CastActiveSkill(TT)
  if self:MissionCanCast() == false then
    return
  end
  local t1 = os.clock()
  local pSkillData = self:_FindActiveSkill(TT)
  if nil == pSkillData then
    return
  end
  local t2 = os.clock()
  Log.debug("[AutoFight]FindActiveSkill() use time=", (t2 - t1) * 1000)
  if self:_IsFeatureSkill(pSkillData.m_nSkillID) then
    self:_CastFeatureSkill(TT, pSkillData)
    self._lastCastSkillPetIds[pSkillData.m_nPetID] = true
  else
    self:_CastActiveSkill(TT, pSkillData.m_pCaster, pSkillData.m_nSkillID, pSkillData.m_nPetID, pSkillData.m_listPickUpPos, pSkillData.m_listSelectTeamPos, pSkillData.m_pickExtraParam)
    self._lastCastSkillPetIds[pSkillData.m_nPetID] = true
  end
  return pSkillData
end

function AutoFightService:_IsFeatureSkill(skillID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  if skillConfigData then
    local skillType = skillConfigData:GetSkillType()
    if skillType == SkillType.FeatureSkill then
      return true
    end
    if skillConfigData:GetAutoFightPickPosPolicy() == PickPosPolicy.PetBatiya then
    end
  end
  return false
end

function AutoFightService:_IsPersonaSkill(skillID)
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if lsvcFeature:HasFeatureType(FeatureType.PersonaSkill) then
    local personSkillID = lsvcFeature:GetFeatureSkillID(FeatureType.PersonaSkill)
    if personSkillID == skillID then
      return true
    end
  end
  return false
end

function AutoFightService:MissionCanCast()
  local matchModule = GameGlobal.GetModule(MatchModule)
  local enterData = matchModule:GetMatchEnterData()
  if enterData:GetMatchType() == MatchType.MT_Mission then
    local currentMissionId = enterData:GetMissionCreateInfo().mission_id
    local current_mission_cfg = Cfg.cfg_mission[currentMissionId]
    if current_mission_cfg == nil then
      return true
    end
    local missionCanCast = current_mission_cfg.CastSkillLimit
    return missionCanCast
  end
  return true
end

function AutoFightService:_TryInsertSkillToSortList(sorted_skills, e, petId, skillId, configService, battleStatCmpt)
  if self._usePickCheck and self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn then
    local curRound = battleStatCmpt:GetLevelTotalRoundCount()
    if self:_CheckLocalCastActiveSkillErrorCurRound(curRound, skillId) then
      return
    end
  end
  local isBuffSetCanNotReady = self._utilSvc:IsBuffSetExtraActiveSkillCanNotReady(petId, skillId)
  if isBuffSetCanNotReady then
    return
  end
  local skillConfigData = configService:GetSkillConfigData(skillId)
  local powerEligibility = false
  if skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
    local legendPower = e:Attributes():GetAttribute("LegendPower")
    local defaultCost = skillConfigData:GetSkillTriggerParam()
    local minCost = self._utilSvc:CalcMinCostLegendPowerByExtraParam(e, defaultCost, skillConfigData, 0, true)
    powerEligibility = legendPower >= minCost
  elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.BuffLayer then
    local extraParam = skillConfigData:GetSkillTriggerExtraParam()
    local buffEffectType = extraParam.buffEffectType
    local blsvc = self._world:GetService("BuffLogic")
    local currentVal = blsvc:GetBuffLayer(e, buffEffectType)
    local requiredVal = skillConfigData:GetSkillTriggerParam()
    powerEligibility = currentVal >= requiredVal
  elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.AlchemyEnergy then
    local petEntity = self._utilSvc:GetEntityByPstID(petId)
    local alchemyPower = e:Attributes():GetAttribute("AlchemyPower")
    local utilCalcSvc = self._world:GetService("UtilCalc")
    local defaultCost = skillConfigData:GetSkillTriggerParam()
    powerEligibility = alchemyPower >= defaultCost and not utilCalcSvc:IsPetCurRoundCastActiveSkill(petEntity)
  elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.ColorPalette then
    local colorPalette = e:ColorPalette()
    if colorPalette then
      powerEligibility = colorPalette:IsSatisfy()
    end
  else
    local power = self._utilSvc:GetPetPowerAttr(e, skillId)
    powerEligibility = power == 0
  end
  local disWhenIsTeamLeader = false
  if self._utilSvc:IsSkillDisabledWhenCasterIsTeamLeader(petId, skillId) and self._utilSvc:IsPetCurrentTeamLeader(petId) then
    disWhenIsTeamLeader = true
  end
  local ready = self._utilSvc:GetPetSkillReadyAttr(e, skillId)
  local canOverdraw = e:HasBuffFlag(BuffFlags.CanOverdraw)
  if canOverdraw then
    ready = 1
    powerEligibility = true
  end
  if not e:HasPetDeadMark() and powerEligibility and ready == 1 and not disWhenIsTeamLeader then
    table.insert(sorted_skills, {
      e,
      skillId,
      petId
    })
  end
end

function AutoFightService:_FindActiveSkill(TT)
  local configService = self._world:GetService("Config")
  local env = self._env
  local teamEntity = env.TeamEntity
  local pickUpType = SkillPickUpType.None
  local battleStatCmpt = self._world:BattleStat()
  local curRound = battleStatCmpt:GetLevelTotalRoundCount()
  local sorted_skills = {}
  for i, e in ipairs(teamEntity:Team():GetTeamPetEntities()) do
    local matchPet = e:MatchPet():GetMatchPet()
    local featureList = matchPet:GetFeatureList() or {
      feature = {}
    }
    if featureList.feature[FeatureType.Scan] then
      local featureLogicComponent = self._world:GetBoardEntity():LogicFeature()
      local scanActiveSkillType = featureLogicComponent:GetScanActiveSkillType()
      if scanActiveSkillType ~= ScanFeatureActiveSkillType.SummonTrap then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.ScanFeatureSaveInfo, {
          skillType = ScanFeatureActiveSkillType.SummonTrap
        })
      end
      YIELD(TT, 200)
    end
    local petId = e:PetPstID():GetPstID()
    local isSilence = self._utilSvc:IsSilenceState(petId)
    if not isSilence and not e:HasBuffFlag(BuffFlags.SealedCurse) then
      local petCanActiveAttack = self._utilSvc:OnCheckPetCanCastActiveSkill(e:GetID())
      if petCanActiveAttack ~= false then
        local isBuffSetCanNotReady = self._utilSvc:IsBuffSetActiveSkillCanNotReady(petId)
        if not isBuffSetCanNotReady then
          local skillId = e:SkillInfo():GetActiveSkillID()
          if not skillId then
            local petData = self._world:GetPetData(petId)
            skillId = petData:GetPetActiveSkill()
          end
          self:_TryInsertSkillToSortList(sorted_skills, e, petId, skillId, configService, battleStatCmpt)
          local extraSkillList = e:SkillInfo():GetExtraActiveSkillIDList()
          if extraSkillList and 0 < #extraSkillList then
            for index, extraSkillId in ipairs(extraSkillList) do
              self:_TryInsertSkillToSortList(sorted_skills, e, petId, extraSkillId, configService, battleStatCmpt)
            end
          end
        end
      end
    end
  end
  if self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn then
    local lsvcFeature = self._world:GetService("FeatureLogic")
    if lsvcFeature:HasFeatureType(FeatureType.PersonaSkill) then
      local curPower, ready = lsvcFeature:GetFeatureSkillCurPower(FeatureType.PersonaSkill)
      if ready and ready == 1 and curPower == 0 then
        local skillId = lsvcFeature:GetFeatureSkillID(FeatureType.PersonaSkill)
        table.insert(sorted_skills, {
          nil,
          skillId,
          0,
          FeatureType.PersonaSkill
        })
      end
    end
    if lsvcFeature:HasFeatureType(FeatureType.MasterSkillRecover) then
      local curPower, ready = lsvcFeature:GetFeatureSkillCurPower(FeatureType.MasterSkillRecover)
      if ready and ready == 1 and curPower == 0 then
        local skillId = lsvcFeature:GetFeatureSkillID(FeatureType.MasterSkillRecover)
        table.insert(sorted_skills, {
          nil,
          skillId,
          0,
          FeatureType.MasterSkillRecover
        })
      end
    end
    if lsvcFeature:HasFeatureType(FeatureType.MasterSkill) then
      local curPower, ready = lsvcFeature:GetFeatureSkillCurPower(FeatureType.MasterSkill)
      if ready and ready == 1 and curPower == 0 then
        local skillId = lsvcFeature:GetFeatureSkillID(FeatureType.MasterSkill)
        table.insert(sorted_skills, {
          nil,
          skillId,
          0,
          FeatureType.MasterSkill
        })
      end
    end
    if lsvcFeature:HasFeatureType(FeatureType.Card) then
      local skillId = self:_FindFeatureCardSkillID()
      if skillId then
        table.insert(sorted_skills, {
          nil,
          skillId,
          0,
          FeatureType.Card
        })
      end
    end
    if lsvcFeature:HasFeatureType(FeatureType.Shop) then
      local skillId, selectInfo = self:_FindFeatureShopSkillID()
      if skillId then
        table.insert(sorted_skills, {
          nil,
          skillId,
          0,
          FeatureType.Shop,
          selectInfo = selectInfo
        })
      end
    end
    if lsvcFeature:HasFeatureType(FeatureType.BanPetSkill) then
      local skillId = self:_FindFeatureBanPetSkillID()
      if skillId then
        table.insert(sorted_skills, {
          nil,
          skillId,
          0,
          FeatureType.BanPetSkill
        })
      end
    end
  end
  local svcCfg = self._configService
  table.sort(sorted_skills, function(a, b)
    local order1 = svcCfg:GetSkillConfigData(a[2]):GetAutoFightSkillOrder()
    local order2 = svcCfg:GetSkillConfigData(b[2]):GetAutoFightSkillOrder()
    if order1 == order2 then
      local teamCmpt = teamEntity:Team()
      local teamIdx1 = teamCmpt:GetTeamIndexByPetPstID(a[3]) or 0
      local teamIdx2 = teamCmpt:GetTeamIndexByPetPstID(b[3]) or 0
      return teamIdx1 < teamIdx2
    end
    return order1 < order2
  end)
  local caster
  local skillID = 0
  local petID = 0
  local clientSelectInfo
  for _, v in ipairs(sorted_skills) do
    local e = v[1]
    local skillId = v[2]
    local petId = v[3]
    local selectInfo = v.selectInfo
    local skillCfgData = svcCfg:GetSkillConfigData(skillId)
    local subSkillList = skillCfgData:GetSubSkillIDList()
    if self:_IsFeatureSkill(skillId) then
      if self:_CheckFeatureSkillCondition(TT, e, skillId, env) then
        caster = e
        skillID = skillId
        petID = petId
        clientSelectInfo = selectInfo
        break
      end
    elseif 0 < #subSkillList then
      if self:_CheckSubSkillCondition(TT, e, subSkillList, env) then
        caster = e
        skillID = env.subSkillID
        petID = petId
        break
      end
    elseif self:_CheckSkillCondition(TT, e, skillId, env) then
      caster = e
      skillID = skillId
      petID = petId
      break
    end
  end
  if nil == caster and not self:_IsFeatureSkill(skillID) then
    return nil
  end
  return AutoSkillCastData:New(caster, skillID, petID, env.PickUpGridPos, env.SelectTeamPos, env.PickUpExtraParam, clientSelectInfo)
end

function AutoFightService:_GetFsmStateID()
  local gameFsmCmpt = self._world:GameFSM()
  if gameFsmCmpt then
    return gameFsmCmpt:CurStateID()
  end
  return GameStateID.Invalid
end

function AutoFightService:_FindTrapSkill()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local caster
  for i, e in ipairs(group:GetEntities()) do
    local power = e:Attributes():GetAttribute("TrapPower") or 0
    local trapComponent = e:Trap()
    local canAutoSkill = trapComponent:GetCantAutoSkill() == nil or trapComponent:GetCantAutoSkill() == 0
    if 0 < power and canAutoSkill then
      caster = e
      break
    end
  end
  if nil == caster then
    return
  end
  local skillID = 0
  if caster and caster:Trap():IsAircraftCore() then
    skillID = self:_FindAircraftCoreSkillID(caster)
    if not self:_CanCastTrapSkill(caster, skillID) then
      return
    end
  end
  local env = self._env
  if caster and caster:Trap():IsCastSkillByRound() then
    skillID = self:_FindRoundkillID(caster)
    if not self:_CanCastTrapSkill(caster, skillID, env) then
      return
    end
  end
  local clientSelectInfo
  return AutoSkillCastData:New(caster, skillID, nil, env.PickUpGridPos, env.SelectTeamPos, env.PickUpExtraParam, clientSelectInfo)
end

function AutoFightService:_FindPetTrapSkill(petEntity)
  local caster
  local petEntityIDList = {}
  if petEntity then
    table.insert(petEntityIDList, petEntity:GetID())
  else
    local pets = self._env.TeamEntity:Team():GetTeamPetEntities()
    for _, petEntity in ipairs(pets) do
      table.insert(petEntityIDList, petEntity:GetID())
    end
  end
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for _, e in ipairs(trapGroup:GetEntities()) do
    if not e:HasDeadMark() and e:Trap():IsPetTrapCastSkill() and e:HasSummoner() then
      local summonEntityID = e:Summoner():GetSummonerEntityID()
      local summonEntity = e:GetSummonerEntity()
      if summonEntity and summonEntity:HasSuperEntity() and summonEntity:GetSuperEntity() then
        summonEntityID = summonEntity:GetSuperEntity():GetID()
      end
      if table.icontains(petEntityIDList, summonEntityID) then
        local isCovered = false
        local trapPos = e:GetGridPosition()
        if self._utilScopeSvc:IsPosHaveMonsterOrPet(trapPos) then
          isCovered = true
        end
        local power = e:Attributes():GetAttribute("TrapPower") or 0
        if 0 < power and not isCovered then
          caster = e
          break
        end
      end
    end
  end
  if nil == caster then
    return
  end
  local env = self._env
  local skillID = 0
  skillID = self:_FindQingTongTrapSkillID(caster)
  if not self:_CanCastTrapSkill(caster, skillID, env, petEntityIDList) then
    return
  end
  local env = self._env
  local clientSelectInfo
  return AutoSkillCastData:New(caster, skillID, nil, env.PickUpGridPos, env.SelectTeamPos, env.PickUpExtraParam, clientSelectInfo)
end

function AutoFightService:_FindAircraftCoreSkillID(caster)
  if self._world:LinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
    return 0
  end
  local skillID = 0
  local trapCmpt = caster:Trap()
  local activeSkillID = trapCmpt:GetActiveSkillID()
  local damageSkillID = activeSkillID[1]
  local healSkillID = activeSkillID[2]
  local shieldSkillID = activeSkillID[3]
  local _, targetIds = self:_CalcSkillScopeResultAndTargets(caster, damageSkillID)
  if 0 < #targetIds then
    for i, id in ipairs(targetIds) do
      local e = self._world:GetEntityByID(id)
      local hp = e:Attributes():GetCurrentHP()
      local maxhp = e:Attributes():GetAttribute("MaxHP")
      if hp < maxhp * 0.4 then
        skillID = damageSkillID
        return skillID
      end
    end
  end
  local com = caster:BuffComponent()
  if com and not com:HasBuffEffect(BuffEffectType.LayerShield) then
    skillID = shieldSkillID
    return skillID
  end
  local hp = caster:Attributes():GetCurrentHP()
  local hpMax = caster:Attributes():GetAttribute("MaxHP")
  if hp / hpMax < 0.7 then
    skillID = healSkillID
    return skillID
  end
  return skillID
end

function AutoFightService:_FindRoundkillID(caster)
  local attrCmpt = caster:Attributes()
  local curRound = attrCmpt:GetAttribute("CurrentRound")
  local trapCmpt = caster:Trap()
  local activeSkillID = trapCmpt:GetActiveSkillID()
  local skillID = activeSkillID[curRound]
  skillID = skillID or 0
  return skillID
end

function AutoFightService:_FindQingTongTrapSkillID(caster)
  local skillID = 0
  local trapCmpt = caster:Trap()
  local activeSkillIDs = trapCmpt:GetActiveSkillID()
  local damageSkillID = activeSkillIDs[1] or 0
  local convertSkillID = activeSkillIDs[2] or 0
  local skillConfigData = self._configService:GetSkillConfigData(damageSkillID)
  if skillConfigData:GetAutoFightPickPosPolicy() == PickPosPolicy.PetYisitawanTrap then
    return damageSkillID
  end
  local trapPos = caster:GetGridPosition()
  if PieceType.Blue ~= self._boardServiceLogic:GetPieceType(trapPos) then
    skillID = convertSkillID
  else
    skillID = damageSkillID
  end
  return skillID
end

function AutoFightService:_CanCastTrapSkill(caster, skillID, env, petEntityIDList)
  if skillID <= 0 then
    return false
  end
  local skillConfigData = self._configService:GetSkillConfigData(skillID)
  local power = caster:Attributes():GetAttribute("TrapPower") or 0
  local count = caster:Attributes():GetAttribute("SkillCount") or 0
  if power >= skillConfigData:GetSkillTriggerParam() and 0 < count then
    local oneRoundLimit = 1
    local castSkillRound = caster:Attributes():GetAttribute("CastSkillRound")
    local battleStatCmpt = self._world:BattleStat()
    local curRound = battleStatCmpt:GetLevelTotalRoundCount()
    for _, round in ipairs(castSkillRound) do
      if round == curRound then
        oneRoundLimit = oneRoundLimit - 1
      end
    end
    if 0 < oneRoundLimit then
      local pickUpType = skillConfigData:GetSkillPickType()
      if pickUpType == SkillPickUpType.None then
      elseif pickUpType == SkillPickUpType.Instruction then
        local skillTags = skillConfigData:GetSkillTag()
        if table.icontains(skillTags, PetSkillTag.FixedPieceColor) then
          local posList, gridList, tarList, pickUpExtraParam = self:_CalcTrapPickupPosList(caster, skillID)
          env.PickUpGridPos = posList
          env.PickUpExtraParam = pickUpExtraParam
        end
        if skillConfigData:GetAutoFightPickPosPolicy() == PickPosPolicy.PetYisitawanTrap then
          local posList, gridList, tarList, pickUpExtraParam = self:_CalcTrapPickupPosList_YiSiTaWan(caster, skillID, petEntityIDList)
          env.PickUpGridPos = posList
          env.PickUpExtraParam = pickUpExtraParam
        end
      end
      return true
    end
  end
  return false
end

function AutoFightService:_CastTrapSkill(TT, caster, skillID, pickUpGridPos)
  if skillID <= 0 then
    return false
  end
  Log.debug("[AutoFight] CastTrapSkill skillID=", skillID)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UITrapSkillVisible, true, caster:GetID())
  while GameStateID.PreviewActiveSkill ~= self:_GetFsmStateID() do
    YIELD(TT, 100)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
    ui = "UIWidgetTrapSkill",
    input = "_OnShowSelectSkill",
    args = {skillID}
  })
  YIELD(TT, 500)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
    ui = "UIWidgetTrapSkill",
    input = "btnGoOnClick",
    args = {}
  })
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local configSvc = self._configService
  local skillConfigData = configSvc:GetSkillConfigData(skillID)
  local pickUpType = skillConfigData:GetSkillPickType()
  if pickUpType == SkillPickUpType.None then
  elseif pickUpType == SkillPickUpType.Instruction then
    if pickUpGridPos then
      for i, pos in ipairs(pickUpGridPos) do
        Log.debug("pickup pos ", Vector2.Pos2Index(pos))
        pickUpTargetCmpt:SetPickUpTargetType(pickUpType)
        pickUpTargetCmpt:SetPickUpGridPos(pos)
        pickUpTargetCmpt:SetCurActiveSkillInfo(skillID, -1)
        renderBoardEntity:ReplacePickUpTarget()
        YIELD(TT, 500)
      end
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetChooseTarget",
      input = "HandleActiveSkillConfirm",
      args = {}
    })
  end
  YIELD(TT, 500)
  while GameStateID.ActiveSkill ~= self:_GetFsmStateID() do
    YIELD(TT, 100)
  end
  return true
end

function AutoFightService:_CastActiveSkill(TT, caster, skillID, petID, pickUpGridPos, selectTeamPos, pickExtraParam)
  Log.debug("[AutoFight] CastActiveSkill caster=", caster:GetID(), " skillID=", skillID)
  if self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn then
    self:_LocalPlayerCastActiveSkill(TT, caster, skillID, petID, pickUpGridPos, selectTeamPos)
  else
    self:_RemotePlayerCastActiveSkill(TT, caster, skillID, petID, pickUpGridPos, selectTeamPos, pickExtraParam)
  end
  while GameStateID.ActiveSkill ~= self:_GetFsmStateID() and not self._localLastCastActiveError do
    if GameStateID.WaitInput == self:_GetFsmStateID() then
      self._localLastCastActiveError = true
      local battleStatCmpt = self._world:BattleStat()
      local curRound = battleStatCmpt:GetLevelTotalRoundCount()
      self:_RecordLocalCastActiveSkillError(curRound, skillID)
      break
    end
    YIELD(TT, 100)
  end
end

function AutoFightService:_LocalPlayerCastActiveSkill(TT, petEntity, skillID, petID, pickUpGridPos, selectTeamPos)
  self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 3)
  while GameStateID.PreviewActiveSkill ~= self:_GetFsmStateID() do
    YIELD(TT, 100)
  end
  YIELD(TT, 500)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AutoFightCheckSwitchPetColumn, petID)
  YIELD(TT, 100)
  local configSvc = self._configService
  local skillConfigData = configSvc:GetSkillConfigData(skillID)
  local pickUpType = skillConfigData:GetSkillPickType()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  if pickUpType == SkillPickUpType.None then
    if selectTeamPos and 0 < #selectTeamPos and skillConfigData:GetAutoFightPickPosPolicy() == PickPosPolicy.PetBonai then
      local eTeam = petEntity:Pet():GetOwnerTeamEntity()
      local petPstID = petEntity:PetPstID():GetPstID()
      local cmd = CastSelectTeamOrderPositionCommand.GenerateCommand(eTeam:GetID(), petPstID, selectTeamPos[1])
      self._world:Player():SendCommand(cmd)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AutoFightCastSkill, skillID, pickUpType, petID)
  elseif pickUpType == SkillPickUpType.LinkLine then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetBattlePet",
      uiid = self._world:GetPetData(petID).uiid,
      input = "OnUp",
      args = {}
    })
    YIELD(TT, 1000)
    local isMultiSkill, skillIndex = self:_CheckIsMultiActiveSkill(petEntity, skillID)
    if isMultiSkill then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
        ui = "UIWidgetPetMultiActiveSkill",
        input = "SubSkillOnClick",
        args = {skillIndex}
      })
      YIELD(TT, 1000)
    end
    local previewEntity = self._world:GetPreviewEntity()
    local linkLineSvc = self._world:GetService("PreviewLinkLine")
    local showPath = {}
    for i, pos in ipairs(pickUpGridPos) do
      if i == 1 then
        pickUpTargetCmpt:SetPickUpTargetType(pickUpType)
        pickUpTargetCmpt:SetPickUpGridPos(pos)
      end
      table.insert(showPath, pos)
      previewEntity:ReplacePreviewLinkLine(showPath, PieceType.Blue, PieceType.None)
      linkLineSvc:NotifyPickUpTargetChange()
      YIELD(TT, 100)
    end
    local linkageSvc = self._world:GetService("LinkageRender")
    linkageSvc:DestroyTouchPosEffect()
    YIELD(TT, 500)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetChooseTarget",
      input = "HandleActiveSkillConfirm",
      args = {}
    })
  elseif pickUpType == SkillPickUpType.LinkLineSP then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetBattlePet",
      uiid = self._world:GetPetData(petID).uiid,
      input = "OnUp",
      args = {}
    })
    YIELD(TT, 1000)
    local isMultiSkill, skillIndex = self:_CheckIsMultiActiveSkill(petEntity, skillID)
    if isMultiSkill then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
        ui = "UIWidgetPetMultiActiveSkill",
        input = "SubSkillOnClick",
        args = {skillIndex}
      })
      YIELD(TT, 1000)
    end
    local previewEntity = self._world:GetPreviewEntity()
    local linkLineSvc = self._world:GetService("PreviewLinkLine")
    local showPath = {}
    for i, pos in ipairs(pickUpGridPos) do
      if i == 1 then
        pickUpTargetCmpt:SetPickUpTargetType(pickUpType)
        pickUpTargetCmpt:SetPickUpGridPos(pos)
      end
      table.insert(showPath, pos)
      previewEntity:ReplacePreviewLinkLine(showPath, PieceType.Blue, PieceType.None)
      linkLineSvc:NotifyPickUpTargetChange()
      YIELD(TT, 100)
    end
    local linkageSvc = self._world:GetService("LinkageRender")
    linkageSvc:DestroyTouchPosEffect()
    YIELD(TT, 500)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetChooseTarget",
      input = "HandleActiveSkillConfirm",
      args = {}
    })
  elseif pickUpType == SkillPickUpType.Puzzle then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetBattlePet",
      uiid = self._world:GetPetData(petID).uiid,
      input = "OnUp",
      args = {}
    })
    YIELD(TT, 1000)
    local isMultiSkill, skillIndex = self:_CheckIsMultiActiveSkill(petEntity, skillID)
    if isMultiSkill then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
        ui = "UIWidgetPetMultiActiveSkill",
        input = "SubSkillOnClick",
        args = {skillIndex}
      })
      YIELD(TT, 1000)
    end
    for _, pos in ipairs(pickUpGridPos) do
      pickUpTargetCmpt:SetPickUpTargetType(pickUpType)
      pickUpTargetCmpt:SetPickUpGridPos(pos)
      pickUpTargetCmpt:SetCurActiveSkillInfo(skillID, petID)
      renderBoardEntity:ReplacePickUpTarget()
      YIELD(TT, 500)
    end
    YIELD(TT, 500)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetChooseTarget",
      input = "HandleActiveSkillConfirm",
      args = {}
    })
  elseif pickUpType == SkillPickUpType.PickUpUIAndTrap then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetBattlePet",
      uiid = self._world:GetPetData(petID).uiid,
      input = "OnUp",
      args = {}
    })
    YIELD(TT, 1000)
    local isMultiSkill, skillIndex = self:_CheckIsMultiActiveSkill(petEntity, skillID)
    if not isMultiSkill then
      isMultiSkill, skillIndex = self:_CheckIsVariantActiveSkill(petEntity, skillID)
    end
    if isMultiSkill then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
        ui = "UIWidgetPetMultiActiveSkill",
        input = "SubSkillOnClick",
        args = {skillIndex}
      })
      YIELD(TT, 1000)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
        ui = "UIWidgetPetMultiActiveSkill",
        input = "BtnGoOnClick",
        args = {}
      })
      YIELD(TT, 1000)
    else
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
        ui = "UIWidgetPetSkill",
        input = "btnGoOnClick",
        args = {skillIndex}
      })
      YIELD(TT, 1000)
    end
    local index = selectTeamPos[2]
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetBattlePet",
      uiid = self._world:GetPetData(selectTeamPos[1]).uiid,
      input = "OnUp",
      args = {}
    })
    YIELD(TT, 1000)
    YIELD(TT, 500)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetChooseTarget",
      input = "HandleActiveSkillConfirm",
      args = {}
    })
  elseif pickUpType == SkillPickUpType.Moye then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetBattlePet",
      uiid = self._world:GetPetData(petID).uiid,
      input = "OnUp",
      args = {}
    })
    YIELD(TT, 1000)
    local isMultiSkill, skillIndex = self:_CheckIsMultiActiveSkill(petEntity, skillID)
    if isMultiSkill then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
        ui = "UIWidgetPetMultiActiveSkill",
        input = "SubSkillOnClick",
        args = {skillIndex}
      })
      YIELD(TT, 1000)
    end
    local previewEntity = self._world:GetPreviewEntity()
    local linkLineSvc = self._world:GetService("PreviewLinkLine")
    local showPath = {}
    for i, pos in ipairs(pickUpGridPos) do
      if i == 1 then
        pickUpTargetCmpt:SetPickUpTargetType(pickUpType)
        pickUpTargetCmpt:SetPickUpGridPos(pos)
        pickUpTargetCmpt:SetCurActiveSkillInfo(skillID, petID)
      end
      table.insert(showPath, pos)
      previewEntity:ReplacePreviewLinkLine(showPath, PieceType.Blue, PieceType.None)
      linkLineSvc:NotifyPickUpTargetChange()
      YIELD(TT, 100)
    end
    local linkageSvc = self._world:GetService("LinkageRender")
    linkageSvc:DestroyTouchPosEffect()
    YIELD(TT, 500)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetChooseTarget",
      input = "HandleActiveSkillConfirm",
      args = {}
    })
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetBattlePet",
      uiid = self._world:GetPetData(petID).uiid,
      input = "OnUp",
      args = {}
    })
    YIELD(TT, 1000)
    local isMultiSkill, skillIndex = self:_CheckIsMultiActiveSkill(petEntity, skillID)
    if not isMultiSkill then
      isMultiSkill, skillIndex = self:_CheckIsVariantActiveSkill(petEntity, skillID)
    end
    if isMultiSkill then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
        ui = "UIWidgetPetMultiActiveSkill",
        input = "SubSkillOnClick",
        args = {skillIndex}
      })
      YIELD(TT, 1000)
    end
    local findPickError = false
    local tryPickCount = #pickUpGridPos
    for i, pos in ipairs(pickUpGridPos) do
      Log.debug("pickup pos ", Vector2.Pos2Index(pos))
      pickUpTargetCmpt:SetPickUpTargetType(pickUpType)
      pickUpTargetCmpt:SetPickUpGridPos(pos)
      pickUpTargetCmpt:SetCurActiveSkillInfo(skillID, petID)
      renderBoardEntity:ReplacePickUpTarget()
      YIELD(TT, 500)
      if self._usePickCheck then
        local curPickEnough = self:_CheckLocalCastActiveSkillPickEnough(i, petEntity, pickUpType)
        if not curPickEnough then
          findPickError = true
          break
        end
      end
    end
    YIELD(TT, 500)
    if self._usePickCheck then
      local pickEnough = self:_CheckLocalCastActiveSkillPickEnough(tryPickCount, petEntity, pickUpType)
      local stateError = false
      if GameStateID.WaitInput == self:_GetFsmStateID() then
        stateError = true
      end
      self._localLastCastActiveError = false
      if not stateError then
        if pickEnough and not findPickError then
          GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
            ui = "UIWidgetChooseTarget",
            input = "HandleActiveSkillConfirm",
            args = {}
          })
        else
          Log.error("autofight pick error!!!")
          GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
            ui = "UIWidgetChooseTarget",
            input = "HandleActiveSkillCancel",
            args = {}
          })
          self._localLastCastActiveError = true
          local errorStep = ActivePickSkillCheckErrorStep.AutoPickOnPickError
          local errorType = 0
          if findPickError then
            errorType = ActivePickSkillCheckErrorType.AutoPickFail
          elseif not pickEnough then
            errorType = ActivePickSkillCheckErrorType.AutoPickFail
          end
          self:_OnLocalCastActivePickSkillFail(errorStep, errorType, skillID, petEntity, pickUpGridPos)
        end
      else
        self._localLastCastActiveError = true
        local errorStep = ActivePickSkillCheckErrorStep.AutoPickOnStateError
        local errorType = ActivePickSkillCheckErrorType.AutoPickStateError
        self:_OnLocalCastActivePickSkillFail(errorStep, errorType, skillID, petEntity, pickUpGridPos)
      end
      if self._localLastCastActiveError then
        local battleStatCmpt = self._world:BattleStat()
        local curRound = battleStatCmpt:GetLevelTotalRoundCount()
        self:_RecordLocalCastActiveSkillError(curRound, skillID)
      end
    else
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
        ui = "UIWidgetChooseTarget",
        input = "HandleActiveSkillConfirm",
        args = {}
      })
    end
  end
end

function AutoFightService:_CheckIsMultiActiveSkill(petEntity, skillId)
  local isMultiSkill = false
  local skillIndex = 1
  local skillInfoCmpt = petEntity:SkillInfo()
  local activeSkillID = skillInfoCmpt:GetActiveSkillID()
  local extraSkillList = skillInfoCmpt:GetExtraActiveSkillIDList()
  if extraSkillList and 0 < #extraSkillList then
    isMultiSkill = true
    if skillId == activeSkillID then
      skillIndex = 1
    else
      for index, extraSkillId in ipairs(extraSkillList) do
        if skillId == extraSkillId then
          skillIndex = index + 1
          break
        end
      end
    end
  end
  return isMultiSkill, skillIndex
end

function AutoFightService:_CheckIsVariantActiveSkill(petEntity, skillId)
  local isMultiSkill = false
  local skillIndex = 1
  local skillInfoCmpt = petEntity:SkillInfo()
  local activeSkillID = skillInfoCmpt:GetActiveSkillID()
  local variantSkillInfo = skillInfoCmpt:GetVariantActiveSkillInfo()
  if variantSkillInfo then
    isMultiSkill = true
    if skillId == activeSkillID then
      skillIndex = 1
    else
      local variantSkillList = variantSkillInfo[activeSkillID]
      if variantSkillList then
        for index, variantSkillId in ipairs(variantSkillList) do
          if skillId == variantSkillId then
            skillIndex = index + 1
            break
          end
        end
      else
      end
    end
  end
  return isMultiSkill, skillIndex
end

function AutoFightService:_CheckLocalCastActiveSkillPickEnough(tryPickCount, petEntity, pickUpType)
  local pickEnough = true
  if petEntity then
    if petEntity:HasPreviewPickUpComponent() then
      local previewPickUpComponent = petEntity:PreviewPickUpComponent()
      local ignoreCheck = previewPickUpComponent:IsIgnorePickCheck()
      if ignoreCheck then
        return true
      end
      local pickGrids = previewPickUpComponent:GetAllValidPickUpGridPos()
      local pickGridsCount = #pickGrids
      if pickGridsCount and pickGridsCount ~= tryPickCount then
        if pickUpType == SkillPickUpType.PickOnePosAndRotate then
          pickEnough = pickGridsCount == 1
        else
          pickEnough = false
        end
      end
    else
      pickEnough = false
    end
  end
  return pickEnough
end

function AutoFightService:_RecordLocalCastActiveSkillError(curRound, skillID)
  if not self._localActiveErrorRecord then
    self._localActiveErrorRecord = {}
  end
  if not self._localActiveErrorRecord[curRound] then
    self._localActiveErrorRecord[curRound] = {}
  end
  local roundReceod = self._localActiveErrorRecord[curRound]
  table.insert(roundReceod, skillID)
end

function AutoFightService:_CheckLocalCastActiveSkillErrorCurRound(curRound, skillID)
  if self._localActiveErrorRecord and self._localActiveErrorRecord[curRound] then
    local roundReceod = self._localActiveErrorRecord[curRound]
    if table.icontains(roundReceod, skillID) then
      return true
    end
  end
  return false
end

function AutoFightService:_RemotePlayerCastActiveSkill(TT, petEntity, skillID, petPstID, pickUpGridPos, selectTeamPos, pickExtraParam)
  local skillConfigData = self._configService:GetSkillConfigData(skillID)
  local pickUpType = skillConfigData:GetSkillPickType()
  if pickUpType == SkillPickUpType.None then
    if selectTeamPos and 0 < #selectTeamPos and skillConfigData:GetAutoFightPickPosPolicy() == PickPosPolicy.PetBonai then
      local cTeam = petEntity:Pet():GetOwnerTeamEntity():Team()
      cTeam:SetSelectedTeamOrderPosition(selectTeamPos[1])
    end
    local cmd = CastActiveSkillCommand:New()
    cmd:SetCmdActiveSkillID(skillID)
    cmd:SetCmdCasterPstID(petPstID)
    self._world:Player():SendCommand(cmd)
  else
    local previewPickUpComponent = petEntity:PreviewPickUpComponent()
    if not previewPickUpComponent then
      petEntity:AddPreviewPickUpComponent()
      previewPickUpComponent = petEntity:PreviewPickUpComponent()
    end
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
    for i, pos in ipairs(pickUpGridPos) do
      local direction = scopeCalculator:GetDirection(pos, self._env.PlayerPos)
      previewPickUpComponent:AddGridPos(pos)
      previewPickUpComponent:AddDirection(direction, pos)
    end
    previewPickUpComponent:AddPickExtraParamList(pickExtraParam)
    local cmd = CastPickUpActiveSkillCommand:New()
    cmd:SetCmdActiveSkillID(skillID)
    cmd:SetCmdCasterPstID(petPstID)
    cmd:SetCmdPickUpResult(pickUpGridPos)
    cmd:SetPickUpDirectionResult(previewPickUpComponent:GetPickUpDirectionPos(), previewPickUpComponent:GetAllDirection(), previewPickUpComponent:GetLastPickUpDirection())
    cmd:SetReflectDir(previewPickUpComponent:GetReflectDir())
    cmd:SetCmdPickUpExtraParamResult(previewPickUpComponent:GetAllPickExtraParam())
    self._world:Player():SendCommand(cmd)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.EnemyPetCastActiveSkill, petPstID)
end

function AutoFightService:_CalcPickupPosList(TT, petEntity, activeSkillID)
  local env = self._env
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local boardService = self._world:GetService("BoardLogic")
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
  local skillTags = skillConfigData:GetSkillTag()
  local validGirdList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
  local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
  local utilData = self._world:GetService("UtilData")
  local extraBoardPosRange = utilData:GetExtraBoardPosList()
  for _, extraPos in ipairs(extraBoardPosRange) do
    table.insert(invalidGridList, extraPos)
  end
  local policy = skillConfigData:GetAutoFightPickPosPolicy()
  local policyParam = skillConfigData:GetAutoFightPickPosPolicyParam()
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  local pickUpType = skillConfigData:GetSkillPickType()
  local casterPos = petEntity:GridLocation().Position
  local casterPosIndex = self:_Pos2Index(casterPos)
  local petColor = petEntity:Element():GetPrimaryType()
  local invalidGridDict = {}
  for _, invalidPos in ipairs(invalidGridList) do
    invalidGridDict[self:_Pos2Index(invalidPos)] = true
  end
  local validPosIdxList = {}
  local validPosList = {}
  for _, validPos in ipairs(validGirdList) do
    local validPosIdx = self:_Pos2Index(validPos)
    if not invalidGridDict[validPosIdx] then
      validPosIdxList[validPosIdx] = true
      validPosList[#validPosList + 1] = validPos
    end
  end
  if table.count(validPosList) == 0 and table.count(invalidGridDict) > 0 then
    return {}, {}, {}
  end
  local levelPolicy = self._env.LevelPolicy
  if levelPolicy == LevelPosPolicy.GotoExitPos and table.icontains(skillTags, PetSkillTag.Transport) and self._env.ExitPos then
    local targetPos
    local exitPos = self._env.ExitPos
    local neareastDistance = (casterPos.x - exitPos.x) ^ 2 + (casterPos.y - exitPos.y) ^ 2
    for i, pos in ipairs(validPosList) do
      local dis = (pos.x - exitPos.x) ^ 2 + (pos.y - exitPos.y) ^ 2
      if neareastDistance > dis then
        neareastDistance = dis
        targetPos = pos
      end
    end
    return {targetPos}, {}, {}
  end
  local pickPosList, attackPosList, targetIdList, extraParam = self:CalcPickUpByPolicy(TT, petEntity, activeSkillID, policy, policyParam)
  if pickPosList then
    return pickPosList, attackPosList, targetIdList, extraParam
  else
    return {}, {}, {}
  end
end

function AutoFightService:_CalcTrapPickupPosList_YiSiTaWan(trapEntity, activeSkillID, petEntityIDList)
  local pickUpPolicyObject = PickUpPolicy_YiSiTaWanTrap:New(self._world)
  local calcParam = PickUpPolicy_CalcParam:New(nil, trapEntity, activeSkillID, nil)
  return pickUpPolicyObject:CalcAutoFightPickUpPolicy(calcParam, petEntityIDList)
end

function AutoFightService:_CalcTrapPickupPosList(trapEntity, activeSkillID)
  local env = self._env
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local boardService = self._world:GetService("BoardLogic")
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
  local skillTags = skillConfigData:GetSkillTag()
  local validGirdList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, trapEntity)
  local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, trapEntity)
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  local pickUpType = skillConfigData:GetSkillPickType()
  local petColor = 0
  local invalidGridDict = {}
  for _, invalidPos in ipairs(invalidGridList) do
    invalidGridDict[self:_Pos2Index(invalidPos)] = true
  end
  local validPosIdxList = {}
  local validPosList = {}
  for _, validPos in ipairs(validGirdList) do
    local validPosIdx = self:_Pos2Index(validPos)
    if not invalidGridDict[validPosIdx] then
      validPosIdxList[validPosIdx] = true
      validPosList[#validPosList + 1] = validPos
    end
  end
  local teamEntity = self._env.TeamEntity
  local casterPos = teamEntity:GridLocation().Position
  local pickPosList = {}
  local targetIdList = {}
  local attackPosList = {}
  local posList, attackPosList, targetIdList = self:_CalPickPosPolicy_NearestPos(trapEntity, activeSkillID, casterPos, validPosIdxList, pickUpNum, petColor)
  return posList, attackPosList, targetIdList
end

function AutoFightService:_CalcPickUpColor(petEntity, activeSkillID, validGirdList)
  local env = self._env
  local results = {}
  local selectedColor = {}
  for _, pos in ipairs(validGirdList) do
    local posIdx = self:_Pos2Index(pos)
    local color = env.BoardPosPieces[posIdx]
    if not selectedColor[color] then
      selectedColor[color] = true
      local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets(petEntity, activeSkillID, pos)
      if 0 < #target_ids then
        table.insert(results, {
          pos,
          target_ids,
          scope_result:GetAttackRange()
        })
      end
    end
  end
  return results
end

function AutoFightService:_CalcPickUpPosAndRange(petEntity, activeSkillID, validGirdList)
  local env = self._env
  local results = {}
  table.shuffle(validGirdList)
  for _, pos in ipairs(validGirdList) do
    local posIdx = self:_Pos2Index(pos)
    if env.BoardPosPieces[posIdx] then
      local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets(petEntity, activeSkillID, pos)
      if 0 < #target_ids then
        table.insert(results, {
          pos,
          target_ids,
          scope_result:GetAttackRange()
        })
      end
    end
  end
  return results
end

function AutoFightService:_CalcPickUpPosAndTeleport(petEntity, activeSkillID, validGirdList)
  local env = self._env
  local results = {}
  table.shuffle(validGirdList)
  local playerPosIdx = self:_Pos2Index(env.PlayerPos)
  local firstPickUpPos = validGirdList[1]
  if not firstPickUpPos then
    return results
  end
  local secondPos
  local battleSvc = self._world:GetService("Battle")
  local connect = env.ConnectMap[playerPosIdx]
  for i = 1, 8 do
    local posIdx = connect[i]
    if posIdx then
      local pos = self:_Index2Pos(posIdx)
      if pos then
        local targetEntityList = battleSvc:FindMonsterEntityInPos(pos)
        if #targetEntityList == 0 and firstPickUpPos ~= pos then
          secondPos = self:_Index2Pos(posIdx)
          break
        end
      end
    end
  end
  if secondPos then
    table.insert(results, {
      firstPickUpPos,
      {1},
      {firstPickUpPos},
      secondPos
    })
  end
  return results
end

function AutoFightService:_CalcPickUpDirection(petEntity, activeSkillID, validGirdList)
  local env = self._env
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local results = {}
  local casterPos = petEntity:GetGridPosition()
  table.shuffle(validGirdList)
  local selectedDirection = {}
  for _, pos in ipairs(validGirdList) do
    local posIdx = self:_Pos2Index(pos)
    local direction = scopeCalculator:GetDirection(pos, casterPos)
    if table.icontains(selectedDirection, direction) then
    elseif env.BoardPosPieces[posIdx] then
      table.insert(selectedDirection, direction)
      local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets(petEntity, activeSkillID, pos)
      if 0 < #target_ids then
        table.insert(results, {
          pos,
          target_ids,
          scope_result:GetAttackRange()
        })
      end
    end
  end
  return results
end

function AutoFightService:_CalcPickUpPosAndDirection(petEntity, activeSkillID, validGirdList)
  local env = self._env
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local results = {}
  local casterPos = petEntity:GetGridPosition()
  table.shuffle(validGirdList)
  for _, firstPickUpPos in ipairs(validGirdList) do
    local directionGridList = {}
    table.insert(directionGridList, Vector2(firstPickUpPos.x + 0, firstPickUpPos.y + 1))
    table.insert(directionGridList, Vector2(firstPickUpPos.x + 1, firstPickUpPos.y + 0))
    table.insert(directionGridList, Vector2(firstPickUpPos.x + 0, firstPickUpPos.y - 1))
    table.insert(directionGridList, Vector2(firstPickUpPos.x - 1, firstPickUpPos.y + 0))
    for _, secondPos in ipairs(directionGridList) do
      local posIdx = self:_Pos2Index(secondPos)
      if env.BoardPosPieces[posIdx] then
        local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets(petEntity, activeSkillID, {firstPickUpPos, secondPos})
        if 0 < #target_ids then
          table.insert(results, {
            firstPickUpPos,
            target_ids,
            scope_result:GetAttackRange(),
            secondPos
          })
        end
      end
    end
  end
  return results
end

local function GetTwoSideOffset(centerPos, dir)
  local ret = {}
  if dir.x ~= 0 then
    table.insert(ret, Vector2(centerPos.x, centerPos.y + 1))
    table.insert(ret, Vector2(centerPos.x, centerPos.y - 1))
  elseif dir.y ~= 0 then
    table.insert(ret, Vector2(centerPos.x + 1, centerPos.y))
    table.insert(ret, Vector2(centerPos.x - 1, centerPos.y))
  end
  return ret
end

function AutoFightService:_CalcPickUpLineAndDirection(petEntity, activeSkillID, validGirdList)
  local env = self._env
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local results = {}
  local casterPos = petEntity:GetGridPosition()
  table.shuffle(validGirdList)
  for _, firstPickUpPos in ipairs(validGirdList) do
    local directionGridList = {}
    local mainDir = firstPickUpPos - casterPos
    local sidePos = GetTwoSideOffset(firstPickUpPos, mainDir)
    for _, sideGrid in ipairs(sidePos) do
      table.insert(directionGridList, sideGrid)
    end
    for _, secondPos in ipairs(directionGridList) do
      local posIdx = self:_Pos2Index(secondPos)
      if env.BoardPosPieces[posIdx] then
        local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets(petEntity, activeSkillID, {firstPickUpPos, secondPos})
        if 0 < #target_ids then
          table.insert(results, {
            firstPickUpPos,
            target_ids,
            scope_result:GetAttackRange(),
            secondPos
          })
        end
      end
    end
  end
  return results
end

function AutoFightService:_CalcPickUpPosAndRotate(petEntity, activeSkillID, validGirdList, dirCount)
  local env = self._env
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local results = {}
  local casterPos = petEntity:GetGridPosition()
  table.shuffle(validGirdList)
  petEntity:AddPreviewPickUpComponent()
  local pickUpCmpt = petEntity:PreviewPickUpComponent()
  local dirs = {1, 2}
  if dirCount == 4 then
    dirs[3] = 3
    dirs[4] = 4
  end
  for _, dir in ipairs(dirs) do
    pickUpCmpt:SetReflectDir(dir)
    for _, pickUpPos in ipairs(validGirdList) do
      local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets(petEntity, activeSkillID, pickUpPos)
      if 0 < #target_ids then
        table.insert(results, {
          pickUpPos,
          target_ids,
          scope_result:GetAttackRange(),
          dir
        })
        return results
      end
    end
  end
  return results
end

function AutoFightService:_CalcPickUpSwitch(petEntity, activeSkillID, validGridList)
  local env = self._env
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local results = {}
  local casterPos = petEntity:GetGridPosition()
  local pickDirPos = {}
  if validGridList then
    for _, gridPos in ipairs(validGridList) do
      local hitBackDirType = scopeCalculator:GetDirection(gridPos, casterPos)
      local pickDirType = PickDirTypeForScope.NONE
      if hitBackDirType then
        if self:_IsCrossDir(hitBackDirType) then
          pickDirType = PickDirTypeForScope.CROSS
          pickDirPos[pickDirType] = {hitBackDirType, gridPos}
        elseif self:_IsXDir(hitBackDirType) then
          pickDirType = PickDirTypeForScope.XSHAPE
          pickDirPos[pickDirType] = {hitBackDirType, gridPos}
        else
          pickDirType = PickDirTypeForScope.NONE
        end
      else
        pickDirType = scopeParam.defaultDirType
      end
    end
  end
  petEntity:AddPreviewPickUpComponent()
  local pickUpCmpt = petEntity:PreviewPickUpComponent()
  local dirs = {2, 3}
  for dirType, record in pairs(pickDirPos) do
    pickUpCmpt:AddDirection(record[1], record[2])
    local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets(petEntity, activeSkillID, casterPos)
    if 0 < #target_ids then
      table.insert(results, {
        record[2],
        target_ids,
        scope_result:GetAttackRange()
      })
    end
  end
  return results
end

function AutoFightService:_CalcPickUpPosAndRange(petEntity, activeSkillID, validGirdList)
  local env = self._env
  local results = {}
  table.shuffle(validGirdList)
  for _, pos in ipairs(validGirdList) do
    local posIdx = self:_Pos2Index(pos)
    if env.BoardPosPieces[posIdx] then
      local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets(petEntity, activeSkillID, pos)
      if 0 < #target_ids then
        table.insert(results, {
          pos,
          target_ids,
          scope_result:GetAttackRange()
        })
      end
    end
  end
  return results
end

function AutoFightService:_IsCrossDir(dirType)
  if dirType == HitBackDirectionType.Down or dirType == HitBackDirectionType.Up or dirType == HitBackDirectionType.Left or dirType == HitBackDirectionType.Right then
    return true
  end
  return false
end

function AutoFightService:_IsXDir(dirType)
  if dirType == HitBackDirectionType.RightUp or dirType == HitBackDirectionType.RightDown or dirType == HitBackDirectionType.LeftUp or dirType == HitBackDirectionType.LeftDown then
    return true
  end
  return false
end

function AutoFightService:_CalcSkillScopeResult(petEntity, skillConfigData, scopeType, scopeParam, centerType, targetType, centerPos)
  local playerBodyArea = petEntity:BodyArea():GetArea()
  local casterDir = petEntity:GridLocation():GetGridDir()
  local casterPos = petEntity:GridLocation().Position
  centerPos = centerPos or casterPos
  if IsRandomSkillScopeType(scopeType) then
    scopeType = SkillScopeType.FullScreen
  end
  local scopeCalculator = self._utilScopeSvc:GetSkillScopeCalc()
  local result = scopeCalculator:ComputeScopeRange(scopeType, scopeParam, centerPos, playerBodyArea, casterDir, targetType, casterPos, petEntity)
  local filterPassParam = SkillScopeFilterPassParam:New({
    casterPos = casterPos,
    casterBodyAreaArray = playerBodyArea,
    world = self._world
  })
  self._scopeFilterDevice:DoFilter(result, skillConfigData:GetScopeFilterParam(), filterPassParam)
  return result
end

function AutoFightService:_CalcSkillScopeResultAndTargets(petEntity, activeSkillID, centerPos)
  local buffLogicSvc = self._world:GetService("BuffLogic")
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
  local scopeType = skillConfigData:GetSkillScopeType()
  local scopeParam = skillConfigData:GetSkillScopeParam()
  local centerType = skillConfigData:GetSkillScopeCenterType()
  local targetType = skillConfigData:GetSkillTargetType()
  local skillScopeAndTarget = skillConfigData:GetAutoFightSkillScopeTypeAndTargetType()
  if skillScopeAndTarget and (skillScopeAndTarget.useType == AutoFightScopeUseType.Replace or skillScopeAndTarget.useType == AutoFightScopeUseType.ReplaceTargetAndTrapCount) then
    scopeType = skillScopeAndTarget.scopeType
    scopeParam = skillScopeAndTarget.scopeParam
    centerType = skillScopeAndTarget.centerType
    targetType = skillScopeAndTarget.targetType
  end
  if targetType == SkillTargetType.Board then
    targetType = SkillTargetType.Monster
  end
  local result = self:_CalcSkillScopeResult(petEntity, skillConfigData, scopeType, scopeParam, centerType, targetType, centerPos)
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local targetIds = targetSelector:DoSelectSkillTarget(petEntity, targetType, result, activeSkillID)
  for i = #targetIds, 1, -1 do
    local targetID = targetIds[i]
    local targetEntity = self._world:GetEntityByID(targetID)
    if targetEntity and targetEntity:HasBuff() and not buffLogicSvc:CheckCanBeMagicAttack(petEntity, targetEntity) then
      table.remove(targetIds, i)
    end
  end
  if skillScopeAndTarget and skillScopeAndTarget.useType == AutoFightScopeUseType.ReplaceTargetAndTrapCount then
    local trapID = skillScopeAndTarget.trapID
    local count = skillScopeAndTarget.trapCount
    local trapSvc = self._world:GetService("TrapLogic")
    local trapPosList = trapSvc:FindTrapPosByTrapID(trapID)
    if count > #trapPosList then
      targetIds = {}
    end
  end
  return result, targetIds
end

function AutoFightService:_CheckSkillCondition(TT, caster, skillID, env)
  local skillConfigData = self._configService:GetSkillConfigData(skillID)
  local condition = skillConfigData:GetAutoFightCondition()
  local skillScopeAndTarget = skillConfigData:GetAutoFightSkillScopeTypeAndTargetType()
  local scopeType = skillConfigData:GetSkillScopeType()
  local skillTags = skillConfigData:GetSkillTag()
  local pickUpType = skillConfigData:GetSkillPickType()
  local petColor = caster:Element():GetPrimaryType()
  env.MVP = nil
  local teamEntity = self._env.TeamEntity
  if table.icontains(skillTags, PetSkillTag.RandPieceColor) and not GameGlobal.GetModule(SkillPerfModule):IsPerfCoreGame() and (self._randPieceColor or self._lastConvertColor > 0) then
    return false
  end
  if table.icontains(skillTags, PetSkillTag.FixedPieceColor) and not GameGlobal.GetModule(SkillPerfModule):IsPerfCoreGame() then
    if self._randPieceColor then
      return false
    end
    if self._lastConvertColor > 0 and self._lastConvertColor ~= petColor then
      return false
    end
  end
  local attackTargetCnt = 0
  local attackGridCnt = 0
  local gridColorCnt = {}
  local posList = {}
  local gridList = {}
  local tarList = {}
  local pickUpExtraParam = {}
  if pickUpType == SkillPickUpType.None then
    local result, targetIds = self:_CalcSkillScopeResultAndTargets(caster, skillID)
    attackTargetCnt = #targetIds
    gridList = result:GetAttackRange()
    attackGridCnt = #gridList
    for _, pos in ipairs(result:GetWholeGridRange()) do
      local posIdx = self:_Pos2Index(pos)
      local pieceType = env.BoardPosPieces[posIdx]
      if pieceType then
        gridColorCnt[pieceType] = (gridColorCnt[pieceType] or 0) + 1
      end
    end
    local policy = skillConfigData:GetAutoFightPickPosPolicy()
    if policy == PickPosPolicy.PetBonai then
      env.SelectTeamPos = {1}
    end
  else
    local t1 = os.clock()
    posList, gridList, tarList, pickUpExtraParam = self:_CalcPickupPosList(TT, caster, skillID)
    local t2 = os.clock()
    Log.debug("[AutoFight]_CalcPickupPosList() use time=", (t2 - t1) * 1000, " skillID=", skillID)
    if #posList == 0 then
      return false
    end
    local policy = skillConfigData:GetAutoFightPickPosPolicy()
    if policy == PickPosPolicy.PetYisitawan then
      env.SelectTeamPos = pickUpExtraParam
    end
    attackGridCnt = #gridList
    attackTargetCnt = #tarList
    env.PickUpGridPos = posList
    env.PickUpExtraParam = pickUpExtraParam
  end
  if self._env.LevelPolicy == LevelPosPolicy.GotoExitPos and table.icontains(skillTags, PetSkillTag.Transport) and self._env.ExitPos then
    return true
  end
  if table.icontains(skillTags, PetSkillTag.Attack) and attackTargetCnt == 0 and not GameGlobal.GetModule(SkillPerfModule):IsPerfCoreGame() then
    return false
  end
  if table.icontains(skillTags, PetSkillTag.FixedPieceColor) and attackGridCnt == 0 and not GameGlobal.GetModule(SkillPerfModule):IsPerfCoreGame() then
    return false
  end
  local checkResult = true
  if condition then
    for k, v in pairs(condition.conds) do
      if k == "AlwaysFalse" then
        condition.conds[k] = "false"
      elseif k == "AlwaysTrue" then
        condition.conds[k] = "true"
      elseif k == "PlayerHP" then
        local playerHP = teamEntity:Attributes():GetCurrentHP()
        local maxHP = teamEntity:Attributes():CalcMaxHp()
        local lsvcCalcDamage = self._world:GetService("CalcDamage")
        local teamHP, teamMaxHP = lsvcCalcDamage:GetTeamLogicHP(teamEntity)
        condition.conds[k] = teamHP / teamMaxHP
      elseif k == "MonsterMinHP" or k == "MonsterMaxHP" then
        local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
        local minblood = 1
        local maxblood = 0
        for i, e in ipairs(group:GetEntities()) do
          local hp = e:Attributes():GetCurrentHP()
          local maxhp = e:Attributes():CalcMaxHp()
          local p = hp / maxhp
          if minblood > p then
            minblood = p
          end
          if maxblood < p then
            maxblood = p
          end
        end
        condition.conds.MonsterMinHP = minblood
        condition.conds.MonsterMaxHP = maxblood
      elseif k == "AttackGrid" then
        condition.conds[k] = attackGridCnt
      elseif k == "AttackTarget" then
        condition.conds[k] = attackTargetCnt
      elseif k == "PowerfullRound" then
        condition.conds[k] = teamEntity:ActiveSkill():GetPowerfullRoundCount(caster:GetID()) or 0
      elseif k == "ScopeGridCount" then
        if skillScopeAndTarget and skillScopeAndTarget.scopeType then
          local effScopeResult = self:_CalcSkillScopeResult(caster, skillConfigData, skillScopeAndTarget.scopeType, skillScopeAndTarget.scopeParam, skillScopeAndTarget.centerType, skillScopeAndTarget.targetType)
          gridColorCnt = {}
          for _, pos in ipairs(effScopeResult:GetAttackRange()) do
            local posIdx = self:_Pos2Index(pos)
            local pieceType = env.BoardPosPieces[posIdx]
            if pieceType then
              gridColorCnt[pieceType] = (gridColorCnt[pieceType] or 0) + 1
            end
          end
        end
        condition.conds[k] = gridColorCnt[petColor] or 0
      elseif k == "ChainPathEvalue" then
        local chainPath, pieceType, evalue = self:GetAutoChainPath(TT, teamEntity)
        condition.conds[k] = evalue
      elseif k == "NotTeamLeader" then
        local teamLeaderEntity = teamEntity:Team():GetTeamLeaderEntity()
        condition.conds[k] = teamLeaderEntity:GetID() ~= caster:GetID() and "true" or "false"
      elseif k == "SanHPPercent" then
        local lsvcFeature = self._world:GetService("FeatureLogic")
        local context = {}
        context.scopeGridCount = #gridList
        if not lsvcFeature:IsActiveSkillCanCast(caster, skillID, context) then
          condition.conds[k] = 0
        else
          local requireSanVal, requireHPPercent = lsvcFeature:CalcActiveSkillSanCost(caster, skillID, context)
          local currentVal = lsvcFeature:GetSanValue()
          if requireSanVal <= currentVal and requireHPPercent == 0 then
            condition.conds[k] = 1
          else
            local lsvcCalcDamage = self._world:GetService("CalcDamage")
            local teamHP, teamMaxHP = lsvcCalcDamage:GetTeamLogicHP(teamEntity)
            local percent = (teamHP - teamMaxHP * requireHPPercent) / teamMaxHP
            condition.conds[k] = percent
          end
        end
      elseif k == "CheckJiero" then
        condition.conds[k] = self:_CheckCondition_PetJiero()
      elseif k == "CheckLingEn" then
        condition.conds[k] = self:_CheckCondition_PetLingEn(caster, skillID)
      elseif k == "CheckLegendEnergy" then
        condition.conds[k] = self:_CheckCondition_LegendEnergy(caster)
      elseif k == "PetHP" then
        local petHP = caster:Attributes():GetCurrentHP()
        local petMaxHP = caster:Attributes():CalcMaxHp()
        condition.conds[k] = petHP / petMaxHP
      end
    end
    checkResult = condition:callback()
  end
  if GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() and GameGlobal.GetModule(SkillPerfModule):HasAppointSkill() then
    if GameGlobal.GetModule(SkillPerfModule):IsAppointSkill(skillID) then
      return true
    else
      return false
    end
  end
  if GameGlobal.GetModule(SkillPerfModule):IsPerfCoreGame() then
    checkResult = true
  end
  if not checkResult then
    return false
  end
  if table.icontains(skillTags, PetSkillTag.RandPieceColor) and not GameGlobal.GetModule(SkillPerfModule):IsPerfCoreGame() then
    self._randPieceColor = true
    env.MVP = nil
  end
  if table.icontains(skillTags, PetSkillTag.FixedPieceColor) and not GameGlobal.GetModule(SkillPerfModule):IsPerfCoreGame() then
    self._lastConvertColor = petColor
    env.MVP = nil
  end
  return true
end

function AutoFightService:_CheckFeatureSkillCondition(TT, caster, skillID, env)
  local skillConfigData = self._configService:GetSkillConfigData(skillID)
  local condition = skillConfigData:GetAutoFightCondition()
  local skillScopeAndTarget = skillConfigData:GetAutoFightSkillScopeTypeAndTargetType()
  local scopeType = skillConfigData:GetSkillScopeType()
  local skillTags = skillConfigData:GetSkillTag()
  local pickUpType = skillConfigData:GetSkillPickType()
  local triggerExtraParam = skillConfigData:GetSkillTriggerExtraParam()
  env.MVP = nil
  local teamEntity = self._env.TeamEntity
  local attackTargetCnt = 0
  local attackGridCnt = 0
  local gridColorCnt = {}
  local lsvcFeature = self._world:GetService("FeatureLogic")
  local posList = {}
  local gridList = {}
  local tarList = {}
  local pickUpExtraParam = {}
  local featureType = FeatureType.PersonaSkill
  if triggerExtraParam and triggerExtraParam[SkillTriggerTypeExtraParam.FeatureType] then
    featureType = triggerExtraParam[SkillTriggerTypeExtraParam.FeatureType]
  end
  if FeatureType.PersonaSkill == featureType then
    return true
  elseif FeatureType.MasterSkillRecover == featureType then
    return true
  elseif FeatureType.MasterSkill == featureType then
    caster = lsvcFeature:GetFeatureSkillHolderEntity(featureType)
    posList, gridList, tarList, pickUpExtraParam = self:_CalcPickupPosList(TT, caster, skillID)
    if #posList == 0 then
      return false
    end
    attackGridCnt = #gridList
    attackTargetCnt = #tarList
    env.PickUpGridPos = posList
    env.PickUpExtraParam = pickUpExtraParam
  elseif FeatureType.Card == featureType then
    return true
  elseif FeatureType.Shop == featureType then
    return true
  elseif FeatureType.BanPetSkill == featureType then
    return true
  end
  return true
end

function AutoFightService:_CalPickPosPolicyPetXiNuoPu(petEntity, activeSkillID, casterPos)
  local env = self._env
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local boardService = self._world:GetService("BoardLogic")
  local ringMax = boardService:GetCurBoardRingMax()
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
  local scopeParamList = skillConfigData._pickUpValidScopeList
  local casterPosIndex = self:_Pos2Index(casterPos)
  local pickPosList = {}
  local retScopeResult = {}
  local retTargetIds = {}
  if 0 < #scopeParamList then
    local totalScopeParam = scopeParamList[1]
    if totalScopeParam:GetScopeType() == SkillScopeType.ScopeByPickNum then
      local subScopeParamList = totalScopeParam:GetScopeParamData()
      if subScopeParamList then
        local subParam = subScopeParamList[1]
        local validScopeParam = SkillPreviewScopeParam:New({
          TargetType = subParam.targetType,
          ScopeType = subParam.scopeType,
          ScopeCenterType = subParam.scopeCenterType,
          TargetTypeParam = subParam.targetTypeParam
        })
        validScopeParam:SetScopeParamData(subParam.scopeParam)
        local validGirdList = utilScopeSvc:BuildScopeGridList({validScopeParam}, petEntity)
        local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
        local invalidGridDict = {}
        for _, invalidPos in ipairs(invalidGridList) do
          invalidGridDict[self:_Pos2Index(invalidPos)] = true
        end
        local validPosIdxList = {}
        local validPosList = {}
        for _, validPos in ipairs(validGirdList) do
          local validPosIdx = self:_Pos2Index(validPos)
          if not invalidGridDict[validPosIdx] then
            validPosIdxList[validPosIdx] = true
            validPosList[#validPosList + 1] = validPos
          end
        end
        local firstPickPos
        for _, off in ipairs(ringMax) do
          local posIdx = self:_PosIndexAddOffset(casterPosIndex, off)
          if validPosIdxList[posIdx] then
            local pos = self:_Index2Pos(posIdx)
            local color = env.BoardPosPieces[posIdx]
            if color and color ~= PieceType.Green then
              firstPickPos = pos
              break
            end
          end
        end
        if firstPickPos then
          subParam = subScopeParamList[2]
          local validScopeParam = SkillPreviewScopeParam:New({
            TargetType = subParam.targetType,
            ScopeType = subParam.scopeType,
            ScopeCenterType = subParam.scopeCenterType,
            TargetTypeParam = subParam.targetTypeParam
          })
          validScopeParam:SetScopeParamData(subParam.scopeParam)
          validGirdList = utilScopeSvc:BuildScopeGridListMultiPick({validScopeParam}, petEntity, {firstPickPos})
          local validPosIdxList = {}
          local validPosList = {}
          for _, validPos in ipairs(validGirdList) do
            local validPosIdx = self:_Pos2Index(validPos)
            if not invalidGridDict[validPosIdx] then
              validPosIdxList[validPosIdx] = true
              validPosList[#validPosList + 1] = validPos
            end
          end
          local secondPickPos
          for _, pos in ipairs(validPosList) do
            if firstPickPos ~= pos then
              secondPickPos = secondPickPos or pos
              local posIdx = self:_Pos2Index(pos)
              local color = env.BoardPosPieces[posIdx]
              if color and color ~= PieceType.Green then
                secondPickPos = pos
                break
              end
            end
          end
          if secondPickPos then
            table.insert(pickPosList, firstPickPos)
            table.insert(pickPosList, secondPickPos)
            retScopeResult, retTargetIds = self:_CalcSkillScopeResultAndTargets(petEntity, activeSkillID, pickPosList)
          end
        end
      end
    end
  end
  return pickPosList, retScopeResult, retTargetIds
end

function AutoFightService:_CalPickPosPolicy_NearestPos(petEntity, activeSkillID, casterPos, validPosIdxList, pickUpNum, petColor)
  local boardService = self._world:GetService("BoardLogic")
  local ringMax = boardService:GetCurBoardRingMax()
  local casterPosIndex = self:_Pos2Index(casterPos)
  local env = self._env
  local posList = {}
  local targetIdList = {}
  local attackPosList = {}
  for _, off in ipairs(ringMax) do
    local posIdx = self:_PosIndexAddOffset(casterPosIndex, off)
    if validPosIdxList[posIdx] then
      local pos = self:_Index2Pos(posIdx)
      if env.BoardPosCanMove[posIdx] and env.BoardPosPieces[posIdx] ~= petColor then
        local result, targetIds = self:_CalcSkillScopeResultAndTargets(petEntity, activeSkillID, pos)
        table.appendArray(attackPosList, result:GetAttackRange())
        table.appendArray(targetIdList, targetIds)
        posList[#posList + 1] = pos
        if pickUpNum <= #posList then
          break
        end
      end
    end
  end
  return posList, attackPosList, targetIdList
end

function AutoFightService:_CalPickPosPolicy_MovePathEndPos(TT, petEntity, activeSkillID)
  local env = self._env
  local attackPosList = {}
  local chainPath, pieceType, evalue = self:GetAutoChainPath(TT, env.TeamEntity)
  local pos = chainPath[#chainPath]
  local isBlockedSummonTrap = self._boardServiceLogic:IsPosBlock(pos, BlockFlag.MonsterLand)
  local isBlockedLinkLine = self._boardServiceLogic:IsPosBlock(pos, BlockFlag.LinkLine)
  if #chainPath == 1 or isBlockedSummonTrap or isBlockedLinkLine then
    return {}, {}, {}
  end
  local result, targetIds = self:_CalcSkillScopeResultAndTargets(petEntity, activeSkillID, pos)
  attackPosList = result:GetAttackRange()
  return {pos}, attackPosList, targetIds
end

function AutoFightService:_CalPickPosPolicy_PetJiaBaiLie(validPosList)
  local env = self._env
  local targetIdList = {}
  local _pieceCnt = {
    0,
    0,
    0,
    0,
    0
  }
  local _pickPos = {}
  for _, pos in ipairs(validPosList) do
    local posIdx = self:_Pos2Index(pos)
    local color = env.BoardPosPieces[posIdx]
    if color and color ~= PieceType.Green then
      _pieceCnt[color] = _pieceCnt[color] + 1
      _pickPos[color] = pos
    end
  end
  local maxCnt, maxPos = 0
  for color, cnt in ipairs(_pieceCnt) do
    if cnt > maxCnt then
      maxCnt = cnt
      maxPos = _pickPos[color]
    end
  end
  return {maxPos}, {maxPos}, targetIdList
end

function AutoFightService:_CalPickPosPolicy_PetLuoYi(petEntity, activeSkillID, casterPos, validPosList, validPosIdxList)
  local env = self._env
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local boardService = self._world:GetService("BoardLogic")
  local ringMax = boardService:GetCurBoardRingMax()
  local udsvc = self._world:GetService("UtilData")
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
  local casterPosIndex = self:_Pos2Index(casterPos)
  local needCheckPower = false
  local powerIfNoTrap, tarTrapId
  local extraParam = skillConfigData:GetSkillTriggerExtraParam()
  if extraParam and extraParam[SkillTriggerTypeExtraParam.PickPosNoCfgTrap] then
    needCheckPower = true
    powerIfNoTrap = extraParam[SkillTriggerTypeExtraParam.PickPosNoCfgTrap]
    local pickType = skillConfigData:GetSkillPickType()
    if pickType == SkillPickUpType.PickDiffPowerInstruction then
      local pickParams = skillConfigData:GetSkillPickParam()
      tarTrapId = pickParams[3]
    end
  end
  local legendPower = 0
  if needCheckPower then
    local attributeCmpt = petEntity:Attributes()
    if attributeCmpt then
      legendPower = attributeCmpt:GetAttribute("LegendPower")
    end
  end
  local pickExtraParam = {}
  local firstPickPos
  for _, off in ipairs(ringMax) do
    local posIdx = self:_PosIndexAddOffset(casterPosIndex, off)
    if validPosIdxList[posIdx] then
      local pos = self:_Index2Pos(posIdx)
      local color = env.BoardPosPieces[posIdx]
      if color and color ~= PieceType.Yellow then
        if needCheckPower then
          local bPickTrap = false
          local traps = udsvc:GetTrapsAtPos(pos)
          if traps then
            for index, e in ipairs(traps) do
              if tarTrapId == e:Trap():GetTrapID() then
                bPickTrap = true
                break
              end
            end
          end
          if not bPickTrap and powerIfNoTrap <= legendPower then
            firstPickPos = pos
            table.insert(pickExtraParam, SkillTriggerTypeExtraParam.PickPosNoCfgTrap)
            break
          end
        else
          firstPickPos = pos
          break
        end
      end
    end
  end
  if firstPickPos then
    return {firstPickPos}, {firstPickPos}, {}, pickExtraParam
  else
    return {}, {}, {}, {}
  end
end

function AutoFightService:_CalPickPosPolicy_PetLen(policyParam, petEntity, activeSkillID, casterPos, validPosList, validPosIdxList)
  local pickPosList = {}
  local atkPosList = {}
  local targetIds = {}
  local extraParam = {}
  local greatestHPVal = 0
  local greatestHPValEntity
  local posIndexEntityIDDic = {}
  local monsterGlobalEntityGroup = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  if self._world:MatchType() == MatchType.MT_BlackFist then
    monsterGlobalEntityGroup = {
      petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
    }
  end
  local utilData = self._world:GetService("UtilData")
  local extraBoardPosRange = utilData:GetExtraBoardPosList()
  for _, e in ipairs(monsterGlobalEntityGroup) do
    local isSelectable = true
    if e:HasBuff() then
      isSelectable = not e:BuffComponent():HasBuffEffect(BuffEffectType.NotBeSelectedAsSkillTarget)
    end
    if not e:HasDeadMark() and isSelectable then
      local hp = e:Attributes():GetCurrentHP()
      local tv2BodyArea = e:BodyArea():GetArea()
      local v2GridPos = e:GetGridPosition()
      local eid = e:GetID()
      local hasValidBodyPos = false
      for _, v2Relative in ipairs(tv2BodyArea) do
        local v2 = v2GridPos + v2Relative
        if not table.intable(extraBoardPosRange, v2) then
          local index = Vector2.Pos2Index(v2)
          posIndexEntityIDDic[index] = eid
          hasValidBodyPos = true
        end
      end
      if hasValidBodyPos and greatestHPVal < hp then
        greatestHPVal = hp
        greatestHPValEntity = e
      end
    end
  end
  if not greatestHPValEntity then
    Log.debug(self._className, "自动主动技释放：场上没怪")
    return pickPosList, atkPosList, targetIds, extraParam
  end
  local greatestHPValEntityID = greatestHPValEntity:GetID()
  Log.debug(self._className, "自动主动技释放：必然包含目标：", greatestHPValEntityID)
  local greatestHPValGridPos = greatestHPValEntity:GetGridPosition()
  if table.intable(extraBoardPosRange, greatestHPValGridPos) then
    local v2GridPos = greatestHPValGridPos
    local tv2BodyArea = greatestHPValEntity:BodyArea():GetArea()
    local validList = {}
    for _, v2Relative in ipairs(tv2BodyArea) do
      local v2 = v2GridPos + v2Relative
      if not table.intable(extraBoardPosRange, v2) then
        table.insert(validList, v2)
      end
    end
    if 0 < #validList then
      table.sort(validList, function(a, b)
        if a.x ~= b.x then
          return a.x < b.x
        else
          return a.y < b.y
        end
      end)
      greatestHPValGridPos = validList[1]
    else
      return pickPosList, atkPosList, targetIds, extraParam
    end
  end
  local utilData = self._world:GetService("UtilData")
  local testResult = {}
  local resultIndex = 0
  for i = 1, #policyParam, 2 do
    local policyXOffset = policyParam[i]
    local policyYOffset = policyParam[i + 1]
    local gridPosX = greatestHPValGridPos.x
    local gridPosY = greatestHPValGridPos.y
    local gridPosOffsetX = gridPosX + policyXOffset
    local gridPosOffsetY = gridPosY + policyYOffset
    local pickPos2 = Vector2.New(gridPosOffsetX, gridPosOffsetY)
    if utilData:IsValidPiecePos(pickPos2) and not self:_IsPosInExtraBoard(pickPos2, extraBoardPosRange) then
      resultIndex = resultIndex + 1
      local result = {
        greatestHPValEntityCount = 0,
        otherMonsterEntityCount = 0,
        index = resultIndex,
        x1 = gridPosX,
        x2 = gridPosOffsetX,
        y1 = gridPosY,
        y2 = gridPosOffsetY,
        targetIDs = {}
      }
      local minX = math.min(gridPosX, gridPosOffsetX)
      local maxX = math.max(gridPosX, gridPosOffsetX)
      local minY = math.min(gridPosY, gridPosOffsetY)
      local maxY = math.max(gridPosY, gridPosOffsetY)
      for x = minX, maxX do
        for y = minY, maxY do
          local v2 = Vector2.New(x, y)
          local tMonsterList = utilData:FindEntityByPosAndType(v2, EnumTargetEntity.Monster)
          if self._world:MatchType() == MatchType.MT_BlackFist then
            local eTeam = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
            if eTeam:GetGridPosition() == v2 then
              tMonsterList = {
                eTeam:GetID()
              }
            end
          end
          for _, eid in ipairs(tMonsterList) do
            if not table.icontains(result.targetIDs, eid) then
              table.insert(result.targetIDs, eid)
            end
            if eid == greatestHPValEntityID then
              result.greatestHPValEntityCount = result.greatestHPValEntityCount + 1
            else
              result.otherMonsterEntityCount = result.otherMonsterEntityCount + 1
            end
          end
        end
      end
      table.insert(testResult, result)
    end
  end
  table.sort(testResult, function(a, b)
    if a.greatestHPValEntityCount ~= b.greatestHPValEntityCount then
      return a.greatestHPValEntityCount > b.greatestHPValEntityCount
    elseif a.otherMonsterEntityCount ~= b.otherMonsterEntityCount then
      return a.otherMonsterEntityCount > b.otherMonsterEntityCount
    else
      return a.index < b.index
    end
  end)
  local finalResult = testResult[1]
  local pickPosA = Vector2.New(finalResult.x1, finalResult.y1)
  local pickPosB = Vector2.New(finalResult.x2, finalResult.y2)
  local minX = math.min(pickPosA.x, pickPosB.x)
  local maxX = math.max(pickPosA.x, pickPosB.x)
  local minY = math.min(pickPosA.y, pickPosB.y)
  local maxY = math.max(pickPosA.y, pickPosB.y)
  for x = minX, maxX do
    for y = minY, maxY do
      local v2 = Vector2.New(x, y)
      if utilData:IsValidPiecePos(v2) then
        table.insert(atkPosList, v2)
      end
    end
  end
  return {pickPosA, pickPosB}, atkPosList, finalResult.targetIDs, extraParam
end

function AutoFightService:_CalPickPosPolicyPetYuSen(petEntity, activeSkillID, casterPos)
  local env = self._env
  local trapID = 0
  local stpSummonTrap
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
  local skillEffectArray = skillConfigData:GetSkillEffect()
  for _, skillEffect in ipairs(skillEffectArray) do
    if skillEffect:GetEffectType() == SkillEffectType.SummonTrap then
      stpSummonTrap = skillEffect
      trapID = stpSummonTrap:GetTrapID()
      if type(trapID) == "table" then
        trapID = trapID[1]
      end
      break
    end
  end
  local targetEntityList = {}
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local teamEntity = petEntity:Pet():GetOwnerTeamEntity()
    local enemyTeam = teamEntity:Team():GetEnemyTeamEntity()
    table.insert(targetEntityList, enemyTeam)
  else
    local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
      if not monsterEntity:HasDeadMark() then
        table.insert(targetEntityList, monsterEntity)
      end
    end
  end
  local trapEntityList = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    if not e:HasDeadMark() and e:TrapID():GetTrapID() == trapID and e:HasSummoner() and e:Summoner():GetSummonerEntityID() == petEntity:GetID() then
      table.insert(trapEntityList, e)
    end
  end
  local pickupPosList = {}
  for _, targetEntity in pairs(targetEntityList) do
    local posList = self:GetPosListAroundBodyArea(targetEntity, 1)
    for _, trapEntity in pairs(trapEntityList) do
      local trapPos = trapEntity:GridLocation():GetGridPos()
      if table.icontains(posList, trapPos) then
        local boardCmpt = self._world:GetBoardEntity():Board()
        local es = boardCmpt:GetPieceEntities(trapPos, function(e)
          return e:HasTeam() or e:HasMonsterID()
        end)
        if #es == 0 and not self._boardServiceLogic:IsPosBlock(trapPos, BlockFlag.LinkLine) then
          table.insert(pickupPosList, trapPos)
        end
      end
    end
  end
  local pickPosList = {}
  local targetIDs = {}
  table.insert(targetIDs, petEntity:GetID())
  if 0 < #pickupPosList then
    pickPosList = table.randomn(pickupPosList, 1)
    return pickPosList, pickPosList, targetIDs
  end
  local scopeCalculator = self._utilScopeSvc:GetSkillScopeCalc()
  local tarSelector = self._world:GetSkillScopeTargetSelector()
  local posList = self._utilSvc:GetCloneBoardGridPos()
  local skillScopeResult = SkillScopeResult:New(SkillScopeType.None, petEntity, posList, posList)
  local nearstTargetIDs = tarSelector:DoSelectSkillTarget(petEntity, SkillTargetType.NearestMonster, skillScopeResult)
  if #nearstTargetIDs < 1 then
    return pickPosList, pickPosList, targetIDs
  end
  local targetID = nearstTargetIDs[1]
  local targetEntity = self._world:GetEntityByID(targetID)
  local posList = self:GetPosListAroundBodyArea(targetEntity, 1)
  for _, pickPos in pairs(posList) do
    local trapSvc = self._world:GetService("TrapLogic")
    if stpSummonTrap:GetBlock() == 0 or trapSvc:CanSummonTrapOnPos(pickPos, trapID) then
      table.insert(pickupPosList, pickPos)
    end
  end
  HelperProxy:SortPosByCenterPosDistance(casterPos, pickupPosList)
  for i = 2, #pickupPosList do
    pickupPosList[i] = nil
  end
  return pickupPosList, pickupPosList, targetIDs
end

function AutoFightService:_CheckSubSkillCondition(TT, e, subSkillList, env)
  local svcCfg = self._configService
  local petEntity = e
  local petPstID = petEntity:PetPstID():GetPstID()
  local sorted_skills = {}
  for i = 1, #subSkillList do
    local skillId = subSkillList[i]
    local skillConfigData = svcCfg:GetSkillConfigData(skillId)
    local cfgExtraParam = skillConfigData:GetSkillTriggerExtraParam()
    if cfgExtraParam then
      local trapID = cfgExtraParam[SkillTriggerTypeExtraParam.TrapID]
      if trapID then
        local trapServiceLogic = self._world:GetService("TrapLogic")
        if not trapServiceLogic:IsTrapCovered(trapID, petPstID) then
          table.insert(sorted_skills, {
            petEntity,
            skillId,
            petPstID,
            i
          })
        end
      end
    else
      table.insert(sorted_skills, {
        petEntity,
        skillId,
        petPstID,
        i
      })
    end
  end
  table.sort(sorted_skills, function(a, b)
    local order1 = svcCfg:GetSkillConfigData(a[2]):GetAutoFightSkillOrder()
    local order2 = svcCfg:GetSkillConfigData(b[2]):GetAutoFightSkillOrder()
    if order1 == order2 then
      return a[4] < b[4]
    end
    return order1 < order2
  end)
  for _, v in ipairs(sorted_skills) do
    local skillId = v[2]
    if self:_CheckSkillCondition(TT, petEntity, skillId, env) then
      env.subSkillID = skillId
      return true
    end
  end
  return false
end

function AutoFightService:_CanAttack(trapPos, targetPosList)
  local scopeCalculator = self._utilScopeSvc:GetSkillScopeCalc()
  local scopeResult = scopeCalculator:ComputeScopeRange(SkillScopeType.Rhombus, {2}, trapPos)
  local attackRange = scopeResult:GetAttackRange()
  local targetInRange = table.union(attackRange, targetPosList)
  if #targetInRange == 0 then
    return false
  end
  return true
end

function AutoFightService:_IsNeedSummonTrap(petEntity, trapID, pieceType, targetPosList)
  local trapEntityList = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    if not e:HasDeadMark() and e:TrapID():GetTrapID() == trapID and e:HasSummoner() then
      local summonEntityID = e:Summoner():GetSummonerEntityID()
      local summonEntity = e:GetSummonerEntity()
      if summonEntity and summonEntity:HasSuperEntity() and summonEntity:GetSuperEntity() then
        summonEntityID = summonEntity:GetSuperEntity():GetID()
      end
      if summonEntityID == petEntity:GetID() then
        table.insert(trapEntityList, e)
      end
    end
  end
  if #trapEntityList == 0 then
    return true, nil
  end
  local trapEntity = trapEntityList[1]
  local trapPos = trapEntity:GetGridPosition()
  if self._utilScopeSvc:IsPosHaveMonsterOrPet(trapPos) then
    return true, trapPos
  end
  if self._utilScopeSvc:IsPosBlock(trapPos, BlockFlag.LinkLine) then
    return true, trapPos
  end
  if pieceType == self._boardServiceLogic:GetPieceType(trapPos) then
    return true, trapPos, true
  end
  if not self:_CanAttack(trapPos, targetPosList) then
    return true, trapPos
  end
  return false, trapPos
end

function AutoFightService:_CalcMatchPickPos(casterPos, posListTab, trapID, pieceType)
  for _, posList in ipairs(posListTab) do
    posList = table.unique(posList)
    HelperProxy:SortPosByCenterPosDistance(casterPos, posList)
    local trapSvc = self._world:GetService("TrapLogic")
    for _, pickPos in pairs(posList) do
      if trapSvc:CanSummonTrapOnPos(pickPos, trapID) then
        if not pieceType then
          return pickPos
        end
        if pieceType and pieceType ~= self._boardServiceLogic:GetPieceType(pickPos) then
          return pickPos
        end
      end
    end
  end
  return nil
end

function AutoFightService:_CalPickPosPolicyPetQingTong(petEntity, activeSkillID, casterPos)
  local pickPosList = {}
  local targetIDs = {}
  table.insert(targetIDs, petEntity:GetID())
  local trapID = 0
  local pieceType = 0
  local canPickTrap = false
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
  local pickPosPolicyParam = skillConfigData:GetAutoFightSkillScopeTypeAndTargetType()
  if pickPosPolicyParam and pickPosPolicyParam.useType == AutoFightScopeUseType.PickPosPolicy then
    trapID = pickPosPolicyParam.trapID
    pieceType = pickPosPolicyParam.pieceType
    canPickTrap = pickPosPolicyParam.canPickTrap
  end
  local targetEntityList = {}
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local teamEntity = petEntity:Pet():GetOwnerTeamEntity()
    local enemyTeam = teamEntity:Team():GetEnemyTeamEntity()
    table.insert(targetEntityList, enemyTeam)
  else
    local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
      if not monsterEntity:HasDeadMark() then
        table.insert(targetEntityList, monsterEntity)
      end
    end
  end
  local targetPosList = {}
  local squareRing1PosList = {}
  local squareRing2PosList = {}
  for _, targetEntity in pairs(targetEntityList) do
    local targetPos = targetEntity:GridLocation():GetGridPos()
    local bodyArea = targetEntity:BodyArea():GetArea()
    for _, value in pairs(bodyArea) do
      local workPos = targetPos + value
      table.insert(targetPosList, workPos)
    end
    local ring1 = self:GetPosListAroundBodyArea(targetEntity, 1)
    table.appendArray(squareRing1PosList, ring1)
    local ring2 = self:GetPosListAroundBodyArea(targetEntity, 2)
    table.appendArray(squareRing2PosList, ring2)
  end
  local needSummon, trapPos, matchPieceType = self:_IsNeedSummonTrap(petEntity, trapID, pieceType, targetPosList)
  if canPickTrap and not needSummon and trapPos then
    table.insert(pickPosList, trapPos)
    return pickPosList, pickPosList, targetIDs
  end
  local squareRingListTab = {}
  table.insert(squareRingListTab, squareRing1PosList)
  table.insert(squareRingListTab, squareRing2PosList)
  local pickPos = self:_CalcMatchPickPos(casterPos, squareRingListTab, trapID, pieceType)
  if pickPos then
    table.insert(pickPosList, pickPos)
    return pickPosList, pickPosList, targetIDs
  end
  if canPickTrap and needSummon and trapPos and matchPieceType and self:_CanAttack(trapPos, targetPosList) then
    table.insert(pickPosList, trapPos)
    return pickPosList, pickPosList, targetIDs
  end
  pickPos = self:_CalcMatchPickPos(casterPos, squareRingListTab, trapID)
  if pickPos then
    table.insert(pickPosList, pickPos)
    return pickPosList, pickPosList, targetIDs
  end
  local vec2BoardMax = {}
  local boardRingMax = self._boardServiceLogic:GetCurBoardRingMax()
  for _, boardPos in ipairs(boardRingMax) do
    local vec2Pos = Vector2(boardPos[1], boardPos[2])
    table.insert(vec2BoardMax, vec2Pos)
  end
  table.removev(vec2BoardMax, casterPos)
  HelperProxy:SortPosByCenterPosDistance(casterPos, vec2BoardMax)
  local trapSvc = self._world:GetService("TrapLogic")
  for _, pickPos in pairs(vec2BoardMax) do
    if trapSvc:CanSummonTrapOnPos(pickPos, trapID) then
      table.insert(pickPosList, pickPos)
      return pickPosList, pickPosList, targetIDs
    end
  end
  return pickPosList, pickPosList, targetIDs
end

function AutoFightService:_CalPickPosPolicy_PetGiles(petEntity, activeSkillID, casterPos, validPosList, validPosIdxList)
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local minHp = 1
  local targetEntity
  for i, e in ipairs(group:GetEntities()) do
    if not e:HasDeadMark() then
      local hp = e:Attributes():GetCurrentHP()
      if not targetEntity or minHp > hp then
        minHp = hp
        targetEntity = e
      end
    end
  end
  if self._world:MatchType() == MatchType.MT_BlackFist then
    targetEntity = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
  end
  if not targetEntity then
    return {}, {}, {}
  end
  local retScopeResult = {}
  local retTargetIds = {}
  local pickPos
  local targetGridPos = targetEntity:GridLocation():GetGridPos()
  local bodyArea = targetEntity:BodyArea():GetArea()
  local dirs = {
    Vector2(0, 1),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(-1, 0)
  }
  for _, value in ipairs(bodyArea) do
    local workPos = targetGridPos + value
    for _, dir in ipairs(dirs) do
      local targetPos = workPos + dir
      if targetPos == casterPos then
        pickPos = targetPos
        break
      end
    end
    if pickPos then
      break
    end
  end
  local utilData = self._world:GetService("UtilData")
  local extraBoardPosRange = utilData:GetExtraBoardPosList()
  if not pickPos then
    local utilDataSvc = self._world:GetService("UtilData")
    for _, dir in ipairs(dirs) do
      local targetPos = targetGridPos + dir
      if utilDataSvc:IsValidPiecePos(targetPos) and not self:_IsPosInExtraBoard(targetPos, extraBoardPosRange) then
        pickPos = targetPos
        break
      end
    end
  end
  retScopeResult, retTargetIds = self:_CalcSkillScopeResultAndTargets(petEntity, activeSkillID, pickPos)
  return {pickPos}, retScopeResult:GetAttackRange(), retTargetIds
end

function AutoFightService:GetPosListAroundBodyArea(entity, ringCount)
  local v2SelfGridPos = entity:GetGridPosition()
  local bodyArea = entity:BodyArea():GetArea()
  local v2SelfDir = entity:GetGridDirection()
  local scopeCalc = SkillScopeCalculator:New(self._utilScopeSvc)
  local scopeResult = scopeCalc:ComputeScopeRange(SkillScopeType.AroundBodyArea, {0, ringCount}, v2SelfGridPos, bodyArea, v2SelfDir, SkillTargetType.Monster, v2SelfGridPos)
  return scopeResult:GetAttackRange()
end

function AutoFightService:_IsPosCanPick(pos, checkBadGrid, checkExtraBoard, utilSvc, extraBoardPosRange)
  if checkBadGrid and self:_IsPosBadGrid(pos, utilSvc) then
    return false
  end
  if checkExtraBoard and self:_IsPosInExtraBoard(pos, extraBoardPosRange) then
    return false
  end
  return true
end

function AutoFightService:_IsPosBadGrid(pos, utilSvc)
  utilSvc = utilSvc or self._world:GetService("UtilData")
  if utilSvc:IsBadGridPos(pos) then
    return true
  end
  return false
end

function AutoFightService:_IsPosInExtraBoard(pos, extraBoardPosRange)
  if not extraBoardPosRange then
    local utilData = self._world:GetService("UtilData")
    extraBoardPosRange = utilData:GetExtraBoardPosList()
  end
  if table.intable(extraBoardPosRange, pos) then
    return true
  end
  return false
end

function AutoFightService:_CalPickPosPolicy_PetVice(petEntity, activeSkillID, casterPos, validPosList, validPosIdxList)
  local targetEntity
  local utilSvc = self._world:GetService("UtilData")
  local utilData = self._world:GetService("UtilData")
  local extraBoardPosRange = utilData:GetExtraBoardPosList()
  if self._world:MatchType() == MatchType.MT_BlackFist then
    targetEntity = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
  else
    local bossEntityList = {}
    local targetEntityList = {}
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local monsterList, monsterPosList = utilScopeSvc:SelectAllMonster(petEntity)
    for i, e in ipairs(monsterList) do
      local gridPos = e:GridLocation():GetGridPos()
      local bodyArea = e:BodyArea():GetArea()
      local hasCacPickPos = false
      for _, value in pairs(bodyArea) do
        local workPos = gridPos + value
        if self:_IsPosCanPick(workPos, true, true, utilSvc, extraBoardPosRange) then
          hasCacPickPos = true
          break
        end
      end
      if hasCacPickPos then
        if e:HasBoss() then
          table.insert(bossEntityList, e)
        end
        table.insert(targetEntityList, e)
      end
    end
    if table.count(bossEntityList) > 0 then
      targetEntityList = bossEntityList
    end
    local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
    local policyParam = skillConfigData:GetAutoFightPickPosPolicyParam()
    for i, e in ipairs(targetEntityList) do
      local buffCmp = e:BuffComponent()
      if buffCmp then
        local buffEffect = policyParam[1]
        if buffCmp:HasBuffEffect(buffEffect) then
          targetEntity = e
          break
        end
      end
    end
    if not targetEntity then
      local maxHP = 0
      for i, e in ipairs(targetEntityList) do
        local hp = e:Attributes():GetCurrentHP()
        if not targetEntity or maxHP < hp then
          maxHP = hp
          targetEntity = e
        end
      end
    end
  end
  if not targetEntity then
    return {}, {}, {}
  end
  local retScopeResult = {}
  local retTargetIds = {}
  local pickPos = targetEntity:GridLocation():GetGridPos()
  if not self:_IsPosCanPick(pickPos, true, true, utilSvc, extraBoardPosRange) then
    local bodyArea = targetEntity:BodyArea():GetArea()
    for _, value in pairs(bodyArea) do
      local workPos = pickPos + value
      local isCanPickPos = self:_IsPosCanPick(workPos, true, true, utilSvc, extraBoardPosRange)
      if isCanPickPos then
        pickPos = workPos
        break
      end
    end
  end
  retScopeResult, retTargetIds = self:_CalcSkillScopeResultAndTargets(petEntity, activeSkillID, pickPos)
  return {pickPos}, retScopeResult:GetAttackRange(), retTargetIds
end

function AutoFightService:_CalPickPosPolicy_FeatureMasterSkill(petEntity, activeSkillID, casterPos, validPosList, validPosIdxList)
  local env = self._env
  local boardService = self._world:GetService("BoardLogic")
  local ringMax = boardService:GetCurBoardRingMax()
  local teamColor = PieceType.Yellow
  local teamPos = casterPos
  local teamEntity = self._env.TeamEntity
  if teamEntity then
    local teamLeaderEntity = teamEntity:Team():GetTeamLeaderEntity()
    teamColor = teamLeaderEntity:Element():GetPrimaryType()
    teamPos = teamEntity:GetGridPosition()
  end
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
  local casterPosIndex = self:_Pos2Index(teamPos)
  local pickExtraParam = {}
  local firstPickPos
  for _, off in ipairs(ringMax) do
    local posIdx = self:_PosIndexAddOffset(casterPosIndex, off)
    if validPosIdxList[posIdx] then
      local pos = self:_Index2Pos(posIdx)
      local color = env.BoardPosPieces[posIdx]
      if color and color ~= teamColor then
        firstPickPos = pos
        break
      end
    end
  end
  if firstPickPos then
    return {firstPickPos}, {firstPickPos}, {}, pickExtraParam
  else
    return {}, {}, {}, {}
  end
end

function AutoFightService:_PetKaLian_CanGridConvertToRed(pos, casterPos)
  local utilScope = self._world:GetService("UtilScopeCalc")
  local lsvcBoard = self._world:GetService("BoardLogic")
  if not utilScope:IsValidPiecePos(pos) then
    return false
  end
  if pos == casterPos then
    return true
  end
  if not lsvcBoard:GetCanConvertGridElement(pos) then
    return false
  end
  if lsvcBoard:GetPieceType(pos) == PieceType.Red then
    return false
  end
  return true
end

function AutoFightService:_CalPickPosPolicy_PetSPKaLian_NoDamage(TT, petEntity, activeSkillID, casterPos, validPosList, validPosIdxList)
  local utilScope = self._world:GetService("UtilScopeCalc")
  local lsvcBoard = self._world:GetService("BoardLogic")
  local tInfo = {}
  for _, v2 in ipairs(validPosList) do
    local convertCount = 0
    local convertPos = {}
    local dir = utilScope:GetStandardDirection8D(v2 - casterPos)
    local posForward = v2 + dir
    local posBackward = v2 - dir
    if self:_PetKaLian_CanGridConvertToRed(posForward, casterPos) then
      convertCount = convertCount + 1
      table.insert(convertPos, posForward)
    end
    if self:_PetKaLian_CanGridConvertToRed(posBackward, casterPos) then
      convertCount = convertCount + 1
      table.insert(convertPos, posBackward)
    end
    if 0 < convertCount then
      local tMonsters, tMonsterPos
      if self._world:MatchType() ~= MatchType.MT_BlackFist then
        tMonsters, tMonsterPos = utilScope:SelectNearestMonsterOnPos(v2, 1)
      else
        local enemyTeamEntity = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
        tMonsters = {enemyTeamEntity}
        tMonsterPos = {
          enemyTeamEntity:GetGridPosition()
        }
      end
      local candidateInfo = {
        index = #tInfo,
        pos = v2,
        convertCount = convertCount,
        convertPos = convertPos,
        nearestMonsterCount = #tMonsters,
        nearestMonsterDistance = 0 < #tMonsterPos and Vector2.Distance(v2, tMonsterPos[1]) or nil
      }
      table.insert(tInfo, candidateInfo)
    end
  end
  if #tInfo == 0 then
    return {}, {}, {}, {}
  end
  table.sort(tInfo, function(a, b)
    if a.convertCount ~= b.convertCount then
      return a.convertCount > b.convertCount
    end
    if a.nearestMonsterDistance ~= b.nearestMonsterDistance then
      return a.nearestMonsterDistance < b.nearestMonsterDistance
    end
    return a.index < b.index
  end)
  local final = tInfo[1]
  return {
    final.pos
  }, final.convertPos, {}, {}
end

function AutoFightService:_CalPickPosPolicy_PetSPKaLian_WithDamage(TT, petEntity, activeSkillID, casterPos, validPosList, validPosIdxList)
  local utilScope = self._world:GetService("UtilScopeCalc")
  local lsvcBoard = self._world:GetService("BoardLogic")
  local configSvc = self._configService
  local skillConfigData = configSvc:GetSkillConfigData(activeSkillID)
  local tInfo = {}
  for _, v2 in ipairs(validPosList) do
    local convertCount = 0
    local dir = utilScope:GetStandardDirection8D(v2 - casterPos)
    local posForward = v2 + dir
    local posBackward = v2 - dir
    if self:_PetKaLian_CanGridConvertToRed(posForward, casterPos) then
      convertCount = convertCount + 1
    end
    if self:_PetKaLian_CanGridConvertToRed(posBackward, casterPos) then
      convertCount = convertCount + 1
    end
    if 0 < convertCount then
      local tMonsters, tMonsterPos
      if self._world:MatchType() ~= MatchType.MT_BlackFist then
        tMonsters, tMonsterPos = utilScope:SelectNearestMonsterOnPos(v2, 1)
        YIELD(TT)
      else
        local enemyTeamEntity = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
        tMonsters = {enemyTeamEntity}
        tMonsterPos = {
          enemyTeamEntity:GetGridPosition()
        }
      end
      local scopeCalculator = utilScope:GetSkillScopeCalc()
      local attackRangeScopeResult = scopeCalculator:ComputeScopeRange(SkillScopeType.AngleFreeLine, {widthThreshold = 1, noExtend = 1}, v2, petEntity:BodyArea():GetArea(), petEntity:GetGridDirection(), SkillTargetType.MonsterTrap, petEntity:GetGridPosition(), petEntity)
      local attackRange = attackRangeScopeResult:GetAttackRange() or {}
      local targetSelector = self._world:GetSkillScopeTargetSelector()
      local targetIds = targetSelector:DoSelectSkillTarget(petEntity, SkillTargetType.Monster, attackRangeScopeResult, activeSkillID) or {}
      local candidateInfo = {
        index = #tInfo,
        pos = v2,
        convertCount = convertCount,
        nearestMonsterCount = #tMonsters,
        nearestMonsterDistance = 0 < #tMonsterPos and Vector2.Distance(v2, tMonsterPos[1]) or nil,
        attackRange = attackRange,
        targetIds = targetIds
      }
      table.insert(tInfo, candidateInfo)
    end
  end
  if #tInfo == 0 then
    return {}, {}, {}, {}
  end
  table.sort(tInfo, function(a, b)
    if a.convertCount ~= b.convertCount then
      return a.convertCount > b.convertCount
    end
    local countA = #a.targetIds
    local countB = #b.targetIds
    if countA ~= countB then
      return countA > countB
    end
    return a.index < b.index
  end)
  local final = tInfo[1]
  YIELD(TT)
  return {
    final.pos
  }, final.attackRange, final.targetIds, {}
end

function AutoFightService:_GetReinhardtRange(pos)
  local retPos = {}
  table.insert(retPos, pos + Vector2(0, 0))
  table.insert(retPos, pos + Vector2(0, 1))
  table.insert(retPos, pos + Vector2(0, -1))
  table.insert(retPos, pos + Vector2(1, 0))
  table.insert(retPos, pos + Vector2(-1, 0))
  return retPos
end

function AutoFightService:_CalPickPosPolicy_PetReinhardt(petEntity, activeSkillID, policyParam, casterPos, validPosList, validPosIdxList, pickUpNum)
  local targetEntity = {}
  local targetPosList = {}
  if self._world:MatchType() == MatchType.MT_BlackFist then
    targetEntity = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
    local pos = targetEntity:GetGridPosition()
    local posIndex = Vector2.Pos2Index(pos)
    targetPosList[posIndex] = targetEntity:GetID()
  else
    local groupEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
    for i, v in ipairs(groupEntities) do
      local areaCmpt = v:BodyArea()
      local pos = v:GetGridPosition()
      local areaList = areaCmpt:GetArea()
      for i, area in ipairs(areaList) do
        local newPos = area + pos
        local posIndex = Vector2.Pos2Index(newPos)
        targetPosList[posIndex] = v:GetID()
      end
    end
  end
  local pickPos = {}
  while 0 < pickUpNum do
    local attackPosCount = 0
    local pickUpPos
    for i, pos in ipairs(validPosList) do
      local range = self:_GetReinhardtRange(pos)
      local tmpAPC = 0
      for i, v in ipairs(range) do
        local index = Vector2.Pos2Index(v)
        if targetPosList[index] then
          tmpAPC = tmpAPC + 1
        end
      end
      if attackPosCount < tmpAPC and not table.Vector2Include(pickPos, pos) then
        attackPosCount = tmpAPC
        pickUpPos = pos
      end
    end
    if not pickUpPos then
      while not pickUpPos do
        local count = #validPosList
        local index = math.random(1, count)
        local pos = validPosList[index]
        if not table.Vector2Include(pickPos, pos) then
          pickUpPos = pos
          break
        end
      end
    end
    pickUpNum = pickUpNum - 1
    table.insert(pickPos, pickUpPos)
  end
  return pickPos, pickPos, {}
end

function AutoFightService:_CastFeatureSkill(TT, skillData)
  Log.debug("[AutoFight] _CastFeatureSkill skillID=", skillData.m_nSkillID)
  if self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn then
    self:_LocalPlayerCastFeatureSkill(TT, skillData)
  else
  end
  while GameStateID.PersonaSkill ~= self:_GetFsmStateID() do
    YIELD(TT, 100)
  end
end

function AutoFightService:_LocalPlayerCastFeatureSkill(TT, skillData)
  local configSvc = self._configService
  local skillConfigData = configSvc:GetSkillConfigData(skillData.m_nSkillID)
  local pickUpType = skillConfigData:GetSkillPickType()
  local triggerExtraParam = skillConfigData:GetSkillTriggerExtraParam()
  local featureType = FeatureType.PersonaSkill
  if triggerExtraParam and triggerExtraParam[SkillTriggerTypeExtraParam.FeatureType] then
    featureType = triggerExtraParam[SkillTriggerTypeExtraParam.FeatureType]
  end
  if FeatureType.BanPetSkill == featureType then
  else
    self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 3)
    while GameStateID.PreviewActiveSkill ~= self:_GetFsmStateID() do
      YIELD(TT, 100)
    end
  end
  YIELD(TT, 500)
  if FeatureType.PersonaSkill == featureType then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AutoFightCastPersonaSkill)
  elseif FeatureType.MasterSkillRecover == featureType then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AutoFightCastPersonaSkill, featureType)
  elseif FeatureType.MasterSkill == featureType then
    local pickUpGridPos = skillData.m_listPickUpPos
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetFeatureMasterSkill",
      input = "OnClickUI",
      args = {}
    })
    YIELD(TT, 1000)
    for i, pos in ipairs(pickUpGridPos) do
      Log.debug("pickup pos ", Vector2.Pos2Index(pos))
      pickUpTargetCmpt:SetPickUpTargetType(pickUpType)
      pickUpTargetCmpt:SetPickUpGridPos(pos)
      local petID = 0
      pickUpTargetCmpt:SetCurActiveSkillInfo(skillData.m_nSkillID, petID)
      renderBoardEntity:ReplacePickUpTarget()
      YIELD(TT, 500)
    end
    YIELD(TT, 500)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
      ui = "UIWidgetChooseTarget",
      input = "HandleActiveSkillConfirm",
      args = {}
    })
  elseif FeatureType.Card == featureType then
    local cardCostType = triggerExtraParam[SkillTriggerTypeExtraParam.CardCost]
    if cardCostType then
      local lsvcFeature = self._world:GetService("FeatureLogic")
      local featureData = lsvcFeature:GetFeatureData(FeatureType.Card)
      local cardUiType = featureData:GetUiType()
      local cardUiName = "UIWidgetFeatureCard"
      local cardInfoUiName = "UIWidgetFeatureCardInfo"
      if cardUiType == FeatureCardUiType.Skin1 then
        cardUiName = "UIWidgetFeatureCard_L"
        cardInfoUiName = "UIWidgetFeatureCardInfo_L"
      end
      local costList = lsvcFeature:GetCostCardListByType(cardCostType)
      if costList then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
          ui = cardUiName,
          input = "OnClickUI",
          args = {}
        })
        YIELD(TT, 1000)
        for _, cardType in ipairs(costList) do
          GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
            ui = cardInfoUiName,
            input = "AutoCardImgOnClick",
            args = {cardType}
          })
          YIELD(TT, 500)
        end
        YIELD(TT, 500)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, {
          ui = cardInfoUiName,
          input = "OnCastClick",
          args = {}
        })
      end
    end
  elseif FeatureType.Shop == featureType then
    local newUnlockCellList = {}
    local shopUIHadSeeUnlockCellList = FeatureServiceHelper.GetShopUIHadSeeUnlockCellList()
    for index, cellID in ipairs(skillData.m_clientSelectInfo) do
      if not table.icontains(shopUIHadSeeUnlockCellList, cellID) then
        table.insert(newUnlockCellList, cellID)
      end
    end
    if 0 < table.count(newUnlockCellList) then
      table.appendArray(shopUIHadSeeUnlockCellList, newUnlockCellList)
      FeatureServiceHelper.SetShopUIHadSeeUnlockCellList(shopUIHadSeeUnlockCellList)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CastShopSkill, skillData.m_nSkillID, skillData.m_clientSelectInfo)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIResetLastPreviewPetId)
    YIELD(TT)
  elseif FeatureType.BanPetSkill == featureType then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureAutoFightCastBanPetSkill, skillData.m_nSkillID)
  end
end

function AutoFightService:_CalPickPosPolicyPetFeiYa(petEntity, activeSkillID)
  local pickPosList = {}
  local targetIDs = {}
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
  if self._castActiveSkillCount == 0 and skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
    local legendPower = petEntity:Attributes():GetAttribute("LegendPower")
    local canCast = legendPower >= 2 * skillConfigData:GetSkillTriggerParam()
    if not canCast then
      self._castActiveSkillCount = 0
      return pickPosList, pickPosList, targetIDs
    end
  end
  local enemyEntities = {}
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for i, e in ipairs(monsterGroup:GetEntities()) do
    if not e:HasDeadMark() then
      table.insert(enemyEntities, e)
    end
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if petEntity then
    if petEntity:HasTeam() then
      teamEntity = petEntity
    elseif petEntity:HasPet() then
      teamEntity = petEntity:Pet():GetOwnerTeamEntity()
    end
  end
  if self._world:MatchType() == MatchType.MT_BlackFist then
    table.insert(enemyEntities, teamEntity:Team():GetEnemyTeamEntity())
  end
  local utilData = self._world:GetService("UtilData")
  local extraBoardPosRange = utilData:GetExtraBoardPosList()
  local minHPEntityID = 0
  local minHP = MAX_INT_32
  local minHPEntityPos
  for _, e in ipairs(enemyEntities) do
    local gridLocCmpt = e:GridLocation()
    local pickPos = gridLocCmpt:GetGridPos()
    if utilData:IsValidPiecePos(pickPos) then
      local isCanPickPos = self:_IsPosCanPick(pickPos, true, true, utilData, extraBoardPosRange)
      if not isCanPickPos then
        local bodyArea = e:BodyArea():GetArea()
        for _, value in pairs(bodyArea) do
          local workPos = pickPos + value
          isCanPickPos = self:_IsPosCanPick(workPos, true, true, utilData, extraBoardPosRange)
          if isCanPickPos then
            pickPos = workPos
            break
          end
        end
      end
      if isCanPickPos then
        local hp = e:Attributes():GetCurrentHP()
        if minHP > hp then
          minHP = hp
          minHPEntityPos = pickPos
          minHPEntityID = e:GetID()
        end
      end
    end
  end
  if minHPEntityPos then
    table.insert(pickPosList, minHPEntityPos)
    table.insert(targetIDs, minHPEntityID)
    self._castActiveSkillCount = self._castActiveSkillCount + 1
    if self._castActiveSkillCount == 2 then
      self._castActiveSkillCount = 0
    end
  end
  return pickPosList, pickPosList, targetIDs
end

function AutoFightService:_FindFeatureCardSkillID()
  local lsvcFeature = self._world:GetService("FeatureLogic")
  local skillList = lsvcFeature:GetAvailableCardSkillList()
  if skillList and 0 < #skillList then
    return skillList[1]
  else
    return
  end
end

function AutoFightService:_FindFeatureShopSkillID()
  local lsvcFeature = self._world:GetService("FeatureLogic")
  local skillID, selectInfo = lsvcFeature:GetAvailableShopSkill()
  if skillID and 0 < skillID then
    return skillID, selectInfo
  else
    return
  end
end

function AutoFightService:_FindFeatureBanPetSkillID()
  local lsvcFeature = self._world:GetService("FeatureLogic")
  local skillID = lsvcFeature:OnGetAutoFightCastBanPetSkillID()
  if skillID and 0 < skillID then
    return skillID
  else
    return
  end
end

function AutoFightService:_CalPickPosPolicyPetJudge(petEntity, activeSkillID, casterPos, validPosList, validPosIdxList)
  local env = self._env
  local petEntityID = petEntity:GetID()
  local petTraps = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for _, e in ipairs(trapGroup:GetEntities()) do
    if not e:HasDeadMark() and e:HasSummoner() then
      local summonEntity = e:GetSummonerEntity()
      if summonEntity and summonEntity:HasSuperEntity() then
        summonEntity = summonEntity:GetSuperEntity()
      end
      if summonEntity then
        local summonEntityID = summonEntity:GetID()
        if petEntityID == summonEntityID then
          table.insert(petTraps, e)
        end
      end
    end
  end
  local pickPos, pickScopeRange
  if #petTraps == 0 then
    local ringNum = 2
    local posList = self:GetPosListAroundBodyArea(petEntity, ringNum)
    table.shuffle(posList)
    for _, pos in ipairs(posList) do
      local posIdx = self:_Pos2Index(pos)
      if validPosIdxList[posIdx] then
        pickPos = pos
        break
      end
    end
    if pickPos then
      local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets(petEntity, activeSkillID, pickPos)
      pickScopeRange = scope_result:GetAttackRange()
    end
  else
    table.shuffle(validPosList)
    local results = {}
    for _, pos in ipairs(validPosList) do
      local posIdx = self:_Pos2Index(pos)
      if env.BoardPosPieces[posIdx] then
        local scope_result, target_ids = self:_CalcSkillScopeResultAndTargets(petEntity, activeSkillID, pos)
        if 0 < #target_ids then
          table.insert(results, {
            pos,
            target_ids,
            scope_result:GetAttackRange()
          })
        end
      end
    end
    if 0 < #results then
      table.sort(results, function(a, b)
        return #a[2] > #b[2]
      end)
      local tarResult = results[1]
      pickPos = tarResult[1]
      pickScopeRange = tarResult[3]
    end
  end
  if pickPos then
    return {pickPos}, pickScopeRange, {petEntityID}
  else
    return {}, {}, {}
  end
end

function AutoFightService:_CalPickPosPolicyPet1601701(petEntity, activeSkillID, casterPos, policyParam)
  local env = self._env
  local petEntityID = petEntity:GetID()
  local pickPos, pickScopeRange
  local leftPos = casterPos.x - 1
  local rightPos = casterPos.x + 1
  local boardSvc = self._world:GetService("BoardLogic")
  local maxY = boardSvc:GetCurBoardMaxY()
  local leftLine, rightLine = {}, {}
  local leftCount, rightCount = 0, 0
  local spPieceType = policyParam[1]
  for i = 1, maxY do
    local newPos = Vector2(leftPos, i)
    local pieceType = boardSvc:GetPieceType(newPos)
    if pieceType and pieceType ~= PieceType.None then
      table.insert(leftLine, newPos)
      if pieceType == spPieceType then
        leftCount = leftCount + 1
      end
    end
    newPos = Vector2(rightPos, i)
    pieceType = boardSvc:GetPieceType(newPos)
    if pieceType and pieceType ~= PieceType.None then
      table.insert(rightLine, newPos)
      if pieceType == spPieceType then
        rightCount = rightCount + 1
      end
    end
  end
  local curLine
  if leftCount > rightCount then
    curLine = leftLine
  else
    curLine = rightLine
  end
  if #curLine == 0 then
    if 0 < #leftLine then
      curLine = leftLine
    else
      curLine = rightLine
    end
  end
  local pickUpPos
  local battleSvc = self._world:GetService("Battle")
  for i, pos in ipairs(curLine) do
    local targetEntityList = battleSvc:FindMonsterEntityInPos(pos)
    if #targetEntityList ~= 0 then
      pickUpPos = pos
    end
  end
  if not pickUpPos then
    local index = math.random(1, #curLine)
    pickUpPos = curLine[index]
  end
  local maxX = boardSvc:GetCurBoardMaxX()
  local leftEdgeLen = math.abs(maxX - pickUpPos.x - 1)
  local rightEdgeLen = math.abs(maxX - pickUpPos.x + 1)
  local dirPos
  if leftEdgeLen < rightEdgeLen then
    dirPos = Vector2(pickUpPos.x - 1, pickUpPos.y)
  else
    dirPos = Vector2(pickUpPos.x + 1, pickUpPos.y)
  end
  return {pickUpPos, dirPos}, {pickUpPos, dirPos}, {}
end

function AutoFightService:_CalPickPosPolicyPet1601751(petEntity, activeSkillID, policyParam, casterPos, validPosList, validPosIdxList)
  local eTeam = petEntity:Pet():GetOwnerTeamEntity()
  local lsvcCalcDamage = self._world:GetService("CalcDamage")
  local teamHP, teamMaxHP = lsvcCalcDamage:GetTeamLogicHP(eTeam)
  local percent = teamHP / teamMaxHP
  if 0.5 <= percent then
    local autoActiveSkillCount = petEntity:PetRender():GetPet1601751HPAboveLimitAutoCastActiveCount()
    if 0 < autoActiveSkillCount then
      return {}, {}, {}
    end
    local pickPos, atkPos, targetList = self:_CalPickupPosPolicyPet1601751SummonHealTrap(petEntity, activeSkillID, policyParam, casterPos, validPosList, validPosIdxList)
    petEntity:PetRender():TickPet1601751HPAboveLimitAutoCastActiveCount()
    return pickPos, atkPos, targetList
  else
    local globalTrapGroupEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.Trap)
    local tSelectedTrap = {}
    for _, e in ipairs(globalTrapGroupEntities) do
      if not e:HasDeadMark() and e:TrapID():GetTrapID() == policyParam.healTrapID and table.Vector2Include(validPosList, e:GetGridPosition()) then
        table.insert(tSelectedTrap, e)
      end
    end
    if 0 < #tSelectedTrap then
      local firstTrap = table.remove(tSelectedTrap, 1)
      local trapGridPos = firstTrap:GetGridPosition()
      return {trapGridPos}, {trapGridPos}, {}
    else
      local pickPos, atkPos, targetList = self:_CalPickupPosPolicyPet1601751SummonHealTrap(petEntity, activeSkillID, policyParam, casterPos, validPosList, validPosIdxList)
      return pickPos, atkPos, targetList
    end
  end
end

function AutoFightService:_CalPickupPosPolicyPet1601751SummonHealTrap(petEntity, activeSkillID, policyParam, casterPos, validPosList, validPosIdxList)
  local utilData = self._world:GetService("UtilData")
  local pool = {}
  for _, v2 in ipairs(validPosList) do
    local tTrapEntities = utilData:GetAllTrapEntitiesAtPosByTrapID(v2, policyParam.healTrapID)
    if #tTrapEntities == 0 then
      table.insert(pool, v2)
    end
  end
  if #pool == 0 then
    return {}, {}, {}
  end
  local luckyPosIndex = math.random(1, #pool)
  local luckyPos = table.remove(pool, luckyPosIndex)
  return {luckyPos}, {luckyPos}, {}
end

function AutoFightService:_OnLocalCastActivePickSkillFail(errorStep, errorType, activeSkillID, petEntity, pickUpGridPos)
  local pickPosList = {}
  if petEntity and petEntity:HasPreviewPickUpComponent() then
    local previewPickUpComponent = petEntity:PreviewPickUpComponent()
    if previewPickUpComponent then
      pickPosList = previewPickUpComponent:GetAllValidPickUpGridPos()
    end
  end
  local cmd = ClientExceptionReportCommand.CreateAutoFightPickErrorReport(activeSkillID, errorStep, errorType, pickPosList, pickUpGridPos)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClientExceptionReport, cmd)
end

function AutoFightService:ClearPetActiveSkillTempData()
  local globalPetRenderEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.Pet)
  for _, e in ipairs(globalPetRenderEntities) do
    local cPetRender = e:PetRender()
    if cPetRender then
      cPetRender:ClearPet1601751HPAboveLimitAutoCastActiveCount()
    end
  end
end

function AutoFightService:_CalPickPosPolicy_PetZhongxuMain(petEntity, activeSkillID, casterPos, validPosList, validPosIdxList)
  local env = self._env
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local boardService = self._world:GetService("BoardLogic")
  local ringMax = boardService:GetCurBoardRingMax()
  local udsvc = self._world:GetService("UtilData")
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
  local casterPosIndex = self:_Pos2Index(casterPos)
  local firstPickPos, blackFistEnemyPos
  if self._world:MatchType() == MatchType.MT_BlackFist and petEntity:HasPet() then
    local enemy = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
    blackFistEnemyPos = enemy:GetGridPosition()
  end
  for _, off in ipairs(ringMax) do
    local posIdx = self:_PosIndexAddOffset(casterPosIndex, off)
    if validPosIdxList[posIdx] then
      local pos = self:_Index2Pos(posIdx)
      local color = env.BoardPosPieces[posIdx]
      if color and color ~= PieceType.Red then
        if self._world:MatchType() == MatchType.MT_BlackFist then
          if blackFistEnemyPos ~= pos then
            firstPickPos = pos
            break
          end
        else
          local isHasMonster, monsterID = utilScopeSvc:IsPosHasMonster(pos)
          if not isHasMonster then
            firstPickPos = pos
            break
          end
        end
      end
    end
  end
  if firstPickPos then
    return {firstPickPos}, {firstPickPos}, {}
  else
    return {}, {}, {}
  end
end

function AutoFightService:_CalPickPosPolicy_PetZhongxuExtra(petEntity, activeSkillID, casterPos, validPosList, validPosIdxList)
  local trapEntity
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    if not e:HasDeadMark() and e:HasSummoner() and e:Summoner():GetSummonerEntityID() == petEntity:GetID() then
      trapEntity = e
      break
    end
  end
  if not trapEntity then
    return {}, {}, {}
  end
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
  local scopeType = SkillScopeType.ZhongxuForceMovementPickRange
  local scopeParam, centerType, targetType
  local skillScopeAndTarget = skillConfigData:GetAutoFightSkillScopeTypeAndTargetType()
  if skillScopeAndTarget and skillScopeAndTarget.useType == AutoFightScopeUseType.PickPosPolicy then
    scopeParam = skillScopeAndTarget.ScopeParam
  else
    return {}, {}, {}
  end
  local centerPos = trapEntity:GetGridPosition()
  local firstPickPos = centerPos
  local result = self:_CalcSkillScopeResult(petEntity, skillConfigData, scopeType, scopeParam, centerType, targetType, centerPos)
  if result then
    local attackRange = result:GetAttackRange()
    local upPos, downPos, leftPos, rightPos
    for index, rangePos in ipairs(attackRange) do
      if not upPos or rangePos.y > upPos.y then
        upPos = rangePos
      end
      if not downPos or rangePos.y < downPos.y then
        downPos = rangePos
      end
      if not leftPos or rangePos.x < leftPos.x then
        leftPos = rangePos
      end
      if not rightPos or rangePos.x > rightPos.x then
        rightPos = rangePos
      end
    end
    local secondPickRange = {}
    if upPos then
      table.insert(secondPickRange, upPos)
    end
    if downPos then
      table.insert(secondPickRange, downPos)
    end
    if leftPos then
      table.insert(secondPickRange, leftPos)
    end
    if rightPos then
      table.insert(secondPickRange, rightPos)
    end
    local secondPickRangeCount = #secondPickRange
    if secondPickRangeCount == 0 then
      return {}, {}, {}
    end
    local secondPosIndex = math.random(1, secondPickRangeCount)
    local secondPickPos = secondPickRange[secondPosIndex]
    local pickPosList = {}
    table.insert(pickPosList, firstPickPos)
    table.insert(pickPosList, secondPickPos)
    return pickPosList, pickPosList, {}
  end
  return {}, {}, {}
end

function AutoFightService:_CalPickPosPolicy_PetYeliyaMain(petEntity, activeSkillID, casterPos, validPosList, validPosIdxList)
  local env = self._env
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local utilDataSvc = self._world:GetService("UtilData")
  local boardService = self._world:GetService("BoardLogic")
  local ringMax = boardService:GetCurBoardRingMax()
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
  local scopeParamList = skillConfigData._pickUpValidScopeList
  local casterPosIndex = self:_Pos2Index(casterPos)
  local checkDamageSkillID = 30018411
  local policyParam = skillConfigData:GetAutoFightPickPosPolicyParam()
  if policyParam and policyParam.checkDamageSkillID then
    checkDamageSkillID = tonumber(policyParam.checkDamageSkillID)
  end
  local pickPosList = {}
  local retScopeResult = {}
  local retTargetIds = {}
  local tmpPickList = {}
  if 0 < #scopeParamList then
    local totalScopeParam = scopeParamList[1]
    if totalScopeParam:GetScopeType() == SkillScopeType.ScopeByPickNum then
      local subScopeParamList = totalScopeParam:GetScopeParamData()
      if subScopeParamList then
        local subParam = subScopeParamList[1]
        local validScopeParam = SkillPreviewScopeParam:New({
          TargetType = subParam.targetType,
          ScopeType = subParam.scopeType,
          ScopeCenterType = subParam.scopeCenterType,
          TargetTypeParam = subParam.targetTypeParam
        })
        validScopeParam:SetScopeParamData(subParam.scopeParam)
        local validGirdList = utilScopeSvc:BuildScopeGridList({validScopeParam}, petEntity)
        local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
        local invalidGridDict = {}
        for _, invalidPos in ipairs(invalidGridList) do
          invalidGridDict[self:_Pos2Index(invalidPos)] = true
        end
        local validPosIdxList = {}
        local validPosList = {}
        for _, validPos in ipairs(validGirdList) do
          local validPosIdx = self:_Pos2Index(validPos)
          if not invalidGridDict[validPosIdx] then
            validPosIdxList[validPosIdx] = true
            validPosList[#validPosList + 1] = validPos
          end
        end
        local firstPickPos, lastPickPos
        local lastPickSuperGrid = false
        local testPickPos
        testPickPos = self:_YeliyaFindValidPosWithSuperGrid(petEntity, casterPos, validPosIdxList, tmpPickList)
        if testPickPos then
          firstPickPos = testPickPos
          lastPickPos = testPickPos
          lastPickSuperGrid = true
          table.insert(tmpPickList, firstPickPos)
        else
          testPickPos = self:_YeliyaFindValidPosWithMaxTargetCount(petEntity, casterPos, validPosIdxList, tmpPickList, checkDamageSkillID)
          if testPickPos then
            firstPickPos = testPickPos
            lastPickPos = testPickPos
            lastPickSuperGrid = false
            table.insert(tmpPickList, firstPickPos)
          else
            return {}, {}, {}
          end
        end
        if firstPickPos then
          if not lastPickSuperGrid then
          else
            local subPickFinish = false
            local maxFindTimes = 30
            local findNextTimes = 0
            subParam = subScopeParamList[2]
            local validScopeParam = SkillPreviewScopeParam:New({
              TargetType = subParam.targetType,
              ScopeType = subParam.scopeType,
              ScopeCenterType = subParam.scopeCenterType,
              TargetTypeParam = subParam.targetTypeParam
            })
            validScopeParam:SetScopeParamData(subParam.scopeParam)
            while not subPickFinish do
              findNextTimes = findNextTimes + 1
              if maxFindTimes < findNextTimes then
                subPickFinish = true
                break
              end
              if lastPickSuperGrid then
                local subScopeResult = self._utilScopeSvc:CalcSKillPreviewScopeResult(validScopeParam, lastPickPos, petEntity)
                local validGirdList = subScopeResult:GetAttackRange()
                local validPosIdxList = {}
                local validPosList = {}
                for _, validPos in ipairs(validGirdList) do
                  local validPosIdx = self:_Pos2Index(validPos)
                  if not invalidGridDict[validPosIdx] then
                    validPosIdxList[validPosIdx] = true
                    validPosList[#validPosList + 1] = validPos
                  end
                end
                local nextPickPos
                testPickPos = self:_YeliyaFindValidPosWithSuperGrid(petEntity, lastPickPos, validPosIdxList, tmpPickList)
                if testPickPos then
                  nextPickPos = testPickPos
                  lastPickPos = testPickPos
                  lastPickSuperGrid = true
                  table.insert(tmpPickList, nextPickPos)
                else
                  testPickPos = self:_YeliyaFindValidPosWithMaxTargetCount(petEntity, lastPickPos, validPosIdxList, tmpPickList, checkDamageSkillID)
                  if testPickPos then
                    nextPickPos = testPickPos
                    lastPickPos = testPickPos
                    lastPickSuperGrid = false
                    table.insert(tmpPickList, nextPickPos)
                  else
                    testPickPos = self:_YeliyaFindValidPosNearToMonster(petEntity, lastPickPos, validPosIdxList, validPosList, tmpPickList)
                    if testPickPos then
                      nextPickPos = testPickPos
                      lastPickPos = testPickPos
                      lastPickSuperGrid = false
                      table.insert(tmpPickList, nextPickPos)
                    end
                  end
                  subPickFinish = true
                end
              end
            end
          end
          if tmpPickList and 0 < #tmpPickList then
            pickPosList = tmpPickList
          end
        end
      end
    end
  end
  return pickPosList, retScopeResult, retTargetIds
end

function AutoFightService:_CalPickPosPolicy_PetYeliyaExtra(petEntity, activeSkillID, casterPos, validPosList, validPosIdxList)
  local boardService = self._world:GetService("BoardLogic")
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID)
  local checkDamageSkillID = 30018411
  local policyParam = skillConfigData:GetAutoFightPickPosPolicyParam()
  if policyParam and policyParam.checkDamageSkillID then
    checkDamageSkillID = tonumber(policyParam.checkDamageSkillID)
  end
  local pickPosList = {}
  local retScopeResult = {}
  local retTargetIds = {}
  local testPickPos
  local tmpPickList = {}
  testPickPos = self:_YeliyaFindValidPosWithMaxTargetCount(petEntity, casterPos, validPosIdxList, tmpPickList, checkDamageSkillID)
  if testPickPos then
    table.insert(pickPosList, testPickPos)
  else
    return {}, {}, {}
  end
  return pickPosList, retScopeResult, retTargetIds
end

function AutoFightService:_YeliyaFindValidPosWithSuperGrid(petEntity, centerPos, validPosIdxList, alreadyPickList)
  local pickPos
  local utilDataSvc = self._utilSvc
  local boardService = self._boardServiceLogic
  local ringMax = boardService:GetCurBoardRingMax()
  local centerPosIndex = self:_Pos2Index(centerPos)
  for _, off in ipairs(ringMax) do
    local posIdx = self:_PosIndexAddOffset(centerPosIndex, off)
    if validPosIdxList[posIdx] then
      local pos = self:_Index2Pos(posIdx)
      if not table.icontains(alreadyPickList, pos) then
        local isBlockedLinkLine = boardService:IsPosBlock(pos, BlockFlag.LinkLine)
        if not isBlockedLinkLine then
          local traps = utilDataSvc:GetTrapsAtPos(pos)
          if traps then
            for index, e in ipairs(traps) do
              if e:Trap():IsSuperGrid() then
                pickPos = pos
                break
              end
            end
          end
        end
      end
    end
  end
  return pickPos
end

function AutoFightService:_YeliyaFindValidPosWithMaxTargetCount(petEntity, centerPos, validPosIdxList, alreadyPickList, checkDamageSkillID)
  local pickPos
  checkDamageSkillID = 30018411
  local boardService = self._boardServiceLogic
  local ringMax = boardService:GetCurBoardRingMax()
  local centerPosIndex = self:_Pos2Index(centerPos)
  local maxTargetCount = 0
  local maxTargetPos
  for _, off in ipairs(ringMax) do
    local posIdx = self:_PosIndexAddOffset(centerPosIndex, off)
    if validPosIdxList[posIdx] then
      local pos = self:_Index2Pos(posIdx)
      if not table.icontains(alreadyPickList, pos) then
        local isBlockedLinkLine = boardService:IsPosBlock(pos, BlockFlag.LinkLine)
        if not isBlockedLinkLine then
          local result, targetIds = self:_CalcSkillScopeResultAndTargets(petEntity, checkDamageSkillID, pos)
          if targetIds then
            local targetCount = #targetIds
            if maxTargetCount < targetCount then
              maxTargetCount = targetCount
              maxTargetPos = pos
            end
          end
        end
      end
    end
  end
  if maxTargetPos then
    pickPos = maxTargetPos
  end
  return pickPos
end

function AutoFightService:_YeliyaFindValidPosNearToMonster(petEntity, centerPos, validPosIdxList, validPosList, alreadyPickList)
  local pickPos
  local buffLogicSvc = self._world:GetService("BuffLogic")
  local boardService = self._boardServiceLogic
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local validEnemyList = {}
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local enemyTeam = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
    table.insert(validEnemyList, enemyTeam)
  else
    for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
      if not monsterEntity:HasDeadMark() then
        table.insert(validEnemyList, monsterEntity)
      end
    end
  end
  if validEnemyList and 0 < #validEnemyList then
    local enemyPosList = {}
    for index, enemyEntity in ipairs(validEnemyList) do
      local enemyPos = enemyEntity:GetGridPosition()
      local tv2BodyArea = enemyEntity:BodyArea():GetArea()
      for _, v2Relative in ipairs(tv2BodyArea) do
        local v2 = enemyPos + v2Relative
        table.insert(enemyPosList, v2)
      end
    end
    local sortedEnemyPosList = HelperProxy:SortPosByCenterPosDistance(centerPos, enemyPosList)
    if sortedEnemyPosList and 0 < #sortedEnemyPosList then
      local nearestPos = sortedEnemyPosList[1]
      local sortedValidPosList = HelperProxy:SortPosByCenterPosDistance(nearestPos, validPosList)
      if sortedValidPosList then
        for index, pos in ipairs(sortedValidPosList) do
          if not table.icontains(alreadyPickList, pos) then
            local isBlockedLinkLine = boardService:IsPosBlock(pos, BlockFlag.LinkLine)
            if not isBlockedLinkLine then
              pickPos = pos
              break
            end
          end
        end
      end
    end
  end
  return pickPos
end

function AutoFightService:Handle_NotifyClientUnscaledCountDown(TT)
  local isWaitTrigger = false
  local waitTriggerCmpt
  local group = self._world:GetGroup(self._world.BW_WEMatchers.UnscaledCountDownRender)
  for i, e in ipairs(group:GetEntities()) do
    local cmpt = e:UnscaledCountDownRender()
    if cmpt:GetIsActive() and cmpt:GetIsWaitTrigger() then
      isWaitTrigger = true
      waitTriggerCmpt = cmpt
      break
    end
  end
  if not isWaitTrigger then
    return false
  end
  local flagID = waitTriggerCmpt:GetFlagID()
  local state = 1
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SyncClientUnscaledCountDownFinish, flagID, state)
  waitTriggerCmpt:SetIsWaitTrigger(false)
  waitTriggerCmpt:SetWaitPlayNotify(true)
  Log.info("autoFight UnscaledCD _CountDownFinish, flagID:", flagID)
  while GameStateID.UnscaledCountDownFinishNotify ~= self:_GetFsmStateID() do
    YIELD(TT, 100)
  end
  return true
end
