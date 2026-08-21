local var_0_0 = class("GuildOfficeMediator", import("..base.ContextMediator"))

var_0_0.ON_ACCEPT_TASK = "GuildOfficeMediator:ON_ACCEPT_TASK"
var_0_0.ON_COMMIT = "GuildOfficeMediator:ON_COMMIT"
var_0_0.ON_FETCH_CAPITAL_LOG = "GuildOfficeMediator:ON_FETCH_CAPITAL_LOG"
var_0_0.ON_SELECT_TASK = "GuildOfficeMediator:ON_SELECT_TASK"
var_0_0.ON_SUBMIT_TASK = "GuildOfficeMediator:ON_SUBMIT_TASK"
var_0_0.UPDATE_WEEKLY_TASK = "GuildOfficeMediator:UPDATE_WEEKLY_TASK"
var_0_0.ON_PURCHASE_SUPPLY = "GuildOfficeMediator:ON_PURCHASE_SUPPLY"
var_0_0.GET_SUPPLY_AWARD = "GuildOfficeMediator:GET_SUPPLY_AWARD"
var_0_0.REFRES_DONATE_LIST = "GuildOfficeMediator:REFRES_DONATE_LIST"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.REFRES_DONATE_LIST, function(arg_2_0, arg_2_1)
		return
	end)
	arg_1_0:bind(var_0_0.UPDATE_WEEKLY_TASK, function(arg_3_0)
		arg_1_0:sendNotification(GAME.GUILD_WEEKLY_TASK_PROGREE_UPDATE)

		return
	end)
	arg_1_0:bind(var_0_0.ON_SUBMIT_TASK, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECT_TASK, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:sendNotification(GAME.GUILD_SELECT_TASK, {
			taskId = arg_5_1,
			num = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_ACCEPT_TASK, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.TRIGGER_TASK, arg_6_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_COMMIT, function(arg_7_0, arg_7_1)
		arg_1_0:sendNotification(GAME.GUILD_COMMIT_DONATE, {
			taskId = arg_7_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_PURCHASE_SUPPLY, function(arg_8_0)
		arg_1_0:sendNotification(GAME.GUILD_BUY_SUPPLY)

		return
	end)
	arg_1_0:bind(var_0_0.GET_SUPPLY_AWARD, function(arg_9_0)
		arg_1_0:sendNotification(GAME.GUILD_GET_SUPPLY_AWARD)

		return
	end)
	arg_1_0.viewComponent:SetGuild((getProxy(GuildProxy):getData()))
	arg_1_0.viewComponent:setPlayer((getProxy(PlayerProxy):getRawData()))

	return
end

function var_0_0.listNotificationInterests(arg_10_0)
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

function var_0_0.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()

	if var_11_0 == GuildProxy.GUILD_UPDATED then
		arg_11_0.viewComponent:SetGuild(var_11_1)
	elseif var_11_0 == PlayerProxy.UPDATED then
		arg_11_0.viewComponent:setPlayer(getProxy(PlayerProxy):getRawData())
	elseif var_11_0 == GAME.GUILD_COMMIT_DONATE_DONE then
		arg_11_0.viewComponent:UpdateContribution()

		if var_11_1.awards and #var_11_1.awards > 0 then
			arg_11_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1.awards, function()
				return
			end)
		else
			(function()
				return
			end)()
		end
	elseif var_11_0 == GuildProxy.ON_DONATE_LIST_UPDATED then
		arg_11_0.viewComponent:UpdateContribution()
	elseif var_11_0 == GAME.TRIGGER_TASK_DONE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_get_week_done"))
		arg_11_0.viewComponent:UpdateTask()
	elseif var_11_0 == GAME.SUBMIT_TASK_DONE then
		arg_11_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1)
		arg_11_0.viewComponent:UpdateTask(true)
	elseif var_11_0 == GuildProxy.WEEKLYTASK_ADDED or var_11_0 == GuildProxy.WEEKLYTASK_UPDATED or var_11_0 == GAME.GUILD_WEEKLY_TASK_PROGREE_UPDATE_DONE then
		arg_11_0.viewComponent:UpdateTask()
	elseif var_11_0 == GAME.GUILD_GET_SUPPLY_AWARD_DONE then
		arg_11_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1.list)
		arg_11_0.viewComponent:UpdateSupplyPanel()
	elseif var_11_0 == GuildProxy.SUPPLY_STARTED then
		arg_11_0.viewComponent:UpdateSupplyPanel()
	elseif var_11_0 == GAME.ZERO_HOUR_OP_DONE then
		-- block empty
	elseif var_11_0 == TaskProxy.TASK_UPDATED then
		local var_11_2 = getProxy(GuildProxy):getRawData()

		if var_11_2 then
			local var_11_3 = var_11_2:getWeeklyTask()

			if var_11_3 and var_11_3.id > 0 and var_11_3:IsSamePrivateTask(var_11_1) then
				arg_11_0.viewComponent:UpdateTask()
			end
		end
	end

	return
end

return var_0_0
