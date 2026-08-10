return {
	CheckRelationUpgradeCondition = function(arg_1_0, arg_1_1)
		local var_1_0 = HeroRelationUpgradeConditionCfg[arg_1_0]

		if not var_1_0 then
			return false
		end

		if var_1_0.type == 1 then
			for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
				local var_1_1 = HeroData:GetHeroData(iter_1_1)

				if var_1_1.level >= var_1_0.arg[1] and var_1_1.unlock == 1 then
					return true
				end
			end

			return false
		elseif var_1_0.type == 2 then
			for iter_1_2, iter_1_3 in ipairs(arg_1_1) do
				local var_1_2 = HeroData:GetHeroData(iter_1_3)
				local var_1_3 = 0

				if var_1_2.unlock == 1 then
					for iter_1_4, iter_1_5 in ipairs(var_1_2.skill) do
						if SkillTools.GetIsDodgeSkill(iter_1_5.skill_id) then
							var_1_3 = var_1_3 + 1
						else
							var_1_3 = var_1_3 + HeroTools.GetTotalSkillLv(iter_1_3, iter_1_5.skill_id)
						end
					end

					if var_1_3 >= var_1_0.arg[1] then
						return true
					end
				end
			end

			return false
		elseif var_1_0.type == 3 then
			for iter_1_6, iter_1_7 in ipairs(arg_1_1) do
				local var_1_4 = HeroData:GetHeroData(iter_1_7)

				if var_1_4.weapon_info.level >= var_1_0.arg[1] and var_1_4.unlock == 1 then
					return true
				end
			end

			return false
		elseif var_1_0.type == 4 then
			for iter_1_8, iter_1_9 in ipairs(arg_1_1) do
				local var_1_5 = HeroData:GetHeroData(iter_1_9)

				if var_1_5.star >= var_1_0.arg[1] and var_1_5.unlock == 1 then
					return true
				end
			end

			return false
		elseif var_1_0.type == 5 then
			for iter_1_10, iter_1_11 in ipairs(arg_1_1) do
				if HeroTools.GetHeroProficiency(iter_1_11) >= var_1_0.arg[1] then
					return true
				end
			end

			return false
		elseif var_1_0.type == 6 then
			for iter_1_12, iter_1_13 in ipairs(arg_1_1) do
				local var_1_6 = HeroData:GetHeroData(iter_1_13)

				if var_1_6 and var_1_6.unlock == 1 then
					local var_1_7 = 0

					for iter_1_14, iter_1_15 in ipairs(var_1_6.transition) do
						var_1_7 = var_1_7 + iter_1_15.talent_points
					end

					if var_1_7 >= var_1_0.arg[1] then
						return true
					end
				end
			end
		else
			return false
		end
	end,
	GetRelationUpgradeConditionDes = function(arg_2_0)
		local var_2_0 = HeroRelationUpgradeConditionCfg[arg_2_0]

		if not var_2_0 then
			return ""
		end

		if var_2_0.type == 1 then
			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_1", var_2_0.arg[1])
		elseif var_2_0.type == 2 then
			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_2", var_2_0.arg[1])
		elseif var_2_0.type == 3 then
			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_3", var_2_0.arg[1])
		elseif var_2_0.type == 4 then
			local var_2_1 = var_2_0.arg[1]
			local var_2_2 = var_2_1

			if var_2_1 == 100 then
				var_2_2 = "B"
			elseif var_2_1 == 200 then
				var_2_2 = "A"
			elseif var_2_1 == 300 then
				var_2_2 = "S"
			elseif var_2_1 == 400 then
				var_2_2 = "SS"
			elseif var_2_1 == 500 then
				var_2_2 = "SSS"
			elseif var_2_1 == 600 then
				var_2_2 = "Ω"
			end

			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_4", var_2_2)
		elseif var_2_0.type == 5 then
			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_5", var_2_0.arg[1])
		elseif var_2_0.type == 6 then
			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_6", var_2_0.arg[1])
		else
			return ""
		end
	end,
	GetTrustLvDes = function(arg_3_0)
		return GetTips("HERO_TRUST_LEVEL_DES_" .. arg_3_0)
	end,
	GetLikeLvDes = function(arg_4_0)
		return GetTips("HERO_LIKE_LEVEL_DES_" .. arg_4_0)
	end,
	GetRelationConfig = function(arg_5_0, arg_5_1)
		for iter_5_0, iter_5_1 in ipairs(HeroRelationCfg.get_id_list_by_main_hero_id[arg_5_0]) do
			local var_5_0 = HeroRelationCfg[iter_5_1]

			if arg_5_1 == var_5_0.relate_hero_id then
				return var_5_0
			end
		end

		return nil
	end,
	CheckWallPaperIsUnlock = function(arg_6_0)
		if arg_6_0.type == 1 then
			return HeroData:GetHeroData(arg_6_0.id).unlock == 1
		elseif arg_6_0.type == 2 then
			return HeroTools.GetHasOwnedSkin(arg_6_0.id)
		elseif arg_6_0.type == 3 then
			return IllustratedData:GetIllustrationInfo()[arg_6_0.id] ~= nil
		end
	end,
	NeedShowArchivePop = function()
		local var_7_0 = getData("archivePop", "cache") or 0

		if manager.time:IsToday(var_7_0) then
			return false, 0, 0
		end

		local var_7_1 = HeroData:GetHeroList()
		local var_7_2
		local var_7_3

		for iter_7_0, iter_7_1 in pairs(var_7_1) do
			local var_7_4 = HeroRecordCfg.get_id_list_by_hero_id[iter_7_1.id][1]

			if #HeroRecordCfg[var_7_4].super_plot_id > 0 then
				local var_7_5 = ArchiveData:GetHasViewedSuperHeartList(var_7_4)
				local var_7_6 = GameSetting.hero_super_plot_unlock_condition.value[2]
				local var_7_7, var_7_8, var_7_9 = IsConditionAchieved(var_7_6, {
					heroId = iter_7_1.id
				})

				if var_7_7 and #var_7_5 < 2 and not getData("archivePop", "popInfo" .. var_7_4 .. 2) then
					local var_7_10 = iter_7_1.id
					local var_7_11 = 2

					return true, var_7_10, var_7_11
				end
			end
		end

		for iter_7_2, iter_7_3 in pairs(var_7_1) do
			local var_7_12 = HeroRecordCfg.get_id_list_by_hero_id[iter_7_3.id][1]

			if #HeroRecordCfg[var_7_12].plot_id > 0 then
				local var_7_13 = ArchiveData:GetHasViewedHeartList(var_7_12)
				local var_7_14 = ArchiveData:GetArchive(var_7_12).lv

				if var_7_14 == 5 and #var_7_13 < var_7_14 - 1 and not getData("archivePop", "popInfo" .. var_7_12 .. 1) then
					local var_7_15 = iter_7_3.id
					local var_7_16 = 1

					return true, var_7_15, var_7_16
				end
			end
		end

		return false, 0, 0
	end
}
