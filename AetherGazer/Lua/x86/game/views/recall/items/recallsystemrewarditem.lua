local var_0_0 = class("RecallSystemRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.commonItem = CommonItemView.New(arg_3_0.itemGo_, true)
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.data = arg_4_1

	CommonTools.SetCommonData(arg_4_0.commonItem, {
		id = arg_4_0.data.id,
		number = arg_4_0.data.num,
		clickFun = function(arg_5_0)
			ShowPopItem(POP_ITEM, {
				arg_5_0.id,
				arg_5_0.number
			})
		end
	})

	arg_4_0.nameTxt_.text = ItemTools.getItemName(arg_4_0.data.id)
end

function var_0_0.UpdateView(arg_6_0)
	return
end

function var_0_0.OnEnter(arg_7_0)
	return
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.commonItem:Dispose()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
