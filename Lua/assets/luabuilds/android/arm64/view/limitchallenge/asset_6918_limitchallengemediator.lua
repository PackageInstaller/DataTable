local LimitChallengeMediator = class("LimitChallengeMediator", import("..base.ContextMediator"))

function LimitChallengeMediator:register()
	self:bindEvent()
	self:tryGetAward()

	return
end

function LimitChallengeMediator:listNotificationInterests()
	return {
		LimitChallengeConst.REQ_CHALLENGE_INFO_DONE,
		LimitChallengeConst.GET_CHALLENGE_AWARD_DONE,
		LimitChallengeConst.UPDATE_PASS_TIME
	}
end

function LimitChallengeMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()

	if var_3_0 == LimitChallengeConst.REQ_CHALLENGE_INFO_DONE then
		self.viewComponent:onReqInfo()
	elseif var_3_0 == LimitChallengeConst.GET_CHALLENGE_AWARD_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_3_1:getBody().awards)
		self.viewComponent:updateToggleList()
		self.viewComponent:trigeHigestUnlockLevel()
	elseif var_3_0 == LimitChallengeConst.UPDATE_PASS_TIME then
		self.viewComponent:updatePassTime()
	end

	return
end

function LimitChallengeMediator:bindEvent()
	self:bind(LimitChallengeConst.OPEN_PRE_COMBAT_LAYER, function(arg_5_0, arg_5_1)
		self:addSubLayers((Context.New({
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

function LimitChallengeMediator:tryGetAward()
	local var_6_0 = getProxy(LimitChallengeProxy):getMissAwardChallengeIDLIst()

	if #var_6_0 > 0 then
		self:sendNotification(LimitChallengeConst.GET_CHALLENGE_AWARD, {
			challengeIDList = var_6_0
		})
	end

	return
end

return LimitChallengeMediator
