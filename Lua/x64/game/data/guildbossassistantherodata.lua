local var_0_0 = singletonClass("GuildBossAssistantHeroData", BaseHeroViewData)

function var_0_0.GetHeroList(arg_1_0)
	return GuildData:GetAssistantBriefList()
end

function var_0_0.GetHeroIDList(arg_2_0)
	return arg_2_0.dataClass:GetHeroIDList(arg_2_0.tempHeroList)
end

function var_0_0.GetHeroUsingSkinInfo(arg_3_0, arg_3_1)
	return arg_3_0.dataClass:GetHeroUsingSkinInfo(arg_3_1, arg_3_0.tempHeroList)
end

return var_0_0
