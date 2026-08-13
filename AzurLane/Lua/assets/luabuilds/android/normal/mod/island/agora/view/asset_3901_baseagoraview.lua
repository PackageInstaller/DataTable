class = var_0_10000

local var_0_0 = "BaseAgoraView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.Core.View.IslandView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_3, arg_1_4)

	arg_1_0.agora = arg_1_2
	arg_1_0.agora_callbacks = {}

	return
end

function var_0_1.SetUp(arg_2_0)
	var_0_1.super.SetUp(arg_2_0)
	arg_2_0:AddAgoraListeners()

	return
end

function var_0_1.AddAgoraListeners(arg_3_0)
	return
end

function var_0_1.RemoveAgoraListeners(arg_4_0)
	return
end

function var_0_1.AddAgoraListener(arg_5_0, arg_5_1, arg_5_2)
	local function var_5_0(arg_6_0, ...)
		arg_5_2(arg_5_0, ...)

		return
	end

	assert = var_1_10004

	var_1_10004(arg_5_0.agora_callbacks[arg_5_2] == nil, "This method has been monitored. Please use another one" .. arg_5_1)

	arg_5_0.agora_callbacks[arg_5_2] = var_5_0

	local var_5_1 = arg_5_0.agora

	var_4.AddListener(var_5_1, arg_5_1, var_5_0)

	return
end

function var_0_1.RemoveAgoraListener(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.agora_callbacks[arg_7_2] then
		local var_7_0 = arg_7_0.agora

		var_4.RemoveListener(var_7_0, arg_7_1, var_3)

		arg_7_0.agora_callbacks[var_3] = nil
	end

	return
end

function var_0_1.OnDispose(arg_8_0)
	var_0_1.super.OnDispose(arg_8_0)
	arg_8_0:RemoveAgoraListeners()

	return
end

return var_0_1
