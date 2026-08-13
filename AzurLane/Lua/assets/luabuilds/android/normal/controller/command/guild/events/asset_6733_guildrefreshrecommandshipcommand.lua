class = var_0_10000

local var_0_0 = "GuildRefreshRecommandShipCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1

	if var_0_1.TIME then
		var_1_1 = var_0_1.TIME
		pg = var_1_10005

		local var_1_2 = var_1_10005.TimeMgr.GetInstance()

		if var_1_1 > var_5.GetServerTime(var_1_2) then
			if var_1_0 then
				var_1_0()
			end

			return
		end
	end

	pg = var_1_1

	local var_1_3 = var_1_1.ConnectionMgr.GetInstance()

	var_4.Send(var_1_3, 61035, {
		type = 0
	}, 61036, function(arg_2_0)
		local var_2_0 = {}

		ipairs = var_2_10002

		local var_2_1

		if not arg_2_0.recommends then
			var_2_1 = {}
		end

		for iter_2_0, iter_2_1 in var_2_10002(var_2_1) do
			if not var_2_0[iter_2_1.user_id] then
				var_2_0[iter_2_1.user_id] = {}
			end

			table = var_7

			var_7.insert(var_2_0[iter_2_1.user_id], iter_2_1.ship_id)
		end

		getProxy = var_2
		GuildProxy = var_3

		local var_2_2 = var_2(var_3)
		local var_2_3 = var_2.getData(var_2_2)
		local var_2_4 = var_3.GetMembers(var_2_3)

		ipairs = var_2_3

		for iter_2_2, iter_2_3 in var_2_3(var_2_4) do
			local var_2_5 = var_2_0[iter_2_3.id]
			local var_2_6 = iter_2_3:GetAssaultFleet()

			var_11.ClearAllRecommandShip(var_2_6)

			if var_2_5 then
				var_11:SetRecommendList(var_2_5)
			end
		end

		var_2:updateGuild(var_3)

		local var_2_7 = arg_1_0
		local var_2_8 = var_5.sendNotification

		GAME = var_7

		var_2_8(var_2_7, var_7.REFRESH_ALL_ASSULT_SHIP_RECOMMAND_STATE_DONE)

		local var_2_9 = var_0_1

		pg = var_2_7

		local var_2_10 = var_2_7.TimeMgr.GetInstance()

		var_2_9.TIME = var_6.GetServerTime(var_2_10) + 3

		if var_1_0 then
			var_1_0()
		end

		return
	end)

	return
end

return var_0_1
