class = var_0_10000

local var_0_0 = "IslandGetFriendTradeRankCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	getProxy = var_1_10004
	IslandProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.GetIsland(var_1_1)
	local var_1_3 = var_4.GetTradeAgency(var_1_2)

	if not var_4.ShouldRefreshRank(var_1_3) then
		if var_1_0 then
			var_1_0()
		end

		return
	end

	GetZeroTime = var_5

	local var_1_4 = var_5()

	GetZeroTime = var_1_3

	local var_1_5 = var_1_3()

	pg = var_1_10007

	local var_1_6 = var_1_10007.TimeMgr.GetInstance()

	if var_7.GetServerHour(var_1_6) <= 2 then
		var_1_5 = var_1_5 - 0
	end

	local var_1_7 = var_1_5 + 10800

	if #arg_1_0:CollectFirends() <= 0 then
		if var_1_0 then
			var_1_0()
		end

		return
	end

	local var_1_8 = {}
	local var_1_9 = {}

	pairs = var_1_10012

	for iter_1_0, iter_1_1 in var_1_10012(var_9) do
		table = var_1_10017

		var_1_10017.insert(var_1_8, function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.Send(var_2_0, iter_1_1, function(arg_3_0)
				table = var_3_10001

				var_3_10001.insert(var_1_9, arg_3_0)
				arg_2_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_12

	var_12(var_1_8, function()
		local var_4_0 = var_0

		var_0.SetRanks(var_4_0, var_1_9, var_1_7)

		if var_1_0 then
			var_1_0()
		end

		return
	end)

	return
end

function var_0_1.CollectFirends(arg_5_0)
	getProxy = var_1_10001
	FriendProxy = var_1_10002

	local var_5_0 = var_1_10001(var_1_10002)
	local var_5_1 = var_1.getAllFriends(var_5_0)

	_ = var_5_0

	return var_5_0.map(var_5_1, function(arg_6_0)
		return arg_6_0.id
	end)
end

function var_0_1.Send(arg_7_0, arg_7_1, arg_7_2)
	pg = var_1_10003

	local var_7_0 = var_1_10003.TimeMgr.GetInstance()
	local var_7_1 = var_3.GetServerTime(var_7_0)

	pg = var_7_0

	local var_7_2 = var_7_0.ConnectionMgr.GetInstance()

	var_4.Send(var_7_2, 21243, {
		island_id = arg_7_1
	}, 21244, function(arg_8_0)
		local var_8_0 = arg_8_0.today_price.timestamp <= var_7_1 and 0 or arg_8_0.today_price.price

		getProxy = var_2_10003
		FriendProxy = var_2_10004

		local var_8_1 = var_2_10003(var_2_10004)
		local var_8_2 = var_3.getFriend(var_8_1, arg_7_1)

		IslandTradeRank = var_8_1

		local var_8_3 = var_8_1.New
		local var_8_4 = {
			id = arg_7_1,
			value = var_8_0
		}
		local var_8_5

		if not var_8_2 or not var_8_2.skinId then
			var_8_5 = 100000
		end

		var_8_4.skinId = var_8_5
		var_8_4.islandLevel = arg_8_0.island_lv

		local var_8_6

		if not var_8_2 or not var_8_2.name then
			var_8_6 = ""
		end

		var_8_4.name = var_8_6

		local var_8_7 = var_8_3(var_8_4)

		arg_7_2(var_8_7)

		return
	end)

	return
end

return var_0_1
