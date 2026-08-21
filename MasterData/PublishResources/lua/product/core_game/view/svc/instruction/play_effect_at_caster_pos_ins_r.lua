require("base_ins_r")
_class("PlayEffectAtCasterPosInstruction", BaseInstruction)
PlayEffectAtCasterPosInstruction = PlayEffectAtCasterPosInstruction

function PlayEffectAtCasterPosInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._offsetX = 0
  self._offsetY = 0
  self._offsetZ = 0
  if paramList.offsetX then
    self._offsetX = tonumber(paramList.offsetX)
  end
  if paramList.offsetY then
    self._offsetY = tonumber(paramList.offsetY)
  end
  if paramList.offsetZ then
    self._offsetZ = tonumber(paramList.offsetZ)
  end
  self._isGridPos = true
  if paramList.isGridPos then
    self._isGridPos = tonumber(paramList.isGridPos) == 1
  end
  self._isLogicGridPos = false
  if paramList.isLogicGridPos then
    self._isLogicGridPos = tonumber(paramList.isLogicGridPos) == 1
  end
  if paramList.tarPickGridIndex then
    self._tarPickGridIndex = tonumber(paramList.tarPickGridIndex)
  end
  if paramList.gridDirX then
    self._dirX = tonumber(paramList.gridDirX)
  end
  if paramList.gridDirY then
    self._dirY = tonumber(paramList.gridDirY)
  end
  self._useRenderDir = tonumber(paramList.useRenderDir) == 1
end

function PlayEffectAtCasterPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local boardServiceRender = world:GetService("BoardRender")
  local effectEntity
  local dir = casterEntity:GetGridDirection()
  if self._useRenderDir then
    dir = casterEntity:GetDirection()
  end
  if self._dirX and self._dirY then
    dir = Vector2(self._dirX, self._dirY)
  end
  if self._isGridPos then
    local pos = boardServiceRender:GetRealEntityGridPos(casterEntity)
    if self._isLogicGridPos then
      pos = casterEntity:GetGridPosition()
    end
    local sEffect = world:GetService("Effect")
    effectEntity = sEffect:CreateWorldPositionDirectionEffect(self._effectID, pos, dir)
    effectEntity:SetDirection(dir)
  else
    local renderPos = casterEntity:GetPosition()
    effectEntity = world:GetService("Effect"):CreatePositionEffect(self._effectID, renderPos)
    effectEntity:SetDirection(dir)
  end
  YIELD(TT)
  if effectEntity then
    local count = 0
    while not effectEntity:View() do
      count = count + 1
      if 10 < count then
        break
      end
      YIELD(TT)
    end
    local view = effectEntity:View()
    if view then
      local effectTran = view:GetGameObject().transform
      effectTran.position = effectTran.position + Vector3(self._offsetX, self._offsetY, self._offsetZ)
      if self._tarPickGridIndex then
        local renderPickUpComponent = casterEntity:RenderPickUpComponent()
        local scopeGridList = renderPickUpComponent:GetAllValidPickUpGridPos()
        local tarGridPos = scopeGridList[self._tarPickGridIndex]
        local casterGridPos = casterEntity:GetGridPosition()
        local dirV2 = tarGridPos - casterGridPos
        local effNewDir = Vector3(dirV2.x, 0 - effectTran.position.y, dirV2.y)
        effectEntity:SetLocation(effectTran.position, effNewDir)
      end
    end
  end
end

function PlayEffectAtCasterPosInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
