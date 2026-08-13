class = var_0_10000

local var_0_0 = var_0_10000("BackyardMsgBoxMgr")

function var_0_0.Init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.view = arg_1_1
	arg_1_0.loaded = false
	PoolMgr = var_3

	local var_1_0 = var_3.GetInstance()

	var_3.GetUI(var_1_0, "BackYardMsgBox", true, function(arg_2_0)
		if arg_1_0.exited then
			return
		end

		setParent = var_1

		local var_2_0 = arg_2_0

		pg = var_2_10003

		var_1(var_2_0, var_2_10003.UIMgr.GetInstance().UIMain)

		arg_1_0._go = arg_2_0
		arg_1_0._tf = arg_2_0.transform

		local var_2_1 = arg_1_0

		findTF = var_2
		var_2_1.frame = var_2(arg_1_0._tf, "msg")

		local var_2_2 = arg_1_0

		findTF = var_2
		var_2_2.closeBtn = var_2(arg_1_0._tf, "frame/close")

		local var_2_3 = arg_1_0

		findTF = var_2

		local var_2_4 = var_2(arg_1_0._tf, "msg/Text")
		local var_2_5 = var_2.GetComponent

		typeof = var_4
		Text = var_2_10005
		var_2_3.context = var_2_5(var_2_4, var_4(var_2_10005))

		local var_2_6 = arg_1_0

		findTF = var_2
		var_2_6.cancelBtn = var_2(arg_1_0._tf, "msg/btns/btn2")

		local var_2_7 = arg_1_0

		findTF = var_2
		var_2_7.confirmBtn = var_2(arg_1_0._tf, "msg/btns/btn1")

		local var_2_8 = arg_1_0

		findTF = var_2
		var_2_8.helpPanel = var_2(arg_1_0._tf, "help_panel")

		local var_2_9 = arg_1_0
		local var_2_10 = arg_1_0.helpPanel

		var_2_9._helpList = var_2.Find(var_2_10, "list")
		setText = var_2_9

		local var_2_11 = arg_1_0._tf
		local var_2_12 = var_2.Find(var_2_11, "frame/title")

		i18n = var_2_11

		var_2_9(var_2_12, var_2_11("words_information"))

		setText = var_2_9

		local var_2_13 = arg_1_0.cancelBtn
		local var_2_14 = var_2.Find(var_2_13, "Text")

		i18n = var_2_13

		var_2_9(var_2_14, var_2_13("word_cancel"))

		setText = var_2_9

		local var_2_15 = arg_1_0.confirmBtn
		local var_2_16 = var_2.Find(var_2_15, "Text")

		i18n = var_2_15

		var_2_9(var_2_16, var_2_15("battle_result_confirm"))

		local var_2_17 = arg_1_0

		var_2_17.loaded = true
		setActive = var_2_17

		var_2_17(arg_1_0._tf, false)
		arg_1_2()

		return
	end)

	pg = var_3

	var_3.DelegateInfo.New(arg_1_0.view)

	return
end

function var_0_0.Show(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0.frame, true)

	setActive = var_1_10002

	var_1_10002(arg_3_0.helpPanel, false)

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
	onButton = var_1_10002

	local var_4_0 = arg_4_0.view
	local var_4_1 = arg_4_0.confirmBtn

	local function var_4_2()
		if arg_4_0.onYes then
			arg_4_0.onYes()
		end

		local var_5_0 = arg_4_0

		var_0.Hide(var_5_0)

		return
	end

	if not arg_4_1.yesSound then
		SFX_PANEL = var_6
	end

	var_1_10002(var_4_0, var_4_1, var_4_2, var_6)

	onButton = var_1_10002

	local var_4_3 = arg_4_0.view
	local var_4_4 = arg_4_0._tf

	local function var_4_5()
		local var_6_0 = arg_4_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_6

	var_1_10002(var_4_3, var_4_4, var_4_5, var_6)

	onButton = var_1_10002

	local var_4_6 = arg_4_0.view
	local var_4_7 = arg_4_0.closeBtn

	local function var_4_8()
		local var_7_0 = arg_4_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_6

	var_1_10002(var_4_6, var_4_7, var_4_8, var_6)

	onButton = var_1_10002

	local var_4_9 = arg_4_0.view
	local var_4_10 = arg_4_0.cancelBtn

	local function var_4_11()
		if arg_4_0.onNo then
			arg_4_0.onNo()
		end

		local var_8_0 = arg_4_0

		var_0.Hide(var_8_0)

		return
	end

	SFX_PANEL = var_6

	var_1_10002(var_4_9, var_4_10, var_4_11, var_6)

	setActive = var_1_10002

	var_1_10002(arg_4_0.cancelBtn, not arg_4_1.hideNo)

	setActive = var_1_10002

	var_1_10002(arg_4_0._tf, true)

	pg = var_1_10002

	local var_4_12 = var_1_10002.UIMgr.GetInstance()

	var_2.OverlayPanel(var_4_12, arg_4_0._tf)

	return
end

function var_0_0.ShowHelp(arg_9_0, arg_9_1)
	setActive = var_1_10002

	var_1_10002(arg_9_0.frame, false)

	setActive = var_1_10002

	var_1_10002(arg_9_0.helpPanel, true)

	for iter_9_0 = #arg_9_1.helps, arg_9_0._helpList.childCount - 1 do
		Destroy = var_1_10007

		local var_9_0 = arg_9_0._helpList

		var_1_10007(var_8.GetChild(var_9_0, iter_9_0))
	end

	for iter_9_1 = arg_9_0._helpList.childCount, #var_2 - 1 do
		cloneTplTo = var_1_10007

		var_1_10007(arg_9_0._helpTpl, arg_9_0._helpList)
	end

	ipairs = var_3

	for iter_9_2, iter_9_3 in var_3(var_2) do
		local var_9_1 = arg_9_0._helpList
		local var_9_2 = var_8.GetChild(var_9_1, iter_9_2 - 1)

		setActive = var_9_1

		var_9_1(var_9_2, true)

		local var_9_3 = var_9_2
		local var_9_4 = var_9_2.Find(var_9_3, "icon")

		setActive = var_9_3

		var_9_3(var_9_4, iter_9_3.icon)

		setActive = var_9_3
		findTF = var_11

		var_9_3(var_11(var_9_2, "line"), iter_9_3.line)

		local var_9_5 = var_9_2:Find("richText")
		local var_9_6 = var_10.GetComponent(var_9_5, "RichText")

		setText = var_9_5

		local var_9_7 = var_9_2

		HXSet = var_13

		local var_9_8 = var_13.hxLan

		if iter_9_3.info then
			SwitchSpecialChar = var_14

			local var_9_9

			if not var_14(iter_9_3.info, true) then
				var_9_9 = ""
			end

			var_9_5(var_9_7, var_9_8(var_9_9))
		end
	end

	arg_9_0:Common(arg_9_1)

	return
end

function var_0_0.Hide(arg_10_0)
	arg_10_0.onYes = nil
	arg_10_0.onNo = nil
	arg_10_0.isShowMsg = false
	setActive = var_1

	var_1(arg_10_0._tf, false)

	pg = var_1

	local var_10_0 = var_1.UIMgr.GetInstance()
	local var_10_1 = var_1.UnOverlayPanel
	local var_10_2 = arg_10_0._tf

	pg = var_1_10004

	var_10_1(var_10_0, var_10_2, var_1_10004.UIMgr.GetInstance().UIMain)

	return
end

function var_0_0.Destroy(arg_11_0)
	arg_11_0.exited = true

	if arg_11_0.isShowMsg then
		arg_11_0:Hide()
	end

	PoolMgr = var_1

	local var_11_0 = var_1.GetInstance()

	var_1.ReturnUI(var_11_0, "BackYardMsgBox", arg_11_0._go)

	return
end

return var_0_0
