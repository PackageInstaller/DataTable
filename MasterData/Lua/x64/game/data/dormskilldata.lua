local var_0_0 = singletonClass("DormSkillData")
local var_0_1

function var_0_0:Init()
	var_0_1 = {}

	for iter_1_0 = 1, 20 do
		var_0_1[iter_1_0] = {}
	end

	self:UpdataAllHeroSkill()
	self:UpdataAllFurSkill()
	self:UpdataAllNpcSkill()
	self:CalInComeStorageMaxNum()
	self:CalCanSignFoodNum()
end

function var_0_0.CheckSkillIsOpen(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if var_0_1 then
		if not BackHomeHeroSkillCfg[arg_2_2].condition or #BackHomeHeroSkillCfg[arg_2_2].condition == 0 then
			return true
		end

		if arg_2_3 == DormEnum.EntityType.Character then
			if BackHomeHeroSkillCfg[arg_2_2].condition and #BackHomeHeroSkillCfg[arg_2_2].condition > 0 then
				if BackHomeHeroSkillCfg[arg_2_2].condition[1] == 1 then
					if DormData:GetCharacterInfo(arg_2_1).jobType ~= BackHomeHeroSkillCfg[arg_2_2].condition[2] then
						return false
					end
				elseif BackHomeHeroSkillCfg[arg_2_2].condition[1] == 2 then
					local var_2_1 = DormData:GetCharacterInfo(arg_2_1):GetCurRoomID()

					if not var_2_1 then
						return false
					end

					if BackHomeCfg[var_2_1].type ~= BackHomeHeroSkillCfg[arg_2_2].condition[2] then
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
		if var_0_1[BackHomeHeroSkillCfg[arg_3_2].type] then
			for iter_3_0, iter_3_1 in ipairs(var_0_1[BackHomeHeroSkillCfg[arg_3_2].type]) do
				if iter_3_1.type == arg_3_3 and iter_3_1.id == arg_3_1 and iter_3_1.skillID == arg_3_2 then
					return true
				end
			end
		end

		return false
	end
end

function var_0_0.AddSkillComponent(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	var_0_1[BackHomeHeroSkillCfg[arg_4_2].type] = var_0_1[BackHomeHeroSkillCfg[arg_4_2].type] or {}

	table.insert(var_0_1[BackHomeHeroSkillCfg[arg_4_2].type], {
		type = arg_4_3,
		id = arg_4_1,
		skillID = arg_4_2
	})
end

function var_0_0.DisposeSkillComponent(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	for iter_5_0 = 1, #var_0_1[BackHomeHeroSkillCfg[arg_5_2].type] do
		if var_0_1[BackHomeHeroSkillCfg[arg_5_2].type][iter_5_0] and var_0_1[BackHomeHeroSkillCfg[arg_5_2].type][iter_5_0].type == arg_5_3 and var_0_1[BackHomeHeroSkillCfg[arg_5_2].type][iter_5_0].id == arg_5_1 and var_0_1[BackHomeHeroSkillCfg[arg_5_2].type][iter_5_0].skillID == arg_5_2 then
			table.remove(var_0_1[BackHomeHeroSkillCfg[arg_5_2].type], iter_5_0)
		end
	end
end

local var_0_2

function var_0_0.GetCanSignFoodNum(arg_6_0)
	return var_0_2
end

function var_0_0.CalCanSignFoodNum(arg_7_0)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs((CanteenData:GetFurInfoList())) do
		if BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[iter_7_0].type_id] then
			var_7_0 = var_7_0 + BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[iter_7_0].type_id].canteen_sell_max[iter_7_1.level]
		end
	end

	var_0_2 = GameSetting.dorm_canteen_sell_default.value[1] + var_7_0
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
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in pairs((CanteenData:GetFurInfoList())) do
		if BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[iter_9_0].type_id] then
			var_9_0 = var_9_0 + BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[iter_9_0].type_id].canteen_storage_max[iter_9_1.level]
		end
	end

	var_0_3 = GameSetting.dorm_canteen_storage_default.value[1] + var_9_0
end

function var_0_0.GetSkillEffect(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if var_0_1 then
		if arg_10_1 == CanteenConst.HeroSkillType.FoodCostQucik then
			local var_10_0 = 0

			if var_0_1[arg_10_1] and #var_0_1[arg_10_1] > 0 then
				for iter_10_0, iter_10_1 in ipairs(var_0_1[arg_10_1]) do
					if arg_10_4 == BackHomeHeroSkillCfg[iter_10_1.skillID].param[1] or BackHomeHeroSkillCfg[iter_10_1.skillID].param[1] == 0 then
						var_10_0 = var_10_0 + BackHomeHeroSkillCfg[iter_10_1.skillID].param[2]
					end
				end
			end

			return var_10_0
		elseif arg_10_1 == CanteenConst.HeroSkillType.FoodCostRise then
			local var_10_1 = 0

			if var_0_1[arg_10_1] and #var_0_1[arg_10_1] > 0 then
				for iter_10_2, iter_10_3 in ipairs(var_0_1[arg_10_1]) do
					if arg_10_4 == BackHomeHeroSkillCfg[iter_10_3.skillID].param[1] or BackHomeHeroSkillCfg[iter_10_3.skillID].param[1] == 0 then
						var_10_1 = var_10_1 + BackHomeHeroSkillCfg[iter_10_3.skillID].param[2]
					end
				end
			end

			return var_10_1
		elseif arg_10_1 == CanteenConst.HeroSkillType.FatigueRecuse then
			local var_10_2 = 100

			if var_0_1[arg_10_1] and #var_0_1[arg_10_1] > 0 then
				for iter_10_4, iter_10_5 in ipairs(var_0_1[arg_10_1]) do
					if arg_10_2 == iter_10_5.id then
						var_10_2 = var_10_2 - BackHomeHeroSkillCfg[iter_10_5.skillID].param[1]
					end
				end
			end

			return var_10_2
		elseif arg_10_1 == CanteenConst.HeroSkillType.PopularRise then
			local var_10_3 = 0

			if var_0_1[arg_10_1] and #var_0_1[arg_10_1] > 0 then
				for iter_10_6, iter_10_7 in ipairs(var_0_1[arg_10_1]) do
					var_10_3 = var_10_3 + BackHomeHeroSkillCfg[iter_10_7.skillID].param[1]
				end
			end

			return var_10_3
		elseif arg_10_1 == CanteenConst.HeroSkillType.FatigueRecoverSelfFast then
			local var_10_4 = 0

			if var_0_1[arg_10_1] and #var_0_1[arg_10_1] > 0 then
				for iter_10_8, iter_10_9 in ipairs(var_0_1[arg_10_1]) do
					if arg_10_2 == iter_10_9.id then
						var_10_4 = var_10_4 + BackHomeHeroSkillCfg[iter_10_9.skillID].param[1]
					end
				end
			end

			return var_10_4
		elseif arg_10_1 == CanteenConst.HeroSkillType.FatigueRecoverAllFast then
			local var_10_5 = 0

			if var_0_1[arg_10_1] and #var_0_1[arg_10_1] > 0 then
				for iter_10_10, iter_10_11 in ipairs(var_0_1[arg_10_1]) do
					var_10_5 = var_10_5 + BackHomeHeroSkillCfg[iter_10_11.skillID].param[1]
				end
			end

			return var_10_5
		elseif arg_10_1 == CanteenConst.HeroSkillType.EntrustFatigueSelfReduce then
			local var_10_6 = 100

			if var_0_1[arg_10_1] and #var_0_1[arg_10_1] > 0 then
				for iter_10_12, iter_10_13 in ipairs(var_0_1[arg_10_1]) do
					if arg_10_2 == iter_10_13.id then
						var_10_6 = var_10_6 - BackHomeHeroSkillCfg[iter_10_13.skillID].param[1]
					end
				end
			end

			return var_10_6
		elseif arg_10_1 == CanteenConst.HeroSkillType.EntrustExternSucceedAdd then
			local var_10_7 = 0

			if var_0_1[arg_10_1] and #var_0_1[arg_10_1] > 0 then
				for iter_10_14, iter_10_15 in ipairs(var_0_1[arg_10_1]) do
					if arg_10_2 == iter_10_15.id then
						var_10_7 = var_10_7 + BackHomeHeroSkillCfg[iter_10_15.skillID].param[1]
					end
				end
			end

			return var_10_7
		elseif arg_10_1 == CanteenConst.HeroSkillType.EntrustExternAwardAdd then
			local var_10_8 = CanteenEntrustData:GetEntrustByPos(arg_10_3).hero_list
			local var_10_9 = 100

			if var_0_1[arg_10_1] and #var_0_1[arg_10_1] > 0 then
				for iter_10_16, iter_10_17 in ipairs(var_0_1[arg_10_1]) do
					for iter_10_18, iter_10_19 in ipairs(var_10_8) do
						if iter_10_19 == iter_10_17.id then
							var_10_9 = var_10_9 + BackHomeHeroSkillCfg[iter_10_17.skillID].param[1]
						end
					end
				end
			end

			return var_10_9
		elseif arg_10_1 == CanteenConst.HeroSkillType.EntrustTotalFatigueReduce then
			local var_10_10 = 0

			if var_0_1[arg_10_1] and #var_0_1[arg_10_1] > 0 then
				for iter_10_20, iter_10_21 in ipairs(var_0_1[arg_10_1]) do
					if arg_10_2 == iter_10_21.id then
						var_10_10 = var_10_10 + BackHomeHeroSkillCfg[iter_10_21.skillID].param[1]
					end
				end
			end

			return var_10_10
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

function var_0_0:UpdataAllFurSkill()
	local var_13_0 = CanteenData:GetFurInfoList()

	if var_13_0 then
		for iter_13_0, iter_13_1 in pairs(var_13_0) do
			for iter_13_2, iter_13_3 in ipairs(BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[iter_13_0].type_id].skill[iter_13_1.level]) do
				if self:CheckSkillIsOpen(iter_13_0, iter_13_3, DormEnum.EntityType.Furniture) and not self:CheckSkillIsRun(iter_13_0, iter_13_3, DormEnum.EntityType.Furniture) then
					self:AddSkillComponent(iter_13_0, iter_13_3, DormEnum.EntityType.Furniture)
				end
			end
		end
	end
end

function var_0_0:GetSkillDesc(arg_14_1)
	local var_14_0 = ""
	local var_14_1 = self:GetSkillEffectDesc(arg_14_1)

	if BackHomeHeroSkillCfg[arg_14_1].condition[1] == 1 then
		var_14_0 = string.format(GetI18NText(BackHomeHeroSkillCfg[arg_14_1].desc), (CanteenTools:GetJobName(BackHomeHeroSkillCfg[arg_14_1].condition[2])))
	elseif BackHomeHeroSkillCfg[arg_14_1].condition[1] == 2 then
		var_14_0 = string.format(GetI18NText(BackHomeHeroSkillCfg[arg_14_1].desc), (GetTips("DORM_LOBBY_NAME")))
	elseif BackHomeHeroSkillCfg[arg_14_1].condition[1] == 3 then
		var_14_0 = string.format(GetI18NText(BackHomeHeroSkillCfg[arg_14_1].desc), GetTips("DORM_CANTEEN_TASK_NAME"))
	end

	return var_14_0 .. var_14_1
end

function var_0_0.GetSkillEffectDesc(arg_15_0, arg_15_1)
	local var_15_0 = ""
	local var_15_1 = ""

	if BackHomeHeroSkillCfg[arg_15_1].param[2] then
		var_15_0 = string.format(GetI18NText(BackHomeHeroSkillDescCfg[BackHomeHeroSkillCfg[arg_15_1].type].desc), tostring((CanteenTools:GetFootTypeName(BackHomeHeroSkillCfg[arg_15_1].param[1]))))
		var_15_1 = BackHomeHeroSkillCfg[arg_15_1].param[2] >= 0 and string.format(GetI18NText(BackHomeHeroSkillDescCfg[BackHomeHeroSkillCfg[arg_15_1].type].pos_desc), tostring(BackHomeHeroSkillCfg[arg_15_1].param[2])) or string.format(GetI18NText(BackHomeHeroSkillDescCfg[BackHomeHeroSkillCfg[arg_15_1].type].neg_desc), tostring(-BackHomeHeroSkillCfg[arg_15_1].param[2]))
	else
		var_15_0 = string.format(GetI18NText(BackHomeHeroSkillDescCfg[BackHomeHeroSkillCfg[arg_15_1].type].desc))
		var_15_1 = BackHomeHeroSkillCfg[arg_15_1].param[1] >= 0 and string.format(GetI18NText(BackHomeHeroSkillDescCfg[BackHomeHeroSkillCfg[arg_15_1].type].pos_desc), tostring(BackHomeHeroSkillCfg[arg_15_1].param[1])) or string.format(GetI18NText(BackHomeHeroSkillDescCfg[BackHomeHeroSkillCfg[arg_15_1].type].neg_desc), tostring(-BackHomeHeroSkillCfg[arg_15_1].param[1]))
	end

	return var_15_0 .. var_15_1
end

function var_0_0.GetCookCanUnlockFoodList(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {}

	if BackHomeFurniture[arg_16_1] then
		for iter_16_0, iter_16_1 in ipairs(BackHomeCanteenFoodCfg.all) do
			if BackHomeCanteenFoodCfg[iter_16_1].cook_type == BackHomeFurniture[arg_16_1].type then
				if BackHomeCanteenFoodCfg[iter_16_1].unlock > 0 then
					if ConditionCfg[BackHomeCanteenFoodCfg[iter_16_1].unlock].type == CanteenConst.UnLockCon.CookLevel and arg_16_2 >= ConditionCfg[BackHomeCanteenFoodCfg[iter_16_1].unlock].params[2] then
						table.insert(var_16_0, iter_16_1)
					end
				else
					table.insert(var_16_0, iter_16_1)
				end
			end
		end
	end

	return var_16_0
end

function var_0_0.CheckSkillCanOpen(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = {}

	if DormNpcTools:CheckIDIsNpc(arg_17_2) then
		for iter_17_0 = 1, #BackHomeNpcCfg[arg_17_2].skill_list do
			table.insert(var_17_0, BackHomeNpcCfg[arg_17_2].skill_list[iter_17_0])
		end
	else
		local var_17_1 = BackHomeHeroCfg[arg_17_2].skill_list
		local var_17_2 = HeroData:GetHeroData(arg_17_2).level

		for iter_17_1 = 1, #BackHomeHeroCfg[arg_17_2].skill_list do
			if var_17_2 >= GameSetting.dorm_hero_skill_unlock.value[iter_17_1] then
				table.insert(var_17_0, var_17_1[iter_17_1])
			end
		end
	end

	local var_17_3 = {}

	for iter_17_2, iter_17_3 in ipairs(var_17_0) do
		if BackHomeHeroSkillCfg[iter_17_3].condition and #BackHomeHeroSkillCfg[iter_17_3].condition > 0 then
			if BackHomeHeroSkillCfg[iter_17_3].condition[1] == 1 and arg_17_1 == BackHomeHeroSkillCfg[iter_17_3].condition[2] then
				table.insert(var_17_3, iter_17_3)
			end
		else
			table.insert(var_17_3, iter_17_3)
		end
	end

	return var_17_3
end

function var_0_0.Dispose(arg_18_0)
	var_0_1 = nil
end

return var_0_0
