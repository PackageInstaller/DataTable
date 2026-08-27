local base = require("Game.ActivityLobby.Ctrl.ActLobbyCtrlBase")
local ActLbInputCtrl = class("ActLbInputCtrl", base)
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_Physics = CS.PhysicsUtility
local ActLbEnum = require("Game.ActivityLobby.ActLbEnum")

function ActLbInputCtrl:ctor(actLbCtrl)
  self._OnFingerTapFunc = BindCallback(self, self._OnFingerTap)
  self._OnGestureFunc = BindCallback(self, self._OnGesture)
end

function ActLbInputCtrl:OnActLbSceneEnter(bind)
  base.OnActLbSceneEnter(self, bind)
  self._camMain = UIManager:GetMainCamera()
  CS_LeanTouch.OnFingerTap("+", self._OnFingerTapFunc)
  CS_LeanTouch.OnGesture("+", self._OnGestureFunc)
end

function ActLbInputCtrl:_OnGesture(fingerList)
  if fingerList.Count == 0 or GuideManager.inGuide or fingerList[0].StartedOverGui then
    return
  end
  self.actLbCtrl.actLbCamCtrl:ActLbCamOnGesture(fingerList)
end

function ActLbInputCtrl:_OnFingerTap(leanFinger)
  if leanFinger.StartedOverGui or leanFinger.IsOverGui then
    return
  end
  if self.actLbCtrl:IsActLbState(ActLbEnum.eActLbState.HideUI) then
    self.actLbCtrl:ShowActLbUI(true)
    return
  end
  local hits = CS_Physics.Raycast(self._camMain, 1 << LayerMask.Raycast, true)
  for i = 0, hits.Length - 1 do
    local hitCollider = hits[i].collider
    if not IsNull(hitCollider) then
      local intrctEntity = self.actLbCtrl.actLbIntrctCtrl:TryGetActLbIntrctEnttByGo(hitCollider.gameObject)
      if intrctEntity ~= nil then
        self.actLbCtrl.actLbCmderCtrl:LbCmdMove2Entt(intrctEntity)
        return
      end
      if hitCollider.tag == TagConsts.DormFloor then
        local hitPos = hits[i].point
        self.actLbCtrl.actLbCmderCtrl:LbCmdMoveDestPos(hitPos)
        return
      end
    end
  end
end

function ActLbInputCtrl:Delete()
  CS_LeanTouch.OnFingerTap("-", self._OnFingerTapFunc)
  CS_LeanTouch.OnGesture("-", self._OnGestureFunc)
end

return ActLbInputCtrl
