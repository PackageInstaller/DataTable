require("cutscene_base_ins_r")
_class("CutsceneMonsterMoveToPlayerInstruction", CutsceneBaseInstruction)
CutsceneMonsterMoveToPlayerInstruction = CutsceneMonsterMoveToPlayerInstruction

function CutsceneMonsterMoveToPlayerInstruction:Constructor(paramList)
  self._monsterName = paramList.monsterName
  self._moveSpeed = tonumber(paramList.moveSpeed) or 2
  self._moveGridCount = tonumber(paramList.moveGridCount) or 1
end

function CutsceneMonsterMoveToPlayerInstruction:DoInstruction(TT, phaseContext)
  local world = phaseContext:GetCutsceneWorld()
  local cutsceneServiceRender = world:GetService("Cutscene")
  cutsceneServiceRender:PlayCutsceneMonsterMoveToPlayer(TT, self._monsterName, self._moveGridCount, self._moveSpeed)
end
