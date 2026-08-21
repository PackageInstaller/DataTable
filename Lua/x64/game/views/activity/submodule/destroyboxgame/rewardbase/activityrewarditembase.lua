local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")
local var_0_1 = class("ActivityRewardItemBase", var_0_0)

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_1.Dispose(arg_2_0)
	var_0_1.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_1.AddListeners(arg_3_0)
	return
end

function var_0_1.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:Show(true)

	arg_4_0.index_ = arg_4_2
end

function var_0_1.Update(arg_5_0)
	return
end

return var_0_1
