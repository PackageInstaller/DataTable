require("base_ins_r")
_class("PlaySwitchBodyAreaResultInstruction", BaseInstruction)
PlaySwitchBodyAreaResultInstruction = PlaySwitchBodyAreaResultInstruction

function PlaySwitchBodyAreaResultInstruction:Constructor(paramList)
end

function PlaySwitchBodyAreaResultInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local switchBodyAreaResult = routineComponent:GetEffectResultByArray(SkillEffectType.SwitchBodyAreaByTargetPos)
  if not switchBodyAreaResult then
    return
  end
  local dirType = switchBodyAreaResult:GetSwitchDirType()
  local oldBodyAreaPos = switchBodyAreaResult:GetOldBodyAreaPos()
  local newDir = switchBodyAreaResult:GetNewDir()
  local newBodyArea = switchBodyAreaResult:GetNewBodyArea()
  self._world = casterEntity:GetOwnerWorld()
  local renderEntityService = self._world:GetService("RenderEntity")
  renderEntityService:DestroyMonsterAreaOutLineEntity(casterEntity)
  renderEntityService:CreateMonsterAreaOutlineEntity(casterEntity)
  local casterPos = casterEntity:GetRenderGridPosition()
  local newBodyAreaPos = casterPos + newBodyArea[1]
  local pieceService = self._world:GetService("Piece")
  casterEntity:SetDirection(newDir)
  pieceService:SetPieceAnimUp(oldBodyAreaPos)
  pieceService:SetPieceAnimDown(newBodyAreaPos)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, NTBodyAreaChange:New(casterEntity))
end
