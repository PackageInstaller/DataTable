class = var_0_10000

local var_0_0 = var_0_10000("CourtYardBridge")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.core = arg_1_1.core
	arg_1_0.isSetup = false
	arg_1_0.controller = arg_1_0:System2Controller(arg_1_1.system, arg_1_1)
	CourtYardView = var_2

	local var_1_0 = var_2.New
	local var_1_1 = arg_1_1.name
	local var_1_2 = arg_1_0.controller

	arg_1_0.view = var_1_0(var_1_1, var_5.GetStorey(var_1_2))

	if not arg_1_0.handle then
		UpdateBeat = var_2
		arg_1_0.handle = var_2:CreateListener(arg_1_0.Update, arg_1_0)
	end

	UpdateBeat = var_2

	var_2:AddListener(arg_1_0.handle)

	return
end

function var_0_0.SetUp(arg_2_0)
	if arg_2_0.controller then
		arg_2_0.isSetup = true

		local var_2_0 = arg_2_0.controller

		var_1.SetUp(var_2_0)
	end

	return
end

function var_0_0.Update(arg_3_0)
	if not arg_3_0.isSetup then
		local var_3_0 = arg_3_0.view

		if var_1.IsInit(var_3_0) then
			arg_3_0:SetUp()
		end
	end

	if arg_3_0.isSetup and arg_3_0.controller then
		local var_3_1 = arg_3_0.controller

		var_1.Update(var_3_1)
	end

	return
end

function var_0_0.IsLoaed(arg_4_0)
	if not arg_4_0.controller then
		return false
	end

	local var_4_0 = arg_4_0.controller

	return var_1.IsLoaed(var_4_0)
end

function var_0_0.GetView(arg_5_0)
	return arg_5_0.view
end

function var_0_0.GetController(arg_6_0)
	return arg_6_0.controller
end

function var_0_0.Exit(arg_7_0)
	if arg_7_0.controller then
		local var_7_0 = arg_7_0.controller

		var_1.Dispose(var_7_0)

		arg_7_0.controller = nil
	end

	if arg_7_0.view then
		local var_7_1 = arg_7_0.view

		var_1.Dispose(var_7_1)

		arg_7_0.view = nil
	end

	return
end

function var_0_0.SendNotification(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0.core then
		local var_8_0 = arg_8_0.core

		var_3.sendNotification(var_8_0, arg_8_1, arg_8_2)
	end

	return
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_9_0.handle)
	end

	arg_9_0:Exit()

	return
end

function var_0_0.System2Controller(arg_10_0, arg_10_1, arg_10_2)
	CourtYardConst = var_1_10003

	if arg_10_1 == var_1_10003.SYSTEM_FEAST then
		CourtYardFeastController = var_3

		return var_3.New(arg_10_0, arg_10_2)
	else
		CourtYardController = var_3

		return var_3.New(arg_10_0, arg_10_2)
	end

	return
end

return var_0_0
