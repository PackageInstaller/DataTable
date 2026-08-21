local var_0_0 = class("QWorldHintBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return
end

function var_0_0.InitUI(arg_2_0)
	return
end

function var_0_0.SetData(arg_3_0)
	return
end

function var_0_0.RefreshUI(arg_4_0)
	return
end

function var_0_0.OnCtor(arg_5_0)
	return
end

function var_0_0.UIParent(arg_6_0)
	return manager.ui.uiMessage.transform
end

function var_0_0.Init(arg_7_0)
	local var_7_0 = Asset.Load(arg_7_0:UIName())

	arg_7_0.gameObject_ = Object.Instantiate(var_7_0, arg_7_0:UIParent())
	arg_7_0.transform_ = arg_7_0.gameObject_.transform

	arg_7_0:BindCfgUI()
	arg_7_0:InitUI()
end

function var_0_0.Show(arg_8_0)
	if arg_8_0.gameObject_ == nil then
		arg_8_0:Init()
	end

	SetActive(arg_8_0.gameObject_, true)
	arg_8_0.transform_:SetAsLastSibling()
	arg_8_0:RefreshUI()
	arg_8_0:OnShow()
end

function var_0_0.OnShow(arg_9_0)
	return
end

function var_0_0.Hide(arg_10_0)
	if arg_10_0.gameObject_ then
		SetActive(arg_10_0.gameObject_, false)
	end

	arg_10_0:OnHide()
end

function var_0_0.OnHide(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.gameObject_ then
		Object.Destroy(arg_12_0.gameObject_)

		arg_12_0.gameObject_ = nil
		arg_12_0.transform_ = nil

		Asset.Unload(arg_12_0:UIName())
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
