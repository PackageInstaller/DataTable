local var_0_0 = class("DormDispatchAwardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.item = CommonItemView.New(arg_2_0.commonitemGo_1)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	if arg_4_1.extraNum then
		arg_4_0.extraText_.text = string.format("+%d", arg_4_1.extraNum)
	else
		arg_4_0.extraText_.text = ""
	end

	arg_4_0.item:SetData({
		id = arg_4_1.id,
		number = arg_4_1.num,
		clickFun = function(arg_5_0)
			ShowPopItem(POP_ITEM, {
				arg_5_0.id
			})
		end
	})
end

function var_0_0.Dispose(arg_6_0)
	if arg_6_0.item then
		arg_6_0.item:Dispose()

		arg_6_0.item = nil
	end

	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
