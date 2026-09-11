local SkuldTravelMapView = class("SkuldTravelMapView", ReduxView)

function SkuldTravelMapView:UIName()
	return "UI/EmptyDream/EDream_travelled/EDream_travelmap"
end

function SkuldTravelMapView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldTravelMapView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldTravelMapView:InitUI()
	self:BindCfgUI()
end

function SkuldTravelMapView:AddUIListeners()
	for iter_5_0 = 1, 3 do
		self:AddBtnListener(self["btn_" .. iter_5_0], nil, function()
			JumpTools.OpenPageByJump("skuldTravelItemSelectView", {
				mapindex = iter_5_0
			})
		end)
	end

	self:AddBtnListener(self.bgbtn_, nil, function()
		JumpTools.Back()
	end)
end

function SkuldTravelMapView:OnEnter()
	self:RefreshUI()
end

function SkuldTravelMapView:RefreshUI()
	for iter_9_0, iter_9_1 in pairs(TravelSkuldStoryCfg.get_id_list_by_location_id) do
		manager.redPoint:bindUIandKey(self["btn_" .. iter_9_0].transform, RedPointConst.TRAVEL_SKULD_TRAVELMAP .. iter_9_0)
	end
end

function SkuldTravelMapView:OnExit()
	return
end

function SkuldTravelMapView:Dispose()
	for iter_11_0, iter_11_1 in pairs(TravelSkuldStoryCfg.get_id_list_by_location_id) do
		manager.redPoint:unbindUIandKey(self["btn_" .. iter_11_0].transform, RedPointConst.TRAVEL_SKULD_TRAVELMAP .. iter_11_0)
	end

	self.super.Dispose(self)
end

return SkuldTravelMapView
