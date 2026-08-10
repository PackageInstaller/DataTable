local var_0_0 = {
	GotoBackHomeRoom = function(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
		local var_1_0 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM)

		if var_1_0 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.DORM, var_1_0))

			return nil
		end

		local var_1_1

		if arg_1_2 then
			function var_1_1(arg_2_0)
				BackHomeDataManager:GotoBackHomeCricketStage(BackHomeCricketConst.ROOM_TYPE.TRAIN)
			end
		elseif arg_1_3 then
			function var_1_1(arg_3_0)
				BackHomeDataManager:GotoBackHomeIlluScene()
			end
		else
			function var_1_1(arg_4_0)
				BackHomeDataManager:GotoBackHomeScene(arg_1_1)
			end
		end

		BackHomeDataManager:EnterBackHomeSystem(var_1_1)
	end,
	BackHomeGotoMain = function(arg_5_0)
		BackHomeDataManager:ExitBackHomeSystem()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/home")
	end,
	OtherSystemVisitExit = function(arg_6_0)
		BackHomeDataManager:OtherSystemVisitBack()
		LuaExchangeHelper.GoToMain()
	end,
	CheckBackHomeConditionAccord = function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = ConditionCfg[arg_7_1]

		if var_7_0 == nil then
			return true, 0, 0
		end

		local var_7_1 = 0

		if var_7_0 then
			local var_7_2 = var_7_0.type

			if var_7_2 == CanteenConst.UnLockCon.CookLevel then
				local var_7_3 = CanteenData:GetFurnitureLevel(var_7_0.params[1])

				return var_7_3 >= var_7_0.params[2], var_7_3, var_7_0.params[2]
			elseif var_7_2 == CanteenConst.UnLockCon.TotleIncome then
				local var_7_4 = CanteenData:GetCurEarning()

				return var_7_4 >= var_7_0.params[1], var_7_4, var_7_0.params[1]
			elseif var_7_2 == CanteenConst.UnLockCon.FoodProficiency then
				local var_7_5 = CanteenFoodData:GetFoodProficiency(var_7_0.params[1])

				return var_7_5 >= var_7_0.params[2], var_7_5, var_7_0.params[2]
			elseif var_7_2 == CanteenConst.UnLockCon.FoodComplateNum then
				local var_7_6 = CanteenFoodData:GetFoodCookNum(var_7_0.params[1])

				return var_7_6 >= var_7_0.params[2], var_7_6, var_7_0.params[2]
			elseif var_7_2 == CanteenConst.UnLockCon.FoodTypeComplateNum then
				local var_7_7 = CanteenFoodData:GetFoodTypeCookNum(var_7_0.params[1])

				return var_7_7 >= var_7_0.params[2], var_7_7, var_7_0.params[2]
			elseif var_7_2 == CanteenConst.UnLockCon.RoomunLockNum then
				local var_7_8 = DormRoomTools:GetUnlockRoomNum()

				return var_7_8 >= var_7_0.params[1], var_7_8, var_7_0.params[1]
			end
		else
			print("不存在该解锁条件")
		end
	end
}

function var_0_0.GetBackHomeConditionDes(arg_8_0, arg_8_1)
	local var_8_0 = ConditionCfg[arg_8_1]

	if var_8_0 then
		local var_8_1 = GetI18NText(var_8_0.desc)
		local var_8_2 = var_8_0.type

		if var_8_2 == CanteenConst.UnLockCon.CookLevel then
			local var_8_3 = CanteenTools:GetCookCfgNameByEid(var_8_0.params[1])
			local var_8_4 = var_8_0.params[2]

			return string.format(var_8_1, GetI18NText(var_8_3), var_8_4)
		elseif var_8_2 == CanteenConst.UnLockCon.TotleIncome then
			local var_8_5 = CanteenData:GetCurEarning()

			if var_8_5 < var_8_0.params[1] then
				var_8_5 = var_0_0:ChangeStrColor(var_8_5)
			end

			return string.format(var_8_1, var_8_5)
		elseif var_8_2 == CanteenConst.UnLockCon.FoodProficiency then
			local var_8_6 = var_8_0.params[1]
			local var_8_7 = CanteenFoodData:GetFoodProficiency(var_8_6)

			if var_8_7 < var_8_0.params[2] then
				var_8_7 = var_0_0:ChangeStrColor(var_8_7)
			end

			return (string.format(var_8_1, GetI18NText(BackHomeCanteenFoodCfg[var_8_6].name), var_8_7))
		elseif var_8_2 == CanteenConst.UnLockCon.FoodComplateNum then
			local var_8_8 = var_8_0.params[1]
			local var_8_9 = CanteenFoodData:GetFoodCookNum(var_8_8)

			if var_8_9 < var_8_0.params[2] then
				var_8_9 = var_0_0:ChangeStrColor(var_8_9)
			end

			return (string.format(var_8_1, GetI18NText(BackHomeCanteenFoodCfg[var_8_8].name), var_8_9))
		elseif var_8_2 == CanteenConst.UnLockCon.FoodTypeComplateNum then
			local var_8_10 = var_8_0.params[1]
			local var_8_11 = CanteenFoodData:GetFoodTypeCookNum(var_8_10)

			if var_8_11 < var_8_0.params[2] then
				var_8_11 = var_0_0:ChangeStrColor(var_8_11)
			end

			return (string.format(var_8_1, GetI18NText(CanteenTools:ShowTipsGetCookCfgName(var_8_10)), var_8_11))
		elseif var_8_2 == CanteenConst.UnLockCon.RoomunLockNum then
			return var_8_1
		end
	else
		print("不存在该解锁条件")
	end
end

function var_0_0.ChangeStrColor(arg_9_0, arg_9_1)
	return "<color=#FF000B>" .. arg_9_1 .. "</color>"
end

function var_0_0.GetCanteenHeroScore(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_10_2) then
		return 0
	end

	for iter_10_0, iter_10_1 in pairs(arg_10_3) do
		if iter_10_0 == HeroID then
			return 0
		end
	end

	for iter_10_2, iter_10_3 in pairs(arg_10_4) do
		if DormData:GetHeroArchiveID(arg_10_2) == iter_10_2 then
			return 0
		end
	end

	local var_10_0 = CanteenFoodData:GetFoodToSignList()[CanteenConst.CanteenMapID]
	local var_10_1 = {}
	local var_10_2 = DormSkillData:CheckSkillCanOpen(arg_10_1, arg_10_2)

	for iter_10_4, iter_10_5 in pairs(var_10_2) do
		table.insert(var_10_1, var_0_0:GetHeroSkillScore(arg_10_1, iter_10_5, var_10_0))
	end

	table.sort(var_10_1, function(arg_11_0, arg_11_1)
		return arg_11_1 < arg_11_0
	end)

	local var_10_3 = var_10_1[1] or 0
	local var_10_4 = var_10_1[2] or 0

	if table.length(var_10_0) == 2 then
		local var_10_5 = {}

		for iter_10_6, iter_10_7 in pairs(var_10_0) do
			table.insert(var_10_5, iter_10_6)
		end

		local var_10_6 = BackHomeCanteenFoodCfg[var_10_5[1]]
		local var_10_7 = BackHomeCanteenFoodCfg[var_10_5[2]]

		if var_10_6.cook_type == var_10_7.cook_type and var_10_3 == 3 then
			var_10_4 = var_10_3
		end
	end

	local var_10_8 = DormData:GetHeroFatigue(arg_10_2)

	return (1 + var_10_3 + var_10_4) * (var_10_8 / 140)
end

function var_0_0.GetHeroSkillScore(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = 0

	if table.length(arg_12_3) <= 0 then
		var_12_0 = var_0_0:GetUnFoodScore(arg_12_1, arg_12_2)
	else
		for iter_12_0, iter_12_1 in pairs(arg_12_3) do
			local var_12_1 = var_0_0:GetFoodScore(arg_12_1, arg_12_2, iter_12_0)

			if var_12_0 < var_12_1 then
				var_12_0 = var_12_1
			end
		end
	end

	return var_12_0
end

function var_0_0.GetUnFoodScore(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = BackHomeHeroSkillCfg[arg_13_2]

	if var_13_0.condition[1] == 1 and var_13_0.condition[2] == arg_13_1 then
		if var_13_0.type == CanteenConst.HeroSkillType.FoodCostQucik or var_13_0.type == CanteenConst.HeroSkillType.FoodCostRise then
			return 1
		else
			return 2
		end
	end

	return 0
end

function var_0_0.GetFoodScore(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = BackHomeCanteenFoodCfg[arg_14_3]
	local var_14_1 = BackHomeHeroSkillCfg[arg_14_2]

	if var_14_1.condition[1] == 1 and var_14_1.condition[2] == arg_14_1 then
		if var_14_1.type == CanteenConst.HeroSkillType.FoodCostQucik or var_14_1.type == CanteenConst.HeroSkillType.FoodCostRise then
			if var_14_1.param[1] == var_14_0.cook_type then
				return 3
			else
				return 1
			end
		else
			return 2
		end
	end

	return 0
end

function var_0_0.OnceDeploy(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = {}
	local var_15_2 = {}
	local var_15_3 = {}
	local var_15_4 = CanteenHeroTools:GetCanteenJobList()

	for iter_15_0, iter_15_1 in ipairs(var_15_4) do
		if iter_15_1 then
			local var_15_5 = iter_15_1.heroID

			if var_15_5 then
				table.insert(var_15_3, var_15_5)
			end
		end
	end

	for iter_15_2, iter_15_3 in ipairs(DormConst.DORM_RESTAURANT_SET_JOB_TYPE) do
		local var_15_6 = DormEnum.RestaurantJobToServerMap[iter_15_3]
		local var_15_7 = CanteenTools.GetAvailableJobHeroList()

		for iter_15_4, iter_15_5 in ipairs(var_15_3) do
			table.insert(var_15_7, iter_15_5)
		end

		local var_15_8 = {}

		for iter_15_6, iter_15_7 in ipairs(var_15_7) do
			if not DormNpcTools:CheckIDIsNpc(iter_15_7) then
				var_15_8[iter_15_7] = var_0_0:GetCanteenHeroScore(var_15_6, iter_15_7, var_15_1, var_15_2)
			end
		end

		local var_15_9 = DormNpcTools:GetNpcInfoListByConstJobType(var_15_6)

		for iter_15_8, iter_15_9 in ipairs(var_15_9) do
			var_15_8[iter_15_9] = 0.15
		end

		local var_15_10 = 0
		local var_15_11 = 0

		for iter_15_10, iter_15_11 in pairs(var_15_8) do
			if var_15_10 < iter_15_11 then
				var_15_10 = iter_15_11
				var_15_11 = iter_15_10
			end
		end

		var_15_1[var_15_11] = var_15_6
		var_15_2[DormData:GetHeroArchiveID(var_15_11)] = true
	end

	local var_15_12 = DormData:GetHeroInfoList()
	local var_15_13 = IdolTraineeData:GetIdolHeroList()
	local var_15_14 = {}

	for iter_15_12, iter_15_13 in ipairs(var_15_13) do
		var_15_14[iter_15_13] = true
	end

	for iter_15_14, iter_15_15 in pairs(var_15_12) do
		if not (iter_15_15:GetHeroState() == DormEnum.DormHeroState.InCanteenEntrust or var_15_1[iter_15_15.hero_id] or var_15_2[DormData:GetHeroArchiveID(iter_15_15.hero_id)]) and not iter_15_15:GetRoomID() then
			table.insert(var_15_0, iter_15_15)
		end
	end

	table.sort(var_15_0, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_0:GetFatigue()
		local var_16_1 = arg_16_1:GetFatigue()

		if var_16_0 == var_16_1 then
			return arg_16_0.hero_id < arg_16_1.hero_id
		end

		return var_16_1 < var_16_0
	end)

	local var_15_15 = {}
	local var_15_16 = #var_15_0
	local var_15_17 = 1

	for iter_15_16 = 1, var_15_16 do
		if var_15_0[iter_15_16] and var_15_14[var_15_0[iter_15_16].hero_id] then
			table.insert(var_15_15, {
				hero_id = var_15_0[iter_15_16].hero_id,
				pos = var_15_17
			})

			var_15_17 = var_15_17 + 1
			var_15_0[iter_15_16] = false

			if var_15_17 == 6 then
				break
			end
		end
	end

	table.sort(var_15_0, function(arg_17_0, arg_17_1)
		if arg_17_0 == false then
			return false
		end

		if arg_17_1 == false then
			return false
		end

		local var_17_0 = arg_17_0:GetFatigue()
		local var_17_1 = arg_17_1:GetFatigue()

		if var_17_0 == var_17_1 then
			return arg_17_0.hero_id < arg_17_1.hero_id
		end

		return var_17_0 < var_17_1
	end)

	local var_15_18 = {}
	local var_15_19 = 0

	for iter_15_17 = 1, var_15_16 do
		if var_15_0[iter_15_17] then
			table.insert(var_15_18, var_15_0[iter_15_17].hero_id)

			var_15_19 = var_15_19 + 1
		end

		if var_15_19 == 5 then
			break
		end
	end

	local var_15_20 = {}

	for iter_15_18, iter_15_19 in pairs(var_15_1) do
		table.insert(var_15_20, {
			jobType = iter_15_19,
			id = iter_15_18
		})
	end

	if var_15_20[1] then
		CanteenAction:SetCharacterJob(var_15_20[1].jobType, {
			var_15_20[1].id
		}, function()
			if var_15_20[2] then
				CanteenAction:SetCharacterJob(var_15_20[2].jobType, {
					var_15_20[2].id
				}, function()
					if var_15_20[3] then
						CanteenAction:SetCharacterJob(var_15_20[3].jobType, {
							var_15_20[3].id
						}, function()
							arg_15_0:OnceDeploy_Stage2(var_15_15, var_15_18)
						end)
					else
						arg_15_0:OnceDeploy_Stage2(var_15_15, var_15_18)
					end
				end)
			else
				arg_15_0:OnceDeploy_Stage2(var_15_15, var_15_18)
			end
		end)
	else
		arg_15_0:OnceDeploy_Stage2(var_15_15, var_15_18)
	end
end

function var_0_0.OnceDeploy_Stage2(arg_21_0, arg_21_1, arg_21_2)
	deferred.all({
		IdolTraineeAction.RequestSetHeroPosPromise(arg_21_1),
		DormAction:DeployHeroInRoomPromise(DormConst.PUBLIC_DORM_ID, arg_21_2, DormEnum.DormDeployType.Place)
	}):next(function(arg_22_0)
		for iter_22_0, iter_22_1 in ipairs(arg_22_0) do
			if not isSuccess(iter_22_1.result) then
				return
			end
		end

		ShowTips("BACKHOME_HERO_AUTO_PLACE")
	end)
end

function var_0_0.CheckHeroIsLockForOtherFeature(arg_23_0, arg_23_1)
	local var_23_0, var_23_1 = var_0_0.CheckHeroIsLockForAnyFeatureByHeroID(arg_23_0)

	return var_23_0 and arg_23_1 ~= var_23_1
end

function var_0_0.CheckHeroIsLockForAnyFeature(arg_24_0)
	local var_24_0 = nullable(arg_24_0, "isLock") or 0

	return var_24_0 ~= 0, var_24_0
end

function var_0_0.CheckHeroIsLockForAnyFeatureByHeroID(arg_25_0)
	local var_25_0 = DormData:GetHeroTemplateInfo(arg_25_0)

	return var_0_0.CheckHeroIsLockForAnyFeature(var_25_0)
end

function var_0_0.CheckHeroIsLockForAnyFeatureByArchiveID(arg_26_0)
	local var_26_0 = DormData:GetHeroInfo(arg_26_0)

	return var_0_0.CheckHeroIsLockForAnyFeature(var_26_0)
end

local var_0_1 = {
	[DormConst.LOCK_HERO_FOR_FEATURE.LOCK_FOR_IDOL_TRAINING] = "IDOL_DANCE_HERO_LOCK"
}

function var_0_0.CheckHeroIsLockForAnyFeatureWithTips(arg_27_0)
	local var_27_0, var_27_1 = var_0_0.CheckHeroIsLockForAnyFeatureByHeroID(arg_27_0)

	return var_27_0, nullable(var_0_1, var_27_1)
end

return var_0_0
