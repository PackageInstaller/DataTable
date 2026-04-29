require("sp_base_inst")
_class("SkillPreviewPlayCasterDirToPickInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayCasterDirToPickInstruction = SkillPreviewPlayCasterDirToPickInstruction

function SkillPreviewPlayCasterDirToPickInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local gridPos = casterEntity:GetGridPosition()
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  local tv2Pick = previewPickUpComponent:GetAllValidPickUpGridPos()
  local v2Pickup = tv2Pick[1] or casterEntity:GetGridPosition()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local dirNew = v2Pickup - gridPos
  if dirNew.x > 0 then
    dirNew.x = 1
  elseif dirNew.x < 0 then
    dirNew.x = -1
  end
  if 0 < dirNew.y then
    dirNew.y = 1
  elseif 0 > dirNew.y then
    dirNew.y = -1
  end
  casterEntity:SetDirection(dirNew)
end
