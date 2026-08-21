local var_0_0 = class("ArchivesWorldBossAutoBattleMsgbox", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "ArchivesWorldBossAutoBattleMsgUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.contentTxt = arg_2_0._tf:Find("window/msg_panel/content/time"):GetComponent(typeof(Text))
	arg_2_0.startBtn = arg_2_0._tf:Find("window/btns/start")
	arg_2_0.startTxt = arg_2_0.startBtn:Find("pic"):GetComponent(typeof(Text))
	arg_2_0.cancelBtn = arg_2_0._tf:Find("window/btns/cancel")
	arg_2_0.cancelTxt = arg_2_0.cancelBtn:Find("pic"):GetComponent(typeof(Text))
	arg_2_0.closeBtn = arg_2_0._tf:Find("window/top/close")
	arg_2_0.titleTxt = arg_2_0._tf:Find("window/top/title"):GetComponent(typeof(Text))

	setText(arg_2_0._tf:Find("window/msg_panel/content/label"), i18n("world_boss_archives_stop_auto_battle_tip"))
	setText(arg_2_0._tf:Find("window/msg_panel/label1"), i18n("world_boss_archives_stop_auto_battle_tip1"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		if arg_3_0.OnNo then
			arg_3_0.OnNo()
		end

		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.startBtn, function()
		if arg_3_0.OnYes then
			arg_3_0.OnYes()
		end

		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_8_0, arg_8_1)
	var_0_0.super.Show(arg_8_0)
	arg_8_0:RemoveTimer()

	if arg_8_1.onContent then
		arg_8_0:AddTimer(arg_8_1)
	else
		arg_8_0.contentTxt.text = arg_8_1.content
	end

	arg_8_0.titleTxt.text = arg_8_1.title
	arg_8_0.OnYes = arg_8_1.onYes
	arg_8_0.OnNo = arg_8_1.onNo

	setActive(arg_8_0.cancelBtn, not arg_8_1.noNo)

	arg_8_0.startTxt.text = arg_8_1.yesText or i18n("word_ok")
	arg_8_0.cancelTxt.text = arg_8_1.noText or i18n("word_cancel")

	return
end

function var_0_0.AddTimer(arg_9_0, arg_9_1)
	arg_9_0.timer = Timer.New(function()
		local var_10_0 = arg_9_1.onContent()

		if var_10_0 == nil then
			arg_9_0:Hide()
		end

		arg_9_0.contentTxt.text = var_10_0

		return
	end, 1, -1)

	arg_9_0.timer:Start()
	arg_9_0.timer.func()

	return
end

function var_0_0.RemoveTimer(arg_11_0)
	if arg_11_0.timer then
		arg_11_0.timer:Stop()

		arg_11_0.timer = nil
	end

	return
end

function var_0_0.Hide(arg_12_0)
	var_0_0.super.Hide(arg_12_0)
	arg_12_0:RemoveTimer()

	arg_12_0.OnYes = nil
	arg_12_0.OnNo = nil

	return
end

function var_0_0.OnDestroy(arg_13_0)
	if arg_13_0:isShowing() then
		arg_13_0:Hide()
	end

	return
end

return var_0_0
