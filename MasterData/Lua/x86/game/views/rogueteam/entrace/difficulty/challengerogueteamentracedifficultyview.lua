local ChallengeRogueTeamEntraceDifficultyView = class("ChallengeRogueTeamEntraceDifficultyView", ReduxView)

ChallengeRogueTeamEntraceDifficultyView.SCALE_VALUE = 0.95
ChallengeRogueTeamEntraceDifficultyView.ELLIPSE_A = 1000
ChallengeRogueTeamEntraceDifficultyView.ELLIPSE_B = 400
ChallengeRogueTeamEntraceDifficultyView.ELLIPSE_SQUARE_A = ChallengeRogueTeamEntraceDifficultyView.ELLIPSE_A * ChallengeRogueTeamEntraceDifficultyView.ELLIPSE_A
ChallengeRogueTeamEntraceDifficultyView.ELLIPSE_SQUARE_B = ChallengeRogueTeamEntraceDifficultyView.ELLIPSE_B * ChallengeRogueTeamEntraceDifficultyView.ELLIPSE_B

function ChallengeRogueTeamEntraceDifficultyView:UIName()
	return "Widget/System/Activity_Roulike/RoulikSelectUI"
end

function ChallengeRogueTeamEntraceDifficultyView:UIParent()
	return manager.ui.uiMain.transform
end

function ChallengeRogueTeamEntraceDifficultyView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.selectDifficultyHandler_ = handler(self, self.OnSelectDifficulty)
	self.onClickAffixHandler_ = handler(self, self.OnClickAffix)
	self.itemList_ = {}
	self.tempVector3_ = Vector3(0, 0, 0)
	self.tempEulerAngles_ = Vector3(self.ringTf_.localEulerAngles.x, self.ringTf_.localEulerAngles.y, self.ringTf_.localEulerAngles.z)
	self.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(self.sureBtnGo_, handler(self, self.OnClickBtn))
	self.affixPopView_ = ChallengeRogueTeamEntranceAffixPopView.New(self.tipsGo_)
end

function ChallengeRogueTeamEntraceDifficultyView:OnEnter()
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_DIFFICULTY_SELECT, self.selectDifficultyHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_DIFFICULTY_AFFIX_CLICK, self.onClickAffixHandler_)

	local var_4_0 = ChallengeRogueTeamData:GetUIDifficultyID()
	local var_4_1 = ChallengeRogueTeamData:GetSelectDifficultyID((ChallengeRogueTeamData:GetCacheTemplateID()))

	self.selectDifficultyID_ = var_4_0 ~= 0 and var_4_0 or var_4_1 ~= 0 and var_4_1 or ChallengeRogueTeamTools.GetMaxDifficultyID()
	self.lastAnglesX_ = self.ringTf_.localEulerAngles.x

	if self.params_.isBack then
		self.isFirstEnter_ = true
	end

	self:RefreshUI()
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginDragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Scroll, LuaHelper.EventTriggerAction1(handler(self, self.ScrollFunc)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(handler(self, self.ClickScrollFunc)))
end

function ChallengeRogueTeamEntraceDifficultyView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ChallengeRogueTeamEntraceDifficultyView:OnExit()
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Scroll)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerDown)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_DIFFICULTY_SELECT, self.selectDifficultyHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_DIFFICULTY_AFFIX_CLICK, self.onClickAffixHandler_)
	manager.windowBar:HideBar()
end

function ChallengeRogueTeamEntraceDifficultyView:Dispose()
	self.rogueTeamSureBtnView_:Dispose()

	self.rogueTeamSureBtnView_ = nil
	self.onClickAffixHandler_ = nil

	if self.affixPopView_ then
		self.affixPopView_:Dispose()

		self.affixPopView_ = nil
	end

	for iter_7_0, iter_7_1 in ipairs(self.itemList_) do
		iter_7_1:Dispose()
	end

	self.selectDifficultyHandler_ = nil
	self.itemList_ = nil

	ChallengeRogueTeamEntraceDifficultyView.super.Dispose(self)
end

function ChallengeRogueTeamEntraceDifficultyView:AddListeners()
	self:AddToggleListener(self.scrollView_, function(arg_9_0)
		self:RefreshItemPosition()
		self:PlayAudio()
	end)
	self:AddBtnListener(self.closeBtn_, nil, function()
		self.affixPopView_:Show(false)
	end)
end

function ChallengeRogueTeamEntraceDifficultyView:PlayAudio()
	if math.abs(self.lastAnglesX_ - self.ringTf_.localEulerAngles.x) > 5 then
		ChallengeRogueTeamTools.PlayAudio("node_select_audio_id")

		self.lastAnglesX_ = self.ringTf_.localEulerAngles.x
	end
end

function ChallengeRogueTeamEntraceDifficultyView:OnClickBtn()
	local var_12_0 = self:GetSelectItem()

	if not var_12_0:GetIsUnlock() then
		return
	else
		local function var_12_1()
			ChallengeRogueTeamAction.SetUIDifficulty(self.selectDifficultyID_)

			local var_13_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.CHALLENGE_ROGUE_TEAM, 0, 1, {
				stageType = BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM
			})

			if manager.guide:IsPlaying() then
				ReserveTools.SetHeroList(var_13_0, GameSetting.rogue_team_guide_list.value[1], GameSetting.rogue_team_guide_list.value[2])
			end

			self:Go("/challengeRogueTeamSectionSelectHero", {
				sectionType = BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM,
				heroDataType = HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM,
				reserveParams = var_13_0
			})
		end

		local var_12_2 = var_12_0:GetAffixPool()

		if #var_12_2 > 0 then
			JumpTools.OpenPageByJump("challengeRogueTeamSelectAffixView", {
				difficulty = var_12_0:GetDifficultyID(),
				affixPool = var_12_2,
				clickFunc = var_12_1
			})
		else
			var_12_1()
		end
	end
end

function ChallengeRogueTeamEntraceDifficultyView:RefreshUI()
	for iter_14_0, iter_14_1 in ipairs(RogueTeamDifficultyCfg.get_id_list_by_template_id[RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].difficulty_temp]) do
		self.itemList_[iter_14_0] = self.itemList_[iter_14_0] or ChallengeRogueTeamEntraceDifficultyItem.New(self.difficultyItem_, self.difficultyParent_)

		self.itemList_[iter_14_0]:SetDifficulty(iter_14_1)
	end

	self:RefreshSelectDifficulty(self.selectDifficultyID_)
	FrameTimer.New(function()
		self:OverMoveAction()
		self:RefreshItemPosition()
	end, 1, 1):Start()
end

function ChallengeRogueTeamEntraceDifficultyView:OnSelectDifficulty(arg_16_1)
	if self.isPopFlag_ then
		self:HideAffixPop()

		return
	end

	self.selectDifficultyID_ = arg_16_1

	self:HideAffixPop()
	self:RefreshSelectBtn()
	self:Scroll2SelectItem()
end

function ChallengeRogueTeamEntraceDifficultyView:OnClickAffix()
	if self.isPopFlag_ then
		self.affixPopView_:Show(false)
	else
		self.affixPopView_:SetData(self.selectDifficultyID_)
	end

	self.isPopFlag_ = not self.isPopFlag_
end

function ChallengeRogueTeamEntraceDifficultyView:HideAffixPop()
	self.isPopFlag_ = false

	if self.affixPopView_ then
		self.affixPopView_:Show(false)
	end
end

function ChallengeRogueTeamEntraceDifficultyView:ClickScrollFunc()
	if self.isPopFlag_ then
		self:HideAffixPop()
	end
end

function ChallengeRogueTeamEntraceDifficultyView:RefreshSelectDifficulty(arg_20_1)
	self.selectDifficultyID_ = arg_20_1

	for iter_20_0, iter_20_1 in ipairs(self.itemList_) do
		iter_20_1:SetSelectDifficulty(arg_20_1)
	end

	self:RefreshSelectBtn()
	self:Scroll2SelectItem()
end

function ChallengeRogueTeamEntraceDifficultyView:RefreshSelectBtn()
	if self:GetSelectItem():GetIsUnlock() then
		self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK)
	else
		self.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.DISENABLE_CLICK)
	end
end

function ChallengeRogueTeamEntraceDifficultyView:RefreshItemPosition()
	for iter_22_0, iter_22_1 in ipairs(self.itemList_) do
		local var_22_0 = iter_22_1:GetLocalPosition().y + self.contentTf_.localPosition.y + self.scrollTf_.rect.height / 2

		if var_22_0 > ChallengeRogueTeamEntraceDifficultyView.ELLIPSE_A then
			var_22_0 = ChallengeRogueTeamEntraceDifficultyView.ELLIPSE_A
		end

		local var_22_2
		local var_22_1

		if var_22_0 < ChallengeRogueTeamEntraceDifficultyView.ELLIPSE_A * -1 then
			var_22_0 = ChallengeRogueTeamEntraceDifficultyView.ELLIPSE_A * -1
			var_22_1 = math.sqrt((math.abs(ChallengeRogueTeamEntraceDifficultyView.ELLIPSE_SQUARE_B - ChallengeRogueTeamEntraceDifficultyView.ELLIPSE_SQUARE_B / ChallengeRogueTeamEntraceDifficultyView.ELLIPSE_SQUARE_A * var_22_0 * var_22_0)))
			var_22_2 = math.acos(var_22_1 / math.sqrt(var_22_1 * var_22_1 + var_22_0 * var_22_0)) / math.pi * 180
		end

		iter_22_1:SetChildrenTransform((var_22_1 - ChallengeRogueTeamEntraceDifficultyView.ELLIPSE_B) * -1, 1 - math.abs((ChallengeRogueTeamEntraceDifficultyView.SCALE_VALUE - 1) / ChallengeRogueTeamEntraceDifficultyView.ELLIPSE_A * var_22_0), var_22_2)
		iter_22_1:RefreshSelectState(math.abs(self.contentTf_.localPosition.y + iter_22_1:GetLocalPosition().y + self.scrollTf_.rect.height / 2) <= 40)
	end

	self.tempEulerAngles_.x = self.contentTf_.localPosition.y / 10
	self.ringTf_.localEulerAngles = self.tempEulerAngles_
end

function ChallengeRogueTeamEntraceDifficultyView:BeginDragFun(arg_23_1, arg_23_2)
	self:StopMoveTimer()
	self:StopScrollTimer()
	self.scrollView_:OnBeginDrag(arg_23_2)
	self:HideAffixPop()
end

function ChallengeRogueTeamEntraceDifficultyView:EndDragFun(arg_24_1, arg_24_2)
	self.scrollView_:OnEndDrag(arg_24_2)
	self:ContinueScrollTimer()
end

function ChallengeRogueTeamEntraceDifficultyView:ScrollFunc(arg_25_1, arg_25_2)
	self:BeginDragFun(arg_25_1, arg_25_2)
	self:EndDragFun(arg_25_1, arg_25_2)
end

function ChallengeRogueTeamEntraceDifficultyView:StopScrollTimer()
	if self.scrollTimer_ then
		self.scrollTimer_:Stop()

		self.scrollTimer_ = nil
	end
end

function ChallengeRogueTeamEntraceDifficultyView:StopMoveTimer()
	if self.moveTimer_ then
		self.moveTimer_:Stop()

		self.moveTimer_ = nil
	end
end

function ChallengeRogueTeamEntraceDifficultyView:ContinueScrollTimer()
	self:StopScrollTimer()

	self.scrollTimer_ = nil
	self.scrollTimer_ = FrameTimer.New(function()
		if math.abs(self.scrollView_.velocity.y) <= 100 then
			self.scrollTimer_:Stop()
			self:AdjustItem()
		end
	end, 1, -1)

	self.scrollTimer_:Start()
end

function ChallengeRogueTeamEntraceDifficultyView:AdjustItem()
	self:RefreshSelectDifficulty(self:GetNearestItem():GetDifficultyID())
end

function ChallengeRogueTeamEntraceDifficultyView:GetNearestItem()
	local var_31_0

	for iter_31_0, iter_31_1 in ipairs(self.itemList_) do
		if math.abs(self.contentTf_.localPosition.y + iter_31_1:GetLocalPosition().y + self.scrollTf_.rect.height / 2) < 9999 then
			var_31_0 = iter_31_1
		end
	end

	return var_31_0
end

function ChallengeRogueTeamEntraceDifficultyView:Scroll2SelectItem()
	for iter_32_0, iter_32_1 in ipairs(self.itemList_) do
		if iter_32_1:GetDifficultyID() == self.selectDifficultyID_ then
			self:AddMoveTimer(iter_32_1)
		end
	end
end

function ChallengeRogueTeamEntraceDifficultyView:AddMoveTimer(arg_33_1)
	self:StopMoveTimer()

	self.moveTimer_ = FrameTimer.New(function()
		local var_34_0 = arg_33_1:GetLocalPosition().y * -1 - self.scrollTf_.rect.height / 2

		self.tempVector3_.x = self.contentTf_.localPosition.x
		self.tempVector3_.y = var_34_0
		self.tempVector3_.z = self.contentTf_.localPosition.z

		local var_34_1 = Vector3.Lerp(self.contentTf_.localPosition, self.tempVector3_, GameSetting.challenge_velocity_times.value[1] * math.pow(self.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime)

		if GameSetting.challenge_scroll_min_length.value[1] > math.abs(self.contentTf_.localPosition.y - var_34_1.y) then
			local var_34_2 = var_34_0 - self.contentTf_.localPosition.y

			if GameSetting.challenge_scroll_min_length.value[1] < math.abs(var_34_0 - self.contentTf_.localPosition.y) then
				var_34_2 = GameSetting.challenge_scroll_min_length.value[1] * var_34_2 / math.abs(var_34_2)
			end

			var_34_1.y = var_34_1.y + var_34_2
		end

		self.contentTf_.localPosition = var_34_1

		if math.abs(self.contentTf_.localPosition.y - var_34_0) <= GameSetting.challenge_stop_min_length.value[1] then
			self.scrollView_:StopMovement()
			self:StopMoveTimer()
			self:OverMoveAction()
			self:HideAffixPop()
		end
	end, 1, -1)

	self.moveTimer_:Start()
end

function ChallengeRogueTeamEntraceDifficultyView:OverMoveAction()
	self.tempVector3_.x = self.contentTf_.localPosition.x
	self.tempVector3_.y = self:GetSelectItem():GetLocalPosition().y * -1 - self.scrollTf_.rect.height / 2
	self.tempVector3_.z = self.contentTf_.localPosition.z
	self.contentTf_.localPosition = self.tempVector3_
	self.lastAnglesX_ = self.ringTf_.localEulerAngles.x
end

function ChallengeRogueTeamEntraceDifficultyView:GetSelectItem()
	for iter_36_0, iter_36_1 in ipairs(self.itemList_) do
		if iter_36_1:GetDifficultyID() == self.selectDifficultyID_ then
			return iter_36_1
		end
	end

	return self.itemList_[1]
end

return ChallengeRogueTeamEntraceDifficultyView
