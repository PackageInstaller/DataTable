require("pet_chain_skill_attack_r")
_class("PetChainSkillAgentAttackSelect", PetChainSkillAttack)
PetChainSkillAgentAttackSelect = PetChainSkillAgentAttackSelect

function PetChainSkillAgentAttackSelect:DoPlayPetAgentChainAttackSelect(TT, casterEntity, chainTimeIndex)
  local buffViewCmpt = casterEntity:BuffView()
  local agentChainEntityID = buffViewCmpt:GetBuffValue("AgentChainEntityID")
  local agentChainEntity = self._world:GetEntityByID(agentChainEntityID)
  if not agentChainEntity then
    return
  end
  agentChainEntity:SkillRoutine():ClearSkillRoutine()
  local agentDataList = self:_GetAgentChainAttackDataByEntityID(casterEntity:GetID())
  local chainAttackCount = #agentDataList
  if chainAttackCount <= 0 then
    return
  end
  if not agentDataList[chainTimeIndex] then
    return
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  local playSkillService = self._world:GetService("PlaySkill")
  self:_OnResultDeadEntityAddDeadFlag(casterEntity:GetID(), chainTimeIndex)
  local agentData = agentDataList[chainTimeIndex]
  local agentPos = agentChainEntity:GridLocation():GetGridPos()
  local agentDir = casterEntity:GridLocation():GetGridDir()
  agentChainEntity:SetLocation(agentPos, agentDir)
  local results = agentData:GetEffectResultDict()
  local skillID = agentData:GetSkillID()
  local resContainer = SkillEffectResultContainer:New()
  resContainer:SetEffectResultDict(results)
  resContainer:SetScopeResult(agentData:GetScopeResult())
  Log.fatal("PlayChainSkill MultiStage Agent :", skillID)
  local isFinalAttack = agentData:IsFinalAttack()
  if chainAttackCount == chainTimeIndex and isFinalAttack then
    self:_CheckFinalAttack(resContainer, casterEntity)
  end
  agentChainEntity:SkillRoutine():SetResultContainer(resContainer)
  local skillPhaseArray = self:_GetChainSkillPhaseArray(agentChainEntity, skillID)
  local taskid = playSkillService:StartSkillRoutine(agentChainEntity, skillPhaseArray, skillID)
  while not TaskHelper:GetInstance():IsTaskFinished(taskid, true) do
    YIELD(TT)
  end
  playBuffSvc:PlayBuffView(TT, NTSingleChainSkillAttackFinish:New(casterEntity, chainTimeIndex, 1))
  local utilData = self._world:GetService("UtilData")
  local chainTimes, extraTimes = utilData:OnGetPetChainTimesForRender(casterEntity)
  if extraTimes and chainTimeIndex == extraTimes then
    playBuffSvc:PlayBuffView(TT, NTExtraChainSkillAttackFinish:New(casterEntity, chainTimeIndex, 1))
  end
  self:_ShowChainAttackMonsterDead(TT)
end

function PetChainSkillAgentAttackSelect:_GetAgentChainAttackDataByEntityID(casterEntityID)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local chainAtkResCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.ChainAttack)
  local chainAttackData = chainAtkResCmpt:GetPetAgentChainSkillDataList(casterEntityID)
  return chainAttackData
end
