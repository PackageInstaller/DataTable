local var_0_0 = class("SecondaryPasswordLayer", import("..base.BaseUI"))

var_0_0.SetView = 1
var_0_0.InputView = 2

function var_0_0.getUIName(arg_1_0)
	return "SecondaryPasswordUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.window = arg_2_0._tf:Find("window")
	arg_2_0.setView = arg_2_0.window:Find("sliders/set")
	arg_2_0.inputView = arg_2_0.window:Find("sliders/input")
	arg_2_0.frame = arg_2_0._tf:Find("frame")
	arg_2_0.informBg = arg_2_0.window:Find("top/bg/information")
	arg_2_0.textTitle = arg_2_0.informBg:Find("title"):GetComponent(typeof(Text))
	arg_2_0.textTitleEn = arg_2_0.informBg:Find("title/title_en"):GetComponent(typeof(Text))
	arg_2_0.inputpanel = arg_2_0.window:Find("inputpanel")
	arg_2_0.containerbtn = arg_2_0.inputpanel:Find("btns")
	arg_2_0.btngroup = CustomIndexLayer.Clone2Full(arg_2_0.containerbtn, 10)

	_.each(arg_2_0.btngroup, function(arg_3_0)
		local var_3_0 = (arg_3_0:GetSiblingIndex() + 1) % 10

		arg_3_0.name = tostring(var_3_0)

		setText(arg_3_0:Find("text"), tostring(var_3_0))
		setText(arg_3_0:Find("highlight/text2"), tostring(var_3_0))

		return
	end)

	arg_2_0.btnconfirm = arg_2_0.inputpanel:Find("confirmbtn")
	arg_2_0.btndelete = arg_2_0.inputpanel:Find("deletebtn")
	arg_2_0.btnclose = arg_2_0.window:Find("top/btnBack")
	arg_2_0.resources = arg_2_0._tf:Find("resources")
	arg_2_0.selectFrame = arg_2_0._tf:Find("resources/xian")
	arg_2_0.setDigitGroup = {}
	arg_2_0.setLine1Grid = arg_2_0.setView:Find("line1/input/grid")
	arg_2_0.setLine2Grid = arg_2_0.setView:Find("line2/input/grid")

	CustomIndexLayer.Clone2Full(arg_2_0.setLine1Grid, 6)
	CustomIndexLayer.Clone2Full(arg_2_0.setLine2Grid, 6)

	for iter_2_0 = 0, arg_2_0.setLine1Grid.childCount - 1 do
		table.insert(arg_2_0.setDigitGroup, arg_2_0.setLine1Grid:GetChild(iter_2_0))
	end

	for iter_2_1 = 0, arg_2_0.setLine1Grid.childCount - 1 do
		table.insert(arg_2_0.setDigitGroup, arg_2_0.setLine2Grid:GetChild(iter_2_1))
	end

	arg_2_0.btnhide = arg_2_0.setView:Find("line1/hidebtn/hide")
	arg_2_0.btnshow = arg_2_0.setView:Find("line1/hidebtn/show")
	arg_2_0.tipseterror = arg_2_0.setView:Find("line2/tip")
	arg_2_0.inputDigitGroup = {}
	arg_2_0.inputLineGrid = arg_2_0.inputView:Find("line1/input/grid")

	CustomIndexLayer.Clone2Full(arg_2_0.inputLineGrid, 6)

	for iter_2_2 = 0, arg_2_0.inputLineGrid.childCount - 1 do
		table.insert(arg_2_0.inputDigitGroup, arg_2_0.inputLineGrid:GetChild(iter_2_2))
	end

	arg_2_0.inputMode = false
	arg_2_0.timers = {}

	arg_2_0:InitInteractable()

	return
end

function var_0_0.InitInteractable(arg_4_0)
	_.each(arg_4_0.btngroup, function(arg_5_0)
		onButton(arg_4_0, arg_5_0, function()
			local var_6_0 = (arg_5_0:GetSiblingIndex() + 1) % 10
			local var_6_1 = arg_4_0.inputPos + 1

			if arg_4_0.inputPos + 1 > 0 and var_6_1 <= #arg_4_0.digitGroup then
				arg_4_0.inputs = arg_4_0.inputs .. tostring(var_6_0)

				setText(arg_4_0.digitGroup[var_6_1]:Find("text"), var_6_0)
				setActive(arg_4_0.digitGroup[var_6_1]:Find("filled"), false)
				setActive(arg_4_0.digitGroup[var_6_1]:Find("space"), false)

				if not arg_4_0.inputMode then
					if arg_4_0.timers["input" .. var_6_1] then
						arg_4_0.timers["input" .. var_6_1]:Reset(function()
							setText(var_0, "")
							setActive(arg_4_0.digitGroup[var_6_1]:Find("filled"), true)

							return
						end, 1, 1)
					else
						arg_4_0.timers["input" .. var_6_1] = Timer.New(function()
							setText(var_0, "")
							setActive(arg_4_0.digitGroup[var_6_1]:Find("filled"), true)

							return
						end, 1, 1)
					end

					arg_4_0.timers["input" .. var_6_1]:Start()
				end

				arg_4_0:SetInputPos(var_6_1)
			end

			setActive(arg_5_0:Find("highlight"), true)

			if arg_4_0.timers["btn" .. var_6_0] then
				arg_4_0.timers["btn" .. var_6_0]:Reset(function()
					setActive(arg_5_0:Find("highlight"), false)

					return
				end, 0.2, 1)
			else
				arg_4_0.timers["btn" .. var_6_0] = Timer.New(function()
					setActive(arg_5_0:Find("highlight"), false)

					return
				end, 0.2, 1)
			end

			arg_4_0.timers["btn" .. var_6_0]:Start()

			return
		end)

		return
	end)
	onButton(arg_4_0, arg_4_0.btndelete, function()
		if arg_4_0.inputPos > 0 and arg_4_0.inputPos <= #arg_4_0.digitGroup then
			arg_4_0.inputs = string.sub(arg_4_0.inputs, 1, -2)

			setText(arg_4_0.digitGroup[arg_4_0.inputPos]:Find("text"), "")
			setActive(arg_4_0.digitGroup[arg_4_0.inputPos]:Find("filled"), false)
			setActive(arg_4_0.digitGroup[arg_4_0.inputPos]:Find("space"), not arg_4_0.inputMode)

			if arg_4_0.timers["input" .. arg_4_0.inputPos] then
				arg_4_0.timers["input" .. arg_4_0.inputPos]:Stop()
			end

			arg_4_0:SetInputPos(arg_4_0.inputPos - 1)
		end

		setActive(arg_4_0.btndelete:Find("highlight"), true)

		if arg_4_0.timers.btndel then
			arg_4_0.timers.btndel:Reset(function()
				setActive(arg_4_0.btndelete:Find("highlight"), false)

				return
			end, 0.3, 1)
		else
			arg_4_0.timers.btndel = Timer.New(function()
				setActive(arg_4_0.btndelete:Find("highlight"), false)

				return
			end, 0.3, 1)
		end

		arg_4_0.timers.btndel:Start()

		return
	end)
	onButton(arg_4_0, arg_4_0.btnconfirm, function()
		if arg_4_0.mode == var_0_0.InputView then
			arg_4_0.inputnone = false

			if #arg_4_0.inputs ~= 6 then
				return
			end

			arg_4_0:emit(SecondaryPasswordMediator.CONFIRM_PASSWORD, arg_4_0.inputs)
		else
			arg_4_0.inputnone = false

			local var_11_0 = true

			if #arg_4_0.inputs ~= 12 then
				var_11_0 = false
			end

			for iter_11_0 = 1, 6 do
				if string.byte(arg_4_0.inputs, iter_11_0) ~= string.byte(arg_4_0.inputs, 6 + iter_11_0) then
					var_11_0 = false

					break
				end
			end

			if not var_11_0 then
				arg_4_0:UpdateView()

				return
			end

			local var_11_1 = string.sub(arg_4_0.inputs, 1, 6)
			local var_11_2
			local var_11_3

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				modal = true,
				mode = "settips",
				hideYes = true,
				title = "setting",
				type = MSGBOX_TYPE_SECONDPWD,
				references = {},
				onYes = function()
					local var_12_0 = var_0.inputfield.text

					var_0.lasttext = var_0.inputfield.text
					var_11_3 = {
						modal = true,
						content = string.format(i18n("secondarypassword_confirm_tips"), var_0.inputfield.text),
						onNo = function()
							pg.MsgboxMgr.GetInstance():ShowMsgBox(var_11_2)

							return
						end,
						onYes = function()
							arg_4_0:emit(SecondaryPasswordMediator.SET_PASSWORD, var_11_1, var_12_0)

							return
						end
					}

					pg.MsgboxMgr.GetInstance():ShowMsgBox(var_11_3)

					return
				end,
				onNo = function()
					arg_4_0:emit(var_0_0.ON_CLOSE)

					return
				end,
				onPreShow = function()
					arg_4_0:Hide()

					return
				end
			})
		end

		return
	end)
	onButton(arg_4_0, arg_4_0.btnhide, function()
		arg_4_0.inputMode = not arg_4_0.inputMode

		arg_4_0:UpdateInputSlider()
		setActive(arg_4_0.btnhide, not arg_4_0.inputMode)
		setActive(arg_4_0.btnshow, arg_4_0.inputMode)

		return
	end)
	onButton(arg_4_0, arg_4_0.btnshow, function()
		arg_4_0.inputMode = not arg_4_0.inputMode

		arg_4_0:UpdateInputSlider()
		setActive(arg_4_0.btnhide, not arg_4_0.inputMode)
		setActive(arg_4_0.btnshow, arg_4_0.inputMode)

		return
	end)
	onButton(arg_4_0, arg_4_0.btnclose, function()
		if arg_4_0.mode == var_0_0.InputView then
			arg_4_0:emit(SecondaryPasswordMediator.CANCEL_OPERATION)
		end

		arg_4_0:emit(var_0_0.ON_CLOSE)

		return
	end, SOUND_BACK)
	onButton(arg_4_0, arg_4_0._tf, function()
		return
	end, SOUND_BACK)

	return
end

local var_0_1 = 69

function var_0_0.didEnter(arg_21_0)
	if arg_21_0.contextData.parent then
		setParent(arg_21_0._tf, arg_21_0.contextData.parent)
	else
		pg.UIMgr.GetInstance():BlurPanel(arg_21_0._tf, {
			staticBlur = true
		})
	end

	local var_21_0 = arg_21_0.contextData.mode

	setActive(arg_21_0.setView, arg_21_0.contextData.mode == var_0_0.SetView)
	setActive(arg_21_0.inputView, var_21_0 == var_0_0.InputView)

	arg_21_0.mode = var_21_0
	arg_21_0.type = arg_21_0.contextData.type

	if var_21_0 == var_0_0.SetView then
		arg_21_0.digitGroup = arg_21_0.setDigitGroup or arg_21_0.inputDigitGroup

		local var_21_1 = arg_21_0.textTitle

		var_21_1.text = var_21_0 == var_0_0.SetView and i18n("words_set_password") or i18n("words_information")
		arg_21_0.textTitleEn.text = var_21_0 == var_0_0.SetView and "PASSWORD" or "INFORM"
		arg_21_0.informBg.sizeDelta.x = arg_21_0.textTitle.preferredWidth + arg_21_0.textTitleEn.preferredWidth + var_0_1
		arg_21_0.informBg.sizeDelta = arg_21_0.informBg.sizeDelta
		arg_21_0.inputs = ""

		arg_21_0:SetInputPos(0)

		arg_21_0.inputnone = true

		arg_21_0:UpdateView()
		arg_21_0:UpdateInputSlider()

		return
	end
end

function var_0_0.UpdateInputSlider(arg_22_0)
	arg_22_0:ClearInputTimers()

	local var_22_0 = arg_22_0.inputMode

	arg_22_0:SetInputXian(arg_22_0.inputPos + 1)

	for iter_22_0 = 1, #arg_22_0.digitGroup do
		local var_22_2 = iter_22_0 <= #arg_22_0.inputs and string.char(string.byte(arg_22_0.inputs, iter_22_0)) or nil

		setText(arg_22_0.digitGroup[iter_22_0]:Find("text"), var_22_0 and var_22_2 or "")
		setActive(var_22_1:Find("space"), not var_22_0 and var_22_2 == nil)
		setActive(var_22_1:Find("filled"), not var_22_0 and var_22_2 ~= nil)
	end

	return
end

function var_0_0.ClearInputTimers(arg_23_0)
	for iter_23_0 = 1, 12 do
		if arg_23_0.timers["input" .. iter_23_0] then
			arg_23_0.timers["input" .. iter_23_0]:Stop()

			arg_23_0.timers["input" .. iter_23_0] = nil
		end
	end

	return
end

function var_0_0.ClearAllTimers(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.timers) do
		if iter_24_1 then
			iter_24_1:Stop()
		end
	end

	arg_24_0.timers = {}

	return
end

function var_0_0.ClearInputs(arg_25_0)
	arg_25_0.inputs = ""

	arg_25_0:SetInputPos(0)
	arg_25_0:UpdateInputSlider()

	return
end

function var_0_0.UpdateView(arg_26_0)
	if arg_26_0.mode == var_0_0.InputView then
		arg_26_0:UpdateInputView()
	else
		arg_26_0:UpdateSetView()
	end

	return
end

local var_0_2

local function var_0_3(arg_27_0)
	local var_27_0 = pg.SecondaryPWDMgr.GetInstance()

	var_0_2 = var_0_2 or {
		[var_27_0.UNLOCK_SHIP] = function(arg_28_0)
			local var_28_0 = getProxy(BayProxy)
			local var_28_1 = var_28_0:getData()
			local var_28_2 = var_28_0:getShipById(arg_28_0.contextData.info[1])

			if var_28_2 then
				return string.format(i18n("words_desc_unlock"), var_28_2:getName())
			end

			return
		end,
		[var_27_0.UNLOCK_COMMANDER] = function(arg_29_0)
			local var_29_0 = getProxy(CommanderProxy):getCommanderById(arg_29_0.contextData.info)

			if var_29_0 then
				return string.format(i18n("words_desc_unlock"), var_29_0:getName())
			end

			return
		end,
		[var_27_0.RESOLVE_EQUIPMENT] = function(arg_30_0)
			local var_30_0 = getProxy(EquipmentProxy):getEquipmentById(arg_30_0.contextData.info)

			if var_30_0 then
				local var_30_1 = var_30_0:getConfig("name")

				if var_30_0:getConfig("id") % 20 > 0 then
					var_30_1 = var_30_1 .. "+" .. tostring(var_30_0:getConfig("id") % 20)
				end

				return string.format(i18n("words_desc_resolve_equip"), var_30_1)
			end

			return
		end,
		[var_27_0.CREATE_INHERIT] = function()
			return i18n("words_desc_create_inherit")
		end,
		[var_27_0.CLOSE_PASSWORD] = function()
			return i18n("words_desc_close_password")
		end,
		[var_27_0.CHANGE_SETTING] = function()
			return i18n("words_desc_change_settings")
		end
	}

	return var_0_2[arg_27_0]
end

function var_0_0.UpdateInputView(arg_34_0)
	local var_34_0 = arg_34_0.inputView:Find("line1/tip")

	setText(var_34_0, getProxy(SecondaryPWDProxy):getRawData().notice)
	setActive(var_34_0, not arg_34_0.inputnone)

	local var_34_1 = var_0_3(arg_34_0.contextData.type)
	local var_34_2 = var_34_1 and var_34_1(arg_34_0) or ""

	setText(arg_34_0.inputView:Find("line1/tip1"), var_34_2)

	return
end

function var_0_0.UpdateConfirmButton(arg_35_0)
	arg_35_0.btnconfirm:GetComponent(typeof(Button)).interactable = #arg_35_0.inputs == #arg_35_0.digitGroup

	setActive(arg_35_0.btnconfirm:Find("gray"), #arg_35_0.inputs ~= #arg_35_0.digitGroup)

	return
end

function var_0_0.UpdateSetView(arg_36_0)
	setActive(arg_36_0.tipseterror, not arg_36_0.inputnone)

	return
end

function var_0_0.SetInputPos(arg_37_0, arg_37_1)
	arg_37_0.inputPos = arg_37_1
	arg_37_1 = arg_37_1 + 1

	arg_37_0:SetInputXian(arg_37_1)
	arg_37_0:UpdateConfirmButton()

	return
end

function var_0_0.Hide(arg_38_0)
	arg_38_0:willExit()
	setActive(arg_38_0._tf, false)

	return
end

function var_0_0.Resume(arg_39_0)
	arg_39_0:didEnter()
	setActive(arg_39_0._tf, true)

	return
end

function var_0_0.SetInputXian(arg_40_0, arg_40_1)
	if arg_40_0.inputMode and arg_40_1 > 0 and arg_40_1 <= #arg_40_0.digitGroup then
		setParent(arg_40_0.selectFrame, arg_40_0.digitGroup[arg_40_1])
	else
		setParent(arg_40_0.selectFrame, arg_40_0.resources)
	end

	return
end

function var_0_0.willExit(arg_41_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_41_0._tf)
	arg_41_0:ClearAllTimers()

	return
end

return var_0_0
