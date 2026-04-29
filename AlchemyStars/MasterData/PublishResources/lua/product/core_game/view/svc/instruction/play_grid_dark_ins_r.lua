require("base_ins_r")
_class("PlayGridDarkInstruction", BaseInstruction)
PlayGridDarkInstruction = PlayGridDarkInstruction

function PlayGridDarkInstruction:Constructor(paramList)
  self._type = tonumber(paramList.darkType)
  self._duration = tonumber(paramList.duration)
  self._endValue = tonumber(paramList.endValue)
end

function PlayGridDarkInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local pieceService = world:GetService("Piece")
  if PlayGridDarkType.Dark == self._type then
    pieceService:SetAllPieceDark()
  elseif PlayGridDarkType.Resume == self._type then
    pieceService:RefreshPieceAnim()
  elseif PlayGridDarkType.DarkParam == self._type then
    pieceService:SetAllPieceDarkParam(self._duration, self._endValue)
  end
end

local PlayGridDarkType = {
  Dark = 0,
  Resume = 1,
  DarkParam = 2
}
_enum("PlayGridDarkType", PlayGridDarkType)
