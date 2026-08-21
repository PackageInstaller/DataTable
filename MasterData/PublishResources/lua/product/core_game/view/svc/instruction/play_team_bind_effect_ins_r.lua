require("base_ins_r")
PlayTeamBindEffectMode = {Add = 1, Remove = 2}
_enum("PlayTeamBindEffectMode", PlayTeamBindEffectMode)
_class("PlayTeamBindEffectInstruction", BaseInstruction)
PlayTeamBindEffectInstruction = PlayTeamBindEffectInstruction

function PlayTeamBindEffectInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._mode = tonumber(paramList.mode)
end

function PlayTeamBindEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
    casterEntity = casterEntity:SuperEntityComponent():GetSuperEntity()
  end
  local teamEntity = world:Player():GetCurrentTeamEntity()
  if casterEntity:HasTeam() then
    teamEntity = casterEntity
  elseif casterEntity:HasPet() then
    teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  end
  local teamLeader = teamEntity:GetTeamLeaderPetEntity()
  local cEffectAttached = teamEntity:EffectAttached()
  if self._mode == PlayTeamBindEffectMode.Add then
    local mapFxID, _ = cEffectAttached:GetAttachedFxMap()
    if mapFxID[self._effectID] then
      self:_RemoveEffect(cEffectAttached, world)
    end
    YIELD(TT)
    local effect = world:GetService("Effect"):CreateEffect(self._effectID, teamLeader)
    cEffectAttached:AddAttachedEffectEntityID(effect:GetID(), self._effectID)
  elseif self._mode == PlayTeamBindEffectMode.Remove then
    self:_RemoveEffect(cEffectAttached, world)
  end
end

function PlayTeamBindEffectInstruction:_RemoveEffect(cEffectAttached, world)
  local mapFxID, _ = cEffectAttached:GetAttachedFxMap()
  if mapFxID[self._effectID] then
    local eid = mapFxID[self._effectID]
    local e = world:GetEntityByID(eid)
    if e then
      cEffectAttached:RemoveAttachedEntityID(eid)
      world:DestroyEntity(e)
    end
  end
end

function PlayTeamBindEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
