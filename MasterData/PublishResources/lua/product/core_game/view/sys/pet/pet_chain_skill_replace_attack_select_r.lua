require("pet_chain_skill_attack_r")
_class("PetChainSkillReplaceAttackSelect", PetChainSkillAttack)
PetChainSkillReplaceAttackSelect = PetChainSkillReplaceAttackSelect

function PetChainSkillReplaceAttackSelect:DoPlayPetReplaceAttackChainAttackSelect(TT, casterEntity, chainTimeIndex, index)
  local buffViewCmpt = casterEntity:BuffView()
  local replaceChainEntityID = buffViewCmpt:GetBuffValue("ReplaceEntityID")
  local replaceChainEntity = self._world:GetEntityByID(replaceChainEntityID)
  if not replaceChainEntity then
    return
  end
  local chainAttackDataList = self:_GetReplaceChainAttackDataByEntityID(casterEntity:GetID())
  if not chainAttackDataList[chainTimeIndex] or not chainAttackDataList[chainTimeIndex][index] then
    return
  end
  local replaceData = chainAttackDataList[chainTimeIndex][index]
  local chainAttackCount = table.count(chainAttackDataList[chainTimeIndex])
  local skillID = replaceData:GetSkillID()
  Log.fatal("PlayChainSkill Replace :", skillID)
  replaceChainEntity:SkillRoutine():ClearSkillRoutine()
  local playBuffSvc = self._world:GetService("PlayBuff")
  local playSkillService = self._world:GetService("PlaySkill")
  local playSkillTaskIDList = {}
  playBuffSvc:PlayBuffView(TT, NTSingleChainSkillAttackBegin:New(casterEntity, chainTimeIndex, false))
  playBuffSvc:PlayBuffView(TT, NTSinglePetChainSkillAttackBegin:New(casterEntity, chainTimeIndex))
  self:_OnResultDeadEntityAddDeadFlag(casterEntity:GetID(), chainTimeIndex)
  local replacePos = replaceChainEntity:GridLocation():GetGridPos()
  local replaceDir = casterEntity:GridLocation():GetGridDir()
  replaceChainEntity:SetLocation(replacePos, replaceDir)
  local results = replaceData:GetEffectResultDict()
  local resContainer = SkillEffectResultContainer:New()
  resContainer:SetEffectResultDict(results)
  resContainer:SetScopeResult(replaceData:GetScopeResult())
  resContainer:SetChainEffectResultTimeIndex(chainTimeIndex)
  resContainer:SetChainEffectResultStageIndex(index)
  replaceChainEntity:SkillRoutine():SetResultContainer(resContainer)
  local isFinalAttack = replaceData:IsFinalAttack()
  if chainAttackCount == chainTimeIndex and isFinalAttack then
    self:_CheckFinalAttack(resContainer, casterEntity)
  end
  local skillPhaseArray = self:_GetChainSkillPhaseArray(replaceChainEntity, skillID)
  local taskid = playSkillService:StartSkillRoutine(replaceChainEntity, skillPhaseArray, skillID)
  local chainSkillWaitDuration = self:_GetChainSkillWaitDuration(skillID)
  local isLastPlayChainSkill = self:_IsLastPlayChainSkill(casterEntity)
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
  playBuffSvc:PlayBuffView(TT, NTSingleChainSkillAttackFinish:New(casterEntity, chainTimeIndex, 1))
  local utilData = self._world:GetService("UtilData")
  local chainTimes, extraTimes = utilData:OnGetPetChainTimesForRender(casterEntity)
  if extraTimes and chainTimeIndex == extraTimes then
    playBuffSvc:PlayBuffView(TT, NTExtraChainSkillAttackFinish:New(casterEntity, chainTimeIndex, 1))
  end
  self:_ShowChainAttackMonsterDead(TT)
end

function PetChainSkillReplaceAttackSelect:_GetReplaceChainAttackDataByEntityID(casterEntityID)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local chainAtkResCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.ChainAttack)
  local chainAttackData = chainAtkResCmpt:GetPetReplaceChainSkillDataList(casterEntityID)
  return chainAttackData
end
