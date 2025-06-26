module("download.ResDownLoadManager", Class.impl("lib.event.EventDispatcher"))

----------------------------响应-----------------------------
-- 资源下载状态更新
RES_STATE_UPDATE = "RES_STATE_UPDATE"

-- 静默下载进度更新
UPDATE_SUB_DOWNLOAD_PROGRESS = "UPDATE_SUB_DOWNLOAD_PROGRESS"
-- 静默下载整理更新
UPDATE_SUB_DOWNLOAD_MOVE = "UPDATE_SUB_DOWNLOAD_MOVE"
-- 静默下载成功结果更新
UPDATE_SUB_DOWNLOAD_RESULT_SUCCESS = "UPDATE_SUB_DOWNLOAD_RESULT_SUCCESS"
-- 静默下载失败结果更新
UPDATE_SUB_DOWNLOAD_RESULT_FAIL = "UPDATE_SUB_DOWNLOAD_RESULT_FAIL"

--构造函数
function ctor(self)
    super.ctor(self)
    self.m_isEditor = CS.Lylibs.ApplicationUtil.IsEditorRun
    self.m_cSharpAssetsUtils = CS.Lylibs.AssetsUtils.Instance
    self.m_cSharpDownloadManager = CS.Lylibs.DownloadManager.Instance
    self.m_cSharpResDownloadMgr = CS.Lylibs.ResDownLoadManager.Instance
    self.m_cSharpFileVersionMgr = CS.Lylibs.FileVersionManager.Instance
    self.m_cSharpZipDownLoadMgr = CS.Lylibs.ZipDownLoadManager
end

-- 数据初始化
function init(self)
    if(not self:__getPermission())then
        return
    end
    -- 热更的状态
    self.m_state = nil
    -- 热更的状态参数
    self.m_data = nil
    -- 热更的模块列表和大小列表，给热更界面做进度条百分比用
    self.m_totalNeedSize = 0
    self.m_moduleTypeList = {}
    self.m_moduleSizeDic = {}
end

-- 开始数据初始化加载
function start(self)
    if(not self:__getPermission())then
        return
    end

    self.m_cSharpAssetsUtils:Init(web.WebManager.res_split_type, nil)
    self.m_cSharpResDownloadMgr:Init()
end

function __getPermission(self)
    if(self.m_isEditor or not web.WebManager.run_update_code)then
        return false
    end
    return true
end

-- 回调热更的状态以及传送相关参数
function setResState(self, updateState, data)
    self.m_state = updateState
    if(self.m_state == download.ResState.Init)then
        self.m_data = data
    elseif(self.m_state == download.ResState.ReadLocalVersion)then
        self.m_data = data
    elseif(self.m_state == download.ResState.ReadCdnVersion) then
        self.m_data = data
    elseif(self.m_state == download.ResState.CompareVersion) then
        self.m_data = data
    elseif(self.m_state == download.ResState.CompareAssetVersion)then
        self.m_data.stepIndex = data[1]
        self.m_data.downloadedCount = data[2]
        self.m_data.maxCount = data[3]
        self.m_data.downloadedKbSize = data[4]
        self.m_data.maxKbSize = data[5]
    elseif(self.m_state == download.ResState.DownloadFiles)then
        self.m_data = {}
        self.m_data.moduleTypeList = {data[1]}
        self.m_data.downloadedCount = data[2]
        self.m_data.maxCount = data[3]
        self.m_data.downloadedKbSize = data[4]
        self.m_data.maxKbSize = data[5]
    elseif(self.m_state == download.ResState.DownloadFilesMove)then
        self.m_data = {}
        self.m_data.moduleTypeList = {data[1]}
        self.m_data.movedCount = data[2]
        self.m_data.moveTotalCount = data[3]
    elseif(self.m_state == download.ResState.DownloadFilesSuc)then
        self.m_data = {}
        self.m_data.moduleTypeList = {data[1]}
    elseif(self.m_state == download.ResState.DownloadFilesFail)then
        self.m_data = {}
        self.m_data.moduleTypeList = data
    elseif(self.m_state == download.ResState.SaveVersion)then
        self.m_data = {}
    elseif(self.m_state == download.ResState.Finished)then
        self.m_data = {}
    else
        self.m_data = {}
    end
    self:dispatchEvent(self.RES_STATE_UPDATE)

    self:updateDownLoadTask()
end

function getUpdateState(self)
    return self.m_state
end

function getUpdateData(self)
    return self.m_data
end

function setDownLoadModuleTypeList(self, moduleTypeList, allModuleSize, matchSignModuleTypeList)
    if(moduleTypeList == nil and allModuleSize == nil and matchSignModuleTypeList == nil)then
        self.m_moduleTypeList = {}
        self.m_totalNeedSize = 0
        self.m_matchSignModuleTypeList = {}
    else
        self.m_moduleTypeList = moduleTypeList
        self.m_totalNeedSize = allModuleSize
        self.m_matchSignModuleTypeList = matchSignModuleTypeList
    end
end

function getDownLoadModuleTypeList(self)
    return self.m_moduleTypeList, self.m_totalNeedSize, self.m_matchSignModuleTypeList
end

function setDownLoadModuleSizeDic(self, moduleType, size)
    if(moduleType == nil and size == nil)then
        self.m_moduleSizeDic = {}
    else
        self.m_moduleSizeDic[moduleType] = size
    end
end

function getDownLoadModuleSizeDic(self)
    return self.m_moduleSizeDic
end

-- 获取资源配置字典
function getAssetsConfigDic(self)
    if(not self.m_assetsJsonDic)then
        local jsonStr = self.m_cSharpAssetsUtils:GetJsonStr()
        local jsonList = JsonUtil.decode(jsonStr)
        self.m_assetsJsonDic = {}
        for i = 1, #jsonList do
            local jsonItemData = jsonList[i]
            self.m_assetsJsonDic[jsonItemData.module_type] = jsonItemData
        end
    end
    return self.m_assetsJsonDic or {}
end

-- 设置是否需要更新的状态
function setIsNeedRunUpdate(self, isNeed)
    if(not self:__getPermission())then
        return
    end
    self.m_cSharpResDownloadMgr.IsNeedRunUpdate = isNeed
end

-- 获取是否需要更新的状态
function getIsNeedRunUpdate(self)
    if(not self:__getPermission())then
        return false
    end
    return self.m_cSharpResDownloadMgr.IsNeedRunUpdate
end

-- 设置是否需要登录sdk的状态
function setIsNeedLoginSdk(self, isNeed)
    if(self.m_isEditor)then
        return
    end
    self.m_cSharpResDownloadMgr.IsNeedLoginSdk = isNeed
end

-- 获取是否需要登录sdk的状态
function getIsNeedLoginSdk(self)
    if(self.m_isEditor)then
        return false
    end
    return self.m_cSharpResDownloadMgr.IsNeedLoginSdk
end

-- 清理资源（清理后需会先解压包内资源，完成后才回调）
function cleanGameRes(self, callFun)
    if(not self:__getPermission())then
        return
    end
    self.m_cSharpResDownloadMgr:CleanGameRes(callFun)
end

-- 设置资源下载链接
function setResDownLoadUrl(self, url)
    if(not self:__getPermission())then
        return
    end
    url = string.deleteSpaces(url)
    if (self.m_cSharpResDownloadMgr.ResCdnUrl == "") then
        self.m_cSharpResDownloadMgr.ResCdnUrl = url
        print("成功初始化C#层CDN地址：" .. url)
    elseif(self.m_cSharpResDownloadMgr.ResCdnUrl ~= url)then
        self.m_cSharpResDownloadMgr.ResCdnUrl = url
        print("成功更新C#层CDN地址：" .. url)
    else
        print("C#层CDN地址已存在不需初始化：" .. self.m_cSharpResDownloadMgr.ResCdnUrl)
    end
end

-- 开始读取客户端版本
function startReadLocalVersion(self)
    if(not self:__getPermission())then
        return
    end
    self.m_cSharpResDownloadMgr:StartReadLocalVersion()
end

-- 开始读取cdn版本
function startReadCdnVersion(self, callFun)
    if(not self:__getPermission())then
        return
    end
    self.m_cSharpResDownloadMgr:StartReadCdnVersion(callFun)
end

-- 开始检查对比版本号
function compareVersion(self)
    if(not self:__getPermission())then
        return
    end
    self.m_cSharpResDownloadMgr:CompareVersion()
end

-- 检查资源列表文件
function startReadFileList(self, isReDownload)
    if(not self:__getPermission())then
        return
    end
    self.m_cSharpResDownloadMgr:StartReadFileList(isReDownload or false)
end

-- 添加指定模块类型列表的资源下载任务
function addDownLoadTask(self, moduleTypeList)
    if(not self:__getPermission())then
        return
    end
    if(self.m_isEditor or not web.WebManager.run_update_code)then
        return
    end
	local isNeedUpdate = self:isModuleAssetsNeedUpdate(moduleTypeList)
    if(isNeedUpdate)then
        if(not self.m_taskList)then
            self.m_taskList = {}
        end
        self:removeDownLoadTask(moduleTypeList)
        for _, moduleType in pairs(moduleTypeList) do
            for __, taskData in pairs(self.m_taskList) do
                if(table.indexof(taskData.moduleTypeList, moduleType) ~= false)then
                    print("资源下载模块任务列表已包含模块类型" .. tostring(moduleType))
                    return
                end
            end
        end

        local taskData = {}
        taskData.moduleTypeList = moduleTypeList
        taskData.moduleTypeSuccessList = {}
        taskData.moduleTypeFailList = {}
        table.insert(self.m_taskList, taskData)

        local isInUpdate = self:isModuleAssetsDownloading(moduleTypeList)
        if(not isInUpdate)then
            self:readyDownloadList(moduleTypeList)
        end
    end
end

function getDownLoadTaskData(self, moduleTypeList)
    if(not self:__getPermission())then
        return
    end
    if(self.m_isEditor or not web.WebManager.run_update_code)then
        return
    end
    if(self.m_taskList)then
        for i = #self.m_taskList, 1, -1 do
            local taskData = self.m_taskList[i]
            local isSame = true
            if(#taskData.moduleTypeList == #moduleTypeList)then
                for j = 1, #moduleTypeList do
                    if(table.indexof(taskData.moduleTypeList, moduleTypeList[j]) == false)then
                        isSame = false
                        break
                    end
                end
            else
                isSame = false
            end
            if(isSame)then
                if(taskData.downloadedKbSize ~= nil and taskData.downloadMaxKbSize ~= nil and taskData.downloadedCount ~= nil and taskData.downloadMaxCount ~= nil)then
                    return taskData.downloadedKbSize, taskData.downloadMaxKbSize, taskData.downloadedCount, taskData.downloadMaxCount, taskData.movedCount or 0, taskData.moveTotalCount or 0
                end
            end
        end
    end
    return 0, 0, 0, 0, 0, 0
end

function removeDownLoadTask(self, moduleTypeList)
    if(not self:__getPermission())then
        return
    end
    if(self.m_isEditor or not web.WebManager.run_update_code)then
        return
    end
    if(self.m_taskList)then
        for i = #self.m_taskList, 1, -1 do
            local taskData = self.m_taskList[i]
            local isSame = true
            if(#taskData.moduleTypeList == #moduleTypeList)then
                for j = 1, #moduleTypeList do
                    if(table.indexof(taskData.moduleTypeList, moduleTypeList[j]) == false)then
                        isSame = false
                        break
                    end
                end
            else
                isSame = false
            end
            if(isSame)then
                for j = 1, #moduleTypeList do
                    self:cancelDownloadingModuleAssets(moduleTypeList[j], false)
                end
                table.remove(self.m_taskList, i)
                break
            end
        end
    end
end

function removeAllDownLoadTask(self)
    if(not self:__getPermission())then
        return
    end
    if(self.m_isEditor or not web.WebManager.run_update_code)then
        return
    end
    if(self.m_taskList)then
        for i = #self.m_taskList, 1, -1 do
            local taskData = self.m_taskList[i]
            for j = 1, #taskData.moduleTypeList do
                self:cancelDownloadingModuleAssets(taskData.moduleTypeList[j], false)
            end
        end
        self.m_taskList = nil
    end
end

-- 更新指定模块类型的资源下载任务
function updateDownLoadTask(self)
    if(not self:__getPermission())then
        return false
    end
    if(self.m_taskList)then
        local data = self:getUpdateData()
        for i = #self.m_taskList, 1, -1 do
            local taskData = self.m_taskList[i]
            local isSame = true
            if(#taskData.moduleTypeList == #data.moduleTypeList)then
                for j = 1, #data.moduleTypeList do
                    if(table.indexof(taskData.moduleTypeList, data.moduleTypeList[j]) == false)then
                        isSame = false
                        break
                    end
                end
            else
                isSame = false
            end
            if(isSame)then
                local updateState = self:getUpdateState()
                if(updateState == download.ResState.DownloadFiles)then
                    taskData.downloadedKbSize = data.downloadedKbSize
                    taskData.downloadMaxKbSize = data.maxKbSize
                    taskData.downloadedCount = data.downloadedCount
                    taskData.downloadMaxCount = data.maxCount
                    self:dispatchEvent(self.UPDATE_SUB_DOWNLOAD_PROGRESS, taskData)

                elseif(updateState == download.ResState.DownloadFilesMove)then
                    taskData.movedCount = data.movedCount
                    taskData.moveTotalCount = data.moveTotalCount
                    self:dispatchEvent(self.UPDATE_SUB_DOWNLOAD_MOVE, taskData)
                elseif(updateState == download.ResState.DownloadFilesSuc)then
                    for j = 1, #data.moduleTypeList do
                        local moduleType = data.moduleTypeList[j]
                        if(table.indexof(taskData.moduleTypeList, moduleType) ~= false)then
                            table.removebyvalue(taskData.moduleTypeList, moduleType)
                            table.insert(taskData.moduleTypeSuccessList, moduleType)
                        end
                    end
                    if(#taskData.moduleTypeList <= 0)then
                        table.remove(self.m_taskList, i)
                        self:dispatchEvent(self.UPDATE_SUB_DOWNLOAD_RESULT_SUCCESS, taskData)
                    end
                elseif(updateState == download.ResState.DownloadFilesFail)then
                    for j = 1, #data.moduleTypeList do
                        local moduleType = data.moduleTypeList[j]
                        if(table.indexof(taskData.moduleTypeList, moduleType) ~= false)then
                            table.removebyvalue(taskData.moduleTypeList, moduleType)
                            table.insert(taskData.moduleTypeFailList, moduleType)
                        end
                    end
                    if(#taskData.moduleTypeList <= 0)then
                        table.remove(self.m_taskList, i)
                        self:dispatchEvent(self.UPDATE_SUB_DOWNLOAD_RESULT_FAIL, taskData)
                    end
                end
            end
        end
    end
end

-- 设置资源下载线程数量
function setThreadCount(self, threadCount)
    if(not self:__getPermission())then
        return false
    end
    self.m_cSharpResDownloadMgr:SetThreadCount(threadCount or 0)
end

-- 设置资源下载线程总速度（limitSpeed:限速为0时默认不限速下载）
function setThreadLimitSpeed(self, limitSpeed)
    if(not self:__getPermission())then
        return false
    end
    self.m_cSharpDownloadManager.ThreadLimitSpeed = limitSpeed
end

-- 设置回调频率比例
function setFrequencyRatio(self, ratio)
    self.m_cSharpResDownloadMgr:SetFrequencyRatio(ratio or 0.01)
end

-- 准备下载对应类型文件资源，游戏的下载速度大概范围值为下载线程数*限速
-- specialLimitSpeed:限速为0时默认不限速下载（这里默认建议为0，交由总速度动态调速）
-- delayMilliSeconds:线程的延时启动毫秒数
function readyDownloadList(self, moduleTypeList, specialLimitSpeed, delayMilliSeconds, isSetModuleAssetsSign)
    if(not self:__getPermission())then
        return
    end
    if(isSetModuleAssetsSign)then
        for _, moduleType in pairs(moduleTypeList) do
            self:setModuleAssetsSign(moduleType, true)
        end
    end
    self.m_cSharpResDownloadMgr:ReadyDownloadList(specialLimitSpeed or 0, delayMilliSeconds or 20, unpack(moduleTypeList))
end

-- 获取运行的线程数量
function getRunThreadCount(self)
    if(not self:__getPermission())then
        return 0
    end
    return self.m_cSharpDownloadManager:GetRunThreadCount()
end

-- 保存本地版本配置
function saveVersion(self)
    if(not self:__getPermission())then
        return
    end
    self.m_cSharpResDownloadMgr:SaveVersion()
end

-- 根据版本配置的key获取value
function getClientVersionValue(self, key)
    return self.m_cSharpFileVersionMgr:GetClientVersionValue(key)
end

-- 根据版本配置的key获取value
function getServerVersionValue(self, key)
    return self.m_cSharpFileVersionMgr:GetServerVersionValue(key)
end

-- 根据版本配置的key获取value
function getVersionStr(self, version)
    return self.m_cSharpFileVersionMgr:GetVersionStr(tonumber(version))
end

-- 判断指定搜索资源和服务器的是否一致，决定是否需要更新后重启游戏
function isSameAsServer(self, moduleType, checkStr)
    if(not self:__getPermission())then
        return false
    end
    return self.m_cSharpFileVersionMgr:IsSameAsServer(moduleType, checkStr)
end

-- 判断指定模块类型资源是否需要更新
function isModuleAssetsNeedUpdate(self, moduleTypeList)
    if(not self:__getPermission())then
        return false
    end
    local count = self.m_cSharpFileVersionMgr:GetModuleAssetsCount(unpack(moduleTypeList))
    if(count == -1)then
        print("服务器资源列表未包含指定模块类型资源：" .. table.tostring(moduleTypeList))
        return false
    else
        return count > 0
    end
end

-- 获取指定模块类型的资源大小（KB）
function getModuleAssetsSize(self, moduleTypeList)
    if(not self:__getPermission())then
        return 0
    end
    return math.max(0, self.m_cSharpFileVersionMgr:GetModuleAssetsSize(unpack(moduleTypeList)))
end

-- 设置模块资源的更新标识
function setModuleAssetsSign(self, moduleType, result)
    if(not self:__getPermission())then
        return
    end
    StorageUtil:saveBool0('IS_UPDATE_MODULE_ASSETS_' .. tostring(moduleType), result)
end

-- 获取模块资源的更新标识
function getModuleAssetsSign(self, moduleType)
    if(not self:__getPermission())then
        return false
    end
    return StorageUtil:getBool0('IS_UPDATE_MODULE_ASSETS_' .. tostring(moduleType))
end

-- 判断指定模块类型的资源是否正在下载中
function isModuleAssetsDownloading(self, moduleTypeList)
    if(not self:__getPermission())then
        return false
    end
    local isInUpdate = self.m_cSharpResDownloadMgr:IsModuleAssetsDownloading(unpack(moduleTypeList))
    return isInUpdate
end

-- 删除指定模块类型的资源下载（当前模块资源正在解压移动序列化配置时不允许删除）
function delDownloadedModuleAssets(self, moduleType)
    if(not self:__getPermission())then
        return false
    end
    local isInUpdate = self:isModuleAssetsDownloading({moduleType})
    if(isInUpdate)then
        print("资源正在下载，请先取消后删除")
        return false
    else
        return self.m_cSharpResDownloadMgr:DelDownloadedModuleAssets(moduleType)
    end
end

-- 取消所有正在下载的指定模块类型资源（含有模块资源正在解压移动序列化配置时不允许取消）
function cancelAllDownloadingAssets(self, isDelDownload)
    local result1 = self.m_cSharpResDownloadMgr:CancelAllDownloadingAssets(isDelDownload or false)
    local result2 = self.m_cSharpZipDownLoadMgr.Instance:StopDownloadZip()
    return result1 and result2
end

-- 取消正在下载的指定模块类型资源（当前模块资源正在解压移动序列化配置时不允许取消）
function cancelDownloadingModuleAssets(self, moduleType, isDelDownload)
    if(not self:__getPermission())then
        return false
    end
    local isInUpdate = self:isModuleAssetsDownloading({moduleType})
    if(isInUpdate)then
        return self.m_cSharpResDownloadMgr:CancelDownloadingModuleAssets(moduleType, isDelDownload or false)
    else
        print("没有下载指定模块类型资源的线程可取消")
        return false
    end
end

-- 初始化zip下载管理器模块
function initZipDownManger(self, call)
    return self.m_cSharpZipDownLoadMgr.Instance:Init(call)
end

function getIsNeedCheckZip(self)
    if(web.WebManager:isOfficialApp())then
        return self.m_cSharpZipDownLoadMgr.Instance:GetIsNeedCheckZip()
    end
end

-- 开始检查初始zip更新下载解压
function startDownloadZip(self, progressCal, successCall, failCall)
    self.m_cSharpZipDownLoadMgr.Instance:StartDownloadZip(progressCal, successCall, failCall)
end

function getZipSize(self)
    local zipSize = math.max(0, self.m_cSharpZipDownLoadMgr.Instance:GetZipSize())
    local needFreeSize = math.max(0, self.m_cSharpZipDownLoadMgr.Instance:GetZipNeedFreeSize())
    return zipSize, needFreeSize
end

function rsyncZipDifferentFileData(self, resultCall)
    return self.m_cSharpZipDownLoadMgr.Instance:RsyncZipDifferentFileData(resultCall)
end

-- 获取下载管理器的当前下载大小
function getDownLoadKbSzie(self, isClear)
    return self.m_cSharpDownloadManager:GetDownLoadKbSzie(isClear)
end

function getZipDownLoadState(self)
    return self.m_cSharpZipDownLoadMgr.Instance:GetState()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
