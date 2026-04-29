require("base_ins_r")
_class("PlayCameraEffectInstruction", BaseInstruction)
PlayCameraEffectInstruction = PlayCameraEffectInstruction

function PlayCameraEffectInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._bindBoard = paramList.bindBoard
  self._casterEffectHolder = tonumber(paramList.casterEffectHolder)
end

function PlayCameraEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if self._effectID and self._effectID > 0 then
    local world = casterEntity:GetOwnerWorld()
    local serEffect = world:GetService("Effect")
    if self._bindBoard then
      local boardEntity = world:GetRenderBoardEntity()
      serEffect:CreateScreenEffPointEffectWithHolder(self._effectID, boardEntity)
    elseif self._casterEffectHolder == 1 then
      serEffect:CreateScreenEffPointEffectWithHolder(self._effectID, casterEntity)
    else
      serEffect:CreateScreenEffPointEffect(self._effectID)
    end
  end
end

function PlayCameraEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
