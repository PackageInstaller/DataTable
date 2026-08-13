class = var_0_10000

local var_0_0 = "IslandChangeDressupCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().ship_id
	local var_1_1 = var_2.unload_dress
	local var_1_2 = var_2.dress_List
	local var_1_3 = var_2.skin_id
	local var_1_4 = var_2.color_id

	pg = var_1_10008

	local var_1_5 = var_1_10008.ConnectionMgr.GetInstance()

	var_8.Send(var_1_5, 21617, {
		ship_id = var_1_0,
		dress_List = var_1_2,
		unload_dress = var_1_1,
		skin_id = var_1_3,
		color_id = var_1_4
	}, 21618, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			pg = var_2_1

			local var_2_0 = var_2_1.GameTrackerMgr.GetInstance()

			var_2_1 = var_2_1.Record
			GameTrackerBuilder = var_2_10003

			var_2_1(var_2_0, var_2_10003.BuildIslandWearDress(var_1_0, var_1_2))

			getProxy = var_2_1
			IslandProxy = var_2_0

			local var_2_2 = var_2_1(var_2_0)

			var_2_10003 = var_2_1.GetIsland(var_2_2)

			local var_2_3 = var_2_1.GetCharacterAgency(var_2_10003)

			var_2_10003 = var_2.GetShipById(var_2_3, var_1_0)

			local var_2_4

			if var_1_3 ~= var_2_10003:GetCurSkinId() then
				var_2_4 = var_1_3
			end

			var_2_10003:ChangeSkinId(var_1_3)

			local var_2_5

			if var_1_4 ~= var_2:GetSkinCurrentColor(var_2_10003:GetCurSkinId()) then
				var_2_5 = var_1_4
			end

			local var_2_6 = var_2

			var_2.SetSkinCurrentColor(var_2_6, var_1_3, var_1_4)

			local var_2_7 = {}

			ipairs = var_2_6

			for iter_2_0, iter_2_1 in var_2_6(var_1_1) do
				var_2:AddDressItem(iter_2_1, 1)
				var_2:DischargeDressOnShip(var_1_0, iter_2_1)

				table = var_12

				var_12.insert(var_2_7, iter_2_1)
			end

			local var_2_8 = {}
			local var_2_9 = {}

			ipairs = var_9

			for iter_2_2, iter_2_3 in var_9(var_1_2) do
				local var_2_10 = iter_2_3.ship_id
				local var_2_11 = iter_2_3.dress_id

				if var_2_10 == 0 then
					var_2_10017 = var_2

					var_2.ReduceDressItem(var_2_10017, var_2_11, 1)
				else
					var_2_10017 = var_2

					var_2.DischargeDressOnShip(var_2_10017, var_2_10, var_2_11)

					if not var_2_9[var_2_10] then
						var_2_9[var_2_10] = {}
					end

					table = var_16

					var_16.insert(var_2_9[var_2_10], var_2_11)
				end

				var_2_10017 = var_2

				var_2.ChargeDressOnShip(var_2_10017, var_1_0, var_2_11)

				table = var_16

				var_16.insert(var_2_8, var_2_11)
			end

			pg = var_9

			local var_2_12 = var_9.TipsMgr.GetInstance()
			local var_2_13 = var_9.ShowTips

			i18n = var_11

			var_2_13(var_2_12, var_11("island_dress_save1"))

			local var_2_14

			if var_2_5 then
				if var_2_5 ~= 0 then
					pg = var_2_12
					var_2_14 = var_2_12.island_skin_colordiff_template[var_2_5].model
				elseif var_2_4 then
					if var_2_4 ~= 0 then
						pg = var_2_12
						var_2_14 = var_2_12.island_skin_template[var_2_4].model
					else
						var_2_14 = var_2_10003:GetModelBySkinAndColorId(0, 0)
					end
				end
			elseif var_2_4 then
				if var_2_4 ~= 0 then
					pg = var_2_12
					var_2_14 = var_2_12.island_skin_template[var_2_4].model
				else
					var_2_14 = var_2_10003:GetModelBySkinAndColorId(0, 0)
				end
			end

			local var_2_15 = var_2_1
			local var_2_16 = var_2_1.DispatchEvent

			IslandCharacterAgency = var_12

			var_2_16(var_2_15, var_12.CHANGE_CHARACTER_DRESS, var_1_0, var_2_14, var_2_7, var_2_8)

			pairs = var_2_16

			for iter_2_4, iter_2_5 in var_2_16(var_2_9) do
				local var_2_17 = var_2_1
				local var_2_18 = var_2_1.DispatchEvent

				IslandCharacterAgency = var_2_10017

				var_2_18(var_2_17, var_2_10017.CHANGE_CHARACTER_DRESS, iter_2_4, nil, iter_2_5, {})
			end

			local var_2_19 = arg_1_0
			local var_2_20 = var_10.sendNotification

			GAME = var_12

			var_2_20(var_2_19, var_12.ISLAND_CHANGE_ROLE_DRESS_DONE)
		else
			pg = var_2_1

			local var_2_21 = var_2_1.TipsMgr.GetInstance()
			local var_2_22 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_22(var_2_21, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
