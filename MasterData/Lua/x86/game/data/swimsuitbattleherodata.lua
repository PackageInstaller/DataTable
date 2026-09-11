local var_0_0 = singletonClass("SwimsuitBattleHeroData", BaseHeroViewData)

function var_0_0.Init(arg_1_0)
	return
end

function var_0_0.GetHeroList(arg_2_0)
	return HeroData:GetHeroList()
end

function var_0_0.GetHeroData(arg_3_0, arg_3_1)
	local var_3_0 = clone(HeroData:GetHeroData(arg_3_1))
	local var_3_1 = SwimsuitBattleData:GetSkinByHeroID(arg_3_1)

	if var_3_1 then
		var_3_0.using_skin = var_3_1
	end

	return var_3_0
end

return var_0_0
