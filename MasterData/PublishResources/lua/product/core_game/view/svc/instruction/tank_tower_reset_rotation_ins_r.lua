require("base_ins_r")
_class("TankTowerResetRotationInstruction", BaseInstruction)
TankTowerResetRotationInstruction = TankTowerResetRotationInstruction

function TankTowerResetRotationInstruction:Constructor(paramList)
  self._time = tonumber(paramList.time)
end

function TankTowerResetRotationInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local casterPos = casterEntity:GetRenderGridPosition()
  local casterDir = casterEntity:GetRenderGridDirection()
  local casterOffset = casterEntity:GridLocation():GetDamageOffset()
  local lookAtPos = casterPos + casterDir + casterOffset
  local BoardServiceRender = world:GetService("BoardRender")
  local v3Forward = BoardServiceRender:GridPos2RenderPos(lookAtPos)
  local cEffectHolder = casterEntity:EffectHolder()
  local efx = cEffectHolder:GetEffectList(BattleConst.Tank2002901TowerEffectKey)[1]
  local timeInSecond = self._time * 0.001
  local tweener = efx:View():GetGameObject().transform:DOLookAt(v3Forward, timeInSecond):SetEase(DG.Tweening.Ease.InOutSine)
  YIELD(TT, self._time)
  if not tweener:IsComplete() then
    tweener:Complete()
  end
end
