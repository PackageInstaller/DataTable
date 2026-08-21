require("sp_base_inst")
_class("SkillPreviewPlayCasterPosConvertInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayCasterPosConvertInstruction = SkillPreviewPlayCasterPosConvertInstruction

function SkillPreviewPlayCasterPosConvertInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local scopeGridList = previewContext:GetScopeResult()
  local previewEffectCalcService = self._world:GetService("PreviewCalcEffect")
  local effectList = previewContext:GetEffect(SkillEffectType.ConvertGridElement)
  local effectParam = previewEffectCalcService:CreateSkillEffectParam(SkillEffectType.ConvertGridElement, effectList)
  local result = previewEffectCalcService:CalcConvertGridElement(casterEntity, scopeGridList, effectParam)
  local gridPos = casterEntity:GetGridPosition()
  local attackRange = previewContext:GetScopeResult()
  if not table.icontains(attackRange, gridPos) then
    return
  end
  local env = self._world:GetPreviewEntity():PreviewEnv()
  if env:GetConvertPlayerPosGridEffectEntityID() then
    local oldEntityID = env:GetConvertPlayerPosGridEffectEntityID()
    local e = self._world:GetEntityByID(oldEntityID)
    if e then
      self._world:DestroyEntity(e)
    end
    env:SetConvertPlayerPosGridEffectEntityID(nil)
  end
  local pieceType = result:GetTargetElementType()
  local fxsvc = self._world:GetService("Effect")
  local e = fxsvc:CreateEffectEntity()
  local pieceService = self._world:GetService("Piece")
  pieceService:SetPieceEntityPieceType(e, pieceType)
  e:SetGridPosition(gridPos)
  e:SetPosition(gridPos)
  env:SetConvertPlayerPosGridEffectEntityID(e:GetID())
  YIELD(TT)
  local effView = e:View()
  if not effView then
    return
  end
  local effectObj = effView:GetGameObject()
  if not effectObj or tostring(effectObj) == "null" then
    return
  end
  local pieceAnimData = PieceAnimationData:New()
  local name = pieceAnimData:GetAnimationName("Color")
  local gridGameObj = e:View().ViewWrapper.GameObject
  local csAnimation = gridGameObj:GetComponentInChildren(typeof(UnityEngine.Animation))
  csAnimation:Play(name)
end

_class("SkillPreviewRemoveCasterPosConvertInstruction", SkillPreviewBaseInstruction)
SkillPreviewRemoveCasterPosConvertInstruction = SkillPreviewRemoveCasterPosConvertInstruction

function SkillPreviewRemoveCasterPosConvertInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local eid = env:GetConvertPlayerPosGridEffectEntityID()
  if not eid then
    return
  end
  local e = self._world:GetEntityByID(eid)
  if not e then
    return
  end
  self._world:DestroyEntity(e)
end
