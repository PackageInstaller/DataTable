local ShipCalcHelper = class("ShipCalcHelper")

function ShipCalcHelper:CalcDestoryRes()
	local var_1_0 = {}
	local var_1_1 = 0
	local var_1_2 = 0
	local var_1_3 = false

	for iter_1_0, iter_1_1 in ipairs(self) do
		local var_1_4, var_1_5, var_1_6 = iter_1_1:calReturnRes()

		var_1_1 = var_1_1 + var_1_4
		var_1_2 = var_1_2 + var_1_5
		var_1_0 = table.mergeArray(var_1_0, underscore.map(var_1_6, function(arg_2_0)
			return Drop.Create(arg_2_0)
		end))
	end

	local var_1_7 = PlayerConst.MergeSameDrops(var_1_0)

	for iter_1_2 = #var_1_7, 1, -1 do
		local var_1_8 = var_1_7[iter_1_2]

		if var_1_7[iter_1_2].type == DROP_TYPE_VITEM and var_1_8:getConfig("virtual_type") == 20 then
			local var_1_9, var_1_10 = unpack(pg.gameset.urpt_chapter_max.description)
			local var_1_11 = math.min(var_1_8.count, var_1_10 - getProxy(BagProxy):GetLimitCntById(var_1_9))

			var_1_3 = var_1_11 < var_1_8.count

			if var_1_11 > 0 then
				var_1_8.count = var_1_11
			else
				table.remove(var_1_7, iter_1_2)
			end
		end
	end

	for iter_1_3, iter_1_4 in pairs(var_1_7) do
		if iter_1_4.count > 0 and iter_1_4.type == DROP_TYPE_VITEM and Item.getConfigData(iter_1_4.id).virtual_type == 20 then
			local var_1_12 = math.min(pg.gameset.urpt_chapter_max.description[2] - getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), iter_1_4.count)

			var_1_3 = var_1_12 < iter_1_4.count
			var_1_7[iter_1_3].count = var_1_12 <= 0 and 0 or var_1_12
		end
	end

	table.sort(var_1_7, CompareFuncs({
		function(arg_3_0)
			return arg_3_0.id
		end
	}))

	return var_1_1, var_1_2, var_1_7, var_1_3
end

function ShipCalcHelper:GetEliteAndHightLevelShips()
	local var_4_0 = {}
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(self) do
		if iter_4_1:getRarity() >= 4 then
			table.insert(var_4_0, iter_4_1)
		elseif iter_4_1.level > 1 then
			table.insert(var_4_1, iter_4_1)
		end
	end

	return var_4_0, var_4_1
end

function ShipCalcHelper:GetEliteAndHightLevelAndResOverflow(arg_5_1)
	local var_5_0 = _.map(self, function(arg_6_0)
		assert(arg_5_1[arg_6_0], arg_6_0)

		return arg_5_1[arg_6_0]
	end)
	local var_5_1, var_5_2 = ShipCalcHelper.GetEliteAndHightLevelShips(var_5_0)
	local var_5_3, var_5_4, var_5_5, var_5_6 = ShipCalcHelper.CalcDestoryRes(var_5_0)

	return var_5_1, var_5_2, var_5_6
end

return ShipCalcHelper
