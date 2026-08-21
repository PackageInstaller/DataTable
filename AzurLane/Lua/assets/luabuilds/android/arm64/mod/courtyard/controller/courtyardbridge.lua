local var_0_0 = class("CourtYardBridge")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.core = arg_1_1.core
	arg_1_0.isSetup = false
	arg_1_0.controller = arg_1_0:System2Controller(arg_1_1.system, arg_1_1)
	arg_1_0.view = CourtYardView.New(arg_1_1.name, arg_1_0.controller:GetStorey())
	arg_1_0.handle = arg_1_0.handle or UpdateBeat:CreateListener(arg_1_0.Update, arg_1_0)

	UpdateBeat:AddListener(arg_1_0.handle)

	return
end

function var_0_0.SetUp(arg_2_0)
	if arg_2_0.controller then
		arg_2_0.isSetup = true

		arg_2_0.controller:SetUp()
	end

	return
end

function var_0_0.Update(arg_3_0)
	if not arg_3_0.isSetup and arg_3_0.view:IsInit() then
		arg_3_0:SetUp()
	end

	if arg_3_0.isSetup and arg_3_0.controller then
		arg_3_0.controller:Update()
	end

	return
end

function var_0_0.IsLoaed(arg_4_0)
	if not arg_4_0.controller then
		return false
	end

	return arg_4_0.controller:IsLoaed()
end

function var_0_0.GetView(arg_5_0)
	return arg_5_0.view
end

function var_0_0.GetController(arg_6_0)
	return arg_6_0.controller
end

function var_0_0.Exit(arg_7_0)
	if arg_7_0.controller then
		arg_7_0.controller:Dispose()

		arg_7_0.controller = nil
	end

	if arg_7_0.view then
		arg_7_0.view:Dispose()

		arg_7_0.view = nil
	end

	return
end

function var_0_0.SendNotification(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0.core then
		arg_8_0.core:sendNotification(arg_8_1, arg_8_2)
	end

	return
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.handle then
		UpdateBeat:RemoveListener(arg_9_0.handle)
	end

	arg_9_0:Exit()

	return
end

function var_0_0.System2Controller(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == CourtYardConst.SYSTEM_FEAST then
		return CourtYardFeastController.New(arg_10_0, arg_10_2)
	else
		return CourtYardController.New(arg_10_0, arg_10_2)
	end

	return
end

return var_0_0
