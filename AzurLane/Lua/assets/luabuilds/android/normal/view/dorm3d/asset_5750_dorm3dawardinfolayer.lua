class = var_0_10000

local var_0_0 = "Dorm3dAwardInfoLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dAwardInfoUI"
end

function var_0_1.init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "bg")

	local function var_2_3()
		if arg_2_0.inAnimPlaying or arg_2_0.isCloseAnim then
			return
		end

		arg_2_0.isCloseAnim = true

		local var_3_0 = arg_2_0._tf
		local var_3_1 = var_0.GetComponent

		typeof = var_2_10002
		Animation = var_2_10003

		local var_3_2 = var_3_1(var_3_0, var_2_10002(var_2_10003))

		var_0.Play(var_3_2, "anim_educate_awardinfo_award_out")

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_2_0, var_2_2, var_2_3, var_5)

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.GetComponent

	typeof = var_2_2
	DftAniEvent = var_2_3

	local var_2_6 = var_2_5(var_2_4, var_2_2(var_2_3))

	var_1.SetEndEvent(var_2_6, function()
		local var_4_0 = arg_2_0

		var_0.closeView(var_4_0)

		return
	end)

	local var_2_7 = arg_2_0._tf

	arg_2_0.tipTF = var_1.Find(var_2_7, "panel/tip")
	setText = var_1

	local var_2_8 = arg_2_0.tipTF

	i18n = var_3

	var_1(var_2_8, var_3("child_close_tip"))

	local var_2_9 = arg_2_0._tf

	arg_2_0.itemContainer = var_1.Find(var_2_9, "panel/content")
	pg = var_1

	local var_2_10 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_10, arg_2_0._tf)

	return
end

function var_0_1.didEnter(arg_5_0)
	UIItemList = var_1_10001

	local var_5_0 = var_1_10001.StaticAlign
	local var_5_1 = arg_5_0.itemContainer
	local var_5_2 = arg_5_0.itemContainer

	var_5_0(var_5_1, var_3.Find(var_5_2, "tpl"), #arg_5_0.contextData.items, function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_1 = arg_6_1 + 1
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_5_0.contextData.items[arg_6_1]

			updateCustomDrop = var_2_10004

			var_2_10004(arg_6_2, var_6_0)

			onButton = var_2_10004

			local var_6_1 = arg_5_0
			local var_6_2 = arg_6_2

			local function var_6_3()
				local var_7_0 = arg_5_0
				local var_7_1 = var_0.emit

				BaseUI = var_3_10002

				var_7_1(var_7_0, var_3_10002.ON_NEW_DROP, {
					style = "dorm",
					drop = var_6_0
				})

				return
			end

			SFX_PANEL = var_2_10008

			var_2_10004(var_6_1, var_6_2, var_6_3, var_2_10008)
		end

		return
	end)

	arg_5_0.inAnimPlaying = true

	local var_5_3 = {}

	table = var_5_1

	var_5_1.insert(var_5_3, function(arg_8_0)
		local var_8_0 = arg_5_0
		local var_8_1 = var_1.managedTween

		LeanTween = var_2_10003

		var_8_1(var_8_0, var_2_10003.delayedCall, arg_8_0, 0.33, nil)

		return
	end)

	eachChild = var_2

	var_2(arg_5_0.itemContainer, function(arg_9_0)
		isActive = var_2_10001

		if var_2_10001(arg_9_0) then
			setActive = var_1

			var_1(arg_9_0, false)

			table = var_1

			var_1.insert(var_5_3, function(arg_10_0)
				setActive = var_3_10001

				var_3_10001(arg_9_0, true)

				local var_10_0 = arg_5_0
				local var_10_1 = var_1.managedTween

				LeanTween = var_3

				var_10_1(var_10_0, var_3.delayedCall, arg_10_0, 0.066, nil)

				return
			end)
		end

		return
	end)

	seriesAsync = var_2

	var_2(var_5_3, function()
		local var_11_0 = arg_5_0
		local var_11_1 = var_0.managedTween

		LeanTween = var_2_10002

		var_11_1(var_11_0, var_2_10002.delayedCall, function()
			arg_5_0.inAnimPlaying = false

			return
		end, 0.066, nil)

		return
	end)

	pg = var_2

	local var_5_4 = var_2.CriMgr.GetInstance()

	var_2.PlaySE_V3(var_5_4, "ui-dorm_reward")

	return
end

function var_0_1.onBackPressed(arg_13_0)
	triggerButton = var_1_10001

	local var_13_0 = arg_13_0._tf

	var_1_10001(var_2.Find(var_13_0, "bg"))

	return
end

function var_0_1.willExit(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_14_0, arg_14_0._tf)

	return
end

return var_0_1
