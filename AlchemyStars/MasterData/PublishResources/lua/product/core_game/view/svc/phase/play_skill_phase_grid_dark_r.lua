require("play_skill_phase_base_r")
_class("PlaySkillPhase_GridDark", PlaySkillPhaseBase)
PlaySkillPhase_GridDark = PlaySkillPhase_GridDark

function PlaySkillPhase_GridDark:Constructor()
end

function PlaySkillPhase_GridDark:PlayFlight(TT, casterEntity, phaseParam)
  local paramWork = phaseParam
  local pieceService = self._world:GetService("Piece")
  local nDarkType = paramWork:GetDarkType() or SkillPhaseParam_GridDark_Type.Dark
  if SkillPhaseParam_GridDark_Type.Dark == nDarkType then
    pieceService:SetAllPieceDark()
  elseif SkillPhaseParam_GridDark_Type.Resume == nDarkType then
  end
end
