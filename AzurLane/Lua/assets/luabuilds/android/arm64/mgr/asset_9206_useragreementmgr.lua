pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.UserAgreementMgr = var_0_10001("UserAgreementMgr")
pg = var_0

local var_0_1 = var_0.UserAgreementMgr
local var_0_2 = "UserAgreementUI"
local var_0_3 = 0
local var_0_4 = 1
local var_0_5 = 2

function var_0_1.Init(arg_1_0, arg_1_1)
	arg_1_0.state = var_0_3

	if arg_1_1 then
		arg_1_1()
	end

	return
end

function var_0_1.Show(arg_2_0, arg_2_1)
	arg_2_0.onClose = arg_2_1.onClose
	arg_2_0.content = arg_2_1.content
	arg_2_0.forceRead = arg_2_1.forceRead
	arg_2_0.title = arg_2_1.title

	if arg_2_0.state == var_0_3 then
		arg_2_0:LoadUI()
	elseif arg_2_0.state == var_0_5 then
		arg_2_0:Flush()
	elseif arg_2_0.state == var_0_4 then
		-- block empty
	end

	return
end

function var_0_1.LoadUI(arg_3_0)
	arg_3_0.state = var_0_4
	pg = var_1

	local var_3_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOn(var_3_0)

	PoolMgr = var_1

	local var_3_1 = var_1.GetInstance()

	var_1.GetUI(var_3_1, var_0_2, true, function(arg_4_0)
		local var_4_0 = arg_3_0

		var_4_0.state = var_0_5
		pg = var_4_0

		local var_4_1 = var_4_0.UIMgr.GetInstance()

		var_1.LoadingOff(var_4_1)

		arg_3_0._go = arg_4_0

		local var_4_2 = arg_3_0

		var_1.OnLoaded(var_4_2)

		local var_4_3 = arg_3_0

		var_1.Flush(var_4_3)

		setActive = var_1

		var_1(arg_3_0._go, true)

		pg = var_1

		local var_4_4 = var_1.UIMgr.GetInstance()

		var_1.BlurPanel(var_4_4, arg_3_0._go.transform)

		return
	end)

	return
end

function var_0_1.OnLoaded(arg_5_0)
	local var_5_0 = arg_5_0._go.transform
	local var_5_1 = var_1.Find(var_5_0, "window/container/scrollrect/content/Text")
	local var_5_2 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_5_0.contentTxt = var_5_2(var_5_1, var_4(var_1_10006))

	local var_5_3 = arg_5_0._go.transform

	arg_5_0.acceptBtn = var_1.Find(var_5_3, "window/accept_btn")

	local var_5_4 = arg_5_0.acceptBtn
	local var_5_5 = var_1.Find(var_5_4, "Text")
	local var_5_6 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_5_0.acceptBtnTxt = var_5_6(var_5_5, var_4(var_1_10006))

	local var_5_7 = arg_5_0._go.transform
	local var_5_8 = var_1.Find(var_5_7, "window/container/scrollrect")
	local var_5_9 = var_1.GetComponent

	typeof = var_4
	ScrollRect = var_1_10006
	arg_5_0.scrollrect = var_5_9(var_5_8, var_4(var_1_10006))

	local var_5_10 = arg_5_0._go.transform
	local var_5_11 = var_1.Find(var_5_10, "window/title")
	local var_5_12 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_5_0.titleTxt = var_5_12(var_5_11, var_4(var_1_10006))

	local var_5_13 = arg_5_0._go.transform
	local var_5_14 = var_1.Find(var_5_13, "window/title1/Text")
	local var_5_15 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_5_0.msgboxTitleTxt = var_5_15(var_5_14, var_4(var_1_10006))

	return
end

function var_0_1.Flush(arg_6_0)
	local var_6_0 = arg_6_0.msgboxTitleTxt

	i18n = var_1_10002
	var_6_0.text = var_1_10002("title_info")
	arg_6_0.contentTxt.text = arg_6_0.content

	local var_6_1 = arg_6_0.acceptBtnTxt

	i18n = var_2
	var_6_1.text = var_2("word_back")
	arg_6_0.titleTxt.text = arg_6_0.title

	local var_6_2 = not arg_6_0.forceRead

	onButton = var_2

	var_2(nil, arg_6_0.acceptBtn, function()
		if var_6_2 then
			local var_7_0 = arg_6_0

			var_0.Hide(var_7_0)
		else
			pg = var_0

			local var_7_1 = var_0.TipsMgr.GetInstance()
			local var_7_2 = var_0.ShowTips

			i18n = var_2_10003

			var_7_2(var_7_1, var_2_10003("read_the_user_agreement"))
		end

		return
	end)

	onScroll = var_2

	var_2(nil, arg_6_0.scrollrect.gameObject, function(arg_8_0)
		if arg_8_0.y <= 0.01 and not var_6_2 then
			var_6_2 = true
			setButtonEnabled = var_1

			var_1(arg_6_0.acceptBtn, var_6_2)
		end

		return
	end)

	setButtonEnabled = var_2

	var_2(arg_6_0.acceptBtn, var_6_2)

	scrollTo = var_2

	var_2(arg_6_0.scrollrect.gameObject, 0, 1)

	return
end

function var_0_1.Hide(arg_9_0)
	if arg_9_0.onClose then
		arg_9_0.onClose()
	end

	if arg_9_0.acceptBtn then
		removeOnButton = var_1

		var_1(arg_9_0.acceptBtn)
	end

	if arg_9_0.scrollrect then
		local var_9_0 = arg_9_0.scrollrect.onValueChanged

		var_1.RemoveAllListeners(var_9_0)
	end

	arg_9_0.onClose = nil
	arg_9_0.content = nil
	arg_9_0.forceRead = nil
	arg_9_0.title = nil

	if arg_9_0._go then
		pg = var_1

		local var_9_1 = var_1.UIMgr.GetInstance()
		local var_9_2 = var_1.UnOverlayPanel
		local var_9_3 = arg_9_0._go.transform

		pg = var_1_10005

		var_9_2(var_9_1, var_9_3, var_1_10005.UIMgr.GetInstance().UIMain)

		PoolMgr = var_9_2

		local var_9_4 = var_9_2.GetInstance()

		var_1.ReturnUI(var_9_4, var_0_2, arg_9_0._go)

		arg_9_0._go = nil
	end

	arg_9_0.state = var_0_3

	return
end

function var_0_1.ShowForBiliPrivate(arg_10_0)
	require = var_1_10001

	local var_10_0 = var_1_10001("GameCfg.useragreems.BiliPrivate")

	arg_10_0:Show({
		content = var_10_0.content,
		title = var_10_0.title
	})

	return
end

function var_0_1.ShowForBiliLicence(arg_11_0)
	require = var_1_10001

	local var_11_0 = var_1_10001("GameCfg.useragreems.BiliLicence")

	arg_11_0:Show({
		content = var_11_0.content,
		title = var_11_0.title
	})

	return
end

function var_0_1.ShowChtPrivate(arg_12_0)
	require = var_1_10001

	local var_12_0 = var_1_10001("GameCfg.useragreems.ChtPrivate")

	arg_12_0:Show({
		content = var_12_0.content,
		title = var_12_0.title
	})

	return
end

function var_0_1.ShowChtLicence(arg_13_0)
	require = var_1_10001

	local var_13_0 = var_1_10001("GameCfg.useragreems.ChtLicence")

	arg_13_0:Show({
		content = var_13_0.content,
		title = var_13_0.title
	})

	return
end

return
