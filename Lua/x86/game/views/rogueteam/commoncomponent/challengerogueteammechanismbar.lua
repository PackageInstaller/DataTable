local var_0_0 = class("ChallengeRogueTeamMechanismBar", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/item/RoulikeProgresshead"
end

function var_0_0.Init(arg_2_0)
	arg_2_0.gameObject_ = GameObject.Instantiate(Asset.Load(arg_2_0:UIName()), manager.ui.uiPop.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
	arg_2_0:AdaptScreen()

	arg_2_0.itemView_ = ChallengeRogueTeamMechanismItem.New(arg_2_0.mechanismItem_)
	arg_2_0.createFlag_ = true
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.PlayAnimator(arg_4_0, arg_4_1)
	arg_4_0.itemView_:PlayAnimator(arg_4_1)
end

function var_0_0.ShowBar(arg_5_0)
	if not arg_5_0.createFlag_ then
		arg_5_0:Init()
	end

	arg_5_0:Show(true)
	arg_5_0.itemView_:RefreshUI()
	arg_5_0.transform_:SetAsLastSibling()
end

function var_0_0.HideBar(arg_6_0)
	arg_6_0:Show(false)
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)

	if arg_8_0.createFlag_ then
		arg_8_0.itemView_:Dispose()

		arg_8_0.itemView_ = nil

		Object.Destroy(arg_8_0.gameObject_)

		arg_8_0.transform_ = nil
		arg_8_0.gameObject_ = nil
		arg_8_0.createFlag_ = false
	end
end

return var_0_0
