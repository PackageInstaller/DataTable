local ChapterV2MapTestMapView = class("ChapterV2MapTestMapView", ReduxView)

function ChapterV2MapTestMapView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.eventLuaList_ = LuaList.New(handler(self, self.IndexItemEvent), self.eventUiList_, ChapterV2MapTestEvent)
	self.locLuaList_ = LuaList.New(handler(self, self.IndexItemLocation), self.locUiList_, ChapterV2MapTestLocation)
end

function ChapterV2MapTestMapView:AddListeners()
	return
end

function ChapterV2MapTestMapView:IndexItemEvent(arg_3_1, arg_3_2)
	arg_3_2:SetData(self.eventList_[arg_3_1], self.eventList_[arg_3_1] == self.clickedEventId_)
end

function ChapterV2MapTestMapView:IndexItemLocation(arg_4_1, arg_4_2)
	arg_4_2:SetData(self.locationList_[arg_4_1], self.locationList_[arg_4_1] == self.clickedLocationId_)
end

function ChapterV2MapTestMapView:OnClickMapEvent(arg_5_1)
	self.clickedEventId_ = arg_5_1

	self:RefreshUI()
	ChapterV2MapTools.OpenEvent(arg_5_1)
end

function ChapterV2MapTestMapView:OnClickMapLocation(arg_6_1)
	self.clickedLocationId_ = arg_6_1

	ChapterV2MapAction.MoveLocation(arg_6_1)
	self:RefreshUI()
end

function ChapterV2MapTestMapView:OnClickTrackEvent(arg_7_1)
	self:OnClickMapLocation(ChapterV2MapEventCfg[arg_7_1].location)
end

function ChapterV2MapTestMapView:OnEnter()
	self.handlerEvent_ = handler(self, self.OnClickMapEvent)
	self.handlerLoc_ = handler(self, self.OnClickMapLocation)

	manager.notify:RegistListener(CHAPTER_MAP_LOCATION_EVENT_CLICK, self.handlerEvent_)
	manager.notify:RegistListener(CHAPTER_MAP_LOCATION_CLICK, self.handlerLoc_)

	self.clickedEventId_ = nil
	self.clickedLocationId_ = nil
end

function ChapterV2MapTestMapView:OnExit()
	manager.notify:RemoveListener(CHAPTER_MAP_LOCATION_EVENT_CLICK, self.handlerEvent_)
	manager.notify:RemoveListener(CHAPTER_MAP_LOCATION_CLICK, self.handlerLoc_)
end

function ChapterV2MapTestMapView:GetMapLocations()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(ChapterV2MapLocationCfg.get_id_list_by_map[self] or {}) do
		if ChapterV2MapTools.IsLocationUnlock(iter_10_1) then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function ChapterV2MapTestMapView:RefreshUI()
	local var_11_0 = ChapterV2MapData:GetCurrentMapId()

	self.mapId_ = var_11_0
	self.locationList_ = self.GetMapLocations(var_11_0)

	self.locLuaList_:StartScroll(#self.locationList_)

	if self.clickedLocationId_ then
		self.eventList_ = ChapterV2MapTools.GetLocationEvents(self.clickedLocationId_)

		self.eventLuaList_:StartScroll(#self.eventList_)
	else
		self.eventLuaList_:StartScroll(0)
	end
end

function ChapterV2MapTestMapView:Dispose()
	if self.eventLuaList_ then
		self.eventLuaList_:Dispose()

		self.eventLuaList_ = nil
	end

	if self.locLuaList_ then
		self.locLuaList_:Dispose()

		self.locLuaList_ = nil
	end

	ChapterV2MapTestMapView.super.Dispose(self)
end

return ChapterV2MapTestMapView
