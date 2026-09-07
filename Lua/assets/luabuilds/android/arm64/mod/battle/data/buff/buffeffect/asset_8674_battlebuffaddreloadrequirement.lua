ys = ys or {}

local var_0_0 = ys.Battle.BattleConst
local var_0_1 = ys.Battle.BattleAttr
local BattleBuffAddReloadRequirement = class("BattleBuffAddReloadRequirement", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAddReloadRequirement = BattleBuffAddReloadRequirement
BattleBuffAddReloadRequirement.__name = "BattleBuffAddReloadRequirement"

function BattleBuffAddReloadRequirement:Ctor(arg_1_1)
	BattleBuffAddReloadRequirement.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAddReloadRequirement:SetArgs(arg_2_1, arg_2_2)
	self._weaponIndex = self._tempData.arg_list.index
	self._weaponType = self._tempData.arg_list.type
	self._value = self._tempData.arg_list.number or 0
	self._convertAttr = self._tempData.arg_list.convert_attr
	self._convertValue = self._tempData.arg_list.convert_value

	return
end

function BattleBuffAddReloadRequirement:onAttach(arg_3_1, arg_3_2)
	local var_3_0 = {}

	if self._weaponType then
		local var_3_1 = self._weaponType == var_0_0.EquipmentType.POINT_HIT_AND_LOCK and arg_3_1:GetChargeList() or self._weaponType == var_0_0.EquipmentType.MANUAL_TORPEDO and arg_3_1:GetTorpedoList() or (self._weaponType == var_0_0.EquipmentType.INTERCEPT_AIRCRAFT or self._weaponType == var_0_0.EquipmentType.STRIKE_AIRCRAFT) and arg_3_1:GetHiveList() or self._weaponType == var_0_0.EquipmentType.AIR_ASSIST and arg_3_1:GetAirAssistList() or arg_3_1:GetAutoWeapons()

		if var_3_1 then
			for iter_3_0, iter_3_1 in ipairs(var_3_1) do
				var_3_0[#var_3_0 + 1] = iter_3_1
			end
		end
	elseif self._weaponIndex then
		for iter_3_2, iter_3_3 in ipairs((arg_3_1:GetTotalWeapon())) do
			if iter_3_3:GetEquipmentIndex() == self._weaponIndex then
				var_3_0[#var_3_0 + 1] = iter_3_3
			end
		end
	else
		assert(false, "BattleBuffAddReloadRequirement：缺少指定类型或索引")
	end

	for iter_3_4, iter_3_5 in ipairs(var_3_0) do
		iter_3_5:AppendReloadFactor(arg_3_2, self:calcFactor(arg_3_2:GetCaster()))

		local var_3_2 = 1

		for iter_3_6, iter_3_7 in pairs((iter_3_5:GetReloadFactorList())) do
			var_3_2 = var_3_2 + iter_3_7
		end

		iter_3_5:FlushReloadMax(var_3_2)
	end

	self._targetWeaponList = var_3_0

	return
end

function BattleBuffAddReloadRequirement:onRemove(arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(self._targetWeaponList) do
		iter_4_1:RemoveReloadFactor(arg_4_2)

		local var_4_0 = 1

		for iter_4_2, iter_4_3 in pairs((iter_4_1:GetReloadFactorList())) do
			var_4_0 = var_4_0 + iter_4_3
		end

		iter_4_1:FlushReloadMax(var_4_0)
	end

	return
end

function BattleBuffAddReloadRequirement:calcFactor(arg_5_1)
	local var_5_0 = 0

	if self._convertAttr == nil then
		-- block empty
	else
		var_5_0 = (self._convertAttr == "HPRate" or self._convertAttr == "DMGRate") and var_0_1.GetCurrent(arg_5_1, self._convertAttr) * self._convertValue or var_0_1.GetBase(arg_5_1, self._convertAttr) * self._convertValue
	end

	return self._value + var_5_0
end

return
