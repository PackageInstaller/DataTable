class = var_0_10000

local var_0_0 = "WorldAchAwardSubview"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

var_0_1.ShowDrop = "WorldAchAwardSubview.ShowDrop"

function var_0_1.getUIName(arg_1_0)
	return "WorldAchAwardSubview"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.textTitle = var_1.Find(var_3_0, "title/Text")

	local var_3_1 = arg_3_0._tf

	arg_3_0.btnBG = var_1.Find(var_3_1, "bg")

	local var_3_2 = arg_3_0._tf

	arg_3_0.itemContent = var_1.Find(var_3_2, "award_list/content")
	UIItemList = var_1

	local var_3_3 = var_1.New
	local var_3_4 = arg_3_0.itemContent
	local var_3_5 = arg_3_0.itemContent

	arg_3_0.itemList = var_3_3(var_3_4, var_4.Find(var_3_5, "item"))

	local var_3_6 = arg_3_0.itemList

	var_1.make(var_3_6, function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_3_0.awards[arg_4_1]
			local var_4_1 = not arg_3_0.nextStar or var_4_0.star < arg_3_0.nextStar
			local var_4_2

			if arg_3_0.nextStar then
				var_4_2 = var_4_0.star == arg_3_0.nextStar
			end

			local var_4_3

			if arg_3_0.nextStar then
				var_4_3 = var_4_0.star > arg_3_0.nextStar
			end

			local var_4_4 = arg_4_2:Find("award")

			setActive = var_2_10008

			var_2_10008(var_4_4, true)

			setActive = var_2_10008

			var_2_10008(arg_4_2:Find("lock_award"), false)

			updateDrop = var_2_10008

			var_2_10008(var_4_4, var_4_0.drop)

			setGray = var_2_10008

			var_2_10008(var_4_4:Find("icon_bg"), var_4_1 or var_4_3)

			onButton = var_2_10008

			local var_4_5 = arg_3_0
			local var_4_6 = var_4_4

			local function var_4_7()
				local var_5_0 = arg_3_0

				var_0.emit(var_5_0, var_0_1.ShowDrop, var_4_0.drop)

				return
			end

			SFX_PANEL = var_13

			var_2_10008(var_4_5, var_4_6, var_4_7, var_13)

			setText = var_2_10008

			var_2_10008(arg_4_2:Find("star/count"), var_4_0.star)

			setActive = var_2_10008

			var_2_10008(arg_4_2:Find("star/bg_on"), var_4_2)

			setActive = var_2_10008

			var_2_10008(arg_4_2:Find("star/bg_off"), not var_4_2)

			setActive = var_2_10008

			var_2_10008(arg_4_2:Find("star/lock"), var_4_3)

			setActive = var_2_10008

			var_2_10008(arg_4_2:Find("ready_mark"), var_4_2 and not var_4_1 and not arg_3_0.hasAward)

			setActive = var_2_10008

			var_2_10008(arg_4_2:Find("get_mark"), var_4_2 and arg_3_0.hasAward)

			setActive = var_2_10008

			var_2_10008(arg_4_2:Find("got_mark"), var_4_1)

			setActive = var_2_10008

			var_2_10008(arg_4_2:Find("lock_mark"), var_4_3)

			setActive = var_2_10008

			var_2_10008(arg_4_2:Find("mark/on"), var_4_1)

			setActive = var_2_10008

			var_2_10008(arg_4_2:Find("mark/off"), not var_4_1)
		end

		return
	end)

	onButton = var_1

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.btnBG

	local function var_3_9()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_3_5

	var_1(var_3_7, var_3_8, var_3_9, var_3_5)

	return
end

function var_0_1.OnDestroy(arg_7_0)
	return
end

function var_0_1.Show(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_8_0, arg_8_0._tf)

	setActive = var_1

	var_1(arg_8_0._tf, true)

	return
end

function var_0_1.Hide(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_0, arg_9_0._tf, arg_9_0._parentTf)

	setActive = var_1

	var_1(arg_9_0._tf, false)

	return
end

function var_0_1.isShowing(arg_10_0)
	local var_10_0

	if arg_10_0._tf then
		isActive = var_10_0
		var_10_0 = var_10_0(arg_10_0._tf)
	end

	return var_10_0
end

function var_0_1.Setup(arg_11_0, arg_11_1)
	arg_11_0.awards = arg_11_1:GetAchievementAwards()
	nowWorld = var_2

	local var_11_0 = var_2()
	local var_11_1, var_11_2 = var_2.AnyUnachievedAchievement(var_11_0, arg_11_1)

	arg_11_0.hasAward = var_11_1

	local var_11_3

	if not var_11_2 or not var_11_2.star then
		var_11_3 = nil
	end

	arg_11_0.nextStar = var_11_3

	local var_11_4 = arg_11_0.itemList

	var_4.align(var_11_4, #arg_11_0.awards)

	setText = var_4

	local var_11_5 = arg_11_0._tf
	local var_11_6 = var_6.Find(var_11_5, "title/Text")
	local var_11_7 = arg_11_1:GetBaseMap()

	var_4(var_11_6, var_7.GetName(var_11_7))

	return
end

return var_0_1
