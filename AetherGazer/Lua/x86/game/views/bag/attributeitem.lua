local var_0_0 = class("AttributeItem", ReduxView)
local var_0_1 = {
	HeroConst.HERO_ATTRIBUTE.ATK,
	HeroConst.HERO_ATTRIBUTE.ARM,
	HeroConst.HERO_ATTRIBUTE.STA,
	HeroConst.HERO_ATTRIBUTE.CRITICAL
}

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.data_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:InitUI()
end

function var_0_0.RefreshData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.data_ = arg_2_1
	arg_2_0.info_ = arg_2_2
	arg_2_0.isSingleEquip_ = arg_2_3

	arg_2_0:Render()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.Render(arg_4_0)
	arg_4_0:RefreshUI(arg_4_0.info_)
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = 0

	if arg_5_0.isSingleEquip_ then
		var_5_0 = PublicAttrCfg[arg_5_1.key]
		var_5_1 = math.floor(arg_5_1.value)
	else
		local var_5_2 = var_0_1[arg_5_1.index]

		var_5_0 = PublicAttrCfg[var_5_2]
		var_5_1 = arg_5_1.attrS[var_5_2] and math.floor(arg_5_1.attrS[var_5_2]) or 0
	end

	if var_5_0.percent and var_5_0.percent == 1 then
		var_5_1 = var_5_1 / 10 .. "%"
	end

	arg_5_0.addText_.text = var_5_1
	arg_5_0.numNoAdd_ = var_5_1
	arg_5_0.valStr_ = var_5_1
	arg_5_0.name_.text = GetI18NText(var_5_0.name)
	arg_5_0.icon_.sprite = getSprite("Atlas/SystemCommonAtlas", var_5_0.icon)
end

function var_0_0.ShowAdd(arg_6_0, arg_6_1)
	if arg_6_0.isSingleEquip_ then
		arg_6_0:GetAddValueStr()

		if arg_6_1 then
			arg_6_0.addText_.text = arg_6_0.numAdd_
		else
			arg_6_0.addText_.text = arg_6_0.numNoAdd_
		end
	end
end

function var_0_0.GetAddValueStr(arg_7_0)
	local var_7_0 = PublicAttrCfg[arg_7_0.info_.key]

	if arg_7_0.info_.race == arg_7_0.info_.heroId then
		local var_7_1 = GameSetting.equip_hero_strengthen_num.value[1] - 1
		local var_7_2 = math.floor(arg_7_0.info_.value * var_7_1 + FLOAT_DELTA)

		if var_7_0.percent and var_7_0.percent == 1 then
			var_7_2 = math.floor(arg_7_0.info_.value * var_7_1 / 10 + FLOAT_DELTA) .. "%"
		end

		arg_7_0.numAdd_ = string.format("%s<color=#e78300>+%s</color>", arg_7_0.valStr_, var_7_2)
	elseif arg_7_0.info_.race and arg_7_0.info_.race ~= 0 then
		local var_7_3 = math.floor(arg_7_0.info_.value * 0.2 + FLOAT_DELTA)

		if var_7_0.percent and var_7_0.percent == 1 then
			var_7_3 = math.floor(arg_7_0.info_.value / 10 * 0.2 + FLOAT_DELTA) .. "%"
		end

		arg_7_0.numAdd_ = string.format("%s<color=#e78300>+%s</color>", arg_7_0.valStr_, var_7_3)
	else
		arg_7_0.numAdd_ = arg_7_0.valStr_
	end
end

function var_0_0.Show(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
