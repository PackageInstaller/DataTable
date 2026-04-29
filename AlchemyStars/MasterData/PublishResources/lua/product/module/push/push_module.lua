_class("PushModule", GameModule)
PushModule = PushModule
local pushAPI, methodIDDefine
if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
  pushAPI = GCloud.MSDK.MSDKPush
  methodIDDefine = GCloud.MSDK.MSDKMethodNameID
elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
  pushAPI = INTL.INTLAPI
  methodIDDefine = INTL.INTLMethodID
end

function PushModule:Constructor()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    self._defaultChannel = "XG"
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    self._defaultChannel = INTL.INTLChannel.Firebase
  end
  self:RegisterCallback()
end

function PushModule:Dispose()
  self:UnregisterCallback()
  self:UnregisterPush()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    self._pushRetCallback = nil
    self._pushBaseRetCallback = nil
  end
end

function PushModule:RegisterPush(openId, channel)
  if pushAPI then
    pushAPI.RegisterPush(channel or self._defaultChannel, openId)
  end
end

function PushModule:UnregisterPush(channel)
  if pushAPI then
    pushAPI.UnregisterPush(channel or self._defaultChannel)
  end
end

function PushModule:SetTag(tag, channel)
  if pushAPI then
    pushAPI.SetTag(channel or self._defaultChannel, tag)
  end
end

function PushModule:DeleteTag(tag, channel)
  if pushAPI then
    pushAPI.DeleteTag(channel or self._defaultChannel, tag)
  end
end

function PushModule:AddLocalNotification(localNotification, channel)
  if pushAPI then
    pushAPI.AddLocalNotification(channel or self._defaultChannel, localNotification)
  end
end

function PushModule:ClearLocalNotifications(channel)
  if pushAPI then
    pushAPI.ClearLocalNotifications(channel or self._defaultChannel)
  end
end

function PushModule:SetINTLPushRetCallback(callback)
  self._pushRetCallback = callback
end

function PushModule:SetINTLPushBaseRetCallback(callback)
  self._pushBaseRetCallback = callback
end

function PushModule:OnInlandPushBaseRetEvent(baseRet)
  local methodTag
  if baseRet.MethodNameId == methodIDDefine.MSDK_PUSH_REGISTER_PUSH:ToInt() then
    methodTag = "RegisterPush"
  elseif baseRet.MethodNameId == methodIDDefine.MSDK_PUSH_UNREGISTER_PUSH:ToInt() then
    methodTag = "UnregisterPush"
  elseif baseRet.MethodNameId == methodIDDefine.MSDK_PUSH_SET_TAG:ToInt() then
    methodTag = "SetTag"
  elseif baseRet.MethodNameId == methodIDDefine.MSDK_PUSH_DELETE_TAG:ToInt() then
    methodTag = "DeleteTag"
  end
  Log.error("[MSDK] OnPushBaseRetEvent methodTag " .. methodTag .. " RetCode " .. baseRet.RetCode .. " RetMsg " .. baseRet.RetMsg)
end

function PushModule:OnInlandPushNotificationEvent(pushRet)
  local methodTag
  if pushRet.MethodNameId == methodIDDefine.MSDK_PUSH_ADD_LOCAL_NOTIFICATION:ToInt() then
    methodTag = "AddLocalNotification"
  elseif pushRet.MethodNameId == methodIDDefine.MSDK_PUSH_CLEAR_LOCAL_NOTIFICATION:ToInt() then
    methodTag = "ClearLocalNotification"
  elseif pushRet.MethodNameId == methodIDDefine.MSDK_PUSH_NOTIFICAITON_CALLBACK:ToInt() then
    methodTag = "NotificationCallback"
  end
  Log.error("[MSDK] OnPushNotificationEvent methodTag " .. methodTag .. " Type " .. pushRet.Type .. " Notification " .. pushRet.Notification)
end

function PushModule:OnIntlPushRet(ret)
  if self._pushRetCallback then
    self._pushRetCallback(ret)
  end
  Log.info("[MSDK-INTL] PushModule:OnIntlPushRet, MethodId = ", ret.MethodId, ", loginRet = ", ret:ToString())
end

function PushModule:OnIntlPushBaseRet(baseRet)
  if self._pushBaseRetCallback then
    self._pushBaseRetCallback(baseRet)
  end
  Log.info("[MSDK-INTL] PushModule:OnIntlPushBaseRet, MethodId = ", baseRet.MethodId, ", loginRet = ", baseRet:ToString())
end

function PushModule:RegisterCallback()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    pushAPI.PushBaseRetEvent = pushAPI.PushBaseRetEvent + self.OnInlandPushBaseRetEvent
    pushAPI.PushNotificationEvent = pushAPI.PushNotificationEvent + self.OnInlandPushNotificationEvent
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    function self.m_OnPushRetEvent(ret)
      self:OnIntlPushRet(ret)
    end
    
    function self.m_OnPushBaseRetEvent(baseRet)
      self:OnIntlPushBaseRet(baseRet)
    end
    
    pushAPI.AddPushResultObserver(self.m_OnPushRetEvent)
    pushAPI.AddPushBaseResultObserver(self.m_OnPushBaseRetEvent)
  end
end

function PushModule:UnregisterCallback()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
    pushAPI.PushBaseRetEvent = pushAPI.PushBaseRetEvent - self.OnInlandPushBaseRetEvent
    pushAPI.PushNotificationEvent = pushAPI.PushNotificationEvent - self.OnInlandPushNotificationEvent
  elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    pushAPI.RemovePushResultObserver(self.m_OnPushRetEvent)
    pushAPI.RemovePushBaseResultObserver(self.m_OnPushBaseRetEvent)
  end
end
