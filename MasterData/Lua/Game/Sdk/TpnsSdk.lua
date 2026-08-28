
---@type BaseSdkUtils
local BaseSdkUtils = import("Game.Sdk.BaseSdkUtils")
---@class TpnsSdk :BaseSdkUtils
local TpnsSdk = Class("TpnsSdk", BaseSdkUtils)
local KTool = CS.Engine.Lib.KTool
local CDTimerModule = CS.Engine.Modules.CDTimerModule
local SDKCenter = CS.Game.Native.MobileSDK.SDKCenter
local kTool = CS.Engine.Lib.KTool
local ProxyPluginName = "PlatformProxy"
---__int
function TpnsSdk:__init(sdkService)
    BaseSdkUtils.__init(self , sdkService)
    self.isClear = true 
end
function TpnsSdk:TpnsCall(isOpen)
    if isNull(isOpen) then
        isOpen = true 
    end
    local isCall  = false
    local SDKService = self.sdkService
    ---@type UserComponent
    local userComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.UserComponent)
    if isNull(userComp) then
        return
    end
    local notificationConf = userComp.userInfo.notificationConf
    if isNull(notificationConf) then
        return
    end
    local keys =  table.keys(notificationConf)
    if #keys == 0 then
        return
    end 
    if SDKService:IsCommonSDK() and kTool.IsMobile() then
        return true
    end
    return false
end

function TpnsSdk:setPushParam()
    if self:TpnsCall() then
        ---@type UserComponent
        local userComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.UserComponent)
        local notificationConf = userComp.userInfo.notificationConf
        local tpnsConf = {
            accessId = checkInt(notificationConf.accessId), 
            accessKey = checkString(notificationConf.accessKey), 
            host = checkString(notificationConf.host),
            domain = checkString(notificationConf.host)
        } 
        local tpnsConfStr = table.serialize(tpnsConf)
        if kTool.IsMobile() then
            SDKCenter.InvokePlugin(ProxyPluginName, "setPushParam", tpnsConfStr)
        end
    end
end

function TpnsSdk:upsertAccounts()
    if self:TpnsCall() then
        local HttpModule = CS.Engine.Http.HttpModule
        local RequestBodyMeta = HttpModule.RequestBodyMeta 
        ---@type UserComponent
        local userComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.UserComponent)
        if isNull(userComp)then
            return
        end
        SDKCenter.InvokePlugin(ProxyPluginName, "upsertAccounts",  tostring(userComp.userInfo.openId))        
    end
end
function TpnsSdk:OpenNotice()
    if self.isClear then
        self:setPushParam()
        self:registerPush()
        self:upsertAccounts()
        self.isClear = false 
    else 
        self:upsertAccounts()
    end
   
end
function TpnsSdk:CloseNotice()
    self.isClear = true
    self:delAccount()
    self:unregisterPush()
end
function TpnsSdk:delAccount()
    if self:TpnsCall(false) then
        local HttpModule = CS.Engine.Http.HttpModule
        local RequestBodyMeta = HttpModule.RequestBodyMeta 
        local userComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.UserComponent)
        if isNull(userComp)then
            return
        end
        SDKCenter.InvokePlugin(ProxyPluginName, "delAccount",tostring(userComp.userInfo.openId))     
    end     
end

function TpnsSdk:unregisterPush()
    if self:TpnsCall(false) then
        if kTool.UNITY_ANDROID() then
            SDKCenter.InvokePlugin(ProxyPluginName, "unregisterPush", "")   
        end     
    end 
end

function TpnsSdk:registerPush()
    if self:TpnsCall() then
        if kTool.UNITY_ANDROID() then
            SDKCenter.InvokePlugin(ProxyPluginName, "registerPush", "")          
        end
           
    end 
end



function TpnsSdk:__delete()
    BaseSdkUtils.__delete(self)
end

return TpnsSdk