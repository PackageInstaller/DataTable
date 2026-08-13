class = var_0_10000

local var_0_0 = "CourtYardMonglineInteraction"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardInteraction"))

function var_0_1.DoStep(arg_1_0)
	arg_1_0.statesCnt[arg_1_0.host.user] = 1
	arg_1_0.statesCnt[arg_1_0.host.owner] = 1
	arg_1_0.totalUserActionCnt = #arg_1_0.userActions
	arg_1_0.totalOwnerActionCnt = #arg_1_0.ownerActions

	var_0_1.super.DoStep(arg_1_0)

	return
end

function var_0_1.PlayUserAction(arg_2_0)
	if arg_2_0.statesCnt[arg_2_0.host.user] + 1 > arg_2_0.totalUserActionCnt then
		return
	end

	arg_2_0.statesCnt[arg_2_0.host.user] = var_1

	local var_2_0 = arg_2_0.states

	var_2_0[arg_2_0.host.user] = false
	print = var_2_0

	var_2_0("ship..............", var_1, arg_2_0.userActions[var_1])

	local var_2_1 = arg_2_0.host
	local var_2_2 = var_2.GetUser(var_2_1)

	var_2.UpdateInteraction(var_2_2, arg_2_0:PackData(arg_2_0.userActions[var_1]))

	return
end

function var_0_1.PlayOwnerAction(arg_3_0)
	if arg_3_0.statesCnt[arg_3_0.host.owner] + 1 > arg_3_0.totalOwnerActionCnt then
		return
	end

	arg_3_0.statesCnt[arg_3_0.host.owner] = var_1

	local var_3_0 = arg_3_0.states

	var_3_0[arg_3_0.host.owner] = false
	print = var_3_0

	var_3_0("furn", var_1, arg_3_0.ownerActions[var_1])

	local var_3_1 = arg_3_0.host
	local var_3_2 = var_2.GetOwner(var_3_1)

	var_2.UpdateInteraction(var_3_2, arg_3_0:PackData(arg_3_0.ownerActions[var_1]))

	return
end

function var_0_1.StepEnd(arg_4_0, arg_4_1)
	if arg_4_0.preheatProcess then
		arg_4_0:DoStep()

		arg_4_0.preheatProcess = false
	else
		if arg_4_0.index == 0 then
			return
		end

		arg_4_0.states[arg_4_1] = true

		local var_4_0 = arg_4_0.host

		if var_2.GetUser(var_4_0) == arg_4_1 then
			arg_4_0:PlayUserAction()
		else
			local var_4_1 = arg_4_0.host

			if var_2.GetOwner(var_4_1) == arg_4_1 then
				arg_4_0:PlayOwnerAction()
			end
		end

		if arg_4_0:IsFinishAll() then
			arg_4_0:AllStepEnd()
		end
	end

	return
end

function var_0_1.IsFinishAll(arg_5_0)
	return arg_5_0.statesCnt[arg_5_0.host.owner] >= arg_5_0.totalOwnerActionCnt and arg_5_0.statesCnt[arg_5_0.host.user] >= arg_5_0.totalUserActionCnt
end

function var_0_1.Clear(arg_6_0)
	var_0_1.super.Clear(arg_6_0)

	arg_6_0.statesCnt = {}

	return
end

return var_0_1
