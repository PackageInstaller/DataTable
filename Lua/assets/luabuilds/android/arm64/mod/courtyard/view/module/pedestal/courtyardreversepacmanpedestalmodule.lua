local CourtYardReversePacmanPedestalModule = class("CourtYardReversePacmanPedestalModule", import("..CourtYardBaseModule"))

function CourtYardReversePacmanPedestalModule:OnInit()
	self.storey = self.data
	self.scrollView = self._tf.parent:Find("scroll_view")

	return
end

function CourtYardReversePacmanPedestalModule:AddListeners()
	self:AddListener(CourtYardEvent.UPDATE_STOREY, self.OnUpdate)

	return
end

function CourtYardReversePacmanPedestalModule:RemoveListeners()
	self:RemoveListener(CourtYardEvent.UPDATE_STOREY, self.OnUpdate)

	return
end

function CourtYardReversePacmanPedestalModule:OnUpdate(arg_4_1)
	self.level = arg_4_1

	self:InitScrollRect(arg_4_1)

	return
end

function CourtYardReversePacmanPedestalModule:InitScrollRect(arg_5_1)
	self._tf.sizeDelta = Vector2(self._tf.sizeDelta.x, 1080 + (arg_5_1 - 1) * 22)

	scrollTo(self.scrollView, 0.5, 0.5)

	return
end

function CourtYardReversePacmanPedestalModule:OnDispose()
	return
end

return CourtYardReversePacmanPedestalModule
