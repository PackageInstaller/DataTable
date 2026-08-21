require("cutscene_base_ins_r")
_class("CutsceneMonsterBindEffectInstruction", CutsceneBaseInstruction)
CutsceneMonsterBindEffectInstruction = CutsceneMonsterBindEffectInstruction

function CutsceneMonsterBindEffectInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._name = paramList.name
end

function CutsceneMonsterBindEffectInstruction:DoInstruction(TT, phaseContext)
  local world = phaseContext:GetCutsceneWorld()
  local effectService = world:GetService("Effect")
  local cutsceneServiceRender = world:GetService("Cutscene")
  for i, entity in ipairs(cutsceneServiceRender:GetCutsceneMonsterGroupEntity()) do
    local cutsceneMonsterComponent = entity:CutsceneMonster()
    if cutsceneMonsterComponent:GetCutsceneMonsterName() == self._name then
      local effect = effectService:CreateEffect(self._effectID, entity)
    end
  end
end

function CutsceneMonsterBindEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
