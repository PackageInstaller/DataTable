local var_0_0 = {
	HideAllCharacter = function()
		DormCharacterManager.GetInstance():Clear()
	end,
	RemoveHero = function(arg_2_0)
		local var_2_0 = DormCharacterManager.GetInstance()
		local var_2_1 = DormHeroTools:GetCurSkinID(arg_2_0)

		var_2_0:Remove(var_2_1)
	end,
	GenerateHeroByDrag = function(arg_3_0, arg_3_1)
		local var_3_0 = DormCharacterManager.GetInstance()
		local var_3_1 = DormHeroTools:GetCurSkinID(arg_3_0)
		local var_3_2 = var_3_0:Generate(var_3_1)
		local var_3_3

		if arg_3_1 then
			var_3_3 = arg_3_1.pointerId
		end

		DormLuaBridge.BeginGrabPlayerEntity(var_3_2, var_3_3)

		return var_3_2
	end,
	GenreateHero = function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = DormCharacterManager.GetInstance()
		local var_4_1 = DormHeroTools:GetCurSkinID(arg_4_1)
		local var_4_2 = var_4_0:Generate(var_4_1, arg_4_2)

		if not var_4_2 then
			print("未生成角色" .. arg_4_1)
		end

		return var_4_2
	end,
	GenreateVisitHero = function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = DormCharacterManager.GetInstance()
		local var_5_1 = DormHeroTools:GetCurSkinID(arg_5_1)
		local var_5_2 = var_5_0:GenerateVisit(var_5_1, arg_5_2)

		if not var_5_2 then
			print("未生成角色" .. arg_5_1)
		end

		if DormData:CanReceiveVisitReward() then
			DormUtils.ShowCharaSpecialVfx(var_5_2, {
				DormEnum.SpecialVfx.Gift
			})
		end

		return var_5_2
	end,
	CheckIsVisitHero = function(arg_6_0, arg_6_1)
		local var_6_0 = DormCharacterManager.GetInstance()

		return var_6_0 and var_6_0:CheckIsVisitHero(arg_6_1)
	end,
	RandomSetHeroTrs = function(arg_7_0, arg_7_1)
		local var_7_0 = Dorm.DormEntityManager.QueryRadius(arg_7_1)
		local var_7_1 = DormLuaBridge.FindSpawnPos(var_7_0, 5, true)

		if var_7_1 then
			local var_7_2 = Quaternion.Euler(0, 360 * math.random(), 0) * Vector3.forward

			Dorm.DormEntityManager.PutEntityLookToDir(arg_7_1, var_7_1, var_7_2)
		else
			DormLuaBridge.TryGrabPlayerOutOfStuck(arg_7_1)
		end
	end,
	DisposeSingleHero = function(arg_8_0, arg_8_1)
		DormCharacterManager.FindAndRemove(arg_8_1)
	end,
	ReGenerateDormHeroEntity = function(arg_9_0)
		local var_9_0 = CanteenAIFunction:GetNameSpace(DormEnum.CharacterType.DormNormalHero)
		local var_9_1 = DormData:GetCurrectSceneID()

		if var_9_1 then
			local var_9_2 = DormCharacterManager.GetInstance()
			local var_9_3 = DormitoryData:GetDormHerosByArchitecture(var_9_1)
			local var_9_4 = {}

			for iter_9_0, iter_9_1 in ipairs(var_9_3) do
				var_9_4[DormData:GetHeroTemplateInfo(iter_9_1):GetHeroCurSkinID(iter_9_1)] = true
			end

			for iter_9_2, iter_9_3 in Dorm.storage:ForeachData(var_9_0, pairs) do
				if not var_9_4[iter_9_2] then
					var_9_2:Remove(iter_9_2)
				end

				var_9_4[iter_9_2] = nil
			end

			for iter_9_4, iter_9_5 in pairs(var_9_4) do
				local var_9_5 = var_9_2:Generate(iter_9_4)

				arg_9_0:RandomSetHeroTrs(var_9_5)
			end
		end
	end
}

function var_0_0.GenerateHeroWhenEnterScene(arg_10_0, arg_10_1)
	local var_10_0 = DormData:GetCurrectSceneID()

	if var_10_0 > DormConst.DORM_VISIT_ROOM_MIN then
		local var_10_1 = DormVisitTools:GetCurVisitHeroSkinDict()

		if var_10_1 then
			for iter_10_0, iter_10_1 in pairs(var_10_1) do
				local var_10_2 = DormCharacterManager.GetInstance():Generate(iter_10_1, true)

				var_0_0:RandomSetHeroTrs(var_10_2)
			end
		end

		return
	end

	local var_10_3 = DormitoryData:GetDormMapList()[var_10_0].archiveIDList

	if not var_10_3 then
		return
	end

	local var_10_4

	if BackHomeCfg[var_10_0].type == DormConst.BACKHOME_TYPE.PublicDorm then
		if var_10_3 and #var_10_3 > 0 then
			for iter_10_2, iter_10_3 in ipairs(var_10_3) do
				local var_10_5 = DormData:GetHeroInfo(iter_10_3):GetHeroId()

				if var_10_5 ~= nil then
					local var_10_6 = var_0_0:GenreateHero(var_10_5, true)

					var_0_0:RandomSetHeroTrs(var_10_6)
				end
			end
		end

		if not arg_10_1 or not arg_10_1.disAllowVisit then
			arg_10_0:GenerateVisitHero()
		end
	elseif BackHomeCfg[var_10_0].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		local var_10_7 = var_10_3[1]
		local var_10_8 = DormData:GetHeroInfo(var_10_7)

		if var_10_8 and var_10_8:GetHeroState() == DormEnum.DormHeroState.InPrivateDorm then
			local var_10_9 = var_10_8:GetHeroId()

			if var_10_9 ~= nil then
				local var_10_10 = var_0_0:GenreateHero(var_10_9, true)

				var_0_0:RandomSetHeroTrs(var_10_10)
			end
		end
	end
end

function var_0_0.GenerateVisitHero(arg_11_0)
	local var_11_0 = DormData:GetCurrectSceneID()

	if BackHomeCfg[var_11_0].type == DormConst.BACKHOME_TYPE.PublicDorm and not DormVisitTools:CheckCurIsVisitRoom() then
		local var_11_1 = 1
		local var_11_2 = DormData:GetVisitInfo()

		for iter_11_0 = 1, var_11_1 do
			if var_11_2.visitUser[iter_11_0] then
				local var_11_3 = var_0_0:GenreateVisitHero(var_11_2.visitUser[iter_11_0].heroID, true)

				var_0_0:RandomSetHeroTrs(var_11_3)
				Dorm.InvokeEntityEvent(DORM_VISIT_CHARACTER_NICKNAME, var_11_3, var_11_2.visitUser[iter_11_0].name)
			else
				break
			end
		end
	end
end

function var_0_0.ShowVisitName(arg_12_0)
	local var_12_0 = DormData:GetCurrectSceneID()

	if BackHomeCfg[var_12_0].type == DormConst.BACKHOME_TYPE.PublicDorm and not DormVisitTools:CheckCurIsVisitRoom() then
		local var_12_1 = DormCharacterManager.GetInstance()
		local var_12_2 = 1
		local var_12_3 = DormData:GetVisitInfo()

		for iter_12_0 = 1, var_12_2 do
			if var_12_3.visitUser[iter_12_0] then
				local var_12_4 = var_12_1:GetVisitEntityID(var_12_3.visitUser[iter_12_0].heroID)

				if var_12_4 then
					Dorm.InvokeEntityEvent(DORM_VISIT_CHARACTER_NICKNAME, var_12_4, var_12_3.visitUser[iter_12_0].name)
				end
			else
				break
			end
		end
	end
end

function var_0_0.ShowVisitTalk(arg_13_0)
	local var_13_0 = DormData:GetCurrectSceneID()

	if BackHomeCfg[var_13_0].type == DormConst.BACKHOME_TYPE.PublicDorm and not DormVisitTools:CheckCurIsVisitRoom() then
		local var_13_1 = DormCharacterManager.GetInstance()
		local var_13_2 = 1
		local var_13_3 = DormData:GetVisitInfo()

		for iter_13_0 = 1, var_13_2 do
			if var_13_3.visitUser[iter_13_0] then
				local var_13_4 = var_13_1:GetVisitEntityID(var_13_3.visitUser[iter_13_0].heroID)

				if var_13_4 then
					manager.notify:Invoke(DORM_VISIT_CHARACTER_FIRST_TALK, var_13_4)
				end
			else
				break
			end
		end
	end
end

function var_0_0.FeedAllHero(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = DormData:GetHeroInfoList()
	local var_14_1 = var_0_0:GetAllHeroEIDInCurScene()
	local var_14_2 = DormData:GetCurrectSceneID()
	local var_14_3
	local var_14_4 = DormData:GetHeroArchiveID(arg_14_1)

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if iter_14_1:CheckCanFeedFood() then
			local var_14_5

			if var_0_0:CheckHeroInRoom(var_14_2, iter_14_0) then
				local var_14_6 = iter_14_1:GetHeroId()

				var_14_5 = var_14_1[iter_14_1:GetHeroCurSkinID(var_14_6)]
			end

			if var_14_4 == iter_14_0 then
				var_14_3 = iter_14_1:FeedFood(var_14_5, arg_14_2(var_14_5))
			else
				iter_14_1:FeedFood(var_14_5, arg_14_2(var_14_5))
			end
		end
	end

	return var_14_3
end

function var_0_0.FeedMultipleHero(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0

	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		local var_15_1 = DormData:GetHeroArchiveID(iter_15_1)
		local var_15_2 = DormData:GetHeroInfo(var_15_1)

		if var_15_2:CheckCanFeedFood() then
			if iter_15_1 == arg_15_2 then
				var_15_0 = var_15_2:FeedFood(iter_15_0, arg_15_3(iter_15_0))
			else
				var_15_0 = var_15_2:FeedFood(iter_15_0, arg_15_3(iter_15_0))
			end
		end
	end

	return var_15_0
end

function var_0_0.RecallAllHero(arg_16_0, arg_16_1)
	local var_16_0 = DormConst.PUBLIC_DORM_ID
	local var_16_1 = {}
	local var_16_2 = false

	if arg_16_1 then
		for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
			if DormData:GetHeroFatigue(iter_16_1) < GameSetting.canteen_hero_fatigue_max.value[1] then
				table.insert(var_16_1, iter_16_1)
			else
				var_16_2 = true
			end
		end

		if var_16_2 then
			DormAction:DeployHeroInRoom(var_16_0, var_16_1, DormEnum.DormDeployType.ReCall)
		else
			ShowTips("DORM_NO_HERO_RECALL")
		end
	end
end

function var_0_0.GetBackHomeHeadSprite(arg_17_0, arg_17_1)
	local var_17_0

	if DormNpcTools:CheckIDIsNpc(arg_17_0) then
		var_17_0 = arg_17_0
	elseif IdolPveNpcCfg[arg_17_0] then
		var_17_0 = IdolPveNpcCfg[arg_17_0].icon
	elseif arg_17_1 then
		var_17_0 = arg_17_0
	else
		var_17_0 = var_0_0:GetCurSkinID(arg_17_0)
	end

	if var_17_0 then
		return getSpriteViaConfig("DormHeroHeadIcon", var_17_0)
	end
end

function var_0_0.GetBackHomeFullModelSprite(arg_18_0)
	local var_18_0 = var_0_0:GetCurSkinID(arg_18_0)

	if var_18_0 then
		return getSpriteViaConfig("DormHeroModelIcon", var_18_0)
	end
end

function var_0_0.GetBackHomeFullModelFowardSprite(arg_19_0)
	local var_19_0 = var_0_0:GetCurSkinID(arg_19_0)

	if var_19_0 then
		return getSpriteViaConfig("DormHeroPortrait", var_19_0)
	end
end

function var_0_0.GetBackHomeHeroSkinIcon(arg_20_0)
	if arg_20_0 then
		return getSpriteViaConfig("DormHeroPortrait", arg_20_0)
	end
end

function var_0_0.GetCurSkinID(arg_21_0, arg_21_1)
	if DormVisitTools:CheckCurIsVisitRoom() then
		local var_21_0 = HeroRecordCfg.get_id_list_by_hero_id[arg_21_1][1]

		return DormVisitTools:GetCurVisitHeroSkin(var_21_0) or arg_21_1
	end

	local var_21_1 = DormData:GetHeroTemplateInfo(arg_21_1)

	if var_21_1 then
		local var_21_2 = var_21_1:GetHeroCurSkinID(arg_21_1)

		if var_21_2 then
			return var_21_2
		else
			print("未找到角色" .. arg_21_1 .. "的皮肤id")
		end
	else
		return arg_21_1
	end
end

function var_0_0.GetCanUseDormHeroSkinList(arg_22_0)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(SkinCfg.get_id_list_by_hero[arg_22_0]) do
		if not HeroTools.GetIsSkinHide(iter_22_1) and BackHomeHeroSkinCfg[iter_22_1] then
			table.insert(var_22_0, iter_22_1)
		end
	end

	return var_22_0
end

function var_0_0.isUnlock(arg_23_0, arg_23_1)
	local var_23_0 = SkinCfg[arg_23_1].hero
	local var_23_1 = HeroTools.HeroUnlockSkinS(var_23_0)

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		if iter_23_1 == arg_23_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetDormHeroCanUseSkinList(arg_24_0, arg_24_1)
	local var_24_0 = var_0_0.GetCanUseDormHeroSkinList(arg_24_1)
	local var_24_1 = {}

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if var_0_0:isUnlock(iter_24_1) then
			table.insert(var_24_1, iter_24_1)
		end
	end

	return var_24_1
end

function var_0_0.GetDormHeroNextCanUseSkin(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0:GetDormHeroCanUseSkinList(arg_25_1)
	local var_25_1 = #var_25_0

	if var_25_1 == 0 or var_25_1 == 1 then
		return nil
	else
		local var_25_2 = table.indexof(var_25_0, arg_25_2)

		return var_25_0[var_25_2 == var_25_1 and 1 or var_25_2 + 1]
	end
end

function var_0_0.CheckDormFatigueLevel(arg_26_0, arg_26_1)
	if not DormNpcTools:CheckIDIsNpc(arg_26_1) then
		if DormData:GetHeroTemplateInfo(arg_26_1):GetFatigue() < GameDisplayCfg.dorm_hero_hungry_fatigue.value[1] then
			return false
		else
			return true
		end
	else
		return true
	end
end

function var_0_0.CheckCanteenFatigueLevel(arg_27_0, arg_27_1)
	if not DormNpcTools:CheckIDIsNpc(arg_27_1) then
		if DormData:GetHeroTemplateInfo(arg_27_1):GetFatigue() < GameDisplayCfg.canteen_hero_tired_fatigue.value[1] then
			return false
		else
			return true
		end
	else
		return true
	end
end

function var_0_0.CheckFeedTime(arg_28_0, arg_28_1)
	if not DormNpcTools:CheckIDIsNpc(arg_28_1) then
		local var_28_0 = DormData:GetHeroTemplateInfo(arg_28_1)

		if not var_28_0 then
			return false
		end

		if var_28_0.feed_times >= GameSetting.dorm_feed_max.value[1] then
			return false
		else
			return true
		end
	else
		return false
	end
end

function var_0_0.GetCanUseHeroInDorm(arg_29_0)
	local var_29_0 = {}
	local var_29_1 = {}

	for iter_29_0, iter_29_1 in ipairs(HeroCfg.get_id_list_by_private[0]) do
		if HeroTools.GetHeroIsUnlock(iter_29_1) and BackHomeHeroCfg[iter_29_1] then
			var_29_0[DormData:GetHeroArchiveID(iter_29_1)] = true
		end
	end

	for iter_29_2, iter_29_3 in pairs(var_29_0) do
		table.insert(var_29_1, iter_29_2)
	end

	return var_29_1
end

function var_0_0.GetAllCanUseHeroInDorm(arg_30_0)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(HeroCfg.get_id_list_by_private[0]) do
		if HeroTools.GetHeroIsUnlock(iter_30_1) == true and BackHomeHeroCfg[iter_30_1] then
			table.insert(var_30_0, iter_30_1)
		end
	end

	return var_30_0
end

function var_0_0.GetUnLockBackHomeHeroIDList(arg_31_0)
	local var_31_0 = var_0_0:GetCanUseHeroInDorm()
	local var_31_1 = {}

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		local var_31_2 = DormData:GetHeroInfo(iter_31_1):GetCanUseHeroList()

		for iter_31_2, iter_31_3 in ipairs(var_31_2) do
			table.insert(var_31_1, iter_31_3)
		end
	end

	return var_31_1
end

function var_0_0.GetFilteredUnlockBackHomeHeroIDList(arg_32_0, arg_32_1)
	local var_32_0 = var_0_0:GetCanUseHeroInDorm()
	local var_32_1 = {}

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		local var_32_2 = DormData:GetHeroInfo(iter_32_1):GetCanUseHeroList()

		for iter_32_2, iter_32_3 in ipairs(var_32_2) do
			if arg_32_1(iter_32_3) then
				table.insert(var_32_1, iter_32_3)
			end
		end
	end

	return var_32_1
end

function var_0_0.GetBackHomeCanUseHeroList(arg_33_0, arg_33_1)
	local var_33_0 = {}
	local var_33_1 = {}

	if BackHomeCfg[arg_33_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
		local var_33_2 = {}

		for iter_33_0, iter_33_1 in ipairs(HeroCfg.get_id_list_by_private[0]) do
			if HeroTools.GetHeroIsUnlock(iter_33_1) == true and BackHomeHeroCfg[iter_33_1] then
				local var_33_3 = DormData:GetHeroArchiveID(iter_33_1)

				if not var_33_1[var_33_3] then
					var_33_1[var_33_3] = true

					table.insert(var_33_2, var_33_3)
				end
			end
		end

		for iter_33_2, iter_33_3 in pairs(var_33_2) do
			local var_33_4 = DormData:GetHeroInfo(iter_33_3)

			if #var_33_4:GetCanUseHeroList() > 0 then
				for iter_33_4, iter_33_5 in ipairs(var_33_4:GetCanUseHeroList()) do
					table.insert(var_33_0, iter_33_5)
				end
			end
		end

		return var_33_0
	elseif BackHomeCfg[arg_33_1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		local var_33_5 = DormitoryData:GetDormSceneData(arg_33_1).archiveIDList[1]

		if var_33_5 then
			local var_33_6 = DormData:GetHeroInfo(var_33_5):GetCanUseHeroList()

			for iter_33_6, iter_33_7 in ipairs(var_33_6) do
				table.insert(var_33_0, iter_33_7)
			end
		else
			print("未找到档案id")
		end

		return var_33_0
	end

	Debug.LogError("未找到对应房间类型")
end

function var_0_0.CheckHeroInRoom(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = DormitoryData:GetDormArchivesByArchitecture(arg_34_1)

	if BackHomeCfg[arg_34_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
		for iter_34_0, iter_34_1 in ipairs(var_34_0) do
			if iter_34_1 == arg_34_2 then
				return true
			end
		end
	elseif BackHomeCfg[arg_34_1].type == DormConst.BACKHOME_TYPE.PrivateDorm and DormData:GetHeroInfo(var_34_0[1]):GetHeroState() == DormEnum.DormHeroState.InPrivateDorm then
		return true
	end

	return false
end

function var_0_0.GetTemplateIDInDorm(arg_35_0, arg_35_1)
	local var_35_0 = {}

	if arg_35_1 and HeroRecordCfg[arg_35_1] then
		local var_35_1 = HeroRecordCfg[arg_35_1].hero_id

		for iter_35_0, iter_35_1 in ipairs(var_35_1) do
			if BackHomeHeroCfg[iter_35_1] then
				table.insert(var_35_0, iter_35_1)
			end
		end
	end

	return var_35_0[1]
end

function var_0_0.GetAllCanUseHeroIDInDorm(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = {}

	if arg_36_1 and HeroRecordCfg[arg_36_1] then
		local var_36_1 = HeroRecordCfg[arg_36_1].hero_id

		for iter_36_0, iter_36_1 in ipairs(var_36_1) do
			if BackHomeHeroCfg[iter_36_1] then
				if not arg_36_2 then
					if HeroTools.GetHeroIsUnlock(iter_36_1) then
						table.insert(var_36_0, iter_36_1)
					end
				else
					table.insert(var_36_0, iter_36_1)
				end
			end
		end
	end

	return var_36_0
end

function var_0_0.GetAllHeroEIDInCurScene(arg_37_0)
	local var_37_0 = DormUtils.EIdNamespace(DormEnum.CharacterType.DormNormalHero)
	local var_37_1 = {}

	for iter_37_0, iter_37_1 in Dorm.storage:ForeachData(var_37_0, pairs) do
		var_37_1[iter_37_0] = iter_37_1
	end

	return var_37_1
end

function var_0_0.IsVoiceNeedUnlock(arg_38_0, arg_38_1, arg_38_2)
	if BackHomeHeroCfg[arg_38_2] then
		for iter_38_0, iter_38_1 in ipairs(BackHomeDormLevelRewardCfg.all) do
			local var_38_0 = BackHomeDormLevelRewardCfg[iter_38_1]

			if var_38_0.type == 2 and var_38_0.reward[1] == arg_38_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetVoiceUnlockLevel(arg_39_0, arg_39_1, arg_39_2)
	for iter_39_0, iter_39_1 in ipairs(BackHomeDormLevel.all) do
		local var_39_0 = BackHomeHeroCfg[arg_39_1].level_reward[iter_39_0]

		for iter_39_2, iter_39_3 in ipairs(var_39_0) do
			local var_39_1 = BackHomeDormLevelRewardCfg[iter_39_3]

			if var_39_1.type == 2 and var_39_1.reward[1] == arg_39_2 then
				return iter_39_1
			end
		end
	end

	return 1
end

function var_0_0.GetDormLevelByHeroID(arg_40_0, arg_40_1)
	local var_40_0 = DormData:GetHeroArchiveID(arg_40_1)
	local var_40_1 = DormRoomTools:GetDormIDViaArchive(var_40_0)

	return DormitoryData:GetDormLevel(var_40_1) or 0
end

function var_0_0.GetHeroListInDance(arg_41_0)
	local var_41_0 = {}
	local var_41_1 = DormData:GetHeroInfoList()

	for iter_41_0, iter_41_1 in pairs(var_41_1) do
		if iter_41_1.dancePos then
			table.insert(var_41_0, iter_41_1)
		end
	end

	return var_41_0
end

function var_0_0.GetCanteenFatigueLevel(arg_42_0)
	local var_42_0 = GameDisplayCfg.dorm_hero_fatigue_level.value

	if arg_42_0 <= var_42_0[1] then
		return 1
	elseif arg_42_0 > var_42_0[1] and arg_42_0 <= var_42_0[2] then
		return 2
	else
		return 3
	end
end

return var_0_0
