require("base_ins_r")
_class("PlayPickUpGridTogetherEffectInstruction", BaseInstruction)
PlayPickUpGridTogetherEffectInstruction = PlayPickUpGridTogetherEffectInstruction

function PlayPickUpGridTogetherEffectInstruction:Constructor(paramList)
end

function PlayPickUpGridTogetherEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.PickUpGridTogether)
  if not resultArray then
    return
  end
  local result = resultArray[1]
  local world = casterEntity:GetOwnerWorld()
  local boardServiceR = world:GetService("BoardRender")
  local utilDataSvc = world:GetService("UtilData")
  local newGridList = result:GetNewGridDataList()
  for i, data in ipairs(newGridList) do
    local newPieceType = data:GetGridType()
    local pos = data:GetGridPos()
    if utilDataSvc:GetRenderPieceType(pos) ~= newPieceType then
      local newGridEntity = boardServiceR:ReCreateGridEntity(newPieceType, pos, false, true)
      if newGridEntity then
        local pieceSvc = world:GetService("Piece")
        pieceSvc:SetPieceEntityAnimNormal(newGridEntity)
      end
    end
  end
end

function PlayPickUpGridTogetherEffectInstruction:GetCacheResource()
  local t = {}
  return t
end
