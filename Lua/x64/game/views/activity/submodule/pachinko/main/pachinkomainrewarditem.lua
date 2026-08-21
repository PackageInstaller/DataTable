local var_0_0 = class("PaChinKoMainRewardItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.commonItem_ = CommonItemView.New(arg_1_0.uiItem_, true)
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0.commonItem_:Dispose()

	arg_2_0.commonItem_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = PaChinKoSignCfg[arg_4_2]
	local var_4_1 = PaChinKoTools.GetReceiveCnt(arg_4_1, arg_4_2)

	arg_4_0.uiCntText_.text = string.format("%s/%s", var_4_1, var_4_0.count)

	if not arg_4_0.itemData_ then
		arg_4_0.itemData_ = clone(ItemTemplateData)

		function arg_4_0.itemData_.clickFun(arg_5_0)
			ShowPopItem(POP_ITEM, var_4_0.reward)
		end
	end

	arg_4_0.itemData_.id = var_4_0.reward[1]
	arg_4_0.itemData_.number = var_4_0.reward[2]
	arg_4_0.itemData_.completedFlag = var_4_1 >= var_4_0.count

	arg_4_0.commonItem_:SetData(arg_4_0.itemData_)
end

return var_0_0
