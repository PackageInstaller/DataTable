local ActLobbyCtrlBase = class("ActLobbyCtrlBase")

function ActLobbyCtrlBase:ctor(actLbCtrl)
  self.actLbCtrl = actLbCtrl
  table.insert(self.actLbCtrl.ctrls, self)
end

function ActLobbyCtrlBase:OnActLbSceneEnter(bind)
  self._rootBind = bind
end

function ActLobbyCtrlBase:Delete()
end

return ActLobbyCtrlBase
