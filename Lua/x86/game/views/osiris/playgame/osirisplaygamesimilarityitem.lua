local var_0_0 = class("OsirisPlayGameSimilarityItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateCon_ = arg_3_0.controllerEx_:GetController("state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		arg_4_0:ShowAffixInfo(arg_4_0.generalitId)

		if arg_4_0.clickFun then
			arg_4_0.clickFun(arg_4_0.index)
		end
	end)
end

function var_0_0.ShowAffixInfo(arg_6_0, arg_6_1)
	SetActive(arg_6_0.affixinfoTrs_.gameObject, true)

	arg_6_0.affixcontentText_.text = GetI18NText(ActivityGeneralityTagCfg[arg_6_1].desc)
	arg_6_0.affixnameText_.text = GetI18NText(ActivityGeneralityTagCfg[arg_6_1].name)

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.affixcontentTrs_)

	if arg_6_0.countdownTimer_ then
		arg_6_0.countdownTimer_:Stop()

		arg_6_0.countdownTimer_ = nil
	end

	arg_6_0.countdownTimer_ = Timer.New(function()
		SetActive(arg_6_0.affixinfoTrs_.gameObject, false)
		arg_6_0.countdownTimer_:Stop()
	end, 3, 1)

	arg_6_0.countdownTimer_:Start()
end

function var_0_0.HideAffixInfo(arg_8_0)
	if arg_8_0.countdownTimer_ then
		arg_8_0.countdownTimer_:Stop()

		arg_8_0.countdownTimer_ = nil
	end

	SetActive(arg_8_0.affixinfoTrs_.gameObject, false)
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0:Show(true)

	arg_9_0.generalitId = arg_9_1
	arg_9_0.stageID = arg_9_2
	arg_9_0.index = arg_9_3

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.skillIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_Osiris/" .. arg_10_0.generalitId)

	local var_10_0 = ActivityGeneralityStageCfg.get_id_list_by_stage_id[arg_10_0.stageID][1]
	local var_10_1 = ActivityGeneralityStageCfg[var_10_0].generality

	arg_10_0.stateCon_:SetSelectedIndex(var_10_1 == arg_10_0.generalitId and 1 or 0)
end

function var_0_0.RegisterClickFunc(arg_11_0, arg_11_1)
	arg_11_0.clickFun = arg_11_1
end

function var_0_0.Show(arg_12_0, arg_12_1)
	SetActive(arg_12_0.gameObject_, arg_12_1)
end

function var_0_0.OnExit(arg_13_0)
	if arg_13_0.countdownTimer_ then
		arg_13_0.countdownTimer_:Stop()

		arg_13_0.countdownTimer_ = nil
	end

	arg_13_0:HideAffixInfo()
	arg_13_0.super.OnExit(arg_13_0)
end

return var_0_0
