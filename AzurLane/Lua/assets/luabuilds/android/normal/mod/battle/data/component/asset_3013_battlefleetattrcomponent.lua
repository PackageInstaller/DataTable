ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10001
var_0_1.BattleFleetAttrComponent = var_0_10001("BattleFleetAttrComponent")
ys = var_0_1

local var_0_2 = var_0_1.Battle.BattleFleetAttrComponent

var_0_2.__name = "BattleFleetAttrComponent"
ys = var_0_2

local var_0_3 = var_0_2.Battle.BattleFleetAttrComponent

ys = var_1

local var_0_4 = var_1.Battle.BattleConst

ys = var_2

local var_0_5 = var_2.Battle.BattleConfig

ys = var_0_10003

local var_0_6 = var_0_10003.Battle.BattleEvent

function var_0_3.Ctor(arg_1_0, arg_1_1)
	arg_1_0._client = arg_1_1

	arg_1_0:initFleetAttr()

	return
end

function var_0_3.Dispose(arg_2_0)
	arg_2_0._client = nil

	return
end

function var_0_3.initFleetAttr(arg_3_0)
	arg_3_0._fleetAttrList = {}

	return
end

function var_0_3.GetCurrent(arg_4_0, arg_4_1)
	local var_4_0

	if not arg_4_0._fleetAttrList[arg_4_1] then
		var_4_0 = 0
	end

	return var_4_0
end

function var_0_3.SetCurrent(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:GetCurrent(arg_5_1)

	if var_0_5.FLEET_ATTR_CAP[arg_5_1] then
		Mathf = var_5
		arg_5_2 = var_5.Clamp(arg_5_2, 0, var_4)
	else
		math = var_5
		arg_5_2 = var_5.max(arg_5_2, 0)
	end

	arg_5_0._fleetAttrList[arg_5_1] = arg_5_2

	if var_5_0 ~= arg_5_2 then
		local var_5_1 = arg_5_2 - var_5_0
		local var_5_2 = arg_5_0._client

		var_6.FleetBuffTrigger(var_5_2, var_0_4.BuffEffectType.ON_FLEET_ATTR_UPDATE, {
			attr = arg_5_1,
			value = arg_5_2,
			delta = var_5_1
		})

		local var_5_3 = arg_5_0._client
		local var_5_4 = var_6.DispatchEvent

		ys = var_8

		var_5_4(var_5_3, var_8.Event.New(var_0_6.UPDATE_FLEET_ATTR, {
			attr = arg_5_1,
			value = arg_5_2
		}))
	end

	return
end

return
