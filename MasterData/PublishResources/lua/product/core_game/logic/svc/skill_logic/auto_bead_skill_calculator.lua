_class("AutoBeadSkillCalculator", Object)
AutoBeadSkillCalculator = AutoBeadSkillCalculator

function AutoBeadSkillCalculator:Constructor(world)
  self._world = world
  self._targetSelector = world:GetSkillScopeTargetSelector()
end

function AutoBeadSkillCalculator:DoCalculateAutoBeadSkill(teamEntity, skillCastPos)
  self:_CalcAutoBeadSkill(teamEntity, skillCastPos)
end

function AutoBeadSkillCalculator:_CalcChainPathRate(teamEntity)
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local chainPath = logicChainPathCmpt:GetLogicChainPath()
  return logicChainPathCmpt:GetChainRateAtIndex(#chainPath)
end

function AutoBeadSkillCalculator:_CalcAutoBeadSkill(teamEntity, castPos)
  local autoBeadServiceLogic = self._world:GetService("AutoBeadLogic")
  local holderEntity = autoBeadServiceLogic:GetAutoBeadSkillHolder(teamEntity)
  if not holderEntity then
    return
  end
  local autoBeadCmpt = holderEntity:LogicAutoBead()
  if not autoBeadCmpt then
    return
  end
  local utilData = self._world:GetService("UtilData")
  self:_OnSetSkillAutoBeadAttackData(holderEntity)
  local skillList = {}
  local skillDataList = {}
  local dataList = autoBeadCmpt:GetAutoBeadInnerDataList()
  for index, data in ipairs(dataList) do
    local innerData = data
    local skillID = innerData:GetAutoBeadSkillID()
    if skillID and 0 < skillID then
      table.insert(skillList, skillID)
      table.insert(skillDataList, innerData)
    end
  end
  local attack = 5000
  local attributeCmpt = holderEntity:Attributes()
  attributeCmpt:Modify("Attack", attack)
  local autoBeadCmpt = holderEntity:LogicAutoBead()
  if not autoBeadCmpt then
    return
  end
  Log.debug("[AutoBeadSkill] begin cast")
  local randomSvc = self._world:GetService("RandomLogic")
  local power = autoBeadCmpt:GetAutoBeadPower()
  local loopTurnIndex = 1
  while 0 < power do
    local skillBeadCount = #skillDataList
    for i = 1, skillBeadCount do
      local autoBeadData = skillDataList[i]
      local autoBeadID = autoBeadData:GetAutoBeadID()
      local skillID = autoBeadData:GetAutoBeadSkillID()
      local extraIndex = 1
      local extraCount = 1
      while extraIndex <= extraCount do
        local comboRate = autoBeadData:GetAutoBeadAttr(ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_Combo)
        local repeatRate = comboRate / 1000
        local repeatIndex = 1
        local repeatCount = 1
        local repeatLimit = 50
        while repeatIndex <= repeatCount do
          Log.debug("[AutoBeadSkill] cast skillID:", skillID, " beadID:", autoBeadID, " loop:", loopTurnIndex, " extra:", extraIndex, " repeat:", repeatIndex)
          self:_CalcOneAutoBeedSkill(teamEntity, skillID, autoBeadID, loopTurnIndex, i, extraIndex, repeatIndex)
          repeatIndex = repeatIndex + 1
          local r = randomSvc:LogicRand()
          if repeatRate > r then
            repeatCount = repeatCount + 1
            Log.debug("[AutoBeadSkill] skillID:", skillID, " beadID:", autoBeadID, " caclRepeat, rate:", repeatRate, " random:", r, " repeat+1")
          else
            Log.debug("[AutoBeadSkill] skillID:", skillID, " beadID:", autoBeadID, " caclRepeat, rate:", repeatRate, " random:", r, " no repeat")
          end
          if repeatLimit < repeatCount then
            repeatCount = repeatLimit
          end
        end
        if extraIndex == 1 then
          local extraRate = autoBeadData:GetAutoBeadExtraRate()
          if extraRate and 0 < extraRate then
            local r = randomSvc:LogicRand()
            if extraRate > r then
              extraCount = extraCount + 1
              Log.debug("[AutoBeadSkill] skillID:", skillID, " beadID:", autoBeadID, " caclExtra, rate:", extraRate, " random:", r, " has extra")
            else
              Log.debug("[AutoBeadSkill] skillID:", skillID, " beadID:", autoBeadID, " caclExtra, rate:", extraRate, " random:", r, " no extra")
            end
          end
        end
        extraIndex = extraIndex + 1
      end
    end
    power = power - 1
    loopTurnIndex = loopTurnIndex + 1
    if 0 < #skillDataList then
      local costPoint = autoBeadCmpt:GetAutoBeadPointEachPower()
      autoBeadServiceLogic:SubAutoBeadPoint(teamEntity, costPoint)
    end
  end
  Log.debug("[AutoBeadSkill] end cast")
end

function AutoBeadSkillCalculator:_OnSetSkillAutoBeadAttackData(holderEntity)
  local autoBeadAttackDataCmpt = holderEntity:SkillAutoBeadAttackData()
  autoBeadAttackDataCmpt:ClearAutoBeadAttackData()
end

function AutoBeadSkillCalculator:_AutoBeedSkillHasNoTarget(casterEntity, skillID, castPos)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local configService = self._world:GetService("Config")
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  local skillConfigData = configService:GetSkillConfigData(skillID, casterEntity)
  local svcCfgDeco = self._world:GetService("ConfigDecoration")
  local skillEffectArray = svcCfgDeco:GetLatestEffectParamArray(casterEntity:GetID(), skillID)
  local effectType191, effectType203
  for _, effect in ipairs(skillEffectArray) do
    if effect:GetEffectType() == SkillEffectType.DynamicCenterDamage then
      effectType191 = effect
    end
    if effect:GetEffectType() == SkillEffectType.DynamicScopeChainDamage then
      effectType203 = effect
    end
  end
  local scopeResult
  local targetList = {}
  if effectType191 then
    local calc191 = SkillEffectCalc_DynamicCenterDamage:New(self._world)
    targetList, scopeResult = calc191:SelectCenter(casterEntity, effectType191, castPos)
  elseif effectType203 then
    local calc203 = SkillEffectCalc_DynamicScopeChainDamage:New(self._world)
    scopeResult = calc203:CalcChainReplaceScope(casterEntity, effectType203)
    targetList = self:_CalcTargetListInScopeResult(casterEntity, scopeResult, skillID)
  else
    scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, castPos, casterEntity)
    boardCmpt:ClearTmpPieceType()
    targetList = self:_CalcTargetListInScopeResult(casterEntity, scopeResult, skillID)
  end
  if #targetList <= 0 then
    return true
  end
  return false
end

function AutoBeadSkillCalculator:_CalcOneAutoBeedSkill(teamEntity, skillID, autoBeadID, loopTurnIndex, beadIndex, extraIndex, repeatIndex)
  local autoBeadServiceLogic = self._world:GetService("AutoBeadLogic")
  local holderEntity = autoBeadServiceLogic:GetAutoBeadSkillHolder(teamEntity)
  if not holderEntity then
    return
  end
  local casterEntity = holderEntity
  local castPos = casterEntity:GetGridPosition()
  local battleService = self._world:GetService("Battle")
  if self:_AutoBeedSkillHasNoTarget(casterEntity, skillID, castPos) then
    return
  end
  local autoBeadAttackDataCmpt = holderEntity:SkillAutoBeadAttackData()
  local curList = autoBeadAttackDataCmpt:GetAutoBeadAttackDataList()
  local curSkillIndex = #curList + 1
  autoBeadAttackDataCmpt:SetCurrentAutoBeadID(autoBeadID)
  autoBeadAttackDataCmpt:AddAutoBeadAttackData(autoBeadID, skillID, curSkillIndex, loopTurnIndex, beadIndex, extraIndex, repeatIndex)
  local autoBeadAttackData = autoBeadAttackDataCmpt:GetAutoBeadAttackData(curSkillIndex)
  local isFinalAttackBeforeSkill = battleService:IsFinalAttack()
  local nTAutoBeadSkillEachStart = NTAutoBeadSkillEachStart:New(holderEntity, skillID, autoBeadID)
  self._world:GetService("Trigger"):Notify(nTAutoBeadSkillEachStart)
  local skillLogicSvc = self._world:GetService("SkillLogic")
  skillLogicSvc:CalcSkillEffect(holderEntity, skillID)
  local nTAutoBeadSkillEachEnd = NTAutoBeadSkillEachEnd:New(holderEntity, skillID, autoBeadID)
  nTAutoBeadSkillEachEnd:SetAutoBeadSkillIndex(curSkillIndex)
  self._world:GetService("Trigger"):Notify(nTAutoBeadSkillEachEnd)
  local skillEffectResultContainer = holderEntity:SkillContext():GetResultContainer()
  skillEffectResultContainer:SetSkillID(skillID)
  autoBeadAttackData:SetResultContainer(skillEffectResultContainer)
  self:_HandleAutoBeadAttackDead(holderEntity:GetID(), curSkillIndex, skillID)
  local isFinalAttack = battleService:IsFinalAttack()
  if not isFinalAttackBeforeSkill and isFinalAttack then
    autoBeadAttackData:SetFinalAttack(true)
  end
  autoBeadAttackDataCmpt:ClearCurrentAutoBeadID()
  holderEntity:ReplaceSkillContext()
end

function AutoBeadSkillCalculator:_CalcTargetListInScopeResult(casterEntity, scopeResult, skillID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, casterEntity)
  local skillTargetType = skillConfigData:GetSkillTargetType()
  local targetEntityIDArray = self._targetSelector:DoSelectSkillTarget(casterEntity, skillTargetType, scopeResult, skillID)
  return targetEntityIDArray
end

function AutoBeadSkillCalculator:_HandleAutoBeadAttackDead(casterEntityID, skillIndex, autoBeadSkillID)
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    local result = sMonsterShowLogic:AddMonsterDeadMark(e)
    local deadMarkCmpt = e:DeadMark()
    if result and deadMarkCmpt and not deadMarkCmpt:GetDeadCasterID() and not e:HasShowDeath() then
      deadMarkCmpt:SetDeadCasterID(casterEntityID)
      deadMarkCmpt:SetAutoBeadAttackIndex(skillIndex)
    end
  end
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.TrapID)
  for _, e in ipairs(trapGroup:GetEntities()) do
    trapServiceLogic:AddTrapDeadMark(e)
    local deadMarkCmpt = e:DeadMark()
    if deadMarkCmpt and not deadMarkCmpt:GetDeadCasterID() then
      deadMarkCmpt:SetDeadCasterID(casterEntityID)
      deadMarkCmpt:SetAutoBeadAttackIndex(skillIndex)
    end
  end
  sMonsterShowLogic:DoAllMonsterDeadLogic()
end
