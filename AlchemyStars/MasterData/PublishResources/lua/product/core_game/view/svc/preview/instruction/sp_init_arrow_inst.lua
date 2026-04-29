require("sp_base_inst")
_class("SkillPreviewInitArrowInstruction", SkillPreviewBaseInstruction)
SkillPreviewInitArrowInstruction = SkillPreviewInitArrowInstruction

function SkillPreviewInitArrowInstruction:Constructor(params)
  self._number = params.Number
  self._showOutGrid = false
  if params.ShowOutGrid and params.ShowOutGrid == "true" then
    self._showOutGrid = true
  end
  self._skillPreviewCenterType = tonumber(params.SkillPreviewCenterType) or 1
end

function SkillPreviewInitArrowInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local centerPos = casterEntity:GridLocation().Position
  if self._skillPreviewCenterType == SkillPreviewCenterType.PickUp then
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    local scopeGridList = previewPickUpComponent:GetAllValidPickUpGridPos()
    centerPos = scopeGridList[1]
  end
  local previewActiveSkillService = world:GetService("PreviewActiveSkill")
  if self._number == "4" then
    previewActiveSkillService:ShowFourPickUpArrow(self._showOutGrid, centerPos)
  elseif self._number == "8" then
    previewActiveSkillService:ShowEightPickUpArrow(self._showOutGrid, centerPos)
  end
end

local SkillPreviewCenterType = {
  Team = 1,
  PickUp = 2,
  MAX = 99
}
_enum("SkillPreviewCenterType", SkillPreviewCenterType)
