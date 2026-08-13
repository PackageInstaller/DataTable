class = var_0_10000

local var_0_0 = "NodeCanvasBaseTask"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NodeCanvasBaseObject"))

function var_0_1.Execute(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:Init(arg_1_1, arg_1_2)
	arg_1_0:OnExecute()

	return
end

function var_0_1.Update(arg_2_0)
	arg_2_0:OnUpdate()

	return
end

function var_0_1.Stop(arg_3_0)
	arg_3_0:OnStop()

	return
end

function var_0_1.Pause(arg_4_0)
	arg_4_0:OnPause()

	return
end

function var_0_1.Resume(arg_5_0)
	arg_5_0:OnResume()

	return
end

function var_0_1.DrawGizmosSelected(arg_6_0)
	arg_6_0:OnDrawGizmosSelected()

	return
end

function var_0_1.EndAction(arg_7_0, arg_7_1)
	if arg_7_0:GetNodeInstance() then
		local var_7_0 = var_2
		local var_7_1 = var_2.EndAction

		defaultValue = var_1_10006

		var_7_1(var_7_0, var_1_10006(arg_7_1, true))
	end

	return
end

function var_0_1.SendEvent(arg_8_0, arg_8_1, arg_8_2)
	_IslandCore = var_1_10003

	if not var_1_10003 then
		return
	end

	_IslandCore = var_1_10003

	local var_8_0 = var_1_10003:GetController()

	var_3.NotifiyCore(var_8_0, arg_8_1, arg_8_2)

	_IslandCore = var_3

	local var_8_1 = var_3:GetController()

	var_3.NotifiyIsland(var_8_1, arg_8_1, arg_8_2)

	return
end

function var_0_1.OnExecute(arg_9_0)
	return
end

function var_0_1.OnUpdate(arg_10_0)
	return
end

function var_0_1.OnStop(arg_11_0)
	return
end

function var_0_1.OnPause(arg_12_0)
	return
end

function var_0_1.OnResume(arg_13_0)
	return
end

function var_0_1.OnDrawGizmosSelected(arg_14_0)
	return
end

return var_0_1
