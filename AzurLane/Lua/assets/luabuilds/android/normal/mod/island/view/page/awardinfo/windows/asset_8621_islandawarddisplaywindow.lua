class = var_0_10000

local var_0_0 = "IslandAwardDisplayWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandAwardDisplayUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.frameTr = var_1.Find(var_2_0, "frame")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "frame/Board/Top/text/text")

	arg_2_0.title = var_1.GetComponent(var_2_2, "Text")
	UIItemList = var_1

	local var_2_3 = var_1.New
	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_2.Find(var_2_4, "frame/Board/Content/award/content")
	local var_2_6 = arg_2_0._tf

	arg_2_0.uiitemList = var_2_3(var_2_5, var_3.Find(var_2_6, "frame/Board/Content/award/content/tpl"))
	setText = var_1

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_2.Find(var_2_7, "frame/tip")

	i18n = var_2_7

	var_1(var_2_8, var_2_7("island_click_close"))

	local var_2_9 = arg_2_0.frameTr
	local var_2_10 = var_1.GetComponent

	typeof = var_3
	Animation = var_4
	arg_2_0.animator = var_2_10(var_2_9, var_3(var_4))

	local var_2_11 = arg_2_0.frameTr
	local var_2_12 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_4
	arg_2_0.aniDft = var_2_12(var_2_11, var_3(var_4))

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "frame/Board/Content/award_scroll/content")

	arg_2_0.scrollRect = var_1.GetComponent(var_2_14, "LScrollRect")

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	return
end

function var_0_1.Show(arg_5_0, arg_5_1)
	var_0_1.super.Show(arg_5_0)

	local var_5_0 = arg_5_0.title

	setColorStr = var_3

	local var_5_1

	if not arg_5_1.title then
		var_5_1 = ""
	end

	local var_5_2

	if not arg_5_1.titleColor then
		var_5_2 = "#393a3c"
	end

	var_5_0.text = var_3(var_5_1, var_5_2)

	arg_5_0:UpdateAwards(arg_5_1.awards)

	return
end

function var_0_1.OnUpdateItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2.transform
	local var_6_1 = arg_6_0.awards[arg_6_1 + 1]

	updateCustomDrop = var_5

	var_5(var_6_0, var_6_1, {
		style = "island"
	})

	setText = var_5
	findTF = var_6

	var_5(var_6(var_6_0, "icon_bg/count_bg/count"), "x" .. var_6_1.count)

	return
end

function var_0_1.UpdateAwards(arg_7_0, arg_7_1)
	local var_7_0 = #arg_7_1
	local var_7_1 = 10 < var_7_0

	arg_7_0.awards = arg_7_1
	setActive = var_3

	local var_7_2 = arg_7_0._tf

	var_3(var_4.Find(var_7_2, "frame/Board/Content/award_scroll"), var_7_1)

	setActive = var_3

	local var_7_3 = arg_7_0._tf

	var_3(var_4.Find(var_7_3, "frame/Board/Content/award"), not var_7_1)

	if var_7_1 then
		local var_7_4 = arg_7_0.scrollRect

		var_3.SetTotalCount(var_7_4, #arg_7_0.awards, -1)
	else
		local var_7_5 = arg_7_0.uiitemList

		var_3.make(var_7_5, function(arg_8_0, arg_8_1, arg_8_2)
			UIItemList = var_2_10003

			if arg_8_0 == var_2_10003.EventUpdate then
				local var_8_0 = arg_7_1[arg_8_1 + 1]

				updateCustomDrop = var_4

				var_4(arg_8_2, var_8_0, {
					style = "island"
				})

				setText = var_4
				findTF = var_5

				var_4(var_5(arg_8_2, "icon_bg/count_bg/count"), "x" .. var_8_0.count)
			end

			return
		end)

		local var_7_6 = arg_7_0.uiitemList

		var_3.align(var_7_6, #arg_7_1)
	end

	return
end

function var_0_1.PlayExitAniamtion(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.aniDft

	var_2.SetEndEvent(var_9_0, function()
		local var_10_0 = arg_9_0.aniDft

		var_0.SetEndEvent(var_10_0, nil)
		arg_9_1()

		return
	end)

	local var_9_1 = arg_9_0.animator

	var_2.Play(var_9_1, "anim_Island_commonget_single_out")

	return
end

function var_0_1.OnDestroy(arg_11_0)
	local var_11_0 = arg_11_0.aniDft

	var_1.SetEndEvent(var_11_0, nil)

	ClearLScrollrect = var_1

	var_1(arg_11_0.scrollRect)

	return
end

return var_0_1
