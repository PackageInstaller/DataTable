local CourtYardDragAgent = class("CourtYardDragAgent", import(".CourtYardAgent"))

function CourtYardDragAgent:Ctor(arg_1_1, arg_1_2)
	CourtYardDragAgent.super.Ctor(self, arg_1_1)

	self.rect = arg_1_2
	self.trigger = GetOrAddComponent(self._tf, "EventTriggerListener")
	self.dragging = false

	self:RegisterEvent()

	return
end

function CourtYardDragAgent:Enable(arg_2_1)
	self.trigger.enabled = arg_2_1

	return
end

function CourtYardDragAgent:RegisterEvent()
	self.trigger:AddBeginDragFunc(function(arg_4_0, arg_4_1)
		if not self:CanDrag(arg_4_0) then
			return
		end

		self.dragging = true

		self:OnBeginDrag()

		return
	end)
	self.trigger:AddDragFunc(function(arg_5_0, arg_5_1)
		if self.dragging and self._go == arg_5_0 then
			self:OnDragging((CourtYardCalcUtil.Local2Map((CourtYardCalcUtil.Screen2Local(self.rect, arg_5_1.position)))))
		end

		return
	end)
	self.trigger:AddDragEndFunc(function(arg_6_0, arg_6_1)
		if self.dragging and arg_6_0 == self._go then
			self.dragging = false

			self:OnDragEnd((CourtYardCalcUtil.Local2Map((CourtYardCalcUtil.Screen2Local(self.rect, arg_6_1.position)))))
		end

		return
	end)

	return
end

function CourtYardDragAgent:CanDrag(arg_7_1)
	return Input.touchCount <= 1 and self._go == arg_7_1
end

function CourtYardDragAgent:UnRegisterEvent()
	self.dragging = false

	ClearEventTrigger(self.trigger)

	return
end

function CourtYardDragAgent:Dispose()
	CourtYardDragAgent.super.Dispose(self)
	self:UnRegisterEvent()
	Object.Destroy(self.trigger)

	return
end

return CourtYardDragAgent
