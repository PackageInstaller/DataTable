
---@type BaseSdkUtils
local BaseSdkUtils = import("Game.Sdk.BaseSdkUtils")
---@class AceUtils :BaseSdkUtils
local AceUtils = Class("AceUtils", BaseSdkUtils)
local KTool = CS.Engine.Lib.KTool
local CDTimerModule = CS.Engine.Modules.CDTimerModule
local SDKCenter = CS.Game.Native.MobileSDK.SDKCenter
local ProxyPluginName = "PlatformProxy"

---@param sdkService SDKService
function AceUtils:__init(sdkService)
    BaseSdkUtils.__init(self , sdkService)
    if not self:AceCall() then
        return
    end
    -- 开始收集安装列表
    if KTool.UNITY_ANDROID() then
        local data = {ioctId = 18 , ioctStr = "AllowAPKCollect"}
        SDKCenter.InvokePlugin(ProxyPluginName, "AnoSDKIoctl", table.serialize(data))
    end

    self.userComp = nil
    self.aceData1Timer  = CDTimerModule.GetInstance():AddCD(30, function(i, t)
       self:AceDataSend()
    end , 864000)
end
function AceUtils:AceCall()
    local isCall  = false
    ---@type SDKService
    local SDKService = self.sdkService
    if SDKService:IsCommonSDK() and  KTool.UNITY_ANDROID() then
        isCall = true
    end
    return isCall
end
function AceUtils:AnoSDKGetReportData()
    return CS.Engine.Lib.AndroidPlugin.AnoSDKGetReportData()
end
function AceUtils:GetAceDataReport()
    local KCookie = CS.Engine.Lib.KCookie
    local aceClose = KCookie.Get("Ace_Close")
    if isNull(aceClose) then
        return -1
    end
    return checkInt(aceClose)
end

function AceUtils:AnoSDKGetReportData2()
    ---@type GuideUtils
    local GuideUtils = import('Game.UI.Guide.GuideUtils')
    if GuideUtils.IsInGuiding() then
      return ""  
    end
    return CS.Engine.Lib.AndroidPlugin.AnoSDKGetReportData2()
end


function AceUtils:AceDataSend()
    if not self:AceCall() then
        return
    end     
    local aceValue = self:GetAceDataReport() 
    if aceValue == 0 or aceValue == 1  then
        local str = self:AnoSDKGetReportData()
        if isNotNull(str) and string.len(str) > 0 then
            GameUtils.Request(
                Interfaces.AceData,
                {antiData = str},
                function(request, response)
                end,
                nil,
                nil,
                nil,
                false
            )
        end
    end
    
end

function AceUtils:AceDataSend2()
    if not self:AceCall() then
        return
    end
    local aceValue = self:GetAceDataReport() 
    if aceValue == 0 or aceValue == 2 then
        local str = self:AnoSDKGetReportData2()
        if isNotNull(str) and string.len(str) > 0 then
            GameUtils.Request(
                Interfaces.AceData2,
                {antiData = str},
                function(request, response)
                end,
                nil,
                nil,
                nil,
                false
            )
        end
    end     
end

function AceUtils:__delete()
    BaseSdkUtils.__delete(self)
    if self.aceData1Timer then
        CDTimerModule.GetInstance():RemoveCD(self.aceData1Timer)
        self.aceData1Timer = nil
    end
    self.userComp = nil
end

return AceUtils