_class("SkillEffectCalc_AbsorbPiece", Object)
SkillEffectCalc_AbsorbPiece = SkillEffectCalc_AbsorbPiece

function SkillEffectCalc_AbsorbPiece:Constructor(world)
  self._world = world
end

function SkillEffectCalc_AbsorbPiece:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillAbsorbPieceEffectParam = skillEffectCalcParam.skillEffectParam
  local targetPieceType = skillAbsorbPieceEffectParam:GetPieceType()
  local targetPieceCount = skillAbsorbPieceEffectParam:GetPieceCount()
  local scopeList = skillEffectCalcParam.skillRange
  local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local centerPos = attacker:GridLocation():GetGridPos()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local absorbPieceList = boardServiceLogic:FindPieceElementByTypeCountAndCenterFromParam(centerPos, targetPieceType, targetPieceCount, scopeList)
  local absorbResult = SkillAbsorbPieceEffectResult:New()
  absorbResult:SetAbsorbPieceList(absorbPieceList)
  local gameFsmCmpt = self._world:GameFSM()
  local gameFsmStateID = gameFsmCmpt:CurStateID()
  if gameFsmStateID ~= GameStateID.PreviewActiveSkill then
    local newGridPosList = boardServiceLogic:SupplyPieceList(absorbPieceList)
    absorbResult:SetNewPieceList(newGridPosList)
  end
  return absorbResult
end
