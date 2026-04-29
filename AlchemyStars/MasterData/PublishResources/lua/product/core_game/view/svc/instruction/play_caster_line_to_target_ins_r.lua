require("base_ins_r")
_class("PlayCasterLineToTargetInstruction", BaseInstruction)
PlayCasterLineToTargetInstruction = PlayCasterLineToTargetInstruction

function PlayCasterLineToTargetInstruction:Constructor(paramList)
  self._lineOnCaster = paramList.lineOnCaster
  self._lineOnTarget = paramList.lineOnTarget
  self._lineEffectID = tonumber(paramList.lineEffectID)
  self._lineEffectDuration = tonumber(paramList.lineEffectDuration)
end

function PlayCasterLineToTargetInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if damageResultArray == nil or table.count(damageResultArray) == 0 then
    return
  end
  local damageResult = damageResultArray[1]
  local targetEntityID = damageResult:GetTargetID()
  local targetEntity = world:GetEntityByID(targetEntityID)
  if not targetEntity then
    return
  end
  local casterViewRoot = casterEntity:View().ViewWrapper.GameObject.transform
  local casterRoot = GameObjectHelper.FindChild(casterViewRoot, self._lineOnCaster)
  local targetViewRoot = targetEntity:View().ViewWrapper.GameObject.transform
  local targetRoot = GameObjectHelper.FindChild(targetViewRoot, self._lineOnTarget)
  if not casterRoot or not targetRoot then
    return
  end
  local effectService = world:GetService("Effect")
  local effectLineRenderer = casterEntity:EffectLineRenderer()
  if not effectLineRenderer then
    casterEntity:AddEffectLineRenderer()
    effectLineRenderer = casterEntity:EffectLineRenderer()
  end
  local effectHolderCmpt = casterEntity:EffectHolder()
  if not effectHolderCmpt then
    casterEntity:AddEffectHolder()
    effectHolderCmpt = casterEntity:EffectHolder()
  end
  local effectEntityIdList = effectHolderCmpt:GetEffectIDEntityDic()[self._lineEffectID]
  local effect
  if effectEntityIdList then
    effect = world:GetEntityByID(effectEntityIdList[1])
    if not effect then
      effectHolderCmpt:GetEffectIDEntityDic()[self._lineEffectID][1] = nil
    end
  end
  if not effect then
    effect = effectService:CreateEffect(self._lineEffectID, casterEntity)
    effectHolderCmpt:AttachPermanentEffect(effect:GetID())
  end
  local go = effect:View():GetGameObject()
  local renderers
  renderers = go:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
  for i = 0, renderers.Length - 1 do
    local line = renderers[i]
    if line then
      line.gameObject:SetActive(true)
    end
  end
  effectLineRenderer:InitEffectLineRenderer(casterEntity:GetID(), casterRoot, targetRoot, casterViewRoot, renderers, effect:GetID())
  effectLineRenderer:SetEffectLineRendererShow(casterEntity:GetID(), true)
  YIELD(TT, self._lineEffectDuration)
  effectLineRenderer:SetEffectLineRendererShow(casterEntity:GetID(), false)
  local effectIDEntityDicLine = effectHolderCmpt:GetEffectIDEntityDic()[self._lineEffectID]
  if effectIDEntityDicLine then
    effectIDEntityDicLine[1] = nil
  end
  if effect then
    world:DestroyEntity(effect)
  end
end
