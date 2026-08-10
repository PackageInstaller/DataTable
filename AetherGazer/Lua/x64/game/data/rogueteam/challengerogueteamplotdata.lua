local var_0_0 = class("ChallengeRogueTeamPlotData")

function var_0_0.ExportMethod(arg_1_0)
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

function var_0_0.Init(arg_2_0)
	arg_2_0:PlotResetData()
end

function var_0_0.PlotResetData(arg_3_0)
	arg_3_0.worldLineList_ = {}
	arg_3_0.endingPlotID_ = 0
	arg_3_0.endingPlayState_ = ChallengeRogueTeamConst.ENDING_PLOT_STATE.UN_PLAYED
	arg_3_0.optionEndWorldLineID_ = 0
	arg_3_0.plotID_ = 0
end

function var_0_0.PlotSetWorldLineID(arg_4_0, arg_4_1)
	if not table.indexof(RogueTeamPlotPopCfg.all, arg_4_1) then
		return
	end

	table.insert(arg_4_0.worldLineList_, arg_4_1)
end

function var_0_0.PlotGetWorldLineID(arg_5_0)
	local var_5_0 = 1

	if #arg_5_0.worldLineList_ > 0 then
		var_5_0 = arg_5_0.worldLineList_[1]

		table.remove(arg_5_0.worldLineList_, 1)
	end

	return var_5_0
end

function var_0_0.PlotSetEndingData(arg_6_0, arg_6_1)
	arg_6_0.endingPlotID_ = arg_6_1.id
	arg_6_0.endingPlayState_ = arg_6_1.state
	arg_6_0.optionEndWorldLineID_ = arg_6_1.id
end

function var_0_0.PlotGetEndingID(arg_7_0)
	return arg_7_0.endingPlotID_
end

function var_0_0.PlotSetEndingPlayState(arg_8_0, arg_8_1)
	arg_8_0.endingPlayState_ = arg_8_1
end

function var_0_0.PlotGetEndingPlayState(arg_9_0)
	return arg_9_0.endingPlayState_
end

function var_0_0.PlotSetOptionEndID(arg_10_0, arg_10_1)
	arg_10_0.optionEndWorldLineID_ = arg_10_1
end

function var_0_0.PlotGetOptionEndID(arg_11_0)
	return arg_11_0.optionEndWorldLineID_
end

function var_0_0.SetPlotID(arg_12_0, arg_12_1)
	arg_12_0.plotID_ = arg_12_1
end

function var_0_0.GetPlotID(arg_13_0)
	return arg_13_0.plotID_
end

return var_0_0
