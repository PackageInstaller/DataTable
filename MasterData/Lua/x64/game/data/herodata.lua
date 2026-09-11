local var_0_0 = singletonClass("HeroData", BaseHeroViewData)
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = false
local var_0_5 = true
local var_0_6 = 0
local var_0_7 = {}
local var_0_8 = {}
local var_0_9 = {}
local var_0_10 = {}
local var_0_11 = {}

function var_0_0:InitHero(arg_1_1, arg_1_2)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}

	self:ResetSortValue()

	var_0_10 = {}
	var_0_11 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2) do
		var_0_11[iter_1_1.id] = iter_1_1.num
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_1) do
		local var_1_0 = DefalutHeroDataTemplate.New(iter_1_3.hero_base_info.id)

		var_1_0:Init(iter_1_3)

		var_1_0.piece = var_0_11[iter_1_3.hero_base_info.id or 0]
		var_0_10[iter_1_3.hero_base_info.id] = var_1_0
	end

	for iter_1_4, iter_1_5 in ipairs(HeroCfg.get_id_list_by_private[0]) do
		var_0_1[iter_1_5] = var_0_10[iter_1_5] and var_0_10[iter_1_5] or DefalutHeroDataTemplate.New(iter_1_5)
		var_0_1[iter_1_5].piece = var_0_11[iter_1_5] or 0

		for iter_1_6, iter_1_7 in ipairs(var_0_1[iter_1_5]:GetEquipInfoList()) do
			if iter_1_7.equip_id ~= 0 then
				var_0_2[iter_1_7.equip_id] = iter_1_5
			end
		end
	end

	manager.notify:Invoke(HERO_DATA_INIT)
	HeroTools.DispatchAllHeroNewRed("unlockHero", RedPointConst.HERO_ID)
	HeroTools.DispatchAllHeroNewRed("unlockRelation", RedPointConst.HERO_REALTION .. "_")
	HeroTools.DispatchAllHeroNewRed("unlockSkin", RedPointConst.HERO_SKIN_ID)
end

function var_0_0.ModifyHero(arg_2_0, arg_2_1)
	var_0_1[arg_2_1.hero_base_info.id]:ModifyHero(arg_2_1)

	var_0_1[arg_2_1.hero_base_info.id].piece = var_0_11[arg_2_1.hero_base_info.id] or 0

	manager.notify:Invoke(HERO_DATA_MODIFY, arg_2_1.hero_base_info.id)
end

function var_0_0.ModifyHeroPieceByList(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		var_0_1[iter_3_1.id].piece = iter_3_1.num
		var_0_11[iter_3_1.id] = iter_3_1.num
	end

	manager.notify:Invoke(HERO_DATA_INIT)
end

function var_0_0.HeroPieceModify(arg_4_0, arg_4_1, arg_4_2)
	var_0_11[arg_4_1] = arg_4_2
	var_0_1[arg_4_1].piece = arg_4_2

	manager.notify:Invoke(HERO_PIECE_MODIFY, arg_4_1)
end

function var_0_0:AddHeroExpSuccess(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = self:GetHeroData(arg_5_1)

	var_5_0.level = arg_5_2
	var_5_0.exp = arg_5_3

	manager.notify:Invoke(HERO_DATA_MODIFY, arg_5_1)
end

function var_0_0:BreakSuccess(arg_6_1, arg_6_2)
	self:GetHeroData(arg_6_1).break_level = arg_6_2

	manager.notify:Invoke(HERO_DATA_MODIFY, arg_6_1)
end

function var_0_0:UnlockHeroSuccess(arg_7_1)
	self:GetHeroData(arg_7_1).unlock = 1

	HeroTools.SetHeroNewTagRed(arg_7_1, "unlockHero", RedPointConst.HERO_ID .. arg_7_1, true)
	DormRedPointTools:SetIlluHeroNewTagRed("heroNew", RedPointConst.DORM_ILLU_HERO, true)
	manager.notify:Invoke(HERO_DATA_MODIFY, arg_7_1)
	manager.notify:Invoke(HERO_UNLOCK_SUCCESS, arg_7_1)
end

function var_0_0:HeroClearTimesModify(arg_8_1, arg_8_2)
	local var_8_0 = self:GetHeroData(arg_8_1)

	if var_8_0 == nil then
		return
	end

	var_8_0.clear_times = (var_8_0.clear_times or 0) + arg_8_2
end

function var_0_0.EquipSwap(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1 ~= 0 then
		local var_9_0 = var_0_1[arg_9_1]:GetEquipInfoList()[arg_9_3].equip_id

		if var_0_2[arg_9_2] and var_0_2[arg_9_2] ~= 0 then
			var_0_1[var_0_2[arg_9_2]]:GetEquipInfoList()[arg_9_3].equip_id = var_9_0

			if var_9_0 and var_9_0 ~= 0 then
				var_0_2[var_9_0] = var_0_2[arg_9_2]
			end
		else
			var_0_2[var_9_0] = nil
		end

		var_0_1[arg_9_1]:GetEquipInfoList()[arg_9_3].equip_id = arg_9_2

		if arg_9_2 ~= 0 then
			var_0_2[arg_9_2] = arg_9_1
		end

		manager.notify:Invoke(HERO_DATA_MODIFY, arg_9_1)
	end
end

function var_0_0.EquipUnloadAll(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(var_0_1[arg_10_1]:GetEquipInfoList()) do
		if iter_10_1.equip_id ~= 0 then
			var_0_2[iter_10_1.equip_id] = nil
			iter_10_1.equip_id = 0
		end
	end

	manager.notify:Invoke(HERO_DATA_MODIFY, arg_10_1)
end

function var_0_0.AstrolabeUnlock(arg_11_0, arg_11_1, arg_11_2)
	if not table.keyof(var_0_1[arg_11_1].unlocked_astrolabe, arg_11_2) then
		table.insert(var_0_1[arg_11_1].unlocked_astrolabe, arg_11_2)
	end
end

function var_0_0.AstrolabeEquip(arg_12_0, arg_12_1, arg_12_2)
	if not table.keyof(var_0_1[arg_12_1].using_astrolabe, arg_12_2) then
		table.insert(var_0_1[arg_12_1].using_astrolabe, arg_12_2)
	end

	manager.notify:Invoke(HERO_DATA_MODIFY, arg_12_1)
end

function var_0_0.AstrolabeEquipAll(arg_13_0, arg_13_1, arg_13_2)
	var_0_1[arg_13_1].using_astrolabe = deepClone(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[arg_13_2])

	manager.notify:Invoke(HERO_DATA_MODIFY, arg_13_1)
end

function var_0_0.AstrolabeEquipByList(arg_14_0, arg_14_1, arg_14_2)
	var_0_1[arg_14_1].using_astrolabe = arg_14_2

	manager.notify:Invoke(HERO_DATA_MODIFY, arg_14_1)
end

function var_0_0.AstrolabeUnload(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = table.keyof(var_0_1[arg_15_1].using_astrolabe, arg_15_2)

	if var_15_0 then
		table.remove(var_0_1[arg_15_1].using_astrolabe, var_15_0)
		var_0_0:AstrolabeUnload(arg_15_1, arg_15_2 + 1)
		manager.notify:Invoke(HERO_DATA_MODIFY, arg_15_1)
	end
end

function var_0_0.AstrolabeUnloadAll(arg_16_0, arg_16_1)
	var_0_1[arg_16_1].using_astrolabe = {}

	manager.notify:Invoke(HERO_DATA_MODIFY, arg_16_1)
end

function var_0_0.WeaponStr(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	var_0_1[arg_17_1]:GetWeaponInfo().level = arg_17_2
	var_0_1[arg_17_1]:GetWeaponInfo().exp = arg_17_3

	manager.notify:Invoke(HERO_DATA_MODIFY, arg_17_1)
end

function var_0_0.WeaponBreak(arg_18_0, arg_18_1, arg_18_2)
	var_0_1[arg_18_1]:GetWeaponInfo().breakthrough = arg_18_2

	manager.notify:Invoke(HERO_DATA_MODIFY, arg_18_1)
end

function var_0_0.ServantReplace(arg_19_0, arg_19_1, arg_19_2)
	var_0_1[arg_19_1].servant_uid = arg_19_2

	manager.notify:Invoke(HERO_DATA_MODIFY, arg_19_1)
end

function var_0_0:HeroSkillUpgrade(arg_20_1, arg_20_2, arg_20_3)
	for iter_20_0, iter_20_1 in ipairs(self:GetHeroData(arg_20_1):GetSkillInfoList()) do
		if iter_20_1.skill_id == arg_20_2 then
			iter_20_1.skill_level = iter_20_1.skill_level + (arg_20_3 or 1)

			break
		end
	end
end

function var_0_0:HeroSkillAttrUpgrade(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = self:GetHeroData(arg_21_1)

	for iter_21_0, iter_21_1 in ipairs(var_21_0:GetSkillAttrList()) do
		if iter_21_1.index == arg_21_2 then
			iter_21_1.level = iter_21_1.level + (arg_21_3 or 1)

			manager.notify:Invoke(HERO_DATA_MODIFY, arg_21_1)

			return
		end
	end

	table.insert(var_21_0:GetSkillAttrList(), {
		index = arg_21_2,
		level = arg_21_3
	})
	manager.notify:Invoke(HERO_DATA_MODIFY, arg_21_1)
end

function var_0_0:HeroStarUp(arg_22_1)
	local var_22_0 = self:GetHeroData(arg_22_1)

	var_0_11[arg_22_1] = var_22_0.piece

	local var_22_1, var_22_2 = HeroTools.GetNextStarAndPhase(HeroStarCfg[var_22_0.star].star, HeroStarCfg[var_22_0.star].phase)

	var_22_0.star = HeroTools.GetStarCfgId(var_22_1, var_22_2)

	manager.notify:Invoke(HERO_DATA_MODIFY, arg_22_1)
end

function var_0_0:SelectSkin(arg_23_1, arg_23_2)
	if HeroCfg[arg_23_1].private == 0 then
		self:GetHeroData(arg_23_1).using_skin = arg_23_2
	elseif HeroCfg[arg_23_1].private == 1 then
		if arg_23_1 == 1001 then
			self:GetTempServerHeroDataList()[arg_23_1].using_skin = arg_23_2 == 0 and arg_23_1 or arg_23_2
		end
	end
end

function var_0_0.GetHeroListExcept(arg_24_0, arg_24_1)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs(var_0_1) do
		if table.indexof(arg_24_1, iter_24_0) then
			-- block empty
		else
			var_24_0[iter_24_0] = iter_24_1
		end
	end

	return var_24_0
end

function var_0_0.GetHeroList(arg_25_0)
	return var_0_1
end

function var_0_0.GetTempServerHeroDataList(arg_26_0)
	return var_0_10
end

function var_0_0.GetEquipMap(arg_27_0)
	return var_0_2
end

function var_0_0.GetHeroOmegaNeedPiece(arg_28_0, arg_28_1)
	local var_28_0 = HeroData:GetHeroData(arg_28_1)
	local var_28_1 = 0

	for iter_28_0 = table.keyof(HeroStarCfg.all, (HeroTools.GetStarCfgId(HeroStarCfg[var_28_0.star].star, HeroStarCfg[var_28_0.star].phase))), #HeroStarCfg.all do
		var_28_1 = var_28_1 + HeroStarCfg[HeroStarCfg.all[iter_28_0]].star_up
	end

	if var_28_0.unlock == 1 then
		return math.max(0, var_28_1 - var_28_0.piece)
	else
		return GameSetting.unlock_hero_need.value[HeroCfg[arg_28_1].rare] + var_28_1
	end
end

function var_0_0.GetHeroNextSurpassNeedPiece(arg_29_0, arg_29_1)
	local var_29_0 = HeroData:GetHeroData(arg_29_1)
	local var_29_1 = var_29_0.unlock == 1 and 0 or GameSetting.unlock_hero_need.value[HeroCfg[arg_29_1].rare]
	local var_29_2 = HeroStarCfg[var_29_0.star].star
	local var_29_3 = HeroStarCfg[var_29_0.star].star

	for iter_29_0 = table.keyof(HeroStarCfg.all, (HeroTools.GetStarCfgId(HeroStarCfg[var_29_0.star].star, HeroStarCfg[var_29_0.star].phase))), #HeroStarCfg.all do
		if var_29_2 < HeroStarCfg[HeroStarCfg.all[iter_29_0]].star then
			var_29_3 = HeroStarCfg[HeroStarCfg.all[iter_29_0]].star

			break
		end

		var_29_1 = var_29_1 + HeroStarCfg[HeroStarCfg.all[iter_29_0]].star_up
	end

	return math.max(0, var_29_1 - var_29_0.piece), var_29_3
end

function var_0_0.GetHeroNum(arg_30_0)
	local var_30_0 = 0

	for iter_30_0, iter_30_1 in pairs(var_0_1) do
		if iter_30_1.unlock == 1 then
			var_30_0 = var_30_0 + 1
		end
	end

	return var_30_0
end

function var_0_0.GetUnlockHeros(arg_31_0)
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in pairs(var_0_1) do
		if iter_31_1.unlock == 1 then
			table.insert(var_31_0, iter_31_1.id)
		end
	end

	return var_31_0
end

function var_0_0.InitFavorite(arg_32_0, arg_32_1)
	var_0_3 = arg_32_1 or {}
end

function var_0_0.IsFavorite(arg_33_0, arg_33_1)
	return table.indexof(var_0_3, arg_33_1)
end

function var_0_0.SetFavoriteHeroOn(arg_34_0, arg_34_1)
	if not table.indexof(var_0_3, arg_34_1) then
		table.insert(var_0_3, arg_34_1)
	end
end

function var_0_0.SetFavoriteHeroOff(arg_35_0, arg_35_1)
	local var_35_0 = table.indexof(var_0_3, arg_35_1)

	if var_35_0 then
		table.remove(var_0_3, var_35_0)
	end
end

function var_0_0.SaveSortValue(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5)
	var_0_5 = arg_36_1 == nil and true or arg_36_1
	var_0_6 = arg_36_2 or 0
	var_0_7 = arg_36_3 or {}
	var_0_8 = arg_36_4 or {}
	var_0_9 = arg_36_5 or {}
end

function var_0_0.SaveSortType(arg_37_0, arg_37_1)
	var_0_6 = arg_37_1 or 0
end

function var_0_0.GetSortValue(arg_38_0)
	return var_0_5, var_0_6, var_0_7, var_0_8, var_0_9
end

function var_0_0.ResetSortValue(arg_39_0)
	var_0_5 = true
	var_0_6 = 0
	var_0_7 = {}
	var_0_8 = {}
	var_0_9 = {}
end

function var_0_0:ImproveTransitionGiftPt(arg_40_1)
	local var_40_0 = self:GetHeroTransitionSkillBySlotID(arg_40_1.hero_id, arg_40_1.slot_id)

	if var_40_0 then
		var_40_0.talent_points = var_40_0.talent_points + arg_40_1.lv_up_num
	else
		table.insert(var_0_1[arg_40_1.hero_id]:GetTransitionInfoList(), {
			slot_id = arg_40_1.slot_id,
			skill_list = {},
			talent_points = arg_40_1.lv_up_num
		})
	end
end

local function var_0_12(arg_41_0, arg_41_1)
	arg_41_0 = arg_41_0 or 0
	arg_41_1 = arg_41_1 or 0

	return arg_41_0 ~= arg_41_1
end

local function var_0_13(arg_42_0, arg_42_1)
	if #arg_42_0 ~= #arg_42_1 then
		return true
	end

	for iter_42_0, iter_42_1 in ipairs(arg_42_0) do
		if var_0_12(iter_42_1.skill_id, arg_42_1[iter_42_0].skill_id) or iter_42_1.skill_level ~= arg_42_1[iter_42_0].skill_level then
			return true
		end
	end

	return false
end

function var_0_0:ModifyTransitionSkill(arg_43_1)
	local var_43_0 = self:GetHeroTransitionSkillBySlotID(arg_43_1.hero_id, arg_43_1.slot_id)

	if var_43_0 then
		var_43_0.skill_list = cleanProtoTable(arg_43_1.skill_list)

		manager.notify:Invoke(HERO_TRANSITION_CHANGE, {
			heroId = arg_43_1.hero_id
		}, (var_0_13(var_43_0.skill_list, arg_43_1.skill_list)))
	end
end

function var_0_0.GetHeroTransitionSkillBySlotID(arg_44_0, arg_44_1, arg_44_2)
	for iter_44_0, iter_44_1 in ipairs(var_0_1[arg_44_1]:GetTransitionInfoList()) do
		if iter_44_1.slot_id == arg_44_2 then
			return iter_44_1
		end
	end

	return false
end

function var_0_0.GetCurModuleLevel(arg_45_0, arg_45_1)
	return (var_0_1[arg_45_1] or nil) and (var_0_1[arg_45_1].moduleLevel or 0)
end

function var_0_0.GetModuleMaxLevel(arg_46_0, arg_46_1)
	return #WeaponModuleCfg[arg_46_1].cost
end

function var_0_0.ModuleLevelUp(arg_47_0, arg_47_1)
	if var_0_1[arg_47_1] then
		var_0_1[arg_47_1].moduleLevel = var_0_1[arg_47_1].moduleLevel + 1
	end
end

function var_0_0.GetModuleAssignmentIsFinish(arg_48_0, arg_48_1)
	if var_0_1[arg_48_1] then
		if var_0_1[arg_48_1].moduleAssignment > 0 then
			return true
		else
			return false
		end
	end

	return false
end

function var_0_0:GetModulePowersByHeroID(arg_49_1)
	local var_49_0 = {}

	if WeaponModuleCfg[arg_49_1] then
		for iter_49_0 = 1, self:GetCurModuleLevel(arg_49_1) do
			for iter_49_1, iter_49_2 in pairs(WeaponModuleCfg[arg_49_1].skill[iter_49_0]) do
				table.insert(var_49_0, iter_49_2)
			end
		end
	end

	return var_49_0
end

function var_0_0:GetAllModulePowersByHeroID(arg_50_1)
	local var_50_0 = {}

	if WeaponModuleCfg[arg_50_1] then
		for iter_50_0 = 1, self:GetModuleMaxLevel(arg_50_1) do
			for iter_50_1, iter_50_2 in pairs(WeaponModuleCfg[arg_50_1].skill[iter_50_0]) do
				table.insert(var_50_0, iter_50_2)
			end
		end
	end

	return var_50_0
end

function var_0_0.GetCurModuleEffectListByType(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	local var_51_0 = {}

	for iter_51_0, iter_51_1 in pairs((HeroTools:GetModulePowersByHeroIDAndLevel(arg_51_1, arg_51_3))) do
		if WeaponModuleEffectCfg[iter_51_1].type == arg_51_2 then
			table.insert(var_51_0, iter_51_1)
		end
	end

	if var_51_0[1] then
		return var_51_0
	else
		return nil
	end
end

function var_0_0.GetLockModuleEffectListByType(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = {}

	for iter_52_0, iter_52_1 in pairs(WeaponModuleCfg[arg_52_1].skill[1]) do
		if WeaponModuleEffectCfg[iter_52_1].type == arg_52_2 then
			table.insert(var_52_0, iter_52_1)
		end
	end

	if var_52_0[1] then
		return var_52_0
	else
		return nil
	end
end

function var_0_0.UnlockTrust(arg_53_0, arg_53_1, arg_53_2)
	if var_0_1[arg_53_1] then
		var_0_1[arg_53_1].trust.level = 1
		var_0_1[arg_53_1].trust.exp = 0
		var_0_1[arg_53_1].trust.mood = arg_53_2
	end

	HeroAction.UpdateSuperStoryRedPoint()
	HeroTools.SetHeroNewTagRed(arg_53_1, "unlockRelation", table.concat({
		RedPointConst.HERO_REALTION,
		"_",
		arg_53_1
	}), true)
end

function var_0_0.UpgradeTrustLevel(arg_54_0, arg_54_1)
	if var_0_1[arg_54_1] then
		var_0_1[arg_54_1].trust.level = var_0_1[arg_54_1].trust.level + 1
		var_0_1[arg_54_1].trust.exp = 0
	end

	HeroAction.UpdateSuperStoryRedPoint()
	OathSupportData.UpdateOathCanCompleteNotice(arg_54_1)
end

function var_0_0.UnlockRelationNet(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	if var_0_1[arg_55_1] then
		var_0_1[arg_55_1].relation:UnlockRelationNet(arg_55_2, arg_55_3)
	end
end

function var_0_0.SetupHeroMainOpenStatus(arg_56_0, arg_56_1)
	var_0_4 = arg_56_1
end

function var_0_0.GetHeroMainOpenStatus(arg_57_0)
	return var_0_4
end

function var_0_0.SetHeroStrategyRedPoint(arg_58_0, arg_58_1)
	saveData("strategy", "strategy_" .. arg_58_1, "1")
end

function var_0_0.GetHeroStrategyRedPoint(arg_59_0, arg_59_1)
	return getData("strategy", "strategy_" .. arg_59_1) ~= "1" and BattleTeachData:GetHeroTeachInfo(arg_59_1, HeroCfg[arg_59_1].study_stage[1]) <= 0
end

function var_0_0.GetRecommendEquipSkill(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = {
		3,
		2,
		1
	}

	for iter_60_0 = 1, #HeroCfg[arg_60_1].recommend_equip_skill do
		if table.indexof(HeroCfg[arg_60_1].recommend_equip_skill[iter_60_0], arg_60_2) then
			return var_60_0[iter_60_0]
		end
	end
end

function var_0_0.SetBattleSkin(arg_61_0, arg_61_1, arg_61_2)
	if var_0_1[arg_61_1] then
		var_0_1[arg_61_1].battle_using_skin = arg_61_2
	end
end

function var_0_0.Init(arg_62_0)
	_G.heroViewPageIndex_ = 1
end

return var_0_0
