local var_0_0 = class("UrExTrafalgarPage", import(".TemplatePage.UrExchangeTemplatePage"))
local var_0_1 = pg.activity_holiday_site

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.icon = arg_1_0._tf:Find("AD/icon")
	arg_1_0.taskTypeDic = setmetatable({
		[var_0_0.MINI_GAME] = function(arg_2_0, arg_2_1)
			local var_2_0 = getProxy(MiniGameProxy):GetHubByGameId(arg_2_1[1]).count == 0

			local function var_2_1()
				if getProxy(TaskProxy):getFinishTaskById(var_0_1[getProxy(ActivityProxy):getActivityById(ActivityConst.HOLIDAY_ACT_ID):getConfig("config_client").function_id[1]].task_id) then
					arg_2_0:emit(ActivityMediator.GO_MINI_GAME, var_0)
				else
					pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_minigame_unlock"))
				end

				return
			end

			return var_2_0 and "1/1" or "0/1", not var_2_0 and var_2_1 or nil
		end
	}, {
		__index = arg_1_0.taskTypeDic
	})

	return
end

function var_0_0.OnFirstFlush(arg_4_0)
	var_0_0.super.OnFirstFlush(arg_4_0)
	setActive(arg_4_0._tasksTF, false)
	setActive(arg_4_0.icon, false)
	setActive(arg_4_0._btnHelp, false)

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	var_0_0.super.OnUpdateFlush(arg_5_0)
	setGray(arg_5_0._btnExchange, true, true)

	return
end

return var_0_0
