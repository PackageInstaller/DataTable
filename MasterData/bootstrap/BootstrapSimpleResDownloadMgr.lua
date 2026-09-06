-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/bootstrap/BootstrapSimpleResDownloadMgr.lua

module("bootstrap.BootstrapSimpleResDownloadMgr", package.seeall)

local BootstrapSimpleResDownloadMgr = class("BootstrapSimpleResDownloadMgr")

local function read_int32(stream)
	local bytes = stream:read(4)

	if not bytes or #bytes < 4 then
		return nil, "Failed to read 4 bytes for int32"
	end

	return string.byte(bytes, 1) + string.byte(bytes, 2) * 256 + string.byte(bytes, 3) * 65536 + string.byte(bytes, 4) * 16777216
end

local function read_int64(stream)
	local low, err = read_int32(stream)

	if not low then
		return nil, err
	end

	local high, err = read_int32(stream)

	if not high then
		return nil, err
	end

	return low + high * 4294967296
end

local function read_string(stream, length)
	if length <= 0 then
		return ""
	end

	local bytes = stream:read(length)

	if not bytes or length > #bytes then
		return nil, "Failed to read string of length " .. length
	end

	return bytes
end

function BootstrapSimpleResDownloadMgr:read_manifest(stream)
	local type_byte = stream:read(1)

	if not type_byte then
		return nil, "Failed to read type byte"
	end

	local type_value = string.byte(type_byte)
	local code = 0
	local err = ""

	if type_value == 1 then
		code, err = read_int32(stream)

		if not code then
			return nil, err
		end

		local msg_len, err = read_int32(stream)

		if not msg_len then
			return nil, err
		end

		if msg_len > 0 then
			local var_4_0, var_4_1 = read_string(stream, msg_len)

			err = var_4_1

			if not var_4_0 then
				return nil, err
			end
		end
	end

	if code ~= 0 then
		return nil
	end

	local manifest = {}

	manifest.FileDict = {}

	local ver_len, err = read_int32(stream)

	if not ver_len then
		return nil, err
	end

	if ver_len > 0 then
		manifest.Version, err = read_string(stream, ver_len)

		if not manifest.Version then
			return nil, err
		end
	end

	local vid_len, err = read_int32(stream)

	if not vid_len then
		return nil, err
	end

	if vid_len > 0 then
		manifest.VersionId, err = read_string(stream, vid_len)

		if not manifest.VersionId then
			return nil, err
		end
	end

	local file_count, err = read_int32(stream)

	if not file_count then
		return nil, err
	end

	for i = 1, file_count do
		local fileItem = {}
		local file_name_len, err = read_int32(stream)

		if not file_name_len then
			return nil, err
		end

		fileItem.File, err = read_string(stream, file_name_len)

		if not fileItem.File then
			return nil, err
		end

		fileItem.MD5, err = read_string(stream, 32)

		if not fileItem.MD5 then
			return nil, err
		end

		fileItem.Size, err = read_int64(stream)

		if not fileItem.Size then
			return nil, err
		end

		local dir_len, err = read_int32(stream)

		if not dir_len then
			return nil, err
		end

		fileItem.Dir, err = read_string(stream, dir_len)

		if not fileItem.Dir then
			return nil, err
		end

		manifest.FileDict[fileItem.File] = fileItem
	end

	return manifest
end

function BootstrapSimpleResDownloadMgr:ctor()
	self._http = require("socket.http")
	self._json = require("cjson")
	self._isLocalFileNeedUpdate = false
	self._FileExtendName = ".data"
	self._FMOD_ASSETBUNDLE_PATH = "audio/fmod/"
	self._FMOD_AssetsName = ".assets"
	self._FMOD_StreamsName = ".streams"
	self._FMOD_ExtendName = ".bank"
	self._LocalResRootPath = Framework.FileUtils.Instance.LocalResRootPath
	self._md5FilePath = self._LocalResRootPath .. "6a298f0958e31d5580515c1d97981909"
	self._manifestFilePath = self._LocalResRootPath .. "simple_manifest.bin"
	self._hotversionIdFilePath = self._LocalResRootPath .. "simple_hotversionid.bin"
	self._mainHostUrl = ""
	self._projectPath = ""
	self._isABMode = Framework.ResourceCache.Instance.resLoadMode == Framework.ResourceLoadMode.AssetBundle
	self._speedupDownloadHashset = {}
	self._downLoadTaskList = {}
	self._currDownTask = nil

	self:OpenLuaSocket()
end

function BootstrapSimpleResDownloadMgr:regSuccessCallBack(handler, handlerObj)
	self._onlineResUpdateCompleteHandler = handler
	self._onlineResUpdateCompleteHandlerObj = handlerObj
end

function BootstrapSimpleResDownloadMgr:download(url, output_file_path, successCB, errorCB)
	coroutine.start(function()
		local response_body, status_code, response_headers, status_message = self._http.request(url)
		local file, err = io.open(output_file_path, "wb")

		if not file then
			forcePrint("Error: Unable to open file for writing:", output_file_path, err)

			if errorCB then
				errorCB()
			end

			return
		end

		file:write(response_body)
		file:close()

		if successCB then
			successCB()
		end
	end)
end

function BootstrapSimpleResDownloadMgr:downloadWithWWW(url, successCB, errorCB)
	local co = coroutine.start(function()
		local www = UnityEngine.WWW.New(url)

		while not www.isDone do
			coroutine.wait(0)
		end

		if www.isDone then
			if string.nilorempty(www.error) then
				if successCB then
					successCB(www)
				end
			elseif errorCB then
				errorCB()
			end
		end
	end)
end

function BootstrapSimpleResDownloadMgr:OpenLuaSocket()
	require("tolua.reflection")

	local luaClientType = System.Type.GetType("LuaClient")

	if luaClientType == nil then
		printError("无法找到LuaClient类型")

		return
	end

	local openLuaSocketMethod = tolua.gettypemethod(luaClientType, "OpenLuaSocket", 36)

	if openLuaSocketMethod == nil then
		printError("无法获取OpenLuaSocket方法")

		return
	end

	local instanceProperty = tolua.getproperty(luaClientType, "Instance")

	if instanceProperty == nil then
		printError("无法获取LuaClient.Instance属性")

		return
	end

	local luaClientInstance = instanceProperty:Get(nil, nil)

	if luaClientInstance == nil then
		printError("LuaClient.Instance为空")

		return
	end

	openLuaSocketMethod:Call(luaClientInstance)
end

function BootstrapSimpleResDownloadMgr:openManifestFile()
	local file, err = io.open(self._manifestFilePath, "rb")

	if not file then
		print("Error opening file:", err)

		return false
	end

	local manifest, error_msg = self:read_manifest(file)

	file:close()

	if not manifest then
		print("Error reading manifest:", error_msg)

		return false
	else
		self._FileDict = manifest.FileDict
		self._hasDownLoadMap = {}

		local file, err = io.open(self._md5FilePath, "r")

		if file then
			local jsonStr = file:read("*a")

			file:close()

			local obj
			local var_12_0 = (not string.nilorempty(jsonStr) and self._json.decode(jsonStr) or {}).fileNames

			if not (not string.nilorempty(jsonStr) and self._json.decode(jsonStr) or {}).fileNames then
				local fileNames = {}

				for i, v in ipairs(fileNames) do
					self._hasDownLoadMap[v] = true
				end

				print(">>>>>>>>>找到文件 处理成功")
			end
		else
			forcePrint(">>>>>>>>>找不到文件", self._md5FilePath, err)
		end

		self:hookGetRes()

		return true
	end
end

function BootstrapSimpleResDownloadMgr:UpateLocalToRemoteData(fileName)
	self._isLocalFileNeedUpdate = true
	self._hasDownLoadMap[fileName] = true

	Framework.HotUpdate.VersionMgr.Instance:UpdateLocalCacheData(fileName)
	self:TrySaveLocalManifestData()
end

function BootstrapSimpleResDownloadMgr:TrySaveLocalManifestData()
	if self._isLocalFileNeedUpdate then
		self._isLocalFileNeedUpdate = false

		Framework.HotUpdate.VersionMgr.Instance:SaveLocalCacheVersionData()
	end
end

local rescache = Framework.ResourceCache.Instance

function BootstrapSimpleResDownloadMgr:hookGetRes()
	local function originGetRes(tem)
		rescache:GetResource(tem.resPath, tem.handler, tem.handlerObj, tem.resType, tem.isPreload)
	end

	function getres(resPath, handler, handlerObj, resType, isPreload)
		resType = resType or 0

		if isPreload == nil then
			isPreload = true
		end

		local fileName = resPath

		if resType == 0 then
			fileName = fileName .. self._FileExtendName
		end

		if self._hasDownLoadMap[fileName] then
			rescache:GetResource(resPath, handler, handlerObj, resType, isPreload)
		else
			self:_createDownloadTask(fileName, resPath, handler, handlerObj, resType, isPreload, originGetRes)
		end
	end

	setglobal("getres", getres)
	forcePrint(">>>>重新注册 getres 成功")

	if self._onlineResUpdateCompleteHandler and self._onlineResUpdateCompleteHandlerObj then
		self._onlineResUpdateCompleteHandler(self._onlineResUpdateCompleteHandlerObj)
	end
end

function BootstrapSimpleResDownloadMgr:_createDownloadTask(fileName, resPath, handler, handlerObj, resType, isPreload, callBack)
	if self._speedupDownloadHashset[fileName] then
		return
	end

	local item = self._FileDict[fileName]

	self._speedupDownloadHashset[fileName] = true

	local res = {}

	res.resPath = resPath
	res.handler = handler
	res.handlerObj = handlerObj
	res.resType = resType
	res.isPreload = isPreload
	res.fileName = fileName
	res.url = string.format("%s/%s/%s/%s", self._mainHostUrl, self._projectPath, item.Dir, fileName)
	res.savePath = self._LocalResRootPath .. fileName

	table.insert(self._downLoadTaskList, res)
	self:_tryDownLoadNext(callBack)
end

function BootstrapSimpleResDownloadMgr:_tryDownLoadNext(callBack)
	if self._currDownTask == nil and #self._downLoadTaskList > 0 then
		local res = table.remove(self._downLoadTaskList, 1)

		if res then
			self._currDownTask = res

			self:downloadWithWWW(res.url, function(www)
				Framework.FileUtils.Instance:DeleteFile(self._currDownTask.savePath)
				Framework.FileUtils.Instance:WriteFile(www.bytes, self._currDownTask.savePath)
				self:UpateLocalToRemoteData(res.fileName)

				if callBack then
					callBack(res)
				end

				self._currDownTask = nil

				self:_tryDownLoadNext()
			end, function()
				self._hasDownLoadMap[res.resPath] = true

				callBack(res)

				self._currDownTask = nil

				self:_tryDownLoadNext()
			end)
		end
	end
end

function BootstrapSimpleResDownloadMgr:CheckAndDownloadBankAssetsWithEvtName(fmodMgr, evtName)
	if self._isABMode then
		local bankName = fmodMgr:GetBankNameByEvent(evtName)

		return self:CheckAndDownloadBankAssets(bankName)
	end

	return true
end

function BootstrapSimpleResDownloadMgr:CheckAndDownloadBankAssets(bankName)
	if self._isABMode and not string.nilorempty(bankName) then
		local fileName1 = self._FMOD_ASSETBUNDLE_PATH .. bankName .. self._FMOD_ExtendName
		local fileName2 = self._FMOD_ASSETBUNDLE_PATH .. bankName .. self._FMOD_AssetsName .. self._FMOD_ExtendName
		local fileName3 = self._FMOD_ASSETBUNDLE_PATH .. bankName .. self._FMOD_StreamsName .. self._FMOD_ExtendName

		if not self._hasDownLoadMap[fileName1] then
			self:_createDownloadTask(fileName1, fileName1, nil, nil, 1, false, nil)

			return false
		end

		if not self._hasDownLoadMap[fileName2] then
			self:_createDownloadTask(fileName2, fileName2, nil, nil, 1, false, nil)

			return false
		end

		if not self._hasDownLoadMap[fileName3] then
			self:_createDownloadTask(fileName3, fileName3, nil, nil, 1, false, nil)

			return false
		end
	end

	return true
end

function BootstrapSimpleResDownloadMgr:GetRemoteVersion(url, url_bak, deviceId, gameId, sdkType, zoneId, packageName, packageVersionCode, platformId, channelId, cochannelId, hotVersion, hotVersionId)
	local paramsStr = "?" .. "deviceId=" .. deviceId .. "&" .. "gameId=" .. gameId .. "&" .. "sdkType=" .. sdkType .. "&" .. "zoneId=" .. zoneId .. "&" .. "packageName=" .. packageName .. "&" .. "packageVersionCode=" .. packageVersionCode .. "&" .. "platformId=" .. platformId .. "&" .. "channelId=" .. channelId .. "&" .. "cochannelId=" .. cochannelId .. "&" .. "hotVersion=" .. hotVersion .. "&" .. "hotVersionId=" .. hotVersionId
	local api = "/open-api/version/manifest/v2"
	local versionManifestUrl = url .. api .. paramsStr

	forcePrint("开始请求version：", versionManifestUrl)
	self:downloadWithWWW(versionManifestUrl, function(www)
		local jsonStr = www.text
		local obj
		local var_25_0 = (not string.nilorempty(jsonStr) and self._json.decode(jsonStr) or {}).data

		if not (not string.nilorempty(jsonStr) and self._json.decode(jsonStr) or {}).data then
			local data = {}

			if not data.hosts then
				local hosts = {}
				local targetVersion = data.hotVersion
				local save_hotVersionId = data.hotVersionId

				self._mainHostUrl = hosts[1]
				self._projectPath = data.projectPath

				print("mainHostUrl:", self._mainHostUrl, "projectPath:", self._projectPath)

				local file, err = io.open(self._hotversionIdFilePath, "r")

				if not file then
					print("第一次下载")
					self:GetRemoteManifest(url, url_bak, deviceId, gameId, sdkType, zoneId, packageName, packageVersionCode, platformId, channelId, cochannelId, hotVersion, hotVersionId, targetVersion, save_hotVersionId)
				else
					local str = file:read("*a")

					file:close()
					forcePrint("hotVersionId: " .. str)

					if str ~= save_hotVersionId then
						self:GetRemoteManifest(url, url_bak, deviceId, gameId, sdkType, zoneId, packageName, packageVersionCode, platformId, channelId, cochannelId, hotVersion, hotVersionId, targetVersion, save_hotVersionId)
					else
						local success = self:openManifestFile()

						if not success then
							self:GetRemoteManifest(url, url_bak, deviceId, gameId, sdkType, zoneId, packageName, packageVersionCode, platformId, channelId, cochannelId, hotVersion, hotVersionId, targetVersion, save_hotVersionId)
						end
					end
				end
			end
		end
	end)
end

function BootstrapSimpleResDownloadMgr:GetRemoteManifest(url, url_bak, deviceId, gameId, sdkType, zoneId, packageName, packageVersionCode, platformId, channelId, cochannelId, hotVersion, hotVersionId, targetVersion, save_hotVersionId)
	local paramsStr = "?" .. "deviceId=" .. deviceId .. "&" .. "gameId=" .. gameId .. "&" .. "sdkType=" .. sdkType .. "&" .. "zoneId=" .. zoneId .. "&" .. "packageName=" .. packageName .. "&" .. "packageVersionCode=" .. packageVersionCode .. "&" .. "platformId=" .. platformId .. "&" .. "channelId=" .. channelId .. "&" .. "cochannelId=" .. cochannelId .. "&" .. "hotVersion=" .. hotVersion .. "&" .. "hotVersionId=" .. hotVersionId .. "&" .. "targetVersion=" .. targetVersion
	local api = "/open-api/project/manifest/v2"
	local versionManifestUrl = url .. api .. paramsStr

	forcePrint("开始请求manifest：", versionManifestUrl)
	self:downloadWithWWW(versionManifestUrl, function(www)
		forcePrint("manifestbin下载成功-保存到", self._manifestFilePath)
		Framework.FileUtils.Instance:DeleteFile(self._manifestFilePath)
		Framework.FileUtils.Instance:WriteFile(www.bytes, self._manifestFilePath)
		Framework.FileUtils.Instance:DeleteFile(self._hotversionIdFilePath)
		Framework.FileUtils.Instance:WriteFile(save_hotVersionId, self._hotversionIdFilePath)
		self:openManifestFile()
	end)
end

BootstrapSimpleResDownloadMgr.instance = BootstrapSimpleResDownloadMgr.New()

return BootstrapSimpleResDownloadMgr
