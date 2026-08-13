class = var_0_10000

local var_0_0 = "MonopolyCar2024TotalRewardPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "TotalRewardPanelForMonopoly"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "Window/Layout/Box/ScrollView/Content/ItemGrid2")
	local var_2_3 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_0(var_2_2, var_4.Find(var_2_3, "Window/Layout/Box/ScrollView/Content/ItemGrid2/GridItem"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_4, "Window/Fixed/ButtonGO")

	local var_2_5 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_5, "BG")
	setText = var_1

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_3.Find(var_2_6, "Window/Fixed/top/bg/obtain/title")

	i18n = var_4

	var_1(var_2_7, var_4("MonopolyCar2024Game_total_award_title"))

	setText = var_1

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_3.Find(var_2_8, "Window/Fixed/ButtonGO/pic")

	i18n = var_4

	var_1(var_2_9, var_4("text_confirm"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1)
	var_0_1.super.Show(arg_6_0)

	local var_6_0 = arg_6_0.uiItemList

	var_2.make(var_6_0, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_6_0

			var_3.UpdateItem(var_7_0, arg_7_2, arg_6_1[arg_7_1 + 1])
		end

		return
	end)

	local var_6_1 = arg_6_0.uiItemList

	var_2.align(var_6_1, #arg_6_1)

	pg = var_2

	local var_6_2 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_6_2, arg_6_0._tf)

	return
end

function var_0_1.Hide(arg_8_0)
	var_0_1.super.Hide(arg_8_0)

	pg = var_1

	local var_8_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_8_0, arg_8_0._tf, arg_8_0.parentTF)

	return
end

function var_0_1.UpdateItem(arg_9_0, arg_9_1, arg_9_2)
	updateDrop = var_1_10003

	var_1_10003(arg_9_1:Find("Icon"), arg_9_2)

	return
end

function var_0_1.OnDestroy(arg_10_0)
	if arg_10_0:isShowing() then
		arg_10_0:Hide()
	end

	return
end

return var_0_1
