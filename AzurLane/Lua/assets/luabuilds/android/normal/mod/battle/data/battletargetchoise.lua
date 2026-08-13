ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig

ys = var_0_10001

local var_0_2 = var_0_10001.Battle.BattleAttr

ys = var_0_10002

local var_0_3 = var_0_10002.Battle.BattleFormulas
local var_0_4 = {}

ys = var_0_10004
var_0_10004.Battle.BattleTargetChoise = var_0_4

function var_0_4.TargetNil()
	return nil
end

function var_0_4.TargetNull()
	return {}
end

function var_0_4.TargetAll()
	ys = var_1_10000

	local var_3_0 = var_1_10000.Battle.BattleDataProxy.GetInstance()

	return var_0.GetUnitList(var_3_0)
end

function var_0_4.TargetEntityUnit()
	local var_4_0 = {}

	ys = var_1_10001

	local var_4_1 = var_1_10001.Battle.BattleDataProxy.GetInstance()
	local var_4_2 = var_1.GetUnitList(var_4_1)

	pairs = var_4_1

	for iter_4_0, iter_4_1 in var_4_1(var_4_2) do
		if not iter_4_1:IsSpectre() then
			var_4_0[#var_4_0 + 1] = iter_4_1
		end
	end

	return var_4_0
end

function var_0_4.TargetSpectreUnit(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {}

	ys = var_1_10004

	local var_5_1 = var_1_10004.Battle.BattleDataProxy.GetInstance()
	local var_5_2 = var_4.GetSpectreShipList(var_5_1)

	pairs = var_5_1

	for iter_5_0, iter_5_1 in var_5_1(var_5_2) do
		var_5_0[#var_5_0 + 1] = iter_5_1
	end

	return var_5_0
end

function var_0_4.TargetTemplate(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0

	if not arg_6_1.targetTemplateIDList then
		var_6_0 = {
			arg_6_1.targetTemplateID
		}
	end

	local var_6_1 = arg_6_2 or var_0_4.TargetEntityUnit()
	local var_6_2 = {}
	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.GetIFF(var_6_3)

	pairs = var_6_3

	for iter_6_0, iter_6_1 in var_6_3(var_6_1) do
		local var_6_5 = iter_6_1:GetTemplateID()
		local var_6_6 = iter_6_1
		local var_6_7 = iter_6_1.GetIFF(var_6_6)

		table = var_6_6

		if var_6_6.contains(var_6_0, var_6_5) and var_6_4 == var_6_7 then
			var_6_2[#var_6_2 + 1] = iter_6_1
		end
	end

	return var_6_2
end

function var_0_4.TargetNationality(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1.targetTemplateIDList then
		({})[1] = arg_7_1.targetTemplateID
	end

	if not arg_7_2 then
		::label_7_0::

		ys = var_1_10004

		local var_7_0 = var_1_10004.Battle.BattleDataProxy.GetInstance()

		var_1_10004 = var_1_10004.GetUnitList(var_7_0)
	end

	local var_7_1 = {}
	local var_7_2 = arg_7_1.nationality

	type = var_1_10007

	local var_7_3 = var_1_10007(var_7_2)

	pairs = var_8

	for iter_7_0, iter_7_1 in var_8(var_1_10004) do
		if var_7_3 == "number" then
			if iter_7_1:GetTemplate().nationality == var_7_2 then
				var_7_1[#var_7_1 + 1] = iter_7_1
			end
		elseif var_7_3 == "table" then
			table = var_1_10013

			if var_1_10013.contains(var_7_2, iter_7_1:GetTemplate().nationality) then
				var_7_1[#var_7_1 + 1] = iter_7_1
			end
		end
	end

	return var_7_1
end

function var_0_4.TargetShipType(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_2 or var_0_4.TargetEntityUnit()
	local var_8_1 = {}
	local var_8_2 = arg_8_1.ship_type_list

	pairs = var_1_10006

	for iter_8_0, iter_8_1 in var_1_10006(var_8_0) do
		local var_8_3 = iter_8_1
		local var_8_4 = iter_8_1.GetTemplate(var_8_3).type

		table = var_8_3

		if var_8_3.contains(var_8_2, var_8_4) then
			var_8_1[#var_8_1 + 1] = iter_8_1
		end
	end

	return var_8_1
end

function var_0_4.TargetShipTag(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2 or var_0_4.TargetEntityUnit()
	local var_9_1 = {}
	local var_9_2 = arg_9_1.ship_tag_list

	pairs = var_1_10006

	for iter_9_0, iter_9_1 in var_1_10006(var_9_0) do
		if iter_9_1:ContainsLabelTag(var_9_2) then
			var_9_1[#var_9_1 + 1] = iter_9_1
		end
	end

	return var_9_1
end

function var_0_4.TargetShipArmor(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_2 or var_0_4.TargetEntityUnit()
	local var_10_1 = {}
	local var_10_2 = arg_10_1.armor_type

	ipairs = var_1_10006

	for iter_10_0, iter_10_1 in var_1_10006(var_10_0) do
		if iter_10_1:GetAttrByName("armorType") == var_10_2 then
			var_10_1[#var_10_1 + 1] = iter_10_1
		end
	end

	return var_10_1
end

function var_0_4.getShipListByIFF(arg_11_0)
	ys = var_1_10001

	local var_11_0 = var_1_10001.Battle.BattleDataProxy.GetInstance()
	local var_11_1

	if arg_11_0 == var_0_1.FRIENDLY_CODE then
		var_11_1 = var_11_0:GetFriendlyShipList()
	elseif arg_11_0 == var_0_1.FOE_CODE then
		var_11_1 = var_11_0:GetFoeShipList()
	end

	return var_11_1
end

function var_0_4.TargetAllHelp(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}

	if arg_12_0 then
		arg_12_1 = arg_12_1 or {}

		local var_12_1 = arg_12_1.exceptCaster
		local var_12_2 = arg_12_0:GetUniqueID()
		local var_12_3 = arg_12_0:GetIFF()
		local var_12_4 = arg_12_2 or var_0_4.getShipListByIFF(var_12_3)

		pairs = var_1_10008

		for iter_12_0, iter_12_1 in var_1_10008(var_12_4) do
			local var_12_5 = iter_12_1:GetUniqueID()

			if iter_12_1:IsAlive() and iter_12_1:GetIFF() == var_12_3 and (not var_12_1 or var_12_5 ~= var_12_2) then
				var_12_0[#var_12_0 + 1] = iter_12_1
			end
		end
	end

	return var_12_0
end

function var_0_4.TargetHelpLeastHP(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1 = arg_13_1 or {}

	local var_13_0
	local var_13_1 = arg_13_1.targetMaxHPRatio

	if arg_13_0 then
		local var_13_3

		if not arg_13_2 then
			::label_13_0::

			local var_13_2 = var_0_4.getShipListByIFF

			var_1_10007 = arg_13_0
			var_13_3 = var_13_2(arg_13_0.GetIFF(var_1_10007))
		end

		local var_13_4 = 9999999999

		pairs = var_1_10007

		for iter_13_0, iter_13_1 in var_1_10007(var_13_3) do
			if iter_13_1:IsAlive() and var_13_4 > iter_13_1:GetCurrentHP() and (not var_13_1 or var_13_1 >= iter_13_1:GetHPRate()) then
				var_13_0 = iter_13_1
				var_13_4 = iter_13_1:GetCurrentHP()
			end
		end
	end

	return {
		var_13_0
	}
end

function var_0_4.TargetHelpLeastHPRatio(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1 = arg_14_1 or {}

	local var_14_0

	if arg_14_0 then
		local var_14_1 = 100
		local var_14_2 = arg_14_2 or var_0_4.getShipListByIFF(arg_14_0:GetIFF())

		pairs = var_1_10006

		for iter_14_0, iter_14_1 in var_1_10006(var_14_2) do
			if iter_14_1:IsAlive() and var_14_1 > iter_14_1:GetHPRate() then
				var_14_0 = iter_14_1
				var_14_1 = iter_14_1:GetHPRate()
			end
		end
	end

	return {
		var_14_0
	}
end

function var_0_4.TargetHighestHP(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1 = arg_15_1 or {}

	local var_15_0

	if arg_15_0 then
		local var_15_1 = arg_15_2 or var_0_4.TargetEntityUnit()
		local var_15_2 = 1

		pairs = var_1_10006

		for iter_15_0, iter_15_1 in var_1_10006(var_15_1) do
			if iter_15_1:IsAlive() and var_15_2 < iter_15_1:GetCurrentHP() then
				var_15_0 = iter_15_1
				var_15_2 = iter_15_1:GetCurrentHP()
			end
		end
	end

	return {
		var_15_0
	}
end

function var_0_4.TargetLowestHPRatio(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1 = arg_16_1 or {}

	local var_16_0
	local var_16_1 = arg_16_2 or var_0_4.TargetEntityUnit()
	local var_16_2 = 1

	pairs = var_1_10006

	for iter_16_0, iter_16_1 in var_1_10006(var_16_1) do
		local var_16_3 = iter_16_1:GetHPRate()

		if iter_16_1:IsAlive() and var_16_3 < var_16_2 and var_16_3 > 0 then
			var_16_0 = iter_16_1
			var_16_2 = var_16_3
		end
	end

	return {
		var_16_0
	}
end

function var_0_4.TargetLowestHP(arg_17_0, arg_17_1, arg_17_2)
	arg_17_1 = arg_17_1 or {}

	local var_17_0
	local var_17_1 = arg_17_2 or var_0_4.TargetEntityUnit()
	local var_17_2 = 9999999999

	pairs = var_1_10006

	for iter_17_0, iter_17_1 in var_1_10006(var_17_1) do
		local var_17_3 = iter_17_1:GetCurrentHP()

		if iter_17_1:IsAlive() and var_17_3 < var_17_2 and var_17_3 > 0 then
			var_17_0 = iter_17_1
			var_17_2 = var_17_3
		end
	end

	return {
		var_17_0
	}
end

function var_0_4.TargetHighestHPRatio(arg_18_0, arg_18_1, arg_18_2)
	arg_18_1 = arg_18_1 or {}

	local var_18_0
	local var_18_1 = arg_18_2 or var_0_4.TargetEntityUnit()
	local var_18_2 = 0

	pairs = var_1_10006

	for iter_18_0, iter_18_1 in var_1_10006(var_18_1) do
		if iter_18_1:IsAlive() and var_18_2 < iter_18_1:GetHPRate() then
			var_18_0 = iter_18_1
			var_18_2 = iter_18_1:GetHPRate()
		end
	end

	return {
		var_18_0
	}
end

function var_0_4.TargetAttrCompare(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = {}
	local var_19_1 = arg_19_2 or var_0_4.TargetEntityUnit()

	pairs = var_1_10005

	for iter_19_0, iter_19_1 in var_1_10005(var_19_1) do
		if iter_19_1:IsAlive() and var_0_3.parseCompareUnitAttr(arg_19_1.attrCompare, iter_19_1, arg_19_0) then
			table = var_10

			var_10.insert(var_19_0, iter_19_1)
		end
	end

	return var_19_0
end

function var_0_4.TargetAttrCeil(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2 or var_0_4.TargetEntityUnit()
	local var_20_1 = arg_20_1.ceilAttr
	local var_20_2 = 0
	local var_20_3

	ipairs = var_1_10007

	for iter_20_0, iter_20_1 in var_1_10007(var_20_0) do
		if var_20_2 <= iter_20_1:GetAttrByName(var_20_1) then
			var_20_2 = var_12
			var_20_3 = iter_20_1
		end
	end

	return {
		var_20_3
	}
end

function var_0_4.TargetAttrFloor(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_2 or var_0_4.TargetEntityUnit()
	local var_21_1 = arg_21_1.floorAttr

	Mathf = var_1_10005

	local var_21_2 = var_1_10005.Infinity
	local var_21_3

	ipairs = var_1_10007

	for iter_21_0, iter_21_1 in var_1_10007(var_21_0) do
		if iter_21_1:GetAttrByName(var_21_1) <= var_21_2 then
			var_21_2 = var_12
			var_21_3 = iter_21_1
		end
	end

	return {
		var_21_3
	}
end

function var_0_4.TargetTempCompare(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = {}
	local var_22_1 = arg_22_2 or var_0_4.TargetEntityUnit()

	pairs = var_1_10005

	for iter_22_0, iter_22_1 in var_1_10005(var_22_1) do
		if iter_22_1:IsAlive() and var_0_3.parseCompareUnitTemplate(arg_22_1.tempCompare, iter_22_1, arg_22_0) then
			table = var_10

			var_10.insert(var_22_0, iter_22_1)
		end
	end

	return var_22_0
end

function var_0_4.TargetHPCompare(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = {}
	local var_23_1 = arg_23_2 or var_0_4.TargetEntityUnit()

	if arg_23_0 then
		local var_23_2 = arg_23_0
		local var_23_3 = arg_23_0.GetHP(var_23_2)

		ipairs = var_23_2

		for iter_23_0, iter_23_1 in var_23_2(var_23_1) do
			if var_23_3 > iter_23_1:GetHP() then
				var_23_0[#var_23_0 + 1] = iter_23_1
			end
		end
	end

	return var_23_0
end

function var_0_4.TargetHPRatioLowerThan(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = {}
	local var_24_1 = arg_24_1.hpRatioList[1]
	local var_24_2 = arg_24_2 or var_0_4.TargetEntityUnit()

	ipairs = var_1_10006

	for iter_24_0, iter_24_1 in var_1_10006(var_24_2) do
		if var_24_1 > iter_24_1:GetHP() then
			var_24_0[#var_24_0 + 1] = iter_24_1
		end
	end

	return var_24_0
end

function var_0_4.TargetNationalityFriendly(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = {}

	if arg_25_0 then
		local var_25_1 = arg_25_1.nationality
		local var_25_2 = arg_25_2 or var_0_4.TargetAllHelp(arg_25_0, arg_25_1)

		pairs = var_1_10006

		for iter_25_0, iter_25_1 in var_1_10006(var_25_2) do
			if iter_25_1:GetTemplate().nationality == var_25_1 then
				var_25_0[#var_25_0 + 1] = iter_25_1
			end
		end
	end

	return var_25_0
end

function var_0_4.TargetNationalityFoe(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = {}

	if arg_26_0 then
		local var_26_1 = arg_26_1.nationality
		local var_26_2 = arg_26_2 or var_0_4.TargetAllHarm(arg_26_0, arg_26_1)

		pairs = var_1_10006

		for iter_26_0, iter_26_1 in var_1_10006(var_26_2) do
			if iter_26_1:GetTemplate().nationality == var_26_1 then
				var_26_0[#var_26_0 + 1] = iter_26_1
			end
		end
	end

	return var_26_0
end

function var_0_4.TargetShipTypeFriendly(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = {}

	if arg_27_0 then
		local var_27_1 = arg_27_1.ship_type_list
		local var_27_2 = arg_27_2 or var_0_4.TargetAllHelp(arg_27_0, arg_27_1)

		pairs = var_1_10006

		for iter_27_0, iter_27_1 in var_1_10006(var_27_2) do
			local var_27_3 = iter_27_1
			local var_27_4 = iter_27_1.GetTemplate(var_27_3).type

			table = var_27_3

			if var_27_3.contains(var_27_1, var_27_4) then
				var_27_0[#var_27_0 + 1] = iter_27_1
			end
		end
	end

	return var_27_0
end

function var_0_4.TargetSelf(arg_28_0)
	return {
		arg_28_0
	}
end

function var_0_4.TargetAllHarm(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = {}
	local var_29_1
	local var_29_2 = arg_29_0
	local var_29_3 = arg_29_0.GetIFF(var_29_2)

	ys = var_29_2

	local var_29_4 = var_29_2.Battle.BattleDataProxy.GetInstance()

	if arg_29_2 then
		var_29_1 = {}
		ipairs = var_1_10007

		for iter_29_0, iter_29_1 in var_1_10007(arg_29_2) do
			if iter_29_1:GetIFF() * var_29_3 == -1 then
				table = var_12

				var_12.insert(var_29_1, iter_29_1)
			end
		end
	elseif var_29_3 == var_0_1.FRIENDLY_CODE then
		var_29_1 = var_29_4:GetFoeShipList()
	elseif var_29_3 == var_0_1.FOE_CODE then
		var_29_1 = var_29_4:GetFriendlyShipList()
	end

	local var_29_5, var_29_6, var_29_7, var_29_8 = var_29_4:GetFieldBound()

	if var_29_1 then
		pairs = iter_29_1

		for iter_29_2, iter_29_3 in iter_29_1(var_29_1) do
			if iter_29_3:IsAlive() and var_29_8 > iter_29_3:GetPosition().x then
				local var_29_9 = iter_29_3
				local var_29_10 = iter_29_3.GetCurrentOxyState(var_29_9)

				ys = var_29_9

				if var_29_10 ~= var_29_9.Battle.BattleConst.OXY_STATE.DIVE then
					var_29_0[#var_29_0 + 1] = iter_29_3
				end
			end
		end
	end

	return var_29_0
end

function var_0_4.TargetAllFoe(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = {}
	local var_30_1
	local var_30_2 = arg_30_0
	local var_30_3 = arg_30_0.GetIFF(var_30_2)

	ys = var_30_2

	local var_30_4 = var_30_2.Battle.BattleDataProxy.GetInstance()

	if arg_30_2 then
		var_30_1 = {}
		ipairs = var_1_10007

		for iter_30_0, iter_30_1 in var_1_10007(arg_30_2) do
			if iter_30_1:GetIFF() * var_30_3 == -1 then
				table = var_12

				var_12.insert(var_30_1, iter_30_1)
			end
		end
	elseif var_30_3 == var_0_1.FRIENDLY_CODE then
		var_30_1 = var_30_4:GetFoeShipList()
	elseif var_30_3 == var_0_1.FOE_CODE then
		var_30_1 = var_30_4:GetFriendlyShipList()
	end

	local var_30_5, var_30_6, var_30_7, var_30_8 = var_30_4:GetFieldBound()

	if var_30_1 then
		pairs = iter_30_1

		for iter_30_2, iter_30_3 in iter_30_1(var_30_1) do
			if iter_30_3:IsAlive() and var_30_8 > iter_30_3:GetPosition().x then
				var_30_0[#var_30_0 + 1] = iter_30_3
			end
		end
	end

	return var_30_0
end

function var_0_4.TargetFoeUncloak(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = {}
	local var_31_1
	local var_31_2 = arg_31_0
	local var_31_3 = arg_31_0.GetIFF(var_31_2)

	ys = var_31_2

	local var_31_4 = var_31_2.Battle.BattleDataProxy.GetInstance()

	if arg_31_2 then
		var_31_1 = {}
		ipairs = var_1_10007

		for iter_31_0, iter_31_1 in var_1_10007(arg_31_2) do
			if iter_31_1:GetIFF() * var_31_3 == -1 then
				table = var_12

				var_12.insert(var_31_1, iter_31_1)
			end
		end
	elseif var_31_3 == var_0_1.FRIENDLY_CODE then
		var_31_1 = var_31_4:GetFoeShipList()
	elseif var_31_3 == var_0_1.FOE_CODE then
		var_31_1 = var_31_4:GetFriendlyShipList()
	end

	local var_31_5, var_31_6, var_31_7, var_31_8 = var_31_4:GetFieldBound()

	if var_31_1 then
		pairs = iter_31_1

		for iter_31_2, iter_31_3 in iter_31_1(var_31_1) do
			if iter_31_3:IsAlive() and var_31_8 > iter_31_3:GetPosition().x and not var_0_2.IsCloak(iter_31_3) then
				local var_31_9 = iter_31_3
				local var_31_10 = iter_31_3.GetCurrentOxyState(var_31_9)

				ys = var_31_9

				if var_31_10 ~= var_31_9.Battle.BattleConst.OXY_STATE.DIVE then
					var_31_0[#var_31_0 + 1] = iter_31_3
				end
			end
		end
	end

	return var_31_0
end

function var_0_4.TargetCloakState(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = {}
	local var_32_1

	if not arg_32_1.cloak then
		var_32_1 = 1
	end

	local var_32_2 = arg_32_2 or var_0_4.TargetEntityUnit()

	ipairs = var_1_10006

	for iter_32_0, iter_32_1 in var_1_10006(var_32_2) do
		if var_0_2.GetCurrent(iter_32_1, "isCloak") == var_32_1 then
			var_32_0[#var_32_0 + 1] = iter_32_1
		end
	end

	return var_32_0
end

function var_0_4.TargetFaintState(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = {}
	local var_33_1

	if not arg_33_1.faint then
		var_33_1 = 1
	end

	local var_33_2 = arg_33_2 or var_0_4.TargetEntityUnit()

	ipairs = var_1_10006

	for iter_33_0, iter_33_1 in var_1_10006(var_33_2) do
		local var_33_3 = iter_33_1:GetAimBias()

		if var_33_1 == 1 then
			if var_33_3 and var_33_3:IsFaint() then
				var_33_0[#var_33_0 + 1] = iter_33_1
			end
		elseif var_33_1 == 0 and (not var_33_3 or not var_33_3:IsFaint()) then
			var_33_0[#var_33_0 + 1] = iter_33_1
		end
	end

	return var_33_0
end

function var_0_4.TargetNearest(arg_34_0, arg_34_1, arg_34_2)
	arg_34_1 = arg_34_1 or {}

	local var_34_0

	if not arg_34_1.range then
		var_34_0 = 9999999999
	end

	local var_34_1
	local var_34_2 = arg_34_2

	ipairs = var_1_10006

	for iter_34_0, iter_34_1 in var_1_10006(var_34_2) do
		if arg_34_0:GetDistance(iter_34_1) < var_34_0 then
			var_34_0 = var_11
			var_34_1 = iter_34_1
		end
	end

	return {
		var_34_1
	}
end

function var_0_4.TargetHarmNearest(arg_35_0, arg_35_1, arg_35_2)
	arg_35_1 = arg_35_1 or {}

	local var_35_0

	if not arg_35_1.range then
		var_35_0 = 9999999999
	end

	local var_35_1
	local var_35_2

	if not arg_35_2 or not var_0_4.TargetFoeUncloak(arg_35_0, arg_35_1, arg_35_2) then
		var_35_2 = var_0_4.TargetFoeUncloak(arg_35_0)
	end

	ipairs = var_1_10006

	for iter_35_0, iter_35_1 in var_1_10006(var_35_2) do
		if arg_35_0:GetDistance(iter_35_1) < var_35_0 then
			var_35_0 = var_11
			var_35_1 = iter_35_1
		end
	end

	return {
		var_35_1
	}
end

function var_0_4.TargetHarmFarthest(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = 0
	local var_36_1

	arg_36_1 = arg_36_1 or {}

	local var_36_2

	if not arg_36_2 or not var_0_4.TargetFoeUncloak(arg_36_0, arg_36_1, arg_36_2) then
		var_36_2 = var_0_4.TargetFoeUncloak(arg_36_0)
	end

	ipairs = var_1_10006

	for iter_36_0, iter_36_1 in var_1_10006(var_36_2) do
		if var_36_0 < arg_36_0:GetDistance(iter_36_1) then
			var_36_0 = var_11
			var_36_1 = iter_36_1
		end
	end

	return {
		var_36_1
	}
end

function var_0_4.TargetHarmRandom(arg_37_0, arg_37_1, arg_37_2)
	arg_37_1 = arg_37_1 or {}

	local var_37_0

	if not arg_37_2 or not var_0_4.TargetFoeUncloak(arg_37_0, arg_37_1, arg_37_2) then
		var_37_0 = var_0_4.TargetFoeUncloak(arg_37_0)
	end

	if #var_37_0 > 0 then
		math = var_5

		local var_37_1 = var_5.random(#var_4)

		return {
			var_4[var_37_1]
		}
	else
		return {}
	end

	return
end

function var_0_4.TargetHarmRandomByWeight(arg_38_0, arg_38_1, arg_38_2)
	arg_38_1 = arg_38_1 or {}

	local var_38_0

	if not arg_38_2 or not var_0_4.TargetFoeUncloak(arg_38_0, arg_38_1, arg_38_2) then
		var_38_0 = var_0_4.TargetFoeUncloak(arg_38_0)
	end

	local var_38_1 = {}
	local var_38_2 = -9999

	ipairs = var_1_10006

	for iter_38_0, iter_38_1 in var_1_10006(var_38_0) do
		local var_38_3

		if not iter_38_1:GetTargetedPriority() then
			var_38_3 = 0
		end

		if var_38_3 == var_38_2 then
			var_38_1[#var_38_1 + 1] = iter_38_1
		elseif var_38_2 < var_38_3 then
			var_38_1 = {
				iter_38_1
			}
			var_38_2 = var_38_3
		end
	end

	if #var_38_1 > 0 then
		math = var_6

		local var_38_4 = var_6.random(#var_38_1)

		return {
			var_38_1[var_38_4]
		}
	else
		return {}
	end

	return
end

function var_0_4.TargetWeightiest(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_2 or var_0_4.TargetEntityUnit()
	local var_39_1 = {}
	local var_39_2 = -9999

	ipairs = var_1_10006

	for iter_39_0, iter_39_1 in var_1_10006(var_39_0) do
		local var_39_3

		if not iter_39_1:GetTargetedPriority() then
			var_39_3 = 0
		end

		if var_39_3 == var_39_2 then
			var_39_1[#var_39_1 + 1] = iter_39_1
		elseif var_39_2 < var_39_3 then
			var_39_1 = {
				iter_39_1
			}
			var_39_2 = var_39_3
		end
	end

	return var_39_1
end

function var_0_4.TargetRandom(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_2 or var_0_4.TargetEntityUnit()
	local var_40_1

	if not arg_40_1.randomCount then
		var_40_1 = 1
	end

	Mathf = var_1_10005

	return (var_1_10005.MultiRandom(var_40_0, var_40_1))
end

function var_0_4.TargetInsideArea(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_2 or var_0_4.TargetAllHarm(arg_41_0)
	local var_41_1

	if not arg_41_1.dir then
		ys = var_41_1
		var_41_1 = var_41_1.Battle.BattleConst.UnitDir.RIGHT
	end

	local var_41_2 = arg_41_1.lineX
	local var_41_3 = {}

	ys = var_1_10007

	if var_41_1 == var_1_10007.Battle.BattleConst.UnitDir.RIGHT then
		ipairs = var_7

		for iter_41_0, iter_41_1 in var_7(var_41_0) do
			local var_41_4 = iter_41_1

			if var_41_2 <= iter_41_1.GetPosition(var_41_4).x then
				table = var_41_4

				var_41_4.insert(var_41_3, iter_41_1)
			end
		end
	else
		ys = var_7

		if var_41_1 == var_7.Battle.BattleConst.UnitDir.LEFT then
			ipairs = var_7

			for iter_41_2, iter_41_3 in var_7(var_41_0) do
				local var_41_5 = iter_41_3

				if var_41_2 >= iter_41_3.GetPosition(var_41_5).x then
					table = var_41_5

					var_41_5.insert(var_41_3, iter_41_3)
				end
			end
		end
	end

	return var_41_3
end

function var_0_4.TargetAircraftHelp(arg_42_0)
	ys = var_1_10001

	local var_42_0 = var_1_10001.Battle.BattleDataProxy.GetInstance()
	local var_42_1 = {}
	local var_42_2 = arg_42_0
	local var_42_3 = arg_42_0.GetIFF(var_42_2)

	pairs = var_42_2

	for iter_42_0, iter_42_1 in var_42_2(var_42_0:GetAircraftList()) do
		if var_42_3 == iter_42_1:GetIFF() then
			var_42_1[#var_42_1 + 1] = iter_42_1
		end
	end

	return var_42_1
end

function var_0_4.TargetAircraftHarm(arg_43_0)
	ys = var_1_10001

	local var_43_0 = var_1_10001.Battle.BattleDataProxy.GetInstance()
	local var_43_1 = {}
	local var_43_2 = arg_43_0
	local var_43_3 = arg_43_0.GetIFF(var_43_2)

	pairs = var_43_2

	for iter_43_0, iter_43_1 in var_43_2(var_43_0:GetAircraftList()) do
		if var_43_3 ~= iter_43_1:GetIFF() and iter_43_1:IsVisitable() then
			var_43_1[#var_43_1 + 1] = iter_43_1
		end
	end

	return var_43_1
end

function var_0_4.TargetAircraftGB(arg_44_0)
	ys = var_1_10001

	local var_44_0 = var_1_10001.Battle.BattleDataProxy.GetInstance()
	local var_44_1 = {}
	local var_44_2 = arg_44_0
	local var_44_3 = arg_44_0.GetIFF(var_44_2)

	pairs = var_44_2

	for iter_44_0, iter_44_1 in var_44_2(var_44_0:GetAircraftList()) do
		if var_44_3 ~= iter_44_1:GetIFF() and iter_44_1:IsVisitable() and iter_44_1:GetMotherUnit() == nil then
			var_44_1[#var_44_1 + 1] = iter_44_1
		end
	end

	return var_44_1
end

function var_0_4.TargetDiveState(arg_45_0, arg_45_1, arg_45_2)
	if not arg_45_1 or not arg_45_1.diveState then
		ys = var_1_10003
		var_1_10003 = var_1_10003.Battle.BattleConst.OXY_STATE.DIVE
	end

	local var_45_0 = arg_45_2 or var_0_4.TargetEntityUnit()
	local var_45_1 = {}

	pairs = var_1_10006

	for iter_45_0, iter_45_1 in var_1_10006(var_45_0) do
		if var_1_10003 == iter_45_1:GetCurrentOxyState() then
			var_45_1[#var_45_1 + 1] = iter_45_1
		end
	end

	return var_45_1
end

function var_0_4.TargetDetectedUnit(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = arg_46_2 or var_0_4.TargetEntityUnit()
	local var_46_1 = {}

	pairs = var_1_10005

	for iter_46_0, iter_46_1 in var_1_10005(var_46_0) do
		if iter_46_1:GetDiveDetected() then
			var_46_1[#var_46_1 + 1] = iter_46_1
		end
	end

	return var_46_1
end

function var_0_4.TargetFatalDamageSrc(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = arg_47_2 or var_0_4.TargetEntityUnit()
	local var_47_1 = arg_47_0:GetDeathSrcID()
	local var_47_2 = {}

	if var_47_1 then
		pairs = var_1_10006

		for iter_47_0, iter_47_1 in var_1_10006(var_47_0) do
			if var_47_1 == iter_47_1:GetUniqueID() and iter_47_1:IsAlive() then
				var_47_2[#var_47_2 + 1] = iter_47_1
			end
		end
	end

	return var_47_2
end

function var_0_4.TargetAllHarmBullet(arg_48_0)
	ys = var_1_10001

	local var_48_0 = var_1_10001.Battle.BattleDataProxy.GetInstance()
	local var_48_1 = {}
	local var_48_2 = arg_48_0
	local var_48_3 = arg_48_0.GetIFF(var_48_2)

	pairs = var_48_2

	for iter_48_0, iter_48_1 in var_48_2(var_48_0:GetBulletList()) do
		if var_48_3 ~= iter_48_1:GetIFF() then
			var_48_1[#var_48_1 + 1] = iter_48_1
		end
	end

	return var_48_1
end

function var_0_4.TargetAllHarmBulletByType(arg_49_0, arg_49_1)
	ys = var_1_10002

	local var_49_0 = var_1_10002.Battle.BattleDataProxy.GetInstance()
	local var_49_1 = {}
	local var_49_2 = arg_49_0
	local var_49_3 = arg_49_0.GetIFF(var_49_2)

	pairs = var_49_2

	for iter_49_0, iter_49_1 in var_49_2(var_49_0:GetBulletList()) do
		if var_49_3 ~= iter_49_1:GetIFF() and iter_49_1:GetType() == arg_49_1 then
			var_49_1[#var_49_1 + 1] = iter_49_1
		end
	end

	return var_49_1
end

function var_0_4.TargetAllHarmTorpedoBullet(arg_50_0)
	local var_50_0 = var_0_4.TargetAllHarmBulletByType
	local var_50_1 = arg_50_0

	ys = var_1_10003

	return var_50_0(var_50_1, var_1_10003.Battle.BattleConst.BulletType.TORPEDO)
end

function var_0_4.TargetFleetIndex(arg_51_0, arg_51_1)
	local var_51_0

	if arg_51_0 then
		var_51_0 = arg_51_0:GetIFF()
	else
		var_51_0 = var_0_1.FRIENDLY_CODE
	end

	ys = var_1_10003

	local var_51_1 = var_1_10003.Battle.BattleDataProxy.GetInstance()
	local var_51_2 = var_3.GetFleetByIFF(var_51_1, var_51_0)

	TeamType = var_51_1

	local var_51_3 = var_51_1.TeamPos
	local var_51_4 = arg_51_1.fleetPos
	local var_51_5 = {}
	local var_51_6 = var_51_2:GetUnitList()
	local var_51_7 = var_51_2:GetScoutList()

	if arg_51_1.exceptCaster then
		var_1_10010 = arg_51_0:GetUniqueID()
	end

	ipairs = var_1_10010

	for iter_51_0, iter_51_1 in var_1_10010(var_51_6) do
		local var_51_8 = iter_51_1
		local var_51_9 = iter_51_1.GetUniqueID(var_51_8)

		if var_9 then
			casterID = var_51_8

			if var_51_9 == var_51_8 then
				goto label_51_0
			end
		end

		if iter_51_1 == var_51_2:GetFlagShip() then
			if var_51_4 == var_51_3.FLAG_SHIP then
				table = var_16

				var_16.insert(var_51_5, iter_51_1)
			end
		elseif iter_51_1 == var_51_7[1] then
			if var_51_4 == var_51_3.LEADER then
				table = var_16

				var_16.insert(var_51_5, iter_51_1)
			end
		elseif #var_51_7 == 3 and iter_51_1 == var_51_7[2] then
			if var_51_4 == var_51_3.CENTER then
				table = var_16

				var_16.insert(var_51_5, iter_51_1)
			end
		elseif iter_51_1 == var_51_7[#var_51_7] then
			if var_51_4 == var_51_3.REAR then
				table = var_16

				var_16.insert(var_51_5, iter_51_1)
			end
		elseif iter_51_1:IsMainFleetUnit() and iter_51_1:GetMainUnitIndex() == 2 then
			if var_51_4 == var_51_3.UPPER_CONSORT then
				table = var_16

				var_16.insert(var_51_5, iter_51_1)
			end
		elseif iter_51_1:IsMainFleetUnit() and iter_51_1:GetMainUnitIndex() == 3 and var_51_4 == var_51_3.LOWER_CONSORT then
			table = var_16

			var_16.insert(var_51_5, iter_51_1)
		end

		::label_51_0::
	end

	local var_51_10 = var_51_2
	local var_51_11 = var_51_2.GetSubList(var_51_10)

	ipairs = var_51_10

	for iter_51_2, iter_51_3 in var_51_10(var_51_6) do
		if iter_51_2 == 1 then
			if var_51_4 == var_51_3.SUB_LEADER then
				table = var_16

				var_16.insert(var_51_5, iter_51_3)
			end
		elseif var_51_4 == var_51_3.SUB_CONSORT then
			table = var_16

			var_16.insert(var_51_5, iter_51_3)
		end
	end

	return var_51_5
end

function var_0_4.TargetPlayerVanguardFleet(arg_52_0, arg_52_1, arg_52_2)
	ys = var_1_10003

	local var_52_0 = var_1_10003.Battle.BattleDataProxy.GetInstance()
	local var_52_1 = var_3.GetFleetByIFF(var_52_0, arg_52_0:GetIFF())
	local var_52_2 = var_3.GetScoutList(var_52_1)

	if not arg_52_2 then
		return var_52_2
	else
		local var_52_3 = #arg_52_2

		while 0 < var_52_3 do
			table = var_6

			if not var_6.contains(var_52_2, arg_52_2[var_52_3]) then
				table = var_6

				var_6.remove(arg_52_2, var_52_3)
			end

			var_52_3 = var_52_3 - 1
		end

		return arg_52_2
	end

	return
end

function var_0_4.TargetPlayerMainFleet(arg_53_0, arg_53_1, arg_53_2)
	ys = var_1_10003

	local var_53_0 = var_1_10003.Battle.BattleDataProxy.GetInstance()
	local var_53_1 = var_3.GetFleetByIFF(var_53_0, arg_53_0:GetIFF())
	local var_53_2 = var_3.GetMainList(var_53_1)

	if not arg_53_2 then
		return var_53_2
	else
		local var_53_3 = #arg_53_2

		while 0 < var_53_3 do
			table = var_6

			if not var_6.contains(var_53_2, arg_53_2[var_53_3]) then
				table = var_6

				var_6.remove(arg_53_2, var_53_3)
			end

			var_53_3 = var_53_3 - 1
		end

		return arg_53_2
	end

	return
end

function var_0_4.TargetPlayerFlagShip(arg_54_0, arg_54_1, arg_54_2)
	ys = var_1_10003

	local var_54_0 = var_1_10003.Battle.BattleDataProxy.GetInstance()
	local var_54_1 = var_3.GetFleetByIFF(var_54_0, arg_54_0:GetIFF())

	return {
		var_54_1:GetFlagShip()
	}
end

function var_0_4.TargetPlayerLeaderShip(arg_55_0, arg_55_1, arg_55_2)
	ys = var_1_10003

	local var_55_0 = var_1_10003.Battle.BattleDataProxy.GetInstance()
	local var_55_1 = var_3.GetFleetByIFF(var_55_0, arg_55_0:GetIFF())

	return {
		var_55_1:GetLeaderShip()
	}
end

function var_0_4.TargetEnemyLeaderShip(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = arg_56_0
	local var_56_1 = arg_56_0.GetIFF(var_56_0) * -1

	ys = var_56_0

	local var_56_2 = var_56_0.Battle.BattleDataProxy.GetInstance()
	local var_56_3 = var_4.GetFleetByIFF(var_56_2, var_56_1)

	return {
		var_56_3:GetLeaderShip()
	}
end

function var_0_4.TargetPlayerByType(arg_57_0, arg_57_1)
	ys = var_1_10002

	local var_57_0 = var_1_10002.Battle.BattleDataProxy.GetInstance()
	local var_57_1 = var_2.GetFleetByIFF(var_57_0, arg_57_0:GetIFF())
	local var_57_2 = var_2.GetUnitList(var_57_1)
	local var_57_3 = {}
	local var_57_4 = arg_57_1.shipType

	ipairs = var_1_10006

	for iter_57_0, iter_57_1 in var_1_10006(var_57_2) do
		if iter_57_1:GetTemplate().type == var_57_4 then
			var_57_3[#var_57_3 + 1] = iter_57_1
		end
	end

	return var_57_3
end

function var_0_4.TargetPlayerAidUnit(arg_58_0, arg_58_1)
	ys = var_1_10002

	local var_58_0 = var_1_10002.Battle.BattleDataProxy.GetInstance()
	local var_58_1 = var_2.GetAidUnit(var_58_0)
	local var_58_2 = {}

	pairs = var_1_10004

	for iter_58_0, iter_58_1 in var_1_10004(var_58_1) do
		table = var_1_10009

		var_1_10009.insert(var_58_2, iter_58_1)
	end

	return var_58_2
end

function var_0_4.TargetDamageSource(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = arg_59_2 or var_0_4.TargetAllFoe(arg_59_0)
	local var_59_1 = {}

	pairs = var_1_10005

	for iter_59_0, iter_59_1 in var_1_10005(var_59_0) do
		if iter_59_1:GetUniqueID() == arg_59_1.damageSourceID then
			table = var_10

			var_10.insert(var_59_1, iter_59_1)

			break
		end
	end

	return var_59_1
end

function var_0_4.TargetRarity(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = arg_60_2 or var_0_4.TargetAllHelp(arg_60_0)
	local var_60_1 = {}

	ipairs = var_1_10005

	for iter_60_0, iter_60_1 in var_1_10005(var_60_0) do
		if iter_60_1:GetRarity() == arg_60_1.rarity then
			table = var_11

			var_11.insert(var_60_1, iter_60_1)
		end
	end

	return var_60_1
end

function var_0_4.TargetIllustrator(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = arg_61_2 or var_0_4.TargetAllHelp(arg_61_0)
	local var_61_1 = {}

	ipairs = var_1_10005

	for iter_61_0, iter_61_1 in var_1_10005(var_61_0) do
		ys = var_1_10010

		if var_1_10010.Battle.BattleDataFunction.GetPlayerShipSkinDataFromID(iter_61_1:GetSkinID()).illustrator == arg_61_1.illustrator then
			table = var_11

			var_11.insert(var_61_1, iter_61_1)
		end
	end

	return var_61_1
end

function var_0_4.TargetTeam(arg_62_0, arg_62_1, arg_62_2)
	ys = var_1_10003

	local var_62_0 = var_1_10003.Battle.BattleDataProxy.GetInstance()
	local var_62_1 = var_3.GetFleetByIFF(var_62_0, arg_62_0:GetIFF())
	local var_62_2 = {}

	TeamType = var_5

	local var_62_3 = var_5.TeamTypeIndex[arg_62_1.teamIndex]

	TeamType = var_6

	if var_62_3 == var_6.Vanguard then
		var_1_10007 = var_62_1
		var_62_2 = var_62_1.GetScoutList(var_1_10007)
	else
		TeamType = var_6

		if var_62_3 == var_6.Main then
			var_1_10007 = var_62_1
			var_62_2 = var_62_1.GetMainList(var_1_10007)
		else
			TeamType = var_6

			if var_62_3 == var_6.Submarine then
				var_1_10007 = var_62_1
				var_62_2 = var_62_1.GetSubList(var_1_10007)
			end
		end
	end

	local var_62_4 = {}

	ipairs = var_1_10007

	for iter_62_0, iter_62_1 in var_1_10007(var_62_2) do
		if arg_62_2 then
			table = var_1_10012

			if var_1_10012.contains(arg_62_2, iter_62_1) then
				table = var_1_10012

				var_1_10012.insert(var_62_4, iter_62_1)
			end
		end
	end

	return var_62_4
end

function var_0_4.TargetGroup(arg_63_0, arg_63_1, arg_63_2)
	local var_63_0 = arg_63_1.groupIDList
	local var_63_1 = arg_63_2 or var_0_4.TargetAllHelp(arg_63_0)
	local var_63_2 = {}
	local var_63_3 = arg_63_0
	local var_63_4 = arg_63_0.GetIFF(var_63_3)

	ipairs = var_63_3

	for iter_63_0, iter_63_1 in var_63_3(var_63_1) do
		local var_63_5 = iter_63_1
		local var_63_6 = iter_63_1.GetTemplateID(var_63_5)

		ys = var_63_5

		local var_63_7 = var_63_5.Battle.BattleDataFunction.GetPlayerShipModelFromID(var_63_6).group_type
		local var_63_8 = iter_63_1
		local var_63_9 = iter_63_1.GetIFF(var_63_8)

		table = var_63_8

		if var_63_8.contains(var_63_0, var_63_7) and var_63_4 == var_63_9 then
			var_63_2[#var_63_2 + 1] = iter_63_1
		end
	end

	return var_63_2
end

function var_0_4.LegalTarget(arg_64_0)
	local var_64_0 = {}
	local var_64_1

	ys = var_1_10003

	local var_64_2 = var_1_10003.Battle.BattleDataProxy.GetInstance()
	local var_64_3, var_64_4, var_64_5, var_64_6 = var_3.GetFieldBound(var_64_2)
	local var_64_7 = var_3:GetUnitList()
	local var_64_8 = arg_64_0
	local var_64_9 = arg_64_0.GetIFF(var_64_8)

	pairs = var_64_8

	for iter_64_0, iter_64_1 in var_64_8(var_64_7) do
		if iter_64_1:IsAlive() and iter_64_1:GetIFF() ~= var_64_9 and var_64_6 > iter_64_1:GetPosition().x and not iter_64_1:IsSpectre() then
			var_64_0[#var_64_0 + 1] = iter_64_1
		end
	end

	return var_64_0
end

function var_0_4.LegalWeaponTarget(arg_65_0)
	local var_65_0 = {}
	local var_65_1

	ys = var_1_10003

	local var_65_2 = var_1_10003.Battle.BattleDataProxy.GetInstance()
	local var_65_3 = var_3.GetUnitList(var_65_2)
	local var_65_4 = arg_65_0
	local var_65_5 = arg_65_0.GetIFF(var_65_4)

	pairs = var_65_4

	for iter_65_0, iter_65_1 in var_65_4(var_65_3) do
		if iter_65_1:GetIFF() ~= var_65_5 and not iter_65_1:IsSpectre() then
			var_65_0[#var_65_0 + 1] = iter_65_1
		end
	end

	return var_65_0
end

return
