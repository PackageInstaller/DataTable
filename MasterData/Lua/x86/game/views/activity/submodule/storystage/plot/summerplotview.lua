local SummerPlotView = class("SummerPlotView", ReduxView)

function SummerPlotView:UIName()
	return "UI/BranchlineUI/SummerUI/SummerPlotUI"
end

function SummerPlotView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerPlotView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.plotUIList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, SummerPlotItem)
end

function SummerPlotView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistHomeCallBack(function()
		self:HideRedPoint()
		self:Go("/home")
	end)
	manager.windowBar:RegistBackCallBack(function()
		self:HideRedPoint()
		self:Back()
	end)

	self.plotList_ = ActivityStoryCollect[self.params_.theme].story_id

	local var_4_0, var_4_1 = ActivityTools.GetActivityChessProgress(ChessConst.SUBPLOT_TAG.ISLAND)

	self.value_ = math.floor(var_4_0 / var_4_1)

	self.plotUIList_:StartScroll(#self.plotList_, 1)
	self:RefreshText()
end

function SummerPlotView:OnExit()
	manager.windowBar:HideBar()
end

function SummerPlotView:Dispose()
	SummerPlotView.super.Dispose(self)

	if self.plotUIList_ then
		self.plotUIList_:Dispose()

		self.plotUIList_ = nil
	end
end

function SummerPlotView:AddListeners()
	return
end

function SummerPlotView:RefreshItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.plotList_[arg_10_1], ActivityStoryCollect[self.params_.theme].unlock_value[arg_10_1] or 100, self.value_)
end

function SummerPlotView:RefreshText()
	self.finishRateText_.text = string.format("%d%%", self.value_)
end

function SummerPlotView:HideRedPoint()
	local var_12_0, var_12_1 = ActivityTools.GetActivityChessProgress(ChessConst.SUBPLOT_TAG.ISLAND)

	for iter_12_0, iter_12_1 in pairs(ActivityStoryCollect[ActivityCfg[ActivityConst.SUMMER_CHESS_ISLAND].activity_theme].story_id) do
		local var_12_2 = string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityCfg[ActivityConst.SUMMER_CHESS_ISLAND].activity_theme, iter_12_1)

		if var_12_0 / var_12_1 >= ActivityStoryCollect[ActivityCfg[ActivityConst.SUMMER_CHESS_ISLAND].activity_theme].unlock_value[iter_12_0] then
			WarChessAction.SetActivityChessPlotRedPoint(ActivityCfg[ActivityConst.SUMMER_CHESS_ISLAND].activity_theme, iter_12_1)
		end
	end
end

return SummerPlotView
