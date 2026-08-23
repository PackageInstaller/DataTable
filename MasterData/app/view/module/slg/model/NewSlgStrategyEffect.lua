local var_0_0 = g.core.const.ConstMgr.NewSlgConst
local NewSlgStrategyEffect = class("NewSlgStrategyEffect")

function NewSlgStrategyEffect:ctor()
	self._effectDic = {}

	for iter_1_0, iter_1_1 in pairs(var_0_0.STRATEGY_EFFECT_TYPE) do
		self._effectDic[iter_1_1] = {
			value = 0,
			type = iter_1_1
		}
	end
end

function NewSlgStrategyEffect:_calculateEffect1(arg_2_1)
	local var_2_0 = 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		var_2_0 = iter_2_1 + var_2_0
	end

	self._effectDic[var_0_0.STRATEGY_EFFECT_TYPE.ATTACK_AUTHORITY_UP_TYPE].value = var_2_0
end

function NewSlgStrategyEffect:_calculateEffect2(arg_3_1)
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		var_3_0 = iter_3_1 + var_3_0
	end

	self._effectDic[var_0_0.STRATEGY_EFFECT_TYPE.DEF_AUTHORITY_UP_TYPE].value = var_3_0
end

function NewSlgStrategyEffect:_calculateEffect3(arg_4_1)
	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		var_4_0 = iter_4_1 + var_4_0
	end

	self._effectDic[var_0_0.STRATEGY_EFFECT_TYPE.ENEMY_ATTACK_CITY_AUTHORITY_DOWN_TYPE].value = var_4_0
end

function NewSlgStrategyEffect:_calculateEffect4(arg_5_1)
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		var_5_0 = iter_5_1 + var_5_0
	end

	self._effectDic[var_0_0.STRATEGY_EFFECT_TYPE.ENEMY_DEF_CITY_AUTHORITY_DOWN_TYPE].value = var_5_0
end

function NewSlgStrategyEffect:_calculateEffect5(arg_6_1)
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		var_6_0 = iter_6_1 + var_6_0
	end

	self._effectDic[var_0_0.STRATEGY_EFFECT_TYPE.ATTACK_TIMES_TYPE].value = var_6_0
end

function NewSlgStrategyEffect:setCurStrategyIds(arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_1 = g.core.config.new_slg_alli_strategy_info.get(iter_7_1)
		local var_7_2 = var_7_0[var_7_1.type]

		if not var_7_0[var_7_1.type] then
			var_7_2 = {}
			var_7_0[var_7_1.type] = var_7_2
		end

		var_7_2[#var_7_2 + 1] = var_7_1.value
	end

	for iter_7_2, iter_7_3 in pairs(var_7_0) do
		self[table.concat({
			"_calculateEffect",
			iter_7_2
		})](self, iter_7_3)
	end
end

function NewSlgStrategyEffect:getEffect(arg_8_1)
	return (self._effectDic[arg_8_1] or nil) and self._effectDic[arg_8_1].value
end

return NewSlgStrategyEffect
