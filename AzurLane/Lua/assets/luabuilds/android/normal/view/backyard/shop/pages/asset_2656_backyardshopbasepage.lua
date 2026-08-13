class = var_0_10000

local var_0_0 = "BackYardShopBasePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))

function var_0_1.PlayerUpdated(arg_1_0, arg_1_1)
	arg_1_0.player = arg_1_1

	arg_1_0:OnPlayerUpdated()

	return
end

function var_0_1.DormUpdated(arg_2_0, arg_2_1)
	arg_2_0.dorm = arg_2_1

	arg_2_0:OnDormUpdated()

	return
end

function var_0_1.FurnituresUpdated(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.dorm
	local var_3_1 = var_2.GetPurchasedFurnitures(var_3_0)

	ipairs = var_3_0

	for iter_3_0, iter_3_1 in var_3_0(arg_3_1) do
		local var_3_2 = var_3_1[iter_3_1]

		arg_3_0:OnDisplayUpdated(var_3_2)
		arg_3_0:OnCardUpdated(var_3_2)
	end

	return
end

function var_0_1.SetUp(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0:Show()

	arg_4_0.pageType = arg_4_1
	arg_4_0.dorm = arg_4_2
	arg_4_0.player = arg_4_3

	arg_4_0:OnSetUp()

	if arg_4_4 then
		arg_4_4()
	end

	return
end

function var_0_1.Show(arg_5_0)
	setActiveViaLayer = var_1_10001

	var_1_10001(arg_5_0._tf, true)

	return
end

function var_0_1.Hide(arg_6_0)
	setActiveViaLayer = var_1_10001

	var_1_10001(arg_6_0._tf, false)

	return
end

function var_0_1.ShowFurnitureMsgBox(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.contextData.furnitureMsgBox

	var_2.ExecuteAction(var_7_0, "SetUp", arg_7_1, arg_7_0.dorm, arg_7_0.player)

	return
end

function var_0_1.ShowThemeVOMsgBox(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.contextData.themeMsgBox

	var_2.ExecuteAction(var_8_0, "SetUp", arg_8_1, arg_8_0.dorm, arg_8_0.player)

	return
end

function var_0_1.OnSetUp(arg_9_0)
	return
end

function var_0_1.OnPlayerUpdated(arg_10_0)
	return
end

function var_0_1.OnDisplayUpdated(arg_11_0, arg_11_1)
	return
end

function var_0_1.OnCardUpdated(arg_12_0, arg_12_1)
	return
end

function var_0_1.OnDormUpdated(arg_13_0)
	return
end

return var_0_1
