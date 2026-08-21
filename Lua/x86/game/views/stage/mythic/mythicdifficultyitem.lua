local var_0_0 = class("MythicDifficultyItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
	arg_1_0:AddClickListen()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selectController_ = arg_2_0.m_contrExCo_:GetController("select")
	arg_2_0.lockController_ = arg_2_0.m_contrExCo_:GetController("lock")
end

function var_0_0.AddClickListen(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.m_button, nil, function()
		if arg_3_0.unlock and arg_3_0.clickFunc then
			arg_3_0.clickFunc(arg_3_0.index)
		end
	end)
end

function var_0_0.RegistCallBack(arg_5_0, arg_5_1)
	arg_5_0.clickFunc = arg_5_1
end

function var_0_0.SetChoice(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1 == arg_6_0.index

	arg_6_0.selectController_:SetSelectedIndex(var_6_0 and 1 or 0)
end

function var_0_0.RefreshData(arg_7_0, arg_7_1)
	arg_7_0.index = arg_7_1

	local var_7_0 = MythicCfg.all[arg_7_0.index]
	local var_7_1 = MythicCfg[var_7_0]

	arg_7_0.m_bg.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Challenge_Mythic/" .. var_7_1.background)
	arg_7_0.unlock = MythicData:GetIsOpenDifficulty(var_7_0)

	arg_7_0.lockController_:SetSelectedIndex(arg_7_0.unlock and 0 or 1)

	if var_7_1.difficulty == 1 then
		local var_7_2 = NumberTools.IntToRomam(var_7_0)

		arg_7_0.numText_.text = var_7_2
	else
		arg_7_0.numText_.text = "Ω"
	end
end

return var_0_0
