local var_0_0 = class("ChallengeRogueTeamEntraceDifficultyView", ReduxView)

var_0_0.SCALE_VALUE = 0.95
var_0_0.ELLIPSE_A = 1000
var_0_0.ELLIPSE_B = 400
var_0_0.ELLIPSE_SQUARE_A = var_0_0.ELLIPSE_A * var_0_0.ELLIPSE_A
var_0_0.ELLIPSE_SQUARE_B = var_0_0.ELLIPSE_B * var_0_0.ELLIPSE_B

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RoulikSelectUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.selectDifficultyHandler_ = handler(arg_3_0, arg_3_0.OnSelectDifficulty)
	arg_3_0.onClickAffixHandler_ = handler(arg_3_0, arg_3_0.OnClickAffix)
	arg_3_0.itemList_ = {}
	arg_3_0.tempVector3_ = Vector3(0, 0, 0)

	local var_3_0 = arg_3_0.ringTf_.localEulerAngles

	arg_3_0.tempEulerAngles_ = Vector3(var_3_0.x, var_3_0.y, var_3_0.z)
	arg_3_0.rogueTeamSureBtnView_ = ChallengeRogueTeamButton.New(arg_3_0.sureBtnGo_, handler(arg_3_0, arg_3_0.OnClickBtn))
	arg_3_0.affixPopView_ = ChallengeRogueTeamEntranceAffixPopView.New(arg_3_0.tipsGo_)
end

function var_0_0.OnEnter(arg_4_0)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_DIFFICULTY_SELECT, arg_4_0.selectDifficultyHandler_)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_DIFFICULTY_AFFIX_CLICK, arg_4_0.onClickAffixHandler_)

	local var_4_0 = ChallengeRogueTeamData:GetCacheTemplateID()
	local var_4_1 = ChallengeRogueTeamData:GetUIDifficultyID()
	local var_4_2 = ChallengeRogueTeamData:GetSelectDifficultyID(var_4_0)

	if var_4_1 ~= 0 then
		arg_4_0.selectDifficultyID_ = var_4_1
	elseif var_4_2 ~= 0 then
		arg_4_0.selectDifficultyID_ = var_4_2
	else
		arg_4_0.selectDifficultyID_ = ChallengeRogueTeamTools.GetMaxDifficultyID()
	end

	arg_4_0.lastAnglesX_ = arg_4_0.ringTf_.localEulerAngles.x

	if arg_4_0.params_.isBack then
		arg_4_0.isFirstEnter_ = true
	end

	arg_4_0:RefreshUI()
	arg_4_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.BeginDragFun)))
	arg_4_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.EndDragFun)))
	arg_4_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Scroll, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.ScrollFunc)))
	arg_4_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.ClickScrollFunc)))
end

function var_0_0.OnTop(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_6_0)
	arg_6_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_6_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	arg_6_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Scroll)
	arg_6_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerDown)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_DIFFICULTY_SELECT, arg_6_0.selectDifficultyHandler_)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_DIFFICULTY_AFFIX_CLICK, arg_6_0.onClickAffixHandler_)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.rogueTeamSureBtnView_:Dispose()

	arg_7_0.rogueTeamSureBtnView_ = nil
	arg_7_0.onClickAffixHandler_ = nil

	if arg_7_0.affixPopView_ then
		arg_7_0.affixPopView_:Dispose()

		arg_7_0.affixPopView_ = nil
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.itemList_) do
		iter_7_1:Dispose()
	end

	arg_7_0.selectDifficultyHandler_ = nil
	arg_7_0.itemList_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddToggleListener(arg_8_0.scrollView_, function(arg_9_0)
		arg_8_0:RefreshItemPosition()
		arg_8_0:PlayAudio()
	end)
	arg_8_0:AddBtnListener(arg_8_0.closeBtn_, nil, function()
		arg_8_0.affixPopView_:Show(false)
	end)
end

function var_0_0.PlayAudio(arg_11_0)
	local var_11_0 = arg_11_0.ringTf_.localEulerAngles.x

	if math.abs(arg_11_0.lastAnglesX_ - var_11_0) > 5 then
		ChallengeRogueTeamTools.PlayAudio("node_select_audio_id")

		arg_11_0.lastAnglesX_ = var_11_0
	end
end

function var_0_0.OnClickBtn(arg_12_0)
	local var_12_0 = arg_12_0:GetSelectItem()

	if not var_12_0:GetIsUnlock() then
		return
	else
		local function var_12_1()
			ChallengeRogueTeamAction.SetUIDifficulty(arg_12_0.selectDifficultyID_)

			local var_13_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.CHALLENGE_ROGUE_TEAM, 0, 1, {
				stageType = BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM
			})

			if manager.guide:IsPlaying() then
				local var_13_1 = GameSetting.rogue_team_guide_list.value

				ReserveTools.SetHeroList(var_13_0, var_13_1[1], var_13_1[2])
			end

			arg_12_0:Go("/challengeRogueTeamSectionSelectHero", {
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

function var_0_0.RefreshUI(arg_14_0)
	local var_14_0 = ChallengeRogueTeamData:GetCacheTemplateID()
	local var_14_1 = RogueTeamCfg[var_14_0].difficulty_temp

	for iter_14_0, iter_14_1 in ipairs(RogueTeamDifficultyCfg.get_id_list_by_template_id[var_14_1]) do
		arg_14_0.itemList_[iter_14_0] = arg_14_0.itemList_[iter_14_0] or ChallengeRogueTeamEntraceDifficultyItem.New(arg_14_0.difficultyItem_, arg_14_0.difficultyParent_)

		arg_14_0.itemList_[iter_14_0]:SetDifficulty(iter_14_1)
	end

	arg_14_0:RefreshSelectDifficulty(arg_14_0.selectDifficultyID_)
	FrameTimer.New(function()
		arg_14_0:OverMoveAction()
		arg_14_0:RefreshItemPosition()
	end, 1, 1):Start()
end

function var_0_0.OnSelectDifficulty(arg_16_0, arg_16_1)
	if arg_16_0.isPopFlag_ then
		arg_16_0:HideAffixPop()

		return
	end

	arg_16_0.selectDifficultyID_ = arg_16_1

	arg_16_0:HideAffixPop()
	arg_16_0:RefreshSelectBtn()
	arg_16_0:Scroll2SelectItem()
end

function var_0_0.OnClickAffix(arg_17_0)
	if arg_17_0.isPopFlag_ then
		arg_17_0.affixPopView_:Show(false)
	else
		arg_17_0.affixPopView_:SetData(arg_17_0.selectDifficultyID_)
	end

	arg_17_0.isPopFlag_ = not arg_17_0.isPopFlag_
end

function var_0_0.HideAffixPop(arg_18_0)
	arg_18_0.isPopFlag_ = false

	if arg_18_0.affixPopView_ then
		arg_18_0.affixPopView_:Show(false)
	end
end

function var_0_0.ClickScrollFunc(arg_19_0)
	if arg_19_0.isPopFlag_ then
		arg_19_0:HideAffixPop()
	end
end

function var_0_0.RefreshSelectDifficulty(arg_20_0, arg_20_1)
	arg_20_0.selectDifficultyID_ = arg_20_1

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.itemList_) do
		iter_20_1:SetSelectDifficulty(arg_20_1)
	end

	arg_20_0:RefreshSelectBtn()
	arg_20_0:Scroll2SelectItem()
end

function var_0_0.RefreshSelectBtn(arg_21_0)
	if arg_21_0:GetSelectItem():GetIsUnlock() then
		arg_21_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.ENABLE_CLICK)
	else
		arg_21_0.rogueTeamSureBtnView_:RefreshBtnState(ChallengeRogueTeamButton.DISENABLE_CLICK)
	end
end

function var_0_0.RefreshItemPosition(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.itemList_) do
		local var_22_0 = iter_22_1:GetLocalPosition().y + arg_22_0.contentTf_.localPosition.y + arg_22_0.scrollTf_.rect.height / 2

		if var_22_0 > var_0_0.ELLIPSE_A then
			var_22_0 = var_0_0.ELLIPSE_A
		end

		if var_22_0 < var_0_0.ELLIPSE_A * -1 then
			var_22_0 = var_0_0.ELLIPSE_A * -1
		end

		local var_22_1 = 1 - math.abs((var_0_0.SCALE_VALUE - 1) / var_0_0.ELLIPSE_A * var_22_0)
		local var_22_2 = math.abs(var_0_0.ELLIPSE_SQUARE_B - var_0_0.ELLIPSE_SQUARE_B / var_0_0.ELLIPSE_SQUARE_A * var_22_0 * var_22_0)
		local var_22_3 = math.sqrt(var_22_2)
		local var_22_4 = math.sqrt(var_22_3 * var_22_3 + var_22_0 * var_22_0)
		local var_22_5 = math.acos(var_22_3 / var_22_4) / math.pi * 180
		local var_22_6 = var_22_3 - var_0_0.ELLIPSE_B

		iter_22_1:SetChildrenTransform(var_22_6 * -1, var_22_1, var_22_5)

		local var_22_7 = math.abs(arg_22_0.contentTf_.localPosition.y + iter_22_1:GetLocalPosition().y + arg_22_0.scrollTf_.rect.height / 2) <= 40

		iter_22_1:RefreshSelectState(var_22_7)
	end

	arg_22_0.tempEulerAngles_.x = arg_22_0.contentTf_.localPosition.y / 10
	arg_22_0.ringTf_.localEulerAngles = arg_22_0.tempEulerAngles_
end

function var_0_0.BeginDragFun(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:StopMoveTimer()
	arg_23_0:StopScrollTimer()
	arg_23_0.scrollView_:OnBeginDrag(arg_23_2)
	arg_23_0:HideAffixPop()
end

function var_0_0.EndDragFun(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0.scrollView_:OnEndDrag(arg_24_2)
	arg_24_0:ContinueScrollTimer()
end

function var_0_0.ScrollFunc(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:BeginDragFun(arg_25_1, arg_25_2)
	arg_25_0:EndDragFun(arg_25_1, arg_25_2)
end

function var_0_0.StopScrollTimer(arg_26_0)
	if arg_26_0.scrollTimer_ then
		arg_26_0.scrollTimer_:Stop()

		arg_26_0.scrollTimer_ = nil
	end
end

function var_0_0.StopMoveTimer(arg_27_0)
	if arg_27_0.moveTimer_ then
		arg_27_0.moveTimer_:Stop()

		arg_27_0.moveTimer_ = nil
	end
end

function var_0_0.ContinueScrollTimer(arg_28_0)
	arg_28_0:StopScrollTimer()

	arg_28_0.scrollTimer_ = nil
	arg_28_0.scrollTimer_ = FrameTimer.New(function()
		if math.abs(arg_28_0.scrollView_.velocity.y) <= 100 then
			arg_28_0.scrollTimer_:Stop()
			arg_28_0:AdjustItem()
		end
	end, 1, -1)

	arg_28_0.scrollTimer_:Start()
end

function var_0_0.AdjustItem(arg_30_0)
	local var_30_0 = arg_30_0:GetNearestItem()

	arg_30_0:RefreshSelectDifficulty(var_30_0:GetDifficultyID())
end

function var_0_0.GetNearestItem(arg_31_0)
	local var_31_0 = 9999
	local var_31_1

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.itemList_) do
		local var_31_2 = math.abs(arg_31_0.contentTf_.localPosition.y + iter_31_1:GetLocalPosition().y + arg_31_0.scrollTf_.rect.height / 2)

		if var_31_2 < var_31_0 then
			var_31_0 = var_31_2
			var_31_1 = iter_31_1
		end
	end

	return var_31_1
end

function var_0_0.Scroll2SelectItem(arg_32_0)
	for iter_32_0, iter_32_1 in ipairs(arg_32_0.itemList_) do
		if iter_32_1:GetDifficultyID() == arg_32_0.selectDifficultyID_ then
			arg_32_0:AddMoveTimer(iter_32_1)
		end
	end
end

function var_0_0.AddMoveTimer(arg_33_0, arg_33_1)
	arg_33_0:StopMoveTimer()

	local var_33_0 = arg_33_0.contentTf_.localPosition

	arg_33_0.moveTimer_ = FrameTimer.New(function()
		local var_34_0 = arg_33_0.contentTf_.localPosition
		local var_34_1 = arg_33_1:GetLocalPosition().y * -1 - arg_33_0.scrollTf_.rect.height / 2
		local var_34_2 = GameSetting.challenge_velocity_times.value[1] * math.pow(arg_33_0.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime

		arg_33_0.tempVector3_.x = var_34_0.x
		arg_33_0.tempVector3_.y = var_34_1
		arg_33_0.tempVector3_.z = var_34_0.z

		local var_34_3 = Vector3.Lerp(var_34_0, arg_33_0.tempVector3_, var_34_2)
		local var_34_4 = GameSetting.challenge_scroll_min_length.value[1]

		if var_34_4 > math.abs(var_34_0.y - var_34_3.y) then
			local var_34_5 = var_34_1 - var_34_0.y

			if var_34_4 < math.abs(var_34_5) then
				var_34_5 = var_34_4 * var_34_5 / math.abs(var_34_5)
			end

			var_34_3.y = var_34_3.y + var_34_5
		end

		arg_33_0.contentTf_.localPosition = var_34_3

		if math.abs(arg_33_0.contentTf_.localPosition.y - var_34_1) <= GameSetting.challenge_stop_min_length.value[1] then
			arg_33_0.scrollView_:StopMovement()
			arg_33_0:StopMoveTimer()
			arg_33_0:OverMoveAction()
			arg_33_0:HideAffixPop()
		end
	end, 1, -1)

	arg_33_0.moveTimer_:Start()
end

function var_0_0.OverMoveAction(arg_35_0)
	local var_35_0 = arg_35_0.contentTf_.localPosition
	local var_35_1 = arg_35_0:GetSelectItem()

	arg_35_0.tempVector3_.x = var_35_0.x
	arg_35_0.tempVector3_.y = var_35_1:GetLocalPosition().y * -1 - arg_35_0.scrollTf_.rect.height / 2
	arg_35_0.tempVector3_.z = var_35_0.z
	arg_35_0.contentTf_.localPosition = arg_35_0.tempVector3_
	arg_35_0.lastAnglesX_ = arg_35_0.ringTf_.localEulerAngles.x
end

function var_0_0.GetSelectItem(arg_36_0)
	for iter_36_0, iter_36_1 in ipairs(arg_36_0.itemList_) do
		if iter_36_1:GetDifficultyID() == arg_36_0.selectDifficultyID_ then
			return iter_36_1
		end
	end

	return arg_36_0.itemList_[1]
end

return var_0_0
