class = var_0_10000

local var_0_0 = var_0_10000("CourtYardInteraction")

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
	local var_3_0 = arg_3_0.host
	local var_3_1, var_3_2, var_3_3, var_3_4, var_3_5, var_3_6, var_3_7 = var_1.GetActions(var_3_0)

	arg_3_0.ownerPreheat = var_3_4
	arg_3_0.userPreheat = var_3_5
	arg_3_0.tailAction = var_3_6
	arg_3_0.ownerActions = var_3_1
	arg_3_0.userActions = var_3_2
	arg_3_0.closeBodyMask = var_3_3
	arg_3_0.preheatOnlyHost = var_3_7
	arg_3_0.total = #var_3_1
	arg_3_0.index = 0

	return
end

function var_0_0.DoPreheatStep(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.preheatProcess = false

	if arg_4_1 then
		arg_4_0.preheatProcess = true

		local var_4_0 = arg_4_0.host
		local var_4_1 = var_3.GetOwner(var_4_0)

		var_3.UpdateInteraction(var_4_1, arg_4_0:PackData(arg_4_1, true))

		if arg_4_2 then
			local var_4_2 = arg_4_0.host
			local var_4_3 = var_3.GetUser(var_4_2)

			var_3.UpdateInteraction(var_4_3, arg_4_0:PackData(arg_4_2, true))
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

	local var_5_0 = arg_5_0.host
	local var_5_1 = var_1.GetUser(var_5_0)

	var_1.UpdateInteraction(var_5_1, arg_5_0:PackData(arg_5_0:GetUserAction()))

	local var_5_2 = arg_5_0.host
	local var_5_3 = var_1.GetOwner(var_5_2)

	var_1.UpdateInteraction(var_5_3, arg_5_0:PackData(arg_5_0:GetOwnerAction()))

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

	local var_8_0 = arg_8_0.host
	local var_8_1 = var_1.GetUser(var_8_0)

	var_1.UpdateInteraction(var_8_1, arg_8_0:PackData(arg_8_0.tailAction))

	local var_8_2 = arg_8_0.host
	local var_8_3 = var_1.GetOwner(var_8_2)

	var_1.UpdateInteraction(var_8_3, arg_8_0:PackData(arg_8_0.tailAction))

	return
end

function var_0_0.PackData(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.index / arg_9_0.total

	return {
		action = arg_9_1,
		slot = arg_9_0.host,
		closeBodyMask = arg_9_0.closeBodyMask[arg_9_0.index],
		progress = var_9_0,
		total = arg_9_0.total,
		index = arg_9_0.index,
		isReset = arg_9_0.isReset,
		block = arg_9_2
	}
end

function var_0_0.StepEnd(arg_10_0, arg_10_1)
	if arg_10_0.preheatProcess then
		local function var_10_0()
			local var_11_0 = arg_10_0

			var_0.OnPreheatDone(var_11_0)

			local var_11_1 = arg_10_0

			var_0.DoStep(var_11_1)

			return
		end

		if arg_10_0.preheatOnlyHost then
			if arg_10_1 == arg_10_0.host.owner then
				var_10_0()
			end
		else
			var_10_0()
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
	local var_12_0 = arg_12_0.host
	local var_12_1 = var_1.GetOwner(var_12_0)

	var_1.OnPreheatActionEnd(var_12_1, arg_12_0.host)

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
		local var_13_0 = arg_13_0.host

		var_1.End(var_13_0)
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
	local var_16_0

	if arg_16_0:IsCompleteUserStep() then
		var_16_0 = arg_16_0:IsCompleteOwnerStep()
	end

	return var_16_0
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
