local var_0_0 = singletonClass("HanafudaData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}

var_0_0.CARD_PLACE_TYPE = {
	PLACE = 3,
	PLAYER = 1,
	PLAYERCOMBINE = 5,
	POOL = 4,
	ENEMYCOMBINE = 6,
	COLLECTION = 7,
	ENEMY = 2
}

local var_0_4 = {
	{},
	{},
	{},
	{},
	{},
	{}
}

var_0_0.GAME_STATE = {
	GAMEOVER = 4,
	DEALCARDS = 3,
	COMPUTER_TURN = 2,
	STOP = 0,
	PLAYER_TURN = 1
}

local var_0_5 = var_0_0.GAME_STATE.STOP
local var_0_6 = {}
local var_0_7 = {}
local var_0_8 = {}
local var_0_9 = 0
local var_0_10 = 0
local var_0_11 = 1
local var_0_12 = 0

function var_0_0.InitGameData(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_4 = {
		{},
		{},
		{},
		{},
		{},
		{}
	}
end

function var_0_0:InitTotalCardsList()
	self:InitGameData()

	for iter_2_0, iter_2_1 in pairs(HanafudaCardCfg) do
		if type(iter_2_0) == "number" then
			iter_2_1.rarity = KagutsuchiFishingEventData:GetRarity(iter_2_0).order

			table.insert(var_0_1, iter_2_1)
		end
	end
end

function var_0_0.GetTotoalCardsList(arg_3_0)
	return var_0_1
end

function var_0_0.InitCombineList(arg_4_0)
	var_0_8 = {}

	for iter_4_0, iter_4_1 in pairs(HanafudaCardCombineCfg) do
		if type(iter_4_0) == "number" then
			table.insert(var_0_8, iter_4_1)
		end
	end

	table.sort(var_0_8, function(arg_5_0, arg_5_1)
		return arg_5_0.id < arg_5_1.id
	end)
end

function var_0_0.GetCombineList(arg_6_0)
	return var_0_8
end

function var_0_0:InitFromServer(arg_7_1)
	self.activityID = arg_7_1.activity_id
	self.completeCardCombineList = {}
	self.rewardedCardCombineList = {}

	local var_7_0 = {}

	var_7_0.result = arg_7_1.card_result.result or 0
	var_7_0.num = arg_7_1.card_result.num or 0
	self.streakInfo = var_7_0

	for iter_7_0, iter_7_1 in ipairs(cleanProtoTable(arg_7_1.card_combine_list)) do
		table.insert(self.completeCardCombineList, iter_7_1)
	end

	for iter_7_2, iter_7_3 in ipairs(cleanProtoTable(arg_7_1.card_reward_list)) do
		table.insert(self.rewardedCardCombineList, iter_7_3)
		table.insert(self.completeCardCombineList, iter_7_3)
	end

	self:InitCombineList()
	self:InitCombineMap()
end

function var_0_0:GetActivityID()
	return self.activityID
end

function var_0_0:GetRewaredCardCombineList()
	return self.rewardedCardCombineList
end

function var_0_0:AddToRewardedCardCombineList(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		table.insert(self.rewardedCardCombineList, iter_10_1)
	end
end

function var_0_0:GetCompleteCardCombineList()
	return self.completeCardCombineList
end

function var_0_0:AddToCompleteCardCombineList(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		table.insert(self.completeCardCombineList, iter_12_1)
	end
end

function var_0_0:GetIsTasksUnRewarded()
	for iter_13_0, iter_13_1 in ipairs((self:GetCompleteCardCombineList())) do
		local var_13_0 = false

		if table.isEmpty(self.rewardedCardCombineList) then
			return true
		end

		for iter_13_2, iter_13_3 in ipairs(self.rewardedCardCombineList) do
			if iter_13_1 == iter_13_3 then
				var_13_0 = true

				break
			end
		end

		if not var_13_0 then
			return true
		end
	end

	return false
end

function var_0_0:GetIsComplete(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(self.completeCardCombineList) do
		if arg_14_1 == iter_14_1 then
			return true
		end
	end

	return false
end

function var_0_0:GetIsRewarded(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(self.rewardedCardCombineList) do
		if arg_15_1 == iter_15_1 then
			return true
		end
	end

	return false
end

function var_0_0:RewardedCardCombineListByID(arg_16_1)
	local var_16_0, var_16_1 = table.indexof(self.completeCardCombineList, arg_16_1)

	if var_16_0 then
		table.insert(self.rewardedCardCombineList, arg_16_1)
	end
end

function var_0_0:GetStreakType()
	return self.streakInfo.result
end

function var_0_0:GetStreakNum()
	return self.streakInfo.num
end

function var_0_0:UpdateStreakInfo(arg_19_1)
	local var_19_0 = self.streakInfo.result
	local var_19_1 = self.streakInfo.num

	if arg_19_1 then
		if var_19_0 == 0 then
			var_19_1 = var_19_1 + 1
		else
			var_19_0 = 1
			var_19_1 = 1
		end
	elseif var_19_0 == 0 then
		var_19_0 = 0
		var_19_1 = 1
	else
		var_19_1 = var_19_1 + 1
	end

	self.streakInfo = {
		result = var_19_0,
		num = var_19_1
	}
end

function var_0_0.SetComputerDiffculty(arg_20_0, arg_20_1)
	var_0_11 = arg_20_1
end

function var_0_0.GetComputerDiffculty(arg_21_0)
	return var_0_11
end

function var_0_0.ShuffleCardList(arg_22_0, arg_22_1)
	var_0_2 = {}

	local var_22_0 = deepClone(arg_22_1)

	while #arg_22_1 > 0 do
		local var_22_1 = table.remove(var_22_0, (math.random(#arg_22_1)))

		var_22_1.index = 1

		table.insert(var_0_2, var_22_1)
	end

	return var_0_2
end

function var_0_0.GetSuffledCardsList(arg_23_0)
	return var_0_2
end

function var_0_0.GetCardsListByType(arg_24_0, arg_24_1)
	return var_0_4[arg_24_1]
end

function var_0_0.GetMatchingCardsIndexList(arg_25_0, arg_25_1)
	local var_25_0 = {}

	if not var_0_2[arg_25_1] then
		return var_25_0
	end

	for iter_25_0, iter_25_1 in ipairs(var_0_4[3]) do
		if iter_25_1.race == var_0_2[arg_25_1].race then
			table.insert(var_25_0, iter_25_1.index)
		end
	end

	return var_25_0
end

function var_0_0.InitCombineMap(arg_26_0)
	var_0_3 = {}

	for iter_26_0, iter_26_1 in ipairs(HanafudaCardCombineCfg) do
		for iter_26_2, iter_26_3 in ipairs(iter_26_1.card_list) do
			var_0_3[iter_26_3] = var_0_3[iter_26_3] or {}

			table.insert(var_0_3[iter_26_3], iter_26_1.id)
			table.sort(var_0_3[iter_26_3], function(arg_27_0, arg_27_1)
				return HanafudaCardCombineCfg[arg_27_0].score > HanafudaCardCombineCfg[arg_27_1].score
			end)
		end
	end
end

function var_0_0.ResetGameData(arg_28_0)
	var_0_4 = {
		{},
		{},
		{},
		{},
		{},
		{}
	}
	var_0_6 = {}
	var_0_7 = {}
	var_0_9 = 0
	var_0_10 = 0
	var_0_12 = 0
end

function var_0_0:DealCards(arg_29_1)
	self:ResetGameData()

	var_0_5 = self.GAME_STATE.DEALCARDS

	local var_29_1 = {}

	for iter_29_0 = 1, 24 do
		local var_29_2 = arg_29_1[iter_29_0]

		var_29_1[arg_29_1[iter_29_0].race] = var_29_1[arg_29_1[iter_29_0].race] or 0

		if iter_29_0 <= 8 then
			var_29_2.placeType = self.CARD_PLACE_TYPE.POOL

			table.insert(var_0_4[4], var_29_2)
		elseif iter_29_0 <= 16 then
			if var_29_1[arg_29_1[iter_29_0].race] >= 2 then
				for iter_29_1 = 1, 24 do
					var_29_1[arg_29_1[iter_29_1].race] = var_29_1[arg_29_1[iter_29_1].race] or 0

					if arg_29_1[iter_29_1].placeType ~= self.CARD_PLACE_TYPE.PLACE and arg_29_1[iter_29_1].race ~= arg_29_1[iter_29_0].race and var_29_1[arg_29_1[iter_29_1].race] < 2 then
						local var_29_3 = deepClone(arg_29_1[iter_29_1])

						var_29_2.placeType = self.CARD_PLACE_TYPE.POOL
						var_29_2.index = iter_29_1
						var_29_3.placeType = self.CARD_PLACE_TYPE.PLACE
						var_29_3.index = iter_29_0
						arg_29_1[iter_29_1] = var_29_2
						arg_29_1[iter_29_0] = var_29_3
						var_29_2 = var_29_3

						break
					end
				end

				var_29_1[var_29_2.race] = var_29_1[var_29_2.race] + 1
			else
				var_29_2.placeType = self.CARD_PLACE_TYPE.PLACE
				var_29_1[arg_29_1[iter_29_0].race] = var_29_1[arg_29_1[iter_29_0].race] + 1
			end

			table.insert(var_0_4[3], var_29_2)
		elseif iter_29_0 <= 20 then
			var_29_2.placeType = self.CARD_PLACE_TYPE.ENEMY

			table.insert(var_0_4[2], var_29_2)
		elseif iter_29_0 <= 24 then
			var_29_2.placeType = self.CARD_PLACE_TYPE.PLAYER

			table.insert(var_0_4[1], var_29_2)
		end
	end

	return arg_29_1
end

function var_0_0:CheckPlayerCards(arg_30_1)
	local var_30_0 = true
	local var_30_1

	for iter_30_0, iter_30_1 in ipairs(var_0_4[arg_30_1]) do
		if not var_30_1 then
			var_30_1 = iter_30_1.race
		elseif var_30_1 ~= iter_30_1.race then
			var_30_0 = false

			break
		end

		var_30_1 = iter_30_1.race
	end

	if var_30_0 then
		var_0_5 = self.GAME_STATE.GAMEOVER

		if arg_30_1 == self.CARD_PLACE_TYPE.PLAYER then
			var_0_12 = 1
		elseif arg_30_1 == self.CARD_PLACE_TYPE.ENEMY then
			var_0_12 = -1
		end
	end
end

function var_0_0:MoveCardToList(arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = table.remove(var_0_4[arg_31_1], (function(arg_32_0, arg_32_1)
		for iter_32_0, iter_32_1 in ipairs(arg_32_0) do
			if iter_32_1.index == arg_32_1 then
				return iter_32_0
			end
		end

		return nil
	end)(var_0_4[arg_31_1], arg_31_3))

	var_31_0.placeType = arg_31_2

	table.insert(var_0_4[arg_31_2], var_31_0)
	self:RefreshScore()
end

function var_0_0.GetRandomCardIndex(arg_33_0)
	local var_33_0 = HanafudaData:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.ENEMY)

	return var_33_0[math.random(#var_33_0)].index
end

function var_0_0:GetNewCombineList(arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = {}
	local var_34_1 = {}
	local var_34_2 = {}

	if arg_34_1 == self.CARD_PLACE_TYPE.PLAYERCOMBINE then
		var_34_0 = self:GetCardsListByType(self.CARD_PLACE_TYPE.PLAYERCOMBINE)
		var_34_1 = var_0_6
	elseif arg_34_1 == self.CARD_PLACE_TYPE.ENEMYCOMBINE then
		var_34_0 = self:GetCardsListByType(self.CARD_PLACE_TYPE.ENEMYCOMBINE)
		var_34_1 = var_0_7
	end

	if not arg_34_3 then
		var_34_0 = deepClone(var_34_0)
	end

	if table.isEmpty(var_34_0) then
		return var_34_2
	end

	for iter_34_0, iter_34_1 in ipairs(arg_34_2) do
		for iter_34_2, iter_34_3 in ipairs(var_0_3[var_0_2[iter_34_1].id]) do
			local var_34_3 = true

			for iter_34_4, iter_34_5 in ipairs(HanafudaCardCombineCfg[iter_34_3].card_list) do
				local var_34_4 = true

				if iter_34_5 ~= var_0_2[iter_34_1].id then
					for iter_34_6, iter_34_7 in ipairs(var_34_0) do
						if iter_34_7.id == iter_34_5 then
							break
						end

						if iter_34_6 == #var_34_0 and iter_34_7.id ~= iter_34_5 then
							var_34_4 = false
							var_34_3 = false

							break
						end
					end
				end

				if var_34_4 == false then
					break
				end
			end

			if var_34_3 then
				table.insert(var_34_2, iter_34_3)

				if arg_34_3 then
					table.insert(var_34_1, iter_34_3)
					self:RefreshScore()
				end
			end
		end

		if not arg_34_3 then
			table.insert(var_34_0, var_0_2[iter_34_1])
		end
	end

	return var_34_2
end

function var_0_0:RefreshScore()
	local var_35_0 = 0

	for iter_35_0, iter_35_1 in ipairs(var_0_6) do
		var_35_0 = var_35_0 + HanafudaCardCombineCfg[iter_35_1].score
	end

	for iter_35_2, iter_35_3 in ipairs((self:GetCardsListByType(self.CARD_PLACE_TYPE.PLAYERCOMBINE))) do
		var_35_0 = var_35_0 + iter_35_3.rarity - 1
	end

	var_0_9 = var_35_0

	local var_35_1 = 0
	local var_35_2 = self:GetCardsListByType(self.CARD_PLACE_TYPE.ENEMYCOMBINE)

	for iter_35_4, iter_35_5 in ipairs(var_0_7) do
		var_35_1 = var_35_1 + HanafudaCardCombineCfg[iter_35_5].score
	end

	var_0_10 = var_35_1
end

function var_0_0.GetPlayerCombineIDList(arg_36_0)
	return var_0_6
end

function var_0_0.GetIsSuccess(arg_37_0)
	if var_0_12 == 1 then
		return true
	elseif var_0_12 == -1 then
		return false
	else
		return var_0_9 >= var_0_10
	end
end

function var_0_0:GetScoreByType(arg_38_1)
	if arg_38_1 == self.CARD_PLACE_TYPE.PLAYER then
		return var_0_9
	elseif self.CARD_PLACE_TYPE.ENEMY then
		return var_0_10
	end
end

function var_0_0:GetHasCardByPlaceTypeAndCardId(arg_39_1, arg_39_2)
	for iter_39_0, iter_39_1 in ipairs((self:GetCardsListByType(arg_39_1))) do
		if iter_39_1.id == arg_39_2 then
			return true
		end
	end

	return false
end

function var_0_0:StartGame(arg_40_1)
	var_0_5 = arg_40_1

	if var_0_5 == self.GAME_STATE.COMPUTER_TURN then
		HanafudaComputer.ComputerPlay()
	end
end

function var_0_0.GetGameState(arg_41_0)
	return var_0_5
end

function var_0_0:NextTurn()
	if #self:GetCardsListByType(HanafudaData.CARD_PLACE_TYPE.POOL) == 0 then
		var_0_5 = self.GAME_STATE.GAMEOVER
	elseif var_0_5 == self.GAME_STATE.COMPUTER_TURN then
		var_0_5 = self.GAME_STATE.PLAYER_TURN
	elseif var_0_5 == self.GAME_STATE.PLAYER_TURN then
		var_0_5 = self.GAME_STATE.COMPUTER_TURN

		HanafudaComputer.ComputerPlay()
	end
end

function var_0_0:ResetGameState()
	var_0_5 = self.GAME_STATE.STOP
end

function var_0_0:GetPoolCardIndex()
	local var_44_0 = self:GetCardsListByType(self.CARD_PLACE_TYPE.POOL)

	return var_44_0[#var_44_0].index
end

return var_0_0
