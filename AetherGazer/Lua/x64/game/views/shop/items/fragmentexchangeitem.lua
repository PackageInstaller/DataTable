local var_0_0 = class("FragmentExchangeItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.commonItem = CommonItemView.New(arg_3_0.commonItem_, true)
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.data = arg_5_1
	arg_5_0.number = arg_5_2

	arg_5_0:UpdateView()
end

function var_0_0.UpdateView(arg_6_0)
	CommonTools.SetCommonData(arg_6_0.commonItem, arg_6_0.data)

	arg_6_0.numTxt_.text = "x " .. arg_6_0.number
	arg_6_0.nameTxt_.text = ItemTools.getItemName(arg_6_0.data.id)
end

function var_0_0.OnEnter(arg_7_0)
	return
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
	Object.Destroy(arg_9_0.gameObject_)
end

return var_0_0
