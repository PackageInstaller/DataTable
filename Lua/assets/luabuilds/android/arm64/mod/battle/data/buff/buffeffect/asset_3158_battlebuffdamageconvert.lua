ys = ys or {}

local var_0_0 = ys
local BattleBuffDamageConvert = class("BattleBuffDamageConvert", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffDamageConvert = BattleBuffDamageConvert
BattleBuffDamageConvert.__name = "BattleBuffDamageConvert"
BattleBuffDamageConvert.ATTR_PRE = {
	[ys.Battle.BattleConst.WeaponDamageAttr.CANNON] = "injureRatioByCannon",
	[ys.Battle.BattleConst.WeaponDamageAttr.TORPEDO] = "injureRatioByBulletTorpedo",
	[ys.Battle.BattleConst.WeaponDamageAttr.AIR] = "injureRatioByAir"
}

function BattleBuffDamageConvert:Ctor(arg_1_1)
	BattleBuffDamageConvert.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffDamageConvert:SetArgs(arg_2_1, arg_2_2)
	self._convert = self._tempData.arg_list.convert_rate
	self._duration = self._tempData.arg_list.duration
	self._buffSkinID = self._tempData.arg_list.buff_skin_id
	self._attrTable = {}

	return
end

function BattleBuffDamageConvert:onTakeDamage(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.damageAttr then
		self._attrTable[arg_3_3.damageAttr] = (self._attrTable[arg_3_3.damageAttr] or 0) + arg_3_3.damage
	end

	return
end

function BattleBuffDamageConvert:onRemove(arg_4_1, arg_4_2)
	local var_4_0 = 0
	local var_4_1

	for iter_4_0, iter_4_1 in pairs(self._attrTable) do
		if var_4_0 <= iter_4_1 then
			var_4_0 = iter_4_1
			var_4_1 = iter_4_0
		end
	end

	if not var_4_1 then
		return
	end

	local var_4_2 = BattleBuffDamageConvert.generateBuff(self._buffSkinID, self._duration, BattleBuffDamageConvert.ATTR_PRE[var_4_1], var_4_0 * self._convert)

	arg_4_1:AddBuff((var_0_0.Battle.BattleBuffSelfModifyUnit.New(var_4_2.id, 1, arg_4_1, var_4_2)))

	return
end

function BattleBuffDamageConvert:generateBuff(arg_5_1, arg_5_2, arg_5_3)
	return {
		id = self,
		icon = self,
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
					group = self
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
