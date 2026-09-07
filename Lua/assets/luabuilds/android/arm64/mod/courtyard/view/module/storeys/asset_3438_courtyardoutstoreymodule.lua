local CourtYardOutStoreyModule = class("CourtYardOutStoreyModule", import(".CourtYardStoreyModule"))

function CourtYardOutStoreyModule:OnInit()
	self.scrollrect = self._tf:Find("scrollRect")
	self.scroll = self.scrollrect:GetComponent(typeof(ScrollRect))
	self.rectTF = self._tf:Find("scrollRect/bg/rect")
	self.gridsTF = self.rectTF:Find("grids")
	self.rootTF = self._tf:Find("root")
	self.selectedTF = self._tf:Find("root/drag")
	self.rotationBtn = self.selectedTF:Find("panel/rotation")
	self.removeBtn = self.selectedTF:Find("panel/cancel")
	self.confirmBtn = self.selectedTF:Find("panel/ok")
	self.dragBtn = CourtYardStoreyDragBtn.New(self.selectedTF:Find("panel/animroot"), self.rectTF)

	return
end

function CourtYardOutStoreyModule:EnableZoom(arg_2_1)
	self.scroll.enabled = arg_2_1

	return
end

return CourtYardOutStoreyModule
