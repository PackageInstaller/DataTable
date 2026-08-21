_class("ThirdPartyModule", GameModule)
ThirdPartyModule = ThirdPartyModule

function ThirdPartyModule:Constructor()
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland or H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
      if not IsUnityEditor() then
        self._performanceHandler = ThirdPartyPerfHandler:New()
      end
    elseif H3DGCloudLuaHelper.MsdkStatus ~= MSDKStatus.MS_International or not IsUnityEditor() then
    end
  end
end

function ThirdPartyModule:SyncOpenID(openID)
  if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland or H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    H3DGCloudLuaHelper.SyncOpenID(openID)
    local pushModule = self:GetModule(PushModule)
    pushModule:RegisterPush(openID)
    if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
      GCloud.MSDK.MSDKCrash.SetUserId(openID)
      if not IsUnityEditor() then
        self._performanceHandler:SyncOpenID(openID)
      end
    elseif H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_International then
    end
  end
end
