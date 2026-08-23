local var_0_0 = g.core.config.team_battle_game_info
local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleRedPacketRainStruct = require("app.view.module.teamBattle.model.struct.TeamBattleRedPacketRainStruct")
local TeamBattleGameData = class("TeamBattleGameData")

function TeamBattleGameData:ctor()
	self:initData()
end

function TeamBattleGameData:initData()
	self:initTurnCardData()
	self:initRedPackageData()
end

function TeamBattleGameData:setTurnCardGameId(arg_3_1)
	self._turnCardGameId = arg_3_1

	self:initTurnCardData()
end

function TeamBattleGameData:initTurnCardData()
	self._turnCardGameId = self._turnCardGameId or 1
	self._rewardId = 0
	self._turnNum = 0
	self._curTurnIndex = 0

	self:_initDropIdDict()

	self._cardSequence = {}
end

function TeamBattleGameData:_initDropIdDict()
	self._rewardDict = {}

	local var_5_0 = var_0_0.fetch(self._turnCardGameId)

	if not var_5_0 then
		return
	end

	local var_5_1 = "reward_"

	while var_0_0.hasKey("parameter_" .. 1) do
		if var_5_0[var_5_1 .. 1] > 0 then
			self._rewardDict[1] = g.core.common.Drops:getGoodsArray(var_5_0[var_5_1 .. 1])
		end
	end
end

function TeamBattleGameData:_createCardSequence()
	self._turnNum = math.random(3, 7)
	self._cardSequence = {}

	local var_6_0 = {
		self._rewardId,
		self._rewardId
	}
	local var_6_1 = 1
	local var_6_2 = 2

	if self._rewardId == 1 then
		var_6_1 = 3
	elseif self._rewardId == 2 then
		var_6_2 = 3
	end

	for iter_6_0 = 1, self._turnNum - 3 do
		table.insert(var_6_0, var_6_1)
	end

	for iter_6_1 = 3, 2 + math.random(math.max(0, self._turnNum - 3 - 2), (math.min(2, self._turnNum - 3))) do
		var_6_0[iter_6_1] = var_6_2
	end

	require("app.core.utils.KsMath").shuffleArray(var_6_0)

	for iter_6_2 = 1, #var_6_0 do
		table.insert(self._cardSequence, var_6_0[iter_6_2])
	end

	self._cardSequence[self._turnNum] = self._rewardId
end

function TeamBattleGameData:getCardTypeByIndex(arg_7_1)
	return self._cardSequence[arg_7_1]
end

function TeamBattleGameData:onTurnCardGameStart(arg_8_1)
	self._rewardId = arg_8_1.params[1]

	self:_createCardSequence()
end

function TeamBattleGameData:getGameId()
	return self._turnCardGameId
end

function TeamBattleGameData:getCardSequence()
	return self._cardSequence
end

function TeamBattleGameData:getRewardDict()
	return self._rewardDict
end

function TeamBattleGameData:getCurCardIndex()
	self._curTurnIndex = self._curTurnIndex + 1

	return self._curTurnIndex
end

function TeamBattleGameData:isLastCard(arg_13_1)
	return arg_13_1 >= self._turnNum
end

function TeamBattleGameData:getRewardId()
	return self._rewardId
end

function TeamBattleGameData:initRedPackageData()
	self._redPackageGameId = 0
	self._redPacketId = 1
	self._redPacketSequence = {}
	self._gainDict = {}

	self:_initGameInfo()
	self:_initAwardArray()
end

function TeamBattleGameData:_initGameInfo()
	self._redPackageGameInfo = {}

	for iter_16_0, iter_16_1 in var_0_0.ipairs() do
		if iter_16_1.type == TeamBattleConst.EVENT_TYPE.GAME_METEOR_SHOWER then
			self._redPackageGameInfo[iter_16_1.id] = iter_16_1
		end
	end
end

function TeamBattleGameData:_initAwardArray()
	self._awardArrayDict = {}
	self._bigAwardDict = {}

	for iter_17_0, iter_17_1 in pairs(self._redPackageGameInfo) do
		self._awardArrayDict[iter_17_1.id] = {}

		local var_17_0 = 1

		while iter_17_1["parameter_" .. 1] and iter_17_1["parameter_" .. 1] > 0 do
			local var_17_1 = g.core.common.Drops:getGoodsArray(iter_17_1["reward_" .. var_17_0])

			for iter_17_2 = 1, iter_17_1["parameter_" .. 1] do
				var_17_1[1].parameterIndex = var_17_0

				table.insert(self._awardArrayDict[iter_17_1.id], var_17_1[1])
			end

			var_17_0 = var_17_0 + 1
		end

		self._bigAwardDict[iter_17_1.id] = {}

		local var_17_3 = g.core.common.Drops:getGoodsArray(iter_17_1.special_reward)

		var_17_3[1].clickNum = iter_17_1.special_time
		self._bigAwardDict[iter_17_1.id] = var_17_3[1]
	end
end

function TeamBattleGameData:getShuffledRedPacket(arg_18_1)
	self._redPacketId = arg_18_1
	self._redPacketSequence = {}
	self._redPackageGameId = self._redPackageGameInfo[self._redPacketId].id or 0

	local var_18_0 = cc.Director:getInstance():getSafeAreaRect()

	for iter_18_0, iter_18_1 in ipairs(self._awardArrayDict[self._redPacketId]) do
		table.insert(self._redPacketSequence, (TeamBattleRedPacketRainStruct.new({
			award = iter_18_1,
			parameterIndex = iter_18_1.parameterIndex,
			startPos = cc.p(math.random(var_18_0.x + 128, display.width - var_18_0.x - 128), 0)
		})))
	end

	local var_18_1 = TeamBattleRedPacketRainStruct.new({
		isBigAward = true,
		award = self._bigAwardDict[self._redPacketId],
		startPos = cc.p(display.width - 300, -300),
		clickNum = self._bigAwardDict[self._redPacketId].clickNum
	})

	self:shuffleRedPacket()
	table.insert(self._redPacketSequence, var_18_1)
	var_18_1:setIndex(#self._redPacketSequence)

	return self._redPacketSequence
end

function TeamBattleGameData:shuffleRedPacket()
	require("app.core.utils.KsMath").shuffleArray(self._redPacketSequence)

	for iter_19_0, iter_19_1 in ipairs(self._redPacketSequence) do
		iter_19_1:setIndex(iter_19_0)
	end
end

function TeamBattleGameData:addAward(arg_20_1)
	self._gainDict[arg_20_1] = self._gainDict[arg_20_1] or 0
	self._gainDict[arg_20_1] = self._gainDict[arg_20_1] + 1
end

function TeamBattleGameData:resetGain()
	self._gainDict = {}
end

function TeamBattleGameData:getGainDict()
	return self._gainDict
end

function TeamBattleGameData:getRedPackageGameId()
	return self._redPackageGameId
end

return TeamBattleGameData
