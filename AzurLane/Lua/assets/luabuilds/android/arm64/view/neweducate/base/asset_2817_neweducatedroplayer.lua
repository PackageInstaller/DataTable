class = var_0_10000

local var_0_0 = "NewEducateDropLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.newEducate.base.NewEducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "NewEducateDropUI"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	local var_2_1

	if not arg_2_0.contextData.items then
		var_2_1 = {}
	end

	arg_2_0.drops = var_2_1

	local var_2_2 = arg_2_0._tf

	arg_2_0.awardWindow = var_1.Find(var_2_2, "award_window")

	local var_2_3 = arg_2_0.awardWindow
	local var_2_4 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_2_0.anim = var_2_4(var_2_3, var_4(var_1_10006))

	local var_2_5 = arg_2_0.awardWindow
	local var_2_6 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_2_0.animEvent = var_2_6(var_2_5, var_4(var_1_10006))

	local var_2_7 = arg_2_0.animEvent

	var_1.SetEndEvent(var_2_7, function()
		local var_3_0 = arg_2_0

		var_0.emit(var_3_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_2_8 = arg_2_0.awardWindow

	arg_2_0.tipTF = var_1.Find(var_2_8, "tip")
	setText = var_1

	local var_2_9 = arg_2_0.tipTF

	i18n = var_4

	var_1(var_2_9, var_4("child_close_tip"))

	local var_2_10 = arg_2_0.awardWindow

	arg_2_0.itemContainer = var_1.Find(var_2_10, "scroll/content")

	local var_2_11 = arg_2_0.awardWindow

	arg_2_0.itemTpl = var_1.Find(var_2_11, "tpl")
	setActive = var_1

	var_1(arg_2_0.itemTpl, false)

	local var_2_12 = arg_2_0._tf

	arg_2_0.favorWindow = var_1.Find(var_2_12, "favor_window")

	local var_2_13 = arg_2_0.favorWindow

	arg_2_0.favorLvTF = var_1.Find(var_2_13, "gift/heart/level")
	setActive = var_1

	var_1(arg_2_0.awardWindow, false)

	setActive = var_1

	var_1(arg_2_0.favorWindow, false)

	local var_2_14 = arg_2_0._tf

	var_1.SetAsLastSibling(var_2_14)

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.awardWindow
	local var_4_2 = var_4.Find(var_4_1, "close")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0._close(var_5_0)

		return
	end

	SFX_CANCEL = var_4_1

	var_1_10001(var_4_0, var_4_2, var_4_3, var_4_1)

	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_6_0)
			if arg_4_0.contextData.isFavor then
				setActive = var_1

				var_1(arg_4_0.favorWindow, true)

				setText = var_1

				local var_6_0 = arg_4_0.favorLvTF
				local var_6_1 = arg_4_0.contextData.char

				var_1(var_6_0, var_4.GetFavorInfo(var_6_1).lv)

				local var_6_2 = arg_4_0
				local var_6_3 = var_1.managedTween

				LeanTween = var_4

				var_6_3(var_6_2, var_4.delayedCall, arg_6_0, 1, nil)
			else
				arg_6_0()
			end

			return
		end
	}, function()
		local var_7_0 = arg_4_0

		var_0.ShowAwardWindow(var_7_0)

		return
	end)

	return
end

function var_0_1.ShowAwardWindow(arg_8_0)
	setActive = var_1_10001

	var_1_10001(arg_8_0.favorWindow, false)

	arg_8_0.inAnimPlaying = true
	setActive = var_1

	var_1(arg_8_0.awardWindow, true)

	local var_8_0 = arg_8_0.anim

	var_1.Play(var_8_0, "anim_educate_dropaward_in")

	local var_8_1 = {}

	table = var_1_10002

	var_1_10002.insert(var_8_1, function(arg_9_0)
		local var_9_0 = arg_8_0
		local var_9_1 = var_1.managedTween

		LeanTween = var_2_10004

		var_9_1(var_9_0, var_2_10004.delayedCall, function()
			arg_9_0()

			return
		end, 0.33, nil)

		return
	end)

	for iter_8_0 = 1, #arg_8_0.drops do
		table = var_1_10006

		var_1_10006.insert(var_8_1, function(arg_11_0)
			local var_11_0 = arg_8_0.drops[iter_8_0]

			cloneTplTo = var_2

			local var_11_1 = var_2(arg_8_0.itemTpl, arg_8_0.itemContainer)

			NewEducateHelper = var_2_10003

			var_2_10003.UpdateItem(var_11_1, var_11_0)

			onButton = var_3

			var_3(arg_8_0, var_11_1, function()
				local var_12_0 = arg_8_0
				local var_12_1 = var_0.emit

				NewEducateBaseUI = var_3_10003

				var_12_1(var_12_0, var_3_10003.ON_ITEM, {
					drop = var_11_0
				})

				return
			end)

			local var_11_2 = arg_8_0
			local var_11_3 = var_3.managedTween

			LeanTween = var_6

			var_11_3(var_11_2, var_6.delayedCall, function()
				arg_11_0()

				return
			end, 0.066, nil)

			return
		end)
	end

	seriesAsync = var_2

	var_2(var_8_1, function()
		local var_14_0 = arg_8_0
		local var_14_1 = var_0.managedTween

		LeanTween = var_2_10003

		var_14_1(var_14_0, var_2_10003.delayedCall, function()
			arg_8_0.inAnimPlaying = false

			return
		end, 0.066, nil)

		return
	end)

	return
end

function var_0_1._close(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.NewGuideMgr.GetInstance()

	if var_1.IsBusy(var_16_0) then
		arg_16_0:emit(var_0_1.ON_CLOSE)

		return
	end

	if arg_16_0.inAnimPlaying or arg_16_0.isCloseAnim then
		return
	end

	local var_16_1 = arg_16_0.anim

	var_1.Play(var_16_1, "anim_educate_awardinfo_award_out")

	arg_16_0.isCloseAnim = true

	return
end

function var_0_1.onBackPressed(arg_17_0)
	arg_17_0:_close()

	return
end

function var_0_1.willExit(arg_18_0)
	pg = var_1_10001

	local var_18_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_18_0, arg_18_0._tf)

	if arg_18_0.contextData.removeFunc then
		arg_18_0.contextData.removeFunc()

		arg_18_0.contextData.removeFunc = nil
	end

	return
end

return var_0_1
