class = var_0_10000

local var_0_0 = "MonopolyCar2024PickPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "MonopolyCar2024PickUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_0, "confirm")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_2_0.anim = var_2_2(var_2_1, var_4(var_1_10006))

	local var_2_3 = arg_2_0.anim
	local var_2_4 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_2_0.animEvent = var_2_4(var_2_3, var_4(var_1_10006))

	local var_2_5 = arg_2_0.animEvent

	var_1.SetEndEvent(var_2_5, function()
		var_0_1.super.Hide(arg_2_0)

		return
	end)

	local var_2_6 = {}
	local var_2_7 = arg_2_0._tf

	var_2_6[1] = var_2.Find(var_2_7, "list/1")

	local var_2_8 = arg_2_0._tf

	var_2_6[2] = var_2.Find(var_2_8, "list/2")

	local var_2_9 = arg_2_0._tf

	var_2_6[3] = var_2.Find(var_2_9, "list/3")
	arg_2_0.items = var_2_6
	setText = var_2_6

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_3.Find(var_2_10, "title/Text")

	i18n = var_2_9

	var_2_6(var_2_11, var_2_9("MonopolyCar2024Game_pick_tip"))

	setText = var_2_6

	local var_2_12 = arg_2_0.confirmBtn
	local var_2_13 = var_3.Find(var_2_12, "Text")

	i18n = var_4

	var_2_6(var_2_13, var_4("MonopolyCar2024Game_sel_label"))

	return
end

function var_0_1.OnInit(arg_4_0)
	arg_4_0.selectedId = 0
	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.confirmBtn

	local function var_4_2()
		if arg_4_0.selectedId <= 0 then
			return
		end

		if arg_4_0.callback then
			arg_4_0.callback(arg_4_0.selectedId)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_0, var_4_1, var_4_2, var_1_10006)

	return
end

function var_0_1.UpdateList(arg_6_0)
	ipairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.items) do
		table = var_1_10006
		var_1_10006 = var_1_10006.contains(arg_6_0.banList, iter_6_0)
		onToggle = var_1_10007

		local var_6_0 = arg_6_0
		local var_6_1 = iter_6_1

		local function var_6_2(arg_7_0)
			if arg_7_0 then
				arg_6_0.selectedId = iter_6_0
			end

			return
		end

		SFX_PANEL = var_1_10012

		var_1_10007(var_6_0, var_6_1, var_6_2, var_1_10012)

		setToggleEnabled = var_1_10007

		var_1_10007(iter_6_1, not var_1_10006)

		warning = var_1_10007

		var_1_10007(iter_6_0, var_1_10006)

		setActive = var_1_10007

		var_1_10007(iter_6_1:Find(iter_6_0 .. "/active"), not var_1_10006)

		setActive = var_1_10007

		var_1_10007(iter_6_1:Find(iter_6_0 .. "/coin"), arg_6_0.banCount < 3 and not var_1_10006)

		if not var_1_10006 then
			triggerToggle = var_1_10007

			var_1_10007(iter_6_1, true)
		end
	end

	return
end

function var_0_1.Show(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	var_0_1.super.Show(arg_8_0)

	arg_8_0.activityId = arg_8_1
	arg_8_0.turnCnt = arg_8_4
	arg_8_0.banCount = #arg_8_2

	if arg_8_0.banCount >= 3 then
		arg_8_0.banList = {}
	else
		arg_8_0.banList = arg_8_2
	end

	arg_8_0.callback = arg_8_5

	arg_8_0:UpdateList()

	pg = var_6

	local var_8_0 = var_6.UIMgr.GetInstance()

	var_6.BlurPanel(var_8_0, arg_8_0._tf)

	local var_8_1 = arg_8_0.anim

	var_6.Play(var_8_1, "anim_monopolycar_pick_in")
	arg_8_0:CheckAuto(arg_8_3)

	return
end

function var_0_1.CheckAuto(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	local var_9_0 = {}

	ipairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(arg_9_0.items) do
		table = var_1_10008

		if not var_1_10008.contains(arg_9_0.banList, iter_9_0) then
			table = var_1_10008

			var_1_10008.insert(var_9_0, iter_9_0)
		end
	end

	math = var_3
	arg_9_0.selectedId = var_9_0[var_3.random(1, #var_9_0)]

	if arg_9_0.callback then
		arg_9_0.callback(arg_9_0.selectedId)
	end

	return
end

function var_0_1.Hide(arg_10_0)
	local var_10_0 = arg_10_0.anim

	var_1.Play(var_10_0, "anim_monopolycar_pick_out")

	ipairs = var_1

	for iter_10_0, iter_10_1 in var_1(arg_10_0.items) do
		triggerToggle = var_1_10006

		var_1_10006(iter_10_1, false)
	end

	arg_10_0.selectedId = 0
	pg = var_1

	local var_10_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_10_1, arg_10_0._tf, arg_10_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_11_0)
	return
end

return var_0_1
