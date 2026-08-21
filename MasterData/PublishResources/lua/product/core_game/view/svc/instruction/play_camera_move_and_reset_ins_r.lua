require("base_ins_r")
_class("PlayCameraMoveAndResetInstruction", BaseInstruction)
PlayCameraMoveAndResetInstruction = PlayCameraMoveAndResetInstruction

function PlayCameraMoveAndResetInstruction:Constructor(paramList)
  local strOffset = paramList.offset
  if strOffset then
    local arr = string.split(strOffset, "|")
    self._offset = Vector3(tonumber(arr[1]), tonumber(arr[2]), tonumber(arr[3]))
  else
    self._offset = Vector3.zero
  end
  self._moveTime = tonumber(paramList.moveTime)
  self._waitTime = tonumber(paramList.waitTime)
  self._resetTime = tonumber(paramList.resetTime)
end

function PlayCameraMoveAndResetInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local mainCamera = world:MainCamera():Camera()
  local cameraTran = mainCamera.transform
  local originalPos = cameraTran.position
  local targetPos = originalPos + self._offset
  cameraTran:DOMove(targetPos, self._moveTime / 1000.0, false)
  YIELD(TT, self._moveTime)
  YIELD(TT, self._waitTime)
  cameraTran:DOMove(originalPos, self._resetTime / 1000.0, false)
  YIELD(TT, self._resetTime)
end
