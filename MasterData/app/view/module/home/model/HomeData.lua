local var_0_0 = g.core.config.banner_info
local var_0_1 = g.core.config.activity_enter_info
local var_0_2 = g.core.const.ConstMgr
local var_0_3 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_4 = g.core.const.ConstMgr.CensorConst
local HomeConst = require("app.view.module.home.const.HomeConst")
local HomeActivityCheckFunction = require("app.view.module.home.common.HomeActivityCheckFunction")
local var_0_7 = g.core.config.home_expand_info
local var_0_8 = g.core.model.User
local HomeData = class("HomeData")

function HomeData:ctor()
	self:initData()
end

function HomeData:initData()
	self._initBanner = false
	self._showBannerList = {}
	self._isNeedUpdateBanner = false
	self._initActivityList = false
	self._showActivityList = {}
	self._spineUseTimeList = {}
	self._serverGitBranch = ""
	self._serverGitVersion = ""
	self._serverJenkinsVersion = ""
	self._isGmFirstReq = true
	self._gmUnputList = {}

	for iter_2_0, iter_2_1 in pairs(HomeConst.GM_UNPUT_INFO_LIST) do
		self._gmUnputList[iter_2_0] = {}
	end

	self._needUnputList = {}
	self._censorList = {}
	self._localCensorData = {}
	self._requireZipList = {}
	self._harmoniousMysteryList = {}
	self._isCodeCorrect = false
	self._initedHarmoniousMystery = false
	self._topSwitch = 0
	self._userCodeRecord = {}
	self._recordPopAutoFinish = {}
	self._firstLoginHome = true
	self._mainQuestIdProgMap = {}

	self:initExpandData()
end

function HomeData:setServerGitInfo(arg_3_1)
	if not arg_3_1 then
		return
	end

	if arg_3_1.git_branch then
		local var_3_0 = string.split(arg_3_1.git_branch, "/")

		if #var_3_0 >= 2 then
			self._serverGitBranch = var_3_0[#var_3_0 - 1]
		end
	end

	self._serverGitVersion = arg_3_1.git_version or ""
	self._serverJenkinsVersion = arg_3_1.jenkins_build_num or ""
end

function HomeData:getServerGitInfo()
	if self._serverGitBranch ~= "" then
		return " b." .. self._serverGitBranch .. "_v." .. self._serverGitVersion .. "_j." .. self._serverJenkinsVersion
	else
		return ""
	end
end

function HomeData:addSpineTime(arg_5_1)
	if self._spineUseTimeList[arg_5_1] then
		self._spineUseTimeList[arg_5_1] = self._spineUseTimeList[arg_5_1] + 1

		if not device.isWindowsDebug() or g.core.resource.ResourceManager:isSpineCached(arg_5_1) or self._spineUseTimeList[arg_5_1] == 21 then
			-- block empty
		elseif self._spineUseTimeList[arg_5_1] > 21 then
			-- block empty
		end
	else
		self._spineUseTimeList[arg_5_1] = 1
	end
end

function HomeData:getSpineTimeList()
	return self._spineUseTimeList
end

function HomeData:updateBannerList()
	self._showBannerList = {}

	local var_7_0 = {}

	for iter_7_0 = 1, var_0_0.getLength() do
		local var_7_1 = var_0_0.indexOf(iter_7_0)

		if var_7_1.sort ~= 0 and not self:isCensorBanner(var_7_1.id) then
			if var_7_1.activity_type == var_0_2.ActivityConst.ACTIVITY_TYPE.SUMMER_ACTIVITY then
				local var_7_2 = var_0_8.themeData:getThemeMergeEntranceActivityData(var_7_1.activity_value)

				if var_7_2 and var_7_2:getActivityState() ~= var_0_2.ActivityConst.ACTIVITY_STATE.EXPIRE then
					local var_7_3 = var_7_2:getActivityThemeValueList()[1]

					if not var_7_0[var_7_3] then
						var_7_0[var_7_3] = true

						table.insert(self._showBannerList, {
							id = var_7_1.id
						})
					end
				end
			elseif self:isBannerActivityOpen(var_7_1, var_7_1.func_id) then
				table.insert(self._showBannerList, {
					id = var_7_1.id
				})
			elseif var_7_1.activity_type == 0 and var_7_1.activity_value == 0 and self:getSpecialActivityOpenStatus(var_7_1.func_id) then
				table.insert(self._showBannerList, {
					id = var_7_1.id
				})
			end
		end
	end

	table.sort(self._showBannerList, function(arg_8_0, arg_8_1)
		local var_8_0 = var_0_0.get(arg_8_0.id)
		local var_8_1 = var_0_0.get(arg_8_1.id)

		if var_8_0.sort ~= var_8_1.sort then
			return var_8_0.sort < var_8_1.sort
		end

		return arg_8_0.id > arg_8_1.id
	end)
end

function HomeData:getBannerList()
	if not self._initBanner then
		self:updateBannerList()

		self._initBanner = true
	end

	return self._showBannerList
end

function HomeData:isBannerActivityOpen(arg_10_1, arg_10_2)
	if arg_10_1.activity_type == 0 and arg_10_1.activity_value == 0 then
		if arg_10_2 and arg_10_2 == g.core.const.ConstMgr.FUNCTION_TYPE.SDK_H5_BANNER then
			return g.core.platform.PlatformProxy:isApplyH5Banner()
		end

		return false
	elseif arg_10_1.activity_type == var_0_2.ActivityConst.ACTIVITY_TYPE.TOTAL_RECHARGE then
		return var_0_8.totalRechargeData:isTotalChargeCanShow(arg_10_1.activity_value)
	elseif arg_10_1.activity_type == var_0_2.ActivityConst.ACTIVITY_TYPE.GMTOTAL_RECHARGE then
		return var_0_8.gmTotalRechargeData:isGmTotalRechargeOpen(arg_10_1.activity_value)
	elseif arg_10_1.activity_type == var_0_2.ActivityConst.ACTIVITY_TYPE.SEVEN_DAYS then
		return var_0_8.sevenDaysData:isShowWithActValue(arg_10_1.activity_value)
	elseif arg_10_1.activity_type == var_0_2.ActivityConst.ACTIVITY_TYPE.MONTH_GACHA then
		return var_0_8.activityMonthGachaData:isActOpen(arg_10_1.activity_value)
	elseif arg_10_1.activity_type == var_0_2.ActivityConst.ACTIVITY_TYPE.CULTIVATE then
		return var_0_8.cultivateDataMgr:isActOpen(arg_10_1.activity_value)
	elseif arg_10_1.activity_type == var_0_2.ActivityConst.ACTIVITY_TYPE.WEEKLY_COMPETITION then
		return var_0_8.weeklyCompetitionMgrData:hasWeeklyCompetitionActivityByBaseId(arg_10_1.activity_value)
	elseif arg_10_1.activity_type == var_0_2.ActivityConst.ACTIVITY_TYPE.HALF_ANNIVERSARY then
		return var_0_8.halfAnniversaryData:isActivityOpen(arg_10_1.activity_value)
	elseif arg_10_1.activity_type == var_0_2.ActivityConst.ACTIVITY_TYPE.ACTIVITY_RETURN then
		return g.core.model.User.activityReturnData:isActivityOpen(arg_10_1.activity_value)
	elseif arg_10_1.activity_type == var_0_2.ActivityConst.ACTIVITY_TYPE.CELEBRATION_LOGIN then
		return var_0_8.activityCelebrationLoginData:isShowEntrance()
	elseif arg_10_1.activity_type == var_0_2.ActivityConst.ACTIVITY_TYPE.SPRINT_RECRUIT then
		return var_0_8.recruitData:isSpringOpenByActivityValue(arg_10_1.activity_value, arg_10_2)
	elseif arg_10_1.activity_type == var_0_2.ActivityConst.ACTIVITY_TYPE.RETRO then
		return var_0_8.retroData:isActOpen(arg_10_1.activity_value)
	elseif arg_10_1.activity_type == var_0_2.ActivityConst.ACTIVITY_TYPE.SUCCUBA_LAUNCH then
		return var_0_8.succubaLaunchData:isActOpen(arg_10_1.activity_value)
	elseif arg_10_1.activity_type == var_0_2.ActivityConst.ACTIVITY_TYPE.RELEASE_ACTIVITY then
		return var_0_8.releaseActivityData:isActivityOpen(arg_10_1.activity_value)
	elseif arg_10_1.activity_type == var_0_2.ActivityConst.ACTIVITY_TYPE.SUMMER_ACTIVITY then
		local var_10_0 = var_0_8.themeData:getThemeMergeEntranceActivityData(arg_10_1.activity_value)

		if var_10_0 and var_10_0:getActivityState() ~= var_0_2.ActivityConst.ACTIVITY_STATE.EXPIRE then
			return g.core.common.ModuleUnlock:isModuleUnlock(var_0_3.SUMMER_ACTIVITY)
		end

		return false
	else
		local var_10_1 = var_0_8.activityDataManager:getShowActivityDataByCfg(arg_10_1.activity_type, arg_10_1.activity_value)

		if var_10_1 then
			if arg_10_1.activity_type == var_0_2.ActivityConst.ACTIVITY_TYPE.COMMANDER_COMPETITION then
				local var_10_2 = g.core.const.ConstMgr.CompetitionConst.ACTIVITY_FUNC[g.core.config.competition_info.get(arg_10_1.activity_value).type]

				if var_10_2 and var_10_2 > 0 then
					return g.core.common.ModuleUnlock:isModuleUnlock(var_10_2)
				else
					return true
				end
			elseif arg_10_2 == g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_PRIMARY_LIMIT then
				local var_10_3

				if var_10_1 then
					var_10_3 = var_10_1:getActivityId()

					if not var_10_1:getInfo().sub_activity_id then
						var_10_3 = var_10_1:getActivityValue()
					end
				end

				return g.core.model.User.recruitData:checkPrimaryLimitRecruitIsOpen(var_10_3)
			else
				return true
			end
		end

		return false
	end
end

function HomeData:isHomeCrossDay()
	local var_11_0 = g.core.common.ServerTime:getTime()
	local var_11_1 = var_0_8.flushInfoData:getHomeFlushTime()

	if not var_11_1 then
		var_0_8.flushInfoData:setHomeFlushTime(var_11_0)
	elseif not g.core.common.ServerTime:isToday(var_11_1) and g.core.common.ServerTime:secondsFromToday() >= 1 then
		var_0_8.flushInfoData:setHomeFlushTime(var_11_0)

		self._recordPopAutoFinish = {}

		return true
	end

	return false
end

function HomeData:updateActivityList()
	self._showActivityList = {}

	for iter_12_0 = 1, var_0_1.getLength() do
		local var_12_0 = var_0_1.indexOf(iter_12_0)

		if var_12_0.sort ~= 0 and self:getActivityOpenStatus(var_12_0) then
			table.insert(self._showActivityList, {
				id = var_12_0.id
			})
		end
	end

	table.sort(self._showActivityList, function(arg_13_0, arg_13_1)
		local var_13_0 = var_0_1.get(arg_13_0.id)
		local var_13_1 = var_0_1.get(arg_13_1.id)

		if var_13_0.sort ~= var_13_1.sort then
			return var_13_0.sort < var_13_1.sort
		end

		return arg_13_0.id > arg_13_1.id
	end)
end

function HomeData:getActivityOpenStatus(arg_14_1)
	return arg_14_1.activity_type == 0 and arg_14_1.activity_value == 0 and self:getSpecialActivityOpenStatus(arg_14_1.function_id) or arg_14_1.activity_type == var_0_2.ActivityConst.ACTIVITY_TYPE.SPRINT_RECRUIT and g.core.model.User.recruitData:isSpringOpenByActivityValue(arg_14_1.activity_value, arg_14_1.function_id) or self:isBannerActivityOpen(arg_14_1, arg_14_1.function_id)
end

function HomeData:getSpecialActivityOpenStatus(arg_15_1)
	local var_15_0 = false

	if not arg_15_1 or arg_15_1 == 0 then
		return var_15_0
	end

	if arg_15_1 == g.core.const.ConstMgr.FUNCTION_TYPE.RETURN_RECRUIT or arg_15_1 == g.core.const.ConstMgr.FUNCTION_TYPE.RETURN_RECRUIT_ARTIFACT then
		return var_0_8.recruitData:isOpenReturnActivity()
	end

	var_15_0 = HomeActivityCheckFunction[arg_15_1] ~= nil and HomeActivityCheckFunction[arg_15_1]() or false

	return var_15_0
end

function HomeData:getActivityList()
	if not self._initActivityList then
		self:updateActivityList()

		self._initActivityList = true
	end

	return self._showActivityList
end

function HomeData:isSummerThemeActivityShow()
	local var_17_0 = var_0_8.activityDataManager:getActivityData(HomeConst.THEME_ACTIVITY.type, HomeConst.THEME_ACTIVITY.value)

	return var_17_0 and var_17_0:isShow()
end

function HomeData:setNeedUpdateBanner(arg_18_1)
	self._isNeedUpdateBanner = arg_18_1 == true
end

function HomeData:getIsNeedUpdateBanner()
	self._isNeedUpdateBanner = false

	return self._isNeedUpdateBanner
end

function HomeData:setFirstLoginHome()
	self._firstLoginHome = true
end

function HomeData:getFirstLoginHome()
	self._firstLoginHome = false

	return self._firstLoginHome
end

function HomeData:getActivityTopBarTitle(arg_22_1, arg_22_2)
	for iter_22_0, iter_22_1 in var_0_1.ipairs() do
		if iter_22_1.activity_type == arg_22_1 and iter_22_1.activity_value == arg_22_2 then
			return iter_22_1.remark
		end
	end

	return ""
end

function HomeData:isGMFirstReq()
	return self._isGmFirstReq
end

function HomeData:initUnputList(arg_24_1)
	self._isGmFirstReq = false
	self._oldGmData = {}

	if arg_24_1.infos then
		for iter_24_0 = 1, #arg_24_1.infos do
			self._oldGmData[arg_24_1.infos[iter_24_0].id] = {
				arg_24_1.infos[iter_24_0]
			}
		end
	end

	self:addGmUnputList((self:packUnputList(arg_24_1.infos, true)))
end

function HomeData:addAndDelUnputList(arg_25_1)
	self._oldGmData = self._oldGmData or {}

	self:delGmUnputList((self:packUnputList(arg_25_1.del)))

	if arg_25_1.del then
		for iter_25_0 = 1, #arg_25_1.del do
			self._oldGmData[arg_25_1.del[iter_25_0].id] = nil
		end
	end

	if arg_25_1.add then
		for iter_25_1 = 1, #arg_25_1.add do
			if self._oldGmData[arg_25_1.add[iter_25_1].id] then
				self:delGmUnputList((self:packUnputList(self._oldGmData[arg_25_1.add[iter_25_1].id])))
			end
		end
	end

	self:addGmUnputList((self:packUnputList(arg_25_1.add, true)))

	if arg_25_1.add then
		for iter_25_2 = 1, #arg_25_1.add do
			self._oldGmData[arg_25_1.add[iter_25_2].id] = {
				arg_25_1.add[iter_25_2]
			}
		end
	end

	for iter_25_3, iter_25_4 in pairs(self._oldGmData) do
		self:addGmUnputList((self:packUnputList(iter_25_4, true)))
	end
end

function HomeData:checkExpiredUnputList()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(self._gmUnputList) do
		for iter_26_2, iter_26_3 in pairs(iter_26_1) do
			if iter_26_3.time and iter_26_3.time > 0 and g.core.common.ServerTime:getLeftSeconds(iter_26_3.time) <= 0 then
				var_26_0[iter_26_0] = var_26_0[iter_26_0] or {}

				table.insert(var_26_0[iter_26_0], {
					id = tonumber(iter_26_2)
				})
			end
		end
	end

	self:delGmUnputList(var_26_0)

	local var_26_1 = {}
	local var_26_2 = {}

	for iter_26_4, iter_26_5 in ipairs(self._needUnputList) do
		if iter_26_5.start_time <= g.core.common.ServerTime:getTime() then
			local var_26_3, var_26_4 = self:packUnputData(iter_26_5)

			for iter_26_6 = 1, #var_26_3 do
				var_26_1[var_26_4] = var_26_1[var_26_4] or {}

				table.insert(var_26_1[var_26_4], var_26_3[iter_26_6])
			end
		else
			table.insert(var_26_2, iter_26_5)
		end
	end

	self:addGmUnputList(var_26_1)

	self._needUnputList = var_26_2
end

function HomeData:packUnputList(arg_27_1, arg_27_2)
	if not arg_27_1 then
		return {}
	end

	local var_27_0 = {}

	for iter_27_0 = 1, #arg_27_1 do
		if self:_checkOpIds(arg_27_1[iter_27_0].op_ids) and arg_27_1[iter_27_0].items then
			for iter_27_1 = 1, #arg_27_1[iter_27_0].items do
				for iter_27_2, iter_27_3 in ipairs(arg_27_1[iter_27_0].items[iter_27_1].item_value) do
					local var_27_1 = {
						id = arg_27_1[iter_27_0].id,
						item_type = arg_27_1[iter_27_0].items[iter_27_1].item_type,
						item_value = iter_27_3,
						sort_type = arg_27_1[iter_27_0].sort_type,
						start_time = arg_27_1[iter_27_0].start_time,
						end_time = arg_27_1[iter_27_0].end_time
					}
					local var_27_2, var_27_3 = self:packUnputData(var_27_1)

					if arg_27_2 and var_27_1.start_time > g.core.common.ServerTime:getTime() then
						table.insert(self._needUnputList, var_27_1)
					else
						for iter_27_4 = 1, #var_27_2 do
							var_27_0[var_27_3] = var_27_0[var_27_3] or {}

							table.insert(var_27_0[var_27_3], var_27_2[iter_27_4])
						end
					end
				end
			end
		end
	end

	return var_27_0
end

function HomeData:packUnputData(arg_28_1)
	local var_28_0

	if not arg_28_1 then
		do return {}, "" end

		var_28_0 = {
			[g.core.common.Goods.TYPE_KNIGHT] = {
				cfgName = "knight_info",
				cfgKey = "advance_id"
			},
			[g.core.common.Goods.TYPE_ARTIFACT] = {
				cfgName = "artifact_info",
				cfgKey = "advance_code"
			},
			[g.core.common.Goods.TYPE_PET] = {
				cfgName = "pet_info",
				cfgKey = "advance_id"
			},
			[g.core.common.Goods.TYPE_UNITETOKEN] = {
				cfgName = "unite_token_info",
				cfgKey = "advance_id"
			},
			[g.core.common.Goods.TYPE_SKIN] = {
				cfgName = "skin_info"
			},
			[g.core.common.Goods.TYPE_ITEM] = {
				cfgName = "item_info"
			},
			[g.core.common.Goods.TYPE_AVATAR] = {
				cfgName = "avata_info"
			},
			[g.core.common.Goods.TYPE_AVATAR_FRAME] = {
				cfgName = "avatar_frame_info"
			},
			[g.core.common.Goods.TYPE_FURNITURE] = {
				cfgName = "furniture_info"
			},
			[g.core.common.Goods.TYPE_ROLE_SKIN] = {
				cfgName = "role_skin_info"
			}
		}
	end

	var_28_0[g.core.common.Goods.TYPE_SUCCUBA] = {
		cfgName = "succuba_info",
		cfgKey = "advance_id"
	}

	local var_28_1
	local var_28_2 = arg_28_1.sort_type or HomeConst.GM_SORT_TYPE.NORMAL

	if var_28_2 == HomeConst.GM_SORT_TYPE.NORMAL then
		var_28_1 = var_28_0[arg_28_1.item_type]
	elseif var_28_2 == HomeConst.GM_SORT_TYPE.KSOUL_CHAPTER then
		var_28_1 = {
			cfgName = "ksoul_book_chapter_info"
		}
	end

	if var_28_1 then
		local var_28_3 = {}

		if var_28_1.cfgKey then
			if g.core.config[var_28_1.cfgName].fetch(arg_28_1.item_value) then
				local var_28_4 = g.core.config[var_28_1.cfgName].get(arg_28_1.item_value)[var_28_1.cfgKey]

				for iter_28_0, iter_28_1 in ipairs((g.core.config[var_28_1.cfgName].match(function(arg_29_0)
					return arg_29_0[var_28_1.cfgKey] == var_28_4
				end))) do
					table.insert(var_28_3, {
						id = iter_28_1.id,
						startTime = arg_28_1.start_time,
						time = arg_28_1.end_time,
						type = arg_28_1.item_type
					})
				end
			end
		else
			table.insert(var_28_3, {
				id = arg_28_1.item_value,
				startTime = arg_28_1.start_time,
				time = arg_28_1.end_time,
				type = arg_28_1.item_type
			})
		end

		return var_28_3, var_28_1.cfgName
	else
		return {}, ""
	end
end

function HomeData:addGmUnputList(arg_30_1)
	for iter_30_0, iter_30_1 in pairs(arg_30_1) do
		if self._gmUnputList[iter_30_0] then
			for iter_30_2 = 1, #iter_30_1 do
				local var_30_0 = iter_30_1[iter_30_2]

				if g.core.config[iter_30_0].fetch(iter_30_1[iter_30_2].id) and HomeConst.GM_UNPUT_INFO_LIST[iter_30_0] then
					if not self._gmUnputList[iter_30_0][tostring(iter_30_1[iter_30_2].id)] then
						local var_30_1 = clone(HomeConst.GM_UNPUT_INFO_LIST[iter_30_0])

						var_30_1.time = var_30_0.time

						for iter_30_3, iter_30_4 in pairs(HomeConst.GM_UNPUT_INFO_LIST[iter_30_0]) do
							if g.core.config[iter_30_0].hasKey(iter_30_3) then
								var_30_1["old_" .. iter_30_3] = g.core.config[iter_30_0].get(iter_30_1[iter_30_2].id)[iter_30_3]

								g.core.config[iter_30_0].set(iter_30_1[iter_30_2].id, iter_30_3, iter_30_4)

								if iter_30_0 == "avata_info" then
									g.core.model.User.userAvatarFrameData:updateAvatar(iter_30_1[iter_30_2].id)
								elseif iter_30_0 == "avatar_frame_info" then
									g.core.model.User.userAvatarFrameData:updateFrame(iter_30_1[iter_30_2].id)
								end

								g.core.model.User.echoLabData:getCollectData():updateUnputCard(var_30_0.type, var_30_0.id)
							end
						end

						self._gmUnputList[iter_30_0][tostring(iter_30_1[iter_30_2].id)] = var_30_1
					end
				else
					g.core.log:error("not found gm unput id : " .. iter_30_1[iter_30_2].id .. " in cfg: " .. iter_30_0)
				end
			end
		end
	end

	g.core.model.User.echoLabData:getCollectData():doSortWhenIsDirty()
end

function HomeData:delGmUnputList(arg_31_1)
	for iter_31_0, iter_31_1 in pairs(arg_31_1) do
		if self._gmUnputList[iter_31_0] then
			for iter_31_2 = 1, #iter_31_1 do
				local var_31_0 = self._gmUnputList[iter_31_0][tostring(iter_31_1[iter_31_2].id)]

				if g.core.config[iter_31_0].fetch(iter_31_1[iter_31_2].id) and var_31_0 then
					for iter_31_3, iter_31_4 in pairs(HomeConst.GM_UNPUT_INFO_LIST[iter_31_0]) do
						if g.core.config[iter_31_0].hasKey(iter_31_3) then
							g.core.config[iter_31_0]:set(iter_31_3, var_31_0["old_" .. iter_31_3] or 1)
						end
					end

					self._gmUnputList[iter_31_0][tostring(iter_31_1[iter_31_2].id)] = nil
				end
			end
		end
	end

	for iter_31_5, iter_31_6 in ipairs(arg_31_1.avata_info or {}) do
		if g.core.config.avata_info.fetch(iter_31_6.id) then
			g.core.model.User.userAvatarFrameData:updateAvatar(iter_31_6.id)
		end
	end

	for iter_31_7, iter_31_8 in ipairs(arg_31_1.avatar_frame_info or {}) do
		if g.core.config.avatar_frame_info.fetch(iter_31_8.id) then
			g.core.model.User.userAvatarFrameData:updateFrame(iter_31_8.id)
		end
	end
end

function HomeData:checkItemIsInUnputList(arg_32_1, arg_32_2)
	return self._gmUnputList[arg_32_1][tostring(arg_32_2)] ~= nil
end

function HomeData:initExpandData()
	self._expandData = {}

	for iter_33_0 = 1, var_0_7.getLength() do
		local var_33_0 = var_0_7.indexOf(iter_33_0)

		if self._expandData[var_33_0.type] then
			table.insert(self._expandData[var_33_0.type], var_33_0)
		else
			self._expandData[var_33_0.type] = {
				var_33_0
			}
		end
	end
end

function HomeData:getExpandDataByType(arg_34_1)
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in ipairs(self._expandData[arg_34_1]) do
		if g.core.common.ModuleUnlock:isModuleShow(iter_34_1.function_id) then
			table.insert(var_34_0, iter_34_1)
		elseif iter_34_1.function_id == g.core.const.ConstMgr.FUNCTION_TYPE.SUCCUBA and g.core.common.ModuleUnlock:isFunctionUnlock(iter_34_1.function_id) then
			table.insert(var_34_0, iter_34_1)
		end
	end

	return var_34_0
end

function HomeData:initCensorList(arg_35_1)
	self._localCensorData = {}
	self._censorList = {}
	self._requireZipList = {}

	if g.core.utils.Rule.isDownloadAllHqZips() then
		self:requireAllCensorZipsForTishen()

		return
	end

	if arg_35_1.infos then
		for iter_35_0, iter_35_1 in ipairs(arg_35_1.infos) do
			self._localCensorData[iter_35_1.id] = iter_35_1

			local var_35_0 = 1

			if iter_35_1.sort_type == 3 then
				var_35_0 = 2
			elseif iter_35_1.sort_type == 6 then
				var_35_0 = 3
			elseif iter_35_1.sort_type >= 8 then
				var_35_0 = iter_35_1.sort_type
			end

			self._censorList[var_35_0] = self._censorList[var_35_0] or {}

			self:addCensorList(iter_35_1, var_35_0)
		end

		self:requireCensorZip()
	end

	if g.core.const.ConstMgr.BASE_CONST.CENSOR_USER_LIST[tostring((g.core.model.User:getPlatUserId()))] or self:getStorageCensorStatus() then
		self:requireAllHarmoniousMysteryZips()
	end
end

function HomeData:addAndDelCensorList(arg_36_1)
	if arg_36_1.updates then
		for iter_36_0, iter_36_1 in ipairs(arg_36_1.updates) do
			self:updateCensorList(iter_36_1)
		end
	end

	if arg_36_1.dels then
		for iter_36_2, iter_36_3 in ipairs(arg_36_1.dels) do
			self:delCensorList(iter_36_3)
		end
	end
end

function HomeData:updateCensorList(arg_37_1)
	local var_37_0 = self._localCensorData[arg_37_1.id]
	local var_37_1 = 1

	if arg_37_1.sort_type == 3 then
		var_37_1 = 2
	elseif arg_37_1.sort_type == 6 then
		var_37_1 = 3
	elseif arg_37_1.sort_type >= 8 then
		var_37_1 = arg_37_1.sort_type
	end

	if var_37_0 and var_37_0.ids and next(var_37_0.ids) then
		for iter_37_0, iter_37_1 in ipairs(var_37_0.ids) do
			if self._censorList[var_37_1] then
				self._censorList[var_37_1][iter_37_1] = nil
			end
		end
	end

	self:addCensorList(arg_37_1, var_37_1, true)
	self:requireCensorZip()
end

function HomeData:delCensorList(arg_38_1)
	local var_38_0 = self._localCensorData[arg_38_1]

	if self._localCensorData[arg_38_1] then
		local var_38_1 = 1

		if var_38_0.sort_type == 3 then
			var_38_1 = 2
		elseif var_38_0.sort_type == 6 then
			var_38_1 = 3
		elseif var_38_0.sort_type >= 8 then
			var_38_1 = var_38_0.sort_type
		end

		if var_38_0 then
			self._censorList[var_38_1] = {}
		end

		self._localCensorData[arg_38_1] = nil
	end
end

function HomeData:_checkOpIds(arg_39_1)
	local var_39_0 = true

	if arg_39_1 and #arg_39_1 > 1 then
		var_39_0 = false

		local var_39_1 = g.core.platform.PlatformProxy:getOpId()

		for iter_39_0, iter_39_1 in ipairs((arg_39_1:split(","))) do
			if iter_39_1 == tostring(var_39_1) then
				var_39_0 = true

				break
			end
		end
	end

	return var_39_0
end

function HomeData:addCensorList(arg_40_1, arg_40_2, arg_40_3)
	if not self:_checkOpIds(arg_40_1.op_ids) then
		return
	end

	local var_40_0 = g.core.model.User:getLevel()

	self._censorList[arg_40_2] = self._censorList[arg_40_2] or {}

	if arg_40_2 == 3 then
		if (arg_40_1.min_level == 0 or var_40_0 > arg_40_1.min_level) and (arg_40_1.max_level == 0 or var_40_0 < arg_40_1.max_level) and (arg_40_1.start_time == 0 or g.core.common.ServerTime:getLeftSeconds(arg_40_1.start_time) <= 0) and (arg_40_1.end_time == 0 or g.core.common.ServerTime:getLeftSeconds(arg_40_1.end_time) > 0) and (arg_40_1.open_day == 0 or g.core.common.ServerTime:getOpenDays() >= arg_40_1.open_day) then
			self._censorList[arg_40_2][1] = {
				id = 1,
				endTime = arg_40_1.end_time,
				max_level = arg_40_1.max_level
			}
		end
	elseif arg_40_1.ids and next(arg_40_1.ids) then
		for iter_40_0, iter_40_1 in ipairs(arg_40_1.ids) do
			if (arg_40_1.min_level == 0 or var_40_0 >= arg_40_1.min_level) and (arg_40_1.max_level == 0 or var_40_0 <= arg_40_1.max_level) and (arg_40_1.start_time == 0 or g.core.common.ServerTime:getLeftSeconds(arg_40_1.start_time) <= 0) and (arg_40_1.end_time == 0 or g.core.common.ServerTime:getLeftSeconds(arg_40_1.end_time) > 0) and (arg_40_1.open_day == 0 or g.core.common.ServerTime:getOpenDays() >= arg_40_1.open_day) then
				self._censorList[arg_40_2][iter_40_1] = {
					id = iter_40_1,
					endTime = arg_40_1.end_time,
					max_level = arg_40_1.max_level
				}

				if arg_40_1.relate_kinds and arg_40_1.relate_kinds[iter_40_0] then
					self:addRelateOpenScreen(arg_40_2, iter_40_1, arg_40_1)
				end

				self:addRelateBanner(arg_40_2, iter_40_1, arg_40_1)
			end
		end
	end

	if arg_40_3 then
		self._localCensorData[arg_40_1.id] = arg_40_1
	end
end

function HomeData:addRelateOpenScreen(arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.LIMIT_RECRUIT

	if var_0_4.CENSOR_TYPE.THEME_ACTIVITY == arg_41_1 then
		var_41_0 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.SUMMER_ACTIVITY
	end

	for iter_41_0, iter_41_1 in ipairs(g.core.config.openscreen_info.match(function(arg_42_0)
		return arg_42_0.activity_type == var_41_0 and arg_42_0.activity_value == arg_41_2
	end) or {}) do
		self._censorList[var_0_4.CENSOR_TYPE.OPEN_ADV] = self._censorList[var_0_4.CENSOR_TYPE.OPEN_ADV] or {}
		self._censorList[var_0_4.CENSOR_TYPE.OPEN_ADV][iter_41_1.id] = {
			id = iter_41_1.id,
			endTime = arg_41_3.end_time,
			max_level = arg_41_3.max_level
		}
	end
end

function HomeData:addRelateBanner(arg_43_1, arg_43_2, arg_43_3)
	local var_43_0 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.LIMIT_RECRUIT

	if var_0_4.CENSOR_TYPE.THEME_ACTIVITY == arg_43_1 then
		var_43_0 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.SUMMER_ACTIVITY
	end

	for iter_43_0, iter_43_1 in ipairs(var_0_0.match(function(arg_44_0)
		return arg_44_0.activity_type == var_43_0 and arg_44_0.activity_value == arg_43_2
	end) or {}) do
		self._censorList[var_0_4.CENSOR_TYPE.BANNER] = self._censorList[var_0_4.CENSOR_TYPE.BANNER] or {}
		self._censorList[var_0_4.CENSOR_TYPE.BANNER][iter_43_1.id] = {
			id = iter_43_1.id,
			endTime = arg_43_3.end_time,
			max_level = arg_43_3.max_level
		}
	end
end

function HomeData:checkExpiredCensorList()
	for iter_45_0, iter_45_1 in pairs(self._localCensorData) do
		local var_45_0 = 1

		if iter_45_1.sort_type == 3 then
			var_45_0 = 2
		elseif iter_45_1.sort_type == 6 then
			var_45_0 = 3
		elseif iter_45_1.sort_type >= 8 then
			var_45_0 = iter_45_1.sort_type
		end

		if iter_45_1 and iter_45_1.ids and next(iter_45_1.ids) then
			for iter_45_2, iter_45_3 in ipairs(iter_45_1.ids) do
				self._censorList[var_45_0][iter_45_3] = nil
			end
		end

		self:addCensorList(iter_45_1, var_45_0)
		self:requireCensorZip()
	end
end

function HomeData:getCensorList(arg_46_1)
	return self._censorList[arg_46_1]
end

function HomeData:checkReverseCensorItem(arg_47_1, arg_47_2)
	if not self._censorList[arg_47_1] or not next(self._censorList[arg_47_1]) then
		return false
	end

	if self._censorList[arg_47_1][arg_47_2] and self._censorList[arg_47_1][arg_47_2] == nil then
		for iter_47_0, iter_47_1 in pairs(self._censorList[arg_47_1]) do
			self:checkAndRemoveUnableInfo(arg_47_1, iter_47_0)
		end

		if not next(self._censorList[arg_47_1]) then
			return false
		end
	end

	return not self:checkAndRemoveUnableInfo(arg_47_1, arg_47_2)
end

function HomeData:checkAndRemoveUnableInfo(arg_48_1, arg_48_2)
	if not self._censorList[arg_48_1] then
		return false
	end

	local var_48_0 = self:checkCensorInfoIsEnable(self._censorList[arg_48_1][arg_48_2])

	if not var_48_0 then
		self._censorList[arg_48_1][arg_48_2] = nil
	end

	return var_48_0
end

function HomeData:checkCensorInfoIsEnable(arg_49_1)
	return arg_49_1 and g.core.common.ServerTime:getTime() < arg_49_1.endTime and g.core.model.User:getLevel() <= arg_49_1.max_level
end

function HomeData:getCensorListById(arg_50_1, arg_50_2)
	if arg_50_2 == 2 and g.core.const.ConstMgr.BASE_CONST.UN_SHOW_ALL_BATTLE_CG then
		return true
	end

	if self._censorList[arg_50_2] then
		return self._censorList[arg_50_2][arg_50_1]
	else
		return false
	end
end

function HomeData:isCensorPv()
	if self._censorList[3] then
		return self._censorList[3][1]
	else
		return false
	end
end

function HomeData:isCensorFunction(arg_52_1)
	local var_52_0 = false

	if self._censorList[var_0_4.CENSOR_TYPE.FUNCTION] then
		if self:checkCensorInfoIsEnable(self._censorList[var_0_4.CENSOR_TYPE.FUNCTION][arg_52_1]) then
			var_52_0 = self._censorList[var_0_4.CENSOR_TYPE.FUNCTION][arg_52_1]
		end
	end

	return var_52_0
end

function HomeData:isCensorTheme(arg_53_1)
	local var_53_0 = false

	if self._censorList[var_0_4.CENSOR_TYPE.THEME_ACTIVITY] then
		if self:checkCensorInfoIsEnable(self._censorList[var_0_4.CENSOR_TYPE.THEME_ACTIVITY][arg_53_1]) then
			var_53_0 = self._censorList[var_0_4.CENSOR_TYPE.THEME_ACTIVITY][arg_53_1]
		end
	end

	return var_53_0
end

function HomeData:isCensorRecruit(arg_54_1)
	local var_54_0 = false

	if self._censorList[var_0_4.CENSOR_TYPE.RECRUIT_ACTIVITY] then
		if self:checkCensorInfoIsEnable(self._censorList[var_0_4.CENSOR_TYPE.RECRUIT_ACTIVITY][arg_54_1]) then
			var_54_0 = self._censorList[var_0_4.CENSOR_TYPE.RECRUIT_ACTIVITY][arg_54_1]
		end
	end

	return var_54_0
end

function HomeData:isCensorSign(arg_55_1)
	local var_55_0 = false

	if self._censorList[var_0_4.CENSOR_TYPE.SIGN_ACTIVITY] then
		if self:checkCensorInfoIsEnable(self._censorList[var_0_4.CENSOR_TYPE.SIGN_ACTIVITY][arg_55_1]) then
			var_55_0 = self._censorList[var_0_4.CENSOR_TYPE.SIGN_ACTIVITY][arg_55_1]
		end
	end

	return var_55_0
end

function HomeData:isCensorAdv(arg_56_1)
	local var_56_0 = false

	if self._censorList[var_0_4.CENSOR_TYPE.OPEN_ADV] then
		if self:checkCensorInfoIsEnable(self._censorList[var_0_4.CENSOR_TYPE.OPEN_ADV][arg_56_1]) then
			var_56_0 = self._censorList[var_0_4.CENSOR_TYPE.OPEN_ADV][arg_56_1]
		end
	end

	return var_56_0
end

function HomeData:isCensorBanner(arg_57_1)
	local var_57_0 = false

	if self._censorList[var_0_4.CENSOR_TYPE.BANNER] then
		if self:checkCensorInfoIsEnable(self._censorList[var_0_4.CENSOR_TYPE.BANNER][arg_57_1]) then
			var_57_0 = self._censorList[var_0_4.CENSOR_TYPE.BANNER][arg_57_1]
		end
	end

	return var_57_0
end

function HomeData:isCensorRigid(arg_58_1)
	if config.DEBUG_VERSION and require("app.view.module.debug.common.DebugCommon").getDebugGlobalValueByKey("force_rigid") then
		return true
	end

	local var_58_0 = false

	if self._censorList[var_0_4.CENSOR_TYPE.RIGID] and next(self._censorList[var_0_4.CENSOR_TYPE.RIGID]) then
		if arg_58_1 then
			if self._censorList[var_0_4.CENSOR_TYPE.RIGID][0] == nil then
				var_58_0 = self._censorList[var_0_4.CENSOR_TYPE.RIGID][arg_58_1]
			elseif self._censorList[var_0_4.CENSOR_TYPE.RIGID][0] then
				var_58_0 = true
			end
		else
			var_58_0 = true
		end
	end

	return var_58_0
end

function HomeData:requireCensorZip()
	if g.core.utils.Tools.checkSilentFull() == 0 and not g.core.guide.GuideProxy:isGuideRunning() and not g.core.model.User.splitDownloadData:isShowDownloadListPop() then
		local var_59_0 = {}

		if self._censorList[1] and next(self._censorList[1]) then
			for iter_59_0, iter_59_1 in pairs(self._censorList[1]) do
				if not self._requireZipList["ks_" .. iter_59_0 .. ".zip"] then
					var_59_0["ks_" .. iter_59_0 .. ".zip"] = true
					self._requireZipList["ks_" .. iter_59_0 .. ".zip"] = true
				end
			end
		end

		if next(var_59_0) then
			require("upgrade.UpgradeHQuality").start(var_59_0)
		end
	end
end

function HomeData:requireAllCensorZipsForTishen()
	local var_60_0 = {}

	for iter_60_0, iter_60_1 in g.core.config.knight_base_info.ipairs() do
		if not self._requireZipList["ks_" .. iter_60_1.id .. ".zip"] then
			var_60_0["ks_" .. iter_60_1.id .. ".zip"] = true
			self._requireZipList["ks_" .. iter_60_1.id .. ".zip"] = true
		end
	end

	if next(var_60_0) then
		require("upgrade.UpgradeHQuality").start(var_60_0)
	end
end

function HomeData:setPopPos(arg_61_1)
	self._embryoPopPos = arg_61_1
end

function HomeData:getPopPos()
	return self._embryoPopPos
end

function HomeData:initHarmoniousMysteryList(arg_63_1)
	self._initedHarmoniousMystery = true

	if arg_63_1.switch_info then
		self._topSwitch = arg_63_1.switch_info.switch
	end

	if arg_63_1.code_infos then
		self:addHarmoniousMysteryList(arg_63_1.code_infos)
	end

	if arg_63_1.user_infos then
		self:addCensorUserId(arg_63_1.user_infos)
	end

	self._userCodeRecord = {}

	for iter_63_0, iter_63_1 in pairs(g.core.common.Storage:load("HarmoniousMystery.json", false) or {}) do
		self._userCodeRecord[iter_63_1.id] = iter_63_1.code
	end

	self:isCodeCorrect()
end

function HomeData:addAndDelHarmoniousMysteryList(arg_64_1)
	if arg_64_1.switch_info then
		self._topSwitch = arg_64_1.switch_info.switch
	end

	if arg_64_1.update_code_infos then
		self:addHarmoniousMysteryList(arg_64_1.update_code_infos)
	end

	if arg_64_1.del_code_ids then
		self:delHarmoniousMysteryList(arg_64_1.del_code_ids)
	end

	if arg_64_1.update_user_infos then
		self:addCensorUserId(arg_64_1.update_user_infos)
	end

	self:isCodeCorrect()
end

function HomeData:addHarmoniousMysteryList(arg_65_1)
	for iter_65_0, iter_65_1 in ipairs(arg_65_1) do
		self._harmoniousMysteryList[iter_65_1.id] = iter_65_1
	end
end

function HomeData:delHarmoniousMysteryList(arg_66_1)
	for iter_66_0, iter_66_1 in ipairs(arg_66_1) do
		self._harmoniousMysteryList[iter_66_1] = nil
	end
end

function HomeData:isHarmoniousMystery()
	return self._topSwitch == 1 and self._isCodeCorrect
end

function HomeData:isCodeCorrect(arg_68_1)
	self._isCodeCorrect = false
	self._isCode = false

	local var_68_0 = g.core.common.ServerTime:getTime()

	if arg_68_1 then
		for iter_68_0, iter_68_1 in pairs(self._harmoniousMysteryList) do
			if arg_68_1 == iter_68_1.code and var_68_0 >= iter_68_1.start_time and var_68_0 < iter_68_1.end_time then
				self._userCodeRecord[iter_68_0] = arg_68_1
				self._isCodeCorrect = true
				self._isCode = true
			end

			if arg_68_1 == iter_68_1.close_code and var_68_0 >= iter_68_1.start_time and var_68_0 < iter_68_1.end_time then
				self._userCodeRecord[iter_68_0] = nil
				self._isCode = true
			end
		end
	end

	for iter_68_2, iter_68_3 in pairs(self._userCodeRecord) do
		if self._harmoniousMysteryList[iter_68_2] then
			if var_68_0 >= self._harmoniousMysteryList[iter_68_2].start_time and var_68_0 < self._harmoniousMysteryList[iter_68_2].end_time then
				self._isCodeCorrect = true
			else
				self._userCodeRecord[iter_68_2] = nil
			end
		else
			self._userCodeRecord[iter_68_2] = nil
		end
	end

	if self._topSwitch == 1 and self._isCodeCorrect then
		self:requireAllHarmoniousMysteryZips()
	end

	local var_68_1 = {}

	for iter_68_4, iter_68_5 in pairs(self._userCodeRecord) do
		table.insert(var_68_1, {
			id = iter_68_4,
			code = iter_68_5
		})
	end

	g.core.common.Storage:save("HarmoniousMystery.json", var_68_1, false)

	if arg_68_1 and not self._isCode then
		return true
	end
end

function HomeData:checkHarmoniousMysteryList()
	self:isCodeCorrect()
end

function HomeData:requireAllHarmoniousMysteryZips()
	if g.core.utils.Tools.checkSilentFull() == 0 and not g.core.guide.GuideProxy:isGuideRunning() and not g.core.model.User.splitDownloadData:isShowDownloadListPop() then
		self:requireAllCensorZipsForTishen()
	end
end

function HomeData:isInitHarmoniousMystery()
	return self._initedHarmoniousMystery
end

function HomeData:isTopSwitch()
	return self._topSwitch == 1
end

function HomeData:addCensorUserId(arg_73_1)
	arg_73_1 = arg_73_1 or {}

	for iter_73_0 = 1, #arg_73_1 do
		local var_73_0 = arg_73_1[iter_73_0].user_ids or {}
		local var_73_1 = arg_73_1[iter_73_0].tp or 0

		for iter_73_1 = 1, #var_73_0 do
			if var_73_1 == 0 then
				g.core.const.ConstMgr.BASE_CONST.CENSOR_USER_LIST[tostring(var_73_0[iter_73_1])] = true
			elseif tostring(var_73_0[iter_73_1]) == tostring(g.core.model.User:getId()) then
				self._censorList[var_0_4.CENSOR_TYPE.RIGID] = self._censorList[var_0_4.CENSOR_TYPE.RIGID] or {}
				self._censorList[var_0_4.CENSOR_TYPE.RIGID][0] = true
			end
		end
	end
end

function HomeData:getStorageCensorStatus()
	if self._censorJsonResult ~= nil then
		return self._censorJsonResult
	end

	local var_74_0 = g.core.common.Storage:load("such_a_hot_weather.json") or {}
	local var_74_1 = cc.FileUtils:getInstance():getWritablePath()
	local var_74_2 = var_74_0.isHot

	if not var_74_0.isHot then
		var_74_2 = cc.FileUtils:getInstance():isFileExist(((device.isAndroid() or nil) and g.core.platform.PlatformProxy:getPackageStorageDir()) .. "/such_a_hot_weather.json")

		if not var_74_2 then
			var_74_2 = cc.FileUtils:getInstance():isFileExist((g.core.common.Storage:returnFullPath("such_a_hot_weather.json")))
			var_74_2 = var_74_2 or false
		end
	end

	self._censorJsonResult = var_74_2

	return self._censorJsonResult
end

function HomeData:getWelfareInfo()
	local var_75_0 = {}
	local var_75_1 = g.core.config.function_info.get(g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_PRIMARY)
	local var_75_2 = var_75_1.name

	var_75_0[#var_75_0 + 1] = {
		title = var_75_1.name,
		value = var_75_1.show_level,
		tip = g.core.lang:get(300009, {
			chapter = var_75_1.show_level
		}),
		detail = g.core.lang:get(108451, {
			chapter = var_75_1.show_level
		})
	}

	local var_75_3 = g.core.config.function_info.get(g.core.const.ConstMgr.FUNCTION_TYPE.PRE_REGISTRATION)

	var_75_0[#var_75_0 + 1] = {
		title = var_75_3.name,
		value = var_75_3.show_level,
		tip = g.core.lang:get(300009, {
			chapter = var_75_3.show_level
		}),
		detail = g.core.lang:get(108450, {
			chapter = var_75_3.show_level
		})
	}

	local var_75_4 = g.core.config.function_info.get(g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_RECRUIT)

	var_75_0[#var_75_0 + 1] = {
		title = var_75_4.name,
		value = var_75_4.show_level,
		tip = g.core.lang:get(300009, {
			chapter = var_75_4.show_level
		}),
		detail = g.core.lang:get(108449, {
			chapter = var_75_4.show_level
		})
	}

	local var_75_5 = g.core.config.recruit_novice_condition_info:getLength()

	for iter_75_0 = 1, 2 do
		local var_75_6 = g.core.config.recruit_novice_condition_info.indexOf(iter_75_0)

		var_75_0[#var_75_0 + 1] = {
			title = var_75_2,
			value = var_75_6.receive_type_times,
			tip = g.core.lang:get(108447, {
				chapter = var_75_6.receive_type_times
			}),
			detail = g.core.lang:get(108452, {
				chapter = var_75_6.receive_type_times
			})
		}
	end

	local var_75_7 = g.core.config.achievement_info.get(10029)

	var_75_0[#var_75_0 + 1] = {
		title = var_75_7.name,
		value = var_75_7.num,
		tip = g.core.lang:get(108447, {
			chapter = var_75_7.num
		}),
		detail = g.core.lang:get(108453, {
			chapter = var_75_7.num
		})
	}

	local var_75_8 = g.core.config.achievement_info.get(10030)

	var_75_0[#var_75_0 + 1] = {
		title = g.core.lang:get(108456),
		value = var_75_8.num,
		tip = g.core.lang:get(108447, {
			chapter = var_75_8.num
		}),
		detail = g.core.lang:get(108454, {
			chapter = var_75_8.num
		})
	}

	local var_75_9 = g.core.config.achievement_info.get(10031)

	var_75_0[#var_75_0 + 1] = {
		title = g.core.lang:get(108462),
		value = var_75_9.num,
		tip = g.core.lang:get(108447, {
			chapter = var_75_9.num
		}),
		detail = g.core.lang:get(108460, {
			chapter = var_75_9.num
		})
	}

	table.sort(var_75_0, function(arg_76_0, arg_76_1)
		return arg_76_0.value < arg_76_1.value
	end)

	local var_75_10
	local var_75_11 = g.core.model.User.dungeonData:getPassedChapterNum()

	for iter_75_1, iter_75_2 in ipairs(var_75_0) do
		if var_75_11 < iter_75_2.value then
			var_75_10 = iter_75_2

			break
		end
	end

	return var_75_10
end

function HomeData:setAutoPopFunc(arg_77_1, arg_77_2)
	arg_77_2 = arg_77_2 or ""
	self._recordPopAutoFinish[arg_77_1 .. "_" .. arg_77_2] = true
end

function HomeData:isRecordPop(arg_78_1, arg_78_2)
	if arg_78_1 == var_0_3.OPEN_SCREEN_AD and not arg_78_2 then
		return false
	end

	arg_78_2 = arg_78_2 or ""

	return self._recordPopAutoFinish[arg_78_1 .. "_" .. arg_78_2]
end

function HomeData:onS2CMainTaskGetInfo(arg_79_1)
	self._mainQuestIdProgMap = arg_79_1.task or {}
end

function HomeData:onS2CMainTaskGetAward(arg_80_1)
	local var_80_0 = g.core.config.main_quest_info.get(arg_80_1.id)

	if var_80_0.next_id == 0 then
		self._mainQuestIdProgMap = {}
	elseif self._mainQuestIdProgMap[1].type ~= var_80_0.next_id then
		self._mainQuestIdProgMap = {
			{
				value = 0,
				type = var_80_0.next_id
			}
		}
	end
end

function HomeData:onS2CMainTaskNotify(arg_81_1)
	self._mainQuestIdProgMap = arg_81_1.task or {}
end

function HomeData:getShowMainQuest()
	if #self._mainQuestIdProgMap == 0 then
		return nil
	else
		return self._mainQuestIdProgMap[1]
	end
end

function HomeData:isShowMainQuest()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.MAIN_QUEST) then
		return false
	elseif not self:getShowMainQuest() then
		return false
	end

	return true
end

return HomeData
