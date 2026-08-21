local var_0_0 = class("InstagramOfficialAccountsItem", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.uiTip = arg_2_0._tf:Find("tip")
	arg_2_0.uiNameText = arg_2_0._tf:Find("name")

	return
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.id = arg_3_1

	arg_3_0:RefreshUI()

	return
end

function var_0_0.RefreshUI(arg_4_0)
	setText(arg_4_0.uiNameText, shortenString(getProxy(InstagramProxy):GetOfficialAccounts()[arg_4_0.id]:getConfig("title"), 26))
	arg_4_0:RefreshTip()

	return
end

function var_0_0.RefreshTip(arg_5_0)
	local var_5_0 = getProxy(InstagramProxy):GetOfficialAccounts()[arg_5_0.id]

	if var_5_0 then
		setActive(arg_5_0.uiTip, var_5_0:ShouldShowTip())
	end

	return
end

function var_0_0.willExit(arg_6_0)
	arg_6_0:detach()

	return
end

return var_0_0
