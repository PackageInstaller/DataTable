class = var_0_10000

local var_0_0 = "CatteryOpAnimPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CatteryOPAnimUI"
end

function var_0_1.OnLoaded(arg_2_0)
	CatteryAddHomeExpAnim = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf

	arg_2_0.homeExpAnim = var_2_0(var_2.Find(var_2_1, "bg/single"))
	CattertAddHomeExpAndCommanderExpAnim = var_1

	local var_2_2 = var_1.New
	local var_2_3 = arg_2_0._tf

	arg_2_0.homeAndCommanderAnim = var_2_2(var_2.Find(var_2_3, "bg/both"))

	return
end

function var_0_1.OnInit(arg_3_0)
	return
end

function var_0_1.AddPlan(arg_4_0, arg_4_1)
	arg_4_0:RemoveTimer()
	arg_4_0:Show()

	local var_4_0, var_4_1, var_4_2, var_4_3 = arg_4_0:ParseData(arg_4_1)
	local var_4_4

	if #var_4_0 > 0 then
		var_4_4 = arg_4_0.homeAndCommanderAnim
	else
		var_4_4 = arg_4_0.homeExpAnim
	end

	if arg_4_0.player then
		local var_4_5 = arg_4_0.player

		var_7.Clear(var_4_5)

		if arg_4_0.player ~= var_4_4 then
			local var_4_6 = arg_4_0.player

			var_7.Hide(var_4_6)
		end
	end

	arg_4_0.doAnim = true

	var_4_4:Action(var_4_0, var_4_1, var_4_2, var_4_3, function()
		arg_4_0.doAnim = false

		if arg_4_0.exited then
			return
		end

		local var_5_0 = arg_4_0

		Timer = var_1
		var_5_0.timer = var_1.New(function()
			local var_6_0 = var_4_4

			var_0.Hide(var_6_0)

			local var_6_1 = arg_4_0

			var_0.Hide(var_6_1)

			return
		end, 0.5, 1)

		local var_5_1 = arg_4_0.timer

		var_0.Start(var_5_1)

		return
	end)

	arg_4_0.player = var_4_4

	return
end

function var_0_1.ParseData(arg_7_0, arg_7_1)
	local var_7_0 = false
	local var_7_1 = false

	ipairs = var_1_10004

	for iter_7_0, iter_7_1 in var_1_10004(arg_7_1.awards) do
		local var_7_2 = iter_7_1.id

		Item = var_1_10010

		if var_7_2 == var_1_10010.COMMANDER_QUICKLY_TOOL_ID then
			var_7_0 = true
		end

		local var_7_3 = iter_7_1.id

		PlayerConst = var_1_10010

		if var_7_3 == var_1_10010.ResDormMoney then
			var_7_1 = true
		end
	end

	return arg_7_1.commanderExps, arg_7_1.homeExp, var_7_0, var_7_1
end

function var_0_1.RemoveTimer(arg_8_0)
	if arg_8_0.timer then
		local var_8_0 = arg_8_0.timer

		var_1.Stop(var_8_0)

		arg_8_0.timer = nil
	end

	return
end

function var_0_1.OnDestroy(arg_9_0)
	arg_9_0:RemoveTimer()

	arg_9_0.doAnim = nil

	local var_9_0 = arg_9_0.homeExpAnim

	var_1.Dispose(var_9_0)

	local var_9_1 = arg_9_0.homeAndCommanderAnim

	var_1.Dispose(var_9_1)

	arg_9_0.exited = true

	return
end

return var_0_1
