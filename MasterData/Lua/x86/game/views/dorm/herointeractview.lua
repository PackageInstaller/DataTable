local HeroInteractView = class("HeroInteractView", ReduxView)

function HeroInteractView:UIName()
	return "Widget/BackHouseUI/Dorm/DormInteractionUI"
end

function HeroInteractView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroInteractView:OnCtor()
	return
end

function HeroInteractView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroInteractView:InitUI()
	self:BindCfgUI()

	self.touchController = ControllerUtil.GetController(self.touchbtnBtn_.gameObject.transform, "lock")
	self.gameController = ControllerUtil.GetController(self.gameBtn_.gameObject.transform, "lock")
	self.feedController = ControllerUtil.GetController(self.feedfoodbtnBtn_.gameObject.transform, "lock")
	self.giftController = ControllerUtil.GetController(self.giftbtnBtn_.gameObject.transform, "lock")
	self.skinController = ControllerUtil.GetController(self.changeclothesBtn_.gameObject.transform, "lock")
	self.feedAllController = ControllerUtil.GetController(self.transform_, "feedAll")
	self.subtitleBubbleView = SubtitleBubbleView.New(self.subtitleView, true)
	self.stateController = self.mianController:GetController("state")
	self.changeFormController = self.mianController:GetController("change")
end

function HeroInteractView:OnEnter()
	Dorm.DormEntityManager.EnablePlayerInput = false
	self.heroEID = self.params_.heroEID or self.heroEID

	if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
		self.stateController:SetSelectedState("dance")

		self.heroID = DormUtils.GetEntityData(self.heroEID).heroID
		self.skinID = DormHeroTools:GetCurSkinID(self.heroID)
	else
		self.stateController:SetSelectedState("dorm")

		self.skinID = DormUtils.GetEntityData(self.heroEID).cfgID
		self.heroID = BackHomeHeroSkinCfg[self.skinID].hero_id
	end

	self.canInteractFlag = true
	self.archiveID = DormData:GetHeroArchiveID(self.heroID)
	self.heroInfo = DormData:GetHeroInfo(self.archiveID)

	self:RefreshView()
	self:RegisterEvent()
	self.subtitleBubbleView:SetEntityFilter({
		[self.heroEID] = true
	})
	self.subtitleBubbleView:OnEnter()
end

function HeroInteractView:OnExit()
	if self.timer then
		FuncTimerManager.inst:RemoveFuncTimer(self.timer)

		self.timer = nil

		if self.imageGo then
			SetActive(self.imageGo, false)

			self.imageGo = nil
		end

		if self.group then
			self.group.alpha = 1
			self.group = nil
		end
	end

	local var_7_0 = BackHomeDataManager:GetCurSystem()

	self.subtitleBubbleView:OnExit()
end

function HeroInteractView:RegisterEvent()
	self:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, function()
		self:RefreshFatigue()
	end)
end

function HeroInteractView:PickFeedFoodAnime(arg_10_1)
	local var_10_0 = BackHomeDataManager.GetInstance():GetCurSystem()

	return DormHeroTemplate.PickInteractAction(var_10_0 == DormEnum.DormSystemType.CricketBattle and nullable(GameDisplayCfg, string.format("dorm_idol_camp_pos%d_interaction_feed", (IdolTraineeCampBridge.GetPosByCharacter(arg_10_1))), "value") or var_10_0 == DormEnum.DormSystemType.Dormitory and GameDisplayCfg.dorm_interaction_feed.value or GameDisplayCfg.dorm_interaction_feed.value)
end

function HeroInteractView:GetAllHeroInScene()
	local var_11_0 = {}
	local var_11_1 = BackHomeDataManager.GetInstance():GetCurSystem()

	if var_11_1 == DormEnum.DormSystemType.CricketBattle then
		for iter_11_0, iter_11_1 in pairs(IdolTraineeCampBridge.charaAtPos) do
			var_11_0[iter_11_1] = IdolTraineeCampBridge.GetCharacterHeroID(iter_11_1)
		end
	elseif var_11_1 == DormEnum.DormSystemType.Dormitory then
		local var_11_2 = DormData:GetHeroInfoList()
		local var_11_3 = DormData:GetCurrectSceneID()

		for iter_11_2, iter_11_3 in pairs((DormHeroTools:GetAllHeroEIDInCurScene())) do
			var_11_0[iter_11_3] = BackHomeHeroSkinCfg[iter_11_2].hero_id
		end
	else
		error("未实现")
	end

	return var_11_0
end

function HeroInteractView:AddUIListener()
	self:AddBtnListenerScale(self.giftbtnBtn_, nil, function()
		if self.canInteractFlag then
			if not DormRoomTools:GetDormIDViaArchive(self.archiveID) then
				ShowTips(GetTips("DORM_HERO_NOT_SET"))

				return
			end

			JumpTools.OpenPageByJump("/dormHeroGiftView", {
				archiveID = self.archiveID,
				heroEID = self.heroEID
			})
		end
	end)
	self:AddBtnListenerScale(self.touchbtnBtn_, nil, function()
		if self.canInteractFlag then
			if DormHeroTools:GetDormLevelByHeroID(self.archiveID) < GameSetting.dorm_menu_touch_unlock.value[1] then
				return
			end

			if self.heroInfo and self.skinID then
				self.canInteractFlag = false

				local var_14_0 = BackHomeDataManager.GetInstance():GetCurSystem()
				local var_14_2 = self.heroInfo:TouchHero(self.heroEID, (DormHeroTemplate.PickInteractAction(var_14_0 == DormEnum.DormSystemType.CricketBattle and nullable(GameDisplayCfg, string.format("dorm_idol_camp_pos%d_interaction_stroke", (IdolTraineeCampBridge.GetPosByCharacter(self.heroEID))), "value") or var_14_0 == DormEnum.DormSystemType.Dormitory and GameDisplayCfg.dorm_interaction_stroke.value or GameDisplayCfg.dorm_interaction_stroke.value)))

				if var_14_2 then
					self:InitInteractTimer(var_14_2, self.touchBar, self.touchGo, self.touchGroup)
				else
					self.canInteractFlag = true
				end
			end
		end
	end)
	self:AddBtnListenerScale(self.replacebtnBtn_, nil, function()
		return
	end)

	local function var_12_0(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_16_0 == 1 and DormHeroTools:FeedMultipleHero(self:GetAllHeroInScene(), arg_16_1, handler(self, self.PickFeedFoodAnime)) or DormData:GetHeroTemplateInfo(arg_16_1):FeedFood(arg_16_2, self:PickFeedFoodAnime(arg_16_2))

		if var_16_0 then
			self:InitInteractTimer(var_16_0, self.feedBar, self.feedGo, self.feedGroup)
		else
			self.canInteractFlag = true
		end

		self:RefreshView()
	end

	self:AddBtnListenerScale(self.feedfoodbtnBtn_, nil, function()
		if self.canInteractFlag then
			local var_17_0, var_17_1 = DormData:GetHeroTemplateInfo(self.heroID):CheckCanFeedFood()

			if not var_17_0 then
				if var_17_1 == "feedTime" then
					ShowTips(GetTips("DORM_FEED_MAX"))
				elseif var_17_1 == "fatigue" then
					ShowTips(GetTips("DORM_CANT_FEED"))
				end

				return
			end

			if DormitoryData:GetAllFeedFlag() then
				self.canInteractFlag = false

				DormAction:GiftFoodToHero(self.heroID, nil, 1, var_12_0)
			else
				self.canInteractFlag = false

				DormAction:GiftFoodToHero(self.heroID, self.heroEID, 2, var_12_0)
			end
		end
	end)
	self:AddBtnListenerScale(self.closebtnBtn_, nil, function()
		local var_18_0 = BackHomeDataManager:GetCurSystem()

		if var_18_0 == DormEnum.DormSystemType.Dormitory then
			Dorm.DormEntityManager.EnablePlayerInput = true

			DormLuaBridge.ChangeCameraMode(0, false)
			manager.notify:Invoke(DORM_RESET_HERO_AI, self.heroEID)
			Dorm.DormEntityManager.SetPlayerEntityFaceToCam(self.heroEID, false)
			JumpTools.OpenPageByJump("/dorm")

			for iter_18_0, iter_18_1 in Dorm.storage:ForeachData(DormUtils.EIdNamespace(DormEnum.CharacterType.DormNormalHero), pairs) do
				if iter_18_1 ~= self.heroEID then
					Dorm.DormEntityManager.ClearFadeOutPoint(iter_18_1)
				end
			end

			self:StopImageTimer()
		elseif var_18_0 == DormEnum.DormSystemType.CricketBattle then
			self:StopImageTimer()
			JumpTools.Back()
		end
	end)
	self:AddBtnListenerScale(self.gameBtn_, nil, function()
		local var_19_0, var_19_1 = BackHomeTools.CheckHeroIsLockForAnyFeatureWithTips(self.heroID)

		if var_19_0 then
			ShowTips(var_19_1)

			return
		end

		if self.canInteractFlag then
			JumpTools.OpenPageByJump("/dormRhythmGameView", {
				heroID = self.heroID,
				heroEID = self.heroEID
			})
		end
	end)
	self:AddBtnListenerScale(self.changeclothesBtn_, nil, function()
		if self.canInteractFlag then
			JumpTools.OpenPageByJump("/dormHeroChangeSkinView", {
				heroID = self.heroID,
				heroEID = self.heroEID
			})
		end
	end)
	self:AddBtnListenerScale(self.allFeedBtn_, nil, function()
		local var_21_0 = DormitoryData:GetAllFeedFlag()

		DormitoryData:SetAllFeedFlag(not var_21_0)

		if not var_21_0 then
			self.feedAllController:SetSelectedState("on")
		else
			self.feedAllController:SetSelectedState("off")
		end
	end)
	self:AddBtnListenerScale(self.trainBtn_, nil, function()
		JumpTools.OpenPageByJump("/idolTraineeTrain", {
			heroID = self.heroID
		})
	end)
	self:AddBtnListener(self.changeFormBtn_, nil, function()
		self:ChangeHeroForm()
	end)
end

function HeroInteractView:StopWaitCamBlend()
	if self.camTimer then
		self.camTimer:Stop()

		self.camTimer = nil
	end
end

function HeroInteractView:RefreshView()
	local var_25_0 = DormHeroTools:GetDormLevelByHeroID(self.archiveID)
	local var_25_1 = BackHomeTools.CheckHeroIsLockForAnyFeatureByHeroID(self.heroID)

	if var_25_0 == 0 then
		self.giftController:SetSelectedState("lock")
	else
		self.giftController:SetSelectedState("normal")
	end

	if var_25_0 < GameSetting.dorm_menu_feed_unlock.value[1] then
		self.feedController:SetSelectedState("lock")
	else
		self.feedController:SetSelectedState("normal")
	end

	if var_25_0 < GameSetting.dorm_menu_touch_unlock.value[1] then
		self.touchController:SetSelectedState("lock")
	else
		self.touchController:SetSelectedState("normal")
	end

	self.skinController:SetSelectedState("normal")
	self.gameController:SetSelectedState(var_25_1 and "lock" or "normal")
	self:RefreshFatigue()

	if DormitoryData:GetAllFeedFlag() then
		self.feedAllController:SetSelectedState("on")
	else
		self.feedAllController:SetSelectedState("off")
	end

	if BackHomeDataManager.GetInstance():GetCurSystem() == DormEnum.DormSystemType.Dormitory and self:CheckSkinCanChangeForm() then
		self.changeFormController:SetSelectedState("show")
	else
		self.changeFormController:SetSelectedState("hide")
	end
end

function HeroInteractView:RefreshFatigue()
	self.maxFatigue.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
	self.curFaitigue.text = self.heroInfo:GetFatigue()
	self.coverNum.text = string.format(GetTips("DORM_FATIGUE_PER_HOUR"), self.heroInfo:GetRecoverFatigueNum())
end

function HeroInteractView:InitInteractTimer(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	if self.timer then
		FuncTimerManager.inst:RemoveFuncTimer(self.timer)

		self.timer = nil
	end

	self.group = arg_27_4
	self.imageGo = arg_27_3

	if arg_27_3 and arg_27_2 then
		arg_27_2.fillAmount = 1

		SetActive(self.imageGo, true)
	end

	local var_27_0 = math.ceil(arg_27_1)
	local var_27_1 = math.ceil(arg_27_1)

	self.group.alpha = 0.6
	self.timer = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		var_27_0 = var_27_0 - Time.deltaTime

		if var_27_1 > 0 then
			local var_28_0 = var_27_0 / var_27_1 or 1

			if var_27_0 <= 0 then
				self.canInteractFlag = true

				FuncTimerManager.inst:RemoveFuncTimer(self.timer)

				self.timer = nil

				SetActive(self.imageGo, false)

				self.group.alpha = 1
			end

			if arg_27_2 and arg_27_3 then
				arg_27_2.fillAmount = var_28_0
			end
		end
	end, -1, true)
end

function HeroInteractView:StopImageTimer()
	if self.timer then
		FuncTimerManager.inst:RemoveFuncTimer(self.timer)

		self.timer = nil

		if self.imageGo then
			SetActive(self.imageGo, false)

			self.imageGo = nil
		end

		if self.group then
			self.group.alpha = 1
			self.group = nil
		end
	end
end

function HeroInteractView:ChangeHeroForm()
	local var_30_1 = DormUtils.GetEntityData(self.heroEID)
	local var_30_2 = (var_30_1.skinVariant or 0) + 1
	local var_30_3 = nullable(nullable(BackHomeHeroSkinVariantCfg, self.skinID), "asset_list", (var_30_1.skinVariant or 0) + 1)

	var_30_1.skinVariant = var_30_3 and var_30_2 or nil

	self:UpdateCharaModel(DormCharacterManager.GetGenCharaInfoBySkinID(self.skinID, var_30_3), var_30_1)
end

function HeroInteractView:UpdateCharaModel(arg_31_1, arg_31_2)
	if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
		local var_31_0 = IdolTraineeCampBridge.GenCharacter(arg_31_2.heroID, arg_31_2.pos, arg_31_1, arg_31_2)

		self.heroEID = var_31_0

		Dorm.DormEntityManager.StopAllCmd(var_31_0)
		IdolTraineeCampBridge.SetHeroAnimScheme(var_31_0, arg_31_2.pos)
		Dorm.DormEntityManager.SetNextIdleNoCrossFade(var_31_0, true)
	else
		DormCharacterManager.LocalSaveCharaSkinVariant(self.skinID, arg_31_2.skinVariant)

		local var_31_1 = DormCharacterManager.GetInstance():Generate(self.skinID, true, arg_31_1, arg_31_2)

		self.heroEID = var_31_1

		Dorm.DormEntityManager.StopAllCmd(var_31_1)
		Dorm.DormEntityManager.PutEntityLookToDir(var_31_1, Dorm.DormEntityManager.QueryPosition(self.heroEID), (Dorm.DormEntityManager.QueryForwardDir(self.heroEID)))
		DormHeroAI:SwitchControl(var_31_1, DormEnum.ControlType.Player)
		Dorm.DormEntityManager.SetPlayerEntityFaceToCam(var_31_1, true)
		DormCharacterInteractBehaviour.SendInternalInteract(var_31_1, var_31_1, "change_skin_self", false)
	end

	self.subtitleBubbleView:SetEntityFilter({
		[self.heroEID] = true
	})
end

function HeroInteractView:CheckSkinCanChangeForm()
	local var_32_0 = nullable(BackHomeHeroSkinVariantCfg, self.skinID)

	if var_32_0 and next(var_32_0.asset_list) then
		return true
	end

	return false
end

function HeroInteractView:Dispose()
	HeroInteractView.super.Dispose(self)
end

return HeroInteractView
