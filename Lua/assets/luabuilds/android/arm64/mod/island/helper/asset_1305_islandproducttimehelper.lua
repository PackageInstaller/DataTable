local IslandProductTimeHelper = class("IslandProductTimeHelper")

function IslandProductTimeHelper:GetSpeedAddtionTypeByPlaceId()
	return switch(self, {
		[IslandProductConst.FellingPlaceId] = function()
			return IslandAblityAgency.TYPE_PRODUCT_FELLING
		end,
		[IslandProductConst.MinePlaceId] = function()
			return IslandAblityAgency.TYPE_PRODUCT_MINING
		end,
		[IslandProductConst.FarmlandPlaceId] = function()
			return IslandAblityAgency.TYPE_PRODUCT_FARM
		end,
		[IslandProductConst.OrchardPlaceId] = function()
			return IslandAblityAgency.TYPE_PRODUCT_ORCHARD
		end,
		[IslandProductConst.GardenPlaceId] = function()
			return IslandAblityAgency.TYPE_PRODUCT_GARDEN
		end,
		[IslandProductConst.FisheryPlaceId] = function()
			return IslandAblityAgency.TYPE_PRODUCT_FISH
		end
	}, function()
		return nil
	end)
end

function IslandProductTimeHelper:GetAllAddPercent(arg_9_1, arg_9_2)
	return IslandProductTimeHelper.GetAttributeAddPercent(self, arg_9_2), IslandProductTimeHelper.GetPlaceAddPercent(self, arg_9_1), IslandProductTimeHelper.GetSkillAddPercent(self, arg_9_1), (IslandProductTimeHelper.GetShipBuffPercent(self, arg_9_1))
end

function IslandProductTimeHelper:GetAttributeGradeId(arg_10_1)
	local var_10_0 = getProxy(IslandProxy)
	local var_10_1 = var_10_0:GetIsland():GetCharacterAgency():GetShipById(self)
	local var_10_2 = var_10_1.GetAttr(var_10_0, IslandShipAttr.ATTRS[arg_10_1])
	local var_10_3 = var_10_1:GetVaildStatusByType(IslandBuffType.SHIP_ATTR)

	if #var_10_3 == 0 then
		return (var_10_1:GetAttrGradeByValue(var_10_2))
	end

	local var_10_4 = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_3) do
		for iter_10_2, iter_10_3 in ipairs((iter_10_1:GetBuffEffect())) do
			if iter_10_3[1] == arg_10_1 then
				var_10_4 = var_10_4 + iter_10_3[2]
			end
		end
	end

	return (var_10_1:GetAttrGradeByValue((math.floor(var_10_2 * (1 + var_10_4 * 0.01)))))
end

function IslandProductTimeHelper:GetAttributeAddPercent(arg_11_1)
	local var_11_0 = getProxy(IslandProxy)
	local var_11_1 = var_11_0:GetIsland():GetCharacterAgency():GetShipById(self)
	local var_11_2 = var_11_1.GetAttr(var_11_0, IslandShipAttr.ATTRS[arg_11_1])
	local var_11_3 = var_11_1:GetVaildStatusByType(IslandBuffType.SHIP_ATTR)

	if #var_11_3 == 0 then
		return pg.island_chara_att[var_11_1:GetAttrGradeByValue(var_11_2)].effect
	end

	local var_11_4 = 0

	for iter_11_0, iter_11_1 in ipairs(var_11_3) do
		for iter_11_2, iter_11_3 in ipairs((iter_11_1:GetBuffEffect())) do
			if iter_11_3[1] == arg_11_1 then
				var_11_4 = var_11_4 + iter_11_3[2]
			end
		end
	end

	return pg.island_chara_att[var_11_1:GetAttrGradeByValue((math.floor(var_11_2 * (1 + var_11_4 * 0.01))))].effect
end

function IslandProductTimeHelper:GetAttributeAddPercentByAttribute(arg_12_1)
	local var_12_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(self):GetVaildStatusByType(IslandBuffType.SHIP_ATTR)

	if #var_12_0 == 0 then
		return 0
	end

	local var_12_1 = 0

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		for iter_12_2, iter_12_3 in ipairs((iter_12_1:GetBuffEffect())) do
			if iter_12_3[1] == arg_12_1 then
				var_12_1 = var_12_1 + iter_12_3[2]
			end
		end
	end

	return var_12_1
end

function IslandProductTimeHelper:GetPlaceAddPercent(arg_13_1)
	local var_13_0 = 0
	local var_13_1 = IslandProductTimeHelper.GetSpeedAddtionTypeByPlaceId(arg_13_1)

	if var_13_1 then
		var_13_0 = var_13_0 + getProxy(IslandProxy):GetIsland():GetAblityAgency():GetProductAdditionSpeedByAblityType(var_13_1)
	end

	return var_13_0
end

function IslandProductTimeHelper:GetSkillAddPercent(arg_14_1)
	local var_14_0 = getProxy(IslandProxy)
	local var_14_1 = 0

	for iter_14_0, iter_14_1 in ipairs(var_14_0:GetIsland():GetCharacterAgency():GetShipById(self).GetSkill(var_14_0):GetUnlockShipEffectIds()) do
		if pg.island_buff_template[iter_14_1].buff_type == IslandBuffType.SHIP_PRODUCT_RATIO then
			if underscore.any(pg.island_buff_template[iter_14_1].type_use[1], function(arg_15_0)
				return arg_15_0 == arg_14_1
			end) then
				var_14_1 = var_14_1 + pg.island_buff_template[iter_14_1].type_use[2]
			end
		end
	end

	return var_14_1
end

function IslandProductTimeHelper:GetShipBuffPercent(arg_16_1)
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in ipairs((getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(self):GetVaildStatusByType(IslandBuffType.SHIP_PRODUCT_RATIO))) do
		local var_16_1 = iter_16_1:GetBuffEffect()

		if underscore.any(var_16_1[1], function(arg_17_0)
			return arg_17_0 == arg_16_1
		end) then
			var_16_0 = var_16_0 + var_16_1[2]
		end
	end

	return var_16_0
end

function IslandProductTimeHelper:CalculateTimeToProductFormula(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = getProxy(IslandProxy)
	local var_18_1 = var_18_0:GetIsland()
	local var_18_2 = var_18_1:GetCharacterAgency():GetShipById(self)
	local var_18_3 = 0

	for iter_18_0, iter_18_1 in ipairs(var_18_2.GetSkill(var_18_0):GetUnlockShipEffectIds()) do
		if pg.island_buff_template[iter_18_1].buff_type == IslandBuffType.SHIP_PRODUCT_RATIO then
			if underscore.any(pg.island_buff_template[iter_18_1].type_use[1], function(arg_19_0)
				return arg_19_0 == arg_18_3
			end) then
				var_18_3 = var_18_3 + pg.island_buff_template[iter_18_1].type_use[2]
			end
		end
	end

	local var_18_4 = 0
	local var_18_5 = IslandProductTimeHelper.GetSpeedAddtionTypeByPlaceId(arg_18_3)

	if var_18_5 then
		var_18_4 = var_18_4 + var_18_1:GetAblityAgency():GetProductAdditionSpeedByAblityType(var_18_5)
	end

	local var_18_6 = var_18_2:GetAttr(IslandShipAttr.ATTRS[pg.island_formula[arg_18_1].attribute])
	local var_18_7 = var_18_2:GetAttrGradeByValue(var_18_6)
	local var_18_8 = var_18_2:GetVaildStatusByType(IslandBuffType.SHIP_ATTR)

	table.sort(var_18_8, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0:GetEndTime()
		local var_20_1 = arg_20_1:GetEndTime()

		if var_20_0 ~= var_20_1 then
			return var_20_0 < var_20_1
		end

		return arg_20_0.id < arg_20_1.id
	end)

	local var_18_9 = pg.TimeMgr.GetInstance():GetServerTime()
	local var_18_10 = {}
	local var_18_11 = var_18_9

	for iter_18_2, iter_18_3 in ipairs(var_18_8) do
		local var_18_12 = iter_18_3:GetEndTime()

		if var_18_11 ~= var_18_12 then
			var_18_11 = var_18_12

			table.insert(var_18_10, {
				timeLength = math.max(var_18_12 - var_18_11, 0),
				buffCount = #var_18_8
			})
		end
	end

	local var_18_14 = {}

	for iter_18_4, iter_18_5 in ipairs(var_18_10) do
		local var_18_15 = 0

		for iter_18_6 = #var_18_8, #var_18_8 - iter_18_5.buffCount + 1, -1 do
			for iter_18_7, iter_18_8 in ipairs((var_18_8[iter_18_6]:GetBuffEffect())) do
				if iter_18_8[1] == pg.island_formula[arg_18_1].attribute then
					var_18_15 = var_18_15 + iter_18_8[2]
				end
			end
		end

		local var_18_16 = var_18_2:GetAttrGradeByValue((math.floor(var_18_6 * (1 + var_18_15 * 0.01))))
		local var_18_18

		if var_18_16 == var_18_7 then
			do break end

			var_18_18 = {}
		end

		var_18_18.buffAddPercent = pg.island_chara_att[var_18_16].effect - pg.island_chara_att[var_18_7].effect
		var_18_18.timeLength = iter_18_5.timeLength

		table.insert(var_18_14, var_18_18)
	end

	local var_18_19 = {}
	local var_18_20 = 0

	for iter_18_9, iter_18_10 in ipairs((var_18_2:GetVaildStatusByType(IslandBuffType.SHIP_PRODUCT_RATIO))) do
		local var_18_21 = iter_18_10:GetBuffEffect()

		if underscore.any(var_18_21[1], function(arg_21_0)
			return arg_21_0 == arg_18_3
		end) then
			table.insert(var_18_19, iter_18_10)

			var_18_20 = var_18_20 + var_18_21[2]
		end
	end

	table.sort(var_18_19, function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0:GetEndTime()
		local var_22_1 = arg_22_1:GetEndTime()

		if var_22_0 ~= var_22_1 then
			return var_22_0 < var_22_1
		end

		return arg_22_0.id < arg_22_1.id
	end)

	local var_18_22 = var_18_9
	local var_18_23 = {}
	local var_18_24 = 0

	for iter_18_11, iter_18_12 in ipairs(var_18_19) do
		local var_18_25 = iter_18_12:GetEndTime()
		local var_18_26 = iter_18_12:GetBuffEffect()[2]

		if var_18_22 ~= var_18_25 then
			var_18_22 = var_18_25
			var_18_20 = var_18_20 - var_18_24

			table.insert(var_18_23, {
				buffAddPercent = var_18_20,
				timeLength = math.max(var_18_25 - var_18_22, 0)
			})
		end

		var_18_24 = var_18_24 + var_18_26
	end

	local var_18_27 = 1
	local var_18_28 = 1
	local var_18_29 = (function(arg_23_0, arg_23_1)
		local var_23_0 = {}

		if #arg_23_0 == 0 and #arg_23_1 == 0 then
			return {}
		end

		if #arg_23_0 == 0 then
			return arg_23_1
		end

		if #arg_23_1 == 0 then
			return arg_23_0
		end

		while var_18_27 <= #arg_23_0 and var_18_28 <= #arg_23_1 do
			local var_23_1 = math.min(arg_23_0[var_18_27].timeLength, arg_23_1[var_18_28].timeLength)

			table.insert(var_23_0, {
				timeLength = var_23_1,
				buffAddPercent = arg_23_0[var_18_27].buffAddPercent + arg_23_1[var_18_28].buffAddPercent
			})

			arg_23_0[var_18_27].timeLength = arg_23_0[var_18_27].timeLength - var_23_1
			arg_23_1[var_18_28].timeLength = arg_23_1[var_18_28].timeLength - var_23_1

			if arg_23_0[var_18_27].timeLength <= 0 then
				var_18_27 = var_18_27 + 1
			end

			if arg_23_1[var_18_28].timeLength <= 0 then
				var_18_28 = var_18_28 + 1
			end
		end

		return var_23_0
	end)(var_18_23, var_18_14)
	local var_18_30 = {}

	for iter_18_13 = 1, arg_18_2 do
		local var_18_31 = pg.island_formula[arg_18_1].workload
		local var_18_32 = 0

		for iter_18_14, iter_18_15 in ipairs(var_18_29) do
			local var_18_33 = math.floor(var_18_31 / (pg.island_set.base_efficiency.key_value_int * (1 + 0.01 * (pg.island_chara_att[var_18_7].effect + iter_18_15.buffAddPercent + (var_18_3 + var_18_4)))))

			if var_18_33 <= iter_18_15.timeLength then
				iter_18_15.timeLength = iter_18_15.timeLength - var_18_33
				var_18_32 = var_18_32 + var_18_33
				var_18_31 = 0

				break
			else
				var_18_32 = var_18_32 + iter_18_15.timeLength
				var_18_31 = var_18_31 - iter_18_15.timeLength * (pg.island_set.base_efficiency.key_value_int * (1 + 0.01 * (pg.island_chara_att[var_18_7].effect + iter_18_15.buffAddPercent + (var_18_3 + var_18_4))))
				iter_18_15.timeLength = 0
			end
		end

		if var_18_31 > 0 then
			var_18_32 = var_18_32 + math.floor(var_18_31 / (pg.island_set.base_efficiency.key_value_int * (1 + 0.01 * (pg.island_chara_att[var_18_7].effect + (var_18_3 + var_18_4)))))
		end

		table.insert(var_18_30, var_18_32)
	end

	return var_18_30
end

return IslandProductTimeHelper
