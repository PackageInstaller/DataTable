local CourtYardFeastPedestalModule = class("CourtYardFeastPedestalModule", import("..CourtYardBaseModule"))

function CourtYardFeastPedestalModule:OnInit()
	self.storey = self.data
	self.scrollView = self._tf.parent:Find("scroll_view")

	return
end

function CourtYardFeastPedestalModule:AddListeners()
	self:AddListener(CourtYardEvent.UPDATE_STOREY, self.OnUpdate)

	return
end

function CourtYardFeastPedestalModule:RemoveListeners()
	self:RemoveListener(CourtYardEvent.UPDATE_STOREY, self.OnUpdate)

	return
end

function CourtYardFeastPedestalModule:OnUpdate(arg_4_1)
	self.level = arg_4_1

	self:InitScrollRect(arg_4_1)

	return
end

function CourtYardFeastPedestalModule:InitScrollRect(arg_5_1)
	self._tf.sizeDelta = Vector2(self._tf.sizeDelta.x, 1080 + (arg_5_1 - 1) * 22)

	scrollTo(self.scrollView, 0.5, 0.5)

	return
end

function CourtYardFeastPedestalModule:OnDispose()
	return
end

return CourtYardFeastPedestalModule
