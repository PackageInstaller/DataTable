require("base_ins_r")
_class("PlayEffectAGridPosInstruction", BaseInstruction)
PlayEffectAGridPosInstruction = PlayEffectAGridPosInstruction

function PlayEffectAGridPosInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._posX = tonumber(paramList.gridPosX)
  self._posY = tonumber(paramList.gridPosY)
  self._dirX = 0
  self._dirY = 1
  if paramList.gridDirX then
    self._dirX = tonumber(paramList.gridDirX)
  end
  if paramList.gridDirY then
    self._dirY = tonumber(paramList.gridDirY)
  end
  self._dirOnPickup = tonumber(paramList.dirOnPickup) == 1
end

function PlayEffectAGridPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local sEffect = world:GetService("Effect")
  local pos = Vector2(self._posX, self._posY)
  local dir = Vector2(self._dirX, self._dirY)
  if self._dirOnPickup then
    local renderPickUpComponent = casterEntity:RenderPickUpComponent()
    if renderPickUpComponent then
      local pickUpGridArray = renderPickUpComponent:GetAllValidPickUpGridPos()
      local v2PickupPos = pickUpGridArray[1]
      dir = v2PickupPos - casterEntity:GetGridPosition()
    end
  end
  local effectEntity = sEffect:CreateWorldPositionDirectionEffect(self._effectID, pos, dir)
end

function PlayEffectAGridPosInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    local effectCfg = Cfg.cfg_effect[self._effectID]
    if effectCfg == nil then
      Log.exception("找不到特效配置,ID是：", self._effectID)
    end
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
