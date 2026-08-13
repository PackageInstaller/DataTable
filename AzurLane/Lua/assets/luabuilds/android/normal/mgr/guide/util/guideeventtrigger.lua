class = var_0_10000

local var_0_0 = var_0_10000("GuideEventTrigger")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	pg = var_1_10006

	var_1_10006.DelegateInfo.New(arg_1_0)

	local var_1_0

	GuideFindUIStep = var_7

	if arg_1_1 == var_7.TRIGGER_TYPE_BUTTON then
		var_1_0 = arg_1_0:HandleBtnTrigger(arg_1_2, arg_1_3, arg_1_5)
	else
		GuideFindUIStep = var_7

		if arg_1_1 == var_7.TRIGGER_TYPE_TOGGLE then
			var_1_0 = arg_1_0:HandleToggleTrigger(arg_1_2, arg_1_3, arg_1_4, arg_1_5)
		else
			GuideFindUIStep = var_7

			if arg_1_1 == var_7.EVENT_TYPE_CLICK then
				var_1_0 = arg_1_0:HandleClickTrigger(arg_1_2, arg_1_3, arg_1_5)
			else
				GuideFindUIStep = var_7

				if arg_1_1 == var_7.EVENT_TYPE_STICK then
					var_1_0 = arg_1_0:HandleStickTrigger(arg_1_2, arg_1_3, arg_1_5)
				else
					GuideFindUIStep = var_7

					if arg_1_1 == var_7.SHOW_UI then
						var_1_0 = arg_1_0:HandleShowUITrigger(arg_1_2, arg_1_3, arg_1_5)
					else
						GuideFindUIStep = var_7

						if arg_1_1 == var_7.TRIGGER_TYPE_BUTTONEX then
							var_1_0 = arg_1_0:HandleBtnExTrigger(arg_1_2, arg_1_3, arg_1_4, arg_1_5)
						else
							GuideFindUIStep = var_7

							if arg_1_1 == var_7.SNAP_PAGE then
								var_1_0 = arg_1_0:HandleSnapPageTrigger(arg_1_2, arg_1_3, arg_1_4, arg_1_5)
							else
								GuideFindUIStep = var_7

								if arg_1_1 == var_7.EVENT_TYPE_EVT_CLICK then
									var_1_0 = arg_1_0:HandleEvtClickTrigger(arg_1_2, arg_1_3, arg_1_5)
								end
							end
						end
					end
				end
			end
		end
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

	addSlip = var_1_10007
	SLIP_TYPE_HRZ = var_1_10008

	var_1_10007(var_1_10008, arg_3_1, var_3_0, var_3_1)

	return function()
		arg_3_4()

		return
	end
end

function var_0_0.HandleBtnTrigger(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local function var_5_0()
		IsNil = var_2_10000

		if var_2_10000(arg_5_2) then
			return
		end

		triggerButton = var_0

		var_0(arg_5_2)
		arg_5_3()

		return
	end

	onButton = var_1_10005

	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_1
	local var_5_3 = var_5_0

	SFX_PANEL = var_1_10009

	var_1_10005(var_5_1, var_5_2, var_5_3, var_1_10009)

	return var_5_0
end

function var_0_0.HandleBtnExTrigger(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local function var_7_0()
		IsNil = var_2_10000

		if var_2_10000(arg_7_2) then
			return
		end

		arg_7_3()
		arg_7_4()

		return
	end

	onButton = var_1_10006

	local var_7_1 = arg_7_0
	local var_7_2 = arg_7_1
	local var_7_3 = var_7_0

	SFX_PANEL = var_1_10010

	var_1_10006(var_7_1, var_7_2, var_7_3, var_1_10010)

	return var_7_0
end

function var_0_0.HandleToggleTrigger(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local function var_9_0(arg_10_0)
		IsNil = var_2_10001

		if var_2_10001(arg_9_2) then
			return
		end

		arg_9_4()

		triggerToggle = var_1

		var_1(arg_9_2, arg_10_0)

		return
	end

	onToggle = var_1_10006

	local var_9_1 = arg_9_0
	local var_9_2 = arg_9_1
	local var_9_3 = var_9_0

	SFX_PANEL = var_1_10010

	var_1_10006(var_9_1, var_9_2, var_9_3, var_1_10010)

	return var_9_0
end

function var_0_0.HandleClickTrigger(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_2
	local var_11_1 = arg_11_2.GetComponent

	typeof = var_1_10006
	EventTriggerListener = var_1_10007

	local var_11_2 = var_11_1(var_11_0, var_1_10006(var_1_10007))

	local function var_11_3(arg_12_0, arg_12_1)
		arg_11_3()

		IsNil = var_2

		if not var_2(arg_11_2) then
			local var_12_0 = var_11_2

			var_2.OnPointerUp(var_12_0, arg_12_1)
		end

		return
	end

	local var_11_4 = arg_11_1
	local var_11_5 = arg_11_1.GetComponent

	typeof = var_1_10008
	EventTriggerListener = var_1_10009

	local var_11_6 = var_11_5(var_11_4, var_1_10008(var_1_10009))

	var_6.AddPointDownFunc(var_11_6, function(arg_13_0, arg_13_1)
		IsNil = var_2_10002

		if not var_2_10002(arg_11_2) then
			local var_13_0 = var_11_2

			var_2.OnPointerDown(var_13_0, arg_13_1)
		end

		return
	end)
	var_6:AddPointUpFunc(var_11_3)

	return var_11_3
end

function var_0_0.HandleEvtClickTrigger(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_2
	local var_14_1 = arg_14_2.GetComponent

	typeof = var_1_10006
	EventTriggerListener = var_1_10007

	local var_14_2 = var_14_1(var_14_0, var_1_10006(var_1_10007))

	local function var_14_3(arg_15_0, arg_15_1)
		arg_14_3()

		IsNil = var_2

		if not var_2(arg_14_2) then
			local var_15_0 = var_14_2

			var_2.OnPointerUp(var_15_0, arg_15_1)
		end

		return
	end

	local var_14_4 = arg_14_1
	local var_14_5 = arg_14_1.GetComponent

	typeof = var_1_10008
	EventTriggerListener = var_1_10009

	local var_14_6 = var_14_5(var_14_4, var_1_10008(var_1_10009))

	var_6.AddPointDownFunc(var_14_6, function(arg_16_0, arg_16_1)
		IsNil = var_2_10002

		if not var_2_10002(arg_14_2) then
			local var_16_0 = var_14_2

			var_2.OnPointerClick(var_16_0, arg_16_1)
		end

		return
	end)
	var_6:AddPointUpFunc(var_14_3)

	return var_14_3
end

function var_0_0.HandleStickTrigger(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local function var_17_0(arg_18_0, arg_18_1)
		IsNil = var_2_10002

		if var_2_10002(arg_17_2) then
			return
		end

		arg_17_3()

		return
	end

	GetOrAddComponent = var_1_10005

	local var_17_1 = arg_17_1

	typeof = var_1_10007
	EventTriggerListener = var_1_10008

	local var_17_2 = var_1_10005(var_17_1, var_1_10007(var_1_10008))

	var_5.AddPointDownFunc(var_17_2, var_17_0)

	return var_17_0
end

function var_0_0.HandleShowUITrigger(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local function var_19_0(arg_20_0, arg_20_1)
		IsNil = var_2_10002

		if var_2_10002(arg_19_2) then
			return
		end

		arg_19_3()

		return
	end

	GetOrAddComponent = var_1_10005

	local var_19_1 = arg_19_1

	typeof = var_1_10007
	EventTriggerListener = var_1_10008

	local var_19_2 = var_1_10005(var_19_1, var_1_10007(var_1_10008))

	var_5.AddPointUpFunc(var_19_2, var_19_0)

	return var_19_0
end

function var_0_0.Clear(arg_21_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_21_0)

	return
end

return var_0_0
