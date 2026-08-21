ys = ys or {}

local var_0_6 = ys.Battle.BattleCardPuzzleConfig
local var_0_10 = class("BattleFleetCardPuzzleAttribute")

ys.Battle.BattleFleetCardPuzzleAttribute = var_0_10
var_0_10.__name = "BattleFleetCardPuzzleAttribute"

function var_0_10.Ctor(arg_1_0, arg_1_1)
	arg_1_0:init()

	arg_1_0._client = arg_1_1

	return
end

function var_0_10.init(arg_2_0)
	arg_2_0._buffAttr = {}
	arg_2_0._attrList = {}
	arg_2_0._clampList = {}

	return
end

function var_0_10.AddBaseAttr(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0._attrList[arg_3_1] or 0

	arg_3_0._attrList[arg_3_1] = math.max(0, arg_3_2 + var_3_0)
	arg_3_0._attrList[arg_3_1] = arg_3_0:checkClamp(arg_3_1)

	arg_3_0._client:DispatchUpdateAttr(arg_3_1)
	arg_3_0:specificAttrUpdate(arg_3_1)

	return
end

function var_0_10.SetAttr(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._attrList[arg_4_1] = arg_4_2
	arg_4_0._attrList[arg_4_1] = arg_4_0:checkClamp(arg_4_1)

	arg_4_0._client:DispatchUpdateAttr(arg_4_1)
	arg_4_0:specificAttrUpdate(arg_4_1)

	return
end

function var_0_10.specificAttrUpdate(arg_5_0, arg_5_1)
	if arg_5_1 == "BaseEnergyBoostRate" or arg_5_1 == "BaseEnergyBoostExtra" then
		arg_5_0._client:FlushHandOverheat()
	end

	return
end

function var_0_10.checkClamp(arg_6_0, arg_6_1)
	if arg_6_0._attrList[arg_6_1] == nil then
		return
	end

	local var_6_0 = arg_6_0._attrList[arg_6_1]

	if var_0_6.FleetAttrClamp[arg_6_1] then
		local var_6_1 = arg_6_0._attrList[var_0_6.FleetAttrClamp[arg_6_1].min] or 0

		var_6_0 = math.max(var_6_0, var_6_1)
		var_6_0 = arg_6_0._attrList[var_0_6.FleetAttrClamp[arg_6_1].max] and math.min(var_6_0, arg_6_0._attrList[var_0_6.FleetAttrClamp[arg_6_1].max]) or var_6_0
	end

	return var_6_0
end

function var_0_10.GetCurrent(arg_7_0, arg_7_1)
	return arg_7_0._attrList[arg_7_1] or 0
end

return
