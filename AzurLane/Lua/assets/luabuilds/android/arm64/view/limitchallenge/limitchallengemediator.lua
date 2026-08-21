local var_0_0 = class("LimitChallengeMediator", import("..base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0:bindEvent()
	arg_1_0:tryGetAward()

	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {
		LimitChallengeConst.REQ_CHALLENGE_INFO_DONE,
		LimitChallengeConst.GET_CHALLENGE_AWARD_DONE,
		LimitChallengeConst.UPDATE_PASS_TIME
	}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()

	if var_3_0 == LimitChallengeConst.REQ_CHALLENGE_INFO_DONE then
		arg_3_0.viewComponent:onReqInfo()
	elseif var_3_0 == LimitChallengeConst.GET_CHALLENGE_AWARD_DONE then
		arg_3_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_3_1:getBody().awards)
		arg_3_0.viewComponent:updateToggleList()
		arg_3_0.viewComponent:trigeHigestUnlockLevel()
	elseif var_3_0 == LimitChallengeConst.UPDATE_PASS_TIME then
		arg_3_0.viewComponent:updatePassTime()
	end

	return
end

function var_0_0.bindEvent(arg_4_0)
	arg_4_0:bind(LimitChallengeConst.OPEN_PRE_COMBAT_LAYER, function(arg_5_0, arg_5_1)
		arg_4_0:addSubLayers((Context.New({
			mediator = LimitChallengePreCombatMediator,
			viewComponent = LimitChallengePreCombatLayer,
			data = {
				stageId = arg_5_1.stageID,
				system = SYSTEM_LIMIT_CHALLENGE
			}
		})))

		return
	end)

	return
end

function var_0_0.tryGetAward(arg_6_0)
	local var_6_0 = getProxy(LimitChallengeProxy):getMissAwardChallengeIDLIst()

	if #var_6_0 > 0 then
		arg_6_0:sendNotification(LimitChallengeConst.GET_CHALLENGE_AWARD, {
			challengeIDList = var_6_0
		})
	end

	return
end

return var_0_0
