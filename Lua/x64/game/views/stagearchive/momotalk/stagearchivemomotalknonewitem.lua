local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")
local var_0_1 = class("StageArchiveMomoTalkNoNewItem", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
end

function var_0_1.SetData(arg_2_0, arg_2_1)
	arg_2_0.index_ = arg_2_1
end

function var_0_1.Show(arg_3_0, arg_3_1)
	SetActive(arg_3_0.gameObject_, arg_3_1)
end

return var_0_1
