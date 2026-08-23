local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.OpenScreenConst
local var_0_2 = g.core.const.ConstMgr.PeakArenaConst
local var_0_3 = g.core.common.ModuleUnlock
local var_0_4 = g.core.model.User.mineData
local var_0_5 = g.core.model.User.guildWarData
local var_0_6 = g.core.model.User.fogNightmareData
local var_0_7 = g.core.model.User.gveDataMgr
local var_0_8 = g.core.model.User.valentinesDayVoteData
local var_0_9 = g.core.model.User.halfAnniversaryData
local var_0_10 = g.core.model.User.activityMonthGachaData
local var_0_11 = g.core.model.User.explorationData
local var_0_12 = g.core.model.User.peakArenaData
local var_0_13 = g.core.model.User.cultivateDataMgr
local var_0_14 = g.core.common.Storage
local var_0_15 = g.core.common.ServerTime
local var_0_16 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_17 = g.core.model.User.sevenDaysData
local var_0_18 = g.core.config.openscreen_info
local var_0_19 = g.core.model.User.activityDataManager
local var_0_20 = g.core.model.User.pubgData
local var_0_21 = g.core.model.User.anniversaryData
local var_0_22 = g.core.model.User.homeData
local OpenScreenData = class("OpenScreenData")

function OpenScreenData:ctor()
	self:initData()
end

function OpenScreenData:initData()
	self._index = 1
	self._listAdv = {}
	self._listConfig = {}
	self._listCustom = {}
	self._todayShowEnd = {}

	self:_initOpenScreenConfigData()
end

function OpenScreenData:_calIsIn(arg_3_1)
	local var_3_0 = arg_3_1.func_id or 0

	if var_3_0 ~= 0 and not var_0_3:isModuleUnlock(var_3_0) then
		return false
	end

	if g.core.model.User.homeData:isCensorAdv(arg_3_1.id) then
		return false
	end

	return self:_calIsShowToday(arg_3_1)
end

function OpenScreenData:_calIsShowToday(arg_4_1)
	if arg_4_1.type == var_0_1.HINT_TYPE.ONCE then
		self._todayShowEnd = (var_0_14:load("openScreen_adv.json") or {})[var_0_15:getDate()] or {}

		if self._todayShowEnd[tostring(arg_4_1.id)] then
			return false
		end
	end

	return self:_calIsInTime(arg_4_1)
end

function OpenScreenData:_calIsInTime(arg_5_1)
	local var_5_0 = var_0_15:getTime()
	local var_5_1 = arg_5_1.time_type or 0

	if var_5_1 == var_0_1.TIME_TYPE.END_TIME then
		if var_5_0 >= arg_5_1.start_time and var_5_0 < arg_5_1.end_time then
			return true
		end
	elseif var_5_1 == var_0_1.TIME_TYPE.EXPIRE_TIME then
		if var_5_0 >= arg_5_1.start_time and var_5_0 < arg_5_1.show_end_time then
			return true
		end
	elseif var_5_1 == var_0_1.TIME_TYPE.UNOPEN and arg_5_1.cond_type == var_0_1.COND_TYPE.CONFIG then
		return true
	elseif arg_5_1.cond_type == var_0_1.COND_TYPE.CUSTOM and var_5_0 >= arg_5_1.start_time and var_5_0 < arg_5_1.show_end_time then
		return true
	end

	return false
end

function OpenScreenData:reloadBaseInfo()
	self:_initOpenScreenConfigData()
	self:_initBaseInfo()
	self:reloadShowIndex()
end

function OpenScreenData:_initBaseInfo()
	self._listAdv = {}

	for iter_7_0 = 1, #self._listConfig do
		if self:_calIsIn(self._listConfig[iter_7_0]) and not var_0_22:isRecordPop(g.core.const.ConstMgr.FUNCTION_TYPE.OPEN_SCREEN_AD, self._listConfig[iter_7_0].id) then
			table.insert(self._listAdv, {
				info = self._listConfig[iter_7_0]
			})
		end
	end

	for iter_7_1 = 1, #self._listCustom do
		if self:_calIsIn(self._listCustom[iter_7_1]) and not var_0_22:isRecordPop(g.core.const.ConstMgr.FUNCTION_TYPE.OPEN_SCREEN_AD, self._listCustom[iter_7_1].id) then
			table.insert(self._listAdv, {
				info = self._listCustom[iter_7_1]
			})
		end
	end

	if next(self._listAdv) then
		table.sort(self._listAdv, function(arg_8_0, arg_8_1)
			if arg_8_0.info.sort ~= arg_8_1.info.sort then
				return arg_8_0.info.sort < arg_8_1.info.sort
			end

			return false
		end)
	end
end

function OpenScreenData:tagCurOpenScreenAd()
	if next(self._listAdv) then
		self._todayShowEnd[tostring(self._listAdv[self._index].info.id)] = true

		var_0_14:save("openScreen_adv.json", {
			[var_0_15:getDate()] = self._todayShowEnd
		})
	end
end

function OpenScreenData:checkAllComplete()
	return self._index >= #self._listAdv
end

function OpenScreenData:hasData()
	return next(self._listAdv)
end

function OpenScreenData:reloadShowIndex()
	self._index = 1
end

function OpenScreenData:goNext()
	self._index = self._index + 1
end

function OpenScreenData:getCurAdv()
	if self._listAdv[self._index] then
		var_0_22:setAutoPopFunc(g.core.const.ConstMgr.FUNCTION_TYPE.OPEN_SCREEN_AD, self._listAdv[self._index].info.id)
	end

	return self._listAdv[self._index]
end

function OpenScreenData:updateCustomGetInfo(arg_15_1)
	self._listCustom = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1.pages or {}) do
		local var_15_1 = {
			id = iter_15_1.id
		}

		var_15_1.route_id = iter_15_1.skip_id or 0
		var_15_1.adv_pic_type = var_0_1.ADV_TYPE.REMOTE_IMAGE
		var_15_1.cond_type = var_0_1.COND_TYPE.CUSTOM
		var_15_1.func_id = iter_15_1.function_id
		var_15_1.time_type = iter_15_1.show_time_type
		var_15_1.start_time = iter_15_1.start_time
		var_15_1.end_time = iter_15_1.finish_time
		var_15_1.show_start_time = iter_15_1.preview_time
		var_15_1.show_end_time = iter_15_1.expire_time
		var_15_1.type = iter_15_1.tip_type == 0 and 1 or 2
		var_15_1.image = iter_15_1.pic
		var_15_1.sort = iter_15_1.order
		var_15_1.tips = iter_15_1.skip_content
		var_15_1.view_type = iter_15_1.view_type
		var_15_1.view_value = iter_15_1.view_value
		var_15_1.skipType = iter_15_1.skip_type or 1
		var_15_1.opIdStr = iter_15_1.op_ids or ""
		var_15_1.min_level = iter_15_1.min_level or 0
		var_15_1.max_level = iter_15_1.max_level or 0
		var_15_1.no_login = iter_15_1.no_login or 0

		local var_15_2 = var_15_1.opIdStr == "" or string.find(var_15_1.opIdStr, tostring((g.core.platform.PlatformProxy:getOpId())))
		local var_15_3 = false
		local var_15_4 = g.core.model.User:getLevel()

		var_15_3 = var_15_1.min_level ~= var_15_1.max_level and var_15_4 >= var_15_1.min_level and var_15_4 <= var_15_1.max_level or true

		if var_15_1.skipType == var_0_1.SKIP_TYPE.PRIVATE_SPACE then
			var_15_3 = var_15_3 and g.core.model.User.UserTitleData:isNeedShowGeneralPrivatePop()

			if g.core.platform.ServerListProxy:isTesting() then
				var_15_3 = false
			end
		end

		if iter_15_1.pic ~= nil and #iter_15_1.pic > 1 and var_15_2 and var_15_3 then
			table.insert(self._listCustom, var_15_1)
		end
	end
end

function OpenScreenData:_initOpenScreenConfigData()
	self._listConfig = {}

	local var_16_0 = {}

	for iter_16_0 = 1, var_0_18.getLength() do
		local var_16_1 = var_0_18.indexOf(iter_16_0):toObject()
		local var_16_2 = var_0_19:getShowActivityDataByCfg(var_16_1.activity_type, var_16_1.activity_value)

		if var_16_1.func_id == var_0_16.PEAK_ARENA then
			if var_0_12:getStageType() == var_0_2.StageType.PEAK then
				local var_16_3 = {
					id = var_16_1.id
				}

				var_16_3.route_id = var_16_1.route_id or 0
				var_16_3.adv_pic_type = var_0_1.ADV_TYPE.IMAGE
				var_16_3.cond_type = var_0_1.COND_TYPE.CONFIG
				var_16_3.func_id = var_16_1.func_id
				var_16_3.time_type = var_16_1.time_type
				var_16_3.start_time = var_0_12:getStartTime()
				var_16_3.end_time = var_0_12:getFinishTime()
				var_16_3.show_start_time = var_0_12:getFinalStageEndTime()
				var_16_3.show_end_time = var_0_12:getFinishTime()
				var_16_3.type = var_16_1.type
				var_16_3.image = var_16_1.icon
				var_16_3.sort = var_16_1.sort
				var_16_3.skipType = var_0_1.SKIP_TYPE.FUNCTION_ROUTE

				table.insert(self._listConfig, var_16_3)
			end
		elseif var_16_1.func_id == var_0_16.MINE then
			if var_0_4:isInOpenTime() and not var_0_4:isInResultTime() then
				local var_16_4 = {
					id = var_16_1.id
				}

				var_16_4.route_id = var_16_1.route_id or 0
				var_16_4.adv_pic_type = var_0_1.ADV_TYPE.IMAGE
				var_16_4.cond_type = var_0_1.COND_TYPE.CONFIG
				var_16_4.func_id = var_16_1.func_id
				var_16_4.time_type = var_16_1.time_type
				var_16_4.start_time = var_0_4:getSeasonStartTime()
				var_16_4.end_time = var_0_4:getSeasonEndTime()
				var_16_4.show_start_time = var_0_4:getSeasonEndTime()
				var_16_4.show_end_time = var_0_4:getCloseTime()
				var_16_4.type = var_16_1.type
				var_16_4.image = var_16_1.icon
				var_16_4.sort = var_16_1.sort
				var_16_4.skipType = var_0_1.SKIP_TYPE.FUNCTION_ROUTE

				table.insert(self._listConfig, var_16_4)
			end
		elseif var_16_1.func_id == var_0_16.GUILD_WAR then
			local var_16_5 = var_0_5:isOpen()
			local var_16_6, var_16_7 = var_0_5:getTimeData()

			if var_16_5 then
				local var_16_8 = {
					id = var_16_1.id
				}

				var_16_8.route_id = var_16_1.route_id or 0
				var_16_8.adv_pic_type = var_0_1.ADV_TYPE.IMAGE
				var_16_8.cond_type = var_0_1.COND_TYPE.CONFIG
				var_16_8.func_id = var_16_1.func_id
				var_16_8.time_type = var_16_1.time_type
				var_16_8.start_time = var_16_6
				var_16_8.end_time = var_16_7
				var_16_8.show_start_time = var_16_6
				var_16_8.show_end_time = var_16_7
				var_16_8.type = var_16_1.type
				var_16_8.image = var_16_1.icon
				var_16_8.sort = var_16_1.sort
				var_16_8.skipType = var_0_1.SKIP_TYPE.FUNCTION_ROUTE

				table.insert(self._listConfig, var_16_8)
			end
		elseif var_16_1.func_id == var_0_16.FOG_NIGHTMARE then
			local var_16_9 = var_0_6:isShowEntrance()
			local var_16_10, var_16_11, var_16_12 = var_0_6:getTimeData()

			if var_16_9 then
				local var_16_13 = {
					id = var_16_1.id
				}

				var_16_13.route_id = var_16_1.route_id or 0
				var_16_13.adv_pic_type = var_0_1.ADV_TYPE.IMAGE
				var_16_13.cond_type = var_0_1.COND_TYPE.CONFIG
				var_16_13.func_id = var_16_1.func_id
				var_16_13.time_type = var_16_1.time_type
				var_16_13.start_time = var_16_10
				var_16_13.end_time = var_16_11
				var_16_13.show_start_time = var_16_10
				var_16_13.show_end_time = var_16_12
				var_16_13.type = var_16_1.type
				var_16_13.image = var_16_1.icon
				var_16_13.sort = var_16_1.sort
				var_16_13.skipType = var_0_1.SKIP_TYPE.FUNCTION_ROUTE

				table.insert(self._listConfig, var_16_13)
			end
		elseif var_16_1.func_id == var_0_16.GVE then
			local var_16_14 = var_0_7:getGveSignUpStartTime()

			if var_0_7:isOpen() then
				local var_16_16 = {
					id = var_16_1.id
				}

				var_16_16.route_id = var_16_1.route_id or 0
				var_16_16.adv_pic_type = var_0_1.ADV_TYPE.IMAGE
				var_16_16.cond_type = var_0_1.COND_TYPE.CONFIG
				var_16_16.func_id = var_16_1.func_id
				var_16_16.time_type = var_16_1.time_type
				var_16_16.start_time = var_16_14
				var_16_16.end_time = var_0_7:getGveFormalEndTime()
				var_16_16.show_start_time = var_16_14
				var_16_16.show_end_time = var_0_7:getGveExpireEndTime()
				var_16_16.type = var_16_1.type
				var_16_16.image = var_16_1.icon
				var_16_16.sort = var_16_1.sort
				var_16_16.skipType = var_0_1.SKIP_TYPE.FUNCTION_ROUTE

				table.insert(self._listConfig, var_16_16)
			end
		elseif var_16_1.func_id == var_0_16.VALENTINES_DAY_VOTE then
			local var_16_17 = var_0_8:isProcess()
			local var_16_18, var_16_19, var_16_20 = var_0_8:getTimeData()

			if var_16_17 then
				local var_16_21 = {
					id = var_16_1.id
				}

				var_16_21.route_id = var_16_1.route_id or 0
				var_16_21.adv_pic_type = var_0_1.ADV_TYPE.IMAGE
				var_16_21.cond_type = var_0_1.COND_TYPE.CONFIG
				var_16_21.func_id = var_16_1.func_id
				var_16_21.time_type = var_16_1.time_type
				var_16_21.start_time = var_16_18
				var_16_21.end_time = var_16_19
				var_16_21.show_start_time = var_16_18
				var_16_21.show_end_time = var_16_20
				var_16_21.type = var_16_1.type
				var_16_21.image = var_16_1.icon
				var_16_21.sort = var_16_1.sort
				var_16_21.skipType = var_0_1.SKIP_TYPE.FUNCTION_ROUTE

				table.insert(self._listConfig, var_16_21)
			end
		elseif var_16_1.func_id == var_0_16.HALF_ANNIVERSARY then
			local var_16_22 = var_0_9:isActivityOpen(var_16_1.activity_value)
			local var_16_23, var_16_24, var_16_25 = var_0_9:getTimeData()

			if var_16_22 then
				local var_16_26 = {
					id = var_16_1.id
				}

				var_16_26.route_id = var_16_1.route_id or 0
				var_16_26.adv_pic_type = var_0_1.ADV_TYPE.IMAGE
				var_16_26.cond_type = var_0_1.COND_TYPE.CONFIG
				var_16_26.func_id = var_16_1.func_id
				var_16_26.time_type = var_16_1.time_type
				var_16_26.start_time = var_16_23
				var_16_26.end_time = var_16_24
				var_16_26.show_start_time = var_16_23
				var_16_26.show_end_time = var_16_25
				var_16_26.type = var_16_1.type
				var_16_26.image = var_16_1.icon
				var_16_26.sort = var_16_1.sort
				var_16_26.skipType = var_0_1.SKIP_TYPE.FUNCTION_ROUTE

				table.insert(self._listConfig, var_16_26)
			end
		elseif var_16_1.func_id == var_0_16.MONTH_GACHA then
			local var_16_27 = var_0_10:isActOpen(var_16_1.activity_value)
			local var_16_28, var_16_29, var_16_30 = var_0_10:getTimeData()

			if var_16_27 then
				local var_16_31 = {
					id = var_16_1.id
				}

				var_16_31.route_id = var_16_1.route_id or 0
				var_16_31.adv_pic_type = var_0_1.ADV_TYPE.IMAGE
				var_16_31.cond_type = var_0_1.COND_TYPE.CONFIG
				var_16_31.func_id = var_16_1.func_id
				var_16_31.time_type = var_16_1.time_type
				var_16_31.start_time = var_16_28
				var_16_31.end_time = var_16_29
				var_16_31.show_start_time = var_16_28
				var_16_31.show_end_time = var_16_30
				var_16_31.type = var_16_1.type
				var_16_31.image = var_16_1.icon
				var_16_31.sort = var_16_1.sort
				var_16_31.skipType = var_0_1.SKIP_TYPE.FUNCTION_ROUTE

				table.insert(self._listConfig, var_16_31)
			end
		elseif var_16_1.func_id == var_0_16.PUBG then
			local var_16_32 = var_0_20:isActivityOpen()
			local var_16_33, var_16_34, var_16_35 = var_0_20:getTimeData()

			if var_16_32 then
				local var_16_36 = {
					id = var_16_1.id
				}

				var_16_36.route_id = var_16_1.route_id or 0
				var_16_36.adv_pic_type = var_0_1.ADV_TYPE.IMAGE
				var_16_36.cond_type = var_0_1.COND_TYPE.CONFIG
				var_16_36.func_id = var_16_1.func_id
				var_16_36.time_type = var_16_1.time_type
				var_16_36.start_time = var_16_33
				var_16_36.end_time = var_16_34
				var_16_36.show_start_time = var_16_33
				var_16_36.show_end_time = var_16_35
				var_16_36.type = var_16_1.type
				var_16_36.image = var_16_1.icon
				var_16_36.sort = var_16_1.sort
				var_16_36.skipType = var_0_1.SKIP_TYPE.FUNCTION_ROUTE

				table.insert(self._listConfig, var_16_36)
			end
		elseif var_16_1.func_id == var_0_16.EXPLORATION then
			local var_16_37 = var_0_11:isActivityOpen()
			local var_16_38, var_16_39, var_16_40 = var_0_11:getTimeData()

			if var_16_37 then
				local var_16_41 = {
					id = var_16_1.id
				}

				var_16_41.route_id = var_16_1.route_id or 0
				var_16_41.adv_pic_type = var_0_1.ADV_TYPE.IMAGE
				var_16_41.cond_type = var_0_1.COND_TYPE.CONFIG
				var_16_41.func_id = var_16_1.func_id
				var_16_41.time_type = var_16_1.time_type
				var_16_41.start_time = var_16_38
				var_16_41.end_time = var_16_39
				var_16_41.show_start_time = var_16_38
				var_16_41.show_end_time = var_16_40
				var_16_41.type = var_16_1.type
				var_16_41.image = var_16_1.icon
				var_16_41.sort = var_16_1.sort
				var_16_41.skipType = var_0_1.SKIP_TYPE.FUNCTION_ROUTE

				table.insert(self._listConfig, var_16_41)
			end
		elseif var_16_1.func_id == var_0_16.CULTIVATE_ACTIVITY then
			local var_16_42 = var_0_13:getCultivateData(var_16_1.activity_value)

			if var_16_42 then
				local var_16_43 = var_16_42:isInActivityShowTime()
				local var_16_44, var_16_45, var_16_46 = var_16_42:getTimeData()

				if var_16_43 then
					local var_16_47 = {
						id = var_16_1.id
					}

					var_16_47.route_id = var_16_1.route_id or 0
					var_16_47.adv_pic_type = var_0_1.ADV_TYPE.IMAGE
					var_16_47.cond_type = var_0_1.COND_TYPE.CONFIG
					var_16_47.func_id = var_16_1.func_id
					var_16_47.time_type = var_16_1.time_type
					var_16_47.start_time = var_16_44
					var_16_47.end_time = var_16_45
					var_16_47.show_start_time = var_16_44
					var_16_47.show_end_time = var_16_46
					var_16_47.type = var_16_1.type
					var_16_47.image = var_16_1.icon
					var_16_47.sort = var_16_1.sort
					var_16_47.skipType = var_0_1.SKIP_TYPE.FUNCTION_ROUTE

					table.insert(self._listConfig, var_16_47)
				end
			end
		elseif var_16_1.func_id == var_0_16.WITCH_ACTIVITY then
			local var_16_48 = var_0_13:getCultivateData(var_16_1.activity_value)

			if var_16_48 then
				local var_16_49 = var_16_48:isInActivityShowTime()
				local var_16_50, var_16_51, var_16_52 = var_16_48:getTimeData()

				if var_16_49 then
					local var_16_53 = {
						id = var_16_1.id
					}

					var_16_53.route_id = var_16_1.route_id or 0
					var_16_53.adv_pic_type = var_0_1.ADV_TYPE.IMAGE
					var_16_53.cond_type = var_0_1.COND_TYPE.CONFIG
					var_16_53.func_id = var_16_1.func_id
					var_16_53.time_type = var_16_1.time_type
					var_16_53.start_time = var_16_50
					var_16_53.end_time = var_16_51
					var_16_53.show_start_time = var_16_50
					var_16_53.show_end_time = var_16_52
					var_16_53.type = var_16_1.type
					var_16_53.image = var_16_1.icon
					var_16_53.sort = var_16_1.sort
					var_16_53.skipType = var_0_1.SKIP_TYPE.FUNCTION_ROUTE

					table.insert(self._listConfig, var_16_53)
				end
			end
		elseif var_16_1.func_id == var_0_16.ANNIVERSARY then
			if var_0_21:isActivityOpen() then
				local var_16_54 = var_0_21:getCurStage() == g.core.const.ConstMgr.AnniversaryConst.STAGE.GAME
				local var_16_55, var_16_56, var_16_57 = var_0_21:getTimeData()

				if var_16_54 then
					local var_16_58 = {
						id = var_16_1.id
					}

					var_16_58.route_id = var_16_1.route_id or 0
					var_16_58.adv_pic_type = var_0_1.ADV_TYPE.IMAGE
					var_16_58.cond_type = var_0_1.COND_TYPE.CONFIG
					var_16_58.func_id = var_16_1.func_id
					var_16_58.time_type = var_16_1.time_type
					var_16_58.start_time = var_16_55
					var_16_58.end_time = var_16_56
					var_16_58.show_start_time = var_16_55
					var_16_58.show_end_time = var_16_57
					var_16_58.type = var_16_1.type
					var_16_58.image = var_16_1.icon
					var_16_58.sort = var_16_1.sort
					var_16_58.skipType = var_0_1.SKIP_TYPE.FUNCTION_ROUTE

					table.insert(self._listConfig, var_16_58)
				end
			end
		elseif var_16_1.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.SUMMER_ACTIVITY then
			local var_16_59 = g.core.model.User.themeData:getThemeMergeEntranceActivityData(var_16_1.activity_value)

			if var_16_59 and var_16_59:getActivityState() ~= var_0_0.ActivityConst.ACTIVITY_STATE.EXPIRE then
				local var_16_60 = var_16_59:getActivityThemeValueList()[1]

				if not var_16_0[var_16_60] then
					var_16_0[var_16_60] = true

					local var_16_61 = {
						id = var_16_1.id
					}

					var_16_61.route_id = var_16_1.route_id or 0
					var_16_61.adv_pic_type = var_0_1.ADV_TYPE.IMAGE
					var_16_61.cond_type = var_0_1.COND_TYPE.CONFIG
					var_16_61.func_id = var_16_1.func_id
					var_16_61.time_type = var_16_1.time_type
					var_16_61.start_time = var_16_59:getStartTime()
					var_16_61.end_time = var_16_59:getFinishTime()
					var_16_61.show_start_time = var_16_59:getStartTime()
					var_16_61.show_end_time = var_16_59:getExpireTime()
					var_16_61.type = var_16_1.type
					var_16_61.image = var_16_1.icon
					var_16_61.sort = var_16_1.sort
					var_16_61.skipType = var_0_1.SKIP_TYPE.FUNCTION_ROUTE

					table.insert(self._listConfig, var_16_61)
				end
			end
		elseif var_16_2 and var_16_2:isShow() then
			local var_16_62 = {
				id = var_16_1.id
			}

			var_16_62.route_id = var_16_1.route_id or 0
			var_16_62.adv_pic_type = var_0_1.ADV_TYPE.IMAGE
			var_16_62.cond_type = var_0_1.COND_TYPE.CONFIG
			var_16_62.func_id = var_16_1.func_id
			var_16_62.time_type = var_16_1.time_type
			var_16_62.start_time = var_16_2:getStartTime()
			var_16_62.end_time = var_16_2:getFinishTime()
			var_16_62.show_start_time = var_16_2:getPreviewTime()
			var_16_62.show_end_time = var_16_2:getExpireTime()
			var_16_62.type = var_16_1.type
			var_16_62.image = var_16_1.icon
			var_16_62.sort = var_16_1.sort
			var_16_62.skipType = var_0_1.SKIP_TYPE.FUNCTION_ROUTE

			if var_16_1.func_id == var_0_16.SEVEN_DAYS_ACTIVITY or var_16_1.func_id == var_0_16.SEVEN_DAYS_ACTIVITY_2 then
				if var_0_17:isShow7DaysActivity(var_16_1.func_id) then
					table.insert(self._listConfig, var_16_62)
				end
			else
				table.insert(self._listConfig, var_16_62)
			end
		end
	end
end

return OpenScreenData
