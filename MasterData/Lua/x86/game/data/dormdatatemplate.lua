DormHeroTemplate = class("DormDataTemplate")

function DormHeroTemplate:Ctor(arg_1_1)
	local var_1_0 = DormHeroTools:GetAllCanUseHeroIDInDorm(arg_1_1.archives_id)[1]

	if not arg_1_1.hero_id then
		if var_1_0 then
			self.hero_id = var_1_0
		else
			print(debug.traceback("无可用人物,档案id为" .. arg_1_1.archives_id))

			return
		end
	else
		self.hero_id = arg_1_1.hero_id
	end

	self.fatigue = arg_1_1.fatigue or GameSetting.canteen_hero_fatigue_max.value[1]
	self.feed_times = arg_1_1.feed_times or 0
	self.archives_id = arg_1_1.archives_id
	self.feedTotalTime = arg_1_1.totalFeedTime or 0
	self.isLock = arg_1_1.isLock or 0

	self:InitHeroSkinData(arg_1_1.skinID)
end

function DormHeroTemplate:InitHeroSkinData(arg_2_1)
	self.skinInfo = {}

	for iter_2_0, iter_2_1 in ipairs((self:GetCanUseHeroList())) do
		self.skinInfo[iter_2_1] = iter_2_1
	end

	if arg_2_1 then
		for iter_2_2, iter_2_3 in ipairs(arg_2_1) do
			if self.skinInfo[iter_2_3.hero_id] then
				self.skinInfo[iter_2_3.hero_id] = iter_2_3.skin_id
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

function DormHeroTemplate:GetHeroId()
	if BackHomeHeroCfg[self.hero_id] then
		return self.hero_id
	else
		local var_5_0 = self:GetCanUseHeroList()

		if #var_5_0 > 0 then
			return var_5_0[1]
		end
	end
end

function DormHeroTemplate:GetHeroTotalFeedTime()
	return self.feedTotalTime
end

function DormHeroTemplate:GetRoomID()
	return self.roomID
end

function DormHeroTemplate:SetCurHeroID(arg_8_1)
	if arg_8_1 == nil then
		self.hero_id = nil

		return
	end

	if self.archives_id == DormData:GetHeroArchiveID(arg_8_1) then
		self.hero_id = arg_8_1
	else
		print("传入角色id不是本档案角色")
	end
end

function DormHeroTemplate:GetHeroCurSkinID(arg_9_1)
	if self.skinInfo then
		if not self.skinInfo[arg_9_1] and DormData:GetHeroArchiveID(arg_9_1) == self.archives_id and BackHomeHeroCfg[arg_9_1] and HeroTools.GetHeroIsUnlock(arg_9_1) then
			self.skinInfo[arg_9_1] = arg_9_1
		end

		if self.skinInfo[arg_9_1] then
			return self.skinInfo[arg_9_1]
		end
	end

	return arg_9_1
end

function DormHeroTemplate:SetHeroSkinID(arg_10_1, arg_10_2)
	if self.skinInfo then
		self.skinInfo[arg_10_1] = arg_10_2
	end
end

function DormHeroTemplate:GetCanUseHeroList()
	return DormHeroTools:GetAllCanUseHeroIDInDorm(self.archives_id) or {}
end

function DormHeroTemplate:GetFatigue()
	return self.fatigue
end

function DormHeroTemplate.SetFatigue(arg_13_0, arg_13_1)
	if arg_13_1 < 0 then
		print("设置体力越界")

		return
	end

	arg_13_0.fatigue = arg_13_1
end

function DormHeroTemplate:CalFatigue(arg_14_1)
	self.fatigue = self.fatigue + arg_14_1

	if self.fatigue < 0 then
		self.fatigue = 0
	end
end

function DormHeroTemplate:UpdataHeroState()
	if self.fatigue < GameSetting.dorm_canteen_work_fatigue.value[1] / 100 - GameSetting.dorm_canteen_work_fatigue.value[1] / 100 % 0.1 and self.jobType then
		self.jobType = nil

		self:BackToDorm()
	end
end

function DormHeroTemplate:GetRecoverFatigueNum()
	local var_16_0 = self:GetHeroState()

	if var_16_0 == DormEnum.DormHeroState.InCanteenEntrust or var_16_0 == DormEnum.DormHeroState.InCanteenJob then
		return 0
	elseif var_16_0 == DormEnum.DormHeroState.OutDorm then
		return GameSetting.dorm_base_fatigue_increase.value[1] / 100
	elseif var_16_0 == DormEnum.DormHeroState.InPublicDorm then
		local var_16_1 = 0

		if self.hero_id then
			var_16_1 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverSelfFast, self.hero_id)
			var_16_1 = var_16_1 + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverAllFast, self.hero_id)
		end

		return GameSetting.dorm_lobby_fatigue_increase.value[1] / 100 * ((100 + var_16_1) / 100) * (3600 / GameSetting.dorm_fatigue_time.value[1])
	elseif var_16_0 == DormEnum.DormHeroState.InPrivateDorm then
		local var_16_2 = 0

		if self.hero_id then
			var_16_2 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverSelfFast, self.hero_id)
			var_16_2 = var_16_2 + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverAllFast, self.hero_id)
		end

		return GameSetting.dorm_fatigue_increase.value[DormHeroTools:GetDormLevelByHeroID(self.archives_id)][2] / 100 * ((100 + var_16_2) / 100) * (3600 / GameSetting.dorm_fatigue_time.value[1])
	elseif var_16_0 == DormEnum.DormHeroState.InIdolTraineeCamp then
		if self.roomID then
			local var_16_3 = 0

			if self.hero_id then
				var_16_3 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverSelfFast, self.hero_id)
				var_16_3 = var_16_3 + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverAllFast, self.hero_id)
			end

			return GameSetting.dorm_fatigue_increase.value[DormHeroTools:GetDormLevelByHeroID(self.archives_id)][2] / 100 * ((100 + var_16_3) / 100) * (3600 / GameSetting.dorm_fatigue_time.value[1])
		else
			local var_16_4 = GameSetting.dorm_lobby_fatigue_increase.value[1] / 100
			local var_16_5 = 0

			if self.hero_id then
				var_16_5 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverSelfFast, self.hero_id)
				var_16_5 = var_16_5 + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverAllFast, self.hero_id)
			end

			return var_16_4 * ((100 + var_16_5) / 100) * (3600 / GameSetting.dorm_fatigue_time.value[1])
		end
	else
		return 0
	end

	print("人物处于未知状态")
end

function DormHeroTemplate:GetCurRoomID()
	local var_17_0 = self:GetHeroState()

	if var_17_0 == DormEnum.DormHeroState.InCanteenEntrust or var_17_0 == DormEnum.DormHeroState.InCanteenJob then
		return DormConst.CANTEEN_ID
	end

	if var_17_0 == DormEnum.DormHeroState.InPublicDorm then
		return DormConst.PUBLIC_DORM_ID
	elseif var_17_0 == DormEnum.DormHeroState.InPrivateDorm then
		return DormRoomTools:GetDormIDViaArchive(self.archives_id)
	end

	return nil
end

function DormHeroTemplate:GetHeroTrueState()
	if self.dancePos then
		return DormEnum.DormHeroState.InIdolTraineeCamp
	end

	if CanteenEntrustData:CheckHasChooseEntrustCharacter(self.archives_id) then
		return DormEnum.DormHeroState.InCanteenEntrust
	end

	if self.jobType then
		return DormEnum.DormHeroState.InCanteenJob
	end

	if DormConst.PUBLIC_DORM_ID then
		for iter_18_0, iter_18_1 in ipairs(DormData:GetDormSceneData(DormConst.PUBLIC_DORM_ID).archiveIDList) do
			if iter_18_1 == self.archives_id then
				return DormEnum.DormHeroState.InPublicDorm
			end
		end

		if DormRoomTools:GetDormIDViaArchive(self.archives_id) then
			return DormEnum.DormHeroState.InPrivateDorm
		end

		return DormEnum.DormHeroState.OutDorm
	end
end

function DormHeroTemplate:GetHeroTempState()
	return self.tempState
end

function DormHeroTemplate:GetHeroState()
	return self:GetHeroTempState() or self:GetHeroTrueState()
end

function DormHeroTemplate:GetHeroFavorability()
	return ArchiveData:GetArchive(self.archives_id).lv
end

function DormHeroTemplate:GetGiftNum(arg_22_1)
	local var_22_0 = DormitoryData:GetDormSceneData((DormRoomTools:GetDormIDViaArchive(self.archives_id)))

	if var_22_0 and var_22_0.give_furnitures then
		return var_22_0.give_furnitures[arg_22_1] or 0
	else
		return 0
	end
end

function DormHeroTemplate:GetCanGiftNum(arg_23_1)
	local var_23_0 = 0

	if DormRoomTools:GetDormIDViaArchive(self.archives_id) then
		var_23_0 = math.min(DormData:GetFurNumInfo(arg_23_1).num - DormData:GetFurNumInfo(arg_23_1).give_num, ((DormSpecialFurnitureTools:JudgeFurIsSpecialType(arg_23_1) or nil) and 1) - self:GetGiftNum(arg_23_1))

		if var_23_0 < 0 then
			var_23_0 = 0
		end
	end

	return var_23_0
end

function DormHeroTemplate:GetCanBuyAndGiftNum(arg_24_1)
	local var_24_0 = 0

	if DormRoomTools:GetDormIDViaArchive(self.archives_id) then
		local var_24_1 = BackHomeFurniture[arg_24_1].give_max

		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(arg_24_1) then
			var_24_1 = 1
		end

		var_24_0 = math.min(var_24_1, var_24_1 - self:GetGiftNum(arg_24_1))

		if var_24_0 < 0 then
			var_24_0 = 0
		end
	end

	return var_24_0
end

function DormHeroTemplate:CheckCanFeedFood()
	if self.feed_times >= GameSetting.dorm_feed_max.value[1] then
		return false, "feedTime"
	end

	if self.fatigue > GameSetting.canteen_hero_fatigue_max.value[1] then
		return false, "fatigue"
	end

	if DormHeroTools:GetDormLevelByHeroID(self.archives_id) < GameSetting.dorm_menu_feed_unlock.value[1] then
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

			local var_29_1 = DormCharacterInteractBehaviour.GetSequence(arg_29_1, nil, DormInteractSequence[arg_29_2].name)

			if var_29_1 then
				var_29_0 = var_29_1.duration
			end
		end

		DormUtils.ClearSingleSpecialVfx(arg_29_1, DormEnum.SpecialVfx.Hungry)

		return var_29_0
	end
end

function DormHeroTemplate:FeedFoodTime(arg_30_1)
	self.feed_times = self.feed_times + arg_30_1
	self.feedTotalTime = self.feedTotalTime + arg_30_1
end

function DormHeroTemplate:GiftFur(arg_31_1, arg_31_2, arg_31_3)
	if arg_31_1 and arg_31_2 then
		local var_31_0 = DormData:GetDormSceneData((DormRoomTools:GetDormIDViaArchive(self.archives_id)))

		var_31_0.give_furnitures = var_31_0.give_furnitures or {}
		var_31_0.give_furnitures[arg_31_1] = var_31_0.give_furnitures[arg_31_1] or 0
		var_31_0.give_furnitures[arg_31_1] = var_31_0.give_furnitures[arg_31_1] + arg_31_2

		local var_31_1 = DormData:GetFurnitureInfoList()

		var_31_1[arg_31_1].give_num = var_31_1[arg_31_1].give_num + arg_31_2

		if var_31_1[arg_31_1].give_num > var_31_1[arg_31_1].num then
			print("家具礼物数量大于拥有数量")
		end

		if arg_31_3 then
			Dorm.DormEntityManager.SendInteractToEntityCMD(arg_31_3, arg_31_3, DormHeroTemplate.PickInteractAction(GameDisplayCfg.dorm_interaction_gift.value), false)
		end
	else
		Debug.LogError("赠送家具id或数量为空")
	end
end

function DormHeroTemplate:TouchHero(arg_32_1, arg_32_2)
	Dorm.DormEntityManager.SendInteractToEntityCMD(arg_32_1, arg_32_1, arg_32_2, false)

	if self.hero_id then
		SDKTools.SendMessageToSDK("backhome_dorm_stroke", {
			hero_id = self.hero_id
		})
	end

	local var_32_0 = DormCharacterInteractBehaviour.GetSequence(arg_32_1, nil, DormInteractSequence[arg_32_2].name)

	return (var_32_0 or nil) and var_32_0.duration
end

function DormHeroTemplate:BackToDorm()
	local var_33_0 = self:GetHeroState()

	self.jobType = nil
	self.dancePos = nil

	if var_33_0 == DormEnum.DormHeroState.InPublicDorm or var_33_0 == DormEnum.DormHeroState.InPrivateDorm then
		return
	end

	local var_33_1 = DormRoomTools:GetDormIDViaArchive(self.archives_id)
	local var_33_2 = DormitoryData:GetDormSceneData(DormConst.PUBLIC_DORM_ID)

	if var_33_2 then
		if var_33_2.archiveIDList then
			if not var_33_1 and #var_33_2.archiveIDList < GameSetting.dorm_lobby_hero_max.value[1] then
				table.insert(var_33_2.archiveIDList, self.archives_id)
			end
		end

		self:ResetHeroSkill()
		CanteenHeroTools:RefreshCanteenJobList()
	end

	self:ResetHeroSkill()
end

function DormHeroTemplate:OutDorm()
	self.jobType = nil
	self.dancePos = nil

	self:ResetHeroSkill()
end

function DormHeroTemplate:EnsureNotInPublicHall()
	local var_35_0 = DormitoryData:GetDormSceneData(DormConst.PUBLIC_DORM_ID)

	if var_35_0 then
		if var_35_0.archiveIDList then
			table.removebyvalue(var_35_0.archiveIDList, self.archives_id)
		end
	end
end

function DormHeroTemplate:GoToCanteen()
	self.dancePos = nil

	local var_36_0 = DormitoryData:GetDormSceneData(DormConst.PUBLIC_DORM_ID).archiveIDList

	if #var_36_0 > 0 then
		for iter_36_0 = 1, #var_36_0 do
			if var_36_0[iter_36_0] == self.archives_id then
				table.remove(var_36_0, iter_36_0)

				break
			end
		end
	end

	self:ResetHeroSkill()
end

function DormHeroTemplate:GoToDance(arg_37_1)
	local var_37_0 = self:GetHeroState()

	if var_37_0 == DormEnum.DormHeroState.InCanteenEntrust or var_37_0 == DormEnum.DormHeroState.InCanteenJob then
		return
	end

	if arg_37_1 and var_37_0 == DormEnum.DormHeroState.InPublicDorm then
		self:EnsureNotInPublicHall()
	end

	self.dancePos = arg_37_1

	if not self.dancePos then
		self:BackToDorm()
	end

	self:ResetHeroSkill()
end

function DormHeroTemplate:DisposeRunSkill()
	if self.hero_id then
		if not BackHomeHeroCfg[self.hero_id] then
			return
		end

		for iter_38_0, iter_38_1 in ipairs(BackHomeHeroCfg[self.hero_id].skill_list) do
			if DormSkillData:CheckSkillIsRun(self.hero_id, iter_38_1, DormEnum.EntityType.Character) then
				DormSkillData:DisposeSkillComponent(self.hero_id, iter_38_1, DormEnum.EntityType.Character)
			end
		end
	end
end

function DormHeroTemplate:OpenHeroSkill()
	if self.hero_id then
		local var_39_0 = {}
		local var_39_1 = HeroData:GetHeroData(self.hero_id).level

		for iter_39_0 = 1, #BackHomeHeroCfg[self.hero_id].skill_list do
			if var_39_1 >= GameSetting.dorm_hero_skill_unlock.value[iter_39_0] then
				table.insert(var_39_0, BackHomeHeroCfg[self.hero_id].skill_list[iter_39_0])
			end
		end

		for iter_39_1, iter_39_2 in ipairs(var_39_0) do
			if DormSkillData:CheckSkillIsOpen(self.hero_id, iter_39_2, DormEnum.EntityType.Character) then
				DormSkillData:AddSkillComponent(self.hero_id, iter_39_2, DormEnum.EntityType.Character)
			end
		end
	end
end

function DormHeroTemplate:ResetHeroSkill()
	self:DisposeRunSkill()
	self:OpenHeroSkill()
end

function DormHeroTemplate.SetJob(arg_41_0, arg_41_1)
	arg_41_0.jobType = arg_41_1
end

function DormHeroTemplate:InitDanceTrainData(arg_42_1)
	self.property = self.property or {}
	self.property[arg_42_1.hero_id] = IdolTraineeData.ParseIdolProperty(arg_42_1.attribute_list, arg_42_1.hero_id)
end

function DormHeroTemplate:UpdataDanceTrainData(arg_43_1, arg_43_2)
	if not self.property and BackHomeHeroCfg[arg_43_2.hero_id].idol_usable == 1 then
		self:InitDanceTrainData({
			hero_id = arg_43_2.hero_id
		})
	end

	self.property[arg_43_2.hero_id][arg_43_2.attribute_index] = arg_43_1.attribute_value
end

function DormHeroTemplate:GetDanceProperty(arg_44_1)
	if arg_44_1 then
		local var_44_0 = arg_44_1 or self.hero_id

		if not self.property then
			self:InitDanceTrainData({
				hero_id = var_44_0
			})
		end

		return self.property[var_44_0]
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

function DormRoomTemplate:GetDormTemplateFurList()
	if self.furnitureInfoS then
		return self.furnitureInfoS
	else
		print("模板家具列表为空")
	end
end

function DormRoomTemplate:GetDormTemplateType()
	if self.type then
		return self.type
	end

	print("模板家具类型为空")
end

function DormRoomTemplate:GetDormTemplateFurNumInfo()
	local var_48_0 = 0
	local var_48_1 = {}

	if self.furnitureInfoS then
		for iter_48_0 = 0, self.furnitureInfoS.Length - 1 do
			var_48_0 = var_48_0 + 1
			var_48_1[self.furnitureInfoS[iter_48_0].id] = var_48_1[self.furnitureInfoS[iter_48_0].id] or 0
			var_48_1[self.furnitureInfoS[iter_48_0].id] = var_48_1[self.furnitureInfoS[iter_48_0].id] + 1
		end
	end

	for iter_48_1, iter_48_2 in pairs(self.specialFur) do
		var_48_1[iter_48_2] = 1
	end

	return var_48_0 + DormConst.DORM_SPECIAL_FURNITURE_NUM, var_48_1
end

function DormRoomTemplate.ReviseFurTemplateNameInfo(arg_49_0, arg_49_1)
	arg_49_0.name = arg_49_1
end

function DormRoomTemplate:GetTemplateName()
	return self.name
end

function DormRoomTemplate:GetTemplateWallAndFloorInfo()
	return self.specialFur
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
