local var_0_0 = class("CourtYardMonglineInteraction", import(".CourtYardInteraction"))

function var_0_0.DoStep(arg_1_0)
	arg_1_0.statesCnt[arg_1_0.host.user] = 1
	arg_1_0.statesCnt[arg_1_0.host.owner] = 1
	arg_1_0.totalUserActionCnt = #arg_1_0.userActions
	arg_1_0.totalOwnerActionCnt = #arg_1_0.ownerActions

	var_0_0.super.DoStep(arg_1_0)

	return
end

function var_0_0.PlayUserAction(arg_2_0)
	if arg_2_0.statesCnt[arg_2_0.host.user] + 1 > arg_2_0.totalUserActionCnt then
		return
	end

	arg_2_0.statesCnt[arg_2_0.host.user] = arg_2_0.statesCnt[arg_2_0.host.user] + 1
	arg_2_0.states[arg_2_0.host.user] = false

	print("ship..............", arg_2_0.statesCnt[arg_2_0.host.user] + 1, arg_2_0.userActions[arg_2_0.statesCnt[arg_2_0.host.user] + 1])
	arg_2_0.host:GetUser():UpdateInteraction(arg_2_0:PackData(arg_2_0.userActions[arg_2_0.statesCnt[arg_2_0.host.user] + 1]))

	return
end

function var_0_0.PlayOwnerAction(arg_3_0)
	if arg_3_0.statesCnt[arg_3_0.host.owner] + 1 > arg_3_0.totalOwnerActionCnt then
		return
	end

	arg_3_0.statesCnt[arg_3_0.host.owner] = arg_3_0.statesCnt[arg_3_0.host.owner] + 1
	arg_3_0.states[arg_3_0.host.owner] = false

	print("furn", arg_3_0.statesCnt[arg_3_0.host.owner] + 1, arg_3_0.ownerActions[arg_3_0.statesCnt[arg_3_0.host.owner] + 1])
	arg_3_0.host:GetOwner():UpdateInteraction(arg_3_0:PackData(arg_3_0.ownerActions[arg_3_0.statesCnt[arg_3_0.host.owner] + 1]))

	return
end

function var_0_0.StepEnd(arg_4_0, arg_4_1)
	if arg_4_0.preheatProcess then
		arg_4_0:DoStep()

		arg_4_0.preheatProcess = false
	else
		if arg_4_0.index == 0 then
			return
		end

		arg_4_0.states[arg_4_1] = true

		if arg_4_0.host:GetUser() == arg_4_1 then
			arg_4_0:PlayUserAction()
		elseif arg_4_0.host:GetOwner() == arg_4_1 then
			arg_4_0:PlayOwnerAction()
		end

		if arg_4_0:IsFinishAll() then
			arg_4_0:AllStepEnd()
		end
	end

	return
end

function var_0_0.IsFinishAll(arg_5_0)
	return arg_5_0.statesCnt[arg_5_0.host.owner] >= arg_5_0.totalOwnerActionCnt and arg_5_0.statesCnt[arg_5_0.host.user] >= arg_5_0.totalUserActionCnt
end

function var_0_0.Clear(arg_6_0)
	var_0_0.super.Clear(arg_6_0)

	arg_6_0.statesCnt = {}

	return
end

return var_0_0
