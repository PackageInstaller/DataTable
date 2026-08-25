local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local libmd5 = require("ejoysdk_lua.libs.md5")
local CodeVersion = require("GameLauncher.CodeVersion")
local File = CS.System.IO.File
local Path = CS.System.IO.Path
local Directory = CS.System.IO.Directory
local Z1WebRequest = CS.Z1WebRequest
local persistentDataPath = Utils.GetApplicationPersistenDataPath()
local hotfixFunName = "hotfix"
local hotfixConfigNamespace = "hotfix"
local hotfixFileRemotePath = "trunk/hotfix"
local hotfixFileLocalPath = "hotfix"
local hotfixFailedReason = {downloadError = 1, codeError = 2}
local downloadRetryWaitTime = 3

local function HotfixInfoFileName(version, md5)
  do return string.format, "Hotfix_%s_%s.lua", version end
  return string.format, "Hotfix_%s_%s.lua", version, md5
end

local function HotfixCodeFileName(version, md5)
  do return string.format, "File_%s_%s.lua", version end
  return string.format, "File_%s_%s.lua", version, md5
end

local ClientHotfixManager, Super = System.NewClass("ClientHotfixManager", Manager)

function ClientHotfixManager:ctor()
  Super.ctor(self)
  self.hotfixEnabled = true
  self.hotfixConfigList = {}
  self.downloadAwaiterList = AwaiterList()
  ECC.add_init_namespace(hotfixConfigNamespace)
  
  function self.OnHotfixConfigUpdate(data)
    if data and data.config then
      Logger.Info("[hotfix] 检测到远端hotfix配置更新 | %s", table.tostring(data.config))
      self:NewHotfix(data.config)
    end
  end
  
  ECC.subscribe(hotfixConfigNamespace, self.OnHotfixConfigUpdate)
  
  function self.OnSdkInitSuccess()
    local data = ECC.get_config(hotfixConfigNamespace)
    if data and data.config then
      Logger.Info("[hotfix] 检测到本地hotfix配置缓存 | %s", table.tostring(data.config))
      self:NewHotfix(data.config)
    end
  end
  
  EventMgr.Instance.OnSdkInitSuccess:RegisterEvent(self.OnSdkInitSuccess)
end

function ClientHotfixManager:OnDestroy()
  Super.OnDestroy(self)
  ECC.unsubscribe(hotfixConfigNamespace, self.OnHotfixConfigUpdate)
  EventMgr.Instance.OnSdkInitSuccess:RemoveEvent(self.OnSdkInitSuccess)
  if self.downloadRetryTimer then
    TimerManager.Instance:StopTimer(self.downloadRetryTimer)
    self.downloadRetryTimer = nil
  end
  self.downloadAwaiterList:Reset()
  if self.downloadCompletedAwaiter then
    self.downloadCompletedAwaiter:Recycle()
    self.downloadCompletedAwaiter = nil
  end
end

function ClientHotfixManager:EnableHotfix()
  self.hotfixEnabled = true
end

function ClientHotfixManager:DisableHotfix()
  self.hotfixEnabled = false
end

function ClientHotfixManager:Awake()
  Super.Awake(self)
  self.hotfixVersionData = {}
  self.hotfixData = {}
  self.model = ClientHotfixData
end

function ClientHotfixManager:NewHotfix(config)
  table.insert(self.hotfixConfigList, table.clone(config))
  if 1 == #self.hotfixConfigList then
    self:_ProcessNextHotfix(self.hotfixConfigList)
  end
end

function ClientHotfixManager:_ProcessNextHotfix(configList)
  local config = configList[1]
  local cdnAddress = config.cdnAddress
  local hotfixVer = config.hotfixInfo.version
  local hotfixMd5 = config.hotfixInfo.md5
  Logger.Info("[hotfix] ++++++++++开始处理热修复，版本(%s)++++++++++", hotfixVer)
  if not self.hotfixEnabled then
    Logger.Info("[hotfix] 处理失败！热修复机制未启用。")
    return
  end
  if hotfixVer <= self.model.currentHotfixId then
    Logger.Info("[hotfix] 处理失败！客户端代码版本(%s)已超过热修复版本(%s)。", self.model.currentHotfixId, hotfixVer)
    table.remove(self.hotfixConfigList, 1)
    if #self.hotfixConfigList > 0 then
      self:_ProcessNextHotfix(self.hotfixConfigList)
    end
    return
  end
  self:_ProcessHotfix(cdnAddress, hotfixVer, hotfixMd5, function(success, reason)
    if success then
      Logger.Info("[hotfix] ----------结束处理热修复，版本(%s)----------", hotfixVer)
      table.remove(self.hotfixConfigList, 1)
      if #self.hotfixConfigList > 0 then
        self:_ProcessNextHotfix(self.hotfixConfigList)
      end
    elseif #self.hotfixConfigList > 1 then
      table.remove(self.hotfixConfigList, 1)
      self:_ProcessNextHotfix(self.hotfixConfigList)
    elseif reason == hotfixFailedReason.downloadError then
      Logger.Info("[hotfix] %s秒钟后重试", downloadRetryWaitTime)
      self.downloadRetryTimer = TimerManager.Instance:CreateTimer(downloadRetryWaitTime, 0, nil, function()
        self:_ProcessNextHotfix(self.hotfixConfigList)
      end)
    else
      table.remove(self.hotfixConfigList, 1)
    end
  end)
end

function ClientHotfixManager:_ProcessHotfix(cdnAddress, hotfixVer, hotfixMd5, finishCallback)
  local hotfixInfoFileName = HotfixInfoFileName(hotfixVer, hotfixMd5)
  local hotfixInfoFileLocalPath = persistentDataPath .. "/" .. hotfixFileLocalPath .. "/" .. hotfixInfoFileName
  if File.Exists(hotfixInfoFileLocalPath) then
    self:_DoHotfixInfoFile(hotfixInfoFileLocalPath, hotfixMd5, cdnAddress, finishCallback)
  else
    local hotfixInfoFileUrl = cdnAddress .. "/" .. hotfixFileRemotePath .. "/" .. hotfixInfoFileName
    self:_DownloadFile(hotfixInfoFileUrl, hotfixInfoFileLocalPath, function(success)
      if success then
        self:_DoHotfixInfoFile(hotfixInfoFileLocalPath, hotfixMd5, cdnAddress, finishCallback)
      elseif finishCallback then
        finishCallback(false, hotfixFailedReason.downloadError)
      end
    end)
  end
end

function ClientHotfixManager:_DoHotfixInfoFile(filePath, md5, cdnAddress, finishCallback)
  local hotfixInfos = self:_DoLuaFile(filePath, md5)
  if not hotfixInfos then
    if finishCallback then
      finishCallback(false, hotfixFailedReason.codeError)
    end
    return
  end
  local hotfixCodeFileInfoList = {}
  self.downloadAwaiterList:Reset()
  for _, info in ipairs(hotfixInfos) do
    if not self.hotfixData[info.hotfixId] then
      if info.clientVersion == CodeVersion then
        local hotfixVer = info.hotfixId
        local hotfixMd5 = info.compressedMd5
        local hotfixCodeFileName = HotfixCodeFileName(hotfixVer, hotfixMd5)
        local hotfixCodeFileLocalPath = persistentDataPath .. "/" .. hotfixFileLocalPath .. "/" .. hotfixCodeFileName
        local hotfixCodeFileInfo = {
          localPath = hotfixCodeFileLocalPath,
          version = hotfixVer,
          md5 = hotfixMd5,
          downloaded = false
        }
        table.insert(hotfixCodeFileInfoList, hotfixCodeFileInfo)
        if File.Exists(hotfixCodeFileLocalPath) then
          hotfixCodeFileInfo.downloaded = true
        else
          local awaiter = self.downloadAwaiterList:Add()
          local hotfixCodeFileUrl = cdnAddress .. "/" .. hotfixFileRemotePath .. "/" .. hotfixCodeFileName
          self:_DownloadFile(hotfixCodeFileUrl, hotfixCodeFileLocalPath, function(success)
            hotfixCodeFileInfo.downloaded = success
            awaiter:SetCompleted()
          end)
        end
      else
        Logger.Error("[hotfix] 客户端代码版本(%s)与hotfix(%s)所修复的代码版本(%s)不匹配，无法应用此修复！", CodeVersion, info.hotfixId, info.clientVersion)
      end
    end
  end
  self.downloadCompletedAwaiter = self.downloadAwaiterList:WhenAll()
  self.downloadCompletedAwaiter:OnCompleted(function()
    self.downloadCompletedAwaiter:Recycle()
    self.downloadCompletedAwaiter = nil
    for _, info in ipairs(hotfixCodeFileInfoList) do
      if not info.downloaded then
        if finishCallback then
          finishCallback(false, hotfixFailedReason.downloadError)
        end
        return
      end
    end
    for _, info in ipairs(hotfixCodeFileInfoList) do
      self:_DoHotfixCodeFile(info.localPath, info.version, info.md5)
    end
    if finishCallback then
      finishCallback(true)
    end
  end)
end

function ClientHotfixManager:_DoHotfixCodeFile(localPath, version, md5)
  Logger.Info("[hotfix] 执行热修复 %s", localPath)
  local result = self:_DoLuaFile(localPath, md5)
  if result then
    if self.hotfixVersionData[version] then
      Logger.Warn("[hotfix] 当前热修复已执行过，不需要再次执行，版本(%s)", version)
      return
    end
    self.hotfixVersionData[version] = true
    if version <= self.model.currentHotfixId then
      Logger.Warn("[hotfix] 当前客户端代码版本(%s)已超过热修复版本(%s)", self.model.currentHotfixId, version)
      return
    end
    if self.hotfixData[version] then
      Logger.Warn("[hotfix] 当前hotfixData已更新过，不需要再更新%s", version)
      return
    end
    self.hotfixData[version] = true
    self.model:setHotfixId(version)
    local hotfixFun = result[hotfixFunName]
    if not hotfixFun then
      Logger.Error("[hotfix] 热修复失败！修复文件中找不到修复函数\"%s\"", hotfixFunName)
      return
    end
    local success, msg = pcall(hotfixFun)
    if not success then
      Logger.Error("[hotfix] 热修复失败！ %s", msg)
      return
    end
    Logger.Info("[hotfix] 热修复成功！")
  end
end

function ClientHotfixManager:_DownloadFile(url, savePath, callback)
  Logger.Info("[hotfix] 下载文件 | %s | savePath: %s", url, savePath)
  Z1WebRequest.GetFileBytes(url, function(errorDesc, respCode, bytes)
    if errorDesc then
      Logger.Error("[hotfix] 下载文件失败！获取远端文件内容时发生错误。 | %s | respCode: %s | errorDesc: %s", url, respCode, errorDesc)
      if callback then
        callback(false)
      end
    else
      local dirName = Path.GetDirectoryName(savePath)
      if not Directory.Exists(dirName) then
        Directory.CreateDirectory(dirName)
      end
      File.WriteAllBytes(savePath, bytes)
      Logger.Info("[hotfix] 下载文件成功! | %s | savePath: %s", url, savePath)
      if callback then
        callback(true)
      end
    end
  end)
end

function ClientHotfixManager:_DoLuaFile(filePath, md5)
  if not File.Exists(filePath) then
    Logger.Error("[hotfix] 执行Lua文件失败！文件不存在。 | filePath: %s", filePath)
    return
  end
  local bytes = File.ReadAllBytes(filePath)
  local bytesmd5 = libmd5.sumhexa(bytes)
  if bytesmd5 ~= md5 then
    Logger.Error("[hotfix] 执行Lua文件失败！文件内容md5与预期不符。 | filePath: %s | md5: %s | expected md5: %s", filePath, bytesmd5, md5)
    return
  end
  local fn, err = load(bytes)
  if not fn then
    Logger.Error("[hotfix] 执行Lua文件失败！加载文件内容时发生错误。 | filePath: %s | %s", filePath, err)
    return
  end
  local success, result = pcall(fn)
  if not success then
    Logger.Error("[hotfix] 执行Lua文件失败！执行文件内容时发生错误。 | filePath: %s | %s", filePath, result)
    return
  end
  return result
end

return ClientHotfixManager
