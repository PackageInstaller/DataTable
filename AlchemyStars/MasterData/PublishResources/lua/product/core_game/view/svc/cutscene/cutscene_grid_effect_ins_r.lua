require("cutscene_base_ins_r")
_class("CutsceneGridEffectInstruction", CutsceneBaseInstruction)
CutsceneGridEffectInstruction = CutsceneGridEffectInstruction

function CutsceneGridEffectInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._posX = tonumber(paramList.posX)
  self._posY = tonumber(paramList.posY)
  self._dirX = tonumber(paramList.dirX) or 0
  self._dirY = tonumber(paramList.dirY) or 0
end

function CutsceneGridEffectInstruction:DoInstruction(TT, phaseContext)
  local world = phaseContext:GetCutsceneWorld()
  local effectService = world:GetService("Effect")
  local pos = Vector2(self._posX, self._posY)
  local dir = Vector2(self._dirX, self._dirY)
  local effectEntity = effectService:CreateWorldPositionDirectionEffect(self._effectID, pos, dir)
end

function CutsceneGridEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
