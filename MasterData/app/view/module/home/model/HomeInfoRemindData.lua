local var_0_0 = 60
local var_0_1 = g.core.config.point_info
local HomeConst = require("app.view.module.home.const.HomeConst")
local var_0_4 = 2
local var_0_5 = g.core.common.ServerTime
local var_0_6 = g.core.model.User.homeInfoRemindRewardData
local var_0_7 = g.core.model.User.homeInfoRemindTaskTimesData
local var_0_8 = g.core.model.User.homeInfoRemindOthersData
local HomeInfoRemindData = class("HomeInfoRemindData")

function HomeInfoRemindData:ctor()
	self:initData()
end

function HomeInfoRemindData:initData()
	self._infoCfg = {}
	self._infoMapData = {}
	self._setConfig = {}
	self._clickRecordConfig = {}
	self._setRecordData = {}
	self._isInitInfoData = false
	self._tipDataMap = {}
	self._tipDataUidMap = {}
	self._tipSelectMap = nil
	self._tipLocalData = nil
	self._viewTipMap = nil
	self._newTipCnt = 0

	self:_initData()
	self:updateTabData()

	self._lastUpdateTimes = nil
end

function HomeInfoRemindData:_initData()
	self._newTipCnt = 0

	for iter_3_0 = 1, var_0_1.getLength() do
		local var_3_0 = var_0_1.indexOf(iter_3_0).toObject()

		self._infoCfg[var_3_0.type] = self._infoCfg[var_3_0.type] or {}

		table.insert(self._infoCfg[var_3_0.type], var_3_0)
	end

	self:_loadLocalTipData()
	self:_loadTipSelectData()
	self:_loadViewTipMapData()
end

function HomeInfoRemindData:updateInfoRemindData()
	self._infoMapData = {}

	for iter_4_0 = 1, 3 do
		local var_4_0 = iter_4_0

		if not self._infoMapData[iter_4_0] then
			self._infoMapData[var_4_0] = {}
		end

		local var_4_1 = clone(self._infoCfg[var_4_0])
		local var_4_2 = {}

		if iter_4_0 == HomeConst.INFO_REMIND_TYPE.REWARD then
			var_4_2 = var_0_6:updateCurInfoRemindData(var_4_1)
		elseif iter_4_0 == HomeConst.INFO_REMIND_TYPE.TIMES then
			var_4_2 = var_0_7:updateCurInfoRemindData(var_4_1)
		elseif iter_4_0 == HomeConst.INFO_REMIND_TYPE.OTHERS then
			var_4_2 = var_0_8:updateCurInfoRemindData(var_4_1)
		end

		self._infoMapData[var_4_0] = var_4_2
	end

	self._isInitInfoData = true
end

function HomeInfoRemindData:judgeShowOneKey()
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(self._infoMapData[HomeConst.INFO_REMIND_TYPE.REWARD]) do
		if iter_5_1.state and iter_5_1.state > 0 then
			var_5_0 = var_5_0 + 1

			if var_5_0 >= var_0_4 then
				return true
			end
		end
	end

	return false
end

function HomeInfoRemindData:getInfoDataByType(arg_6_1)
	if not arg_6_1 or not self._infoMapData[arg_6_1] then
		return {}
	end

	table.sort(self._infoMapData[arg_6_1], function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0.showLight or 0
		local var_7_1 = arg_7_1.showLight or 0

		if var_7_0 ~= var_7_1 then
			return var_7_1 < var_7_0
		end

		if arg_7_0.num ~= arg_7_1.num then
			return arg_7_0.num > arg_7_1.num
		end

		return arg_7_0.cfgInfo.sort < arg_7_1.cfgInfo.sort
	end)

	return self._infoMapData[arg_6_1]
end

function HomeInfoRemindData:_getInfoCfgById(arg_8_1, arg_8_2)
	if self._infoCfg[arg_8_1] then
		for iter_8_0, iter_8_1 in ipairs(self._infoCfg[arg_8_1]) do
			if iter_8_1.id == arg_8_2 then
				return clone(iter_8_1)
			end
		end
	end
end

function HomeInfoRemindData:showAwardTypeRedPoint()
	local var_9_0 = self:getInfoDataByType(HomeConst.INFO_REMIND_TYPE.REWARD)

	if #var_9_0 < 0 then
		return false
	end

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if iter_9_1.state == 1 then
			return true
		end
	end

	return false
end

function HomeInfoRemindData:showTipBtnRedPoint()
	self:updateInfoRemindData()

	if self:showAwardTypeRedPoint() then
		return true
	end

	if #self._infoMapData[HomeConst.INFO_REMIND_TYPE.TIMES] > 0 and not self:judgeHomeInfoHasClick(HomeConst.INFO_REMIND_TYPE.TIMES) or #self._infoMapData[HomeConst.INFO_REMIND_TYPE.OTHERS] > 0 and not self:judgeHomeInfoHasClick(HomeConst.INFO_REMIND_TYPE.OTHERS) then
		return true
	end

	return false
end

function HomeInfoRemindData:updateTabData()
	self._setRecordData = {}

	for iter_11_0 = 1, 3 do
		local var_11_0 = {
			isChoose = self:judgeHomeInfoRemindSetting(iter_11_0)
		}
		local var_11_1

		if iter_11_0 == HomeConst.INFO_REMIND_TYPE.REWARD then
			var_11_1 = 100530
		elseif iter_11_0 == HomeConst.INFO_REMIND_TYPE.TIMES then
			var_11_1 = 100531
		elseif iter_11_0 == HomeConst.INFO_REMIND_TYPE.OTHERS then
			var_11_1 = 100532
		end

		var_11_0.title = g.core.lang:get(var_11_1)

		table.insert(self._setRecordData, var_11_0)
	end
end

function HomeInfoRemindData:getSetRecordData()
	return self._setRecordData
end

function HomeInfoRemindData:resetHomeInfoClickRecordWhenCrossDay()
	self:_setNewHomeInfoClickRecord(HomeConst.INFO_REMIND_TYPE.TIMES, 0)
	self:_setNewHomeInfoClickRecord(HomeConst.INFO_REMIND_TYPE.OTHERS, 0)
end

function HomeInfoRemindData:judgeResetHomeInfoClickRecordWhenLogin()
	local var_14_0 = g.core.common.Storage:load("HomeInfoRemindRecord.json", false) or {}
	local var_14_1 = self:_getHomeInfoJudgeStr(HomeConst.INFO_REMIND_TYPE.TIMES)

	if var_14_0[var_14_1] and var_14_0[var_14_1].nextUpdateTime < var_0_5:getTime() then
		self:resetHomeInfoClickRecordWhenCrossDay()
	end
end

function HomeInfoRemindData:_getHomeInfoJudgeStr(arg_15_1)
	return "HomeInfoRemindRecord" .. tostring(arg_15_1) .. "_" .. tostring((g.core.model.User:getId())) .. "_" .. tostring(g.core.platform.ServerListProxy:getSelectedServer().sid)
end

function HomeInfoRemindData:_setNewHomeInfoClickRecord(arg_16_1, arg_16_2)
	local var_16_0 = self._clickRecordConfig

	if not self._clickRecordConfig then
		var_16_0 = g.core.common.Storage:load("HomeInfoRemindRecord.json", false)
		var_16_0 = var_16_0 or {}
	end

	self._clickRecordConfig = var_16_0
	self._clickRecordConfig[self:_getHomeInfoJudgeStr(arg_16_1)] = {
		value = arg_16_2,
		nextUpdateTime = var_0_5:getTime() + var_0_5:secondsFromToday()
	}

	g.core.common.Storage:save("HomeInfoRemindRecord.json", self._clickRecordConfig, false)
end

function HomeInfoRemindData:judgeHomeInfoHasClick(arg_17_1)
	local var_17_0 = g.core.common.Storage:load("HomeInfoRemindRecord.json", false) or {}
	local var_17_1 = self:_getHomeInfoJudgeStr(arg_17_1)

	if var_17_0[var_17_1] and var_17_0[var_17_1] == 1 then
		return true
	end

	return false
end

function HomeInfoRemindData:_getHomeInfoRemindSettingStr(arg_18_1)
	return "HomeInfoRemindSettingRecord" .. tostring(arg_18_1) .. "_" .. tostring((g.core.model.User:getId())) .. "_" .. tostring(g.core.platform.ServerListProxy:getSelectedServer().sid)
end

function HomeInfoRemindData:_setHomeInfoRemindSettingRecord(arg_19_1)
	local var_19_0 = self._setConfig

	if not self._setConfig then
		var_19_0 = g.core.common.Storage:load("HomeInfoRemindSettingRecord.json", false)
		var_19_0 = var_19_0 or {}
	end

	self._setConfig = var_19_0
	self._setConfig[self:_getHomeInfoRemindSettingStr(arg_19_1)] = "1"

	g.core.common.Storage:save("HomeInfoRemindSettingRecord.json", self._setConfig, false)
end

function HomeInfoRemindData:judgeHomeInfoRemindSetting(arg_20_1)
	local var_20_0 = g.core.common.Storage:load("HomeInfoRemindSettingRecord.json", false) or {}
	local var_20_1 = self:_getHomeInfoRemindSettingStr(arg_20_1)

	if var_20_0[var_20_1] and var_20_0[var_20_1] == "1" then
		return true
	end

	return false
end

function HomeInfoRemindData:getIsHasTipsContent()
	if not self._isInitInfoData then
		self:updateInfoRemindData()
	end

	for iter_21_0 = 1, 3 do
		if self._infoMapData[iter_21_0] and #self._infoMapData[iter_21_0] > 0 then
			return true
		end
	end

	return false
end

function HomeInfoRemindData:resetLastUpdateTime()
	self._lastUpdateTimes = var_0_5:getTime()
end

function HomeInfoRemindData:isNeedRefreshData()
	if self._lastUpdateTimes and var_0_5:getTime() - self._lastUpdateTimes > var_0_0 then
		self._lastUpdateTimes = var_0_5:getTime()

		return true
	end

	return false
end

function HomeInfoRemindData:isShowSlgGatherTip()
	return g.core.model.User.newSlgData:isOpen() and not g.core.model.User.newSlgData:isForecasting() and g.core.model.User.newSlgData:isChariotGatherTime() and g.core.model.User.newSlgData:getNextAttackCityIds()[1] ~= 0
end

function HomeInfoRemindData:checkTipData()
	local var_25_0 = {}
	local var_25_1 = {}
	local var_25_2 = false

	for iter_25_0, iter_25_1 in pairs(self._tipDataMap) do
		for iter_25_2, iter_25_3 in ipairs(iter_25_1) do
			if iter_25_3:getCfgId() == g.core.const.ConstMgr.NewSlgConst.GATHER_TIP_ID then
				var_25_2 = true
			end

			local var_25_3 = iter_25_3:getCheckKey()

			if not iter_25_3:isInTime() then
				var_25_0[#var_25_0 + 1] = iter_25_3
			elseif var_25_1[var_25_3] then
				var_25_0[#var_25_0 + 1] = iter_25_3
			end

			var_25_1[var_25_3] = true
		end
	end

	for iter_25_4, iter_25_5 in ipairs(var_25_0) do
		self:delTipData(iter_25_5, true)
	end

	if not var_25_2 and self:isShowSlgGatherTip() then
		self:_addTipData({
			unique_id = 0,
			id = g.core.const.ConstMgr.NewSlgConst.GATHER_TIP_ID,
			expire_time = g.core.model.User.newSlgData:getChariotGatherEndTime(),
			params = table.concat({
				g.core.model.User.newSlgData:getNextAttackCityIds()[1],
				"0",
				g.core.model.User.newSlgData:getChariotGatherStartTime()
			}, ":")
		})
	end
end

function HomeInfoRemindData:updateAllTipData(arg_26_1)
	self._tipDataMap = {}
	self._tipDataUidMap = {}
	self._newTipCnt = 0

	if self:isShowSlgGatherTip() then
		self:_addTipData({
			unique_id = 0,
			id = g.core.const.ConstMgr.NewSlgConst.GATHER_TIP_ID,
			expire_time = g.core.model.User.newSlgData:getChariotGatherEndTime(),
			params = table.concat({
				g.core.model.User.newSlgData:getNextAttackCityIds()[1],
				"0",
				g.core.model.User.newSlgData:getChariotGatherStartTime()
			}, ":")
		})
	end

	for iter_26_0, iter_26_1 in ipairs(arg_26_1.tips or {}) do
		self:_addTipData(iter_26_1)
	end
end

function HomeInfoRemindData:_addTipData(arg_27_1)
	local var_27_0 = self:getTipDataByParam(arg_27_1)

	if var_27_0:getCfgId() == g.core.const.ConstMgr.NewSlgConst.GATHER_TIP_ID then
		local var_27_1 = g.core.common.ServerTime:getDateObject()

		if not self._tipLocalData[g.core.const.ConstMgr.NewSlgConst.GATHER_TIP_ID] or not self._tipLocalData[g.core.const.ConstMgr.NewSlgConst.GATHER_TIP_ID][table.concat({
			var_27_1.year,
			var_27_1.month,
			var_27_1.day
		}, ":")] then
			var_27_0:setIsNew(true)
		end
	else
		var_27_0:setIsNew(not self:isViewTip(var_27_0:getUid()))
	end

	if var_27_0:isNew() and not var_27_0:isHide() then
		self._newTipCnt = self._newTipCnt + 1
	end

	local var_27_2 = var_27_0:getCfg()
	local var_27_3 = self._tipDataMap[var_27_2.function_id]

	if not self._tipDataMap[var_27_2.function_id] then
		var_27_3 = {}
		self._tipDataMap[var_27_2.function_id] = var_27_3
	end

	var_27_3[#var_27_3 + 1] = var_27_0

	local var_27_4 = var_27_0:getUid()

	if var_27_4 then
		self._tipDataUidMap[var_27_4] = var_27_0
	end
end

function HomeInfoRemindData:getTipDataByParam(arg_28_1)
	local var_28_0

	if g.core.const.ConstMgr.NewSlgConst.GATHER_TIP_ID == arg_28_1.id then
		var_28_0 = require("app.view.module.home.model.remindTip.RemindTipSlgCityData").new(arg_28_1)
	elseif arg_28_1.id == 2 then
		var_28_0 = require("app.view.module.home.model.remindTip.RemindTipSlgBossData").new(arg_28_1)
	elseif arg_28_1.id == 3 then
		var_28_0 = require("app.view.module.home.model.remindTip.RemindTipMysteryBossData").new(arg_28_1)
	elseif arg_28_1.id == 4 or arg_28_1.id == 5 then
		function arg_28_1.jumpFunc()
			g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_MAIN)
		end

		var_28_0 = require("app.view.module.home.model.remindTip.RemindTipSlgS2CityData").new(arg_28_1)
	end

	return var_28_0
end

function HomeInfoRemindData:_removeTipData(arg_30_1)
	if self._tipDataUidMap[arg_30_1] then
		local var_30_0 = self._tipDataUidMap[arg_30_1]:getCfg().function_id

		for iter_30_0, iter_30_1 in ipairs(self._tipDataMap[var_30_0]) do
			if iter_30_1:getUid() == arg_30_1 then
				table.remove(self._tipDataMap[var_30_0], iter_30_0)

				if #self._tipDataMap[var_30_0] == 0 then
					self._tipDataMap[var_30_0] = nil
				end

				break
			end
		end

		self._tipDataUidMap[arg_30_1] = nil
	end
end

function HomeInfoRemindData:updateTipData(arg_31_1)
	for iter_31_0, iter_31_1 in ipairs(arg_31_1.tips) do
		local var_31_0 = self:getTipData(iter_31_1.unique_id, iter_31_1.id)

		if var_31_0 then
			var_31_0:updateData(iter_31_1)
		else
			self:_addTipData(iter_31_1)
		end
	end
end

function HomeInfoRemindData:getTipData(arg_32_1, arg_32_2)
	local var_32_0

	if arg_32_1 then
		var_32_0 = self._tipDataUidMap[arg_32_1]
	else
		local var_32_1 = self._tipDataMap[g.core.config.tips_info.get(arg_32_2).function_id]

		if var_32_1 then
			for iter_32_0, iter_32_1 in ipairs(var_32_1) do
				if iter_32_1:getCfgId() == arg_32_2 then
					var_32_0 = iter_32_1

					break
				end
			end
		end
	end

	return var_32_0
end

function HomeInfoRemindData:delTipData(arg_33_1, arg_33_2)
	local var_33_0 = arg_33_1:getCfgId()

	if var_33_0 == g.core.const.ConstMgr.NewSlgConst.GATHER_TIP_ID or var_33_0 == g.core.const.ConstMgr.MysteryConst.BOSS_TIP_ID then
		return
	end

	if arg_33_1:getCfg().if_hold == 1 then
		self:delLocalTipData(var_33_0)
	elseif not arg_33_2 then
		g.core.network.GameNetProxy:send_C2S_Tips_Del({
			unique_ids = {
				arg_33_1:getUid()
			}
		})
	else
		self:_removeTipData(arg_33_1:getUid())
	end
end

function HomeInfoRemindData:delTipNetData(arg_34_1)
	for iter_34_0, iter_34_1 in ipairs(arg_34_1.unique_ids) do
		self:_removeTipData(iter_34_1)
	end
end

function HomeInfoRemindData:getTipDataList(arg_35_1, arg_35_2)
	self:checkTipData()

	local var_35_0 = {}

	for iter_35_0, iter_35_1 in pairs(self._tipDataMap) do
		for iter_35_2, iter_35_3 in ipairs(iter_35_1) do
			if not arg_35_1 then
				var_35_0[#var_35_0 + 1] = iter_35_3
			elseif not arg_35_2 and iter_35_0 == arg_35_1 then
				var_35_0[#var_35_0 + 1] = iter_35_3
			elseif iter_35_0 == arg_35_1 and iter_35_3:getCfg().type == arg_35_2 then
				var_35_0[#var_35_0 + 1] = iter_35_3
			end
		end
	end

	return var_35_0
end

function HomeInfoRemindData:getTipMap()
	self:checkTipData()

	return self._tipDataMap
end

function HomeInfoRemindData:delLocalTipData(arg_37_1)
	local var_37_0 = g.core.common.ServerTime:getDateObject()

	self._tipLocalData[arg_37_1] = self._tipLocalData[arg_37_1] or {}
	self._tipLocalData[arg_37_1][table.concat({
		var_37_0.year,
		var_37_0.month,
		var_37_0.day
	}, ":")] = true

	self:_saveLocalTipData()

	local var_37_1 = g.core.config.tips_info.get(arg_37_1)

	for iter_37_0, iter_37_1 in ipairs(self._tipDataMap[var_37_1.function_id]) do
		if iter_37_1:getCfg().type == var_37_1.type then
			table.remove(self._tipDataMap[var_37_1.function_id], iter_37_0)

			break
		end
	end

	if #self._tipDataMap[var_37_1.function_id] == 0 then
		self._tipDataMap[var_37_1.function_id] = nil
	end
end

function HomeInfoRemindData:_loadLocalTipData()
	self._tipLocalData = self._tipLocalData or g.core.common.Storage:load("HomeInfoTipRecord.json", true) or {}
end

function HomeInfoRemindData:_saveLocalTipData()
	g.core.common.Storage:save("HomeInfoTipRecord.json", self._tipLocalData, true)
end

function HomeInfoRemindData:_loadTipSelectData()
	self._tipSelectMap = g.core.common.Storage:load("HomeInfoTipSelect.json", true) or {}
end

function HomeInfoRemindData:_saveTipSelectData()
	g.core.common.Storage:save("HomeInfoTipSelect.json", self._tipSelectMap, true)
end

function HomeInfoRemindData:updateTipSelect(arg_42_1)
	for iter_42_0, iter_42_1 in pairs(self._tipSelectMap) do
		self._tipSelectMap[iter_42_0] = false
	end

	for iter_42_2, iter_42_3 in ipairs(arg_42_1) do
		self._tipSelectMap[tostring(iter_42_3)] = true
	end

	self:_saveTipSelectData()
end

function HomeInfoRemindData:getTipSelectData()
	return self._tipSelectMap
end

function HomeInfoRemindData:setViewTip(arg_44_1)
	if arg_44_1:getUid() and not self._viewTipMap[arg_44_1:getUid()] then
		self._viewTipMap[tostring(arg_44_1:getUid())] = 1

		self:_saveViewTipMapData()

		self._newTipCnt = self._newTipCnt - 1
	end

	arg_44_1:setIsNew(false)
end

function HomeInfoRemindData:isViewTip(arg_45_1)
	return self._viewTipMap[arg_45_1]
end

function HomeInfoRemindData:_loadViewTipMapData()
	self._viewTipMap = g.core.common.Storage:load("HomeInfoTipView.json", true) or {}
end

function HomeInfoRemindData:_saveViewTipMapData()
	g.core.common.Storage:save("HomeInfoTipView.json", self._viewTipMap, true)
end

function HomeInfoRemindData:hasNewTip()
	return self._newTipCnt > 0
end

return HomeInfoRemindData
