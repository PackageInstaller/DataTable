return {
	GetRankUIName = function(arg_1_0)
		if arg_1_0 == ActivityConst.XUHENG_PT2_RANK then
			return "UI/VersionUI/XuHeng1stUI/XH1stPtUI/XH1stPtRankUI"
		elseif arg_1_0 == ActivityConst.ACTIVITY_2_1_PT2_RANK then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndPtUI/XH2ndPtRankUI"
		elseif arg_1_0 == ActivityConst.ACTIVITY_2_2_PT2_RANK then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdPtUI/XH3rdPtRankUI"
		elseif arg_1_0 == ActivityConst.ACTIVITY_2_4_PT2_RANK_UP then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionPTUI/JapanRegionPTUPRankUI"
		elseif arg_1_0 == ActivityConst.ACTIVITY_2_4_PT2_RANK_DOWN then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionPTUI/JapanRegionPTDownRankUI"
		elseif arg_1_0 == ActivityConst.KAGUTSUCHI_ACTIVITY_PT2_RANK_DOWN then
			return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionPtDownUI/JapanRegionPTDownRankUI"
		elseif arg_1_0 == ActivityConst.ACTIVITY_2_8_PT2_RANK_UP then
			return "UI/VersionUI/IndiaUI_2_8/IndiaPTUp/IndiaPTUpRankUI"
		elseif arg_1_0 == ActivityConst.ACTIVITY_2_8_PT2_RANK_DOWN then
			return "UI/VersionUI/IndiaUI_2_8/IndiaPTDown/IndiaPTDownRankUI"
		else
			return "UI/VersionUI/XuHeng1stUI/XH1stPtUI/XH1stPtRankUI"
		end
	end,
	GetRankItemClass = function(arg_2_0)
		if arg_2_0 == ActivityConst.XUHENG_PT2_RANK then
			return ActivityPT2RankItem
		else
			return ActivityRaceRankItem
		end
	end
}
