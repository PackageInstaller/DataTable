_class("BuffViewCreateTrapWithChainScope", BuffViewBase)
BuffViewCreateTrapWithChainScope = BuffViewCreateTrapWithChainScope

function BuffViewCreateTrapWithChainScope:PlayView(TT)
  local trapEntityIDs = self._buffResult:GetEntityIds()
  local trapResult = self._buffResult:GetTrapSkillResults()
  local trapServiceRender = self._world:GetService("TrapRender")
  if trapEntityIDs then
    local t = {}
    for _, eid in ipairs(trapEntityIDs) do
      local e = self._world:GetEntityByID(eid)
      if e:HasTrapID() then
        table.insert(t, e)
      end
    end
    trapServiceRender:ShowTraps(TT, t, true)
  end
  for _, v in ipairs(trapResult) do
    local eId = v[1]
    local e = self._world:GetEntityByID(eId)
    local skillEffectResultContainer = v[2]
    local triggerEid = v[3]
    local triggerEntity = self._world:GetEntityByID(triggerEid)
    e:SkillRoutine():SetResultContainer(skillEffectResultContainer)
    e:TrapRender():SetTriggerSkillResultContainer(skillEffectResultContainer)
    trapServiceRender:PlayTrapTriggerSkill(TT, e, false, triggerEntity)
  end
end

function BuffViewCreateTrapWithChainScope:IsNotifyMatch(notify)
  return true
end
