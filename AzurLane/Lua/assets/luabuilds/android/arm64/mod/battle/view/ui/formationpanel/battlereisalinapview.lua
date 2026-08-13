ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleConfig

class = var_0_10003

local var_0_3 = var_0_10003("BattleReisalinAPView")

var_0.Battle.BattleReisalinAPView = var_0_3
var_0_3.__name = "BattleReisalinAPView"

function var_0_3.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1

	arg_1_0:init()

	return
end

function var_0_3.init(arg_2_0)
	arg_2_0._apCap = var_0_2.FLEET_ATTR_CAP[arg_2_0:GetAttrName()]
	findTF = var_1
	arg_2_0._count = var_1(arg_2_0._tf, "count")
	findTF = var_1
	arg_2_0._glow = var_1(arg_2_0._tf, "glow_gizmos")

	local var_2_0 = arg_2_0._count
	local var_2_1 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0._countText = var_2_1(var_2_0, var_4(var_1_10006))
	SetActive = var_1

	var_1(arg_2_0._tf, true)
	arg_2_0:UpdateAP(0)

	return
end

function var_0_3.UpdateAP(arg_3_0, arg_3_1)
	arg_3_0._countText.text = arg_3_1

	if arg_3_1 >= arg_3_0._apCap then
		local var_3_0 = arg_3_0._countText

		Color = var_1_10003
		var_3_0.color = var_1_10003.ReisalinGold
		SetActive = var_3_0

		var_3_0(arg_3_0._glow, true)
	else
		local var_3_1 = arg_3_0._countText

		Color = var_1_10003
		var_3_1.color = var_1_10003.white
		SetActive = var_3_1

		var_3_1(arg_3_0._glow, false)
	end

	return
end

function var_0_3.GetAttrName(arg_4_0)
	return var_0_2.ALCHEMIST_AP_NAME
end

function var_0_3.Dispose(arg_5_0)
	arg_5_0._count = nil
	arg_5_0._glow = nil
	arg_5_0._countText = nil
	arg_5_0._tf = nil

	return
end

return
