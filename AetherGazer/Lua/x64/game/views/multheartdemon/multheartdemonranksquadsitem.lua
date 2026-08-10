local var_0_0 = class("MultHeartDemonRankSquadsItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.typeController_ = ControllerUtil.GetController(arg_2_0.transform_, "type")
end

local function var_0_1(arg_3_0, arg_3_1)
	if arg_3_0 and arg_3_0 ~= 0 then
		return arg_3_0
	end

	return arg_3_1
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = HeroStandardSystemCfg[arg_4_1.skin_id]
	local var_4_1
	local var_4_2

	if var_4_0 ~= nil then
		arg_4_0.heroID_ = var_4_0.hero_id
		var_4_1 = var_4_0.skin_id
	else
		arg_4_0.heroID_ = arg_4_1.hero_id
		var_4_1 = var_0_1(arg_4_1.skin_id, arg_4_0.heroID_)
	end

	arg_4_0.portraitImg_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. var_4_1)

	local var_4_3 = HeroCfg[arg_4_0.heroID_]

	arg_4_0.nameText_.text = GetI18NText(var_4_3.name)
	arg_4_0.rangeTypeText_.text = GetTips("MULTI_HEART_DEMON_ORDER_" .. arg_4_2)

	local var_4_4 = nullable(arg_4_3, arg_4_2) or nullable(arg_4_3, arg_4_1.skin_id) or 100

	arg_4_0.hp_.text = string.format("%d%%", var_4_4)
	arg_4_0.hpBar_.fillAmount = var_4_4 / 100
end

function var_0_0.SetIsCaptain(arg_5_0, arg_5_1)
	arg_5_0.typeController_:SetSelectedIndex(arg_5_1 and 1 or 0)
end

return var_0_0
