class = var_0_10000

local var_0_0 = "ContinuousOperationMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.CONTINUE_OPERATION = "ContinuousOperationMediator:CONTINUE_OPERATION"
var_0_1.ON_REENTER = "ContinuousOperationMediator:ON_REENTER"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	GAME = var_1_10003

	var_1_1(var_1_0, var_1_10003.PAUSE_BATTLE, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10002

		var_2_1(var_2_0, var_2_10002.PAUSE_BATTLE)

		return
	end)
	arg_1_0:bind(var_0_1.ON_REENTER, function()
		local var_3_0 = arg_1_0

		var_0.sendNotification(var_3_0, var_0_1.ON_REENTER, {
			autoFlag = arg_1_0.contextData.autoFlag
		})

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	BattleMediator = var_3

	var_1_3(var_1_2, var_3.HIDE_ALL_BUTTONS, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		BattleMediator = var_2_10004

		var_4_1(var_4_0, var_2_10004.HIDE_ALL_BUTTONS, arg_4_1)

		if not arg_4_1 then
			ys = var_4_1

			local var_4_2 = var_4_1.Battle.BattleState.GetInstance().IsAutoBotActive

			SYSTEM_ACT_BOSS = var_4

			if not var_4_2(var_4) then
				pg = var_3

				local var_4_3 = var_3.TipsMgr.GetInstance()
				local var_4_4 = var_3.ShowTips

				i18n = var_5

				var_4_4(var_4_3, var_5("multiple_sorties_auto_on"))

				local var_4_5 = arg_1_0
				local var_4_6 = var_3.sendNotification

				GAME = var_5

				var_4_6(var_4_5, var_5.AUTO_BOT, {
					isActiveBot = false
				})

				local var_4_7 = arg_1_0
				local var_4_8 = var_3.sendNotification

				GAME = var_5

				var_4_8(var_4_7, var_5.AUTO_SUB, {
					isActiveSub = false
				})

				local var_4_9 = var_2
				local var_4_10 = var_2.ActiveBot
				local var_4_11 = var_2.IsAutoBotActive

				SYSTEM_ACT_BOSS = var_6

				var_4_10(var_4_9, var_4_11(var_6))
			end
		end

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	NewBattleResultMediator = var_1_10002
	var_5_0[1] = var_1_10002.ON_ENTER_BATTLE_RESULT
	NewBattleResultMediator = var_2
	var_5_0[2] = var_2.ON_COMPLETE_BATTLE_RESULT

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.getBody(var_6_1)

	NewBattleResultMediator = var_6_1

	local var_6_4

	if var_6_0 == var_6_1.ON_ENTER_BATTLE_RESULT then
		local var_6_3 = arg_6_0

		var_6_4 = arg_6_0.sendNotification
		NewBattleResultMediator = var_1_10006

		var_6_4(var_6_3, var_1_10006.SET_SKIP_FLAG, true)

		local var_6_5 = arg_6_0.viewComponent

		var_6_4.OnEnterBattleResult(var_6_5)
	else
		NewBattleResultMediator = var_6_4

		if var_6_0 == var_6_4.ON_COMPLETE_BATTLE_RESULT then
			local var_6_6 = arg_6_0.viewComponent

			var_4.AnimatingSlider(var_6_6)
		end
	end

	return
end

function var_0_1.remove(arg_7_0)
	return
end

return var_0_1
