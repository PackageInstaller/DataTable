require("base_ins_r")
_class("PlayCameraMoveInstruction", BaseInstruction)
PlayCameraMoveInstruction = PlayCameraMoveInstruction

function PlayCameraMoveInstruction:Constructor(paramList)
  self._index = tonumber(paramList.index)
  self._moveTime = tonumber(paramList.moveTime)
  self._waitTime = tonumber(paramList.waitTime)
  self._resetTime = tonumber(paramList.resetTime)
end

function PlayCameraMoveInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local minHeight = BattleConst.MinScreenHeight
  local maxHeight = BattleConst.MaxScreenHeight
  local offset = BattleConst.CameraOffsetArray[self._index]
  local maxOffsetX = offset.x
  local maxOffsetY = offset.y
  local maxOffsetZ = offset.z
  local world = casterEntity:GetOwnerWorld()
  local mainCamera = world:MainCamera():Camera()
  local location = casterEntity:Location()
  local casterPos = location.Position
  local viewPortPos = mainCamera:WorldToViewportPoint(casterPos)
  if minHeight >= viewPortPos.y then
    return
  end
  local percent = (viewPortPos.y - minHeight) / (maxHeight - minHeight)
  if 1 < percent then
    percent = 1
  end
  local offsetY = maxOffsetY * percent
  local offsetX = maxOffsetX * percent
  local offsetZ = maxOffsetZ * percent
  local cameraTran = mainCamera.transform
  local targetPos = cameraTran:TransformPoint(Vector3(offsetX, offsetY, offsetZ))
  local originalPos = cameraTran.position
  cameraTran:DOMove(targetPos, self._moveTime / 1000.0, false)
  YIELD(TT, self._moveTime)
  YIELD(TT, self._waitTime)
  cameraTran:DOMove(originalPos, self._resetTime / 1000.0, false)
  YIELD(TT, self._resetTime)
end
