local var_0_0 = {}
local var_0_1 = uf.UpgradeManager
local UpgradeOut = require("upgrade.UpgradeOut")
local UpgradeUtil = require("upgrade.UpgradeUtil")
local UpgradeConst = require("upgrade.UpgradeConst")

var_0_0.silentUpgradeDir = device.obbDirPath
var_0_0.silentDownloadDir = var_0_0.silentUpgradeDir .. "/download/"
var_0_0.localStorage = {}
var_0_0.localSilentInfo = {}
var_0_0._callback = nil
var_0_0._isSilentSync = false
var_0_0._downloadPkgDict = {}
var_0_0._totalSize = 0
var_0_0._finishedSize = 0
var_0_0._needDownloadList = {}
var_0_0._curUnzipInfo = nil
var_0_0._isDeleteing = false
var_0_0._waitUnzipPath = nil
var_0_0._curPkg = nil
var_0_0._setPause = false
var_0_0._isPause = false
var_0_0._downloadState = nil
var_0_0._silentVersion = config.GAME_VERSION_NO

function var_0_0.start(arg_1_0)
	if not config.UPGRADE_SILENT_ENABLED or var_0_0._isSilentClosed() then
		return
	end

	var_0_0._silentVersion = g.core.utils.Tools.getSilentObbVersion()
	var_0_0._callback = arg_1_0 or var_0_0._callback
	var_0_0._statsProTab = {}

	if not var_0_0._isSilentSync then
		var_0_0._initSilentUpgrade()

		if not var_0_0._checkForUpgrade() then
			return
		end

		var_0_0.checkShowNoWifiTip()

		local var_1_0 = UpgradeOut.SILENT_UPGRADE_CONFIG

		if not config.USE_CDN_UPGRADE then
			var_1_0 = UpgradeOut.SILENT_UPGRADE_CONFIG_TEST
		end

		var_1_0 = var_1_0 or g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] and g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].SILENT_UPGRADE_URL or UpgradeOut.SILENT_UPGRADE_JP

		var_0_0._fetchSilentUpgradeInfo((string.gsub(var_1_0, "#silent_version#", var_0_0._silentVersion)))

		var_0_0._isSilentSync = true
	end
end

function var_0_0.checkShowNoWifiTip()
	if g.core.platform.PlatformProxy:isWIFIState() then
		return
	end

	if var_0_0.localSilentInfo.wifiTips then
		return
	end

	var_0_0.localSilentInfo.wifiTips = true

	g.core.common.Storage:save("upgrade_silent_info_" .. var_0_0._silentVersion .. ".json", var_0_0.localSilentInfo, false)
	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
		type = 0,
		title = g.core.lang:get(1257),
		text = g.core.lang:get(100047),
		text_ok = g.core.lang:get(101506),
		text_cancel = g.core.lang:get(101507)
	}), {
		blackOpacity = 0,
		ignoreTouch = true
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
		event_id = g.core.const.ConstMgr.SuperSdkConst.SILENT_LOAD_WIFI_TIP
	})
end

function var_0_0.showUpgradeTip(arg_3_0)
	if not var_0_0._checkForUpgrade(arg_3_0) then
		return
	end

	local var_3_0 = g.core.platform.PlatformProxy:isWIFIState() and g.core.lang:get(100001) or ""
	local var_3_1
	local var_3_2

	if var_0_0._totalSize - var_0_0._finishedSize > 1 then
		var_3_1 = g.core.lang:get(100002, {
			size = g.core.utils.Number.toMemoryShortSize(var_0_0._totalSize - var_0_0._finishedSize),
			wifi = var_3_0
		})
	else
		var_3_1 = g.core.lang:get(100048, {
			wifi = var_3_0
		})
		var_3_2 = require("app.view.base.component.BaseAssistPopComp").new
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
		type = 1,
		title = g.core.lang:get(100003),
		text = var_3_1,
		text_cancel = g.core.lang:get(100006),
		handler_cancel = function()
			g.core.layer.LayerManager:clearIosDownObj()
			var_0_0._showUpgradePop(arg_3_0)
		end
	}), {
		ignoreTouch = true
	})
end

function var_0_0._checkForUpgrade(arg_5_0)
	if not config.UPGRADE_SILENT_ENABLED or var_0_0.localSilentInfo.isAllFinished or var_0_0._isSilentClosed() then
		if arg_5_0 then
			arg_5_0()
		end

		return false
	end

	return true
end

function var_0_0.isNeedUpgrade()
	if not config.UPGRADE_SILENT_ENABLED or var_0_0._isSilentClosed() then
		return
	end

	var_0_0._silentVersion = g.core.utils.Tools.getSilentObbVersion()

	if not var_0_0._isSilentSync then
		var_0_0._initSilentUpgrade()
	end

	return not var_0_0._isSilentSync and var_0_0._checkForUpgrade()
end

function var_0_0._showUpgradePop(arg_7_0)
	if not var_0_0._checkForUpgrade(arg_7_0) then
		return
	end

	var_0_0._upgradeLayer = g.core.module.ModuleManager:pushModule(g.view.entrance.SILENT_UPGRADE)

	var_0_0._upgradeLayer:startSilentUpgrade(arg_7_0)
	var_0_0._onDownloadStart()

	if var_0_0._curUnzipInfo then
		var_0_0._dispatchDownloadEvent(UpgradeConst.EN_UI_SILENT.UNZIP_START, var_0_0._curUnzipInfo)
	end
end

function var_0_0._initSilentUpgrade()
	cc.FileUtils:getInstance():createDirectory(var_0_0.silentUpgradeDir)

	var_0_0.localSilentInfo = g.core.common.Storage:load("upgrade_silent_info_" .. var_0_0._silentVersion .. ".json", false) or {}
	var_0_0.localStorage = g.core.common.Storage:load("upgrade_silent_" .. var_0_0._silentVersion .. ".json", false) or {}

	if not var_0_0._checkFullDownload() then
		if var_0_0.localSilentInfo.isAllFinished then
			g.core.platform.BuglyProxy:error("old user silent download error!")
		end

		var_0_0.localSilentInfo.isAllFinished = false
	end

	if not next(var_0_0.localStorage) and var_0_0._silentVersion == config.GAME_VERSION_NO then
		if cc.FileUtils:getInstance():isDirectoryExist(var_0_0.silentUpgradeDir .. "res/") then
			var_0_0._isDeleteing = true

			var_0_1:getInstance():removePathAsync(var_0_0.silentUpgradeDir .. "res/", function()
				var_0_0._isDeleteing = false

				if var_0_0._waitUnzipPath then
					var_0_0._delayToUnzipPkg2(var_0_0._waitUnzipPath)
				end
			end)
		end
	end
end

function var_0_0._fetchSilentUpgradeInfo(arg_10_0, arg_10_1)
	if not config.UPGRADE_SILENT_ENABLED then
		return
	end

	UpgradeUtil.httpGet(arg_10_0, function(arg_11_0)
		var_0_0._startSilentUpgrade(arg_11_0)
	end, function(arg_12_0)
		var_0_0._dispatchDownloadEvent(UpgradeConst.EN_UI_SILENT.ERROR, {
			customId = "404"
		})
		g.core.common.Scheduler:newScheduleOnce(function()
			var_0_0._fetchSilentUpgradeInfo(arg_10_0)
		end, arg_10_1 and checkint(arg_10_1) + 1 or 1)
	end)
end

function var_0_0:_startSilentUpgrade()
	if not self or not self[tostring(var_0_0._silentVersion)] then
		g.core.module.ModuleManager:tip((g.core.lang:get(100010, {
			errcode = var_0_0._silentVersion
		})))

		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
		event_id = g.core.const.ConstMgr.SuperSdkConst.SILENT_LOAD_START
	})

	local var_14_0, var_14_1, var_14_2 = var_0_0._getSilentUpgradeInfo(self)

	var_0_0._totalSize = var_14_0
	var_0_0._finishedSize = var_14_1
	var_0_0._needDownloadList = var_14_2

	if var_14_0 <= var_14_1 and table.nums(var_14_2) <= 0 then
		return var_0_0._upgradeFinish(true)
	end

	var_0_0._onStatsFinishSize()
	var_0_0._startNextSilentUpgradeTask()
end

function var_0_0:_getSilentUpgradeInfo()
	local var_15_0 = 0
	local var_15_1 = 0
	local var_15_2 = {}
	local var_15_3 = {}

	table.insert(var_15_3, (string.gsub(self.upgrade_url, "#silent_version#", var_0_0._silentVersion)))
	table.insert(var_15_3, (string.gsub(self.upgrade_url2, "#silent_version#", var_0_0._silentVersion)))

	local var_15_4 = var_15_3[math.random(1, table.nums(var_15_3))]

	for iter_15_0, iter_15_1 in ipairs(self[tostring(var_0_0._silentVersion)]) do
		if iter_15_1.name then
			var_15_0 = var_15_0 + iter_15_1.size
			iter_15_1.path = var_0_0.silentDownloadDir .. iter_15_1.name

			if var_0_0.localStorage[iter_15_1.name] then
				var_15_1 = var_15_1 + iter_15_1.size
			else
				iter_15_1.finishedSize = 0
				iter_15_1.url = var_15_4 .. "/" .. iter_15_1.name

				table.insert(var_15_2, iter_15_1)
			end
		end
	end

	if self.silent_knight_sub_package then
		g.core.common.PackageRes:setPackageEnable(self.silent_knight_sub_package == var_0_0._silentVersion)
		g.core.common.PackageRes:doRequestPackageInfo()
	end

	return var_15_0, var_15_1, var_15_2
end

function var_0_0._upgradeFinish(arg_16_0)
	g.core.common.Storage:save("upgrade_silent_" .. var_0_0._silentVersion .. ".json", var_0_0.localStorage, false)

	if arg_16_0 then
		if var_0_0._checkFullDownload() then
			var_0_0.localSilentInfo.isAllFinished = true
		else
			g.core.platform.BuglyProxy:error("new user silent download error!")

			var_0_0.localSilentInfo.isAllFinished = false
		end

		g.core.common.Storage:save("upgrade_silent_info_" .. var_0_0._silentVersion .. ".json", var_0_0.localSilentInfo, false)
		g.core.common.Scheduler:newScheduleOnce(function()
			var_0_0._dispatchDownloadEvent(UpgradeConst.EN_UI_SILENT.FINISHED)

			if var_0_0._upgradeLayer then
				var_0_0._upgradeLayer:removeFromParent()
			end

			g.core.layer.LayerManager:clearIosDownObj()

			var_0_0._upgradeLayer = nil
			var_0_0._callback = nil

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SILENT_UPGRADE_FINISH, false)
		end, 1)
		var_0_0._onStatsFinishSize()
	end
end

function var_0_0._startNextSilentUpgradeTask(arg_18_0)
	local var_18_0 = table.remove(var_0_0._needDownloadList)

	if not var_18_0 then
		var_0_0._upgradeFinish(true)

		return
	end

	if var_0_0._setPause then
		table.insert(var_0_0._needDownloadList, var_18_0)

		var_0_0._isPause = true

		return
	end

	var_0_1:getInstance():reset()

	var_0_0._curPkg = var_18_0
	var_0_0._downloadPkgDict[var_18_0.name] = var_18_0

	var_0_1:getInstance():addDownloadTask(var_18_0.url, var_18_0.name, function()
		var_0_0.onDownloadEvent(...)
	end, var_18_0.md5, var_18_0.path)
	var_0_1:getInstance():startDownload()
end

function var_0_0.onDownloadEvent(arg_20_0, arg_20_1)
	var_0_0._downloadState = arg_20_0

	if arg_20_0 == var_0_1.Event_Start then
		var_0_0._onDownloadStart(arg_20_1)
	elseif arg_20_0 == var_0_1.Event_Progress then
		var_0_0._onDownloadProgress(arg_20_1)
	elseif arg_20_0 == var_0_1.Event_Finish then
		var_0_0._onDownloadFinish(arg_20_1)
	elseif arg_20_0 == var_0_1.Event_Unzip then
		var_0_0._onPackageUnzip(arg_20_1)
	elseif arg_20_0 == var_0_1.Event_Exception then
		var_0_0._onDownloadException(arg_20_1)
	end
end

function var_0_0._calculateFinishedSize()
	local var_21_0 = var_0_0._finishedSize

	for iter_21_0, iter_21_1 in pairs(var_0_0._downloadPkgDict) do
		var_21_0 = var_21_0 + iter_21_1.finishedSize
	end

	return {
		finish = var_21_0,
		total = var_0_0._totalSize
	}
end

function var_0_0._dispatchDownloadEvent()
	if var_0_0._callback then
		var_0_0._callback(...)
	end
end

function var_0_0._onDownloadStart()
	var_0_0._dispatchDownloadEvent(UpgradeConst.EN_UI_SILENT.START, (var_0_0._calculateFinishedSize()))
end

function var_0_0:_onDownloadProgress()
	if self and var_0_0._downloadPkgDict[self and self.customId] then
		local var_24_0 = self.finish or 0

		if var_24_0 <= (var_0_0._downloadPkgDict[self and self.customId].finishedSize or 0) then
			return
		end

		var_0_0._downloadPkgDict[self and self.customId].finishedSize = var_24_0

		var_0_0._dispatchDownloadEvent(UpgradeConst.EN_UI_SILENT.PROGRESS, (var_0_0._calculateFinishedSize()))
	end
end

function var_0_0:_onDownloadFinish()
	local var_25_0 = var_0_0._downloadPkgDict[self and self.customId]

	if self and var_0_0._downloadPkgDict[self and self.customId] then
		g.core.common.Scheduler:newScheduleOnce(function()
			if var_0_0._checkDownloadPkgMD5(var_25_0) then
				var_0_0._delayToUnzipPkg(var_25_0.path)
			end
		end, 0.4)
	end
end

function var_0_0._checkDownloadPkgMD5(arg_27_0)
	return true
end

function var_0_0._delayToUnzipPkg(arg_28_0)
	if var_0_0._isDeleteing then
		var_0_0._waitUnzipPath = arg_28_0
	else
		var_0_0._delayToUnzipPkg2(arg_28_0)
	end
end

function var_0_0._delayToUnzipPkg2(arg_29_0)
	var_0_0._waitUnzipPath = nil

	var_0_1:getInstance():unzipPackage(arg_29_0, function(arg_30_0)
		var_0_0._dispatchDownloadEvent(UpgradeConst.EN_UI_SILENT.UNZIP_OK)

		var_0_0._curUnzipInfo = nil

		var_0_0.onDownloadEvent(var_0_1.Event_Unzip, arg_30_0)
	end, var_0_0.silentUpgradeDir)

	var_0_0._curUnzipInfo = {
		startTime = os.time(),
		filePath = arg_29_0
	}

	var_0_0._dispatchDownloadEvent(UpgradeConst.EN_UI_SILENT.UNZIP_START, var_0_0._curUnzipInfo)
end

function var_0_0:_onPackageUnzip()
	if self.finish and self.ret then
		local var_31_0 = string.gsub(self.path, ".*/download/", "")

		if var_0_0._downloadPkgDict[var_31_0] == nil then
			return
		end

		var_0_0.localStorage[var_31_0] = true

		var_0_0._upgradeFinish(false)

		var_0_0._finishedSize = var_0_0._finishedSize + var_0_0._downloadPkgDict[var_31_0].finishedSize
		var_0_0._downloadPkgDict[var_31_0] = nil

		var_0_0._onStatsFinishSize()
		var_0_0._startNextSilentUpgradeTask()

		return
	end

	if not self.ret then
		var_0_0._delayToUnzipPkg(self.path)
	else
		g.core.platform.BuglyProxy:error("UpgradeSilent unzip error : param.finish = " .. tostring(self.finish) .. " param.path = " .. self.path)

		local var_31_1 = string.gsub(self.path, ".*/download/", "")

		if var_0_0._downloadPkgDict[var_31_1] == nil then
			return
		end

		table.insert(var_0_0._needDownloadList, var_0_0._downloadPkgDict[var_31_1])

		var_0_0._downloadPkgDict[var_31_1] = nil

		var_0_0._startNextSilentUpgradeTask()
	end
end

function var_0_0:_onDownloadException()
	local var_32_0 = self and self.customId

	table.insert(var_0_0._needDownloadList, var_0_0._downloadPkgDict[self and self.customId])
	var_0_0._dispatchDownloadEvent(UpgradeConst.EN_UI_SILENT.ERROR, {
		customId = "408"
	})

	var_0_0._downloadPkgDict[var_32_0] = nil

	if var_0_0._isPause then
		return
	end

	g.core.common.Scheduler:newScheduleOnce(function()
		var_0_0._startNextSilentUpgradeTask()
	end, 2)
end

function var_0_0._onStatsFinishSize()
	local var_34_0 = math.floor(var_0_0._finishedSize / var_0_0._totalSize * 100 / 10) * 10

	if var_34_0 > 0 and not var_0_0._statsProTab[var_34_0] then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
			event_id = g.core.const.ConstMgr.SuperSdkConst["SILENT_LOAD_PERCENT" .. var_34_0]
		})

		var_0_0._statsProTab[var_34_0] = true
	end
end

function var_0_0.setPause(arg_35_0)
	if arg_35_0 then
		var_0_0._setPause = true

		if var_0_0._downloadState and (var_0_0._downloadState == var_0_1.Event_Start or var_0_0._downloadState == var_0_1.Event_Progress) then
			var_0_0._isPause = true

			if var_0_0._curPkg then
				table.insert(var_0_0._needDownloadList, var_0_0._curPkg)

				var_0_0._downloadPkgDict[var_0_0._curPkg.name] = nil
			end

			var_0_1:getInstance():stopDownload()
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
			event_id = g.core.const.ConstMgr.SuperSdkConst.SILENT_LOAD_PAUSE
		})
	else
		var_0_0._setPause = false

		if var_0_0._isPause then
			var_0_0._startNextSilentUpgradeTask()
		end

		var_0_0._isPause = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
			event_id = g.core.const.ConstMgr.SuperSdkConst.SILENT_LOAD_START
		})
	end
end

function var_0_0._isSilentClosed()
	local var_36_0 = g.core.common.Storage:load("silent_close_state.json", false)

	return var_36_0 and var_36_0.open
end

function var_0_0._checkFullDownload()
	local var_37_0 = g.core.const.ConstMgr.PlatformConst.SILENT_VER_NUM["v" .. var_0_0._silentVersion]

	if not g.core.const.ConstMgr.PlatformConst.SILENT_VER_NUM["v" .. var_0_0._silentVersion] then
		return true
	end

	local var_37_1 = 0

	for iter_37_0, iter_37_1 in pairs(g.core.common.Storage:load("upgrade_silent_" .. var_0_0._silentVersion .. ".json", false) or {}) do
		if iter_37_1 == true then
			var_37_1 = var_37_1 + 1
		end
	end

	return var_37_0 <= var_37_1
end

function var_0_0.isFullDownload()
	return var_0_0.localSilentInfo.isAllFinished
end

return var_0_0
