return {
	GetMainUIName = function(arg_1_0)
		if ActivityConst.SUMMER_LIMITED_CALCULATION == arg_1_0 then
			return "UI/VersionUI/SummerUI/SummerArtifactUI"
		elseif ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION == arg_1_0 then
			return "UI/VersionUI/DarkFlameUI/DFArtifactUI/DFArtifactMainUI"
		elseif ActivityConst.ACTIVITY_2_10_LIMITED_CALCULATION == arg_1_0 then
			return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10ArtifactUI/JapanRegionUI_2_10ArtifactUI"
		else
			return "UI/VersionUI/SummerUI/SummerArtifactUI"
		end
	end,
	GetGameHelpKey = function(arg_2_0)
		if ActivityConst.SUMMER_LIMITED_CALCULATION == arg_2_0 then
			return "ACTIVITY_SUMMER_LIMITED_CALCULATION_DESCRIPE"
		elseif ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION == arg_2_0 then
			return "ACTIVITY_1_7_LIMITED_CALCULATION_DESCRIPE"
		else
			return "ACTIVITY_1_7_LIMITED_CALCULATION_DESCRIPE"
		end
	end,
	GetRankUIName = function(arg_3_0)
		if ActivityConst.SUMMER_LIMITED_CALCULATION == arg_3_0 then
			return "UI/VersionUI/SummerUI/SummerArtifactRankUI"
		elseif ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION == arg_3_0 then
			return "UI/VersionUI/DarkFlameUI/DFArtifactUI/DFArtifactRankUI"
		elseif ActivityConst.ACTIVITY_2_10_LIMITED_CALCULATION == arg_3_0 then
			return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10ArtifactUI/JapanRegionUI_2_10ArtifactRankUI"
		else
			return "UI/VersionUI/SummerUI/SummerArtifactRankUI"
		end
	end,
	GetBuffList = function(arg_4_0)
		local var_4_0
		local var_4_1 = {}
		local var_4_2 = LimitedCalculationData:GetDifficultyList(arg_4_0)

		for iter_4_0, iter_4_1 in ipairs(var_4_2) do
			if ActivityLimitCalculationCfg[iter_4_1].player_level ~= 0 then
				table.insert(var_4_1, iter_4_1)
			end
		end

		return var_4_1
	end,
	GetDebuffList = function(arg_5_0)
		local var_5_0
		local var_5_1 = {}
		local var_5_2 = LimitedCalculationData:GetDifficultyList(arg_5_0)

		for iter_5_0, iter_5_1 in ipairs(var_5_2) do
			if ActivityLimitCalculationCfg[iter_5_1].enemy_level ~= 0 then
				table.insert(var_5_1, iter_5_1)
			end
		end

		return var_5_1
	end
}
