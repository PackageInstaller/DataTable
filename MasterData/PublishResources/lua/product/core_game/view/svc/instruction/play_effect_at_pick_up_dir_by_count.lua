require("base_ins_r")
_class("PlayEffectAtPickUpDirByCountInstruction", BaseInstruction)
PlayEffectAtPickUpDirByCountInstruction = PlayEffectAtPickUpDirByCountInstruction

function PlayEffectAtPickUpDirByCountInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._pickUpIndex = tonumber(paramList.pickUpIndex)
  if paramList.dirX then
    local arr = string.split(paramList.dirX, "|")
    self._dirX = arr
  end
  if paramList.dirY then
    local arr = string.split(paramList.dirY, "|")
    self._dirY = arr
  end
end

function PlayEffectAtPickUpDirByCountInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local oriEntity = casterEntity
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
    local cSuperEntity = casterEntity:SuperEntityComponent()
    oriEntity = cSuperEntity:GetSuperEntity()
  end
  local world = oriEntity:GetOwnerWorld()
  local sEffect = world:GetService("Effect")
  local renderPickUpComponent = oriEntity:RenderPickUpComponent()
  if not renderPickUpComponent then
    return
  end
  local pickUpGridArray = renderPickUpComponent:GetAllValidPickUpGridPos()
  local v2PickupPos = pickUpGridArray[self._pickUpIndex]
  local dir = Vector2(tonumber(self._dirX[#pickUpGridArray]), tonumber(self._dirY[#pickUpGridArray]))
  local effectEntity = sEffect:CreateWorldPositionDirectionEffect(self._effectID, v2PickupPos, dir)
end

function PlayEffectAtPickUpDirByCountInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
