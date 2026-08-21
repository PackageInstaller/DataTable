local var_0_0 = class("CoreVerificationChallengeRankAffixItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.categoryController_ = arg_3_0.affixController_:GetController("category")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	local var_5_0 = ActivityAffixPoolCfg[arg_5_1.id].affix

	if arg_5_1.lv == 0 then
		arg_5_0.categoryController_:SetSelectedIndex(1)

		arg_5_0.lvText.text = " "
	elseif arg_5_1.lv == -1 then
		arg_5_0.categoryController_:SetSelectedIndex(0)

		arg_5_0.lvText.text = " "
	else
		local var_5_1 = var_5_0[1]

		if AffixTypeCfg[var_5_1].extra_description == "AFFIX_CORE_BUFF" then
			arg_5_0.categoryController_:SetSelectedIndex(0)

			arg_5_0.lvText.text = string.format(GetTips("PINBALL_HERO_LEVEL"), arg_5_1.lv)
		else
			arg_5_0.categoryController_:SetSelectedIndex(1)

			arg_5_0.lvText.text = " "
		end
	end

	arg_5_0.nameText.text = getAffixName(var_5_0)
	arg_5_0.icon.sprite = getAffixSprite(var_5_0)
end

function var_0_0.Show(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
