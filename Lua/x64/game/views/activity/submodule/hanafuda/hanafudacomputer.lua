local var_0_0 = {}
local var_0_1 = {
	COMPUTER_TURN = 2,
	STOP = 0,
	PLAYER_TURN = 1
}

function var_0_0.ComputerPlay(arg_1_0)
	if var_0_0.GetGameState() ~= var_0_1.COMPUTER_TURN then
		return
	end

	var_0_0.timer_ = Timer.New(function()
		if var_0_0.GetGameState() ~= var_0_1.COMPUTER_TURN then
			var_0_0.timer_:Stop()

			var_0_0.timer_ = nil

			if var_0_0.playTimer_ then
				var_0_0.playTimer_:Stop()

				var_0_0.playTimer_ = nil
			end
		end

		local var_2_0 = var_0_0.GetPoolCardIndex()
		local var_2_1 = var_0_0.GetMatchingCardsIndexList(var_2_0)

		if not table.isEmpty(var_2_1) then
			local var_2_2 = math.random(1, #var_2_1)

			var_0_0.ClickPlaceCard(var_2_1[var_2_2])
		else
			var_0_0.PlayCardByIndex(var_2_0)
		end
	end, 1, 1, true)
	var_0_0.playTimer_ = Timer.New(function()
		if var_0_0.GetGameState() ~= var_0_1.COMPUTER_TURN then
			var_0_0.playTimer_:Stop()

			var_0_0.playTimer_ = nil
		end

		local var_3_0 = var_0_0.GetRandomCardIndex()
		local var_3_1 = var_0_0.GetMatchingCardsIndexList(var_3_0)

		if not table.isEmpty(var_3_1) then
			local var_3_2 = math.random(1, #var_3_1)

			var_0_0.ClickPlaceCard(var_3_1[var_3_2])
		else
			var_0_0.PlayCardByIndex(var_3_0)
		end

		var_0_0.timer_:Start()
	end, 2, 1, true)

	var_0_0.playTimer_:Start()
end

function var_0_0.GetRandomCardIndex()
	local var_4_0 = HanafudaData:GetRandomCardIndex()

	manager.notify:CallUpdateFunc(CLICK_PLAYER_CARD, var_4_0)

	return var_4_0
end

function var_0_0.GetMatchingCardsIndexList(arg_5_0)
	return HanafudaData:GetMatchingCardsIndexList(arg_5_0)
end

function var_0_0.PlayCardByIndex(arg_6_0)
	manager.notify:CallUpdateFunc(PLAY_CARD_BY_INDEX, arg_6_0)
end

function var_0_0.ClickPlaceCard(arg_7_0)
	manager.notify:CallUpdateFunc(CLICK_PLACE_CARD, arg_7_0)
end

function var_0_0.GetPoolCardIndex()
	return HanafudaData:GetPoolCardIndex()
end

function var_0_0.GetGameState()
	return HanafudaData:GetGameState()
end

function var_0_0.Stop()
	if var_0_0.timer_ then
		var_0_0.timer_:Stop()

		var_0_0.timer_ = nil
	end

	if var_0_0.playTimer_ then
		var_0_0.playTimer_:Stop()

		var_0_0.playTimer_ = nil
	end
end

return var_0_0
