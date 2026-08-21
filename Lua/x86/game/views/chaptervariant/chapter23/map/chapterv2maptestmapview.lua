local var_0_0 = class("ChapterV2MapTestMapView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.eventLuaList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItemEvent), arg_1_0.eventUiList_, ChapterV2MapTestEvent)
	arg_1_0.locLuaList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItemLocation), arg_1_0.locUiList_, ChapterV2MapTestLocation)
end

function var_0_0.AddListeners(arg_2_0)
	return
end

function var_0_0.IndexItemEvent(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0.eventList_[arg_3_1]

	arg_3_2:SetData(var_3_0, var_3_0 == arg_3_0.clickedEventId_)
end

function var_0_0.IndexItemLocation(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.locationList_[arg_4_1]

	arg_4_2:SetData(var_4_0, var_4_0 == arg_4_0.clickedLocationId_)
end

function var_0_0.OnClickMapEvent(arg_5_0, arg_5_1)
	arg_5_0.clickedEventId_ = arg_5_1

	arg_5_0:RefreshUI()
	ChapterV2MapTools.OpenEvent(arg_5_1)
end

function var_0_0.OnClickMapLocation(arg_6_0, arg_6_1)
	arg_6_0.clickedLocationId_ = arg_6_1

	ChapterV2MapAction.MoveLocation(arg_6_1)
	arg_6_0:RefreshUI()
end

function var_0_0.OnClickTrackEvent(arg_7_0, arg_7_1)
	local var_7_0 = ChapterV2MapEventCfg[arg_7_1]

	arg_7_0:OnClickMapLocation(var_7_0.location)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.handlerEvent_ = handler(arg_8_0, arg_8_0.OnClickMapEvent)
	arg_8_0.handlerLoc_ = handler(arg_8_0, arg_8_0.OnClickMapLocation)

	manager.notify:RegistListener(CHAPTER_MAP_LOCATION_EVENT_CLICK, arg_8_0.handlerEvent_)
	manager.notify:RegistListener(CHAPTER_MAP_LOCATION_CLICK, arg_8_0.handlerLoc_)

	arg_8_0.clickedEventId_ = nil
	arg_8_0.clickedLocationId_ = nil
end

function var_0_0.OnExit(arg_9_0)
	manager.notify:RemoveListener(CHAPTER_MAP_LOCATION_EVENT_CLICK, arg_9_0.handlerEvent_)
	manager.notify:RemoveListener(CHAPTER_MAP_LOCATION_CLICK, arg_9_0.handlerLoc_)
end

function var_0_0.GetMapLocations(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = ChapterV2MapLocationCfg.get_id_list_by_map[arg_10_0] or {}

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		if ChapterV2MapTools.IsLocationUnlock(iter_10_1) then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = ChapterV2MapData:GetCurrentMapId()

	arg_11_0.mapId_ = var_11_0
	arg_11_0.locationList_ = arg_11_0.GetMapLocations(var_11_0)

	arg_11_0.locLuaList_:StartScroll(#arg_11_0.locationList_)

	if arg_11_0.clickedLocationId_ then
		arg_11_0.eventList_ = ChapterV2MapTools.GetLocationEvents(arg_11_0.clickedLocationId_)

		arg_11_0.eventLuaList_:StartScroll(#arg_11_0.eventList_)
	else
		arg_11_0.eventLuaList_:StartScroll(0)
	end
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.eventLuaList_ then
		arg_12_0.eventLuaList_:Dispose()

		arg_12_0.eventLuaList_ = nil
	end

	if arg_12_0.locLuaList_ then
		arg_12_0.locLuaList_:Dispose()

		arg_12_0.locLuaList_ = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
