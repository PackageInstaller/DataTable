local var_0_0 = class("RegressionBPRewardItem", ReduxView)

function var_0_0.GetItemPath(arg_1_0)
	if arg_1_0.isSmall_ then
		return "Widget/System/Com_dynamic/CommonItem_s"
	else
		return "Widget/System/Com_dynamic/CommonItem"
	end
end

function var_0_0.OnCtor(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_0.parentGo_ = Object.Instantiate(arg_2_2, arg_2_1.transform)

	arg_2_0:BindCfgUI(arg_2_0.parentGo_)

	arg_2_0.isSmall_ = arg_2_3
	arg_2_0.gameObject_ = arg_2_0.parentGo_
	arg_2_0.transform_ = arg_2_0.parentGo_.transform

	SetActive(arg_2_0.gameObject_, true)

	arg_2_0.commonItemGo_ = manager.objectPool:Get(arg_2_0:GetItemPath())
	arg_2_0.commonItem_ = CommonItemView.New(arg_2_0.commonItemGo_)

	arg_2_0:SetParent()

	arg_2_0.clickCallback_ = arg_2_5

	if arg_2_0.receivedMarkGo_ then
		arg_2_0.receivedMarkGo_.transform:SetAsLastSibling()
	end

	arg_2_0.statusController_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
end

function var_0_0.SetParent(arg_3_0)
	arg_3_0.commonItemGo_.transform:SetParent(arg_3_0.parentGo_.transform, true)
	arg_3_0.commonItem_:ResetTransform()
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0.itemData_ then
		arg_4_0.itemData_ = clone(ItemTemplateData)
		arg_4_0.itemData_.clickFun = arg_4_0.clickCallback_
	end

	arg_4_0.itemData_.id = arg_4_1[1]
	arg_4_0.itemData_.number = arg_4_1[2]

	arg_4_0.commonItem_:SetData(arg_4_0.itemData_)
	arg_4_0:Show(true)

	if arg_4_3 == nil or arg_4_3 >= 1 then
		arg_4_0.commonItem_:RefreshLock(false)
	else
		arg_4_0.commonItem_:RefreshLock(true)
	end
end

function var_0_0.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.parentGo_, arg_5_1)
end

function var_0_0.RefreshStatus(arg_6_0, arg_6_1)
	arg_6_0.statusController_:SetSelectedIndex(arg_6_1)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
	arg_7_0.commonItem_:Dispose()

	arg_7_0.commonItem_ = nil

	manager.objectPool:Return(arg_7_0:GetItemPath(), arg_7_0.commonItemGo_)
end

return var_0_0
