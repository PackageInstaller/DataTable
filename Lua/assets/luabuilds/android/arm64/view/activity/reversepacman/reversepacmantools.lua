local var_0_0 = {}

function var_0_0.GetRoleListByType(arg_1_0)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(var_0_0.GetActivity():getConfig("config_client").chasing_char) do
		if pg.activity_chasing_character[iter_1_1].ai_type == arg_1_0 then
			table.insert(var_1_0, iter_1_1)
		end
	end

	return var_1_0
end

function var_0_0.HasHireRole()
	for iter_2_0, iter_2_1 in pairs((var_0_0.GetActivity():GetFavorabilityList())) do
		return true
	end

	return false
end

function var_0_0.GetInterviewItemID(arg_3_0)
	return var_0_0.GetActivity():getConfig("config_client").interviewItemID
end

function var_0_0.GetGiftItemID(arg_4_0)
	return var_0_0.GetActivity():getConfig("config_client").giftItemID
end

function var_0_0.GetTechnologyPTDrop(arg_5_0)
	local var_5_0 = pg.activity_shop_template[var_0_0.GetActivity():getConfig("config_client").technologyShopIDList[1]]

	return Drop.New({
		type = var_5_0.resource_category,
		id = var_5_0.resource_type
	})
end

function var_0_0.GetItemCnt(arg_6_0)
	return var_0_0.GetActivity():GetVitemNumber(arg_6_0)
end

function var_0_0.IsUnlockRole(arg_7_0)
	if pg.activity_chasing_character[arg_7_0].unlock_story_id == 0 then
		return true
	end

	return pg.NewStoryMgr.GetInstance():IsPlayed((pg.NewStoryMgr.GetInstance():StoryId2StoryName(tonumber(pg.activity_chasing_character[arg_7_0].unlock_story_id))))
end

function var_0_0.IsHireRole(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(var_0_0.GetActivity():GetFavorabilityList()) do
		if iter_8_0 == arg_8_0 then
			return true
		end
	end

	return false
end

function var_0_0.GetActivity()
	return getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_REVERSE_PACMAN)
end

function var_0_0.GetMaxFavorabilityValue(arg_10_0)
	return pg.activity_chasing_character[arg_10_0].love_level[#pg.activity_chasing_character[arg_10_0].love_level][2]
end

function var_0_0.GetFavorabilityValue(arg_11_0)
	return var_0_0.GetActivity():GetFavorability(arg_11_0)
end

function var_0_0.GetUpgradeFavorability(arg_12_0)
	local var_12_0 = var_0_0.GetFavorabilityValue(arg_12_0)

	for iter_12_0, iter_12_1 in ipairs(pg.activity_chasing_character[arg_12_0].love_level) do
		if var_12_0 == iter_12_1[2] then
			return iter_12_1[1]
		end
	end

	return 0
end

function var_0_0.GetUnreadyHireStory()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(var_0_0.GetActivity():GetFavorabilityList()) do
		if iter_13_1 >= pg.activity_chasing_character[iter_13_0].love_level[1][2] then
			if not pg.NewStoryMgr.GetInstance():IsPlayed(pg.activity_chasing_character[iter_13_0].love_level_show[1]) then
				table.insert(var_13_0, iter_13_0)
			end
		end
	end

	return var_13_0
end

function var_0_0.GetFavorabilityUnreadyStory()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(var_0_0.GetActivity():GetFavorabilityList()) do
		for iter_14_2, iter_14_3 in ipairs(pg.activity_chasing_character[iter_14_0].love_level) do
			if iter_14_2 ~= 1 and iter_14_3[2] == iter_14_1 then
				if not pg.NewStoryMgr.GetInstance():IsPlayed(pg.activity_chasing_character[iter_14_0].love_level_show[iter_14_2]) then
					table.insert(var_14_0, iter_14_0)
				end
			end
		end
	end

	return var_14_0
end

function var_0_0.GetUnPassLevelIds()
	local var_15_0 = {}
	local var_15_1 = var_0_0.GetActivity()
	local var_15_2 = var_15_1:GetStageDataList()

	for iter_15_0, iter_15_1 in ipairs(pg.activity_chasing_level.all) do
		if not var_15_2[iter_15_1] and var_15_1:IsUnlockStage(iter_15_1) then
			table.insert(var_15_0, iter_15_1)
		end
	end

	return var_15_0
end

return var_0_0
