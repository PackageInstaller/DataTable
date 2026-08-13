class = var_0_10000

local var_0_0 = "AnniversaryEightLoginJpPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.templatePage.CoreLoginSignTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_1, "item")

	local var_1_2 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_2, "items/items")
	UIItemList = var_1
	arg_1_0.itemList = var_1.New(arg_1_0.items, arg_1_0.item)

	local var_1_3 = arg_1_0.bg

	arg_1_0.signBtn = var_1.Find(var_1_3, "signBtn")

	local var_1_4 = arg_1_0.bg

	arg_1_0.signRedTip = var_1.Find(var_1_4, "signBtn/tip")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	arg_2_0.enterFlag = true
	setActive = var_1

	var_1(arg_2_0.item, false)

	arg_2_0.playedAnimationList = {}

	for iter_2_0 = 1, arg_2_0.activity.data1 do
		table = var_1_10005

		var_1_10005.insert(arg_2_0.playedAnimationList, iter_2_0 - 1)
	end

	local var_2_0 = arg_2_0.itemList

	var_1.make(var_2_0, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_3_2:Find("item")
			local var_3_1 = arg_2_0.config.front_drops[arg_3_1 + 1]
			local var_3_2 = {
				type = var_3_1[1],
				id = var_3_1[2],
				count = var_3_1[3]
			}

			updateDrop = var_6

			var_6(var_3_0, var_3_2)

			onButton = var_6

			local var_3_3 = arg_2_0
			local var_3_4 = arg_3_2

			local function var_3_5()
				local var_4_0 = arg_2_0
				local var_4_1 = var_0.emit

				BaseUI = var_3_10003

				var_4_1(var_4_0, var_3_10003.ON_DROP, var_3_2)

				return
			end

			SFX_PANEL = var_2_10011

			var_6(var_3_3, var_3_4, var_3_5, var_2_10011)

			local var_3_6 = arg_3_2:Find("got")

			setActive = var_2_10007

			var_2_10007(var_3_6, arg_3_1 < arg_2_0.nday)

			setActive = var_2_10007

			local var_3_7 = arg_3_2:Find("getEffect")
			local var_3_8, var_3_9

			if arg_2_0.activity.data1 == arg_3_1 then
				var_3_8 = arg_2_0.activity
				var_3_9 = var_10.readyToAchieve(var_3_8)
			else
				var_3_9 = false
			end

			if false then
				var_3_9 = true
			end

			var_2_10007(var_3_7, var_3_9)

			table = var_2_10007

			if var_2_10007.contains(arg_2_0.playedAnimationList, arg_3_1) and arg_3_1 == arg_2_0.nday - 1 then
				GetComponent = var_7

				local var_3_10 = arg_3_2

				typeof = var_10
				Animation = var_3_8

				local var_3_11 = var_7(var_3_10, var_10(var_3_8))

				var_7.Play(var_3_11, "anim_AnniversaryEightLoginJPPage_tpl_get")
			end
		end

		return
	end)

	onButton = var_1

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.signBtn

	local function var_2_3()
		local var_5_0 = arg_2_0.activity

		if var_0.readyToAchieve(var_5_0) == false then
			return
		end

		local var_5_1 = arg_2_0
		local var_5_2 = var_1.emit

		ActivityMediator = var_2_10004

		var_5_2(var_5_1, var_2_10004.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_2_0.activity.id
		})

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_2_1, var_2_2, var_2_3, var_1_10006)

	return
end

function var_0_1.ShowOrHide(arg_6_0, arg_6_1)
	var_0_1.super.ShowOrHide(arg_6_0, arg_6_1)

	if arg_6_1 == true then
		setActive = var_2

		var_2(arg_6_0.items, false)

		Timer = var_2
		arg_6_0.showTimer = var_2.New(function()
			local var_7_0 = arg_6_0

			var_7_0.enterFlag = false
			setActive = var_7_0

			var_7_0(arg_6_0.items, true)

			local var_7_1 = arg_6_0

			var_0.StopTimer(var_7_1)

			return
		end, 0.396, 1)

		local var_6_0 = arg_6_0.showTimer

		var_2.Start(var_6_0)
	else
		arg_6_0.enterFlag = true
	end

	return
end

function var_0_1.StopTimer(arg_8_0)
	if arg_8_0.showTimer then
		local var_8_0 = arg_8_0.showTimer

		var_1.Stop(var_8_0)

		arg_8_0.showTimer = nil
	end

	return
end

function var_0_1.OnUpdateFlush(arg_9_0)
	arg_9_0.nday = arg_9_0.activity.data1

	for iter_9_0 = 1, arg_9_0.activity.data1 do
		table = var_1_10005

		var_1_10005.insert(arg_9_0.playedAnimationList, iter_9_0 - 1)
	end

	local var_9_0 = arg_9_0.itemList

	var_1.align(var_9_0, arg_9_0.Day, arg_9_0.enterFlag and 0.1 or 0)

	setText = var_1

	local var_9_1 = arg_9_0.bg

	var_1(var_3.Find(var_9_1, "items/Root/image_05/Text"), arg_9_0.nday .. "/" .. arg_9_0.Day)

	local var_9_2 = arg_9_0.activity
	local var_9_3 = var_1.readyToAchieve(var_9_2)

	setActive = var_2

	var_2(arg_9_0.signRedTip, var_9_3)

	setGray = var_2

	var_2(arg_9_0.signBtn, not var_9_3)

	return
end

function var_0_1.OnDestroy(arg_10_0)
	arg_10_0:StopTimer()

	local var_10_0 = arg_10_0.itemList

	var_1.Dispose(var_10_0)
	var_0_1.super.OnDestroy(arg_10_0)

	return
end

return var_0_1
