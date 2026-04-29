require("base_ins_r")
_class("PlayMultiJumpEffectToTargetInstruction", BaseInstruction)
PlayMultiJumpEffectToTargetInstruction = PlayMultiJumpEffectToTargetInstruction

function PlayMultiJumpEffectToTargetInstruction:Constructor(paramList)
  self._flyEffectID = tonumber(paramList.flyEffectID)
  self._flySpeed = tonumber(paramList.flySpeed)
  if paramList.flyTime then
    self._flyTime = tonumber(paramList.flyTime)
  end
  self._startOffsetX = tonumber(paramList.startOffsetX) or 0
  self._startOffsetY = tonumber(paramList.startOffsetY) or 0
  self._startOffsetZ = tonumber(paramList.startOffsetZ) or 0
  self._targetOffsetX = tonumber(paramList.targetOffsetX) or 0
  self._targetOffsetY = tonumber(paramList.targetOffsetY) or 0
  self._targetOffsetZ = tonumber(paramList.targetOffsetZ) or 0
  self._jumpPower = tonumber(paramList.jumpPower)
  self._usePetTemplateID = tonumber(paramList.usePetTemplateID)
  self._useTargetViewDamageCenter = tonumber(paramList.useTargetViewDamageCenter)
  self._toPickPos = tonumber(paramList.toPickPos)
end

function PlayMultiJumpEffectToTargetInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local world = casterEntity:GetOwnerWorld()
  local targetEntity = world:GetEntityByID(targetEntityID)
  local casterEntityReal = casterEntity
  local targetPosV2
  if self._toPickPos and self._toPickPos == 1 then
    local renderPickUpComponent = casterEntity:RenderPickUpComponent()
    if renderPickUpComponent then
      local pickUpGridArray = renderPickUpComponent:GetAllValidPickUpGridPos()
      targetPosV2 = pickUpGridArray[1]
    end
    if not targetPosV2 then
      return
    end
  elseif targetEntity then
    local cGridLocation = targetEntity:GridLocation()
    local v2 = cGridLocation:Center()
    if self._useTargetViewDamageCenter then
      v2 = targetEntity:GetDamageCenter()
    end
    targetPosV2 = v2
  else
    return
  end
  if not targetPosV2 then
    return
  end
  if self._usePetTemplateID then
    local teamEntity = world:Player():GetLocalTeamEntity()
    local teamMembers = teamEntity:Team():GetTeamPetEntities()
    for _, petEntity in ipairs(teamMembers) do
      local cPetPstID = petEntity:PetPstID()
      local petTemplateID = cPetPstID:GetTemplateID()
      if petTemplateID == self._usePetTemplateID then
        casterEntityReal = petEntity
        break
      end
    end
  end
  local tran = casterEntityReal:View():GetGameObject().transform
  local castPos = tran:TransformPoint(Vector3(self._startOffsetX, self._startOffsetY, self._startOffsetZ))
  local boardServiceRender = casterEntityReal:GetOwnerWorld():GetService("BoardRender")
  local targetPos = boardServiceRender:GridPos2RenderPos(targetPosV2)
  targetPos = targetPos + Vector3(self._targetOffsetX, self._targetOffsetY, self._targetOffsetZ)
  local dir = targetPos - castPos
  local effectEntity = world:GetService("Effect"):CreatePositionEffect(self._flyEffectID, castPos)
  effectEntity:SetDirection(dir)
  local distance = Vector3.Distance(castPos, targetPos)
  local flyTime = 0
  if self._flySpeed then
    flyTime = distance * self._flySpeed
  end
  local go = effectEntity:View():GetGameObject()
  local dotween
  local jumpPower = self._jumpPower or math.sqrt(distance)
  flyTime = self._flyTime or flyTime
  local path = {}
  table.insert(path, castPos)
  local middlePos = Vector3.Lerp(castPos, targetPos, 0.4) + Vector3(0, jumpPower, 0)
  table.insert(path, middlePos)
  table.insert(path, targetPos)
  local pathBezier = {}
  for i = 0, 1, 0.1 do
    table.insert(pathBezier, self:_BezierMethod(i, path))
  end
  table.insert(pathBezier, targetPos)
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    local tweenTime = flyTime / table.count(pathBezier)
    for i = 1, table.count(pathBezier) - 1 do
      local nextPos = pathBezier[i + 1]
      go.transform:LookAt(nextPos)
      go.transform:DOMove(nextPos, tweenTime * 0.001)
      YIELD(TT, tweenTime)
    end
    go:SetActive(false)
    world:DestroyEntity(effectEntity)
  end)
end

function PlayMultiJumpEffectToTargetInstruction:GetCacheResource()
  local t = {}
  if self._flyEffectID and self._flyEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._flyEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayMultiJumpEffectToTargetInstruction:_BezierMethod(t, foceList)
  if table.count(foceList) < 2 then
    return foceList[1]
  end
  local temp = {}
  for i = 1, table.count(foceList) - 1 do
    local proportion = Vector3((1 - t) * foceList[i].x + t * foceList[i + 1].x, (1 - t) * foceList[i].y + t * foceList[i + 1].y, (1 - t) * foceList[i].z + t * foceList[i + 1].z)
    table.insert(temp, proportion)
  end
  return self:_BezierMethod(t, temp)
end
