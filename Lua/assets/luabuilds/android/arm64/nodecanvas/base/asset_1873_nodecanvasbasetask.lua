local NodeCanvasBaseTask = class("NodeCanvasBaseTask", import(".NodeCanvasBaseObject"))

function NodeCanvasBaseTask:Execute(arg_1_1, arg_1_2)
	self:Init(arg_1_1, arg_1_2)
	self:OnExecute()

	return
end

function NodeCanvasBaseTask:Update()
	self:OnUpdate()

	return
end

function NodeCanvasBaseTask:Stop()
	self:OnStop()

	return
end

function NodeCanvasBaseTask:Pause()
	self:OnPause()

	return
end

function NodeCanvasBaseTask:Resume()
	self:OnResume()

	return
end

function NodeCanvasBaseTask:DrawGizmosSelected()
	self:OnDrawGizmosSelected()

	return
end

function NodeCanvasBaseTask:EndAction(arg_7_1)
	local var_7_0 = self:GetNodeInstance()

	if var_7_0 then
		var_7_0:EndAction(defaultValue(arg_7_1, true))
	end

	return
end

function NodeCanvasBaseTask:SendEvent(arg_8_1, arg_8_2)
	if not _IslandCore then
		return
	end

	_IslandCore:GetController():NotifiyCore(arg_8_1, arg_8_2)
	_IslandCore:GetController():NotifiyIsland(arg_8_1, arg_8_2)

	return
end

function NodeCanvasBaseTask:OnExecute()
	return
end

function NodeCanvasBaseTask:OnUpdate()
	return
end

function NodeCanvasBaseTask:OnStop()
	return
end

function NodeCanvasBaseTask:OnPause()
	return
end

function NodeCanvasBaseTask:OnResume()
	return
end

function NodeCanvasBaseTask:OnDrawGizmosSelected()
	return
end

return NodeCanvasBaseTask
