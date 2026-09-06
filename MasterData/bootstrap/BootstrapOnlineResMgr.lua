-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/bootstrap/BootstrapOnlineResMgr.lua

module("bootstrap.BootstrapOnlineResMgr", package.seeall)

local BootstrapOnlineResMgr = class("BootstrapOnlineResMgr")
local res_ID = 0
local STATE_0 = 0
local STATE_1 = 1
local STATE_2 = 2

function BootstrapOnlineResMgr:ctor()
	self._all_call_back_map = {}
	self._all_downloading_map = {}
	self._MGR_STATE = 0

	local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

	if Framework.OSDef.RunOS == Framework.OSDef.Android and versionCode >= 1100 or Framework.OSDef.RunOS == Framework.OSDef.IOS and versionCode >= 1100 then
		self._MGR_STATE = STATE_1
	end
end

function BootstrapOnlineResMgr:initWithOnlineResMgr(url, url_bak, deviceId, gameId, sdkType, zoneId, packageName, packageVersionCode, platformId, channelId, cochannelId)
	local OnlineResUpdateEventType = Framework.OnlineResUpdate.OnlineResUpdateEventType

	self._onlineResUpdateMgr = Framework.OnlineResUpdate.OnlineResUpdateMgr.Instance
	self._versionDataMgr = self._onlineResUpdateMgr.GamePlayLocalCacheVersionDataMgr

	self._onlineResUpdateMgr:AddListener(OnlineResUpdateEventType.LocalVersionCodeSuccess, self._onLocalVersionCodeSuccess, self)
	self._onlineResUpdateMgr:AddListener(OnlineResUpdateEventType.LocalDownloadManifestSuccess, self._onLocalDownloadManifestSuccess, self)
	self._onlineResUpdateMgr:AddListener(OnlineResUpdateEventType.HotManifestFileSuccess, self._onHotManifestFileSuccess, self)
	self._onlineResUpdateMgr:AddListener(OnlineResUpdateEventType.RequestDownloadManifestSuccess, self._onRequestDownloadManifestSuccess, self)
	self._onlineResUpdateMgr:AddListener(OnlineResUpdateEventType.LocalManifestSaveSuccess, self._onLocalManifestSaveSuccess, self)
	self._onlineResUpdateMgr:AddListener(OnlineResUpdateEventType.DeleteAllHotManifestSuccess, self._onDeleteAllHotManifestSuccess, self)
	self._onlineResUpdateMgr:AddListener(OnlineResUpdateEventType.NeedFilesDownloadSuccess, self._onNeedFilesDownloadSuccess, self)
	self._onlineResUpdateMgr:AddListener(OnlineResUpdateEventType.OnlineResUpdateComplete, self._onOnlineResUpdateComplete, self)
	self._onlineResUpdateMgr:AddListener(OnlineResUpdateEventType.ReadManifestFileError, self._onReadManifestFileError, self)
	self._onlineResUpdateMgr:AddListener(OnlineResUpdateEventType.ResDownloadError, self._onResDownloadError, self)
	self._onlineResUpdateMgr:AddListener(OnlineResUpdateEventType.ResDownloadProgress, self._onResDownloadProgress, self)
	self._onlineResUpdateMgr:AddListener(OnlineResUpdateEventType.DownloadFileComplete, self._onDownloadFileComplete, self)
	self._onlineResUpdateMgr:AddListener(OnlineResUpdateEventType.LocalVersionCodeFailed, self._onLocalVersionCodeFailed, self)
	self._onlineResUpdateMgr:CheckAndStartLoadFile(url, url_bak, deviceId, gameId, sdkType, zoneId, packageName, packageVersionCode, platformId, channelId, cochannelId)
end

function BootstrapOnlineResMgr:initWithSimpleResMgr(url, url_bak, deviceId, gameId, sdkType, zoneId, packageName, packageVersionCode, platformId, channelId, cochannelId)
	if Framework.OSDef.isEditor then
		Framework.OnlineResUpdate.OnlineResUpdateMgr.Instance:ForOnlyLocalBundle()
	end

	usingnow("bootstrap.BootstrapSimpleResDownloadMgr", "BootstrapSimpleResDownloadMgr")
	BootstrapSimpleResDownloadMgr.instance:regSuccessCallBack(self._onlineResUpdateCompleteHandler, self._onlineResUpdateCompleteHandlerObj)
	BootstrapSimpleResDownloadMgr.instance:GetRemoteVersion(url, url_bak, deviceId, gameId, sdkType, zoneId, packageName, packageVersionCode, platformId, channelId, cochannelId, "0.0.0", "")
end

function BootstrapOnlineResMgr:CheckAndStartLoadFile(handler, handlerObj)
	self._onlineResUpdateCompleteHandler = handler
	self._onlineResUpdateCompleteHandlerObj = handlerObj

	if Framework.OSDef.isEditor then
		self._MGR_STATE = STATE_1
	end

	local url = ""
	local url_bak = ""
	local deviceId = BootstrapUtil.getImei()
	local gameId = BootstrapUtil.getGameId()
	local sdkType = BootstrapUtil.getHotUpdateDeviceType()
	local zoneId = 1
	local packageName = BootstrapUtil.getGamePackageName()
	local packageVersionCode = BootstrapUtil.getGameVersionCode()
	local platformId = checknumber(BootstrapUtil.getPlatformId())
	local channelId = checknumber(BootstrapUtil.getChannelId())
	local cochannelId = checknumber(BootstrapUtil.getCoChannelId())

	if self._MGR_STATE ~= STATE_0 then
		url = Framework.OnlineResUpdate.OnlineResUpdateDefs.MAIN_URL
		url_bak = Framework.OnlineResUpdate.OnlineResUpdateDefs.BAK_URL

		if CSGameUtil.GetGameConfigUrlType() == 1 then
			url = Framework.OnlineResUpdate.OnlineResUpdateDefs.MAIN_URL_TEST
			url_bak = Framework.OnlineResUpdate.OnlineResUpdateDefs.BAK_URL_TEST
		end
	end

	forcePrint(">>>>>>>>>>>>>BootDWP S:", self._MGR_STATE, "T:", CSGameUtil.GetGameConfigUrlType(), "U:", url, "B", url_bak)
	forcePrint("===============Start Hot DWP====================")
	forcePrint("gameId===>" .. gameId)
	forcePrint("sdkType===>" .. sdkType)
	forcePrint("zoneId===>" .. zoneId)
	forcePrint("packageName===>" .. packageName)
	forcePrint("packageVersionCode===>" .. packageVersionCode)
	forcePrint("platformId===>" .. platformId)
	forcePrint("channelId===>" .. channelId)
	forcePrint("cochannelId===>" .. cochannelId)

	if self._MGR_STATE == STATE_1 then
		self:initWithOnlineResMgr(url, url_bak, deviceId, gameId, sdkType, zoneId, packageName, packageVersionCode, platformId, channelId, cochannelId)
	elseif self._MGR_STATE == STATE_2 then
		self:initWithSimpleResMgr(url, url_bak, deviceId, gameId, sdkType, zoneId, packageName, packageVersionCode, platformId, channelId, cochannelId)
	elseif self._onlineResUpdateCompleteHandler and self._onlineResUpdateCompleteHandlerObj then
		self._onlineResUpdateCompleteHandler(self._onlineResUpdateCompleteHandlerObj)
	end
end

function BootstrapOnlineResMgr:regCallBackByType(type, handler, handlerObj)
	self._all_call_back_map[type] = self._all_call_back_map[type] or {}

	for i, obj in ipairs(self._all_call_back_map[type]) do
		if obj.handler == handler and obj.handlerObj == handlerObj then
			return
		end
	end

	local tem = {}

	tem.handler = handler
	tem.handlerObj = handlerObj

	table.insert(self._all_call_back_map[type], tem)
end

function BootstrapOnlineResMgr:unregCallBackByType(type, handler, handlerObj)
	self._all_call_back_map[type] = self._all_call_back_map[type] or {}

	for i, obj in ipairs(self._all_call_back_map[type]) do
		if obj.handler == handler and obj.handlerObj == handlerObj then
			self._all_call_back_map[type][i] = nil

			return
		end
	end
end

function BootstrapOnlineResMgr:_callFuncByType(type, ...)
	if self._all_call_back_map[type] then
		for i, obj in ipairs(self._all_call_back_map[type]) do
			if obj.handler then
				if obj.handlerObj then
					obj.handler(obj.handlerObj, ...)
				else
					obj.handler(...)
				end
			end
		end
	end
end

function BootstrapOnlineResMgr:regErrorCallBack(handler, handlerObj)
	self._errorHander = handler
	self._errorHanderObj = handlerObj
end

function BootstrapOnlineResMgr:_onReadManifestFileError()
	self:showUITipByState(BootstrapConstdef.EBootstrapState.ReadManifestFileError, "-版本信息读取失败-")

	local OnlineResUpdateEventType = Framework.OnlineResUpdate.OnlineResUpdateEventType

	self:_callFuncByType(OnlineResUpdateEventType.ReadManifestFileError)
end

function BootstrapOnlineResMgr:_onResDownloadError(res)
	self:showUITipByState(BootstrapConstdef.EBootstrapState.ResDownloadError, "-资源下载失败-" .. "\n[" .. res.ErrorText .. "]")

	local OnlineResUpdateEventType = Framework.OnlineResUpdate.OnlineResUpdateEventType

	self:_callFuncByType(OnlineResUpdateEventType.ResDownloadError, res)
end

function BootstrapOnlineResMgr:_onResDownloadProgress(res, progress)
	local OnlineResUpdateEventType = Framework.OnlineResUpdate.OnlineResUpdateEventType

	self:_callFuncByType(OnlineResUpdateEventType.ResDownloadProgress, res, progress)
end

function BootstrapOnlineResMgr:_onLocalVersionCodeSuccess(state)
	self:showUITipByState(BootstrapConstdef.EBootstrapState.LocalVersionCodeSuccess, "-读取开始-", 0.1)

	local OnlineResUpdateEventType = Framework.OnlineResUpdate.OnlineResUpdateEventType

	self:_callFuncByType(OnlineResUpdateEventType.HotManifestFileSuccess, state)
end

function BootstrapOnlineResMgr:_onLocalDownloadManifestSuccess()
	self:showUITipByState(BootstrapConstdef.EBootstrapState.LocalDownloadManifestSuccess, "-加载完成-", 0.2)

	local OnlineResUpdateEventType = Framework.OnlineResUpdate.OnlineResUpdateEventType

	self:_callFuncByType(OnlineResUpdateEventType.LocalDownloadManifestSuccess)
end

function BootstrapOnlineResMgr:_onHotManifestFileSuccess()
	self:showUITipByState(BootstrapConstdef.EBootstrapState.HotManifestFileSuccess, "-热更读取完成-", 0.3)

	local OnlineResUpdateEventType = Framework.OnlineResUpdate.OnlineResUpdateEventType

	self:_callFuncByType(OnlineResUpdateEventType.HotManifestFileSuccess)
end

function BootstrapOnlineResMgr:_onRequestDownloadManifestSuccess()
	self:showUITipByState(BootstrapConstdef.EBootstrapState.RequestDownloadManifestSuccess, "-远端成功-", 0.6)

	local OnlineResUpdateEventType = Framework.OnlineResUpdate.OnlineResUpdateEventType

	self:_callFuncByType(OnlineResUpdateEventType.RequestDownloadManifestSuccess)
end

function BootstrapOnlineResMgr:_onLocalManifestSaveSuccess()
	self:showUITipByState(BootstrapConstdef.EBootstrapState.LocalManifestSaveSuccess, "-本地更新完成[1]-", 0.8)

	local OnlineResUpdateEventType = Framework.OnlineResUpdate.OnlineResUpdateEventType

	self:_callFuncByType(OnlineResUpdateEventType.LocalManifestSaveSuccess)
end

function BootstrapOnlineResMgr:_onDeleteAllHotManifestSuccess()
	self:showUITipByState(BootstrapConstdef.EBootstrapState.DeleteAllHotManifestSuccess, "-本地更新完成[2]-", 0.85)

	local OnlineResUpdateEventType = Framework.OnlineResUpdate.OnlineResUpdateEventType

	self:_callFuncByType(OnlineResUpdateEventType.DeleteAllHotManifestSuccess)
end

function BootstrapOnlineResMgr:_onNeedFilesDownloadSuccess()
	self:showUITipByState(BootstrapConstdef.EBootstrapState.NeedFilesDownloadSuccess, "-本地更新完成[3]-", 0.95)

	local OnlineResUpdateEventType = Framework.OnlineResUpdate.OnlineResUpdateEventType

	self:_callFuncByType(OnlineResUpdateEventType.NeedFilesDownloadSuccess)
end

function BootstrapOnlineResMgr:_onOnlineResUpdateComplete()
	self:showUITipByState(BootstrapConstdef.EBootstrapState.OnlineResUpdateComplete, "-本地更新完成[4]-", 1)

	if self._onlineResUpdateCompleteHandler and self._onlineResUpdateCompleteHandlerObj then
		self._onlineResUpdateCompleteHandler(self._onlineResUpdateCompleteHandlerObj)
	end

	local OnlineResUpdateEventType = Framework.OnlineResUpdate.OnlineResUpdateEventType

	self:_callFuncByType(OnlineResUpdateEventType.OnlineResUpdateComplete)
end

function BootstrapOnlineResMgr:showUITipByState(eBootstrapState, tips, val)
	if self._onlineResUpdateCompleteHandlerObj and self._onlineResUpdateCompleteHandlerObj.isUIExist == true then
		self._onlineResUpdateCompleteHandlerObj:showUITipByState(eBootstrapState, tips, val)
	elseif self._errorHander then
		self._errorHander(self._errorHanderObj, eBootstrapState, tips, val)
	end
end

function BootstrapOnlineResMgr:_onDownloadFileComplete(task)
	local path = task.fileName

	for k, res in pairs(self._all_downloading_map) do
		local size = res.downloadingMap[path]

		if size ~= nil then
			res.curSize = res.curSize + size
			res.curCount = res.curCount + 1
			res.downloadingMap[path] = nil

			if res.curCount == res.totalCount then
				self:_tryCallBackResComplete(res)

				self._all_downloading_map[res.id] = nil
			else
				self:_tryCallBackResProgress(res)
			end
		end
	end

	local OnlineResUpdateEventType = Framework.OnlineResUpdate.OnlineResUpdateEventType

	self:_callFuncByType(OnlineResUpdateEventType.DownloadFileComplete, task)
end

function BootstrapOnlineResMgr:CheckAndDownloadBankAssetsWithEvtName(fmodMgr, evtName)
	if self._MGR_STATE == STATE_2 then
		return BootstrapSimpleResDownloadMgr.instance:CheckAndDownloadBankAssetsWithEvtName(fmodMgr, evtName)
	end

	return true
end

function BootstrapOnlineResMgr:CheckAndDownloadBankAssets(bankName)
	if self._MGR_STATE == STATE_2 then
		return BootstrapSimpleResDownloadMgr.instance:CheckAndDownloadBankAssets(bankName)
	end

	return true
end

local fmod_path = "audio/fmod/"
local mp4_path = "movie/"

function BootstrapOnlineResMgr:downloadFilesWithSize(urlList, completeHandler, progressHandler, handlerObj, isUpSpeed, resType)
	if self._MGR_STATE == STATE_1 then
		if urlList and #urlList > 0 then
			if resType == nil then
				resType = 0
			end

			if isUpSpeed == nil then
				isUpSpeed = true
			end

			local totalSize = 0
			local totalCount = 0
			local curSize = 0
			local curCount = 0
			local downloadingMap = {}
			local checkMap = {}
			local tType = resType

			for i, url in ipairs(urlList) do
				local dependsList

				if string.find(url, fmod_path) or string.find(url, mp4_path) then
					tType = 1
					dependsList = self._onlineResUpdateMgr:GetFileDependsListWithExt(url)
				else
					tType = resType
					dependsList = self._onlineResUpdateMgr:GetFileDependsList(url)
				end

				local cnt = dependsList.Count - 1

				for i = 0, cnt do
					local path = dependsList[i]

					if checkMap[path] == nil then
						checkMap[path] = true

						local isNew = self._onlineResUpdateMgr:DownloadFileUntilUpdated(path, tType, isUpSpeed)
						local size = self._versionDataMgr:GetRemoteSize(path)

						size = checknumber(tostring(size))
						size = math.max(0, size)
						totalSize = totalSize + size
						totalCount = totalCount + 1

						if isNew then
							curSize = curSize + size
							curCount = curCount + 1
						else
							downloadingMap[path] = size
						end
					end
				end
			end

			res_ID = res_ID + 1

			local res = {}

			res.id = res_ID
			res.totalCount = totalCount
			res.totalSize = totalSize
			res.curCount = curCount
			res.curSize = curSize
			res.downloadingMap = downloadingMap
			res.completeHandler = completeHandler
			res.progressHandler = progressHandler
			res.handlerObj = handlerObj

			if curCount == totalCount then
				self:_tryCallBackResComplete(res)
			else
				self._all_downloading_map[res.id] = res
			end

			return res
		else
			return nil
		end
	else
		res_ID = res_ID + 1

		local res = {}

		res.id = res_ID
		res.totalCount = 1
		res.totalSize = 1
		res.curCount = 1
		res.curSize = 1
		res.downloadingMap = nil
		res.completeHandler = completeHandler
		res.progressHandler = progressHandler
		res.handlerObj = handlerObj

		self:_tryCallBackResComplete(res)

		return res
	end
end

function BootstrapOnlineResMgr:_tryCallBackResComplete(res)
	self:_tryCallBackResProgress(res)

	if res.completeHandler then
		if res.handlerObj then
			res.completeHandler(res.handlerObj, res)
		else
			res:completeHandler()
		end
	end
end

function BootstrapOnlineResMgr:_tryCallBackResProgress(res)
	if res.progressHandler then
		if res.handlerObj then
			res.progressHandler(res.handlerObj, res)
		else
			res:progressHandler()
		end
	end
end

function BootstrapOnlineResMgr:_onLocalVersionCodeFailed()
	local OnlineResUpdateEventType = Framework.OnlineResUpdate.OnlineResUpdateEventType

	self:_callFuncByType(OnlineResUpdateEventType.LocalVersionCodeFailed)
end

BootstrapOnlineResMgr.instance = BootstrapOnlineResMgr.New()

return BootstrapOnlineResMgr
