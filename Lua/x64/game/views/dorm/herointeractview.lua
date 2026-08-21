local var_0_0 = class("HeroInteractView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormInteractionUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.touchController = ControllerUtil.GetController(arg_5_0.touchbtnBtn_.gameObject.transform, "lock")
	arg_5_0.gameController = ControllerUtil.GetController(arg_5_0.gameBtn_.gameObject.transform, "lock")
	arg_5_0.feedController = ControllerUtil.GetController(arg_5_0.feedfoodbtnBtn_.gameObject.transform, "lock")
	arg_5_0.giftController = ControllerUtil.GetController(arg_5_0.giftbtnBtn_.gameObject.transform, "lock")
	arg_5_0.skinController = ControllerUtil.GetController(arg_5_0.changeclothesBtn_.gameObject.transform, "lock")
	arg_5_0.feedAllController = ControllerUtil.GetController(arg_5_0.transform_, "feedAll")
	arg_5_0.subtitleBubbleView = SubtitleBubbleView.New(arg_5_0.subtitleView, true)
	arg_5_0.stateController = arg_5_0.mianController:GetController("state")
	arg_5_0.changeFormController = arg_5_0.mianController:GetController("change")
end

function var_0_0.OnEnter(arg_6_0)
	Dorm.DormEntityManager.EnablePlayerInput = false
	arg_6_0.heroEID = arg_6_0.params_.heroEID or arg_6_0.heroEID

	if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
		arg_6_0.stateController:SetSelectedState("dance")

		arg_6_0.heroID = DormUtils.GetEntityData(arg_6_0.heroEID).heroID
		arg_6_0.skinID = DormHeroTools:GetCurSkinID(arg_6_0.heroID)
	else
		arg_6_0.stateController:SetSelectedState("dorm")

		arg_6_0.skinID = DormUtils.GetEntityData(arg_6_0.heroEID).cfgID
		arg_6_0.heroID = BackHomeHeroSkinCfg[arg_6_0.skinID].hero_id
	end

	arg_6_0.canInteractFlag = true
	arg_6_0.archiveID = DormData:GetHeroArchiveID(arg_6_0.heroID)
	arg_6_0.heroInfo = DormData:GetHeroInfo(arg_6_0.archiveID)

	arg_6_0:RefreshView()
	arg_6_0:RegisterEvent()
	arg_6_0.subtitleBubbleView:SetEntityFilter({
		[arg_6_0.heroEID] = true
	})
	arg_6_0.subtitleBubbleView:OnEnter()
end

function var_0_0.OnExit(arg_7_0)
	if arg_7_0.timer then
		FuncTimerManager.inst:RemoveFuncTimer(arg_7_0.timer)

		arg_7_0.timer = nil

		if arg_7_0.imageGo then
			SetActive(arg_7_0.imageGo, false)

			arg_7_0.imageGo = nil
		end

		if arg_7_0.group then
			arg_7_0.group.alpha = 1
			arg_7_0.group = nil
		end
	end

	local var_7_0 = BackHomeDataManager:GetCurSystem()

	arg_7_0.subtitleBubbleView:OnExit()
end

function var_0_0.RegisterEvent(arg_8_0)
	arg_8_0:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, function()
		arg_8_0:RefreshFatigue()
	end)
end

function var_0_0.PickFeedFoodAnime(arg_10_0, arg_10_1)
	local var_10_0 = BackHomeDataManager.GetInstance():GetCurSystem()
	local var_10_1

	if var_10_0 == DormEnum.DormSystemType.CricketBattle then
		local var_10_2 = IdolTraineeCampBridge.GetPosByCharacter(arg_10_1)
		local var_10_3 = string.format("dorm_idol_camp_pos%d_interaction_feed", var_10_2)

		var_10_1 = nullable(GameDisplayCfg, var_10_3, "value")
	elseif var_10_0 == DormEnum.DormSystemType.Dormitory then
		var_10_1 = GameDisplayCfg.dorm_interaction_feed.value
	else
		var_10_1 = GameDisplayCfg.dorm_interaction_feed.value
	end

	return DormHeroTemplate.PickInteractAction(var_10_1)
end

function var_0_0.GetAllHeroInScene(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = BackHomeDataManager.GetInstance():GetCurSystem()

	if var_11_1 == DormEnum.DormSystemType.CricketBattle then
		for iter_11_0, iter_11_1 in pairs(IdolTraineeCampBridge.charaAtPos) do
			var_11_0[iter_11_1] = IdolTraineeCampBridge.GetCharacterHeroID(iter_11_1)
		end
	elseif var_11_1 == DormEnum.DormSystemType.Dormitory then
		local var_11_2 = DormData:GetHeroInfoList()
		local var_11_3 = DormHeroTools:GetAllHeroEIDInCurScene()
		local var_11_4 = DormData:GetCurrectSceneID()

		for iter_11_2, iter_11_3 in pairs(var_11_3) do
			var_11_0[iter_11_3] = BackHomeHeroSkinCfg[iter_11_2].hero_id
		end
	else
		error("未实现")
	end

	return var_11_0
end

function var_0_0.AddUIListener(arg_12_0)
	arg_12_0:AddBtnListenerScale(arg_12_0.giftbtnBtn_, nil, function()
		if arg_12_0.canInteractFlag then
			if not DormRoomTools:GetDormIDViaArchive(arg_12_0.archiveID) then
				ShowTips(GetTips("DORM_HERO_NOT_SET"))

				return
			end

			JumpTools.OpenPageByJump("/dormHeroGiftView", {
				archiveID = arg_12_0.archiveID,
				heroEID = arg_12_0.heroEID
			})
		end
	end)
	arg_12_0:AddBtnListenerScale(arg_12_0.touchbtnBtn_, nil, function()
		if arg_12_0.canInteractFlag then
			if DormHeroTools:GetDormLevelByHeroID(arg_12_0.archiveID) < GameSetting.dorm_menu_touch_unlock.value[1] then
				return
			end

			if arg_12_0.heroInfo and arg_12_0.skinID then
				arg_12_0.canInteractFlag = false

				local var_14_0 = BackHomeDataManager.GetInstance():GetCurSystem()
				local var_14_1

				if var_14_0 == DormEnum.DormSystemType.CricketBattle then
					local var_14_2 = IdolTraineeCampBridge.GetPosByCharacter(arg_12_0.heroEID)
					local var_14_3 = string.format("dorm_idol_camp_pos%d_interaction_stroke", var_14_2)

					var_14_1 = nullable(GameDisplayCfg, var_14_3, "value")
				elseif var_14_0 == DormEnum.DormSystemType.Dormitory then
					var_14_1 = GameDisplayCfg.dorm_interaction_stroke.value
				else
					var_14_1 = GameDisplayCfg.dorm_interaction_stroke.value
				end

				local var_14_4 = DormHeroTemplate.PickInteractAction(var_14_1)
				local var_14_5 = arg_12_0.heroInfo:TouchHero(arg_12_0.heroEID, var_14_4)

				if var_14_5 then
					arg_12_0:InitInteractTimer(var_14_5, arg_12_0.touchBar, arg_12_0.touchGo, arg_12_0.touchGroup)
				else
					arg_12_0.canInteractFlag = true
				end
			end
		end
	end)
	arg_12_0:AddBtnListenerScale(arg_12_0.replacebtnBtn_, nil, function()
		return
	end)

	local function var_12_0(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0

		if arg_16_0 == 1 then
			local var_16_1 = arg_12_0:GetAllHeroInScene()

			var_16_0 = DormHeroTools:FeedMultipleHero(var_16_1, arg_16_1, handler(arg_12_0, arg_12_0.PickFeedFoodAnime))
		else
			var_16_0 = DormData:GetHeroTemplateInfo(arg_16_1):FeedFood(arg_16_2, arg_12_0:PickFeedFoodAnime(arg_16_2))
		end

		if var_16_0 then
			arg_12_0:InitInteractTimer(var_16_0, arg_12_0.feedBar, arg_12_0.feedGo, arg_12_0.feedGroup)
		else
			arg_12_0.canInteractFlag = true
		end

		arg_12_0:RefreshView()
	end

	arg_12_0:AddBtnListenerScale(arg_12_0.feedfoodbtnBtn_, nil, function()
		if arg_12_0.canInteractFlag then
			local var_17_0, var_17_1 = DormData:GetHeroTemplateInfo(arg_12_0.heroID):CheckCanFeedFood()

			if not var_17_0 then
				if var_17_1 == "feedTime" then
					ShowTips(GetTips("DORM_FEED_MAX"))
				elseif var_17_1 == "fatigue" then
					ShowTips(GetTips("DORM_CANT_FEED"))
				end

				return
			end

			if DormitoryData:GetAllFeedFlag() then
				arg_12_0.canInteractFlag = false

				DormAction:GiftFoodToHero(arg_12_0.heroID, nil, 1, var_12_0)
			else
				arg_12_0.canInteractFlag = false

				DormAction:GiftFoodToHero(arg_12_0.heroID, arg_12_0.heroEID, 2, var_12_0)
			end
		end
	end)
	arg_12_0:AddBtnListenerScale(arg_12_0.closebtnBtn_, nil, function()
		local var_18_0 = BackHomeDataManager:GetCurSystem()

		if var_18_0 == DormEnum.DormSystemType.Dormitory then
			Dorm.DormEntityManager.EnablePlayerInput = true

			DormLuaBridge.ChangeCameraMode(0, false)
			manager.notify:Invoke(DORM_RESET_HERO_AI, arg_12_0.heroEID)
			Dorm.DormEntityManager.SetPlayerEntityFaceToCam(arg_12_0.heroEID, false)
			JumpTools.OpenPageByJump("/dorm")

			local var_18_1 = DormUtils.EIdNamespace(DormEnum.CharacterType.DormNormalHero)

			for iter_18_0, iter_18_1 in Dorm.storage:ForeachData(var_18_1, pairs) do
				if iter_18_1 ~= arg_12_0.heroEID then
					Dorm.DormEntityManager.ClearFadeOutPoint(iter_18_1)
				end
			end

			arg_12_0:StopImageTimer()
		elseif var_18_0 == DormEnum.DormSystemType.CricketBattle then
			arg_12_0:StopImageTimer()
			JumpTools.Back()
		end
	end)
	arg_12_0:AddBtnListenerScale(arg_12_0.gameBtn_, nil, function()
		local var_19_0, var_19_1 = BackHomeTools.CheckHeroIsLockForAnyFeatureWithTips(arg_12_0.heroID)

		if var_19_0 then
			ShowTips(var_19_1)

			return
		end

		if arg_12_0.canInteractFlag then
			JumpTools.OpenPageByJump("/dormRhythmGameView", {
				heroID = arg_12_0.heroID,
				heroEID = arg_12_0.heroEID
			})
		end
	end)
	arg_12_0:AddBtnListenerScale(arg_12_0.changeclothesBtn_, nil, function()
		if arg_12_0.canInteractFlag then
			JumpTools.OpenPageByJump("/dormHeroChangeSkinView", {
				heroID = arg_12_0.heroID,
				heroEID = arg_12_0.heroEID
			})
		end
	end)
	arg_12_0:AddBtnListenerScale(arg_12_0.allFeedBtn_, nil, function()
		local var_21_0 = DormitoryData:GetAllFeedFlag()

		DormitoryData:SetAllFeedFlag(not var_21_0)

		if not var_21_0 then
			arg_12_0.feedAllController:SetSelectedState("on")
		else
			arg_12_0.feedAllController:SetSelectedState("off")
		end
	end)
	arg_12_0:AddBtnListenerScale(arg_12_0.trainBtn_, nil, function()
		JumpTools.OpenPageByJump("/idolTraineeTrain", {
			heroID = arg_12_0.heroID
		})
	end)
	arg_12_0:AddBtnListener(arg_12_0.changeFormBtn_, nil, function()
		arg_12_0:ChangeHeroForm()
	end)
end

function var_0_0.StopWaitCamBlend(arg_24_0)
	if arg_24_0.camTimer then
		arg_24_0.camTimer:Stop()

		arg_24_0.camTimer = nil
	end
end

function var_0_0.RefreshView(arg_25_0)
	local var_25_0 = DormHeroTools:GetDormLevelByHeroID(arg_25_0.archiveID)
	local var_25_1 = BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(arg_25_0.heroID)

	if var_25_0 == 0 then
		arg_25_0.giftController:SetSelectedState("lock")
	else
		arg_25_0.giftController:SetSelectedState("normal")
	end

	if var_25_0 < GameSetting.dorm_menu_feed_unlock.value[1] then
		arg_25_0.feedController:SetSelectedState("lock")
	else
		arg_25_0.feedController:SetSelectedState("normal")
	end

	if var_25_0 < GameSetting.dorm_menu_touch_unlock.value[1] then
		arg_25_0.touchController:SetSelectedState("lock")
	else
		arg_25_0.touchController:SetSelectedState("normal")
	end

	arg_25_0.skinController:SetSelectedState("normal")
	arg_25_0.gameController:SetSelectedState(var_25_1 and "lock" or "normal")
	arg_25_0:RefreshFatigue()

	if DormitoryData:GetAllFeedFlag() then
		arg_25_0.feedAllController:SetSelectedState("on")
	else
		arg_25_0.feedAllController:SetSelectedState("off")
	end

	if BackHomeDataManager.GetInstance():GetCurSystem() == DormEnum.DormSystemType.Dormitory and arg_25_0:CheckSkinCanChangeForm() then
		arg_25_0.changeFormController:SetSelectedState("show")
	else
		arg_25_0.changeFormController:SetSelectedState("hide")
	end
end

function var_0_0.RefreshFatigue(arg_26_0)
	arg_26_0.maxFatigue.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
	arg_26_0.curFaitigue.text = arg_26_0.heroInfo:GetFatigue()
	arg_26_0.coverNum.text = string.format(GetTips("DORM_FATIGUE_PER_HOUR"), arg_26_0.heroInfo:GetRecoverFatigueNum())
end

function var_0_0.InitInteractTimer(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	if arg_27_0.timer then
		FuncTimerManager.inst:RemoveFuncTimer(arg_27_0.timer)

		arg_27_0.timer = nil
	end

	arg_27_0.group = arg_27_4
	arg_27_0.imageGo = arg_27_3

	if arg_27_3 and arg_27_2 then
		arg_27_2.fillAmount = 1

		SetActive(arg_27_0.imageGo, true)
	end

	local var_27_0 = math.ceil(arg_27_1)
	local var_27_1 = math.ceil(arg_27_1)

	arg_27_0.group.alpha = 0.6
	arg_27_0.timer = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		var_27_0 = var_27_0 - Time.deltaTime

		local var_28_0 = var_27_1 > 0 and var_27_0 / var_27_1 or 1

		if var_27_0 <= 0 then
			arg_27_0.canInteractFlag = true

			FuncTimerManager.inst:RemoveFuncTimer(arg_27_0.timer)

			arg_27_0.timer = nil

			SetActive(arg_27_0.imageGo, false)

			arg_27_0.group.alpha = 1
		end

		if arg_27_2 and arg_27_3 then
			arg_27_2.fillAmount = var_28_0
		end
	end, -1, true)
end

function var_0_0.StopImageTimer(arg_29_0)
	if arg_29_0.timer then
		FuncTimerManager.inst:RemoveFuncTimer(arg_29_0.timer)

		arg_29_0.timer = nil

		if arg_29_0.imageGo then
			SetActive(arg_29_0.imageGo, false)

			arg_29_0.imageGo = nil
		end

		if arg_29_0.group then
			arg_29_0.group.alpha = 1
			arg_29_0.group = nil
		end
	end
end

function var_0_0.ChangeHeroForm(arg_30_0)
	local var_30_0 = arg_30_0.skinID
	local var_30_1 = arg_30_0.heroID
	local var_30_2 = DormUtils.GetEntityData(arg_30_0.heroEID)
	local var_30_3 = (var_30_2.skinVariant or 0) + 1
	local var_30_4 = nullable(BackHomeHeroSkinVariantCfg, var_30_0)
	local var_30_5 = nullable(var_30_4, "asset_list", var_30_3)

	if var_30_5 then
		var_30_2.skinVariant = var_30_3
	else
		var_30_2.skinVariant = nil
	end

	local var_30_6 = DormCharacterManager.GetGenCharaInfoBySkinID(var_30_0, var_30_5)

	arg_30_0:UpdateCharaModel(var_30_6, var_30_2)
end

function var_0_0.UpdateCharaModel(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0.skinID

	if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
		local var_31_1 = arg_31_2.pos
		local var_31_2 = IdolTraineeCampBridge.GenCharacter(arg_31_2.heroID, var_31_1, arg_31_1, arg_31_2)

		arg_31_0.heroEID = var_31_2

		Dorm.DormEntityManager.StopAllCmd(var_31_2)
		IdolTraineeCampBridge.SetHeroAnimScheme(var_31_2, var_31_1)
		Dorm.DormEntityManager.SetNextIdleNoCrossFade(var_31_2, true)
	else
		DormCharacterManager.LocalSaveCharaSkinVariant(var_31_0, arg_31_2.skinVariant)

		local var_31_3 = Dorm.DormEntityManager.QueryPosition(arg_31_0.heroEID)
		local var_31_4 = Dorm.DormEntityManager.QueryForwardDir(arg_31_0.heroEID)
		local var_31_5 = DormCharacterManager.GetInstance():Generate(var_31_0, true, arg_31_1, arg_31_2)

		arg_31_0.heroEID = var_31_5

		Dorm.DormEntityManager.StopAllCmd(var_31_5)
		Dorm.DormEntityManager.PutEntityLookToDir(var_31_5, var_31_3, var_31_4)
		DormHeroAI:SwitchControl(var_31_5, DormEnum.ControlType.Player)
		Dorm.DormEntityManager.SetPlayerEntityFaceToCam(var_31_5, true)
		DormCharacterInteractBehaviour.SendInternalInteract(var_31_5, var_31_5, "change_skin_self", false)
	end

	arg_31_0.subtitleBubbleView:SetEntityFilter({
		[arg_31_0.heroEID] = true
	})
end

function var_0_0.CheckSkinCanChangeForm(arg_32_0)
	local var_32_0 = arg_32_0.skinID
	local var_32_1 = nullable(BackHomeHeroSkinVariantCfg, var_32_0)

	if var_32_1 and next(var_32_1.asset_list) then
		return true
	end

	return false
end

function var_0_0.Dispose(arg_33_0)
	var_0_0.super.Dispose(arg_33_0)
end

return var_0_0
