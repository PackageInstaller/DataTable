local var_0_0 = class("CourtYardInteraction")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.host = arg_1_1
	arg_1_0.isReset = false

	arg_1_0:Clear()

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.loop = arg_2_1

	arg_2_0:InitData()
	arg_2_0:DoPreheatStep(arg_2_0.ownerPreheat, arg_2_0.userPreheat)

	return
end

function var_0_0.InitData(arg_3_0)
	local var_3_0, var_3_1, var_3_2, var_3_3, var_3_4, var_3_5, var_3_6 = arg_3_0.host:GetActions()

	arg_3_0.ownerPreheat = var_3_3
	arg_3_0.userPreheat = var_3_4
	arg_3_0.tailAction = var_3_5
	arg_3_0.ownerActions = var_3_0
	arg_3_0.userActions = var_3_1
	arg_3_0.closeBodyMask = var_3_2
	arg_3_0.preheatOnlyHost = var_3_6
	arg_3_0.total = #var_3_0
	arg_3_0.index = 0

	return
end

function var_0_0.DoPreheatStep(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.preheatProcess = false

	if arg_4_1 then
		arg_4_0.preheatProcess = true

		arg_4_0.host:GetOwner():UpdateInteraction(arg_4_0:PackData(arg_4_1, true))

		if arg_4_2 then
			arg_4_0.host:GetUser():UpdateInteraction(arg_4_0:PackData(arg_4_2, true))
		end
	else
		arg_4_0:DoStep()
	end

	return
end

function var_0_0.DoStep(arg_5_0)
	if arg_5_0.index >= arg_5_0.total then
		arg_5_0:AllStepEnd()

		return
	end

	arg_5_0.index = arg_5_0.index + 1
	arg_5_0.states[arg_5_0.host.user] = false
	arg_5_0.states[arg_5_0.host.owner] = false

	arg_5_0.host:GetUser():UpdateInteraction(arg_5_0:PackData(arg_5_0:GetUserAction()))
	arg_5_0.host:GetOwner():UpdateInteraction(arg_5_0:PackData(arg_5_0:GetOwnerAction()))

	arg_5_0.isReset = false

	return
end

function var_0_0.GetUserAction(arg_6_0)
	return arg_6_0.userActions[arg_6_0.index]
end

function var_0_0.GetOwnerAction(arg_7_0)
	return arg_7_0.ownerActions[arg_7_0.index]
end

function var_0_0.DoTailStep(arg_8_0)
	arg_8_0.index = 0

	arg_8_0.host:GetUser():UpdateInteraction(arg_8_0:PackData(arg_8_0.tailAction))
	arg_8_0.host:GetOwner():UpdateInteraction(arg_8_0:PackData(arg_8_0.tailAction))

	return
end

function var_0_0.PackData(arg_9_0, arg_9_1, arg_9_2)
	return {
		action = arg_9_1,
		slot = arg_9_0.host,
		closeBodyMask = arg_9_0.closeBodyMask[arg_9_0.index],
		progress = arg_9_0.index / arg_9_0.total,
		total = arg_9_0.total,
		index = arg_9_0.index,
		isReset = arg_9_0.isReset,
		block = arg_9_2
	}
end

function var_0_0.StepEnd(arg_10_0, arg_10_1)
	if arg_10_0.preheatProcess then
		if arg_10_0.preheatOnlyHost then
			if arg_10_1 == arg_10_0.host.owner then
				(function()
					arg_10_0:OnPreheatDone()
					arg_10_0:DoStep()

					return
				end)()
			end
		else
			(function()
				arg_10_0:OnPreheatDone()
				arg_10_0:DoStep()

				return
			end)()
		end
	else
		if arg_10_0.index == 0 then
			return
		end

		arg_10_0.states[arg_10_1] = true

		arg_10_0:OnStepEnd()
	end

	return
end

function var_0_0.OnPreheatDone(arg_12_0)
	arg_12_0.host:GetOwner():OnPreheatActionEnd(arg_12_0.host)

	return
end

function var_0_0.AllStepEnd(arg_13_0)
	if arg_13_0.loop and arg_13_0.total > 1 then
		arg_13_0.isReset = true
		arg_13_0.index = 0

		arg_13_0:DoStep()
	elseif arg_13_0.loop and arg_13_0.total == 1 then
		-- block empty
	elseif not arg_13_0.loop and arg_13_0.tailAction then
		arg_13_0:DoTailStep()
	else
		arg_13_0.host:End()
		arg_13_0:Clear()
	end

	return
end

function var_0_0.Clear(arg_14_0)
	arg_14_0.index = 0
	arg_14_0.states = {}
	arg_14_0.total = 0
	arg_14_0.loop = nil

	return
end

function var_0_0.GetIndex(arg_15_0)
	return arg_15_0.index
end

function var_0_0.IsCompleteStep(arg_16_0)
	return arg_16_0:IsCompleteUserStep() and arg_16_0:IsCompleteOwnerStep()
end

function var_0_0.IsCompleteUserStep(arg_17_0)
	return arg_17_0.states[arg_17_0.host.user] == true
end

function var_0_0.IsCompleteOwnerStep(arg_18_0)
	return arg_18_0.states[arg_18_0.host.owner] == true
end

function var_0_0.OnStepEnd(arg_19_0)
	if arg_19_0:IsCompleteStep() then
		arg_19_0:DoStep()
	end

	return
end

function var_0_0.Reset(arg_20_0)
	return
end

return var_0_0
