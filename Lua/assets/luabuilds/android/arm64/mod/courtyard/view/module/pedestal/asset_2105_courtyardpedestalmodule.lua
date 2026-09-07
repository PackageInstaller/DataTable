local CourtYardPedestalModule = class("CourtYardPedestalModule", import("..CourtYardBaseModule"))

function CourtYardPedestalModule:OnInit()
	self.storey = self.data
	self.scrollView = self._tf.parent:Find("scroll_view")
	self.wallPaper = CourtYardPedestalWallPaper.New(self)
	self.floorPaper = CourtYardPedestalFloorPaper.New(self)
	self.road = CourtYardPedestalRoad.New(self)
	self.wallBase = CourtYardPedestalWallBase.New(self)
	self.msgBox = CourtYardExtendTipPage.New(self)

	return
end

function CourtYardPedestalModule:AddListeners()
	self:AddListener(CourtYardEvent.UPDATE_STOREY, self.OnUpdate)
	self:AddListener(CourtYardEvent.UPDATE_WALLPAPER, self.OnWallPaperUpdate)
	self:AddListener(CourtYardEvent.UPDATE_FLOORPAPER, self.OnFloorPaperUpdate)

	return
end

function CourtYardPedestalModule:RemoveListeners()
	self:RemoveListener(CourtYardEvent.UPDATE_STOREY, self.OnUpdate)
	self:RemoveListener(CourtYardEvent.UPDATE_WALLPAPER, self.OnWallPaperUpdate)
	self:RemoveListener(CourtYardEvent.UPDATE_FLOORPAPER, self.OnFloorPaperUpdate)

	return
end

function CourtYardPedestalModule:OnWallPaperUpdate(arg_4_1)
	self.wallPaper:Update(arg_4_1, self.level)

	return
end

function CourtYardPedestalModule:OnFloorPaperUpdate(arg_5_1)
	self.floorPaper:Update(arg_5_1, self.level)

	return
end

function CourtYardPedestalModule:OnUpdate(arg_6_1)
	self.level = arg_6_1

	self.road:Update(arg_6_1)
	self.wallBase:Update(arg_6_1)
	self:InitScrollRect(arg_6_1)

	return
end

function CourtYardPedestalModule:InitScrollRect(arg_7_1)
	self._tf.sizeDelta = Vector2(self._tf.sizeDelta.x, 1080 + (arg_7_1 - 1) * 22)

	scrollTo(self.scrollView, 0.508, 0.655)

	return
end

function CourtYardPedestalModule:OnDispose()
	self.msgBox:Destroy()

	self.msgBox = nil

	self.wallPaper:Dispose()

	self.wallPaper = nil

	self.floorPaper:Dispose()

	self.floorPaper = nil

	self.road:Dispose()

	self.road = nil

	self.wallBase:Dispose()

	self.wallBase = nil

	return
end

return CourtYardPedestalModule
