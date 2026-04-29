require("base_ins_r")
_class("PlayCasterEffectByUnderGridInstruction", BaseInstruction)
PlayCasterEffectByUnderGridInstruction = PlayCasterEffectByUnderGridInstruction

function PlayCasterEffectByUnderGridInstruction:Constructor(paramList)
  self._redEffectID = paramList.redEffectID
  self._yellowEffectID = paramList.yellowEffectID
  self._blueEffectID = paramList.blueEffectID
  self._greenEffectID = paramList.greenEffectID
end

function PlayCasterEffectByUnderGridInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local e = casterEntity
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
    local cSuperEntity = casterEntity:SuperEntityComponent()
    e = cSuperEntity:GetSuperEntity()
  end
  local gridPos = e:GetRenderGridPosition()
  self._world = e:GetOwnerWorld()
  local utilDataSvc = self._world:GetService("UtilData")
  local pieceType = utilDataSvc:GetPieceType(gridPos)
  local effectID
  if pieceType == PieceType.Blue then
    effectID = self._blueEffectID
  elseif pieceType == PieceType.Red then
    effectID = self._redEffectID
  elseif pieceType == PieceType.Green then
    effectID = self._greenEffectID
  elseif pieceType == PieceType.Yellow then
    effectID = self._yellowEffectID
  end
  local effect = self._world:GetService("Effect"):CreateEffect(self.effectID, e)
end

function PlayCasterEffectByUnderGridInstruction:GetCacheResource()
  local t = {}
  if self._redEffectID and self._redEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._redEffectID].ResPath,
      1
    })
  end
  if self._blueEffectID and 0 < self._blueEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._blueEffectID].ResPath,
      1
    })
  end
  if self._yellowEffectID and 0 < self._yellowEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._yellowEffectID].ResPath,
      1
    })
  end
  if self._greenEffectID and 0 < self._greenEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._greenEffectID].ResPath,
      1
    })
  end
  return t
end
