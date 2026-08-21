ys = ys or {}

local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = class("BattleReisalinAPView")

ys.Battle.BattleReisalinAPView = var_0_2
var_0_2.__name = "BattleReisalinAPView"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1

	arg_1_0:init()

	return
end

function var_0_2.init(arg_2_0)
	arg_2_0._apCap = var_0_1.FLEET_ATTR_CAP[arg_2_0:GetAttrName()]
	arg_2_0._count = findTF(arg_2_0._tf, "count")
	arg_2_0._glow = findTF(arg_2_0._tf, "glow_gizmos")
	arg_2_0._countText = arg_2_0._count:GetComponent(typeof(Text))

	SetActive(arg_2_0._tf, true)
	arg_2_0:UpdateAP(0)

	return
end

function var_0_2.UpdateAP(arg_3_0, arg_3_1)
	arg_3_0._countText.text = arg_3_1

	if arg_3_1 >= arg_3_0._apCap then
		arg_3_0._countText.color = Color.ReisalinGold

		SetActive(arg_3_0._glow, true)
	else
		arg_3_0._countText.color = Color.white

		SetActive(arg_3_0._glow, false)
	end

	return
end

function var_0_2.GetAttrName(arg_4_0)
	return var_0_1.ALCHEMIST_AP_NAME
end

function var_0_2.Dispose(arg_5_0)
	arg_5_0._count = nil
	arg_5_0._glow = nil
	arg_5_0._countText = nil
	arg_5_0._tf = nil

	return
end

return
