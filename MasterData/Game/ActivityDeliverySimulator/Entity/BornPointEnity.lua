local base = require("Game.ActivityDeliverySimulator.Entity.DeliverySimulatorInteractEntityBase")
local BornPointEnity = class("BornPointEnity", base)

function BornPointEnity:ctor(handInId, interactObj, dsCtrl)
  if dsCtrl ~= nil then
    dsCtrl.playerBornPos = interactObj.transform.position
  end
end

return BornPointEnity
