class = var_0_10000

local var_0_0 = "FriendRequestPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "FriendRequestUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.requestPanel = var_1.Find(var_2_0, "request_panel")

	local var_2_1 = arg_2_0._tf

	arg_2_0.requestTopTF = var_1.Find(var_2_1, "request_view_top")

	local var_2_2 = arg_2_0.requestTopTF

	arg_2_0.refuseAllBtn = var_1.Find(var_2_2, "refuse_all_btn")

	local var_2_3 = arg_2_0._tf

	arg_2_0.informPanel = var_1.Find(var_2_3, "inform_panel")

	local var_2_4 = arg_2_0.informPanel

	arg_2_0.toggleTpl = var_1.Find(var_2_4, "frame/window/main/Toggle")

	local var_2_5 = arg_2_0.informPanel

	arg_2_0.buttonTpl = var_1.Find(var_2_5, "frame/window/main/button")

	local var_2_6 = arg_2_0.informPanel

	arg_2_0.toggleContainer = var_1.Find(var_2_6, "frame/window/main/toggles")

	local var_2_7 = arg_2_0.informPanel

	arg_2_0.confirmBtn = var_1.Find(var_2_7, "frame/window/buttons/confirm_btn")

	local var_2_8 = arg_2_0.informPanel

	arg_2_0.cancelBtn = var_1.Find(var_2_8, "frame/window/buttons/cancel_btn")

	local var_2_9 = arg_2_0.informPanel

	arg_2_0.backBtn = var_1.Find(var_2_9, "frame/window/top/btnBack")

	local var_2_10 = arg_2_0.informPanel
	local var_2_11 = var_1.Find(var_2_10, "frame/window/name")
	local var_2_12 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.nameTF = var_2_12(var_2_11, var_4(var_1_10006))
	setActive = var_1

	var_1(arg_2_0.informPanel, false)

	return
end

function var_0_1.OnInit(arg_3_0)
	FriendRefusePage = var_1_10001
	arg_3_0.refuseMsgBox = var_1_10001.New(arg_3_0._tf, arg_3_0.event)
	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.refuseAllBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		FriendMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.REFUSE_ALL_REQUEST)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)
	arg_3_0:InitInform()

	return
end

function var_0_1.UpdateData(arg_5_0, arg_5_1)
	local var_5_0

	if not arg_5_1.requestVOs then
		var_5_0 = {}
	end

	arg_5_0.requestVOs = var_5_0

	if not arg_5_0.isInit then
		arg_5_0.isInit = true

		arg_5_0:isInitRequestPage()
	else
		arg_5_0:sortRequest()
	end

	return
end

function var_0_1.isInitRequestPage(arg_6_0)
	arg_6_0.requestItems = {}

	local var_6_0 = arg_6_0.requestPanel
	local var_6_1 = var_1.Find(var_6_0, "mask/view")

	arg_6_0.requestRect = var_1.GetComponent(var_6_1, "LScrollRect")

	function arg_6_0.requestRect.onInitItem(arg_7_0)
		local var_7_0 = arg_6_0

		var_1.onInitItem(var_7_0, arg_7_0)

		return
	end

	function arg_6_0.requestRect.onUpdateItem(arg_8_0, arg_8_1)
		local var_8_0 = arg_6_0

		var_2.onUpdateItem(var_8_0, arg_8_0, arg_8_1)

		return
	end

	arg_6_0:sortRequest()

	return
end

function var_0_1.sortRequest(arg_9_0)
	local var_9_0 = arg_9_0.requestRect

	var_1.SetTotalCount(var_9_0, #arg_9_0.requestVOs, -1)

	return
end

function var_0_1.onInitItem(arg_10_0, arg_10_1)
	FriendRequestCard = var_1_10002

	local var_10_0 = var_1_10002.New(arg_10_1)

	onButton = var_1_10003

	local var_10_1 = arg_10_0
	local var_10_2 = var_10_0.acceptBtn

	local function var_10_3()
		if var_10_0.friendVO then
			local var_11_0 = arg_10_0
			local var_11_1 = var_0.emit

			FriendMediator = var_2_10003

			var_11_1(var_11_0, var_2_10003.ACCEPT_REQUEST, var_10_0.friendVO.id)
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_10_1, var_10_2, var_10_3, var_1_10008)

	onButton = var_1_10003

	var_1_10003(arg_10_0, var_10_0.refuseBtn, function()
		if var_10_0.friendVO then
			local var_12_0 = arg_10_0.refuseMsgBox
			local var_12_1 = var_0.ExecuteAction
			local var_12_2 = "Show"

			i18n = var_2_10004

			local var_12_3 = var_2_10004("refuse_friend")

			i18n = var_2_10005

			var_12_1(var_12_0, var_12_2, var_12_3, var_2_10005("refuse_and_add_into_bl"), function(arg_13_0)
				local var_13_0 = arg_10_0
				local var_13_1 = var_1.emit

				FriendMediator = var_3_10004

				var_13_1(var_13_0, var_3_10004.REFUSE_REQUEST, var_10_0.friendVO, arg_13_0)

				return
			end)
		end

		return
	end)

	onButton = var_1_10003

	local var_10_4 = arg_10_0
	local var_10_5 = var_10_0.resumeBtn

	local function var_10_6()
		local var_14_0 = arg_10_0
		local var_14_1 = var_0.emit

		FriendMediator = var_2_10003

		var_14_1(var_14_0, var_2_10003.OPEN_RESUME, var_10_0.friendVO.id)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_10_4, var_10_5, var_10_6, var_1_10008)

	arg_10_0.requestItems[arg_10_1] = var_10_0

	return
end

function var_0_1.onUpdateItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0

	if not arg_15_0.requestItems[arg_15_2] then
		arg_15_0:onInitItem(arg_15_2)

		var_15_0 = arg_15_0.requestItems[arg_15_2]
	end

	local var_15_1 = arg_15_0.requestVOs[arg_15_1 + 1]

	var_15_0:update(var_15_1.player, var_15_1.timestamp, var_15_1.content)

	onButton = var_5

	var_5(arg_15_0, var_15_0.reportBtn, function()
		if var_15_0.friendVO then
			local var_16_0 = arg_15_0

			var_0.openInfromPanel(var_16_0, var_15_0.friendVO, var_15_1.content)
		end

		return
	end)

	return
end

function var_0_1.openInfromPanel(arg_17_0, arg_17_1, arg_17_2)
	setActive = var_1_10003

	var_1_10003(arg_17_0.informPanel, true)
	arg_17_0:UpdateInform(arg_17_1, arg_17_2)

	return
end

function var_0_1.closeInfromPanel(arg_18_0)
	setActive = var_1_10001

	var_1_10001(arg_18_0.informPanel, false)

	return
end

function var_0_1.InitInform(arg_19_0)
	require = var_1_10001

	local var_19_0 = var_1_10001("ShareCfg.informCfg")

	ipairs = var_1_10002

	for iter_19_0, iter_19_1 in var_1_10002(var_19_0) do
		cloneTplTo = var_1_10007

		local var_19_1 = var_1_10007(arg_19_0.toggleTpl, arg_19_0.toggleContainer)
		local var_19_2 = var_1_10007.Find(var_19_1, "Label")
		local var_19_3 = var_8.GetComponent(var_19_2, "Text")

		var_19_3.text = iter_19_1.content
		onToggle = var_19_3

		var_19_3(arg_19_0, var_1_10007, function(arg_20_0)
			if arg_20_0 then
				arg_19_0.informInfo = iter_19_1.content
			end

			return
		end)
	end

	onButton = var_2

	var_2(arg_19_0, arg_19_0.cancelBtn, function()
		local var_21_0 = arg_19_0

		var_0.closeInfromPanel(var_21_0)

		return
	end)

	onButton = var_2

	var_2(arg_19_0, arg_19_0.backBtn, function()
		local var_22_0 = arg_19_0

		var_0.closeInfromPanel(var_22_0)

		return
	end)

	return
end

function var_0_1.UpdateInform(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.nameTF

	i18n = var_1_10004
	var_23_0.text = var_1_10004("inform_player", arg_23_1.name)
	onButton = var_23_0

	var_23_0(arg_23_0, arg_23_0.confirmBtn, function()
		if not arg_23_0.informInfo then
			pg = var_0

			local var_24_0 = var_0.TipsMgr.GetInstance()
			local var_24_1 = var_0.ShowTips

			i18n = var_2_10003

			var_24_1(var_24_0, var_2_10003("inform_select_type"))

			return
		end

		local var_24_2 = arg_23_0
		local var_24_3 = var_0.emit

		FriendMediator = var_2_10003

		var_24_3(var_24_2, var_2_10003.INFORM, arg_23_1.id, arg_23_0.informInfo, arg_23_2)

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_25_0)
	pairs = var_1_10001

	local var_25_0

	if not arg_25_0.requestItems then
		var_25_0 = {}
	end

	for iter_25_0, iter_25_1 in var_1_10001(var_25_0) do
		iter_25_1:dispose()
	end

	local var_25_1 = arg_25_0.refuseMsgBox

	var_1.Destroy(var_25_1)

	return
end

return var_0_1
