local CourtYardStoreyDragBtn = class("CourtYardStoreyDragBtn")

function CourtYardStoreyDragBtn:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._go = arg_1_1.gameObject
	self.agent = CourtYardDragAgent.New(self, arg_1_2)

	self.agent:Enable(false)

	return
end

function CourtYardStoreyDragBtn:Active(arg_2_1, arg_2_2, arg_2_3)
	self.OnDragCallBack = arg_2_1
	self.OnDragingCallBack = arg_2_2
	self.OnDragEndCallBack = arg_2_3

	self.agent:Enable(true)

	return
end

function CourtYardStoreyDragBtn:DeActive()
	self.OnDragCallBack = nil
	self.OnDragingCallBack = nil
	self.OnDragEndCallBack = nil

	self.agent:Enable(false)

	return
end

function CourtYardStoreyDragBtn:OnBeginDrag()
	if self.OnDragCallBack then
		self.OnDragCallBack()
	end

	return
end

function CourtYardStoreyDragBtn:OnDragging(arg_5_1)
	if self.OnDragingCallBack then
		self.OnDragingCallBack(arg_5_1)
	end

	return
end

function CourtYardStoreyDragBtn:OnDragEnd(arg_6_1)
	if self.OnDragEndCallBack then
		self.OnDragEndCallBack(arg_6_1)
	end

	return
end

function CourtYardStoreyDragBtn:Dispose()
	self:DeActive()
	self.agent:Dispose()

	return
end

return CourtYardStoreyDragBtn
