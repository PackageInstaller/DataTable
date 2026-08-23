local UpgradeConst = require("upgrade.UpgradeConst")
local PackageResGroup = require("app.core.common.PackageResGroup")
local UpgradePackageSilent = require("upgrade.UpgradePackageSilent")
local var_0_3 = {
	WWISE = "wwise",
	KNIGHT = "knight",
	BATTLE = "battle"
}
local var_0_4 = {
	knight = 2,
	wwise = 3,
	battle = 1
}
local PackageResMgr = class("PackageResMgr")

function PackageResMgr:ctor()
	self._resDicNet = {}
	self._resDicLocal = {
		sub_package_enable = false,
		infoDic = {}
	}
	self.resType = var_0_3
	self._mainGroupList = {}
	self._curMainGroup = nil
	self._curTempGroup = nil
	self._isInit = false
	self._isRequestNetInfo = false
	self._waitNormalSilentFinish = false
end

function PackageResMgr:initPackageResMgr()
	if self._isInit then
		return
	end

	self._localFileName = g.core.common.GlobalFunc.contactParamByString("upgrade_package_info_", g.core.utils.Tools.getSilentObbVersion(), ".json")

	print(self._localFileName)
	self:_loadLocalPackageResDicItem()
	self:_initSilentCallback()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SILENT_UPGRADE_FINISH, handler(self, self._startDownloadMainGroupList), self)

	self._isInit = true
end

function PackageResMgr:_initSilentCallback()
	if not UpgradePackageSilent.isInit then
		UpgradePackageSilent.start((handler(self, self.onDownloadEventHandler)))
	end
end

function PackageResMgr:doRequestPackageInfo()
	if not self:isPackageEnable() or self._isRequestNetInfo then
		return false
	end

	self:_initSilentCallback()

	local UpgradeOut = require("upgrade.UpgradeOut")
	local var_4_1 = UpgradeOut.SILENT_UPGRADE_CONFIG
	local var_4_2 = ""

	if not config.USE_CDN_UPGRADE then
		var_4_1 = UpgradeOut.SILENT_UPGRADE_CONFIG_TEST
		var_4_2 = "_test"
	end

	var_4_1 = var_4_1 or g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] and g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].SILENT_UPGRADE_URL or UpgradeOut.SILENT_UPGRADE_JP

	UpgradePackageSilent.requestUrl(string.gsub(var_4_1, "upgrade[^/]*%.config$", table.concat({
		"upgrade_battle",
		var_4_2,
		".config"
	})), {
		type = g.core.common.PackageRes.resType.BATTLE
	})
	UpgradePackageSilent.requestUrl(string.gsub(var_4_1, "upgrade[^/]*%.config$", table.concat({
		"upgrade_knight",
		var_4_2,
		".config"
	})), {
		type = g.core.common.PackageRes.resType.KNIGHT
	})
	UpgradePackageSilent.requestUrl(string.gsub(var_4_1, "upgrade[^/]*%.config$", table.concat({
		"upgrade_wwise",
		var_4_2,
		".config"
	})), {
		type = g.core.common.PackageRes.resType.WWISE
	})

	self._isRequestNetInfo = true
end

function PackageResMgr:_loadLocalPackageResDicItem()
	local var_5_0 = g.core.common.Storage:load(self._localFileName, false)

	if var_5_0 then
		self._resDicLocal = var_5_0
		self._resDicLocal.infoDic = self._resDicLocal.infoDic or {}
	end
end

function PackageResMgr:saveLocalResDic()
	g.core.common.Storage:save(self._localFileName, self._resDicLocal, false)
end

function PackageResMgr:setPackageResDicItem(arg_7_1, arg_7_2)
	if not self._resDicNet[arg_7_1] then
		local var_7_0 = {}
		local var_7_1 = PackageResGroup.new(var_0_4[arg_7_1])

		var_7_1:setPause(true)

		for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
			local var_7_2 = iter_7_1.name:gsub(".zip", "")
			local var_7_3 = var_7_2:split("_")
			local var_7_4 = ""

			var_7_4 = var_7_2:find(var_0_3.WWISE) and var_7_3[2] or var_7_3[1]
			var_7_0[var_7_4] = iter_7_1

			if not self:_isNewerThanLocal(var_7_4, arg_7_1, var_7_0) then
				iter_7_1.unzip = true
				iter_7_1.finishedSize = iter_7_1.size
			end

			var_7_1:addPackageRes(var_7_4, arg_7_1, iter_7_1)
		end

		self._mainGroupList[#self._mainGroupList + 1] = var_7_1
		self._resDicNet[arg_7_1] = {
			itemMap = var_7_0,
			index = #self._mainGroupList + 1
		}
	end

	self:_checkIsStartMainGroup()
end

function PackageResMgr:_checkIsStartMainGroup()
	if #self._mainGroupList == table.nums(var_0_3) and not self._waitNormalSilentFinish and not self._curMainGroup then
		self:_startDownloadMainGroupList()
	end
end

function PackageResMgr:_startDownloadMainGroupList()
	if self._curMainGroup then
		return
	end

	table.sort(self._mainGroupList, function(arg_10_0, arg_10_1)
		return arg_10_0:getPriority() < arg_10_1:getPriority()
	end)
	self:_downloadNextMainGroup()
end

function PackageResMgr:_downloadNextMainGroup()
	self._waitNormalSilentFinish = false

	local var_11_0 = self:_getNextNeedDownloadMainGroup()

	if var_11_0 then
		var_11_0:setPause(false)

		for iter_11_0, iter_11_1 in ipairs((var_11_0:getNeedDownloadResItemList())) do
			self:addResInfoToDownloadList(iter_11_1)
		end

		self._curMainGroup = var_11_0
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_PACKAGE_LIST_DOWNLOAD_START, false)
end

function PackageResMgr:_getNextNeedDownloadMainGroup()
	local var_12_0

	for iter_12_0, iter_12_1 in ipairs(self._mainGroupList) do
		if not iter_12_1:isFinishAll() then
			var_12_0 = iter_12_1

			break
		end
	end

	return var_12_0
end

function PackageResMgr:_pauseMainGroup()
	for iter_13_0, iter_13_1 in ipairs(self._mainGroupList) do
		iter_13_1:setPause(true)
	end
end

function PackageResMgr:_resumeMainGroup()
	for iter_14_0, iter_14_1 in ipairs(self._mainGroupList) do
		if iter_14_1 == self._curMainGroup then
			iter_14_1:setPause(false)
		else
			iter_14_1:setPause(true)
		end
	end
end

function PackageResMgr:setPackageResDicItemSizeInfo(arg_15_1, arg_15_2, arg_15_3)
	if self._resDicNet[arg_15_1] then
		if arg_15_2 then
			self._resDicNet[arg_15_1].itemMap.totalSize = arg_15_2
		end

		if arg_15_3 then
			self._resDicNet[arg_15_1].itemMap.finishedSize = arg_15_3
		end
	end
end

function PackageResMgr:checkResListIsNeedUpgrade(arg_16_1)
	local var_16_0 = false
	local var_16_1

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		if self:checkResIsNeedUpgrade(iter_16_1.resId, iter_16_1.resType) then
			var_16_0 = true
			var_16_1 = self._curTempGroup:getGroupId()
		end
	end

	return var_16_0, var_16_1
end

function PackageResMgr:checkResIsNeedUpgrade(arg_17_1, arg_17_2, arg_17_3)
	if not self:isPackageEnable() or self._waitNormalSilentFinish or not (g.core.guide.GuideProxy:isGuideRunning() and g.core.model.User:getLevel() <= 7) then
		return false
	elseif not self._isRequestNetInfo then
		self:doRequestPackageInfo()

		return true
	elseif #self._mainGroupList ~= 3 then
		return true
	end

	arg_17_1 = tostring(arg_17_1)

	local var_17_0, var_17_1 = self:_isNewerThanLocal(arg_17_1, arg_17_2)
	local var_17_2

	if var_17_0 then
		if not arg_17_3 then
			if not self._curTempGroup then
				self._curTempGroup = PackageResGroup.new()

				g.core.common.Scheduler:newScheduleOnce(handler(self, self.onShowDownloadingPop), 0)
			end

			self._curTempGroup:addPackageRes(arg_17_1, arg_17_2, var_17_1)
			self:addWaitDownloadList(arg_17_1, arg_17_2, var_17_1, true)

			var_17_2 = self._curTempGroup:getGroupId()
		end
	elseif self._curTempGroup and self._curTempGroup:getResItemIndex(arg_17_1, arg_17_2) then
		var_17_0 = not self._curTempGroup:isResItemFinish(arg_17_1, arg_17_2)
		var_17_2 = self._curTempGroup:getGroupId()
	end

	return var_17_0, var_17_2
end

function PackageResMgr:_isNewerThanLocal(arg_18_1, arg_18_2, arg_18_3)
	if not self:isPackageEnable() then
		return false
	end

	arg_18_1 = tostring(arg_18_1)

	local var_18_0 = false

	arg_18_3 = arg_18_3 or self._resDicNet[arg_18_2].itemMap

	local var_18_1 = self._resDicLocal.infoDic[arg_18_2]

	if not arg_18_3 or (self._curTempGroup or nil) and self._curTempGroup:getResItemIndex(arg_18_1, arg_18_2) then
		return var_18_0
	end

	local var_18_3 = arg_18_3[arg_18_1]

	if var_18_1 and var_18_3 then
		if not var_18_1[arg_18_1] then
			var_18_0 = true
		elseif var_18_3.md5 ~= var_18_1[arg_18_1].md5 then
			var_18_0 = true
		end
	elseif var_18_3 then
		var_18_0 = true
	end

	return var_18_0, var_18_3
end

function PackageResMgr:getResMainGroupList()
	return self._mainGroupList
end

function PackageResMgr:addWaitDownloadList(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0 = self._curMainGroup and self._curMainGroup:getResItemIndex(arg_20_1, arg_20_2) or nil

	if (self:isDebugClose() or nil) and nil then
		UpgradePackageSilent.exchangeSilentUpgrade(arg_20_3, not arg_20_4)
	else
		UpgradePackageSilent.addSilentUpgrade(arg_20_3, not arg_20_4)
	end
end

function PackageResMgr:addResInfoToDownloadList(arg_21_1, arg_21_2)
	if self:isDebugClose() then
		return
	end

	UpgradePackageSilent.addSilentUpgrade(arg_21_1, not arg_21_2)
end

function PackageResMgr:deleteResInfoInLocalAndReDownload(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0

	if self._resDicLocal.infoDic[arg_22_2] then
		self._resDicLocal.infoDic[arg_22_2][arg_22_1] = nil
	end

	self:saveLocalResDic()

	if self._curTempGroup then
		var_22_0 = self._curTempGroup:getResItem(arg_22_1, arg_22_2)
	end

	if not var_22_0 then
		if self._curMainGroup then
			var_22_0 = self._curMainGroup:getResItem(arg_22_1, arg_22_2)
		end
	end

	if var_22_0 then
		var_22_0.unzip = false
		var_22_0.finishedSize = 0
	end

	if arg_22_3 then
		self:addResInfoToDownloadList(var_22_0, true)
	end
end

function PackageResMgr:onDownloadEventHandler(arg_23_1, arg_23_2)
	if arg_23_1 == UpgradeConst.EN_UI_SILENT.FETCH_URL then
		self:setPackageResDicItem(arg_23_2.params.extParam.type, arg_23_2.params.zipList)
		self:setPackageResDicItemSizeInfo(arg_23_2.params.extParam.type, arg_23_2.params.totalSize, arg_23_2.params.finishedSize)
	elseif arg_23_1 == UpgradeConst.EN_UI_SILENT.START then
		-- block empty
	elseif arg_23_1 == UpgradeConst.EN_UI_SILENT.PROGRESS then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_PACKAGE_LIST_DOWNLOAD_UPDATED, false)
	elseif arg_23_1 == UpgradeConst.EN_UI_SILENT.UNZIP_START then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_PACKAGE_LIST_DOWNLOAD_UPDATED, false)
	elseif arg_23_1 == UpgradeConst.EN_UI_SILENT.UNZIP_OK then
		self:onFinishDownloadItem(arg_23_2.pkg)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_PACKAGE_LIST_DOWNLOAD_UPDATED, false)

		if self._curTempGroup and self._curTempGroup:isFinishAll() then
			local var_23_0 = {
				param = arg_23_2,
				taskId = self._curTempGroup:getGroupId()
			}

			g.core.common.Scheduler:newScheduleOnce(handler(self, function(arg_24_0)
				cc.FileUtils:getInstance():purgeCachedEntries()
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_PACKAGE_LIST_DOWNLOAD_FINISH, false, var_23_0)

				arg_24_0._curTempGroup = nil

				arg_24_0:onHideDownloadingPop()
			end), 1)
		end
	elseif arg_23_1 == UpgradeConst.EN_UI_SILENT.FINISHED then
		self:_sendGetAward(self._curMainGroup:getCfg().id)
		self:_downloadNextMainGroup()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_PACKAGE_LIST_DOWNLOAD_UPDATED, false)
	elseif arg_23_1 == UpgradeConst.EN_UI_SILENT.ERROR and arg_23_2.customId and arg_23_2.customId == "-1" then
		local var_23_1 = arg_23_2.pkg
		local var_23_2 = arg_23_2.pkgName:gsub(".zip", "")
		local var_23_3 = var_23_2:split("_")
		local var_23_4 = ""
		local var_23_5 = var_23_3[2]

		if var_23_2:find(var_0_3.WWISE) then
			var_23_4 = var_23_3[2]
			var_23_5 = var_0_3.WWISE
		else
			var_23_4 = var_23_3[1]
		end

		self:deleteResInfoInLocalAndReDownload(var_23_4, var_23_5, var_23_1 ~= nil)
	end
end

function PackageResMgr:onFinishDownloadItem(arg_25_1)
	local var_25_0 = arg_25_1.name:gsub(".zip", "")
	local var_25_1 = var_25_0:split("_")
	local var_25_2 = ""
	local var_25_3 = ""

	if var_25_0:find(var_0_3.WWISE) then
		var_25_2 = var_25_1[2]
		var_25_3 = var_25_1[1]
	else
		var_25_2 = var_25_1[1]
		var_25_3 = var_25_1[2]
	end

	arg_25_1.unzip = true

	local var_25_4 = self._resDicLocal.infoDic[var_25_3]

	if not self._resDicLocal.infoDic[var_25_3] then
		self._resDicLocal.infoDic[var_25_3] = {}
		var_25_4 = self._resDicLocal.infoDic[var_25_3]
	end

	var_25_4[var_25_2] = arg_25_1

	self:saveLocalResDic()
end

function PackageResMgr:getCurMainDownloadInfo()
	return (self._curMainGroup or nil) and self._curMainGroup:getGroupSizeInfo()
end

function PackageResMgr:getCurTempDownloadingInfo()
	return (self._curTempGroup or nil) and self._curTempGroup:getGroupSizeInfo()
end

function PackageResMgr:getTaskIdByResIdAndResType(arg_28_1, arg_28_2)
	return (self._curTempGroup and self._curTempGroup:getResItemIndex(tostring(arg_28_1), arg_28_2) or nil) and self._curTempGroup:getGroupId()
end

function PackageResMgr:onShowDownloadingPop()
	self:_pauseMainGroup()
	g.core.layer.LayerManager:setDownloadingPopVisible(true)
end

function PackageResMgr:onHideDownloadingPop()
	self:_resumeMainGroup()
	g.core.layer.LayerManager:setDownloadingPopVisible(false)
end

function PackageResMgr:setPackageEnable(arg_31_1)
	self._resDicLocal.sub_package_enable = arg_31_1
	self._waitNormalSilentFinish = arg_31_1

	self:saveLocalResDic()
end

function PackageResMgr:isPackageEnable()
	return self._resDicLocal.sub_package_enable
end

function PackageResMgr:isDebugClose()
	return require("app.view.module.debug.common.DebugCommon").getDebugGlobalValueByKey("package_close")
end

function PackageResMgr:_autoCloseLoading()
	if self._debugTimer then
		return
	end

	self._debugTimer = g.core.common.Scheduler:newScheduleOnce(handler(self, function(arg_35_0)
		arg_35_0._curTempGroup = nil

		arg_35_0:onHideDownloadingPop()

		arg_35_0._debugTimer = nil
	end), 1)
end

function PackageResMgr:checkAndSendGetAward()
	for iter_36_0, iter_36_1 in ipairs(self._mainGroupList) do
		local var_36_0 = iter_36_1:getCfg()

		if iter_36_1:isFinishAll() and not g.core.model.User.splitDownloadData:isReceivedAwardById(var_36_0.id) then
			g.core.network.GameNetProxy:send_C2S_SplitDownload_Award({
				id = var_36_0.id
			})
		end
	end
end

function PackageResMgr:_sendGetAward(arg_37_1)
	if g.core.model.User:getId() == 0 then
		return
	end

	if not g.core.model.User.splitDownloadData:isReceivedAwardById(arg_37_1) then
		g.core.network.GameNetProxy:send_C2S_SplitDownload_Award({
			id = arg_37_1
		})
	end
end

return PackageResMgr
