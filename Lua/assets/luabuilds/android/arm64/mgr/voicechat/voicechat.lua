local var_0_0 = class("VoiceChat")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.bgName = arg_1_1.bgName
	arg_1_0.shipGroup = arg_1_1.shipGroup
	arg_1_0.stopBgm = arg_1_1.stopBgm or false
	arg_1_0.label = arg_1_1.label
	arg_1_0.steps = {}

	local var_1_0 = arg_1_1.scripts or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		table.insert(arg_1_0.steps, (VoiceChatStep.New(iter_1_1, arg_1_0.shipGroup)))
	end

	arg_1_0.branchCode = nil
	arg_1_0.skipAll = false

	return
end

function var_0_0.GetBgName(arg_2_0)
	return arg_2_0.bgName
end

function var_0_0.GetShipName(arg_3_0)
	local var_3_0 = ShipGroup.getDefaultShipConfig(arg_3_0.shipGroup)

	assert(var_3_0, "shipGroup not found:" .. arg_3_0.shipGroup)

	return var_3_0.name
end

function var_0_0.MarkSkip(arg_4_0)
	arg_4_0.skipAll = true

	return
end

function var_0_0.IsSkipAll(arg_5_0)
	return arg_5_0.skipAll == true
end

function var_0_0.SetBranchCode(arg_6_0, arg_6_1)
	arg_6_0.branchCode = arg_6_1

	return
end

function var_0_0.GetStepByIndex(arg_7_0, arg_7_1)
	if arg_7_0:IsSkipAll() then
		return nil
	end

	local var_7_0 = arg_7_0.steps[arg_7_1]

	if not arg_7_0.steps[arg_7_1] or arg_7_0.branchCode and not var_7_0:IsSameBranch(arg_7_0.branchCode) then
		return nil
	end

	return var_7_0
end

function var_0_0.HasBg(arg_8_0)
	return arg_8_0.bgName ~= nil and arg_8_0.bgName ~= ""
end

function var_0_0.ShouldStopBgm(arg_9_0)
	return arg_9_0.stopBgm
end

function var_0_0.GetLabel(arg_10_0)
	return arg_10_0.label
end

return var_0_0
