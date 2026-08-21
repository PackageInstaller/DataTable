local var_0_0 = class("IslandVirtualInteractUnit", import(".IslandInteractUnit"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.attach = "AgoraMainStage/furniture/" .. (function()
		return math.floor(arg_1_0.id / 10)
	end)() .. "/" .. arg_1_2.config.attach

	return
end

function var_0_0.OnAttach(arg_3_0, arg_3_1)
	var_0_0.super.OnAttach(arg_3_0, arg_3_1)
	arg_3_0.signalReceiver:SetCommonEvent(function(arg_4_0)
		if arg_3_0.ignoreSignal then
			return
		end

		switch(arg_4_0.stringParameter, {
			TimelineEnd = function()
				arg_3_0:Op("AgoraVirtualInterActionEnd", arg_3_0.id, arg_3_0.view.player.id)

				return
			end
		})

		return
	end)

	return
end

function var_0_0.GetTargetRoot(arg_6_0)
	if arg_6_0.attachGo then
		return arg_6_0.attachGo.transform
	else
		arg_6_0.attachGo = GameObject.Find(arg_6_0.attach)

		return arg_6_0.attachGo.transform
	end

	return
end

function var_0_0.GetPlayerParent(arg_7_0)
	if arg_7_0.tempPlayerParentPath == nil then
		return arg_7_0:GetTargetRoot()
	else
		local var_7_0 = arg_7_0:GetTargetRoot():Find(arg_7_0.tempPlayerParentPath)

		assert(var_7_0, "can't find player parent with path: " .. arg_7_0.tempPlayerParentPath)

		return var_7_0
	end

	return
end

function var_0_0.StartInteract(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7, arg_8_8)
	arg_8_0.tempPlayerParentPath = arg_8_8

	var_0_0.super.StartInteract(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)

	return
end

return var_0_0
