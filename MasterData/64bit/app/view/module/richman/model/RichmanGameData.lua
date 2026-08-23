local var_0_0 = g.core.config.richman_game_info
local RichmanConst = require("app.view.module.richman.const.RichmanConst")
local var_0_2 = g.core.config.richman_event_info
local RichmanRedPacketRainStruct = require("app.view.module.richman.model.RichmanRedPacketRainStruct")
local RichmanGameData = class("RichmanGameData")

function RichmanGameData:ctor()
	self:initData()
end

function RichmanGameData:initData()
	self:initTurnCardData()
	self:initRedPackageData()
end

function RichmanGameData:getWishTreeGameData(arg_3_1)
	local var_3_0 = var_0_2.get(arg_3_1.id).event_value1
	local var_3_1 = {}
	local var_3_2

	if var_3_0 and var_0_0.fetch(var_3_0) then
		local var_3_3 = var_0_0.get(var_3_0)

		var_3_1 = g.core.common.Drops:getGoodsArray(var_3_3.reward_1, false, true)

		if var_3_3.special_reward > 0 then
			local var_3_4 = g.core.common.Drops:getGoodsArray(var_3_3.special_reward, false, true)

			if #var_3_4 > 0 then
				var_3_2 = var_3_4[1]
			end
		end
	end

	return var_3_1, var_3_2
end

function RichmanGameData:setTurnCardGameId(arg_4_1)
	self._turnCardGameId = arg_4_1

	self:initTurnCardData()
end

function RichmanGameData:initTurnCardData()
	self._turnCardGameId = self._turnCardGameId or 1
	self._rewardId = 0
	self._turnNum = 0
	self._curTurnIndex = 0

	self:_initDropIdDict()

	self._cardSequence = {}
end

function RichmanGameData:_initDropIdDict()
	self._rewardDict = {}

	local var_6_0 = var_0_0.fetch(self._turnCardGameId)

	if not var_6_0 then
		return
	end

	local var_6_1 = "reward_"

	while var_0_0.hasKey("parameter_" .. 1) do
		if var_6_0[var_6_1 .. 1] > 0 then
			self._rewardDict[1] = g.core.common.Drops:getGoodsArray(var_6_0[var_6_1 .. 1])
		end
	end
end

function RichmanGameData:_createCardSequence()
	self._turnNum = math.random(3, 7)
	self._cardSequence = {}

	local var_7_0 = {
		self._rewardId,
		self._rewardId
	}
	local var_7_1 = 1
	local var_7_2 = 2

	if self._rewardId == 1 then
		var_7_1 = 3
	elseif self._rewardId == 2 then
		var_7_2 = 3
	end

	for iter_7_0 = 1, self._turnNum - 3 do
		table.insert(var_7_0, var_7_1)
	end

	for iter_7_1 = 3, 2 + math.random(math.max(0, self._turnNum - 3 - 2), (math.min(2, self._turnNum - 3))) do
		var_7_0[iter_7_1] = var_7_2
	end

	require("app.core.utils.KsMath").shuffleArray(var_7_0)

	for iter_7_2 = 1, #var_7_0 do
		table.insert(self._cardSequence, var_7_0[iter_7_2])
	end

	self._cardSequence[self._turnNum] = self._rewardId
end

function RichmanGameData:getCardTypeByIndex(arg_8_1)
	return self._cardSequence[arg_8_1]
end

function RichmanGameData:onTurnCardGameStart(arg_9_1)
	self._rewardId = arg_9_1.params[1]

	self:_createCardSequence()
end

function RichmanGameData:getGameId()
	return self._turnCardGameId
end

function RichmanGameData:getCardSequence()
	return self._cardSequence
end

function RichmanGameData:getRewardDict()
	return self._rewardDict
end

function RichmanGameData:getCurCardIndex()
	self._curTurnIndex = self._curTurnIndex + 1

	return self._curTurnIndex
end

function RichmanGameData:isLastCard(arg_14_1)
	return arg_14_1 >= self._turnNum
end

function RichmanGameData:getRewardId()
	return self._rewardId
end

function RichmanGameData:initRedPackageData()
	self._redPackageGameId = 0
	self._redPacketId = 1
	self._redPacketSequence = {}
	self._gainDict = {}

	self:_initGameInfo()
	self:_initAwardArray()
end

function RichmanGameData:_initGameInfo()
	self._redPackageGameInfo = {}

	for iter_17_0, iter_17_1 in var_0_0.ipairs() do
		if iter_17_1.type == RichmanConst.EVENT_TYPE.GAME_REDPACKET then
			self._redPackageGameInfo[iter_17_1.id] = iter_17_1
		end
	end
end

function RichmanGameData:_initAwardArray()
	self._awardArrayDict = {}
	self._bigAwardDict = {}

	for iter_18_0, iter_18_1 in pairs(self._redPackageGameInfo) do
		self._awardArrayDict[iter_18_1.id] = {}

		local var_18_0 = 1

		while iter_18_1["parameter_" .. 1] and iter_18_1["parameter_" .. 1] > 0 do
			local var_18_1 = g.core.common.Drops:getGoodsArray(iter_18_1["reward_" .. var_18_0])

			for iter_18_2 = 1, iter_18_1["parameter_" .. 1] do
				var_18_1[1].parameterIndex = var_18_0

				table.insert(self._awardArrayDict[iter_18_1.id], var_18_1[1])
			end

			var_18_0 = var_18_0 + 1
		end

		self._bigAwardDict[iter_18_1.id] = {}

		local var_18_3 = g.core.common.Drops:getGoodsArray(iter_18_1.special_reward)

		var_18_3[1].clickNum = iter_18_1.special_time
		self._bigAwardDict[iter_18_1.id] = var_18_3[1]
	end
end

function RichmanGameData:getShuffledRedPacket(arg_19_1)
	self._redPacketId = arg_19_1
	self._redPacketSequence = {}
	self._redPackageGameId = self._redPackageGameInfo[self._redPacketId].id or 0

	local function var_19_0(arg_20_0)
		return display.height / display.width * (arg_20_0 - display.width)
	end

	for iter_19_0, iter_19_1 in ipairs(self._awardArrayDict[self._redPacketId]) do
		local var_19_1 = math.random(display.width * 5 / 7, display.width * 20 / 19)

		table.insert(self._redPacketSequence, (RichmanRedPacketRainStruct.new({
			award = iter_19_1,
			parameterIndex = iter_19_1.parameterIndex,
			startPos = cc.p(var_19_1, var_19_0(var_19_1))
		})))
	end

	local var_19_2 = RichmanRedPacketRainStruct.new({
		isBigAward = true,
		award = self._bigAwardDict[self._redPacketId],
		startPos = cc.p(display.width - 300, -300),
		clickNum = self._bigAwardDict[self._redPacketId].clickNum
	})

	self:shuffleRedPacket()
	table.insert(self._redPacketSequence, var_19_2)
	var_19_2:setIndex(#self._redPacketSequence)

	return self._redPacketSequence
end

function RichmanGameData:shuffleRedPacket()
	require("app.core.utils.KsMath").shuffleArray(self._redPacketSequence)

	for iter_21_0, iter_21_1 in ipairs(self._redPacketSequence) do
		iter_21_1:setIndex(iter_21_0)
	end
end

function RichmanGameData:addAward(arg_22_1)
	self._gainDict[arg_22_1] = self._gainDict[arg_22_1] or 0
	self._gainDict[arg_22_1] = self._gainDict[arg_22_1] + 1
end

function RichmanGameData:resetGain()
	self._gainDict = {}
end

function RichmanGameData:getGainDict()
	return self._gainDict
end

function RichmanGameData:getRedPackageGameId()
	return self._redPackageGameId
end

return RichmanGameData
