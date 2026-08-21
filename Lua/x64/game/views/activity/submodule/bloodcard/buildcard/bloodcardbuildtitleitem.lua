local var_0_0 = import("game.views.chat.loopScrollView.LoopScrollViewBaseItem")
local var_0_1 = class("BloodCardBuildTitleItem", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.cardItemList_ = {}
end

function var_0_1.AddListeners(arg_2_0)
	return
end

function var_0_1.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:Show(true)

	arg_3_0.index_ = arg_3_2
end

function var_0_1.Show(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

function var_0_1.Dispose(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.cardItemList_) do
		iter_5_1:Dispose()
	end

	arg_5_0.cardItemList_ = nil

	var_0_1.super.Dispose(arg_5_0)
	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.gameObject_ = nil
	arg_5_0.transform_ = nil
end

return var_0_1
