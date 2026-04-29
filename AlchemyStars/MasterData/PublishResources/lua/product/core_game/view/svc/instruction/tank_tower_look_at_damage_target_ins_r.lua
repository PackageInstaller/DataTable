require("base_ins_r")
_class("TankTowerLookAtDamageTargetInstruction", BaseInstruction)
TankTowerLookAtDamageTargetInstruction = TankTowerLookAtDamageTargetInstruction

function TankTowerLookAtDamageTargetInstruction:Constructor(paramList)
  self._time = tonumber(paramList.time)
end

function TankTowerLookAtDamageTargetInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local targetEntity = world:GetEntityByID(targetEntityID)
  local v3TargetRenderLocation = targetEntity:Location():GetPosition()
  local cEffectHolder = casterEntity:EffectHolder()
  local efx = cEffectHolder:GetEffectList(BattleConst.Tank2002901TowerEffectKey)[1]
  local timeInSecond = self._time * 0.001
  local tweener = efx:View():GetGameObject().transform:DOLookAt(v3TargetRenderLocation, timeInSecond):SetEase(DG.Tweening.Ease.InOutSine)
  YIELD(TT, self._time)
  if not tweener:IsComplete() then
    tweener:Complete()
  end
end
