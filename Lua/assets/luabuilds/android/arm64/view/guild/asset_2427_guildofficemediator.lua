local GuildOfficeMediator = class("GuildOfficeMediator", import("..base.ContextMediator"))

GuildOfficeMediator.ON_ACCEPT_TASK = "GuildOfficeMediator:ON_ACCEPT_TASK"
GuildOfficeMediator.ON_COMMIT = "GuildOfficeMediator:ON_COMMIT"
GuildOfficeMediator.ON_FETCH_CAPITAL_LOG = "GuildOfficeMediator:ON_FETCH_CAPITAL_LOG"
GuildOfficeMediator.ON_SELECT_TASK = "GuildOfficeMediator:ON_SELECT_TASK"
GuildOfficeMediator.ON_SUBMIT_TASK = "GuildOfficeMediator:ON_SUBMIT_TASK"
GuildOfficeMediator.UPDATE_WEEKLY_TASK = "GuildOfficeMediator:UPDATE_WEEKLY_TASK"
GuildOfficeMediator.ON_PURCHASE_SUPPLY = "GuildOfficeMediator:ON_PURCHASE_SUPPLY"
GuildOfficeMediator.GET_SUPPLY_AWARD = "GuildOfficeMediator:GET_SUPPLY_AWARD"
GuildOfficeMediator.REFRES_DONATE_LIST = "GuildOfficeMediator:REFRES_DONATE_LIST"

function GuildOfficeMediator:register()
	self:bind(GuildOfficeMediator.REFRES_DONATE_LIST, function(arg_2_0, arg_2_1)
		return
	end)
	self:bind(GuildOfficeMediator.UPDATE_WEEKLY_TASK, function(arg_3_0)
		self:sendNotification(GAME.GUILD_WEEKLY_TASK_PROGREE_UPDATE)

		return
	end)
	self:bind(GuildOfficeMediator.ON_SUBMIT_TASK, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_4_1)

		return
	end)
	self:bind(GuildOfficeMediator.ON_SELECT_TASK, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.GUILD_SELECT_TASK, {
			taskId = arg_5_1,
			num = arg_5_2
		})

		return
	end)
	self:bind(GuildOfficeMediator.ON_ACCEPT_TASK, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.TRIGGER_TASK, arg_6_1)

		return
	end)
	self:bind(GuildOfficeMediator.ON_COMMIT, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.GUILD_COMMIT_DONATE, {
			taskId = arg_7_1
		})

		return
	end)
	self:bind(GuildOfficeMediator.ON_PURCHASE_SUPPLY, function(arg_8_0)
		self:sendNotification(GAME.GUILD_BUY_SUPPLY)

		return
	end)
	self:bind(GuildOfficeMediator.GET_SUPPLY_AWARD, function(arg_9_0)
		self:sendNotification(GAME.GUILD_GET_SUPPLY_AWARD)

		return
	end)
	self.viewComponent:SetGuild((getProxy(GuildProxy):getData()))
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getRawData()))

	return
end

function GuildOfficeMediator:listNotificationInterests()
	return {
		GAME.TRIGGER_TASK_DONE,
		GAME.GUILD_COMMIT_DONATE_DONE,
		GAME.SUBMIT_TASK_DONE,
		GuildProxy.GUILD_UPDATED,
		GuildProxy.WEEKLYTASK_ADDED,
		GuildProxy.WEEKLYTASK_UPDATED,
		GuildProxy.CAPITAL_UPDATED,
		PlayerProxy.UPDATED,
		GAME.GUILD_WEEKLY_TASK_PROGREE_UPDATE_DONE,
		GAME.GUILD_GET_SUPPLY_AWARD_DONE,
		GuildProxy.SUPPLY_STARTED,
		GAME.ZERO_HOUR_OP_DONE,
		TaskProxy.TASK_UPDATED,
		GuildProxy.ON_DONATE_LIST_UPDATED
	}
end

function GuildOfficeMediator:handleNotification(arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()

	if var_11_0 == GuildProxy.GUILD_UPDATED then
		self.viewComponent:SetGuild(var_11_1)
	elseif var_11_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer(getProxy(PlayerProxy):getRawData())
	elseif var_11_0 == GAME.GUILD_COMMIT_DONATE_DONE then
		self.viewComponent:UpdateContribution()

		local function var_11_2()
			return
		end

		if var_11_1.awards and #var_11_1.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1.awards, var_11_2)
		else
			var_11_2()
		end
	elseif var_11_0 == GuildProxy.ON_DONATE_LIST_UPDATED then
		self.viewComponent:UpdateContribution()
	elseif var_11_0 == GAME.TRIGGER_TASK_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_get_week_done"))
		self.viewComponent:UpdateTask()
	elseif var_11_0 == GAME.SUBMIT_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1)
		self.viewComponent:UpdateTask(true)
	elseif var_11_0 == GuildProxy.WEEKLYTASK_ADDED or var_11_0 == GuildProxy.WEEKLYTASK_UPDATED or var_11_0 == GAME.GUILD_WEEKLY_TASK_PROGREE_UPDATE_DONE then
		self.viewComponent:UpdateTask()
	elseif var_11_0 == GAME.GUILD_GET_SUPPLY_AWARD_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1.list)
		self.viewComponent:UpdateSupplyPanel()
	elseif var_11_0 == GuildProxy.SUPPLY_STARTED then
		self.viewComponent:UpdateSupplyPanel()
	elseif var_11_0 == GAME.ZERO_HOUR_OP_DONE then
		-- block empty
	elseif var_11_0 == TaskProxy.TASK_UPDATED then
		local var_11_3 = getProxy(GuildProxy):getRawData()

		if var_11_3 then
			local var_11_4 = var_11_3:getWeeklyTask()

			if var_11_4 and var_11_4.id > 0 and var_11_4:IsSamePrivateTask(var_11_1) then
				self.viewComponent:UpdateTask()
			end
		end
	end

	return
end

return GuildOfficeMediator
