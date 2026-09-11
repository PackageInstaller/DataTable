local var_0_0 = {
	InitCanteenJobState = function(arg_1_0, arg_1_1)
		for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
			if DormNpcTools:CheckIDIsNpc(iter_1_1.hero_id) then
				local var_1_0 = BackHomeNpcData:GetNpcInfoById(iter_1_1.hero_id)

				if var_1_0 then
					var_1_0:SetJob(iter_1_1.type)
				end
			else
				local var_1_1 = DormData:GetHeroInfoList()[DormData:GetHeroArchiveID(iter_1_1.hero_id)]

				if var_1_1 then
					var_1_1:SetJob(iter_1_1.type)
					var_1_1:SetCurHeroID(iter_1_1.hero_id)
				end
			end
		end

		CanteenHeroTools:RefreshCanteenJobList()
	end,
	GetCurWorkIDListByJobType = function(arg_2_0, arg_2_1)
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in pairs((DormData:GetHeroInfoList())) do
			if iter_2_1.jobType == arg_2_1 then
				table.insert(var_2_0, iter_2_0)
			end
		end

		for iter_2_2, iter_2_3 in pairs((BackHomeNpcData:GetBackHomeNpcInfoList())) do
			if iter_2_3.jobType == arg_2_1 then
				table.insert(var_2_0, iter_2_2)
			end
		end

		return var_2_0
	end,
	HasJobAssignedToHero = function(arg_3_0, arg_3_1)
		local var_3_0 = DormData:GetHeroInfoList()

		if var_3_0 then
			for iter_3_0, iter_3_1 in pairs(var_3_0) do
				if iter_3_1.jobType == DormEnum.RestaurantJobToServerMap[arg_3_1] then
					return true
				end
			end

			if DormNpcTools:CheckHasNpcWorkOnJob(DormEnum.RestaurantJobToServerMap[arg_3_1]) then
				return true
			end
		end

		return false
	end
}
local var_0_1

function var_0_0.GetCanteenJobList(arg_4_0)
	if var_0_1 then
		return var_0_1
	end
end

function var_0_0.GetJobTypeByHeroID(arg_5_0, arg_5_1)
	local var_5_0 = DormData:GetHeroInfoList()[DormData:GetHeroArchiveID(arg_5_1)]

	if var_5_0 then
		return var_5_0.jobType
	end
end

function var_0_0.RefreshCanteenJobList(arg_6_0)
	local var_6_0 = DormData:GetHeroInfoList()
	local var_6_1 = BackHomeNpcData:GetBackHomeNpcInfoList()
	local var_6_2 = {
		{},
		{},
		{}
	}

	if var_6_0 then
		for iter_6_0, iter_6_1 in pairs(var_6_0) do
			if iter_6_1.jobType then
				local var_6_3 = var_6_0[iter_6_0]:GetHeroId()

				var_6_2[iter_6_1.jobType].heroID = var_6_3
				var_6_2[iter_6_1.jobType].skinID = DormHeroTools:GetCurSkinID(var_6_3)
			end
		end
	end

	if var_6_1 then
		for iter_6_2, iter_6_3 in pairs(var_6_1) do
			if iter_6_3.jobType then
				var_6_2[iter_6_3.jobType].heroID = iter_6_2
				var_6_2[iter_6_3.jobType].skinID = iter_6_2
			end
		end
	end

	var_0_1 = var_6_2
end

function var_0_0.GetJobDispatchMaxCount(arg_7_0, arg_7_1)
	if arg_7_1 == DormEnum.CharacterType.RestaurantCook then
		return 1
	elseif arg_7_1 == DormEnum.CharacterType.RestaurantWaiter then
		return 1
	elseif arg_7_1 == DormEnum.CharacterType.RestaurantCashier then
		return 1
	end
end

function var_0_0.CheckHeroConcertTag(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 == 1 then
		if arg_8_3 == CharactorParamCfg[arg_8_1].RangeType then
			return true
		end
	elseif arg_8_2 == 2 then
		if arg_8_3 == HeroCfg[arg_8_1].race then
			return true
		end
	elseif arg_8_2 == 3 then
		if arg_8_3 == HeroCfg[arg_8_1].ATK_attribute[1] then
			return true
		end
	elseif arg_8_2 == 4 and arg_8_3 == HeroCfg[arg_8_1].mechanism_type[1] then
		return true
	end

	return false
end

return var_0_0
