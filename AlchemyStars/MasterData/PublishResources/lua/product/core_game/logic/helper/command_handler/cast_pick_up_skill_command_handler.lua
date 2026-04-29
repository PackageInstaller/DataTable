require("command_base_handler")
_class("CastPickUpSkillCommandHandler", CommandBaseHandler)
CastPickUpSkillCommandHandler = CastPickUpSkillCommandHandler

function CastPickUpSkillCommandHandler:DoHandleCommand(cmd)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local activeSkillID = cmd:GetCmdActiveSkillID()
  local activeSkillData = BattleSkillCfg(activeSkillID)
  local petPstID = cmd:GetCmdCasterPstID()
  local casterPetEntity, casterPos, casterDir
  if petPstID and 0 < petPstID then
    casterPetEntity = teamEntity:Team():GetPetEntityByPetPstID(petPstID)
    casterPos = casterPetEntity:GridLocation().Position
    casterDir = casterPetEntity:GridLocation().Direction
  end
  local pickUpGridList = cmd:GetCmdPickUpResult()
  local battleStatCmpt = self._world:BattleStat()
  local round = battleStatCmpt:GetLevelTotalRoundCount()
  local cfgsvc = self._world:GetService("Config")
  local skillcfg = cfgsvc:GetSkillConfigData(activeSkillID, casterPetEntity)
  if activeSkillData.Type == SkillType.Active then
    local castPetEntity = self:GetEntityByPstID(petPstID)
    if self:CheckActiveSkillCastCondition(petPstID, activeSkillID) and self:CheckPickUpValid(castPetEntity, activeSkillID, cmd) then
      local activeSkillPickUpComponent = castPetEntity:ActiveSkillPickUpComponent()
      if not activeSkillPickUpComponent then
        castPetEntity:AddActiveSkillPickUpComponent()
        activeSkillPickUpComponent = castPetEntity:ActiveSkillPickUpComponent()
      end
      activeSkillPickUpComponent:ClearGridPos()
      activeSkillPickUpComponent:AddGridPosList(pickUpGridList)
      activeSkillPickUpComponent:AddDirectionList(cmd:GetDirectionPickupData())
      activeSkillPickUpComponent:SetReflectDir(cmd:GetReflectDir())
      activeSkillPickUpComponent:AddPickExtraParamList(cmd:GetCmdPickUpExtraParamResult())
      activeSkillPickUpComponent:SetPickUpPetPstID(cmd:GetPickUpPetPstID())
      local lsvcFeature = self._world:GetService("FeatureLogic")
      if lsvcFeature:HasFeatureType(FeatureType.TetrisGame) and cmd:GetPickUpTetrisDirIndex() then
        lsvcFeature:SetTetrisDirIndex(cmd:GetPickUpTetrisDirIndex())
      end
      self:_ResetSkillGrayWatch(teamEntity, petPstID, activeSkillID)
      self:_ClearActivePower(teamEntity, petPstID, activeSkillID)
      battleStatCmpt:AddActiveSkillCount(teamEntity)
      local utilData = self._world:GetService("UtilData")
      local isExtraSkill, extraSkillIndex = utilData:IsPetExtraActiveSkill(castPetEntity, activeSkillID)
      if not isExtraSkill then
        battleStatCmpt:SetLastDoActiveSkillRound(petPstID, round)
      else
        battleStatCmpt:SetLastDoActiveSkillRound(petPstID, round, extraSkillIndex)
      end
      battleStatCmpt:SetPetDoActiveSkillRecord(petPstID, round, activeSkillID)
      self._world:GetDataLogger():AddDataLog("OnLinkEnd")
      self._world:GetDataLogger():AddDataLog("OnShowStart")
      local casterPetEntityID = castPetEntity:GetID()
      local activeSkillCmpt = teamEntity:ActiveSkill()
      activeSkillCmpt:SetActiveSkillID(activeSkillID, casterPetEntityID)
      local logicPickUpCmpt = teamEntity:LogicPickUp()
      logicPickUpCmpt:SetLogicCurActiveSkillInfo(activeSkillID, castPetEntity:PetPstID():GetPstID())
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
      if triggerExtraParam and triggerExtraParam[SkillTriggerTypeExtraParam.Pet1702361InTeam] and not castPetEntity:BuffComponent():HasFlag(BuffFlags.Pet1702361NotLinkLine) then
        self:_HandleServerSyncFailed(BattleFailedType.Pet1702361InTeam, "Pet1702361InTeam")
        return
      end
      battleStatCmpt:RecordCurRoundDoActiveSkillTimes(petPstID)
      local svc = self._world:GetService("L2R")
      svc:L2RPickUpComponentData(castPetEntity:GetID(), pickUpGridList, cmd:GetDirectionPickupData(), cmd:GetReflectDir(), cmd:GetCmdPickUpExtraParamResult())
      if self._world:RunAtClient() and self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn then
        self._world:EventDispatcher():Dispatch(GameEventType.PickUpActiveSkillTargetFinish, 2)
      else
        self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 2)
      end
    else
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
      local utilData = self._world:GetService("UtilData")
      local ready = utilData:GetPetSkillReadyAttr(casterPetEntity, activeSkillID)
      local configService = self._world:GetService("Config")
      local skillConfigData = configService:GetSkillConfigData(localSkillID)
      local errorMsg
      if skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
        local legendPower = castPetEntity:Attributes():GetAttribute("LegendPower")
        errorMsg = "LegendPet CastPickUpSkill failed,logic legendPower:" .. tostring(legendPower) .. " ReadyState:" .. tostring(ready) .. " localSkillID:" .. localSkillID
      else
        local power = utilData:GetPetPowerAttr(casterPetEntity, activeSkillID)
        errorMsg = " CastPickUpSkill failed,logic power: " .. tostring(power) .. " ReadyState:" .. tostring(ready) .. " localSkillID:" .. localSkillID
      end
      self:_HandleServerSyncFailed(BattleFailedType.ActiveSkillCDError, errorMsg)
    end
  elseif activeSkillData.Type == SkillType.TrapSkill then
    local casterTrapEntityID = cmd:GetCmdCasterTrapEntityID()
    local casterTrapEntity = self._world:GetEntityByID(casterTrapEntityID)
    local activeSkillPickUpComponent = casterTrapEntity:ActiveSkillPickUpComponent()
    if not activeSkillPickUpComponent then
      casterTrapEntity:AddActiveSkillPickUpComponent()
      activeSkillPickUpComponent = casterTrapEntity:ActiveSkillPickUpComponent()
    end
    activeSkillPickUpComponent:ClearGridPos()
    activeSkillPickUpComponent:AddGridPosList(pickUpGridList)
    activeSkillPickUpComponent:AddDirectionList(cmd:GetDirectionPickupData())
    activeSkillPickUpComponent:SetReflectDir(cmd:GetReflectDir())
    local attributeCmpt = casterTrapEntity:Attributes()
    local curPower = attributeCmpt:GetAttribute("TrapPower")
    local count = attributeCmpt:GetAttribute("SkillCount")
    if (curPower <= 0 or count <= 0) and activeSkillData.TriggerParam ~= 0 then
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
    self._world:GetDataLogger():AddDataLog("OnLinkEnd")
    self._world:GetDataLogger():AddDataLog("OnShowStart")
    local activeSkillCmpt = teamEntity:ActiveSkill()
    activeSkillCmpt:SetActiveSkillID(activeSkillID, casterTrapEntityID)
    local logicPickUpCmpt = teamEntity:LogicPickUp()
    logicPickUpCmpt:SetLogicCurActiveSkillInfo(activeSkillID, -1)
    logicPickUpCmpt:SetEntityID(casterTrapEntityID)
    local svc = self._world:GetService("L2R")
    svc:L2RPickUpComponentData(casterTrapEntityID, pickUpGridList, cmd:GetDirectionPickupData(), cmd:GetReflectDir(), cmd:GetCmdPickUpExtraParamResult())
    if self._world:RunAtClient() and self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn then
      self._world:EventDispatcher():Dispatch(GameEventType.PickUpActiveSkillTargetFinish, 2)
    else
      self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 2)
    end
  elseif activeSkillData.Type == SkillType.FeatureSkill then
    local bCanCast = false
    local useFeatureType = FeatureType.PersonaSkill
    local lsvcFeature = self._world:GetService("FeatureLogic")
    if lsvcFeature then
      local triggerExtraParam = skillcfg:GetSkillTriggerExtraParam()
      if triggerExtraParam and triggerExtraParam[SkillTriggerTypeExtraParam.FeatureType] then
        useFeatureType = triggerExtraParam[SkillTriggerTypeExtraParam.FeatureType]
      end
      if lsvcFeature:CheckFeatureSkillCastCondition(useFeatureType, activeSkillID) then
        lsvcFeature:OnFeatureSkillCast(useFeatureType, activeSkillID)
        bCanCast = true
      end
    end
    if not bCanCast then
      self:_HandleServerSyncFailed(BattleFailedType.ActiveSkillCDError, "persona skill cd error")
      return
    end
    local casterEntity = lsvcFeature:GetFeatureSkillHolderEntity(useFeatureType)
    local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
    if not activeSkillPickUpComponent then
      casterEntity:AddActiveSkillPickUpComponent()
      activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
    end
    activeSkillPickUpComponent:ClearGridPos()
    activeSkillPickUpComponent:AddGridPosList(pickUpGridList)
    activeSkillPickUpComponent:AddDirectionList(cmd:GetDirectionPickupData())
    activeSkillPickUpComponent:SetReflectDir(cmd:GetReflectDir())
    activeSkillPickUpComponent:AddPickExtraParamList(cmd:GetCmdPickUpExtraParamResult())
    self._world:GetDataLogger():AddDataLog("OnLinkEnd")
    self._world:GetDataLogger():AddDataLog("OnShowStart")
    local casterEntityID = casterEntity:GetID()
    local featureSkillCmpt = teamEntity:FeatureSkill()
    featureSkillCmpt:SetFeatureSkillID(useFeatureType, activeSkillID, casterEntityID)
    local logicPickUpCmpt = teamEntity:LogicPickUp()
    local pstid = -1
    logicPickUpCmpt:SetLogicCurActiveSkillInfo(activeSkillID, pstid)
    logicPickUpCmpt:SetEntityID(casterEntityID)
    local svc = self._world:GetService("L2R")
    svc:L2RPickUpComponentData(casterEntityID, pickUpGridList, cmd:GetDirectionPickupData(), cmd:GetReflectDir(), cmd:GetCmdPickUpExtraParamResult())
    if self._world:RunAtClient() and self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn then
      self._world:EventDispatcher():Dispatch(GameEventType.PickUpActiveSkillTargetFinish, 4)
    elseif self._world:MatchType() == MatchType.MT_PopStar then
      self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 4)
    else
      self._world:EventDispatcher():Dispatch(GameEventType.WaitInputFinish, 11)
    end
  end
end
