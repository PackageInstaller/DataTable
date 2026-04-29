require("switch_body_area_dir_type")
require("base_ins_r")
_class("PlaySwitchBodyAreaInstruction", BaseInstruction)
PlaySwitchBodyAreaInstruction = PlaySwitchBodyAreaInstruction

function PlaySwitchBodyAreaInstruction:Constructor(paramList)
  self._leftAnim = paramList.leftAnim
  self._rightAnim = paramList.rightAnim
  self._turnAnim = paramList.turnAnim
  self._leftAnimLen = tonumber(paramList.leftAnimLen)
  self._rightAnimLen = tonumber(paramList.rightAnimLen)
  self._turnAnimLen = tonumber(paramList.turnAnimLen)
end

function PlaySwitchBodyAreaInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local switchBodyAreaResult = routineComponent:GetEffectResultByArray(SkillEffectType.SwitchBodyAreaByTargetPos)
  if not switchBodyAreaResult then
    return
  end
  local dirType = switchBodyAreaResult:GetSwitchDirType()
  local oldBodyAreaPos = switchBodyAreaResult:GetOldBodyAreaPos()
  local newDir = switchBodyAreaResult:GetNewDir()
  local newBodyArea = switchBodyAreaResult:GetNewBodyArea()
  local playAnim, animLen
  if dirType == SwitchBodyAreaDirType.Right then
    playAnim = self._rightAnim
    animLen = self._rightAnimLen
  elseif dirType == SwitchBodyAreaDirType.Left then
    playAnim = self._leftAnim
    animLen = self._leftAnimLen
  elseif dirType == SwitchBodyAreaDirType.Turn then
    playAnim = self._turnAnim
    animLen = self._turnAnimLen
  end
  self._world = casterEntity:GetOwnerWorld()
  if playAnim then
    casterEntity:SetAnimatorControllerTriggers({playAnim})
  end
  local oneFrameTime = 0
  if animLen then
    YIELD(TT, animLen)
  end
  casterEntity:SetAnimatorControllerTriggers({"Idle"})
  local renderEntityService = self._world:GetService("RenderEntity")
  renderEntityService:DestroyMonsterAreaOutLineEntity(casterEntity)
  local casterPos = casterEntity:GetRenderGridPosition()
  local newBodyAreaPos = casterPos + newBodyArea[1]
  local pieceService = self._world:GetService("Piece")
  casterEntity:SetDirection(newDir)
  pieceService:SetPieceAnimUp(oldBodyAreaPos)
  pieceService:SetPieceAnimDown(newBodyAreaPos)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, NTBodyAreaChange:New(casterEntity))
end
