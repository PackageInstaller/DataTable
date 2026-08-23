local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = g.core.common.ModuleUnlock
local var_0_2 = g.core.network.GameNetProxy
local var_0_3 = g.core.const.ConstMgr.ThemeConst
local CrossDayService = class("CrossDayService")

function CrossDayService:ctor()
	self._updateDirty = false
	self._syncOpenTime = false
end

function CrossDayService:start()
	local var_2_0, var_2_1 = g.core.common.ServerTime:getTimeNumByMinStep(15)

	self._quarterMinNum = var_2_1

	self:_reinitDatas()

	self._handler = self._handler or g.core.layer.LayerManager:getRoot():newSchedule(handler(self, self._onUpdate), 1)
end

function CrossDayService:onSyncOpenTimeEnd()
	self._syncOpenTime = true
	self.openDays = self.openDays or g.core.common.ServerTime:getOpenDays()
end

function CrossDayService:reset()
	if self._handler then
		g.core.layer.LayerManager:getRoot():cancelSchedule(self._handler)

		self._handler = nil
	end

	self._updateDirty = false
	self._syncOpenTime = false
	self.openDays = 0
end

function CrossDayService:_onUpdate(arg_5_1, arg_5_2)
	if not self._syncOpenTime then
		return
	end

	local var_5_0 = g.core.guide.GuideProxy:isGuideRunning()

	if not var_5_0 and self._updateDirty then
		self._updateDirty = false

		self:_reinitDatas()
		self:_crossSetDatas()

		return
	end

	local var_5_1 = g.core.common.ServerTime:getOpenDays()

	if var_5_1 ~= self.openDays then
		self.openDays = var_5_1

		if var_5_0 then
			self._updateDirty = true

			return
		end

		g.core.common.Scheduler:newScheduleOnce(function()
			self:_reinitDatas()
			self:_crossSetDatas()
		end, math.random(200, 300) / 100)
		g.core.common.Scheduler:newScheduleOnce(function()
			self:_reqCrossSerDatas()
		end, 30 + math.random(10))

		if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.WEEKLY_COMPETITION) then
			g.core.common.Scheduler:newScheduleOnce(function()
				g.core.model.User.weeklyCompetitionMgrData:setGiftDirty()
				g.core.network.GameNetProxy:send_C2S_WeeklyCompetition_Info({})
			end, 90 + math.random(10))
		end
	end

	local var_5_2, var_5_3 = g.core.common.ServerTime:getTimeNumByMinStep(15)

	if var_5_2 and self._quarterMinNum ~= var_5_3 then
		self._quarterMinNum = var_5_3

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_QUARTER_MINUTE_NOTIFY, false, var_5_3)
	end

	local var_5_4, var_5_5 = g.core.common.ServerTime:getTimeNumByMinStep(30)

	if var_5_4 then
		g.core.model.User.homeData:checkExpiredUnputList()
		g.core.model.User.homeData:checkExpiredCensorList()
		g.core.model.User.homeData:checkHarmoniousMysteryList()
	end
end

function CrossDayService:_crossSetDatas()
	var_0_2:send_C2S_Activity_Common_GetInfoServer({})

	if var_0_1:isModuleUnlock(var_0_0.ACTIVITY_SIGNIN) then
		var_0_2:send_C2S_SignIn_Info({})
	end

	if var_0_1:isModuleUnlock(var_0_0.SEVEN_DAYS_SIGN_IN) then
		var_0_2:send_C2S_LoginReward_Info({})
	end

	if var_0_1:isModuleUnlock(var_0_0.SEVEN_DAYS_ACTIVITY) then
		var_0_2:send_C2S_NewSevendays_Info({
			type = g.core.model.User.sevenDaysData:getActValueByFunId(var_0_0.SEVEN_DAYS_ACTIVITY)
		})
	end

	if var_0_1:isModuleUnlock(var_0_0.SEVEN_DAYS_ACTIVITY_2) then
		if g.core.model.User.sevenDaysData:isShow7DaysActivity(var_0_0.SEVEN_DAYS_ACTIVITY_2) then
			var_0_2:send_C2S_NewSevendays_Info({
				type = g.core.model.User.sevenDaysData:getActValueByFunId(var_0_0.SEVEN_DAYS_ACTIVITY_2)
			})
		end
	end

	var_0_2:send_C2S_NewYearWish_GetInfo({})
	g.core.model.User.homeInfoRemindData:resetHomeInfoClickRecordWhenCrossDay()

	if var_0_1:isModuleUnlock(var_0_0.ACTIVITY_STAMINA) then
		var_0_2:send_C2S_GetStamina_Info({})
	end

	if var_0_1:isModuleUnlock(var_0_0.SUMMER_ACTIVITY) then
		var_0_2:send_C2S_TurnCard_GetInfo({
			id = var_0_3.THEME_VALUE.HORUS
		})
	end

	if var_0_1:isModuleUnlock(var_0_0.COMMANDER_WORLD) then
		g.core.model.User.commanderWorldData:reInitDailyData()
		var_0_2:send_C2S_OrderWorld_Info({})
	end

	var_0_2:send_C2S_Shop_GetShopInfo({})

	if not g.core.model.User.lotteryData:hasLotteryActivity() and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.LOTTERY) then
		g.core.network.GameNetProxy:send_C2S_Lottery_GetInfo({})
	end

	local var_9_0 = g.core.model.User.guildData:hasGuild()

	if var_9_0 and var_0_1:isModuleUnlock(var_0_0.GUILD_BOSS) and g.core.model.User.guildBossData:isProcess() then
		var_0_2:send_C2S_GuildBoss_GetInfo({})
	end

	if g.core.common.ServerTime:getWeekDay() == 1 and var_9_0 and var_0_1:isModuleUnlock(var_0_0.GUILD_DUNGEON) then
		var_0_2:send_C2S_GuildDungeon_GetInfo({})
		var_0_2:send_C2S_GuildDungeon_GetSkillInfo({})
		g.core.model.User.guildDungeonData:resetReceiveState()
	end

	if var_0_1:isModuleUnlock(var_0_0.PEAK_ARENA) then
		var_0_2:send_C2S_PeakArena_GetActivityInfo({})
	end

	if var_0_1:isModuleUnlock(var_0_0.SIGN_CUSTOM_ACTIVITY) then
		var_0_2:send_C2S_GmActivityLogin_GetInfo({})
	end

	var_0_2:send_C2S_Recharge_GetGMTotalRechargeInfo({})

	if var_0_1:isModuleUnlock(var_0_0.GOLD_SAVING) then
		var_0_2:send_C2S_GoldSaving_Flush({})
	end

	if var_0_1:isModuleUnlock(var_0_0.USER_BACK) then
		g.core.network.GameNetProxy:send_C2S_UserBack_GetInfo({})
	end

	var_0_2:send_C2S_PassCard_Info({})

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_ARTIFACT_BASE) then
		g.core.network.GameNetProxy:send_C2S_CrossActivity_GetInfo({})
	end

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HOME_INFO_REMIND) then
		g.core.network.GameNetProxy:send_C2S_FlushRedPoint({})
	end

	if var_0_1:isModuleUnlock(var_0_0.WUSH_TOWER) then
		var_0_2:send_C2S_DeadTower_EnterInfo({})
	end

	if var_0_1:isModuleUnlock(var_0_0.ECHO_LAB) then
		var_0_2:send_C2S_Palace_GetInfo({})
	end

	if var_0_1:isModuleUnlock(var_0_0.DAILY_WISH) and g.core.model.User.activityWishpoolData:isShowEntrance() then
		var_0_2:send_C2S_Wishpool_Flush({})
	end

	if var_0_1:isModuleUnlock(var_0_0.PUSH_GIFT) then
		var_0_2:send_C2S_PushGift_Info({})
		var_0_2:send_C2S_PushGift_GetGmActInfo({})
	end

	if var_0_1:isModuleUnlock(var_0_0.ACTIVITY_RECYCLE_BIN) then
		var_0_2:send_C2S_Retrieve_GetInfo({})
	end

	if var_0_1:isModuleUnlock(var_0_0.ACTIVITY_RETRO) and g.core.model.User.retroData:isActOpen() then
		var_0_2:send_C2S_Retro_GetInfo({})
	end

	if var_0_1:isModuleUnlock(var_0_0.MYSTERY) then
		var_0_2:send_C2S_Mystery_Info({})
		g.core.model.User.mysteryData:crossDayResetTaskProg()
	end

	if var_0_1:isModuleUnlock(var_0_0.ABVERT_PAGE_AWARD) then
		var_0_2:send_C2S_AbvertPageAward_GetInfo({})
	end

	g.core.network.GameNetProxy:send_C2S_H5Activity_GetInfo({})
	g.core.network.GameNetProxy:send_C2S_Recharge_GetGMFirstRechargeInfo({})

	if var_0_1:isModuleUnlock(var_0_0.SKIN_SHOP) then
		g.core.network.GameNetProxy:send_C2S_SkinShopGMInfo({})
	end

	g.core.network.GameNetProxy:send_C2S_Flush({
		privilege = true
	})

	if var_0_1:isModuleUnlock(var_0_0.VALENTINES_DAY_VOTE) and g.core.model.User.valentinesDayVoteData:isProcess() then
		g.core.network.GameNetProxy:send_C2S_Support_GetInfo({})
	end

	if g.core.common.ModuleUnlock:isFunctionUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HOLIDAY_VOICE, nil, true) then
		local var_9_1 = g.core.common.ServerTime:getDateObject((g.core.common.ServerTime:getTime()))
		local var_9_2 = {}

		for iter_9_0, iter_9_1 in g.core.config.knight_favorability_info.ipairs() do
			if iter_9_1.brithday_month == tonumber(var_9_1.month) and iter_9_1.brithday_day == tonumber(var_9_1.day) then
				table.insert(var_9_2, iter_9_1.id)
			end
		end

		g.core.network.GameNetProxy:send_C2S_Festival_Get_Infos({
			advance_ids = var_9_2
		})
	end

	if g.core.model.User.spireData:isActivityOpen() then
		g.core.model.User.spireData:resetChallengeTimes()
	end

	if var_0_1:isModuleUnlock(var_0_0.HOME_LAND_FURNITURE) then
		var_0_2:send_C2S_FurnitureRoom_GetInfo({})
	end

	if var_0_1:isModuleUnlock(var_0_0.SERVER_PASS_ACTIVITY) then
		var_0_2:send_C2S_ServerPass_Info({})
	end

	g.core.model.User.allianceTrialData:resetDayTimes()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY)
end

function CrossDayService:_reqCrossSerDatas()
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HOME_INFO_REMIND) then
		-- block empty
	end

	g.core.network.GameNetProxy:send_C2S_Shop_GetShopInfo({})
end

function CrossDayService:_reinitDatas()
	g.core.model.User.activityDailyBoxData:resetDataWhenCrossDay()
	g.core.model.User.worldRedPacketData:resetDataWhenCrossDay()
	var_0_2:send_C2S_CustomActivity_GetInfo({})
	var_0_2:send_C2S_Recharge_GetRecharge({})
end

return CrossDayService
