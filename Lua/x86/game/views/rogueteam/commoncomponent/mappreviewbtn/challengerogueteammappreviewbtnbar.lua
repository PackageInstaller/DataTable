local var_0_0 = class("ChallengeRogueTeamMapPreviewBtnBar", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RoulikMapFloorBtnUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0.gameObject_ = GameObject.Instantiate(Asset.Load(arg_2_0:UIName()), manager.ui.uiPop.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
	arg_2_0:AdaptScreen()

	arg_2_0.btnView_ = ChallengeRogueTeamMapPreviewBtn.New(arg_2_0.btnGo_)
	arg_2_0.createFlag_ = true
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.ShowBar(arg_4_0)
	if not arg_4_0.createFlag_ then
		arg_4_0:Init()
	end

	arg_4_0:Show(true)
	arg_4_0.btnView_:RefreshUI()
	arg_4_0.transform_:SetAsLastSibling()
end

function var_0_0.RefreshUI(arg_5_0)
	if not arg_5_0.createFlag_ then
		arg_5_0:Init()
	end

	arg_5_0.btnView_:RefreshUI()
end

function var_0_0.ShowState(arg_6_0, arg_6_1)
	arg_6_0.btnView_:ShowState(arg_6_1)
end

function var_0_0.HideBar(arg_7_0)
	arg_7_0:Show(false)
end

function var_0_0.Show(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)

	if arg_9_0.createFlag_ then
		arg_9_0.btnView_:Dispose()

		arg_9_0.btnView_ = nil

		Object.Destroy(arg_9_0.gameObject_)

		arg_9_0.transform_ = nil
		arg_9_0.gameObject_ = nil
		arg_9_0.createFlag_ = false
	end
end

return var_0_0
