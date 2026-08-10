local var_0_0 = class("ChapterMapItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.tempVector3_ = Vector3.New(0, 0, 0)
	arg_1_0.parent_ = arg_1_2
	arg_1_0.viewportTransform_ = arg_1_2.transform.parent
	arg_1_0.width_ = arg_1_0.viewportTransform_.rect.width / 2
	arg_1_0.alphaScale_ = 0.0007692307692307692

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
	arg_1_0:Show(true)
end

function var_0_0.OnEnter(arg_2_0)
	return
end

function var_0_0.OnExit(arg_3_0)
	if arg_3_0.chapterClientID_ then
		manager.redPoint:unbindUIandKey(arg_3_0.itemRect_, string.format("%s_%s", RedPointConst.COMBAT_PLOT, arg_3_0.chapterClientID_))
	end

	arg_3_0:StopTimer()
	arg_3_0:StopTween()
	arg_3_0:RemoveActivityTimer()
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0:RemoveListeners()
	var_0_0.super.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.gameObject_ = nil
	arg_4_0.transform_ = nil
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.chapterPaint_.immediate = true
	arg_5_0.lockController_ = arg_5_0.controllerEx_:GetController("lock")
	arg_5_0.activityController_ = arg_5_0.controllerEx_:GetController("activityFlag")
	arg_5_0.selectController_ = arg_5_0.controllerEx_:GetController("chapter")
end

function var_0_0.ResolveEntryChapterID(arg_6_0, arg_6_1)
	local var_6_0 = ChapterClientCfg[arg_6_1]

	if var_6_0 == nil then
		return nil
	end

	local var_6_1 = BattleFieldData:GetCacheChapter(arg_6_1)

	if not table.keyof(var_6_0.chapter_list, var_6_1) then
		return ChapterTools.GetChapterIDByClient(arg_6_1)
	end

	if not ChapterTools.IsFinishPreChapter(var_6_1) or not ChapterTools.IsUnlockChapter(var_6_1) then
		return ChapterTools.GetChapterIDByClient(arg_6_1)
	end

	return var_6_1
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.btn_, nil, function()
		local var_8_0 = arg_7_0.hardLevel_
		local var_8_1 = arg_7_0.chapterClientID_
		local var_8_2 = ChapterMapItemView:ResolveEntryChapterID(var_8_1)
		local var_8_3 = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)
		local var_8_4 = ChapterClientCfg[var_8_3]
		local var_8_5 = ActivityData:GetActivityIsOpen(ChapterCfg[var_8_2].activity_id)

		if var_8_4.id ~= var_8_1 then
			manager.audio:PlayUIAudioByVoice("stage_slide")
			BattleFieldAction.ChangeSelectChapterID(var_8_2)

			return
		end

		local var_8_6, var_8_7 = ChapterTools.IsFinishPreChapter(var_8_2)
		local var_8_8 = ActivityData:GetActivityIsOpen(ChapterCfg[var_8_2].unlock_activity_id)
		local var_8_9 = {
			10123,
			10124,
			10125
		}
		local var_8_10 = table.indexof(var_8_9, var_8_2) ~= nil

		if not var_8_6 then
			ShowTips(ChapterTools.GetChapterLockText(var_8_2, var_8_7))

			return
		else
			local var_8_11 = ChapterCfg.get_id_list_by_connect_group[ChapterCfg[var_8_2].connect_group[1]]
			local var_8_12

			if var_8_11 then
				var_8_12 = var_8_11[1]
			end

			var_8_1 = ChapterTools.GetChapterClientIDByChapterID(var_8_12)

			local var_8_13 = getData("Activity_Chapter", "Pop_Connect" .. var_8_1)
			local var_8_14 = false

			if var_8_12 and not ChapterTools.IsClearFirstStage(var_8_12) then
				var_8_14 = true
			end

			if not var_8_10 then
				if var_8_8 and var_8_14 and not var_8_13 and var_8_2 ~= var_8_12 then
					ShowMessageBox({
						content = string.format(GetTips("JUMP_TO_CONNECT_CHAPTER"), GetI18NText(ChapterClientCfg[var_8_1].desc)),
						OkCallback = function()
							OperationRecorder.RecordButtonTouch({
								button_name = "story_chapter_jump",
								chapter_id = var_8_1
							})
							ChapterTools.GotoChapterSection(var_8_12)
							BattleFieldAction.ChangeSelectChapterID(var_8_12)
							saveData("Activity_Chapter", "Pop_Connect" .. var_8_1, true)
						end,
						CancelCallback = function()
							ChapterTools.GotoChapterSection(var_8_2)
							OperationRecorder.RecordButtonTouch({
								button_name = "story_chapter_jump",
								chapter_id = var_8_1
							})
							saveData("Activity_Chapter", "Pop_Connect" .. var_8_1, true)
						end
					})
				else
					ChapterTools.GotoChapterSection(var_8_2)
					OperationRecorder.RecordButtonTouch({
						button_name = "story_chapter_jump",
						chapter_id = var_8_1
					})
				end
			end
		end

		if var_8_10 and var_8_7 and var_8_7 > 0 then
			local var_8_15 = var_8_7

			ShowMessageBox({
				content = GetTips("CHAPTERV2_JUMP_TO_CONNECT_CHAPTER"),
				OkCallback = function()
					OperationRecorder.RecordButtonTouch({
						button_name = "story_chapter_jump",
						chapter_id = var_8_15
					})
					ChapterTools.GotoChapterSection(var_8_15)
					BattleFieldAction.ChangeSelectChapterID(var_8_15)
				end
			})
		else
			OperationRecorder.RecordButtonTouch({
				button_name = "story_chapter_jump",
				chapter_id = var_8_1
			})
			ChapterTools.GotoChapterSection(var_8_2)
			BattleFieldAction.ChangeSelectChapterID(var_8_2)
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.surveyBtn_, nil, function()
		local var_12_0 = arg_7_0.chapterClientID_

		JumpTools.OpenPageByJump("chapterSurveyPop", {
			chapterID = var_12_0
		})
	end)
end

function var_0_0.RemoveListeners(arg_13_0)
	arg_13_0.btn_.onClick:RemoveAllListeners()
end

function var_0_0.RefreshData(arg_14_0)
	local var_14_0 = arg_14_0.chapterClientID_
	local var_14_1 = ChapterClientCfg[var_14_0].chapter_list[1]

	arg_14_0.collectRate_ = ChapterTools.GetChapterClientFinishPercentage(var_14_0)

	local var_14_2 = ChapterCfg[var_14_1]

	arg_14_0.isLock_ = not ChapterTools.IsFinishPreChapter(var_14_1)
	arg_14_0.hardLevel_ = var_14_2.type
	arg_14_0.asset_pend_key = ChapterClientCfg[var_14_0].asset_pend_key
	arg_14_0.isAssetPendLock_ = not manager.assetPend:CheckAssetPend(arg_14_0.asset_pend_key)
end

function var_0_0.RefreshUI(arg_15_0)
	arg_15_0:RefreshItem()
	arg_15_0:RefreshLock()
	arg_15_0:RefreshActivity()
	arg_15_0:RefreshCollect()
end

function var_0_0.RefreshItem(arg_16_0)
	local var_16_0 = arg_16_0.chapterClientID_

	if arg_16_0.oldChapterClientID_ ~= var_16_0 then
		local var_16_1 = ChapterClientCfg[var_16_0]

		arg_16_0.chapterName_.text = GetI18NText(var_16_1.name)
		arg_16_0.chapterDesc_.text = GetI18NText(var_16_1.desc)

		local var_16_2 = SpritePathCfg.ChapterPaint.path .. var_16_1.chapter_paint

		SetSpriteWithoutAtlasAsync(arg_16_0.chapterPaint_, var_16_2)

		arg_16_0.oldChapterClientID_ = var_16_0
	end

	SetActive(arg_16_0.surveyBtnGo_, SurveyData:GetChapterSurveyID(var_16_0) and SurveyData:GetChapterSurveyID(var_16_0) ~= 0 and ChapterTools.IsClearChapterClient(var_16_0))
end

function var_0_0.RefreshLock(arg_17_0)
	local var_17_0 = ChapterClientCfg[arg_17_0.chapterClientID_]

	if var_17_0 then
		arg_17_0.asset_pend_key = var_17_0.asset_pend_key
		arg_17_0.isAssetPendLock_ = not manager.assetPend:CheckAssetPend(arg_17_0.asset_pend_key)
	end

	if arg_17_0.isLock_ then
		arg_17_0.lockController_:SetSelectedState("true")
	elseif arg_17_0.isAssetPendLock_ then
		arg_17_0.lockController_:SetSelectedState("assetpend")
	else
		arg_17_0.lockController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshActivity(arg_18_0)
	local var_18_0 = ChapterClientCfg[arg_18_0.chapterClientID_].chapter_list[1]
	local var_18_1 = ChapterCfg[var_18_0]

	arg_18_0.activityController_:SetSelectedState(tostring(ActivityData:GetActivityIsOpen(var_18_1.activity_id)))
end

function var_0_0.RefreshHardLevel(arg_19_0)
	arg_19_0.chapterLevelText_.text = GetTips(BattleConst.HARD_LANGUAGE[arg_19_0.hardLevel_])
end

function var_0_0.RefreshCollect(arg_20_0)
	arg_20_0.collectText_.text = string.format("%s%%", math.floor(arg_20_0.collectRate_ * 100))
end

function var_0_0.PlayAnimate(arg_21_0)
	arg_21_0:AddUpdate()
	arg_21_0:StopTween()

	arg_21_0.collectProgress_.fillAmount = 0
	arg_21_0.tweenValue_ = LeanTween.value(arg_21_0.gameObject_, 0, arg_21_0.collectRate_, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
		arg_21_0.collectProgress_.fillAmount = arg_22_0
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_21_0.tweenValue_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

		arg_21_0.tweenValue_ = nil
	end)):setEase(LeanTweenType.easeOutQuad):setDelay(0.2)
end

function var_0_0.StopTween(arg_24_0)
	if arg_24_0.tweenValue_ then
		arg_24_0.tweenValue_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_24_0.gameObject_)

		arg_24_0.tweenValue_ = nil
	end
end

function var_0_0.SetChapterClientID(arg_25_0, arg_25_1)
	if arg_25_0.chapterClientID_ then
		manager.redPoint:unbindUIandKey(arg_25_0.itemRect_, string.format("%s_%s", RedPointConst.COMBAT_PLOT, arg_25_0.chapterClientID_))
	end

	local var_25_0 = arg_25_0.chapterClientID_ == arg_25_1

	arg_25_0.chapterClientID_ = arg_25_1
	arg_25_0.transform_.name = arg_25_1

	manager.redPoint:bindUIandKey(arg_25_0.itemRect_, string.format("%s_%s", RedPointConst.COMBAT_PLOT, arg_25_0.chapterClientID_))
	arg_25_0:RefreshData()
	arg_25_0:RefreshUI()

	if not var_25_0 then
		arg_25_0:PlayAnimate()
	end

	arg_25_0:AddActivityTimer()
	arg_25_0:Show(true)
end

function var_0_0.SetLocalPosition(arg_26_0, arg_26_1)
	arg_26_0.transform_.localPosition = arg_26_1
end

function var_0_0.GetLocalPosition(arg_27_0)
	return arg_27_0.transform_.localPosition + arg_27_0.parent_.transform.localPosition
end

function var_0_0.Show(arg_28_0, arg_28_1)
	if arg_28_1 == false then
		arg_28_0.tempVector3_.x = 1000000000000
		arg_28_0.tempVector3_.y = 1000000000000
		arg_28_0.tempVector3_.z = 1000000000000

		arg_28_0:SetLocalPosition(arg_28_0.tempVector3_)
	else
		SetActive(arg_28_0.gameObject_, arg_28_1)
	end
end

function var_0_0.Hide(arg_29_0, arg_29_1)
	arg_29_1 = arg_29_1 and ChapterTools.HasChapterStage(arg_29_0.chapterClientID_)

	SetActive(arg_29_0.gameObject_, arg_29_1)

	if arg_29_1 then
		arg_29_0:PlayAnimate()
	end
end

function var_0_0.Scale(arg_30_0, arg_30_1)
	arg_30_0.tempVector3_.x = arg_30_1
	arg_30_0.tempVector3_.y = arg_30_1
	arg_30_0.tempVector3_.z = 1
	arg_30_0.transform_.localScale = arg_30_0.tempVector3_
end

function var_0_0.SetAlpha(arg_31_0, arg_31_1)
	return
end

function var_0_0.StopTimer(arg_32_0)
	if arg_32_0.timer_ then
		arg_32_0.timer_:Stop()

		arg_32_0.timer_ = nil
	end
end

function var_0_0.AddUpdate(arg_33_0)
	arg_33_0:StopTimer()
	arg_33_0:CalcScale()

	arg_33_0.timer_ = FrameTimer.New(function()
		arg_33_0:CalcScale()
	end, 1, -1)

	arg_33_0.timer_:Start()
end

function var_0_0.CalcScale(arg_35_0)
	local var_35_0 = arg_35_0:GetLocalPosition()
	local var_35_1 = math.abs(var_35_0.x - arg_35_0.width_)

	if var_35_1 < arg_35_0.width_ * 2 then
		arg_35_0:Scale(1 - var_35_1 / (arg_35_0.width_ * 10))
	end
end

function var_0_0.SetSelectID(arg_36_0, arg_36_1)
	if arg_36_0.chapterClientID_ == arg_36_1 then
		arg_36_0.selectController_:SetSelectedState("select")
		arg_36_0:PlayAnimate()
	else
		arg_36_0.selectController_:SetSelectedState("normal")
	end
end

function var_0_0.GetChapterClientID(arg_37_0)
	return arg_37_0.chapterClientID_
end

function var_0_0.IsLock(arg_38_0)
	return arg_38_0.isLock_
end

function var_0_0.AddActivityTimer(arg_39_0)
	arg_39_0:RemoveActivityTimer()

	local var_39_0 = arg_39_0.chapterClientID_
	local var_39_1 = ChapterClientCfg[var_39_0].chapter_list[1]
	local var_39_2 = ChapterCfg[var_39_1].activity_id

	if var_39_2 == 0 then
		return
	end

	local var_39_3 = ActivityData:GetActivityData(var_39_2):IsActivitying()

	arg_39_0.activityTimer_ = Timer.New(function()
		local var_40_0 = ActivityData:GetActivityData(var_39_2):IsActivitying()

		if var_40_0 ~= var_39_3 then
			var_39_3 = var_40_0
			arg_39_0.isLock_ = not ChapterTools.IsFinishPreChapter(var_39_1)

			arg_39_0:RefreshLock()
			arg_39_0:RefreshActivity()
		end
	end, 1, -1)

	arg_39_0.activityTimer_:Start()
end

function var_0_0.RemoveActivityTimer(arg_41_0)
	if arg_41_0.activityTimer_ then
		arg_41_0.activityTimer_:Stop()

		arg_41_0.activityTimer_ = nil
	end
end

return var_0_0
