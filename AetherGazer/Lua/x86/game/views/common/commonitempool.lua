local var_0_0 = class("CommonItemPool", ReduxView)

function var_0_0.GetItemPath(arg_1_0)
	if arg_1_0.isSmall_ then
		return "Widget/System/Com_dynamic/CommonItem_s"
	else
		return "Widget/System/Com_dynamic/CommonItem"
	end
end

function var_0_0.OnCtor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.isSmall_ = arg_2_3
	arg_2_0.gameObject_ = manager.objectPool:Get(arg_2_0:GetItemPath())
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0.gameObject_.transform:SetParent(arg_2_1.transform)

	arg_2_0.commonItem_ = CommonItemView.New(arg_2_0.gameObject_)
	arg_2_0.commonItem_.itemCanvasGroup_.alpha = 1

	arg_2_0:SetData(arg_2_2)
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.commonItem_:SetData(arg_3_1)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	arg_4_0.commonItem_:Dispose()

	arg_4_0.commonItem_ = nil

	manager.objectPool:Return(arg_4_0:GetItemPath(), arg_4_0.gameObject_)
end

function var_0_0.Show(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

return var_0_0
