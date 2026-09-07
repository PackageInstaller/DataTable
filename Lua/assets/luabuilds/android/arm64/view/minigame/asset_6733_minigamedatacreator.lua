local MiniGameDataCreator = class("MiniGameDataCreator")

MiniGameDataCreator.ShrineGameID = 3
MiniGameDataCreator.FireWorkGameID = 4
MiniGameDataCreator.TowerClimbingGameID = 13
MiniGameDataCreator.NewYearShrineGameID = 20

function MiniGameDataCreator:DataCreateFunc(arg_1_1, arg_1_2, arg_1_3)
	if self == MiniGameOPCommand.CMD_SPECIAL_GAME then
		local var_1_0 = arg_1_1[2]
		local var_1_1 = getProxy(MiniGameProxy):GetMiniGameData(arg_1_1[1])
		local var_1_2 = {}

		if var_1_1:getConfig("type") == MiniGameConst.MG_TYPE_3 then
			if var_1_0 == 1 then
				var_1_2.count = arg_1_2[1]
				var_1_2.serverGold = arg_1_2[2]
				var_1_2.isInited = true
			elseif var_1_0 == 2 then
				var_1_2.count = var_1_1:GetRuntimeData("count") - 1
				var_1_2.serverGold = arg_1_2[1]
			elseif var_1_0 == 3 then
				var_1_2.serverGold = arg_1_2[1]
			end
		elseif var_1_1:getConfig("type") == MiniGameConst.MG_TYPE_5 then
			if var_1_0 == 1 then
				var_1_2.count = arg_1_2[1]
				var_1_2.isInited = true
			elseif var_1_0 == 2 then
				var_1_2.count = var_1_1:GetRuntimeData("count") - 1

				local var_1_3 = var_1_1:GetRuntimeData("kvpElements")

				table.insert(var_1_3[1], {
					key = arg_1_1[4],
					value = arg_1_1[5]
				})
				var_1_1:SetRuntimeData("kvpElements", var_1_3)
			end
		elseif arg_1_1[1] == MiniGameDataCreator.TowerClimbingGameID and var_1_0 == 1 then
			var_1_2.isInited = true
		end

		local var_1_4 = var_1_1:getConfig("type")

		if var_1_4 == MiniGameConst.MG_TYPE_2 and var_1_0 == 1 or var_1_4 == MiniGameConst.MG_TYPE_5 and var_1_0 == 1 or var_1_4 == MiniGameConst.MG_TYPE_4 then
			local var_1_5 = {}

			for iter_1_0 = 1, #arg_1_2 do
				var_1_5[iter_1_0] = arg_1_2[iter_1_0]
			end

			local var_1_6 = {}

			for iter_1_1, iter_1_2 in ipairs(arg_1_3) do
				local var_1_7 = {}

				for iter_1_3, iter_1_4 in ipairs(iter_1_2.value_list) do
					table.insert(var_1_7, {
						key = iter_1_4.key,
						value = iter_1_4.value,
						value2 = iter_1_4.value2
					})
				end

				var_1_6[iter_1_2.key] = var_1_7
			end

			var_1_2.elements = var_1_5
			var_1_2.kvpElements = var_1_6
		end

		for iter_1_5, iter_1_6 in pairs(var_1_2) do
			var_1_1:SetRuntimeData(iter_1_5, iter_1_6)
		end
	end

	return
end

return MiniGameDataCreator
