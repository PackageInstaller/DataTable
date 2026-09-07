ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffAddBulletAttr = class("BattleBuffAddBulletAttr", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffAddBulletAttr.__name = "BattleBuffAddBulletAttr"

local var_0_1 = ys.Battle.BattleBuffAddBulletAttr

function ys.Battle.BattleBuffAddBulletAttr.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffAddBulletAttr:SetArgs(arg_2_1, arg_2_2)
	self._attr = self._tempData.arg_list.attr
	self._number = self._tempData.arg_list.number
	self._rate = self._tempData.arg_list.rate or 10000
	self._bulletID = self._tempData.arg_list.bulletID
	self._weaponIndexList = self._tempData.arg_list.index
	self._numberBase = self._number
	self._displacementConvert = self._tempData.arg_list.displacement_convert
	self._displacementDynamic = self._tempData.arg_list.displacement_convert_dynamic

	return
end

function ys.Battle.BattleBuffAddBulletAttr:onStack(arg_3_1, arg_3_2)
	self._number = self._numberBase * arg_3_2._stack

	return
end

function ys.Battle.BattleBuffAddBulletAttr:onBulletCreate(arg_4_1, arg_4_2, arg_4_3)
	if not self:equipIndexRequire(arg_4_3.equipIndex) then
		return
	end

	self:calcBulletAttr(arg_4_3)

	return
end

function ys.Battle.BattleBuffAddBulletAttr:onInternalBulletCreate(arg_5_1, arg_5_2, arg_5_3)
	if not self:equipIndexRequire(arg_5_3.equipIndex) then
		return
	end

	self:calcBulletAttr(arg_5_3)

	return
end

function ys.Battle.BattleBuffAddBulletAttr:onManualBulletCreate(arg_6_1, arg_6_2, arg_6_3)
	if not self:equipIndexRequire(arg_6_3.equipIndex) then
		return
	end

	self:calcBulletAttr(arg_6_3)

	return
end

function ys.Battle.BattleBuffAddBulletAttr:onBulletCollideBefore(arg_7_1, arg_7_2, arg_7_3)
	if not self:equipIndexRequire(arg_7_3.equipIndex) then
		return
	end

	self:displacementConvert(arg_7_3, arg_7_1)
	self:calcBulletAttr(arg_7_3)

	return
end

function ys.Battle.BattleBuffAddBulletAttr:onBombBulletBang(arg_8_1, arg_8_2, arg_8_3)
	if not self:equipIndexRequire(arg_8_3.equipIndex) then
		return
	end

	self:displacementConvert(arg_8_3, arg_8_1)
	self:calcBulletAttr(arg_8_3)

	return
end

function ys.Battle.BattleBuffAddBulletAttr:onTorpedoBulletBang(arg_9_1, arg_9_2, arg_9_3)
	if not self:equipIndexRequire(arg_9_3.equipIndex) then
		return
	end

	self:displacementConvert(arg_9_3, arg_9_1)
	self:calcBulletAttr(arg_9_3)

	return
end

function ys.Battle.BattleBuffAddBulletAttr:displacementConvert(arg_10_1, arg_10_2)
	if self._displacementConvert then
		local var_10_0 = arg_10_1._bullet:GetCurrentDistance()

		if self._displacementConvert.rate > 0 then
			self._number = math.min(math.max(var_10_0 - self._displacementConvert.base, 0) * self._displacementConvert.rate, self._displacementConvert.max)
		elseif self._displacementConvert.rate < 0 then
			self._number = math.min(math.max(0, self._displacementConvert.max + (var_10_0 - self._displacementConvert.base) * self._displacementConvert.rate), self._displacementConvert.max)
		elseif self._displacementConvert.rate == 0 then
			self._number = 0
		end
	elseif self._displacementDynamic then
		local var_10_1 = self:getTargetList(arg_10_2, self._displacementDynamic.check_caster, self._displacementDynamic)

		self._number = var_10_1 and #var_10_1 > 0 and math.min(math.max(Vector3.Distance(var_10_1[1]:GetPosition(), (arg_10_1._bullet:GetPosition())) - self._displacementDynamic.base, 0) * self._displacementDynamic.rate, self._displacementDynamic.max) or 0
	end

	return
end

function ys.Battle.BattleBuffAddBulletAttr:calcBulletAttr(arg_11_1)
	if var_0_0.Battle.BattleFormulas.IsHappen(self._rate) then
		local var_11_0 = arg_11_1._bullet
		local var_11_1 = arg_11_1._bullet:GetWeapon():GetEquipmentIndex()
		local var_11_2 = false

		if not self._weaponIndexList then
			var_11_2 = true
		elseif #self._weaponIndexList == 0 and var_11_1 == nil then
			var_11_2 = true
		elseif table.contains(self._weaponIndexList, var_11_1) then
			var_11_2 = true
		end

		if var_11_2 then
			if self._bulletID then
				if var_11_0:GetTemplate().id == self._bulletID then
					var_0_0.Battle.BattleAttr.Increase(var_11_0, self._attr, self._number)
				end
			else
				var_0_0.Battle.BattleAttr.Increase(var_11_0, self._attr, self._number)
			end
		end
	end

	return
end

return
