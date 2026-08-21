_class("SkillEffectCalc_WeikeNotify", SkillEffectCalc_Base)
SkillEffectCalc_WeikeNotify = SkillEffectCalc_WeikeNotify

function SkillEffectCalc_WeikeNotify:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillID = skillEffectCalcParam.skillID
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID, casterEntity)
  local param = skillEffectCalcParam.skillEffectParam
  local companionType = param:GetCompanionType()
  local notifyType
  if companionType == SkillEffect_WeikeNotify_CompanionType.TypeA then
    notifyType = 168
  elseif companionType == SkillEffect_WeikeNotify_CompanionType.TypeB then
    notifyType = 169
  elseif companionType == SkillEffect_WeikeNotify_CompanionType.TypeC then
    notifyType = 170
  end
  local chainSkillTypes = {
    SkillEffect_WeikeNotify_SkillType.ChainSkill1,
    SkillEffect_WeikeNotify_SkillType.ChainSkill2,
    SkillEffect_WeikeNotify_SkillType.ChainSkill3
  }
  local skillType = param:GetSkillType()
  Log.error("CalcWeikeNotify: skillID: ", skillID, " skillType:", skillType)
  local count
  if table.icontains(chainSkillTypes, skillType) then
    local realEntity = casterEntity:HasSuperEntity() and casterEntity:GetSuperEntity() or casterEntity
    realEntity = realEntity or casterEntity
    local cPetPstID = realEntity:PetPstID()
    if cPetPstID then
      count = cPetPstID:TickWeikeChainSkillNotifyCount(notifyType)
    end
  end
  local result = SkillEffectResult_WeikeNotify:New(notifyType, skillType, skillEffectCalcParam.attackPos, count)
  return {result}
end
