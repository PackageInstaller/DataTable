ys = ys or {}
ys.Battle.BattleChargeArea = class("BattleChargeArea")
ys.Battle.BattleChargeArea.__name = "BattleChargeArea"

function ys.Battle.BattleChargeArea.Ctor(arg_1_0, arg_1_1)
	arg_1_1.gameObject:SetActive(false)

	arg_1_0._areaTf = arg_1_1.transform
	arg_1_0._areaGO = arg_1_1

	return
end

function ys.Battle.BattleChargeArea.InitArea(arg_2_0)
	arg_2_0._controller = arg_2_0._areaTf:GetComponent("ChargeArea")

	local var_2_0 = arg_2_0._chargeWeapon:GetTemplateData().range

	arg_2_0._areaTf.localScale.x = var_2_0 / 5.5
	arg_2_0._areaTf.localScale.y = var_2_0 / 5.5
	arg_2_0._areaTf.localScale = arg_2_0._areaTf.localScale
	arg_2_0._controller.maxAngle = arg_2_0._chargeWeapon:GetTemplateData().angle
	arg_2_0._controller.minAngle = arg_2_0._chargeWeapon:GetMinAngle()
	arg_2_0._areaTf:Find("UpperEdge").transform.localScale = Vector3(1, 1 / arg_2_0._areaTf.localScale.y, 1)
	arg_2_0._areaTf:Find("LowerEdge").transform.localScale = Vector3(1, 1 / arg_2_0._areaTf.localScale.y, 1)
	arg_2_0._controller.rate = 0.5

	return
end

function ys.Battle.BattleChargeArea.Update(arg_3_0, arg_3_1)
	arg_3_0._areaTf.position = arg_3_1

	return
end

function ys.Battle.BattleChargeArea.SetWeapon(arg_4_0, arg_4_1)
	arg_4_0._chargeWeapon = arg_4_1

	arg_4_0:InitArea()

	return
end

function ys.Battle.BattleChargeArea.SetActive(arg_5_0, arg_5_1)
	arg_5_0._areaGO:SetActive(arg_5_1)

	return
end

function ys.Battle.BattleChargeArea.GetActive(arg_6_0)
	return arg_6_0._areaGO:GetActive()
end

function ys.Battle.BattleChargeArea.Reset(arg_7_0)
	arg_7_0._controller.rate = 1

	return
end

return
