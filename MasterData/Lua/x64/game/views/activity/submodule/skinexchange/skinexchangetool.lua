return {
	GetMainUIName = function(arg_1_0)
		if ActivityConst.SUMMER_SKIN_EXCHANGE == arg_1_0 then
			return "UI/VersionUI/SummerUI/SummerSkinTrialObtainUI"
		else
			return "UI/VersionUI/SummerUI/SummerSkinTrialObtainUI"
		end
	end,
	IsCanExchange = function(arg_2_0)
		local var_2_0 = ActivityData:GetActivityData(arg_2_0)

		if var_2_0 and var_2_0:IsActivitying() then
			if SkinExchangeData:GetState(arg_2_0) == 1 then
				return false, GetTips("ERROR_CLUB_REWARD_ALREADY_SIGN")
			end
		else
			return false, GetTips("SOLO_NOT_OPEN")
		end

		local var_2_1 = true
		local var_2_5 = ""

		for iter_2_0, iter_2_1 in ipairs(ActivitySkinExchangeCfg[arg_2_0].cost) do
			if iter_2_1[2] > ItemTools.getItemNum(iter_2_1[1]) then
				var_2_1 = false
				var_2_5 = string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(iter_2_1[1]))

				break
			end
		end

		return var_2_1, var_2_5
	end
}
