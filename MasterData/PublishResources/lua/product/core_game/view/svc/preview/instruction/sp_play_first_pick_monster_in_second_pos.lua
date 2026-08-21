require("sp_base_inst")
_class("SkillPreviewPlayFirstPickMonsterInSecondPosInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayFirstPickMonsterInSecondPosInstruction = SkillPreviewPlayFirstPickMonsterInSecondPosInstruction

function SkillPreviewPlayFirstPickMonsterInSecondPosInstruction:Constructor(params)
end

function SkillPreviewPlayFirstPickMonsterInSecondPosInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local entitySvc = world:GetService("RenderEntity")
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  local firstPickUpPos = previewPickUpComponent:GetFirstValidPickUpGridPos()
  local lastPickUpPos = previewPickUpComponent:GetLastPickUpGridPos()
  local utilDataServiceShare = world:GetService("UtilData")
  if firstPickUpPos and lastPickUpPos and (firstPickUpPos.x ~= lastPickUpPos.x or firstPickUpPos.y ~= lastPickUpPos.y) then
    local monsterEntity = utilDataServiceShare:GetMonsterAtPos(firstPickUpPos)
    if monsterEntity then
      entitySvc:CreateGhost(previewContext:GetPickUpPos(), monsterEntity, "AtkUltPreview")
    end
  end
end
