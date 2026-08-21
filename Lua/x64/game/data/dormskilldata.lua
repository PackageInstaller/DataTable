local var_0_0 = singletonClass("DormSkillData")
local var_0_1

function var_0_0.Init(arg_1_0)
	var_0_1 = {}

	for iter_1_0 = 1, 20 do
		var_0_1[iter_1_0] = {}
	end

	arg_1_0:UpdataAllHeroSkill()
	arg_1_0:UpdataAllFurSkill()
	arg_1_0:UpdataAllNpcSkill()
	arg_1_0:CalInComeStorageMaxNum()
	arg_1_0:CalCanSignFoodNum()
end

function var_0_0.CheckSkillIsOpen(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if var_0_1 then
		local var_2_0 = BackHomeHeroSkillCfg[arg_2_2]
		local var_2_1 = var_2_0.type
		local var_2_2 = var_2_0.condition

		if not var_2_2 or #var_2_2 == 0 then
			return true
		end

		if arg_2_3 == DormEnum.EntityType.Character then
			if var_2_2 and #var_2_2 > 0 then
				if var_2_2[1] == 1 then
					if DormData:GetCharacterInfo(arg_2_1).jobType ~= var_2_2[2] then
						return false
					end
				elseif var_2_2[1] == 2 then
					local var_2_3 = DormData:GetCharacterInfo(arg_2_1):GetCurRoomID()

					if not var_2_3 then
						return false
					end

					if BackHomeCfg[var_2_3].type ~= var_2_2[2] then
						return false
					end
				end
			end
		elseif arg_2_3 == DormEnum.EntityType.Furniture then
			return true
		end

		return true
	end
end

function var_0_0.CheckSkillIsRun(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if var_0_1 then
		local var_3_0 = BackHomeHeroSkillCfg[arg_3_2].type

		if var_0_1[var_3_0] then
			for iter_3_0, iter_3_1 in ipairs(var_0_1[var_3_0]) do
				if iter_3_1.type == arg_3_3 and iter_3_1.id == arg_3_1 and iter_3_1.skillID == arg_3_2 then
					return true
				end
			end
		end

		return false
	end
end

function var_0_0.AddSkillComponent(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = BackHomeHeroSkillCfg[arg_4_2].type

	if not var_0_1[var_4_0] then
		var_0_1[var_4_0] = {}
	end

	local var_4_1 = {
		type = arg_4_3,
		id = arg_4_1,
		skillID = arg_4_2
	}

	table.insert(var_0_1[var_4_0], var_4_1)
end

function var_0_0.DisposeSkillComponent(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = BackHomeHeroSkillCfg[arg_5_2].type

	for iter_5_0 = 1, #var_0_1[var_5_0] do
		local var_5_1 = var_0_1[var_5_0][iter_5_0]

		if var_5_1 and var_5_1.type == arg_5_3 and var_5_1.id == arg_5_1 and var_5_1.skillID == arg_5_2 then
			table.remove(var_0_1[var_5_0], iter_5_0)
		end
	end
end

local var_0_2

function var_0_0.GetCanSignFoodNum(arg_6_0)
	return var_0_2
end

function var_0_0.CalCanSignFoodNum(arg_7_0)
	local var_7_0 = GameSetting.dorm_canteen_sell_default.value[1]
	local var_7_1 = CanteenData:GetFurInfoList()
	local var_7_2 = 0

	for iter_7_0, iter_7_1 in pairs(var_7_1) do
		local var_7_3 = iter_7_1.level
		local var_7_4 = BackHomeCanteenFurnitureIDCfg[iter_7_0].type_id

		if BackHomeCanteenFurnitureCfg[var_7_4] then
			var_7_2 = var_7_2 + BackHomeCanteenFurnitureCfg[var_7_4].canteen_sell_max[var_7_3]
		end
	end

	var_0_2 = var_7_0 + var_7_2
end

local var_0_3

function var_0_0.GetInComeStorageMax(arg_8_0)
	if var_0_3 then
		return var_0_3
	else
		print("存储上限不存在")
	end
end

function var_0_0.CalInComeStorageMaxNum(arg_9_0)
	local var_9_0 = GameSetting.dorm_canteen_storage_default.value[1]
	local var_9_1 = CanteenData:GetFurInfoList()
	local var_9_2 = 0

	for iter_9_0, iter_9_1 in pairs(var_9_1) do
		local var_9_3 = iter_9_1.level
		local var_9_4 = BackHomeCanteenFurnitureIDCfg[iter_9_0].type_id

		if BackHomeCanteenFurnitureCfg[var_9_4] then
			var_9_2 = var_9_2 + BackHomeCanteenFurnitureCfg[var_9_4].canteen_storage_max[var_9_3]
		end
	end

	var_0_3 = var_9_0 + var_9_2
end

function var_0_0.GetSkillEffect(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if var_0_1 then
		local var_10_0 = var_0_1[arg_10_1]

		if arg_10_1 == CanteenConst.HeroSkillType.FoodCostQucik then
			local var_10_1 = 0

			if var_10_0 and #var_10_0 > 0 then
				for iter_10_0, iter_10_1 in ipairs(var_10_0) do
					local var_10_2 = iter_10_1.skillID

					if arg_10_4 == BackHomeHeroSkillCfg[var_10_2].param[1] or BackHomeHeroSkillCfg[var_10_2].param[1] == 0 then
						var_10_1 = var_10_1 + BackHomeHeroSkillCfg[var_10_2].param[2]
					end
				end
			end

			return var_10_1
		elseif arg_10_1 == CanteenConst.HeroSkillType.FoodCostRise then
			local var_10_3 = 0

			if var_10_0 and #var_10_0 > 0 then
				for iter_10_2, iter_10_3 in ipairs(var_10_0) do
					local var_10_4 = iter_10_3.skillID

					if arg_10_4 == BackHomeHeroSkillCfg[var_10_4].param[1] or BackHomeHeroSkillCfg[var_10_4].param[1] == 0 then
						var_10_3 = var_10_3 + BackHomeHeroSkillCfg[var_10_4].param[2]
					end
				end
			end

			return var_10_3
		elseif arg_10_1 == CanteenConst.HeroSkillType.FatigueRecuse then
			local var_10_5 = 100

			if var_10_0 and #var_10_0 > 0 then
				for iter_10_4, iter_10_5 in ipairs(var_10_0) do
					if arg_10_2 == iter_10_5.id then
						var_10_5 = var_10_5 - BackHomeHeroSkillCfg[iter_10_5.skillID].param[1]
					end
				end
			end

			return var_10_5
		elseif arg_10_1 == CanteenConst.HeroSkillType.PopularRise then
			local var_10_6 = 0

			if var_10_0 and #var_10_0 > 0 then
				for iter_10_6, iter_10_7 in ipairs(var_10_0) do
					local var_10_7 = iter_10_7.skillID

					var_10_6 = var_10_6 + BackHomeHeroSkillCfg[var_10_7].param[1]
				end
			end

			return var_10_6
		elseif arg_10_1 == CanteenConst.HeroSkillType.FatigueRecoverSelfFast then
			local var_10_8 = 0

			if var_10_0 and #var_10_0 > 0 then
				for iter_10_8, iter_10_9 in ipairs(var_10_0) do
					if arg_10_2 == iter_10_9.id then
						var_10_8 = var_10_8 + BackHomeHeroSkillCfg[iter_10_9.skillID].param[1]
					end
				end
			end

			return var_10_8
		elseif arg_10_1 == CanteenConst.HeroSkillType.FatigueRecoverAllFast then
			local var_10_9 = 0

			if var_10_0 and #var_10_0 > 0 then
				for iter_10_10, iter_10_11 in ipairs(var_10_0) do
					var_10_9 = var_10_9 + BackHomeHeroSkillCfg[iter_10_11.skillID].param[1]
				end
			end

			return var_10_9
		elseif arg_10_1 == CanteenConst.HeroSkillType.EntrustFatigueSelfReduce then
			local var_10_10 = 100

			if var_10_0 and #var_10_0 > 0 then
				for iter_10_12, iter_10_13 in ipairs(var_10_0) do
					if arg_10_2 == iter_10_13.id then
						var_10_10 = var_10_10 - BackHomeHeroSkillCfg[iter_10_13.skillID].param[1]
					end
				end
			end

			return var_10_10
		elseif arg_10_1 == CanteenConst.HeroSkillType.EntrustExternSucceedAdd then
			local var_10_11 = 0

			if var_10_0 and #var_10_0 > 0 then
				for iter_10_14, iter_10_15 in ipairs(var_10_0) do
					if arg_10_2 == iter_10_15.id then
						var_10_11 = var_10_11 + BackHomeHeroSkillCfg[iter_10_15.skillID].param[1]
					end
				end
			end

			return var_10_11
		elseif arg_10_1 == CanteenConst.HeroSkillType.EntrustExternAwardAdd then
			local var_10_12 = CanteenEntrustData:GetEntrustByPos(arg_10_3).hero_list
			local var_10_13 = 100

			if var_10_0 and #var_10_0 > 0 then
				for iter_10_16, iter_10_17 in ipairs(var_10_0) do
					for iter_10_18, iter_10_19 in ipairs(var_10_12) do
						if iter_10_19 == iter_10_17.id then
							var_10_13 = var_10_13 + BackHomeHeroSkillCfg[iter_10_17.skillID].param[1]
						end
					end
				end
			end

			return var_10_13
		elseif arg_10_1 == CanteenConst.HeroSkillType.EntrustTotalFatigueReduce then
			local var_10_14 = 0

			if var_10_0 and #var_10_0 > 0 then
				for iter_10_20, iter_10_21 in ipairs(var_10_0) do
					if arg_10_2 == iter_10_21.id then
						var_10_14 = var_10_14 + BackHomeHeroSkillCfg[iter_10_21.skillID].param[1]
					end
				end
			end

			return var_10_14
		else
			print("未找到对应类型技能")
		end
	end
end

function var_0_0.UpdataAllHeroSkill(arg_11_0)
	local var_11_0 = DormData:GetHeroInfoList()

	if var_11_0 then
		for iter_11_0, iter_11_1 in pairs(var_11_0) do
			iter_11_1:DisposeRunSkill()
			iter_11_1:OpenHeroSkill()
		end
	end
end

function var_0_0.UpdataAllNpcSkill(arg_12_0)
	local var_12_0 = BackHomeNpcData:GetBackHomeNpcInfoList()

	if var_12_0 then
		for iter_12_0, iter_12_1 in pairs(var_12_0) do
			iter_12_1:DisposeRunSkill()
			iter_12_1:OpenHeroSkill()
		end
	end
end

function var_0_0.UpdataAllFurSkill(arg_13_0)
	local var_13_0 = CanteenData:GetFurInfoList()

	if var_13_0 then
		for iter_13_0, iter_13_1 in pairs(var_13_0) do
			local var_13_1 = BackHomeCanteenFurnitureIDCfg[iter_13_0].type_id
			local var_13_2 = BackHomeCanteenFurnitureCfg[var_13_1].skill[iter_13_1.level]

			for iter_13_2, iter_13_3 in ipairs(var_13_2) do
				if arg_13_0:CheckSkillIsOpen(iter_13_0, iter_13_3, DormEnum.EntityType.Furniture) and not arg_13_0:CheckSkillIsRun(iter_13_0, iter_13_3, DormEnum.EntityType.Furniture) then
					arg_13_0:AddSkillComponent(iter_13_0, iter_13_3, DormEnum.EntityType.Furniture)
				end
			end
		end
	end
end

function var_0_0.GetSkillDesc(arg_14_0, arg_14_1)
	local var_14_0 = BackHomeHeroSkillCfg[arg_14_1]
	local var_14_1 = ""
	local var_14_2 = arg_14_0:GetSkillEffectDesc(arg_14_1)

	if var_14_0.condition[1] == 1 then
		local var_14_3 = CanteenTools:GetJobName(var_14_0.condition[2])

		var_14_1 = string.format(GetI18NText(var_14_0.desc), var_14_3)
	elseif var_14_0.condition[1] == 2 then
		local var_14_4 = GetTips("DORM_LOBBY_NAME")

		var_14_1 = string.format(GetI18NText(var_14_0.desc), var_14_4)
	elseif var_14_0.condition[1] == 3 then
		var_14_1 = string.format(GetI18NText(var_14_0.desc), GetTips("DORM_CANTEEN_TASK_NAME"))
	end

	return var_14_1 .. var_14_2
end

function var_0_0.GetSkillEffectDesc(arg_15_0, arg_15_1)
	local var_15_0 = ""
	local var_15_1 = BackHomeHeroSkillCfg[arg_15_1]
	local var_15_2 = var_15_1.type
	local var_15_3 = ""

	if var_15_1.param[2] then
		local var_15_4 = CanteenTools:GetFootTypeName(var_15_1.param[1])

		var_15_0 = string.format(GetI18NText(BackHomeHeroSkillDescCfg[var_15_2].desc), tostring(var_15_4))

		if var_15_1.param[2] >= 0 then
			var_15_3 = string.format(GetI18NText(BackHomeHeroSkillDescCfg[var_15_2].pos_desc), tostring(var_15_1.param[2]))
		else
			var_15_3 = string.format(GetI18NText(BackHomeHeroSkillDescCfg[var_15_2].neg_desc), tostring(-var_15_1.param[2]))
		end
	else
		var_15_0 = string.format(GetI18NText(BackHomeHeroSkillDescCfg[var_15_2].desc))

		if var_15_1.param[1] >= 0 then
			var_15_3 = string.format(GetI18NText(BackHomeHeroSkillDescCfg[var_15_2].pos_desc), tostring(var_15_1.param[1]))
		else
			var_15_3 = string.format(GetI18NText(BackHomeHeroSkillDescCfg[var_15_2].neg_desc), tostring(-var_15_1.param[1]))
		end
	end

	return var_15_0 .. var_15_3
end

function var_0_0.GetCookCanUnlockFoodList(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = BackHomeFurniture[arg_16_1]
	local var_16_1 = {}

	if var_16_0 then
		for iter_16_0, iter_16_1 in ipairs(BackHomeCanteenFoodCfg.all) do
			if BackHomeCanteenFoodCfg[iter_16_1].cook_type == var_16_0.type then
				local var_16_2 = BackHomeCanteenFoodCfg[iter_16_1].unlock

				if var_16_2 > 0 then
					local var_16_3 = ConditionCfg[var_16_2]

					if var_16_3.type == CanteenConst.UnLockCon.CookLevel and arg_16_2 >= var_16_3.params[2] then
						table.insert(var_16_1, iter_16_1)
					end
				else
					table.insert(var_16_1, iter_16_1)
				end
			end
		end
	end

	return var_16_1
end

function var_0_0.CheckSkillCanOpen(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = {}

	if DormNpcTools:CheckIDIsNpc(arg_17_2) then
		local var_17_1 = BackHomeNpcCfg[arg_17_2].skill_list

		for iter_17_0 = 1, #var_17_1 do
			table.insert(var_17_0, var_17_1[iter_17_0])
		end
	else
		local var_17_2 = BackHomeHeroCfg[arg_17_2].skill_list
		local var_17_3 = GameSetting.dorm_hero_skill_unlock.value
		local var_17_4 = HeroData:GetHeroData(arg_17_2).level

		for iter_17_1 = 1, #var_17_2 do
			if var_17_4 >= var_17_3[iter_17_1] then
				table.insert(var_17_0, var_17_2[iter_17_1])
			end
		end
	end

	local var_17_5 = {}

	for iter_17_2, iter_17_3 in ipairs(var_17_0) do
		local var_17_6 = BackHomeHeroSkillCfg[iter_17_3].condition

		if var_17_6 and #var_17_6 > 0 then
			if var_17_6[1] == 1 and arg_17_1 == var_17_6[2] then
				table.insert(var_17_5, iter_17_3)
			end
		else
			table.insert(var_17_5, iter_17_3)
		end
	end

	return var_17_5
end

function var_0_0.Dispose(arg_18_0)
	var_0_1 = nil
end

return var_0_0
