class = var_0_10000

local var_0_0 = "NewEducateReplaceTarotLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.newEducate.base.NewEducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "NewEducateReplaceTarotUI"
end

function var_0_1.init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "title")

	i18n = var_1_10004

	var_1_10001(var_2_1, var_1_10004("child2_replace_title"))

	setText = var_1_10001

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_3.Find(var_2_2, "tip")

	i18n = var_4

	var_1_10001(var_2_3, var_4("child2_replace_tip"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.toggleTF = var_1.Find(var_2_4, "toggle")
	setText = var_1

	local var_2_5 = arg_2_0.toggleTF
	local var_2_6 = var_3.Find(var_2_5, "Text")

	i18n = var_4

	var_1(var_2_6, var_4("child2_show_detail_desc"))

	local var_2_7 = arg_2_0._tf

	arg_2_0.oldTF = var_1.Find(var_2_7, "old")
	NewEducateTarotCard = var_1
	arg_2_0.oldCard = var_1.New(arg_2_0.oldTF)

	local var_2_8 = arg_2_0._tf

	arg_2_0.newTF = var_1.Find(var_2_8, "new")
	NewEducateTarotCard = var_1
	arg_2_0.newCard = var_1.New(arg_2_0.newTF)

	local var_2_9 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_9, "cancel_btn")
	setText = var_1

	local var_2_10 = arg_2_0.cancelBtn
	local var_2_11 = var_3.Find(var_2_10, "Text")

	i18n = var_4

	var_1(var_2_11, var_4("child2_replace_cancel"))

	local var_2_12 = arg_2_0._tf

	arg_2_0.sureBtn = var_1.Find(var_2_12, "sure_btn")
	setText = var_1

	local var_2_13 = arg_2_0.sureBtn
	local var_2_14 = var_3.Find(var_2_13, "Text")

	i18n = var_4

	var_1(var_2_14, var_4("child2_replace_sure"))

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:BlurPanel(arg_3_0._tf, {
		groupDelta = 3
	})

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.cancelBtn

	local function var_3_2()
		local var_4_0 = arg_3_0.state

		var_0.SetHoldId(var_4_0, arg_3_0.oldId)

		local var_4_1 = arg_3_0

		var_0.CheckState(var_4_1)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.sureBtn

	local function var_3_5()
		local var_5_0 = arg_3_0.state

		var_0.SetHoldId(var_5_0, arg_3_0.newId)

		local var_5_1 = arg_3_0

		var_0.CheckState(var_5_1)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_3, var_3_4, var_3_5, var_1_10006)

	onToggle = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.toggleTF

	local function var_3_8(arg_6_0)
		NewEducateHelper = var_2_10001

		var_2_10001.SetTarotDeatilDescData(arg_6_0)

		local var_6_0 = arg_3_0.oldCard

		var_1.UpdateDescMode(var_6_0, arg_6_0)

		local var_6_1 = arg_3_0.newCard

		var_1.UpdateDescMode(var_6_1, arg_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_6, var_3_7, var_3_8, var_1_10006)
	arg_3_0:UpdateView()

	triggerToggle = var_1

	local var_3_9 = arg_3_0.toggleTF

	NewEducateHelper = var_3_7

	var_1(var_3_9, var_3_7.IsShowTarotDeatilDesc())

	return
end

function var_0_1.UpdateView(arg_7_0)
	getProxy = var_1_10001
	NewEducateProxy = var_1_10003

	local var_7_0 = var_1_10001(var_1_10003)
	local var_7_1 = var_1.GetCurChar(var_7_0)
	local var_7_2 = var_1.GetFSM(var_7_1)

	arg_7_0.state = var_1.GetPriorityState(var_7_2)

	local var_7_3 = arg_7_0.state

	arg_7_0.oldId = var_1.GetHoldId(var_7_3)

	if arg_7_0.oldId == 0 then
		local var_7_4 = arg_7_0.contextData.char

		arg_7_0.oldId = var_1.GetTarotId(var_7_4)
	end

	local var_7_5 = arg_7_0.state

	arg_7_0.newId = var_1.GetFirstId(var_7_5)

	local var_7_6 = arg_7_0.oldCard
	local var_7_7 = var_1.Update
	local var_7_8 = arg_7_0.oldId

	NewEducateTarotCard = var_1_10005

	var_7_7(var_7_6, var_7_8, var_1_10005.TYPE.CURRENT)

	local var_7_9 = arg_7_0.newCard
	local var_7_10 = var_1.Update
	local var_7_11 = arg_7_0.newId

	NewEducateTarotCard = var_5

	var_7_10(var_7_9, var_7_11, var_5.TYPE.REPLACE)

	triggerToggle = var_7_10

	var_7_10(arg_7_0.toggleTF, false)

	return
end

function var_0_1.CheckState(arg_8_0)
	local var_8_0 = arg_8_0.state

	var_1.PopId(var_8_0)

	local var_8_1 = arg_8_0.state

	if var_1.IsFinish(var_8_1) then
		local var_8_2 = arg_8_0.contextData.char
		local var_8_3 = var_1.GetTarotId(var_8_2)
		local var_8_4 = arg_8_0.state
		local var_8_5

		if var_2.GetHoldId(var_8_4) == var_8_3 then
			var_8_5 = 0
		else
			local var_8_6 = arg_8_0.state

			var_8_5 = var_2.GetHoldId(var_8_6)
		end

		local var_8_7 = arg_8_0
		local var_8_8 = arg_8_0.emit

		NewEducateReplaceTarotMediator = var_1_10006

		var_8_8(var_8_7, var_1_10006.ON_REPLACE_TAROT, var_8_5)
	else
		arg_8_0:closeView()
	end

	return
end

function var_0_1.OnReplaceDone(arg_9_0, arg_9_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_10_0)
			local var_10_0 = arg_9_0._tf
			local var_10_1 = var_1.GetComponent

			typeof = var_2_10004
			Animation = var_2_10006

			local var_10_2 = var_10_1(var_10_0, var_2_10004(var_2_10006))

			var_1.Play(var_10_2, "Anim_NewEducateReplaceTarotUI_cliek")

			onDelayTick = var_1

			var_1(arg_10_0, 0.4)

			return
		end,
		function(arg_11_0)
			if #arg_9_1.drops > 0 then
				local var_11_0 = arg_9_0

				var_1.emit(var_11_0, var_0_1.ON_DROP, {
					items = arg_9_1.drops,
					removeFunc = function()
						arg_11_0()

						return
					end
				})
			else
				arg_11_0()
			end

			return
		end
	}, function()
		local var_13_0 = arg_9_0

		var_0.closeView(var_13_0)

		return
	end)

	return
end

function var_0_1.onBackPressed(arg_14_0)
	return
end

function var_0_1.willExit(arg_15_0)
	local var_15_0 = arg_15_0.oldCard

	var_1.Dispose(var_15_0)

	local var_15_1 = arg_15_0.newCard

	var_1.Dispose(var_15_1)
	arg_15_0:UnOverlayPanel(arg_15_0._tf)

	existCall = var_1

	var_1(arg_15_0.contextData.onExit)

	return
end

return var_0_1
