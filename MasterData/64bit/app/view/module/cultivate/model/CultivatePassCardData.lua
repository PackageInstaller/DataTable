local var_0_0 = g.core.config.cultivate_activity_passcard_info
local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local var_0_2 = g.core.common.Drops
local CultivatePassCardData = class("CultivatePassCardData")

function CultivatePassCardData:ctor(arg_1_1, arg_1_2)
	self._curLv = 0
	self._passCardId = arg_1_1
	self._passCardList = nil
	self._passCardCurrentData = {}
end

function CultivatePassCardData:initPassCardData()
	if self._passCardList then
		return
	end

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in var_0_0.ipairs() do
		if iter_2_1.passcard_id == self._passCardId then
			table.insert(var_2_0, iter_2_1)
		end
	end

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		return arg_3_0.level < arg_3_1.level
	end)

	self._passCardList = var_2_0
end

function CultivatePassCardData:getPassCardList()
	self:initPassCardData()

	return self._passCardList
end

function CultivatePassCardData:getPreviewFreeReward()
	self:initPassCardData()

	local var_5_0 = {}
	local var_5_1 = {}
	local var_5_2 = {}
	local var_5_3 = {}

	local function var_5_4(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		for iter_6_0, iter_6_1 in ipairs(arg_6_2) do
			local var_6_0 = iter_6_1.type .. "_" .. iter_6_1.value .. "_" .. arg_6_3.diaplay_remark

			if arg_6_0[iter_6_1.type .. "_" .. iter_6_1.value .. "_" .. arg_6_3.diaplay_remark] then
				arg_6_0[var_6_0].size = arg_6_0[var_6_0].size + iter_6_1.size
			else
				arg_6_0[var_6_0] = iter_6_1

				if arg_6_3.diaplay_remark == 1 then
					iter_6_1.sortLv = 10000
					iter_6_1.mark = arg_6_3.remark_des
				else
					iter_6_1.mark = g.core.lang:get(421415)
					iter_6_1.sortLv = 0
				end

				table.insert(arg_6_1, iter_6_1)
			end

			arg_6_0[var_6_0].sortLv = math.max(arg_6_0[var_6_0].sortLv, iter_6_1.quality * 1000 + arg_6_3.level * 10 + arg_6_3.id)
		end
	end

	for iter_5_0, iter_5_1 in ipairs(self._passCardList) do
		local var_5_5 = var_0_2:getGoodsArray(iter_5_1.pay_drop)

		var_5_4(var_5_2, var_5_0, var_0_2:getGoodsArray(iter_5_1.free_drop), iter_5_1)
		var_5_4(var_5_3, var_5_1, var_5_5, iter_5_1)
	end

	table.sort(var_5_0, function(arg_7_0, arg_7_1)
		if arg_7_0.sortLv ~= arg_7_1.sortLv then
			return arg_7_0.sortLv > arg_7_1.sortLv
		end

		return false
	end)
	table.sort(var_5_1, function(arg_8_0, arg_8_1)
		if arg_8_0.sortLv ~= arg_8_1.sortLv then
			return arg_8_0.sortLv > arg_8_1.sortLv
		end

		return false
	end)

	return var_5_0, var_5_1
end

function CultivatePassCardData:getLevelRewards(arg_9_1)
	local var_9_0 = self._passCardList[arg_9_1]
	local var_9_1 = {
		freeDrop = var_0_2:getGoodsArray(self._passCardList[arg_9_1].free_drop),
		rewardFree = self._passCardCurrentData[arg_9_1] and self._passCardCurrentData[arg_9_1].free_state,
		payDrop = var_0_2:getGoodsArray(self._passCardList[arg_9_1].pay_drop)
	}

	if self._passCardCurrentData[arg_9_1] then
		var_9_1.payNum = self._passCardCurrentData[arg_9_1].buy_num or 0
	end

	var_9_1.lvCfg = var_9_0

	return var_9_1
end

function CultivatePassCardData:updatePassCardData(arg_10_1, arg_10_2)
	if arg_10_2 then
		self._taskIdMap = {}
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_1 or {}) do
		local var_10_0 = var_0_0.get(iter_10_1.passcard_id).level

		self._passCardCurrentData[var_10_0] = self._passCardCurrentData[var_10_0] or iter_10_1
		self._passCardCurrentData[var_10_0].progress = iter_10_1.progress
		self._passCardCurrentData[var_10_0].free_state = iter_10_1.free_state
		self._passCardCurrentData[var_10_0].buy_num = iter_10_1.buy_num
	end

	self:updateCurrentLevel()
end

function CultivatePassCardData:updateCurrentLevel()
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs(self._passCardCurrentData) do
		if self:getFreeRewardState(iter_11_1.passcard_id, true) ~= CultivateConst.PASS_CARD_REWARD_STATE.NOT_FINISH then
			var_11_0 = iter_11_0
		else
			break
		end
	end

	self._curLv = var_11_0
end

function CultivatePassCardData:getFreeRewardStateByLevel(arg_12_1)
	self:initPassCardData()

	return self:getFreeRewardState(self._passCardList[arg_12_1].id)
end

function CultivatePassCardData:getFreeRewardState(arg_13_1, arg_13_2)
	local var_13_0 = var_0_0.get(arg_13_1)

	if not arg_13_2 and var_13_0.level > self._curLv then
		return CultivateConst.PASS_CARD_REWARD_STATE.NOT_FINISH
	end

	local var_13_1 = self._passCardCurrentData[var_13_0.level]

	if not self._passCardCurrentData[var_13_0.level] then
		return CultivateConst.PASS_CARD_REWARD_STATE.NOT_FINISH
	end

	if var_13_1.free_state then
		return CultivateConst.PASS_CARD_REWARD_STATE.GOT
	end

	if var_13_1.progress >= var_13_0.num then
		return CultivateConst.PASS_CARD_REWARD_STATE.CAN_REWARD
	end

	return CultivateConst.PASS_CARD_REWARD_STATE.NOT_FINISH
end

function CultivatePassCardData:getBuyRechargeGiftStateByLevel(arg_14_1)
	self:initPassCardData()

	return self:getBuyRechargeGiftState(self._passCardList[arg_14_1].id)
end

function CultivatePassCardData:getBuyRechargeGiftState(arg_15_1)
	local var_15_0 = var_0_0.get(arg_15_1)

	if var_15_0.level > self._curLv then
		return CultivateConst.PASS_CARD_REWARD_STATE.NOT_FINISH
	end

	local var_15_1 = self._passCardCurrentData[var_15_0.level]

	if not self._passCardCurrentData[var_15_0.level] then
		return CultivateConst.PASS_CARD_REWARD_STATE.NOT_FINISH
	end

	if var_15_1.free_state then
		return CultivateConst.PASS_CARD_REWARD_STATE.GOT
	end

	if var_15_1.buy_num >= var_15_0.buy_num then
		return CultivateConst.PASS_CARD_REWARD_STATE.CAN_REWARD
	end

	return CultivateConst.PASS_CARD_REWARD_STATE.NOT_FINISH
end

function CultivatePassCardData:onPassCardReward(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1.passcard_ids) do
		self._passCardCurrentData[var_0_0.get(iter_16_1).level].free_state = true
	end
end

function CultivatePassCardData:getBuyTimes(arg_17_1)
	local var_17_0 = self._passCardCurrentData[var_0_0.get(arg_17_1).level]

	if var_17_0 then
		return var_17_0.buy_num
	end

	return 0
end

function CultivatePassCardData:getLevel()
	return self._curLv
end

function CultivatePassCardData:getMulFreeRewards()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(self._passCardCurrentData) do
		if not iter_19_1.free_state and self._curLv >= var_0_0.get(iter_19_1.passcard_id).level then
			table.insert(var_19_0, iter_19_1.passcard_id)
		end
	end

	return var_19_0
end

function CultivatePassCardData:isCanActivePassCard()
	return self._curLv > 0
end

function CultivatePassCardData:isPassCardOpen()
	if not self._passCardCurrentData[1] then
		return false
	end

	return self._passCardCurrentData[1].free_state
end

function CultivatePassCardData:getPassCardIdByLv(arg_22_1)
	if not self._passCardCurrentData[arg_22_1] then
		return 0
	end

	return self._passCardCurrentData[arg_22_1].passcard_id
end

function CultivatePassCardData:isHasFreePassCardReward()
	return #self:getMulFreeRewards() > 0
end

return CultivatePassCardData
