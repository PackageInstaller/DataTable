local var_0_0 = {
	GotoBackHomeRoom = function(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
		local var_1_0 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM)

		if var_1_0 then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.DORM, var_1_0))

			return nil
		end

		BackHomeDataManager:EnterBackHomeSystem(arg_1_2 and function(arg_2_0)
			BackHomeDataManager:GotoBackHomeCricketStage(BackHomeCricketConst.ROOM_TYPE.TRAIN)
		end or arg_1_3 and function(arg_3_0)
			BackHomeDataManager:GotoBackHomeIlluScene()
		end or function(arg_4_0)
			BackHomeDataManager:GotoBackHomeScene(arg_1_1)
		end)
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

		if ConditionCfg[arg_7_1] == nil then
			return true, 0, 0
		end

		if var_7_0 then
			if var_7_0.type == CanteenConst.UnLockCon.CookLevel then
				local var_7_2 = CanteenData:GetFurnitureLevel(var_7_0.params[1])

				return var_7_2 >= var_7_0.params[2], var_7_2, var_7_0.params[2]
			elseif var_7_0.type == CanteenConst.UnLockCon.TotleIncome then
				local var_7_3 = CanteenData:GetCurEarning()

				return var_7_3 >= var_7_0.params[1], var_7_3, var_7_0.params[1]
			elseif var_7_0.type == CanteenConst.UnLockCon.FoodProficiency then
				local var_7_4 = CanteenFoodData:GetFoodProficiency(var_7_0.params[1])

				return var_7_4 >= var_7_0.params[2], var_7_4, var_7_0.params[2]
			elseif var_7_0.type == CanteenConst.UnLockCon.FoodComplateNum then
				local var_7_5 = CanteenFoodData:GetFoodCookNum(var_7_0.params[1])

				return var_7_5 >= var_7_0.params[2], var_7_5, var_7_0.params[2]
			elseif var_7_0.type == CanteenConst.UnLockCon.FoodTypeComplateNum then
				local var_7_6 = CanteenFoodData:GetFoodTypeCookNum(var_7_0.params[1])

				return var_7_6 >= var_7_0.params[2], var_7_6, var_7_0.params[2]
			elseif var_7_0.type == CanteenConst.UnLockCon.RoomunLockNum then
				local var_7_7 = DormRoomTools:GetUnlockRoomNum()

				return var_7_7 >= var_7_0.params[1], var_7_7, var_7_0.params[1]
			end
		else
			print("不存在该解锁条件")
		end
	end
}

function var_0_0.GetBackHomeConditionDes(arg_8_0, arg_8_1)
	if ConditionCfg[arg_8_1] then
		local var_8_0 = GetI18NText(ConditionCfg[arg_8_1].desc)

		if ConditionCfg[arg_8_1].type == CanteenConst.UnLockCon.CookLevel then
			return string.format(var_8_0, GetI18NText((CanteenTools:GetCookCfgNameByEid(ConditionCfg[arg_8_1].params[1]))), ConditionCfg[arg_8_1].params[2])
		elseif ConditionCfg[arg_8_1].type == CanteenConst.UnLockCon.TotleIncome then
			local var_8_1 = CanteenData:GetCurEarning()

			if var_8_1 < ConditionCfg[arg_8_1].params[1] then
				var_8_1 = var_0_0:ChangeStrColor(var_8_1)
			end

			return string.format(var_8_0, var_8_1)
		elseif ConditionCfg[arg_8_1].type == CanteenConst.UnLockCon.FoodProficiency then
			local var_8_2 = CanteenFoodData:GetFoodProficiency(ConditionCfg[arg_8_1].params[1])

			if var_8_2 < ConditionCfg[arg_8_1].params[2] then
				var_8_2 = var_0_0:ChangeStrColor(var_8_2)
			end

			return (string.format(var_8_0, GetI18NText(BackHomeCanteenFoodCfg[ConditionCfg[arg_8_1].params[1]].name), var_8_2))
		elseif ConditionCfg[arg_8_1].type == CanteenConst.UnLockCon.FoodComplateNum then
			local var_8_3 = CanteenFoodData:GetFoodCookNum(ConditionCfg[arg_8_1].params[1])

			if var_8_3 < ConditionCfg[arg_8_1].params[2] then
				var_8_3 = var_0_0:ChangeStrColor(var_8_3)
			end

			return (string.format(var_8_0, GetI18NText(BackHomeCanteenFoodCfg[ConditionCfg[arg_8_1].params[1]].name), var_8_3))
		elseif ConditionCfg[arg_8_1].type == CanteenConst.UnLockCon.FoodTypeComplateNum then
			local var_8_4 = CanteenFoodData:GetFoodTypeCookNum(ConditionCfg[arg_8_1].params[1])

			if var_8_4 < ConditionCfg[arg_8_1].params[2] then
				var_8_4 = var_0_0:ChangeStrColor(var_8_4)
			end

			return (string.format(var_8_0, GetI18NText(CanteenTools:ShowTipsGetCookCfgName(ConditionCfg[arg_8_1].params[1])), var_8_4))
		elseif ConditionCfg[arg_8_1].type == CanteenConst.UnLockCon.RoomunLockNum then
			return var_8_0
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

	for iter_10_4, iter_10_5 in pairs((DormSkillData:CheckSkillCanOpen(arg_10_1, arg_10_2))) do
		table.insert(var_10_1, var_0_0:GetHeroSkillScore(arg_10_1, iter_10_5, var_10_0))
	end

	table.sort(var_10_1, function(arg_11_0, arg_11_1)
		return arg_11_1 < arg_11_0
	end)

	local var_10_2 = var_10_1[1] or 0
	local var_10_3 = var_10_1[2] or 0

	if table.length(var_10_0) == 2 then
		local var_10_4 = {}

		for iter_10_6, iter_10_7 in pairs(var_10_0) do
			table.insert(var_10_4, iter_10_6)
		end

		if BackHomeCanteenFoodCfg[var_10_4[1]].cook_type == BackHomeCanteenFoodCfg[var_10_4[2]].cook_type and var_10_2 == 3 then
			var_10_3 = var_10_2
		end
	end

	return (1 + var_10_2 + var_10_3) * (DormData:GetHeroFatigue(arg_10_2) / 140)
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
	if BackHomeHeroSkillCfg[arg_13_2].condition[1] == 1 and BackHomeHeroSkillCfg[arg_13_2].condition[2] == arg_13_1 then
		if BackHomeHeroSkillCfg[arg_13_2].type == CanteenConst.HeroSkillType.FoodCostQucik or BackHomeHeroSkillCfg[arg_13_2].type == CanteenConst.HeroSkillType.FoodCostRise then
			return 1
		else
			return 2
		end
	end

	return 0
end

function var_0_0.GetFoodScore(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if BackHomeHeroSkillCfg[arg_14_2].condition[1] == 1 and BackHomeHeroSkillCfg[arg_14_2].condition[2] == arg_14_1 then
		if BackHomeHeroSkillCfg[arg_14_2].type == CanteenConst.HeroSkillType.FoodCostQucik or BackHomeHeroSkillCfg[arg_14_2].type == CanteenConst.HeroSkillType.FoodCostRise then
			if BackHomeHeroSkillCfg[arg_14_2].param[1] == BackHomeCanteenFoodCfg[arg_14_3].cook_type then
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

function var_0_0:OnceDeploy()
	local var_15_0 = {}
	local var_15_1 = {}
	local var_15_2 = {}
	local var_15_3 = {}

	for iter_15_0, iter_15_1 in ipairs((CanteenHeroTools:GetCanteenJobList())) do
		if iter_15_1 then
			if iter_15_1.heroID then
				table.insert(var_15_3, iter_15_1.heroID)
			end
		end
	end

	for iter_15_2, iter_15_3 in ipairs(DormConst.DORM_RESTAURANT_SET_JOB_TYPE) do
		local var_15_4 = CanteenTools.GetAvailableJobHeroList()

		for iter_15_4, iter_15_5 in ipairs(var_15_3) do
			table.insert(var_15_4, iter_15_5)
		end

		local var_15_5 = {}

		for iter_15_6, iter_15_7 in ipairs(var_15_4) do
			if not DormNpcTools:CheckIDIsNpc(iter_15_7) then
				var_15_5[iter_15_7] = var_0_0:GetCanteenHeroScore(DormEnum.RestaurantJobToServerMap[iter_15_3], iter_15_7, var_15_1, var_15_2)
			end
		end

		for iter_15_8, iter_15_9 in ipairs((DormNpcTools:GetNpcInfoListByConstJobType(DormEnum.RestaurantJobToServerMap[iter_15_3]))) do
			var_15_5[iter_15_9] = 0.15
		end

		local var_15_6 = 0
		local var_15_7 = 0

		for iter_15_10, iter_15_11 in pairs(var_15_5) do
			if var_15_6 < iter_15_11 then
				var_15_6 = iter_15_11
				var_15_7 = iter_15_10
			end
		end

		var_15_1[var_15_7] = DormEnum.RestaurantJobToServerMap[iter_15_3]
		var_15_2[DormData:GetHeroArchiveID(var_15_7)] = true
	end

	local var_15_8 = {}

	for iter_15_12, iter_15_13 in ipairs((IdolTraineeData:GetIdolHeroList())) do
		var_15_8[iter_15_13] = true
	end

	for iter_15_14, iter_15_15 in pairs((DormData:GetHeroInfoList())) do
		local var_15_9 = iter_15_15:GetHeroState() ~= DormEnum.DormHeroState.InCanteenEntrust and (var_15_1[iter_15_15.hero_id] or var_15_2[DormData:GetHeroArchiveID(iter_15_15.hero_id)]) or true

		if not var_15_9 and not iter_15_15:GetRoomID() then
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

	local var_15_10 = {}
	local var_15_11 = 1

	for iter_15_16 = 1, #var_15_0 do
		if var_15_0[iter_15_16] and var_15_8[var_15_0[iter_15_16].hero_id] then
			table.insert(var_15_10, {
				hero_id = var_15_0[iter_15_16].hero_id,
				pos = var_15_11
			})

			var_15_11 = var_15_11 + 1
			var_15_0[iter_15_16] = false

			if var_15_11 == 6 then
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

	local var_15_12 = {}
	local var_15_13 = 0

	for iter_15_17 = 1, #var_15_0 do
		if var_15_0[iter_15_17] then
			table.insert(var_15_12, var_15_0[iter_15_17].hero_id)

			var_15_13 = var_15_13 + 1
		end

		if var_15_13 == 5 then
			break
		end
	end

	local var_15_14 = {}

	for iter_15_18, iter_15_19 in pairs(var_15_1) do
		table.insert(var_15_14, {
			jobType = iter_15_19,
			id = iter_15_18
		})
	end

	if var_15_14[1] then
		CanteenAction:SetCharacterJob(var_15_14[1].jobType, {
			var_15_14[1].id
		}, function()
			if var_15_14[2] then
				CanteenAction:SetCharacterJob(var_15_14[2].jobType, {
					var_15_14[2].id
				}, function()
					if var_15_14[3] then
						CanteenAction:SetCharacterJob(var_15_14[3].jobType, {
							var_15_14[3].id
						}, function()
							self:OnceDeploy_Stage2(var_15_10, var_15_12)
						end)
					else
						self:OnceDeploy_Stage2(var_15_10, var_15_12)
					end
				end)
			else
				self:OnceDeploy_Stage2(var_15_10, var_15_12)
			end
		end)
	else
		self:OnceDeploy_Stage2(var_15_10, var_15_12)
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
	return var_0_0.CheckHeroIsLockForAnyFeature((DormData:GetHeroTemplateInfo(arg_25_0)))
end

function var_0_0.CheckHeroIsLockForAnyFeatureByArchiveID(arg_26_0)
	return var_0_0.CheckHeroIsLockForAnyFeature((DormData:GetHeroInfo(arg_26_0)))
end

local var_0_1 = {
	[DormConst.LOCK_HERO_FOR_FEATURE.LOCK_FOR_IDOL_TRAINING] = "IDOL_DANCE_HERO_LOCK"
}

function var_0_0.CheckHeroIsLockForAnyFeatureWithTips(arg_27_0)
	local var_27_0, var_27_1 = var_0_0.CheckHeroIsLockForAnyFeatureByHeroID(arg_27_0)

	return var_27_0, nullable(var_0_1, var_27_1)
end

return var_0_0
