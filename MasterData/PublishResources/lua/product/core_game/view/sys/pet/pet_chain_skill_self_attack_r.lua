_class("PetChainSkillSelfAttack", PetChainSkillAttack)
PetChainSkillSelfAttack = PetChainSkillSelfAttack

function PetChainSkillSelfAttack:DoPlayPetSelfChainAttack(TT, casterEntity, skillID)
  local chainAttackDataList = self:_GetChainAttackDataByEntityID(casterEntity:GetID())
  local chainAttackData = {}
  for roundIndex, chainAttackDatas in pairs(chainAttackDataList) do
    for _, data in pairs(chainAttackDatas) do
      table.insert(chainAttackData, data)
    end
  end
  local chainAttackCount = #chainAttackData
  if chainAttackCount <= 0 then
    return
  end
  local utilData = self._world:GetService("UtilData")
  local chainTimes, extraTimes = utilData:OnGetPetChainTimesForRender(casterEntity)
  local playBuffSvc = self._world:GetService("PlayBuff")
  local playSkillService = self._world:GetService("PlaySkill")
  local skillPhaseArray = self:_GetChainSkillPhaseArray(casterEntity, skillID)
  local playEntity = casterEntity
  if self:GetReplaceEntity(casterEntity) then
    playEntity = self:GetReplaceEntity(casterEntity)
    local replacePos = playEntity:GridLocation():GetGridPos()
    local replaceDir = casterEntity:GridLocation():GetGridDir()
    playEntity:SetLocation(replacePos, replaceDir)
  end
  playEntity:SkillRoutine():ClearSkillRoutine()
  local chainSkillWaitDuration = self:_GetChainSkillWaitDuration(skillID)
  local isLastPlayChainSkill = self:_IsLastPlayChainSkill(casterEntity)
  local playSkillTaskIDList = {}
  for chainIndex = 1, chainAttackCount do
    playBuffSvc:PlayBuffView(TT, NTSingleChainSkillAttackBegin:New(casterEntity, chainIndex, false))
    playBuffSvc:PlayBuffView(TT, NTSinglePetChainSkillAttackBegin:New(casterEntity, chainIndex))
    self:_OnResultDeadEntityAddDeadFlag(casterEntity:GetID(), chainIndex)
    local attdata = chainAttackData[chainIndex]
    local results = attdata:GetEffectResultDict()
    local resContainer = SkillEffectResultContainer:New()
    resContainer:SetEffectResultDict(results)
    local skillEffect_Teleport = resContainer:GetEffectResultByArray(SkillEffectType.Teleport)
    if skillEffect_Teleport then
      resContainer:AddEffectResult(skillEffect_Teleport)
    end
    local isFinalAttack = attdata:IsFinalAttack()
    if chainAttackCount == chainIndex and isFinalAttack then
      self:_CheckFinalAttack(resContainer, casterEntity)
    end
    resContainer:SetScopeResult(attdata:GetScopeResult())
    resContainer:SetSkillID(skillID)
    resContainer:SetChainEffectResultTimeIndex(chainIndex)
    resContainer:SetChainEffectResultStageIndex(1)
    playEntity:SkillRoutine():SetResultContainer(resContainer)
    local dir = self:GetPetForward(casterEntity)
    if dir then
      casterEntity:SetDirection(dir)
    end
    local pstId = casterEntity:PetPstID():GetPstID()
    self._world:EventDispatcher():Dispatch(GameEventType.ShowHideChainSkillCG, pstId, true)
    local nt1 = NTChainSkillAttackStart:New(casterEntity)
    nt1:SetChainSkillTimeIndex(chainIndex)
    nt1:SetChainSkillStageIndex(1)
    playBuffSvc:PlayBuffView(TT, nt1)
    if chainIndex == 2 then
      playBuffSvc:PlayBuffView(TT, NTSecondChainSkillAttackStart:New(casterEntity))
    end
    local taskid = playSkillService:StartSkillRoutine(playEntity, skillPhaseArray, skillID)
    playSkillTaskIDList[#playSkillTaskIDList + 1] = taskid
    if not isLastPlayChainSkill and chainSkillWaitDuration then
      if 0 < chainSkillWaitDuration then
        YIELD(TT, chainSkillWaitDuration)
      end
    else
      Log.debug("### [PlayerChainAttackStateSystem_Render]<color=red>not</color> use cfg_chain_skill_duration data.", skillID)
      while not TaskHelper:GetInstance():IsTaskFinished(taskid) do
        YIELD(TT)
      end
    end
    playBuffSvc:PlayBuffView(TT, NTChainSkillAttack:New(casterEntity))
    local nt2 = NTChainSkillAttackEnd:New(casterEntity)
    nt2:SetChainSkillTimeIndex(chainIndex)
    nt2:SetChainSkillStageIndex(1)
    nt2:SetChainSkillId(skillID)
    playBuffSvc:PlayBuffView(TT, nt2)
    playBuffSvc:PlayBuffView(TT, NTChainSkillDamageEnd:New(casterEntity))
    if chainIndex == chainAttackCount then
      playBuffSvc:PlayBuffView(TT, NTSecondChainSkillAttackEnd:New(casterEntity))
    end
    if extraTimes and chainIndex == extraTimes then
      playBuffSvc:PlayBuffView(TT, NTExtraChainSkillAttackFinish:New(casterEntity, chainIndex, 1))
    end
    playBuffSvc:PlayBuffView(TT, NTSingleChainSkillAttackFinish:New(casterEntity, chainIndex, 1))
    self:_ShowChainAttackMonsterDead(TT)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(playSkillTaskIDList) do
    YIELD(TT)
  end
end

function PetChainSkillSelfAttack:_GetChainAttackDataByEntityID(casterEntityID)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local chainAtkResCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.ChainAttack)
  local chainAttackData = chainAtkResCmpt:GetPetChainSkillDataList(casterEntityID)
  return chainAttackData
end

function PetChainSkillSelfAttack:_GetChainSkillWaitDuration(skillID)
  local cfgv = Cfg.cfg_chain_skill_duration[skillID]
  if cfgv then
    return cfgv.duration
  end
end
