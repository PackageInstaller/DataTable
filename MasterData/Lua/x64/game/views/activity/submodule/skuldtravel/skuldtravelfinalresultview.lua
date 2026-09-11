local SkuldTravelFinalResultView = class("SkuldTravelFinalResultView", ReduxView)

function SkuldTravelFinalResultView:UIName()
	return "UI/EmptyDream/EDream_travelled/EDream_travelend"
end

function SkuldTravelFinalResultView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldTravelFinalResultView:Init()
	self:InitUI()
end

function SkuldTravelFinalResultView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.ItemRenderler), self.listgo_, SkuldTravelFinalResultItem)
end

function SkuldTravelFinalResultView:ItemRenderler(arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1)
end

function SkuldTravelFinalResultView:OnEnter()
	if SkuldTravelData:IsOpenNewEnding() then
		self.list_:StartScroll(#TravelSkuldEndingCfg.all, #TravelSkuldEndingCfg.all)
	else
		self.list_:StartScroll(#TravelSkuldEndingCfg.all - 1)
	end
end

function SkuldTravelFinalResultView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SkuldTravelFinalResultView:OnSkuldOpenEnding()
	self.list_:Refresh()
end

function SkuldTravelFinalResultView:OnExit()
	manager.windowBar:HideBar()
end

function SkuldTravelFinalResultView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	SkuldTravelFinalResultView.super.Dispose(self)
end

return SkuldTravelFinalResultView
