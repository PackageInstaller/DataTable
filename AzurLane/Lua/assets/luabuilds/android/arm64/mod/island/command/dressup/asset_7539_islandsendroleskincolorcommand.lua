class = var_0_10000

local var_0_0 = "IslandSendRoleSkinColorCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().ship_id
	local var_1_1 = var_2.skin_id
	local var_1_2 = var_2.color_id

	getProxy = var_1_10006
	IslandProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)
	local var_1_4 = var_6.GetIsland(var_1_3)

	pg = var_1_10007

	local var_1_5 = var_1_10007.ConnectionMgr.GetInstance()

	var_7.Send(var_1_5, 21619, {
		ship_id = var_1_0,
		color_id = var_1_2
	}, 21620, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			pg = var_2_1

			local var_2_0 = var_2_1.GameTrackerMgr.GetInstance()

			var_2_1 = var_2_1.Record
			GameTrackerBuilder = var_2_10004

			var_2_1(var_2_0, var_2_10004.BuildIslandUnlockColor(var_1_0, var_1_2))

			getProxy = var_2_1
			IslandProxy = var_2_0

			local var_2_2 = var_2_1(var_2_0)

			var_2_10004 = var_2_1.GetIsland(var_2_2)

			local var_2_3 = var_2_1.GetCharacterAgency(var_2_10004)

			var_2.AddSkinColor(var_2_3, var_1_0, var_1_1, var_1_2)

			IslandTaskHelper = var_3

			local var_2_4 = var_3.UpdateRuntimeTaskByTargetType

			IslandTaskTargetType = var_2_3

			var_2_4(var_2_3.SKIN_ALL_COLOR)

			IslandTaskHelper = var_2_4

			local var_2_5 = var_2_4.UpdateRuntimeTaskByTargetType

			IslandTaskTargetType = var_5

			var_2_5(var_5.SKIN_COLOR)

			local var_2_6 = var_2_1:GetInventoryAgency()

			pg = var_2_10004

			local var_2_7 = var_2_10004.island_skin_colordiff_template[var_1_2].cost

			ipairs = var_6

			for iter_2_0, iter_2_1 in var_6(var_2_7) do
				var_2_6:RemoveItem(iter_2_1[1], iter_2_1[2])
			end

			pg = var_6

			local var_2_8 = var_6.TipsMgr.GetInstance()
			local var_2_9 = var_6.ShowTips

			i18n = iter_2_0

			var_2_9(var_2_8, iter_2_0("common_buy_success"))

			local var_2_10 = arg_1_0
			local var_2_11 = var_6.sendNotification

			GAME = var_9

			var_2_11(var_2_10, var_9.ISLAND_BUY_ROLE_SKIN_COLOR_DONE)
		else
			pg = var_2_1

			local var_2_12 = var_2_1.TipsMgr.GetInstance()
			local var_2_13 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_13(var_2_12, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
