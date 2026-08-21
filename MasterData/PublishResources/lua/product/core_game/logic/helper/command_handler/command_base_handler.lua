_class("CommandBaseHandler", Object)
CommandBaseHandler = CommandBaseHandler

function CommandBaseHandler:Constructor(world)
  self._cmdOwnerEntity = nil
  self._world = world
end

function CommandBaseHandler:SetCommandOwner(owner)
  self._cmdOwnerEntity = owner
  self._world = owner:GetOwnerWorld()
end

function CommandBaseHandler:DoHandleCommand(cmd)
end

function CommandBaseHandler:_HandleServerSyncFailed(failedType, failedMsg)
  Log.fatal("[SyncLog],type:", failedType, " info:", failedMsg)
  if self._world:RunAtServer() then
    local serverWorld = self._world
    serverWorld:HandleSyncFailed(failedType, failedMsg)
  end
end

function CommandBaseHandler:_ResetSkillGrayWatch(teamEntity, castSkillPetPstID, castSkillID)
  local battleStatComponent = self._world:BattleStat()
  local curRound = battleStatComponent:GetLevelTotalRoundCount()
  local teamMembers = teamEntity:Team():GetTeamPetEntities()
  for _, e in ipairs(teamMembers) do
    local petPstIDCmpt = e:PetPstID()
    local pstID = petPstIDCmpt:GetPstID()
    if pstID == castSkillPetPstID then
      local buffComponent = e:BuffComponent()
      local keyStr = "HadSaveSkillGrayWatch" .. "_Round_" .. tostring(curRound) .. "_Skill_" .. tostring(castSkillID)
      local hadSaveSkillGrayWatch = buffComponent:GetBuffValue(keyStr)
      if hadSaveSkillGrayWatch then
        buffComponent:SetBuffValue(keyStr, nil)
      end
    end
  end
end

function CommandBaseHandler:_ClearActivePower(teamEntity, castSkillPetPstID, castSkillID, chainPath)
  local utilData = self._world:GetService("UtilData")
  local teamMembers = teamEntity:Team():GetTeamPetEntities()
  for _, e in ipairs(teamMembers) do
    local petPstIDCmpt = e:PetPstID()
    local pstID = petPstIDCmpt:GetPstID()
    if pstID == castSkillPetPstID then
      local attributeCmpt = e:Attributes()
      local bHasVariantSkill = false
      local localSkillID = e:SkillInfo():GetActiveSkillID()
      local extraSkillList = e:SkillInfo():GetExtraActiveSkillIDList()
      if extraSkillList and table.icontains(extraSkillList, castSkillID) then
        localSkillID = castSkillID
      else
        local variantActiveSkillInfo = e:SkillInfo():GetVariantActiveSkillInfo()
        if variantActiveSkillInfo then
          bHasVariantSkill = true
          local variantList = variantActiveSkillInfo[localSkillID]
          if variantList and table.icontains(variantList, castSkillID) then
            localSkillID = castSkillID
          end
        end
      end
      local configService = self._world:GetService("Config")
      local skillConfigData = configService:GetSkillConfigData(localSkillID, e)
      if skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
        local legendPower = attributeCmpt:GetAttribute("LegendPower")
        local costLegendPower = skillConfigData:GetSkillTriggerParam()
        local cfgCostLegendPower = costLegendPower
        local zhongxuForceMoveStep = 0
        costLegendPower, zhongxuForceMoveStep = self:_GetLegendPowerConstByExtraParam(costLegendPower, skillConfigData, castSkillPetPstID, chainPath)
        cfgCostLegendPower = utilData:CalcMinCostLegendPowerByExtraParam(e, cfgCostLegendPower, skillConfigData, zhongxuForceMoveStep, false)
        local cSkillInfo = e:SkillInfo()
        if cSkillInfo:IsActiveSkillEnergyCount() then
          local cBuff = e:BuffComponent()
          local activeSkillRecord = cBuff:GetBuffValue("ActiveSkillEnergyCostCountByRound") or {}
          local currentRoundCount = self._world:BattleStat():GetLevelTotalRoundCount()
          if not activeSkillRecord[currentRoundCount] then
            activeSkillRecord[currentRoundCount] = cfgCostLegendPower
          else
            activeSkillRecord[currentRoundCount] = activeSkillRecord[currentRoundCount] + cfgCostLegendPower
          end
          cBuff:SetBuffValue("ActiveSkillEnergyCostCountByRound", activeSkillRecord)
        end
        legendPower = legendPower - costLegendPower
        if cfgCostLegendPower > legendPower then
          if legendPower < 0 then
            legendPower = 0
          end
          local blsvc = self._world:GetService("BuffLogic")
          blsvc:ChangePetActiveSkillReady(e, 0, localSkillID)
        end
        self:_CheckMultiLegengPowerSkillReadyOnClearPower(e, legendPower, localSkillID)
        attributeCmpt:Modify("LegendPower", legendPower)
      elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.BuffLayer then
        local costLayer = skillConfigData:GetSkillTriggerParam()
        local extraParam = skillConfigData:GetSkillTriggerExtraParam()
        local buffEffectType = extraParam.buffEffectType
        local blsvc = self._world:GetService("BuffLogic")
        local currentVal = blsvc:GetBuffLayer(e, buffEffectType)
        local finalVal = math.max(currentVal - costLayer, 0)
        blsvc:SetBuffLayer(e, buffEffectType, finalVal, true)
        local blsvc = self._world:GetService("BuffLogic")
        local variantActiveSkillInfo = e:SkillInfo():GetVariantActiveSkillInfo()
        if variantActiveSkillInfo then
          local sourceActiveSkillID = e:SkillInfo():GetActiveSkillID()
          bHasVariantSkill = true
          local variantList = table.clone(variantActiveSkillInfo[sourceActiveSkillID])
          table.insert(variantList, sourceActiveSkillID)
          for i, skillID in ipairs(variantList) do
            local variantSkillConfigData = configService:GetSkillConfigData(skillID, e)
            local variantExtraParam = variantSkillConfigData:GetSkillTriggerExtraParam()
            local variantCostLayer = variantSkillConfigData:GetSkillTriggerParam()
            if variantExtraParam.buffEffectType == buffEffectType and finalVal < variantCostLayer then
              blsvc:ChangePetActiveSkillReady(e, 0, skillID)
              if self._world:RunAtClient() then
                self._world:EventDispatcher():Dispatch(GameEventType.PetActiveSkillCancelReady, pstID, false)
              end
            end
          end
        end
      elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.AlchemyEnergy then
        local alchemyPower = attributeCmpt:GetAttribute("AlchemyPower")
        local costLegendPower = skillConfigData:GetSkillTriggerParam()
        local cfgCostLegendPower = costLegendPower
        alchemyPower = alchemyPower - costLegendPower
        if cfgCostLegendPower > alchemyPower and alchemyPower < 0 then
          alchemyPower = 0
        end
        local utilCalcSvc = self._world:GetService("UtilCalc")
        utilCalcSvc:ChangeAlchemyPower(e, alchemyPower, false)
      elseif skillConfigData:GetSkillTriggerType() == SkillTriggerType.ColorPalette then
        local colorPaletteComponent = e:ColorPalette()
        if colorPaletteComponent then
          colorPaletteComponent:Clear()
        end
        local configService = self._world:GetService("Config")
        local utilData = self._world:GetService("UtilData")
        local extraSkillList = e:SkillInfo():GetExtraActiveSkillIDList()
        if extraSkillList then
          for _, extraSkillID in ipairs(extraSkillList) do
            local extraSkillConfigData = configService:GetSkillConfigData(extraSkillID)
            if extraSkillConfigData and extraSkillConfigData:GetSkillTriggerType() == SkillTriggerType.ColorPalette then
              utilData:SetPetSkillReadyAttr(e, 0, extraSkillID)
            end
          end
        end
        local svc = self._world:GetService("L2R")
        svc:L2RSyncColorPaletteData(e:GetID())
      else
        self._world:GetSyncLogger():Trace({
          key = "_ClearActivePower",
          casterPstID = pstID
        })
        if bHasVariantSkill then
          local cfgMaxPower = skillConfigData:GetSkillTriggerParam()
          utilData:SetPetMaxPowerAttr(e, cfgMaxPower, localSkillID)
        end
        local maxPower = utilData:GetPetMaxPowerAttr(e, localSkillID)
        if e:HasBuffFlag(BuffFlags.Overdraw) then
          local curPower = attributeCmpt:GetAttribute("Power")
          maxPower = curPower
        end
        utilData:SetPetPowerAttr(e, maxPower, localSkillID)
        local blsvc = self._world:GetService("BuffLogic")
        blsvc:ChangePetActiveSkillReady(e, 0, localSkillID)
      end
      teamEntity:ActiveSkill():ClearPowerfullRoundCount(e:GetID())
      teamEntity:ActiveSkill():ClearPreviousReadyRoundCount(e:GetID())
    else
    end
  end
end

function CommandBaseHandler:_GetLegendPowerConstByExtraParam(defaultCost, skillConfigData, castSkillPetPstID, chainPath)
  local cost = defaultCost
  local step = 0
  local castPetEntity = self:GetEntityByPstID(castSkillPetPstID)
  Log.fatal("CommandBaseHandler:_GetLegendPowerConstByExtraParam")
  if castPetEntity and skillConfigData then
    local cfgExtraParam = skillConfigData:GetSkillTriggerExtraParam()
    local pickCmpt = castPetEntity:ActiveSkillPickUpComponent()
    local utilData = self._world:GetService("UtilData")
    if cfgExtraParam then
      for k, v in pairs(cfgExtraParam) do
        Log.fatal("Key=", k, " Value:", v)
      end
      if pickCmpt then
        if cfgExtraParam[SkillTriggerTypeExtraParam.PickPosNoCfgTrap] then
          if pickCmpt:HasPickExtraParam(SkillTriggerTypeExtraParam.PickPosNoCfgTrap) then
            cost = cfgExtraParam[SkillTriggerTypeExtraParam.PickPosNoCfgTrap]
          end
        elseif cfgExtraParam[SkillTriggerTypeExtraParam.CostByForceMoveStep] then
          cost, step = utilData:CalcZhongxuForceMovementCostByPick(castPetEntity, skillConfigData:GetID())
          if cost < 0 then
            cost = defaultCost
          end
          if step < 0 then
            step = 0
          end
        elseif cfgExtraParam[SkillTriggerTypeExtraParam.CostPickUpUIAndTrap] then
          cost = utilData:GetCasterPickUpExtraChainPowerCount(castPetEntity, skillConfigData:GetID())
        end
      end
      if cfgExtraParam[SkillTriggerTypeExtraParam.Pet1702361LinkLinePerPower] then
        local perPower = utilData:GetPet1702361LinkLinePerPower(castPetEntity, skillConfigData:GetID())
        cost = perPower * (table.count(chainPath) - 1)
        Log.info("ChainPathCount = :", #chainPath, " = ", table.count(chainPath), "Cost:", cost)
      end
    end
  end
  return cost, step
end

function CommandBaseHandler:GetEntityIDByPstID(checkPstID)
  local casterPetEntityID = -1
  local petPstIDGroup = self._world:GetGroup(self._world.BW_WEMatchers.PetPstID)
  for i, e in ipairs(petPstIDGroup:GetEntities()) do
    local petPstIDCmpt = e:PetPstID()
    local pstID = petPstIDCmpt:GetPstID()
    if pstID == checkPstID then
      casterPetEntityID = e:GetID()
    end
  end
  return casterPetEntityID
end

function CommandBaseHandler:GetEntityByPstID(checkPstID)
  local utilData = self._world:GetService("UtilData")
  return utilData:GetEntityByPstID(checkPstID)
end

function CommandBaseHandler:CheckActiveSkillCastCondition(petPstID, skillID)
  local utilData = self._world:GetService("UtilData")
  return utilData:CheckActiveSkillCastCondition(petPstID, skillID)
end

function CommandBaseHandler:CheckDirectionPickUpValid(petEntity, activeSkillID, cmd)
  local directionPickupPos, pickUpDirection, lastPickUpDirection = cmd:GetDirectionPickupData()
  if table.count(directionPickupPos) ~= table.count(pickUpDirection) then
    Log.fatal("CheckPickUpDirection Failed table.count(directionPickupPos):", table.count(directionPickupPos), "~= table.count(pickUpDirection):", table.count(pickUpDirection), "SkillID:", activeSkillID)
    return false
  end
  local posList = {}
  for direction, pos in pairs(directionPickupPos) do
    if not self:CheckDirection(direction) then
      Log.fatal("CheckPickUpDirection Failed DirectionType:", direction, " Invalid", "SkillID:", activeSkillID)
      return false
    end
    table.insert(posList, pos)
  end
  if not self:CheckPickUpGridValid(petEntity, activeSkillID, posList) then
    Log.fatal("CheckPickUpDirection Failed Pos Invalid ", "SkillID:", activeSkillID)
    return false
  end
  return true
end

function CommandBaseHandler:CheckAkexiyaPickUpValid(petEntity, activeSkillID, cmd)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  local mustPickUpNum
  if skillConfigData._pickUpParam[2] then
    mustPickUpNum = tonumber(skillConfigData._pickUpParam[2])
  end
  if skillConfigData._pickUpParam[2] then
    mustPickUpNum = tonumber(skillConfigData._pickUpParam[2])
  end
  local pickUpGridList = cmd:GetCmdPickUpResult()
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  if pickUpNum < #pickUpGridList then
    Log.fatal("#pickUpGridList> pickUpNum PickUpNum:", pickUpNum, "PickUpGridListCount:", #pickUpGridList, "SkillID:", activeSkillID)
    return false
  end
  if mustPickUpNum and #pickUpGridList ~= mustPickUpNum then
    Log.fatal("#pickUpGridList ~= mustPickUpNum MustPickUpNum:", mustPickUpNum, "PickUpGridListCount:", #pickUpGridList, "SkillID:", activeSkillID)
    return false
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local firstPickupPos = pickUpGridList[1]
  local firstPickUpValidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.firstPickValidScopeList or {})
  local firstPickUpInvalidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.firstPickInvalidScopeList or {})
  local validGridList = utilScopeSvc:BuildScopeGridList(firstPickUpValidScopeList, petEntity) or {}
  local invalidGridList = utilScopeSvc:BuildScopeGridList(firstPickUpInvalidScopeList, petEntity) or {}
  if not table.Vector2Include(validGridList, firstPickupPos) then
    Log.fatal("Pos is not in ValidGridList Pos:", tostring(firstPickupPos), "SkillID:", "SkillID:", activeSkillID)
    return false
  end
  if table.Vector2Include(invalidGridList, firstPickupPos) then
    Log.fatal("Pos is  in InValidGridList Pos:", tostring(firstPickupPos), "SkillID:", "SkillID:", activeSkillID)
    return false
  end
  if self._world:RunAtServer() then
    local previewPickUpComponent = petEntity:PreviewPickUpComponent()
    if not previewPickUpComponent then
      petEntity:AddPreviewPickUpComponent()
      previewPickUpComponent = petEntity:PreviewPickUpComponent()
    end
    previewPickUpComponent:AddGridPos(firstPickupPos)
  end
  local utilData = self._world:GetService("UtilData")
  local pickUpValidScopeList = {}
  local pickUpInvalidScopeList = {}
  local firstPickMonster = utilData:GetMonsterAtPos(firstPickupPos)
  local trapID = 0
  if skillConfigData._pickUpParam[5] then
    trapID = tonumber(skillConfigData._pickUpParam[5])
  end
  local isPickTrap = false
  local pickHasMonster = false
  if trapID and trapID ~= 0 then
    local tTrapEntities = utilData:GetTrapsAtPos(firstPickupPos)
    for _, e in ipairs(tTrapEntities) do
      if e:TrapID():GetTrapID() == trapID then
        isPickTrap = true
        break
      end
    end
  end
  if isPickTrap then
    pickUpValidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.trapPickValidScopeList or {})
    pickUpInvalidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.trapPickInvalidScopeList or {})
  else
    pickUpValidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.monsterPickValidScopeList or {})
    pickUpInvalidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.monsterPickInvalidScopeList or {})
  end
  local secondValidGridList = utilScopeSvc:BuildScopeGridList(pickUpValidScopeList, petEntity) or {}
  local secondInvalidGridList = utilScopeSvc:BuildScopeGridList(pickUpInvalidScopeList, petEntity) or {}
  for index, v2 in ipairs(secondValidGridList) do
    Log.error("pos index ", index, "v2=", tostring(v2))
  end
  local secondPickupPos = pickUpGridList[2]
  if not table.Vector2Include(secondValidGridList, secondPickupPos) then
    Log.fatal("second Pos is not in ValidGridList Pos:", tostring(secondPickupPos), "SkillID:", "SkillID:", activeSkillID)
    return false
  end
  if table.Vector2Include(secondInvalidGridList, secondPickupPos) then
    Log.fatal("second Pos is  in InValidGridList Pos:", tostring(secondPickupPos), "SkillID:", "SkillID:", activeSkillID)
    return false
  end
  return true
end

function CommandBaseHandler:CheckPickUpValid(petEntity, activeSkillID, cmd)
  local skillLogicService = self._world:GetService("SkillLogic")
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  local activeSkillPickUpType = skillConfigData:GetSkillPickType()
  if activeSkillPickUpType == SkillPickUpType.DirectionInstruction and not self:CheckDirectionPickUpValid(petEntity, activeSkillID, cmd) then
    return false
  end
  if activeSkillPickUpType == SkillPickUpType.Akexiya then
    return self:CheckAkexiyaPickUpValid(petEntity, activeSkillID, cmd)
  end
  if activeSkillPickUpType == SkillPickUpType.Yeliya then
    return self:CheckYeliyaPickUpValid(petEntity, activeSkillID, cmd)
  end
  if activeSkillPickUpType == SkillPickUpType.PickAndTeleportInst then
    if not self:CheckPickUpAndTelValid(petEntity, activeSkillID, cmd) then
      return false
    end
    return true
  elseif activeSkillPickUpType == SkillPickUpType.LinkLine then
    return self:CheckPickUpLinkLineValid(petEntity, activeSkillID, cmd)
  elseif activeSkillPickUpType == SkillPickUpType.Puzzle then
    return self:CheckPickUpPuzzleValid(petEntity, activeSkillID, cmd)
  elseif activeSkillPickUpType == SkillPickUpType.PickUpUIAndTrap then
    return self:CheckPickUpUIAndTrap(petEntity, activeSkillID, cmd)
  elseif activeSkillPickUpType == SkillPickUpType.AlGorePickUp then
    return self:CheckAlGorePickUp(petEntity, activeSkillID, cmd)
  elseif activeSkillPickUpType == SkillPickUpType.LinkLineSP then
    return self:CheckPickUpLinkLineValid(petEntity, activeSkillID, cmd)
  elseif activeSkillPickUpType == SkillPickUpType.Moye then
    return self:CheckPickUpMoyeValid(petEntity, activeSkillID, cmd)
  else
    local pickUpGridList = cmd:GetCmdPickUpResult()
    return self:CheckPickUpGridValid(petEntity, activeSkillID, pickUpGridList)
  end
end

function CommandBaseHandler:CheckPickUpAndTelValid(petEntity, activeSkillID, cmd)
  local buffLogicService = self._world:GetService("BuffLogic")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local utilDataSvc = self._world:GetService("UtilData")
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local activeSkillPickUpType = skillConfigData:GetSkillPickType()
  local validGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
  local skillScopeGridList = utilScopeSvc:CalcSkillResultByConfigData(skillConfigData, petEntity)
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  local telPickIndex = tonumber(skillConfigData._pickUpParam[2])
  local monsterPosList = {}
  local pickUpGridList = cmd:GetCmdPickUpResult()
  if not pickUpGridList or #validGridList == 0 or #skillScopeGridList == 0 then
    Log.fatal("pickUpGridList is Nil SkillID:", "SkillID:", activeSkillID)
    return false
  elseif #pickUpGridList == 0 then
    Log.fatal("pickUpGridList is Empty SkillID:", "SkillID:", activeSkillID)
    return false
  elseif 0 < #pickUpGridList then
    local monsterPos = pickUpGridList[1]
    if not table.Vector2Include(validGridList, monsterPos) then
      Log.fatal("Pos is not in ValidGridList Pos:", tostring(monsterPos), "SkillID:", "SkillID:", activeSkillID)
      return false
    end
    local monsterEntity = utilDataSvc:GetMonsterAtPos(monsterPos)
    if not monsterEntity then
      Log.fatal("Pos is not Monster in Pos:", tostring(monsterPos), "SkillID:", "SkillID:", activeSkillID)
      return false
    end
    if 1 < #pickUpGridList then
      local newPos = pickUpGridList[2]
      local areaCmpt = monsterEntity:BodyArea()
      if not buffLogicService:CheckCanBeHitBack(monsterEntity) or #areaCmpt:GetArea() ~= 1 then
        Log.fatal("Monster can't HitBack Pos :", tostring(monsterPos), "BodyAreaCount:", #areaCmpt:GetArea(), "SkillID:", "SkillID:", activeSkillID)
        return false
      end
      if not table.Vector2Include(skillScopeGridList, newPos) then
        Log.fatal("MonsterNewPos is not in SkillScopeList Pos:", tostring(newPos), "SkillID:", "SkillID:", activeSkillID)
        return false
      end
      if not utilDataSvc:IsMonsterCanTel2TargetPos(monsterEntity, newPos) then
        Log.fatal("MonsterNewPos  is invalid Pos:", tostring(newPos), "SkillID:", "SkillID:", activeSkillID)
      end
    end
  end
  return true
end

function CommandBaseHandler:CheckPickUpGridValid(petEntity, activeSkillID, pickUpGridList)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  local validGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
  local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  local mustPickUpNum
  if skillConfigData._pickUpParam[2] then
    mustPickUpNum = tonumber(skillConfigData._pickUpParam[2])
  end
  if pickUpNum < #pickUpGridList then
    Log.fatal("#pickUpGridList> pickUpNum PickUpNum:", pickUpNum, "PickUpGridListCount:", #pickUpGridList, "SkillID:", activeSkillID)
    return false
  end
  if mustPickUpNum and #pickUpGridList ~= mustPickUpNum then
    Log.fatal("#pickUpGridList ~= mustPickUpNum MustPickUpNum:", mustPickUpNum, "PickUpGridListCount:", #pickUpGridList, "SkillID:", activeSkillID)
    return false
  end
  for _, pos in ipairs(pickUpGridList) do
    if not validGridList and not table.Vector2Include(validGridList, pos) then
      Log.fatal("Pos is not in ValidGridList Pos:", tostring(pos), "SkillID:", "SkillID:", activeSkillID)
      return false
    end
    if not invalidGridList and table.Vector2Include(invalidGridList, pos) then
      Log.fatal("Pos is  in InValidGridList Pos:", tostring(pos), "SkillID:", "SkillID:", activeSkillID)
      return false
    end
  end
  return true
end

function CommandBaseHandler:CheckYeliyaPickUpValid(petEntity, activeSkillID, cmd)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  local validGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
  local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
  local pickUpGridList = cmd:GetCmdPickUpResult()
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  local mustPickUpNum
  if skillConfigData._pickUpParam[2] then
    mustPickUpNum = tonumber(skillConfigData._pickUpParam[2])
  end
  if mustPickUpNum and mustPickUpNum > #pickUpGridList then
    Log.fatal("#pickUpGridList < mustPickUpNum MustPickUpNum:", mustPickUpNum, "PickUpGridListCount:", #pickUpGridList, "SkillID:", activeSkillID)
    return false
  end
  return true
end

function CommandBaseHandler:CheckPickUpLinkLineValid(petEntity, activeSkillID, cmd)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  local pickUpGridList = cmd:GetCmdPickUpResult()
  if #pickUpGridList < 2 then
    Log.fatal("PickCount < MustPickNum! MustNum: 2, PickCount:", #pickUpGridList, ", SkillID:", activeSkillID)
    return false
  end
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  local canLinkMonster = false
  if skillConfigData._pickUpParam[2] then
    canLinkMonster = tonumber(skillConfigData._pickUpParam[2]) == 1
  end
  local needSubCount = 1
  local endPos = pickUpGridList[#pickUpGridList]
  local utilDataSvc = self._world:GetService("UtilData")
  if utilDataSvc:GetMonsterAtPos(endPos) then
    needSubCount = needSubCount + 1
  end
  local linkCount = #pickUpGridList - needSubCount
  if linkCount < 0 or pickUpNum < linkCount then
    Log.fatal("Link count error, link:", linkCount, ", cfgNum:", pickUpNum, ", SkillID:", activeSkillID)
    return false
  end
  local startPos = pickUpGridList[1]
  local playerPos = petEntity:GetGridPosition()
  if startPos.x ~= playerPos.x or startPos.y ~= playerPos.y then
    Log.fatal("Link path start pos invalid, client:", startPos:Pos2Index(), " server:", playerPos:Pos2Index())
    return false
  end
  for i = 1, #pickUpGridList - 1 do
    local pos1 = pickUpGridList[i]
    local pos2 = pickUpGridList[i + 1]
    local isCanConnect = false
    for i = -1, 1 do
      for j = -1, 1 do
        if pos1.x + i == pos2.x and pos1.y + j == pos2.y and not utilDataSvc:IsPosBlockForPreviewLinkLine(pos2, canLinkMonster) then
          isCanConnect = true
        end
      end
    end
    if isCanConnect == false then
      Log.fatal("Pos not connect, pos1:", pos1:Pos2Index(), " pos2:", pos2:Pos2Index())
      return false
    end
  end
  return true
end

function CommandBaseHandler:CheckPickUpPuzzleValid(petEntity, activeSkillID, cmd)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  local utilDataSvc = self._world:GetService("UtilData")
  local pickUpGridList = cmd:GetCmdPickUpResult()
  if #pickUpGridList < 1 then
    Log.fatal("PickCount < MustPickNum! MustNum: 1, PickCount:", #pickUpGridList, ", SkillID:", activeSkillID)
    return false
  end
  local pos = pickUpGridList[1]
  local validGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
  local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
  if not validGridList and not table.Vector2Include(validGridList, pos) then
    Log.fatal("Pos is not in ValidGridList Pos:", tostring(pos), "SkillID:", activeSkillID)
    return false
  end
  if not invalidGridList and table.Vector2Include(invalidGridList, pos) then
    Log.fatal("Pos is in InValidGridList Pos:", tostring(pos), "SkillID:", activeSkillID)
    return false
  end
  local puzzleScopeInfo = skillConfigData:GetSkillPickParam().PuzzleScope
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local scopeResult = scopeCalculator:ComputeScopeRange(puzzleScopeInfo.ScopeType, puzzleScopeInfo.ScopeParam, pos, petEntity:BodyArea():GetArea(), petEntity:GetGridDirection(), puzzleScopeInfo.TargetType, pos, petEntity)
  local puzzleRange = scopeResult:GetAttackRange()
  for index, pickUpPos in ipairs(pickUpGridList) do
    if index ~= 1 then
      local centerPos = pickUpGridList[index - 1]
      if not utilDataSvc:CheckPuzzlePickUpIsValid(pickUpPos, centerPos, puzzleRange) then
        Log.fatal("Pick grid pos error, SkillID:", activeSkillID)
        return false
      end
    end
  end
  return true
end

function CommandBaseHandler:CheckPickUpUIAndTrap(petEntity, activeSkillID, cmd)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  local pickUpGridList = cmd:GetCmdPickUpResult()
  local pickUpPetPstID = cmd:GetPickUpPetPstID()
  local pickUpNum = tonumber(skillConfigData:GetSkillPickParam()[1])
  if pickUpNum == 0 and #pickUpGridList ~= 0 then
    Log.fatal("Can't PickUpGrid  PickCount:", #pickUpGridList, ", SkillID:", activeSkillID)
    return false
  end
  if #pickUpGridList ~= 0 and pickUpPetPstID then
    Log.fatal("pickUpGridList ~=0 and pickUpPetPstID~=nil SkillID:", activeSkillID)
    return false
  end
  if #pickUpGridList ~= 0 then
    local pos = pickUpGridList[1]
    local validGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
    local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
    if not validGridList and not table.Vector2Include(validGridList, pos) then
      Log.fatal("Pos is not in ValidGridList Pos:", tostring(pos), "SkillID:", activeSkillID)
      return false
    end
    if not invalidGridList and table.Vector2Include(invalidGridList, pos) then
      Log.fatal("Pos is in InValidGridList Pos:", tostring(pos), "SkillID:", activeSkillID)
      return false
    end
  end
  if pickUpPetPstID then
    local utilDataSvc = self._world:GetService("UtilData")
    local petEntity = utilDataSvc:GetEntityByPstID(pickUpPetPstID)
    if not (petEntity and petEntity:HasPetPstID()) or petEntity:HasDeadMark() then
      Log.fatal("PickUpPetPstID is not valid PetPstID:", tostring(pickUpPetPstID), "SkillID:", activeSkillID)
      return false
    end
  end
  return true
end

function CommandBaseHandler:CheckAlGorePickUp(petEntity, activeSkillID, cmd)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  local pickUpGridList = cmd:GetCmdPickUpResult()
  local firstPickUpNum = tonumber(skillConfigData:GetSkillPickParam()[1])
  local secondPickUpNum = tonumber(skillConfigData:GetSkillPickParam()[2])
  if #pickUpGridList > firstPickUpNum + secondPickUpNum or #pickUpGridList < firstPickUpNum + 1 then
    Log.fatal(" PickUpGridCount Invalid  PickCount:", #pickUpGridList, ", SkillID:", activeSkillID)
    return false
  end
  local firstValidPosList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
  local secondValidPosList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity, pickUpGridList[1])
  if not firstValidPosList and not table.Vector2Include(firstValidPosList, pickUpGridList[1]) then
    Log.fatal("First Pos is not in ValidGridList Pos:", tostring(pickUpGridList[1]), "SkillID:", activeSkillID)
    return false
  end
  for i, pos in ipairs(pickUpGridList) do
    if 1 < i and (not secondValidPosList or not table.Vector2Include(secondValidPosList, pos)) then
      Log.fatal("Second Pos is not  in ValidGridList Pos:", tostring(pos), "SkillID:", activeSkillID)
      return false
    end
  end
  return true
end

function CommandBaseHandler:IsPosNil(pos)
  local cBoard = self._world:GetBoardEntity():Board()
  return cBoard:IsPosNil(pos)
end

function CommandBaseHandler:IsGridPosValid(pos)
  local utilData = self._world:GetService("UtilData")
  if not utilData:IsValidPiecePos(pos) then
    return false
  end
  if utilData:IsPosBlock(pos, BlockFlag.LinkLine) then
    return false
  end
  return true
end

function CommandBaseHandler:CheckDirection(direction)
  if direction ~= HitBackDirectionType.Down and direction ~= HitBackDirectionType.Up and direction ~= HitBackDirectionType.Left and direction ~= HitBackDirectionType.Right and direction ~= HitBackDirectionType.LeftUp and direction ~= HitBackDirectionType.LeftDown and direction ~= HitBackDirectionType.RightUp and direction ~= HitBackDirectionType.RightDown then
    return false
  end
  return true
end

function CommandBaseHandler:GetCurState()
  local utilDataSvc = self._world:GetService("UtilData")
  return utilDataSvc:GetCurMainStateID()
end

function CommandBaseHandler:_ParseScopeList(list)
  local parser = SkillScopeParamParser:New()
  local t = {}
  for _, v in ipairs(list) do
    local param = SkillPreviewScopeParam:New(v)
    local data = parser:ParseScopeParam(v.ScopeType, v.ScopeParam)
    param:SetScopeParamData(data)
    table.insert(t, param)
  end
  return t
end

function CommandBaseHandler:_CheckMultiLegengPowerSkillReadyOnClearPower(e, legendPower, localSkillID)
  local configService = self._world:GetService("Config")
  local baseActiveSkillID = e:SkillInfo():GetActiveSkillID()
  local extraSkillList = e:SkillInfo():GetExtraActiveSkillIDList()
  if extraSkillList then
    local checkSkillList = {}
    table.insert(checkSkillList, baseActiveSkillID)
    table.appendArray(checkSkillList, extraSkillList)
    for _, checkSkillID in ipairs(checkSkillList) do
      if checkSkillID ~= localSkillID then
        local checkSkillConfigData = configService:GetSkillConfigData(checkSkillID)
        if checkSkillConfigData and checkSkillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
          local checkSkillCostLegendPower = checkSkillConfigData:GetSkillTriggerParam()
          if legendPower < checkSkillCostLegendPower then
            local blsvc = self._world:GetService("BuffLogic")
            blsvc:ChangePetActiveSkillReady(e, 0, checkSkillID)
          end
        end
      end
    end
  end
end

function CommandBaseHandler:CheckPickUpMoyeValid(petEntity, activeSkillID, cmd)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  local pickUpGridList = cmd:GetCmdPickUpResult()
  if #pickUpGridList < 2 then
    Log.fatal("PickCount < MustPickNum! MustNum: 2, PickCount:", #pickUpGridList, ", SkillID:", activeSkillID)
    return false
  end
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  local canLinkMonster = false
  if skillConfigData._pickUpParam[2] then
    canLinkMonster = tonumber(skillConfigData._pickUpParam[2]) == 1
  end
  local needSubCount = 1
  local endPos = pickUpGridList[#pickUpGridList]
  local utilDataSvc = self._world:GetService("UtilData")
  if utilDataSvc:GetMonsterAtPos(endPos) then
    needSubCount = needSubCount + 1
  end
  local linkCount = #pickUpGridList - needSubCount
  if linkCount < 0 or pickUpNum < linkCount then
    Log.fatal("Link count error, link:", linkCount, ", cfgNum:", pickUpNum, ", SkillID:", activeSkillID)
    return false
  end
  local firstPickupPos = pickUpGridList[1]
  local firstPickUpValidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.firstPickValidScopeList or {})
  local validGridList = utilScopeSvc:BuildScopeGridList(firstPickUpValidScopeList, petEntity) or {}
  if 0 < #validGridList and not table.Vector2Include(validGridList, firstPickupPos) then
    Log.fatal("Pos is not in ValidGridList Pos:", tostring(firstPickupPos), "SkillID:", "SkillID:", activeSkillID)
    return false
  end
  for i = 1, #pickUpGridList - 1 do
    local pos1 = pickUpGridList[i]
    local pos2 = pickUpGridList[i + 1]
    local isCanConnect = false
    for i = -1, 1 do
      for j = -1, 1 do
        if pos1.x + i == pos2.x and pos1.y + j == pos2.y and not utilDataSvc:IsPosBlockForPreviewLinkLine(pos2, canLinkMonster) then
          isCanConnect = true
        end
      end
    end
    if isCanConnect == false then
      Log.fatal("Pos not connect, pos1:", pos1:Pos2Index(), " pos2:", pos2:Pos2Index())
      return false
    end
  end
  return true
end
