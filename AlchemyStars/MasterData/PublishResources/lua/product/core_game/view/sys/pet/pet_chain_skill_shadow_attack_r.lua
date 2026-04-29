require("pet_chain_skill_attack_r")
_class("PetChainSkillShadowAttack", PetChainSkillAttack)
PetChainSkillShadowAttack = PetChainSkillShadowAttack

function PetChainSkillShadowAttack:DoPlayPetShadowChainAttack(TT, casterEntity, skillID)
  local shadowChainAttackDataList = self:_GetPetShadowChainAttackDataByEntityID(casterEntity:GetID())
  local chainAttackCount = #shadowChainAttackDataList
  if chainAttackCount <= 0 then
    return
  end
  local playSkillService = self._world:GetService("PlaySkill")
  local playBuffSvc = self._world:GetService("PlayBuff")
  local shadowEntity = self:_GetCasterShadowEntity(casterEntity)
  if not shadowEntity then
    return
  end
  shadowEntity:SetViewVisible(true)
  self:_SetShadowEntityLocationByPetEntity(casterEntity, shadowEntity)
  if not self:_IsCasterHasShadowChainSkillPro(casterEntity) then
    shadowEntity:PlayMaterialAnim("common_shadoweff")
  end
  Log.fatal("PlayChainSkill Shadow :", skillID)
  local skillPhaseArray = self:_GetChainSkillPhaseArray(casterEntity, skillID)
  local utilData = self._world:GetService("UtilData")
  local chainTimes, extraTimes = utilData:OnGetPetChainTimesForRender(casterEntity)
  local playSkillTaskIDList = {}
  for chainIndex = 1, chainAttackCount do
    self:_OnResultDeadEntityAddDeadFlag(casterEntity:GetID(), chainIndex)
    shadowEntity:SkillRoutine():ClearSkillRoutine()
    local shadowData = shadowChainAttackDataList[chainIndex]
    local skillResult = SkillEffectResultContainer:New()
    local results = shadowData:GetEffectResultDict()
    skillResult:SetEffectResultDict(results)
    skillResult:SetScopeResult(shadowData:GetScopeResult())
    local isFinalAttack = shadowData:IsFinalAttack()
    if chainAttackCount == chainIndex and isFinalAttack then
      self:_CheckFinalAttack(skillResult, casterEntity)
    end
    shadowEntity:SkillRoutine():SetResultContainer(skillResult)
    local taskid = playSkillService:StartSkillRoutine(shadowEntity, skillPhaseArray, skillID)
    playSkillTaskIDList[#playSkillTaskIDList + 1] = taskid
    while not TaskHelper:GetInstance():IsTaskFinished(taskid, true) do
      YIELD(TT)
    end
    playBuffSvc:PlayBuffView(TT, NTSingleChainSkillAttackFinish:New(casterEntity, chainIndex, 1))
    if extraTimes and chainIndex == extraTimes then
      playBuffSvc:PlayBuffView(TT, NTExtraChainSkillAttackFinish:New(casterEntity, chainIndex, 1))
    end
    self:_ShowChainAttackMonsterDead(TT)
  end
  local buffViewCmpt = casterEntity:BuffView()
  if buffViewCmpt:HasBuffEffect(BuffEffectType.ShadowChainSKill) or buffViewCmpt:HasBuffEffect(BuffEffectType.ShadowChainSKillPro) then
    local shadowEntityID = buffViewCmpt:GetBuffValue("ShadowChainEntityID")
    local shadowEntity = self._world:GetEntityByID(shadowEntityID)
    if shadowEntity then
      shadowEntity:SetViewVisible(false)
    end
  end
end

function PetChainSkillShadowAttack:_GetPetShadowChainAttackDataByEntityID(casterEntityID)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local chainAtkResCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.ChainAttack)
  local shadowChainAttackData = chainAtkResCmpt:GetPetShadowChainSkillDataList(casterEntityID)
  return shadowChainAttackData
end

function PetChainSkillShadowAttack:_GetCasterShadowEntity(casterEntity)
  local buffViewCmpt = casterEntity:BuffView()
  local hasShadowChainSKill = buffViewCmpt:HasBuffEffect(BuffEffectType.ShadowChainSKill)
  local hasShadowChainSKillPro = buffViewCmpt:HasBuffEffect(BuffEffectType.ShadowChainSKillPro)
  if hasShadowChainSKill or hasShadowChainSKillPro then
    local shadowEntityID = buffViewCmpt:GetBuffValue("ShadowChainEntityID")
    local shadowEntity = self._world:GetEntityByID(shadowEntityID)
    return shadowEntity
  end
  return
end

function PetChainSkillShadowAttack:_IsCasterHasShadowChainSkillPro(casterEntity)
  local buffViewCmpt = casterEntity:BuffView()
  local hasShadowChainSKillPro = buffViewCmpt:HasBuffEffect(BuffEffectType.ShadowChainSKillPro)
  return hasShadowChainSKillPro
end

function PetChainSkillShadowAttack:_SetShadowEntityLocationByPetEntity(casterEntity, shadowEntity)
  local buffViewCmpt = casterEntity:BuffView()
  local shadowPos = buffViewCmpt:GetBuffValue("ShadowChainPos")
  local shadowDir = casterEntity:GridLocation():GetGridDir()
  shadowEntity:SetLocation(shadowPos, shadowDir)
end
