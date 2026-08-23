local var_0_0 = g.core.config.gold_saving_game_info
local RedPacketRainData = class("RedPacketRainData")
local RedPacketRainStruct = import(".RedPacketRainStruct")

function RedPacketRainData:ctor()
	self:initData()
end

function RedPacketRainData:initData()
	self._gameId = 0
	self._redPacketId = 1
	self._redPacketSequence = {}
	self._gainDict = {}

	self:_initGameInfo()
	self:_initAwardArray()
end

function RedPacketRainData:_initGameInfo()
	self._gameInfo = {}

	for iter_3_0, iter_3_1 in var_0_0.ipairs() do
		if iter_3_1.type == 2 then
			self._gameInfo[iter_3_1.id] = iter_3_1
		end
	end
end

function RedPacketRainData:_initAwardArray()
	self._awardArrayDict = {}
	self._bigAwardDict = {}

	for iter_4_0, iter_4_1 in pairs(self._gameInfo) do
		self._awardArrayDict[iter_4_1.id] = {}

		local var_4_0 = 1

		while iter_4_1["parameter_" .. 1] and iter_4_1["parameter_" .. 1] > 0 do
			local var_4_1 = g.core.common.Drops:getGoodsArray(iter_4_1["reward_" .. var_4_0])

			for iter_4_2 = 1, iter_4_1["parameter_" .. 1] do
				var_4_1[1].parameterIndex = var_4_0

				table.insert(self._awardArrayDict[iter_4_1.id], var_4_1[1])
			end

			var_4_0 = var_4_0 + 1
		end

		self._bigAwardDict[iter_4_1.id] = {}

		local var_4_3 = g.core.common.Drops:getGoodsArray(iter_4_1.special_reward)

		var_4_3[1].clickNum = iter_4_1.special_time
		self._bigAwardDict[iter_4_1.id] = var_4_3[1]
	end
end

function RedPacketRainData:getShuffledRedPacket(arg_5_1)
	self._redPacketId = arg_5_1
	self._redPacketSequence = {}
	self._gameId = self._gameInfo[self._redPacketId].id or 0

	local var_5_0 = cc.Director:getInstance():getSafeAreaRect()

	for iter_5_0, iter_5_1 in ipairs(self._awardArrayDict[self._redPacketId]) do
		table.insert(self._redPacketSequence, (RedPacketRainStruct.new({
			award = iter_5_1,
			parameterIndex = iter_5_1.parameterIndex,
			startPos = cc.p(math.random(var_5_0.x + 128, display.width - var_5_0.x - 128), 0)
		})))
	end

	local var_5_1 = RedPacketRainStruct.new({
		isBigAward = true,
		award = self._bigAwardDict[self._redPacketId],
		startPos = cc.p(display.width + 300, -300),
		clickNum = self._bigAwardDict[self._redPacketId].clickNum
	})

	self:shuffleRedPacket()
	table.insert(self._redPacketSequence, var_5_1)
	var_5_1:setIndex(#self._redPacketSequence)

	return self._redPacketSequence
end

function RedPacketRainData:shuffleRedPacket()
	require("app.core.utils.KsMath").shuffleArray(self._redPacketSequence)

	for iter_6_0, iter_6_1 in ipairs(self._redPacketSequence) do
		iter_6_1:setIndex(iter_6_0)
	end
end

function RedPacketRainData:addAward(arg_7_1)
	self._gainDict[arg_7_1] = self._gainDict[arg_7_1] or 0
	self._gainDict[arg_7_1] = self._gainDict[arg_7_1] + 1
end

function RedPacketRainData:resetGain()
	self._gainDict = {}
end

function RedPacketRainData:getGainDict()
	return self._gainDict
end

function RedPacketRainData:getGameId()
	return self._gameId
end

return RedPacketRainData
