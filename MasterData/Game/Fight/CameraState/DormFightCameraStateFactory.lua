local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCameraStateFactory = {}

function DormFightCameraStateFactory.CreateCameraState(stateType)
  local ret
  if stateType == DormFightConst.CameraStateEnum.RotateScene then
    ret = require("Game.Fight.CameraState.DFCameraRotateSceneState").New()
  elseif stateType == DormFightConst.CameraStateEnum.FollowCharacter then
    ret = require("Game.Fight.CameraState.DFCameraFollowState").New()
  end
  return ret
end

return DormFightCameraStateFactory
