class = var_0_10000

local var_0_0 = "IslandASynLoadSubView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseSubView"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.__funcList = {}
	arg_1_0.isloading = false

	return
end

function var_0_1.Init(arg_2_0, ...)
	arg_2_0.isloading = true

	var_0_1.super.Init(arg_2_0, ...)

	return
end

function var_0_1.OnLoaded(arg_3_0)
	arg_3_0.isloading = false

	arg_3_0:ExecuteFuncList()

	return
end

function var_0_1.ExecuteFuncList(arg_4_0)
	if #arg_4_0.__funcList <= 0 then
		return
	end

	ipairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0.__funcList) do
		local var_4_0 = arg_4_0[iter_4_1.name]
		local var_4_1 = arg_4_0

		unpackEx = var_1_10008

		var_4_0(var_4_1, var_1_10008(iter_4_1.args))
	end

	arg_4_0.__funcList = {}

	return
end

function var_0_1.GetUIParent(arg_5_0, arg_5_1)
	return arg_5_0:GetView().pageContianer
end

function var_0_1.Show(arg_6_0, ...)
	if arg_6_0:IsEmpty() then
		arg_6_0:Init(...)
	else
		arg_6_0:ShowOrHideGameObject(arg_6_0._go, true)
		arg_6_0:Flush(...)
	end

	arg_6_0:OnShow()

	return
end

function var_0_1.OnShow(arg_7_0)
	return
end

function var_0_1.Hide(arg_8_0)
	arg_8_0:ShowOrHideGameObject(arg_8_0._go, false)
	arg_8_0:OnHide()

	return
end

function var_0_1.OnHide(arg_9_0)
	return
end

function var_0_1.ShowOrHideGameObject(arg_10_0, arg_10_1, arg_10_2)
	GetOrAddComponent = var_1_10003

	local var_10_0 = arg_10_1

	typeof = var_1_10005
	CanvasGroup = var_1_10006

	local var_10_1 = var_1_10003(var_10_0, var_1_10005(var_1_10006))

	var_10_1.alpha = arg_10_2 and 1 or 0
	var_10_1.blocksRaycasts = arg_10_2

	return
end

function var_0_1.Execute(arg_11_0, arg_11_1, ...)
	if arg_11_0:IsLoaded() or not arg_11_0:IsLoaded() and #arg_11_0.__funcList == 0 and arg_11_1 == "Show" then
		arg_11_0[arg_11_1](arg_11_0, ...)
	elseif arg_11_0.isloading then
		table = var_2

		local var_11_0 = var_2.insert
		local var_11_1 = arg_11_0.__funcList
		local var_11_2 = {
			name = arg_11_1
		}

		packEx = var_1_10005
		var_11_2.args = var_1_10005(...)

		var_11_0(var_11_1, var_11_2)
	end

	return
end

return var_0_1
