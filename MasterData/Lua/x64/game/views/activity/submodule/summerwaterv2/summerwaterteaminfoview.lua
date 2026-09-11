local SummerWaterTeamInfoView = class("SummerWaterTeamInfoView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function SummerWaterTeamInfoView:ExtraSorter(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	return true, arg_1_1.id < arg_1_2.id
end

function SummerWaterTeamInfoView:GetTrialHeroList()
	return {
		self.heroTrialList_[1]
	}
end

function SummerWaterTeamInfoView:GetHeroList()
	return {}
end

function SummerWaterTeamInfoView:OnWaterResult()
	ShowTips("TIME_OVER")
	self:Back()
end

return SummerWaterTeamInfoView
