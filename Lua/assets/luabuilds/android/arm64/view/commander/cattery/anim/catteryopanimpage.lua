local var_0_0 = class("CatteryOpAnimPage", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "CatteryOPAnimUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.homeExpAnim = CatteryAddHomeExpAnim.New(arg_2_0._tf:Find("bg/single"))
	arg_2_0.homeAndCommanderAnim = CattertAddHomeExpAndCommanderExpAnim.New(arg_2_0._tf:Find("bg/both"))

	return
end

function var_0_0.OnInit(arg_3_0)
	return
end

function var_0_0.AddPlan(arg_4_0, arg_4_1)
	arg_4_0:RemoveTimer()
	arg_4_0:Show()

	local var_4_0, var_4_1, var_4_2, var_4_3 = arg_4_0:ParseData(arg_4_1)
	local var_4_4 = #var_4_0 > 0 and arg_4_0.homeAndCommanderAnim or arg_4_0.homeExpAnim

	if arg_4_0.player then
		arg_4_0.player:Clear()

		if arg_4_0.player ~= var_4_4 then
			arg_4_0.player:Hide()
		end
	end

	arg_4_0.doAnim = true

	var_4_4:Action(var_4_0, var_4_1, var_4_2, var_4_3, function()
		arg_4_0.doAnim = false

		if arg_4_0.exited then
			return
		end

		arg_4_0.timer = Timer.New(function()
			var_4_4:Hide()
			arg_4_0:Hide()

			return
		end, 0.5, 1)

		arg_4_0.timer:Start()

		return
	end)

	arg_4_0.player = var_4_4

	return
end

function var_0_0.ParseData(arg_7_0, arg_7_1)
	local var_7_0 = false
	local var_7_1 = false

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.awards) do
		if iter_7_1.id == Item.COMMANDER_QUICKLY_TOOL_ID then
			var_7_0 = true
		end

		if iter_7_1.id == PlayerConst.ResDormMoney then
			var_7_1 = true
		end
	end

	return arg_7_1.commanderExps, arg_7_1.homeExp, var_7_0, var_7_1
end

function var_0_0.RemoveTimer(arg_8_0)
	if arg_8_0.timer then
		arg_8_0.timer:Stop()

		arg_8_0.timer = nil
	end

	return
end

function var_0_0.OnDestroy(arg_9_0)
	arg_9_0:RemoveTimer()

	arg_9_0.doAnim = nil

	arg_9_0.homeExpAnim:Dispose()
	arg_9_0.homeAndCommanderAnim:Dispose()

	arg_9_0.exited = true

	return
end

return var_0_0
