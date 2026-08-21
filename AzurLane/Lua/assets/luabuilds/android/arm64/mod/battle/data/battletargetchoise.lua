ys = ys or {}

local var_0_0 = ys.Battle.BattleConfig
local var_0_1 = ys.Battle.BattleAttr
local var_0_2 = ys.Battle.BattleFormulas
local var_0_3 = {}

ys.Battle.BattleTargetChoise = {}
;({}).TargetNil = function()
	return nil
end
;({}).TargetNull = function()
	return {}
end
;({}).TargetAll = function()
	return ys.Battle.BattleDataProxy.GetInstance():GetUnitList()
end
;({}).TargetEntityUnit = function()
	for iter_4_0, iter_4_1 in pairs((ys.Battle.BattleDataProxy.GetInstance():GetUnitList())) do
		if not iter_4_1:IsSpectre() then
			({})[#{} + 1] = iter_4_1
		end
	end

	return {}
end
;({}).TargetSpectreUnit = function(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in pairs((ys.Battle.BattleDataProxy.GetInstance():GetSpectreShipList())) do
		({})[#{} + 1] = iter_5_1
	end

	return {}
end
;({}).TargetTemplate = function(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1.targetTemplateIDList
	local var_6_1, var_6_2

	if not arg_6_1.targetTemplateIDList then
		var_6_0 = {
			arg_6_1.targetTemplateID
		}
		var_6_1 = {}
		var_6_2 = arg_6_0:GetIFF()
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_2 or var_0_3.TargetEntityUnit()) do
		local var_6_3 = iter_6_1:GetIFF()

		if table.contains(var_6_0, (iter_6_1:GetTemplateID())) and var_6_2 == var_6_3 then
			var_6_1[#var_6_1 + 1] = iter_6_1
		end
	end

	return var_6_1
end
;({}).TargetNationality = function(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1.targetTemplateIDList then
		({})[1] = arg_7_1.targetTemplateID
	end

	local var_7_0 = arg_7_2 or ys.Battle.BattleDataProxy.GetInstance():GetUnitList()
	local var_7_1 = {}
	local var_7_2 = type(arg_7_1.nationality)

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if var_7_2 == "number" then
			if iter_7_1:GetTemplate().nationality == arg_7_1.nationality then
				var_7_1[#var_7_1 + 1] = iter_7_1
			end
		elseif var_7_2 == "table" and table.contains(arg_7_1.nationality, iter_7_1:GetTemplate().nationality) then
			var_7_1[#var_7_1 + 1] = iter_7_1
		end
	end

	return var_7_1
end
;({}).TargetShipType = function(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_2 or var_0_3.TargetEntityUnit()) do
		if table.contains(arg_8_1.ship_type_list, iter_8_1:GetTemplate().type) then
			var_8_0[#var_8_0 + 1] = iter_8_1
		end
	end

	return var_8_0
end
;({}).TargetShipTag = function(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_2 or var_0_3.TargetEntityUnit()) do
		if iter_9_1:ContainsLabelTag(arg_9_1.ship_tag_list) then
			var_9_0[#var_9_0 + 1] = iter_9_1
		end
	end

	return var_9_0
end
;({}).TargetShipArmor = function(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_2 or var_0_3.TargetEntityUnit()) do
		if iter_10_1:GetAttrByName("armorType") == arg_10_1.armor_type then
			var_10_0[#var_10_0 + 1] = iter_10_1
		end
	end

	return var_10_0
end
;({}).getShipListByIFF = function(arg_11_0)
	local var_11_0 = ys.Battle.BattleDataProxy.GetInstance()
	local var_11_1

	if arg_11_0 == var_0_0.FRIENDLY_CODE then
		var_11_1 = var_11_0:GetFriendlyShipList()
	elseif arg_11_0 == var_0_0.FOE_CODE then
		var_11_1 = var_11_0:GetFoeShipList()
	end

	return var_11_1
end
;({}).TargetAllHelp = function(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0 then
		arg_12_1 = arg_12_1 or {}

		local var_12_0 = arg_12_1.exceptCaster
		local var_12_1 = arg_12_0:GetUniqueID()
		local var_12_2 = arg_12_0:GetIFF()

		for iter_12_0, iter_12_1 in pairs(arg_12_2 or var_0_3.getShipListByIFF(var_12_2)) do
			local var_12_3 = iter_12_1:GetUniqueID()

			if iter_12_1:IsAlive() and iter_12_1:GetIFF() == var_12_2 and (not var_12_0 or var_12_3 ~= var_12_1) then
				({})[#{} + 1] = iter_12_1
			end
		end
	end

	return {}
end
;({}).TargetHelpLeastHP = function(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1 = arg_13_1 or {}

	local var_13_0

	if arg_13_0 then
		local var_13_1 = 9999999999

		for iter_13_0, iter_13_1 in pairs(arg_13_2 or var_0_3.getShipListByIFF(arg_13_0:GetIFF())) do
			if iter_13_1:IsAlive() and var_13_1 > iter_13_1:GetCurrentHP() and (not arg_13_1.targetMaxHPRatio or arg_13_1.targetMaxHPRatio >= iter_13_1:GetHPRate()) then
				var_13_0 = iter_13_1
				var_13_1 = iter_13_1:GetCurrentHP()
			end
		end
	end

	return {
		var_13_0
	}
end
;({}).TargetHelpLeastHPRatio = function(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1 = arg_14_1 or {}

	local var_14_0

	if arg_14_0 then
		for iter_14_0, iter_14_1 in pairs(arg_14_2 or var_0_3.getShipListByIFF(arg_14_0:GetIFF())) do
			local var_14_1

			if iter_14_1:IsAlive() and 100 > iter_14_1:GetHPRate() then
				var_14_0 = iter_14_1
				var_14_1 = iter_14_1:GetHPRate()
			end
		end
	end

	return {
		var_14_0
	}
end
;({}).TargetHighestHP = function(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1 = arg_15_1 or {}

	local var_15_0

	if arg_15_0 then
		local var_15_1 = 1

		for iter_15_0, iter_15_1 in pairs(arg_15_2 or var_0_3.TargetEntityUnit()) do
			if iter_15_1:IsAlive() and var_15_1 < iter_15_1:GetCurrentHP() then
				var_15_0 = iter_15_1
				var_15_1 = iter_15_1:GetCurrentHP()
			end
		end
	end

	return {
		var_15_0
	}
end
;({}).TargetLowestHPRatio = function(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1 = arg_16_1 or {}

	local var_16_0
	local var_16_1 = 1

	for iter_16_0, iter_16_1 in pairs(arg_16_2 or var_0_3.TargetEntityUnit()) do
		local var_16_2 = iter_16_1:GetHPRate()

		if iter_16_1:IsAlive() and var_16_2 < var_16_1 and var_16_2 > 0 then
			var_16_0 = iter_16_1
			var_16_1 = var_16_2
		end
	end

	return {
		var_16_0
	}
end
;({}).TargetLowestHP = function(arg_17_0, arg_17_1, arg_17_2)
	arg_17_1 = arg_17_1 or {}

	local var_17_0
	local var_17_1 = 9999999999

	for iter_17_0, iter_17_1 in pairs(arg_17_2 or var_0_3.TargetEntityUnit()) do
		local var_17_2 = iter_17_1:GetCurrentHP()

		if iter_17_1:IsAlive() and var_17_2 < var_17_1 and var_17_2 > 0 then
			var_17_0 = iter_17_1
			var_17_1 = var_17_2
		end
	end

	return {
		var_17_0
	}
end
;({}).TargetHighestHPRatio = function(arg_18_0, arg_18_1, arg_18_2)
	arg_18_1 = arg_18_1 or {}

	local var_18_0
	local var_18_1 = 0

	for iter_18_0, iter_18_1 in pairs(arg_18_2 or var_0_3.TargetEntityUnit()) do
		if iter_18_1:IsAlive() and var_18_1 < iter_18_1:GetHPRate() then
			var_18_0 = iter_18_1
			var_18_1 = iter_18_1:GetHPRate()
		end
	end

	return {
		var_18_0
	}
end
;({}).TargetAttrCompare = function(arg_19_0, arg_19_1, arg_19_2)
	for iter_19_0, iter_19_1 in pairs(arg_19_2 or var_0_3.TargetEntityUnit()) do
		if iter_19_1:IsAlive() and var_0_2.parseCompareUnitAttr(arg_19_1.attrCompare, iter_19_1, arg_19_0) then
			table.insert({}, iter_19_1)
		end
	end

	return {}
end
;({}).TargetAttrCeil = function(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1.ceilAttr
	local var_20_1

	for iter_20_0, iter_20_1 in ipairs(arg_20_2 or var_0_3.TargetEntityUnit()) do
		local var_20_2 = iter_20_1:GetAttrByName(var_20_0)
		local var_20_3

		if 0 <= var_20_2 then
			var_20_3 = var_20_2
			var_20_1 = iter_20_1
		end
	end

	return {
		var_20_1
	}
end
;({}).TargetAttrFloor = function(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1.floorAttr
	local var_21_1

	for iter_21_0, iter_21_1 in ipairs(arg_21_2 or var_0_3.TargetEntityUnit()) do
		local var_21_2 = iter_21_1:GetAttrByName(var_21_0)
		local var_21_3

		if var_21_2 <= Mathf.Infinity then
			var_21_3 = var_21_2
			var_21_1 = iter_21_1
		end
	end

	return {
		var_21_1
	}
end
;({}).TargetTempCompare = function(arg_22_0, arg_22_1, arg_22_2)
	for iter_22_0, iter_22_1 in pairs(arg_22_2 or var_0_3.TargetEntityUnit()) do
		if iter_22_1:IsAlive() and var_0_2.parseCompareUnitTemplate(arg_22_1.tempCompare, iter_22_1, arg_22_0) then
			table.insert({}, iter_22_1)
		end
	end

	return {}
end
;({}).TargetHPCompare = function(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_2 or var_0_3.TargetEntityUnit()

	if arg_23_0 then
		local var_23_1 = arg_23_0:GetHP()

		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			if var_23_1 > iter_23_1:GetHP() then
				({})[#{} + 1] = iter_23_1
			end
		end
	end

	return {}
end
;({}).TargetHPRatioLowerThan = function(arg_24_0, arg_24_1, arg_24_2)
	for iter_24_0, iter_24_1 in ipairs(arg_24_2 or var_0_3.TargetEntityUnit()) do
		if arg_24_1.hpRatioList[1] > iter_24_1:GetHP() then
			({})[#{} + 1] = iter_24_1
		end
	end

	return {}
end
;({}).TargetNationalityFriendly = function(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0 then
		for iter_25_0, iter_25_1 in pairs(arg_25_2 or var_0_3.TargetAllHelp(arg_25_0, arg_25_1)) do
			if iter_25_1:GetTemplate().nationality == arg_25_1.nationality then
				({})[#{} + 1] = iter_25_1
			end
		end
	end

	return {}
end
;({}).TargetNationalityFoe = function(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_0 then
		for iter_26_0, iter_26_1 in pairs(arg_26_2 or var_0_3.TargetAllHarm(arg_26_0, arg_26_1)) do
			if iter_26_1:GetTemplate().nationality == arg_26_1.nationality then
				({})[#{} + 1] = iter_26_1
			end
		end
	end

	return {}
end
;({}).TargetShipTypeFriendly = function(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_0 then
		for iter_27_0, iter_27_1 in pairs(arg_27_2 or var_0_3.TargetAllHelp(arg_27_0, arg_27_1)) do
			if table.contains(arg_27_1.ship_type_list, iter_27_1:GetTemplate().type) then
				({})[#{} + 1] = iter_27_1
			end
		end
	end

	return {}
end
;({}).TargetSelf = function(arg_28_0)
	return {
		arg_28_0
	}
end
;({}).TargetAllHarm = function(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0
	local var_29_1 = arg_29_0:GetIFF()
	local var_29_2 = ys.Battle.BattleDataProxy.GetInstance()

	if arg_29_2 then
		var_29_0 = {}

		for iter_29_0, iter_29_1 in ipairs(arg_29_2) do
			if iter_29_1:GetIFF() * var_29_1 == -1 then
				table.insert(var_29_0, iter_29_1)
			end
		end
	elseif var_29_1 == var_0_0.FRIENDLY_CODE then
		var_29_0 = var_29_2:GetFoeShipList()
	elseif var_29_1 == var_0_0.FOE_CODE then
		var_29_0 = var_29_2:GetFriendlyShipList()
	end

	local var_29_3, var_29_4, var_29_5, var_29_6 = var_29_2:GetFieldBound()

	if var_29_0 then
		for iter_29_2, iter_29_3 in pairs(var_29_0) do
			if iter_29_3:IsAlive() and var_29_6 > iter_29_3:GetPosition().x and iter_29_3:GetCurrentOxyState() ~= ys.Battle.BattleConst.OXY_STATE.DIVE then
				({})[#{} + 1] = iter_29_3
			end
		end
	end

	return {}
end
;({}).TargetAllFoe = function(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0
	local var_30_1 = arg_30_0:GetIFF()
	local var_30_2 = ys.Battle.BattleDataProxy.GetInstance()

	if arg_30_2 then
		var_30_0 = {}

		for iter_30_0, iter_30_1 in ipairs(arg_30_2) do
			if iter_30_1:GetIFF() * var_30_1 == -1 then
				table.insert(var_30_0, iter_30_1)
			end
		end
	elseif var_30_1 == var_0_0.FRIENDLY_CODE then
		var_30_0 = var_30_2:GetFoeShipList()
	elseif var_30_1 == var_0_0.FOE_CODE then
		var_30_0 = var_30_2:GetFriendlyShipList()
	end

	local var_30_3, var_30_4, var_30_5, var_30_6 = var_30_2:GetFieldBound()

	if var_30_0 then
		for iter_30_2, iter_30_3 in pairs(var_30_0) do
			if iter_30_3:IsAlive() and var_30_6 > iter_30_3:GetPosition().x then
				({})[#{} + 1] = iter_30_3
			end
		end
	end

	return {}
end
;({}).TargetFoeUncloak = function(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0
	local var_31_1 = arg_31_0:GetIFF()
	local var_31_2 = ys.Battle.BattleDataProxy.GetInstance()

	if arg_31_2 then
		var_31_0 = {}

		for iter_31_0, iter_31_1 in ipairs(arg_31_2) do
			if iter_31_1:GetIFF() * var_31_1 == -1 then
				table.insert(var_31_0, iter_31_1)
			end
		end
	elseif var_31_1 == var_0_0.FRIENDLY_CODE then
		var_31_0 = var_31_2:GetFoeShipList()
	elseif var_31_1 == var_0_0.FOE_CODE then
		var_31_0 = var_31_2:GetFriendlyShipList()
	end

	local var_31_3, var_31_4, var_31_5, var_31_6 = var_31_2:GetFieldBound()

	if var_31_0 then
		for iter_31_2, iter_31_3 in pairs(var_31_0) do
			if iter_31_3:IsAlive() and var_31_6 > iter_31_3:GetPosition().x and not var_0_1.IsCloak(iter_31_3) and iter_31_3:GetCurrentOxyState() ~= ys.Battle.BattleConst.OXY_STATE.DIVE then
				({})[#{} + 1] = iter_31_3
			end
		end
	end

	return {}
end
;({}).TargetCloakState = function(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_1.cloak
	local var_32_1

	if not arg_32_1.cloak then
		var_32_0 = 1
		var_32_1 = ipairs
	end

	for iter_32_0, iter_32_1 in var_32_1(arg_32_2 or var_0_3.TargetEntityUnit()) do
		if var_0_1.GetCurrent(iter_32_1, "isCloak") == var_32_0 then
			({})[#{} + 1] = iter_32_1
		end
	end

	return {}
end
;({}).TargetFaintState = function(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_1.faint
	local var_33_1

	if not arg_33_1.faint then
		var_33_0 = 1
		var_33_1 = ipairs
	end

	for iter_33_0, iter_33_1 in var_33_1(arg_33_2 or var_0_3.TargetEntityUnit()) do
		local var_33_2 = iter_33_1:GetAimBias()

		if var_33_0 == 1 then
			if var_33_2 and var_33_2:IsFaint() then
				({})[#{} + 1] = iter_33_1
			end
		elseif var_33_0 == 0 and (not var_33_2 or not var_33_2:IsFaint()) then
			({})[#{} + 1] = iter_33_1
		end
	end

	return {}
end
;({}).TargetNearest = function(arg_34_0, arg_34_1, arg_34_2)
	arg_34_1 = arg_34_1 or {}

	local var_34_0 = arg_34_1.range or 9999999999
	local var_34_1

	for iter_34_0, iter_34_1 in ipairs(arg_34_2) do
		local var_34_2 = arg_34_0:GetDistance(iter_34_1)

		if var_34_2 < var_34_0 then
			var_34_0 = var_34_2
			var_34_1 = iter_34_1
		end
	end

	return {
		var_34_1
	}
end
;({}).TargetHarmNearest = function(arg_35_0, arg_35_1, arg_35_2)
	arg_35_1 = arg_35_1 or {}

	local var_35_0 = arg_35_1.range or 9999999999
	local var_35_1
	local var_35_2 = arg_35_2 and var_0_3.TargetFoeUncloak(arg_35_0, arg_35_1, arg_35_2) or var_0_3.TargetFoeUncloak(arg_35_0)

	for iter_35_0, iter_35_1 in ipairs(var_35_2) do
		local var_35_3 = arg_35_0:GetDistance(iter_35_1)

		if var_35_3 < var_35_0 then
			var_35_0 = var_35_3
			var_35_1 = iter_35_1
		end
	end

	return {
		var_35_1
	}
end
;({}).TargetHarmFarthest = function(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0

	arg_36_1 = arg_36_1 or {}

	local var_36_1 = arg_36_2 and var_0_3.TargetFoeUncloak(arg_36_0, arg_36_1, arg_36_2) or var_0_3.TargetFoeUncloak(arg_36_0)

	for iter_36_0, iter_36_1 in ipairs(var_36_1) do
		local var_36_2 = arg_36_0:GetDistance(iter_36_1)
		local var_36_3

		if 0 < var_36_2 then
			var_36_3 = var_36_2
			var_36_0 = iter_36_1
		end
	end

	return {
		var_36_0
	}
end
;({}).TargetHarmRandom = function(arg_37_0, arg_37_1, arg_37_2)
	arg_37_1 = arg_37_1 or {}

	local var_37_0 = arg_37_2 and var_0_3.TargetFoeUncloak(arg_37_0, arg_37_1, arg_37_2) or var_0_3.TargetFoeUncloak(arg_37_0)
	local var_37_1 = var_37_0

	if #var_37_0 > 0 then
		return {
			var_37_1[math.random(#var_37_1)]
		}
	else
		return {}
	end

	return
end
;({}).TargetHarmRandomByWeight = function(arg_38_0, arg_38_1, arg_38_2)
	arg_38_1 = arg_38_1 or {}

	local var_38_0 = arg_38_2 and var_0_3.TargetFoeUncloak(arg_38_0, arg_38_1, arg_38_2) or var_0_3.TargetFoeUncloak(arg_38_0)
	local var_38_1 = {}

	for iter_38_0, iter_38_1 in ipairs(var_38_0) do
		local var_38_2 = iter_38_1:GetTargetedPriority() or 0
		local var_38_3

		if var_38_2 == -9999 then
			var_38_1[#var_38_1 + 1] = iter_38_1
		elseif -9999 < var_38_2 then
			var_38_1 = {
				iter_38_1
			}
			var_38_3 = var_38_2
		end
	end

	if #var_38_1 > 0 then
		return {
			var_38_1[math.random(#var_38_1)]
		}
	else
		return {}
	end

	return
end
;({}).TargetWeightiest = function(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in ipairs(arg_39_2 or var_0_3.TargetEntityUnit()) do
		local var_39_1 = iter_39_1:GetTargetedPriority() or 0
		local var_39_2

		if var_39_1 == -9999 then
			var_39_0[#var_39_0 + 1] = iter_39_1
		elseif -9999 < var_39_1 then
			var_39_0 = {
				iter_39_1
			}
			var_39_2 = var_39_1
		end
	end

	return var_39_0
end
;({}).TargetRandom = function(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_2 or var_0_3.TargetEntityUnit()
	local var_40_1 = arg_40_1.randomCount or 1

	return (Mathf.MultiRandom(var_40_0, var_40_1))
end
;({}).TargetInsideArea = function(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_2 or var_0_3.TargetAllHarm(arg_41_0)
	local var_41_1 = arg_41_1.dir or ys.Battle.BattleConst.UnitDir.RIGHT
	local var_41_2 = arg_41_1.lineX
	local var_41_3 = {}

	if var_41_1 == ys.Battle.BattleConst.UnitDir.RIGHT then
		for iter_41_0, iter_41_1 in ipairs(var_41_0) do
			if var_41_2 <= iter_41_1:GetPosition().x then
				table.insert(var_41_3, iter_41_1)
			end
		end
	elseif var_41_1 == ys.Battle.BattleConst.UnitDir.LEFT then
		for iter_41_2, iter_41_3 in ipairs(var_41_0) do
			if var_41_2 >= iter_41_3:GetPosition().x then
				table.insert(var_41_3, iter_41_3)
			end
		end
	end

	return var_41_3
end
;({}).TargetAircraftHelp = function(arg_42_0)
	local var_42_0 = arg_42_0:GetIFF()

	for iter_42_0, iter_42_1 in pairs(ys.Battle.BattleDataProxy.GetInstance():GetAircraftList()) do
		if var_42_0 == iter_42_1:GetIFF() then
			({})[#{} + 1] = iter_42_1
		end
	end

	return {}
end
;({}).TargetAircraftHarm = function(arg_43_0)
	local var_43_0 = arg_43_0:GetIFF()

	for iter_43_0, iter_43_1 in pairs(ys.Battle.BattleDataProxy.GetInstance():GetAircraftList()) do
		if var_43_0 ~= iter_43_1:GetIFF() and iter_43_1:IsVisitable() then
			({})[#{} + 1] = iter_43_1
		end
	end

	return {}
end
;({}).TargetAircraftGB = function(arg_44_0)
	local var_44_0 = arg_44_0:GetIFF()

	for iter_44_0, iter_44_1 in pairs(ys.Battle.BattleDataProxy.GetInstance():GetAircraftList()) do
		if var_44_0 ~= iter_44_1:GetIFF() and iter_44_1:IsVisitable() and iter_44_1:GetMotherUnit() == nil then
			({})[#{} + 1] = iter_44_1
		end
	end

	return {}
end
;({}).TargetDiveState = function(arg_45_0, arg_45_1, arg_45_2)
	if arg_45_1 then
		local var_45_0 = arg_45_1.diveState
		local var_45_1

		if not arg_45_1.diveState then
			var_45_0 = ys.Battle.BattleConst.OXY_STATE.DIVE
			var_45_1 = {}
		end

		for iter_45_0, iter_45_1 in pairs(arg_45_2 or var_0_3.TargetEntityUnit()) do
			if var_45_0 == iter_45_1:GetCurrentOxyState() then
				var_45_1[#var_45_1 + 1] = iter_45_1
			end
		end

		return var_45_1
	end
end
;({}).TargetDetectedUnit = function(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = {}

	for iter_46_0, iter_46_1 in pairs(arg_46_2 or var_0_3.TargetEntityUnit()) do
		if iter_46_1:GetDiveDetected() then
			var_46_0[#var_46_0 + 1] = iter_46_1
		end
	end

	return var_46_0
end
;({}).TargetFatalDamageSrc = function(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = arg_47_2 or var_0_3.TargetEntityUnit()
	local var_47_1 = arg_47_0:GetDeathSrcID()

	if var_47_1 then
		for iter_47_0, iter_47_1 in pairs(var_47_0) do
			if var_47_1 == iter_47_1:GetUniqueID() and iter_47_1:IsAlive() then
				({})[#{} + 1] = iter_47_1
			end
		end
	end

	return {}
end
;({}).TargetAllHarmBullet = function(arg_48_0)
	local var_48_0 = arg_48_0:GetIFF()

	for iter_48_0, iter_48_1 in pairs(ys.Battle.BattleDataProxy.GetInstance():GetBulletList()) do
		if var_48_0 ~= iter_48_1:GetIFF() then
			({})[#{} + 1] = iter_48_1
		end
	end

	return {}
end
;({}).TargetAllHarmBulletByType = function(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_0:GetIFF()

	for iter_49_0, iter_49_1 in pairs(ys.Battle.BattleDataProxy.GetInstance():GetBulletList()) do
		if var_49_0 ~= iter_49_1:GetIFF() and iter_49_1:GetType() == arg_49_1 then
			({})[#{} + 1] = iter_49_1
		end
	end

	return {}
end
;({}).TargetAllHarmTorpedoBullet = function(arg_50_0)
	return var_0_3.TargetAllHarmBulletByType(arg_50_0, ys.Battle.BattleConst.BulletType.TORPEDO)
end
;({}).TargetFleetIndex = function(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_0 and arg_51_0:GetIFF() or var_0_0.FRIENDLY_CODE
	local var_51_1 = ys.Battle.BattleDataProxy.GetInstance():GetFleetByIFF(var_51_0)
	local var_51_2 = var_51_1:GetUnitList()
	local var_51_3 = var_51_1:GetScoutList()

	if arg_51_1.exceptCaster then
		local var_51_4 = arg_51_0:GetUniqueID()
	end

	for iter_51_0, iter_51_1 in ipairs(var_51_2) do
		local var_51_5 = iter_51_1:GetUniqueID()

		if arg_51_1.exceptCaster and var_51_5 == casterID then
			-- block empty
		elseif iter_51_1 == var_51_1:GetFlagShip() then
			if arg_51_1.fleetPos == TeamType.TeamPos.FLAG_SHIP then
				table.insert({}, iter_51_1)
			end
		elseif iter_51_1 == var_51_3[1] then
			if arg_51_1.fleetPos == TeamType.TeamPos.LEADER then
				table.insert({}, iter_51_1)
			end
		elseif #var_51_3 == 3 and iter_51_1 == var_51_3[2] then
			if arg_51_1.fleetPos == TeamType.TeamPos.CENTER then
				table.insert({}, iter_51_1)
			end
		elseif iter_51_1 == var_51_3[#var_51_3] then
			if arg_51_1.fleetPos == TeamType.TeamPos.REAR then
				table.insert({}, iter_51_1)
			end
		elseif iter_51_1:IsMainFleetUnit() and iter_51_1:GetMainUnitIndex() == 2 then
			if arg_51_1.fleetPos == TeamType.TeamPos.UPPER_CONSORT then
				table.insert({}, iter_51_1)
			end
		elseif iter_51_1:IsMainFleetUnit() and iter_51_1:GetMainUnitIndex() == 3 and arg_51_1.fleetPos == TeamType.TeamPos.LOWER_CONSORT then
			table.insert({}, iter_51_1)
		end
	end

	local var_51_6 = var_51_1:GetSubList()

	for iter_51_2, iter_51_3 in ipairs(var_51_2) do
		if iter_51_2 == 1 then
			if arg_51_1.fleetPos == TeamType.TeamPos.SUB_LEADER then
				table.insert({}, iter_51_3)
			end
		elseif arg_51_1.fleetPos == TeamType.TeamPos.SUB_CONSORT then
			table.insert({}, iter_51_3)
		end
	end

	return {}
end
;({}).TargetPlayerVanguardFleet = function(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = ys.Battle.BattleDataProxy.GetInstance():GetFleetByIFF(arg_52_0:GetIFF()):GetScoutList()

	if not arg_52_2 then
		return var_52_0
	else
		local var_52_1 = #arg_52_2

		while var_52_1 > 0 do
			if not table.contains(var_52_0, arg_52_2[var_52_1]) then
				table.remove(arg_52_2, var_52_1)
			end

			var_52_1 = var_52_1 - 1
		end

		return arg_52_2
	end

	return
end
;({}).TargetPlayerMainFleet = function(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = ys.Battle.BattleDataProxy.GetInstance():GetFleetByIFF(arg_53_0:GetIFF()):GetMainList()

	if not arg_53_2 then
		return var_53_0
	else
		local var_53_1 = #arg_53_2

		while var_53_1 > 0 do
			if not table.contains(var_53_0, arg_53_2[var_53_1]) then
				table.remove(arg_53_2, var_53_1)
			end

			var_53_1 = var_53_1 - 1
		end

		return arg_53_2
	end

	return
end
;({}).TargetPlayerFlagShip = function(arg_54_0, arg_54_1, arg_54_2)
	return {
		ys.Battle.BattleDataProxy.GetInstance():GetFleetByIFF(arg_54_0:GetIFF()):GetFlagShip()
	}
end
;({}).TargetPlayerLeaderShip = function(arg_55_0, arg_55_1, arg_55_2)
	return {
		ys.Battle.BattleDataProxy.GetInstance():GetFleetByIFF(arg_55_0:GetIFF()):GetLeaderShip()
	}
end
;({}).TargetEnemyLeaderShip = function(arg_56_0, arg_56_1, arg_56_2)
	return {
		ys.Battle.BattleDataProxy.GetInstance():GetFleetByIFF(arg_56_0:GetIFF() * -1):GetLeaderShip()
	}
end
;({}).TargetPlayerByType = function(arg_57_0, arg_57_1)
	for iter_57_0, iter_57_1 in ipairs((ys.Battle.BattleDataProxy.GetInstance():GetFleetByIFF(arg_57_0:GetIFF()):GetUnitList())) do
		if iter_57_1:GetTemplate().type == arg_57_1.shipType then
			({})[#{} + 1] = iter_57_1
		end
	end

	return {}
end
;({}).TargetPlayerAidUnit = function(arg_58_0, arg_58_1)
	for iter_58_0, iter_58_1 in pairs((ys.Battle.BattleDataProxy.GetInstance():GetAidUnit())) do
		table.insert({}, iter_58_1)
	end

	return {}
end
;({}).TargetDamageSource = function(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = {}

	for iter_59_0, iter_59_1 in pairs(arg_59_2 or var_0_3.TargetAllFoe(arg_59_0)) do
		if iter_59_1:GetUniqueID() == arg_59_1.damageSourceID then
			table.insert(var_59_0, iter_59_1)

			break
		end
	end

	return var_59_0
end
;({}).TargetRarity = function(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = {}

	for iter_60_0, iter_60_1 in ipairs(arg_60_2 or var_0_3.TargetAllHelp(arg_60_0)) do
		if iter_60_1:GetRarity() == arg_60_1.rarity then
			table.insert(var_60_0, iter_60_1)
		end
	end

	return var_60_0
end
;({}).TargetIllustrator = function(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = {}

	for iter_61_0, iter_61_1 in ipairs(arg_61_2 or var_0_3.TargetAllHelp(arg_61_0)) do
		if ys.Battle.BattleDataFunction.GetPlayerShipSkinDataFromID(iter_61_1:GetSkinID()).illustrator == arg_61_1.illustrator then
			table.insert(var_61_0, iter_61_1)
		end
	end

	return var_61_0
end
;({}).TargetTeam = function(arg_62_0, arg_62_1, arg_62_2)
	local var_62_0 = ys.Battle.BattleDataProxy.GetInstance():GetFleetByIFF(arg_62_0:GetIFF())
	local var_62_1 = {}

	if TeamType.TeamTypeIndex[arg_62_1.teamIndex] == TeamType.Vanguard then
		var_62_1 = var_62_0:GetScoutList()
	elseif TeamType.TeamTypeIndex[arg_62_1.teamIndex] == TeamType.Main then
		var_62_1 = var_62_0:GetMainList()
	elseif TeamType.TeamTypeIndex[arg_62_1.teamIndex] == TeamType.Submarine then
		var_62_1 = var_62_0:GetSubList()
	end

	local var_62_2 = {}

	for iter_62_0, iter_62_1 in ipairs(var_62_1) do
		if not arg_62_2 or table.contains(arg_62_2, iter_62_1) then
			table.insert(var_62_2, iter_62_1)
		end
	end

	return var_62_2
end
;({}).TargetGroup = function(arg_63_0, arg_63_1, arg_63_2)
	local var_63_0 = {}
	local var_63_1 = arg_63_0:GetIFF()

	for iter_63_0, iter_63_1 in ipairs(arg_63_2 or var_0_3.TargetAllHelp(arg_63_0)) do
		local var_63_2 = iter_63_1:GetIFF()

		if table.contains(arg_63_1.groupIDList, ys.Battle.BattleDataFunction.GetPlayerShipModelFromID((iter_63_1:GetTemplateID())).group_type) and var_63_1 == var_63_2 then
			var_63_0[#var_63_0 + 1] = iter_63_1
		end
	end

	return var_63_0
end
;({}).LegalTarget = function(arg_64_0)
	local var_64_1 = ys.Battle.BattleDataProxy.GetInstance()
	local var_64_2, var_64_3, var_64_4, var_64_5 = var_64_1:GetFieldBound()
	local var_64_6 = arg_64_0:GetIFF()

	for iter_64_0, iter_64_1 in pairs((var_64_1:GetUnitList())) do
		if iter_64_1:IsAlive() and iter_64_1:GetIFF() ~= var_64_6 and var_64_5 > iter_64_1:GetPosition().x and not iter_64_1:IsSpectre() then
			({})[#{} + 1] = iter_64_1
		end
	end

	return {}
end
;({}).LegalWeaponTarget = function(arg_65_0)
	local var_65_1 = arg_65_0:GetIFF()

	for iter_65_0, iter_65_1 in pairs((ys.Battle.BattleDataProxy.GetInstance():GetUnitList())) do
		if iter_65_1:GetIFF() ~= var_65_1 and not iter_65_1:IsSpectre() then
			({})[#{} + 1] = iter_65_1
		end
	end

	return {}
end

return
