require("pet_chain_skill_attack_r")
_class("PetChainSkillReplaceAttack", PetChainSkillAttack)
PetChainSkillReplaceAttack = PetChainSkillReplaceAttack

function PetChainSkillReplaceAttack:DoPlayPetReplaceChainAttack(TT, casterEntity, skillID)
  local buffViewCmpt = casterEntity:BuffView()
  local replaceChainEntityID = buffViewCmpt:GetBuffValue("ReplaceEntityID")
  local replaceChainEntity = self._world:GetEntityByID(replaceChainEntityID)
  if not replaceChainEntity then
    return
  end
  replaceChainEntity:SkillRoutine():ClearSkillRoutine()
  local replaceDataList = self:GetReplaceChainAttackDataByEntityID(casterEntity:GetID())
  local chainAttackCount = #replaceDataList
  if chainAttackCount <= 0 then
    return
  end
  local configService = self._world:GetService("Config")
  local playBuffSvc = self._world:GetService("PlayBuff")
  local playSkillService = self._world:GetService("PlaySkill")
  local utilData = self._world:GetService("UtilData")
  local chainTimes, extraTimes = utilData:OnGetPetChainTimesForRender(casterEntity)
  for chainIndex = 1, chainAttackCount do
    self:_OnResultDeadEntityAddDeadFlag(casterEntity:GetID(), chainIndex)
    local replaceData = replaceDataList[chainIndex]
    local replacePos = replaceChainEntity:GridLocation():GetGridPos()
    local replaceDir = casterEntity:GridLocation():GetGridDir()
    replaceChainEntity:SetLocation(replacePos, replaceDir)
    local results = replaceData:GetEffectResultDict()
    local resContainer = SkillEffectResultContainer:New()
    resContainer:SetEffectResultDict(results)
    resContainer:SetScopeResult(replaceData:GetScopeResult())
    local isFinalAttack = replaceData:IsFinalAttack()
    if chainAttackCount == chainIndex and isFinalAttack then
      self:_CheckFinalAttack(resContainer, casterEntity)
    end
    replaceChainEntity:SkillRoutine():SetResultContainer(resContainer)
    local skillPhaseArray = self:_GetChainSkillPhaseArray(replaceChainEntity, replaceData:GetSkillID())
    local taskid = playSkillService:StartSkillRoutine(replaceChainEntity, skillPhaseArray, replaceData:GetSkillID())
    while not TaskHelper:GetInstance():IsTaskFinished(taskid, true) do
      YIELD(TT)
    end
    playBuffSvc:PlayBuffView(TT, NTSingleChainSkillAttackFinish:New(casterEntity, chainIndex, 1))
    if extraTimes and chainIndex == extraTimes then
      playBuffSvc:PlayBuffView(TT, NTExtraChainSkillAttackFinish:New(casterEntity, chainIndex, 1))
    end
    self:_ShowChainAttackMonsterDead(TT)
  end
end

function PetChainSkillReplaceAttack:GetReplaceChainAttackDataByEntityID(casterEntityID)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local chainAtkResCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.ChainAttack)
  local chainAttackData = chainAtkResCmpt:GetPetReplaceChainSkillDataList(casterEntityID)
  return chainAttackData
end
