class = var_0_10000

local var_0_0 = var_0_10000("NewEducateBenefit")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.buffs = {}
	ipairs = var_3

	for iter_1_0, iter_1_1 in var_3(arg_1_1.actives) do
		local var_1_0 = arg_1_0.buffs
		local var_1_1 = iter_1_1.id

		NewEducateBuff = var_1_10010
		var_1_0[var_1_1] = var_1_10010.New(iter_1_1)
	end

	arg_1_0:InitDisplayPct(arg_1_2.benefit_display)
	arg_1_0:InitDisplayNum(arg_1_2.dollar_num_display)
	arg_1_0:InitDisplayCounter(arg_1_2.counter)

	return
end

function var_0_0.AddBuff(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.buffs
	local var_2_1 = arg_2_1.id

	NewEducateBuff = var_1_10004
	var_2_0[var_2_1] = var_1_10004.New(arg_2_1)

	return
end

function var_0_0.RemoveBuff(arg_3_0, arg_3_1)
	arg_3_0.buffs[arg_3_1] = nil

	return
end

function var_0_0.GetBuff(arg_4_0, arg_4_1)
	return arg_4_0.buffs[arg_4_1]
end

function var_0_0.GetListByType(arg_5_0, arg_5_1)
	local var_5_0 = {}

	pairs = var_1_10003

	for iter_5_0, iter_5_1 in var_1_10003(arg_5_0.buffs) do
		NewEducateBuff = var_1_10008

		if var_1_10008.IsVisible(iter_5_1.id) and iter_5_1:getConfig("type") == arg_5_1 then
			table = var_1_10008

			var_1_10008.insert(var_5_0, iter_5_1)
		end
	end

	table = var_3

	local var_5_1 = var_3.sort
	local var_5_2 = var_5_0

	CompareFuncs = iter_5_0

	var_5_1(var_5_2, iter_5_0({
		function(arg_6_0)
			return arg_6_0.round
		end,
		function(arg_7_0)
			return arg_7_0.id
		end
	}))

	return var_5_0
end

function var_0_0.GetAllBuffList(arg_8_0)
	local var_8_0 = {}

	pairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.buffs) do
		table = var_1_10007

		var_1_10007.insert(var_8_0, iter_8_1)
	end

	return var_8_0
end

function var_0_0.OnNextRound(arg_9_0, arg_9_1)
	pairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.buffs) do
		iter_9_1:OnNextRound(arg_9_1)

		if arg_9_1 == iter_9_1:GetEndRound() then
			arg_9_0.buffs[iter_9_1.id] = nil
		end
	end

	return
end

function var_0_0.ExistBuff(arg_10_0, arg_10_1)
	return arg_10_0.buffs[arg_10_1]
end

function var_0_0.GetAllIds(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {}

	pairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_0.buffs) do
		if iter_11_1:IsPending() then
			table = var_8

			var_8.insert(var_11_1, iter_11_1.id)
		else
			table = var_8

			var_8.insert(var_11_0, iter_11_1.id)
		end
	end

	return var_11_0, var_11_1
end

function var_0_0.InitDisplayPct(arg_12_0, arg_12_1)
	arg_12_0.displayPctData = {}
	ipairs = var_2

	for iter_12_0, iter_12_1 in var_2(arg_12_1) do
		if not arg_12_0.displayPctData[iter_12_1.type] then
			arg_12_0.displayPctData[iter_12_1.type] = {}
		end

		arg_12_0.displayPctData[iter_12_1.type][iter_12_1.id] = iter_12_1.number
	end

	return
end

function var_0_0.UpdateDisplayPct(arg_13_0, arg_13_1)
	ipairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(arg_13_1) do
		if not arg_13_0.displayPctData[iter_13_1.type] then
			arg_13_0.displayPctData[iter_13_1.type] = {}
		end

		arg_13_0.displayPctData[iter_13_1.type][iter_13_1.id] = iter_13_1.number
	end

	return
end

function var_0_0.GetDisplayPctData(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0.displayPctData[arg_14_1] then
		return 0
	end

	if arg_14_0.displayPctData[arg_14_1][arg_14_2] then
		calcFloor = var_3

		local var_14_0

		if not var_3(arg_14_0.displayPctData[arg_14_1][arg_14_2] / 100) then
			var_14_0 = 0
		end

		return var_14_0
	end
end

function var_0_0.GetDisplayPctList(arg_15_0)
	local var_15_0 = {}

	table = var_1_10002

	local var_15_1 = var_1_10002.insert
	local var_15_2 = var_15_0
	local var_15_3 = {}

	NewEducateConst = var_1_10006
	var_15_3.type = var_1_10006.DROP_TYPE.RES

	local var_15_4 = arg_15_0
	local var_15_5 = arg_15_0.GetResIdByType

	NewEducateChar = var_1_10009
	var_15_3.id = var_15_5(var_15_4, var_1_10009.RES_TYPE.MONEY)

	var_15_1(var_15_2, var_15_3)

	ipairs = var_15_1

	for iter_15_0, iter_15_1 in var_15_1(arg_15_0:GetAttrIds()) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_15_6 = var_15_0
		local var_15_7 = {}

		NewEducateConst = var_1_10011
		var_15_7.type = var_1_10011.DROP_TYPE.ATTR
		var_15_7.id = iter_15_1

		var_1_10007(var_15_6, var_15_7)
	end

	return var_15_0
end

function var_0_0.IsMoodBenefit(arg_16_0)
	return arg_16_0 >= 10001 and arg_16_0 <= 10100
end

function var_0_0.GetFinalPct(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0 / 16

	ipairs = var_1_10003

	for iter_17_0, iter_17_1 in var_1_10003(arg_17_1) do
		var_17_0 = var_17_0 * (iter_17_1 / 16)
	end

	return var_17_0 * 100
end

function var_0_0.GetDisplayPctByDrop(arg_18_0, arg_18_1)
	local var_18_0 = 0
	local var_18_1 = 0
	local var_18_2 = {}
	local var_18_3 = {}

	pairs = var_1_10006

	for iter_18_0, iter_18_1 in var_1_10006(arg_18_0.buffs) do
		ipairs = var_1_10011
		pg = var_1_10013

		for iter_18_2, iter_18_3 in var_1_10011(var_1_10013.child2_benefit_list[iter_18_0].content) do
			if not var_0_0.IsMoodBenefit(iter_18_3) then
				local var_18_4, var_18_5 = var_0_0.GetDisplayPctByBenefitId(iter_18_3, arg_18_1)

				var_18_0 = var_18_0 + var_18_4[1]
				table = var_18
				var_18_2 = var_18.mergeArray(var_18_2, var_18_4[2])
				var_18_1 = var_18_1 + var_18_5[1]
				table = var_18
				var_18_3 = var_18.mergeArray(var_18_3, var_18_5[2])
			end
		end
	end

	local var_18_6 = var_0_0.GetFinalPct(var_18_0, var_18_2)
	local var_18_7 = var_0_0.GetFinalPct(var_18_1, var_18_3)
end

function var_0_0.GetDisplayPctByBenefitId(arg_19_0, arg_19_1)
	local var_19_0 = 0
	local var_19_1 = 0
	local var_19_2 = {}
	local var_19_3 = {}

	pg = var_1_10006

	local var_19_4 = var_1_10006.child2_benefit[arg_19_0].trigger

	NewEducateConst = var_1_10008

	local var_19_5 = var_19_4 == var_1_10008.TRIGGER_TYPE.PERMANENT and #var_6.condition == 0

	ipairs = var_8

	for iter_19_0, iter_19_1 in var_8(var_6.effect) do
		switch = var_1_10013

		local var_19_6 = iter_19_1[1]
		local var_19_7 = {}

		NewEducateConst = var_1_10017
		var_19_7[var_1_10017.EFFECT_TYPE.ADD_PPT] = function()
			if iter_19_1[2][1] == arg_19_1.type and var_0[2] == arg_19_1.id then
				var_19_1 = var_19_1 + var_0[3]

				if var_19_5 then
					var_19_0 = var_19_0 + var_0[3]
				end
			end

			return
		end
		NewEducateConst = var_1_10017
		var_19_7[var_1_10017.EFFECT_TYPE.MULT_PPT] = function()
			if iter_19_1[2][1] == arg_19_1.type and var_0[2] == arg_19_1.id then
				table = var_1

				var_1.insert(var_19_3, var_0[3])

				if var_19_5 then
					table = var_1

					var_1.insert(var_19_2, var_0[3])
				end
			end

			return
		end

		var_1_10013(var_19_6, var_19_7)
	end

	return {
		var_19_0,
		var_19_2
	}, {
		var_19_1,
		var_19_3
	}
end

function var_0_0.InitDisplayNum(arg_22_0, arg_22_1)
	arg_22_0:UpdateDisplayNum(arg_22_1)

	return
end

function var_0_0.UpdateDisplayNum(arg_23_0, arg_23_1)
	ipairs = var_1_10002

	for iter_23_0, iter_23_1 in var_1_10002(arg_23_1) do
		if not arg_23_0.buffs[iter_23_1.buffid] then
			warning = var_7

			var_7("not exist buff: ", iter_23_1.buffid)
		else
			local var_23_0 = arg_23_0.buffs[iter_23_1.buffid]

			var_7.UpdateDisplayNum(var_23_0, iter_23_1.benefitval)
		end
	end

	return
end

function var_0_0.InitDisplayCounter(arg_24_0, arg_24_1)
	arg_24_0.displayCounterData = {}
	ipairs = var_2

	for iter_24_0, iter_24_1 in var_2(arg_24_1) do
		local var_24_0 = arg_24_0.displayCounterData
		local var_24_1 = iter_24_1.group

		NewEducateBenefitCounter = var_1_10009
		var_24_0[var_24_1] = var_1_10009.New(iter_24_1)
	end

	return
end

function var_0_0.UpdateDisplayCounter(arg_25_0, arg_25_1)
	ipairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_1) do
		local var_25_0 = arg_25_0.displayCounterData[iter_25_1.group]
		local var_25_1 = arg_25_0.displayCounterData
		local var_25_2 = iter_25_1.group

		NewEducateBenefitCounter = var_1_10010
		var_25_1[var_25_2] = var_1_10010.New(iter_25_1)
	end

	return
end

function var_0_0.GetDisplayCounterData(arg_26_0, arg_26_1)
	return arg_26_0.displayCounterData[arg_26_1]
end

function var_0_0.GetActiveEffectsByType(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = {}

	pairs = var_1_10004

	for iter_27_0, iter_27_1 in var_1_10004(arg_27_0.buffs) do
		if #iter_27_1:GetBenefitIdsByEffectType(arg_27_2) > 0 then
			ipairs = var_10

			for iter_27_2, iter_27_3 in var_10(var_9) do
				local var_27_1 = arg_27_1
				local var_27_2 = arg_27_1.IsMatchComplex

				pg = iter_27_4

				if var_27_2(var_27_1, iter_27_4.child2_benefit[iter_27_3].condition) then
					ipairs = var_15
					pg = var_27_1

					for iter_27_4, iter_27_5 in var_15(var_27_1.child2_benefit[iter_27_3].effect) do
						if iter_27_5[1] == arg_27_2 then
							table = var_20

							var_20.insert(var_27_0, iter_27_5)
						end
					end
				end
			end
		end
	end

	return var_27_0
end

function var_0_0.GetExtraPlan(arg_28_0, arg_28_1)
	local var_28_0 = {}
	local var_28_1 = arg_28_0
	local var_28_2 = arg_28_0.GetActiveEffectsByType
	local var_28_3 = arg_28_1

	NewEducateConst = var_1_10007

	local var_28_4 = var_28_2(var_28_1, var_28_3, var_1_10007.EFFECT_TYPE.EXTRA_PLAN)

	underscore = var_1_10004

	var_1_10004.each(var_28_4, function(arg_29_0)
		table = var_2_10001
		var_28_0 = var_2_10001.mergeArray(var_28_0, arg_29_0[2], true)

		return
	end)

	return var_28_0
end

function var_0_0.GetGoodsDiscountInfos(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.GetActiveEffectsByType
	local var_30_2 = arg_30_1

	NewEducateConst = var_1_10006

	local var_30_3 = var_30_1(var_30_0, var_30_2, var_1_10006.EFFECT_TYPE.REDUCE_GOODS_COST)

	return arg_30_0:GetCommonDiscountInfos(var_30_3)
end

function var_0_0.GetCommonDiscountInfos(arg_31_0, arg_31_1)
	local var_31_0 = {}

	underscore = var_1_10003

	var_1_10003.each(arg_31_1, function(arg_32_0)
		local var_32_0 = arg_32_0[2][1]
		local var_32_1 = arg_32_0[2][2]
		local var_32_2 = arg_32_0[2][3]
		local var_32_3 = arg_32_0[2][4]

		if not var_31_0[var_32_0] then
			var_31_0[var_32_0] = {}
		end

		if not var_31_0[var_32_0][var_32_1] then
			var_31_0[var_32_0][var_32_1] = {
				value = 0,
				ratio = 0
			}
		end

		if var_32_2 == 1 then
			var_31_0[var_32_0][var_32_1].value = var_31_0[var_32_0][var_32_1].value + var_32_3
		elseif var_32_2 == 2 then
			var_31_0[var_32_0][var_32_1].ratio = var_31_0[var_32_0][var_32_1].ratio + var_32_3
		end

		return
	end)

	return var_31_0
end

function var_0_0.GetActivePlanDiscountEffects(arg_33_0, arg_33_1)
	local var_33_0 = {}

	pairs = var_1_10003

	for iter_33_0, iter_33_1 in var_1_10003(arg_33_0.buffs) do
		local var_33_1 = iter_33_1
		local var_33_2 = iter_33_1.GetBenefitIdsByEffectType

		NewEducateConst = var_1_10011

		if #var_33_2(var_33_1, var_1_10011.EFFECT_TYPE.REDUCE_PLAN_COST) > 0 then
			ipairs = var_9

			for iter_33_2, iter_33_3 in var_9(var_8) do
				pg = var_1_10014
				var_1_10014 = var_1_10014.child2_benefit[iter_33_3].condition

				local var_33_3 = arg_33_1:GetConditionIdsFromComplex(var_1_10014)

				ipairs = var_1_10016

				for iter_33_4, iter_33_5 in var_1_10016(var_33_3) do
					pg = var_1_10021

					if var_1_10021.child2_condition[iter_33_5].type == 8 or var_1_10021.type == 15 then
						local var_33_4 = {}

						ipairs = var_1_10023
						pg = var_1_10025

						for iter_33_6, iter_33_7 in var_1_10023(var_1_10025.child2_benefit[iter_33_3].effect) do
							local var_33_5 = iter_33_7[1]

							NewEducateConst = var_1_10029

							if var_33_5 == var_1_10029.EFFECT_TYPE.REDUCE_PLAN_COST then
								table = var_33_5

								var_33_5.insert(var_33_4, iter_33_7)
							end
						end

						ipairs = var_1_10023

						for iter_33_8, iter_33_9 in var_1_10023(var_1_10021.param[1]) do
							if not var_33_0[iter_33_9] then
								var_33_0[iter_33_9] = {}
							end

							table = var_28
							var_33_0[iter_33_9] = var_28.mergeArray(var_33_0[iter_33_9], var_33_4)
						end
					end
				end
			end
		end
	end

	return var_33_0
end

function var_0_0.GetPlanDiscountInfos(arg_34_0, arg_34_1)
	local var_34_0 = {}
	local var_34_1 = arg_34_0:GetActivePlanDiscountEffects(arg_34_1)

	pairs = var_1_10004

	for iter_34_0, iter_34_1 in var_1_10004(var_34_1) do
		var_34_0[iter_34_0] = arg_34_0:GetCommonDiscountInfos(iter_34_1)
	end

	return var_34_0
end

return var_0_0
