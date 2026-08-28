local Singleton = import('Frame.Singleton')
local PlayerPrefsUtility = CS.Engine.Tools.PlayerPrefsUtility
---@class ThirdDownloadManager
---@field GetInstance fun(self:ThirdDownloadManager):ThirdDownloadManager
local ThirdDownloadManager = Class("ThirdDownloadManager", Singleton)
local THIRD_PACK_DOWNLOAD_START = "THIRD_PACK_DOWNLOAD_START"
local THIRD_PACK_DOWNLOAD_SUPPORT = "THIRD_PACK_DOWNLOAD_SUPPORT"
local THIRD_PACK_DOWNLOAD_AND_PLAYING = "THIRD_PACK_DOWNLOAD_AND_PLAYING"
local Game = CS.Game.Native.Game
local AppVersion = CS.Engine.Lib.AppVersion
local KTool = CS.Engine.Lib.KTool
local SmallPackageDownloaded = "SmallPackageDownloaded"
local ThirdPackageDownloaded = "ThirdPackageDownloaded"
local PathUtility = CS.Engine.Lib.PathUtility
local util = require 'XLua.util'
local cs_coroutine = require('XLua.cs_coroutine')
local DecompressState = CS.Engine.Lib.Updater.DecompressState
local ResourceModule = CS.Engine.Modules.ResourceModule
local DownloadState = CS.Engine.Lib.Updater.DownloadState
local Directory = CS.System.IO.Directory
local Exists = CS.System.IO.Directory.Exists
local Utils = CS.Engine.Tools.Utils
local VerifyPackageState = CS.Engine.Lib.Updater.VerifyPackageState
local Yielders = CS.Engine.Lib.Yielders
local Updater = CS.Engine.Lib.Updater.Updater
---@type PreDownloadConstants
local PreDownloadConstants = import('Game.UI.PreDownload.PreDownloadConstants')
function ThirdDownloadManager:__init()
    self.isMainDownload = false
   
end

function ThirdDownloadManager:__delete()
    self.isMainDownload = nil
end

function ThirdDownloadManager:IsOpenDownloadMain()
    return self.isMainDownload or self:IsDownloadAndPlaying()
end

function ThirdDownloadManager:MainThirdDownload(downloadBeforeInfo)
    local thirdPackageConfig = self:GetDownloadThirdPackage(downloadBeforeInfo)
    if isNull(thirdPackageConfig) then
        return
    end
    cs_coroutine.start(function()
        xTry(function()
            ---@type Engine.Lib.Updater.DownloadState
            local download = DownloadState(nil, ResourceModule.AppDataPath, "Download")
            download.PatchMd5S = thirdPackageConfig.patchDojos
            download.OnLastMd5CheckCallback = function()
                Events.Broadcast("DownloadStatus", { status = PreDownloadConstants.DownloadStatus.ResourceCheck })
                xRecord.record('20-005', 'verify_third_start')
            end
            download.OnLastMargeFileCallback = function()
                Events.Broadcast("DownloadStatus", { status = PreDownloadConstants.DownloadStatus.ResourceMarge })
                xRecord.record('20-002', 'download_third_completed')
                -- self.TitleText.text = localize("文件合并中，请耐心等待...")
            end
            local verifyProgress = 0
            local startProgress = 0
            local progressMap = {}
            Events.Broadcast("DownloadStatus", { status = PreDownloadConstants.DownloadStatus.Starting })
            xRecord.record('20-001', string.format('downloading_third_%s',CS.UnityEngine.Application.version))
            download.ProgressCallback = function(DownloadedSize, TotalSize, speed)
                local size = DownloadedSize
                local Progress = size / TotalSize
                Events.Broadcast("DownloadStatus", { status = PreDownloadConstants.DownloadStatus.Progressing, downloadSize = size, totalSize = TotalSize, progress = Progress, speed = speed })
            end
            if self:IsDuoLe() then
                self:StartDownloadingAndPlaying()
            end
            local verifyProgress = 0
            download.OnCheckPercentCallback = function(percent)
                local proInt = math.floor(percent)
                if proInt >= verifyProgress then
                    local currentProgress = verifyProgress
                    while proInt >= verifyProgress do
                        currentProgress = verifyProgress
                        verifyProgress = verifyProgress + 20
                    end
                end
                Events.Broadcast("DownloadStatus", { status = PreDownloadConstants.DownloadStatus.ResourceNewCheck, progress = percent })
            end
            PlayerPrefsUtility.SetEncryptedString(THIRD_PACK_DOWNLOAD_START , "1")
            PlayerPrefsUtility.Save()
            download.OnFailCallback = function(error)
                if error == Constants.DownloadErrorType.INSUFFICIENT_DISK_SPACE_ERROR then
                    -- GameUtils.SecondConfirm(localize("空间不足,请清理空间") ,function ()
                    --     -- CS.UnityEngine.Application.Quit()
                    -- end,function ()
                    --     -- CS.UnityEngine.Application.Quit()
                    -- end)
                    -- GameUtils.Toast(localize("空间不足,请清理空间"), 5)
                    -- GameUtils.Toast(localize("空间不足"))
                elseif error == Constants.DownloadErrorType.UNKNOWN then
                    if not IS_REVIEW then
                        GameUtils.Toast(localize("未知错误"))    
                    end
                elseif error == Constants.DownloadErrorType.FILE_MERGE_ERROR then
                    if not IS_REVIEW then
                        GameUtils.Toast(localize("文件错误"))
                    end
                elseif error == Constants.DownloadErrorType.FILE_CHECK_ERROR then
                    if not IS_REVIEW then
                        GameUtils.Toast(localize("文件检测错误"))    
                    end
                elseif error == Constants.DownloadErrorType.NETWORK_ERROR then
                    if not IS_REVIEW then
                        GameUtils.Toast(localize("网络错误"))    
                    end
                elseif error == Constants.DownloadErrorType.BLOCK_ERROR then
                    if not IS_REVIEW then
                        GameUtils.Toast(localize("下载错误，修正中"))    
                    end
                end
            end
            download.OnFailStringCallback = function(data)
                local downloadInfo = table.deserialize(data)
                if isNotNull(downloadInfo.value) then
                    local value = checkInt(downloadInfo.value)
                    if value == Constants.DownloadErrorType.INSUFFICIENT_DISK_SPACE_ERROR then
                        GameUtils.Toast(localize("空间不足,请清理空间"), 5)
                        Events.Broadcast("DownloadStatus", { status = PreDownloadConstants.DownloadStatus.DownloadSpaceNotEnough, downloadInfo = downloadInfo})
                    end
                end 
            end
            download:SetFinishCallback(function(state)
                ---@type Engine.Lib.Updater.DownloadState
                local mState = state
                if mState.IsError then
                    Events.Broadcast("DownloadStatus", { status = PreDownloadConstants.DownloadStatus.Error, error = tostring(mState.Error.Message) })
                else
                    ----正常的下载完成
                    if not download.IsFinished then
                        download:Finish()
                    end
                    download.ProgressCallback = nil
                    download:SetFinishCallback(nil)
                    Events.Broadcast("DownloadStatus", { status = PreDownloadConstants.DownloadStatus.DownloadDone, progress = 100 })
                    xRecord.record('20-005', 'verify_third_completed')
                    xRecord.record('20-003', 'decom_third_start')
                end
            end)
            local vendorPath = PathUtility.Combine(ResourceModule.AppDataPath, ResourceModule.ProductRelPath)
            local decompressState = DecompressState(vendorPath, download)
            local decomProgress = 0
            self.isMainDownload = true
            decompressState.OnDecompressProgressAction = function()
                local proInt = decompressState.Progress * 100
                if proInt >= decomProgress then
                    local currentProgress = decomProgress
                    while proInt >= decomProgress do
                        currentProgress = decomProgress
                        decomProgress = decomProgress + 20
                    end
                end
                ---解压文件显示
                Events.Broadcast("DownloadStatus", { status = PreDownloadConstants.DownloadStatus.Decompressing, progress = decompressState.Progress })
            end
            decompressState.IsDeleteZip = false
            decompressState:SetFinishCallback(function()
                if decompressState.IsError then
                    Events.Broadcast("DownloadStatus", { status = PreDownloadConstants.DownloadStatus.Error, error = decompressState.Error.Message })
                    ----解压出错的情况下，清理下下载目录
                    local downloadPath = PathUtility.Combine(ResourceModule.AppDataPath, "Download")
                    if Exists(downloadPath) then
                        ---更新写入的路径
                        PathUtility.Clean(downloadPath)
                    end
                    if not Exists(downloadPath) then
                        Directory.CreateDirectory(downloadPath)
                    end
                else
                    xRecord.record('20-004', 'decom_third_completed')
                    -- xRecord.record('14-008', 'decom_finish')
                end
            end)
            local verifyPackageState = VerifyPackageState(download, false)
            local updater = Updater({ download, verifyPackageState, decompressState })
            
            updater.FinishCallback = function(update)
                ---更新完成进入游戏
                if updater.IsError then
                    self.isMainDownload = false
                    xRecord.record('14-010', tostring(updater.Error.Message))
                    ---更新出现错误了
                    Events.Broadcast("DownloadStatus", { status = PreDownloadConstants.DownloadStatus.Error, error = updater.Error.Message })
                else
                    ThirdDownloadManager:StartDownloadThirdPackageVersion(ThirdPackageDownloaded , CS.UnityEngine.Application.version)
                    local downloadPath = PathUtility.Combine(ResourceModule.AppDataPath, "Download")
                    if Exists(downloadPath) then
                        ---更新写入的路径
                        PathUtility.Clean(downloadPath)
                    end
                    if not Exists(downloadPath) then
                        Directory.CreateDirectory(downloadPath)
                    end
                    Events.Broadcast("DownloadStatus", { status = PreDownloadConstants.DownloadStatus.Finish })
                end
            end
            CS.Engine.Lib.AppEngine._Instance:StartCoroutine(updater:StartEnumerator())
            while not updater.IsDone do
                cs_coroutine.yield_return(Yielders.EndOfFrame)
            end
            download:RemoveListeners()
        end)
    end)
end
function ThirdDownloadManager:IsEnterSystemId(systemId)
    if not self:IsDuoLe() then
        return true
    end
    ---@type GuideUtils
    local GuideUtils = import('Game.UI.Guide.GuideUtils')
    if GuideUtils.IsInGuiding() then
        return true
    end
   
    if self:IsDownloadAndPlaying() then
        ---@type QuestComponent
        local questComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.QuestComponent)
        if isNotNull(questComp)  then
            if checkInt(questComp:GetCurQuestId()) >= 101080 then
                GameUtils.Toast(localize("下载资源中，请耐心等待..") )
                return
            end
        end
        GameUtils.Toast(localize("下载资源中，请先通关主线1-8"))
        return false
    else 
        if self:IsNotDwonloadingEnd() then
            self:DownloadSignalPackage(localize("请下载完整资源 ，抽取绝美角色"))
            return false
        end
    end
    local isUnLock = CfUtils.SystemToggleVo(systemId)
    return isUnLock
end   
function ThirdDownloadManager:IsDuoLe()
    local appEngine = CS.Engine.Lib.AppEngine
    local version = appEngine.GetAppBundleVersion()
    local channelId = checkInt(version.ChannelId)
    if ((channelId >= 6007 and channelId <= 6011) or channelId == 5023 or  channelId == 6013) and KTool.IsMobile() then
        return true
    end  
    return false
end

function ThirdDownloadManager:GetUpdatePatches(userUpdateInfo)
    local json = checkTable(userUpdateInfo)
    local remoteV = AppVersion(json.version)
    local localV = Game.Instance.Version
    local patches = {}
    local subPatches = {}
    if json.patches and table.count(json.patches) > 0 then
        local t = {}
        for key, v in pairs(json.patches) do
            ---@type Engine.Lib.Updater.PatchDojo
            local patchDojo = CS.Engine.Lib.Updater.PatchDojo()
            patchDojo.md5 = v.md5
            patchDojo.size = v.size
            patchDojo.url = string.format('%s/%s/%s.zip',json.updateUrl, json.version, key)
            patchDojo.ZipName = string.format("%s.zip", json.version)
            t[key] = patchDojo
        end
        patches = t
    end
    if json.subPatches and table.count(json.subPatches) > 0 then
        local t = {}
        for key, v in pairs(json.subPatches) do
            ---@type Engine.Lib.Updater.PatchDojo
            local patchDojo = CS.Engine.Lib.Updater.PatchDojo()
            patchDojo.md5 = v.md5
            patchDojo.size = v.size
            patchDojo.url = string.format('%s/%s/%s.zip',json.updateUrl, json.version, key)
            patchDojo.ZipName = string.format("%s.zip", json.version)
            t[key] = patchDojo
        end
        subPatches = t
    end
    local targetPatches = {}
    if string.isEmpty(json.subVersion) then
        targetPatches = patches
    else
        targetPatches = subPatches
    end
    return localV:CompareTo(remoteV) < 0 and targetPatches[localV:ToStandardVersionString()], targetPatches[localV:ToStandardVersionString()]
end 
function ThirdDownloadManager:IsSupportThirdPackage()
    if not (KTool.UNITY_ANDROID() or KTool.UNITY_IOS()) then
        return false
    end
    local isSupportPackage = PlayerPrefsUtility.GetEncryptedString(THIRD_PACK_DOWNLOAD_SUPPORT , "0")
    if checkInt(isSupportPackage) == 1 then
        return true
    end
    return false
end

function ThirdDownloadManager:SetSupportThirdPackages(downloadInfo)
    if not KTool.IsMobile() then
        return
    end
    if isNotNull(downloadInfo[1]) and type(downloadInfo[1]) == "table" then
        PlayerPrefsUtility.SetEncryptedString(THIRD_PACK_DOWNLOAD_SUPPORT, "1")
    else 
        PlayerPrefsUtility.SetEncryptedString(THIRD_PACK_DOWNLOAD_SUPPORT, "0")
    end
    PlayerPrefsUtility.Save()
end

function ThirdDownloadManager:IsStartDownloadThirdPackage()
   local isStart = PlayerPrefsUtility.GetEncryptedString(THIRD_PACK_DOWNLOAD_START, "0")
   if checkInt(isStart) == 1 then
        return true
   end
   return false
end

function ThirdDownloadManager:StartDownloadThirdPackageVersion(name ,  version)
    self:EndDownloadingAndPlaying()
    PlayerPrefsUtility.SetEncryptedString(name , version)
    PlayerPrefsUtility.SetEncryptedString(THIRD_PACK_DOWNLOAD_START, "0")
    PlayerPrefsUtility.Save()
 end

-- downloadInfo 下载 三段包 、二段的数据
-- userUpdateInfo 更新的下载数据
function ThirdDownloadManager:GetDownloadThirdAndSecondAndUpdatePackage(downloadInfo , userUpdateInfo)
    local spt = import('Frame.support')
    local PatchDojo = CS.Engine.Lib.Updater.PatchDojo
    local RemoteVersion = ""
    local count = 0 
    for k, v in ipairs(downloadInfo) do
        if isNotNull(v.split) then
            count = count + #v.split
        else 
            count = count + 1
        end
    end
    local hasUpdate,patchDojo =  self:GetUpdatePatches(userUpdateInfo)
    if hasUpdate then
        count = count + 1
    end
    local patchDojos = spt.new_array(typeof(PatchDojo), count)
    local index = 0
    local totalZipSize = 0
    local totalSize = 0
    for k, v in pairs(downloadInfo) do
        if isNotNull(v.split) and table.count(v.split) > 0  then
            -- 如果支持分1G 的zip 
            for i = 1, table.count(v.split) do
                local dojo = PatchDojo()
                dojo.IsUpdate = false
                local split = v.split
                local downloadInfo = split[i]
                dojo.url = downloadInfo.url
                if downloadInfo.xxh64 and not string.isEmpty(downloadInfo.xxh64) then
                    dojo.md5 = downloadInfo.xxh64
                else
                    dojo.md5 = downloadInfo.md5
                end
                dojo.size = checkNumber(downloadInfo.size)
                dojo.DecompressSize = checkNumber(downloadInfo.decompressSize)
                dojo.ZipName = k .. "_" .. i .. "_" ..  KTool.GetFileNameFromURL(downloadInfo.url);
                patchDojos[index] = dojo
                totalSize = dojo.DecompressSize + totalSize
                totalZipSize = checkNumber(dojo.size) + totalZipSize
                index = index + 1
            end
        else 
            local dojo = PatchDojo()
            dojo.IsUpdate = false
            local downloadInfo = v 
            dojo.url = downloadInfo.url
            if downloadInfo.xxh64 and not string.isEmpty(downloadInfo.xxh64) then
                dojo.md5 = downloadInfo.xxh64
            else
                dojo.md5 = downloadInfo.md5
            end
            dojo.size = checkNumber(downloadInfo.size)
            dojo.DecompressSize = checkNumber(downloadInfo.decompressSize)
            if isNotNull(dojo.DecompressSize)  then
                totalSize = dojo.DecompressSize + totalSize
            else 
                totalSize = dojo.size + totalSize
            end
            dojo.ZipName = k .. "_"  ..  KTool.GetFileNameFromURL(downloadInfo.url)
            patchDojos[index] = dojo
            index = index + 1
        end
    end
    if hasUpdate then
        local dojo = PatchDojo()
        dojo.IsUpdate = true
        dojo.url = patchDojo.url
        dojo.md5 = patchDojo.md5
        dojo.ZipName = patchDojo.ZipName
        dojo.size = checkNumber(patchDojo.size)
        if isNotNull(dojo.DecompressSize)  then
            totalSize = dojo.DecompressSize + totalSize
        else 
            totalSize = dojo.size + totalSize
        end
        totalZipSize = checkNumber(dojo.size) + totalSize
        patchDojos[count - 1] = dojo
        local json = checkTable(userUpdateInfo)
        local remoteV = AppVersion(json.version)
        RemoteVersion = remoteV
    end
    return {
        RemoteVersion  = RemoteVersion , 
        totalZipSize = totalZipSize , 
        totalSize = totalSize , 
        patchDojos = patchDojos 
    }
end


function ThirdDownloadManager:DownloadSignalPackage(text , callfunc)
    if not self:IsDuoLe() then
        if calfunc then
            calfunc()    
        end
        return
    end
    local preVersion = PlayerPrefsUtility.GetEncryptedString(SmallPackageDownloaded, "")
    if string.isEmpty(preVersion) then
        preVersion = CS.UnityEngine.Application.version
    end
    local thirdVersion = PlayerPrefsUtility.GetEncryptedString(ThirdPackageDownloaded, "")
    if not string.isEmpty(thirdVersion) then
        preVersion = preVersion .. ";" .. thirdVersion
    end
    GameUtils.Request("User/downloadBefore", { preVersion = preVersion }, function(request, response)
        if checkNumber(response.errCode) == 0 then
            if not KTool.IsWifi() then
                GameUtils.SecondConfirm(text , function ()
                    ThirdDownloadManager:MainThirdDownload(checkTable(response.data))
                    if callfunc then
                        callfunc()    
                    end
                end,function ()
                    PlayerPrefsUtility.SetEncryptedString(THIRD_PACK_DOWNLOAD_AND_PLAYING , "0")
                    PlayerPrefsUtility.Save()
                    if callfunc then
                        callfunc()    
                    end
                end )
            else 
                GameUtils.Toast(localize("开启静默下载 ..."))    
                ThirdDownloadManager:MainThirdDownload(checkTable(response.data))
                if callfunc then
                    callfunc()
                end
            end
        end 
    end)    
end

function ThirdDownloadManager:StartDownloadingAndPlaying()
    PlayerPrefsUtility.SetEncryptedString(THIRD_PACK_DOWNLOAD_AND_PLAYING , "1")
    PlayerPrefsUtility.Save()
end

function ThirdDownloadManager:EndDownloadingAndPlaying()
    PlayerPrefsUtility.SetEncryptedString(THIRD_PACK_DOWNLOAD_AND_PLAYING , "0")
    PlayerPrefsUtility.Save()
end    
--- 三段包是否没有下载完
function ThirdDownloadManager:IsNotDwonloadingEnd()
    if not self:IsDuoLe() then
        return false
    end
    local thirdVersion = PlayerPrefsUtility.GetEncryptedString(ThirdPackageDownloaded, "")
    local currentVersion = CS.UnityEngine.Application.version
    if currentVersion ==  thirdVersion then
        return false
    end
    return true
end
--- 是否在边下边玩过程中
function ThirdDownloadManager:IsDownloadAndPlaying()
    local isStartDownloadPlaying = PlayerPrefsUtility.GetEncryptedString(THIRD_PACK_DOWNLOAD_AND_PLAYING , "0")
    if checkInt(isStartDownloadPlaying) == 0 then
        return false
    end
    return true
end
-- downloadInfo 下载二段包的数据
-- userUpdateInfo 更新的下载数据
function ThirdDownloadManager:GetDownloadSecondAndUpdatePackage(downloadInfo , userUpdateInfo)
    local spt = import('Frame.support')
    local PatchDojo = CS.Engine.Lib.Updater.PatchDojo
    local RemoteVersion = ""
    local count = 0 
    local secondInfo = downloadInfo[1]
    if isNotNull(secondInfo.split) then
        count = count + #secondInfo.split
    else 
        count = count + 1
    end
    local hasUpdate,patchDojo = self:GetUpdatePatches(userUpdateInfo)
    if hasUpdate then
        count = count + 1
    end
    local patchDojos = spt.new_array(typeof(PatchDojo), count)
    local index = 0
    local totalZipSize = 0
    local totalSize = 0
    if isNotNull(secondInfo.split) and table.count(secondInfo.split) > 0  then
        -- 如果支持分1G 的zip 
        for i = 1, table.count(secondInfo.split) do
            local dojo = PatchDojo()
            dojo.IsUpdate = false
            local split = secondInfo.split
            local downloadInfo = split[i]
            dojo.url = downloadInfo.url
            if downloadInfo.xxh64 and not string.isEmpty(downloadInfo.xxh64) then
                dojo.md5 = downloadInfo.xxh64
            else
                dojo.md5 = downloadInfo.md5
            end
            dojo.size = checkNumber(downloadInfo.size)
            dojo.DecompressSize = checkNumber(downloadInfo.decompressSize)
            patchDojos[index] = dojo
            totalSize = dojo.DecompressSize + totalSize
            totalZipSize = checkNumber(dojo.size) + totalZipSize
            dojo.ZipName = i .. "_"  ..  KTool.GetFileNameFromURL(downloadInfo.url)
            index = index + 1
        end
    else 
        local dojo = PatchDojo()
        dojo.IsUpdate = false
        local downloadInfo = secondInfo 
        dojo.url = downloadInfo.url
        if downloadInfo.xxh64 and not string.isEmpty(downloadInfo.xxh64) then
            dojo.md5 = downloadInfo.xxh64
        else
            dojo.md5 = downloadInfo.md5
        end
        dojo.ZipName = 1 .. "_"  ..  KTool.GetFileNameFromURL(downloadInfo.url)
        dojo.size = checkNumber(downloadInfo.size)
        dojo.DecompressSize = checkNumber(downloadInfo.decompressSize)
        if isNotNull(dojo.DecompressSize)  then
            totalSize = dojo.DecompressSize + totalSize
        else 
            totalSize = dojo.size + totalSize
        end
        patchDojos[index] = dojo
        index = index + 1
    end
    if hasUpdate then
        local dojo = PatchDojo()
        dojo.IsUpdate = true
        dojo.url = patchDojo.url
        dojo.md5 = patchDojo.md5
        dojo.ZipName = patchDojo.ZipName
        dojo.size = checkNumber(patchDojo.size)
        if isNotNull(dojo.DecompressSize)  then
            totalSize = dojo.DecompressSize + totalSize
        else 
            totalSize = dojo.size + totalSize
        end
        totalZipSize = checkNumber(dojo.size) + totalSize
        patchDojos[count - 1] = dojo
        local json = checkTable(userUpdateInfo)
        local remoteV = AppVersion(json.version)
        RemoteVersion = remoteV
    end
    return {
        RemoteVersion  = RemoteVersion , 
        totalZipSize = totalZipSize , 
        totalSize = totalSize , 
        patchDojos = patchDojos 
    }
end


function ThirdDownloadManager:IsMainOpenDownloadThirdPackage(chapterId)
    chapterId = checkInt(chapterId)
    if chapterId == 0 then
        return false
    end
    -- 不是移动设备直接返回
    if not self:IsSupportThirdPackage() then
        return false
    end
    local version =  PlayerPrefsUtility.GetEncryptedString(ThirdPackageDownloaded , "")
    if string.len(version) > 3  then
        return false
    end

    if chapterId < 106 then
        return false
    end
    return true
end

function ThirdDownloadManager:IsActivityOpenDownloadThirdPackage(activityType)
     -- 不是移动设备直接返回
     if not self:IsSupportThirdPackage() then
        return false
    end
    activityType = checkInt(activityType)
    if activityType == 0 then
        return false
    end
    local version =  PlayerPrefsUtility.GetEncryptedString(ThirdPackageDownloaded , "")
    if string.len(version) > 0  then
        return false
    end
    ---@type ActivityResControlVo[]
    local ActivityResControlVos = CfUtils.GetWholeVo(AutoIds.IdSetting6620, 'ActivityResControlVo')
    local oneActivityType = 0
    local isOpne = false
    for k, ActivityResControlVo in pairs(ActivityResControlVos) do
        oneActivityType = checkInt(ActivityResControlVo.activityType)
        if activityType == oneActivityType and checkNumber(ActivityResControlVo.status) == 0 then
            isOpne = true
            break
        end 
    end
    return isOpne
end

-- downloadInfo 下载三段包的数据
-- userUpdateInfo 更新的下载数据
function ThirdDownloadManager:GetDownloadThirdAndUpdatePackage(downloadInfo , userUpdateInfo)
    local spt = import('Frame.support')
    local PatchDojo = CS.Engine.Lib.Updater.PatchDojo
    local RemoteVersion = ""
    local count = 0 
    local thirdInfo = downloadInfo[2]
    if isNotNull(thirdInfo.split) then
        count = count + #thirdInfo.split
    else 
        count = count + 1
    end
    local hasUpdate,patchDojo =  self:GetUpdatePatches(userUpdateInfo)
    if hasUpdate then
        count = count + 1
    end
    local patchDojos = spt.new_array(typeof(PatchDojo), count)
    local index = 0
    local totalZipSize = 0
    local totalSize = 0
    if isNotNull(thirdInfo.split) and table.count(thirdInfo.split) > 0  then
        -- 如果支持分1G 的zip 
        for i = 1, table.count(thirdInfo.split) do
            local dojo = PatchDojo()
            dojo.IsUpdate = false
            local split = thirdInfo.split
            local downloadInfo = split[i]
            dojo.url = downloadInfo.url
            if downloadInfo.xxh64 and not string.isEmpty(downloadInfo.xxh64) then
                dojo.md5 = downloadInfo.xxh64
            else
                dojo.md5 = downloadInfo.md5
            end
            dojo.size = checkNumber(downloadInfo.size)
            dojo.DecompressSize = checkNumber(downloadInfo.decompressSize)
            dojo.ZipName = i .. "_"  ..  KTool.GetFileNameFromURL(downloadInfo.url)
            patchDojos[index] = dojo
            totalSize = dojo.DecompressSize + totalSize
            totalZipSize = checkNumber(dojo.size) + totalZipSize
            index = index + 1
        end
    else 
        local dojo = PatchDojo()
        dojo.IsUpdate = false
        local downloadInfo = thirdInfo 
        dojo.url = downloadInfo.url
        if downloadInfo.xxh64 and not string.isEmpty(downloadInfo.xxh64) then
            dojo.md5 = downloadInfo.xxh64
        else
            dojo.md5 = downloadInfo.md5
        end
        dojo.size = checkNumber(downloadInfo.size)
        dojo.ZipName = 1 .. "_"  ..  KTool.GetFileNameFromURL(downloadInfo.url)
        dojo.DecompressSize = checkNumber(downloadInfo.decompressSize)
        patchDojos[index] = dojo
        index = index + 1
    end
    if hasUpdate then
        local dojo = PatchDojo()
        dojo.IsUpdate = true
        dojo.url = patchDojo.url
        dojo.md5 = patchDojo.md5
        dojo.ZipName = patchDojo.ZipName
        dojo.size = checkNumber(patchDojo.size)
        if isNotNull(dojo.DecompressSize)  then
            totalSize = dojo.DecompressSize + totalSize
        else 
            totalSize = dojo.size + totalSize
        end
        totalZipSize = checkNumber(dojo.size) + totalSize
        patchDojos[count - 1] = dojo
        local json = checkTable(userUpdateInfo)
        local remoteV = AppVersion(json.version)
        RemoteVersion = remoteV
    end
    return {
        RemoteVersion  = RemoteVersion , 
        totalZipSize = totalZipSize , 
        totalSize = totalSize , 
        patchDojos = patchDojos 
    }
end

-- 下载三段包
function ThirdDownloadManager:GetDownloadThirdPackage(downloadInfo)
    local RemoteVersion = ""
    local PatchDojo = CS.Engine.Lib.Updater.PatchDojo
    local totalZipSize = 0
    local totalSize = 0
    local count = #downloadInfo
    local thirdDownloadInfo = downloadInfo[count]
    if isNull(thirdDownloadInfo) then
        return
    end
    local count = thirdDownloadInfo.split and table.count(thirdDownloadInfo.split) or 1
    local spt = import('Frame.support')
    local patchDojos = spt.new_array(typeof(PatchDojo), count)
    if isNotNull(thirdDownloadInfo.split) and table.count(thirdDownloadInfo.split) > 0  then
        -- 如果支持分1G 的zip 
        for i = 1, table.count(thirdDownloadInfo.split) do
            local dojo = PatchDojo()
            dojo.IsUpdate = false
            local split = thirdDownloadInfo.split
            local downloadInfo = split[i]
            dojo.url = downloadInfo.url
            if downloadInfo.xxh64 and not string.isEmpty(downloadInfo.xxh64) then
                dojo.md5 = downloadInfo.xxh64
            else
                dojo.md5 = downloadInfo.md5
            end
            dojo.size = checkNumber(downloadInfo.size)
            dojo.DecompressSize = checkNumber(downloadInfo.decompressSize)
            patchDojos[i - 1] = dojo
            totalSize = dojo.DecompressSize + totalSize
            totalZipSize = checkNumber(dojo.size) + totalZipSize
        end
    else 
        local dojo = PatchDojo()
        dojo.IsUpdate = false
        local downloadInfo = thirdDownloadInfo
        dojo.url = downloadInfo.url
        if downloadInfo.xxh64 and not string.isEmpty(downloadInfo.xxh64) then
            dojo.md5 = downloadInfo.xxh64
        else
            dojo.md5 = downloadInfo.md5
        end
        dojo.size = checkNumber(downloadInfo.size)
        dojo.DecompressSize = checkNumber(downloadInfo.decompressSize)
        totalSize = dojo.DecompressSize + totalSize
        totalZipSize = checkNumber(dojo.size) + totalZipSize
        patchDojos[0] = dojo
    end
    return {
        RemoteVersion = "" ,
        totalZipSize = totalZipSize , 
        totalSize = totalSize , 
        patchDojos = patchDojos 
    }
end

return ThirdDownloadManager