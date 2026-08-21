require("cutscene_base_ins_r")
_class("CutsceneMonsterDeadAnimationInstruction", CutsceneBaseInstruction)
CutsceneMonsterDeadAnimationInstruction = CutsceneMonsterDeadAnimationInstruction

function CutsceneMonsterDeadAnimationInstruction:Constructor(paramList)
  self._name = paramList.name
  self._monsterDeadType = tonumber(paramList.monsterDeadType)
end

function CutsceneMonsterDeadAnimationInstruction:DoInstruction(TT, phaseContext)
  local world = phaseContext:GetCutsceneWorld()
  local cutsceneServiceRender = world:GetService("Cutscene")
  for i, entity in ipairs(cutsceneServiceRender:GetCutsceneMonsterGroupEntity()) do
    local cutsceneMonsterComponent = entity:CutsceneMonster()
    if cutsceneMonsterComponent:GetCutsceneMonsterName() == self._name then
      cutsceneServiceRender:PlayCutsceneMonsterDead(TT, entity, self._monsterDeadType)
    end
  end
end
