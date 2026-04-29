require("base_ins_r")
_class("PlayChangeBodyAreaInstruction", BaseInstruction)
PlayChangeBodyAreaInstruction = PlayChangeBodyAreaInstruction

function PlayChangeBodyAreaInstruction:Constructor(paramList)
  self._notRefreshPieceAnimAndOutLine = tonumber(paramList.notRefreshPieceAnimAndOutLine) or 0
end

function PlayChangeBodyAreaInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ChangeBodyArea)
  if resultArray == nil then
    Log.fatal("PlayChangeBodyAreaInstruction, result is nil.")
    return
  end
  local pieceService = world:GetService("Piece")
  if self._notRefreshPieceAnimAndOutLine == 0 then
    pieceService:RefreshPieceAnim()
    pieceService:RefreshMonsterAreaOutLine(TT)
  end
  local playBuffSvc = world:GetService("PlayBuff")
  for _, result in ipairs(resultArray) do
    local entityID = result:GetChangeBodyAreaEntityID()
    local entity = world:GetEntityByID(entityID)
    playBuffSvc:PlayBuffView(TT, NTBodyAreaChange:New(entity))
  end
end
