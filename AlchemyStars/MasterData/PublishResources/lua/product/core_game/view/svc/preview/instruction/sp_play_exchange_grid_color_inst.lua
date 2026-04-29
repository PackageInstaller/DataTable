require("sp_base_inst")
_class("SkillPreviewPlayExchangeGridColorInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayExchangeGridColorInstruction = SkillPreviewPlayExchangeGridColorInstruction

function SkillPreviewPlayExchangeGridColorInstruction:Constructor(params)
  self._effectID = tonumber(params.EffectID)
end

function SkillPreviewPlayExchangeGridColorInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local previewActiveSkillService = world:GetService("PreviewActiveSkill")
  local utilDataSvc = world:GetService("UtilData")
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  local allPickUpGrid = previewPickUpComponent:GetAllValidPickUpGridPos()
  local pickUpCount = previewPickUpComponent:GetAllValidPickUpGridPosCount()
  if pickUpCount == 1 then
    previewActiveSkillService:DoConvert({
      allPickUpGrid[1]
    }, "Normal", "Dark")
  elseif pickUpCount == 2 then
    local gridType1 = utilDataSvc:GetPieceType(allPickUpGrid[1])
    local gridType2 = utilDataSvc:GetPieceType(allPickUpGrid[2])
    previewActiveSkillService:DoConvertElement(TT, {
      allPickUpGrid[1]
    }, gridType2, casterEntity)
    previewActiveSkillService:DoConvertElement(TT, {
      allPickUpGrid[2]
    }, gridType1, casterEntity)
  else
    Log.fatal("NoPickUpGrid")
  end
end
