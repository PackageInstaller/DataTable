local SkuldSystemMainView = class("SkuldSystemMainView", ReduxView)

function SkuldSystemMainView:UIName()
	return "Widget/System/Activity_Skuld/Activity_Skuld_MianUI"
end

function SkuldSystemMainView:UIParent()
	return manager.ui.uiMain.transform
end

function SkuldSystemMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkuldSystemMainView:InitUI()
	self:BindCfgUI()

	self.trustItem_ = SkuldSystemTrustItem.New(self.trustGo_)
	self.statusController_ = self.controllerEx_:GetController("status")
	self.endingController_ = self.controllerEx_:GetController("ending")
	self.titlePosController_ = self.controllerEx_:GetController("titlePos")
	self.dayTimeController_ = self.controllerEx_:GetController("daytime")
	self.movieController_ = self.controllerEx_:GetController("movie")
	self.loopMovieController_ = self.controllerEx_:GetController("loopMovie")
	self.criMovie_ = self.movieGo_:GetComponent("CriManaMovieControllerForUI")
	self.criplayer_ = self.criMovie_.player

	self.criplayer_:SetMaxPictureDataSize(300000)
	self.criMovie_:Stop()

	function self.criplayer_.statusChangeCallback(arg_5_0)
		self:CirMovieStatusChange(arg_5_0)
	end

	self.criLoopMovie_ = self.movieLoopGo_:GetComponent("CriManaMovieControllerForUI")
	self.criLoopPlayer_ = self.criLoopMovie_.player

	self.criLoopPlayer_:SetMaxPictureDataSize(300000)
	self.criLoopMovie_:Stop()

	self.moviePlaying = false
end

function SkuldSystemMainView:AddUIListeners()
	self:AddBtnListener(self.startBtn_, nil, function()
		JumpTools.OpenPageByJump("/skuldSystemStageView", {
			isFinal = false,
			startNext = false
		})
	end)
	self:AddBtnListener(self.endingBtn_, nil, function()
		local var_8_0 = false

		for iter_8_0, iter_8_1 in pairs(SkuldStageCfg.get_id_list_by_section[9]) do
			if SkuldSystemData:GetLevelIDIsOpen(iter_8_1) then
				var_8_0 = true

				break
			end
		end

		if var_8_0 then
			SkuldSystemAction.SendMark("EndClick")
			manager.redPoint:setTip(RedPointConst.SKULD_SYSTEM_FINAL_OPEN, 0, RedPointStyle.SHOW_NEW_TAG)
			JumpTools.OpenPageByJump("/skuldSystemStageView", {
				isFinal = true,
				startNext = false
			})
		else
			ShowTips("SKULD_ENDING_LOCK")
		end
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
			JumpTools.OpenPageByJump("/skuldSystemTaskView")
		else
			local var_9_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_SKULD_MAIN_TASK)

			if manager.time:GetServerTime() < var_9_0.startTime then
				ShowTips(string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_9_0.startTime)))
			else
				ShowTips("TIME_OVER")
			end
		end
	end)
	self:AddBtnListener(self.pictureBtn_, nil, function()
		JumpTools.OpenPageByJump("/skuldSystemPhotoView")
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		ShowTips("SKULD_FINAL_LOCK")
	end)
end

function SkuldSystemMainView:OnEnter()
	SkuldSystemData:UpdateSkuldPhoteRedPoint()

	self.nameText_.text = GetTips("SKULD_SYSTEM_NAME")

	if ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id) >= GameSetting.skuld_trust_max.value[1] then
		self.statusController_:SetSelectedState("trustMax")
	else
		self.statusController_:SetSelectedState("normal")
	end

	self.trustItem_:RefreshUI()
	self.trustItem_:OnEnter()
	self:PlayUnlockAni()

	local var_12_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_SKULD_MAIN_TASK)

	SetActive(self.endingAniGo_, false)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
		SetActive(self.taskGo_, true)

		self.timeLable_.text = manager.time:GetLostTimeStr2(var_12_0.stopTime)

		self.titlePosController_:SetSelectedState("pos1")
	else
		if manager.time:GetServerTime() < var_12_0.startTime then
			SetActive(self.taskGo_, false)
		elseif manager.time:GetServerTime() > var_12_0.stopTime then
			SetActive(self.taskGo_, false)
		end

		self.titlePosController_:SetSelectedState("pos2")
	end

	if SkuldSystemData:GetLevelIDIsClear(1030) then
		self.dayTimeController_:SetSelectedState("17")
	else
		self.dayTimeController_:SetSelectedState("16")
	end

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
				if self.timer_ == nil then
					SetActive(self.taskGo_, true)

					self.timeLable_.text = manager.time:GetLostTimeStr2(var_12_0.stopTime)
				end
			elseif manager.time:GetServerTime() < var_12_0.startTime then
				SetActive(self.taskGo_, false)
			elseif manager.time:GetServerTime() > var_12_0.stopTime then
				SetActive(self.taskGo_, false)
			end
		end, 1, -1)
	end

	self.timer_:Start()
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.SKULD_SYSTEM_TASK_ALL .. ActivityConst.ACTIVITY_SKULD_MAIN_TASK)
	manager.redPoint:bindUIandKey(self.pictureBtn_.transform, RedPointConst.SKULD_SYSTEM_PHOTO)
	manager.redPoint:bindUIandKey(self.endingBtn_.transform, RedPointConst.SKULD_SYSTEM_FINAL_OPEN)
	manager.redPoint:bindUIandKey(self.startBtn_.transform, RedPointConst.SKULD_SYSTEM_ARCHIVE_ALL .. "_6010128")
end

function SkuldSystemMainView:OnEnterOver()
	self:PlayEnterAni()
	SkuldSystemAction.RefreshAudio()
end

function SkuldSystemMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("SKULD_SYSTEM_TIPS_1")
end

function SkuldSystemMainView:OnExit()
	manager.windowBar:HideBar()
	self.trustItem_:OnExit()
	self:StopTimer()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.SKULD_SYSTEM_TASK_ALL .. ActivityConst.ACTIVITY_SKULD_MAIN_TASK)
	manager.redPoint:unbindUIandKey(self.pictureBtn_.transform, RedPointConst.SKULD_SYSTEM_PHOTO)
	manager.redPoint:unbindUIandKey(self.endingBtn_.transform, RedPointConst.SKULD_SYSTEM_FINAL_OPEN)
	manager.redPoint:unbindUIandKey(self.startBtn_.transform, RedPointConst.SKULD_SYSTEM_ARCHIVE_ALL .. "_6010128")
end

function SkuldSystemMainView:PlayEnterAni()
	self.hasViewStart_ = getData("skuldStageView", "hasViewStart")

	SetFile(self.criLoopPlayer_, nil, "SofdecAsset/activity/Activity_Skuld_MianUI_loop.usm", CriMana.Player.SetMode.AppendRepeatedly)
	self.criLoopPlayer_:Prepare()

	if SkuldSystemData:GetLevelIDIsClear(1030) then
		if not self.hasViewStart_ then
			SetFile(self.criplayer_, nil, "SofdecAsset/activity/Activity_Skuld_MianUI_start.usm", CriMana.Player.SetMode.Append)
			self.criplayer_:Prepare()
			manager.windowBar:HideBar()
			self:PlayMovie(self.criplayer_, self.criMovie_)
			self.loopMovieController_:SetSelectedState("false")

			self.movieGo_.transform.localPosition = Vector2(0, 0)
			self.movieLoopGo_.transform.localPosition = Vector2(9999, 9999)
		else
			self.movieLoopGo_.transform.localPosition = Vector2(0, 0)
			self.movieGo_.transform.localPosition = Vector2(9999, 9999)

			self:PlayMovie(self.criLoopPlayer_, self.criLoopMovie_)
			self.loopMovieController_:SetSelectedState("true")
		end

		self.movieController_:SetSelectedState("true")
		SetActive(self.movieGo_, true)
		SetActive(self.movieLoopGo_, true)
	else
		SetActive(self.movieGo_, false)
		SetActive(self.movieLoopGo_, false)
		self.movieController_:SetSelectedState("false")
		self.loopMovieController_:SetSelectedState("true")
	end
end

function SkuldSystemMainView:PlayMovie(arg_18_1, arg_18_2)
	arg_18_1:SetVolume((manager.audio:GetMusicVolume()))
	arg_18_2:Play()

	self.moviePlaying = true
end

function SkuldSystemMainView:CirMovieStatusChange(arg_19_1)
	local var_19_0 = tostring(arg_19_1)

	if var_19_0 == "PlayEnd" then
		if not self.hasViewStart_ then
			self.hasViewStart_ = true

			saveData("skuldStageView", "hasViewStart", true)

			self.movieLoopGo_.transform.localPosition = Vector2(0, 0)

			self:PlayMovie(self.criLoopPlayer_, self.criLoopMovie_)

			self.movieGo_.transform.localPosition = Vector2(9999, 9999)

			self.loopMovieController_:SetSelectedState("true")
			self.enterAni_:Update(0)
			self.enterAni_:Play("NorseUI_3_0_NianMianUI_Skuld", -1, 0)
			manager.windowBar:SwitchBar({
				BACK_BAR,
				HOME_BAR,
				INFO_BAR
			})
			manager.windowBar:SetGameHelpKey("SKULD_SYSTEM_TIPS_1")
			self:PlayUnlockAni()
			SkuldSystemAction.RefreshAudio()
		else
			self.criMovie_:Stop()
		end
	elseif var_19_0 == "Stop" then
		self.criMovie_:Stop()
	elseif var_19_0 == "Error" then
		self.criMovie_:Stop()
	end
end

function SkuldSystemMainView:PlayUnlockAni()
	local var_20_0 = false

	for iter_20_0, iter_20_1 in pairs(SkuldStageCfg.get_id_list_by_section[9]) do
		if SkuldSystemData:GetLevelIDIsOpen(iter_20_1) then
			var_20_0 = true

			break
		end
	end

	if var_20_0 then
		self.endingController_:SetSelectedState("unlock")

		if SkuldSystemData:GetClientKey("IsPlayEndUnlock") and not self.hasViewStart_ then
			SetActive(self.endingAniGo_, false)
		else
			SetActive(self.endingAniGo_, true)
			self.endingAni_:Play("stage_unlock")
			SkuldSystemAction.SendMark("IsPlayEndUnlock")
		end
	else
		SetActive(self.endingAniGo_, false)
		self.endingController_:SetSelectedState("lock")
	end
end

function SkuldSystemMainView:StopMovie()
	if self.criMovie_ then
		self.criMovie_:Stop()
	end

	if self.criLoopMovie_ then
		self.criLoopMovie_:Stop()
	end

	self.moviePlaying = false
end

function SkuldSystemMainView:DisPoseMovie()
	if self.criMovie_ or self.criLoopMovie_ then
		self:StopMovie()

		if self.criPlayer_ then
			self.criPlayer_:Dispose()

			self.criplayer_.statusChangeCallback = nil
			self.criPlayer_ = nil
		end

		if self.criLoopPlayer_ then
			self.criLoopPlayer_:Dispose()

			self.criLoopPlayer_ = nil
		end
	end
end

function SkuldSystemMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SkuldSystemMainView:Dispose()
	self:StopTimer()
	self.trustItem_:Dispose()
	self:DisPoseMovie()
	self.super.Dispose(self)
end

return SkuldSystemMainView
