ys = ys or {}

local BattleBuffHP = class("BattleBuffHP", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffHP = BattleBuffHP
BattleBuffHP.__name = "BattleBuffHP"

function BattleBuffHP:Ctor(arg_1_1)
	BattleBuffHP.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffHP:SetArgs(arg_2_1, arg_2_2)
	self._number = self._tempData.arg_list.number or 0
	self._numberBase = self._number
	self._currentHPRatio = 0

	if self._tempData.arg_list.currentHPRatio then
		self._currentHPRatio = self._tempData.arg_list.currentHPRatio * 0.0001
	end

	local var_2_0, var_2_1 = arg_2_1:GetHP()
	local var_2_2, var_2_3 = self._caster:GetHP()

	self._maxHPRatio = self._tempData.arg_list.maxHPRatio or 0
	self._maxHPNumber = var_2_1 * self._maxHPRatio
	self._castMaxHPRatio = self._tempData.arg_list.casterMaxHPRatio or 0
	self._castMaxHPNumber = self._castMaxHPRatio * var_2_3
	self._castHPRatio = self._tempData.arg_list.casterHPRatio or 0
	self._weaponType = self._tempData.arg_list.weaponType
	self._damageConvert = 0

	if self._tempData.arg_list.damageConvertRatio then
		self._damageConvert = self._tempData.arg_list.damageConvertRatio * 0.0001
	end

	self._incorruptible = self._tempData.arg_list.incorrupt

	return
end

function BattleBuffHP:onBulletHit(arg_3_1, arg_3_2, arg_3_3)
	if not self:equipIndexRequire(arg_3_3.equipIndex) then
		return
	end

	if not self:bulletTagRequire(arg_3_3.bulletTag) then
		return
	end

	if not self:victimRequire(arg_3_3.target, arg_3_1) then
		return
	end

	local var_3_0 = arg_3_1:GetAttrByName("healingRate")

	if not self._weaponType then
		local var_3_1 = self._number
		local var_3_2 = self._number > 0

		if self._number > 0 then
			var_3_1 = math.floor(var_3_1 * var_3_0)
		end

		arg_3_3.target:UpdateHP(var_3_1, {
			isMiss = false,
			isCri = false,
			isHeal = var_3_2
		})
	elseif arg_3_3.weaponType == self._weaponType then
		arg_3_1:UpdateHP(math.floor(arg_3_3.damage * self._damageConvert * var_3_0), {
			isMiss = false,
			isCri = false,
			isHeal = true,
			incorrupt = self._incorruptible
		})
	end

	return
end

function BattleBuffHP:onAttach(arg_4_1, arg_4_2)
	onDelayTick(function()
		BattleBuffHP.super.onAttach(self, arg_4_1, arg_4_2)

		return
	end, 0.03)

	return
end

function BattleBuffHP:onTrigger(arg_6_1, arg_6_2)
	local var_6_0 = self:CalcNumber(arg_6_1)
	local var_6_1 = var_6_0 > 0

	if var_6_0 > 0 then
		var_6_0 = math.floor(var_6_0 * arg_6_1:GetAttrByName("healingRate"))
	end

	arg_6_1:UpdateHP(var_6_0, {
		isMiss = false,
		isCri = false,
		isHeal = var_6_1,
		incorrupt = self._incorruptible
	})

	return
end

function BattleBuffHP:CalcNumber(arg_7_1)
	return math.floor((arg_7_1:GetHP() * self._currentHPRatio + self._maxHPNumber + self._number + self._castMaxHPNumber + self._caster:GetHP() * self._castHPRatio) * (self._caster:GetAttrByName("healingEnhancement") + 1))
end

return
