require("cutscene_base_ins_r")
_class("CutsceneHitbackPlayerInstruction", CutsceneBaseInstruction)
CutsceneHitbackPlayerInstruction = CutsceneHitbackPlayerInstruction

function CutsceneHitbackPlayerInstruction:Constructor(paramList)
  self._dis = tonumber(paramList.dis)
  self._dirX = tonumber(paramList.dirX) or 0
  self._dirY = tonumber(paramList.dirY) or 1
  self._speed = tonumber(paramList.speed) or 10
end

function CutsceneHitbackPlayerInstruction:DoInstruction(TT, phaseContext)
  local world = phaseContext:GetCutsceneWorld()
  local cutsceneServiceRender = world:GetService("Cutscene")
  local dir = Vector2(self._dirX, self._dirY)
  cutsceneServiceRender:PlayCutsceneHitbackPlayer(TT, self._dis, dir, self._speed)
end
