local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")
local var_0_1 = class("ChallengeRogueTeamBagRelicTitleItem", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_1.AddListeners(arg_2_0)
	return
end

function var_0_1.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:Show(true)

	arg_3_0.nameText_.text = GetTips(ChallengeRogueTeamConst.RELIC_SUB_TYPE_TITLE[arg_3_1])
	arg_3_0.index_ = arg_3_2
end

function var_0_1.SetSelectID(arg_4_0, arg_4_1)
	return
end

function var_0_1.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_1.Dispose(arg_6_0)
	var_0_1.super.Dispose(arg_6_0)
	Object.Destroy(arg_6_0.gameObject_)

	arg_6_0.gameObject_ = nil
	arg_6_0.transform_ = nil
end

return var_0_1
