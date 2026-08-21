local var_0_0 = class("NewServerCapsuleToysItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_1, true)
	arg_1_0:BindCfgUI()

	arg_1_0.commonItem_ = CommonItemView.New(arg_1_0.commonItemGo_)
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.rewardID_ = arg_2_1

	local var_2_0 = NewServerCapsuleToysCfg[arg_2_1]
	local var_2_1 = NewServerData:GetCapsuleToysStatus()[arg_2_1]
	local var_2_2 = 0

	if var_2_1 then
		var_2_2 = var_2_1.remain_num
	end

	arg_2_0.progressText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), var_2_2, var_2_0.total)

	local var_2_3 = NewServerCapsuleToysCfg[arg_2_0.rewardID_].reward

	if not arg_2_0.itemData_ then
		arg_2_0.itemData_ = clone(ItemTemplateData)

		function arg_2_0.itemData_.clickFun(arg_3_0)
			ShowPopItem(POP_ITEM, {
				arg_3_0.id,
				arg_3_0.number
			})
		end
	end

	arg_2_0.itemData_.id = var_2_3[1]
	arg_2_0.itemData_.number = var_2_3[2]
	arg_2_0.itemData_.completedFlag = var_2_2 == 0

	arg_2_0.commonItem_:SetData(arg_2_0.itemData_)
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.commonItem_:Dispose()

	arg_4_0.commonItem_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
