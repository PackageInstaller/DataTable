require("base_ins_r")
_class("PlayChessKnightTeleportInstruction", BaseInstruction)
PlayChessKnightTeleportInstruction = PlayChessKnightTeleportInstruction

function PlayChessKnightTeleportInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local teleportResult = routineComponent:GetEffectResultByArray(SkillEffectType.Teleport, self._stageIndex)
  if not teleportResult then
    return
  end
  local v2 = teleportResult:GetPosNew()
  casterEntity:SetPosition(v2)
  local go = casterEntity:View():GetGameObject()
  local tfRoot = GameObjectHelper.FindChild(go.transform, "Root")
  if tfRoot then
    tfRoot.localPosition = Vector3.zero
  end
end
