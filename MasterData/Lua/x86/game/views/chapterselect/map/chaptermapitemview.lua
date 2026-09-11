local ChapterMapItemView = class("ChapterMapItemView", ReduxView)

function ChapterMapItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.tempVector3_ = Vector3.New(0, 0, 0)
	self.parent_ = arg_1_2
	self.viewportTransform_ = arg_1_2.transform.parent
	self.width_ = self.viewportTransform_.rect.width / 2
	self.alphaScale_ = 0.0007692307692307692

	self:InitUI()
	self:AddListeners()
	self:Show(true)
end

function ChapterMapItemView:OnEnter()
	return
end

function ChapterMapItemView:OnExit()
	if self.chapterClientID_ then
		manager.redPoint:unbindUIandKey(self.itemRect_, string.format("%s_%s", RedPointConst.COMBAT_PLOT, self.chapterClientID_))
	end

	self:StopTimer()
	self:StopTween()
	self:RemoveActivityTimer()
end

function ChapterMapItemView:Dispose()
	self:RemoveListeners()
	ChapterMapItemView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChapterMapItemView:InitUI()
	self:BindCfgUI()

	self.chapterPaint_.immediate = true
	self.lockController_ = self.controllerEx_:GetController("lock")
	self.activityController_ = self.controllerEx_:GetController("activityFlag")
	self.selectController_ = self.controllerEx_:GetController("chapter")
end

function ChapterMapItemView:ResolveEntryChapterID(arg_6_1)
	if ChapterClientCfg[arg_6_1] == nil then
		return nil
	end

	local var_6_0 = BattleFieldData:GetCacheChapter(arg_6_1)

	if not table.keyof(ChapterClientCfg[arg_6_1].chapter_list, var_6_0) then
		return ChapterTools.GetChapterIDByClient(arg_6_1)
	end

	if not ChapterTools.IsFinishPreChapter(var_6_0) or not ChapterTools.IsUnlockChapter(var_6_0) then
		return ChapterTools.GetChapterIDByClient(arg_6_1)
	end

	return var_6_0
end

function ChapterMapItemView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		local var_8_1 = self.chapterClientID_
		local var_8_2 = ChapterMapItemView:ResolveEntryChapterID(self.chapterClientID_)
		local var_8_3 = ActivityData:GetActivityIsOpen(ChapterCfg[var_8_2].activity_id)

		if ChapterClientCfg[BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)].id ~= self.chapterClientID_ then
			manager.audio:PlayUIAudioByVoice("stage_slide")
			BattleFieldAction.ChangeSelectChapterID(var_8_2)

			return
		end

		local var_8_4, var_8_5 = ChapterTools.IsFinishPreChapter(var_8_2)
		local var_8_6 = ActivityData:GetActivityIsOpen(ChapterCfg[var_8_2].unlock_activity_id)
		local var_8_7 = table.indexof({
			10123,
			10124,
			10125
		}, var_8_2) ~= nil

		if not var_8_4 then
			ShowTips(ChapterTools.GetChapterLockText(var_8_2, var_8_5))

			return
		else
			local var_8_8

			if ChapterCfg.get_id_list_by_connect_group[ChapterCfg[var_8_2].connect_group[1]] then
				var_8_8 = ChapterCfg.get_id_list_by_connect_group[ChapterCfg[var_8_2].connect_group[1]][1]
			end

			var_8_1 = ChapterTools.GetChapterClientIDByChapterID(var_8_8)

			if not var_8_7 then
				if var_8_6 and not not (var_8_8 and not ChapterTools.IsClearFirstStage(var_8_8)) and not getData("Activity_Chapter", "Pop_Connect" .. var_8_1) and var_8_2 ~= var_8_8 then
					ShowMessageBox({
						content = string.format(GetTips("JUMP_TO_CONNECT_CHAPTER"), GetI18NText(ChapterClientCfg[var_8_1].desc)),
						OkCallback = function()
							OperationRecorder.RecordButtonTouch({
								button_name = "story_chapter_jump",
								chapter_id = var_8_1
							})
							ChapterTools.GotoChapterSection(var_8_8)
							BattleFieldAction.ChangeSelectChapterID(var_8_8)
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

		if var_8_7 and var_8_5 and var_8_5 > 0 then
			local var_8_9 = var_8_5

			ShowMessageBox({
				content = GetTips("CHAPTERV2_JUMP_TO_CONNECT_CHAPTER"),
				OkCallback = function()
					OperationRecorder.RecordButtonTouch({
						button_name = "story_chapter_jump",
						chapter_id = var_8_9
					})
					ChapterTools.GotoChapterSection(var_8_9)
					BattleFieldAction.ChangeSelectChapterID(var_8_9)
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
	self:AddBtnListener(self.surveyBtn_, nil, function()
		JumpTools.OpenPageByJump("chapterSurveyPop", {
			chapterID = self.chapterClientID_
		})
	end)
end

function ChapterMapItemView:RemoveListeners()
	self.btn_.onClick:RemoveAllListeners()
end

function ChapterMapItemView:RefreshData()
	self.collectRate_ = ChapterTools.GetChapterClientFinishPercentage(self.chapterClientID_)
	self.isLock_ = not ChapterTools.IsFinishPreChapter(ChapterClientCfg[self.chapterClientID_].chapter_list[1])
	self.hardLevel_ = ChapterCfg[ChapterClientCfg[self.chapterClientID_].chapter_list[1]].type
	self.asset_pend_key = ChapterClientCfg[self.chapterClientID_].asset_pend_key
	self.isAssetPendLock_ = not manager.assetPend:CheckAssetPend(self.asset_pend_key)
end

function ChapterMapItemView:RefreshUI()
	self:RefreshItem()
	self:RefreshLock()
	self:RefreshActivity()
	self:RefreshCollect()
end

function ChapterMapItemView:RefreshItem()
	local var_16_0 = self.chapterClientID_
	local var_16_1

	if self.oldChapterClientID_ ~= self.chapterClientID_ then
		self.chapterName_.text = GetI18NText(ChapterClientCfg[var_16_0].name)
		self.chapterDesc_.text = GetI18NText(ChapterClientCfg[var_16_0].desc)

		SetSpriteWithoutAtlasAsync(self.chapterPaint_, SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[var_16_0].chapter_paint)

		self.oldChapterClientID_ = var_16_0
		var_16_1 = SurveyData:GetChapterSurveyID(var_16_0) and SurveyData:GetChapterSurveyID(var_16_0) ~= 0 and ChapterTools.IsClearChapterClient(var_16_0)
	end

	SetActive(self.surveyBtnGo_, var_16_1)
end

function ChapterMapItemView:RefreshLock()
	if ChapterClientCfg[self.chapterClientID_] then
		self.asset_pend_key = ChapterClientCfg[self.chapterClientID_].asset_pend_key
		self.isAssetPendLock_ = not manager.assetPend:CheckAssetPend(self.asset_pend_key)
	end

	if self.isLock_ then
		self.lockController_:SetSelectedState("true")
	elseif self.isAssetPendLock_ then
		self.lockController_:SetSelectedState("assetpend")
	else
		self.lockController_:SetSelectedState("false")
	end
end

function ChapterMapItemView:RefreshActivity()
	self.activityController_:SetSelectedState(tostring(ActivityData:GetActivityIsOpen(ChapterCfg[ChapterClientCfg[self.chapterClientID_].chapter_list[1]].activity_id)))
end

function ChapterMapItemView:RefreshHardLevel()
	self.chapterLevelText_.text = GetTips(BattleConst.HARD_LANGUAGE[self.hardLevel_])
end

function ChapterMapItemView:RefreshCollect()
	self.collectText_.text = string.format("%s%%", math.floor(self.collectRate_ * 100))
end

function ChapterMapItemView:PlayAnimate()
	self:AddUpdate()
	self:StopTween()

	self.collectProgress_.fillAmount = 0
	self.tweenValue_ = LeanTween.value(self.gameObject_, 0, self.collectRate_, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
		self.collectProgress_.fillAmount = arg_22_0
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self.tweenValue_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

		self.tweenValue_ = nil
	end)):setEase(LeanTweenType.easeOutQuad):setDelay(0.2)
end

function ChapterMapItemView:StopTween()
	if self.tweenValue_ then
		self.tweenValue_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.gameObject_)

		self.tweenValue_ = nil
	end
end

function ChapterMapItemView:SetChapterClientID(arg_25_1)
	if self.chapterClientID_ then
		manager.redPoint:unbindUIandKey(self.itemRect_, string.format("%s_%s", RedPointConst.COMBAT_PLOT, self.chapterClientID_))
	end

	local var_25_0 = self.chapterClientID_ == arg_25_1

	self.chapterClientID_ = arg_25_1
	self.transform_.name = arg_25_1

	manager.redPoint:bindUIandKey(self.itemRect_, string.format("%s_%s", RedPointConst.COMBAT_PLOT, self.chapterClientID_))
	self:RefreshData()
	self:RefreshUI()

	if not var_25_0 then
		self:PlayAnimate()
	end

	self:AddActivityTimer()
	self:Show(true)
end

function ChapterMapItemView:SetLocalPosition(arg_26_1)
	self.transform_.localPosition = arg_26_1
end

function ChapterMapItemView:GetLocalPosition()
	return self.transform_.localPosition + self.parent_.transform.localPosition
end

function ChapterMapItemView:Show(arg_28_1)
	if arg_28_1 == false then
		self.tempVector3_.x = 1000000000000
		self.tempVector3_.y = 1000000000000
		self.tempVector3_.z = 1000000000000

		self:SetLocalPosition(self.tempVector3_)
	else
		SetActive(self.gameObject_, arg_28_1)
	end
end

function ChapterMapItemView:Hide(arg_29_1)
	arg_29_1 = arg_29_1 and ChapterTools.HasChapterStage(self.chapterClientID_)

	SetActive(self.gameObject_, arg_29_1)

	if arg_29_1 then
		self:PlayAnimate()
	end
end

function ChapterMapItemView:Scale(arg_30_1)
	self.tempVector3_.x = arg_30_1
	self.tempVector3_.y = arg_30_1
	self.tempVector3_.z = 1
	self.transform_.localScale = self.tempVector3_
end

function ChapterMapItemView:SetAlpha(arg_31_1)
	return
end

function ChapterMapItemView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ChapterMapItemView:AddUpdate()
	self:StopTimer()
	self:CalcScale()

	self.timer_ = FrameTimer.New(function()
		self:CalcScale()
	end, 1, -1)

	self.timer_:Start()
end

function ChapterMapItemView:CalcScale()
	local var_35_0 = math.abs(self:GetLocalPosition().x - self.width_)

	if var_35_0 < self.width_ * 2 then
		self:Scale(1 - var_35_0 / (self.width_ * 10))
	end
end

function ChapterMapItemView:SetSelectID(arg_36_1)
	if self.chapterClientID_ == arg_36_1 then
		self.selectController_:SetSelectedState("select")
		self:PlayAnimate()
	else
		self.selectController_:SetSelectedState("normal")
	end
end

function ChapterMapItemView:GetChapterClientID()
	return self.chapterClientID_
end

function ChapterMapItemView:IsLock()
	return self.isLock_
end

function ChapterMapItemView:AddActivityTimer()
	self:RemoveActivityTimer()

	local var_39_0 = ChapterClientCfg[self.chapterClientID_].chapter_list[1]
	local var_39_1 = ChapterCfg[ChapterClientCfg[self.chapterClientID_].chapter_list[1]].activity_id

	if ChapterCfg[ChapterClientCfg[self.chapterClientID_].chapter_list[1]].activity_id == 0 then
		return
	end

	local var_39_2 = ActivityData:GetActivityData(ChapterCfg[ChapterClientCfg[self.chapterClientID_].chapter_list[1]].activity_id):IsActivitying()

	self.activityTimer_ = Timer.New(function()
		local var_40_0 = ActivityData:GetActivityData(var_39_1):IsActivitying()

		if var_40_0 ~= var_39_2 then
			var_39_2 = var_40_0
			self.isLock_ = not ChapterTools.IsFinishPreChapter(var_39_0)

			self:RefreshLock()
			self:RefreshActivity()
		end
	end, 1, -1)

	self.activityTimer_:Start()
end

function ChapterMapItemView:RemoveActivityTimer()
	if self.activityTimer_ then
		self.activityTimer_:Stop()

		self.activityTimer_ = nil
	end
end

return ChapterMapItemView
