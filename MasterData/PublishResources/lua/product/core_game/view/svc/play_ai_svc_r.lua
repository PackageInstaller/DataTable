_class("PlayAIService", BaseService)
PlayAIService = PlayAIService

function PlayAIService:DoCommonRountine(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local recorderCmpt = renderBoardEntity:AIRecorder()
  local orderList = recorderCmpt:GetOrderList()
  for i, order in ipairs(orderList) do
    recorderCmpt:SetCurrentOrder(order)
    local entityIDList = recorderCmpt:GetAIWalkerIDList()
    local waitTaskList = {}
    for _, entityID in ipairs(entityIDList) do
      local casterEntity = self._world:GetEntityByID(entityID)
      local collection = recorderCmpt:GetAIResultCollection(entityID)
      if collection and collection:HasNormalAttackResult() then
        local resList = collection:GetNormalAttackResultList()
        local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._PlayAISkillResultList, self, casterEntity, resList)
        waitTaskList[#waitTaskList + 1] = taskID
      end
    end
    if 0 < #waitTaskList then
      while not TaskHelper:GetInstance():IsAllTaskFinished(waitTaskList) do
        YIELD(TT)
      end
    end
    entityIDList = recorderCmpt:GetAICasterIDList()
    for _, entityID in ipairs(entityIDList) do
      local casterEntity = self._world:GetEntityByID(entityID)
      local collection = recorderCmpt:GetAIResultCollection(entityID)
      if collection and collection:HasSpellResult() then
        local resList = collection:GetSpellResultList()
        local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._PlayAISkillResultList, self, casterEntity, resList)
        while not TaskHelper:GetInstance():IsTaskFinished(taskID) do
          YIELD(TT)
        end
      end
    end
    entityIDList = recorderCmpt:GetAIRotateBodyAreaIDList()
    for _, entityID in ipairs(entityIDList) do
      local casterEntity = self._world:GetEntityByID(entityID)
      local collection = recorderCmpt:GetAIResultCollection(entityID)
      if collection and collection:HasRotateBodyAreaResult() then
        playBuffSvc:PlayBuffView(TT, NTBodyAreaChange:New(casterEntity))
      end
    end
  end
  recorderCmpt:ClearAIRecorder()
end

function PlayAIService:_PlayAISkillResultList(TT, casterEntity, resList)
  for _, v in ipairs(resList) do
    if not v:IsHadPlay() then
      local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._DoCastSkill, self, casterEntity, v)
      while not TaskHelper:GetInstance():IsTaskFinished(taskID) do
        YIELD(TT)
      end
      v:HadPlay()
    end
  end
end

function PlayAIService:_DoCastSkill(TT, casterEntity, aiSkillResult)
  local configService = self._world:GetService("Config")
  local skillEffectResultContainer = aiSkillResult:GetResultContainer()
  casterEntity:SkillRoutine():SetResultContainer(skillEffectResultContainer)
  casterEntity:SetDirection(aiSkillResult:GetCastSkillDir())
  local aiSkillID = skillEffectResultContainer:GetSkillID()
  local buffCmpt = casterEntity:BuffView()
  local petEID = buffCmpt:GetBuffValue("ChangeModelWithPetIndex")
  if petEID then
    local petEntity = self._world:GetEntityByID(petEID)
    aiSkillID = petEntity:SkillInfo():GetNormalSkillID()
    local skillConfigDataPet = configService:GetSkillConfigData(aiSkillID, casterEntity)
    local needUseNormalAttackView = false
    local skillEffectArray = skillConfigDataPet:GetSkillEffect()
    for _, effect in ipairs(skillEffectArray) do
      if effect:GetEffectType() == SkillEffectType.TransferTarget then
        needUseNormalAttackView = true
        break
      end
    end
    if needUseNormalAttackView then
      local petEntity = self._world:GetEntityByID(petEID)
      aiSkillID = tonumber(petEntity:PetPstID():GetTemplateID() .. "01")
    end
  end
  local skillConfigData = configService:GetSkillConfigData(aiSkillID, casterEntity)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray()
  Log.debug("[PlayAI]Entity:", casterEntity:GetID(), " cast skill:", aiSkillID, ",frame:", UnityEngine.Time.frameCount)
  local playSkillService = self._world:GetService("PlaySkill")
  local waitTaskID = playSkillService:StartSkillRoutine(casterEntity, skillPhaseArray, aiSkillID)
  while not TaskHelper:GetInstance():IsTaskFinished(waitTaskID) do
    YIELD(TT)
  end
  self:_PlayChessPetDead(TT, aiSkillResult)
  Log.debug("[PlayAI]Entity:", casterEntity:GetID(), " finish cast,skill:", aiSkillID, ",frame:", UnityEngine.Time.frameCount)
end

function PlayAIService:PlayParallelSpellResult(TT)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local recorderCmpt = renderBoardEntity:AIRecorder()
  local parallelResultList = recorderCmpt:GetAllParallelSpellResultList()
  for _, aiSkillResultListByCasterID in HelperProxy:GetInstance():pairsByKeys(parallelResultList) do
    local taskList = {}
    for casterEntityID, aiSkillResultList in pairs(aiSkillResultListByCasterID) do
      local monsterEntity = self._world:GetEntityByID(casterEntityID)
      local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._PlayAISkillResultList, self, monsterEntity, aiSkillResultList)
      table.insert(taskList, taskID)
    end
    while not TaskHelper:GetInstance():IsAllTaskFinished(taskList) do
      YIELD(TT)
    end
  end
end

function PlayAIService:DoMainAIRountine(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  local waitTaskList = {}
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local recorderCmpt = renderBoardEntity:AIRecorder()
  local orderList = recorderCmpt:GetOrderList()
  self:PlayParallelSpellResult(TT)
  for i, order in ipairs(orderList) do
    recorderCmpt:SetCurrentOrder(order)
    local entityIDList = recorderCmpt:GetAIWalkerIDList()
    for _, entityID in ipairs(entityIDList) do
      local e = self._world:GetEntityByID(entityID)
      if not e:HasMonsterID() then
        Log.error("DoMainAIRountine() NOT MONSTER!!")
      end
      local collection = recorderCmpt:GetAIResultCollection(e:GetID())
      local walkResultList = collection:GetWalkResultList()
      local normalResultList = collection:GetNormalAttackResultList()
      local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._DoWalkAttack, self, e, walkResultList, normalResultList)
      if 0 < taskID then
        waitTaskList[#waitTaskList + 1] = taskID
      end
    end
    if 0 < #waitTaskList then
      while not TaskHelper:GetInstance():IsAllTaskFinished(waitTaskList) do
        YIELD(TT)
      end
    end
    entityIDList = recorderCmpt:GetAICasterIDList()
    for _, entityID in ipairs(entityIDList) do
      local monsterEntity = self._world:GetEntityByID(entityID)
      local collection = recorderCmpt:GetAIResultCollection(entityID)
      if collection and collection:HasSpellResult() then
        local resList = collection:GetSpellResultList()
        local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._PlayAISkillResultList, self, monsterEntity, resList)
        while not TaskHelper:GetInstance():IsTaskFinished(taskID) do
          YIELD(TT)
        end
      end
    end
    entityIDList = recorderCmpt:GetAIRotateBodyAreaIDList()
    for _, entityID in ipairs(entityIDList) do
      local casterEntity = self._world:GetEntityByID(entityID)
      local collection = recorderCmpt:GetAIResultCollection(entityID)
      if collection and collection:HasRotateBodyAreaResult() then
        playBuffSvc:PlayBuffView(TT, NTBodyAreaChange:New(casterEntity))
      end
    end
  end
  recorderCmpt:ClearAIRecorder()
end

function PlayAIService:_DoWalkAttack(TT, monsterEntity, walkResultList, normalResultList)
  local boardServiceRender = self._world:GetService("BoardRender")
  local moveSpeed = self:_GetMoveSpeed(monsterEntity)
  local hasWalkPoint = false
  if 0 < #walkResultList then
    hasWalkPoint = true
  end
  if hasWalkPoint then
    self:StartMoveAnimation(monsterEntity, true)
    boardServiceRender:RefreshPiece(monsterEntity, true, true)
  end
  for _, v in ipairs(walkResultList) do
    local walkRes = v
    local walkPos = walkRes:GetWalkPos()
    local boardServiceRender = self._world:GetService("BoardRender")
    local curPos = boardServiceRender:GetRealEntityGridPos(monsterEntity)
    monsterEntity:AddGridMove(moveSpeed, walkPos, curPos)
    local walkDir = walkPos - curPos
    local bodyAreaCmpt = monsterEntity:BodyArea()
    local areaCount = bodyAreaCmpt:GetAreaCount()
    if areaCount == 4 then
      local leftDownPos = Vector2(curPos.x - 0.5, curPos.y - 0.5)
      walkDir = walkPos - leftDownPos
    end
    monsterEntity:SetDirection(walkDir)
    Log.debug("[PlayAI]Entity:", monsterEntity:GetID(), ",CurPos:", curPos, " WalkTo,", walkPos)
    while monsterEntity:HasGridMove() do
      YIELD(TT)
    end
    self:_PlayArrivePos(TT, monsterEntity, walkRes, curPos)
  end
  if hasWalkPoint then
    self:StartMoveAnimation(monsterEntity, false)
    boardServiceRender:RefreshPiece(monsterEntity, false, true)
  end
  Log.debug("[PlayAI]Entity:", monsterEntity:GetID(), ",finish walk")
  self:_PlayAISkillResultList(TT, monsterEntity, normalResultList)
end

function PlayAIService:_PlayArrivePos(TT, monsterEntity, walkRes, oldPos)
  local trapResList = walkRes:GetWalkTrapResultList()
  for _, v in ipairs(trapResList) do
    local walkTrapRes = v
    local trapEntityID = walkTrapRes:GetTrapEntityID()
    local trapEntity = self._world:GetEntityByID(trapEntityID)
    local trapSkillRes = walkTrapRes:GetTrapResult()
    local skillEffectResultContainer = trapSkillRes:GetResultContainer()
    trapEntity:SkillRoutine():SetResultContainer(skillEffectResultContainer)
    Log.debug("[AIMove] PlayArrivePos() monster=", monsterEntity:GetID(), " pos=", walkRes:GetWalkPos(), " play trapid=", trapEntity:GetID(), " defender=", skillEffectResultContainer:GetScopeResult():GetTargetIDs()[1])
    local trapSvc = self._world:GetService("TrapRender")
    trapSvc:PlayTrapTriggerSkill(TT, trapEntity, false, monsterEntity)
  end
  local passGrids = walkRes:GetWalkPassedGrid()
  local nt = NTMonsterMoveOneFinish:New(monsterEntity, passGrids, walkRes:GetWalkPos(), oldPos)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, nt)
end

function PlayAIService:_GetMoveSpeed(casterEntity)
  local cfgSvc = self._world:GetService("Config")
  local configData = cfgSvc:GetMonsterConfigData()
  local monsterIDCmpt = casterEntity:MonsterID()
  local monsterID = monsterIDCmpt:GetMonsterID()
  local speed = configData:GetMonsterSpeed(monsterID)
  speed = speed or 1
  return speed
end

function PlayAIService:StartMoveAnimation(targetEntity, isMove)
  local curVal = targetEntity:GetAnimatorControllerBoolsData("Move")
  if curVal ~= isMove then
    targetEntity:SetAnimatorControllerBools({Move = isMove})
  end
end

function PlayAIService:_PlayChessPetDead(TT, aiSkillResult)
  if self._world:MatchType() ~= MatchType.MT_Chess then
    return
  end
  local deadIDList = aiSkillResult:GetAISkillResult_DeadChessList()
  local chessSvcRender = self._world:GetService("ChessRender")
  chessSvcRender:DoChessPetListDeadRender(TT, deadIDList)
  local resultList = aiSkillResult:GetAISkillResult_AntiChessResultList()
  if resultList then
    for _, v in ipairs(resultList) do
      local targetEntityID = v.entityID
      local skillID = v.skillID
      local skillResult = v.skillResult
      local targetEntity = self._world:GetEntityByID(targetEntityID)
      local configSvc = self._world:GetService("Config")
      local skillConfigData = configSvc:GetSkillConfigData(skillID, targetEntity)
      local skillPhaseArray = skillConfigData:GetSkillPhaseArray()
      targetEntity:SkillRoutine():SetResultContainer(skillResult)
      local playSkillService = self._world:GetService("PlaySkill")
      playSkillService:_SkillRoutineTask(TT, targetEntity, skillPhaseArray, skillID)
    end
  end
end
