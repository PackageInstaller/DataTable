local GuideEventTrigger = class("GuideEventTrigger")

function GuideEventTrigger:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	pg.DelegateInfo.New(self)

	local var_1_0

	if arg_1_1 == GuideFindUIStep.TRIGGER_TYPE_BUTTON then
		var_1_0 = self:HandleBtnTrigger(arg_1_2, arg_1_3, arg_1_5)
	elseif arg_1_1 == GuideFindUIStep.TRIGGER_TYPE_TOGGLE then
		var_1_0 = self:HandleToggleTrigger(arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	elseif arg_1_1 == GuideFindUIStep.EVENT_TYPE_CLICK then
		var_1_0 = self:HandleClickTrigger(arg_1_2, arg_1_3, arg_1_5)
	elseif arg_1_1 == GuideFindUIStep.EVENT_TYPE_STICK then
		var_1_0 = self:HandleStickTrigger(arg_1_2, arg_1_3, arg_1_5)
	elseif arg_1_1 == GuideFindUIStep.SHOW_UI then
		var_1_0 = self:HandleShowUITrigger(arg_1_2, arg_1_3, arg_1_5)
	elseif arg_1_1 == GuideFindUIStep.TRIGGER_TYPE_BUTTONEX then
		var_1_0 = self:HandleBtnExTrigger(arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	elseif arg_1_1 == GuideFindUIStep.SNAP_PAGE then
		var_1_0 = self:HandleSnapPageTrigger(arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	elseif arg_1_1 == GuideFindUIStep.EVENT_TYPE_EVT_CLICK then
		var_1_0 = self:HandleEvtClickTrigger(arg_1_2, arg_1_3, arg_1_5)
	end

	self.trigger = var_1_0

	return
end

function GuideEventTrigger:Trigger()
	if self.trigger then
		self.trigger(true)
	end

	return
end

function GuideEventTrigger:HandleSnapPageTrigger(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	addSlip(SLIP_TYPE_HRZ, arg_3_1, (arg_3_3 == -1 or nil) and nil, (arg_3_3 == 1 or nil) and nil)

	return function()
		arg_3_4()

		return
	end
end

function GuideEventTrigger:HandleBtnTrigger(arg_5_1, arg_5_2, arg_5_3)
	local function var_5_0()
		if IsNil(arg_5_2) then
			return
		end

		triggerButton(arg_5_2)
		arg_5_3()

		return
	end

	onButton(self, arg_5_1, var_5_0, SFX_PANEL)

	return var_5_0
end

function GuideEventTrigger:HandleBtnExTrigger(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local function var_7_0()
		if IsNil(arg_7_2) then
			return
		end

		arg_7_3()
		arg_7_4()

		return
	end

	onButton(self, arg_7_1, var_7_0, SFX_PANEL)

	return var_7_0
end

function GuideEventTrigger:HandleToggleTrigger(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local function var_9_0(arg_10_0)
		if IsNil(arg_9_2) then
			return
		end

		arg_9_4()
		triggerToggle(arg_9_2, arg_10_0)

		return
	end

	onToggle(self, arg_9_1, var_9_0, SFX_PANEL)

	return var_9_0
end

function GuideEventTrigger:HandleClickTrigger(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_2:GetComponent(typeof(EventTriggerListener))

	local function var_11_1(arg_12_0, arg_12_1)
		arg_11_3()

		if not IsNil(arg_11_2) then
			var_11_0:OnPointerUp(arg_12_1)
		end

		return
	end

	local var_11_2 = arg_11_1:GetComponent(typeof(EventTriggerListener))

	var_11_2:AddPointDownFunc(function(arg_13_0, arg_13_1)
		if not IsNil(arg_11_2) then
			var_11_0:OnPointerDown(arg_13_1)
		end

		return
	end)
	var_11_2:AddPointUpFunc(var_11_1)

	return var_11_1
end

function GuideEventTrigger:HandleEvtClickTrigger(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_2:GetComponent(typeof(EventTriggerListener))

	local function var_14_1(arg_15_0, arg_15_1)
		arg_14_3()

		if not IsNil(arg_14_2) then
			var_14_0:OnPointerUp(arg_15_1)
		end

		return
	end

	local var_14_2 = arg_14_1:GetComponent(typeof(EventTriggerListener))

	var_14_2:AddPointDownFunc(function(arg_16_0, arg_16_1)
		if not IsNil(arg_14_2) then
			var_14_0:OnPointerClick(arg_16_1)
		end

		return
	end)
	var_14_2:AddPointUpFunc(var_14_1)

	return var_14_1
end

function GuideEventTrigger:HandleStickTrigger(arg_17_1, arg_17_2, arg_17_3)
	local function var_17_0(arg_18_0, arg_18_1)
		if IsNil(arg_17_2) then
			return
		end

		arg_17_3()

		return
	end

	GetOrAddComponent(arg_17_1, typeof(EventTriggerListener)):AddPointDownFunc(var_17_0)

	return var_17_0
end

function GuideEventTrigger:HandleShowUITrigger(arg_19_1, arg_19_2, arg_19_3)
	local function var_19_0(arg_20_0, arg_20_1)
		if IsNil(arg_19_2) then
			return
		end

		arg_19_3()

		return
	end

	GetOrAddComponent(arg_19_1, typeof(EventTriggerListener)):AddPointUpFunc(var_19_0)

	return var_19_0
end

function GuideEventTrigger:Clear()
	pg.DelegateInfo.Dispose(self)

	return
end

return GuideEventTrigger
