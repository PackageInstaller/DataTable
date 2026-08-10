return {
	GetMainUIName = function(arg_1_0)
		if ActivityConst.FACTORY_SURVIVE_SOLO == arg_1_0 then
			return "UI/MardukUI/onerolesurvial/MardukOneroleUI"
		elseif ActivityConst.TYR_SURVIVE_SOLO == arg_1_0 then
			return "UI/VersionUI/DarkFlameUI/DFDisorienTationUI/DFDisorienTationUI"
		else
			return "UI/MardukUI/onerolesurvial/MardukOneroleUI"
		end
	end,
	GetGameHelpKey = function(arg_2_0)
		if ActivityConst.FACTORY_SURVIVE_SOLO == arg_2_0 then
			return "ACTIVITY_SOLO_SLAYER_DESC"
		elseif ActivityConst.TYR_SURVIVE_SOLO == arg_2_0 then
			return "ACTIVITY_SOLO_SLAYER_DESC"
		else
			return ""
		end
	end,
	GetRewardPopView = function(arg_3_0)
		if ActivityConst.FACTORY_SURVIVE_SOLO == arg_3_0 then
			return "UI/MardukUI/onerolesurvial/MardukOneroleRewardUI"
		elseif ActivityConst.TYR_SURVIVE_SOLO == arg_3_0 then
			return "UI/VersionUI/DarkFlameUI/DFDisorienTationUI/DFDisorienTationRewardUI"
		else
			return "UI/MardukUI/onerolesurvial/MardukOneroleRewardUI"
		end
	end,
	GetRewardItemSkin = function(arg_4_0)
		if ActivityConst.FACTORY_SURVIVE_SOLO == arg_4_0 then
			return FactorySkinTrialRewardItem
		else
			return RewardItem
		end
	end
}
