_class("PetChainSkillSelfAttackForMultiStage", PetChainSkillAttack)
PetChainSkillSelfAttackForMultiStage = PetChainSkillSelfAttackForMultiStage

function PetChainSkillSelfAttackForMultiStage:DoPlayPetSelfChainAttackForMultiStage(TT, casterEntity, chainTimeIndex, index)
  local chainAttackDataList = self:_GetChainAttackDataByEntityID(casterEntity:GetID())
  if not chainAttackDataList[chainTimeIndex] or not chainAttackDataList[chainTimeIndex][index] then
    return
  end
  local attdata = chainAttackDataList[chainTimeIndex][index]
  local chainAttackCount = table.count(chainAttackDataList[chainTimeIndex])
  local skillID = attdata:GetSkillID()
  local playBuffSvc = self._world:GetService("PlayBuff")
  local playSkillService = self._world:GetService("PlaySkill")
  local playEntity = casterEntity
  if self:GetReplaceEntity(casterEntity) then
    playEntity = self:GetReplaceEntity(casterEntity)
    local replacePos = playEntity:GridLocation():GetGridPos()
    local replaceDir = casterEntity:GridLocation():GetGridDir()
    playEntity:SetLocation(replacePos, replaceDir)
  end
  local skillPhaseArray = self:_GetChainSkillPhaseArray(casterEntity, skillID)
  playEntity:SkillRoutine():ClearSkillRoutine()
  Log.fatal("PlayChainSkill MultiStage :", skillID)
  local chainSkillWaitDuration = self:_GetChainSkillWaitDuration(skillID)
  local isLastPlayChainSkill = self:_IsLastPlayChainSkill(casterEntity)
  local playSkillTaskIDList = {}
  playBuffSvc:PlayBuffView(TT, NTSingleChainSkillAttackBegin:New(casterEntity, chainTimeIndex, false))
  playBuffSvc:PlayBuffView(TT, NTSinglePetChainSkillAttackBegin:New(casterEntity, chainTimeIndex))
  self:_OnResultDeadEntityAddDeadFlag(casterEntity:GetID(), chainTimeIndex, index)
  local results = attdata:GetEffectResultDict()
  local resContainer = SkillEffectResultContainer:New()
  resContainer:SetEffectResultDict(results)
  local skillEffect_Teleport = resContainer:GetEffectResultByArray(SkillEffectType.Teleport)
  if skillEffect_Teleport then
    resContainer:AddEffectResult(skillEffect_Teleport)
  end
  local isFinalAttack = attdata:IsFinalAttack()
  if chainAttackCount == chainTimeIndex and isFinalAttack then
    self:_CheckFinalAttack(resContainer, casterEntity)
  end
  resContainer:SetScopeResult(attdata:GetScopeResult())
  resContainer:SetSkillID(skillID)
  resContainer:SetChainEffectResultTimeIndex(chainTimeIndex)
  resContainer:SetChainEffectResultStageIndex(index)
  playEntity:SkillRoutine():SetResultContainer(resContainer)
  local dir = self:GetPetForward(casterEntity)
  if dir then
    casterEntity:SetDirection(dir)
  end
  local pstId = casterEntity:PetPstID():GetPstID()
  self._world:EventDispatcher():Dispatch(GameEventType.ShowHideChainSkillCG, pstId, true)
  local nt1 = NTChainSkillAttackStart:New(casterEntity)
  nt1:SetChainSkillTimeIndex(chainTimeIndex)
  nt1:SetChainSkillStageIndex(index)
  playBuffSvc:PlayBuffView(TT, nt1)
  if chainTimeIndex == 2 then
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
  nt2:SetChainSkillTimeIndex(chainTimeIndex)
  nt2:SetChainSkillStageIndex(index)
  nt2:SetChainSkillId(skillID)
  playBuffSvc:PlayBuffView(TT, nt2)
  playBuffSvc:PlayBuffView(TT, NTChainSkillDamageEnd:New(casterEntity))
  if chainTimeIndex == chainAttackCount then
    playBuffSvc:PlayBuffView(TT, NTSecondChainSkillAttackEnd:New(casterEntity))
  end
  local utilData = self._world:GetService("UtilData")
  local chainTimes, extraTimes = utilData:OnGetPetChainTimesForRender(casterEntity)
  if extraTimes and chainTimeIndex == extraTimes then
    playBuffSvc:PlayBuffView(TT, NTExtraChainSkillAttackFinish:New(casterEntity, chainTimeIndex, 1))
  end
  playBuffSvc:PlayBuffView(TT, NTSingleChainSkillAttackFinish:New(casterEntity, chainTimeIndex, index))
  self:_ShowChainAttackMonsterDead(TT)
  while not TaskHelper:GetInstance():IsAllTaskFinished(playSkillTaskIDList) do
    YIELD(TT)
  end
end

function PetChainSkillSelfAttackForMultiStage:_GetChainAttackDataByEntityID(casterEntityID)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local chainAtkResCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.ChainAttack)
  local chainAttackData = chainAtkResCmpt:GetPetChainSkillDataList(casterEntityID)
  return chainAttackData
end

function PetChainSkillSelfAttackForMultiStage:_GetChainSkillWaitDuration(skillID)
  local cfgv = Cfg.cfg_chain_skill_duration[skillID]
  if cfgv then
    return cfgv.duration
  end
end
