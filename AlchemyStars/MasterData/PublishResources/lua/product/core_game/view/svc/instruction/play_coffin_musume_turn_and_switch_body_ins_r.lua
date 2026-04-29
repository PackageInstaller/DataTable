require("switch_body_area_dir_type")
_class("PlayCoffinMusumeTurnAndSwitchBodyInstruction", BaseInstruction)
PlayCoffinMusumeTurnAndSwitchBodyInstruction = PlayCoffinMusumeTurnAndSwitchBodyInstruction

function PlayCoffinMusumeTurnAndSwitchBodyInstruction:Constructor(paramList)
  self._up = tonumber(paramList.isUp) == 1
end

local animNameByDirType = {
  [SwitchBodyAreaDirType.None] = "Skill01Up",
  [SwitchBodyAreaDirType.Left] = "Skill01Left",
  [SwitchBodyAreaDirType.Turn] = "Skill01Down",
  [SwitchBodyAreaDirType.Right] = "Skill01Right"
}

function PlayCoffinMusumeTurnAndSwitchBodyInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local switchBodyAreaResult = routineComponent:GetEffectResultByArray(SkillEffectType.SwitchBodyAreaByTargetPos)
  if not switchBodyAreaResult then
    return
  end
  local renderEntityService = world:GetService("RenderEntity")
  local pieceService = world:GetService("Piece")
  local dirType = switchBodyAreaResult:GetSwitchDirType()
  if self._up then
    local animName = animNameByDirType[dirType] or "Skill01Up"
    casterEntity:SetAnimatorControllerTriggers({animName})
    renderEntityService:DestroyMonsterAreaOutLineEntity(casterEntity)
    local centerPos = switchBodyAreaResult:GetOldBodyAreaPos()
    local oldBodyArea = switchBodyAreaResult:GetOldBodyArea()
    for _, body in ipairs(oldBodyArea) do
      pieceService:SetPieceAnimUp(centerPos + body)
    end
  else
    local centerPos = casterEntity:GetGridPosition()
    casterEntity:SetAnimatorControllerTriggers({
      "turnFinished"
    })
    casterEntity:SetDirection(switchBodyAreaResult:GetNewDir())
    renderEntityService:CreateMonsterAreaOutlineEntity(casterEntity)
    local bodyArea = switchBodyAreaResult:GetNewBodyArea()
    for _, body in ipairs(bodyArea) do
      pieceService:SetPieceAnimDown(centerPos + body)
    end
    local playBuffSvc = world:GetService("PlayBuff")
    playBuffSvc:PlayBuffView(TT, NTBodyAreaChange:New(casterEntity))
  end
end
