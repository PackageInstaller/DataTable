local var_0_0 = import("game.reserve.ReserveContDataTemplate")
local var_0_1 = class("ReserveProposalContDataTemplate", var_0_0)

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.isTemp = false
	arg_1_0.name = ""
	arg_1_0.tags = {}
end

function var_0_1.SetName(arg_2_0, arg_2_1)
	arg_2_0.name = arg_2_1
end

function var_0_1.GetName(arg_3_0)
	return arg_3_0.name
end

function var_0_1.GetIsTemp(arg_4_0)
	return arg_4_0.isTemp
end

function var_0_1.SetIsTemp(arg_5_0, arg_5_1)
	arg_5_0.isTemp = arg_5_1
end

function var_0_1.GetAttributeTagList(arg_6_0)
	return arg_6_0.tags
end

function var_0_1.SetAttributeTagList(arg_7_0, arg_7_1)
	arg_7_0.tags = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		arg_7_0.tags[#arg_7_0.tags + 1] = iter_7_1
	end
end

function var_0_1.Reset(arg_8_0)
	var_0_1.super.Reset(arg_8_0)

	arg_8_0.isTemp = false
	arg_8_0.name = ""
end

return var_0_1
