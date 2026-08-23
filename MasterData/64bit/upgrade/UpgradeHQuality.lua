local var_0_0 = {}
local var_0_1 = uf.UpgradeManager
local UpgradeUtil = require("upgrade.UpgradeUtil")
local UpgradeConst = require("upgrade.UpgradeConst")

var_0_0.silentUpgradeDir = device.hqDirPath
var_0_0.upgradeUrl = nil
var_0_0.zipList = {}
var_0_0.localStorage = {}
var_0_0._checkZipList = {}
var_0_0._isSilentSync = false
var_0_0._isAllFinish = true
var_0_0._downloadPkgDict = {}
var_0_0._needDownloadList = {}
var_0_0._extraUrl = ""

function var_0_0.start(arg_1_0)
	if not config.UPGRADE_HQUALITY_ENABLED or not arg_1_0 then
		return
	end

	var_0_0._dispatchDownloadEvent("收到下载请求：" .. table.nums(arg_1_0))

	if var_0_0._isAllFinish then
		var_0_0._isSilentSync = false
	end

	if not var_0_0._isSilentSync then
		var_0_0._checkZipList = arg_1_0 or {}

		var_0_0._initSilentUpgrade()
		var_0_0._fetchSilentUpgradeInfo(config.HQUALITY_UPGRADE_CONFIG .. "?t=" .. os.time())

		var_0_0._isSilentSync = true
	elseif var_0_0.upgradeUrl then
		var_0_0._checkZipList = arg_1_0 or {}

		local var_1_0 = var_0_0._getNeedDownLoadList()

		for iter_1_0 = 1, #var_1_0 do
			table.insert(var_0_0._needDownloadList, var_1_0[iter_1_0])
		end

		var_0_0._dispatchDownloadEvent("实际二次下载请求：" .. #var_1_0)
	else
		g.core.platform.BuglyProxy:error("UpgradeHQuality download url error !")
	end
end

function var_0_0._initSilentUpgrade()
	cc.FileUtils:getInstance():createDirectory(var_0_0.silentUpgradeDir)

	var_0_0.localStorage = g.core.common.Storage:load("upgrade_hquality.json", false) or {}
end

function var_0_0._fetchSilentUpgradeInfo(arg_3_0, arg_3_1)
	if not config.UPGRADE_HQUALITY_ENABLED then
		return
	end

	UpgradeUtil.httpGet(arg_3_0, function(arg_4_0)
		var_0_0._startSilentUpgrade(arg_4_0)
	end, function(arg_5_0)
		var_0_0._dispatchDownloadEvent(UpgradeConst.EN_UI_SILENT.ERROR, {
			customId = "404"
		})
		g.core.common.Scheduler:newScheduleOnce(function()
			var_0_0._fetchSilentUpgradeInfo(arg_3_0)
		end, arg_3_1 and checkint(arg_3_1) + 1 or 1)
	end)
end

function var_0_0:_startSilentUpgrade()
	if not self or not self.zip_list then
		g.core.platform.BuglyProxy:error("UpgradeHQuality get upgrade.config error !")

		return
	end

	var_0_0._getSilentUpgradeInfo(self)

	var_0_0._needDownloadList = var_0_0._getNeedDownLoadList()

	var_0_0._dispatchDownloadEvent("实际首次下载请求：" .. #var_0_0._needDownloadList)

	if table.nums(var_0_0._needDownloadList) <= 0 then
		return var_0_0._upgradeFinish(true)
	end

	var_0_0._isAllFinish = false

	var_0_0._startNextSilentUpgradeTask()
end

function var_0_0:_getSilentUpgradeInfo()
	local var_8_0 = {}
	local var_8_1 = string.gsub(config.HQUALITY_UPGRADE_CONFIG, "/upgrade.config", "")

	table.insert(var_8_0, var_8_1)

	if string.find(var_8_1, "wx-studio") then
		table.insert(var_8_0, (string.gsub(var_8_1, "cdn-wx-studio", "res-wx-studio")))
	end

	var_0_0.upgradeUrl = var_8_0[math.random(1, table.nums(var_8_0))]
	var_0_0.zipList = self.zip_list
end

function var_0_0._getNeedDownLoadList()
	local var_9_0 = {}
	local var_9_1, var_9_2 = g.core.platform.PlatformProxy:getVersion()

	if table.nums(var_0_0._checkZipList) > 0 then
		for iter_9_0, iter_9_1 in ipairs(var_0_0.zipList) do
			if iter_9_1.name and var_0_0._checkIsInCheckList(iter_9_1.name) then
				iter_9_1.path = (var_0_0.silentUpgradeDir .. "/download/") .. iter_9_1.name

				if var_0_0.localStorage[iter_9_1.name] and var_0_0.localStorage[iter_9_1.name] == iter_9_1.md5 then
					-- block empty
				else
					iter_9_1.url = var_0_0.upgradeUrl .. "/" .. iter_9_1.name .. "?v=" .. var_9_1 .. var_0_0._extraUrl

					table.insert(var_9_0, iter_9_1)
				end
			end
		end
	end

	return var_9_0
end

function var_0_0._checkIsInCheckList(arg_10_0)
	return true
end

function var_0_0._startNextSilentUpgradeTask(arg_11_0)
	local var_11_0 = table.remove(var_0_0._needDownloadList)

	if not var_11_0 then
		var_0_0._upgradeFinish(true)

		return
	end

	var_0_1:getInstance():reset()

	var_0_0._downloadPkgDict[var_11_0.name] = var_11_0

	var_0_1:getInstance():addDownloadTask(var_11_0.url, var_11_0.name, function()
		var_0_0.onDownloadEvent(...)
	end, var_11_0.md5, var_11_0.path)
	var_0_1:getInstance():startDownload()
end

function var_0_0._upgradeFinish(arg_13_0)
	g.core.common.Storage:save("upgrade_hquality.json", var_0_0.localStorage, false)

	if arg_13_0 then
		var_0_0._isAllFinish = true

		var_0_0._dispatchDownloadEvent(UpgradeConst.EN_UI_SILENT.FINISHED)
	end
end

function var_0_0.onDownloadEvent(arg_14_0, arg_14_1)
	if arg_14_0 == var_0_1.Event_Start then
		var_0_0._onDownloadStart(arg_14_1)
	elseif arg_14_0 == var_0_1.Event_Progress then
		var_0_0._onDownloadProgress(arg_14_1)
	elseif arg_14_0 == var_0_1.Event_Finish then
		var_0_0._onDownloadFinish(arg_14_1)
	elseif arg_14_0 == var_0_1.Event_Unzip then
		var_0_0._onPackageUnzip(arg_14_1)
	elseif arg_14_0 == var_0_1.Event_Exception then
		var_0_0._onDownloadException(arg_14_1)
	end
end

function var_0_0._dispatchDownloadEvent(arg_15_0, arg_15_1)
	do return end

	if arg_15_1 then
		local var_15_0 = arg_15_1.name or ""

		if type(arg_15_0) == "string" then
			dump(arg_15_0)
		elseif arg_15_0 == UpgradeConst.EN_UI_SILENT.START then
			dump("开始下载高清资源：" .. var_15_0)
		elseif arg_15_0 == UpgradeConst.EN_UI_SILENT.PROGRESS then
			dump("下载高清资源完成：" .. var_15_0)
		elseif arg_15_0 == UpgradeConst.EN_UI_SILENT.UNZIP_START then
			dump("开始解压高清资源：" .. ((arg_15_1 or nil) and (arg_15_1.filePath or "")))
		elseif arg_15_0 == UpgradeConst.EN_UI_SILENT.UNZIP_OK then
			dump("解压高清资源完成：" .. var_15_0)
		elseif arg_15_0 == UpgradeConst.EN_UI_SILENT.FINISHED then
			dump("高清资源全部下载解压完成")
		elseif arg_15_0 == UpgradeConst.EN_UI_SILENT.ERROR then
			dump("高清资源下载解压错误：" .. var_15_0 .. " error：" .. ((arg_15_1 or nil) and (arg_15_1.customId or "")))
		end
	end
end

function var_0_0:_onDownloadStart()
	var_0_0._dispatchDownloadEvent(UpgradeConst.EN_UI_SILENT.START, {
		name = self and self.customId
	})
end

function var_0_0._onDownloadProgress(arg_17_0)
	return
end

function var_0_0:_onDownloadFinish()
	local var_18_0 = var_0_0._downloadPkgDict[self and self.customId]

	if self and var_0_0._downloadPkgDict[self and self.customId] then
		g.core.common.Scheduler:newScheduleOnce(function()
			var_0_0._delayToUnzipPkg(var_18_0.path)
		end, 0.4)
	end
end

function var_0_0._delayToUnzipPkg(arg_20_0)
	var_0_1:getInstance():unzipPackage(arg_20_0, function(arg_21_0)
		var_0_0._dispatchDownloadEvent(UpgradeConst.EN_UI_SILENT.UNZIP_OK, {
			name = arg_21_0 and arg_21_0.customId
		})
		var_0_0.onDownloadEvent(var_0_1.Event_Unzip, arg_21_0)
	end, var_0_0.silentUpgradeDir)
	var_0_0._dispatchDownloadEvent(UpgradeConst.EN_UI_SILENT.UNZIP_START, {
		filePath = arg_20_0
	})
end

function var_0_0:_onPackageUnzip()
	if self.finish and self.ret then
		local var_22_0 = string.gsub(self.path, ".*/download/", "")

		if var_0_0._downloadPkgDict[var_22_0] == nil then
			return
		end

		var_0_0.localStorage[var_22_0] = var_0_0._downloadPkgDict[var_22_0].md5

		var_0_0._upgradeFinish(false)
		var_0_0._dispatchDownloadEvent(UpgradeConst.EN_UI_SILENT.PROGRESS, {
			name = var_0_0._downloadPkgDict[var_22_0].name
		})

		var_0_0._downloadPkgDict[var_22_0] = nil

		var_0_0._startNextSilentUpgradeTask()

		return
	end

	if not self.ret then
		var_0_0._delayToUnzipPkg(self.path)
	else
		g.core.platform.BuglyProxy:error("UpgradeHQuality unzip error : param.finish = " .. tostring(self.finish) .. " param.path = " .. self.path)

		local var_22_1 = string.gsub(self.path, ".*/download/", "")

		if var_0_0._downloadPkgDict[var_22_1] == nil then
			return
		end

		table.insert(var_0_0._needDownloadList, var_0_0._downloadPkgDict[var_22_1])

		var_0_0._downloadPkgDict[var_22_1] = nil

		var_0_0._startNextSilentUpgradeTask()
	end
end

function var_0_0:_onDownloadException()
	local var_23_0 = self and self.customId

	table.insert(var_0_0._needDownloadList, var_0_0._downloadPkgDict[self and self.customId])
	var_0_0._dispatchDownloadEvent(UpgradeConst.EN_UI_SILENT.ERROR, {
		customId = "408",
		name = var_23_0
	})

	var_0_0._downloadPkgDict[var_23_0] = nil

	g.core.common.Scheduler:newScheduleOnce(function()
		var_0_0._startNextSilentUpgradeTask()
	end, 2)
end

return var_0_0
