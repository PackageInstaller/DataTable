local base = require("Game.ActivityLobby.Ctrl.ActLobbyCtrlBase")
local ActLbAStarPathCtrl = class("ActLbAStarPathCtrl", base)

function ActLbAStarPathCtrl:ctor(actLbCtrl)
end

function ActLbAStarPathCtrl:OnActLbSceneEnter(bind)
  base.OnActLbSceneEnter(self, bind)
end

function ActLbAStarPathCtrl:Delete()
end

return ActLbAStarPathCtrl
