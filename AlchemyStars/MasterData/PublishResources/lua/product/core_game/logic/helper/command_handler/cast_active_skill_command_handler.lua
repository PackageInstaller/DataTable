require("command_base_handler")
_class("CastActiveSkillCommandHandler", CommandBaseHandler)
CastActiveSkillCommandHandler = CastActiveSkillCommandHandler

function CastActiveSkillCommandHandler:DoHandleCommand(cmd)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local activeSkillID = cmd:GetCmdActiveSkillID()
  local activeSkillData = BattleSkillCfg(activeSkillID)
  local battleStatCmpt = self._world:BattleStat()
  local round = battleStatCmpt:GetLevelTotalRoundCount()
  local casterPetEntityID = 0
  local cfgsvc = self._world:GetService("Config")
  local skillcfg = cfgsvc:GetSkillConfigData(activeSkillID)
  local useFeatureType
  if activeSkillData.Type == SkillType.Active then
    local petPstID = cmd:GetCmdCasterPstID()
    casterPetEntityID = self:GetEntityIDByPstID(petPstID)
    local casterPetEntity = self._world:GetEntityByID(casterPetEntityID)
    local casterPos = casterPetEntity:GridLocation().Position
    local casterDir = casterPetEntity:GridLocation().Direction
    local localSkillID = casterPetEntity:SkillInfo():GetActiveSkillID()
    local extraSkillList = casterPetEntity:SkillInfo():GetExtraActiveSkillIDList()
    if extraSkillList and table.icontains(extraSkillList, activeSkillID) then
      localSkillID = activeSkillID
    else
      local variantActiveSkillInfo = casterPetEntity:SkillInfo():GetVariantActiveSkillInfo()
      if variantActiveSkillInfo then
        local variantList = variantActiveSkillInfo[localSkillID]
        if variantList and table.icontains(variantList, activeSkillID) then
          localSkillID = activeSkillID
        end
      end
    end
    local configService = self._world:GetService("Config")
    local skillConfigData = configService:GetSkillConfigData(localSkillID, casterPetEntity)
    activeSkillID = skillConfigData:GetID()
    self:_ResetSkillGrayWatch(teamEntity, petPstID, activeSkillID)
    if not self:CheckActiveSkillCastCondition(petPstID, activeSkillID) then
      local attributeCmpt = casterPetEntity:Attributes()
      local utilData = self._world:GetService("UtilData")
      local ready = utilData:GetPetSkillReadyAttr(casterPetEntity, activeSkillID)
      local errorMsg
      if skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
        local curLegendPower = attributeCmpt:GetAttribute("LegendPower")
        errorMsg = "LegendPet ActiveSkill failed,logic LegendPower:" .. tostring(curLegendPower) .. " ReadyState:" .. tostring(ready) .. " localSkillID:" .. localSkillID
      else
        local curPower = utilData:GetPetPowerAttr(casterPetEntity, activeSkillID)
        errorMsg = " ActiveSkill failed,logic power:" .. tostring(curPower) .. " ReadyState:" .. tostring(ready) .. " localSkillID:" .. localSkillID
      end
      self:_HandleServerSyncFailed(BattleFailedType.ActiveSkillCDError, errorMsg)
      return
    end
    local utilData = self._world:GetService("UtilData")
    if utilData:IsSkillDisabledWhenCasterIsTeamLeader(petPstID, activeSkillID) then
      local teamLeaderEntityID = teamEntity:Team():GetTeamLeaderEntityID()
      if teamLeaderEntityID == casterPetEntityID then
        self:_HandleServerSyncFailed(BattleFailedType.HeboBaseActiveSkillCannotCastAsTeamLeader, "Cannot cast when caster is team leader! ")
        return
      end
    end
    local lsvcFeature = self._world:GetService("FeatureLogic")
    if lsvcFeature:HasFeatureType(FeatureType.Sanity) then
      local context = {}
      local utilScopeSvc = self._world:GetService("UtilScopeCalc")
      local scopeResult = utilScopeSvc:CalcSkillScope(skillcfg, casterPos, casterPetEntity, casterDir)
      local attackRange = scopeResult:GetAttackRange() or {}
      context.scopeGridCount = #attackRange
      if not lsvcFeature:IsActiveSkillCanCast(casterPetEntity, activeSkillID, context) then
        self:_HandleServerSyncFailed(BattleFailedType.NotEnoughSan, "not enough san")
        return
      end
      local san, hpPercent, hpConvertSan = lsvcFeature:CalcActiveSkillSanCost(casterPetEntity, activeSkillID, context)
      local curSanValue, oldSanValue, realModifyValue, debtVal, modifyTimes = lsvcFeature:DecreaseSanValue(san)
      local nt = NTSanValueChange:New(curSanValue, oldSanValue, debtVal, modifyTimes)
      self._world:GetService("Trigger"):Notify(nt)
      if self._world:RunAtClient() then
        local rsvcFeature = self._world:GetService("FeatureRender")
        rsvcFeature:NotifySanValueChange(curSanValue, oldSanValue, realModifyValue)
        GameGlobal.TaskManager():CoreGameStartTask(function(TT)
          self._world:GetService("PlayBuff"):PlayBuffView(TT, nt)
        end)
      end
      if 0 < hpPercent then
        do
          local eTeam = casterPetEntity:Pet():GetOwnerTeamEntity()
          local maxHP = eTeam:Attributes():CalcMaxHp()
          local val = maxHP * hpPercent
          local lsvcCalcDamage = self._world:GetService("CalcDamage")
          local damageInfo = lsvcCalcDamage:DoCalcDamage(casterPetEntity, eTeam, {
            formulaID = 130,
            hp = val,
            hpPercent = hpPercent,
            skillID = activeSkillID
          })
          if self._world:RunAtClient() then
            local rsvcPlayDamage = self._world:GetService("PlayDamage")
            rsvcPlayDamage:AsyncUpdateHPAndDisplayDamage(eTeam, damageInfo)
          end
        end
      end
    end
    local triggerExtraParam = skillcfg:GetSkillTriggerExtraParam()
    if triggerExtraParam and triggerExtraParam[SkillTriggerTypeExtraParam.HPValPercent] then
      local paramHPVal = triggerExtraParam[SkillTriggerTypeExtraParam.HPValPercent]
      if paramHPVal then
        local eTeam = casterPetEntity:Pet():GetOwnerTeamEntity()
        local maxHPPercent = paramHPVal[1]
        local remainHPPercent = paramHPVal[2]
        local casterCurrentHP = eTeam:Attributes():GetCurrentHP()
        local casterMaxHP = eTeam:Attributes():CalcMaxHp()
        local requiredMaxVal = math.ceil(casterMaxHP * maxHPPercent)
        local remainHP = casterCurrentHP - requiredMaxVal
        if remainHP <= 0 then
          self:_HandleServerSyncFailed(BattleFailedType.NotEnoughHP, table.concat({
            "remainHP:",
            tostring(remainHP),
            "currentHP:",
            casterCurrentHP
          }))
          return
        end
        local requiredRemainHP = math.ceil(remainHP * remainHPPercent)
        if remainHP <= requiredRemainHP then
          self:_HandleServerSyncFailed(BattleFailedType.NotEnoughHP, table.concat({
            "remainHP:",
            tostring(remainHP),
            "currentHP:",
            casterCurrentHP
          }))
          return
        end
      end
    end
    if triggerExtraParam and triggerExtraParam[SkillTriggerTypeExtraParam.CardNotFull] then
      local lsvcFeature = self._world:GetService("FeatureLogic")
      if lsvcFeature:HasFeatureType(FeatureType.Card) and not lsvcFeature:CanAddCard() then
        self:_HandleServerSyncFailed(BattleFailedType.CardFull, "card full")
        return
      end
    end
    local nt = NTBeforePetActiveSkillClearPower:New(casterPetEntity, activeSkillID)
    self._world:GetService("Trigger"):Notify(nt)
    self:_ClearActivePower(teamEntity, petPstID, activeSkillID)
    battleStatCmpt:AddActiveSkillCount(teamEntity)
    local utilData = self._world:GetService("UtilData")
    if casterPetEntity:HasBuffFlag(BuffFlags.Overdraw) == false then
      local isExtraSkill, extraSkillIndex = utilData:IsPetExtraActiveSkill(casterPetEntity, activeSkillID)
      if not isExtraSkill then
        battleStatCmpt:SetLastDoActiveSkillRound(petPstID, round)
      else
        battleStatCmpt:SetLastDoActiveSkillRound(petPstID, round, extraSkillIndex)
      end
      battleStatCmpt:SetPetDoActiveSkillRecord(petPstID, round, activeSkillID)
    end
    battleStatCmpt:RecordCurRoundDoActiveSkillTimes(petPstID)
  elseif activeSkillData.Type == SkillType.TrapSkill then
    casterPetEntityID = cmd:GetCmdCasterTrapEntityID()
    local casterPetEntity = self._world:GetEntityByID(casterPetEntityID)
    local isPetTrapOverlap = false
    local utilScopeCalc = self._world:GetService("UtilScopeCalc")
    local trapPos = casterPetEntity:GetGridPosition()
    if casterPetEntity:Trap():IsPetTrapCastSkill() and utilScopeCalc:IsPosHaveMonsterOrPet(trapPos) then
      isPetTrapOverlap = true
    end
    local attributeCmpt = casterPetEntity:Attributes()
    local curPower = attributeCmpt:GetAttribute("TrapPower")
    local count = attributeCmpt:GetAttribute("SkillCount")
    if (curPower <= 0 or count <= 0 or isPetTrapOverlap) and activeSkillData.TriggerParam ~= 0 then
      local errorMsg = "CastActiveSkillCommandHandler cast trap skill error! curPower" .. curPower .. " skillCount=" .. count
      self:_HandleServerSyncFailed(BattleFailedType.ActiveSkillCDError, errorMsg)
      return
    end
    local triggerExtraParam = skillcfg:GetSkillTriggerExtraParam()
    if triggerExtraParam and triggerExtraParam[SkillTriggerTypeExtraParam.CostFeatureStepPoint] then
      local paramStepPoint = triggerExtraParam[SkillTriggerTypeExtraParam.CostFeatureStepPoint]
      if paramStepPoint then
        local lsvcFeature = self._world:GetService("FeatureLogic")
        if lsvcFeature:HasFeatureType(FeatureType.StepPoint) then
          local curStepPoint = lsvcFeature:GetCurStepPoint()
          if paramStepPoint <= curStepPoint then
          else
            local errorMsg = "CastActiveSkillCommandHandler cast trap skill error! not enough step point,cur:" .. curStepPoint .. " need:", paramStepPoint
            self:_HandleServerSyncFailed(BattleFailedType.FeatureStepPointError, errorMsg)
            return
          end
        else
          local errorMsg = "CastActiveSkillCommandHandler cast trap skill error! no step point data"
          self:_HandleServerSyncFailed(BattleFailedType.FeatureStepPointError, errorMsg)
          return
        end
      end
    end
    local newTrapPower = curPower - activeSkillData.TriggerParam
    attributeCmpt:Modify("TrapPower", newTrapPower)
    local castSkillRound = attributeCmpt:GetAttribute("CastSkillRound")
    table.insert(castSkillRound, round)
    attributeCmpt:Modify("CastSkillRound", castSkillRound)
    local skillCount = attributeCmpt:GetAttribute("SkillCount")
    skillCount = skillCount - 1
    if skillCount <= 0 then
      skillCount = 0
    end
    attributeCmpt:Modify("SkillCount", skillCount)
  elseif activeSkillData.Type == SkillType.FeatureSkill then
    local bCanCast = false
    useFeatureType = FeatureType.PersonaSkill
    local lsvcFeature = self._world:GetService("FeatureLogic")
    if lsvcFeature then
      local triggerExtraParam = skillcfg:GetSkillTriggerExtraParam()
      if triggerExtraParam and triggerExtraParam[SkillTriggerTypeExtraParam.FeatureType] then
        useFeatureType = triggerExtraParam[SkillTriggerTypeExtraParam.FeatureType]
      end
      if lsvcFeature:CheckFeatureSkillCastCondition(useFeatureType, activeSkillID) then
        lsvcFeature:OnFeatureSkillCast(useFeatureType, activeSkillID)
        bCanCast = true
        casterPetEntityID = lsvcFeature:GetFeatureSkillHolderEntityID(useFeatureType)
      end
    end
    if not bCanCast then
      self:_HandleServerSyncFailed(BattleFailedType.ActiveSkillCDError, "persona skill cd error")
      return
    end
  end
  self._world:GetDataLogger():AddDataLog("OnLinkEnd")
  self._world:GetDataLogger():AddDataLog("OnShowStart")
  if activeSkillData.Type == SkillType.FeatureSkill then
    local featureSkillCmpt = teamEntity:FeatureSkill()
    featureSkillCmpt:SetFeatureSkillID(useFeatureType, activeSkillID, casterPetEntityID)
    if self._world:RunAtClient() and self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn then
      if skillcfg:GetSkillPickType() == SkillPickUpType.FeatureSkipPreview then
        self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 11)
      else
        self._world:EventDispatcher():Dispatch(GameEventType.PreviewActiveSkillFinish, 4)
      end
    else
      self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 11)
    end
  else
    local activeSkillCmpt = teamEntity:ActiveSkill()
    activeSkillCmpt:SetActiveSkillID(activeSkillID, casterPetEntityID)
    if self._world:RunAtClient() and self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn then
      self._world:EventDispatcher():Dispatch(GameEventType.PreviewActiveSkillFinish, 2)
    else
      self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 2)
    end
  end
end
