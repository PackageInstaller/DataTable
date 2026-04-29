require("play_skill_phase_base_r")
_class("PlaySkillRemoveEffectPhase", PlaySkillPhaseBase)
PlaySkillRemoveEffectPhase = PlaySkillRemoveEffectPhase

function PlaySkillRemoveEffectPhase:PlayFlight(TT, casterEntity, phaseParam)
  local e = casterEntity
  if casterEntity:HasSuperEntity() then
    local cSuperEntity = casterEntity:SuperEntityComponent()
    e = cSuperEntity:GetSuperEntity()
  end
  local holderCmp = e:EffectHolder()
  if not holderCmp then
    return
  end
  local effectService = self._world:GetService("Effect")
  local effIds = phaseParam:GetEffectIDList()
  local idDic = holderCmp:GetEffectIDEntityDic()
  if effIds then
    for _, id in pairs(effIds) do
      local entityList = idDic[id]
      if entityList then
        for k, entityID in pairs(entityList) do
          if entityID then
            local entity = self._world:GetEntityByID(entityID)
            if entity then
              self._world:DestroyEntity(entity)
            end
          end
        end
        idDic[id] = nil
      end
    end
  end
end
