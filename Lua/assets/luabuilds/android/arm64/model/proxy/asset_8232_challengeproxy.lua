local ChallengeProxy = class("ChallengeProxy", import(".NetProxy"))

ChallengeProxy.MODE_CASUAL = 0
ChallengeProxy.MODE_INFINITE = 1

function ChallengeProxy:register()
	self._curMode = ChallengeProxy.MODE_CASUAL
	self._challengeInfo = nil
	self._userChallengeList = {}

	self:on(24010, function(arg_2_0)
		self:updateCombatScore(arg_2_0.score)

		return
	end)

	return
end

function ChallengeProxy:userSeaonExpire(arg_3_1)
	if self._challengeInfo:getSeasonID() ~= self._userChallengeList[arg_3_1]:getSeasonID() then
		return true
	else
		return false
	end

	return
end

function ChallengeProxy:updateCombatScore(arg_4_1)
	self:getUserChallengeInfo(self._curMode):updateCombatScore(arg_4_1)

	return
end

function ChallengeProxy:updateSeasonChallenge(arg_5_1)
	if not self._challengeInfo then
		self._challengeInfo = ChallengeInfo.New(arg_5_1)
	else
		self._challengeInfo:UpdateChallengeInfo(arg_5_1)
	end

	return
end

function ChallengeProxy:updateCurrentChallenge(arg_6_1)
	if self._userChallengeList[arg_6_1.mode] == nil then
		self._userChallengeList[arg_6_1.mode] = UserChallengeInfo.New(arg_6_1)
	else
		self._userChallengeList[arg_6_1.mode]:UpdateChallengeInfo(arg_6_1)
	end

	return
end

function ChallengeProxy:GetCurrentChallenge(arg_7_1)
	return self._userChallengeList
end

function ChallengeProxy:getCurMode()
	return self._curMode
end

function ChallengeProxy:setCurMode(arg_9_1)
	if arg_9_1 == ChallengeProxy.MODE_CASUAL then
		self._curMode = ChallengeProxy.MODE_CASUAL
	elseif arg_9_1 == ChallengeProxy.MODE_INFINITE then
		self._curMode = ChallengeProxy.MODE_INFINITE
	else
		assert(false, "challenge mode undefined")
	end

	return
end

function ChallengeProxy:getChallengeInfo()
	return self._challengeInfo
end

function ChallengeProxy:getUserChallengeInfoList()
	return self._userChallengeList
end

function ChallengeProxy:getUserChallengeInfo(arg_12_1)
	return self._userChallengeList[arg_12_1]
end

function ChallengeProxy:WriteBackOnExitBattleResult(arg_13_1, arg_13_2)
	local var_13_0 = self:getUserChallengeInfo(arg_13_2)

	if arg_13_1 < ys.Battle.BattleConst.BattleScore.S then
		self:sendNotification(GAME.CHALLENGE2_RESET, {
			mode = arg_13_2
		})
	else
		local var_13_1 = var_13_0:IsFinish()

		var_13_0:updateLevelForward()

		if var_13_0:getMode() == ChallengeProxy.MODE_INFINITE and var_13_1 then
			var_13_0:setInfiniteDungeonIDListByLevel()
		end
	end

	if not self:userSeaonExpire(var_13_0:getMode()) then
		self:getChallengeInfo():checkRecord(var_13_0)
	end

	return
end

return ChallengeProxy
