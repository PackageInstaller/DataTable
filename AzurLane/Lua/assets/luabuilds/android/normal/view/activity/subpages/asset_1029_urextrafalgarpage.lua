class = var_0_10000

local var_0_0 = "UrExTrafalgarPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.UrExchangeTemplatePage"))

pg = var_0_0

local var_0_2 = var_0_0.activity_holiday_site

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.icon = var_1.Find(var_1_0, "AD/icon")
	setmetatable = var_1
	arg_1_0.taskTypeDic = var_1({
		[var_0_1.MINI_GAME] = function(arg_2_0, arg_2_1)
			local var_2_0 = arg_2_1[1]

			getProxy = var_2_10003
			MiniGameProxy = var_2_10004

			local var_2_1 = var_2_10003(var_2_10004)
			local var_2_2 = var_3.GetHubByGameId(var_2_1, var_2_0).count == 0

			local function var_2_3()
				getProxy = var_3_10000
				TaskProxy = var_3_10001

				local var_3_0 = var_3_10000(var_3_10001)

				getProxy = var_3_10001
				ActivityProxy = var_3_10002

				local var_3_1 = var_3_10001(var_3_10002)
				local var_3_2 = var_1.getActivityById

				ActivityConst = var_3_10004

				local var_3_3 = var_3_2(var_3_1, var_3_10004.HOLIDAY_ACT_ID)
				local var_3_4 = var_2.getConfig(var_3_3, "config_client").function_id
				local var_3_5 = var_0_2[var_3_4[1]].task_id
				local var_3_6 = var_3_0

				if var_3_0.getFinishTaskById(var_3_6, var_3_5) then
					local var_3_7 = arg_2_0

					var_3_6 = var_3_6.emit
					ActivityMediator = var_3_10009

					var_3_6(var_3_7, var_3_10009.GO_MINI_GAME, var_2_0)
				else
					pg = var_3_6

					local var_3_8 = var_3_6.TipsMgr.GetInstance()
					local var_3_9 = var_7.ShowTips

					i18n = var_3_10009

					var_3_9(var_3_8, var_3_10009("challenge_minigame_unlock"))
				end

				return
			end

			return var_2_2 and "1/1" or "0/1", not var_2_2 and var_2_3 or nil
		end
	}, {
		__index = arg_1_0.taskTypeDic
	})

	return
end

function var_0_1.OnFirstFlush(arg_4_0)
	var_0_1.super.OnFirstFlush(arg_4_0)

	setActive = var_1

	var_1(arg_4_0._tasksTF, false)

	setActive = var_1

	var_1(arg_4_0.icon, false)

	setActive = var_1

	var_1(arg_4_0._btnHelp, false)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	var_0_1.super.OnUpdateFlush(arg_5_0)

	setGray = var_1

	var_1(arg_5_0._btnExchange, true, true)

	return
end

return var_0_1
