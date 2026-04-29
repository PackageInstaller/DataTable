require("base_service")
local __AttrKey_ControlIncrease = "ControlIncrease"
_class("BuffLogicService", BaseService)
BuffLogicService = BuffLogicService

function BuffLogicService:Constructor(world)
  self._buffLogicHandler = {}
  self._world = world
  self._buffSeqID = 1000
end

function BuffLogicService:CreateLogic(buffInstance, logicParam)
  local logicName = string.trim(logicParam.logic)
  local logicPrototype = Classes["BuffLogic" .. logicName]
  if not logicPrototype then
    local buffLogicName = "BuffLogic" .. logicParam.logic
    Log.exception("BuffLogicService:CreateLogic() not find logic:", buffLogicName, " config Logic:", logicParam.logic)
    return
  end
  return logicPrototype:New(buffInstance, logicParam)
end

function BuffLogicService:CreateBuffInstance(buffID, entity, context, alterLayer, addLayerCount)
  self._buffSeqID = self._buffSeqID + 1
  local buffInstance = BuffInstance:New(self._buffSeqID, buffID, entity, self._world, context, alterLayer, addLayerCount)
  return buffInstance
end

function BuffLogicService:RemoveAllBuffInstance(entity)
  local buffCom = entity:BuffComponent()
  if buffCom then
    buffCom:ClearAllBuffInstances()
  end
end

function BuffLogicService:AutoRemoveUnloadedBuff()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.Buff)
  for i, e in ipairs(group:GetEntities()) do
    e:BuffComponent():RemoveUnloadedBuffInstance()
  end
end

function BuffLogicService:CreateBuffLogic(buffInstance, logicConfig)
  if not logicConfig or not next(logicConfig) then
    return nil
  end
  local logic = {}
  for i, cfg in ipairs(logicConfig) do
    local sublogic = self:CreateLogic(buffInstance, cfg)
    logic[#logic + 1] = sublogic
  end
  return logic
end

function BuffLogicService:AddBuffByTargetType(buffID, buffTargetType, buffTargetParam, context, buffSource, equipIntensifyParams, casterEntity)
  local es = self:CalcBuffTargetEntities(buffTargetType, buffTargetParam, casterEntity)
  local buffArray = {}
  for i, e in ipairs(es) do
    local buffInstance = self:AddBuff(buffID, e, context, buffSource, equipIntensifyParams)
    if buffInstance then
      buffArray[#buffArray + 1] = buffInstance
      local buffComponent = e:BuffComponent()
    end
  end
  return buffArray
end

function BuffLogicService:HandleBuffIDReplace(buffID, entity)
  if self:IsReplaceBuffIDMatchType(entity) then
    local replaceBuffID = self:GetReplaceBuffIDByGlobalCfg(buffID)
    if replaceBuffID then
      return replaceBuffID
    end
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local buffComp = teamEntity:BuffComponent()
  local buffCfg = Cfg.cfg_buff[buffID]
  if buffCfg and entity:HasMonsterID() then
    local buffEffectType = buffCfg.BuffEffectType
    local key = string.format(BattleConst.BVK_ReplaceBuffIDFormat, buffEffectType)
    local replaceBuffIDDic = buffComp:GetBuffValue(key)
    if replaceBuffIDDic and replaceBuffIDDic[buffID] then
      return replaceBuffIDDic[buffID]
    end
  end
  return buffID
end

function BuffLogicService:GetReplacedBuffIdForPlayIns(entity, buffID)
  if self:IsReplaceBuffIDMatchType(entity) then
    local replaceBuffID = self:GetReplaceBuffIDByGlobalCfg(buffID)
    if replaceBuffID then
      return replaceBuffID
    end
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local buffComp = teamEntity:BuffComponent()
  local buffCfg = Cfg.cfg_buff[buffID]
  if buffCfg and entity:HasMonsterID() then
    local buffEffectType = buffCfg.BuffEffectType
    local key = string.format(BattleConst.BVK_ReplaceBuffIDFormat, buffEffectType)
    local replaceBuffIDDic = buffComp:GetBuffValue(key)
    if replaceBuffIDDic and replaceBuffIDDic[buffID] then
      return replaceBuffIDDic[buffID]
    end
  end
  return buffID
end

function BuffLogicService:GetReplacedBuffEffectTypeForPlayIns(entity, buffEffectType)
  if not buffEffectType then
    return
  end
  if not entity then
    return
  end
  if self:IsReplaceBuffIDMatchType(entity) then
    local cfg = Cfg.cfg_global.ReplaceBuffIDMatchType
    if cfg and cfg.TableValue then
      for oriID, tarID in pairs(cfg.TableValue) do
        local oriBuffCfg = Cfg.cfg_buff[oriID]
        if oriBuffCfg then
          local oriBuffEffectType = oriBuffCfg.BuffEffectType
          if oriBuffEffectType == buffEffectType then
            local tarBuffCfg = Cfg.cfg_buff[tarID]
            if tarBuffCfg then
              local tarBuffEffectType = tarBuffCfg.BuffEffectType
              return tarBuffEffectType
            end
          end
        end
      end
    end
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local buffComp = teamEntity:BuffComponent()
  if entity:HasMonsterID() then
    local key = string.format(BattleConst.BVK_ReplaceBuffIDFormat, buffEffectType)
    local replaceBuffIDDic = buffComp:GetBuffValue(key)
    if replaceBuffIDDic then
      for oriID, tarID in pairs(replaceBuffIDDic) do
        local oriBuffCfg = Cfg.cfg_buff[oriID]
        if oriBuffCfg then
          local oriBuffEffectType = oriBuffCfg.BuffEffectType
          if oriBuffEffectType == buffEffectType then
            local tarBuffCfg = Cfg.cfg_buff[tarID]
            if tarBuffCfg then
              local tarBuffEffectType = tarBuffCfg.BuffEffectType
              return tarBuffEffectType
            end
          end
        end
      end
    end
  end
  return buffEffectType
end

function BuffLogicService:AddBuff(buffID, entity, context, buffSource, equipIntensifyParams, NoAddBuffNotify)
  if entity == nil then
    Log.fatal("[Buff] add buff failed, entity is nil. BuffID: ", buffID)
  end
  buffID = self:HandleBuffIDReplace(buffID, entity)
  local buffComp = entity:BuffComponent()
  if not buffComp then
    return
  end
  local buffCfg = Cfg.cfg_buff[buffID]
  if not buffCfg then
    Log.fatal("buffID has no config ", buffID)
    return
  end
  local buffEffectType = buffCfg.BuffEffectType
  if (entity:HasTeam() or entity:HasPet()) and buffEffectType == BuffEffectType.Fear then
    Log.fatal("Fear buff target is team or pet")
    return
  end
  local triggerSvc = self._world:GetService("Trigger")
  triggerSvc:Notify(NTBeforeEntityAddBuff:New(entity, buffID, buffEffectType))
  if buffCfg.IsDebuff and entity:Attributes():GetAttribute("DebuffImmunity") ~= nil then
    self:PrintBuffLogicSvcLog("[Buff] buff target immunity debuff. BuffID: ", buffID)
    return nil
  end
  local effs = buffComp:GetBuffValue("ImmuneBuffEffect")
  if effs and table.icontains(effs, buffEffectType) then
    self:PrintBuffLogicSvcLog("[Buff] buff immnue buff effect ", buffEffectType)
    return
  end
  if buffCfg.BuffType == BuffType.Control then
    if entity:EntityType().Value == EntityType.Trap then
      self:PrintBuffLogicSvcLog("[buff] buff trap cannot add control buff=", buffID)
      return
    end
    if buffComp:HasFlag(BuffFlags.ImmuneControl) then
      self:PrintBuffLogicSvcLog("[Buff] buff immnue control buff=", buffID)
      return
    end
  end
  local buffSeq = -1
  self._world:GetSyncLogger():Trace({
    key = "AddBuff",
    entityID = entity:GetID(),
    buffID = buffID
  })
  local buffInstance = self:HandleOverlap(buffID, entity, context, equipIntensifyParams)
  if buffInstance and not buffInstance:IsInit() then
    buffInstance:InitBuffHandler(equipIntensifyParams)
    buffComp:AddBuffInstance(buffInstance)
    buffComp:AddBuffSource(buffSource, buffInstance)
    buffSeq = buffInstance:BuffSeq()
  end
  local controlIncreaseVal = entity:Attributes():GetAttribute(__AttrKey_ControlIncrease) or 0
  if 0 < controlIncreaseVal and buffInstance and 0 < buffInstance:GetMaxRoundCount() and table.icontains(BattleConst.ControlBuffEffectTypeArray, buffInstance:GetBuffEffectType()) then
    buffInstance:AddMaxRoundCount(controlIncreaseVal)
  end
  local affixService = self._world:GetService("Affix")
  if affixService:HasChangePetAddBuffMaxRound() and (entity:HasTeam() or entity:HasPet()) and buffCfg.CustomParams and buffCfg.CustomParams.effectFlags then
    local changeRound = affixService:GetChangePetAddBuffMaxRoundParam(buffCfg.CustomParams.effectFlags)
    if changeRound and buffInstance and 0 < buffInstance:GetMaxRoundCount() then
      buffInstance:AddMaxRoundCount(changeRound)
    end
  end
  if not NoAddBuffNotify then
    triggerSvc:Notify(NTAfterEntityAddBuff:New(entity, buffID, buffEffectType, buffSeq))
  end
  self:PrintBuffLogicSvcLog("AddBuff() entityID=", entity:GetID(), " buffSeq=", buffSeq, " buffID=", buffID)
  return buffInstance
end

function BuffLogicService:ModifyMaxLayerCountByGlobalCfg(configData, entity)
  local maxLayerCount = configData:GetMaxLayerCount()
  local curTeamEntity = self._world:Player():GetLocalTeamEntity()
  local replaceBuffMaxLayerBuffEffectList = curTeamEntity:BuffComponent():GetBuffValue("ReplaceMaxLayer_BuffEffectTypeList")
  if not entity:HasMonsterID() then
    local utilCalcSvc = self._world:GetService("UtilCalc")
    if replaceBuffMaxLayerBuffEffectList then
      if not utilCalcSvc:IsBlackFistRemoteEntity(entity) then
        return maxLayerCount
      end
    else
      return maxLayerCount
    end
  end
  if replaceBuffMaxLayerBuffEffectList and table.icontains(replaceBuffMaxLayerBuffEffectList, configData:GetBuffEffectType()) then
    maxLayerCount = curTeamEntity:BuffComponent():GetBuffValue("ReplaceMaxLayer_MaxLayer")
  end
  local cfg = Cfg.cfg_global.ModifyBuffLayer
  if cfg and cfg.ArrayValue and table.icontains(cfg.ArrayValue, self._world:SubMatchType()) and cfg.TableValue and table.icontains(cfg.TableValue.BuffEffectTypeList, configData:GetBuffEffectType()) then
    maxLayerCount = cfg.TableValue.MaxLayerCount
  end
  return maxLayerCount
end

function BuffLogicService:HandleOverlap(buffID, entity, context, equipIntensifyParams)
  local buffComp = entity:BuffComponent()
  local buffCfg = Cfg.cfg_buff[buffID]
  local buffEffectType = buffCfg.BuffEffectType
  local replaceType = buffCfg.ReplaceType
  local existBuff = buffComp:GetBuffArrayByBuffEffect(buffEffectType)
  local buffInstance
  if replaceType == BuffReplaceType.Exclusive then
    if 0 == #existBuff then
      buffInstance = self:CreateBuffInstance(buffID, entity, context)
    else
      self:PrintBuffLogicSvcLog("AddBuff() replaceType=Exclusive buffID=", buffID)
    end
  elseif replaceType == BuffReplaceType.CoExist then
    buffInstance = self:CreateBuffInstance(buffID, entity, context)
  elseif replaceType == BuffReplaceType.RoundOverlap then
    if 0 == #existBuff then
      buffInstance = self:CreateBuffInstance(buffID, entity, context)
    else
      buffInstance = existBuff[1]
      buffInstance:AddMaxRoundCount(buffCfg.RoundCount)
    end
  elseif replaceType == BuffReplaceType.EffectOverlap then
    if 0 == #existBuff then
      buffInstance = self:CreateBuffInstance(buffID, entity, context)
    else
      buffInstance = existBuff[1]
      buffInstance:DoOverlap(buffID, context, equipIntensifyParams)
    end
  elseif replaceType == BuffReplaceType.Replace then
    if 0 ~= #existBuff then
      buffInstance = existBuff[1]
      buffInstance:Unload()
    end
    buffInstance = self:CreateBuffInstance(buffID, entity, context)
  elseif replaceType == BuffReplaceType.LayerLimit then
    local sConfig = self._world:GetService("Config")
    local configData = sConfig:GetBuffConfigData(buffID) or {}
    local cfg = configData:GetData()
    local tmpCfg = {}
    tmpCfg.Load = {}
    tmpCfg.Load.logic = table.cloneconf(cfg.LoadLogic) or {}
    tmpCfg.Active = {}
    tmpCfg.Active.logic = table.cloneconf(cfg.ActiveLogic) or {}
    tmpCfg.Active.trigger = table.cloneconf(cfg.ActiveTrigger)
    tmpCfg.Exec = {}
    tmpCfg.Exec.logic = table.cloneconf(cfg.ExecLogic) or {}
    tmpCfg.Exec.trigger = table.cloneconf(cfg.ExecTrigger)
    tmpCfg.Deactive = {}
    tmpCfg.Deactive.logic = table.cloneconf(cfg.DeactiveLogic) or {}
    tmpCfg.Deactive.trigger = table.cloneconf(cfg.DeactiveTrigger)
    tmpCfg.Unload = {}
    tmpCfg.Unload.logic = table.cloneconf(cfg.UnloadLogic) or {}
    tmpCfg.Unload.trigger = table.cloneconf(cfg.UnloadTrigger)
    self:DoEquipIntensify(buffID, tmpCfg, equipIntensifyParams)
    local alterLayer = {}
    local addLayerCount = {}
    local logic = tmpCfg.Load.logic
    local layerCheck, partialLayer
    if #logic == 0 then
      layerCheck = true
    else
      local utilData = self._world:GetService("UtilData")
      local maxLayerCount = self:ModifyMaxLayerCountByGlobalCfg(configData, entity)
      for index, l in ipairs(logic) do
        if l.logic == "AddLayer" then
          local layerType = l.layerType or cfg.BuffEffectType
          addLayerCount[layerType] = addLayerCount[layerType] or 0
          local layer = utilData:GetBuffLayer(entity, layerType)
          if maxLayerCount ~= 0 and 0 < layer then
            if maxLayerCount < layer + addLayerCount[layerType] + l.layer then
              if 0 < maxLayerCount - layer - addLayerCount[layerType] then
                alterLayer[index] = maxLayerCount - layer - addLayerCount[layerType]
                addLayerCount[layerType] = addLayerCount[layerType] + alterLayer[index]
              else
                alterLayer[index] = 0
              end
            else
              addLayerCount[layerType] = addLayerCount[layerType] + l.layer
            end
          else
            addLayerCount[layerType] = addLayerCount[layerType] + l.layer
          end
        end
      end
    end
    local isLayerChanged = false
    for _, v in pairs(addLayerCount) do
      if 0 < v then
        isLayerChanged = true
        break
      end
    end
    if isLayerChanged then
      buffInstance = self:CreateBuffInstance(buffID, entity, context, alterLayer, addLayerCount)
    end
  end
  return buffInstance
end

function BuffLogicService:CalcPlayerBuffTurn(teamEntity)
  local svc = self._world:GetService("Trigger")
  svc:Notify(NTPlayerTurnStart:New(teamEntity))
  svc:Notify(NTEnemyTurnStart:New(teamEntity))
  svc:Notify(NTPlayerTurnStartLast:New(teamEntity))
  local entityList = self._world:GetAllPlayerEntity(teamEntity)
  for i, e in ipairs(entityList) do
    if not e:HasPetDeadMark() then
      local buffCmpt = e:BuffComponent()
      local buffArray = buffCmpt:GetBuffArray()
      local buffCopy = table.shallowcopy(buffArray)
      for _, buffInstance in ipairs(buffCopy) do
        local buffEffectType = buffInstance:GetBuffEffectType()
        if table.icontains(_G.UnitTurnDelayStartEffectType, buffEffectType) then
          Log.debug("CalcPlayerBuffTurn: buffEffectType: ", buffEffectType, ": lifecycle is delayed. ")
        else
          buffInstance:AddRoundCount(NTPlayerTurnStart:New(teamEntity))
        end
      end
    end
  end
  svc:Notify(NTPlayerTurnBuffAddRoundEnd:New(teamEntity))
  svc:Notify(NTPlayerTurnBuffAddRoundEndAfter:New(teamEntity))
end

function BuffLogicService:CalcPlayerBuffDelayedTurn(teamEntity)
  local entityList = self._world:GetAllPlayerEntity(teamEntity)
  for i, e in ipairs(entityList) do
    if not e:HasPetDeadMark() then
      local buffCmpt = e:BuffComponent()
      local buffArray = buffCmpt:GetBuffArray()
      local buffCopy = table.shallowcopy(buffArray)
      for _, buffInstance in ipairs(buffCopy) do
        local buffEffectType = buffInstance:GetBuffEffectType()
        if table.icontains(_G.UnitTurnDelayStartEffectType, buffEffectType) then
          Log.debug("CalcPlayerBuffDelayedTurn: buffEffectType: ", buffEffectType, ": delayed lifecycle processing. ")
          buffInstance:AddRoundCount(NTPlayerTurnStart:New(teamEntity))
        end
      end
    end
  end
end

function BuffLogicService:CalcChessBuffTurn()
  local chessGroup = self._world:GetGroup(self._world.BW_WEMatchers.ChessPet)
  for i, e in ipairs(chessGroup:GetEntities()) do
    if not e:HasDeadMark() and not e:BuffComponent():IsBuffFreeze() then
      local buffCmpt = e:BuffComponent()
      local buffArray = buffCmpt:GetBuffArray()
      local buffCopy = table.shallowcopy(buffArray)
      for _, buffInstance in ipairs(buffCopy) do
        buffInstance:AddRoundCount(NTPlayerTurnStart:New())
      end
    end
  end
end

function BuffLogicService:CalcMonsterBuffTurn(teamEntity)
  self._world:GetService("Trigger"):Notify(NTMonsterTurnStart:New())
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for i, e in ipairs(monsterGroup:GetEntities()) do
    if not e:HasDeadMark() and not e:BuffComponent():IsBuffFreeze() then
      local buffCmpt = e:BuffComponent()
      local buffArray = buffCmpt:GetBuffArray()
      local buffCopy = table.shallowcopy(buffArray)
      for _, buffInstance in ipairs(buffCopy) do
        local buffEffectType = buffInstance:GetBuffEffectType()
        if table.icontains(_G.UnitTurnDelayStartEffectType, buffEffectType) then
          Log.debug("CalcMonsterBuffTurn: buffEffectType: ", buffEffectType, ": lifecycle is delayed. ")
        else
          buffInstance:AddRoundCount(NTMonsterTurnStart:New())
        end
      end
    end
  end
  if teamEntity then
    local entityList = self._world:GetAllPlayerEntity(teamEntity)
    for i, e in ipairs(entityList) do
      local buffCmpt = e:BuffComponent()
      local buffArray = buffCmpt:GetBuffArray()
      local buffCopy = table.shallowcopy(buffArray)
      for _, buffInstance in ipairs(buffCopy) do
        local unloadNotifys = buffInstance:GetUnloadNotifyType()
        if 0 < #unloadNotifys and unloadNotifys[1] == NotifyType.MonsterTurnStart then
          buffInstance:AddRoundCount(NTMonsterTurnStart:New())
        end
      end
    end
  end
  self._world:GetService("Trigger"):Notify(NTMonsterTurnAfterAddBuffRound:New())
end

function BuffLogicService:CalcMonsterBuffDelayedTurn()
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for i, e in ipairs(monsterGroup:GetEntities()) do
    if not e:HasDeadMark() and not e:BuffComponent():IsBuffFreeze() then
      local buffCmpt = e:BuffComponent()
      local buffArray = buffCmpt:GetBuffArray()
      local buffCopy = table.shallowcopy(buffArray)
      for _, buffInstance in ipairs(buffCopy) do
        local buffEffectType = buffInstance:GetBuffEffectType()
        if table.icontains(_G.UnitTurnDelayStartEffectType, buffEffectType) then
          Log.debug("CalcMonsterBuffDelayedTurn: buffEffectType: ", buffEffectType, ": delayed lifecycle processing. ")
          buffInstance:AddRoundCount(NTMonsterTurnStart:New())
        end
      end
    end
  end
  self._world:GetService("Trigger"):Notify(NTMonsterTurnAfterDelayedAddBuffRound:New())
end

function BuffLogicService:CalcBuffTargetEntities(buffTargetType, buffTargetParam, casterEntity)
  buffTargetType = self._world:ReplaceBuffTarget(buffTargetType)
  local partnerSvc = self._world:GetService("PartnerLogic")
  if partnerSvc then
    buffTargetType = partnerSvc:ReplaceBuffTarget(buffTargetType)
    if buffTargetType == BuffTargetType.None then
      return {}
    end
  end
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local enemyEntities = {}
  for i, e in ipairs(monsterGroup:GetEntities()) do
    if not e:HasDeadMark() then
      table.insert(enemyEntities, e)
    end
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if casterEntity then
    if casterEntity:HasTeam() then
      teamEntity = casterEntity
    elseif casterEntity:HasPet() then
      teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
    end
  end
  if self._world:MatchType() == MatchType.MT_BlackFist then
    table.insert(enemyEntities, teamEntity:Team():GetEnemyTeamEntity())
  end
  local es = {}
  if buffTargetType == BuffTargetType.Self then
    es[#es + 1] = casterEntity
    return es
  elseif buffTargetType == BuffTargetType.AllMonster then
    if type(buffTargetParam) == "table" and buffTargetParam[1] == 1 then
      local t = {}
      local caster = casterEntity
      if casterEntity:HasSuperEntity() then
        caster = casterEntity:GetSuperEntity()
      end
      for i = 1, #enemyEntities do
        if enemyEntities[i]:GetID() ~= caster:GetID() then
          table.insert(t, enemyEntities[i])
        end
      end
      enemyEntities = t
    end
    return enemyEntities
  elseif buffTargetType == BuffTargetType.OneGridMonster then
    for i, e in ipairs(enemyEntities) do
      if e:BodyArea():GetAreaCount() == 1 then
        table.insert(es, e)
      end
    end
  elseif buffTargetType == BuffTargetType.MultiGridMonster then
    for i, e in ipairs(enemyEntities) do
      if 1 < e:BodyArea():GetAreaCount() then
        table.insert(es, e)
      end
    end
  elseif buffTargetType == BuffTargetType.PetElement then
    local teamMembers = teamEntity:Team():GetTeamPetEntities()
    for i, e in ipairs(teamMembers) do
      local element = e:Element():GetPrimaryType()
      if table.icontains(buffTargetParam, element) then
        table.insert(es, e)
      end
    end
  elseif buffTargetType == BuffTargetType.AddPartnerAllPartnerPetElement then
    local tmpTeamEntity = self._world:Player():GetAddPartnerTempTeam()
    if tmpTeamEntity then
      local teamMembers = tmpTeamEntity:Team():GetTeamPetEntities()
      for i, e in ipairs(teamMembers) do
        local element = e:Element():GetPrimaryType()
        if table.icontains(buffTargetParam, element) then
          table.insert(es, e)
        end
      end
    end
  elseif buffTargetType == BuffTargetType.NonLeaderPetElement then
    local teamMembers = teamEntity:Team():GetTeamPetEntities()
    for i, e in ipairs(teamMembers) do
      local eTeam = teamEntity
      local eidTeamLeader = eTeam:Team():GetTeamLeaderEntityID()
      local element = e:Element():GetPrimaryType()
      if e:GetID() ~= eidTeamLeader and table.icontains(buffTargetParam, element) then
        table.insert(es, e)
      end
    end
  elseif buffTargetType == BuffTargetType.RandomMonster then
    local randomSvc = self._world:GetService("RandomLogic")
    local mes = {}
    table.appendArray(mes, enemyEntities)
    local x = buffTargetParam and buffTargetParam or 1
    for i = 1, x do
      if #mes == 0 then
        break
      end
      local index = randomSvc:LogicRand(1, #mes)
      es[#es + 1] = mes[index]
      mes[index] = nil
    end
  elseif buffTargetType == BuffTargetType.AllPet then
    local teamMembers = teamEntity:Team():GetTeamPetEntities()
    for i, e in ipairs(teamMembers) do
      if not e:HasPetDeadMark() then
        es[#es + 1] = e
      end
    end
    return es
  elseif buffTargetType == BuffTargetType.AddPartnerAllPartnerPet then
    local tmpTeamEntity = self._world:Player():GetAddPartnerTempTeam()
    if tmpTeamEntity then
      local teamMembers = tmpTeamEntity:Team():GetTeamPetEntities()
      for i, e in ipairs(teamMembers) do
        if not e:HasPetDeadMark() then
          es[#es + 1] = e
        end
      end
      return es
    end
  elseif buffTargetType == BuffTargetType.RemoteTeamAllPet then
    local remoteTeam = self._world:Player():GetRemoteTeamEntity()
    local teamMembers = remoteTeam:Team():GetTeamPetEntities()
    for i, e in ipairs(teamMembers) do
      if not e:HasPetDeadMark() then
        es[#es + 1] = e
      end
    end
    return es
  elseif buffTargetType == BuffTargetType.Team then
    local playerEntity = teamEntity
    return {playerEntity}
  elseif buffTargetType == BuffTargetType.AddPartnerTmpTeam then
    local tmpTeamEntity = self._world:Player():GetAddPartnerTempTeam()
    if tmpTeamEntity then
      local playerEntity = tmpTeamEntity
      return {playerEntity}
    end
  elseif buffTargetType == BuffTargetType.AroundMonster then
    local curPos = casterEntity:GetGridPosition()
    local curBodyArea = casterEntity:BodyArea():GetArea()
    local ringCount = buffTargetParam and buffTargetParam or 1
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
    local scopeResult = scopeCalculator:ComputeScopeRange(SkillScopeType.SquareRing, {ringCount, 0}, curPos, curBodyArea)
    local attackRange = scopeResult:GetAttackRange()
    for _, e in ipairs(enemyEntities) do
      local pos = e:GetGridPosition()
      local bodyArea = e:BodyArea():GetArea()
      for i, area in ipairs(bodyArea) do
        local curMonsterBodyPos = pos + area
        if table.intable(attackRange, curMonsterBodyPos) then
          table.insert(es, e)
          break
        end
      end
    end
  elseif buffTargetType == BuffTargetType.RegularBodyMonster then
    local cfgService = self._world:GetService("Config")
    local monsterConfigData = cfgService:GetMonsterConfigData()
    for i, e in ipairs(enemyEntities) do
      if monsterConfigData:IsRegularShape(e:MonsterID():GetMonsterID()) then
        table.insert(es, e)
      end
    end
  elseif buffTargetType == BuffTargetType.MonsterHaventDragonMark then
    for _, e in ipairs(enemyEntities) do
      local buffComp = e:BuffComponent()
      if not buffComp:CheckHaveBuffById(buffTargetParam) then
        table.insert(es, e)
      end
    end
  elseif buffTargetType == BuffTargetType.AllTrap then
    local g = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
    return g:GetEntities()
  elseif buffTargetType == BuffTargetType.AnyAlive then
    local teamMembers = teamEntity:Team():GetTeamPetEntities()
    local petAlive = {}
    for i, e in ipairs(teamMembers) do
      if not e:HasPetDeadMark() then
        petAlive[#petAlive + 1] = e
      end
    end
    local randomSvc = self._world:GetService("RandomLogic")
    local r = randomSvc:LogicRand(1, #petAlive)
    es[1] = petAlive[r]
  elseif buffTargetType == BuffTargetType.LowHPPet then
    local teamMembers = teamEntity:Team():GetTeamPetEntities()
    local lowhp = 0
    local target
    for i, e in ipairs(teamMembers) do
      if not e:HasPetDeadMark() then
        local hp = e:Attributes():GetCurrentHP()
        local max_hp = e:Attributes():CalcMaxHp()
        if lowhp == 0 or hp < max_hp and lowhp > hp then
          lowhp = hp
          target = e
        end
      end
    end
    es[1] = target
  elseif buffTargetType == BuffTargetType.HPBTPet then
    local teamMembers = teamEntity:Team():GetTeamPetEntities()
    for i, e in ipairs(teamMembers) do
      if not e:HasPetDeadMark() then
        local hp = e:Attributes():GetCurrentHP()
        local max_hp = e:Attributes():CalcMaxHp()
        if buffTargetParam <= hp / max_hp then
          es[#es + 1] = e
        end
      end
    end
  elseif buffTargetType == BuffTargetType.PetJob then
    local teamMembers = teamEntity:Team():GetTeamPetEntities()
    for i, e in ipairs(teamMembers) do
      if not e:HasPetDeadMark() then
        local petPstID = e:PetPstID():GetPstID()
        local petData = self._world:GetPetData(petPstID)
        local petJob = petData:GetJob()
        if table.icontains(buffTargetParam, petJob) then
          es[#es + 1] = e
        end
      end
    end
  elseif buffTargetType == BuffTargetType.AddPartnerTmpPetJob then
    local tmpTeamEntity = self._world:Player():GetAddPartnerTempTeam()
    if tmpTeamEntity then
      local teamMembers = tmpTeamEntity:Team():GetTeamPetEntities()
      for i, e in ipairs(teamMembers) do
        if not e:HasPetDeadMark() then
          local petPstID = e:PetPstID():GetPstID()
          local petData = self._world:GetPetData(petPstID)
          local petJob = petData:GetJob()
          if table.icontains(buffTargetParam, petJob) then
            es[#es + 1] = e
          end
        end
      end
    end
  elseif buffTargetType == BuffTargetType.BodyAreaGridElementCount then
    local utilData = self._world:GetService("UtilData")
    for i, e in ipairs(enemyEntities) do
      local pos = e:GetGridPosition()
      local area = e:BodyArea():GetArea()
      for _, v in ipairs(area) do
        local posWork = pos + v
        local pieceElement = utilData:FindPieceElement(Vector2(posWork.x, posWork.y))
        if buffTargetParam == pieceElement then
          es[#es + 1] = e
          break
        end
      end
    end
  elseif buffTargetType == BuffTargetType.SpecificPet then
    local petID = buffTargetParam[1]
    local friendTeam = buffTargetParam[2] or 0
    local rootTeam = buffTargetParam[3] or 0
    if self._world:MatchType() == MatchType.MT_BlackFist then
      if friendTeam == 0 then
        teamEntity = teamEntity:Team():GetEnemyTeamEntity()
      end
      if rootTeam == 1 and casterEntity then
        local superEntity = casterEntity
        if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
          superEntity = casterEntity:SuperEntityComponent():GetSuperEntity()
        end
        if superEntity and superEntity:HasSummoner() then
          local ownerPet = superEntity:GetSummonerEntity()
          if ownerPet:HasPet() then
            teamEntity = ownerPet:Pet():GetOwnerTeamEntity()
          end
        end
      end
    end
    local teamMembers = teamEntity:Team():GetTeamPetEntities()
    for i, e in ipairs(teamMembers) do
      local cPetPstID = e:PetPstID()
      if petID == cPetPstID:GetTemplateID() then
        table.insert(es, e)
        break
      end
    end
  elseif buffTargetType == BuffTargetType.MonsterExceptBoss then
    local ret = {}
    for i, e in ipairs(monsterGroup:GetEntities()) do
      if not e:HasDeadMark() and not e:HasBoss() then
        table.insert(ret, e)
      end
    end
    return ret
  elseif buffTargetType == BuffTargetType.MonsterOnlyBoss then
    local ret = {}
    for i, e in ipairs(monsterGroup:GetEntities()) do
      if not e:HasDeadMark() and e:HasBoss() then
        table.insert(ret, e)
      end
    end
    return ret
  elseif buffTargetType == BuffTargetType.AllTalePet then
    local teamMembers = teamEntity:Team():GetTeamPetEntities()
    for i, e in ipairs(teamMembers) do
      local cPetPstID = e:PetPstID()
      if Cfg.cfg_tale_pet({
        ID = cPetPstID:GetTemplateID()
      }) then
        table.insert(es, e)
      end
    end
  elseif buffTargetType == BuffTargetType.AddPartnerTmpAllTalePet then
    local tmpTeamEntity = self._world:Player():GetAddPartnerTempTeam()
    if tmpTeamEntity then
      local teamMembers = tmpTeamEntity:Team():GetTeamPetEntities()
      for i, e in ipairs(teamMembers) do
        local cPetPstID = e:PetPstID()
        if Cfg.cfg_tale_pet({
          ID = cPetPstID:GetTemplateID()
        }) then
          table.insert(es, e)
        end
      end
    end
  elseif buffTargetType == BuffTargetType.AllNonTalePet then
    local teamMembers = teamEntity:Team():GetTeamPetEntities()
    for i, e in ipairs(teamMembers) do
      local cPetPstID = e:PetPstID()
      if not Cfg.cfg_tale_pet({
        ID = cPetPstID:GetTemplateID()
      }) then
        table.insert(es, e)
      end
    end
  elseif buffTargetType == BuffTargetType.AddPartnerTmpAllNonTalePet then
    local tmpTeamEntity = self._world:Player():GetAddPartnerTempTeam()
    if tmpTeamEntity then
      local teamMembers = tmpTeamEntity:Team():GetTeamPetEntities()
      for i, e in ipairs(teamMembers) do
        local cPetPstID = e:PetPstID()
        if not Cfg.cfg_tale_pet({
          ID = cPetPstID:GetTemplateID()
        }) then
          table.insert(es, e)
        end
      end
    end
  elseif buffTargetType == BuffTargetType.HPPercentHighestMonster then
    local hpPercentHighestMonsterList = {}
    local hpPercentHighest = 0
    for i, e in ipairs(enemyEntities) do
      local hp = e:Attributes():GetCurrentHP()
      local max_hp = e:Attributes():CalcMaxHp()
      local hpPercent = hp / max_hp
      if hpPercentHighest <= hpPercent then
        if hpPercentHighest < hpPercent then
          table.clear(hpPercentHighestMonsterList)
          hpPercentHighest = hpPercent
        end
        table.insert(hpPercentHighestMonsterList, e)
      end
    end
    local hpHighestMonsterList = {}
    local hptHighest = 0
    for i, e in ipairs(hpPercentHighestMonsterList) do
      local hp = e:Attributes():GetCurrentHP()
      if hptHighest <= hp then
        if hptHighest < hp then
          table.clear(hpHighestMonsterList)
          hptHighest = hp
        end
        table.insert(hpHighestMonsterList, e)
      end
    end
    if 1 >= table.count(hpHighestMonsterList) then
      es = hpHighestMonsterList
    else
      local randomSvc = self._world:GetService("RandomLogic")
      local randomIndex = randomSvc:LogicRand(1, #hpHighestMonsterList)
      table.insert(es, hpHighestMonsterList[randomIndex])
    end
  elseif buffTargetType == BuffTargetType.PetCamp then
    local teamMembers = teamEntity:Team():GetTeamPetEntities()
    for _, e in ipairs(teamMembers) do
      local camp = e:MatchPet():GetMatchPet():GetPetCamp()
      if table.icontains(buffTargetParam, camp) then
        table.insert(es, e)
      end
    end
  elseif buffTargetType == BuffTargetType.MonsterAI then
    local cfgService = self._world:GetService("Config")
    local monsterConfigData = cfgService:GetMonsterConfigData()
    for i, e in ipairs(enemyEntities) do
      local monsterID = e:MonsterID()
      local monsterAIIDList = monsterConfigData:GetMonsterAIID(monsterID:GetMonsterID())
      if table.icontains(buffTargetParam, monsterAIIDList[1][1]) then
        table.insert(es, e)
      end
    end
  elseif buffTargetType == BuffTargetType.SelectMonsterID then
    local cfgService = self._world:GetService("Config")
    local monsterConfigData = cfgService:GetMonsterConfigData()
    for i, e in ipairs(enemyEntities) do
      local monsterID = e:MonsterID()
      if table.icontains(buffTargetParam, monsterID:GetMonsterID()) then
        table.insert(es, e)
      end
    end
  elseif buffTargetType == BuffTargetType.MaxDamageDealerPetToSelf then
    local cDamageStatistics = casterEntity:DamageStatisticsComponent()
    if cDamageStatistics then
      local array = cDamageStatistics:GetDamageSourceArray()
      for i = #array, 1, -1 do
        local e = self._world:GetEntityByID(array[i].entityID)
        if e:HasPetPstID() then
          table.insert(es, e)
          break
        end
      end
    end
  elseif buffTargetType == BuffTargetType.NonCasterPetElement then
    local teamMembers = teamEntity:Team():GetTeamPetEntities()
    for i, e in ipairs(teamMembers) do
      local element = e:Element():GetPrimaryType()
      if e:GetID() ~= casterEntity:GetID() and table.icontains(buffTargetParam, element) then
        table.insert(es, e)
      end
    end
  elseif buffTargetType == BuffTargetType.BodyAreaGridElementProp then
    es = self:CalTargets_BodyAreaGridElementProp(buffTargetParam, enemyEntities)
  elseif buffTargetType == BuffTargetType.BodyAreaGridFindElement then
    es = self:CalTargets_BodyAreaGridFindElement(buffTargetParam, enemyEntities)
  elseif buffTargetType == BuffTargetType.CasterTeamLeader then
    local caster = casterEntity
    if caster:HasSuperEntity() then
      caster = caster:GetSuperEntity()
    end
    local cPet = caster:Pet()
    if cPet then
      local eTeam = cPet:GetOwnerTeamEntity()
      local cTeam = eTeam:Team()
      local eTeamLeader = cTeam:GetTeamLeaderEntity()
      table.insert(es, eTeamLeader)
    end
  elseif buffTargetType == BuffTargetType.AllAliveMonster then
    local excludeSelf = type(buffTargetParam) == "table" and buffTargetParam.ExcludeSelf == 1
    local t = {}
    local caster = casterEntity
    if casterEntity:HasSuperEntity() then
      caster = casterEntity:GetSuperEntity()
    end
    for i = 1, #enemyEntities do
      if 0 < enemyEntities[i]:Attributes():GetCurrentHP() and (not excludeSelf or enemyEntities[i]:GetID() ~= caster:GetID()) then
        table.insert(t, enemyEntities[i])
      end
    end
    enemyEntities = t
    return enemyEntities
  elseif buffTargetType == BuffTargetType.AllPetAndFeatureHolder then
    local teamMembers = teamEntity:Team():GetTeamPetEntities()
    for i, e in ipairs(teamMembers) do
      if not e:HasPetDeadMark() then
        es[#es + 1] = e
      end
    end
    local lsvcFeature = self._world:GetService("FeatureLogic")
    if lsvcFeature then
      local holder = lsvcFeature:GetFeatureSkillHolderEntity(FeatureType.PersonaSkill)
      if holder then
        es[#es + 1] = holder
      end
    end
    return es
  elseif buffTargetType == BuffTargetType.CurrentTeamLeader then
    local teamEntity = self._world:Player():GetCurrentTeamEntity()
    if teamEntity then
      local teamLeader = teamEntity:Team():GetTeamLeaderEntity()
      table.insert(es, teamLeader)
    end
  elseif buffTargetType == BuffTargetType.CurrentTeamTail then
    local teamEntity = self._world:Player():GetCurrentTeamEntity()
    if teamEntity then
      local cTeam = teamEntity:Team()
      local teamOrder = cTeam:GetTeamOrder()
      local finalIndex = #teamOrder
      local lastPetPstID = teamOrder[finalIndex]
      local lastPetEntity = cTeam:GetPetEntityByPetPstID(lastPetPstID)
      table.insert(es, lastPetEntity)
    end
  elseif buffTargetType == BuffTargetType.SpTrap then
    local listTrap = self._world:GetGroupEntities(self._world.BW_WEMatchers.Trap)
    for i = 1, #listTrap do
      local targetEntity = listTrap[i]
      local trapIDCmpt = targetEntity:TrapID()
      local trapID = trapIDCmpt:GetTrapID()
      if table.icontains(buffTargetParam, trapID) then
        table.insert(es, targetEntity)
      end
    end
  elseif buffTargetType == BuffTargetType.PartOfAllMonster then
    local randomSvc = self._world:GetService("RandomLogic")
    local totalMonsterCount = #enemyEntities
    if 1 < totalMonsterCount then
      local partRate = 0.5
      if type(buffTargetParam) == "table" and buffTargetParam.CountRate then
        partRate = buffTargetParam.CountRate
      end
      local needCount = math.ceil(totalMonsterCount * partRate)
      randomSvc:Shuffle(enemyEntities)
      local randTargets = {}
      for i = 1, needCount do
        if i <= totalMonsterCount then
          table.insert(randTargets, enemyEntities[i])
        end
      end
      return randTargets
    else
      return enemyEntities
    end
  elseif buffTargetType == BuffTargetType.RandCountMonsterWithBuff then
    if type(buffTargetParam) == "table" and buffTargetParam.MatchBuffList then
      local matchBuffList = buffTargetParam.MatchBuffList
      if matchBuffList then
        local randomSvc = self._world:GetService("RandomLogic")
        local matchBuffTargets = {}
        for index, enemyEneity in ipairs(enemyEntities) do
          local buffCmp = enemyEneity:BuffComponent()
          if buffCmp then
            local findBuff = false
            for _, buffEffect in ipairs(matchBuffList) do
              if buffCmp:HasBuffEffect(buffEffect) then
                findBuff = true
                break
              end
            end
            if findBuff then
              table.insert(matchBuffTargets, enemyEneity)
            end
          end
        end
        local matchTargetCount = #matchBuffTargets
        if matchTargetCount == 0 then
          return {}
        end
        local countMin = buffTargetParam.CountMin or 1
        local countMax = buffTargetParam.CountMax or 1
        local randCount = randomSvc:LogicRand(countMin, countMax)
        randomSvc:Shuffle(matchBuffTargets)
        local randTargets = {}
        for i = 1, randCount do
          if i <= matchTargetCount then
            table.insert(randTargets, matchBuffTargets[i])
          else
            break
          end
        end
        return randTargets
      end
    end
    return {}
  elseif buffTargetType == BuffTargetType.MonsterAICheckScopeHasTargetTrap then
    local aiID = buffTargetParam[1]
    local skillID = buffTargetParam[2]
    local trapID = buffTargetParam[3]
    local hasTrap = buffTargetParam[4] or 0
    local cfgService = self._world:GetService("Config")
    local monsterConfigData = cfgService:GetMonsterConfigData()
    for i, e in ipairs(enemyEntities) do
      local monsterID = e:MonsterID()
      local monsterAIIDList = monsterConfigData:GetMonsterAIID(monsterID:GetMonsterID())
      if aiID == monsterAIIDList[1][1] then
        local selfPos = e:GetGridPosition()
        local dir = e:GridLocation().Direction
        local selfBodyArea = e:BodyArea():GetArea()
        local skillResult = self:_CalculateSkillScope(skillID, selfPos, dir, selfBodyArea)
        local skillRange = skillResult:GetAttackRange()
        local scopeHasTrapCount = 0
        local trapServerLogic = self._world:GetService("TrapLogic")
        local tarpPosList = trapServerLogic:FindTrapPosByTrapID(trapID)
        for _, pos in ipairs(tarpPosList) do
          if table.intable(skillRange, pos) then
            scopeHasTrapCount = scopeHasTrapCount + 1
          end
        end
        if hasTrap == 0 and scopeHasTrapCount == 0 then
          table.insert(es, e)
        elseif hasTrap ~= 0 and 0 < scopeHasTrapCount then
          table.insert(es, e)
        end
      end
    end
  elseif buffTargetType == BuffTargetType.Host then
    if casterEntity:HasAI() then
      local aiComponent = casterEntity:AI()
      local attachMonsterID = aiComponent:GetRuntimeData("AttachMonsterID")
      local hostEntity = self._world:GetEntityByID(attachMonsterID)
      if hostEntity then
        table.insert(es, hostEntity)
      end
    end
  elseif buffTargetType == BuffTargetType.PetJobsAndElement then
    local jobTypeList = buffTargetParam.JobType
    local elementTypeList = buffTargetParam.ElementType
    local teamMembers = teamEntity:Team():GetTeamPetEntities()
    for i, e in ipairs(teamMembers) do
      if not e:HasPetDeadMark() then
        local petPstID = e:PetPstID():GetPstID()
        local petElement = e:Element():GetPrimaryType()
        local petData = self._world:GetPetData(petPstID)
        local petJob = petData:GetJob()
        if table.icontains(jobTypeList, petJob) and table.icontains(elementTypeList, petElement) then
          es[#es + 1] = e
        end
      end
    end
  elseif buffTargetType == BuffTargetType.FettersPet then
    local fettersCmpt = casterEntity:Fetters()
    if fettersCmpt then
      local entityID = fettersCmpt:GetFettersPetEntityID()
      local fettersPetEntity = self._world:GetEntityByID(entityID)
      if fettersPetEntity and not fettersPetEntity:HasPetDeadMark() then
        table.insert(es, fettersPetEntity)
      end
    end
  elseif buffTargetType == BuffTargetType.FarestMonsterNoBuff then
    local selectMonster
    local MonsterEntityArray = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
    local disLen = 0
    local ownerPos = casterEntity:GetGridPosition()
    for k, monsterEntity in ipairs(MonsterEntityArray) do
      if not monsterEntity:HasDeadMark() then
        local conform = false
        local buffCmpt = monsterEntity:BuffComponent()
        for _, buffEffectID in ipairs(buffTargetParam) do
          if not buffCmpt:HasBuffEffect(buffEffectID) then
            conform = true
          end
        end
        if conform then
          local monsterPos = monsterEntity:GetGridPosition()
          local distance = Vector2.Distance(monsterPos, ownerPos)
          if disLen < distance then
            disLen = distance
            selectMonster = monsterEntity
          end
        end
      end
    end
    es = {selectMonster}
  elseif buffTargetType == BuffTargetType.MinAttackPet then
    local minAttackPet
    local minAttackValue = 0
    local teamMembers = teamEntity:Team():GetTeamPetEntities()
    for _, pet in ipairs(teamMembers) do
      if not pet:HasPetDeadMark() then
        local petPstID = pet:PetPstID():GetPstID()
        local petData = self._world:GetPetData(petPstID)
        if not minAttackPet then
          minAttackPet = pet
          minAttackValue = petData:GetPetAttack()
        elseif minAttackValue > petData:GetPetAttack() then
          minAttackPet = pet
          minAttackValue = petData:GetPetAttack()
        end
      end
    end
    if minAttackPet then
      table.insert(es, minAttackPet)
    end
  elseif buffTargetType == BuffTargetType.SkillHolderName then
    casterEntity = casterEntity or teamEntity
    local skillHolderName = buffTargetParam
    if type(buffTargetParam) == "table" then
      skillHolderName = tostring(buffTargetParam[1])
    end
    local skillHolderID = casterEntity:GetSkillHolder(skillHolderName)
    local skillHolder = self._world:GetEntityByID(skillHolderID)
    es[#es + 1] = skillHolder
  elseif buffTargetType == BuffTargetType.AutoBeadHolder then
    local autoBeadServiceLogic = self._world:GetService("AutoBeadLogic")
    local holderEntity = autoBeadServiceLogic:GetAutoBeadSkillHolder(teamEntity)
    es = {holderEntity}
  elseif buffTargetType == BuffTargetType.AnyAroundMonster then
    local curPos = casterEntity:GetGridPosition()
    local curBodyArea = casterEntity:BodyArea():GetArea()
    local ringCount
    if buffTargetParam ~= 0 then
      ringCount = buffTargetParam
    else
      ringCount = 1
    end
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
    local scopeResult = scopeCalculator:ComputeScopeRange(SkillScopeType.SquareRing, {ringCount, 0}, curPos, curBodyArea)
    local attackRange = scopeResult:GetAttackRange()
    for _, e in ipairs(enemyEntities) do
      local pos = e:GetGridPosition()
      local bodyArea = e:BodyArea():GetArea()
      for i, area in ipairs(bodyArea) do
        local curMonsterBodyPos = pos + area
        if table.intable(attackRange, curMonsterBodyPos) then
          table.insert(es, e)
          break
        end
      end
    end
  end
  return es
end

function BuffLogicService:AddBuffLayer(entity, buffEffectType, layer, pos, casterEntity)
  pos = pos or entity:GetGridPosition()
  local bc = entity:BuffComponent()
  if not bc then
    return 0
  end
  local buffinst = bc:GetSingleBuffByBuffEffect(buffEffectType)
  if not buffinst then
    return 0
  end
  local oldFinalVal = buffinst:GetLayerCount()
  local newLayer, changeLayer, overflowLayer = buffinst:AddLayerCount(layer)
  local key = buffinst:GetBuffLayerName()
  local layerName = buffinst:GetBuffLayerName()
  local totalKey = string.format(BattleConst.AddBuffLayerTotalKeyFormatter, layerName)
  local count = bc:GetBuffValue(totalKey) or 0
  count = count + layer
  bc:SetBuffValue(totalKey, count)
  local nt = NTNotifyLayerChange:New(key, layer, count, pos, entity, buffEffectType, casterEntity)
  nt.__oldFinalLayer = oldFinalVal
  nt:SetChangeLayer(changeLayer)
  nt:SetOverflowLayer(overflowLayer)
  self._world:GetService("Trigger"):Notify(nt)
  return newLayer, buffinst, overflowLayer
end

function BuffLogicService:GetBuffTotalLayer(entity, layerName)
  local bc = entity:BuffComponent()
  if bc then
    local totalKey = string.format(BattleConst.AddBuffLayerTotalKeyFormatter, layerName)
    local layer = bc:GetBuffValue(totalKey) or 0
    return layer
  end
  return 0
end

function BuffLogicService:GetBuffLayer(entity, buffEffectType)
  local bc = entity:BuffComponent()
  if bc then
    local key = self:GetBuffLayerName(buffEffectType)
    local layer = bc:GetBuffValue(key) or 0
    local mul = bc:GetBuffValue(key .. "Mul")
    if mul and layer then
      layer = layer * mul
    end
    if layer < 0 then
      layer = 0
    end
    return layer
  end
  return 0
end

function BuffLogicService:ClearBuffLayer(entity, buffEffectType)
  local bc = entity:BuffComponent()
  if bc then
    local key = self:GetBuffLayerName(buffEffectType)
    local oldLayer = bc:GetBuffValue(key) or 0
    bc:SetBuffValue(key, 0)
    local totalKey = string.format(BattleConst.AddBuffLayerTotalKeyFormatter, key)
    local count = bc:GetBuffValue(totalKey) or 0
    local instance = bc:GetSingleBuffByBuffEffect(buffEffectType)
    local casterEntity = instance and instance:Context() and instance:Context().casterEntity or nil
    local nt = NTNotifyLayerChange:New(key, 0, count, entity:GetGridPosition(), entity, buffEffectType, casterEntity)
    nt:SetChangeLayer(-oldLayer)
    self._world:GetService("Trigger"):Notify(nt)
  end
end

function BuffLogicService:SetBuffLayer(entity, buffEffectType, layer, silenced)
  local bc = entity:BuffComponent()
  if bc then
    if layer < 0 then
      layer = 0
    end
    local instance = bc:GetSingleBuffByBuffEffect(buffEffectType)
    if instance then
      local maxLayer = instance:GetMaxBuffLayerCount()
      if 0 < maxLayer and layer > maxLayer then
        Log.info(self._className, "request layer ", layer, " exceeds its limit: ", maxLayer)
        layer = maxLayer
      end
    elseif layer ~= 0 then
      Log.error(self._className, "尝试给没有计层buff的单位设置层数：buffEffectType:", buffEffectType, " layer:", layer, "trace:\n", Log.traceback())
    end
    local key = self:GetBuffLayerName(buffEffectType)
    local old = bc:GetBuffValue(key) or 0
    bc:SetBuffValue(key, layer)
    local totalKey = string.format(BattleConst.AddBuffLayerTotalKeyFormatter, key)
    local count = bc:GetBuffValue(totalKey) or 0
    local casterEntity = instance and instance:Context() and instance:Context().casterEntity or nil
    if not silenced then
      local nt = NTNotifyLayerChange:New(key, layer, count, entity:GetGridPosition(), entity, buffEffectType, casterEntity)
      nt.__oldFinalLayer = old
      nt:SetChangeLayer(layer - old)
      self._world:GetService("Trigger"):Notify(nt)
    end
    return layer, instance
  end
end

function BuffLogicService:SetBuffLayerMul(entity, buffEffectType, mul)
  local bc = entity:BuffComponent()
  if bc then
    local key = self:GetBuffLayerName(buffEffectType)
    bc:SetBuffValue(key .. "Mul", mul)
  end
end

function BuffLogicService:GetBuffLayerName(buffEffectType)
  return "Layer" .. buffEffectType
end

function BuffLogicService:CheckElementImmunity(attacker, defender)
  local elementList = defender:Attributes():GetAttribute("BuffElementImmunity")
  local utilSvc = self._world:GetService("UtilData")
  local element = utilSvc:GetEntityElementType(attacker, true)
  if elementList ~= nil then
    for _, el in ipairs(elementList) do
      if element == el then
        return true
      end
    end
  end
  return false
end

function BuffLogicService:CheckLayerShield(entity)
  local buffComponent = entity:BuffComponent()
  if not buffComponent then
    return false, 0
  end
  local buffinst = buffComponent:GetSingleBuffByBuffEffect(BuffEffectType.LayerShield)
  if not buffinst then
    return false, 0
  end
  local shieldLayer = buffinst:GetLayerCount()
  if not shieldLayer or shieldLayer == 0 then
    return false, 0
  end
  return true, shieldLayer
end

function BuffLogicService:ReduceLayerShield(entity, layerCount, reducedAmount)
  self:GetService("Trigger"):Notify(NTReduceShieldLayer:New(entity, layerCount - reducedAmount))
end

function BuffLogicService:CheckAndReduceShield(entity)
  local hasLayerShield, shieldLayer = self:CheckLayerShield(entity)
  if not hasLayerShield then
    return false
  end
  self:ReduceLayerShield(entity, shieldLayer, 1)
  return true
end

function BuffLogicService:CheckBreakInvincible(entity)
  if not entity then
    return false
  end
  local buffCom = entity:BuffComponent()
  return buffCom and buffCom:HasFlag(BuffFlags.BreakInvincible)
end

function BuffLogicService:CheckControlled(entity)
  local cBuff = entity:BuffComponent()
  if cBuff then
    local buff = cBuff:GetBuffArrayByBuffType(BuffType.Control)
    return buff and table.count(buff) > 0
  end
  return false
end

function BuffLogicService:CheckCanAddBuff(caster, defender)
  if not self:CheckBreakInvincible(caster) and self:CheckInvincible(defender) then
    return false
  elseif defender:Attributes():GetAttribute("BuffMonsterSkillImmunity") and (caster:HasPetPstID() or caster:HasSuperEntity() and caster:GetSuperEntity():HasPetPstID() and caster:EntityType():IsSkillHolder()) then
    return false
  end
  return true
end

function BuffLogicService:CheckCanBePullAround(entity)
  if self:CheckInvincible(entity) then
    return false
  end
  if self:CheckImmuneTranslate(entity, "ImmunePullAround") then
    return false
  end
  return true
end

function BuffLogicService:CheckCanBeDamage(attacker, defender, skillID, ignoreShield)
  local skillLogicService = self:GetService("SkillLogic")
  local isNormalSkill = skillLogicService:CheckNormalSkill(skillID)
  local isSingleEntitySkill = skillLogicService:IsSelectEntitySkill(skillID)
  local isGridSkill = skillLogicService:IsSelectGridSkill(skillID)
  local isAutoBeadSkill = skillLogicService:CheckAutoBeadSkill(skillID)
  local isAttackerTeamMember = false
  if attacker:HasPet() then
    local teamEntity = attacker:Pet():GetOwnerTeamEntity()
    if teamEntity then
      isAttackerTeamMember = not teamEntity:Team():IsTeamLeaderByEntityId(attacker:GetID())
    end
  end
  local attrComp = defender:Attributes()
  if not attrComp then
    Log.error("CheckCanBeDamage() defender has no attrComp")
    return DamageType.Guard
  end
  local cDefBuff = defender:BuffComponent()
  local damageType = DamageType.Normal
  if attacker:EntityType():IsAutoBeadSkillHolder() and isAutoBeadSkill then
    local bMiss = self:CheckAutoBeadSkillMiss(skillID, attacker, defender)
    if bMiss then
      damageType = DamageType.Miss
      return damageType
    end
  end
  if skillID and 0 < skillID and self:CheckMissAndEvade(skillID, attacker, defender) then
    damageType = DamageType.Miss
  elseif not self:CheckBreakInvincible(attacker) and self:CheckInvincible(defender) then
    damageType = DamageType.Guard
  elseif not ignoreShield and self:CheckAndReduceShield(defender) then
    damageType = DamageType.Guard
  elseif isNormalSkill and attrComp:GetAttribute("BuffAtkImmunity") then
    damageType = DamageType.Guard
  elseif not isNormalSkill and attrComp:GetAttribute("BuffMonsterSkillImmunity") then
    if attacker:HasPetPstID() or attacker:HasSuperEntity() and attacker:GetSuperEntity():HasPetPstID() and attacker:EntityType():IsSkillHolder() then
      damageType = DamageType.Guard
    end
  elseif self:CheckElementImmunity(attacker, defender) then
    damageType = DamageType.Guard
  elseif isSingleEntitySkill and attrComp:GetAttribute("BuffSingleEntitySkillImmunity") then
    damageType = DamageType.Miss
  elseif isNormalSkill and attrComp:GetAttribute("BuffNormalSkillImmunity") then
    damageType = DamageType.Miss
  elseif isGridSkill and attrComp:GetAttribute("BuffGridSkillImmunity") then
    damageType = DamageType.Miss
  elseif isNormalSkill and cDefBuff:GetBuffValue("MaxNormalAtkCount") and cDefBuff:GetBuffValue("CurrentNormalAtkCount") then
    if cDefBuff:GetBuffValue("CurrentNormalAtkCount") >= cDefBuff:GetBuffValue("MaxNormalAtkCount") then
      damageType = DamageType.Guard
    end
  elseif isAttackerTeamMember and attrComp:GetAttribute("BuffGuardDamageFromTeamMember") then
    damageType = DamageType.Guard
  end
  return damageType
end

function BuffLogicService:GetLayerShield(entity)
  local layer = 0
  local buffComponent = entity:BuffComponent()
  if buffComponent then
    local buffInstanceLayerShield = buffComponent:GetSingleBuffByBuffEffect(BuffEffectType.LayerShield)
    if buffInstanceLayerShield then
      layer = buffInstanceLayerShield:GetLayerCount()
    end
  end
  return layer
end

function BuffLogicService:CheckAutoBeadSkillMiss(skillID, attacker, defender)
  local autoBeadCmpt = attacker:LogicAutoBead()
  if autoBeadCmpt then
    local autoBeadAttackDataCmpt = attacker:SkillAutoBeadAttackData()
    if autoBeadAttackDataCmpt then
      local curAutoBeadID = autoBeadAttackDataCmpt:GetCurrentAutoBeadID()
      if curAutoBeadID and 0 < curAutoBeadID then
        local autoBeadData = autoBeadCmpt:GetAutoBeadInnerDataByID(curAutoBeadID)
        if autoBeadData then
          local hitRate = autoBeadData:GetAutoBeadAttr(ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_Hit)
          hitRate = hitRate / 1000
          local randomSvc = self._world:GetService("RandomLogic")
          local random = randomSvc:LogicRand()
          if hitRate < random then
            return true
          end
        end
      end
    end
  end
  return false
end

function BuffLogicService:CheckMissAndEvade(skillID, attacker, defender)
  local defenderBuff = defender:BuffComponent()
  if defenderBuff and defenderBuff:HasFlag(BuffFlags.Benumb) then
    return false
  end
  local nEvadeEffect = 0
  local attrDefender = defender:Attributes()
  local nEvadeBase = attrDefender and attrDefender:GetAttribute("Evade") or 0
  nEvadeEffect = nEvadeBase
  local cBuffDef = defender:BuffComponent()
  if cBuffDef then
    local skillLogicService = self:GetService("SkillLogic")
    local isNormalSkill = skillLogicService:CheckNormalSkill(skillID)
    if isNormalSkill then
      local normalSkillEvade = cBuffDef:GetBuffValue("NormalSkillEvade") or 0
      nEvadeEffect = nEvadeEffect + normalSkillEvade
    end
  end
  local buffAttacker = attacker:BuffComponent()
  if buffAttacker then
    local nMiss = 0
    nMiss = buffAttacker:GetBuffValue("Miss") or 0
    if not self:IsSameTeam(attacker, defender) then
      nEvadeEffect = nEvadeEffect + nMiss
    end
  end
  if nEvadeEffect <= 0 then
    return false
  end
  local randomSvc = self._world:GetService("RandomLogic")
  local random = randomSvc:LogicRand()
  if nEvadeEffect >= random then
    return true
  end
  return false
end

function BuffLogicService:IsSameTeam(attacker, defender)
  local attackerTeamEntityID
  if attacker:HasPet() then
    local teamEntity = attacker:Pet():GetOwnerTeamEntity()
    attackerTeamEntityID = teamEntity:GetID()
  elseif attacker:HasTeam() then
    attackerTeamEntityID = attacker:GetID()
  end
  local defenderTeamEntityID
  if defender:HasPet() then
    local teamEntity = defender:Pet():GetOwnerTeamEntity()
    defenderTeamEntityID = teamEntity:GetID()
  elseif defender:HasTeam() then
    defenderTeamEntityID = defender:GetID()
  end
  if defenderTeamEntityID and attackerTeamEntityID and defenderTeamEntityID == attackerTeamEntityID then
    return true
  end
  return false
end

function BuffLogicService:AutoRemoveBuffByHit(entityWork)
  local buffComponent = entityWork:BuffComponent()
  if nil == buffComponent then
    return
  end
  local listAutoRemoveByHit = buffComponent:GetAutoRemoveByHit()
  for i = 1, #listAutoRemoveByHit do
    local nBuffID = listAutoRemoveByHit[i]
    local pBuffInstance = buffComponent:FindBuffByBuffID(nBuffID)
    if pBuffInstance and pBuffInstance:GetWorkRountCount() > 0 then
      self:RemoveBuffEffect(pBuffInstance)
      buffComponent:RemoveBuff(pBuffInstance)
      buffComponent:DelAutoRemoveByHit(nBuffID)
    end
  end
end

function BuffLogicService:DoGuideLockRoundCount(teamEntity)
  if not teamEntity then
    return false
  end
  local buffCmpt = teamEntity:BuffComponent()
  if buffCmpt == nil then
    return false
  end
  local buffInstance = buffCmpt:GetSingleBuffByBuffEffect(BuffEffectType.GuideLockRoundCount)
  if buffInstance then
    local guideRoundCount = buffCmpt:GetBuffValue("GuideLockRoundCount")
    local battleStatCmpt = self._world:BattleStat()
    if guideRoundCount >= battleStatCmpt:GetLevelLeftRoundCount() then
      return true
    end
  end
  return false
end

function BuffLogicService:GetAttributeValue(entity, attributeName)
  local value = entity:Attributes():GetAttribute(attributeName)
  return value
end

function BuffLogicService:GetEntityAttackValue(entity)
  local baseAttack = entity:Attributes():GetAttribute("Attack")
  local attackConstantFix = entity:Attributes():GetAttribute("AttackConstantFix") or 0
  local attackPercentage = entity:Attributes():GetAttribute("AttackPercentage") or 0
  return math.floor(baseAttack * (1 + attackPercentage) + attackConstantFix)
end

function BuffLogicService:GetEntityDefenceValue(entity)
  local defence = entity:Attributes():GetAttribute("Defense") or 1
  local sFormula = self._world:GetService("Formula")
  local defencePercentage = sFormula:CalcDefencePercentage(entity)
  local defenceConstantFix = sFormula:CalcDefenceConstantFix(entity)
  return math.floor(defence * (1 + defencePercentage) + defenceConstantFix)
end

function BuffLogicService:GetEntityMaxHPValue(entity)
  local attributeCmpt
  if entity:HasPetPstID() then
    local teamEntity = entity:Pet():GetOwnerTeamEntity()
    attributeCmpt = teamEntity:Attributes()
  else
    attributeCmpt = entity:Attributes()
  end
  local maxHP = attributeCmpt:CalcMaxHp()
  return maxHP
end

function BuffLogicService:_GetAttributeModifier(entity, attributeName)
  local cAttributes = entity:Attributes()
  if cAttributes then
    local modifier = cAttributes:GetAttributeModifier(attributeName)
    return modifier
  else
    self:PrintBuffLogicSvcLog("### no Attributes component on entity. EntityId=", entity:GetID())
  end
end

function BuffLogicService:_AddAttributeValue(entity, attributeName, modifierID, value)
  local modifier = self:_GetAttributeModifier(entity, attributeName)
  if modifier then
    modifier:AddModify(value, modifierID)
    self:PrintBuffLogicSvcLog("_AddAttributeValue() entity=", entity:GetID(), " attributeName=", attributeName, " modifyValue=", value, " finalValue=", modifier:Value())
  else
    self:PrintBuffLogicSvcLog("_AddAttributeValue() not find modifier! ", attributeName, modifierID, value)
  end
end

function BuffLogicService:_RemoveAttributeValue(entity, attributeName, modifierID)
  local modifier = self:_GetAttributeModifier(entity, attributeName)
  if modifier then
    modifier:RemoveModify(modifierID)
    self:PrintBuffLogicSvcLog("_RemoveAttributeValue() entity=", entity:GetID(), " attributeName=", attributeName, " finalValue=", modifier:Value())
  else
    self:PrintBuffLogicSvcLog("_RemoveAttributeValue() not find modifier! ", attributeName, modifierID)
  end
end

function BuffLogicService:ChangeBaseAttack(entity, modifierID, modifyType, value)
  local modifier
  if modifyType == ModifyBaseAttackType.Attack then
    self:_AddAttributeValue(entity, "Attack", modifierID, value)
  elseif modifyType == ModifyBaseAttackType.AttackPercentage then
    self:_AddAttributeValue(entity, "AttackPercentage", modifierID, value)
  elseif modifyType == ModifyBaseAttackType.AttackConstantFix then
    self:_AddAttributeValue(entity, "AttackConstantFix", modifierID, value)
  end
end

function BuffLogicService:RemoveBaseAttack(entity, modifierID, modifyType)
  local modifier
  if modifyType == ModifyBaseAttackType.Attack then
    self:_RemoveAttributeValue(entity, "Attack", modifierID)
  elseif modifyType == ModifyBaseAttackType.AttackPercentage then
    self:_RemoveAttributeValue(entity, "AttackPercentage", modifierID)
  elseif modifyType == ModifyBaseAttackType.AttackConstantFix then
    self:_RemoveAttributeValue(entity, "AttackConstantFix", modifierID)
  end
end

function BuffLogicService:ChangeBaseDefence(entity, modifierID, modifyType, value)
  local modifier
  if modifyType == ModifyBaseDefenceType.Defense then
    self:_AddAttributeValue(entity, "Defense", modifierID, value)
  elseif modifyType == ModifyBaseDefenceType.DefencePercentage then
    self:_AddAttributeValue(entity, "DefencePercentage", modifierID, value)
  elseif modifyType == ModifyBaseDefenceType.DefenceConstantFix then
    self:_AddAttributeValue(entity, "DefenceConstantFix", modifierID, value)
  end
end

function BuffLogicService:RemoveBaseDefence(entity, modifierID, modifyType)
  local modifier
  if modifyType == ModifyBaseDefenceType.Defense then
    self:_RemoveAttributeValue(entity, "Defense", modifierID)
  elseif modifyType == ModifyBaseDefenceType.DefencePercentage then
    self:_RemoveAttributeValue(entity, "DefencePercentage", modifierID)
  elseif modifyType == ModifyBaseDefenceType.DefenceConstantFix then
    self:_RemoveAttributeValue(entity, "DefenceConstantFix", modifierID)
  end
end

function BuffLogicService:GetBaseDefence(entity, modifierID, modifyType)
  local modifier
  local modifyValue = 0
  if modifyType == ModifyBaseDefenceType.Defense then
    modifier = self:_GetAttributeModifier(entity, "Defense")
  elseif modifyType == ModifyBaseDefenceType.DefencePercentage then
    modifier = self:_GetAttributeModifier(entity, "DefencePercentage")
  elseif modifyType == ModifyBaseDefenceType.DefenceConstantFix then
    modifier = self:_GetAttributeModifier(entity, "DefenceConstantFix")
  end
  if modifier then
    modifyValue = modifier:GetModifyValue(modifierID) or 0
  end
  return modifyValue
end

function BuffLogicService:ChangeBaseMaxHP(entity, modifierID, modifyType, value)
  local modifier
  if modifyType == ModifyBaseMaxHPType.MaxHPPercentage then
    self:_AddAttributeValue(entity, "MaxHPPercentage", modifierID, value)
  elseif modifyType == ModifyBaseMaxHPType.MaxHPConstantFix then
    self:_AddAttributeValue(entity, "MaxHPConstantFix", modifierID, value)
  end
end

function BuffLogicService:RemoveBaseMaxHP(entity, modifierID, modifyType)
  local modifier
  if modifyType == ModifyBaseMaxHPType.MaxHPPercentage then
    self:_RemoveAttributeValue(entity, "MaxHPPercentage", modifierID)
  elseif modifyType == ModifyBaseMaxHPType.MaxHPConstantFix then
    self:_RemoveAttributeValue(entity, "MaxHPConstantFix", modifierID)
  end
end

function BuffLogicService:ChangeSkillIncrease(entity, modifierID, modifyType, value)
  local modifier
  if modifyType == ModifySkillIncreaseParamType.NormalSkill then
    self:_AddAttributeValue(entity, "NormalSkillIncreaseParam", modifierID, value)
  elseif modifyType == ModifySkillIncreaseParamType.ChainSkill then
    self:_AddAttributeValue(entity, "ChainSkillIncreaseParam", modifierID, value)
  elseif modifyType == ModifySkillIncreaseParamType.ActiveSkill then
    self:_AddAttributeValue(entity, "ActiveSkillIncreaseParam", modifierID, value)
  elseif modifyType == ModifySkillIncreaseParamType.MonsterDamage then
    self:_AddAttributeValue(entity, "MonsterSkillIncreaseParam", modifierID, value)
  elseif modifyType == ModifySkillIncreaseParamType.TrapDamage then
    self:_AddAttributeValue(entity, "TrapSkillIncreaseParam", modifierID, value)
  elseif modifyType == ModifySkillIncreaseParamType.CampSkill then
    self:_AddAttributeValue(entity, "CampSkillIncreaseParam", modifierID, value)
  end
end

function BuffLogicService:RemoveSkillIncrease(entity, modifierID, modifyType)
  local modifier
  if modifyType == ModifySkillIncreaseParamType.NormalSkill then
    self:_RemoveAttributeValue(entity, "NormalSkillIncreaseParam", modifierID)
  elseif modifyType == ModifySkillIncreaseParamType.ChainSkill then
    self:_RemoveAttributeValue(entity, "ChainSkillIncreaseParam", modifierID)
  elseif modifyType == ModifySkillIncreaseParamType.ActiveSkill then
    self:_RemoveAttributeValue(entity, "ActiveSkillIncreaseParam", modifierID)
  elseif modifyType == ModifySkillIncreaseParamType.MonsterDamage then
    self:_RemoveAttributeValue(entity, "MonsterSkillIncreaseParam", modifierID)
  elseif modifyType == ModifySkillIncreaseParamType.TrapDamage then
    self:_RemoveAttributeValue(entity, "TrapSkillIncreaseParam", modifierID)
  elseif modifyType == ModifySkillIncreaseParamType.CampSkill then
    self:_RemoveAttributeValue(entity, "CampSkillIncreaseParam", modifierID)
  end
end

function BuffLogicService:ChangeSkillParam(entity, modifierID, modifyType, value)
  local modifier
  if modifyType == ModifySkillParamType.NormalSkill then
    self:_AddAttributeValue(entity, "NormalSkillParam", modifierID, value)
  elseif modifyType == ModifySkillParamType.ChainSkill then
    self:_AddAttributeValue(entity, "ChainSkillParam", modifierID, value)
  elseif modifyType == ModifySkillParamType.ActiveSkill then
    self:_AddAttributeValue(entity, "ActiveSkillParam", modifierID, value)
  elseif modifyType == ModifySkillParamType.MonsterDamage then
    self:_AddAttributeValue(entity, "MonsterSkillParam", modifierID, value)
  end
end

function BuffLogicService:RemoveSkillParam(entity, modifierID, modifyType)
  local modifier
  if modifyType == ModifySkillParamType.NormalSkill then
    self:_RemoveAttributeValue(entity, "NormalSkillParam", modifierID)
  elseif modifyType == ModifySkillParamType.ChainSkill then
    self:_RemoveAttributeValue(entity, "ChainSkillParam", modifierID)
  elseif modifyType == ModifySkillParamType.ActiveSkill then
    self:_RemoveAttributeValue(entity, "ActiveSkillParam", modifierID)
  elseif modifyType == ModifySkillParamType.MonsterDamage then
    self:_RemoveAttributeValue(entity, "MonsterSkillParam", modifierID)
  end
end

function BuffLogicService:ChangeExElementParam(entity, modifierID, value)
  self:_AddAttributeValue(entity, "ExElementParam", modifierID, value)
end

function BuffLogicService:RemoveExElementParam(entity, modifierID)
  self:_RemoveAttributeValue(entity, "ExElementParam", modifierID)
end

function BuffLogicService:ChangeExBeHitElementParam(entity, modifierID, value)
  self:_AddAttributeValue(entity, "ExBeHitElementParam", modifierID, value)
end

function BuffLogicService:RemoveExBeHitElementParam(entity, modifierID)
  self:_RemoveAttributeValue(entity, "ExBeHitElementParam", modifierID)
end

function BuffLogicService:ChangeSkillFinalParam(entity, modifierID, modifyType, value)
  local modifier
  if modifyType == ModifySkillParamType.NormalSkill then
    self:_AddAttributeValue(entity, "NormalSkillFinalParam", modifierID, value)
  elseif modifyType == ModifySkillParamType.ChainSkill then
    self:_AddAttributeValue(entity, "ChainSkillFinalParam", modifierID, value)
  elseif modifyType == ModifySkillParamType.ActiveSkill then
    self:_AddAttributeValue(entity, "ActiveSkillFinalParam", modifierID, value)
  elseif modifyType == ModifySkillParamType.MonsterDamage then
    self:_AddAttributeValue(entity, "MonsterSkillFinalParam", modifierID, value)
  elseif modifyType == ModifySkillParamType.SanSkill then
    self:_AddAttributeValue(entity, "SanSkillFinalParam", modifierID, value)
  elseif modifyType == ModifySkillParamType.CampSkill then
    self:_AddAttributeValue(entity, "CampSkillFinalParam", modifierID, value)
  elseif modifyType == ModifySkillParamType.AutoBeadSkill then
    self:_AddAttributeValue(entity, "AutoBeadSkillFinalParam", modifierID, value)
  end
end

function BuffLogicService:RemoveSkillFinalParam(entity, modifierID, modifyType)
  local modifier
  if modifyType == ModifySkillParamType.NormalSkill then
    self:_RemoveAttributeValue(entity, "NormalSkillFinalParam", modifierID)
  elseif modifyType == ModifySkillParamType.ChainSkill then
    self:_RemoveAttributeValue(entity, "ChainSkillFinalParam", modifierID)
  elseif modifyType == ModifySkillParamType.ActiveSkill then
    self:_RemoveAttributeValue(entity, "ActiveSkillFinalParam", modifierID)
  elseif modifyType == ModifySkillParamType.MonsterDamage then
    self:_RemoveAttributeValue(entity, "MonsterSkillFinalParam", modifierID)
  elseif modifyType == ModifySkillParamType.SanSkill then
    self:_RemoveAttributeValue(entity, "SanSkillFinalParam", modifierID)
  elseif modifyType == ModifySkillParamType.CampSkill then
    self:_RemoveAttributeValue(entity, "CampSkillFinalParam", modifierID)
  elseif modifyType == ModifySkillParamType.AutoBeadSkill then
    self:_RemoveAttributeValue(entity, "AutoBeadSkillFinalParam", modifierID)
  end
end

function BuffLogicService:GetMonsterSkillAbsorbBaseValue(entity, absorbType)
  local modifier
  if absorbType == MonsterSkillAbsorbType.NormalSkill then
    modifier = self:_GetAttributeModifier(entity, "AbsorbNormal")
  elseif absorbType == MonsterSkillAbsorbType.ChainSkill then
    modifier = self:_GetAttributeModifier(entity, "AbsorbChain")
  elseif absorbType == MonsterSkillAbsorbType.ActiveSkill then
    modifier = self:_GetAttributeModifier(entity, "AbsorbActive")
  end
  if modifier then
    local baseModifyId = 1
    return modifier:GetModifyValue(baseModifyId)
  else
    self:PrintBuffLogicSvcLog("GetMonsterSkillAbsorbBaseValue() not find modifier! type ", absorbType)
  end
end

function BuffLogicService:ChangeMonsterSkillAbsorb(entity, modifierID, modifyType, value)
  local modifier
  if modifyType == MonsterSkillAbsorbType.NormalSkill then
    self:_AddAttributeValue(entity, "AbsorbNormal", modifierID, value)
  elseif modifyType == MonsterSkillAbsorbType.ChainSkill then
    self:_AddAttributeValue(entity, "AbsorbChain", modifierID, value)
  elseif modifyType == MonsterSkillAbsorbType.ActiveSkill then
    self:_AddAttributeValue(entity, "AbsorbActive", modifierID, value)
  end
end

function BuffLogicService:RemoveMonsterSkillAbsorb(entity, modifierID, modifyType)
  local modifier
  if modifyType == MonsterSkillAbsorbType.NormalSkill then
    self:_RemoveAttributeValue(entity, "AbsorbNormal", modifierID)
  elseif modifyType == MonsterSkillAbsorbType.ChainSkill then
    self:_RemoveAttributeValue(entity, "AbsorbChain", modifierID)
  elseif modifyType == MonsterSkillAbsorbType.ActiveSkill then
    self:_RemoveAttributeValue(entity, "AbsorbActive", modifierID)
  end
end

function BuffLogicService:ChangeChainSkillReleaseFix(entity, modifierID, value)
  self:_AddAttributeValue(entity, "ChainSkillReleaseFix", modifierID, value)
end

function BuffLogicService:RemoveChainSkillReleaseFix(entity, modifierID)
  self:_RemoveAttributeValue(entity, "ChainSkillReleaseFix", modifierID)
end

function BuffLogicService:ChangeChainSkillReleaseMul(entity, modifierID, value)
  self:_AddAttributeValue(entity, "ChainSkillReleaseMul", modifierID, value)
end

function BuffLogicService:RemoveChainSkillReleaseMul(entity, modifierID)
  self:_RemoveAttributeValue(entity, "ChainSkillReleaseMul", modifierID)
end

function BuffLogicService:ChangeDamagePercentAmpfily(entity, modifierID, value)
  self:_AddAttributeValue(entity, "DamagePercentAmpfily", modifierID, value)
end

function BuffLogicService:RemoveDamagePercentAmpfily(entity, modifierID)
  self:_RemoveAttributeValue(entity, "DamagePercentAmpfily", modifierID)
end

function BuffLogicService:ChangeTrueDamageFixParam(entity, modifierID, value)
  self:_AddAttributeValue(entity, "TrueDamageFixParam", modifierID, value)
end

function BuffLogicService:RemoveTrueDamageFixParam(entity, modifierID)
  self:_RemoveAttributeValue(entity, "TrueDamageFixParam", modifierID)
end

function BuffLogicService:ChangeDamageGlancingParam(entity, modifierID, percent, maxValue)
  self:_AddAttributeValue(entity, "GlancingRate", modifierID, percent)
  self:_AddAttributeValue(entity, "GlancingMaxValue", modifierID, maxValue)
end

function BuffLogicService:RemoveDamageGlancingParam(entity, modifierID)
  self:_RemoveAttributeValue(entity, "GlancingRate", modifierID)
  self:_RemoveAttributeValue(entity, "GlancingMaxValue", modifierID)
end

function BuffLogicService:ChangeAdditionalCritProb(entity, modifierID, val)
  self:_AddAttributeValue(entity, "AdditionalCritProb", modifierID, val)
end

function BuffLogicService:RemoveAdditionalCritProb(entity, modifierID, val)
  self:_RemoveAttributeValue(entity, "AdditionalCritProb", modifierID)
end

function BuffLogicService:ChangeAdditionalCritParam(entity, modifierID, val)
  self:_AddAttributeValue(entity, "AdditionalCritParam", modifierID, val)
end

function BuffLogicService:RemoveAdditionalCritParam(entity, modifierID, val)
  self:_RemoveAttributeValue(entity, "AdditionalCritParam", modifierID)
end

function BuffLogicService:ChangeControlIncrease(entity, modifierID, val)
  self:_AddAttributeValue(entity, __AttrKey_ControlIncrease, modifierID, val)
end

function BuffLogicService:RemoveControlIncrease(entity, modifierID)
  self:_RemoveAttributeValue(entity, __AttrKey_ControlIncrease, modifierID)
end

function BuffLogicService:ChangeFinalBeHitDamageParam(entity, modifierID, value)
  self:_AddAttributeValue(entity, "FinalBehitDamageParam", modifierID, value)
end

function BuffLogicService:RemoveFinalBeHitDamageParam(entity, modifierID)
  self:_RemoveAttributeValue(entity, "FinalBehitDamageParam", modifierID)
end

function BuffLogicService:ChangeFinalBehitByTeamLeaderDamageParam(entity, modifierID, value)
  self:_AddAttributeValue(entity, "FinalBehitByTeamLeaderDamageParam", modifierID, value)
end

function BuffLogicService:RemoveFinalBehitByTeamLeaderDamageParam(entity, modifierID)
  self:_RemoveAttributeValue(entity, "FinalBehitByTeamLeaderDamageParam", modifierID)
end

function BuffLogicService:ChangeFinalBehitByTeamMemberDamageParam(entity, modifierID, value)
  self:_AddAttributeValue(entity, "FinalBehitByTeamMemberDamageParam", modifierID, value)
end

function BuffLogicService:RemoveFinalBehitByTeamMemberDamageParam(entity, modifierID)
  self:_RemoveAttributeValue(entity, "FinalBehitByTeamMemberDamageParam", modifierID)
end

function BuffLogicService:_AddBuff2AllMonster(buffIDList, monsterList, buffSource, equipIntensifyParams)
  for _, monster in ipairs(monsterList) do
    for _, buffID in ipairs(buffIDList) do
      self:AddBuff(buffID, monster, nil, buffSource, equipIntensifyParams)
    end
  end
end

function BuffLogicService:ChangeSecondaryAttackParam(entity, modifierID, val)
  self:_AddAttributeValue(entity, "SecondaryAttackParam", modifierID, val)
end

function BuffLogicService:RemoveSecondaryAttackParam(entity, modifierID, val)
  self:_RemoveAttributeValue(entity, "SecondaryAttackParam", modifierID)
end

function BuffLogicService:ChangeAllAttackParam(entity, modifierID, val)
  self:_AddAttributeValue(entity, "AllAttackParam", modifierID, val)
end

function BuffLogicService:RemoveAllAttackParam(entity, modifierID, val)
  self:_RemoveAttributeValue(entity, "AllAttackParam", modifierID)
end

function BuffLogicService:_BuildPetPassiveSkill(petEntity, configServer)
  local passiveSkillID = petEntity:SkillInfo():GetPassiveSkillID()
  local equipIntensifyParams = petEntity:SkillInfo():GetEquipIntensifyParam()
  if passiveSkillID and passiveSkillID ~= 0 then
    local config = configServer:GetPetPassiveSkill(passiveSkillID)
    if config and config.BuffID then
      local buffSource = BuffSource:New(BuffSourceType.PassiveSkill, petEntity:PetPstID():GetPstID())
      for _, buffID in ipairs(config.BuffID) do
        self:AddBuffByTargetType(buffID, config.BuffTargetType, config.BuffTargetParam, {casterEntity = petEntity}, buffSource, equipIntensifyParams, petEntity)
      end
    end
  end
end

function BuffLogicService:BuildPetPassiveSkill(teamEntity)
  local petEntityList = teamEntity:Team():GetTeamPetEntities()
  local configServer = self._world:GetService("Config")
  for _, petEntity in ipairs(petEntityList) do
    self:_BuildPetPassiveSkill(petEntity, configServer)
  end
  for _, petEntity in ipairs(petEntityList) do
    local ready = petEntity:Attributes():GetAttribute("Ready")
    if ready == 1 then
      local notify = NTPowerReady:New(petEntity)
      self._world:GetService("Trigger"):Notify(notify)
    end
  end
end

function BuffLogicService:_BuildPetIntensifyBuff(petEntity)
  local buffList = petEntity:SkillInfo():GetIntensifyBuffList()
  local intensifyParams = {}
  local equipIntensifyParams = petEntity:SkillInfo():GetEquipIntensifyParam()
  local equipRefineIntensifyParams = petEntity:EquipRefine():GetEquipRefineIntensifyParam()
  if equipIntensifyParams and type(equipIntensifyParams) == "table" then
    local cloneEquipIntensifyParam = table.clone(equipIntensifyParams)
    if equipRefineIntensifyParams then
      local appendList = {}
      for _, equipRefineParam in ipairs(equipRefineIntensifyParams) do
        local findInOldParam = false
        for equipKey, equipParam in ipairs(cloneEquipIntensifyParam) do
          if equipParam.BuffID == equipRefineParam.BuffID then
            findInOldParam = true
            break
          end
        end
        if not findInOldParam then
          table.insert(appendList, equipRefineParam)
        end
      end
      table.appendArray(cloneEquipIntensifyParam, appendList)
      intensifyParams = cloneEquipIntensifyParam
    end
  else
    intensifyParams = equipRefineIntensifyParams
  end
  local buffSource = BuffSource:New(BuffSourceType.SkillIntensify, petEntity:PetPstID():GetPstID())
  if buffList and 0 < #buffList then
    for k, buffID in ipairs(buffList) do
      self:AddBuff(buffID, petEntity, nil, buffSource, intensifyParams)
    end
  end
end

function BuffLogicService:BuildPetIntensifyBuff(teamEntity)
  local teamEntities = teamEntity:Team():GetTeamPetEntities()
  for _, petEntity in ipairs(teamEntities) do
    self:_BuildPetIntensifyBuff(petEntity)
  end
end

function BuffLogicService:BuildPetEquipRefineBuff(teamEntity)
  local petEntityList = teamEntity:Team():GetTeamPetEntities()
  for _, petEntity in ipairs(petEntityList) do
    local buffList = petEntity:EquipRefine():GetEquipRefineBuffList()
    if buffList then
      local buffSource = BuffSource:New(BuffSourceType.EquipRefine, petEntity:PetPstID():GetPstID())
      for _, buffID in ipairs(buffList) do
        self:AddBuff(buffID, petEntity, nil, buffSource)
      end
    end
  end
  for _, petEntity in ipairs(petEntityList) do
    local ready = petEntity:Attributes():GetAttribute("Ready")
    if ready == 1 then
      local notify = NTPowerReady:New(petEntity)
      self._world:GetService("Trigger"):Notify(notify)
    end
  end
end

function BuffLogicService:_DoTriggerBreakHPLock(entity)
  if not entity then
    return
  end
  local gsmState = self._world:GameFSM():CurStateID()
  local battleStatCmpt = self._world:BattleStat()
  local round = battleStatCmpt:GetCurWaveTotalRoundCount()
  local buffCmpt = entity:BuffComponent()
  if buffCmpt:IsHPNeedUnLock(round - 1, gsmState) then
    buffCmpt:RecordUnlockHPIndex(buffCmpt:GetHPLockIndex())
    buffCmpt:RecordLastUnlockHPRound(round)
    buffCmpt:ResetHPLockState()
    local isUnlockHP = buffCmpt:GetBuffValue("IsUnlockHP")
    self._world:GetService("Trigger"):Notify(NTBreakHPLock:New(entity, isUnlockHP))
  end
end

function BuffLogicService:RefreshLockHPLogic()
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
    if not monsterEntity:HasDeadMark() then
      self:_DoTriggerBreakHPLock(monsterEntity)
    end
  end
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  self:_DoTriggerBreakHPLock(teamEntity)
end

function BuffLogicService:CalcAddTimesByParam(addBuffType, buffCountParam, casterEntity, targetEntity, notify, skillRange)
  local count = 1
  if addBuffType == SkillAddBuffType.ByCostHPPercent then
    local battleService = self._world:GetService("Battle")
    local hp, maxHP = battleService:GetCasterHP(casterEntity)
    if not buffCountParam.percent or not buffCountParam.maxCount then
      Log.exception("AddBuffParam buffCountParam Invalid skillID:", skillEffectCalcParam:GetSkillID())
      return count
    end
    local costHPPercent = (maxHP - hp) / maxHP * 100
    local addCount = math.modf(costHPPercent / buffCountParam.percent)
    if addCount > buffCountParam.maxCount then
      addCount = buffCountParam.maxCount
    end
    count = addCount + count
  elseif addBuffType == SkillAddBuffType.BySurroundingTargetCount then
    local scopeParam = buffCountParam
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local scopeCalc = SkillScopeCalculator:New(utilScopeSvc)
    local scopeResult = scopeCalc:ComputeScopeRange(scopeParam.scopeType, scopeParam.scopeParam, casterEntity:GetGridPosition(), casterEntity:BodyArea():GetArea(), casterEntity:GetGridDirection(), scopeParam.scopeTargetType, casterEntity:GetGridPosition(), casterEntity)
    local targetSelector = self._world:GetSkillScopeTargetSelector()
    local targets = targetSelector:DoSelectSkillTarget(casterEntity, scopeParam.scopeTargetType, scopeResult)
    local tids = {}
    for _, tid in ipairs(targets) do
      if not table.icontains(tids, tid) then
        table.insert(tids, tid)
      end
    end
    count = #tids
  elseif addBuffType == SkillAddBuffType.MultipleTimes then
    local curBuffLayer = self:GetBuffLayer(targetEntity, buffCountParam.targetBuffEffect)
    if curBuffLayer == nil then
      count = 0
      return count
    end
    local newBuffLayer = math.floor(curBuffLayer * buffCountParam.multipleTimes)
    if newBuffLayer > buffCountParam.maxLayer then
      newBuffLayer = buffCountParam.maxLayer
    end
    count = newBuffLayer - curBuffLayer
  elseif addBuffType == SkillAddBuffType.LimitMaxCount then
    local cBuff = targetEntity:BuffComponent()
    if cBuff then
      local buff = cBuff:GetBuffArrayByBuffEffect(buffCountParam.targetBuffEffect)
      if buffCountParam.limitMaxCount <= table.count(buff) then
        count = 0
      end
    end
  elseif addBuffType == SkillAddBuffType.ByCasterTeamOrderDrop then
    local caster = casterEntity
    if caster:HasSuperEntity() then
      caster = caster:GetSuperEntity()
    end
    if not caster:HasPetPstID() then
      Log.exception("AddBuffTypeException: 施加者不是光灵不能使用addBuffType==7")
    elseif not notify or notify:GetNotifyType() ~= NotifyType.TeamOrderChange then
      Log.exception("AddBuffTypeException: addBuffType==7要配合buff通知131使用")
    else
      local petPstID = caster:PetPstID():GetPstID()
      local oldIndex = table.ikey(notify:GetOldTeamOrder(), petPstID)
      local newIndex = table.ikey(notify:GetNewTeamOrder(), petPstID)
      local change = newIndex - oldIndex
      count = math.max(0, change)
    end
  elseif addBuffType == SkillAddBuffType.ByTargetInRangeGridCount and skillRange and targetEntity then
    local bodyAreaCmpt = targetEntity:BodyArea()
    if bodyAreaCmpt then
      local pos = targetEntity:GetGridPosition()
      local area = bodyAreaCmpt:GetArea()
      count = 0
      for index, offPos in ipairs(area) do
        local posWork = pos + offPos
        if table.icontains(skillRange, posWork) then
          count = count + 1
        end
      end
    end
  end
  return count
end

function BuffLogicService:GetEquipIntensifyParam(equipIntensifyParams, buffID)
  if equipIntensifyParams then
    for _, v in ipairs(equipIntensifyParams) do
      if v.BuffID and v.BuffID == buffID then
        return v
      end
    end
  end
  return self._world:BattleStat():GetBuffIntensifyParam(buffID)
end

function BuffLogicService:_ExchangeBuffLogicParam(key, value, cfg)
  if cfg then
    local cfgLogic = cfg
    for cfgLogicKey, cfgLogicValue in pairs(cfgLogic) do
      if cfgLogicKey == key.param then
        cfg[cfgLogicKey] = value
        return true
      end
      if type(cfgLogicValue) == "table" then
        for cfgLogicValue_key, cfgLogicValue_value in pairs(cfgLogicValue) do
          if type(cfgLogicValue_key) == "number" and key.paramIndex and key.paramIndex == cfgLogicValue_key then
            if type(cfgLogicValue_value) == "table" then
              for cfgLogicValue_value_key, v in pairs(cfgLogicValue_value) do
                if cfgLogicValue_value_key == key.param then
                  cfg[cfgLogicKey][cfgLogicValue_key][cfgLogicValue_value_key] = value
                  return true
                end
              end
            else
              cfg[cfgLogicKey][cfgLogicValue_key] = value
              return true
            end
          elseif cfgLogicValue_key == key.param then
            cfg[cfgLogicKey][cfgLogicValue_key] = value
            return true
          end
        end
      end
    end
    return false
  else
    return false
  end
end

function BuffLogicService:_ExChangeBuffTriggerParam(value, triggerIndex, triggerParamIndex, cfgTrigger)
  if cfgTrigger and cfgTrigger[triggerIndex] and cfgTrigger[triggerIndex][triggerParamIndex] then
    cfgTrigger[triggerIndex][triggerParamIndex] = value
    return true
  else
    return false
  end
end

function BuffLogicService:UpdateBuffInstanceField(buffInstance, equipIntensifyParams)
  if not buffInstance then
    Log.fatal("### buffInstance nil")
    return
  end
  local buffId = buffInstance:BuffID()
  local equipIntensifyParam = self:GetEquipIntensifyParam(equipIntensifyParams, buffId)
  if not equipIntensifyParam then
    return
  end
  for _, v in ipairs(equipIntensifyParam) do
    if v.field then
      local field = v.field
      local value = v.value
      if field == "LayerCount" then
        buffInstance:SetMaxBuffLayerCount(value)
      else
        Log.fatal("### no such kind of field. need to extend. field=", field)
      end
    end
  end
end

function BuffLogicService:DoEquipIntensify(buffID, cfg, equipIntensifyParams)
  local ret = true
  local equipIntensifyParam = self:GetEquipIntensifyParam(equipIntensifyParams, buffID)
  if equipIntensifyParam then
    for _, v in ipairs(equipIntensifyParam) do
      if v.key then
        if v.key.LogicType then
          if not v.key.LogicIndex then
            v.key.LogicIndex = 1
          end
          if cfg[v.key.LogicType] and cfg[v.key.LogicType].logic then
            ret = self:_ExchangeBuffLogicParam(v.key, v.value, cfg[v.key.LogicType].logic[v.key.LogicIndex])
          else
            break
          end
        end
        if v.key.TriggerType then
          if v.key.TriggerIndex and v.key.TriggerParamIndex and cfg[v.key.TriggerType] and cfg[v.key.TriggerType].trigger then
            ret = self:_ExChangeBuffTriggerParam(v.value, v.key.TriggerIndex, v.key.TriggerParamIndex, cfg[v.key.TriggerType].trigger)
          else
            break
          end
        end
      end
    end
  end
  if not ret then
    Log.exception("EquipIntensify Config failed BuffID:", buffID)
  end
end

function BuffLogicService:GetBuffSourceEntity(buffSource)
  if buffSource then
    local sourceType = buffSource:GetSourceType()
    local sourceID = buffSource:GetSourceID()
    if sourceType == BuffSourceType.SkillIntensify or BuffSourceType.PassiveSkill then
      local petEntityList = self._world:GetGroupEntities(self._world.BW_WEMatchers.PetPstID)
      for i, petEntity in ipairs(petEntityList) do
        if petEntity:PetPstID() and petEntity:PetPstID():GetPstID() == sourceID then
          return petEntity
        end
      end
    end
  end
  return nil
end

function BuffLogicService:CheckCanBeHitBack(entity)
  if self:CheckInvincible(entity) then
    return false
  end
  if self:CheckImmuneTranslate(entity, "ImmuneHitBack") then
    return false
  end
  if self:CheckControlImmunity(entity) then
    return false
  end
  return true
end

function BuffLogicService:CheckInvincible(entity)
  if not entity then
    return false
  end
  local buffCom = entity:BuffComponent()
  return buffCom and buffCom:HasFlag(BuffFlags.Invincible)
end

function BuffLogicService:CheckImmuneTranslate(entity, translateType)
  local cBuff = entity:BuffComponent()
  if not cBuff then
    return false
  end
  local val = cBuff:GetBuffValue(translateType) or false
  return val
end

function BuffLogicService:CheckControlImmunity(entity)
  local buffCmp = entity:BuffComponent()
  return buffCmp and buffCmp:HasBuffEffect(BuffEffectType.ControlImmunized)
end

function BuffLogicService:CheckForceMoveImmunity(entity)
  local buffCmp = entity:BuffComponent()
  return buffCmp and buffCmp:HasBuffEffect(BuffEffectType.ForceMoveImmunized)
end

function BuffLogicService:CheckCanBeMagicAttack(attacker, defender)
  local buffLogic = self._world:GetService("BuffLogic")
  local attrComp = defender:Attributes()
  if buffLogic:CheckElementImmunity(attacker, defender) then
    return false
  end
  if self:CheckInvincible(defender) then
    return false
  end
  if attrComp:GetAttribute("BuffMonsterSkillImmunity") and (attacker:HasPetPstID() or attacker:HasSuperEntity() and attacker:GetSuperEntity():HasPetPstID() and attacker:EntityType():IsSkillHolder()) then
    return false
  end
  return true
end

function BuffLogicService:CheckElementReinforce(caster, defender)
  if not (caster and defender and caster:HasPetPstID()) or not defender:Attributes() then
    return -1
  end
  local isElementReinforce = defender:Attributes():GetAttribute("ElementReinforce")
  if not isElementReinforce then
    return -1
  end
  local utilSvc = self._world:GetService("UtilData")
  local t1 = utilSvc:GetEntityElementType(caster, true)
  local t2 = utilSvc:GetEntityElementType(defender)
  local sFormula = self._world:GetService("Formula")
  return sFormula:GetRestrainFlag(t1, t2, caster, defender)
end

function BuffLogicService:CheckSealedCurse(e)
  if not e:HasPetPstID() then
    return false
  end
  local buffCom = e:BuffComponent()
  return buffCom and buffCom:HasFlag(BuffFlags.SealedCurse)
end

function BuffLogicService:PrintBuffLogicSvcLog(...)
  if self._world and self._world:IsDevelopEnv() then
    Log.debug(...)
  end
end

function BuffLogicService:ChangePetActiveSkillReady(e, ready, skillID)
  self:PrintBuffLogicSvcLog("BuffLogicService:ChangePetActiveSkillReady: eid=", e:GetID(), "ready=", ready)
  local r = ready
  if e:HasBuffFlag(BuffFlags.SealedCurse) then
    Log.debug("SealedCurse detected. Set ready to 0. ")
    r = 0
  elseif self:IsPetActiveSkillCanNotReadyByBuff(e) then
    r = 0
  end
  if not skillID then
    e:Attributes():Modify("Ready", r)
  else
    local utilData = self._world:GetService("UtilData")
    local isExtraSkill, extraSkillIndex = utilData:IsPetExtraActiveSkill(e, skillID)
    local isUseBuffLayerVariantSkill, variantIndex = utilData:IsPetVariantActiveSkillUseBuffLayer(e, skillID)
    if isExtraSkill then
      if self:IsPetExtraActiveSkillCanNotReadyByBuff(e, skillID) then
        r = 0
      end
      local readyKey = "Ready" .. tostring(extraSkillIndex)
      e:Attributes():SetSimpleAttribute(readyKey, r)
    elseif isUseBuffLayerVariantSkill then
      local readyKey = "Ready" .. tostring(variantIndex)
      e:Attributes():SetSimpleAttribute(readyKey, r)
    else
      e:Attributes():Modify("Ready", r)
    end
  end
  return r
end

function BuffLogicService:BuffSetPetActiveSkillCanNotReady(e, bSet, reason)
  local buffCmpt = e:BuffComponent()
  if buffCmpt then
    local setVal = bSet and 1 or 0
    buffCmpt:SetBuffValue("BuffSetCanNotReady", setVal)
    if bSet then
      if reason then
        local tipsKeyStr = "BuffSetCanNotReadyReason"
        buffCmpt:SetBuffValue(tipsKeyStr, reason)
      end
    else
      local tipsKeyStr = "BuffSetCanNotReadyReason"
      buffCmpt:SetBuffValue(tipsKeyStr, nil)
    end
  end
end

function BuffLogicService:IsPetActiveSkillCanNotReadyByBuff(e)
  local buffCmpt = e:BuffComponent()
  if buffCmpt then
    local setVal = buffCmpt:GetBuffValue("BuffSetCanNotReady")
    if setVal and setVal == 1 then
      local tipsKeyStr = "BuffSetCanNotReadyReason"
      local reason = buffCmpt:GetBuffValue(tipsKeyStr)
      return true, reason
    end
  end
  return false
end

function BuffLogicService:BuffSetPetExtraActiveSkillCanNotReady(e, skillID, bSet, reason)
  local buffCmpt = e:BuffComponent()
  if buffCmpt then
    local utilData = self._world:GetService("UtilData")
    local isExtraSkill, extraSkillIndex = utilData:IsPetExtraActiveSkill(e, skillID)
    local subFix = skillID
    if isExtraSkill then
      subFix = extraSkillIndex
    end
    local keyStr = "BuffSetCanNotReady" .. tostring(subFix)
    local setVal = bSet and 1 or 0
    buffCmpt:SetBuffValue(keyStr, setVal)
    if bSet then
      if reason then
        local tipsKeyStr = "BuffSetCanNotReadyReason" .. tostring(subFix)
        buffCmpt:SetBuffValue(tipsKeyStr, reason)
      end
    else
      local tipsKeyStr = "BuffSetCanNotReadyReason" .. tostring(subFix)
      buffCmpt:SetBuffValue(tipsKeyStr, nil)
    end
  end
end

function BuffLogicService:IsPetExtraActiveSkillCanNotReadyByBuff(e, skillID)
  local buffCmpt = e:BuffComponent()
  if buffCmpt then
    local utilData = self._world:GetService("UtilData")
    local isExtraSkill, extraSkillIndex = utilData:IsPetExtraActiveSkill(e, skillID)
    local subFix = skillID
    if isExtraSkill then
      subFix = extraSkillIndex
    end
    local keyStr = "BuffSetCanNotReady" .. tostring(subFix)
    local setVal = buffCmpt:GetBuffValue(keyStr)
    if setVal and setVal == 1 then
      local tipsKeyStr = "BuffSetCanNotReadyReason" .. tostring(subFix)
      local reason = buffCmpt:GetBuffValue(tipsKeyStr)
      return true, reason
    end
  end
  return false
end

function BuffLogicService:IsTargetCanBePercentDamage(targetEntity)
  local attrCmpt = targetEntity:Attributes()
  local val = attrCmpt:GetAttribute("NoPercentDamage") or 0
  return val == 0
end

function BuffLogicService:IsTargetCanBeToDie(targetEntity)
  local attrCmpt = targetEntity:Attributes()
  local val = attrCmpt:GetAttribute("NoDeadDamage") or 0
  return val == 0
end

function BuffLogicService:_NotifyBuffDamageBegin(attacker, defender)
end

function BuffLogicService:_NotifyBuffDamageEnd(attacker, defender, damageInfo)
  local triggerSvc = self._world:GetService("Trigger")
  if defender:HasMonsterID() then
    local nt = NTMonsterBuffDamageEnd:New(attacker, defender)
    triggerSvc:Notify(nt)
  end
end

function BuffLogicService:DoBuffDamage(buffID, attacker, defender, damageParam)
  self._world:GetMatchLogger():BeginBuff(attacker:GetID(), buffID)
  self:_NotifyBuffDamageBegin(attacker, defender)
  local calcDamageSvc = self._world:GetService("CalcDamage")
  local damageInfo = calcDamageSvc:DoCalcDamage(attacker, defender, damageParam, true)
  self:_NotifyBuffDamageEnd(attacker, defender, damageInfo)
  self._world:GetMatchLogger():EndBuff(attacker:GetID())
  return damageInfo
end

function BuffLogicService:CalTargets_BodyAreaGridElementProp(buffTargetParam, enemyEntities)
  local es = {}
  if type(buffTargetParam) == "table" then
    local tarElements = buffTargetParam.tarElements or {}
    local maxProb = buffTargetParam.maxProb or 1
    local randomSvc = self._world:GetService("RandomLogic")
    local utilData = self._world:GetService("UtilData")
    for i, e in ipairs(enemyEntities) do
      local pos = e:GetGridPosition()
      local area = e:BodyArea():GetArea()
      local totalPieceCount = e:BodyArea():GetAreaCount()
      if totalPieceCount == 0 then
        totalPieceCount = 1
      end
      local tarPieceCount = 0
      for _, v in ipairs(area) do
        local posWork = pos + v
        local pieceElement = utilData:FindPieceElement(Vector2(posWork.x, posWork.y))
        if table.icontains(tarElements, pieceElement) then
          tarPieceCount = tarPieceCount + 1
        end
      end
      local pieceRandRate = tarPieceCount / totalPieceCount
      if 1 < pieceRandRate then
        pieceRandRate = 1
      end
      if maxProb < 1 then
        local maxProbNum = 100 * maxProb
        local finalProb = pieceRandRate * maxProbNum
        local random = randomSvc:LogicRand(1, 100)
        if finalProb < random then
        else
          table.insert(es, e)
        end
      else
        table.insert(es, e)
      end
    end
  end
  return es
end

function BuffLogicService:CalTargets_BodyAreaGridFindElement(buffTargetParam, enemyEntities)
  local es = {}
  if type(buffTargetParam) == "table" then
    local tarElements = buffTargetParam.tarElements or {}
    local utilData = self._world:GetService("UtilData")
    for i, e in ipairs(enemyEntities) do
      local pos = e:GetGridPosition()
      local area = e:BodyArea():GetArea()
      local tarPieceCount = 0
      for _, v in ipairs(area) do
        local posWork = pos + v
        local pieceElement = utilData:FindPieceElement(Vector2(posWork.x, posWork.y))
        if table.icontains(tarElements, pieceElement) then
          tarPieceCount = tarPieceCount + 1
        end
      end
      if 0 < tarPieceCount then
        table.insert(es, e)
      end
    end
  end
  return es
end

function BuffLogicService:CheckEntityLockHP(entity)
  local buffCmpt = entity:BuffComponent()
  local curRound = self._world:BattleStat():GetCurWaveTotalRoundCount()
  local isLock = buffCmpt:IsHPLock(curRound) or buffCmpt:IsHPLock(curRound - 1)
  local hasLockHPBuff = buffCmpt:GetBuffValue("LockHPByRound")
  hasLockHPBuff = hasLockHPBuff or buffCmpt:GetBuffValue("LockHPAlways")
  return hasLockHPBuff, isLock
end

function BuffLogicService:GetLockHPInfo(entity, preDamage)
  local buffComponent = entity:BuffComponent()
  local curHp = entity:Attributes():GetCurrentHP()
  local maxHp = entity:Attributes():CalcMaxHp()
  curHp = curHp - (preDamage or 0)
  if curHp < 0 then
    curHp = 0
  end
  local leftHpPercent = curHp / maxHp * 100
  local lockHpPercent = 0
  local index = 0
  local lockHpList = buffComponent:GetBuffValue("LockHPList")
  for k, v in ipairs(lockHpList) do
    if leftHpPercent <= v.hpPercent and not buffComponent:HpIsHasLocked(v.hpPercent) then
      lockHpPercent = v.hpPercent
      index = k
    end
  end
  if buffComponent:GetBuffValue("LockHPAlways") and lockHpList and lockHpList[1] then
    local per = lockHpList[1].hpPercent
    if leftHpPercent <= per then
      lockHpPercent = per
      index = 1
    end
  end
  return lockHpPercent, index
end

local chargeGreyHPTag = "BuffLogicService:ChangeGreyHP: "

function BuffLogicService:ChangeGreyHP(e, val)
  local cBuff = e:BuffComponent()
  if not cBuff then
    Log.debug(chargeGreyHPTag, "target has no BuffComponent: ", e:GetID())
    return
  end
  if not cBuff:IsGreyHPEnabled() then
    Log.debug(chargeGreyHPTag, "target grey HP disabled: ", e:GetID())
    return
  end
  local currentVal = cBuff:GetGreyHPValue() or 0
  Log.debug(chargeGreyHPTag, e:GetID(), "current grey HP val: ", currentVal, "add val: ", val)
  currentVal = math.max(0, currentVal + val)
  cBuff:SetGreyHPValue(currentVal)
  local logger = self._world:GetMatchLogger()
  logger:BeginDamageLog(e:GetID())
  logger:AddDamageLog(e:GetID(), {
    key = "GreyHP",
    desc = "灰血积蓄值: [val]",
    val = val
  })
  logger:EndDamageLog(e:GetID())
  return self:FixGreyHPVal(e)
end

function BuffLogicService:ClearGreyHP(e)
  local cBuff = e:BuffComponent()
  if not cBuff then
    return
  end
  if not cBuff:IsGreyHPEnabled() then
    return
  end
  cBuff:ClearGreyHPValue()
  return self:FixGreyHPVal(e)
end

local fixGreyHPValTag = "BuffLogicService:FixGreyHPVal: "

function BuffLogicService:FixGreyHPVal(e)
  local cBuff = e:BuffComponent()
  if not cBuff then
    Log.debug(fixGreyHPValTag, "target has no BuffComponent: ", e:GetID())
    return
  end
  local cAttributes = e:Attributes()
  local currentHP = cAttributes:GetCurrentHP()
  local maxHP = cAttributes:CalcMaxHp()
  local currentVal = cBuff:GetGreyHPValue()
  if not currentVal or currentVal <= 0 then
    Log.debug(fixGreyHPValTag, "entityID = ", e:GetID(), "no grey HP val. ")
    return
  end
  local logger = self._world:GetMatchLogger()
  logger:BeginDamageLog(e:GetID())
  if maxHP < currentHP + currentVal then
    local replaceVal = math.max(0, maxHP - currentHP)
    Log.debug(fixGreyHPValTag, "entityID = ", e:GetID(), " currentHP[", currentHP, "] +", " currentVal[", currentVal, "] > ", " maxHP[", maxHP, "]", "setting new grey HP val to ", replaceVal)
    logger:AddDamageLog(e:GetID(), {
      key = "GreyHP",
      desc = "灰血值修正: 当前生命值[currentHP] + 当前灰血值[currentVal] > 最大生命值[maxHP]，修正最终值[replaceVal]",
      currentHP = currentHP,
      currentVal = currentVal,
      maxHP = maxHP,
      replaceVal = replaceVal
    })
    cBuff:SetGreyHPValue(replaceVal)
    currentVal = replaceVal
  else
    Log.debug(fixGreyHPValTag, "entityID = ", e:GetID(), " currentHP[", currentHP, "] +", " currentVal[", currentVal, "] > ", " maxHP[", maxHP, "]", "no need to fix. ")
    logger:AddDamageLog(e:GetID(), {
      key = "GreyHP",
      desc = "灰血值无需修正: 当前生命值[currentHP] + 当前灰血值[currentVal] <= 最大生命值[maxHP]",
      currentHP = currentHP,
      currentVal = currentVal,
      maxHP = maxHP
    })
  end
  logger:AddDamageLog(e:GetID(), {
    key = "GreyHP",
    desc = "最终灰血值: [currentVal]",
    currentVal = currentVal
  })
  logger:EndDamageLog(e:GetID())
  return currentVal
end

local recoverFromGreyHPTag = "BuffLogicService:RecoverFromGreyHP: "

function BuffLogicService:GetRecoverFromGreyHPDamageInfo(e, rate)
  local cBuff = e:BuffComponent()
  if not cBuff then
    Log.debug(recoverFromGreyHPTag, "target has no BuffComponent: ", e:GetID())
    return
  end
  local cAttributes = e:Attributes()
  local currentHP = cAttributes:GetCurrentHP()
  local maxHP = cAttributes:CalcMaxHp()
  local currentLostHP = maxHP - currentHP
  local currentVal = cBuff:GetGreyHPValue()
  if not currentVal or currentVal <= 0 then
    return
  end
  local recoverVal = math.max(1, math.floor(math.min(rate * currentVal, currentLostHP)))
  Log.debug(recoverFromGreyHPTag, "recover val: ", recoverVal, "entityID = ", e:GetID())
  local damageInfo = DamageInfo:New(recoverVal, DamageType.Recover)
  return damageInfo
end

function BuffLogicService:GetRecoverByMaxHP(e, rate)
  local cBuff = e:BuffComponent()
  if not cBuff then
    return
  end
  local cAttributes = e:Attributes()
  local currentHP = cAttributes:GetCurrentHP()
  local maxHP = cAttributes:CalcMaxHp()
  local recoverMaxHP = math.floor(math.min(maxHP * rate, maxHP))
  local recoverVal = math.max(1, recoverMaxHP - currentHP)
  local damageInfo = DamageInfo:New(recoverVal, DamageType.Recover)
  return damageInfo
end

function BuffLogicService:GetRecoverByMaxHPCount(e)
  local cBuff = e:BuffComponent()
  if not cBuff then
    return
  end
  return cBuff:GetRecoverByMaxHPCountValue()
end

function BuffLogicService:SetRecoverByMaxHPCount(e, val)
  local cBuff = e:BuffComponent()
  if not cBuff then
    return
  end
  cBuff:SetRecoverByMaxHPCountValue(val)
end

function BuffLogicService:IsChainSkillUseChainScope(entity)
  if entity:HasBuff() then
    return entity:BuffComponent():GetBuffValue("ChainSkillUseChainScope") and entity:BuffComponent():GetBuffValue("ChainSkillUseChainScope") == 1
  end
end

function BuffLogicService:SetPoisonByAttackCasterID(entity, layerType, casterID)
  if layerType ~= BuffEffectType.PoisonByAttack then
    return
  end
  if not entity or not casterID then
    return
  end
  local buffCmpt = entity:BuffComponent()
  if not buffCmpt then
    return
  end
  buffCmpt:SetPoisonByAttackCasterID(casterID)
end

function BuffLogicService:ClearPoisonByAttackCasterID(entity, layerType)
  if layerType ~= BuffEffectType.PoisonByAttack then
    return
  end
  if not entity then
    return
  end
  local buffCmpt = entity:BuffComponent()
  if not buffCmpt then
    return
  end
  buffCmpt:ClearPoisonByAttackCasterID()
end

function BuffLogicService:GetPoisonByAttackCasterID(entity)
  if not entity then
    return
  end
  local buffCmpt = entity:BuffComponent()
  if not buffCmpt then
    return
  end
  return buffCmpt:GetPoisonByAttackCasterID()
end

function BuffLogicService:SetRebeccaPoisonCasterID(entity, layerType, casterID)
  if layerType ~= BuffEffectType.RebeccaPoison then
    return
  end
  if not entity or not casterID then
    return
  end
  local buffCmpt = entity:BuffComponent()
  if not buffCmpt then
    return
  end
  local casterEntity = self._world:GetEntityByID(casterID)
  if casterEntity then
    if casterEntity:HasSummoner() then
      local summonEntityID = casterEntity:Summoner():GetSummonerEntityID()
      casterID = summonEntityID
      if casterEntity:HasSuperEntity() then
        local superEntity = casterEntity:SuperEntityComponent():GetSuperEntity()
        if superEntity then
          casterID = superEntity:GetID()
        end
      end
    elseif casterEntity:HasSuperEntity() then
      local superEntity = casterEntity:SuperEntityComponent():GetSuperEntity()
      if superEntity then
        casterID = superEntity:GetID()
      end
    end
  end
  buffCmpt:SetRebeccaPoisonCasterID(casterID)
end

function BuffLogicService:ClearRebeccaPoisonCasterID(entity, layerType)
  if layerType ~= BuffEffectType.RebeccaPoison then
    return
  end
  if not entity then
    return
  end
  local buffCmpt = entity:BuffComponent()
  if not buffCmpt then
    return
  end
  buffCmpt:ClearRebeccaPoisonCasterID()
end

function BuffLogicService:GetRebeccaPoisonCasterID(entity)
  if not entity then
    return
  end
  local buffCmpt = entity:BuffComponent()
  if not buffCmpt then
    return
  end
  return buffCmpt:GetRebeccaPoisonCasterID()
end

function BuffLogicService:ReBuildCurrentPetsPassiveSkillToPartner(teamEntity, partnerTepTeam)
  local petEntityList = teamEntity:Team():GetTeamPetEntities()
  local configServer = self._world:GetService("Config")
  for _, petEntity in ipairs(petEntityList) do
    local passiveSkillID = petEntity:SkillInfo():GetPassiveSkillID()
    local equipIntensifyParams = petEntity:SkillInfo():GetEquipIntensifyParam()
    if passiveSkillID and passiveSkillID ~= 0 then
      local config = configServer:GetPetPassiveSkill(passiveSkillID)
      if config and config.BuffID then
        local buffSource = BuffSource:New(BuffSourceType.PassiveSkill, petEntity:PetPstID():GetPstID())
        for _, buffID in ipairs(config.BuffID) do
          self:AddBuffByTargetType(buffID, config.BuffTargetType, config.BuffTargetParam, {casterEntity = petEntity}, buffSource, equipIntensifyParams, petEntity)
        end
      end
    end
  end
end

function BuffLogicService:BuildNewPartnerPassiveSkill(teamEntity, partnerTempTeam)
  local petEntityList = partnerTempTeam:Team():GetTeamPetEntities()
  local configServer = self._world:GetService("Config")
  for _, petEntity in ipairs(petEntityList) do
    local passiveSkillID = petEntity:SkillInfo():GetPassiveSkillID()
    local equipIntensifyParams = petEntity:SkillInfo():GetEquipIntensifyParam()
    if passiveSkillID and passiveSkillID ~= 0 then
      local config = configServer:GetPetPassiveSkill(passiveSkillID)
      if config and config.BuffID then
        local buffSource = BuffSource:New(BuffSourceType.PassiveSkill, petEntity:PetPstID():GetPstID())
        for _, buffID in ipairs(config.BuffID) do
          self:AddBuffByTargetType(buffID, config.BuffTargetType, config.BuffTargetParam, {casterEntity = petEntity}, buffSource, equipIntensifyParams, petEntity)
        end
      end
    end
  end
  for _, petEntity in ipairs(petEntityList) do
    local ready = petEntity:Attributes():GetAttribute("Ready")
    if ready == 1 then
      local notify = NTPowerReady:New(petEntity)
      self._world:GetService("Trigger"):Notify(notify)
    end
  end
end

function BuffLogicService:ChangeDmgParamSingleTypeSkill(entity, modifierID, value)
  self:_AddAttributeValue(entity, "DmgParamSingleTypeSkill", modifierID, value)
end

function BuffLogicService:RemoveDmgParamSingleTypeSkill(entity, modifierID)
  self:_RemoveAttributeValue(entity, "DmgParamSingleTypeSkill", modifierID)
end

function BuffLogicService:CalcMinCostByExtraParam(petEntity, skillID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, petEntity)
  local defaultCost = skillConfigData:GetSkillTriggerParam()
  local utilData = self._world:GetService("UtilData")
  local cost = utilData:CalcMinCostLegendPowerByExtraParam(petEntity, defaultCost, skillConfigData, 0, false)
  return cost
end

function BuffLogicService:GetCountDown(entity, buffEffectType)
  local bc = entity:BuffComponent()
  if bc then
    local key = self:GetBuffLayerName(buffEffectType) .. "CountDown"
    local countDown = bc:GetBuffValue(key)
    return countDown
  end
end

function BuffLogicService:SetCountDown(entity, buffEffectType, countDown)
  local bc = entity:BuffComponent()
  if bc then
    if countDown < 0 then
      countDown = 0
    end
    local buffInstance = bc:GetSingleBuffByBuffEffect(buffEffectType)
    local key = self:GetBuffLayerName(buffEffectType) .. "CountDown"
    bc:SetBuffValue(key, countDown)
    return countDown, buffInstance
  end
end

function BuffLogicService:AddCountDown(entity, buffEffectType, addCountDown)
  local bc = entity:BuffComponent()
  if not bc then
    return
  end
  local buffInstance = bc:GetSingleBuffByBuffEffect(buffEffectType)
  if not buffInstance then
    return
  end
  local oldFinalVal = buffInstance:GetCountDown()
  local newCountDown, changeCountDown = buffInstance:AddCountDown(addCountDown)
  return newCountDown, buffInstance
end

function BuffLogicService:IsPetNotifyTypeDisable(entity, notifyType)
  if not entity:HasPet() then
    return false
  end
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local activeSkillCmpt = teamEntity:ActiveSkill()
  local curActiveSkillID = activeSkillCmpt:GetActiveSkillID()
  local curCasterID = activeSkillCmpt:GetActiveSkillCasterEntityID()
  if curCasterID ~= entity:GetID() then
    return false
  end
  local bc = entity:BuffComponent()
  if not bc then
    return false
  end
  local strValue = bc:GetBuffValue("ForbiddenNotifyType")
  local strArray = string.split(strValue, "|")
  local skillID = tonumber(strArray[1])
  local strTypeArray = string.split(strArray[2], ",")
  local typeList = {}
  for _, strType in ipairs(strTypeArray) do
    table.insert(typeList, tonumber(strType))
  end
  if skillID == curActiveSkillID and table.icontains(typeList, notifyType) then
    return true
  end
  return false
end

function BuffLogicService:IsPetNotTriggerAntiAttack(entity)
  if not entity:HasPet() then
    return false
  end
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local activeSkillCmpt = teamEntity:ActiveSkill()
  local curActiveSkillID = activeSkillCmpt:GetActiveSkillID()
  local curCasterID = activeSkillCmpt:GetActiveSkillCasterEntityID()
  if curCasterID ~= entity:GetID() then
    return false
  end
  local bc = entity:BuffComponent()
  if not bc then
    return false
  end
  local strValue = bc:GetBuffValue("ForbiddenNotifyType")
  local strArray = string.split(strValue, "|")
  local skillID = tonumber(strArray[1])
  if skillID == curActiveSkillID then
    return true
  end
  return false
end

local BuffChangeAttrType = {
  AttackPer
}

function BuffLogicService:ChangeADPAttr(entity, modifierID, value)
  self:_AddAttributeValue(entity, "ADPAttr", modifierID, value)
end

function BuffLogicService:GetPopStarStageBuffIDList()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local buffComponent = teamEntity:BuffComponent()
  if not buffComponent then
    return
  end
  local buffIDList = {}
  local buffArray = buffComponent:GetBuffArrayByBuffType(BuffType.PopStarStage)
  if buffArray and 0 < #buffArray then
    for _, buffIns in ipairs(buffArray) do
      buffIDList[#buffIDList + 1] = buffIns:BuffID()
    end
  end
  return buffIDList
end

local chargeCurseHPTag = "BuffLogicService:ChangeCurseHP: "

function BuffLogicService:ChangeCurseHP(e, val)
  local cBuff = e:BuffComponent()
  if not cBuff then
    Log.debug(chargeCurseHPTag, "target has no BuffComponent: ", e:GetID())
    return
  end
  if not cBuff:IsCurseHPEnabled() then
    Log.debug(chargeCurseHPTag, "target curse HP disabled: ", e:GetID())
    return
  end
  local currentVal = cBuff:GetCurseHPValue() or 0
  Log.debug(chargeCurseHPTag, e:GetID(), "current curse HP val: ", currentVal, "add val: ", val)
  currentVal = currentVal + val
  if currentVal < 0 then
    currentVal = 0
  end
  cBuff:SetCurseHPValue(currentVal)
  local logger = self._world:GetMatchLogger()
  logger:BeginDamageLog(e:GetID())
  logger:AddDamageLog(e:GetID(), {
    key = "CurseHP",
    desc = "诅咒血条积蓄值: [val]",
    val = val
  })
  logger:EndDamageLog(e:GetID())
  return self:FixCurseHPVal(e)
end

function BuffLogicService:ClearCurseHP(e)
  local cBuff = e:BuffComponent()
  if not cBuff then
    return
  end
  if not cBuff:IsCurseHPEnabled() then
    return
  end
  cBuff:ClearCurseHPValue()
  return self:FixCurseHPVal(e)
end

local fixCurseHPValTag = "BuffLogicService:FixCurseHPVal: "

function BuffLogicService:FixCurseHPVal(e)
  local cBuff = e:BuffComponent()
  if not cBuff then
    Log.debug(fixCurseHPValTag, "target has no BuffComponent: ", e:GetID())
    return
  end
  local cAttributes = e:Attributes()
  local maxHP = cAttributes:CalcMaxHp()
  local currentVal = cBuff:GetCurseHPValue()
  if not currentVal or currentVal < 0 then
    Log.debug(fixCurseHPValTag, "entityID = ", e:GetID(), "no curse HP val. ")
    return
  end
  local logger = self._world:GetMatchLogger()
  logger:BeginDamageLog(e:GetID())
  if maxHP < currentVal then
    local replaceVal = maxHP
    Log.debug(fixCurseHPValTag, "entityID = ", e:GetID(), " currentVal[", currentVal, "] > ", " maxHP[", maxHP, "]", "setting new curse HP val to ", replaceVal)
    logger:AddDamageLog(e:GetID(), {
      key = "CurseHP",
      desc = "诅咒血条值修正: 当前诅咒血条[currentVal] > 最大生命值[maxHP]，修正最终值[replaceVal]",
      currentVal = currentVal,
      maxHP = maxHP,
      replaceVal = replaceVal
    })
    cBuff:SetCurseHPValue(replaceVal)
    currentVal = replaceVal
  else
    Log.debug(fixCurseHPValTag, "entityID = ", e:GetID(), " currentVal[", currentVal, "] > ", " maxHP[", maxHP, "]", "no need to fix. ")
    logger:AddDamageLog(e:GetID(), {
      key = "CurseHP",
      desc = "诅咒血条无需修正: 当前诅咒血条[currentVal] <= 最大生命值[maxHP]",
      currentVal = currentVal,
      maxHP = maxHP
    })
  end
  logger:AddDamageLog(e:GetID(), {
    key = "CurseHP",
    desc = "最终诅咒血条: [currentVal]",
    currentVal = currentVal
  })
  logger:EndDamageLog(e:GetID())
  return currentVal
end

function BuffLogicService:ModifyAttributeValueByEnlighten(entity, enlightenInfo)
  if not enlightenInfo then
    return
  end
  local modifyID = BattleConst.AttributesModifierIDByEnlighten
  local attack = enlightenInfo:GetAttackFixValue()
  self:ChangeBaseAttack(entity, modifyID, ModifyBaseAttackType.AttackConstantFix, attack)
  local defence = enlightenInfo:GetDefenceFixValue()
  self:ChangeBaseDefence(entity, modifyID, ModifyBaseDefenceType.DefenceConstantFix, defence)
  local maxHP = enlightenInfo:GetMaxHPFixValue()
  self:ChangeBaseMaxHP(entity, modifyID, ModifyBaseMaxHPType.MaxHPConstantFix, maxHP)
  local exParam = enlightenInfo:GetExElementParam()
  self:ChangeExElementParam(entity, modifyID, exParam)
  local skillIncreaseParam = enlightenInfo:GetActiveSkillIncreaseParam()
  self:ChangeSkillIncrease(entity, modifyID, ModifySkillIncreaseParamType.ActiveSkill, skillIncreaseParam)
end

function BuffLogicService:IsCanCastChainSkill(entity)
  if entity:HasBuff() then
    if entity:BuffComponent():GetBuffValue("ForbidChainFlag") then
      return entity:BuffComponent():GetBuffValue("ReplaceEntityID") ~= nil
    end
    return true
  end
  return true
end

function BuffLogicService:IsForceEnterAuroraTime(entity)
  local com = entity:BuffComponent()
  if com then
    local val = com:GetBuffValue(BattleConst.BVK_ForceEnterAurora)
    if val then
      return val
    end
  end
  return false
end

function BuffLogicService:GetModifyValueByID(entity, attributeName, modifyID)
  local modifier = self:_GetAttributeModifier(entity, attributeName)
  if not modifier then
    return 0
  end
  local value = modifier:GetModifyValue(modifyID) or 0
  return value
end

function BuffLogicService:IsTeamLeaderCanAttack(teamEntity, pieceType)
  local buffComp = teamEntity:BuffComponent()
  local isAttackOnlyInEle = buffComp:GetBuffValue(PopStarConst.BVK_TLAttackOnlyInEle)
  if isAttackOnlyInEle then
    local battleService = self._world:GetService("Battle")
    local teamLeaderEntity = teamEntity:Team():GetTeamLeaderEntity()
    local elementCmpt = teamLeaderEntity:Element()
    if CanMatchPieceType(pieceType, elementCmpt:GetPrimaryType()) then
      return true
    end
    local fettersSvc = self._world:GetService("Fetters")
    if fettersSvc then
      local fpPieceType = fettersSvc:GetFettersPrimaryType(teamLeaderEntity)
      if fpPieceType and CanMatchPieceType(pieceType, fpPieceType) then
        return true
      end
    end
    if elementCmpt:HasSecondaryType() and CanMatchPieceType(pieceType, elementCmpt:GetSecondaryType()) then
      return true
    end
    return false
  end
  return true
end

function BuffLogicService:IsEnableSpecialDotFormula(attacker, defender)
  if attacker and attacker:HasMonsterID() then
    return false
  end
  local curTeamEntity = self._world:Player():GetLocalTeamEntity()
  if curTeamEntity:BuffComponent():GetBuffValue("ReplaceBuffFormulaTable") then
    return true
  end
  if defender and not defender:HasMonsterID() then
    return false
  end
  local cfg = Cfg.cfg_global.SpecialFormulaMatchType
  if cfg and cfg.ArrayValue then
    return table.icontains(cfg.ArrayValue, self._world:MatchType())
  end
  return false
end

function BuffLogicService:GetSpecialDotFormulaParamByID(formulaID)
  local curTeamEntity = self._world:Player():GetLocalTeamEntity()
  local replaceBuffFormulaTable
  if curTeamEntity:BuffComponent():GetBuffValue("ReplaceBuffFormulaTable") then
    replaceBuffFormulaTable = table.clone(curTeamEntity:BuffComponent():GetBuffValue("ReplaceBuffFormulaTable"))
  end
  local cfg = Cfg.cfg_global.SpecialFormulaMatchType
  if cfg and cfg.TableValue and cfg.ArrayValue and table.icontains(cfg.ArrayValue, self._world:MatchType()) then
    replaceBuffFormulaTable = cfg.TableValue
  end
  if replaceBuffFormulaTable then
    return replaceBuffFormulaTable[formulaID]
  end
end

function BuffLogicService:IsReplaceBuffIDMatchType(targetEntity)
  if targetEntity and not targetEntity:HasMonsterID() then
    return false
  end
  local cfg = Cfg.cfg_global.ReplaceBuffIDMatchType
  if cfg and cfg.ArrayValue then
    return table.icontains(cfg.ArrayValue, self._world:MatchType())
  end
  return false
end

function BuffLogicService:GetReplaceBuffIDByGlobalCfg(buffEffectType)
  local cfg = Cfg.cfg_global.ReplaceBuffIDMatchType
  if cfg and cfg.TableValue then
    return cfg.TableValue[buffEffectType]
  end
end

function BuffLogicService:CalcBuffEffectCount(defender, buffEffectIDList)
  local count = 0
  local defenderBuff = defender:BuffComponent()
  if defenderBuff then
    for _, buffEffectID in ipairs(buffEffectIDList) do
      if defenderBuff:HasBuffEffect(buffEffectID) then
        count = count + 1
      end
    end
  end
  return count
end

function BuffLogicService:GetHPShield(entity)
  local buffComponent = entity:BuffComponent()
  local curShieldValue = buffComponent:GetBuffValue("HPShield") or 0
  local matchType = self._world:MatchType()
  if self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze and entity:HasPetPstID() then
    local teamEntity = entity:Pet():GetOwnerTeamEntity()
    local buffComponentTeam = teamEntity:BuffComponent()
    curShieldValue = buffComponentTeam:GetBuffValue("HPShield") or 0
    local petEntityList = teamEntity:Team():GetTeamPetEntities()
    local count = 0
    for _, entity in ipairs(petEntityList) do
      if not entity:HasPetDeadMark() then
        count = count + 1
      end
    end
    curShieldValue = math.floor(curShieldValue / count + 0.5)
  end
  return curShieldValue
end

function BuffLogicService:AddHPShield(entity, value)
  local buffCmpt = entity:BuffComponent()
  if not buffCmpt then
    return
  end
  if buffCmpt:GetBuffValue("ThawLayer") then
    local attrCmpt = entity:Attributes()
    local maxHP = attrCmpt:CalcMaxHp()
    local subValue = buffCmpt:GetBuffValue("ThawCostHPShieldPer") * maxHP * buffCmpt:GetBuffValue("ThawLayer")
    Log.info("Thaw subtract HPShield: ", subValue)
    value = math.max(0, value - subValue)
  end
  local curHpSh = entity:BuffComponent():AddBuffValue("HPShield", value)
  return curHpSh
end

function BuffLogicService:AddLayerShield(buffInstance, entity, value)
  local buffCmpt = entity:BuffComponent()
  if not buffCmpt then
    return
  end
  if buffCmpt:GetBuffValue("ThawLayer") then
    local subValue = buffCmpt:GetBuffValue("ThawLayerShieldCount") * buffCmpt:GetBuffValue("ThawLayer")
    Log.info("Thaw subtract LayerShield: ", subValue)
    value = math.max(0, value - subValue)
  end
  buffInstance:AddLayerCount(value)
end

function BuffLogicService:IsCloseEnterAuroraTime(entity)
  local com = entity:BuffComponent()
  if com then
    return com:GetBuffValue("CloseAuroraTime") == true
  end
  return false
end

function BuffLogicService:CalcShieldFormValue(notify, shieldFromType, shieldFromParam, entity, buffInstance)
  local value = 0
  if shieldFromType == HPShieldFromType.OwnerHP then
    value = entity:Attributes():GetCurrentHP()
  elseif shieldFromType == HPShieldFromType.OwnerMaxHP then
    value = entity:Attributes():CalcMaxHp()
  elseif shieldFromType == HPShieldFromType.CasterHP then
    local casterEntity = buffInstance:Context().casterEntity
    if casterEntity:HasPetPstID() then
      local pstid = casterEntity:PetPstID():GetPstID()
      local petData = self._world:GetPetData(pstid)
      value = petData:GetPetHealth()
    elseif casterEntity:HasMonsterID() then
      local configService = self._world:GetService("Config")
      local monsterConfigData = configService:GetMonsterConfigData()
      local monsterid = casterEntity:MonsterID():GetMonsterID()
      local maxhp = configService:GetMonsterHealth(casterEntity)
      value = maxhp
    else
      value = 0
    end
  elseif shieldFromType == HPShieldFromType.LastDamage then
    value = notify:GetDamage()
  elseif shieldFromType == HPShieldFromType.SpecificPet then
    local teamEntity = self._world:Player():GetCurrentTeamEntity()
    if entity:HasTeam() then
      teamEntity = entity
    elseif entity:HasPet() then
      teamEntity = entity:Pet():GetOwnerTeamEntity()
    end
    local pets = teamEntity:Team():GetTeamPetEntities()
    for i, e in ipairs(pets) do
      local cPetPstID = e:PetPstID()
      if shieldFromParam == cPetPstID:GetTemplateID() then
        value = e:Attributes():GetCurrentHP()
        break
      end
    end
  elseif shieldFromType == HPShieldFromType.SpilledHP then
    value = buffInstance:Context().hpSpilled
  elseif shieldFromType == HPShieldFromType.OwnerDefence then
    local attributesComponent = entity:Attributes()
    local totalDefence = attributesComponent:GetDefence()
    value = totalDefence
  elseif shieldFromType == HPShieldFromType.OwnerBaseDefence then
    local attributesComponent = entity:Attributes()
    local baseDefence = attributesComponent:GetAttribute("Defense")
    value = baseDefence
  elseif shieldFromType == HPShieldFromType.OwnerBaseAttack then
    local attributesComponent = entity:Attributes()
    local baseAttack = attributesComponent:GetAttribute("Attack")
    value = baseAttack
  elseif shieldFromType == HPShieldFromType.OwnerAttack then
    local attributesComponent = entity:Attributes()
    local curAttack = attributesComponent:GetAttack()
    value = curAttack
  elseif shieldFromType == HPShieldFromType.OwnerLostHPPercent then
    local cAttributes = entity:Attributes()
    local maxHP = cAttributes:CalcMaxHp()
    local currentHP = cAttributes:GetCurrentHP()
    value = maxHP - currentHP
  elseif shieldFromType == HPShieldFromType.OwnerMaxHPMulPopCount then
    local count = 0
    local popStarProSvc = self._world:GetService("PopStarProLogic")
    if popStarProSvc then
      count = popStarProSvc:GetCountByModifyType(BuffPopStarProModifyType.PopGridCount)
    end
    value = entity:Attributes():CalcMaxHp() * count
  end
  return value
end

function BuffLogicService:GetReplacePetVoiceID()
  if self._world:GetGameTurn() == GameTurnType.RemotePlayerTurn then
    return
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local buffCmpt = teamEntity:BuffComponent()
  local prob = buffCmpt:GetBuffValue("RandomChangeAllPetVoiceProb")
  if prob then
    local random = math.random(1, 100)
    if prob >= random then
      local voiceList = buffCmpt:GetBuffValue("RandomChangeAllPetVoiceVoiceList")
      local index = math.random(1, #voiceList)
      Log.info("RandomChangeAllPetVoiceVoiceList", "Random: ", random, " Prob:", prob, " index = ", index, "voiceID = ", voiceList[index])
      return voiceList[index]
    end
  end
end

function BuffLogicService:GetEntityHPShieldType(entityID)
  local entity = self._world:GetEntityByID(entityID)
  local buffCmpt = entity:BuffComponent()
  if buffCmpt:GetBuffValue("HPShieldType") then
    return buffCmpt:GetBuffValue("HPShieldType")
  end
  return HPShieldType.Normal
end
