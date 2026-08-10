local var_0_0 = class("MomoTalkRecordItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.itemBtn_, nil, function()
		if arg_2_0.onClick_ then
			arg_2_0.onClick_(arg_2_0.sessionID_)
		end
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.sessionID_ = arg_4_1.sessionID
	arg_4_0.onClick_ = arg_4_2

	if arg_4_0.text_ then
		arg_4_0.text_.text = GetI18NText(arg_4_1.preview)
	end
end

function var_0_0.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
