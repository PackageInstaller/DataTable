class = var_0_10000

local var_0_0 = "IslandCheaterTavernAgency"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseAgency"))

function var_0_1.OnInit(arg_1_0, arg_1_1)
	return
end

function var_0_1.SetIsConnecting(arg_2_0, arg_2_1)
	arg_2_0.isConnecting = arg_2_1

	return
end

function var_0_1.IsConnecting(arg_3_0)
	return arg_3_0.isConnecting
end

function var_0_1.SetUILoadOver(arg_4_0, arg_4_1)
	arg_4_0.isUILoadOver = arg_4_1

	if arg_4_1 then
		ipairs = var_1_10002

		local var_4_0

		if not arg_4_0.cacheFunc then
			var_4_0 = {}
		end

		for iter_4_0, iter_4_1 in var_1_10002(var_4_0) do
			iter_4_1()
		end
	end

	arg_4_0.cacheFunc = {}

	return
end

function var_0_1.IsUILoadOver(arg_5_0)
	return arg_5_0.isUILoadOver
end

function var_0_1.AddCacheFunc(arg_6_0, arg_6_1)
	local var_6_0

	if not arg_6_0.cacheFunc then
		var_6_0 = {}
	end

	arg_6_0.cacheFunc = var_6_0
	table = var_6_0

	var_6_0.insert(arg_6_0.cacheFunc, arg_6_1)

	return
end

function var_0_1.SetStartGameData(arg_7_0, arg_7_1)
	arg_7_0.player_dic = {}
	arg_7_0.roomType = arg_7_1.room_type
	arg_7_0.allPlayerNum = #arg_7_1.player_list
	arg_7_0.curPlayerSeat = 0
	ipairs = var_2

	for iter_7_0, iter_7_1 in var_2(arg_7_1.player_list) do
		local var_7_0 = iter_7_1.user_id

		getProxy = var_1_10008
		PlayerProxy = var_1_10009
		var_1_10009 = var_1_10008(var_1_10009)

		if var_7_0 == var_1_10008.getRawData(var_1_10009).id then
			arg_7_0.curPlayerSeat = iter_7_1.seat
		end

		local var_7_1 = arg_7_0.player_dic

		var_1_10008 = iter_7_1.user_id
		IslandCheaterPlayer = var_1_10009
		var_7_1[var_1_10008] = var_1_10009.New(iter_7_1)
	end

	arg_7_0:SetMainPlayerCards(arg_7_1.card_list)
	arg_7_0:SetRealCard(arg_7_1.real_card)

	return
end

function var_0_1.SetResetGameData(arg_8_0, arg_8_1)
	arg_8_0.player_dic = {}
	arg_8_0.roomType = arg_8_1.room_type
	arg_8_0.allPlayerNum = #arg_8_1.player_list + #arg_8_1.out_player_list
	arg_8_0.curPlayerSeat = 0
	ipairs = var_2

	for iter_8_0, iter_8_1 in var_2(arg_8_1.player_list) do
		local var_8_0 = iter_8_1.user_id

		getProxy = var_1_10008
		PlayerProxy = var_1_10009
		var_1_10009 = var_1_10008(var_1_10009)

		if var_8_0 == var_1_10008.getRawData(var_1_10009).id then
			arg_8_0.curPlayerSeat = iter_8_1.seat
		end

		local var_8_1 = arg_8_0.player_dic

		var_1_10008 = iter_8_1.user_id
		IslandCheaterPlayer = var_1_10009
		var_8_1[var_1_10008] = var_1_10009.New(iter_8_1)
	end

	ipairs = var_2

	for iter_8_2, iter_8_3 in var_2(arg_8_1.out_player_list) do
		local var_8_2 = iter_8_3.user_id

		getProxy = var_1_10008
		PlayerProxy = var_1_10009
		var_1_10009 = var_1_10008(var_1_10009)

		if var_8_2 == var_1_10008.getRawData(var_1_10009).id then
			arg_8_0.curPlayerSeat = iter_8_3.seat
		end

		iter_8_3.card_num = 0

		local var_8_3 = arg_8_0.player_dic

		var_1_10008 = iter_8_3.user_id
		IslandCheaterPlayer = var_1_10009
		var_8_3[var_1_10008] = var_1_10009.New(iter_8_3)
		var_1_10008 = arg_8_0.player_dic[iter_8_3.user_id]

		var_7.SetOutState(var_1_10008)
	end

	arg_8_0:SetMainPlayerCards(arg_8_1.card_list)
	arg_8_0:SetRealCard(arg_8_1.real_card)

	return
end

function var_0_1.GetRoomType(arg_9_0)
	return arg_9_0.roomType
end

function var_0_1.UpdateGameDataEveryRound(arg_10_0, arg_10_1)
	arg_10_0:SetMainPlayerCards(arg_10_1.card_list)
	arg_10_0:SetRealCard(arg_10_1.real_card)

	pairs = var_2

	for iter_10_0, iter_10_1 in var_2(arg_10_0.player_dic) do
		if iter_10_1.state == 0 then
			IslandCheaterTavernConst = var_7
			iter_10_1.card_num = var_7.cardNumEveryRound
		end
	end

	return
end

function var_0_1.SetMainPlayerCards(arg_11_0, arg_11_1)
	arg_11_0.cardList = {}
	ipairs = var_2

	for iter_11_0, iter_11_1 in var_2(arg_11_1) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_11_0 = arg_11_0.cardList

		IslandCheaterCard = var_1_10009

		var_1_10007(var_11_0, var_1_10009.New(iter_11_1))
	end

	return
end

function var_0_1.GetMainPlayerCards(arg_12_0)
	table = var_1_10001

	var_1_10001.sort(arg_12_0.cardList, function(arg_13_0, arg_13_1)
		return arg_13_0.key < arg_13_1.key
	end)

	return arg_12_0.cardList
end

function var_0_1.ClearMainPlayerCards(arg_14_0)
	arg_14_0.cardList = {}

	return
end

function var_0_1.MainPlayerPutCard(arg_15_0, arg_15_1)
	local var_15_0 = {}

	ipairs = var_1_10003

	for iter_15_0, iter_15_1 in var_1_10003(arg_15_1 or {}) do
		ipairs = var_1_10008

		for iter_15_2, iter_15_3 in var_1_10008(arg_15_0.cardList) do
			if iter_15_3.key == iter_15_1 then
				table = var_13

				var_13.insert(var_15_0, iter_15_2)
			end
		end
	end

	table = var_3

	var_3.sort(var_15_0, function(arg_16_0, arg_16_1)
		return arg_16_1 < arg_16_0
	end)

	ipairs = var_3

	for iter_15_4, iter_15_5 in var_3(var_15_0) do
		table = var_1_10008

		var_1_10008.remove(arg_15_0.cardList, iter_15_5)
	end

	return
end

function var_0_1.GetMainPlayerAutoPutCard(arg_17_0, arg_17_1)
	local var_17_0 = {}
	local var_17_1 = arg_17_0:GetMainPlayerCards()

	for iter_17_0 = 1, arg_17_1 do
		table = var_1_10008

		var_1_10008.insert(var_17_0, var_17_1[iter_17_0].key)
	end

	return var_17_0
end

function var_0_1.SetRealCard(arg_18_0, arg_18_1)
	arg_18_0.real_card = arg_18_1

	return
end

function var_0_1.GetRealCard(arg_19_0)
	return arg_19_0.real_card
end

function var_0_1.ReducePlayerCardNum(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_0.player_dic[arg_20_1] then
		var_3:ReduceCardNum(arg_20_2)
	end

	return
end

function var_0_1.GetPlayerCardNum(arg_21_0, arg_21_1)
	local var_21_0

	if not arg_21_0.player_dic[arg_21_1] or not var_2:GetCardNum() then
		var_21_0 = 0
	end

	return var_21_0
end

function var_0_1.UpdatePlayerBombState(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_0.player_dic[arg_22_1] then
		var_4:UpdateBombState(arg_22_2)

		if arg_22_3 == 1 then
			local var_22_0 = var_4

			var_4.SetOutState(var_22_0)

			getProxy = var_5
			PlayerProxy = var_22_0

			local var_22_1 = var_5(var_22_0)

			if arg_22_1 == var_5.getRawData(var_22_1).id then
				arg_22_0:ClearMainPlayerCards()
			end
		end
	end

	return
end

function var_0_1.UpdatePlayerDelegateState(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0.player_dic[arg_23_1] then
		var_3:UpdateDelegateState(arg_23_2)
	end

	return
end

function var_0_1.GetPlayerCurrentAndAllHp(arg_24_0, arg_24_1)
	if arg_24_0.player_dic[arg_24_1] then
		return var_2:GetCurrentAndAllHp()
	end

	return 0, 0
end

function var_0_1.GetMainPlayer(arg_25_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_25_0 = var_1_10001(var_1_10002)
	local var_25_1 = var_1.getRawData(var_25_0).id

	return arg_25_0.player_dic[var_25_1]
end

function var_0_1.GetPlayerData(arg_26_0, arg_26_1)
	return arg_26_0.player_dic[arg_26_1]
end

function var_0_1.GetPlayerList(arg_27_0)
	local var_27_0 = {}
	local var_27_1 = {}

	pairs = var_1_10003

	for iter_27_0, iter_27_1 in var_1_10003(arg_27_0.player_dic) do
		local var_27_2 = iter_27_1.seat
		local var_27_3 = iter_27_1.user_id

		getProxy = var_1_10010
		PlayerProxy = var_1_10011
		var_1_10011 = var_1_10010(var_1_10011)

		if var_27_3 ~= var_1_10010.getRawData(var_1_10011).id then
			var_27_0[(iter_27_1.seat - arg_27_0.curPlayerSeat + arg_27_0.allPlayerNum) % arg_27_0.allPlayerNum] = iter_27_1
			var_27_1[iter_27_1.user_id] = var_8
		end
	end

	return var_27_0, var_27_1
end

function var_0_1.CheckCanOnlyQurey(arg_28_0)
	pairs = var_1_10001

	for iter_28_0, iter_28_1 in var_1_10001(arg_28_0.player_dic) do
		local var_28_0 = iter_28_1.user_id

		getProxy = var_1_10007
		PlayerProxy = var_1_10008
		var_1_10008 = var_1_10007(var_1_10008)

		if var_28_0 ~= var_1_10007.getRawData(var_1_10008).id then
			var_1_10007 = iter_28_1

			if not iter_28_1.IsOut(var_1_10007) then
				var_1_10007 = iter_28_1

				if iter_28_1.GetCardNum(var_1_10007) ~= 0 then
					return false
				end
			end
		end
	end

	return true
end

function var_0_1.GetCurrentPtNum(arg_29_0)
	return 0
end

function var_0_1.CheckWinerUserId(arg_30_0)
	local var_30_0
	local var_30_1 = 0

	pairs = var_1_10003

	for iter_30_0, iter_30_1 in var_1_10003(arg_30_0.player_dic) do
		if not iter_30_1:IsOut() then
			var_30_0 = iter_30_1.user_id
			var_30_1 = var_30_1 + 1
		end
	end

	if var_30_1 == 1 then
		return var_30_0
	end

	return
end

return var_0_1
