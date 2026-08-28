local UIModule = CS.Engine.UI.UIModule
local KTool = CS.Engine.Lib.KTool
--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/PreDownload/PredownloadMemoryTipsPopup.prefab > name: PredownloadMemoryTipsPopup
---@class PredownloadMemoryTipsPopup
---@field Env                           	PredownloadMemoryTipsPopup              
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnJump                       	UnityEngine.RectTransform               	@ 0    
---@field TxtIconName                   	UnityEngine.RectTransform               	@ 1    
---@field TxtDeco                       	UnityEngine.RectTransform               	@ 2    
---@field RewardTips                    	UnityEngine.RectTransform               	@ 3    
local PredownloadMemoryTipsPopup = Class('PredownloadMemoryTipsPopup')
local ADD_SPACE_SIZE = 1610612736
local DeviceID = CS.Engine.Http.DeviceID
function PredownloadMemoryTipsPopup:__init()
    self.isBackForground = false
    self.TotalSize = nil
    self.isDownloadStart = false
    self.callback = nil
    if KTool.UNITY_IOS() then
        ADD_SPACE_SIZE = 2147483648
    end
    self.handler = Events.AddListener("DownloadStatus", Bind(self, self.DownStatusEventHandler))
end


function PredownloadMemoryTipsPopup:__delete()
    self.isBackForground = nil
    if isNotNull(self.handler) then
        Events.RemoveListener("DownloadStatus", self.handler)
        self.handler = nil    
    end
end


function PredownloadMemoryTipsPopup:Awake()
    local BehaviourAction =  CfUtils.GetOrAddComponent(self.controller.gameObject,CS.Engine.Lib.BehaviourAction )
    BehaviourAction.OnApplicationPauseAction = function(_, isPause)
        self.isBackForground = (not isPause)
    end
    BehaviourAction.OnApplicationFocusAction = function(_, isResume)
        if isResume then
            if (not self.isDownloadStart) and  KTool.UNITY_IOS() then
                self.MemorySize = DeviceID.GetFreeDiskSpaceInBytes
                local addSize = ADD_SPACE_SIZE
                self.needMemorySize = (self.TotalSize + ADD_SPACE_SIZE) - self.MemorySize
                print("self.needMemorySize => " ,self.needMemorySize)
                if self.needMemorySize < 0 then
                    if self.callback then
                        self.callback()    
                    end
                    self.isDownloadStart = true
                    UIModule.CloseDialog(self.controller)
                else 
                    self:RefreshUI(self.needMemorySize)    
                end
            end
        end
    end     
    
    if KTool.UNITY_IOS() then
        KTool.SetActive(self.BtnJump.gameObject , false)
    end
    SetButtonAction(self.BtnJump , function ()
        local SDKCenter = CS.Game.Native.MobileSDK.SDKCenter
        local kTool = CS.Engine.Lib.KTool
        local ProxyPluginName = "PlatformProxy"
        if kTool.UNITY_ANDROID() then
            SDKCenter.InvokePlugin(ProxyPluginName, "openSystemSetting", 'INTERNAL_STORAGE_SETTINGS')
        end     
    end)
end


function PredownloadMemoryTipsPopup:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        local needMemorySize =  initParams.needMemorySize
        self.TotalSize =  initParams.TotalSize
        self.callback = initParams.callback
        self:RefreshUI(needMemorySize)
    end)
end
function PredownloadMemoryTipsPopup:RefreshUI(needMemorySize)
    local Utils = CS.Engine.Tools.Utils
    local is1000 = KTool.UNITY_IOS()
    local utilStr = Utils.HumanReadableBytes(needMemorySize , is1000)
    local num , unit = string.match(utilStr , "([0-9|.]+)([A-Z]+)")
    CfUtils.FillText(self.TxtDeco , localize("您还需要<color=#ff009c><size=36>_num_</size></color><color=#ff009c><size=24>_unit_</size></color>才可完成下载是否立即前往清理？", {_num_  = num , _unit_ = unit }) )
    ---@type PreDownloadUtils
    local PreDownloadUtils = import('Game.UI.PreDownload.PreDownloadUtils')  
    local isNewPlayer = PreDownloadUtils.IsNewPlayer()
    CfUtils.SetActive(self.RewardTips, isNewPlayer)
end

function PredownloadMemoryTipsPopup:ListDirctory(path , sizes)
    local DirectoryInfo = CS.System.IO.DirectoryInfo
    ---@type System.IO.DirectoryInfo
    local theFolder = DirectoryInfo(path)
    ---@type System.IO.FileInfo[]
    local fileInfo =  theFolder:GetFiles()
    local support = require 'Frame.support'
    if isNotNull(fileInfo) and fileInfo.Length > 0  then
        for i = 0 , fileInfo.Length-1 do
            local  v = fileInfo[i]
            sizes[1] = sizes[1] + v.Length
        end
    end
    ---@type System.IO.DirectoryInfo[]
    local dircts = theFolder:GetDirectories()
    if isNotNull(dircts) and dircts.Length > 0 then
        for i = 0 , dircts.Length - 1 do
            local v = dircts[i]
            self:ListDirctory(v.FullName , sizes)
        end
       
    end     
    return sizes[1]
end

function PredownloadMemoryTipsPopup:GetTempTotalSize(path)
    return self:ListDirctory(path , {0})
end

function PredownloadMemoryTipsPopup:DownStatusEventHandler(params)
    ---@type PreDownloadConstants
    local PreDownloadConstants = import('Game.UI.PreDownload.PreDownloadConstants')
    local status = params.status
    if status == PreDownloadConstants.DownloadStatus.Progressing then 
        if not self.isBackForground then
            return 
        end
        self.isBackForground = false
        local totalSize = checkInt(self.TotalSize)  
        local downloadSize =  params.downloadSize
        local property = typeof(CS.Engine.Lib.AndroidPlugin):GetProperty("AvailableInternalMemorySize")
        if isNotNull(property) then
            local MemorySize = CS.Engine.Lib.AndroidPlugin.AvailableInternalMemorySize
            local addSize = ADD_SPACE_SIZE
            local ResourceModule = CS.Engine.Modules.ResourceModule
            local PathUtility = CS.Engine.Lib.PathUtility
            local downloadPath = PathUtility.Combine(ResourceModule.AppDataPath, "Download")
            local Directory = CS.System.IO.Directory
            if Directory.Exists(downloadPath) then
                local downloadPathTemp = PathUtility.Combine(downloadPath, "Temp")
                if Directory.Exists(downloadPathTemp) then
                    downloadSize = self:GetTempTotalSize(downloadPathTemp)  
                end
            end
            local needMemorySize = (totalSize + addSize) - MemorySize - downloadSize
            if needMemorySize <= 0 then
                UIModule.CloseDialog(self.controller)
            else 
                self:RefreshUI(needMemorySize)
            end
        end
    elseif status == PreDownloadConstants.DownloadStatus.DownloadDone then
        UIModule.CloseDialog(self.controller)
    end     
end

function PredownloadMemoryTipsPopup:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


return PredownloadMemoryTipsPopup
