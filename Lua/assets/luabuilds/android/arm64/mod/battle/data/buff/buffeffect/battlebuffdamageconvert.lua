ys = ys or {}

local var_0_2 = class("BattleBuffDamageConvert", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffDamageConvert = var_0_2
var_0_2.__name = "BattleBuffDamageConvert"
var_0_2.ATTR_PRE = {
	[ys.Battle.BattleConst.WeaponDamageAttr.CANNON] = "injureRatioByCannon",
	[ys.Battle.BattleConst.WeaponDamageAttr.TORPEDO] = "injureRatioByBulletTorpedo",
	[ys.Battle.BattleConst.WeaponDamageAttr.AIR] = "injureRatioByAir"
}

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._convert = arg_2_0._tempData.arg_list.convert_rate
	arg_2_0._duration = arg_2_0._tempData.arg_list.duration
	arg_2_0._buffSkinID = arg_2_0._tempData.arg_list.buff_skin_id
	arg_2_0._attrTable = {}

	return
end

function var_0_2.onTakeDamage(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.damageAttr then
		local var_3_0 = arg_3_0._attrTable[arg_3_3.damageAttr] or 0

		arg_3_0._attrTable[arg_3_3.damageAttr] = var_3_0 + arg_3_3.damage
	end

	return
end

function var_0_2.onRemove(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = 0
	local var_4_1

	for iter_4_0, iter_4_1 in pairs(arg_4_0._attrTable) do
		if var_4_0 <= iter_4_1 then
			var_4_0 = iter_4_1
			var_4_1 = iter_4_0
		end
	end

	if not var_4_1 then
		return
	end

	local var_4_2 = var_0_2.generateBuff(arg_4_0._buffSkinID, arg_4_0._duration, var_0_2.ATTR_PRE[var_4_1], var_4_0 * arg_4_0._convert)

	arg_4_1:AddBuff((var_0.Battle.BattleBuffSelfModifyUnit.New(var_4_2.id, 1, arg_4_1, var_4_2)))

	return
end

function var_0_2.generateBuff(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
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
