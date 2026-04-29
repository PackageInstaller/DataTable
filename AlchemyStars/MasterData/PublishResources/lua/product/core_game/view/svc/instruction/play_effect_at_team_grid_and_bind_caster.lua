require("base_ins_r")
_class("PlayEffectAtTeamGridAndBindCasterInstruction", BaseInstruction)
PlayEffectAtTeamGridAndBindCasterInstruction = PlayEffectAtTeamGridAndBindCasterInstruction

function PlayEffectAtTeamGridAndBindCasterInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._bindCaster = tonumber(paramList.bindCaster) or 1
end

function PlayEffectAtTeamGridAndBindCasterInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end

function PlayEffectAtTeamGridAndBindCasterInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local teamEntity = world:Player():GetCurrentTeamEntity()
  local gridPos = teamEntity:GetGridPosition()
  if self._bindCaster == 1 then
    effectService:CreateGridEffectWithEffectHolder(self._effectID, gridPos, casterEntity)
  else
    effectService:CreateWorldPositionEffect(self._effectID, gridPos)
  end
end
