require("cutscene_base_ins_r")
_class("CutsceneCreateMonsterInstruction", CutsceneBaseInstruction)
CutsceneCreateMonsterInstruction = CutsceneCreateMonsterInstruction

function CutsceneCreateMonsterInstruction:Constructor(paramList)
  self._monsterID = tonumber(paramList.monsterID)
  self._monsterClassID = tonumber(paramList.monsterClassID)
  self._name = paramList.name
  self._posX = tonumber(paramList.posX)
  self._posY = tonumber(paramList.posY)
  self._dirX = tonumber(paramList.dirX) or 0
  self._dirY = tonumber(paramList.dirY) or 0
  self._turnToPlayer = tonumber(paramList.turnToPlayer) or 1
end

function CutsceneCreateMonsterInstruction:DoInstruction(TT, phaseContext)
  local world = phaseContext:GetCutsceneWorld()
  local cutsceneServiceRender = world:GetService("Cutscene")
  local pos = Vector2(self._posX, self._posY)
  local dir = Vector2(self._dirX, self._dirY)
  cutsceneServiceRender:PlayCutsceneCreateMonster(TT, self._monsterID, self._monsterClassID, self._name, pos, dir, self._turnToPlayer)
end
