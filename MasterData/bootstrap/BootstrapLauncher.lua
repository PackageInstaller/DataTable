-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/bootstrap/BootstrapLauncher.lua

module("bootstrap.BootstrapLauncher", package.seeall)

local BootstrapLauncher = class("BootstrapLauncher", BootstrapLauncherBase)

function BootstrapLauncher:ctor()
	BootstrapLauncher.super.ctor(self)
	usingnow("bootstrap.BootstrapConstdefExtend", "BootstrapConstdefExtend")
	usingnow("bootstrap.BootstrapPjaqGameConfigMgr", "BootstrapPjaqGameConfigMgr")
	usingnow("bootstrap.BootstrapLanguage", "BootstrapLanguage")
	usingnow("bootstrap.BootstrapResPreLoad", "BootstrapResPreLoad")
	usingnow("bootstrap.BootstrapMsgBoxView", "BootstrapMsgBoxView")
	usingnow("bootstrap.BootstrapLoadingView", "BootstrapLoadingView")
	usingnow("bootstrap.BootstrapAdaptationoverlayview", "BootstrapAdaptationoverlayview")
	usingnow("bootstrap.Netkit", "Netkit")
	usingnow("bootstrap.BootstrapOnlineResMgr", "BootstrapOnlineResMgr")

	self.__VERSION = 1
	self._startHotUpdateDowntime = os.time()
	self._isSendEHotUpdateDownloadProgress1 = false
	self._isSendEHotUpdateDownloadProgress5 = false
	self._isSendEHotUpdateDownloadProgress10 = false
	self._isSendEHotUpdateDownloadProgress20 = false
	self._isSendEHotUpdateDownloadProgress25 = false
	self._isSendEHotUpdateDownloadProgress30 = false
	self._isSendEHotUpdateDownloadProgress50 = false
	self._isSendEHotUpdateDownloadProgress75 = false
	self._isSendEHotUpdateDownloadProgress80 = false
	self._isSendEHotUpdateDownloadProgress100 = false
	self._currentReceivedBytes = 0
	self._totalBytesToReceive = 0
	self._startHotUpdateDowntime = 0
	self._countHotUpdateDownloadFail = 0
	self._sensorsTrackPara = {}
	self._recordStartHotUpMsTime = 0
	self.isUIExist = false

	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ECSharpInitStart)
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ECSherpInitComplete)
	BootstrapUtil.registerNativeCallBack()
	BootstrapUtil.registerScreenChangedListener()
end

function BootstrapLauncher:importLogicLua()
	BootstrapLauncher.super.importLogicLua(self)
	Game.MemoryWarning.AddListener(self._onNotEnoughMemory, self)
	Framework.ResourceCache.Instance:EnableUnityCachingSystem(GameUtil.isUnityCacheEnable())
end

function BootstrapLauncher:_onNotEnoughMemory()
	if enableDebug then
		FloatWordMgr.instance:show("内存紧张,开始尝试垃圾回收")
	end

	ResGcMgr.instance:gc()
end

function BootstrapLauncher:start()
	printInfo(LogTag.BOOTSTRAP, "BootstrapLauncher start----------")
	BootstrapUtil.hideTransition()
	BootstrapResPreLoad.loadUI()
	self:showUITipByState(BootstrapConstdef.EBootstrapState.LoadUIPrefab)
end

function BootstrapLauncher:onLoadUIFinish()
	BootstrapMsgBoxView.buildUI()
	BootstrapMsgBoxView.onEnter()
	BootstrapLoadingView.buildUI()
	BootstrapLoadingView.onEnter()

	self.isUIExist = true

	local runtimeOS = Framework.OSDef.RunOS

	if runtimeOS == Framework.OSDef.Android or runtimeOS == Framework.OSDef.IOS then
		if enableDebug and CSGameUtil.GetGameConfigUrlType() == 3 then
			printInfo("OS:" .. runtimeOS .. ", 内网测试包不走sdk登录！")
			self:_startShowLogo()
		else
			BootstrapLoadingView.show(true)
			self:_checkSdkInit()
		end
	else
		printInfo("OS:" .. runtimeOS .. ", 非移动平台直接跳过SDK初始化！")
		self:_startShowLogo()
	end
end

function BootstrapLauncher:_startShowLogo()
	BootstrapLoadingView.show(true)
	BootstrapLoadingView.showLogo(false)
	BootstrapLoadingView.showUpdateOrLoad(true)
	self:_onLogoAndWarningFinish()
end

function BootstrapLauncher:_onLogoAndWarningFinish()
	BootstrapPjaqGameConfigMgr.reqGameConfig()
end

function BootstrapLauncher:_checkSdkInit()
	BootstrapUtil.registerInitListener(self.onSdkInited, self)

	local initStatus = BootstrapUtil.checkSdkInit()

	if initStatus == BootstrapUtil.INIT_SUCCESS then
		self:onSdkInited(BootstrapUtil.STATUS_OK)
	elseif initStatus == BootstrapUtil.INIT_FAIL then
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EExecSDKInitFail)
		self:showUITipByState(BootstrapConstdef.EBootstrapState.SDKInitFail)
	end
end

function BootstrapLauncher:onSdkInited(statusCode, statusDesc)
	if statusCode == BootstrapUtil.STATUS_OK then
		forcePrint(LogTag.BOOTSTRAP, "BootstrapLauncher onSdkInited:SDKInitSuccess----------")
		BootstrapUtil.clearInitCallback()
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EExecSDKInitSuccess)
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ECPSDKInitSuccess)
		BootstrapMsgBoxView.setTxtVersionActive(false)
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartReqGameConfig)
		self:_startShowLogo()
	else
		forcePrint("BootstrapLauncher onSdkInited:SDKInitFail----------")
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EExecSDKInitFail)
		self:showUITipByState(BootstrapConstdef.EBootstrapState.SDKInitFail, statusDesc)
	end
end

function BootstrapLauncher:onHttpGetGameConfigFinish()
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartReqGameConfigSuccess)
	BootstrapLauncher.super.start(self)
end

function BootstrapLauncher:getHotUpdateAppCode()
	return "aqsy"
end

if not Framework.OSDef.isEditor then
	local LOCAL_VERSIONCODE = "__local_versioncode"

	function BootstrapLauncher:startHotUpdate()
		self:showUITipByState(BootstrapConstdef.EBootstrapState.StartHotUpdate)

		self.helper = Framework.HotUpdate.GameUpdateHelper.Instance

		self.helper:AddListener(Framework.HotUpdate.HotUpdateEventType.RequestRemoteVersionFail, self.onRequestRemoteVersionFail, self)
		self.helper:AddListener(Framework.HotUpdate.HotUpdateEventType.RequestRemoteVersionSuccess, self.onRequestRemoteVersionSuccess, self)
		self.helper:AddListener(Framework.HotUpdate.HotUpdateEventType.RequestRemoteProjectManifestFail, self.onRequestRemoteProjectManifestFail, self)
		self.helper:AddListener(Framework.HotUpdate.HotUpdateEventType.RequestRemoteProjectManifestSuccess, self.onRequestRemoteProjectManifestSuccess, self)
		self.helper:AddListener(Framework.HotUpdate.HotUpdateEventType.NeedPackageUpdate, self.onNeedPackageUpdate, self)
		self.helper:AddListener(Framework.HotUpdate.HotUpdateEventType.StartHotUpdateNotify, self.onStartHotUpdateNotify, self)
		self.helper:AddListener(Framework.HotUpdate.HotUpdateEventType.HotUpdateDownloadProgress, self.onHotUpdateDownloadProgress, self)
		self.helper:AddListener(Framework.HotUpdate.HotUpdateEventType.HotUpdateDownloadFail, self.onHotUpdateDownloadFail, self)
		self.helper:AddListener(Framework.HotUpdate.HotUpdateEventType.HotUpdateDownloadSuccess, self.onHotUpdateDownloadSuccess, self)
		self.helper:AddListener(Framework.HotUpdate.HotUpdateEventType.DiskSpaceInsufficient, self.onDiskSpaceInsufficient, self)
		self.helper:AddListener(Framework.HotUpdate.HotUpdateEventType.HotUpdateAllDownloadSuccess, self.onHotUpdateAllDownloadSuccess, self)
		self.helper:AddListener(Framework.HotUpdate.HotUpdateEventType.StartUnzipNotify, self.onStartUnzipNotify, self)
		self.helper:AddListener(Framework.HotUpdate.HotUpdateEventType.UnzipProgress, self.onUnzipProgress, self)
		self.helper:AddListener(Framework.HotUpdate.HotUpdateEventType.UnzipSuccess, self.onUnzipSuccess, self)
		self.helper:AddListener(Framework.HotUpdate.HotUpdateEventType.UnzipFail, self.onUnzipFail, self)
		self.helper:AddListener(Framework.HotUpdate.HotUpdateEventType.HotUpdateComplete, self.onHotUpdateComplete, self)
		self.helper:AddListener(Framework.HotUpdate.HotUpdateEventType.UnzipFileNotify, self.onUnzipFileNotify, self)
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartRequestRemoteVersionIp)
		BootstrapUtil.sensorsTrackLoadingOnce("开始热更新", "stl_start_hotupdate")

		self._recordStartHotUpMsTime = math.floor(tolua.gettime() * 1000)

		local hotUpdateUrl = BootstrapPjaqGameConfigMgr.getHotUpdateInfoUrl()
		local appCode = self:getHotUpdateAppCode()
		local deviceType = BootstrapUtil.getHotUpdateDeviceType()
		local channelId = tostring(BootstrapUtil.getPlatformId())
		local versionCode = BootstrapUtil.getGameVersionCode()
		local packageName = BootstrapUtil.getGamePackageName()
		local channelId2 = BootstrapUtil.getChannelId()
		local versionCodeNum = checknumber(versionCode)
		local vc = Framework.LocalStorage.Instance:GetInt(LOCAL_VERSIONCODE, -1)

		if vc > 0 and vc ~= versionCodeNum then
			Framework.ResourceCache.Instance:ClearCaching()
			Framework.HotUpdate.VersionMgr.Instance:DeleteAllLocal()
			forcePrint(">>>>>>> ========B覆盖安装时候才触发 新包版本号 会更新 修复一次再加载ab")
		end

		forcePrint(">>>>>>> ========lastVersionCode:[" .. vc .. "]_versionCode:[" .. versionCodeNum .. "]_unityVersion:" .. UnityEngine.Application.unityVersion)

		local vc = Framework.LocalStorage.Instance:SetInt(LOCAL_VERSIONCODE, versionCodeNum)

		forcePrint("===============Start Hot Update====================")
		forcePrint("hotUpdateUrl===>" .. hotUpdateUrl)
		forcePrint("appCode===>" .. appCode)
		forcePrint("deviceType===>" .. deviceType)
		forcePrint("channelId===>" .. channelId)
		forcePrint("versionCode===>" .. versionCode)
		forcePrint("packageName===>" .. packageName)
		forcePrint("channelId2===>" .. channelId2)
		self.helper:StartUpdate(hotUpdateUrl, appCode, deviceType, channelId, versionCode, packageName, channelId2, 4)
	end
end

function BootstrapLauncher:onRequestRemoteVersionSuccess(remoteVersion, zoneId, review, loginUrl, force, loginUrlBak)
	forcePrint("onRequestRemoteVersionSuccess====================")
	forcePrint(remoteVersion)
	forcePrint(zoneId)
	forcePrint(review)
	forcePrint(loginUrl)
	forcePrint(force)
	forcePrint(loginUrlBak)
	forcePrint("end ====================onRequestRemoteVersionSuccess====================")

	if enableDebug then
		BootstrapMsgBoxView.setTxtVersionActive(true)
	end

	local eventId = "803"
	local eventName = "GetManifest"
	local gameId = BootstrapUtil.getGameId()
	local spend_time = math.floor(tolua.gettime() * 1000 - self._recordStartHotUpMsTime)
	local start_timestamp = self._recordStartHotUpMsTime

	Netkit.trackHttpData(eventId, eventName, gameId, spend_time, start_timestamp)

	BootstrapPjaqGameConfigMgr.isReview = review or false

	local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

	if versionCode >= 1020 and versionCode < 1100 or versionCode >= 1150 then
		local isAppReviewing = self:invokeBool(BootstrapUtil.sdkClazz, "isAppReviewing")

		BootstrapPjaqGameConfigMgr.isReview = isAppReviewing or false
	end

	if BootstrapPjaqGameConfigMgr.isReview then
		BootstrapPjaqGameConfigMgr.handleReviewGameConfig()

		function ensureTrailingSlash(url)
			if string.sub(url, -1) ~= "/" then
				url = url .. "/"
			end

			return url
		end

		loginUrl = ensureTrailingSlash(loginUrl)
		loginUrlBak = ensureTrailingSlash(loginUrlBak)
		BootstrapPjaqGameConfigMgr.GameConfigJsonData.httpLoginUrl = loginUrl

		if BootstrapPjaqGameConfigMgr.ReverseWebUrls then
			for i = 0, BootstrapPjaqGameConfigMgr.ReverseWebUrls.Length - 1 do
				BootstrapPjaqGameConfigMgr.ReverseWebUrls[i] = loginUrlBak
			end
		end
	end

	self:showUITipByState(BootstrapConstdef.EBootstrapState.RequestRemoteVersionSuccess)

	local sensorsTrackPara = {
		version = tostring(remoteVersion),
		loginUrl = tostring(loginUrl),
		loginUrlBak = tostring(loginUrlBak),
		zoneId = tostring(zoneId),
		force = tostring(force),
		custom = tostring(""),
		review = tostring(review),
		silent = tostring(BootstrapUtil.getNetworkInfo() == "WIFI")
	}

	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ERequestRemoteVersionMainfestSuccess, sensorsTrackPara)
end

local json = require("cjson")
local nativeMgr = Framework.NativeMgr.Instance

function BootstrapLauncher:invokeBool(clazz, method, param, defaultValue)
	param = param or {}

	local paramString = json.encode(param)

	if defaultValue == nil then
		return nativeMgr:CallStaticBool(clazz, method, paramString)
	else
		return nativeMgr:CallStaticBoolDefault(clazz, method, paramString, defaultValue)
	end
end

function BootstrapLauncher:onRequestRemoteProjectManifestSuccess()
	self:showUITipByState(BootstrapConstdef.EBootstrapState.RequestRemoteProjectManifestSuccess)
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ERequestRemoteVersionSuccess)
end

function BootstrapLauncher:onHotUpdateAllDownloadSuccess()
	self:showUITipByState(BootstrapConstdef.EBootstrapState.HotUpdateAllDownloadSuccess)
end

function BootstrapLauncher:onUnzipSuccess()
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartHotUpdateUnzipSuccess)
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ECPStartHotUpdateUnzipSuccess)
	self:showUITipByState(BootstrapConstdef.EBootstrapState.UnzipSuccess)
end

function BootstrapLauncher:onStartHotUpdateNotify(currentReceivedBytes, totalBytesToReceive, startDownload)
	self._countHotUpdateDownloadFail = 0
	self._currentReceivedBytes = checknumber(tostring(currentReceivedBytes))

	forcePrint("热更开始“=============_currentReceivedBytes===" .. self._currentReceivedBytes)

	self._totalBytesToReceive = checknumber(tostring(totalBytesToReceive))

	forcePrint("热更开始“=============_totalBytesToReceive===" .. self._totalBytesToReceive)
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ENeedHotUpdate)

	local sensorsTrackPara = {
		totalSize = tostring(self._totalBytesToReceive),
		autoDownload = tostring(BootstrapUtil.getNetworkInfo() == "WIFI")
	}

	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotupdateCheckSuccess, sensorsTrackPara)
	self:showUITipByState(BootstrapConstdef.EBootstrapState.NeedToStartHotUpdate)
end

function BootstrapLauncher:onHotUpdateDownloadProgress(currentReceivedBytes, totalBytesToReceive)
	if BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.HotUpdateDownloadFail or BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.DiskSpaceInsufficient then
		return
	end

	self._currentReceivedBytes = self._currentReceivedBytes or 0

	local t_currentReceivedBytes = checknumber(tostring(currentReceivedBytes))
	local t_totalBytesToReceive = checknumber(tostring(totalBytesToReceive))
	local curSpeedValuePerSec = (t_currentReceivedBytes - self._currentReceivedBytes) / 1024 * 30
	local tips = string.format(BootstrapLanguage.a10, curSpeedValuePerSec, t_currentReceivedBytes / 1024 / 1024, t_totalBytesToReceive / 1024 / 1024)
	local per = t_currentReceivedBytes / t_totalBytesToReceive

	if per > 0.01 and not self._isSendEHotUpdateDownloadProgress1 then
		local sec = os.time() - self._startHotUpdateDowntime

		forcePrint(LogTag.BOOTSTRAP, "热更新下载进度1 需要时间秒=", sec)

		self._sensorsTrackPara.colA = BootstrapConstdef.getHotUpdateDownloadTimeStr(sec)
		self._sensorsTrackPara.totalSize = tostring(t_currentReceivedBytes)
		self._sensorsTrackPara.totalSecond = tostring(sec)
		self._isSendEHotUpdateDownloadProgress1 = true

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress1, self._sensorsTrackPara)
	elseif per > 0.05 and not self._isSendEHotUpdateDownloadProgress5 then
		local sec = os.time() - self._startHotUpdateDowntime

		forcePrint(LogTag.BOOTSTRAP, "热更新下载进度5 需要时间秒=", sec)

		self._sensorsTrackPara.colA = BootstrapConstdef.getHotUpdateDownloadTimeStr(sec)
		self._sensorsTrackPara.totalSize = tostring(t_currentReceivedBytes)
		self._sensorsTrackPara.totalSecond = tostring(sec)
		self._isSendEHotUpdateDownloadProgress5 = true

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress5, self._sensorsTrackPara)
	elseif per > 0.1 and not self._isSendEHotUpdateDownloadProgress10 then
		local sec = os.time() - self._startHotUpdateDowntime

		forcePrint(LogTag.BOOTSTRAP, "热更新下载进度10 需要时间秒=", sec)

		self._sensorsTrackPara.colA = BootstrapConstdef.getHotUpdateDownloadTimeStr(sec)
		self._sensorsTrackPara.totalSize = tostring(t_currentReceivedBytes)
		self._sensorsTrackPara.totalSecond = tostring(sec)
		self._isSendEHotUpdateDownloadProgress10 = true

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress10, self._sensorsTrackPara)
	elseif per > 0.2 and not self._isSendEHotUpdateDownloadProgress20 then
		local sec = os.time() - self._startHotUpdateDowntime

		forcePrint(LogTag.BOOTSTRAP, "热更新下载进度20 需要时间秒=", sec)

		self._sensorsTrackPara.colA = BootstrapConstdef.getHotUpdateDownloadTimeStr(sec)
		self._sensorsTrackPara.totalSize = tostring(t_currentReceivedBytes)
		self._sensorsTrackPara.totalSecond = tostring(sec)
		self._isSendEHotUpdateDownloadProgress20 = true

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress20, self._sensorsTrackPara)
	elseif per > 0.25 and not self._isSendEHotUpdateDownloadProgress25 then
		local sec = os.time() - self._startHotUpdateDowntime

		forcePrint(LogTag.BOOTSTRAP, "热更新下载进度25 需要时间秒=", sec)

		self._sensorsTrackPara.colA = BootstrapConstdef.getHotUpdateDownloadTimeStr(sec)
		self._sensorsTrackPara.totalSize = tostring(t_currentReceivedBytes)
		self._sensorsTrackPara.totalSecond = tostring(sec)
		self._isSendEHotUpdateDownloadProgress25 = true

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress25, self._sensorsTrackPara)
	elseif per > 0.3 and not self._isSendEHotUpdateDownloadProgress30 then
		local sec = os.time() - self._startHotUpdateDowntime

		forcePrint(LogTag.BOOTSTRAP, "热更新下载进度30 需要时间秒=", sec)

		self._sensorsTrackPara.colA = BootstrapConstdef.getHotUpdateDownloadTimeStr(sec)
		self._sensorsTrackPara.totalSize = tostring(t_currentReceivedBytes)
		self._sensorsTrackPara.totalSecond = tostring(sec)
		self._isSendEHotUpdateDownloadProgress30 = true

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress30, self._sensorsTrackPara)
	elseif per > 0.5 and not self._isSendEHotUpdateDownloadProgress50 then
		local sec = os.time() - self._startHotUpdateDowntime

		forcePrint(LogTag.BOOTSTRAP, "热更新下载进度50 需要时间秒=", sec)

		self._sensorsTrackPara.colA = BootstrapConstdef.getHotUpdateDownloadTimeStr(sec)
		self._sensorsTrackPara.totalSize = tostring(t_currentReceivedBytes)
		self._sensorsTrackPara.totalSecond = tostring(sec)
		self._isSendEHotUpdateDownloadProgress50 = true

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress50, self._sensorsTrackPara)
	elseif per > 0.75 and not self._isSendEHotUpdateDownloadProgress75 then
		local sec = os.time() - self._startHotUpdateDowntime

		forcePrint(LogTag.BOOTSTRAP, "热更新下载进度50 需要时间秒=", sec)

		self._sensorsTrackPara.colA = BootstrapConstdef.getHotUpdateDownloadTimeStr(sec)
		self._sensorsTrackPara.totalSize = tostring(t_currentReceivedBytes)
		self._sensorsTrackPara.totalSecond = tostring(sec)
		self._isSendEHotUpdateDownloadProgress75 = true

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress75, self._sensorsTrackPara)
	elseif per > 0.95 and not self._isSendEHotUpdateDownloadProgress100 then
		local sec = os.time() - self._startHotUpdateDowntime

		forcePrint(LogTag.BOOTSTRAP, "热更新下载进度95 需要时间秒=", sec)

		self._sensorsTrackPara.colA = BootstrapConstdef.getHotUpdateDownloadTimeStr(sec)
		self._sensorsTrackPara.totalSize = tostring(t_currentReceivedBytes)
		self._sensorsTrackPara.totalSecond = tostring(sec)
		self._isSendEHotUpdateDownloadProgress100 = true

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateDownloadProgress100, self._sensorsTrackPara)
	end

	self:showUITipByState(BootstrapConstdef.EBootstrapState.HotUpdateDownloadProgress, tips, per)

	self._currentReceivedBytes = t_currentReceivedBytes
end

function BootstrapLauncher:onStartUnzipNotify()
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartHotUpdateUnzip)
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ECPStartHotUpdateUnzip)
	self:showUITipByState(BootstrapConstdef.EBootstrapState.StartUnzipNotify)
end

function BootstrapLauncher:onUnzipProgress(progress)
	if BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.UnzipFail or BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.DiskSpaceInsufficient then
		return
	end

	if tostring(progress) ~= "nan" then
		local tips = string.format(BootstrapLanguage.a11, progress * 100)

		self:showUITipByState(BootstrapConstdef.EBootstrapState.UnzipProgress, tips, progress)
	end
end

function BootstrapLauncher:onRequestRemoteVersionFail(requestAgain)
	local eventId = "804"
	local eventName = "GetManifestFail"
	local gameId = BootstrapUtil.getGameId()
	local spend_time = math.floor(tolua.gettime() * 1000 - self._recordStartHotUpMsTime)
	local start_timestamp = self._recordStartHotUpMsTime

	Netkit.trackHttpData(eventId, eventName, gameId, spend_time, start_timestamp)
	self:showUITipByState(BootstrapConstdef.EBootstrapState.RequestRemoteVersionFail)
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotupdateCheckFail)
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ERequestRemoteVersionMainfestFail)
end

function BootstrapLauncher:onRequestRemoteProjectManifestFail(requestAgain)
	self:showUITipByState(BootstrapConstdef.EBootstrapState.RequestRemoteProjectManifestFail)
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotupdateCheckFail)

	local sensorsTrackPara = {
		reason = BootstrapLanguage.a34
	}

	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ERequestRemoteVersionFail, sensorsTrackPara)
end

function BootstrapLauncher:onHotUpdateDownloadFail(url, errorCode, file, fileLength, errorInfo)
	if self._countHotUpdateDownloadFail == 3 then
		printInfo("已经失败3次，继续重试，将启用回源下载")
		Framework.HotUpdate.GameUpdateMgr.Instance:SetDownloadFromSourceResServer()

		self._countHotUpdateDownloadFail = 0
	else
		self._countHotUpdateDownloadFail = self._countHotUpdateDownloadFail + 1
	end

	self:showUITipByState(BootstrapConstdef.EBootstrapState.HotUpdateDownloadFail, url, errorCode)

	local sensorsTrackPara = {
		totalSize = tostring(self._totalBytesToReceive),
		totalSecond = tostring(os.time() - self._startHotUpdateDowntime),
		progressRate = tostring(math.ceil(self._currentReceivedBytes / self._totalBytesToReceive * 100)) .. "%",
		fileName = url
	}
	local val = errorCode
	local tipcontent = ""

	if val == Framework.Download.DownloadError.NetworkDisconnect then
		tipcontent = BootstrapLanguage.a23
	elseif val == Framework.Download.DownloadError.NotFound then
		tipcontent = BootstrapLanguage.a24
	elseif val == Framework.Download.DownloadError.ServerMaintenance then
		tipcontent = BootstrapLanguage.a25
	elseif val == Framework.Download.DownloadError.DiskFull then
		tipcontent = BootstrapLanguage.a26
	elseif val == Framework.Download.DownloadError.Timeout then
		tipcontent = BootstrapLanguage.a27
	elseif not string.nilorempty(errorInfo) then
		tipcontent = errorInfo
	end

	sensorsTrackPara.reason = tipcontent

	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateFail, sensorsTrackPara)
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartHotUpdateIpFail)
	self:_trackHotupdateFailed(url, checknumber(tostring(fileLength)))
end

function BootstrapLauncher:onHotUpdateDownloadSuccess(url, file, data_length)
	forcePrint("onHotUpdateDownloadSuccess===", url, data_length)

	local eventId = "801"
	local eventName = "Patch"
	local gameId = BootstrapUtil.getGameId()
	local url = BootstrapPjaqGameConfigMgr.getHotUpdateInfoUrl()
	local spend_time = math.floor(tolua.gettime() * 1000 - self._recordStartHotUpMsTime)
	local start_timestamp = self._recordStartHotUpMsTime

	Netkit.trackPatchData(checknumber(tostring(data_length)), eventId, eventName, gameId, url, spend_time, start_timestamp)
end

function BootstrapLauncher:onDiskSpaceInsufficient()
	self:showUITipByState(BootstrapConstdef.EBootstrapState.DiskSpaceInsufficient)

	local sensorsTrackPara = {
		reason = "磁盘空间不足"
	}

	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ECPStartHotUpdateUnzipFail, sensorsTrackPara)
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EDiskSpaceInsufficient)
end

function BootstrapLauncher:onUnzipFail(status, unzipAgain)
	self:showUITipByState(BootstrapConstdef.EBootstrapState.UnzipFail, status)
end

function BootstrapLauncher:onNeedPackageUpdate(url)
	self._urlNeedPackageUpdate = url

	self:showUITipByState(BootstrapConstdef.EBootstrapState.NeedPackageUpdate)

	local sensorsTrackPara = {
		AppUrl = tostring(self._urlNeedPackageUpdate)
	}

	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ECPJumpUpdateUrl, sensorsTrackPara)
end

function BootstrapLauncher:onUnzipFileNotify(allUnzipFileNames)
	return
end

function BootstrapLauncher:onHotUpdateComplete()
	local sensorsTrackPara = {
		totalSize = tostring(self._totalBytesToReceive),
		totalSecond = tostring(os.time() - self._startHotUpdateDowntime)
	}

	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateComplete, sensorsTrackPara)
	self:showUITipByState(BootstrapConstdef.EBootstrapState.HotUpdateComplete)
	BootstrapOnlineResMgr.instance:CheckAndStartLoadFile(self.onHotupdateDone, self)
end

function BootstrapLauncher:onHotupdateDone()
	self._currentReceivedBytes = 0
	self._totalBytesToReceive = 0
	self._startHotUpdateDowntime = 0
	self._isSendEHotUpdateDownloadProgress1 = false
	self._isSendEHotUpdateDownloadProgress10 = false
	self._isSendEHotUpdateDownloadProgress25 = false
	self._isSendEHotUpdateDownloadProgress50 = false
	self._isSendEHotUpdateDownloadProgress80 = false
	self._isSendEHotUpdateDownloadProgress100 = false

	forcePrint(LogTag.BOOTSTRAP, "热更新流程完毕")
	BootstrapUtil.sensorsTrackLoadingOnce("热更新结束", "stl_end_hotupdate")
	BootstrapLauncher.super.onHotupdateDone(self)
end

function BootstrapLauncher:startLoadLuaBundles()
	if Framework.HotUpdate.VersionMgr.Instance.IsUpdateBootstrapScripts then
		forcePrint("此时热更有更新Bootstrap或tolua，现在开始重新载入bootstrap")

		Framework.HotUpdate.VersionMgr.Instance.IsUpdateBootstrapScripts = false
		Framework.HotUpdate.VersionMgr.Instance.IsReloadLuaClient = true

		self:reloadLuaClient()
	else
		BootstrapLauncher.super.startLoadLuaBundles(self)
	end
end

function BootstrapLauncher:reloadLuaClient()
	StarterExtention.ReloadLuaClient()
	BootstrapLoadingView.destroyUI()
	BootstrapMsgBoxView.destroyUI()

	self.isUIExist = false
end

function BootstrapLauncher:onLuaBundlesDone()
	BootstrapMsgBoxView.setTxtVersionActive(false)
	self:showUITipByState(BootstrapConstdef.EBootstrapState.BussLuaBundlesDone)
	forcePrint(LogTag.BOOTSTRAP, "游戏业务lua的ab已经加载完毕，开始启动游戏业务")
	BootstrapLauncher.super.onLuaBundlesDone(self)
end

function BootstrapLauncher:handleResPreLoadMgrFinish()
	forcePrint(LogTag.BOOTSTRAP, "游戏预加载资源完毕，游戏准备好了，可以玩了")
	BootstrapLoadingView.destroyUI()
	BootstrapMsgBoxView.destroyUI()

	self.isUIExist = false

	ResGcMgr.instance:gc()
end

function BootstrapLauncher:showUITipByState(eBootstrapState, tips, val)
	BootstrapConstdef.CurBootstrapState = eBootstrapState

	if BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.LoadUIPrefabError then
		BootstrapMsgBoxView.TxtVersionContent.text = BootstrapLanguage.a4
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfig then
		BootstrapLoadingView.showPersent(true)
		BootstrapLoadingView.setPersentVal(0)
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.a6)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfigError then
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartReqGameConfigFail)
		BootstrapLoadingView.showPersent(false)
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.retry, BootstrapLanguage.cancel)
		BootstrapMsgBoxView.setTxtContent(BootstrapLanguage.a5)
		BootstrapMsgBoxView.show(true)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfigSuccess then
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.a7)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.StartHotUpdate then
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.a9)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.BussLuaBundlesDone then
		BootstrapLoadingView.showPersent(true)
		BootstrapLoadingView.setPersentVal(0)
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.a8)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.HotUpdateDownloadProgress then
		BootstrapLoadingView.setTxtContent(tips)
		BootstrapLoadingView.showPersent(true)
		BootstrapLoadingView.setPersentVal(val)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.HotUpdateDownloadBeginning then
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.a22)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.UnzipProgress then
		BootstrapLoadingView.setTxtContent(tips)
		BootstrapLoadingView.showPersent(true)
		BootstrapLoadingView.setPersentVal(val)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.UnzipSuccess then
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.a12)
		BootstrapLoadingView.showPersent(false)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.HotUpdateComplete then
		BootstrapLoadingView.showPersent(true)
		BootstrapLoadingView.setPersentVal(0)
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.a13)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.NeedToStartHotUpdate then
		local curB2M = (self._totalBytesToReceive - self._currentReceivedBytes) / 1024 / 1024

		if curB2M <= ((tostring(BootstrapUtil.getNetworkInfo()) == "WIFI" or nil) and math.huge) then
			self:_beginToStartHotUpdate()
		else
			local strVal

			if curB2M < 1 then
				curB2M = (self._totalBytesToReceive - self._currentReceivedBytes) / 1024
				strVal = string.format("%dKB", (self._totalBytesToReceive - self._currentReceivedBytes) / 1024)
			else
				strVal = string.format("%dMB", curB2M)
			end

			BootstrapLoadingView.setTxtContent("")
			BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.sure, BootstrapLanguage.cancel)
			BootstrapMsgBoxView.setTxtContent(string.format(BootstrapLanguage.a2, strVal))
			BootstrapMsgBoxView.show(true)
		end
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.NeedPackageUpdate then
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.sure, BootstrapLanguage.cancel)
		BootstrapMsgBoxView.setTxtContent(BootstrapLanguage.a1)
		BootstrapMsgBoxView.show(true)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.StartUnzipNotify then
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.a14)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.HotUpdateAllDownloadSuccess then
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.a15)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.RequestRemoteVersionSuccess then
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.a16)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.RequestRemoteProjectManifestSuccess then
		BootstrapLoadingView.setTxtContent(BootstrapLanguage.a17)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.RequestRemoteVersionFail then
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.retry, BootstrapLanguage.exit)
		BootstrapMsgBoxView.setTxtContent(BootstrapLanguage.a34)
		BootstrapMsgBoxView.show(true)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.RequestRemoteProjectManifestFail then
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.retry, BootstrapLanguage.exit)
		BootstrapMsgBoxView.setTxtContent(BootstrapLanguage.a34)
		BootstrapMsgBoxView.show(true)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.HotUpdateDownloadFail then
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.sure, BootstrapLanguage.cancel)

		local tipcontent = BootstrapLanguage.a19

		if val == Framework.Download.DownloadError.NetworkDisconnect then
			tipcontent = BootstrapLanguage.a23
		elseif val == Framework.Download.DownloadError.NotFound then
			tipcontent = BootstrapLanguage.a24
		elseif val == Framework.Download.DownloadError.ServerMaintenance then
			tipcontent = BootstrapLanguage.a25
		elseif val == Framework.Download.DownloadError.DiskFull then
			tipcontent = BootstrapLanguage.a26
		elseif val == Framework.Download.DownloadError.Timeout then
			tipcontent = BootstrapLanguage.a27
		end

		BootstrapMsgBoxView.setTxtContent(tipcontent)
		BootstrapMsgBoxView.show(true)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.UnzipFail then
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.sure, BootstrapLanguage.cancel)

		local tipcontent = BootstrapLanguage.a20

		if tips == Framework.UnzipStatus.DiskFull then
			tipcontent = BootstrapLanguage.a28
		elseif tips == Framework.UnzipStatus.ThreadAbort then
			tipcontent = BootstrapLanguage.a29
		elseif tips == Framework.UnzipStatus.Exception then
			tipcontent = BootstrapLanguage.a30
		elseif tips == Framework.UnzipStatus.NotFound then
			tipcontent = BootstrapLanguage.a31
		end

		local sensorsTrackPara = {
			reason = tostring(tipcontent)
		}

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.ECPStartHotUpdateUnzipFail, sensorsTrackPara)
		BootstrapMsgBoxView.setTxtContent(tipcontent)
		BootstrapMsgBoxView.show(true)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.SDKInitFail then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.DiskSpaceInsufficient then
		BootstrapLoadingView.setTxtContent("")
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.sure, BootstrapLanguage.cancel)
		BootstrapMsgBoxView.setTxtContent(BootstrapLanguage.a33)
		BootstrapMsgBoxView.show(true)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.LocalVersionCodeSuccess or BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.LocalDownloadManifestSuccess or BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.HotManifestFileSuccess or BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.RequestDownloadManifestSuccess or BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.LocalManifestSaveSuccess or BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.DeleteAllHotManifestSuccess or BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.NeedFilesDownloadSuccess or BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.OnlineResUpdateComplete then
		BootstrapLoadingView.setTxtContent(tips)
		BootstrapLoadingView.showPersent(true)
		BootstrapLoadingView.setPersentVal(val)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ReadManifestFileError or BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ResDownloadError then
		BootstrapLoadingView.setTxtContent("")
		BootstrapLoadingView.showPersent(false)
		BootstrapMsgBoxView.setBtnTxt(BootstrapLanguage.sure, BootstrapLanguage.cancel)
		BootstrapMsgBoxView.setTxtContent(tips)
		BootstrapMsgBoxView.show(true)
	end
end

function BootstrapLauncher:_trackHotupdateFailed(url, data_length)
	forcePrint("_trackHotupdateFailed===", url, data_length)

	local eventId = "802"
	local eventName = "PatchFail"
	local gameId = BootstrapUtil.getGameId()
	local spend_time = math.floor(tolua.gettime() * 1000 - self._recordStartHotUpMsTime)
	local start_timestamp = self._recordStartHotUpMsTime

	Netkit.trackPatchData(data_length, eventId, eventName, gameId, url, spend_time, start_timestamp)
end

function BootstrapLauncher:onMsgBoxCancelBtnClick()
	BootstrapMsgBoxView.show(false)

	if BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.LoadUIPrefabError then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfig then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfigError then
		self:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfigSuccess then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.NeedToStartHotUpdate then
		local sensorsTrackPara = {
			reason = "用户取消热更"
		}

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateFail, sensorsTrackPara)
		self:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.NeedPackageUpdate then
		self:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.RequestRemoteVersionFail then
		local sensorsTrackPara = {
			reason = "获取热更配置失败"
		}

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateFail, sensorsTrackPara)
		self:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.RequestRemoteProjectManifestFail then
		self:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.HotUpdateDownloadFail then
		self:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.UnzipFail then
		local sensorsTrackPara = {
			reason = "解压失败"
		}

		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EHotUpdateFail, sensorsTrackPara)
		self:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.SDKInitFail then
		self:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.DiskSpaceInsufficient then
		self:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ReadManifestFileError or BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ResDownloadError then
		self:applicationQuit()
	end
end

function BootstrapLauncher:onMsgBoxOkBtnClick()
	if BootstrapConstdef.CurBootstrapState ~= BootstrapConstdef.EBootstrapState.NeedPackageUpdate then
		BootstrapMsgBoxView.show(false)
	end

	if BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.LoadUIPrefabError then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfig then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfigError then
		BootstrapPjaqGameConfigMgr.reqGameConfig()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.GetGameConfigSuccess then
		-- block empty
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.NeedToStartHotUpdate then
		self:_beginToStartHotUpdate()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.NeedPackageUpdate then
		forcePrint(LogTag.BOOTSTRAP, "整包更新地址：", self._urlNeedPackageUpdate)
		UnityEngine.Application.OpenURL(self._urlNeedPackageUpdate)
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.RequestRemoteVersionFail then
		self.helper:DoNext()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.RequestRemoteProjectManifestFail then
		self.helper:DoNext()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.HotUpdateDownloadFail then
		self:showUITipByState(BootstrapConstdef.EBootstrapState.HotUpdateDownloadBeginning)
		self.helper:DoNext()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.UnzipFail then
		self:showUITipByState(BootstrapConstdef.EBootstrapState.StartUnzipNotify)
		self.helper:DoNext()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.SDKInitFail then
		BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EExecSDKInitFailAndRetry)
		BootstrapUtil.sdkInit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.DiskSpaceInsufficient then
		self:applicationQuit()
	elseif BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ReadManifestFileError or BootstrapConstdef.CurBootstrapState == BootstrapConstdef.EBootstrapState.ResDownloadError then
		self:applicationQuit()
	end
end

function BootstrapLauncher:_beginToStartHotUpdate()
	local sensorsTrackPara = {
		totalSize = tostring(self._totalBytesToReceive),
		autoDownload = tostring(BootstrapUtil.getNetworkInfo() == "WIFI")
	}

	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartHotUpdate, sensorsTrackPara)
	BootstrapUtil.sensorsTrack(BootstrapConstdef.EBootstrapEventId.EStartHotUpdateIp)

	self._startHotUpdateDowntime = os.time()
	self._isSendEHotUpdateDownloadProgress1 = false
	self._isSendEHotUpdateDownloadProgress5 = false
	self._isSendEHotUpdateDownloadProgress10 = false
	self._isSendEHotUpdateDownloadProgress20 = false
	self._isSendEHotUpdateDownloadProgress25 = false
	self._isSendEHotUpdateDownloadProgress30 = false
	self._isSendEHotUpdateDownloadProgress50 = false
	self._isSendEHotUpdateDownloadProgress75 = false
	self._isSendEHotUpdateDownloadProgress80 = false
	self._isSendEHotUpdateDownloadProgress100 = false

	self.helper:DoNext()
end

function BootstrapLauncher:applicationQuit()
	BootstrapUtil.sdkDestroy()
	UnityEngine.Application.Quit()
end

function BootstrapLauncher:playAnim()
	local starterGO = UnityEngine.GameObject.Find("AoUnityStarter")
	local starter = PjaqmStarter.Get(starterGO)

	starter:PrepareAnimation(BootstrapResPreLoad.animTakeName)

	self._isPlayingAnim = true
	self._boostrapAnimResNode = starter.boostrapAnimResNode
	self._unHandlerStarted = nil

	self._boostrapAnimResNode:SetActive(true)

	self._amPlayer = AMPlayer.PlayUseSceneObjects(self._boostrapAnimResNode, BootstrapResPreLoad.animTakeName, true, self._handlePlayerEvent, self._handlerEvent, self, self, 1, false)
	self._amPlayer.autoClearRes = true

	if self._unHandlerStarted then
		self._unHandlerStarted = nil

		self:_onStart()
	end
end

function BootstrapLauncher:getBoostrapAnimResNode()
	return self._boostrapAnimResNode
end

function BootstrapLauncher:stopAnim()
	if self._amPlayer then
		self._amPlayer:Stop()

		self._amPlayer = nil
	end

	self._animCamera = nil
	self._saveCullingMask = nil

	if self._boostrapAnimResNode then
		self._boostrapAnimResNode:SetActive(false)
	end
end

function BootstrapLauncher:visibleAnim(visible)
	if not self._animCamera then
		return
	end

	self._animCamera.cullingMask = visible and self._saveCullingMask or 0
end

function BootstrapLauncher:_handlePlayerEvent(evtName, player)
	if evtName == "start" then
		self:_onStart(player)
	elseif evtName == "stop" then
		self:_onStop(player)
	end
end

function BootstrapLauncher:_onStart(player)
	if self._amPlayer then
		local gameStart = UnityEngine.GameObject.Find("UIROOT/GameStartBg/Image")

		gameStart:SetActive(false)
	else
		self._unHandlerStarted = true
	end
end

function BootstrapLauncher:_onStop(player)
	self._amPlayer = nil
end

function BootstrapLauncher:_handlerEvent(evtName, go, param1, param2, param3, param4, param5)
	if evtName == "Move" then
		go.transform.position = param1
	elseif evtName == "playSpinAnimation" then
		self:_onPlaySpineAnimation(go, param1, param2, param3, param4, param5)
	elseif evtName == "ActiveEffect" then
		go:SetActive(true)

		if string.find(go.name, "camera") then
			self._animCamera = go:GetComponent(typeof(UnityEngine.Camera))
			self._saveCullingMask = self._animCamera.cullingMask
		end
	elseif evtName == "DeActiveEffect" then
		go:SetActive(false)
	elseif evtName == "playanimator" then
		GoUtil.PlayAnimator(go, param1, param2)
	elseif evtName == "ShowUI" then
		self:showUITipByState(BootstrapConstdef.EBootstrapState.LoadUIPrefabSuccess)
		self:onLoadUIFinish()
	end
end

function BootstrapLauncher:_onPlaySpineAnimation(go, animName, loop, flipX, speed)
	GoUtil.PlaySpineAnim(go, animName, flipX, loop, true, speed)
end

BootstrapLauncher.instance = BootstrapLauncher.New()

BootstrapLauncher.instance:start()

return BootstrapLauncher
