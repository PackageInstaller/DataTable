_class("HitbackSystem_Render", Object)
HitbackSystem_Render = HitbackSystem_Render

function HitbackSystem_Render:Constructor(world)
  self._world = world
  self._timeService = self._world:GetService("Time")
  self._group = world:GetGroup(world.BW_WEMatchers.Hitback)
end

function HitbackSystem_Render:Execute()
  self._group:HandleForeach(self, self.UpdateHitback)
end

function HitbackSystem_Render:UpdateHitback(e)
  self:_DoHitback(e)
end

function HitbackSystem_Render:_DoHitback(e)
  local hitbackCmpt = e:Hitback()
  if not hitbackCmpt then
    Log.debug("[HitBack] 发现非法的击退数据", e:GetID())
    return
  end
  if hitbackCmpt:IsHitbackEnd() then
    return
  end
  local v2Begin = hitbackCmpt:GetHitbackStartPos()
  local v2Dest = hitbackCmpt:GetHitbackTargetPos()
  local fSpeed = hitbackCmpt:GetHitbackSpeed()
  if v2Begin == v2Dest then
    Log.debug(self._className, "eid:", e:GetID(), " - 原地击退")
    self:_OnEventHitback_End(e)
    return
  end
  local cLocation = e:Location()
  if not cLocation then
    local v2TargetPos = v2Dest:Clone()
    e:SetLocation(v2TargetPos, Vector2.down)
    self:_OnEventHitback_End(e)
    return
  end
  if not hitbackCmpt:IsStartMoving() then
    self:_OnEventHitback_Start(e, hitbackCmpt)
  end
  local boardServiceRender = self._world:GetService("BoardRender")
  local position = boardServiceRender:GetRealEntityGridPos(e)
  local distance = Vector2.Distance(v2Dest, v2Begin)
  local fullTime = distance / fSpeed * 1000
  local deltaTimeMS = self._timeService:GetDeltaTimeMs()
  hitbackCmpt:AppendDeltaTime(deltaTimeMS)
  local time = hitbackCmpt:GetDeltaTime()
  local fProgress = time / fullTime
  local currentPos = Vector2.Lerp(v2Begin, v2Dest, fProgress)
  e:SetLocation(currentPos)
  if 1 <= fProgress then
    self:_TryMovePetMemeber(e, v2Dest)
    self:_OnEventHitback_End(e)
  end
end

function HitbackSystem_Render:_TryMovePetMemeber(hitbackTarget, targetPos)
  if not hitbackTarget:HasPetPstID() then
    return
  end
  local teamEntity = hitbackTarget:Pet():GetOwnerTeamEntity()
  teamEntity:SetPosition(targetPos)
  local utilDataSvc = self._world:GetService("UtilData")
  if utilDataSvc:CanChangePieceToGray() then
    local boardService = self._world:GetService("BoardRender")
    boardService:ReCreateGridEntity(PieceType.None, targetPos)
  end
  local pets = teamEntity:Team():GetTeamPetEntities()
  for _, e in ipairs(pets) do
    e:SetPosition(targetPos)
  end
end

function HitbackSystem_Render:_OnEventHitback_Start(entityWork, cmptHitback)
  cmptHitback:SetStartMoving(true)
  local posNow = cmptHitback:GetHitbackStartPos()
  local gridOffset = cmptHitback:GetGridOffset() or Vector2(0, 0)
  local posCenter = posNow - gridOffset
  local trapServiceRender = self._world:GetService("TrapRender")
  if entityWork:HasBodyArea() then
    local bodyArea = entityWork:BodyArea():GetArea()
    for _, areaPos in ipairs(bodyArea) do
      trapServiceRender:ShowHideTrapAtPos(areaPos + posCenter, true)
    end
  else
    trapServiceRender:ShowHideTrapAtPos(posNow, true)
  end
  local entityRenderService = self._world:GetService("RenderEntity")
  if entityWork:HasMonsterID() then
    entityRenderService:DestroyMonsterAreaOutLineEntity(entityWork)
  end
  cmptHitback:ResetDeltaTime()
end

function HitbackSystem_Render:_OnEventHitback_End(entityWork)
  local hitbackCmpt = entityWork:Hitback()
  hitbackCmpt:SetHitbackEnd()
end
