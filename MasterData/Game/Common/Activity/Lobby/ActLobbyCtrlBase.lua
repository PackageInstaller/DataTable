local base = require("Game.Common.Activity.ActCommonCtrlBase")
local ActLobbyCtrlBase = class("ActLobbyCtrlBase", base)
local cs_MessageCommon = CS.MessageCommon

function ActLobbyCtrlBase:OnInit()
  base.OnInit(self)
end

function ActLobbyCtrlBase:OnDelete()
  base.OnDelete(self)
end

function ActLobbyCtrlBase:TryOpenActLobby(actId, skipStartShow, callback)
  local data = self._dataDic[actId]
  if data == nil then
    return
  end
  ControllerManager:DeleteController(ControllerTypeId.SectorController)
  local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl, true)
  local mainActivityId = data:GetActFrameId()
  local lobbyId = self:GetNowLobbyId(data)
  ctrl:SetActLobbyIndex(lobbyId)
  ctrl:InitActLobbyCtrl(mainActivityId)
  if skipStartShow then
    ctrl:SkipActLbStartShow()
  end
  self._enterCompleteCallback = callback
end

function ActLobbyCtrlBase:GetNowLobbyId(data)
  return nil
end

function ActLobbyCtrlBase:RunEnterCompleteFunc()
  if self._enterCompleteCallback then
    self._enterCompleteCallback()
    self._enterCompleteCallback = nil
  end
end

function ActLobbyCtrlBase:OpenActLobbyObj(objId, args)
  if objId ~= nil then
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    if not ctrl.actLbIntrctCtrl:GetActLbEntityIsUnlock(objId) then
      local unLockTip = ctrl.actLbIntrctCtrl:GetActLbIntrctActionUnlockTip(objId)
      if string.IsNullOrEmpty(unLockTip) then
        return
      end
      cs_MessageCommon.ShowMessageTips(unLockTip)
      return
    end
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain, false)
    ctrl.actLbIntrctCtrl:InvokeActLbEntity(objId, args)
    self.isInLobbyEnter = nil
    return
  end
  if self.isInLobbyEnter then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain, false)
    self.isInLobbyEnter = nil
  end
end

function ActLobbyCtrlBase:SetInLobbyEnter(bool)
  self.isInLobbyEnter = bool
end

return ActLobbyCtrlBase
