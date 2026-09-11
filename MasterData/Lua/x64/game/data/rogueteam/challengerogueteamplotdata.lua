local ChallengeRogueTeamPlotData = class("ChallengeRogueTeamPlotData")

function ChallengeRogueTeamPlotData:ExportMethod()
	return {
		"PlotResetData",
		"PlotSetWorldLineID",
		"PlotGetWorldLineID",
		"PlotSetEndingData",
		"PlotGetEndingID",
		"PlotSetEndingPlayState",
		"PlotGetEndingPlayState",
		"PlotSetOptionEndID",
		"PlotGetOptionEndID",
		"SetPlotID",
		"GetPlotID"
	}
end

function ChallengeRogueTeamPlotData:Init()
	self:PlotResetData()
end

function ChallengeRogueTeamPlotData:PlotResetData()
	self.worldLineList_ = {}
	self.endingPlotID_ = 0
	self.endingPlayState_ = ChallengeRogueTeamConst.ENDING_PLOT_STATE.UN_PLAYED
	self.optionEndWorldLineID_ = 0
	self.plotID_ = 0
end

function ChallengeRogueTeamPlotData:PlotSetWorldLineID(arg_4_1)
	if not table.indexof(RogueTeamPlotPopCfg.all, arg_4_1) then
		return
	end

	table.insert(self.worldLineList_, arg_4_1)
end

function ChallengeRogueTeamPlotData:PlotGetWorldLineID()
	local var_5_0 = 1

	if #self.worldLineList_ > 0 then
		var_5_0 = self.worldLineList_[1]

		table.remove(self.worldLineList_, 1)
	end

	return var_5_0
end

function ChallengeRogueTeamPlotData:PlotSetEndingData(arg_6_1)
	self.endingPlotID_ = arg_6_1.id
	self.endingPlayState_ = arg_6_1.state
	self.optionEndWorldLineID_ = arg_6_1.id
end

function ChallengeRogueTeamPlotData:PlotGetEndingID()
	return self.endingPlotID_
end

function ChallengeRogueTeamPlotData:PlotSetEndingPlayState(arg_8_1)
	self.endingPlayState_ = arg_8_1
end

function ChallengeRogueTeamPlotData:PlotGetEndingPlayState()
	return self.endingPlayState_
end

function ChallengeRogueTeamPlotData:PlotSetOptionEndID(arg_10_1)
	self.optionEndWorldLineID_ = arg_10_1
end

function ChallengeRogueTeamPlotData:PlotGetOptionEndID()
	return self.optionEndWorldLineID_
end

function ChallengeRogueTeamPlotData:SetPlotID(arg_12_1)
	self.plotID_ = arg_12_1
end

function ChallengeRogueTeamPlotData:GetPlotID()
	return self.plotID_
end

return ChallengeRogueTeamPlotData
