require("play_skill_phase_base_r")
_class("PlaySkillImpactAnimationPhase", PlaySkillPhaseBase)
PlaySkillImpactAnimationPhase = PlaySkillImpactAnimationPhase

function PlaySkillImpactAnimationPhase:PlayFlight(TT, casterEntity, phaseParam)
  local skillService = self:SkillService()
  local gridLocation = casterEntity:GridLocation()
  local center = gridLocation:Center()
  local effectService = self._world:GetService("Effect")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local res = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Damage)
  self:HideArmEffect(casterEntity)
  YIELD(TT, phaseParam:GetShowDelay())
  if res then
    effectService:ShowIdleEffect(casterEntity, true)
  else
    local effectHolderCmpt = casterEntity:EffectHolder()
    if effectHolderCmpt ~= nil then
      local weakEffectIDLeft = 36
      local weakEffectIDRight = 37
      local weakEffectEntity = effectService:CreateEffect(weakEffectIDLeft, casterEntity)
      effectHolderCmpt:AttachWeakEffect(weakEffectEntity:GetID())
      weakEffectEntity = effectService:CreateEffect(weakEffectIDRight, casterEntity)
      effectHolderCmpt:AttachWeakEffect(weakEffectEntity:GetID())
    end
  end
end

function PlaySkillImpactAnimationPhase:HideArmEffect(casterEntity)
  local cEffectHolder = casterEntity:EffectHolder()
  local dict = cEffectHolder:GetEffectIDEntityDic()
  local lEff, rEff = 24, 25
  local lIdList, rIdList = dict[lEff], dict[rEff]
  self:DestroyEntity(lIdList)
  self:DestroyEntity(rIdList)
  dict[lEff] = nil
  dict[rEff] = nil
end

function PlaySkillImpactAnimationPhase:DestroyEntity(eIdList)
  if eIdList then
    for i, v in ipairs(eIdList) do
      local e = self._world:GetEntityByID(v)
      if e then
        self._world:DestroyEntity(e)
      end
    end
  end
end
