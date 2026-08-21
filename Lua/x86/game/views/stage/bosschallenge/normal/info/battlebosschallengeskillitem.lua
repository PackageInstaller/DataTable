local var_0_0 = class("BattleBossChallengeSkillItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_2_0, arg_2_1)
	SetActive(arg_2_0.gameObject_, true)

	arg_2_0.textName_.text = arg_2_1.name
	arg_2_0.textDesc_.text = arg_2_1.info

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_2_0.transformDesc_)
end

function var_0_0.Hide(arg_3_0)
	SetActive(arg_3_0.gameObject_, false)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.transform_ = nil
	arg_4_0.gameObject_ = nil
end

return var_0_0
