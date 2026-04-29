require("custom_node")
require("ai_sort_by_distance")
_class("AINewNode", CustomNode)
AINewNode = AINewNode

function AINewNode:Constructor()
  self.m_stActionLogType = nil
  self.Status = AINewNodeStatus.Ready
  self.m_entityOwn = nil
  self:Activate(true)
  self.m_logicOwn = nil
  self.m_configData = nil
  self.m_logicData = nil
  self._world = nil
  self._genInfo = nil
  self._treeID = nil
end

function AINewNode:Reset()
  self.Status = AINewNodeStatus.Ready
  self.m_logicData = nil
end

function AINewNode:SetLogicData(logicData)
  self.m_logicData = logicData
end

function AINewNode:SetConfigData(configData)
  self.m_configData = configData
end

function AINewNode:GetConfigData()
  return self.m_configData
end

function AINewNode:SetTreeID(treeID)
  self._treeID = treeID
end

function AINewNode:GetTreeID()
  return self._treeID
end

function AINewNode:InitializeNode(cfg, context, logicOwn, configData)
  AINewNode.super.InitializeNode(self, cfg, context)
  local genInfo = context.GenInfo
  self.m_entityOwn = genInfo.OwnerEntity
  self.m_logicOwn = logicOwn
  self.m_configData = configData
  self.CustomLogicID = cfg.ID
  self.CustomLogicType = cfg.Type
  self._world = genInfo.m_world
  self._genInfo = genInfo
  self.m_stActionLogType = "[" .. cfg.Type .. "]"
  if not self.CustomLogicID and not self.m_logicOwn and EDITOR then
    Log.exception("No AIConfigData Trace:", Log.traceback())
  end
end

function AINewNode:GetConfigAIID()
  if self.CustomLogicID then
    return self.CustomLogicID
  elseif self.m_logicOwn then
    return self.m_logicOwn.CustomLogicID
  else
    Log.fatal("No AIConfigIDData")
  end
end

function AINewNode:GetParallelID()
  if self.CustomLogicID then
    return self._parallelID
  elseif self.m_logicOwn then
    return self.m_logicOwn._parallelID
  else
    Log.fatal("No AIConfigIDData")
  end
end

function AINewNode:GetMyOwnEntityID()
  return self.m_entityOwn:GetID()
end

function AINewNode:GetMyOwnEntity()
  return self.m_entityOwn
end

function AINewNode:SetInitialize(world, entityOwn)
  self._world = world
  self.m_entityOwn = entityOwn
end

function AINewNode:SetSkillList(newSkillList)
  self._genInfo:SetSkillList(newSkillList)
end

function AINewNode:Update()
  if self:IsActive() then
    self._world:GetSyncLogger():Trace({
      key = "AINodeUpdate",
      AINode = self._className,
      status = GetEnumKey("AINewNodeStatus", self.Status)
    })
    if self.Status == AINewNodeStatus.Ready then
      self:OnBegin()
      self.Status = AINewNodeStatus.Running
    end
    self.Status = self:OnUpdate()
    self:PrintLog("AINodeStatus=", self.Status)
    if self.Status ~= AINewNodeStatus.Running then
      self:OnEnd()
    end
  end
  return self.Status
end

function AINewNode:OnBegin()
end

function AINewNode:OnUpdate()
  return AINewNodeStatus.Success
end

function AINewNode:OnEnd()
end

function AINewNode:IsEnableStart()
  if self.Status == AINewNodeStatus.Ready or self.Status == AINewNodeStatus.Running then
    return true
  end
  return false
end

function AINewNode:IsRunning()
  if self.Status == AINewNodeStatus.Running then
    return true
  end
  return false
end

function AINewNode:IsReady()
  if self.Status == AINewNodeStatus.Ready then
    return true
  end
  return false
end

function AINewNode:IsSuccess()
  if self.Status == AINewNodeStatus.Success then
    return true
  end
  return false
end

function AINewNode:GetStatues()
  return self.Status
end

function AINewNode:GetActionSkillIDEx(preview)
  if preview then
    return self:GetActionSkillID()
  end
  if self.m_entityOwn:BuffComponent():HasFlag(BuffFlags.Benumb) then
    local skillID = self:GetNormalSkillID() or 0
    self:PrintLog("自行为树选取技能<麻痹Buff不放技能>，技能ID = ", skillID)
    return skillID
  end
  return self:GetActionSkillID()
end

function AINewNode:GetActionSkillID(nIndex)
  return self:GetLogicData(nIndex or 1)
end

function AINewNode:GetAILogicID()
  local nLogicID = self.CustomLogicID or self.m_logicOwn.CustomLogicID or 0
  return nLogicID
end

function AINewNode:GetStrSwitchType(switchType)
  if switchType == AINewNodeStatus.Ready then
    return "Ready"
  elseif switchType == AINewNodeStatus.Running then
    return "Running"
  elseif switchType == AINewNodeStatus.Success then
    return "Success", 1
  elseif switchType == AINewNodeStatus.Failure then
    return "Failure", 2
  elseif switchType > AINewNodeStatus.Other then
    return "Other :" .. switchType, switchType
  else
    Log.fatal("Invalid SwitchType :", switchType, "Trace:", Log.traceback())
  end
end

function AINewNode:AddDebugStream(monsterID, entityID, round, runCount, aiConfigID, aiTreeID, slotID)
  if not self._aiDebugModule then
    self._aiDebugModule = GameGlobal.GetModule(AIDebugModule)
  end
  if not self._aiLogger then
    self._aiLogger = self._world:GetAILogger()
  end
  if EDITOR then
    self._aiDebugModule:AddAIDebugStreamInfo(monsterID, entityID, round, runCount, aiConfigID, aiTreeID, slotID)
  end
  self._aiLogger:AddAIStreamLog(monsterID, entityID, round, runCount, aiConfigID, aiTreeID, slotID)
end

function AINewNode:AddDebugInfo(monsterID, entityID, round, runCount, aiConfigID, aiTreeID, info)
  if not self._aiDebugModule then
    self._aiDebugModule = GameGlobal.GetModule(AIDebugModule)
  end
  if not self._aiLogger then
    self._aiLogger = self._world:GetAILogger()
  end
  if EDITOR then
    self._aiDebugModule:AddAIDebugRunInfo(monsterID, entityID, round, runCount, aiConfigID, aiTreeID, info)
  end
  self._aiLogger:AddAIDebugInfoLog(monsterID, entityID, round, runCount, aiConfigID, aiTreeID, info)
end

function AINewNode:PrintActionSwitchLog(curAction, curTreeID, nextAction, nextTreeID, switchType, nextIsEnd)
  if EDITOR then
    if not self:GetMyOwnEntity():HasMonsterID() then
      return
    end
    if not self._aiDebugModule then
      self._aiDebugModule = GameGlobal.GetModule(AIDebugModule)
      self._aiLogger = self._world:GetAILogger()
    end
    local entityID = curAction:GetMyOwnEntityID()
    local aiConfigID = curAction:GetConfigAIID()
    local curActionType = curAction:GetStrActionType()
    local nextActionInfo = ""
    local switchType, slotID = self:GetStrSwitchType(switchType)
    local aiComponent = self:GetMyOwnEntity():AI()
    local runCount = aiComponent:GetAIRoundRunCount(self:GetConfigAIID())
    local round = self._world:BattleStat():GetLevelTotalRoundCount()
    local monsterID = 0
    if self:GetMyOwnEntity():HasMonsterID() then
      monsterID = self:GetMyOwnEntity():MonsterID():GetMonsterID()
    elseif self:GetMyOwnEntity():HasTrapID() then
      monsterID = self:GetMyOwnEntity():TrapID():GetTrapID()
    end
    local entityID = self:GetMyOwnEntity():GetID()
    self:AddDebugStream(monsterID, entityID, round, runCount, aiConfigID, curTreeID, slotID)
    if nextAction then
      local nextActionType = nextAction:GetStrActionType()
      nextActionInfo = " NextActionTreeID:" .. nextTreeID .. " NexActionType:" .. nextActionType
    end
    local aiComponent = self:GetMyOwnEntity():AI()
    local runCount = aiComponent:GetAIRoundRunCount(self:GetConfigAIID())
    Log.debug("[AI] SwitchNode AIConfigID:", aiConfigID, " RunCount:", runCount, " CurTreeID:", curTreeID, " CurActionType:", curActionType, " SwitchType:", switchType, nextActionInfo)
  end
end

function AINewNode:GetStrActionType()
  return self.m_stActionLogType
end

function AINewNode:PrintDebugLog(...)
  if self._world and self._world:IsDevelopEnv() and EDITOR then
    local aiComponent = self:GetMyOwnEntity():AI()
    local runCount = aiComponent:GetAIRoundRunCount(self:GetConfigAIID())
    local round = self._world:BattleStat():GetLevelTotalRoundCount()
    local monsterID = 0
    if self:GetMyOwnEntity():HasMonsterID() then
      monsterID = self:GetMyOwnEntity():MonsterID():GetMonsterID()
    elseif self:GetMyOwnEntity():HasTrapID() then
      monsterID = self:GetMyOwnEntity():TrapID():GetTrapID()
    end
    local entityID = self:GetMyOwnEntity():GetID()
    local aiConfigID = self:GetConfigAIID()
    local treeID = self:GetTreeID()
    local info = string.args2str({
      ...
    }, " ")
    self:AddDebugInfo(monsterID, entityID, round, runCount, aiConfigID, treeID, info)
  end
end

function AINewNode:PrintLog(...)
  if self._world and self._world:IsDevelopEnv() then
    local aiComponent = self:GetMyOwnEntity():AI()
    local roundCount = aiComponent:GetAIRoundRunCount(self:GetConfigAIID())
    Log.debug("[AI] AIConfigID:", self:GetConfigAIID(), " RunCount:", roundCount, " TreeID:", self:GetTreeID(), " EntityID=", self.m_entityOwn:GetID(), " Action=", self.m_stActionLogType, " ", ...)
    if _G.ENABLE_DETAIL_MATCH_LOG then
      local info = string.args2str({
        ...
      }, " ")
      local aiId = self:GetConfigAIID()
      local aiIdStr = ""
      if aiId then
        aiIdStr = tostring(aiId)
      end
      local treeId = self:GetTreeID()
      local treeIdStr = ""
      if treeId then
        treeIdStr = tostring(treeId)
      end
      local logStr = string.format("[AI] AIConfigID:%s RunCount:%d TreeID:%s EntityID=%d Action=%s %s", aiIdStr, roundCount, treeIdStr, self.m_entityOwn:GetID(), self.m_stActionLogType, info)
      self._world:GetDetailMatchLogger():SimpleLog(logStr)
    end
  end
end

function AINewNode:PrintLog2(...)
  Log.debug("[AI] AIConfigID:", self:GetConfigAIID(), " TreeID:", self:GetTreeID(), " EntityID=", self.m_entityOwn:GetID(), " Action=", self.m_stActionLogType, " ", ...)
  if _G.ENABLE_DETAIL_MATCH_LOG then
    local info = string.args2str({
      ...
    }, " ")
    local aiId = self:GetConfigAIID()
    local aiIdStr = ""
    if aiId then
      aiIdStr = tostring(aiId)
    end
    local treeId = self:GetTreeID()
    local treeIdStr = ""
    if treeId then
      treeIdStr = tostring(treeId)
    end
    local logStr = string.format("[AI] AIConfigID:%s TreeID:%s EntityID=%d Action=%s %s", aiIdStr, treeIdStr, self.m_entityOwn:GetID(), self.m_stActionLogType, info)
    self._world:GetDetailMatchLogger():SimpleLog(logStr)
  end
end

function AINewNode:_MakePosString(posWork)
  return GameHelper.MakePosString(posWork)
end

function AINewNode:GetSelfPos()
  local entityOwn = self.m_entityOwn
  if nil == entityOwn then
    return nil
  end
  return entityOwn:GetGridPosition()
end

function AINewNode.IsEntityDead(entityWork)
  if entityWork and entityWork:HasDeadMark() then
    return true
  end
  return false
end

function AINewNode:GetLogicNodeRoot()
  if nil == self.m_entityOwn then
    return nil
  end
  local aiComponent = self.m_entityOwn:AI()
  if nil == aiComponent then
    return nil
  end
  return aiComponent:GetRootLogic()
end

function AINewNode:_GetLogicData(logicData, nIndex)
  if type(logicData) == "number" then
    return logicData
  elseif type(logicData) == "nil" then
    return nil
  elseif type(logicData) == "table" then
    return logicData[nIndex]
  elseif type(logicData) == "function" then
    return logicData(nIndex)
  end
  return logicData
end

function AINewNode:GetLogicData(nIndex)
  if nIndex and type(nIndex) == "string" then
    return self:_GetLogicData(self.m_configData, nIndex)
  end
  nIndex = nIndex or 0
  if nil == self.m_logicData or nIndex < 0 then
    return self:_GetLogicData(self.m_configData, -nIndex)
  end
  return self:_GetLogicData(self.m_logicData, nIndex)
end

function AINewNode:GetAiComponent()
  return self.m_entityOwn:AI()
end

function AINewNode:GetRuntimeData(key)
  local aiComponent = self:GetAiComponent()
  if nil == aiComponent then
    return nil
  end
  return aiComponent:GetRuntimeData(key)
end

function AINewNode:SetRuntimeData(key, value)
  if self:GetAiComponent() then
    self.m_entityOwn:AI():SetRuntimeData(key, value)
  else
    self:PrintLog("在还没有AI Component时 设置了runtimeData!")
  end
end

function AINewNode:_GetConfigSkillList(monsterID)
  local listSkill
  if 0 < monsterID then
    local configService = self._world:GetService("Config")
    local monsterConfig = configService:GetMonsterConfigData()
    listSkill = monsterConfig:GetMonsterSkillIDs(monsterID)
  end
  return listSkill
end

function AINewNode:GetConfigSkillList()
  local skills = self._genInfo:GetSkillList()
  if nil == skills or #skills <= 0 then
    local nConfigType = self._genInfo:GetGenInfoType()
    if EnumAIGenInfo.Monster == nConfigType then
      local cMonsterID = self.m_entityOwn:MonsterID()
      if cMonsterID then
        skills = self:_GetConfigSkillList(cMonsterID:GetMonsterID())
      end
    else
      skills = self._genInfo:GetSkillList()
    end
  end
  return skills
end

function AINewNode:GetConfigSkillID(nIndexX, nIndexY)
  local vecSkillList = self:GetConfigSkillList()
  return vecSkillList[nIndexX][nIndexY]
end

function AINewNode:GetNormalSkillID()
  local configService = self._world:GetService("Config")
  local vecSkillList = self:GetConfigSkillList()
  for i, vec in ipairs(vecSkillList) do
    if type(vec) == "table" then
      for j, skillID in ipairs(vec) do
        local cfg = configService:GetSkillConfigData(skillID)
        local skillType = cfg:GetSkillType()
        if skillType == SkillType.Normal then
          return skillID
        end
      end
    else
      local skillID = vec
      local cfg = configService:GetSkillConfigData(skillID)
      local skillType = cfg:GetSkillType()
      if skillType == SkillType.Normal then
        return skillID
      end
    end
  end
end

function AINewNode:GetGameRountNow()
  local battleStatCmpt = self._world:BattleStat()
  local round = battleStatCmpt:GetCurWaveTotalRoundCount()
  return round
end

function AINewNode:GetWaveIndexNow()
  local battleStatCmpt = self._world:BattleStat()
  local waveIndex = battleStatCmpt:GetCurWaveIndex()
  return waveIndex
end

function AINewNode:IsPosAccessible(pos)
  if false == self.m_entityOwn:HasBodyArea() then
    return true
  end
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local monsterIDCmpt = self.m_entityOwn:MonsterID()
  local nMonsterBlockData = monsterIDCmpt:GetMonsterBlockData()
  local coverList = self:GetCoverAreaList(pos)
  local coverListSelf = self:GetCoverAreaList(self.m_entityOwn:GetGridPosition())
  for i = 1, #coverList do
    local posWork = coverList[i]
    if not table.icontains(coverListSelf, posWork) and boardServiceLogic:IsPosBlock(posWork, nMonsterBlockData) then
      return false
    end
  end
  return true
end

function AINewNode:FindPosValid(planPosList, defPos)
  if nil == planPosList or planPosList:Size() <= 0 then
    return defPos
  end
  local posSelf = defPos
  local posReturn = posSelf
  local nPosCount = planPosList:Size()
  for i = 1, nPosCount do
    local posWork = planPosList:GetAt(i)
    local bAccessible = self:IsPosAccessible(posWork.data)
    if true == bAccessible then
      posReturn = posWork.data
      break
    end
  end
  return posReturn
end

function AINewNode:FindPosValidAndConnected(planPosList, posTarget, posDefault)
  if nil == planPosList then
    return posDefault
  end
  local posReturn = posDefault
  local nPosCount = planPosList:Size()
  for i = 1, nPosCount do
    local posWork = planPosList:GetAt(i)
    local bAccessible = self:IsPosAccessible(posWork.data)
    if true == bAccessible and self:IsPosConnected(posTarget, posWork.data) then
      posReturn = posWork.data
      break
    end
  end
  return posReturn
end

function AINewNode:GetCoverAreaList(pos)
  local posList = {}
  if self.m_entityOwn then
    posList = self.m_entityOwn:GetCoverAreaList(pos, self:GetFakeBodyArea())
  end
  return posList
end

function AINewNode:GetAreaList(casterEntity)
  local fakeBodyArea = self:GetFakeBodyArea()
  if fakeBodyArea then
    return fakeBodyArea
  end
  local selfBodyArea = casterEntity:BodyArea():GetArea()
  return selfBodyArea
end

function AINewNode:GetFakeBodyArea()
end

function AINewNode:IsHaveObstacle(posStart, posEnd)
  local direct = posEnd - posStart
  local nMax = math.max(math.abs(direct.x), math.abs(direct.y))
  if 0 == nMax then
    return false
  end
  direct.x = direct.x / nMax
  direct.y = direct.y / nMax
  local posWork = posStart + direct
  local posLogic = Vector2.New(math.floor(posWork.x), math.floor(posWork.y))
  while posLogic ~= posEnd do
    if false == self:IsPosAccessible(posLogic) then
      return true
    end
    posWork = posWork + direct
    posLogic.x = math.floor(posWork.x)
    posLogic.y = math.floor(posWork.y)
  end
  return false
end

function AINewNode:IsPosConnected(posStart, posEnd)
  local bHaveObstacle = self:IsHaveObstacle(posStart, posEnd)
  return false == bHaveObstacle
end

function AINewNode:ComputeWalkRange(centerPos, nWalkStep, bFilter)
  bFilter = bFilter or false
  local cbFilter
  if bFilter then
    cbFilter = Callback:New(1, self.IsPosAccessible, self)
  end
  return ComputeScopeRange.ComputeRange_WalkMathPos(centerPos, 1, nWalkStep, cbFilter)
end

function AINewNode:IsTargetInRange(casterEntity, targetType, targetTypeParam, scopeCenterType, scopeType, scopeParam)
  local dir = casterEntity:GridLocation().Direction
  local casterBodyArea = casterEntity:BodyArea():GetArea()
  local casterPos = casterEntity:GetGridPosition()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalc = utilScopeSvc:GetSkillScopeCalc()
  local centerPos, bodyArea = skillCalc._gridFilter:CalcCenterPosAndBodyArea(scopeCenterType, casterPos, casterBodyArea, scopeParam)
  local result = skillCalc:ComputeScopeRange(scopeType, scopeParam, centerPos, bodyArea, dir, targetType, casterPos, casterEntity)
  local targetEntityIDArray = utilScopeSvc:SelectSkillTarget(self.m_entityOwn, targetType, result, nil, targetTypeParam)
  return 0 < #targetEntityIDArray
end

function AINewNode:_CalculateSkillScope(skillID, centerPos, dir, bodyAreaList, entityCaster)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalculater = utilScopeSvc:GetSkillScopeCalc()
  dir = dir or Vector2(0, 1)
  local skillResult = skillCalculater:CalcSkillScope(skillConfigData, centerPos, dir, bodyAreaList, entityCaster)
  return skillResult
end

function AINewNode:SkillRangeIsBlock(nSkillID, BlockFlag)
  local entityCaster = self.m_entityOwn
  local aiComponent = entityCaster:AI()
  if nil == aiComponent then
    return false
  end
  local selfPos = entityCaster:GetGridPosition()
  local dir = entityCaster:GridLocation().Direction
  local selfBodyArea = entityCaster:BodyArea():GetArea()
  local skillResult = self:_CalculateSkillScope(nSkillID, selfPos, dir, selfBodyArea, entityCaster)
  if not skillResult then
    return true
  end
  local range = skillResult:GetWholeGridRange()
  local boardSvc = self._world:GetService("BoardLogic")
  for _, pos in ipairs(range) do
    if boardSvc:IsPosBlock(pos, BlockFlag) then
      return true
    end
  end
  return false
end

function AINewNode:IsSkillTargetInSkillRange(nSkillID)
  local entityCaster = self.m_entityOwn
  local aiComponent = entityCaster:AI()
  if nil == aiComponent then
    return false
  end
  local selfPos = entityCaster:GetGridPosition()
  local dir = entityCaster:GridLocation().Direction
  local selfBodyArea = self:GetAreaList(entityCaster)
  local targetIDList = self:GetSkillTargetList(nSkillID, selfPos, dir, selfBodyArea, entityCaster)
  return 0 < #targetIDList
end

function AINewNode:GetSkillTargetList(skillID, centerPos, dir, bodyAreaList, entityCaster)
  local skillResult = self:_CalculateSkillScope(skillID, centerPos, dir, bodyAreaList, entityCaster)
  if not skillResult then
    return {}
  end
  local configService = self._world:GetService("Config")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local targetType = skillConfigData:GetSkillTargetType()
  local targetEntityIDArray = utilScopeSvc:SelectSkillTarget(self.m_entityOwn, targetType, skillResult, skillID)
  return targetEntityIDArray
end

function AINewNode:CalculateSkillRange(skillID, centerPos, dir, bodyAreaList)
  local skillResult = self:_CalculateSkillScope(skillID, centerPos, dir, bodyAreaList)
  if not skillResult then
    return {}
  end
  local skillRange = skillResult:GetAttackRange()
  local listReturn = {}
  for i = 1, #skillRange do
    local posWork = skillRange[i]
    if false == table.icontains(listReturn, posWork) then
      table.insert(listReturn, posWork)
    end
  end
  return listReturn
end

function AINewNode:IsEntityInSkillRange(nSkillID, entityTarget)
  local entityCaster = self.m_entityOwn
  local aiComponent = entityCaster:AI()
  if nil == aiComponent then
    return false
  end
  local selfPos = entityCaster:GetGridPosition()
  local dir = entityCaster:GridLocation().Direction
  local selfBodyArea = self:GetAreaList(entityCaster)
  local skillRangeData = self:CalculateSkillRange(nSkillID, selfPos, dir, selfBodyArea)
  if not entityTarget or #skillRangeData == 0 then
    self:PrintLog("skillID = ", nSkillID, ", 技能范围为空<不能攻击>")
    return false
  end
  local bSuccess = self:_IsTargetInSkillRange(entityTarget, skillRangeData)
  if true == bSuccess then
    self:PrintLog("skillID = ", nSkillID, ", 技能范围内<可以攻击>")
    return true
  else
    local configService = self._world:GetService("Config")
    local skillConfigData = configService:GetSkillConfigData(nSkillID)
    if SkillTargetType.Monster == skillConfigData:GetSkillTargetType() then
      self:PrintLog("skillID = ", nSkillID, ", 同组范围<可以攻击>")
      return true
    end
    self:PrintLog("skillID = ", nSkillID, ", 技能范围外<不能攻击>")
    return false
  end
  self:PrintLog("skillID = ", nSkillID, ", 技能范围外<不能攻击>")
  return false
end

function AINewNode.InsertSortedArray(sortedArray, centerPos, workPos, nIndex)
  local posData = AiSortByDistance:New(centerPos, workPos, nIndex)
  sortedArray:Insert(posData)
end

function AINewNode.InsertSortedArrayDisAndDir(sortedArray, centerPos, workPos, curPos, nIndex)
  local posData = AiSortByDistanceAndDir:New(centerPos, workPos, curPos, nIndex)
  sortedArray:Insert(posData)
end

function AINewNode:_IsOneLine(posA, posB, posC, bCheckPath)
  local bOneLine = GameHelper.IsPointOneLine(posA, posB, posC)
  return bOneLine
end

function AINewNode.CheckHitBlockPath(world, posStart, posEnd)
  local bBlockPath = false
  local utilSvc = world:GetService("UtilData")
  local boardServiceLogic = world:GetService("BoardLogic")
  local posDir = GameHelper.ComputeLogicDir(posEnd - posStart)
  local posWork = posStart + posDir
  while posWork ~= posEnd do
    local listEntityBomb = utilSvc:GetTrapsAtPos(posWork)
    if table.count(listEntityBomb) > 0 and boardServiceLogic:IsPosBlock(posWork, BlockFlag.HitBack) then
      bBlockPath = true
      break
    end
    posWork = posWork + posDir
  end
  return bBlockPath
end

function AINewNode:_IsCanHitBombToPlayer(posMonster, posBomb, posPlayer, bCheckPath)
  local bOneLine = GameHelper.IsPointOneLine(posMonster, posBomb, posPlayer)
  if nil == bCheckPath then
    return bOneLine
  end
  bOneLine = bOneLine and not AINewNode.CheckHitBlockPath(self._world, posBomb, posPlayer)
  return bOneLine
end

function AINewNode:_IsAllAIMoveDone()
  local aiSchSvc = self._world:GetService("AIScheduler")
  local aiList = aiSchSvc:GetAIList()
  self:PrintLog("_IsAllAIMoveDone() aiList count=", aiList:Size())
  for i = 1, aiList:Size() do
    local e = aiList:GetAt(i)
    self:PrintLog("_IsAllAIMoveDone() aiList[", i, "]=", e:GetID())
    local aiCmpt = e:AI()
    local hasDeadMark = e:HasDeadMark()
    if not hasDeadMark and aiCmpt then
      local st = aiCmpt:GetMoveState()
      local entityID = e:GetID()
      if st ~= AIMoveState.MoveEnd then
        self:PrintLog("[AI] IsAllAIMoveDone() false entityID=", entityID, " moveState=", GetEnumKey("AIMoveState", st))
        return false
      end
    end
  end
  return true
end

function AINewNode:GetLogicSkillID()
  local skillIndexX, skillIndexY = self:GetLogicData(-1), self:GetLogicData(-2)
  if skillIndexY then
    local nSkillID = self:GetConfigSkillID(skillIndexX, skillIndexY)
    return nSkillID
  else
    return skillIndexX
  end
end

function AINewNode:GetMonsterGroupID()
  local monsterIDCmpt = self.m_entityOwn:MonsterID()
  local monsterMoveGroupID = monsterIDCmpt:GetMoveGroupID()
  return monsterMoveGroupID
end

function AINewNode:GetAllGroupMonster()
  local monsterIDCmpt = self.m_entityOwn:MonsterID()
  local monsterMoveGroupID = monsterIDCmpt:GetMoveGroupID()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  self._sameGroupMonsterList = utilCalcSvc:FindMonsterByMoveGroupID(monsterMoveGroupID)
end
