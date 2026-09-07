local NcClickObject = class("NcClickObject", import("..base.NodeCanvasBaseTask"))

function NcClickObject:OnExecute()
	function NcClickObject.Click(arg_2_0)
		self:EndAction()

		return
	end

	self:GetRouter().onMouseDown = self:GetRouter().onMouseDown + NcClickObject.Click

	return
end

function NcClickObject:OnStop()
	if NcClickObject.Click then
		self:GetRouter().onMouseDown = self:GetRouter().onMouseDown - NcClickObject.Click
		NcClickObject.Click = nil
	end

	return
end

return NcClickObject
