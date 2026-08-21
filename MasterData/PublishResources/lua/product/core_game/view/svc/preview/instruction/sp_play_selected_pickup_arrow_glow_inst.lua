require("sp_base_inst")
_class("SkillPreviewPlaySelectedPickupArrowGlowInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlaySelectedPickupArrowGlowInstruction = SkillPreviewPlaySelectedPickupArrowGlowInstruction

function SkillPreviewPlaySelectedPickupArrowGlowInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local pickUpPos = previewContext:GetPickUpPos()
  local boardServiceRender = world:GetService("BoardRender")
  local arrowEntities = world:GetGroup(world.BW_WEMatchers.PickUpArrow):GetEntities()
  for _, e in ipairs(arrowEntities) do
    local v3Pos = e:Location():GetPosition()
    local v2Pos = boardServiceRender:BoardRenderPos2GridPos(v3Pos)
    local statTable = {select = false, idle = true}
    if v2Pos == pickUpPos then
      statTable = {select = true, idle = false}
    end
    e:SetAnimatorControllerBools(statTable)
  end
end
