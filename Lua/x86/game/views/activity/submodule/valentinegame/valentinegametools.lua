return {
	GetMainUIName = function(arg_1_0)
		if ActivityConst.TYR_VALENTINE_GAME == arg_1_0 then
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineMainUI"
		else
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineMainUI"
		end
	end,
	GetRewardUIName = function(arg_2_0)
		if ActivityConst.TYR_VALENTINE_GAME == arg_2_0 then
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineRewardUI"
		else
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineRewardUI"
		end
	end,
	GetTestUIName = function(arg_3_0)
		if ActivityConst.TYR_VALENTINE_GAME == arg_3_0 then
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineStageUI"
		else
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineStageUI"
		end
	end,
	GetGameHelpKey = function(arg_4_0)
		if ActivityConst.TYR_VALENTINE_GAME == arg_4_0 then
			return "ACTIVITY_VALENTINE_DESCRIPE"
		else
			return ""
		end
	end,
	GetPointRule = function(arg_5_0)
		if ActivityConst.TYR_VALENTINE_GAME == arg_5_0 then
			local var_5_0 = GameSetting.activity_valentine_right_num.value

			return var_5_0[1], var_5_0[2]
		else
			local var_5_1 = GameSetting.activity_valentine_right_num.value

			return var_5_1[1], var_5_1[2]
		end
	end,
	GetLoadingUIName = function(arg_6_0)
		if ActivityConst.TYR_VALENTINE_GAME == arg_6_0 then
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineStarUI"
		else
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineStarUI"
		end
	end,
	GetGameUIName = function(arg_7_0)
		if ActivityConst.TYR_VALENTINE_GAME == arg_7_0 then
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineGameUI"
		else
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineGameUI"
		end
	end,
	GetResultUIName = function(arg_8_0)
		if ActivityConst.TYR_VALENTINE_GAME == arg_8_0 then
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineResultUI"
		else
			return "UI/VersionUI/DarkFlameUI/DFValentineUI/DFValentineResultUI"
		end
	end
}
