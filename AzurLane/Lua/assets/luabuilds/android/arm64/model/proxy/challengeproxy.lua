local var_0_0 = class("ChallengeProxy", import(".NetProxy"))

var_0_0.MODE_CASUAL = 0
var_0_0.MODE_INFINITE = 1

function var_0_0.register(arg_1_0)
	arg_1_0._curMode = var_0_0.MODE_CASUAL
	arg_1_0._challengeInfo = nil
	arg_1_0._userChallengeList = {}

	arg_1_0:on(24010, function(arg_2_0)
		arg_1_0:updateCombatScore(arg_2_0.score)

		return
	end)

	return
end

function var_0_0.userSeaonExpire(arg_3_0, arg_3_1)
	if arg_3_0._challengeInfo:getSeasonID() ~= arg_3_0._userChallengeList[arg_3_1]:getSeasonID() then
		return true
	else
		return false
	end

	return
end

function var_0_0.updateCombatScore(arg_4_0, arg_4_1)
	arg_4_0:getUserChallengeInfo(arg_4_0._curMode):updateCombatScore(arg_4_1)

	return
end

function var_0_0.updateSeasonChallenge(arg_5_0, arg_5_1)
	if not arg_5_0._challengeInfo then
		arg_5_0._challengeInfo = ChallengeInfo.New(arg_5_1)
	else
		arg_5_0._challengeInfo:UpdateChallengeInfo(arg_5_1)
	end

	return
end

function var_0_0.updateCurrentChallenge(arg_6_0, arg_6_1)
	if arg_6_0._userChallengeList[arg_6_1.mode] == nil then
		arg_6_0._userChallengeList[arg_6_1.mode] = UserChallengeInfo.New(arg_6_1)
	else
		arg_6_0._userChallengeList[arg_6_1.mode]:UpdateChallengeInfo(arg_6_1)
	end

	return
end

function var_0_0.GetCurrentChallenge(arg_7_0, arg_7_1)
	return arg_7_0._userChallengeList
end

function var_0_0.getCurMode(arg_8_0)
	return arg_8_0._curMode
end

function var_0_0.setCurMode(arg_9_0, arg_9_1)
	if arg_9_1 == var_0_0.MODE_CASUAL then
		arg_9_0._curMode = var_0_0.MODE_CASUAL
	elseif arg_9_1 == var_0_0.MODE_INFINITE then
		arg_9_0._curMode = var_0_0.MODE_INFINITE
	else
		assert(false, "challenge mode undefined")
	end

	return
end

function var_0_0.getChallengeInfo(arg_10_0)
	return arg_10_0._challengeInfo
end

function var_0_0.getUserChallengeInfoList(arg_11_0)
	return arg_11_0._userChallengeList
end

function var_0_0.getUserChallengeInfo(arg_12_0, arg_12_1)
	return arg_12_0._userChallengeList[arg_12_1]
end

function var_0_0.WriteBackOnExitBattleResult(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:getUserChallengeInfo(arg_13_2)

	if arg_13_1 < ys.Battle.BattleConst.BattleScore.S then
		arg_13_0:sendNotification(GAME.CHALLENGE2_RESET, {
			mode = arg_13_2
		})
	else
		local var_13_1 = var_13_0:IsFinish()

		var_13_0:updateLevelForward()

		if var_13_0:getMode() == ChallengeProxy.MODE_INFINITE and var_13_1 then
			var_13_0:setInfiniteDungeonIDListByLevel()
		end
	end

	local var_13_2 = arg_13_0:getChallengeInfo()

	if not arg_13_0:userSeaonExpire(var_13_0:getMode()) then
		var_13_2:checkRecord(var_13_0)
	end

	return
end

return var_0_0
