class = var_0_10000

local var_0_0 = "ChallengeProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.MODE_CASUAL = 0
var_0_1.MODE_INFINITE = 1

function var_0_1.register(arg_1_0)
	arg_1_0._curMode = var_0_1.MODE_CASUAL
	arg_1_0._challengeInfo = nil
	arg_1_0._userChallengeList = {}

	arg_1_0:on(24010, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.updateCombatScore(var_2_0, arg_2_0.score)

		return
	end)

	return
end

function var_0_1.userSeaonExpire(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._challengeInfo
	local var_3_1 = var_2.getSeasonID(var_3_0)
	local var_3_2 = arg_3_0._userChallengeList[arg_3_1]

	if var_3_1 ~= var_3.getSeasonID(var_3_2) then
		return true
	else
		return false
	end

	return
end

function var_0_1.updateCombatScore(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getUserChallengeInfo(arg_4_0._curMode)

	var_2.updateCombatScore(var_4_0, arg_4_1)

	return
end

function var_0_1.updateSeasonChallenge(arg_5_0, arg_5_1)
	if not arg_5_0._challengeInfo then
		ChallengeInfo = var_2
		arg_5_0._challengeInfo = var_2.New(arg_5_1)
	else
		local var_5_0 = arg_5_0._challengeInfo

		var_2.UpdateChallengeInfo(var_5_0, arg_5_1)
	end

	return
end

function var_0_1.updateCurrentChallenge(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.mode

	if arg_6_0._userChallengeList[var_6_0] == nil then
		local var_6_1 = arg_6_0._userChallengeList

		UserChallengeInfo = var_1_10005
		var_6_1[var_6_0] = var_1_10005.New(arg_6_1)
	else
		var_3:UpdateChallengeInfo(arg_6_1)
	end

	return
end

function var_0_1.GetCurrentChallenge(arg_7_0, arg_7_1)
	return arg_7_0._userChallengeList
end

function var_0_1.getCurMode(arg_8_0)
	return arg_8_0._curMode
end

function var_0_1.setCurMode(arg_9_0, arg_9_1)
	if arg_9_1 == var_0_1.MODE_CASUAL then
		arg_9_0._curMode = var_0_1.MODE_CASUAL
	elseif arg_9_1 == var_0_1.MODE_INFINITE then
		arg_9_0._curMode = var_0_1.MODE_INFINITE
	else
		assert = var_2

		var_2(false, "challenge mode undefined")
	end

	return
end

function var_0_1.getChallengeInfo(arg_10_0)
	return arg_10_0._challengeInfo
end

function var_0_1.getUserChallengeInfoList(arg_11_0)
	return arg_11_0._userChallengeList
end

function var_0_1.getUserChallengeInfo(arg_12_0, arg_12_1)
	return arg_12_0._userChallengeList[arg_12_1]
end

function var_0_1.WriteBackOnExitBattleResult(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:getUserChallengeInfo(arg_13_2)

	ys = var_1_10004

	if arg_13_1 < var_1_10004.Battle.BattleConst.BattleScore.S then
		local var_13_1 = arg_13_0
		local var_13_2 = arg_13_0.sendNotification

		GAME = var_1_10007

		var_13_2(var_13_1, var_1_10007.CHALLENGE2_RESET, {
			mode = arg_13_2
		})
	else
		local var_13_3 = var_13_0
		local var_13_4 = var_13_0.IsFinish(var_13_3)

		var_13_0:updateLevelForward()

		local var_13_5 = var_13_0:getMode()

		ChallengeProxy = var_13_3

		if var_13_5 == var_13_3.MODE_INFINITE and var_13_4 then
			var_13_0:setInfiniteDungeonIDListByLevel()
		end
	end

	local var_13_6 = arg_13_0:getChallengeInfo()

	if not arg_13_0:userSeaonExpire(var_13_0:getMode()) then
		var_13_6:checkRecord(var_13_0)
	end

	return
end

return var_0_1
