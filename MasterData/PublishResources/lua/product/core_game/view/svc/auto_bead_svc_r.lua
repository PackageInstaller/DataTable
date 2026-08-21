require("base_service")
_class("AutoBeadServiceRender", BaseService)
AutoBeadServiceRender = AutoBeadServiceRender

function AutoBeadServiceRender:Constructor(world)
  self.world = world
end

function AutoBeadServiceRender:InitAutoBeadHolder(teamEntity)
  local cTeam = teamEntity:Team()
  local holderEntityID = cTeam:GetAutoBeadSkillHolderID()
  local holderEntity = self._world:GetEntityByID(holderEntityID)
  if not holderEntity then
    return
  end
  local pos = teamEntity:GetPosition()
  local dir = teamEntity:GetDirection()
  holderEntity:SetLocation(pos, dir)
  holderEntity:SetAnimatorControllerTriggers({"idle"})
  local rideEntity = teamEntity
  local mountEntity = holderEntity
  local rideOffset = Vector3(0, 0, 0)
  local mountOffset = Vector3(0, 0, 0)
  local ridLocationCmpt = rideEntity:Location()
  ridLocationCmpt:SetModifyLocationCallback(function(pos, dir)
    self:SetTargetLocation(pos, dir, mountEntity, rideOffset, mountOffset)
  end)
end

function AutoBeadServiceRender:InitAutoBead()
  self:NotifyAutoBeadPointRefreshUI()
end

function AutoBeadServiceRender:SetTargetLocation(pos, dir, targetEntity, oriOffset, targetOffset)
  if not targetEntity:HasLocation() then
    return
  end
  local boardServiceRender = self._world:GetService("BoardRender")
  local targetGridPos = boardServiceRender:BoardRenderPos2FloatGridPos_New(pos)
  targetGridPos = targetGridPos - oriOffset + targetOffset
  local targetPos = boardServiceRender:GridPosition2LocationPos(targetGridPos, targetEntity)
  local locationCmpt = targetEntity:Location()
  locationCmpt:CallBackModifyLocation(targetPos, dir, targetEntity)
end

function AutoBeadServiceRender:OnGridMoveToPos(e, speed, cur_pos, dest_pos, teamEntity)
  local cTeam = teamEntity:Team()
  local holderEntityID = cTeam:GetAutoBeadSkillHolderID()
  local holderEntity = self._world:GetEntityByID(holderEntityID)
  if not holderEntity then
    return
  end
  local leader = teamEntity:GetTeamLeaderPetEntity()
  if leader:GetID() == e:GetID() then
    local group = self._world:GetGroup(self._world.BW_WEMatchers.RenderSyncMoveWithTeam)
    local boardServiceRender = self._world:GetService("BoardRender")
    holderEntity:AddGridMove(speed, dest_pos, cur_pos)
  end
end

function AutoBeadServiceRender:_DoRenderShowAutoBeadAttack(TT, teamEntity)
  self:NotifyAutoBeadPointRefreshUI()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local autoBeadAtkRes = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.AutoBeadAttack)
  if not autoBeadAtkRes then
    return
  end
  local holderEntityID = autoBeadAtkRes:GetHolderEntityID()
  if not holderEntityID then
    return
  end
  local skillDataList = autoBeadAtkRes:GetHolderAutoBeadSkillDataList(holderEntityID)
  if not skillDataList then
    return
  end
  if #skillDataList == 0 then
    return
  end
  local pieceService = self._world:GetService("Piece")
  local chainSkillCnt = #skillDataList
  local holderEntity = self._world:GetEntityByID(holderEntityID)
  if not holderEntity then
    return
  end
  local teamPos = teamEntity:GetPosition()
  holderEntity:SetPosition(teamPos)
  pieceService:SetAllPieceDark()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureAutoBeadSkill, true)
  local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._PlayAutoBeadSkillResultList, self, holderEntity, skillDataList)
  local notCheckTimeOut = true
  while not TaskHelper:GetInstance():IsTaskFinished(taskID, notCheckTimeOut) do
    YIELD(TT)
  end
  pieceService:RefreshPieceAnim()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureAutoBeadSkill, false)
end

function AutoBeadServiceRender:_PlayAutoBeadSkillResultList(TT, casterEntity, resList)
  local skillCount = #resList
  for skillIndex, v in ipairs(resList) do
    local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._DoCastSkill, self, casterEntity, v, skillIndex, skillCount)
    while not TaskHelper:GetInstance():IsTaskFinished(taskID) do
      YIELD(TT)
    end
  end
end

function AutoBeadServiceRender:_DoCastSkill(TT, casterEntity, attackData, skillIndex, skillCount)
  local playEntity = casterEntity
  local resContainer = attackData:GetResultContainer()
  local skillID = resContainer:GetSkillID()
  local configService = self._world:GetService("Config")
  local playBuffSvc = self._world:GetService("PlayBuff")
  local playSkillService = self._world:GetService("PlaySkill")
  local skillPhaseArray = self:_GetAutoBeadSkillPhaseArray(casterEntity, skillID)
  playEntity:SkillRoutine():ClearSkillRoutine()
  playEntity:SkillRoutine():SetResultContainer(resContainer)
  Log.fatal("PlayAutoBeadSkill :", skillID)
  local playSkillTaskIDList = {}
  self:_OnResultDeadEntityAddDeadFlag(casterEntity:GetID(), skillIndex)
  local isFinalAttack = attackData:IsFinalAttack()
  if isFinalAttack then
    self:_CheckFinalAttack(resContainer, casterEntity)
  end
  local autoBeadSkillIndex = attackData:GetAutoBeadSkillIndex()
  resContainer:SetAutoBeadResultSkillIndex(autoBeadSkillIndex)
  local dir = self:GetPetForward(casterEntity)
  if dir then
    casterEntity:SetDirection(dir)
  end
  local autoBeadID = attackData:GetAutoBeadID()
  local nt1 = NTAutoBeadSkillEachStart:New(playEntity, skillID, autoBeadID)
  playBuffSvc:PlayBuffView(TT, nt1)
  local taskid = playSkillService:StartSkillRoutine(playEntity, skillPhaseArray, skillID)
  playSkillTaskIDList[#playSkillTaskIDList + 1] = taskid
  while not TaskHelper:GetInstance():IsTaskFinished(taskid) do
    YIELD(TT)
  end
  local nt2 = NTAutoBeadSkillEachEnd:New(playEntity, skillID, autoBeadID)
  nt2:SetAutoBeadSkillIndex(autoBeadSkillIndex)
  playBuffSvc:PlayBuffView(TT, nt2)
  self:_ShowAttackMonsterDead(TT)
  while not TaskHelper:GetInstance():IsAllTaskFinished(playSkillTaskIDList) do
    YIELD(TT)
  end
end

function AutoBeadServiceRender:_DoCastSkillxxx(TT, casterEntity, attackData, skillIndex, skillCount)
  local skillID = attackData:GetSkillID()
  local playBuffSvc = self._world:GetService("PlayBuff")
  local playSkillService = self._world:GetService("PlaySkill")
  local playEntity = casterEntity
  local skillPhaseArray = self:_GetAutoBeadSkillPhaseArray(casterEntity, skillID)
  playEntity:SkillRoutine():ClearSkillRoutine()
  Log.fatal("PlayAutoBeadSkill :", skillID)
  local playSkillTaskIDList = {}
  self:_OnResultDeadEntityAddDeadFlag(casterEntity:GetID(), skillIndex)
  local results = attackData:GetEffectResultDict()
  local resContainer = SkillEffectResultContainer:New()
  resContainer:SetEffectResultDict(results)
  local skillEffect_Teleport = resContainer:GetEffectResultByArray(SkillEffectType.Teleport)
  if skillEffect_Teleport then
    resContainer:AddEffectResult(skillEffect_Teleport)
  end
  local isFinalAttack = attackData:IsFinalAttack()
  if isFinalAttack then
    self:_CheckFinalAttack(resContainer, casterEntity)
  end
  resContainer:SetScopeResult(attackData:GetScopeResult())
  resContainer:SetSkillID(skillID)
  playEntity:SkillRoutine():SetResultContainer(resContainer)
  local dir = self:GetPetForward(casterEntity)
  if dir then
    casterEntity:SetDirection(dir)
  end
  local taskid = playSkillService:StartSkillRoutine(playEntity, skillPhaseArray, skillID)
  playSkillTaskIDList[#playSkillTaskIDList + 1] = taskid
  while not TaskHelper:GetInstance():IsTaskFinished(taskid) do
    YIELD(TT)
  end
  self:_ShowAttackMonsterDead(TT)
  while not TaskHelper:GetInstance():IsAllTaskFinished(playSkillTaskIDList) do
    YIELD(TT)
  end
end

function AutoBeadServiceRender:_GetAutoBeadSkillPhaseArray(casterEntity, skillID)
  local configService = self._world:GetService("Config")
  local skinId = 1
  local skillConfigData = configService:GetSkillConfigData(skillID, casterEntity)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray(skinId)
  return skillPhaseArray
end

function AutoBeadServiceRender:_OnResultDeadEntityAddDeadFlag(casterEntityID, skillIndex)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local autoBeadAtkResCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.AutoBeadAttack)
  local deadEntityIdList = autoBeadAtkResCmpt:GetDeadEntityIDListByHolder(casterEntityID)
  local deadList = deadEntityIdList[skillIndex]
  if deadList then
    for _, eid in ipairs(deadList) do
      local e = self._world:GetEntityByID(eid)
      e:AddDeadFlag()
    end
  end
end

function AutoBeadServiceRender:_CheckFinalAttack(skillEffectResultContainer, casterEntity)
  local damageReslut = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if damageReslut == nil then
    skillEffectResultContainer:SetFinalAttack(false)
  else
    skillEffectResultContainer:SetFinalAttack(true)
    self:_SortForFinalAttack(damageReslut, casterEntity)
    local skillDamageResult = damageReslut[#damageReslut]
    local finalAttackEnemyID = skillDamageResult:GetTargetID()
    skillEffectResultContainer:SetFinalAttackEntityID(finalAttackEnemyID)
  end
end

function AutoBeadServiceRender:_SortForFinalAttack(skillDamageResultArray, casterEntity)
  if skillDamageResultArray == nil or #skillDamageResultArray <= 1 then
    return skillDamageResultArray
  end
  local count = #skillDamageResultArray
  
  local function CmpBodyAreafunc(skillDamageEffectResult1, skillDamageEffectResult2)
    local areaCount1 = self:_GetAreaCount(skillDamageEffectResult1)
    local areaCount2 = self:_GetAreaCount(skillDamageEffectResult2)
    return areaCount1 < areaCount2
  end
  
  table.sort(skillDamageResultArray, CmpBodyAreafunc)
  local lastSkillDamageResult = skillDamageResultArray[count]
  local maxAreaCount = self:_GetAreaCount(lastSkillDamageResult)
  local sortByAreaArray = {}
  for _, v in ipairs(skillDamageResultArray) do
    local curAreaCount = self:_GetAreaCount(v)
    if curAreaCount == maxAreaCount then
      sortByAreaArray[#sortByAreaArray + 1] = v
    end
  end
  local areaArrayCount = #sortByAreaArray
  if areaArrayCount <= 1 then
    return skillDamageResultArray
  else
    local function CmpDistancefunc(skillDamageEffectResult1, skillDamageEffectResult2)
      local dis1 = self:_GetDistanceToPlayer(skillDamageEffectResult1, casterEntity)
      
      local dis2 = self:_GetDistanceToPlayer(skillDamageEffectResult2, casterEntity)
      return dis1 < dis2
    end
    
    table.sort(sortByAreaArray, CmpDistancefunc)
    local maxDistanceResult = sortByAreaArray[areaArrayCount]
    table.removev(skillDamageResultArray, maxDistanceResult)
    skillDamageResultArray[#skillDamageResultArray + 1] = maxDistanceResult
  end
end

function AutoBeadServiceRender:_GetAreaCount(skillDamageResult)
  local entityID = skillDamageResult:GetTargetID()
  local entity = self._world:GetEntityByID(entityID)
  if entity == nil then
    return 0
  end
  local bodyAreaCmpt = entity:BodyArea()
  local areaCount = 0
  if bodyAreaCmpt ~= nil then
    areaCount = bodyAreaCmpt:GetAreaCount()
  end
  return areaCount
end

function AutoBeadServiceRender:_GetDistanceToPlayer(skillDamageResult, casterEntity)
  local playerPos = casterEntity:GridLocation().Position
  local gridPos = skillDamageResult:GetGridPos()
  return Vector2.Distance(gridPos, playerPos)
end

function AutoBeadServiceRender:GetPetForward(casterEntity)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local casterPos = casterEntity:GridLocation().Position
  local damageResultList = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if not damageResultList or table.count(damageResultList) == 0 then
    return
  end
  local beAttackEntityID = damageResultList[1]:GetTargetID()
  local targetEntity = self._world:GetEntityByID(beAttackEntityID)
  if not targetEntity then
    return
  end
  
  local function get_index(c, p)
    if p.x - c.x == 0 and 0 < p.y - c.y then
      return 1
    end
    if p.x - c.x > 0 and 0 < p.y - c.y then
      return 2
    end
    if p.x - c.x > 0 and p.y - c.y == 0 then
      return 3
    end
    if p.x - c.x > 0 and 0 > p.y - c.y then
      return 4
    end
    if p.x - c.x == 0 and 0 > p.y - c.y then
      return 5
    end
    if p.x - c.x < 0 and 0 > p.y - c.y then
      return 6
    end
    if p.x - c.x < 0 and p.y - c.y == 0 then
      return 7
    end
    if p.x - c.x < 0 and 0 < p.y - c.y then
      return 8
    end
    return 1
  end
  
  local damagePosList = {}
  for i, result in ipairs(damageResultList) do
    if result:GetGridPos() then
      table.insert(damagePosList, result:GetGridPos())
    end
  end
  
  local function cmpFunc(damageResultPos1, damageResultPos2)
    local dis1 = Vector2.Distance(damageResultPos1, casterPos)
    local dis2 = Vector2.Distance(damageResultPos2, casterPos)
    if dis1 == dis2 then
      return get_index(casterPos, damageResultPos1) < get_index(casterPos, damageResultPos2)
    else
      return dis1 < dis2
    end
  end
  
  table.sort(damagePosList, cmpFunc)
  local dir = damagePosList[1] - casterPos
  return dir
end

function AutoBeadServiceRender:_ShowAttackMonsterDead(TT)
  local sMonsterShowRender = self._world:GetService("MonsterShowRender")
  sMonsterShowRender:DoAllMonsterDeadRender(TT)
end

function AutoBeadServiceRender:_StopFocusEffect(TT)
  self._world:MainCamera():EnableDarkCamera(false)
  local toNormalTime = BattleConst.ChainSkillToNormalTime
  local targetAlpha = 0
  local originalAlpha = BattleConst.ChainSkillDarkAlpha
  self._world:MainCamera():EnableDarkCamera(false)
  local lastTime = 0
  local timeService = self._world:GetService("Time")
  local curTime = timeService:GetCurrentTimeMs()
  local startTime = curTime
  local timeLen = curTime - startTime
  while toNormalTime > timeLen do
    local deltaTime = timeService:GetDeltaTimeMs()
    timeLen = timeLen + deltaTime
    local percent = timeLen / toNormalTime
    local imgAlpha = originalAlpha - percent * originalAlpha
    self._world:MainCamera():SetHudBgAlpha(imgAlpha)
    self._world:EventDispatcher():Dispatch(GameEventType.SetHeadMaskAlpha, imgAlpha)
    YIELD(TT)
  end
end

function AutoBeadServiceRender:_StartFocusEffect(TT)
  local toDarkTime = BattleConst.ChainSkillToDarkTime
  local targetAlpha = BattleConst.ChainSkillDarkAlpha
  self._world:MainCamera():EnableDarkCamera(true)
  local lastTime = 0
  local timeService = self._world:GetService("Time")
  local curTime = timeService:GetCurrentTimeMs()
  local startTime = curTime
  local timeLen = curTime - startTime
  while toDarkTime > timeLen do
    local deltaTime = timeService:GetDeltaTimeMs()
    timeLen = timeLen + deltaTime
    local percent = timeLen / toDarkTime
    local imgAlpha = percent * targetAlpha
    self._world:MainCamera():SetHudBgAlpha(imgAlpha)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetHeadMaskAlpha, imgAlpha)
    YIELD(TT)
  end
  local pieceService = self._world:GetService("Piece")
  pieceService:SetAllPieceDark()
end

function AutoBeadServiceRender:NotifyAutoBeadPointRefreshUI()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureAutoBeadPointRefreshUI)
end

function AutoBeadServiceRender:NotifyAutoBeadPointChange(curPoint, oldPoint)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureAutoBeadPointChange, curPoint)
end

function AutoBeadServiceRender:NotifyAutoBeadPointToPowerChange(curPoint, oldPoint)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureAutoBeadPointToPowerChange, curPoint)
end
