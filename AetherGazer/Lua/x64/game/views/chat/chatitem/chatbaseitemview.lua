local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")
local var_0_1 = class("ChatBaseItemView", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:Init()
	arg_1_0:AddListeners()
	arg_1_0:Show(true)
end

function var_0_1.Show(arg_2_0, arg_2_1)
	SetActive(arg_2_0.gameObject_, arg_2_1)
end

function var_0_1.Init(arg_3_0)
	return
end

function var_0_1.AddListeners(arg_4_0)
	return
end

function var_0_1.Dispose(arg_5_0)
	arg_5_0:RemoveAllListeners()
	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.gameObject_ = nil
	arg_5_0.transform_ = nil

	var_0_1.super.Dispose(arg_5_0)
end

return var_0_1
