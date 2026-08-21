local var_0_0 = class("BackyardMsgBoxMgr")

function var_0_0.Init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.view = arg_1_1
	arg_1_0.loaded = false

	PoolMgr.GetInstance():GetUI("BackYardMsgBox", true, function(arg_2_0)
		if arg_1_0.exited then
			return
		end

		setParent(arg_2_0, pg.UIMgr.GetInstance().UIMain)

		arg_1_0._go = arg_2_0
		arg_1_0._tf = arg_2_0.transform
		arg_1_0.frame = findTF(arg_1_0._tf, "msg")
		arg_1_0.closeBtn = findTF(arg_1_0._tf, "frame/close")
		arg_1_0.context = findTF(arg_1_0._tf, "msg/Text"):GetComponent(typeof(Text))
		arg_1_0.cancelBtn = findTF(arg_1_0._tf, "msg/btns/btn2")
		arg_1_0.confirmBtn = findTF(arg_1_0._tf, "msg/btns/btn1")
		arg_1_0.helpPanel = findTF(arg_1_0._tf, "help_panel")
		arg_1_0._helpList = arg_1_0.helpPanel:Find("list")

		setText(arg_1_0._tf:Find("frame/title"), i18n("words_information"))
		setText(arg_1_0.cancelBtn:Find("Text"), i18n("word_cancel"))
		setText(arg_1_0.confirmBtn:Find("Text"), i18n("battle_result_confirm"))

		arg_1_0.loaded = true

		setActive(arg_1_0._tf, false)
		arg_1_2()

		return
	end)
	pg.DelegateInfo.New(arg_1_0.view)

	return
end

function var_0_0.Show(arg_3_0, arg_3_1)
	setActive(arg_3_0.frame, true)
	setActive(arg_3_0.helpPanel, false)

	if not arg_3_0.loaded then
		return
	end

	arg_3_0.isShowMsg = true
	arg_3_0.context.text = arg_3_1.content
	arg_3_0.onYes = arg_3_1.onYes
	arg_3_0.onNo = arg_3_1.onNo

	arg_3_0:Common(arg_3_1)

	return
end

function var_0_0.Common(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.yesSound or SFX_PANEL

	onButton(arg_4_0.view, arg_4_0.confirmBtn, function()
		if arg_4_0.onYes then
			arg_4_0.onYes()
		end

		arg_4_0:Hide()

		return
	end, var_4_0)
	onButton(arg_4_0.view, arg_4_0._tf, function()
		arg_4_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_4_0.view, arg_4_0.closeBtn, function()
		arg_4_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_4_0.view, arg_4_0.cancelBtn, function()
		if arg_4_0.onNo then
			arg_4_0.onNo()
		end

		arg_4_0:Hide()

		return
	end, SFX_PANEL)
	setActive(arg_4_0.cancelBtn, not arg_4_1.hideNo)
	setActive(arg_4_0._tf, true)
	pg.UIMgr.GetInstance():OverlayPanel(arg_4_0._tf)

	return
end

function var_0_0.ShowHelp(arg_9_0, arg_9_1)
	setActive(arg_9_0.frame, false)
	setActive(arg_9_0.helpPanel, true)

	for iter_9_0 = #arg_9_1.helps, arg_9_0._helpList.childCount - 1 do
		Destroy(arg_9_0._helpList:GetChild(iter_9_0))
	end

	for iter_9_1 = arg_9_0._helpList.childCount, #arg_9_1.helps - 1 do
		cloneTplTo(arg_9_0._helpTpl, arg_9_0._helpList)
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_1.helps) do
		local var_9_0 = arg_9_0._helpList:GetChild(iter_9_2 - 1)

		setActive(var_9_0, true)
		setActive(var_9_0:Find("icon"), iter_9_3.icon)
		setActive(findTF(var_9_0, "line"), iter_9_3.line)

		local var_9_1 = var_9_0:Find("richText"):GetComponent("RichText")
		local var_9_2 = iter_9_3.info and SwitchSpecialChar(iter_9_3.info, true) or ""

		setText(var_9_0, HXSet.hxLan(var_9_2))
	end

	arg_9_0:Common(arg_9_1)

	return
end

function var_0_0.Hide(arg_10_0)
	arg_10_0.onYes = nil
	arg_10_0.onNo = nil
	arg_10_0.isShowMsg = false

	setActive(arg_10_0._tf, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0._tf, pg.UIMgr.GetInstance().UIMain)

	return
end

function var_0_0.Destroy(arg_11_0)
	arg_11_0.exited = true

	if arg_11_0.isShowMsg then
		arg_11_0:Hide()
	end

	PoolMgr.GetInstance():ReturnUI("BackYardMsgBox", arg_11_0._go)

	return
end

return var_0_0
