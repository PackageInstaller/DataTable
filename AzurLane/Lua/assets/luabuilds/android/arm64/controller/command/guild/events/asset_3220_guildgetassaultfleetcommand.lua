class = var_0_10000

local var_0_0 = "GuildGetAssaultFleetCommand"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuildEventBaseCommand"))

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).callback

	getProxy = var_1_0
	GuildProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	if not var_4.ShouldRequestForamtion(var_1_2) then
		if var_1_1 then
			var_1_1()
		end

		return
	end

	pg = var_5

	local var_1_3 = var_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 61011, {
		type = 0
	}, 61012, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_1 = var_2_1.getData(var_2_0)

			local var_2_2 = {}

			ipairs = var_2_0

			local var_2_3

			if not arg_2_0.recommends then
				var_2_3 = {}
			end

			for iter_2_0, iter_2_1 in var_2_0(var_2_3) do
				if not var_2_2[iter_2_1.user_id] then
					var_2_2[iter_2_1.user_id] = {}
				end

				table = var_8

				var_8.insert(var_2_2[iter_2_1.user_id], iter_2_1.ship_id)
			end

			ipairs = var_3

			for iter_2_2, iter_2_3 in var_3(arg_2_0.ships) do
				local var_2_4 = iter_2_3.user_id

				if var_2_1:getMemberById(var_2_4) then
					GuildAssaultFleet = var_2_10010
					var_2_10010 = var_2_10010.New(iter_2_3)

					if var_2_2[var_9.id] then
						var_2_10010:SetRecommendList(var_11)
					end

					var_9:UpdateAssaultFleet(var_2_10010)
				end
			end

			local var_2_5 = var_0

			var_3.updateGuild(var_2_5, var_2_1)

			local var_2_6 = arg_1_0
			local var_2_7 = var_3.sendNotification

			GAME = var_6

			var_2_7(var_2_6, var_6.GUILD_GET_ASSAULT_FLEET_DONE)

			pg = var_2_7

			local var_2_8 = var_2_7.ShipFlagMgr.GetInstance()

			var_3.UpdateFlagShips(var_2_8, "inGuildEvent")

			if var_1_1 then
				var_1_1()
			end
		else
			pg = var_2_1

			local var_2_9 = var_2_1.TipsMgr.GetInstance()
			local var_2_10 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_10(var_2_9, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
