local var_0_0 = class("BilliardGameHeroBuffItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.buffController_ = arg_2_0.buffControllerEx_:GetController("bufficon")
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.Show(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = BilliardBuffCfg[arg_5_2]

	if arg_5_3 > 0 then
		SetActive(arg_5_0.buffTimeGo_, true)

		arg_5_0.buffTimeText_.text = arg_5_3
	else
		SetActive(arg_5_0.buffTimeGo_, false)
	end

	arg_5_0.buffImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_SummerPub/BilliardGame/buff/" .. var_5_0.buff_icon)
	arg_5_0.buffNameText_.text = var_5_0.name
	arg_5_0.buffDescText_.text = var_5_0.buff_desc

	if var_5_0.is_debuff == 1 then
		arg_5_0.buffController_:SetSelectedIndex(1)
	else
		arg_5_0.buffController_:SetSelectedIndex(0)
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
