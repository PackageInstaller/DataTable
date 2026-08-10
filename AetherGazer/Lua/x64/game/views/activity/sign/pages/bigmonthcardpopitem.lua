local var_0_0 = class("BigMonthCardPopItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.commonItem_ = CommonItemView.New(arg_2_0.commonitemGo_)
end

function var_0_0.RefreshData(arg_3_0, arg_3_1)
	arg_3_0.commonItem_:SetData(arg_3_1)
end

function var_0_0.SetText(arg_4_0, arg_4_1)
	arg_4_0.text_.text = arg_4_1
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.commonItem_:Dispose()
	arg_6_0:RemoveAllListeners()

	if arg_6_0.commonItem_ then
		arg_6_0.commonItem_:Dispose()

		arg_6_0.commonItem_ = nil
	end

	arg_6_0.super.Dispose(arg_6_0)
end

return var_0_0
