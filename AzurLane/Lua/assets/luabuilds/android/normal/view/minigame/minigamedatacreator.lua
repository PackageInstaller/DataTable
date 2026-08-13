class = var_0_10000

local var_0_0 = var_0_10000("MiniGameDataCreator")

var_0_0.ShrineGameID = 3
var_0_0.FireWorkGameID = 4
var_0_0.TowerClimbingGameID = 13
var_0_0.NewYearShrineGameID = 20

function var_0_0.DataCreateFunc(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	MiniGameOPCommand = var_1_10004

	if arg_1_0 == var_1_10004.CMD_SPECIAL_GAME then
		local var_1_0 = arg_1_1[1]
		local var_1_1 = arg_1_1[2]

		getProxy = var_1_10006
		MiniGameProxy = var_1_10007

		local var_1_2 = var_1_10006(var_1_10007)
		local var_1_3 = var_6.GetMiniGameData(var_1_2, var_1_0)
		local var_1_4 = {}
		local var_1_5 = var_1_3
		local var_1_6 = var_1_3.getConfig(var_1_5, "type")

		MiniGameConst = var_1_5

		if var_1_6 == var_1_5.MG_TYPE_3 then
			if var_1_1 == 1 then
				var_1_4.count = arg_1_2[1]
				var_1_4.serverGold = arg_1_2[2]
				var_1_4.isInited = true
			elseif var_1_1 == 2 then
				var_1_4.count = var_1_3:GetRuntimeData("count") - 1
				var_1_4.serverGold = arg_1_2[1]
			elseif var_1_1 == 3 then
				var_1_4.serverGold = arg_1_2[1]
			end
		else
			local var_1_7 = var_1_3
			local var_1_8 = var_1_3.getConfig(var_1_7, "type")

			MiniGameConst = var_1_7

			if var_1_8 == var_1_7.MG_TYPE_5 then
				if var_1_1 == 1 then
					var_1_4.count = arg_1_2[1]
					var_1_4.isInited = true
				elseif var_1_1 == 2 then
					var_1_4.count = var_1_3:GetRuntimeData("count") - 1

					local var_1_9 = arg_1_1[4]
					local var_1_10 = arg_1_1[5]
					local var_1_11 = var_1_3:GetRuntimeData("kvpElements")[1]

					table = var_13

					var_13.insert(var_1_11, {
						key = var_1_9,
						value = var_1_10
					})
					var_1_3:SetRuntimeData("kvpElements", var_11)
				end
			elseif var_1_0 == var_0_0.TowerClimbingGameID and var_1_1 == 1 then
				var_1_4.isInited = true
			end
		end

		local var_1_12 = var_1_3
		local var_1_13 = var_1_3.getConfig(var_1_12, "type")

		MiniGameConst = var_1_12

		if var_1_13 ~= var_1_12.MG_TYPE_2 or var_1_1 ~= 1 then
			MiniGameConst = var_1_14

			if var_1_13 ~= var_1_14.MG_TYPE_5 or var_1_1 ~= 1 then
				MiniGameConst = var_1_14

				local var_1_14

				if var_1_13 == var_1_14.MG_TYPE_4 then
					var_1_14 = {}

					for iter_1_0 = 1, #arg_1_2 do
						var_1_14[iter_1_0] = arg_1_2[iter_1_0]
					end

					local var_1_15 = {}

					ipairs = var_12

					for iter_1_1, iter_1_2 in var_12(arg_1_3) do
						local var_1_16 = {}

						ipairs = var_1_10018

						for iter_1_3, iter_1_4 in var_1_10018(iter_1_2.value_list) do
							table = var_1_10023

							var_1_10023.insert(var_1_16, {
								key = iter_1_4.key,
								value = iter_1_4.value,
								value2 = iter_1_4.value2
							})
						end

						var_1_15[iter_1_2.key] = var_1_16
					end

					var_1_4.elements = var_1_14
					var_1_4.kvpElements = var_1_15
				end

				pairs = var_1_14

				for iter_1_5, iter_1_6 in var_1_14(var_1_4) do
					var_1_3:SetRuntimeData(iter_1_5, iter_1_6)
				end

				return
			end
		end
	end
end

return var_0_0
