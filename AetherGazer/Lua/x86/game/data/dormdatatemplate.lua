DormHeroTemplate = class("DormDataTemplate")

function DormHeroTemplate.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = DormHeroTools:GetAllCanUseHeroIDInDorm(arg_1_1.archives_id)[1]

	if not arg_1_1.hero_id then
		if var_1_0 then
			arg_1_0.hero_id = var_1_0
		else
			print(debug.traceback("无可用人物,档案id为" .. arg_1_1.archives_id))

			return
		end
	else
		arg_1_0.hero_id = arg_1_1.hero_id
	end

	arg_1_0.fatigue = arg_1_1.fatigue or GameSetting.canteen_hero_fatigue_max.value[1]
	arg_1_0.feed_times = arg_1_1.feed_times or 0
	arg_1_0.archives_id = arg_1_1.archives_id
	arg_1_0.feedTotalTime = arg_1_1.totalFeedTime or 0
	arg_1_0.isLock = arg_1_1.isLock or 0

	arg_1_0:InitHeroSkinData(arg_1_1.skinID)
end

function DormHeroTemplate.InitHeroSkinData(arg_2_0, arg_2_1)
	arg_2_0.skinInfo = {}

	local var_2_0 = arg_2_0:GetCanUseHeroList()

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		arg_2_0.skinInfo[iter_2_1] = iter_2_1
	end

	if arg_2_1 then
		for iter_2_2, iter_2_3 in ipairs(arg_2_1) do
			local var_2_1 = iter_2_3.hero_id
			local var_2_2 = iter_2_3.skin_id

			if arg_2_0.skinInfo[var_2_1] then
				arg_2_0.skinInfo[var_2_1] = var_2_2
			else
				print("未找到对应角色")
			end
		end
	end
end

function DormHeroTemplate.InitHeroRoomID(arg_3_0, arg_3_1)
	arg_3_0.roomID = arg_3_1
end

function DormHeroTemplate.Dispose(arg_4_0)
	return
end

function DormHeroTemplate.GetHeroId(arg_5_0)
	if BackHomeHeroCfg[arg_5_0.hero_id] then
		return arg_5_0.hero_id
	else
		local var_5_0 = arg_5_0:GetCanUseHeroList()

		if #var_5_0 > 0 then
			return var_5_0[1]
		end
	end
end

function DormHeroTemplate.GetHeroTotalFeedTime(arg_6_0)
	return arg_6_0.feedTotalTime
end

function DormHeroTemplate.GetRoomID(arg_7_0)
	return arg_7_0.roomID
end

function DormHeroTemplate.SetCurHeroID(arg_8_0, arg_8_1)
	if arg_8_1 == nil then
		arg_8_0.hero_id = nil

		return
	end

	if arg_8_0.archives_id == DormData:GetHeroArchiveID(arg_8_1) then
		arg_8_0.hero_id = arg_8_1
	else
		print("传入角色id不是本档案角色")
	end
end

function DormHeroTemplate.GetHeroCurSkinID(arg_9_0, arg_9_1)
	if arg_9_0.skinInfo then
		if not arg_9_0.skinInfo[arg_9_1] and DormData:GetHeroArchiveID(arg_9_1) == arg_9_0.archives_id and BackHomeHeroCfg[arg_9_1] and HeroTools.GetHeroIsUnlock(arg_9_1) then
			arg_9_0.skinInfo[arg_9_1] = arg_9_1
		end

		if arg_9_0.skinInfo[arg_9_1] then
			return arg_9_0.skinInfo[arg_9_1]
		end
	end

	return arg_9_1
end

function DormHeroTemplate.SetHeroSkinID(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.skinInfo then
		arg_10_0.skinInfo[arg_10_1] = arg_10_2
	end
end

function DormHeroTemplate.GetCanUseHeroList(arg_11_0)
	return DormHeroTools:GetAllCanUseHeroIDInDorm(arg_11_0.archives_id) or {}
end

function DormHeroTemplate.GetFatigue(arg_12_0)
	return arg_12_0.fatigue
end

function DormHeroTemplate.SetFatigue(arg_13_0, arg_13_1)
	if arg_13_1 < 0 then
		print("设置体力越界")

		return
	end

	arg_13_0.fatigue = arg_13_1
end

function DormHeroTemplate.CalFatigue(arg_14_0, arg_14_1)
	arg_14_0.fatigue = arg_14_0.fatigue + arg_14_1

	if arg_14_0.fatigue < 0 then
		arg_14_0.fatigue = 0
	end
end

function DormHeroTemplate.UpdataHeroState(arg_15_0)
	local var_15_0 = GameSetting.dorm_canteen_work_fatigue.value[1] / 100

	if arg_15_0.fatigue < var_15_0 - var_15_0 % 0.1 and arg_15_0.jobType then
		arg_15_0.jobType = nil

		arg_15_0:BackToDorm()
	end
end

function DormHeroTemplate.GetRecoverFatigueNum(arg_16_0)
	local var_16_0 = arg_16_0:GetHeroState()
	local var_16_1 = 3600 / GameSetting.dorm_fatigue_time.value[1]

	if var_16_0 == DormEnum.DormHeroState.InCanteenEntrust or var_16_0 == DormEnum.DormHeroState.InCanteenJob then
		return 0
	elseif var_16_0 == DormEnum.DormHeroState.OutDorm then
		return GameSetting.dorm_base_fatigue_increase.value[1] / 100
	elseif var_16_0 == DormEnum.DormHeroState.InPublicDorm then
		local var_16_2 = GameSetting.dorm_lobby_fatigue_increase.value[1] / 100
		local var_16_3 = 0

		if arg_16_0.hero_id then
			var_16_3 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverSelfFast, arg_16_0.hero_id)
			var_16_3 = var_16_3 + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverAllFast, arg_16_0.hero_id)
		end

		return var_16_2 * ((100 + var_16_3) / 100) * var_16_1
	elseif var_16_0 == DormEnum.DormHeroState.InPrivateDorm then
		local var_16_4 = DormHeroTools:GetDormLevelByHeroID(arg_16_0.archives_id)
		local var_16_5 = GameSetting.dorm_fatigue_increase.value[var_16_4][2] / 100
		local var_16_6 = 0

		if arg_16_0.hero_id then
			var_16_6 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverSelfFast, arg_16_0.hero_id)
			var_16_6 = var_16_6 + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverAllFast, arg_16_0.hero_id)
		end

		return var_16_5 * ((100 + var_16_6) / 100) * var_16_1
	elseif var_16_0 == DormEnum.DormHeroState.InIdolTraineeCamp then
		if arg_16_0.roomID then
			local var_16_7 = DormHeroTools:GetDormLevelByHeroID(arg_16_0.archives_id)
			local var_16_8 = GameSetting.dorm_fatigue_increase.value[var_16_7][2] / 100
			local var_16_9 = 0

			if arg_16_0.hero_id then
				var_16_9 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverSelfFast, arg_16_0.hero_id)
				var_16_9 = var_16_9 + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverAllFast, arg_16_0.hero_id)
			end

			return var_16_8 * ((100 + var_16_9) / 100) * var_16_1
		else
			local var_16_10 = GameSetting.dorm_lobby_fatigue_increase.value[1] / 100
			local var_16_11 = 0

			if arg_16_0.hero_id then
				var_16_11 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverSelfFast, arg_16_0.hero_id)
				var_16_11 = var_16_11 + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverAllFast, arg_16_0.hero_id)
			end

			return var_16_10 * ((100 + var_16_11) / 100) * var_16_1
		end
	else
		return 0
	end

	print("人物处于未知状态")
end

function DormHeroTemplate.GetCurRoomID(arg_17_0)
	local var_17_0 = arg_17_0:GetHeroState()

	if var_17_0 == DormEnum.DormHeroState.InCanteenEntrust or var_17_0 == DormEnum.DormHeroState.InCanteenJob then
		return DormConst.CANTEEN_ID
	end

	if var_17_0 == DormEnum.DormHeroState.InPublicDorm then
		return DormConst.PUBLIC_DORM_ID
	elseif var_17_0 == DormEnum.DormHeroState.InPrivateDorm then
		return DormRoomTools:GetDormIDViaArchive(arg_17_0.archives_id)
	end

	return nil
end

function DormHeroTemplate.GetHeroTrueState(arg_18_0)
	local var_18_0 = DormRoomTools:GetDormIDViaArchive(arg_18_0.archives_id)

	if arg_18_0.dancePos then
		return DormEnum.DormHeroState.InIdolTraineeCamp
	end

	if CanteenEntrustData:CheckHasChooseEntrustCharacter(arg_18_0.archives_id) then
		return DormEnum.DormHeroState.InCanteenEntrust
	end

	if arg_18_0.jobType then
		return DormEnum.DormHeroState.InCanteenJob
	end

	local var_18_1 = DormConst.PUBLIC_DORM_ID

	if var_18_1 then
		local var_18_2 = DormData:GetDormSceneData(var_18_1)

		for iter_18_0, iter_18_1 in ipairs(var_18_2.archiveIDList) do
			if iter_18_1 == arg_18_0.archives_id then
				return DormEnum.DormHeroState.InPublicDorm
			end
		end

		if var_18_0 then
			return DormEnum.DormHeroState.InPrivateDorm
		end

		return DormEnum.DormHeroState.OutDorm
	end
end

function DormHeroTemplate.GetHeroTempState(arg_19_0)
	return arg_19_0.tempState
end

function DormHeroTemplate.GetHeroState(arg_20_0)
	return arg_20_0:GetHeroTempState() or arg_20_0:GetHeroTrueState()
end

function DormHeroTemplate.GetHeroFavorability(arg_21_0)
	return ArchiveData:GetArchive(arg_21_0.archives_id).lv
end

function DormHeroTemplate.GetGiftNum(arg_22_0, arg_22_1)
	local var_22_0 = DormRoomTools:GetDormIDViaArchive(arg_22_0.archives_id)
	local var_22_1 = DormitoryData:GetDormSceneData(var_22_0)

	if var_22_1 and var_22_1.give_furnitures then
		return var_22_1.give_furnitures[arg_22_1] or 0
	else
		return 0
	end
end

function DormHeroTemplate.GetCanGiftNum(arg_23_0, arg_23_1)
	local var_23_0 = 0

	if DormRoomTools:GetDormIDViaArchive(arg_23_0.archives_id) then
		local var_23_1 = arg_23_0:GetGiftNum(arg_23_1)
		local var_23_2 = DormData:GetFurNumInfo(arg_23_1).num
		local var_23_3 = DormData:GetFurNumInfo(arg_23_1).give_num
		local var_23_4 = BackHomeFurniture[arg_23_1].give_max

		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(arg_23_1) then
			var_23_4 = 1
		end

		var_23_0 = math.min(var_23_2 - var_23_3, var_23_4 - var_23_1)

		if var_23_0 < 0 then
			var_23_0 = 0
		end
	end

	return var_23_0
end

function DormHeroTemplate.GetCanBuyAndGiftNum(arg_24_0, arg_24_1)
	local var_24_0 = 0

	if DormRoomTools:GetDormIDViaArchive(arg_24_0.archives_id) then
		local var_24_1 = arg_24_0:GetGiftNum(arg_24_1)
		local var_24_2 = BackHomeFurniture[arg_24_1].give_max

		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(arg_24_1) then
			var_24_2 = 1
		end

		var_24_0 = math.min(var_24_2, var_24_2 - var_24_1)

		if var_24_0 < 0 then
			var_24_0 = 0
		end
	end

	return var_24_0
end

function DormHeroTemplate.CheckCanFeedFood(arg_25_0)
	if arg_25_0.feed_times >= GameSetting.dorm_feed_max.value[1] then
		return false, "feedTime"
	end

	if arg_25_0.fatigue > GameSetting.canteen_hero_fatigue_max.value[1] then
		return false, "fatigue"
	end

	if DormHeroTools:GetDormLevelByHeroID(arg_25_0.archives_id) < GameSetting.dorm_menu_feed_unlock.value[1] then
		return false, "unlock"
	end

	return true
end

function DormHeroTemplate.ResetFeedTime(arg_26_0)
	arg_26_0.feed_times = 0
end

local function var_0_0(arg_27_0)
	if type(arg_27_0) == "number" then
		return arg_27_0, 1
	else
		return arg_27_0[1], arg_27_0[2]
	end
end

function DormHeroTemplate.PickInteractAction(arg_28_0)
	if arg_28_0 and next(arg_28_0) then
		local var_28_0 = 0

		for iter_28_0, iter_28_1 in ipairs(arg_28_0) do
			local var_28_1, var_28_2 = var_0_0(iter_28_1)

			var_28_0 = var_28_0 + var_28_2
		end

		local var_28_3 = math.random() * var_28_0

		for iter_28_2, iter_28_3 in ipairs(arg_28_0) do
			local var_28_4, var_28_5 = var_0_0(iter_28_3)

			var_28_3 = var_28_3 - var_28_5

			if var_28_3 < 0 then
				return var_28_4
			end
		end
	end

	return nil
end

function DormHeroTemplate.FeedFood(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1 and not Dorm.DormEntityManager.TestDuringInteract(arg_29_1, true) then
		local var_29_0

		if arg_29_2 then
			Dorm.DormEntityManager.SendInteractToEntityCMD(arg_29_1, arg_29_1, arg_29_2, false)

			local var_29_1 = DormInteractSequence[arg_29_2].name
			local var_29_2 = DormCharacterInteractBehaviour.GetSequence(arg_29_1, nil, var_29_1)

			if var_29_2 then
				var_29_0 = var_29_2.duration
			end
		end

		DormUtils.ClearSingleSpecialVfx(arg_29_1, DormEnum.SpecialVfx.Hungry)

		return var_29_0
	end
end

function DormHeroTemplate.FeedFoodTime(arg_30_0, arg_30_1)
	arg_30_0.feed_times = arg_30_0.feed_times + arg_30_1
	arg_30_0.feedTotalTime = arg_30_0.feedTotalTime + arg_30_1
end

function DormHeroTemplate.GiftFur(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_1 and arg_31_2 then
		local var_31_0 = DormRoomTools:GetDormIDViaArchive(arg_31_0.archives_id)
		local var_31_1 = DormData:GetDormSceneData(var_31_0)

		if not var_31_1.give_furnitures then
			var_31_1.give_furnitures = {}
		end

		if not var_31_1.give_furnitures[arg_31_1] then
			var_31_1.give_furnitures[arg_31_1] = 0
		end

		var_31_1.give_furnitures[arg_31_1] = var_31_1.give_furnitures[arg_31_1] + arg_31_2

		local var_31_2 = DormData:GetFurnitureInfoList()

		var_31_2[arg_31_1].give_num = var_31_2[arg_31_1].give_num + arg_31_2

		if var_31_2[arg_31_1].give_num > var_31_2[arg_31_1].num then
			print("家具礼物数量大于拥有数量")
		end

		if arg_31_3 then
			local var_31_3 = GameDisplayCfg.dorm_interaction_gift.value
			local var_31_4 = DormHeroTemplate.PickInteractAction(var_31_3)

			Dorm.DormEntityManager.SendInteractToEntityCMD(arg_31_3, arg_31_3, var_31_4, false)
		end
	else
		Debug.LogError("赠送家具id或数量为空")
	end
end

function DormHeroTemplate.TouchHero(arg_32_0, arg_32_1, arg_32_2)
	Dorm.DormEntityManager.SendInteractToEntityCMD(arg_32_1, arg_32_1, arg_32_2, false)

	if arg_32_0.hero_id then
		SDKTools.SendMessageToSDK("backhome_dorm_stroke", {
			hero_id = arg_32_0.hero_id
		})
	end

	local var_32_0 = DormInteractSequence[arg_32_2].name
	local var_32_1 = DormCharacterInteractBehaviour.GetSequence(arg_32_1, nil, var_32_0)
	local var_32_2

	if var_32_1 then
		var_32_2 = var_32_1.duration
	end

	return var_32_2
end

function DormHeroTemplate.BackToDorm(arg_33_0)
	local var_33_0 = arg_33_0:GetHeroState()

	arg_33_0.jobType = nil
	arg_33_0.dancePos = nil

	if var_33_0 == DormEnum.DormHeroState.InPublicDorm or var_33_0 == DormEnum.DormHeroState.InPrivateDorm then
		return
	end

	local var_33_1 = DormRoomTools:GetDormIDViaArchive(arg_33_0.archives_id)
	local var_33_2 = DormitoryData:GetDormSceneData(DormConst.PUBLIC_DORM_ID)

	if var_33_2 then
		local var_33_3 = var_33_2.archiveIDList

		if var_33_3 then
			local var_33_4 = #var_33_3

			if not var_33_1 and var_33_4 < GameSetting.dorm_lobby_hero_max.value[1] then
				table.insert(var_33_3, arg_33_0.archives_id)
			end
		end

		arg_33_0:ResetHeroSkill()
		CanteenHeroTools:RefreshCanteenJobList()
	end

	arg_33_0:ResetHeroSkill()
end

function DormHeroTemplate.OutDorm(arg_34_0)
	arg_34_0.jobType = nil
	arg_34_0.dancePos = nil

	arg_34_0:ResetHeroSkill()
end

function DormHeroTemplate.EnsureNotInPublicHall(arg_35_0)
	local var_35_0 = DormitoryData:GetDormSceneData(DormConst.PUBLIC_DORM_ID)

	if var_35_0 then
		local var_35_1 = var_35_0.archiveIDList

		if var_35_1 then
			table.removebyvalue(var_35_1, arg_35_0.archives_id)
		end
	end
end

function DormHeroTemplate.GoToCanteen(arg_36_0)
	arg_36_0.dancePos = nil

	local var_36_0 = DormitoryData:GetDormSceneData(DormConst.PUBLIC_DORM_ID).archiveIDList

	if #var_36_0 > 0 then
		for iter_36_0 = 1, #var_36_0 do
			if var_36_0[iter_36_0] == arg_36_0.archives_id then
				table.remove(var_36_0, iter_36_0)

				break
			end
		end
	end

	arg_36_0:ResetHeroSkill()
end

function DormHeroTemplate.GoToDance(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:GetHeroState()

	if var_37_0 == DormEnum.DormHeroState.InCanteenEntrust or var_37_0 == DormEnum.DormHeroState.InCanteenJob then
		return
	end

	if arg_37_1 and var_37_0 == DormEnum.DormHeroState.InPublicDorm then
		arg_37_0:EnsureNotInPublicHall()
	end

	arg_37_0.dancePos = arg_37_1

	if not arg_37_0.dancePos then
		arg_37_0:BackToDorm()
	end

	arg_37_0:ResetHeroSkill()
end

function DormHeroTemplate.DisposeRunSkill(arg_38_0)
	if arg_38_0.hero_id then
		if not BackHomeHeroCfg[arg_38_0.hero_id] then
			return
		end

		local var_38_0 = BackHomeHeroCfg[arg_38_0.hero_id].skill_list

		for iter_38_0, iter_38_1 in ipairs(var_38_0) do
			if DormSkillData:CheckSkillIsRun(arg_38_0.hero_id, iter_38_1, DormEnum.EntityType.Character) then
				DormSkillData:DisposeSkillComponent(arg_38_0.hero_id, iter_38_1, DormEnum.EntityType.Character)
			end
		end
	end
end

function DormHeroTemplate.OpenHeroSkill(arg_39_0)
	if arg_39_0.hero_id then
		local var_39_0 = BackHomeHeroCfg[arg_39_0.hero_id].skill_list
		local var_39_1 = GameSetting.dorm_hero_skill_unlock.value
		local var_39_2 = {}
		local var_39_3 = HeroData:GetHeroData(arg_39_0.hero_id).level

		for iter_39_0 = 1, #var_39_0 do
			if var_39_3 >= var_39_1[iter_39_0] then
				table.insert(var_39_2, var_39_0[iter_39_0])
			end
		end

		for iter_39_1, iter_39_2 in ipairs(var_39_2) do
			if DormSkillData:CheckSkillIsOpen(arg_39_0.hero_id, iter_39_2, DormEnum.EntityType.Character) then
				DormSkillData:AddSkillComponent(arg_39_0.hero_id, iter_39_2, DormEnum.EntityType.Character)
			end
		end
	end
end

function DormHeroTemplate.ResetHeroSkill(arg_40_0)
	arg_40_0:DisposeRunSkill()
	arg_40_0:OpenHeroSkill()
end

function DormHeroTemplate.SetJob(arg_41_0, arg_41_1)
	arg_41_0.jobType = arg_41_1
end

function DormHeroTemplate.InitDanceTrainData(arg_42_0, arg_42_1)
	if not arg_42_0.property then
		arg_42_0.property = {}
	end

	arg_42_0.property[arg_42_1.hero_id] = IdolTraineeData.ParseIdolProperty(arg_42_1.attribute_list, arg_42_1.hero_id)
end

function DormHeroTemplate.UpdataDanceTrainData(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_2.hero_id

	if not arg_43_0.property and BackHomeHeroCfg[var_43_0].idol_usable == 1 then
		arg_43_0:InitDanceTrainData({
			hero_id = var_43_0
		})
	end

	arg_43_0.property[var_43_0][arg_43_2.attribute_index] = arg_43_1.attribute_value
end

function DormHeroTemplate.GetDanceProperty(arg_44_0, arg_44_1)
	if arg_44_1 then
		local var_44_0 = arg_44_1 or arg_44_0.hero_id

		if not arg_44_0.property then
			arg_44_0:InitDanceTrainData({
				hero_id = var_44_0
			})
		end

		return arg_44_0.property[var_44_0]
	end
end

DormRoomTemplate = class("DormRoomTemplate")

function DormRoomTemplate.Ctor(arg_45_0, arg_45_1)
	arg_45_0.id = arg_45_1.id
	arg_45_0.type = arg_45_1.type
	arg_45_0.name = arg_45_1.name
	arg_45_0.posID = arg_45_1.pos
	arg_45_0.furnitureInfoS = arg_45_1.furnitureInfoS
	arg_45_0.specialFur = arg_45_1.specialFur
end

function DormRoomTemplate.GetDormTemplateFurList(arg_46_0)
	if arg_46_0.furnitureInfoS then
		return arg_46_0.furnitureInfoS
	else
		print("模板家具列表为空")
	end
end

function DormRoomTemplate.GetDormTemplateType(arg_47_0)
	if arg_47_0.type then
		return arg_47_0.type
	end

	print("模板家具类型为空")
end

function DormRoomTemplate.GetDormTemplateFurNumInfo(arg_48_0)
	local var_48_0 = 0
	local var_48_1 = {}

	if arg_48_0.furnitureInfoS then
		for iter_48_0 = 0, arg_48_0.furnitureInfoS.Length - 1 do
			var_48_0 = var_48_0 + 1

			local var_48_2 = arg_48_0.furnitureInfoS[iter_48_0]

			if not var_48_1[var_48_2.id] then
				var_48_1[var_48_2.id] = 0
			end

			var_48_1[var_48_2.id] = var_48_1[var_48_2.id] + 1
		end
	end

	for iter_48_1, iter_48_2 in pairs(arg_48_0.specialFur) do
		var_48_1[iter_48_2] = 1
	end

	return var_48_0 + DormConst.DORM_SPECIAL_FURNITURE_NUM, var_48_1
end

function DormRoomTemplate.ReviseFurTemplateNameInfo(arg_49_0, arg_49_1)
	arg_49_0.name = arg_49_1
end

function DormRoomTemplate.GetTemplateName(arg_50_0)
	return arg_50_0.name
end

function DormRoomTemplate.GetTemplateWallAndFloorInfo(arg_51_0)
	return arg_51_0.specialFur
end

function DormRoomTemplate.Dispose(arg_52_0)
	arg_52_0.id = nil
	arg_52_0.type = nil
	arg_52_0.name = nil
	arg_52_0.posID = nil
	arg_52_0.furnitureInfoS = nil
	arg_52_0.specialFur = nil
	arg_52_0.hasHit = false
end
