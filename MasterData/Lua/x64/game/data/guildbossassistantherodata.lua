local var_0_0 = singletonClass("GuildBossAssistantHeroData", BaseHeroViewData)

function var_0_0.GetHeroList(arg_1_0)
	return GuildData:GetAssistantBriefList()
end

function var_0_0:GetHeroIDList()
	return self.dataClass:GetHeroIDList(self.tempHeroList)
end

function var_0_0:GetHeroUsingSkinInfo(arg_3_1)
	return self.dataClass:GetHeroUsingSkinInfo(arg_3_1, self.tempHeroList)
end

return var_0_0
