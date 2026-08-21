require("base_ins_r")
_class("PlayRubikMultiLaserEffectInstruction", BaseInstruction)
PlayRubikMultiLaserEffectInstruction = PlayRubikMultiLaserEffectInstruction

function PlayRubikMultiLaserEffectInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
end

function PlayRubikMultiLaserEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local attackRange = scopeResult:GetAttackRange()
  local rangLengthList = {}
  for _, pos in pairs(attackRange) do
    if not rangLengthList[pos.x] then
      rangLengthList[pos.x] = 0.5
    end
    local newValue = rangLengthList[pos.x] + 1
    if newValue == 7.5 then
      newValue = 20
    end
    rangLengthList[pos.x] = newValue
  end
  local effectService = world:GetService("Effect")
  local effectPos = Vector3(-4, 0, 3.5)
  for i = 1, 7 do
    local workPos = effectPos + Vector3(i - 1, 0, 0)
    local effect = effectService:CreateWorldPositionEffect(self._effectID, workPos)
    local effectObject = effect:View():GetGameObject()
    effectObject.transform.localEulerAngles = Vector3(0, 180, 0)
    local length = rangLengthList[i] or 0
    local laser = GameObjectHelper.FindChild(effectObject.transform, "mesh_jiguang")
    laser.transform:DOScale(Vector3(1, 1, length), 0)
  end
end

function PlayRubikMultiLaserEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      7
    })
  end
  return t
end
