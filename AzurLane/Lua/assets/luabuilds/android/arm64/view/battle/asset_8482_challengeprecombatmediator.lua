class = var_0_10000

local var_0_0 = "ChallengePreCombatMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_START = "ChallengePreCombatMediator:ON_START"
var_0_1.ON_SWITCH_SHIP = "ChallengePreCombatMediator:ON_SWITCH_SHIP"
var_0_1.ON_AUTO = "ChallengePreCombatMediator:ON_AUTO"
var_0_1.ON_SUB_AUTO = "ChallengePreCombatMediator:ON_SUB_AUTO"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0.contextData.mode

	getProxy = var_1_10002
	ChallengeProxy = var_1_10004

	local var_1_1 = var_1_10002(var_1_10004)
	local var_1_2 = var_2.getUserChallengeInfo(var_1_1, var_1_0)

	arg_1_0:bind(var_0_1.ON_AUTO, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0

		var_2.onAutoBtn(var_2_0, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SUB_AUTO, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0

		var_2.onAutoSubBtn(var_3_0, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_START, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_4_2 = var_2_10004.BEGIN_STAGE
		local var_4_3 = {}

		SYSTEM_CHALLENGE = var_2_10006
		var_4_3.system = var_2_10006
		var_4_3.mode = var_1_0

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)

	local var_1_3 = arg_1_0.viewComponent
	local var_1_4 = var_4.setPlayerInfo

	getProxy = var_7
	PlayerProxy = var_1_10009

	local var_1_5 = var_7(var_1_10009)

	var_1_4(var_1_3, var_7.getData(var_1_5))

	local var_1_6 = var_1_2:getSubmarineFleet()
	local var_1_7 = var_4.getShipsByTeam

	TeamType = var_8

	local var_1_8 = var_1_7(var_1_6, var_8.Submarine, false)
	local var_1_9 = arg_1_0.viewComponent

	var_6.setSubFlag(var_1_9, #var_1_8 > 0)

	local var_1_10 = arg_1_0.viewComponent

	var_6.updateChallenge(var_1_10, var_1_2)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	PlayerProxy = var_1_10002
	var_5_0[1] = var_1_10002.UPDATED
	GAME = var_2
	var_5_0[2] = var_2.BEGIN_STAGE_ERRO
	GAME = var_2
	var_5_0[3] = var_2.BEGIN_STAGE_DONE
	ChallengeProxy = var_2
	var_5_0[4] = var_2.CHALLENGE_UPDATED

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1:getBody()

	PlayerProxy = var_6_0

	local var_6_4

	if var_6_1 == var_6_0.UPDATED then
		local var_6_3 = arg_6_0.viewComponent

		var_6_4 = var_6_4.setPlayerInfo
		getProxy = var_1_10007
		PlayerProxy = var_1_10009

		local var_6_5 = var_1_10007(var_1_10009)

		var_6_4(var_6_3, var_1_10007.getData(var_6_5))
	else
		GAME = var_6_4

		local var_6_7

		if var_6_1 == var_6_4.BEGIN_STAGE_ERRO then
			if var_6_2 == 3 then
				pg = var_6_7

				local var_6_6 = var_6_7.MsgboxMgr.GetInstance()

				var_6_7 = var_6_7.ShowMsgBox
				var_1_10007 = {
					hideNo = true
				}
				i18n = var_1_10008
				var_1_10007.content = var_1_10008("battle_preCombatMediator_timeout")

				function var_1_10007.onYes()
					local var_7_0 = arg_6_0.viewComponent
					local var_7_1 = var_0.emit

					BaseUI = var_2_10003

					var_7_1(var_7_0, var_2_10003.ON_CLOSE)

					return
				end

				var_6_7(var_6_6, var_1_10007)
			end
		else
			GAME = var_6_7

			if var_6_1 == var_6_7.BEGIN_STAGE_DONE then
				local var_6_8 = arg_6_0
				local var_6_9 = arg_6_0.sendNotification

				GAME = var_1_10007

				local var_6_10 = var_1_10007.GO_SCENE

				SCENE = var_1_10008

				var_6_9(var_6_8, var_6_10, var_1_10008.COMBATLOAD, var_6_2)
			end
		end
	end

	return
end

function var_0_1.onAutoBtn(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.isOn
	local var_8_1 = arg_8_1.toggle
	local var_8_2 = arg_8_0
	local var_8_3 = arg_8_0.sendNotification

	GAME = var_1_10007

	var_8_3(var_8_2, var_1_10007.AUTO_BOT, {
		isActiveBot = var_8_0,
		toggle = var_8_1
	})

	return
end

function var_0_1.onAutoSubBtn(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.isOn
	local var_9_1 = arg_9_1.toggle
	local var_9_2 = arg_9_0
	local var_9_3 = arg_9_0.sendNotification

	GAME = var_1_10007

	var_9_3(var_9_2, var_1_10007.AUTO_SUB, {
		isActiveSub = var_9_0,
		toggle = var_9_1
	})

	return
end

return var_0_1
