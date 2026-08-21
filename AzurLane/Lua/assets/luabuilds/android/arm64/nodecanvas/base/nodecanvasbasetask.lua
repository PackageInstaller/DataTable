local var_0_0 = class("NodeCanvasBaseTask", import(".NodeCanvasBaseObject"))

function var_0_0.Execute(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:Init(arg_1_1, arg_1_2)
	arg_1_0:OnExecute()

	return
end

function var_0_0.Update(arg_2_0)
	arg_2_0:OnUpdate()

	return
end

function var_0_0.Stop(arg_3_0)
	arg_3_0:OnStop()

	return
end

function var_0_0.Pause(arg_4_0)
	arg_4_0:OnPause()

	return
end

function var_0_0.Resume(arg_5_0)
	arg_5_0:OnResume()

	return
end

function var_0_0.DrawGizmosSelected(arg_6_0)
	arg_6_0:OnDrawGizmosSelected()

	return
end

function var_0_0.EndAction(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:GetNodeInstance()

	if var_7_0 then
		var_7_0:EndAction(defaultValue(arg_7_1, true))
	end

	return
end

function var_0_0.SendEvent(arg_8_0, arg_8_1, arg_8_2)
	if not _IslandCore then
		return
	end

	_IslandCore:GetController():NotifiyCore(arg_8_1, arg_8_2)
	_IslandCore:GetController():NotifiyIsland(arg_8_1, arg_8_2)

	return
end

function var_0_0.OnExecute(arg_9_0)
	return
end

function var_0_0.OnUpdate(arg_10_0)
	return
end

function var_0_0.OnStop(arg_11_0)
	return
end

function var_0_0.OnPause(arg_12_0)
	return
end

function var_0_0.OnResume(arg_13_0)
	return
end

function var_0_0.OnDrawGizmosSelected(arg_14_0)
	return
end

return var_0_0
