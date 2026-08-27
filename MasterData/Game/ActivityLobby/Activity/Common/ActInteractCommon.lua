local ActInteractCommon = {}
local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
ActInteractCommon.IntrctCmFuncs = {}

function ActInteractCommon.IntrctCmFuncs.ShowGuidePic(entity)
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl == nil then
    error("actLbCtrl == nil")
    return
  end
  local actLbCfg = actLbCtrl:GetActLbCfg()
  GuidePicture.OpenGuidePicture(actLbCfg.guide_id)
end

return ActInteractCommon
