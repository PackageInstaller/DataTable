local var_0_0 = class("MatrixHeroHeadItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index = 0

	arg_1_0:initUI()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.floorController = ControllerUtil.GetController(arg_2_0.m_floorController, "floor")
end

function var_0_0.Refresh(arg_3_0, arg_3_1)
	local var_3_0 = HeroStandardSystemCfg[arg_3_1]

	if not var_3_0 then
		arg_3_0.floorController:SetSelectedIndex(0)

		return
	end

	arg_3_0.floorController:SetSelectedIndex(1)

	local var_3_1 = var_3_0.hero_id
	local var_3_2 = MatrixData:GetHeroSkin(var_3_1)

	arg_3_0.m_icon.sprite = getSpriteViaConfig("HeroLittleIcon", var_3_2)
end

return var_0_0
