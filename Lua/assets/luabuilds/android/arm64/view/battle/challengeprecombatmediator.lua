local var_0_0 = class("ChallengePreCombatMediator", import("..base.ContextMediator"))

var_0_0.ON_START = "ChallengePreCombatMediator:ON_START"
var_0_0.ON_SWITCH_SHIP = "ChallengePreCombatMediator:ON_SWITCH_SHIP"
var_0_0.ON_AUTO = "ChallengePreCombatMediator:ON_AUTO"
var_0_0.ON_SUB_AUTO = "ChallengePreCombatMediator:ON_SUB_AUTO"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(ChallengeProxy):getUserChallengeInfo(arg_1_0.contextData.mode)

	arg_1_0:bind(var_0_0.ON_AUTO, function(arg_2_0, arg_2_1)
		arg_1_0:onAutoBtn(arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_SUB_AUTO, function(arg_3_0, arg_3_1)
		arg_1_0:onAutoSubBtn(arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_0.ON_START, function(arg_4_0)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_CHALLENGE,
			mode = var_0
		})

		return
	end)
	arg_1_0.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getData())

	local var_1_1 = var_1_0:getSubmarineFleet()

	arg_1_0.viewComponent:setSubFlag(#var_1_1:getShipsByTeam(TeamType.Submarine, false) > 0)
	arg_1_0.viewComponent:updateChallenge(var_1_0)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		PlayerProxy.UPDATED,
		GAME.BEGIN_STAGE_ERRO,
		GAME.BEGIN_STAGE_DONE,
		ChallengeProxy.CHALLENGE_UPDATED
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == PlayerProxy.UPDATED then
		arg_6_0.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getData())
	elseif var_6_0 == GAME.BEGIN_STAGE_ERRO then
		if var_6_1 == 3 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("battle_preCombatMediator_timeout"),
				onYes = function()
					arg_6_0.viewComponent:emit(BaseUI.ON_CLOSE)

					return
				end
			})
		end
	elseif var_6_0 == GAME.BEGIN_STAGE_DONE then
		arg_6_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_6_1)
	end

	return
end

function var_0_0.onAutoBtn(arg_8_0, arg_8_1)
	arg_8_0:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_8_1.isOn,
		toggle = arg_8_1.toggle
	})

	return
end

function var_0_0.onAutoSubBtn(arg_9_0, arg_9_1)
	arg_9_0:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = arg_9_1.isOn,
		toggle = arg_9_1.toggle
	})

	return
end

return var_0_0
