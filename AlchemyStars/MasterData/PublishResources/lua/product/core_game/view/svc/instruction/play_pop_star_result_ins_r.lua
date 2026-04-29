require("base_ins_r")
_class("PlayPopStarResultInstruction", BaseInstruction)
PlayPopStarResultInstruction = PlayPopStarResultInstruction

function PlayPopStarResultInstruction:Constructor(paramList)
end

function PlayPopStarResultInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local resultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local result = resultContainer:GetEffectResultByArray(SkillEffectType.PopStar)
  if not result then
    return
  end
  local popRes = result:GetDataPopStarResult()
  local pieceService = world:GetService("Piece")
  for _, v in ipairs(popRes:GetDelSet()) do
    pieceService:SetPieceAnimMoveDone(v.pos)
  end
  if world:MatchType() == MatchType.MT_PopStar then
    local popStarRSvc = world:GetService("PopStarRender")
    popStarRSvc:PlayPopStarResult(TT, popRes, true)
  elseif world:MatchType() == MatchType.MT_PopStarPro then
    local popStarRSvc = world:GetService("PopStarProRender")
    popStarRSvc:PlayPopStarResult(TT, popRes)
  end
end
