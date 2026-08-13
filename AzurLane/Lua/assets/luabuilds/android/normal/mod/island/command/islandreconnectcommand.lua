class = var_0_10000

local var_0_0 = "IslandReconnectCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().islandId

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 21230, {
		island_id = var_1_0
	}, 21231, function(arg_2_0)
		if arg_2_0.result == 0 then
			-- block empty
		else
			_IslandCore = var_2_1

			local var_2_1

			if var_2_1 then
				_IslandCore = var_2_1

				if var_2_1:GetView().player then
					_IslandCore = var_2_1

					if var_2_1:GetView().player._tf then
						_IslandCore = var_2_1

						local var_2_0 = var_2_1

						var_2_1 = var_2_1.GetController(var_2_0).mapId
						_IslandCore = var_2_0
						var_2_10003 = var_2_0

						local var_2_2 = var_2_0.GetView(var_2_10003).player
						local var_2_3

						var_2_10003, var_2_3 = var_2.LastGroundedPosition(var_2_2)
						getProxy = var_2_10005
						IslandProxy = var_2_10006

						local var_2_4 = var_2_10005(var_2_10006)

						var_5.RecordTempPlayerPosition(var_2_4, var_2_1, var_2_10003, var_2_3)
					end
				end
			end

			_IslandCore = var_2_1

			if var_2_1 then
				pg = var_2_1

				local var_2_5 = var_2_1.NewGuideMgr.GetInstance()

				var_1.Stop(var_2_5)

				pg = var_1

				local var_2_6 = var_1.m02
				local var_2_7 = var_1.sendNotification

				GAME = var_2_10003

				var_2_7(var_2_6, var_2_10003.ISLAND_ON_RECONNECT, {
					reconnect = true,
					id = var_1_0
				})
			end
		end

		return
	end)

	return
end

return var_0_1
