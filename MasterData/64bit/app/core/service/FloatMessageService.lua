local FloatMessageService = class("FloatMessageService")

function FloatMessageService:ctor()
	self._allFloatModules = {}
	self._loadingFinish = false
	self._botTime = 0
	self._showMoudles = {}

	if not g.core.layer.LayerManager:getSysTipLayer():getChild("FloatMessageLayer") then
		-- block empty
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_ON_PRE_LOADING_FINISH, self.SetLoadingFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EVENT, self._onModuleEvent, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH, self._onFlush, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DUNGEON_GETCHAPTERLIST, self._onDungeonGetChapterList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MAIL_INFO, self._onMailGetInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CITY_GETINFO, self._onGetCityBotReward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_FLUSH, self._onGetRedPackageInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BIOGRAPHY_NOTIFYINVITEE, self._onGetBioInviteFloat, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GROUP_BATTLE_NOTIFYINVITE, self._onGetTeamPvpInviteFloat, self)

	self._scheduleHandler = g.core.common.Scheduler:newSchedule(handler(self, self._scheduleUpdate), 1)
end

function FloatMessageService:_scheduleUpdate()
	if #self._showMoudles > 0 then
		local var_2_0 = g.core.module.ModuleManager:getCurModule()

		for iter_2_0, iter_2_1 in ipairs(self._showMoudles) do
			if var_2_0 and iter_2_1.getInfo and iter_2_1.getInfo().route_type == var_2_0.module.routeType then
				self:_onFloatModuleEvent("finish", iter_2_1)
			end
		end
	end

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.MYSTERY_BOSS) then
		if not self._loadingFinish then
			return
		end

		local var_2_1 = g.core.model.User.mysteryBossData:getCareBossId()

		if var_2_1 ~= 0 then
			local var_2_2 = false
			local var_2_3 = g.core.model.User.mysteryBossData:getBossById(var_2_1)

			if var_2_3:isUnlock() and var_2_3:isInOpenTime() then
				if not var_2_3:isAlive() then
					if g.core.common.ServerTime:getTime() > var_2_3:getRebornTs() + 120 then
						var_2_2 = true
					end
				else
					var_2_2 = true
				end

				if var_2_2 and g.core.model.User.mysteryBossData:getLeftAwardTimes(var_2_3:getType()) > 0 then
					if (g.core.common.Storage:load("mystery_boss_float.json") or {}).time ~= var_2_3:getRebornTs() then
						g.core.common.Storage:save("mystery_boss_float.json", {
							time = var_2_3:getRebornTs()
						})
						self:_createMysteryBossFloat()
					end
				end
			end
		end
	end
end

function FloatMessageService:SetLoadingFinish()
	self._loadingFinish = true
end

function FloatMessageService:reset()
	local var_4_0 = g.core.layer.LayerManager:getSysTipLayer():getBaseChild("FloatMessageLayer")

	if var_4_0 then
		var_4_0:removeFromParent()
	end
end

function FloatMessageService:_onModuleEvent(arg_5_1, arg_5_2)
	local var_5_0 = {
		...
	}

	if arg_5_2 == "FloatHotTimePop_ok" then
		if var_5_0[1] and var_5_0[1].getInfo and var_5_0[1]:getInfo().route_type == g.view.entrance.REBEL.routeType then
			g.core.module.ModuleManager:popToRootAndPush(g.view.entrance.REBEL)
		elseif var_5_0[1] and var_5_0[1].getInfo then
			local var_5_1 = var_5_0[1]:getInfo()

			for iter_5_0, iter_5_1 in ipairs(g.view.entrance.BIO_MAIN.routeType) do
				if iter_5_1 == var_5_1.route_type then
					g.core.module.ModuleManager:popToRootAndPush(g.view.entrance.BIO_MAIN)

					break
				end
			end
		end
	end
end

function FloatMessageService:_onShowCityBotReward()
	self:CancelBotSchedule()

	self._cityBotFloatInfos = self._cityBotFloatInfos or g.core.config.float_message_info.match(function(arg_7_0)
		if g.view.entrance.CITY.routeType == arg_7_0.route_type then
			return arg_7_0
		end
	end)

	local var_6_0 = self:_createCityBotFloat(self._cityBotFloatInfos)

	table.insertto(self._allFloatModules, var_6_0, 0)

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		iter_6_1:reset()
		iter_6_1:onStart()
	end
end

function FloatMessageService:CancelBotSchedule()
	if self._botScheduleHandler then
		g.core.common.Scheduler:cancelSchedule(self._botScheduleHandler)

		self._botScheduleHandler = nil
	end
end

function FloatMessageService:_onGetBioInviteFloat()
	local var_9_0 = {}

	table.insertto(var_9_0, self:_createBioInviteFloat((g.core.config.float_message_info.match(function(arg_10_0)
		if g.view.entrance.BIO_TEAM_INVITED.routeType == arg_10_0.route_type then
			return arg_10_0
		end
	end))), 0)
	table.insertto(self._allFloatModules, var_9_0, 0)

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		iter_9_1:reset()
		iter_9_1:onStart()
	end
end

function FloatMessageService:_onGetTeamPvpInviteFloat()
	local var_11_0 = {}

	table.insertto(var_11_0, self:_createTeamPvpInviteFloat((g.core.config.float_message_info.match(function(arg_12_0)
		if g.view.entrance.TEAMPVP_INVITED.routeType == arg_12_0.route_type then
			return arg_12_0
		end
	end))), 0)
	table.insertto(self._allFloatModules, var_11_0, 0)

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		iter_11_1:reset()
		iter_11_1:onStart()
	end
end

function FloatMessageService:_onGetCityBotReward()
	local var_13_0, var_13_1 = g.core.model.User.cityData:CheckPatrolReward()

	if self._botTime == var_13_1 then
		return
	end

	self._botTime = var_13_1

	local var_13_2 = var_13_1 - g.core.common.ServerTime:getTime()

	self:CancelBotSchedule()

	self._botScheduleHandler = g.core.common.Scheduler:newSchedule(handler(self, self._onShowCityBotReward), var_13_2 >= 0 and var_13_2 or 0)
end

function FloatMessageService:_onGetRedPackageInfo()
	local var_14_0 = {}

	table.insertto(var_14_0, self:_createRedPacketFloat((g.core.config.float_message_info.match(function(arg_15_0)
		if g.view.entrance.GUILD_REDPACKET.routeType == arg_15_0.route_type then
			return arg_15_0
		end
	end))), 0)
	table.insertto(self._allFloatModules, var_14_0, 0)

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		iter_14_1:reset()
		iter_14_1:onStart()
	end
end

function FloatMessageService:_showGotoBossMsgBox()
	local function var_16_0(arg_17_0)
		if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.MYSTERY_BOSS) then
			if not g.core.module.ModuleManager:isCurModule((g.view.entrance.ModuleGotoProxy:getModule(214))) then
				g.view.entrance.ModuleGotoProxy:gotoModule(214)
			else
				g.core.module.ModuleManager:pushModule(g.view.entrance.MYSTERYBOSS_CHOOSE, {
					bossId = arg_17_0 or 0
				})
			end
		end
	end

	if g.core.model.User.mysteryBossData:isCareBossCanChallenge() then
		local var_16_1 = g.core.model.User.mysteryBossData:getCareBossId()
		local var_16_2 = g.core.config.mystery_boss_info.get(var_16_1)

		g.core.module.ModuleManager:pushPopup((require("app.view.base.component.BaseTxtPopComp").new({
			text = g.core.lang:get(1146, {
				name = var_16_2.name,
				color = "#" .. g.core.common.Color.qualityEx[var_16_2.quality]
			}),
			text_ok = g.core.lang:get(1083),
			text_cancel = g.core.lang:get(1084),
			handler_ok = handler(self, function()
				var_16_0(var_16_1)
			end)
		})))
	else
		var_16_0()
	end
end

function FloatMessageService:_createMysteryBossFloat()
	local var_19_0 = {}
	local var_19_1 = {}

	table.insert(var_19_0, var_19_1)

	local var_19_2 = g.core.config.float_message_info.get(4003)

	function var_19_1.reset()
		g.core.event.EventManager:removeListenerWithTarget(var_19_1)
	end

	function var_19_1.onStart()
		self:_onFloatModuleEvent("start", var_19_1)
	end

	function var_19_1.getInfo()
		return var_19_2
	end

	function var_19_1.onClick()
		self:_showGotoBossMsgBox()
	end

	function var_19_1.onListen()
		self:_onFloatModuleEvent("start", var_19_1)
	end

	table.insertto(self._allFloatModules, var_19_0, 0)

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		iter_19_1:reset()
		iter_19_1:onStart()
	end
end

function FloatMessageService:_onFlush()
	local var_25_0 = {}

	for iter_25_0 = 1, g.core.config.float_message_info.getLength() do
		local var_25_3 = g.core.config.float_message_info.indexOf(iter_25_0)

		if var_25_3.route_type == g.view.entrance.REBEL.routeType then
			table.insert(var_25_0, var_25_3)
		elseif var_25_3.route_type == g.view.entrance.GUILD_REDPACKET.routeType then
			-- block empty
		elseif var_25_3.route_type == g.view.entrance.BIO_TEAM_INVITED.routeType then
			-- block empty
		end
	end

	local var_25_4 = {}

	table.insertto(var_25_4, self:_createRebelFloat(var_25_0), 0)

	for iter_25_1, iter_25_2 in ipairs(var_25_4) do
		iter_25_2:reset()
		iter_25_2:onStart()
	end

	table.insertto(self._allFloatModules, var_25_4, 0)
end

function FloatMessageService:_onDungeonGetChapterList(arg_26_1, arg_26_2, arg_26_3)
	if not self._bioFloatInfos then
		self._bioFloatInfos = g.core.config.float_message_info.match(function(arg_27_0)
			for iter_27_0, iter_27_1 in ipairs(g.view.entrance.BIO_MAIN.routeType) do
				if iter_27_1 == arg_27_0.route_type then
					return arg_27_0
				end
			end
		end)

		local var_26_0 = self:_createBioFloat(self._bioFloatInfos)

		table.insertto(self._allFloatModules, var_26_0, 0)

		for iter_26_0, iter_26_1 in ipairs(var_26_0) do
			iter_26_1:reset()
			iter_26_1:onStart()
		end
	end
end

function FloatMessageService:_onMailGetInfo(arg_28_1, arg_28_2, arg_28_3)
	if not arg_28_3.mails then
		return
	end

	local var_28_0 = g.core.config.mail_info.match(function(arg_29_0)
		for iter_29_0, iter_29_1 in ipairs(arg_28_3.mails) do
			if iter_29_1.base_id == arg_29_0.id and arg_29_0.if_bubble and arg_29_0.if_bubble == 1 and g.core.model.User.mailData:isUnReadMail(iter_29_1) then
				return arg_29_0
			end
		end
	end)

	if var_28_0 and #var_28_0 > 0 then
		self._mailInfos = g.core.config.float_message_info.match(function(arg_30_0)
			return arg_30_0.route_type == 172
		end)

		local var_28_1 = self:_createMailFloat(self._mailInfos)

		table.insertto(self._allFloatModules, var_28_1, 0)

		for iter_28_0, iter_28_1 in ipairs(var_28_1) do
			iter_28_1:reset()
			iter_28_1:onStart()
		end
	end
end

function FloatMessageService:_createRebelFloat(arg_31_1)
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_1) do
		local var_31_1 = {}

		table.insert(var_31_0, var_31_1)

		local var_31_2 = g.core.config.time_event_info.get(iter_31_1.float_value1, iter_31_1.float_value2)

		function var_31_1.reset()
			g.core.event.EventManager:removeListenerWithTarget(var_31_1)
		end

		function var_31_1.onStart()
			g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SCHEDULE_NOTIFY, var_31_1.onTime, var_31_1)

			if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.REBEL_MAIN) then
				local var_33_0 = g.core.common.Storage:load("float_message_rebel.json")
				local var_33_1 = g.core.common.ServerTime:secondsFromToday()
				local var_33_2 = var_33_0 and g.core.common.ServerTime:secondsFromToday(var_33_0.time) or -1

				if (var_33_2 < var_31_2.open_time or var_33_2 >= var_31_2.end_time) and var_33_1 >= var_31_2.open_time and var_33_1 < var_31_2.end_time then
					self:_onFloatModuleEvent("start", var_31_1)
				end
			end
		end

		function var_31_1.getInfo()
			return iter_31_1
		end

		function var_31_1.onClick()
			g.core.common.Storage:save("float_message_rebel.json", {
				time = g.core.common.ServerTime:getTime()
			})
		end

		function var_31_1.onTime(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
			if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.REBEL_MAIN) then
				if arg_36_2 < var_31_2.open_time and arg_36_3 >= var_31_2.open_time then
					self:_onFloatModuleEvent("start", var_31_1)
				elseif arg_36_2 < var_31_2.end_time and arg_36_3 >= var_31_2.end_time then
					self:_onFloatModuleEvent("finish", var_31_1)
				end
			end
		end
	end

	return var_31_0
end

function FloatMessageService:_createBioFloat(arg_37_1)
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in ipairs(arg_37_1) do
		local var_37_1 = {}

		table.insert(var_37_0, var_37_1)

		local var_37_2 = g.core.config.time_event_info.get(iter_37_1.float_value1, iter_37_1.float_value2)

		function var_37_1.reset()
			g.core.event.EventManager:removeListenerWithTarget(var_37_1)
		end

		function var_37_1.onStart()
			g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SCHEDULE_NOTIFY, var_37_1.onTime, var_37_1)

			if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BIO_TEAM) then
				local var_39_0 = g.core.common.Storage:load("float_message_bio.json")
				local var_39_1 = g.core.common.ServerTime:secondsFromToday()
				local var_39_2 = var_39_0 and g.core.common.ServerTime:secondsFromToday(var_39_0.time) or -1

				if (var_39_2 < var_37_2.open_time or var_39_2 >= var_37_2.end_time) and var_39_1 >= var_37_2.open_time and var_39_1 < var_37_2.end_time then
					self:_onFloatModuleEvent("start", var_37_1)
				end
			end
		end

		function var_37_1.getInfo()
			return iter_37_1
		end

		function var_37_1.onClick()
			g.core.common.Storage:save("float_message_bio.json", {
				time = g.core.common.ServerTime:getTime()
			})
		end

		function var_37_1.onTime(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
			if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.BIO_TEAM) then
				if arg_42_2 < var_37_2.open_time and arg_42_3 >= var_37_2.open_time then
					self:_onFloatModuleEvent("start", var_37_1)
				elseif arg_42_2 < var_37_2.end_time and arg_42_3 >= var_37_2.end_time then
					self:_onFloatModuleEvent("finish", var_37_1)
				end
			end
		end
	end

	return var_37_0
end

function FloatMessageService:_createRedPacketFloat(arg_43_1)
	local var_43_0 = {}

	for iter_43_0, iter_43_1 in ipairs(arg_43_1) do
		local var_43_1 = {}

		table.insert(var_43_0, var_43_1)

		function var_43_1.reset()
			g.core.event.EventManager:removeListenerWithTarget(var_43_1)
		end

		function var_43_1.onStart()
			local var_45_0 = g.core.model.User.redPacketData:getPickTime()

			if var_45_0[1] and var_45_0[1] > 0 then
				self:_onFloatModuleEvent("start", var_43_1)
			end
		end

		function var_43_1.onClick()
			return
		end

		function var_43_1.getInfo()
			return iter_43_1
		end

		function var_43_1.onListen()
			local var_48_0 = g.core.model.User.redPacketData:getPickTime()

			if var_48_0[1] and var_48_0[1] > 0 then
				self:_onFloatModuleEvent("start", var_43_1)
			end
		end
	end

	return var_43_0
end

function FloatMessageService:_createBioInviteFloat(arg_49_1)
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
		local var_49_1 = {}

		table.insert(var_49_0, var_49_1)

		function var_49_1.reset()
			g.core.event.EventManager:removeListenerWithTarget(var_49_1)
		end

		function var_49_1.onStart()
			var_49_1.onListen()
		end

		function var_49_1.onClick()
			return
		end

		function var_49_1.getInfo()
			return iter_49_1
		end

		function var_49_1.onListen()
			self:_onFloatModuleEvent("start", var_49_1)
		end
	end

	return var_49_0
end

function FloatMessageService:_createTeamPvpInviteFloat(arg_55_1)
	local var_55_0 = {}

	for iter_55_0, iter_55_1 in ipairs(arg_55_1) do
		local var_55_1 = {}

		table.insert(var_55_0, var_55_1)

		function var_55_1.reset()
			g.core.event.EventManager:removeListenerWithTarget(var_55_1)
		end

		function var_55_1.onStart()
			var_55_1.onListen()
		end

		function var_55_1.onClick()
			return
		end

		function var_55_1.getInfo()
			return iter_55_1
		end

		function var_55_1.onListen()
			self:_onFloatModuleEvent("start", var_55_1)
		end
	end

	return var_55_0
end

function FloatMessageService:_createCityBotFloat(arg_61_1)
	local var_61_0 = {}

	for iter_61_0, iter_61_1 in ipairs(arg_61_1) do
		local var_61_1 = {}

		table.insert(var_61_0, var_61_1)

		function var_61_1.reset()
			g.core.event.EventManager:removeListenerWithTarget(var_61_1)
		end

		function var_61_1.onStart()
			if self._loadingFinish then
				self:_onFloatModuleEvent("start", var_61_1)
			else
				self._waitLoadingHandler = self._waitLoadingHandler or g.core.common.Scheduler:newSchedule(function()
					if self._loadingFinish then
						g.core.common.Scheduler:cancelSchedule(self._waitLoadingHandler)

						self._waitLoadingHandler = nil

						self:_onFloatModuleEvent("start", var_61_1)
					end
				end, 1)
			end
		end

		function var_61_1.getInfo()
			return iter_61_1
		end

		function var_61_1.onClick()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.CITY_MAIN) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.CITY)
			end
		end

		function var_61_1.onListen()
			self:_onFloatModuleEvent("start", var_61_1)
		end
	end

	return var_61_0
end

function FloatMessageService:_createMailFloat(arg_68_1)
	local var_68_0 = {}

	for iter_68_0, iter_68_1 in ipairs(arg_68_1) do
		iter_68_1.route_type = 1005

		local var_68_1 = {}

		table.insert(var_68_0, var_68_1)

		function var_68_1.reset()
			g.core.event.EventManager:removeListenerWithTarget(var_68_1)
		end

		function var_68_1.onStart()
			self:_onFloatModuleEvent("start", var_68_1)
		end

		function var_68_1.getInfo()
			return iter_68_1
		end

		function var_68_1.onClick()
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.MAIL) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.MAIL)
			end
		end
	end

	return var_68_0
end

function FloatMessageService:_pushFloatMessage(arg_73_1)
	local var_73_0 = arg_73_1:getInfo()

	self:_getFloatRoot():addFloat({
		id = var_73_0.id,
		countdown = var_73_0.time,
		floatType = var_73_0.float_type,
		routeType = var_73_0.route_type,
		icon = var_73_0.icon,
		title = var_73_0.show_name
	})
end

function FloatMessageService:_removeFloatMessage(arg_74_1)
	self:_getFloatRoot():removeFloat({
		id = arg_74_1:getInfo().id
	})
end

function FloatMessageService:_getFloatRoot()
	local var_75_0 = g.core.layer.LayerManager:getSysTipLayer():getChild("FloatMessageLayer")

	if not var_75_0 then
		-- block empty
	end

	return var_75_0
end

function FloatMessageService:_onFloatEvent(arg_76_1)
	if arg_76_1 == "FloatMessageIcon_click" then
		for iter_76_0, iter_76_1 in ipairs(self._allFloatModules) do
			if iter_76_1:getInfo().id == ({
				...
			})[1].id then
				iter_76_1:onClick()

				break
			end
		end
	end
end

function FloatMessageService:_checkShowModulesHasModule(arg_77_1)
	for iter_77_0, iter_77_1 in ipairs(self._showMoudles) do
		if iter_77_1 == arg_77_1 then
			return true, iter_77_0
		end
	end

	return false
end

function FloatMessageService:_onFloatModuleEvent(arg_78_1, arg_78_2)
	if arg_78_1 == "start" then
		local var_78_0 = g.core.module.ModuleManager:getCurModule()

		if var_78_0 and var_78_0.module.routeType ~= arg_78_2.getInfo().route_type then
			self._showMoudles = self._showMoudles or {}

			local var_78_1, var_78_2 = self:_checkShowModulesHasModule(arg_78_2)

			if not var_78_1 then
				self._showMoudles[#self._showMoudles + 1] = arg_78_2
			end

			self:_pushFloatMessage(arg_78_2)
		end
	elseif arg_78_1 == "finish" then
		self:_removeFloatMessage(arg_78_2)

		local var_78_3, var_78_4 = self:_checkShowModulesHasModule(arg_78_2)

		if var_78_3 then
			table.remove(self._showMoudles, var_78_4)
		end
	end
end

return FloatMessageService
