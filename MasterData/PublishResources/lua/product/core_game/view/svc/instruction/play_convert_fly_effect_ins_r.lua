require("play_grid_range_convert_ins_r")
_class("PlayConvertFlyEffectInstruction", PlayGridRangeConvertInstruction)
PlayConvertFlyEffectInstruction = PlayConvertFlyEffectInstruction

function PlayConvertFlyEffectInstruction:Constructor(paramList)
  self._flyEffectID = tonumber(paramList.flyEffectID)
  self._flySpeed = tonumber(paramList.flySpeed)
  if paramList.flyTime then
    self._flyTime = tonumber(paramList.flyTime)
  end
  self._flyTrace = tonumber(paramList.flyTrace)
  self._offsetX = tonumber(paramList.offsetx) or 0
  self._offsetY = tonumber(paramList.offsety) or 0
  self._offsetZ = tonumber(paramList.offsetz) or 0
  self._flyEaseType = paramList.flyEaseType
  self._pickUpPosAsTarget = tonumber(paramList.pickUpPosAsTarget) == 1
  self._targetPos = ""
  if paramList.targetPos then
    self._targetPos = paramList.targetPos
  end
  self._originalBoneName = ""
  if paramList.originalBoneName then
    self._originalBoneName = paramList.originalBoneName
  end
  self._isBlock = tonumber(paramList.isBlock) or 1
  self._convertEffectID = tonumber(paramList.convertEffectID)
  self._jumpPower = tonumber(paramList.jumpPower)
end

function PlayConvertFlyEffectInstruction:_Convert(world, gridPos, newGridType, flushTraps, casterEntity, TT)
  local trapServiceRender = world:GetService("TrapRender")
  for _, trap in ipairs(flushTraps) do
    trapServiceRender:DestroyTrap(trap)
  end
  if newGridType and newGridType >= PieceType.None and newGridType <= PieceType.Any then
    local tran = casterEntity:View():GetGameObject().transform
    local castPos = tran:TransformPoint(Vector3(self._offsetX, self._offsetY, self._offsetZ))
    local boardServiceRender = casterEntity:GetOwnerWorld():GetService("BoardRender")
    local targetPos = boardServiceRender:GridPos2RenderPos(gridPos)
    local dir = targetPos - castPos
    local effectEntity = world:GetService("Effect"):CreatePositionEffect(self._flyEffectID, castPos)
    effectEntity:SetDirection(dir)
    local distance = Vector3.Distance(castPos, targetPos)
    local flyTime = 0
    if self._flySpeed then
      flyTime = distance * self._flySpeed
    end
    local go = effectEntity:View():GetGameObject()
    local jumpPower = self._jumpPower or math.sqrt(distance)
    flyTime = self._flyTime or flyTime
    local dotween = go.transform:DOJump(targetPos, jumpPower, 1, flyTime * 0.001, false)
    dotween:OnComplete(function()
      if self._isBlock == 1 then
        self:_TaskFlying(TT, flyTime, world, effectEntity, gridPos, newGridType)
      else
        GameGlobal.TaskManager():CoreGameStartTask(self._TaskFlying, self, flyTime, world, effectEntity, gridPos, newGridType)
      end
    end)
    if self._isBlock == 1 then
      YIELD(TT, flyTime)
    end
  end
end

function PlayConvertFlyEffectInstruction:_TaskFlying(TT, flyTime, world, effectEntity, gridPos, newGridType)
  local boardServiceR = world:GetService("BoardRender")
  local newGridEntity = boardServiceR:ReCreateGridEntity(newGridType, gridPos)
  if newGridEntity then
    local pieceSvc = world:GetService("Piece")
    pieceSvc:SetPieceEntityAnimNormal(newGridEntity)
    if self._convertEffectID then
      local fxsvc = world:GetService("Effect")
      fxsvc:CreateWorldPositionEffect(self._convertEffectID, gridPos)
    end
  end
  world:DestroyEntity(effectEntity)
end

function PlayConvertFlyEffectInstruction:GetCacheResource()
  local t = {}
  if self._flyEffectID and self._flyEffectID > 0 and Cfg.cfg_effect[self._flyEffectID] then
    table.insert(t, {
      Cfg.cfg_effect[self._flyEffectID].ResPath,
      1
    })
  end
  if self._convertEffectID and 0 < self._convertEffectID and Cfg.cfg_effect[self._convertEffectID] then
    table.insert(t, {
      Cfg.cfg_effect[self._convertEffectID].ResPath,
      1
    })
  end
  return t
end
