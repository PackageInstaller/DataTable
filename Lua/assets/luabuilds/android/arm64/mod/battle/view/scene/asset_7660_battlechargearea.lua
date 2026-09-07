ys = ys or {}
ys.Battle.BattleChargeArea = class("BattleChargeArea")
ys.Battle.BattleChargeArea.__name = "BattleChargeArea"

function ys.Battle.BattleChargeArea.Ctor(arg_1_0, arg_1_1)
	arg_1_1.gameObject:SetActive(false)

	arg_1_0._areaTf = arg_1_1.transform
	arg_1_0._areaGO = arg_1_1

	return
end

function ys.Battle.BattleChargeArea:InitArea()
	self._controller = self._areaTf:GetComponent("ChargeArea")

	local var_2_0 = self._chargeWeapon:GetTemplateData().range

	self._areaTf.localScale.x = var_2_0 / 5.5
	self._areaTf.localScale.y = var_2_0 / 5.5
	self._areaTf.localScale = self._areaTf.localScale
	self._controller.maxAngle = self._chargeWeapon:GetTemplateData().angle
	self._controller.minAngle = self._chargeWeapon:GetMinAngle()
	self._areaTf:Find("UpperEdge").transform.localScale = Vector3(1, 1 / self._areaTf.localScale.y, 1)
	self._areaTf:Find("LowerEdge").transform.localScale = Vector3(1, 1 / self._areaTf.localScale.y, 1)
	self._controller.rate = 0.5

	return
end

function ys.Battle.BattleChargeArea:Update(arg_3_1)
	self._areaTf.position = arg_3_1

	return
end

function ys.Battle.BattleChargeArea:SetWeapon(arg_4_1)
	self._chargeWeapon = arg_4_1

	self:InitArea()

	return
end

function ys.Battle.BattleChargeArea:SetActive(arg_5_1)
	self._areaGO:SetActive(arg_5_1)

	return
end

function ys.Battle.BattleChargeArea:GetActive()
	return self._areaGO:GetActive()
end

function ys.Battle.BattleChargeArea:Reset()
	self._controller.rate = 1

	return
end

return
