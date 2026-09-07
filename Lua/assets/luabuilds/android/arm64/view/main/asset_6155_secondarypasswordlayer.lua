local SecondaryPasswordLayer = class("SecondaryPasswordLayer", import("..base.BaseUI"))

SecondaryPasswordLayer.SetView = 1
SecondaryPasswordLayer.InputView = 2

function SecondaryPasswordLayer:getUIName()
	return "SecondaryPasswordUI"
end

function SecondaryPasswordLayer:init()
	self.window = self._tf:Find("window")
	self.setView = self.window:Find("sliders/set")
	self.inputView = self.window:Find("sliders/input")
	self.frame = self._tf:Find("frame")
	self.informBg = self.window:Find("top/bg/information")
	self.textTitle = self.informBg:Find("title"):GetComponent(typeof(Text))
	self.textTitleEn = self.informBg:Find("title/title_en"):GetComponent(typeof(Text))
	self.inputpanel = self.window:Find("inputpanel")
	self.containerbtn = self.inputpanel:Find("btns")
	self.btngroup = CustomIndexLayer.Clone2Full(self.containerbtn, 10)

	_.each(self.btngroup, function(arg_3_0)
		local var_3_0 = (arg_3_0:GetSiblingIndex() + 1) % 10

		arg_3_0.name = tostring(var_3_0)

		setText(arg_3_0:Find("text"), tostring(var_3_0))
		setText(arg_3_0:Find("highlight/text2"), tostring(var_3_0))

		return
	end)

	self.btnconfirm = self.inputpanel:Find("confirmbtn")
	self.btndelete = self.inputpanel:Find("deletebtn")
	self.btnclose = self.window:Find("top/btnBack")
	self.resources = self._tf:Find("resources")
	self.selectFrame = self._tf:Find("resources/xian")
	self.setDigitGroup = {}
	self.setLine1Grid = self.setView:Find("line1/input/grid")
	self.setLine2Grid = self.setView:Find("line2/input/grid")

	CustomIndexLayer.Clone2Full(self.setLine1Grid, 6)
	CustomIndexLayer.Clone2Full(self.setLine2Grid, 6)

	for iter_2_0 = 0, self.setLine1Grid.childCount - 1 do
		table.insert(self.setDigitGroup, self.setLine1Grid:GetChild(iter_2_0))
	end

	for iter_2_1 = 0, self.setLine1Grid.childCount - 1 do
		table.insert(self.setDigitGroup, self.setLine2Grid:GetChild(iter_2_1))
	end

	self.btnhide = self.setView:Find("line1/hidebtn/hide")
	self.btnshow = self.setView:Find("line1/hidebtn/show")
	self.tipseterror = self.setView:Find("line2/tip")
	self.inputDigitGroup = {}
	self.inputLineGrid = self.inputView:Find("line1/input/grid")

	CustomIndexLayer.Clone2Full(self.inputLineGrid, 6)

	for iter_2_2 = 0, self.inputLineGrid.childCount - 1 do
		table.insert(self.inputDigitGroup, self.inputLineGrid:GetChild(iter_2_2))
	end

	self.inputMode = false
	self.timers = {}

	self:InitInteractable()

	return
end

function SecondaryPasswordLayer:InitInteractable()
	_.each(self.btngroup, function(arg_5_0)
		onButton(self, arg_5_0, function()
			local var_6_0 = (arg_5_0:GetSiblingIndex() + 1) % 10
			local var_6_1 = self.inputPos + 1

			if self.inputPos + 1 > 0 and var_6_1 <= #self.digitGroup then
				self.inputs = self.inputs .. tostring(var_6_0)

				local var_6_2 = self.digitGroup[var_6_1]:Find("text")

				setText(var_6_2, var_6_0)
				setActive(self.digitGroup[var_6_1]:Find("filled"), false)
				setActive(self.digitGroup[var_6_1]:Find("space"), false)

				local function var_6_3()
					setText(var_6_2, "")
					setActive(self.digitGroup[var_6_1]:Find("filled"), true)

					return
				end

				if not self.inputMode then
					if self.timers["input" .. var_6_1] then
						self.timers["input" .. var_6_1]:Reset(var_6_3, 1, 1)
					else
						self.timers["input" .. var_6_1] = Timer.New(var_6_3, 1, 1)
					end

					self.timers["input" .. var_6_1]:Start()
				end

				self:SetInputPos(var_6_1)
			end

			setActive(arg_5_0:Find("highlight"), true)

			local function var_6_4()
				setActive(arg_5_0:Find("highlight"), false)

				return
			end

			if self.timers["btn" .. var_6_0] then
				self.timers["btn" .. var_6_0]:Reset(var_6_4, 0.2, 1)
			else
				self.timers["btn" .. var_6_0] = Timer.New(var_6_4, 0.2, 1)
			end

			self.timers["btn" .. var_6_0]:Start()

			return
		end)

		return
	end)
	onButton(self, self.btndelete, function()
		if self.inputPos > 0 and self.inputPos <= #self.digitGroup then
			self.inputs = string.sub(self.inputs, 1, -2)

			setText(self.digitGroup[self.inputPos]:Find("text"), "")
			setActive(self.digitGroup[self.inputPos]:Find("filled"), false)
			setActive(self.digitGroup[self.inputPos]:Find("space"), not self.inputMode)

			if self.timers["input" .. self.inputPos] then
				self.timers["input" .. self.inputPos]:Stop()
			end

			self:SetInputPos(self.inputPos - 1)
		end

		setActive(self.btndelete:Find("highlight"), true)

		local function var_9_0()
			setActive(self.btndelete:Find("highlight"), false)

			return
		end

		if self.timers.btndel then
			self.timers.btndel:Reset(var_9_0, 0.3, 1)
		else
			self.timers.btndel = Timer.New(var_9_0, 0.3, 1)
		end

		self.timers.btndel:Start()

		return
	end)
	onButton(self, self.btnconfirm, function()
		if self.mode == SecondaryPasswordLayer.InputView then
			self.inputnone = false

			if #self.inputs ~= 6 then
				return
			end

			self:emit(SecondaryPasswordMediator.CONFIRM_PASSWORD, self.inputs)
		else
			self.inputnone = false

			local var_11_0 = #self.inputs == 12

			for iter_11_0 = 1, 6 do
				if string.byte(self.inputs, iter_11_0) ~= string.byte(self.inputs, 6 + iter_11_0) then
					var_11_0 = false

					break
				end
			end

			if not var_11_0 then
				self:UpdateView()

				return
			end

			local var_11_1 = string.sub(self.inputs, 1, 6)
			local var_11_2
			local var_11_3 = {}
			local var_11_4

			var_11_2 = {
				modal = true,
				mode = "settips",
				hideYes = true,
				title = "setting",
				type = MSGBOX_TYPE_SECONDPWD,
				references = var_11_3,
				onYes = function()
					local var_12_0 = var_11_3.inputfield.text

					var_11_3.lasttext = var_11_3.inputfield.text
					var_11_4 = {
						modal = true,
						content = string.format(i18n("secondarypassword_confirm_tips"), var_11_3.inputfield.text),
						onNo = function()
							pg.MsgboxMgr.GetInstance():ShowMsgBox(var_11_2)

							return
						end,
						onYes = function()
							self:emit(SecondaryPasswordMediator.SET_PASSWORD, var_11_1, var_12_0)

							return
						end
					}

					pg.MsgboxMgr.GetInstance():ShowMsgBox(var_11_4)

					return
				end,
				onNo = function()
					self:emit(SecondaryPasswordLayer.ON_CLOSE)

					return
				end,
				onPreShow = function()
					self:Hide()

					return
				end
			}

			pg.MsgboxMgr.GetInstance():ShowMsgBox(nil)
		end

		return
	end)
	onButton(self, self.btnhide, function()
		self.inputMode = not self.inputMode

		self:UpdateInputSlider()
		setActive(self.btnhide, not self.inputMode)
		setActive(self.btnshow, self.inputMode)

		return
	end)
	onButton(self, self.btnshow, function()
		self.inputMode = not self.inputMode

		self:UpdateInputSlider()
		setActive(self.btnhide, not self.inputMode)
		setActive(self.btnshow, self.inputMode)

		return
	end)
	onButton(self, self.btnclose, function()
		if self.mode == SecondaryPasswordLayer.InputView then
			self:emit(SecondaryPasswordMediator.CANCEL_OPERATION)
		end

		self:emit(SecondaryPasswordLayer.ON_CLOSE)

		return
	end, SOUND_BACK)
	onButton(self, self._tf, function()
		return
	end, SOUND_BACK)

	return
end

local var_0_1 = 69

function SecondaryPasswordLayer:didEnter()
	if self.contextData.parent then
		setParent(self._tf, self.contextData.parent)
	else
		pg.UIMgr.GetInstance():BlurPanel(self._tf, {
			staticBlur = true
		})
	end

	local var_21_0 = self.contextData.mode

	setActive(self.setView, self.contextData.mode == SecondaryPasswordLayer.SetView)
	setActive(self.inputView, var_21_0 == SecondaryPasswordLayer.InputView)

	self.mode = var_21_0
	self.type = self.contextData.type

	if var_21_0 == SecondaryPasswordLayer.SetView then
		self.digitGroup = self.setDigitGroup or self.inputDigitGroup
	end

	self.textTitle.text = var_21_0 == SecondaryPasswordLayer.SetView and i18n("words_set_password") or i18n("words_information")
	self.textTitleEn.text = var_21_0 == SecondaryPasswordLayer.SetView and "PASSWORD" or "INFORM"
	self.informBg.sizeDelta.x = self.textTitle.preferredWidth + self.textTitleEn.preferredWidth + var_0_1
	self.informBg.sizeDelta = self.informBg.sizeDelta
	self.inputs = ""

	self:SetInputPos(0)

	self.inputnone = true

	self:UpdateView()
	self:UpdateInputSlider()

	return
end

function SecondaryPasswordLayer:UpdateInputSlider()
	self:ClearInputTimers()

	local var_22_0 = self.inputMode

	self:SetInputXian(self.inputPos + 1)

	for iter_22_0 = 1, #self.digitGroup do
		local var_22_1 = self.digitGroup[iter_22_0]
		local var_22_2 = iter_22_0 <= #self.inputs and string.char(string.byte(self.inputs, iter_22_0)) or nil

		setText(self.digitGroup[iter_22_0]:Find("text"), var_22_0 and var_22_2 or "")
		setActive(var_22_1:Find("space"), not var_22_0 and var_22_2 == nil)
		setActive(var_22_1:Find("filled"), not var_22_0 and var_22_2 ~= nil)
	end

	return
end

function SecondaryPasswordLayer:ClearInputTimers()
	for iter_23_0 = 1, 12 do
		if self.timers["input" .. iter_23_0] then
			self.timers["input" .. iter_23_0]:Stop()

			self.timers["input" .. iter_23_0] = nil
		end
	end

	return
end

function SecondaryPasswordLayer:ClearAllTimers()
	for iter_24_0, iter_24_1 in pairs(self.timers) do
		if iter_24_1 then
			iter_24_1:Stop()
		end
	end

	self.timers = {}

	return
end

function SecondaryPasswordLayer:ClearInputs()
	self.inputs = ""

	self:SetInputPos(0)
	self:UpdateInputSlider()

	return
end

function SecondaryPasswordLayer:UpdateView()
	if self.mode == SecondaryPasswordLayer.InputView then
		self:UpdateInputView()
	else
		self:UpdateSetView()
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

function SecondaryPasswordLayer:UpdateInputView()
	local var_34_0 = self.inputView:Find("line1/tip")

	setText(var_34_0, getProxy(SecondaryPWDProxy):getRawData().notice)
	setActive(var_34_0, not self.inputnone)

	local var_34_1 = var_0_3(self.contextData.type)

	setText(self.inputView:Find("line1/tip1"), var_34_1 and var_34_1(self) or "")

	return
end

function SecondaryPasswordLayer:UpdateConfirmButton()
	self.btnconfirm:GetComponent(typeof(Button)).interactable = #self.inputs == #self.digitGroup

	setActive(self.btnconfirm:Find("gray"), #self.inputs ~= #self.digitGroup)

	return
end

function SecondaryPasswordLayer:UpdateSetView()
	setActive(self.tipseterror, not self.inputnone)

	return
end

function SecondaryPasswordLayer:SetInputPos(arg_37_1)
	self.inputPos = arg_37_1
	arg_37_1 = arg_37_1 + 1

	self:SetInputXian(arg_37_1)
	self:UpdateConfirmButton()

	return
end

function SecondaryPasswordLayer:Hide()
	self:willExit()
	setActive(self._tf, false)

	return
end

function SecondaryPasswordLayer:Resume()
	self:didEnter()
	setActive(self._tf, true)

	return
end

function SecondaryPasswordLayer:SetInputXian(arg_40_1)
	if self.inputMode and arg_40_1 > 0 and arg_40_1 <= #self.digitGroup then
		setParent(self.selectFrame, self.digitGroup[arg_40_1])
	else
		setParent(self.selectFrame, self.resources)
	end

	return
end

function SecondaryPasswordLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self:ClearAllTimers()

	return
end

return SecondaryPasswordLayer
