local var_0_0 = class("DuckItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddBtnListener(nil, nil, "OnClick")
end

function var_0_0.RefreshData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.index_ = arg_3_1
	arg_3_0.data_ = arg_3_3 and ActivityDuckCfg[arg_3_2]
	arg_3_0.imgDuck_.sprite = arg_3_3 and getSpriteWithoutAtlas(arg_3_0.data_.icon)
end

function var_0_0.RegisterClick(arg_4_0, arg_4_1)
	arg_4_0.clickFunc = arg_4_1
end

function var_0_0.OnClick(arg_5_0)
	if arg_5_0.clickFunc then
		arg_5_0.clickFunc(arg_5_0.index_)
	end
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.clickFunc = nil

	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
