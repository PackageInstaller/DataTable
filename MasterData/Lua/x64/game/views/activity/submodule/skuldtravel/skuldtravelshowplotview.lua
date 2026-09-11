local SkuldTravelShowPlotView = class("SkuldTravelShowPlotView", ReduxView)

function SkuldTravelShowPlotView:UIName()
	return "UI/EmptyDream/EDream_travelled/EDream_travelrecord"
end

function SkuldTravelShowPlotView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldTravelShowPlotView:Init()
	self:InitUI()
end

function SkuldTravelShowPlotView:InitUI()
	self:BindCfgUI()

	self.itemlist_ = {}

	for iter_4_0 = 1, 9 do
		self.itemlist_[iter_4_0] = SkuldTravelShowPlotItem.New(self["itemgo_" .. iter_4_0])
	end
end

function SkuldTravelShowPlotView:OnEnter()
	self:RefreshUI()
end

function SkuldTravelShowPlotView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SkuldTravelShowPlotView:RefreshUI()
	for iter_7_0, iter_7_1 in pairs(self.itemlist_) do
		iter_7_1:SetData(TravelSkuldStoryCfg.all[iter_7_0])
	end
end

function SkuldTravelShowPlotView:OnExit()
	manager.windowBar:HideBar()
end

function SkuldTravelShowPlotView:Dispose()
	if self.itemlist_ then
		for iter_9_0, iter_9_1 in pairs(self.itemlist_) do
			iter_9_1:Dispose()

			self.itemlist_[iter_9_0] = nil
		end

		self.itemlist_ = nil
	end

	self.super.Dispose(self)
end

return SkuldTravelShowPlotView
