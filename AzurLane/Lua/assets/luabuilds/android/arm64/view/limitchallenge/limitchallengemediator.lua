class = var_0_10000

local var_0_0 = "LimitChallengeMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	arg_1_0:bindEvent()
	arg_1_0:tryGetAward()

	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = {}

	LimitChallengeConst = var_1_10002
	var_2_0[1] = var_1_10002.REQ_CHALLENGE_INFO_DONE
	LimitChallengeConst = var_2
	var_2_0[2] = var_2.GET_CHALLENGE_AWARD_DONE
	LimitChallengeConst = var_2
	var_2_0[3] = var_2.UPDATE_PASS_TIME

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.getName(var_3_0)
	local var_3_2 = arg_3_1:getBody()

	LimitChallengeConst = var_3_0

	if var_3_1 == var_3_0.REQ_CHALLENGE_INFO_DONE then
		local var_3_3 = arg_3_0.viewComponent

		var_4.onReqInfo(var_3_3)
	else
		LimitChallengeConst = var_4

		local var_3_5

		if var_3_1 == var_4.GET_CHALLENGE_AWARD_DONE then
			local var_3_4 = arg_3_0.viewComponent

			var_3_5 = var_3_5.emit
			BaseUI = var_1_10007

			var_3_5(var_3_4, var_1_10007.ON_ACHIEVE, var_3_2.awards)

			local var_3_6 = arg_3_0.viewComponent

			var_3_5.updateToggleList(var_3_6)

			local var_3_7 = arg_3_0.viewComponent

			var_3_5.trigeHigestUnlockLevel(var_3_7)
		else
			LimitChallengeConst = var_3_5

			if var_3_1 == var_3_5.UPDATE_PASS_TIME then
				local var_3_8 = arg_3_0.viewComponent

				var_4.updatePassTime(var_3_8)
			end
		end
	end

	return
end

function var_0_1.bindEvent(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.bind

	LimitChallengeConst = var_1_10004

	var_4_1(var_4_0, var_1_10004.OPEN_PRE_COMBAT_LAYER, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_1.stageID

		Context = var_2_10003

		local var_5_1 = var_2_10003.New
		local var_5_2 = {}

		LimitChallengePreCombatMediator = var_2_10006
		var_5_2.mediator = var_2_10006
		LimitChallengePreCombatLayer = var_2_10006
		var_5_2.viewComponent = var_2_10006

		local var_5_3 = {
			stageId = var_5_0
		}

		SYSTEM_LIMIT_CHALLENGE = var_2_10007
		var_5_3.system = var_2_10007
		var_5_2.data = var_5_3

		local var_5_4 = var_5_1(var_5_2)
		local var_5_5 = arg_4_0

		var_4.addSubLayers(var_5_5, var_5_4)

		return
	end)

	return
end

function var_0_1.tryGetAward(arg_6_0)
	getProxy = var_1_10001
	LimitChallengeProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)

	if #var_1.getMissAwardChallengeIDLIst(var_6_0) > 0 then
		local var_6_1 = arg_6_0
		local var_6_2 = arg_6_0.sendNotification

		LimitChallengeConst = var_1_10005

		var_6_2(var_6_1, var_1_10005.GET_CHALLENGE_AWARD, {
			challengeIDList = var_1
		})
	end

	return
end

return var_0_1
