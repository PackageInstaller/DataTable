require("base_ins_r")
_class("PlayMonster2802301CentralEffectInstruction", BaseInstruction)
PlayMonster2802301CentralEffectInstruction = PlayMonster2802301CentralEffectInstruction

function PlayMonster2802301CentralEffectInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._posY = tonumber(paramList.posY)
  local strOffset = paramList.offset
  if strOffset then
    local arr = string.split(strOffset, "|")
    self._offset = Vector2(tonumber(arr[1]), tonumber(arr[2]))
  else
    self._offset = Vector2.zero
  end
end

function PlayMonster2802301CentralEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local targetPos = Vector2.zero
  targetPos.y = self._posY
  targetPos.x = world:GetService("UtilData"):GetRoundBeginPlayerPos().x
  local offsetPos = targetPos + self._offset
  local effectService = world:GetService("Effect")
  effectService:CreateWorldPositionEffect(self._effectID, offsetPos)
end

function PlayMonster2802301CentralEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
