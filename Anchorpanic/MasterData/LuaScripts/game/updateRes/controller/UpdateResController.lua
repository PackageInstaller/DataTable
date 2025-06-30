module("updateRes.UpdateResController", Class.impl())

--构造函数
function ctor(self)
    self:__init()
end

--析构函数
function dtor(self)
end

function start(self)
    web.setSplashTipProcess(95)
    print("WebController", "开始检测资源更新")
    download.ResDownLoadManager:setResDownLoadUrl(updateRes.UpdateResManager:getCdnUrl())

    local threadCount = 1
    local oneThreadLimitSpeed = 0
    if(sdk.SdkManager:getIsSimulator())then
        -- 模拟器的设置多线程设置少点
        threadCount = 5
        oneThreadLimitSpeed = 1000
    else
        if(gs.Application.platform == gs.RuntimePlatform.Android)then
            threadCount = 5
            oneThreadLimitSpeed = 0
        elseif(gs.Application.platform == gs.RuntimePlatform.IPhonePlayer)then
            threadCount = 5
            oneThreadLimitSpeed = 0
        elseif(gs.Application.platform == gs.RuntimePlatform.WindowsPlayer)then
            threadCount = 5
            oneThreadLimitSpeed = 0
        else
            threadCount = 5
            oneThreadLimitSpeed = 0
        end
    end
    download.ResDownLoadManager:setFrequencyRatio(0.1)
    download.ResDownLoadManager:setThreadCount(threadCount)
    download.ResDownLoadManager:setThreadLimitSpeed(threadCount * oneThreadLimitSpeed)

    web.WebController:reqReportStep(web.REPORT_STEP.UPDATE_MODEL_INIT)
    download.ResDownLoadManager:start()
end

function __init(self)
    self:__addEvents()
    download.ResDownLoadManager:init()
    -- 显示资源更新加载界面
    updateRes.UpdateResManager:dispatchEvent(updateRes.UpdateResManager.SHOW_LOADING_VIEW, {})
end

function __addEvents(self)
    -- 资源状态更新
    download.ResDownLoadManager:addEventListener(download.ResDownLoadManager.RES_STATE_UPDATE, self.onResStateUpdateHandler, self)
    -- 显示资源更新加载界面
    updateRes.UpdateResManager:addEventListener(updateRes.UpdateResManager.SHOW_LOADING_VIEW, self.onShowLoadingViewHandler, self)
    -- 关闭资源更新加载界面
    updateRes.UpdateResManager:addEventListener(updateRes.UpdateResManager.CLOSE_LOADING_VIEW, self.onCloseLoadingViewHandler, self)
    -- -- 更新资源更新加载界面
    -- updateRes.UpdateResManager:addEventListener(updateRes.UpdateResManager.UPDATE_LOADING, self.onUpdateLoadingViewHandler, self)

    -- 打开Alert界面
    updateRes.UpdateResManager:addEventListener(updateRes.UpdateResManager.OPEN_ALERT_VIEW, self.onOpenAlertViewHandler, self)   
    -- 关闭Alert界面
    updateRes.UpdateResManager:addEventListener(updateRes.UpdateResManager.CLOSE_ALERT_VIEW, self.onCloseAlertViewHandler, self)    
end

function __removeEvents(self)
    -- 资源状态更新
    download.ResDownLoadManager:removeEventListener(download.ResDownLoadManager.RES_STATE_UPDATE, self.onResStateUpdateHandler, self)
    -- 显示资源更新加载界面
    updateRes.UpdateResManager:removeEventListener(updateRes.UpdateResManager.SHOW_LOADING_VIEW, self.onShowLoadingViewHandler, self)
    -- 关闭资源更新加载界面
    updateRes.UpdateResManager:removeEventListener(updateRes.UpdateResManager.CLOSE_LOADING_VIEW, self.onCloseLoadingViewHandler, self)
    -- -- 更新资源更新加载界面
    -- updateRes.UpdateResManager:removeEventListener(updateRes.UpdateResManager.UPDATE_LOADING, self.onUpdateLoadingViewHandler, self)

    -- 打开Alert界面
    updateRes.UpdateResManager:removeEventListener(updateRes.UpdateResManager.OPEN_ALERT_VIEW, self.onOpenAlertViewHandler, self)  
    -- 关闭Alert界面
    updateRes.UpdateResManager:removeEventListener(updateRes.UpdateResManager.CLOSE_ALERT_VIEW, self.onCloseAlertViewHandler, self)   
end

-- 资源状态更新
function onResStateUpdateHandler(self, args)
    if self.mLoadingView then

        -- 下载出错重新开始下载
        if(not self.m_errorCall)then
            self.m_errorCall = function(callFun, callObj, callParams, errorCodeStr)
                self.mLoadingView:removePrepareProgressTimerHandler()
                local isHasNetWork, isMobileNet, isWifi = web.getNetStatus()
                if(isHasNetWork)then
                    local msg = "网络下载出错请重新下载"
                    if(errorCodeStr and errorCodeStr ~= "")then
                        msg = msg .. "，提示码：" .. errorCodeStr
                    end
                    updateRes.ShowAlert(updateRes.TipType.Net, "更新提示", msg
                        ,"确认",
                        function()
                            self:__removeAlertView()
                            if(callParams)then
                                callFun(callObj, callParams)
                            else
                                callFun(callObj)
                            end
                        end
                        -- ,"退出",
                        -- function()
                        --     CS.Lylibs.SDKManager.Ins:CloseApplication()
                        -- end
                    )
                else
                    updateRes.ShowAlert(updateRes.TipType.Net, "更新提示", "请检查网络状态"
                        ,"确认",
                        function()
                            self:__removeAlertView()
                            download.ResDownLoadManager:start()
                        end
                        -- ,"退出",
                        -- function()
                        --     CS.Lylibs.SDKManager.Ins:CloseApplication()
                        -- end
                    )
                end
            end
        end

        -- 重新下载安装包
        if(not self.m_downLoadPackageCall)then
            self.m_downLoadPackageCall = function()
                local tip = "换包"
                local confirmCall = function() CS.Lylibs.SDKManager.Ins:CloseApplication() end
                if(web.WebManager:isReleaseApp())then
                    local version = download.ResDownLoadManager:getClientVersionValue(gs.AssetSetting.VersionKey)
                    local versionStr = download.ResDownLoadManager:getVersionStr(version)
                    local prefixVersion = download.ResDownLoadManager:getClientVersionValue(gs.AssetSetting.PrefixVersionKey)
                    local proVersion = download.ResDownLoadManager:getClientVersionValue(gs.AssetSetting.ProVersionKey)
                    local artVersion = download.ResDownLoadManager:getClientVersionValue(gs.AssetSetting.ArtVersionKey)
                    tip = string.format("当前版本 %s 过低，请前往下载最新版本", web.getFormatVersion(prefixVersion, versionStr, proVersion, artVersion))
                else
                    if(web.WebManager.platform == web.DEVICE_TYPE.WINDOWS)then
                        tip = "需要更新svn目录"
                        confirmCall = function()
                            local streamAssetsPath = gs.PathUtil.StreamingPath
                            local splistList = string.split(streamAssetsPath, "/")
                            local path = ""
                            for i = 1, #splistList do
                                if(i <= #splistList - 2)then
                                    if(i == 1)then
                                        path = splistList[i]
                                    else
                                        path = path .. "\\" .. splistList[i]
                                    end
                                end
                            end

                            -- Debug:setLogAllow(true)
                            -- gs.ApplicationUtil.SetDebugVisible(true)
                            -- gs.ApplicationUtil.ShowDebugView()

                            CS.Lylibs.SDKManager.Ins:CloseApplication()
                            CS.System.Diagnostics.Process.Start("explorer.exe", path)
                            -- gs.ApplicationUtil.ControlPathSVn(path, "update")
                        end
                    elseif(web.WebManager.platform == web.DEVICE_TYPE.ANDROID)then
                        tip = "请重新下载安装包安装"
                        confirmCall = function()
                            local game_cdn_url = string.format("%s/%s/%s", web.WebManager.game_cdn, CS.Lylibs.AssetSetting.CdnVersionDir, CS.Lylibs.AssetSetting.VersionJsonName)
                            local function correctCall(self, webData, jsonObj)
                                if(jsonObj == nil)then
                                    CS.Lylibs.SDKManager.Ins:CloseApplication()
                                else
                                    local cdnVersion = tonumber(jsonObj[CS.Lylibs.AssetSetting.VersionKey])
                                    local maxVer = math.floor(cdnVersion / 1000000)
                                    local midVer = math.floor(cdnVersion / 1000 % 1000)
                                    local minVer = math.floor(cdnVersion % 1000)
                                    local appVersion = string.format("%s.%s.%s", maxVer, midVer, "1")
                                    local gamrUrl = string.gsub(web.WebManager.game_url, "x.x.x", appVersion)
                                    gs.SdkManager:LaunchUrlDetail(gamrUrl)
                                    CS.Lylibs.SDKManager.Ins:CloseApplication()
                                end
                            end
                            local function errorCall(self, errorData, jsonObj)
                                correctCall(self, nil)
                            end
                            WebInterfaceUtil:getAsyncLoop(game_cdn_url, correctCall, errorCall, self, 1)
                        end
                    elseif(web.WebManager.platform == web.DEVICE_TYPE.IOS)then
                        tip = "请重新下载安装包安装"
                        confirmCall = function()
                            gs.SdkManager:LaunchUrlDetail(web.WebManager.game_url)
                            CS.Lylibs.SDKManager.Ins:CloseApplication()
                        end
                    end
                end

                updateRes.ShowAlert(updateRes.TipType.Normal, "更新提示", tip
                    ,"确认",
                    function()
                        self:__removeAlertView()
                        confirmCall()
                    end
                    -- ,"取消",
                    -- function()
                    -- end
                )
            end
        end

        -- 清除资源重新更新
        if(not self.m_streamErrorCall)then
            self.m_streamErrorCall = function()
                updateRes.ShowAlert(updateRes.TipType.Normal, "更新提示", "客户端版本号异常，将清除所有资源并重新下载"
                    ,"确认",
                    function()
                        print("清理资源目录重新更新")
                        self:__removeAlertView()
                        download.ResDownLoadManager:cleanGameRes(function(result) download.ResDownLoadManager:start() end)
                    end
                    ,"退出",
                    function()
                        CS.Lylibs.SDKManager.Ins:CloseApplication()
                        -- CS.Lylibs.SDKManager.Ins:RestartApplication()
                    end
                )
            end
        end
        
        self.mLoadingView:updateView()
        local downLoadMgr = download.ResDownLoadManager
        local state = downLoadMgr:getUpdateState()
        local data = downLoadMgr:getUpdateData()

        if (state == download.ResState.Init) then                               -- 初始化
            if(data[1] == 0)then                                                -- 更新界面
            elseif(data[1] == 1)then                                            -- 初始化成功
                web.WebController:reqReportStep(web.REPORT_STEP.READ_CLIENT_VERSION)
                downLoadMgr:startReadLocalVersion()
            end

        elseif (state == download.ResState.ReadLocalVersion) then               -- 读取客户端版本号
            if(data[1] == 0)then                                                -- 更新界面                                
            elseif(data[1] == 1)then                                            -- 读取客户端版本号成功
                web.WebController:reqReportStep(web.REPORT_STEP.READ_CDN_VERSION)
                downLoadMgr:startReadCdnVersion()
            elseif(data[1] == 2)then                                            -- 解析出客户端版本号异常
                self.m_streamErrorCall()
            end

        elseif (state == download.ResState.ReadCdnVersion) then                 -- 读取服务器版本号
            if(data[1] == 0)then                                                -- 更新界面
            elseif(data[1] == 1)then                                            -- 下载服务器版本文件出错
                self.m_errorCall(downLoadMgr.startReadCdnVersion, downLoadMgr, nil, updateRes.ErrorCode.ServerVersionFileError)
            elseif(data[1] == 2)then                                            -- 下载服务器版本文件完成，但文件不存在
                self.m_errorCall(downLoadMgr.startReadCdnVersion, downLoadMgr, nil, updateRes.ErrorCode.ServerVersionFileMiss)
            elseif(data[1] == 3)then                                            -- 下载服务器版本文件完成，但解析出服务器版本号异常
                self.m_errorCall(downLoadMgr.startReadCdnVersion, downLoadMgr, nil, updateRes.ErrorCode.ServerVersionContentError)
            elseif(data[1] == 4)then                                            -- 解析出服务器版本号成功
                web.WebController:reqReportStep(web.REPORT_STEP.COMPARE_VERSION)
                downLoadMgr:compareVersion()
            end

        elseif (state == download.ResState.CompareVersion) then                 -- 版本号比对
            if(data[1] == 0)then                                                -- 更新界面
            elseif(data[1] == 1)then                                            -- 版本号校验异常
                self.m_errorCall(function()
                    downLoadMgr:init()
                    download.ResDownLoadManager:start()
                end, self, nil, updateRes.ErrorCode.VersionCompareError)
            elseif(data[1] == 2)then                                            -- 需要换包更新
                self.m_downLoadPackageCall()
            elseif(data[1] == 3)then                                            -- 当前已是最新版本
                web.WebController:reqReportStep(web.REPORT_STEP.READ_ASSETS_FILE)
                downLoadMgr:startReadFileList(false)
            elseif(data[1] == 4)then                                            -- 需要热更新
                web.WebController:reqReportStep(web.REPORT_STEP.READ_ASSETS_FILE)
                downLoadMgr:startReadFileList(true)
            elseif(data[1] == 5)then                                            -- 需要版本更新
                web.WebController:reqReportStep(web.REPORT_STEP.READ_ASSETS_FILE)
                downLoadMgr:startReadFileList(true)
            end

        elseif (state == download.ResState.CompareAssetVersion) then                    -- 资源文件配置下载比对
            if(data.stepIndex == 0)then                                                 -- 资源文件配置大小获取失败
                self.m_errorCall(downLoadMgr.startReadFileList, downLoadMgr, true, updateRes.ErrorCode.ServerVersionFileSizeError)
            elseif(data.stepIndex == 1)then                                             -- 开始检测资源文件配置
            elseif(data.stepIndex == 2)then                                             -- 资源版本为最新，直接检查资源文件配置成功
                web.WebController:reqReportStep(web.REPORT_STEP.COMPARE_ASSETS_FINISH)
                CS.Lylibs.FileVersionManager.Instance:CreateDifferenceList(function() self:judgeDownload() end)
            elseif(data.stepIndex == 3)then                                             -- 资源文件配置正在下载中
                -- 暂不做表现
                -- data.downloadedCount
                -- data.maxCount
                -- data.downloadedKbSize
                -- data.maxKbSize
            elseif(data.stepIndex == 4)then                                            -- 下载资源文件配置出错
                self.m_errorCall(downLoadMgr.startReadFileList, downLoadMgr, true, updateRes.ErrorCode.ServerFileListError)
            elseif(data.stepIndex == 5)then                                            -- 下载资源文件配置完成，但文件不存在
                self.m_errorCall(downLoadMgr.startReadFileList, downLoadMgr, true, updateRes.ErrorCode.ServerFileListMiss)
            elseif(data.stepIndex == 6)then                                            -- 下载资源文件配置完成，检查资源文件配置成功
                web.WebController:reqReportStep(web.REPORT_STEP.COMPARE_ASSETS_FINISH)
                if(download.ResDownLoadManager:getIsNeedCheckZip())then
                    local initZipDownManger = nil
                    local rsyncZipDifferentFileData = nil
                    rsyncZipDifferentFileData = function()
                        download.ResDownLoadManager:rsyncZipDifferentFileData(function(resultCode)
                            if(resultCode == 0)then
                                CS.Lylibs.FileVersionManager.Instance:CreateDifferenceList(function() self:judgeDownload() end)
                            else
                                self.m_errorCall(function()
                                    self:__removeAlertView()
                                    initZipDownManger()
                                end, self, nil, string.format("%s(%s)", updateRes.ErrorCode.ZipConfigDownLoadError, tostring(resultCode)))
                            end
                        end)
                    end

                    initZipDownManger = function()
                        download.ResDownLoadManager:initZipDownManger(function(resultCode)
                            if(resultCode == 0)then
                                rsyncZipDifferentFileData()
                            else
                                self.m_errorCall(function()
                                    self:__removeAlertView()
                                    initZipDownManger()
                                end, self, nil, string.format("%s(%s)", updateRes.ErrorCode.ZipInitError, tostring(resultCode)))
                            end
                        end)
                    end
                    initZipDownManger()
                else
                    CS.Lylibs.FileVersionManager.Instance:CreateDifferenceList(function() self:judgeDownload() end)
                end
            end
        elseif (state == download.ResState.DownloadFilesSuc) then               -- 资源下载成功
            for i = 1, #data.moduleTypeList do
                local moduleType = data.moduleTypeList[i]
                gs.AssetsUtils:CheckDelMatchSign(moduleType)
            end
            self:judgeDownload()
        elseif (state == download.ResState.DownloadFilesFail) then               -- 资源下载失败
            local checkDownloadClean = function()
                local result = download.ResDownLoadManager:cancelAllDownloadingAssets()
                if(result)then
                    LoopManager:removeTimerByIndex(self.mCheckDownloadCleanSn)
                    self.mCheckDownloadCleanSn = nil

                    updateRes.ShowAlert(updateRes.TipType.Normal, "更新提示", "网络下载出错请重新下载，提示码：" .. updateRes.ErrorCode.ServerResError
                    ,"确认",
                    function()
                        self:judgeDownload()
                    end
                    -- ,"取消",
                    -- function()
                    -- end
                    )
                end
            end
            if(self.mCheckDownloadCleanSn)then
                LoopManager:removeTimerByIndex(self.mCheckDownloadCleanSn)
            end
            self.mCheckDownloadCleanSn = LoopManager:addTimer(1, 0, self, checkDownloadClean)
        end
    end
end

function resetDownload(self)
    self.mIsForceUpdateAll = nil
    self.mIsFirstSizeTip = nil
    self.mIsCheckMatchSign = nil
    download.ResDownLoadManager:setDownLoadModuleTypeList(nil, nil, nil)
    download.ResDownLoadManager:setDownLoadModuleSizeDic(nil, nil)
    CS.Lylibs.DownloadFileVo.byteArrayPool:Dispose()
end

-- 下载判断
function judgeDownload(self)
    local checkDownLoadModule = function()
        self:__removeAlertView()

        if(download.ResDownLoadManager:getIsNeedCheckZip())then
            local function progressCall(state, downloadedCount, totalCount, downloadedSize, totalSize)
                self.mLoadingView:updateZipView(nil, nil, state, downloadedCount, totalCount, downloadedSize, totalSize)
            end
            local function successCall(resultCode)
                self.mLoadingView:updateZipView(resultCode, nil, nil, nil, nil, nil, nil)
            end
            local function failCall(resultCode)
                self.mLoadingView:updateZipView(nil, resultCode, nil, nil, nil, nil, nil)
            end
            download.ResDownLoadManager:startDownloadZip(progressCall, successCall, failCall)
            return
        end

        local downLoadModuleList, totalNeedSize, matchSignModuleTypeList = download.ResDownLoadManager:getDownLoadModuleTypeList()
        if(not self.mIsCheckMatchSign)then
            self.mIsCheckMatchSign = true
            -- 主动检查 启动时必要资源的匹配版本标识
            gs.AssetsUtils:CheckAddMatchSign(matchSignModuleTypeList)
        end
        for i = 1, #downLoadModuleList do
            local moduleType = tonumber(downLoadModuleList[i])
            if(download.ResDownLoadManager:isModuleAssetsNeedUpdate({moduleType}))then
                print("准备下载资源: " .. download.GetModuleName(moduleType))
                download.ResDownLoadManager:readyDownloadList({moduleType}, 0, 50)
                return
            end
        end
        
        web.WebController:reqReportStep(web.REPORT_STEP.DOWNLOAD_ASSETS_FINISH)
        print("保存版本")
        download.ResDownLoadManager:saveVersion()                                   -- 保存版本
        web.WebController:reqReportStep(web.REPORT_STEP.SAVE_VERSION_FINISH)

        self:resetDownload()

        -- 事后清理掉ZipGameRes目录
        gs.AssetsUtils:AddCleanResSign(false, true)
    end

    local checkDownLoadSizeTip = function()
        if(not self.mIsFirstSizeTip)then
            self.mIsFirstSizeTip = true
            -- 判断是否服务器通知游戏中需要更新的状态，是则更新完后重启游戏加载
            if(GameManager and GameManager:getGameState() == 3)then
                updateRes.UpdateResManager:setIsNeedRestart(true)
                if(login and login.LoginManager)then
                    login.LoginManager:setIsLoginPreLoaded(false)
                end
            end
    
            -- 判断本次是否需要更新 和 更新需下载的总量
            local downLoadModuleList = {}
            local matchSignModuleTypeList = {}
            
            -- 固定顺序判断
            if(download.ResDownLoadManager:isModuleAssetsNeedUpdate({download.ModuleType.LUA}))then
                table.insert(downLoadModuleList, download.ModuleType.LUA)
                table.insert(matchSignModuleTypeList, download.ModuleType.LUA)
            end
            if(download.ResDownLoadManager:isModuleAssetsNeedUpdate({download.ModuleType.CORE}))then
                table.insert(downLoadModuleList, download.ModuleType.CORE)
                table.insert(matchSignModuleTypeList, download.ModuleType.CORE)
            end
            if(download.ResDownLoadManager:isModuleAssetsNeedUpdate({download.ModuleType.UPDATE_RES}))then
                table.insert(downLoadModuleList, download.ModuleType.UPDATE_RES)
                table.insert(matchSignModuleTypeList, download.ModuleType.UPDATE_RES)
            end
            if(download.ResDownLoadManager:isModuleAssetsNeedUpdate({download.ModuleType.COMMON}))then
                table.insert(downLoadModuleList, download.ModuleType.COMMON)
                table.insert(matchSignModuleTypeList, download.ModuleType.COMMON)
            end

            -- 其余自动判断
            local assetsDic = download.ResDownLoadManager:getAssetsConfigDic()
            for moduleType in pairs(assetsDic) do
                if(moduleType ~= download.ModuleType.LUA and moduleType ~= download.ModuleType.CORE and moduleType ~= download.ModuleType.UPDATE_RES and moduleType ~= download.ModuleType.COMMON)then
                    local data = assetsDic[moduleType]
                    if(data.startup_auto_update == 1)then
                        if(download.ResDownLoadManager:isModuleAssetsNeedUpdate({moduleType}))then
                            table.insert(downLoadModuleList, moduleType)
                        end
                    else
                        local isCheckModule = download.ResDownLoadManager:getModuleAssetsSign(moduleType)
                        if(self.mIsForceUpdateAll or isCheckModule)then
                            local isNeedUpdate = download.ResDownLoadManager:isModuleAssetsNeedUpdate({moduleType})
                            if(isNeedUpdate)then
                                table.insert(downLoadModuleList, moduleType)
                            end
                        end
                    end
                end
            end
    
            self.mLoadingView:removePrepareProgressTimerHandler()
            if(#downLoadModuleList > 0 or download.ResDownLoadManager:getIsNeedCheckZip())then
                -- 打开热更时要显示的定时轮播图
                BoardShower:addBoardAction()
    
                if (not updateRes.UpdateResManager:getIsNeedRestart()) then
                    -- 有资源更新变动时直接每次更新必须重启游戏
                    updateRes.UpdateResManager:setIsNeedRestart(true)
                    if(login and login.LoginManager)then
                        login.LoginManager:setIsLoginPreLoaded(false)
                    end
                end
    
                local totalNeedSize = 0
                for i = 1, #downLoadModuleList do
                    local moduleType = downLoadModuleList[i]
                    local moduleNeedSize = download.ResDownLoadManager:getModuleAssetsSize({moduleType})
                    totalNeedSize = totalNeedSize + moduleNeedSize
                    download.ResDownLoadManager:setDownLoadModuleSizeDic(moduleType, moduleNeedSize)
                end
                download.ResDownLoadManager:setDownLoadModuleTypeList(downLoadModuleList, totalNeedSize, matchSignModuleTypeList)
                
                local totalNeedZipSize = 0
                local totalZipNeedFreeSize = 0
                if(download.ResDownLoadManager:getIsNeedCheckZip())then
                    totalNeedZipSize, totalZipNeedFreeSize = download.ResDownLoadManager:getZipSize()
                end

                local function confirmDownload()
                    local isHasNetWork, isMobileNet, isWifi = web.getNetStatus()
                    if(isWifi)then
                        checkDownLoadModule()
                    else
                        -- 按照杰明，统一每次都提示
                        local minKB = 0
                        if (totalNeedSize + totalNeedZipSize > minKB) then
                            -- local formatSize, unit = download.GetFormatSize(totalNeedSize)
                            -- local formatZipSize, zipUnit = download.GetFormatSize(totalNeedZipSize)
                            -- local tip = "游戏需要更新部分资源(" .. tostring(formatZipSize) .. zipUnit .. " + " .. tostring(formatSize) .. unit .. ")，建议您在wifi环境下更新"
                            local sizeTip = ""
                            local tip = "游戏需要更新部分%s，建议您在wifi环境下更新"
                            local formatTotalSize, totalUnit = download.GetFormatSize(totalNeedSize + totalNeedZipSize)
                            if(totalNeedSize <= 0 and totalNeedZipSize >= 0)then
                                sizeTip = string.format("资源包(%s)", tostring(formatTotalSize) .. totalUnit)
                            elseif(totalNeedSize >= 0 and totalNeedZipSize <= 0)then
                                sizeTip = string.format("资源文件(%s)", tostring(formatTotalSize) .. totalUnit)
                            elseif(totalNeedSize >= 0 and totalNeedZipSize >= 0)then
                                sizeTip = string.format("资源(%s)", tostring(formatTotalSize) .. totalUnit)
                            end
                            updateRes.ShowAlert(updateRes.TipType.Normal, "更新提示", string.format(tip, sizeTip)
                                ,"确认",
                                function()
                                    checkDownLoadModule()
                                end
                                ,"退出",
                                function()
                                    CS.Lylibs.SDKManager.Ins:CloseApplication()
                                end
                            )
                        else
                            checkDownLoadModule()
                        end
                    end
                end

                local freeDiskSpaceMB = gs.SdkManager:GetFreeDiskSpaceMB()
                if(freeDiskSpaceMB > 0 and totalNeedSize + totalZipNeedFreeSize >= freeDiskSpaceMB * 1024)then
                    local tipFormatTotalSize, tipTotalUnit = download.GetFormatSize(totalNeedSize + totalZipNeedFreeSize - freeDiskSpaceMB * 1024)
                    updateRes.ShowAlert(updateRes.TipType.Normal, "更新提示", string.format("资源更新还需要%s，您的磁盘空间可能不足，是否继续下载？", tostring(tipFormatTotalSize) .. tipTotalUnit)
                        ,"确认",
                        function()
                            confirmDownload()
                        end
                        ,"退出",
                        function()
                            CS.Lylibs.SDKManager.Ins:CloseApplication()
                        end
                    )
                else
                    confirmDownload()
                end
            else
                download.ResDownLoadManager:setDownLoadModuleTypeList(nil, nil, nil)
                download.ResDownLoadManager:setDownLoadModuleSizeDic(nil, nil)
                checkDownLoadModule()
            end
        else
            checkDownLoadModule()
        end
    end

    -- 是否渠道包，不是则不提示
    if(web.WebManager:isOfficialApp())then
        checkDownLoadSizeTip()
    else
        if(not self.mIsFirstSizeTip)then
            -- 是否已经下载过静默下载的资源了，是则不提示
            local isForbidAllUpdateTip = true
            local assetsDic = download.ResDownLoadManager:getAssetsConfigDic()
            for moduleType in pairs(assetsDic) do
                if(moduleType ~= download.ModuleType.LUA and moduleType ~= download.ModuleType.CORE and moduleType ~= download.ModuleType.UPDATE_RES and moduleType ~= download.ModuleType.COMMON)then
                    local data = assetsDic[moduleType]
                    if(data.startup_auto_update == 0)then
                        local isCheckModule = download.ResDownLoadManager:getModuleAssetsSign(moduleType)
                        local isNeedUpdate = download.ResDownLoadManager:isModuleAssetsNeedUpdate({moduleType})
                        if(not isCheckModule and isNeedUpdate)then
                            isForbidAllUpdateTip = false
                            break
                        end
                    end
                end
            end
            if(isForbidAllUpdateTip)then
                checkDownLoadSizeTip()
            else
                -- 是否后台控制强制提示
                local time = web.__getTime()
                local url, parasmDic = web.getChannelUpdateTypeUrl()
                local function correctCall(self, webData, jsonObj)
                    print("UpdateResController", string.format("获取cdn资源更新类型->响应，耗时：%s秒", web.__getTime() - time))
                    if(jsonObj == nil)then
                        print("UpdateResController", string.format("获取cdn资源更新类型->提示码：%s", web.TIP_CODE.CDN_UPDATE_TYPE_ERROR))
                        local titleTip = string.format("资源网络异常请重试！提示码：%s", web.TIP_CODE.CDN_UPDATE_TYPE_ERROR)
                        if(string.find(webData, "<html") ~= nil)then
                            titleTip = titleTip .. "，" .. web.CDN_UPDATE_TYPE_SUB_CODE.HTML_CONTENT
                        end
                        UIFactory:alertOK0("网络提示", titleTip, 
                            function() 
                                WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, function(self, errorData, jsonObj) correctCall(self, errorData, nil) end, self, tryCount) 
                            end)
                    else
                        local subCode = web.WebManager:parseChannelUpdateTypeData(webData, jsonObj)
                        if(subCode == web.CDN_UPDATE_TYPE_SUB_CODE.NORMAL)then
                            print("UpdateResController", "获取cdn资源更新类型->成功")
                            -- 运营不配置渠道强更的话后台发送 -1，不弹弹窗，直接下载部分资源（不包含静默下载的）
                            -- 运营配置渠道强更的话后台发送 1，弹出弹窗内容提示可以选择下载全部资源（包含静默下载的）
                            -- 运营配置渠道强更的话后台发送 2，不弹出弹窗，直接下载全部资源（包含静默下载的）
                            if(web.WebManager.web_force_update_type <= 0)then
                                checkDownLoadSizeTip()
                            elseif(web.WebManager.web_force_update_type == 1)then
                                updateRes.ShowAlert(updateRes.TipType.Normal, "更新提示", "当前版本仅能体验部分游戏内容，是否下载完整版？"
                                ,"确认",
                                function()
                                    local url, parasmDic = web.getReportGenericArgsUrl(web.GENERIC_ARGS_REPORT_TYPE.CHANNEL_SELECT_ALL_UPDATE, 1)
                                    WebInterfaceUtil:postAsyncLoop(url, parasmDic, nil, nil, self, nil)
                                    self.mIsForceUpdateAll = true
                                    checkDownLoadSizeTip()
                                end
                                ,"取消",
                                function()
                                    local url, parasmDic = web.getReportGenericArgsUrl(web.GENERIC_ARGS_REPORT_TYPE.CHANNEL_SELECT_ALL_UPDATE, 0)
                                    WebInterfaceUtil:postAsyncLoop(url, parasmDic, nil, nil, self, nil)
                                    checkDownLoadSizeTip()
                                end
                                )
                            elseif(web.WebManager.web_force_update_type == 2)then
                                self.mIsForceUpdateAll = true
                                checkDownLoadSizeTip()
                            else
                                checkDownLoadSizeTip()
                            end
                        else
                            print("UpdateResController", string.format("资源网络异常请重试！提示码：%s，%s", web.TIP_CODE.CDN_UPDATE_TYPE_ERROR, subCode))
                            UIFactory:alertOK0("网络提示", string.format("资源网络异常请重试！提示码：%s，%s", web.TIP_CODE.CDN_UPDATE_TYPE_ERROR, subCode), 
                                function() 
                                    WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, function(self, errorData, jsonObj) correctCall(self, errorData, nil) end, self, tryCount) 
                                end)
                        end
                    end
                end
                WebInterfaceUtil:postAsyncLoop(url, parasmDic, correctCall, function(self, errorData, jsonObj) correctCall(self, errorData, nil) end, self, 3)
            end
        else
            checkDownLoadSizeTip()
        end
    end
end

-- 关闭Loading界面
function onCloseLoadingViewHandler(self, args, dispatcher, selfFun)
    self:__removeEvents()
    self:__removeLoadingView()
end

function onShowLoadingViewHandler(self)
    self:__showLoadingView()
end

-- 取消下载资源
function onCancleDownLoadHandler(self)
    print("取消下载资源")
end

-- 打开Alert界面
function onOpenAlertViewHandler(self, args)
    self:__showAlertView(args)
end

-- 关闭Alert界面
function onCloseAlertViewHandler(self, args)
    self:__removeAlertView()
end

------------------------------------------------------------Loading-------------—------------------------------
-- 显示Loading界面
function __showLoadingView(self)
    if self.mLoadingView == nil then
        self.mLoadingView = updateRes.UpdateResLoadingView.new()
        self.mLoadingView:open()
    end
end

-- 移除Loading界面
function __removeLoadingView(self)
    if self.mLoadingView then
        self.mLoadingView:close()
        self.mLoadingView:destroy()
        self.mLoadingView = nil
    end
    self:__removeAlertView()
end

------------------------------------------------------------Alert-------------—------------------------------
-- 显示Alert界面
function __showAlertView(self, data)
    if self.m_alertView == nil then
        self.m_alertView = updateRes.UpdateResAlertView.new()
    end
    self.m_alertView:open()
    self.m_alertView:setData(data)
end

-- 移除Alert界面
function __removeAlertView(self)
    if self.m_alertView then
        self.m_alertView:close()
        self.m_alertView:destroy()
        self.m_alertView = nil
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
