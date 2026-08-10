local var_0_0 = class("HodurChallengeSelectAffixItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selectController_ = arg_2_0.mainControllerEx_:GetController("default0")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.affixID_ = arg_3_1

	arg_3_0:SetSelected(false)
	arg_3_0:RefreshUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.affixBtn_, nil, function()
		if arg_4_0.onClickHandler_ then
			arg_4_0.onClickHandler_(arg_4_0.affixID_)
		end
	end)
end

function var_0_0.SetClickHandler(arg_6_0, arg_6_1)
	arg_6_0.onClickHandler_ = arg_6_1
end

function var_0_0.SetSelected(arg_7_0, arg_7_1)
	arg_7_0.selectController_:SetSelectedState(arg_7_1 and "select" or "Default")

	if arg_7_0.selected_ == arg_7_1 then
		return
	end

	arg_7_0.selected_ = arg_7_1

	manager.notify:CallUpdateFunc(HODUR_SELECT_AFFIX, arg_7_1)
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = AffixTypeCfg[arg_8_0.affixID_]

	arg_8_0.affixImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_Hodur/Debufficon/" .. arg_8_0.affixID_)
	arg_8_0.nameText_.text = var_8_0.name
end

function var_0_0.SetActive(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
