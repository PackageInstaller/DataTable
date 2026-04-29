require("play_skill_phase_base_r")
_class("PlaySkillPlayEffectAtSomeElementGridPhase", PlaySkillPhaseBase)
PlaySkillPlayEffectAtSomeElementGridPhase = PlaySkillPlayEffectAtSomeElementGridPhase

function PlaySkillPlayEffectAtSomeElementGridPhase:PlayFlight(TT, casterEntity, phaseParam)
  local effectIDArray = phaseParam:GetEffectIDArray()
  local targetElementArray = phaseParam:GetTargetElementArray()
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, param in pairs(targetElementArray) do
    local elementType = tonumber(param)
    for _, pieceEntity in pairs(pieceGroup:GetEntities()) do
      local pieceCmpt = pieceEntity:Piece()
      if pieceCmpt.Type == elementType then
        self:_PlayEffect(pieceEntity:GridLocation().Position, effectIDArray)
      end
    end
  end
end

function PlaySkillPlayEffectAtSomeElementGridPhase:_PlayEffect(gridPos, effectIDArray)
  for _, param in ipairs(effectIDArray) do
    local effectID = tonumber(param)
    self._world:GetService("Effect"):CreateWorldPositionEffect(effectID, gridPos)
  end
end
