local NodeCanvasBaseCondition = class("NodeCanvasBaseCondition", import(".NodeCanvasBaseObject"))

function NodeCanvasBaseCondition:Enable(arg_1_1, arg_1_2)
	self:Init(arg_1_1, arg_1_2)
	self:OnEnable()

	return
end

function NodeCanvasBaseCondition:Disable()
	self:OnDisable()

	return
end

function NodeCanvasBaseCondition:Check()
	return self:OnCheck()
end

function NodeCanvasBaseCondition:OnEnable()
	return
end

function NodeCanvasBaseCondition:OnDisable()
	return
end

function NodeCanvasBaseCondition:OnCheck()
	return true
end

return NodeCanvasBaseCondition
