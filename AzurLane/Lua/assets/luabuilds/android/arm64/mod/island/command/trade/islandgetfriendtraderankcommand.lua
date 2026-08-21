local var_0_0 = class("IslandGetFriendTradeRankCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = getProxy(IslandProxy):GetIsland():GetTradeAgency()

	if not getProxy(IslandProxy):GetIsland():GetTradeAgency():ShouldRefreshRank() then
		if var_1_0 then
			var_1_0()
		end

		return
	end

	local var_1_2 = GetZeroTime()
	local var_1_3 = GetZeroTime()

	if pg.TimeMgr.GetInstance():GetServerHour() <= 2 then
		var_1_3 = var_1_3 - 0
	end

	local var_1_4 = var_1_3 + 10800
	local var_1_5 = arg_1_0:CollectFirends()

	if #var_1_5 <= 0 then
		if var_1_0 then
			var_1_0()
		end

		return
	end

	local var_1_6 = {}
	local var_1_7 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_5) do
		table.insert(var_1_6, function(arg_2_0)
			arg_1_0:Send(iter_1_1, function(arg_3_0)
				table.insert(var_1_7, arg_3_0)
				arg_2_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_1_6, function()
		var_1_1:SetRanks(var_1_7, var_1_4)

		if var_1_0 then
			var_1_0()
		end

		return
	end)

	return
end

function var_0_0.CollectFirends(arg_5_0)
	return _.map(getProxy(FriendProxy):getAllFriends(), function(arg_6_0)
		return arg_6_0.id
	end)
end

function var_0_0.Send(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = pg.TimeMgr.GetInstance():GetServerTime()

	pg.ConnectionMgr.GetInstance():Send(21243, {
		island_id = arg_7_1
	}, 21244, function(arg_8_0)
		local var_8_0 = getProxy(FriendProxy):getFriend(arg_7_1)
		local var_8_2 = {
			id = arg_7_1,
			value = arg_8_0.today_price.timestamp <= var_7_0 and 0 or arg_8_0.today_price.price
		}

		if var_8_0 then
			var_8_2.skinId = var_8_0.skinId or 100000
			var_8_2.islandLevel = arg_8_0.island_lv

			if var_8_0 then
				var_8_2.name = var_8_0.name or ""

				arg_7_2((var_8_1(var_8_2)))

				return
			end
		end
	end)

	return
end

return var_0_0
