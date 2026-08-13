class = var_0_10000

local var_0_0 = "ArchivesWorldBossAutoBattleMsgbox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ArchivesWorldBossAutoBattleMsgUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "window/msg_panel/content/time")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.contentTxt = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf

	arg_2_0.startBtn = var_1.Find(var_2_3, "window/btns/start")

	local var_2_4 = arg_2_0.startBtn
	local var_2_5 = var_1.Find(var_2_4, "pic")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.startTxt = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_7, "window/btns/cancel")

	local var_2_8 = arg_2_0.cancelBtn
	local var_2_9 = var_1.Find(var_2_8, "pic")
	local var_2_10 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.cancelTxt = var_2_10(var_2_9, var_3(var_1_10004))

	local var_2_11 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_11, "window/top/close")

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.Find(var_2_12, "window/top/title")
	local var_2_14 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.titleTxt = var_2_14(var_2_13, var_3(var_1_10004))
	setText = var_1

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_2.Find(var_2_15, "window/msg_panel/content/label")

	i18n = var_2_15

	var_1(var_2_16, var_2_15("world_boss_archives_stop_auto_battle_tip"))

	setText = var_1

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_2.Find(var_2_17, "window/msg_panel/label1")

	i18n = var_2_17

	var_1(var_2_18, var_2_17("world_boss_archives_stop_auto_battle_tip1"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.cancelBtn

	local function var_3_8()
		if arg_3_0.OnNo then
			arg_3_0.OnNo()
		end

		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.startBtn

	local function var_3_11()
		if arg_3_0.OnYes then
			arg_3_0.OnYes()
		end

		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	return
end

function var_0_1.Show(arg_8_0, arg_8_1)
	var_0_1.super.Show(arg_8_0)
	arg_8_0:RemoveTimer()

	if arg_8_1.onContent then
		arg_8_0:AddTimer(arg_8_1)
	else
		arg_8_0.contentTxt.text = arg_8_1.content
	end

	arg_8_0.titleTxt.text = arg_8_1.title
	arg_8_0.OnYes = arg_8_1.onYes
	arg_8_0.OnNo = arg_8_1.onNo
	setActive = var_2

	var_2(arg_8_0.cancelBtn, not arg_8_1.noNo)

	local var_8_0

	if not arg_8_1.yesText then
		i18n = var_8_0
		var_8_0 = var_8_0("word_ok")
	end

	arg_8_0.startTxt.text = var_8_0

	local var_8_1

	if not arg_8_1.noText then
		i18n = var_8_1
		var_8_1 = var_8_1("word_cancel")
	end

	arg_8_0.cancelTxt.text = var_8_1

	return
end

function var_0_1.AddTimer(arg_9_0, arg_9_1)
	Timer = var_1_10002
	arg_9_0.timer = var_1_10002.New(function()
		if arg_9_1.onContent() == nil then
			local var_10_0 = arg_9_0

			var_1.Hide(var_10_0)
		end

		arg_9_0.contentTxt.text = var_0

		return
	end, 1, -1)

	local var_9_0 = arg_9_0.timer

	var_2.Start(var_9_0)
	arg_9_0.timer.func()

	return
end

function var_0_1.RemoveTimer(arg_11_0)
	if arg_11_0.timer then
		local var_11_0 = arg_11_0.timer

		var_1.Stop(var_11_0)

		arg_11_0.timer = nil
	end

	return
end

function var_0_1.Hide(arg_12_0)
	var_0_1.super.Hide(arg_12_0)
	arg_12_0:RemoveTimer()

	arg_12_0.OnYes = nil
	arg_12_0.OnNo = nil

	return
end

function var_0_1.OnDestroy(arg_13_0)
	if arg_13_0:isShowing() then
		arg_13_0:Hide()
	end

	return
end

return var_0_1
