require("pet_chain_skill_attack_r")
_class("PetChainSkillAgentAttack", PetChainSkillAttack)
PetChainSkillAgentAttack = PetChainSkillAgentAttack

function PetChainSkillAgentAttack:DoPlayPetAgentChainAttack(TT, casterEntity, skillID)
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
  local configService = self._world:GetService("Config")
  local playBuffSvc = self._world:GetService("PlayBuff")
  local playSkillService = self._world:GetService("PlaySkill")
  for chainIndex = 1, chainAttackCount do
    self:_OnResultDeadEntityAddDeadFlag(casterEntity:GetID(), chainIndex)
    local agentData = agentDataList[chainIndex]
    local agentPos = agentChainEntity:GridLocation():GetGridPos()
    local agentDir = casterEntity:GridLocation():GetGridDir()
    agentChainEntity:SetLocation(agentPos, agentDir)
    local results = agentData:GetEffectResultDict()
    local resContainer = SkillEffectResultContainer:New()
    resContainer:SetEffectResultDict(results)
    resContainer:SetScopeResult(agentData:GetScopeResult())
    local isFinalAttack = agentData:IsFinalAttack()
    if chainAttackCount == chainIndex and isFinalAttack then
      self:_CheckFinalAttack(resContainer, casterEntity)
    end
    agentChainEntity:SkillRoutine():SetResultContainer(resContainer)
    Log.fatal("Play Chain Skill AgentSkill :", agentData:GetSkillID())
    local skillPhaseArray = self:_GetChainSkillPhaseArray(agentChainEntity, agentData:GetSkillID())
    local taskid = playSkillService:StartSkillRoutine(agentChainEntity, skillPhaseArray, agentData:GetSkillID())
    while not TaskHelper:GetInstance():IsTaskFinished(taskid, true) do
      YIELD(TT)
    end
    playBuffSvc:PlayBuffView(TT, NTSingleChainSkillAttackFinish:New(casterEntity, chainIndex, 1))
    local utilData = self._world:GetService("UtilData")
    local chainTimes, extraTimes = utilData:OnGetPetChainTimesForRender(casterEntity)
    if extraTimes and chainIndex == extraTimes then
      playBuffSvc:PlayBuffView(TT, NTExtraChainSkillAttackFinish:New(casterEntity, chainIndex, 1))
    end
    self:_ShowChainAttackMonsterDead(TT)
  end
end

function PetChainSkillAgentAttack:_GetAgentChainAttackDataByEntityID(casterEntityID)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local chainAtkResCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.ChainAttack)
  local chainAttackData = chainAtkResCmpt:GetPetAgentChainSkillDataList(casterEntityID)
  return chainAttackData
end
