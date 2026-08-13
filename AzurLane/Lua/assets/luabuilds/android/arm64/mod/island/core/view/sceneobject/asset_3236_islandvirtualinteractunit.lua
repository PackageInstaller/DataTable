class = var_0_10000

local var_0_0 = "IslandVirtualInteractUnit"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandInteractUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	local function var_1_0()
		math = var_2_10000

		return var_2_10000.floor(arg_1_0.id / 10)
	end

	arg_1_0.attach = "AgoraMainStage/furniture/" .. var_1_0() .. "/" .. arg_1_2.config.attach

	return
end

function var_0_1.OnAttach(arg_3_0, arg_3_1)
	var_0_1.super.OnAttach(arg_3_0, arg_3_1)

	local var_3_0 = arg_3_0.signalReceiver

	var_2.SetCommonEvent(var_3_0, function(arg_4_0)
		if arg_3_0.ignoreSignal then
			return
		end

		switch = var_1

		var_1(arg_4_0.stringParameter, {
			TimelineEnd = function()
				local var_5_0 = arg_3_0

				var_0.Op(var_5_0, "AgoraVirtualInterActionEnd", arg_3_0.id, arg_3_0.view.player.id)

				return
			end
		})

		return
	end)

	return
end

function var_0_1.GetTargetRoot(arg_6_0)
	if arg_6_0.attachGo then
		return arg_6_0.attachGo.transform
	else
		GameObject = var_1
		arg_6_0.attachGo = var_1.Find(arg_6_0.attach)

		return arg_6_0.attachGo.transform
	end

	return
end

function var_0_1.GetPlayerParent(arg_7_0)
	if arg_7_0.tempPlayerParentPath == nil then
		return arg_7_0:GetTargetRoot()
	else
		local var_7_0 = arg_7_0:GetTargetRoot()
		local var_7_1 = var_1.Find(var_7_0, arg_7_0.tempPlayerParentPath)

		assert = var_1_10002

		var_1_10002(var_7_1, "can't find player parent with path: " .. arg_7_0.tempPlayerParentPath)

		return var_7_1
	end

	return
end

function var_0_1.StartInteract(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7, arg_8_8)
	arg_8_0.tempPlayerParentPath = arg_8_8

	var_0_1.super.StartInteract(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)

	return
end

return var_0_1
