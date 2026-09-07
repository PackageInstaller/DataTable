local CourtYardVisitorShipModule = class("CourtYardVisitorShipModule", import(".CourtYardShipModule"))

function CourtYardVisitorShipModule:OnInit()
	CourtYardVisitorShipModule.super.OnInit(self)

	self.nameTF = self._tf:Find("name")

	setText(self.nameTF, self.data:GetName())

	return
end

function CourtYardVisitorShipModule:InitAttachment()
	return
end

function CourtYardVisitorShipModule:OnBeginDrag()
	return
end

function CourtYardVisitorShipModule:OnDragging(arg_4_1)
	return
end

function CourtYardVisitorShipModule:OnDragEnd(arg_5_1)
	return
end

function CourtYardVisitorShipModule:OnInimacyChange(arg_6_1)
	return
end

function CourtYardVisitorShipModule:OnCoinChange(arg_7_1)
	return
end

return CourtYardVisitorShipModule
