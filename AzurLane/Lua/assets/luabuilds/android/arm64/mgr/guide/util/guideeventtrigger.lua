local var_0_0 = class("GuideEventTrigger")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	pg.DelegateInfo.New(arg_1_0)

	local var_1_0

	if arg_1_1 == GuideFindUIStep.TRIGGER_TYPE_BUTTON then
		var_1_0 = arg_1_0:HandleBtnTrigger(arg_1_2, arg_1_3, arg_1_5)
	elseif arg_1_1 == GuideFindUIStep.TRIGGER_TYPE_TOGGLE then
		var_1_0 = arg_1_0:HandleToggleTrigger(arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	elseif arg_1_1 == GuideFindUIStep.EVENT_TYPE_CLICK then
		var_1_0 = arg_1_0:HandleClickTrigger(arg_1_2, arg_1_3, arg_1_5)
	elseif arg_1_1 == GuideFindUIStep.EVENT_TYPE_STICK then
		var_1_0 = arg_1_0:HandleStickTrigger(arg_1_2, arg_1_3, arg_1_5)
	elseif arg_1_1 == GuideFindUIStep.SHOW_UI then
		var_1_0 = arg_1_0:HandleShowUITrigger(arg_1_2, arg_1_3, arg_1_5)
	elseif arg_1_1 == GuideFindUIStep.TRIGGER_TYPE_BUTTONEX then
		var_1_0 = arg_1_0:HandleBtnExTrigger(arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	elseif arg_1_1 == GuideFindUIStep.SNAP_PAGE then
		var_1_0 = arg_1_0:HandleSnapPageTrigger(arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	elseif arg_1_1 == GuideFindUIStep.EVENT_TYPE_EVT_CLICK then
		var_1_0 = arg_1_0:HandleEvtClickTrigger(arg_1_2, arg_1_3, arg_1_5)
	end

	arg_1_0.trigger = var_1_0

	return
end

function var_0_0.Trigger(arg_2_0)
	if arg_2_0.trigger then
		arg_2_0.trigger(true)
	end

	return
end

function var_0_0.HandleSnapPageTrigger(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = arg_3_4
	local var_3_1 = arg_3_4

	if arg_3_3 == -1 then
		var_3_0 = nil
	end

	if arg_3_3 == 1 then
		var_3_1 = nil
	end

	addSlip(SLIP_TYPE_HRZ, arg_3_1, var_3_0, var_3_1)

	return function()
		arg_3_4()

		return
	end
end

function var_0_0.HandleBtnTrigger(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	onButton(arg_5_0, arg_5_1, function()
		if IsNil(arg_5_2) then
			return
		end

		triggerButton(arg_5_2)
		arg_5_3()

		return
	end, SFX_PANEL)

	return function()
		if IsNil(arg_5_2) then
			return
		end

		triggerButton(arg_5_2)
		arg_5_3()

		return
	end
end

function var_0_0.HandleBtnExTrigger(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	onButton(arg_7_0, arg_7_1, function()
		if IsNil(arg_7_2) then
			return
		end

		arg_7_3()
		arg_7_4()

		return
	end, SFX_PANEL)

	return function()
		if IsNil(arg_7_2) then
			return
		end

		arg_7_3()
		arg_7_4()

		return
	end
end

function var_0_0.HandleToggleTrigger(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	onToggle(arg_9_0, arg_9_1, function(arg_10_0)
		if IsNil(arg_9_2) then
			return
		end

		arg_9_4()
		triggerToggle(arg_9_2, arg_10_0)

		return
	end, SFX_PANEL)

	return function(arg_10_0)
		if IsNil(arg_9_2) then
			return
		end

		arg_9_4()
		triggerToggle(arg_9_2, arg_10_0)

		return
	end
end

function var_0_0.HandleClickTrigger(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_2:GetComponent(typeof(EventTriggerListener))
	local var_11_1 = arg_11_1:GetComponent(typeof(EventTriggerListener))

	var_11_1:AddPointDownFunc(function(arg_13_0, arg_13_1)
		if not IsNil(arg_11_2) then
			var_11_0:OnPointerDown(arg_13_1)
		end

		return
	end)
	var_11_1:AddPointUpFunc(function(arg_12_0, arg_12_1)
		arg_11_3()

		if not IsNil(arg_11_2) then
			var_11_0:OnPointerUp(arg_12_1)
		end

		return
	end)

	return function(arg_12_0, arg_12_1)
		arg_11_3()

		if not IsNil(arg_11_2) then
			var_11_0:OnPointerUp(arg_12_1)
		end

		return
	end
end

function var_0_0.HandleEvtClickTrigger(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_2:GetComponent(typeof(EventTriggerListener))
	local var_14_1 = arg_14_1:GetComponent(typeof(EventTriggerListener))

	var_14_1:AddPointDownFunc(function(arg_16_0, arg_16_1)
		if not IsNil(arg_14_2) then
			var_14_0:OnPointerClick(arg_16_1)
		end

		return
	end)
	var_14_1:AddPointUpFunc(function(arg_15_0, arg_15_1)
		arg_14_3()

		if not IsNil(arg_14_2) then
			var_14_0:OnPointerUp(arg_15_1)
		end

		return
	end)

	return function(arg_15_0, arg_15_1)
		arg_14_3()

		if not IsNil(arg_14_2) then
			var_14_0:OnPointerUp(arg_15_1)
		end

		return
	end
end

function var_0_0.HandleStickTrigger(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	GetOrAddComponent(arg_17_1, typeof(EventTriggerListener)):AddPointDownFunc(function(arg_18_0, arg_18_1)
		if IsNil(arg_17_2) then
			return
		end

		arg_17_3()

		return
	end)

	return function(arg_18_0, arg_18_1)
		if IsNil(arg_17_2) then
			return
		end

		arg_17_3()

		return
	end
end

function var_0_0.HandleShowUITrigger(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	GetOrAddComponent(arg_19_1, typeof(EventTriggerListener)):AddPointUpFunc(function(arg_20_0, arg_20_1)
		if IsNil(arg_19_2) then
			return
		end

		arg_19_3()

		return
	end)

	return function(arg_20_0, arg_20_1)
		if IsNil(arg_19_2) then
			return
		end

		arg_19_3()

		return
	end
end

function var_0_0.Clear(arg_21_0)
	pg.DelegateInfo.Dispose(arg_21_0)

	return
end

return var_0_0
