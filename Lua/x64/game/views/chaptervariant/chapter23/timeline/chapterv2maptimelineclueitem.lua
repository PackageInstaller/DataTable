local var_0_0 = class("ChapterV2MapTimelineClueItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.control_ = arg_1_0.conEx_:GetController("starItem")
end

function var_0_0.AddListeners(arg_2_0)
	return
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.control_:SetSelectedState(arg_3_1 and "on" or "off")
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	arg_4_0.gameObject_ = nil
	arg_4_0.transform_ = nil
end

return var_0_0
