ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent
local var_0_3 = var_0.Battle.BattleCardPuzzleEvent
local var_0_4 = var_0.Battle.BattleFormulas
local var_0_5 = var_0.Battle.BattleConst
local var_0_6 = var_0.Battle.BattleConfig
local var_0_7 = var_0.Battle.BattleCardPuzzleConfig
local var_0_8 = var_0.Battle.BattleAttr
local var_0_9 = var_0.Battle.BattleDataFunction
local var_0_10 = var_0.Battle.BattleAttr

class = var_0_10011

local var_0_11 = var_0_10011("BattleFleetCardPuzzleAttribute")

var_0.Battle.BattleFleetCardPuzzleAttribute = var_0_11
var_0_11.__name = "BattleFleetCardPuzzleAttribute"

function var_0_11.Ctor(arg_1_0, arg_1_1)
	arg_1_0:init()

	arg_1_0._client = arg_1_1

	return
end

function var_0_11.init(arg_2_0)
	arg_2_0._buffAttr = {}
	arg_2_0._attrList = {}
	arg_2_0._clampList = {}

	return
end

function var_0_11.AddBaseAttr(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0._attrList

	math = var_1_10004

	local var_3_1 = var_1_10004.max
	local var_3_2 = 0
	local var_3_3

	if not arg_3_0._attrList[arg_3_1] then
		var_3_3 = 0
	end

	var_3_0[arg_3_1] = var_3_1(var_3_2, arg_3_2 + var_3_3)
	arg_3_0._attrList[arg_3_1] = arg_3_0:checkClamp(arg_3_1)

	local var_3_4 = arg_3_0._client

	var_3.DispatchUpdateAttr(var_3_4, arg_3_1)
	arg_3_0:specificAttrUpdate(arg_3_1)

	return
end

function var_0_11.SetAttr(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._attrList[arg_4_1] = arg_4_2
	arg_4_0._attrList[arg_4_1] = arg_4_0:checkClamp(arg_4_1)

	local var_4_0 = arg_4_0._client

	var_3.DispatchUpdateAttr(var_4_0, arg_4_1)
	arg_4_0:specificAttrUpdate(arg_4_1)

	return
end

function var_0_11.specificAttrUpdate(arg_5_0, arg_5_1)
	if arg_5_1 == "BaseEnergyBoostRate" or arg_5_1 == "BaseEnergyBoostExtra" then
		local var_5_0 = arg_5_0._client

		var_2.FlushHandOverheat(var_5_0)
	end

	return
end

function var_0_11.checkClamp(arg_6_0, arg_6_1)
	if arg_6_0._attrList[arg_6_1] == nil then
		return
	end

	local var_6_0 = arg_6_0._attrList[arg_6_1]

	if var_0_7.FleetAttrClamp[arg_6_1] then
		local var_6_1 = arg_6_0._attrList[var_3.max]
		local var_6_2

		if not arg_6_0._attrList[var_3.min] then
			var_6_2 = 0
		end

		math = var_6
		var_6_0 = var_6.max(var_6_0, var_6_2)

		if var_6_1 then
			math = var_6
			var_6_0 = var_6.min(var_6_0, var_6_1) or var_6_0
		end
	end

	return var_6_0
end

function var_0_11.GetCurrent(arg_7_0, arg_7_1)
	local var_7_0

	if not arg_7_0._attrList[arg_7_1] then
		var_7_0 = 0
	end

	return var_7_0
end

return
