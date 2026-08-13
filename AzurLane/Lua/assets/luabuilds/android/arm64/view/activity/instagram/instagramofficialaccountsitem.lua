class = var_0_10000

local var_0_0 = "InstagramOfficialAccountsItem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.uiTip = var_1.Find(var_2_0, "tip")

	local var_2_1 = arg_2_0._tf

	arg_2_0.uiNameText = var_1.Find(var_2_1, "name")

	return
end

function var_0_1.SetData(arg_3_0, arg_3_1)
	arg_3_0.id = arg_3_1

	arg_3_0:RefreshUI()

	return
end

function var_0_1.RefreshUI(arg_4_0)
	local var_4_0 = arg_4_0.id

	getProxy = var_1_10002
	InstagramProxy = var_1_10004

	local var_4_1 = var_1_10002(var_1_10004)
	local var_4_2 = var_2.GetOfficialAccounts(var_4_1)[var_4_0]

	setText = var_1_10003

	local var_4_3 = arg_4_0.uiNameText

	shortenString = var_1_10006

	var_1_10003(var_4_3, var_1_10006(var_4_2:getConfig("title"), 26))
	arg_4_0:RefreshTip()

	return
end

function var_0_1.RefreshTip(arg_5_0)
	local var_5_0 = arg_5_0.id

	getProxy = var_1_10002
	InstagramProxy = var_1_10004

	local var_5_1 = var_1_10002(var_1_10004)

	if var_2.GetOfficialAccounts(var_5_1)[var_5_0] then
		setActive = var_1_10003

		var_1_10003(arg_5_0.uiTip, var_2:ShouldShowTip())
	end

	return
end

function var_0_1.willExit(arg_6_0)
	arg_6_0:detach()

	return
end

return var_0_1
