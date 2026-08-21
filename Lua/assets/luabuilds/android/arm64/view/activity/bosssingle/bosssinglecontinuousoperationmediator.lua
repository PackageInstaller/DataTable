local var_0_0 = class("BossSingleContinuousOperationMediator", import("view.base.ContextMediator"))

var_0_0.CONTINUE_OPERATION = "BossSingleContinuousOperationMediator:CONTINUE_OPERATION"
var_0_0.ON_REENTER = "BossSingleContinuousOperationMediator:ON_REENTER"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(GAME.PAUSE_BATTLE, function()
		arg_1_0:sendNotification(GAME.PAUSE_BATTLE)

		return
	end)
	arg_1_0:bind(var_0_0.ON_REENTER, function()
		arg_1_0:sendNotification(var_0_0.ON_REENTER, {
			autoFlag = arg_1_0.contextData.autoFlag
		})

		return
	end)
	arg_1_0:bind(BattleMediator.HIDE_ALL_BUTTONS, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(BattleMediator.HIDE_ALL_BUTTONS, arg_4_1)

		if not arg_4_1 then
			local var_4_0 = ys.Battle.BattleState.GetInstance()

			if not var_4_0.IsAutoBotActive(SYSTEM_BOSS_SINGLE) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("multiple_sorties_auto_on"))
				arg_1_0:sendNotification(GAME.AUTO_BOT, {
					isActiveBot = false
				})
				arg_1_0:sendNotification(GAME.AUTO_SUB, {
					isActiveSub = false
				})
				var_4_0:ActiveBot(var_4_0.IsAutoBotActive(SYSTEM_BOSS_SINGLE))
			end
		end

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		NewBattleResultMediator.ON_ENTER_BATTLE_RESULT,
		NewBattleResultMediator.ON_COMPLETE_BATTLE_RESULT
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == NewBattleResultMediator.ON_ENTER_BATTLE_RESULT then
		arg_6_0:sendNotification(NewBattleResultMediator.SET_SKIP_FLAG, true)
		arg_6_0.viewComponent:OnEnterBattleResult()
	elseif var_6_0 == NewBattleResultMediator.ON_COMPLETE_BATTLE_RESULT then
		arg_6_0.viewComponent:AnimatingSlider()
	end

	return
end

function var_0_0.remove(arg_7_0)
	return
end

return var_0_0
