local var_0_0 = class("SkuldSystemMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Skuld/Activity_Skuld_MianUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.trustItem_ = SkuldSystemTrustItem.New(arg_4_0.trustGo_)
	arg_4_0.statusController_ = arg_4_0.controllerEx_:GetController("status")
	arg_4_0.endingController_ = arg_4_0.controllerEx_:GetController("ending")
	arg_4_0.titlePosController_ = arg_4_0.controllerEx_:GetController("titlePos")
	arg_4_0.dayTimeController_ = arg_4_0.controllerEx_:GetController("daytime")
	arg_4_0.movieController_ = arg_4_0.controllerEx_:GetController("movie")
	arg_4_0.loopMovieController_ = arg_4_0.controllerEx_:GetController("loopMovie")
	arg_4_0.criMovie_ = arg_4_0.movieGo_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criplayer_ = arg_4_0.criMovie_.player

	arg_4_0.criplayer_:SetMaxPictureDataSize(300000)
	arg_4_0.criMovie_:Stop()

	function arg_4_0.criplayer_.statusChangeCallback(arg_5_0)
		arg_4_0:CirMovieStatusChange(arg_5_0)
	end

	arg_4_0.criLoopMovie_ = arg_4_0.movieLoopGo_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criLoopPlayer_ = arg_4_0.criLoopMovie_.player

	arg_4_0.criLoopPlayer_:SetMaxPictureDataSize(300000)
	arg_4_0.criLoopMovie_:Stop()

	arg_4_0.moviePlaying = false
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.startBtn_, nil, function()
		JumpTools.OpenPageByJump("/skuldSystemStageView", {
			isFinal = false,
			startNext = false
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.endingBtn_, nil, function()
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
	arg_6_0:AddBtnListener(arg_6_0.taskBtn_, nil, function()
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
	arg_6_0:AddBtnListener(arg_6_0.pictureBtn_, nil, function()
		JumpTools.OpenPageByJump("/skuldSystemPhotoView")
	end)
	arg_6_0:AddBtnListener(arg_6_0.lockBtn_, nil, function()
		ShowTips("SKULD_FINAL_LOCK")
	end)
end

function var_0_0.OnEnter(arg_12_0)
	SkuldSystemData:UpdateSkuldPhoteRedPoint()

	arg_12_0.nameText_.text = GetTips("SKULD_SYSTEM_NAME")

	if ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id) >= GameSetting.skuld_trust_max.value[1] then
		arg_12_0.statusController_:SetSelectedState("trustMax")
	else
		arg_12_0.statusController_:SetSelectedState("normal")
	end

	arg_12_0.trustItem_:RefreshUI()
	arg_12_0.trustItem_:OnEnter()
	arg_12_0:PlayUnlockAni()

	local var_12_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_SKULD_MAIN_TASK)

	SetActive(arg_12_0.endingAniGo_, false)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
		SetActive(arg_12_0.taskGo_, true)

		arg_12_0.timeLable_.text = manager.time:GetLostTimeStr2(var_12_0.stopTime)

		arg_12_0.titlePosController_:SetSelectedState("pos1")
	else
		if manager.time:GetServerTime() < var_12_0.startTime then
			SetActive(arg_12_0.taskGo_, false)
		elseif manager.time:GetServerTime() > var_12_0.stopTime then
			SetActive(arg_12_0.taskGo_, false)
		end

		arg_12_0.titlePosController_:SetSelectedState("pos2")
	end

	if SkuldSystemData:GetLevelIDIsClear(1030) then
		arg_12_0.dayTimeController_:SetSelectedState("17")
	else
		arg_12_0.dayTimeController_:SetSelectedState("16")
	end

	if arg_12_0.timer_ == nil then
		arg_12_0.timer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_SKULD_MAIN_TASK) then
				if arg_12_0.timer_ == nil then
					SetActive(arg_12_0.taskGo_, true)

					arg_12_0.timeLable_.text = manager.time:GetLostTimeStr2(var_12_0.stopTime)
				end
			elseif manager.time:GetServerTime() < var_12_0.startTime then
				SetActive(arg_12_0.taskGo_, false)
			elseif manager.time:GetServerTime() > var_12_0.stopTime then
				SetActive(arg_12_0.taskGo_, false)
			end
		end, 1, -1)
	end

	arg_12_0.timer_:Start()

	local var_12_1 = RedPointConst.SKULD_SYSTEM_TASK_ALL .. ActivityConst.ACTIVITY_SKULD_MAIN_TASK

	manager.redPoint:bindUIandKey(arg_12_0.taskBtn_.transform, var_12_1)

	local var_12_2 = RedPointConst.SKULD_SYSTEM_PHOTO

	manager.redPoint:bindUIandKey(arg_12_0.pictureBtn_.transform, var_12_2)
	manager.redPoint:bindUIandKey(arg_12_0.endingBtn_.transform, RedPointConst.SKULD_SYSTEM_FINAL_OPEN)

	local var_12_3 = RedPointConst.SKULD_SYSTEM_ARCHIVE_ALL .. "_6010128"

	manager.redPoint:bindUIandKey(arg_12_0.startBtn_.transform, var_12_3)
end

function var_0_0.OnEnterOver(arg_14_0)
	arg_14_0:PlayEnterAni()
	SkuldSystemAction.RefreshAudio()
end

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("SKULD_SYSTEM_TIPS_1")
end

function var_0_0.OnExit(arg_16_0)
	manager.windowBar:HideBar()
	arg_16_0.trustItem_:OnExit()
	arg_16_0:StopTimer()

	local var_16_0 = RedPointConst.SKULD_SYSTEM_TASK_ALL .. ActivityConst.ACTIVITY_SKULD_MAIN_TASK

	manager.redPoint:unbindUIandKey(arg_16_0.taskBtn_.transform, var_16_0)

	local var_16_1 = RedPointConst.SKULD_SYSTEM_PHOTO

	manager.redPoint:unbindUIandKey(arg_16_0.pictureBtn_.transform, var_16_1)
	manager.redPoint:unbindUIandKey(arg_16_0.endingBtn_.transform, RedPointConst.SKULD_SYSTEM_FINAL_OPEN)

	local var_16_2 = RedPointConst.SKULD_SYSTEM_ARCHIVE_ALL .. "_6010128"

	manager.redPoint:unbindUIandKey(arg_16_0.startBtn_.transform, var_16_2)
end

function var_0_0.PlayEnterAni(arg_17_0)
	arg_17_0.hasViewStart_ = getData("skuldStageView", "hasViewStart")

	SetFile(arg_17_0.criLoopPlayer_, nil, "SofdecAsset/activity/Activity_Skuld_MianUI_loop.usm", CriMana.Player.SetMode.AppendRepeatedly)
	arg_17_0.criLoopPlayer_:Prepare()

	if SkuldSystemData:GetLevelIDIsClear(1030) then
		if not arg_17_0.hasViewStart_ then
			SetFile(arg_17_0.criplayer_, nil, "SofdecAsset/activity/Activity_Skuld_MianUI_start.usm", CriMana.Player.SetMode.Append)
			arg_17_0.criplayer_:Prepare()
			manager.windowBar:HideBar()
			arg_17_0:PlayMovie(arg_17_0.criplayer_, arg_17_0.criMovie_)
			arg_17_0.loopMovieController_:SetSelectedState("false")

			arg_17_0.movieGo_.transform.localPosition = Vector2(0, 0)
			arg_17_0.movieLoopGo_.transform.localPosition = Vector2(9999, 9999)
		else
			arg_17_0.movieLoopGo_.transform.localPosition = Vector2(0, 0)
			arg_17_0.movieGo_.transform.localPosition = Vector2(9999, 9999)

			arg_17_0:PlayMovie(arg_17_0.criLoopPlayer_, arg_17_0.criLoopMovie_)
			arg_17_0.loopMovieController_:SetSelectedState("true")
		end

		arg_17_0.movieController_:SetSelectedState("true")
		SetActive(arg_17_0.movieGo_, true)
		SetActive(arg_17_0.movieLoopGo_, true)
	else
		SetActive(arg_17_0.movieGo_, false)
		SetActive(arg_17_0.movieLoopGo_, false)
		arg_17_0.movieController_:SetSelectedState("false")
		arg_17_0.loopMovieController_:SetSelectedState("true")
	end
end

function var_0_0.PlayMovie(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = manager.audio:GetMusicVolume()

	arg_18_1:SetVolume(var_18_0)
	arg_18_2:Play()

	arg_18_0.moviePlaying = true
end

function var_0_0.CirMovieStatusChange(arg_19_0, arg_19_1)
	local var_19_0 = tostring(arg_19_1)

	if var_19_0 == "PlayEnd" then
		if not arg_19_0.hasViewStart_ then
			arg_19_0.hasViewStart_ = true

			saveData("skuldStageView", "hasViewStart", true)

			arg_19_0.movieLoopGo_.transform.localPosition = Vector2(0, 0)

			arg_19_0:PlayMovie(arg_19_0.criLoopPlayer_, arg_19_0.criLoopMovie_)

			arg_19_0.movieGo_.transform.localPosition = Vector2(9999, 9999)

			arg_19_0.loopMovieController_:SetSelectedState("true")
			arg_19_0.enterAni_:Update(0)
			arg_19_0.enterAni_:Play("NorseUI_3_0_NianMianUI_Skuld", -1, 0)
			manager.windowBar:SwitchBar({
				BACK_BAR,
				HOME_BAR,
				INFO_BAR
			})
			manager.windowBar:SetGameHelpKey("SKULD_SYSTEM_TIPS_1")
			arg_19_0:PlayUnlockAni()
			SkuldSystemAction.RefreshAudio()
		else
			arg_19_0.criMovie_:Stop()
		end
	elseif var_19_0 == "Stop" then
		arg_19_0.criMovie_:Stop()
	elseif var_19_0 == "Error" then
		arg_19_0.criMovie_:Stop()
	end
end

function var_0_0.PlayUnlockAni(arg_20_0)
	local var_20_0 = false

	for iter_20_0, iter_20_1 in pairs(SkuldStageCfg.get_id_list_by_section[9]) do
		if SkuldSystemData:GetLevelIDIsOpen(iter_20_1) then
			var_20_0 = true

			break
		end
	end

	if var_20_0 then
		arg_20_0.endingController_:SetSelectedState("unlock")

		if SkuldSystemData:GetClientKey("IsPlayEndUnlock") and not arg_20_0.hasViewStart_ then
			SetActive(arg_20_0.endingAniGo_, false)
		else
			SetActive(arg_20_0.endingAniGo_, true)
			arg_20_0.endingAni_:Play("stage_unlock")
			SkuldSystemAction.SendMark("IsPlayEndUnlock")
		end
	else
		SetActive(arg_20_0.endingAniGo_, false)
		arg_20_0.endingController_:SetSelectedState("lock")
	end
end

function var_0_0.StopMovie(arg_21_0)
	if arg_21_0.criMovie_ then
		arg_21_0.criMovie_:Stop()
	end

	if arg_21_0.criLoopMovie_ then
		arg_21_0.criLoopMovie_:Stop()
	end

	arg_21_0.moviePlaying = false
end

function var_0_0.DisPoseMovie(arg_22_0)
	if arg_22_0.criMovie_ or arg_22_0.criLoopMovie_ then
		arg_22_0:StopMovie()

		if arg_22_0.criPlayer_ then
			arg_22_0.criPlayer_:Dispose()

			arg_22_0.criplayer_.statusChangeCallback = nil
			arg_22_0.criPlayer_ = nil
		end

		if arg_22_0.criLoopPlayer_ then
			arg_22_0.criLoopPlayer_:Dispose()

			arg_22_0.criLoopPlayer_ = nil
		end
	end
end

function var_0_0.StopTimer(arg_23_0)
	if arg_23_0.timer_ then
		arg_23_0.timer_:Stop()

		arg_23_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0:StopTimer()
	arg_24_0.trustItem_:Dispose()
	arg_24_0:DisPoseMovie()
	arg_24_0.super.Dispose(arg_24_0)
end

return var_0_0
