ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig

class = var_0_10003

local var_0_3 = var_0_10003("BattleEnvironmentBehaviourPlayFX", var_0.Battle.BattleEnvironmentBehaviour)

var_0.Battle.BattleEnvironmentBehaviourPlayFX = var_0_3
var_0_3.__name = "BattleEnvironmentBehaviourPlayFX"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.SetTemplate(arg_2_0, arg_2_1)
	var_0_3.super.SetTemplate(arg_2_0, arg_2_1)

	arg_2_0._FXID = arg_2_0._tmpData.FX_ID

	if arg_2_0._tmpData.offset then
		Vector3 = var_2_0
		unpack = var_3

		local var_2_0

		if not var_2_0(var_3(arg_2_0._tmpData.offset)) then
			Vector3 = var_2_0
			var_2_0 = var_2_0.zero
		end

		arg_2_0._offset = var_2_0

		return
	end
end

function var_0_3.doBehaviour(arg_3_0)
	local var_3_0 = 1

	if arg_3_0._tmpData.scaleRate then
		local var_3_1 = arg_3_0._unit
		local var_3_2 = var_2.GetAOEData(var_3_1)
		local var_3_3 = var_2.GetAreaType(var_3_2)
		local var_3_4

		if var_3_3 == var_0_1.AreaType.CUBE then
			var_3_4 = var_2:GetWidth()
		elseif var_3_3 == var_0_1.AreaType.COLUMN then
			var_3_4 = var_2:GetRange()
		end

		var_3_0 = arg_3_0._tmpData.scaleRate * var_3_4
	elseif arg_3_0._tmpData.scale then
		var_3_0 = arg_3_0._tmpData.scale
	end

	local var_3_5 = arg_3_0._unit
	local var_3_6 = var_2.GetAOEData(var_3_5)
	local var_3_7 = var_2.GetPosition(var_3_6) + arg_3_0._offset
	local var_3_8 = var_0.Battle.BattleDataProxy.GetInstance()

	var_3.SpawnEffect(var_3_8, arg_3_0._FXID, var_3_7, var_3_0)
	var_0_3.super.doBehaviour(arg_3_0)

	return
end

return
