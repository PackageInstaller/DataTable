local var_0_0 = tostring
local var_0_1 = {}

function var_0_1:initRule()
	local var_1_0 = self:getCommonSkillCfg()
	local var_1_1 = self:getActiveSkillCfg()
	local var_1_2 = self:getSpRules()

	var_1_0 = var_1_2.commonSkill or var_1_0
	var_1_1 = var_1_2.activeSkill or var_1_1

	var_0_1._initSpecialRule(var_1_0)
	var_0_1._initSpecialRule(var_1_1)

	return {}
end

function var_0_1:_initSpecialRule()
	if self.special_effect_type_1 == 0 then
		return
	end

	local var_2_0 = var_0_1["_initSkillEffectType" .. var_0_0(self.special_effect_type_1)]

	assert(var_2_0, "Invalid skill_info.special_effect_type_1: " .. var_0_0(self.special_effect_type_1))
	var_2_0(self)
end

function var_0_1._initSkillEffectType1(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1.killAttackAgain = {
		_value1 = arg_3_2.special_effect_value_1,
		_value2 = arg_3_2.special_effect_value_2,
		execute = function(arg_4_0, arg_4_1)
			return
		end
	}
end

function var_0_1._initSkillEffectType2(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1.killAttrUp = {
		_value1 = arg_5_2.special_effect_value_1,
		_value2 = arg_5_2.special_effect_value_2,
		execute = function(arg_6_0)
			return
		end
	}
end

function var_0_1._initSkillEffectType3(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1.speedStun = {
		_value1 = arg_7_2.special_effect_value_1,
		_value2 = arg_7_2.special_effect_value_2,
		execute = function(arg_8_0)
			return
		end
	}
end

function var_0_1._initSkillEffectType4(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1.speedAngerDown = {
		_value1 = arg_9_2.special_effect_value_1,
		_value2 = arg_9_2.special_effect_value_2,
		execute = function(arg_10_0)
			return
		end
	}
end

function var_0_1._initSkillEffectType5(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1.angerDamUp = {
		_value1 = arg_11_2.special_effect_value_1,
		_value2 = arg_11_2.special_effect_value_2,
		execute = function(arg_12_0)
			return
		end
	}
end

function var_0_1._initSkillEffectType6(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1.comboValueDown = {
		_value1 = arg_13_2.special_effect_value_1,
		_value2 = arg_13_2.special_effect_value_2,
		execute = function(arg_14_0)
			return
		end
	}
end

function var_0_1._initSkillEffectType7(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1.buffIncreaseDamUp = {
		_value1 = arg_15_2.special_effect_value_1,
		_value2 = arg_15_2.special_effect_value_2,
		execute = function(arg_16_0)
			return
		end
	}
end

function var_0_1._initSkillEffectType8(arg_17_0, arg_17_1, arg_17_2)
	arg_17_1.hpAngerDown = {
		_value1 = arg_17_2.special_effect_value_1,
		_value2 = arg_17_2.special_effect_value_2,
		execute = function(arg_18_0)
			return
		end
	}
end

function var_0_1._initSkillEffectType9(arg_19_0, arg_19_1, arg_19_2)
	arg_19_1.killComboUp = {
		_value1 = arg_19_2.special_effect_value_1,
		_value2 = arg_19_2.special_effect_value_2,
		execute = function(arg_20_0)
			return
		end
	}
end

function var_0_1._initSkillEffectType10(arg_21_0, arg_21_1, arg_21_2)
	arg_21_1.buffComboDown = {
		_value1 = arg_21_2.special_effect_value_1,
		_value2 = arg_21_2.special_effect_value_2,
		execute = function(arg_22_0)
			return
		end
	}
end

function var_0_1._initSkillEffectType11(arg_23_0, arg_23_1, arg_23_2)
	arg_23_1.buffEffectDamUp = {
		_value1 = arg_23_2.special_effect_value_1,
		_value2 = arg_23_2.special_effect_value_2,
		execute = function(arg_24_0)
			return
		end
	}
end

function var_0_1._initSkillEffectType12(arg_25_0, arg_25_1, arg_25_2)
	arg_25_1.hpDamUp = {
		_value1 = arg_25_2.special_effect_value_1,
		_value2 = arg_25_2.special_effect_value_2,
		execute = function(arg_26_0)
			return
		end
	}
end

return var_0_1
