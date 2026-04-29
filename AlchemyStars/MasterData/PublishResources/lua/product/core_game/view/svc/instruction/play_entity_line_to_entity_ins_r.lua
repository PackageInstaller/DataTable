require("base_ins_r")
_class("PlayEntityLineToEntityInstruction", BaseInstruction)
PlayEntityLineToEntityInstruction = PlayEntityLineToEntityInstruction

function PlayEntityLineToEntityInstruction:Constructor(paramList)
  self._lineOnCaster = paramList.lineOnCaster
  self._lineOnTarget = paramList.lineOnTarget
  self._trapID = tonumber(paramList.trapID)
  self._targetTrapIndex = tonumber(paramList.targetTrapIndex)
  self._lineEffectID = tonumber(paramList.lineEffectID)
  self._lineEffectDuration = tonumber(paramList.lineEffectDuration)
end

function PlayEntityLineToEntityInstruction:DoInstruction(TT, entity, phaseContext)
  local world = entity:GetOwnerWorld()
  local casterEntity, targetEntity
  local utilDataSvc = world:GetService("UtilData")
  local trapEntityList = utilDataSvc:GetTrapByID(self._trapID)
  if #trapEntityList < 2 then
    Log.error("[PlayEntityLineToEntity] trap count error, trap id = ", self._trapID, ", trap count = ", #trapEntityList)
    return
  end
  if self._targetTrapIndex then
    casterEntity = entity
    targetEntity = trapEntityList[self._targetTrapIndex]
  else
    casterEntity = trapEntityList[1]
    targetEntity = trapEntityList[2]
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
  local renders = go:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
  for i = 0, renders.Length - 1 do
    local line = renders[i]
    if line then
      line.gameObject:SetActive(true)
    end
  end
  effectLineRenderer:InitEffectLineRenderer(casterEntity:GetID(), casterRoot, targetRoot, casterViewRoot, renders, effect:GetID())
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
