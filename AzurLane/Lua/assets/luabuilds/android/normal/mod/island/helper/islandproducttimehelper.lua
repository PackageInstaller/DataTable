class = var_0_10000

local var_0_0 = var_0_10000("IslandProductTimeHelper")

function var_0_0.GetSpeedAddtionTypeByPlaceId(arg_1_0)
	switch = var_1_10001

	local var_1_0 = arg_1_0
	local var_1_1 = {}

	IslandProductConst = var_1_10004
	var_1_1[var_1_10004.FellingPlaceId] = function()
		IslandAblityAgency = var_2_10000

		return var_2_10000.TYPE_PRODUCT_FELLING
	end
	IslandProductConst = var_4
	var_1_1[var_4.MinePlaceId] = function()
		IslandAblityAgency = var_2_10000

		return var_2_10000.TYPE_PRODUCT_MINING
	end
	IslandProductConst = var_4
	var_1_1[var_4.FarmlandPlaceId] = function()
		IslandAblityAgency = var_2_10000

		return var_2_10000.TYPE_PRODUCT_FARM
	end
	IslandProductConst = var_4
	var_1_1[var_4.OrchardPlaceId] = function()
		IslandAblityAgency = var_2_10000

		return var_2_10000.TYPE_PRODUCT_ORCHARD
	end
	IslandProductConst = var_4
	var_1_1[var_4.GardenPlaceId] = function()
		IslandAblityAgency = var_2_10000

		return var_2_10000.TYPE_PRODUCT_GARDEN
	end
	IslandProductConst = var_4
	var_1_1[var_4.FisheryPlaceId] = function()
		IslandAblityAgency = var_2_10000

		return var_2_10000.TYPE_PRODUCT_FISH
	end

	return var_1_10001(var_1_0, var_1_1, function()
		return nil
	end)
end

function var_0_0.GetAllAddPercent(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = var_0_0.GetAttributeAddPercent(arg_9_0, arg_9_2)
	local var_9_1 = var_0_0.GetPlaceAddPercent(arg_9_0, arg_9_1)
	local var_9_2 = var_0_0.GetSkillAddPercent(arg_9_0, arg_9_1)
	local var_9_3 = var_0_0.GetShipBuffPercent(arg_9_0, arg_9_1)

	return var_9_0, var_9_1, var_9_2, var_9_3
end

function var_0_0.GetAttributeGradeId(arg_10_0, arg_10_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_10_0 = var_1_10002(var_1_10003)
	local var_10_1 = var_2.GetIsland(var_10_0)
	local var_10_2 = var_2.GetCharacterAgency(var_10_1)
	local var_10_3 = var_3.GetShipById(var_10_2, arg_10_0)
	local var_10_4 = var_4.GetAttr

	IslandShipAttr = var_1_10007

	local var_10_5 = var_10_4(var_10_3, var_1_10007.ATTRS[arg_10_1])
	local var_10_6 = var_4:GetAttrGradeByValue(var_10_5)
	local var_10_7 = var_4
	local var_10_8 = var_4.GetVaildStatusByType

	IslandBuffType = var_1_10009

	if #var_10_8(var_10_7, var_1_10009.SHIP_ATTR) == 0 then
		return var_10_6
	end

	local var_10_9 = 0

	ipairs = var_9

	for iter_10_0, iter_10_1 in var_9(var_7) do
		local var_10_10 = iter_10_1
		local var_10_11 = iter_10_1.GetBuffEffect(var_10_10)

		ipairs = var_10_10

		for iter_10_2, iter_10_3 in var_10_10(var_10_11) do
			if iter_10_3[1] == arg_10_1 then
				var_10_9 = var_10_9 + iter_10_3[2]
			end
		end
	end

	math = var_9

	local var_10_12 = var_9.floor(var_10_5 * (1 + var_10_9 * 0.01))

	return (var_4:GetAttrGradeByValue(var_10_12))
end

function var_0_0.GetAttributeAddPercent(arg_11_0, arg_11_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_11_0 = var_1_10002(var_1_10003)
	local var_11_1 = var_2.GetIsland(var_11_0)
	local var_11_2 = var_2.GetCharacterAgency(var_11_1)
	local var_11_3 = var_3.GetShipById(var_11_2, arg_11_0)
	local var_11_4 = var_4.GetAttr

	IslandShipAttr = var_1_10007

	local var_11_5 = var_11_4(var_11_3, var_1_10007.ATTRS[arg_11_1])
	local var_11_6 = var_4
	local var_11_7 = var_4.GetAttrGradeByValue(var_11_6, var_11_5)

	pg = var_11_6

	local var_11_8 = var_11_6.island_chara_att[var_11_7].effect
	local var_11_9 = var_4
	local var_11_10 = var_4.GetVaildStatusByType

	IslandBuffType = var_1_10010

	if #var_11_10(var_11_9, var_1_10010.SHIP_ATTR) == 0 then
		return var_11_8
	end

	local var_11_11 = 0

	ipairs = var_10

	for iter_11_0, iter_11_1 in var_10(var_8) do
		local var_11_12 = iter_11_1
		local var_11_13 = iter_11_1.GetBuffEffect(var_11_12)

		ipairs = var_11_12

		for iter_11_2, iter_11_3 in var_11_12(var_11_13) do
			if iter_11_3[1] == arg_11_1 then
				var_11_11 = var_11_11 + iter_11_3[2]
			end
		end
	end

	math = var_10

	local var_11_14 = var_10.floor(var_11_5 * (1 + var_11_11 * 0.01))
	local var_11_15 = var_4
	local var_11_16 = var_4.GetAttrGradeByValue(var_11_15, var_11_14)

	pg = var_11_15

	return var_11_15.island_chara_att[var_11_16].effect
end

function var_0_0.GetAttributeAddPercentByAttribute(arg_12_0, arg_12_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_12_0 = var_1_10002(var_1_10003)
	local var_12_1 = var_2.GetIsland(var_12_0)
	local var_12_2 = var_2.GetCharacterAgency(var_12_1)
	local var_12_3 = var_3.GetShipById(var_12_2, arg_12_0)
	local var_12_4 = var_4.GetVaildStatusByType

	IslandBuffType = var_1_10007

	if #var_12_4(var_12_3, var_1_10007.SHIP_ATTR) == 0 then
		return 0
	end

	local var_12_5 = 0

	ipairs = var_7

	for iter_12_0, iter_12_1 in var_7(var_5) do
		local var_12_6 = iter_12_1
		local var_12_7 = iter_12_1.GetBuffEffect(var_12_6)

		ipairs = var_12_6

		for iter_12_2, iter_12_3 in var_12_6(var_12_7) do
			if iter_12_3[1] == arg_12_1 then
				var_12_5 = var_12_5 + iter_12_3[2]
			end
		end
	end

	return var_12_5
end

function var_0_0.GetPlaceAddPercent(arg_13_0, arg_13_1)
	local var_13_0 = 0

	getProxy = var_1_10003
	IslandProxy = var_1_10004

	local var_13_1 = var_1_10003(var_1_10004)
	local var_13_2 = var_3.GetIsland(var_13_1)

	if var_0_0.GetSpeedAddtionTypeByPlaceId(arg_13_1) then
		local var_13_3 = var_13_2:GetAblityAgency()

		var_13_0 = var_13_0 + var_5.GetProductAdditionSpeedByAblityType(var_13_3, var_4)
	end

	return var_13_0
end

function var_0_0.GetSkillAddPercent(arg_14_0, arg_14_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_14_0 = var_1_10002(var_1_10003)
	local var_14_1 = var_2.GetIsland(var_14_0)
	local var_14_2 = var_2.GetCharacterAgency(var_14_1)
	local var_14_3 = var_3.GetShipById(var_14_2, arg_14_0)
	local var_14_4 = 0

	ipairs = var_6

	local var_14_5 = var_14_3:GetSkill()

	for iter_14_0, iter_14_1 in var_6(var_7.GetUnlockShipEffectIds(var_14_5)) do
		pg = var_1_10011

		local var_14_6 = var_1_10011.island_buff_template[iter_14_1].buff_type

		IslandBuffType = var_1_10013

		if var_14_6 == var_1_10013.SHIP_PRODUCT_RATIO then
			var_1_10013 = var_1_10011.type_use[1]
			underscore = var_1_10014

			if var_1_10014.any(var_1_10013, function(arg_15_0)
				return arg_15_0 == arg_14_1
			end) then
				var_14_4 = var_14_4 + var_12[2]
			end
		end
	end

	return var_14_4
end

function var_0_0.GetShipBuffPercent(arg_16_0, arg_16_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_16_0 = var_1_10002(var_1_10003)
	local var_16_1 = var_2.GetIsland(var_16_0)
	local var_16_2 = var_2.GetCharacterAgency(var_16_1)
	local var_16_3 = var_3.GetShipById(var_16_2, arg_16_0)
	local var_16_4 = var_4.GetVaildStatusByType

	IslandBuffType = var_1_10007

	local var_16_5 = var_16_4(var_16_3, var_1_10007.SHIP_PRODUCT_RATIO)
	local var_16_6 = 0

	ipairs = var_7

	for iter_16_0, iter_16_1 in var_7(var_16_5) do
		local var_16_7 = iter_16_1:GetBuffEffect()[1]

		underscore = var_1_10014

		if var_1_10014.any(var_16_7, function(arg_17_0)
			return arg_17_0 == arg_16_1
		end) then
			var_16_6 = var_16_6 + var_12[2]
		end
	end

	return var_16_6
end

function var_0_0.CalculateTimeToProductFormula(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	getProxy = var_1_10005
	IslandProxy = var_1_10006

	local var_18_0 = var_1_10005(var_1_10006)
	local var_18_1 = var_5.GetIsland(var_18_0)
	local var_18_2 = var_5.GetCharacterAgency(var_18_1)
	local var_18_3 = var_6.GetShipById(var_18_2, arg_18_0)

	pg = var_18_2

	local var_18_4 = var_18_2.island_set.base_efficiency.key_value_int

	pg = var_9

	local var_18_5 = var_9.island_formula[arg_18_1].attribute
	local var_18_6 = 0

	ipairs = var_1_10012

	local var_18_7 = var_18_3:GetSkill()

	for iter_18_0, iter_18_1 in var_1_10012(var_13.GetUnlockShipEffectIds(var_18_7)) do
		pg = var_1_10017

		local var_18_8 = var_1_10017.island_buff_template[iter_18_1].buff_type

		IslandBuffType = var_1_10019

		if var_18_8 == var_1_10019.SHIP_PRODUCT_RATIO then
			var_1_10019 = var_1_10017.type_use[1]
			underscore = var_1_10020

			if var_1_10020.any(var_1_10019, function(arg_19_0)
				return arg_19_0 == arg_18_3
			end) then
				var_18_6 = var_18_6 + var_18[2]
			end
		end
	end

	local var_18_9 = 0

	if var_0_0.GetSpeedAddtionTypeByPlaceId(arg_18_3) then
		iter_18_1 = var_5:GetAblityAgency()
		var_18_9 = var_18_9 + var_14.GetProductAdditionSpeedByAblityType(iter_18_1, var_13)
	end

	local var_18_10 = var_18_3
	local var_18_11 = var_18_3.GetAttr

	IslandShipAttr = iter_18_1

	local var_18_12 = var_18_11(var_18_10, iter_18_1.ATTRS[var_18_5])
	local var_18_13 = var_18_3
	local var_18_14 = var_18_3.GetAttrGradeByValue(var_18_13, var_18_12)

	pg = var_18_13

	local var_18_15 = var_18_13.island_chara_att[var_18_14].effect
	local var_18_16 = var_18_6 + var_18_9
	local var_18_17 = var_18_3
	local var_18_18 = var_18_3.GetVaildStatusByType

	IslandBuffType = var_1_10020

	local var_18_19 = var_18_18(var_18_17, var_1_10020.SHIP_ATTR)

	table = var_18_17

	var_18_17.sort(var_18_19, function(arg_20_0, arg_20_1)
		if arg_20_0:GetEndTime() ~= arg_20_1:GetEndTime() then
			return var_2 < var_3
		end

		return arg_20_0.id < arg_20_1.id
	end)

	pg = var_19

	local var_18_20 = var_19.TimeMgr.GetInstance()
	local var_18_21 = var_19.GetServerTime(var_18_20)
	local var_18_22 = {}
	local var_18_23 = var_18_21
	local var_18_24 = #var_18_19

	ipairs = var_1_10023

	for iter_18_2, iter_18_3 in var_1_10023(var_18_19) do
		local var_18_25 = iter_18_3

		if var_18_23 ~= iter_18_3.GetEndTime(var_18_25) then
			math = var_18_25

			local var_18_26 = var_18_25.max(var_28 - var_18_23, 0)

			var_18_23 = var_28
			table = var_30

			var_30.insert(var_18_22, {
				timeLength = var_18_26,
				buffCount = var_18_24
			})
		end

		var_18_24 = var_18_24 - 1
	end

	local var_18_27 = {}

	ipairs = var_24

	for iter_18_4, iter_18_5 in var_24(var_18_22) do
		local var_18_28 = 0
		local var_18_29 = iter_18_5.buffCount

		for iter_18_6 = #var_18_19, var_31 - var_18_29 + 1, -1 do
			var_1_10038 = var_18_19[iter_18_6]

			local var_18_30 = var_1_10036.GetBuffEffect(var_1_10038)

			ipairs = var_1_10038

			for iter_18_7, iter_18_8 in var_1_10038(var_18_30) do
				if iter_18_8[1] == var_18_5 then
					var_18_28 = var_18_28 + iter_18_8[2]
				end
			end
		end

		math = var_32

		local var_18_31 = var_32.floor(var_18_12 * (1 + var_18_28 * 0.01))

		var_1_10034 = var_18_3

		if var_18_3.GetAttrGradeByValue(var_1_10034, var_18_31) == var_18_14 then
			break
		end

		pg = var_1_10034

		local var_18_32 = var_1_10034.island_chara_att[var_33].effect - var_18_15

		table = var_1_10036

		var_1_10036.insert(var_18_27, {
			buffAddPercent = var_18_32,
			timeLength = iter_18_5.timeLength
		})
	end

	local var_18_33 = var_18_3
	local var_18_34 = var_18_3.GetVaildStatusByType

	IslandBuffType = var_26

	local var_18_35 = var_18_34(var_18_33, var_26.SHIP_PRODUCT_RATIO)
	local var_18_36 = {}
	local var_18_37 = 0

	ipairs = iter_18_4

	for iter_18_9, iter_18_10 in iter_18_4(var_18_35) do
		local var_18_38 = iter_18_10:GetBuffEffect()[1]

		underscore = var_1_10034

		if var_1_10034.any(var_18_38, function(arg_21_0)
			return arg_21_0 == arg_18_3
		end) then
			table = var_35

			var_35.insert(var_18_36, iter_18_10)

			var_18_37 = var_18_37 + var_32[2]
		end
	end

	table = var_27

	var_27.sort(var_18_36, function(arg_22_0, arg_22_1)
		if arg_22_0:GetEndTime() ~= arg_22_1:GetEndTime() then
			return var_2 < var_3
		end

		return arg_22_0.id < arg_22_1.id
	end)

	local var_18_39 = var_18_21
	local var_18_40 = {}
	local var_18_41 = 0

	ipairs = iter_18_9

	for iter_18_11, iter_18_12 in iter_18_9(var_18_36) do
		local var_18_42 = iter_18_12:GetEndTime()
		local var_18_43 = iter_18_12:GetBuffEffect()[2]

		if var_18_39 ~= var_18_42 then
			math = var_1_10038
			var_1_10038 = var_1_10038.max(var_18_42 - var_18_39, 0)
			var_18_39 = var_18_42
			var_18_37 = var_18_37 - var_18_41
			table = var_39

			var_39.insert(var_18_40, {
				buffAddPercent = var_18_37,
				timeLength = var_1_10038
			})
		end

		var_18_41 = var_18_41 + var_18_43
	end

	local var_18_44 = 1
	local var_18_45 = 1
	local var_18_46 = (function(arg_23_0, arg_23_1)
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

		while var_18_44 <= #arg_23_0 and var_18_45 <= #arg_23_1 do
			local var_23_1 = arg_23_0[var_18_44]
			local var_23_2 = arg_23_1[var_18_45]

			math = var_2_10005
			var_2_10005 = var_2_10005.min(var_23_1.timeLength, var_23_2.timeLength)
			table = var_6

			var_6.insert(var_23_0, {
				timeLength = var_2_10005,
				buffAddPercent = var_23_1.buffAddPercent + var_23_2.buffAddPercent
			})

			var_23_1.timeLength = var_23_1.timeLength - var_2_10005
			var_23_2.timeLength = var_23_2.timeLength - var_2_10005

			if var_23_1.timeLength <= 0 then
				var_18_44 = var_18_44 + 1
			end

			if var_23_2.timeLength <= 0 then
				var_18_45 = var_18_45 + 1
			end
		end

		return var_23_0
	end)(var_18_40, var_18_27)
	local var_18_47 = {}
	local var_18_48 = var_9.workload

	for iter_18_13 = 1, arg_18_2 do
		local var_18_49 = var_18_48
		local var_18_50 = 0

		ipairs = iter_18_8

		for iter_18_14, iter_18_15 in iter_18_8(var_18_46) do
			local var_18_51 = var_18_4 * (1 + 0.01 * (var_18_15 + iter_18_15.buffAddPercent + var_18_16))

			math = var_1_10048

			if var_1_10048.floor(var_18_49 / var_18_51) <= iter_18_15.timeLength then
				iter_18_15.timeLength = iter_18_15.timeLength - var_1_10048
				var_18_50 = var_18_50 + var_1_10048
				var_18_49 = 0

				break
			else
				var_18_50 = var_18_50 + iter_18_15.timeLength
				var_18_49 = var_18_49 - iter_18_15.timeLength * var_18_51
				iter_18_15.timeLength = 0
			end
		end

		if 0 < var_18_49 then
			iter_18_8 = var_18_4 * (1 + 0.01 * (var_18_15 + var_18_16))
			math = var_43
			var_18_50 = var_18_50 + var_43.floor(var_18_49 / iter_18_8)
		end

		table = iter_18_8

		iter_18_8.insert(var_18_47, var_18_50)
	end

	return var_18_47
end

return var_0_0
