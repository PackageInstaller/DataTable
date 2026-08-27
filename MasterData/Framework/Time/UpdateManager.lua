local Messenger = require("Framework.Common.Messenger")
local UpdateManager = class("UpdateManager")
local UpdateMsgID = 1
local LateUpdateMsgID = 2
local FixedUpdateMsgID = 3

function UpdateManager:ctor()
  self.ui_message = Messenger.New()
  self.__update_handle = nil
  self.__lateupdate_handle = nil
  self.__fixedupdate_handle = nil
  self.started = false
end

local function UpdateHandle(self)
  self.ui_message:Broadcast(UpdateMsgID)
end

local function LateUpdateHandle(self)
  self.ui_message:Broadcast(LateUpdateMsgID)
end

local function FixedUpdateHandle(self)
  self.ui_message:Broadcast(FixedUpdateMsgID)
end

function UpdateManager:Start()
  if self.started then
    return
  end
  self.started = true
  self.__update_handle = UpdateBeat:CreateListener(UpdateHandle, self)
  self.__lateupdate_handle = LateUpdateBeat:CreateListener(LateUpdateHandle, self)
  self.__fixedupdate_handle = FixedUpdateBeat:CreateListener(FixedUpdateHandle, self)
  UpdateBeat:AddListener(self.__update_handle)
  LateUpdateBeat:AddListener(self.__lateupdate_handle)
  FixedUpdateBeat:AddListener(self.__fixedupdate_handle)
end

function UpdateManager:Stop()
  if not self.started then
    return
  end
  self.started = false
  if self.__update_handle ~= nil then
    UpdateBeat:RemoveListener(self.__update_handle)
    self.__update_handle = nil
  end
  if self.__lateupdate_handle ~= nil then
    LateUpdateBeat:RemoveListener(self.__lateupdate_handle)
    self.__lateupdate_handle = nil
  end
  if self.__fixedupdate_handle ~= nil then
    FixedUpdateBeat:RemoveListener(self.__fixedupdate_handle)
    self.__fixedupdate_handle = nil
  end
  self.ui_message:Clear()
end

function UpdateManager:AddUpdate(listener)
  self.ui_message:AddListener(UpdateMsgID, listener)
end

function UpdateManager:AddLateUpdate(listener)
  self.ui_message:AddListener(LateUpdateMsgID, listener)
end

function UpdateManager:AddFixedUpdate(listener)
  self.ui_message:AddListener(FixedUpdateMsgID, listener)
end

function UpdateManager:RemoveUpdate(listener)
  self.ui_message:RemoveListener(UpdateMsgID, listener)
end

function UpdateManager:RemoveLateUpdate(listener)
  self.ui_message:RemoveListener(LateUpdateMsgID, listener)
end

function UpdateManager:RemoveFixedUpdate(listener)
  self.ui_message:RemoveListener(FixedUpdateMsgID, listener)
end

return UpdateManager
