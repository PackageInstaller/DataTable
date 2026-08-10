local var_0_0 = class("CapsuleToysRewardItem", ReduxView)

function var_0_0.GetItemPath(arg_1_0)
	if arg_1_0.isSmall_ then
		return "Widget/System/Com_dynamic/CommonItem_s"
	else
		return "Widget/System/Com_dynamic/CommonItem"
	end
end

function var_0_0.OnCtor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.parentGo_ = Object.Instantiate(arg_2_2, arg_2_1.transform, false)

	arg_2_0:BindCfgUI(arg_2_0.parentGo_)

	arg_2_0.isSmall_ = arg_2_3
	arg_2_0.gameObject_ = arg_2_0.parentGo_
	arg_2_0.transform_ = arg_2_0.parentGo_.transform

	SetActive(arg_2_0.gameObject_, true)

	arg_2_0.commonItemGo_ = manager.objectPool:Get(arg_2_0:GetItemPath())
	arg_2_0.commonItem_ = CommonItemView.New(arg_2_0.commonItemGo_)

	arg_2_0:SetParent()

	arg_2_0.parentGo_.transform.localScale = Vector3.one

	if arg_2_0.soldOutGo_ then
		arg_2_0.soldOutGo_.transform:SetAsLastSibling()
	end
end

function var_0_0.SetParent(arg_3_0)
	arg_3_0.commonItemGo_.transform:SetParent(arg_3_0.contentTrans_, true)
	arg_3_0.commonItem_:ResetTransform()
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0.rewardID_ = arg_4_1

	local var_4_0 = RegressionCapsuleToysCfg[arg_4_1]
	local var_4_1 = RegressionData:GetCapsuleToysStatus()[arg_4_1]
	local var_4_2 = 0

	if var_4_1 then
		var_4_2 = var_4_1.remain_num
	end

	arg_4_0.progressText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), var_4_2, var_4_0.total)

	if arg_4_0.soldOutGo_ then
		SetActive(arg_4_0.soldOutGo_, var_4_2 == 0)
	end

	local var_4_3 = RegressionCapsuleToysCfg[arg_4_0.rewardID_].reward

	if not arg_4_0.itemData_ then
		arg_4_0.itemData_ = clone(ItemTemplateData)

		function arg_4_0.itemData_.clickFun(arg_5_0)
			ShowPopItem(POP_ITEM, {
				arg_5_0.id,
				arg_5_0.number
			})
		end
	end

	arg_4_0.itemData_.id = var_4_3[1]
	arg_4_0.itemData_.number = var_4_3[2]

	arg_4_0.commonItem_:SetData(arg_4_0.itemData_)
end

function var_0_0.Show(arg_6_0, arg_6_1)
	SetActive(arg_6_0.parentGo_, arg_6_1)
	var_0_0.super.Show(arg_6_0, arg_6_1)
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.commonItem_:Dispose()

	arg_7_0.commonItem_ = nil

	manager.objectPool:Return(arg_7_0:GetItemPath(), arg_7_0.commonItemGo_)

	arg_7_0.commonItemGo_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
