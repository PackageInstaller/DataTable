ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleAttr
local var_0_3 = var_0.Battle.BattleConst

class = var_0_10004

local var_0_4 = var_0_10004("BattleBuffDamageConvert", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffDamageConvert = var_0_4
var_0_4.__name = "BattleBuffDamageConvert"
var_0_4.ATTR_PRE = {
	[var_0_3.WeaponDamageAttr.CANNON] = "injureRatioByCannon",
	[var_0_3.WeaponDamageAttr.TORPEDO] = "injureRatioByBulletTorpedo",
	[var_0_3.WeaponDamageAttr.AIR] = "injureRatioByAir"
}

function var_0_4.Ctor(arg_1_0, arg_1_1)
	var_0_4.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_4.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._convert = arg_2_0._tempData.arg_list.convert_rate
	arg_2_0._duration = var_3.duration
	arg_2_0._buffSkinID = var_3.buff_skin_id
	arg_2_0._attrTable = {}

	return
end

function var_0_4.onTakeDamage(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.damageAttr then
		local var_3_0

		if not arg_3_0._attrTable[var_4] then
			var_3_0 = 0
		end

		local var_3_1 = var_3_0 + arg_3_3.damage

		arg_3_0._attrTable[var_4] = var_3_1
	end

	return
end

function var_0_4.onRemove(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = 0
	local var_4_1

	pairs = var_1_10005

	for iter_4_0, iter_4_1 in var_1_10005(arg_4_0._attrTable) do
		if var_4_0 <= iter_4_1 then
			var_4_0 = iter_4_1
			var_4_1 = iter_4_0
		end
	end

	if not var_4_1 then
		return
	end

	local var_4_2 = var_0_4.ATTR_PRE[var_4_1]
	local var_4_3 = var_0_4.generateBuff(arg_4_0._buffSkinID, arg_4_0._duration, var_4_2, var_4_0 * arg_4_0._convert)
	local var_4_4 = var_0.Battle.BattleBuffSelfModifyUnit.New(var_4_3.id, 1, arg_4_1, var_4_3)

	arg_4_1:AddBuff(var_4_4)

	return
end

function var_0_4.generateBuff(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	return {
		id = arg_5_0,
		icon = arg_5_0,
		time = arg_5_1,
		blink = {
			0,
			0.7,
			1,
			0.3,
			0.3
		},
		effect_list = {
			{
				type = "BattleBuffAddAttr",
				trigger = {
					"onAttach",
					"onRemove"
				},
				arg_list = {
					attr = arg_5_2,
					number = arg_5_3,
					group = arg_5_0
				}
			}
		},
		{
			time = arg_5_1
		},
		name = "代码生成buff",
		init_effect = "jinengchufablue",
		picture = "",
		desc = "代码生成buff-指定属性减伤",
		stack = 1,
		last_effect = ""
	}
end

return
