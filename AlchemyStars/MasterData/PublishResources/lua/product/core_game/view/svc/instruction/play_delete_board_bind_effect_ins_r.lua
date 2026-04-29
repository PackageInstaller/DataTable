require("base_ins_r")
_class("PlayDeleteBoardBindEffectInstruction", BaseInstruction)
PlayDeleteBoardBindEffectInstruction = PlayDeleteBoardBindEffectInstruction

function PlayDeleteBoardBindEffectInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID) or 0
end

function PlayDeleteBoardBindEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local boardEntity = world:GetRenderBoardEntity()
  local entityList = {}
  if self._effectID and self._effectID > 0 then
    local casterEffectHolderCmpt = boardEntity:EffectHolder()
    local effectEntityIDList = casterEffectHolderCmpt:GetEffectEntityIDByEffectID(self._casterEffectID)
    if effectEntityIDList then
      for _, effectEntityID in ipairs(effectEntityIDList) do
        local effectEntity = world:GetEntityByID(effectEntityID)
        world:DestroyEntity(effectEntity)
      end
    end
    casterEffectHolderCmpt:ClearEffectByEffectID(self._casterEffectID)
  end
end
