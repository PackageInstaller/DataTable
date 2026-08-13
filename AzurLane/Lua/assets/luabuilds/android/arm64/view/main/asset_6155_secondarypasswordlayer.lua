class = var_0_10000

local var_0_0 = "SecondaryPasswordLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.SetView = 1
var_0_1.InputView = 2

function var_0_1.getUIName(arg_1_0)
	return "SecondaryPasswordUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.window = var_1.Find(var_2_0, "window")

	local var_2_1 = arg_2_0.window

	arg_2_0.setView = var_1.Find(var_2_1, "sliders/set")

	local var_2_2 = arg_2_0.window

	arg_2_0.inputView = var_1.Find(var_2_2, "sliders/input")

	local var_2_3 = arg_2_0._tf

	arg_2_0.frame = var_1.Find(var_2_3, "frame")

	local var_2_4 = arg_2_0.window

	arg_2_0.informBg = var_1.Find(var_2_4, "top/bg/information")

	local var_2_5 = arg_2_0.informBg
	local var_2_6 = var_1.Find(var_2_5, "title")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.textTitle = var_2_7(var_2_6, var_4(var_1_10006))

	local var_2_8 = arg_2_0.informBg
	local var_2_9 = var_1.Find(var_2_8, "title/title_en")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.textTitleEn = var_2_10(var_2_9, var_4(var_1_10006))

	local var_2_11 = arg_2_0.window

	arg_2_0.inputpanel = var_1.Find(var_2_11, "inputpanel")

	local var_2_12 = arg_2_0.inputpanel

	arg_2_0.containerbtn = var_1.Find(var_2_12, "btns")
	CustomIndexLayer = var_1
	arg_2_0.btngroup = var_1.Clone2Full(arg_2_0.containerbtn, 10)
	_ = var_1

	var_1.each(arg_2_0.btngroup, function(arg_3_0)
		local var_3_0 = (arg_3_0:GetSiblingIndex() + 1) % 10

		tostring = var_2_10002
		arg_3_0.name = var_2_10002(var_3_0)
		setText = var_2

		local var_3_1 = arg_3_0:Find("text")

		tostring = var_2_10005

		var_2(var_3_1, var_2_10005(var_3_0))

		setText = var_2

		local var_3_2 = arg_3_0:Find("highlight/text2")

		tostring = var_5

		var_2(var_3_2, var_5(var_3_0))

		return
	end)

	local var_2_13 = arg_2_0.inputpanel

	arg_2_0.btnconfirm = var_1.Find(var_2_13, "confirmbtn")

	local var_2_14 = arg_2_0.inputpanel

	arg_2_0.btndelete = var_1.Find(var_2_14, "deletebtn")

	local var_2_15 = arg_2_0.window

	arg_2_0.btnclose = var_1.Find(var_2_15, "top/btnBack")

	local var_2_16 = arg_2_0._tf

	arg_2_0.resources = var_1.Find(var_2_16, "resources")

	local var_2_17 = arg_2_0._tf

	arg_2_0.selectFrame = var_1.Find(var_2_17, "resources/xian")
	arg_2_0.setDigitGroup = {}

	local var_2_18 = arg_2_0.setView

	arg_2_0.setLine1Grid = var_1.Find(var_2_18, "line1/input/grid")

	local var_2_19 = arg_2_0.setView

	arg_2_0.setLine2Grid = var_1.Find(var_2_19, "line2/input/grid")
	CustomIndexLayer = var_1

	var_1.Clone2Full(arg_2_0.setLine1Grid, 6)

	CustomIndexLayer = var_1

	var_1.Clone2Full(arg_2_0.setLine2Grid, 6)

	local var_2_20 = arg_2_0.setLine1Grid.childCount

	for iter_2_0 = 0, var_2_20 - 1 do
		table = var_1_10006
		var_1_10006 = var_1_10006.insert

		local var_2_21 = arg_2_0.setDigitGroup
		local var_2_22 = arg_2_0.setLine1Grid

		var_1_10006(var_2_21, var_9.GetChild(var_2_22, iter_2_0))
	end

	for iter_2_1 = 0, var_2_20 - 1 do
		table = var_1_10006
		var_1_10006 = var_1_10006.insert

		local var_2_23 = arg_2_0.setDigitGroup
		local var_2_24 = arg_2_0.setLine2Grid

		var_1_10006(var_2_23, var_9.GetChild(var_2_24, iter_2_1))
	end

	local var_2_25 = arg_2_0.setView

	arg_2_0.btnhide = var_2.Find(var_2_25, "line1/hidebtn/hide")

	local var_2_26 = arg_2_0.setView

	arg_2_0.btnshow = var_2.Find(var_2_26, "line1/hidebtn/show")

	local var_2_27 = arg_2_0.setView

	arg_2_0.tipseterror = var_2.Find(var_2_27, "line2/tip")
	arg_2_0.inputDigitGroup = {}

	local var_2_28 = arg_2_0.inputView

	arg_2_0.inputLineGrid = var_2.Find(var_2_28, "line1/input/grid")
	CustomIndexLayer = var_2

	var_2.Clone2Full(arg_2_0.inputLineGrid, 6)

	local var_2_29 = arg_2_0.inputLineGrid.childCount

	for iter_2_2 = 0, var_2_29 - 1 do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_2_30 = arg_2_0.inputDigitGroup
		local var_2_31 = arg_2_0.inputLineGrid

		var_1_10007(var_2_30, var_10.GetChild(var_2_31, iter_2_2))
	end

	arg_2_0.inputMode = false
	arg_2_0.timers = {}

	arg_2_0:InitInteractable()

	return
end

function var_0_1.InitInteractable(arg_4_0)
	_ = var_1_10001

	var_1_10001.each(arg_4_0.btngroup, function(arg_5_0)
		onButton = var_2_10001

		var_2_10001(arg_4_0, arg_5_0, function()
			local var_6_0 = arg_5_0
			local var_6_1 = (var_0.GetSiblingIndex(var_6_0) + 1) % 10
			local var_6_2 = arg_4_0.inputPos + 1
			local var_6_3

			if 0 < var_6_2 and var_6_2 <= #arg_4_0.digitGroup then
				var_6_3 = arg_4_0

				local var_6_4 = arg_4_0.inputs

				tostring = var_3_10004
				var_6_3.inputs = var_6_4 .. var_3_10004(var_6_1)

				local var_6_5 = arg_4_0.digitGroup[var_6_2]

				var_6_3 = var_6_3.Find(var_6_5, "text")
				setText = var_3

				var_3(var_6_3, var_6_1)

				setActive = var_3

				local var_6_6 = arg_4_0.digitGroup[var_6_2]

				var_3(var_5.Find(var_6_6, "filled"), false)

				setActive = var_3

				local var_6_7 = arg_4_0.digitGroup[var_6_2]

				var_3(var_5.Find(var_6_7, "space"), false)

				local function var_6_8()
					setText = var_4_10000

					var_4_10000(var_6_3, "")

					setActive = var_4_10000

					local var_7_0 = arg_4_0.digitGroup[var_6_2]

					var_4_10000(var_2.Find(var_7_0, "filled"), true)

					return
				end

				if not arg_4_0.inputMode then
					if arg_4_0.timers["input" .. var_6_2] then
						local var_6_9 = arg_4_0.timers["input" .. var_6_2]

						var_4.Reset(var_6_9, var_6_8, 1, 1)
					else
						local var_6_10 = arg_4_0.timers
						local var_6_11 = "input" .. var_6_2

						Timer = var_6
						var_6_10[var_6_11] = var_6.New(var_6_8, 1, 1)
					end

					local var_6_12 = arg_4_0.timers["input" .. var_6_2]

					var_4.Start(var_6_12)
				end

				local var_6_13 = arg_4_0

				var_4.SetInputPos(var_6_13, var_6_2)
			end

			setActive = var_6_3

			local var_6_14 = arg_5_0

			var_6_3(var_4.Find(var_6_14, "highlight"), true)

			local function var_6_15()
				setActive = var_4_10000

				local var_8_0 = arg_5_0

				var_4_10000(var_2.Find(var_8_0, "highlight"), false)

				return
			end

			if arg_4_0.timers["btn" .. var_6_1] then
				local var_6_16 = arg_4_0.timers["btn" .. var_6_1]

				var_3.Reset(var_6_16, var_6_15, 0.2, 1)
			else
				local var_6_17 = arg_4_0.timers
				local var_6_18 = "btn" .. var_6_1

				Timer = var_5
				var_6_17[var_6_18] = var_5.New(var_6_15, 0.2, 1)
			end

			local var_6_19 = arg_4_0.timers["btn" .. var_6_1]

			var_3.Start(var_6_19)

			return
		end)

		return
	end)

	onButton = var_1

	var_1(arg_4_0, arg_4_0.btndelete, function()
		local var_9_0 = arg_4_0.inputPos
		local var_9_1

		if 0 < var_9_0 and var_9_0 <= #arg_4_0.digitGroup then
			var_9_1 = arg_4_0
			string = var_2_10002
			var_9_1.inputs = var_2_10002.sub(arg_4_0.inputs, 1, -2)
			setText = var_9_1

			local var_9_2 = arg_4_0.digitGroup[var_9_0]

			var_9_1(var_3.Find(var_9_2, "text"), "")

			setActive = var_9_1

			local var_9_3 = arg_4_0.digitGroup[var_9_0]

			var_9_1(var_3.Find(var_9_3, "filled"), false)

			setActive = var_9_1

			local var_9_4 = arg_4_0.digitGroup[var_9_0]

			var_9_1(var_3.Find(var_9_4, "space"), not arg_4_0.inputMode)

			if arg_4_0.timers["input" .. var_9_0] then
				local var_9_5 = arg_4_0.timers["input" .. var_9_0]

				var_9_1.Stop(var_9_5)
			end

			local var_9_6 = arg_4_0

			var_9_1.SetInputPos(var_9_6, var_9_0 - 1)
		end

		setActive = var_9_1

		local var_9_7 = arg_4_0.btndelete

		var_9_1(var_3.Find(var_9_7, "highlight"), true)

		local function var_9_8()
			setActive = var_3_10000

			local var_10_0 = arg_4_0.btndelete

			var_3_10000(var_2.Find(var_10_0, "highlight"), false)

			return
		end

		if arg_4_0.timers.btndel then
			local var_9_9 = arg_4_0.timers.btndel

			var_2.Reset(var_9_9, var_9_8, 0.3, 1)
		else
			local var_9_10 = arg_4_0.timers

			Timer = var_3
			var_9_10.btndel = var_3.New(var_9_8, 0.3, 1)
		end

		local var_9_11 = arg_4_0.timers.btndel

		var_2.Start(var_9_11)

		return
	end)

	onButton = var_1

	var_1(arg_4_0, arg_4_0.btnconfirm, function()
		if arg_4_0.mode == var_0_1.InputView then
			arg_4_0.inputnone = false

			if #arg_4_0.inputs ~= 6 then
				return
			end

			local var_11_0 = arg_4_0
			local var_11_1 = var_0.emit

			SecondaryPasswordMediator = var_2_10003

			var_11_1(var_11_0, var_2_10003.CONFIRM_PASSWORD, arg_4_0.inputs)
		else
			arg_4_0.inputnone = false

			local var_11_2 = true

			if #arg_4_0.inputs ~= 12 then
				var_11_2 = false
			end

			for iter_11_0 = 1, 6 do
				string = var_2_10005
				var_2_10005 = var_2_10005.byte(arg_4_0.inputs, iter_11_0)
				string = var_2_10006

				if var_2_10005 ~= var_2_10006.byte(arg_4_0.inputs, 6 + iter_11_0) then
					var_11_2 = false

					break
				end
			end

			if not var_11_2 then
				local var_11_3 = arg_4_0

				var_1.UpdateView(var_11_3)

				return
			end

			string = var_1

			local var_11_4 = var_1.sub(arg_4_0.inputs, 1, 6)
			local var_11_5
			local var_11_6 = {}
			local var_11_7
			local var_11_8 = {
				modal = true,
				mode = "settips",
				hideYes = true,
				title = "setting"
			}

			MSGBOX_TYPE_SECONDPWD = var_2_10006
			var_11_8.type = var_2_10006
			var_11_8.references = var_11_6

			function var_11_8.onYes()
				local var_12_0 = var_11_6.inputfield.text

				var_11_6.lasttext = var_12_0

				local var_12_1 = {
					modal = true
				}

				string = var_3_10002

				local var_12_2 = var_3_10002.format

				i18n = var_3_10004
				var_12_1.content = var_12_2(var_3_10004("secondarypassword_confirm_tips"), var_12_0)

				function var_12_1.onNo()
					pg = var_4_10000

					local var_13_0 = var_4_10000.MsgboxMgr.GetInstance()

					var_0.ShowMsgBox(var_13_0, var_11_5)

					return
				end

				function var_12_1.onYes()
					local var_14_0 = arg_4_0
					local var_14_1 = var_0.emit

					SecondaryPasswordMediator = var_4_10003

					var_14_1(var_14_0, var_4_10003.SET_PASSWORD, var_11_4, var_12_0)

					return
				end

				var_11_7 = var_12_1
				pg = var_12_1

				local var_12_3 = var_12_1.MsgboxMgr.GetInstance()

				var_1.ShowMsgBox(var_12_3, var_11_7)

				return
			end

			function var_11_8.onNo()
				local var_15_0 = arg_4_0

				var_0.emit(var_15_0, var_0_1.ON_CLOSE)

				return
			end

			function var_11_8.onPreShow()
				local var_16_0 = arg_4_0

				var_0.Hide(var_16_0)

				return
			end

			var_11_5 = var_11_8
			pg = var_11_8

			local var_11_9 = var_11_8.MsgboxMgr.GetInstance()

			var_5.ShowMsgBox(var_11_9, var_11_5)
		end

		return
	end)

	onButton = var_1

	var_1(arg_4_0, arg_4_0.btnhide, function()
		arg_4_0.inputMode = not arg_4_0.inputMode

		local var_17_0 = arg_4_0

		var_0.UpdateInputSlider(var_17_0)

		setActive = var_0

		var_0(arg_4_0.btnhide, not arg_4_0.inputMode)

		setActive = var_0

		var_0(arg_4_0.btnshow, arg_4_0.inputMode)

		return
	end)

	onButton = var_1

	var_1(arg_4_0, arg_4_0.btnshow, function()
		arg_4_0.inputMode = not arg_4_0.inputMode

		local var_18_0 = arg_4_0

		var_0.UpdateInputSlider(var_18_0)

		setActive = var_0

		var_0(arg_4_0.btnhide, not arg_4_0.inputMode)

		setActive = var_0

		var_0(arg_4_0.btnshow, arg_4_0.inputMode)

		return
	end)

	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.btnclose

	local function var_4_2()
		if arg_4_0.mode == var_0_1.InputView then
			local var_19_0 = arg_4_0
			local var_19_1 = var_0.emit

			SecondaryPasswordMediator = var_2_10003

			var_19_1(var_19_0, var_2_10003.CANCEL_OPERATION)
		end

		local var_19_2 = arg_4_0

		var_0.emit(var_19_2, var_0_1.ON_CLOSE)

		return
	end

	SOUND_BACK = var_1_10006

	var_1(var_4_0, var_4_1, var_4_2, var_1_10006)

	onButton = var_1

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0._tf

	local function var_4_5()
		return
	end

	SOUND_BACK = var_1_10006

	var_1(var_4_3, var_4_4, var_4_5, var_1_10006)

	return
end

local var_0_2 = 69

function var_0_1.didEnter(arg_21_0)
	if arg_21_0.contextData.parent then
		setParent = var_1

		var_1(arg_21_0._tf, arg_21_0.contextData.parent)
	else
		pg = var_1

		local var_21_0 = var_1.UIMgr.GetInstance()

		var_1.BlurPanel(var_21_0, arg_21_0._tf, {
			staticBlur = true
		})
	end

	local var_21_1 = arg_21_0.contextData.mode

	setActive = var_1_10002

	var_1_10002(arg_21_0.setView, var_21_1 == var_0_1.SetView)

	setActive = var_1_10002

	var_1_10002(arg_21_0.inputView, var_21_1 == var_0_1.InputView)

	arg_21_0.mode = var_21_1
	arg_21_0.type = arg_21_0.contextData.type

	local var_21_2

	if var_21_1 ~= var_0_1.SetView or not arg_21_0.setDigitGroup then
		var_21_2 = arg_21_0.inputDigitGroup
	end

	arg_21_0.digitGroup = var_21_2

	local var_21_3 = arg_21_0.textTitle

	if var_21_1 == var_0_1.SetView then
		i18n = var_21_4

		local var_21_4

		if not var_21_4("words_set_password") then
			i18n = var_21_4
			var_21_4 = var_21_4("words_information")
		end

		var_21_3.text = var_21_4
		arg_21_0.textTitleEn.text = var_21_1 == var_0_1.SetView and "PASSWORD" or "INFORM"

		local var_21_5 = arg_21_0.informBg.sizeDelta

		var_21_5.x = arg_21_0.textTitle.preferredWidth + arg_21_0.textTitleEn.preferredWidth + var_0_2
		arg_21_0.informBg.sizeDelta = var_21_5
		arg_21_0.inputs = ""

		arg_21_0:SetInputPos(0)

		arg_21_0.inputnone = true

		arg_21_0:UpdateView()
		arg_21_0:UpdateInputSlider()

		return
	end
end

function var_0_1.UpdateInputSlider(arg_22_0)
	arg_22_0:ClearInputTimers()

	local var_22_0 = arg_22_0.inputMode

	arg_22_0:SetInputXian(arg_22_0.inputPos + 1)

	for iter_22_0 = 1, #arg_22_0.digitGroup do
		local var_22_1 = arg_22_0.digitGroup[iter_22_0]

		if iter_22_0 <= #arg_22_0.inputs then
			string = var_7

			local var_22_2 = var_7.char

			string = var_1_10009

			local var_22_3

			if not var_22_2(var_1_10009.byte(arg_22_0.inputs, iter_22_0)) then
				var_22_3 = nil
			end

			setText = var_1_10008

			var_1_10008(var_22_1:Find("text"), var_22_0 and var_22_3 or "")

			setActive = var_1_10008

			var_1_10008(var_22_1:Find("space"), not var_22_0 and var_22_3 == nil)

			setActive = var_1_10008

			var_1_10008(var_22_1:Find("filled"), not var_22_0 and var_22_3 ~= nil)
		end
	end

	return
end

function var_0_1.ClearInputTimers(arg_23_0)
	for iter_23_0 = 1, 12 do
		if arg_23_0.timers["input" .. iter_23_0] then
			local var_23_0 = arg_23_0.timers["input" .. iter_23_0]

			var_5.Stop(var_23_0)

			arg_23_0.timers["input" .. iter_23_0] = nil
		end
	end

	return
end

function var_0_1.ClearAllTimers(arg_24_0)
	pairs = var_1_10001

	for iter_24_0, iter_24_1 in var_1_10001(arg_24_0.timers) do
		if iter_24_1 then
			iter_24_1:Stop()
		end
	end

	arg_24_0.timers = {}

	return
end

function var_0_1.ClearInputs(arg_25_0)
	arg_25_0.inputs = ""

	arg_25_0:SetInputPos(0)
	arg_25_0:UpdateInputSlider()

	return
end

function var_0_1.UpdateView(arg_26_0)
	if arg_26_0.mode == var_0_1.InputView then
		arg_26_0:UpdateInputView()
	else
		arg_26_0:UpdateSetView()
	end

	return
end

local var_0_3

local function var_0_4(arg_27_0)
	pg = var_1_10001

	local var_27_0 = var_1_10001.SecondaryPWDMgr.GetInstance()
	local var_27_1

	if not var_0_3 then
		var_27_1 = {
			[var_27_0.UNLOCK_SHIP] = function(arg_28_0)
				local var_28_0 = arg_28_0.contextData.info[1]

				getProxy = var_2_10003
				BayProxy = var_2_10005

				local var_28_1 = var_2_10003(var_2_10005)
				local var_28_2 = var_3.getData(var_28_1)

				if var_3:getShipById(var_28_0) then
					string = var_28_1

					local var_28_3 = var_28_1.format

					i18n = var_8

					return var_28_3(var_8("words_desc_unlock"), var_5:getName())
				end

				return
			end,
			[var_27_0.UNLOCK_COMMANDER] = function(arg_29_0)
				local var_29_0 = arg_29_0.contextData.info

				getProxy = var_2_10002
				CommanderProxy = var_2_10004

				local var_29_1 = var_2_10002(var_2_10004)

				if var_2.getCommanderById(var_29_1, var_29_0) then
					string = var_2_10004

					local var_29_2 = var_2_10004.format

					i18n = var_6

					return var_29_2(var_6("words_desc_unlock"), var_3:getName())
				end

				return
			end,
			[var_27_0.RESOLVE_EQUIPMENT] = function(arg_30_0)
				local var_30_0 = arg_30_0.contextData.info

				getProxy = var_2_10002
				EquipmentProxy = var_2_10004

				local var_30_1 = var_2_10002(var_2_10004)

				if var_2.getEquipmentById(var_30_1, var_30_0) then
					local var_30_2 = var_3:getConfig("name")
					local var_30_3 = var_3
					local var_30_4

					if var_3.getConfig(var_30_3, "id") % 20 > 0 then
						var_30_4 = var_30_2

						local var_30_5 = "+"

						tostring = var_30_3
						var_30_2 = var_30_4 .. var_30_5 .. var_30_3(var_3:getConfig("id") % 20)
					end

					string = var_30_4

					local var_30_6 = var_30_4.format

					i18n = var_30_3

					return var_30_6(var_30_3("words_desc_resolve_equip"), var_30_2)
				end

				return
			end,
			[var_27_0.CREATE_INHERIT] = function()
				i18n = var_2_10000

				return var_2_10000("words_desc_create_inherit")
			end,
			[var_27_0.CLOSE_PASSWORD] = function()
				i18n = var_2_10000

				return var_2_10000("words_desc_close_password")
			end,
			[var_27_0.CHANGE_SETTING] = function()
				i18n = var_2_10000

				return var_2_10000("words_desc_change_settings")
			end
		}
	end

	var_0_3 = var_27_1

	return var_0_3[arg_27_0]
end

function var_0_1.UpdateInputView(arg_34_0)
	getProxy = var_1_10001
	SecondaryPWDProxy = var_1_10003

	local var_34_0 = var_1_10001(var_1_10003)
	local var_34_1 = var_1.getRawData(var_34_0)
	local var_34_2 = arg_34_0.inputView
	local var_34_3 = var_3.Find(var_34_2, "line1/tip")

	setText = var_34_0

	var_34_0(var_34_3, var_34_1.notice)

	setActive = var_34_0

	var_34_0(var_34_3, not arg_34_0.inputnone)

	local var_34_4 = arg_34_0.inputView
	local var_34_5 = var_4.Find(var_34_4, "line1/tip1")
	local var_34_6 = var_0_4(arg_34_0.contextData.type)

	setText = var_34_4

	local var_34_7 = var_34_5
	local var_34_8

	if not var_34_6 or not var_34_6(arg_34_0) then
		var_34_8 = ""
	end

	var_34_4(var_34_7, var_34_8)

	return
end

function var_0_1.UpdateConfirmButton(arg_35_0)
	local var_35_0 = arg_35_0.btnconfirm
	local var_35_1 = var_1.GetComponent

	typeof = var_1_10004
	Button = var_1_10006
	var_35_1(var_35_0, var_1_10004(var_1_10006)).interactable = #arg_35_0.inputs == #arg_35_0.digitGroup
	setActive = var_2

	local var_35_2 = arg_35_0.btnconfirm

	var_2(var_4.Find(var_35_2, "gray"), #arg_35_0.inputs ~= #arg_35_0.digitGroup)

	return
end

function var_0_1.UpdateSetView(arg_36_0)
	setActive = var_1_10001

	var_1_10001(arg_36_0.tipseterror, not arg_36_0.inputnone)

	return
end

function var_0_1.SetInputPos(arg_37_0, arg_37_1)
	arg_37_0.inputPos = arg_37_1
	arg_37_1 = arg_37_1 + 1

	arg_37_0:SetInputXian(arg_37_1)
	arg_37_0:UpdateConfirmButton()

	return
end

function var_0_1.Hide(arg_38_0)
	arg_38_0:willExit()

	setActive = var_1

	var_1(arg_38_0._tf, false)

	return
end

function var_0_1.Resume(arg_39_0)
	arg_39_0:didEnter()

	setActive = var_1

	var_1(arg_39_0._tf, true)

	return
end

function var_0_1.SetInputXian(arg_40_0, arg_40_1)
	if arg_40_0.inputMode and 0 < arg_40_1 and arg_40_1 <= #arg_40_0.digitGroup then
		setParent = var_2

		var_2(arg_40_0.selectFrame, arg_40_0.digitGroup[arg_40_1])
	else
		setParent = var_2

		var_2(arg_40_0.selectFrame, arg_40_0.resources)
	end

	return
end

function var_0_1.willExit(arg_41_0)
	pg = var_1_10001

	local var_41_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_41_0, arg_41_0._tf)
	arg_41_0:ClearAllTimers()

	return
end

return var_0_1
