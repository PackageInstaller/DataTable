require("sp_base_inst")
_class("SkillPreviewPlayPickColorAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayPickColorAnimInstruction = SkillPreviewPlayPickColorAnimInstruction

function SkillPreviewPlayPickColorAnimInstruction:Constructor(params)
  self._anim = params.Anim
end

function SkillPreviewPlayPickColorAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  self._world = previewContext:GetWorld()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local allPickUpPos = previewPickUpComponent:GetAllValidPickUpGridPos()
  local pickUpPieceType = {}
  local utilDataSvc = self._world:GetService("UtilData")
  local pieceTypeList = {}
  for k, pos in pairs(allPickUpPos) do
    local pieceType = utilDataSvc:GetPieceType(pos)
    if not table.icontains(pieceTypeList, pieceType) then
      table.insert(pieceTypeList, pieceType)
    end
  end
  local gridList = utilDataSvc:GetPiecePosByType(pieceTypeList)
  previewActiveSkillService:DoConvert(gridList, self._anim, "Dark")
end
