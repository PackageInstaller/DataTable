local var_0_0 = class("IslandASynLoadSubView", import(".IslandBaseSubView"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.__funcList = {}
	arg_1_0.isloading = false

	return
end

function var_0_0.Init(arg_2_0, ...)
	arg_2_0.isloading = true

	var_0_0.super.Init(arg_2_0, ...)

	return
end

function var_0_0.OnLoaded(arg_3_0)
	arg_3_0.isloading = false

	arg_3_0:ExecuteFuncList()

	return
end

function var_0_0.ExecuteFuncList(arg_4_0)
	if #arg_4_0.__funcList <= 0 then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.__funcList) do
		arg_4_0[iter_4_1.name](arg_4_0, unpackEx(iter_4_1.args))
	end

	arg_4_0.__funcList = {}

	return
end

function var_0_0.GetUIParent(arg_5_0, arg_5_1)
	return arg_5_0:GetView().pageContianer
end

function var_0_0.Show(arg_6_0, ...)
	if arg_6_0:IsEmpty() then
		arg_6_0:Init(...)
	else
		arg_6_0:ShowOrHideGameObject(arg_6_0._go, true)
		arg_6_0:Flush(...)
	end

	arg_6_0:OnShow()

	return
end

function var_0_0.OnShow(arg_7_0)
	return
end

function var_0_0.Hide(arg_8_0)
	arg_8_0:ShowOrHideGameObject(arg_8_0._go, false)
	arg_8_0:OnHide()

	return
end

function var_0_0.OnHide(arg_9_0)
	return
end

function var_0_0.ShowOrHideGameObject(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = GetOrAddComponent(arg_10_1, typeof(CanvasGroup))

	var_10_0.alpha = arg_10_2 and 1 or 0
	var_10_0.blocksRaycasts = arg_10_2

	return
end

function var_0_0.Execute(arg_11_0, arg_11_1, ...)
	if arg_11_0:IsLoaded() or not arg_11_0:IsLoaded() and #arg_11_0.__funcList == 0 and arg_11_1 == "Show" then
		arg_11_0[arg_11_1](arg_11_0, ...)
	elseif arg_11_0.isloading then
		table.insert(arg_11_0.__funcList, {
			name = arg_11_1,
			args = packEx(...)
		})
	end

	return
end

return var_0_0
