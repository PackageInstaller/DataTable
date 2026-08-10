local var_0_0 = class("DormIlluDanceDetailView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolDance/IdolDanceIllustrateDanceDetailsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.OnTop(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.OnBehind(arg_5_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_6_0)
	if arg_6_0.infoPage_ then
		arg_6_0.infoPage_:OnEnter(arg_6_0.params_.danceID)
	end

	arg_6_0.uiList_:StartScroll(#arg_6_0.heroIDList_)
	arg_6_0.uiList_:Refresh()

	if arg_6_0.heroID_ == 0 then
		arg_6_0:ChangeHeroID(arg_6_0.heroIDList_[0] or 1084)
	end

	arg_6_0:UpdateHeroModel()
	arg_6_0:ChangeDanceID(arg_6_0.params_.danceID)

	arg_6_0.danceIDList_ = arg_6_0.params_.danceIDList
	arg_6_0.doneAniList_ = {}

	manager.ui:SetMainCameraCom("CinemachineBrain", false)
	manager.ui:SetMainCamera("hero")
end

function var_0_0.OnExit(arg_7_0)
	if arg_7_0.infoPage_ then
		arg_7_0.infoPage_:OnExit()
	end

	if arg_7_0.entityID_ and arg_7_0.entityID_ ~= 0 then
		arg_7_0:StopSeq()
		DormIllu.RemoveDanceHero(arg_7_0.entityID_)

		arg_7_0.entityID_ = 0
	end

	arg_7_0.danceID_ = 0

	manager.ui:ResetMainCamera()
end

function var_0_0.Dispose(arg_8_0)
	if arg_8_0.infoPage_ then
		arg_8_0.infoPage_:Dispose()

		arg_8_0.infoPage_ = nil
	end

	if arg_8_0.uiList_ then
		arg_8_0.uiList_:Dispose()
	end

	if arg_8_0.entityID_ and arg_8_0.entityID_ ~= 0 then
		DormIllu.RemoveDanceHero(arg_8_0.entityID_)

		arg_8_0.entityID_ = 0
	end

	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.InitUI(arg_9_0)
	arg_9_0:BindCfgUI()
	arg_9_0:AddUIListener()

	arg_9_0.playController_ = arg_9_0.playControllerEx_:GetController("play")
	arg_9_0.infoPage_ = DormIlluDanceDetailInfoView.New(arg_9_0.danceInfoSubView_)
	arg_9_0.uiList_ = LuaList.New(handler(arg_9_0, arg_9_0.IndexItem), arg_9_0.heroList_, DormDanceHeroItem)
	arg_9_0.danceIDList_ = {}
	arg_9_0.danceID_ = 0
	arg_9_0.heroIDList_ = IdolTraineeData:GetIdolHeroList()
	arg_9_0.heroID_ = 0
end

function var_0_0.AddUIListener(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.playBtn_, nil, function()
		if arg_10_0.task and not arg_10_0.task:IsAborted() then
			arg_10_0:StopSeq()
		else
			arg_10_0:UpdateAni()
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.leftBtn_, nil, function()
		local var_12_0 = 0

		for iter_12_0, iter_12_1 in ipairs(arg_10_0.danceIDList_) do
			if iter_12_1 == arg_10_0.danceID_ then
				if iter_12_0 == 1 then
					var_12_0 = arg_10_0.danceIDList_[#arg_10_0.danceIDList_]
				else
					var_12_0 = arg_10_0.danceIDList_[iter_12_0 - 1]
				end
			end
		end

		arg_10_0:ChangeDanceID(var_12_0)
	end)
	arg_10_0:AddBtnListener(arg_10_0.rightBtn_, nil, function()
		local var_13_0 = 0

		for iter_13_0, iter_13_1 in ipairs(arg_10_0.danceIDList_) do
			if iter_13_1 == arg_10_0.danceID_ then
				if iter_13_0 == #arg_10_0.danceIDList_ then
					var_13_0 = arg_10_0.danceIDList_[1]
				else
					var_13_0 = arg_10_0.danceIDList_[iter_13_0 + 1]
				end
			end
		end

		arg_10_0:ChangeDanceID(var_13_0)
	end)
	arg_10_0:AddDragListener(arg_10_0.backGo_, function()
		local var_14_0 = Dorm.DormEntityManager.GetTransform(arg_10_0.entityID_)

		if var_14_0 then
			arg_10_0.startRot_ = var_14_0.localEulerAngles
		else
			arg_10_0.startRot_ = Vector3.zero
		end

		arg_10_0.lastRotateY_ = nil
		arg_10_0.lastDeltaX_ = 0
	end, function(arg_15_0, arg_15_1)
		local var_15_0 = Dorm.DormEntityManager.GetTransform(arg_10_0.entityID_)

		if var_15_0 then
			local var_15_1 = arg_10_0.lastRotateY_ or var_15_0.localEulerAngles.y
			local var_15_2 = var_15_1 + (arg_15_0 - (arg_10_0.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_15_1
			local var_15_3 = var_15_2

			if var_15_2 < -HeroConst.MAX_RORATE_ANGLE then
				var_15_3 = -HeroConst.MAX_RORATE_ANGLE
			elseif var_15_2 > HeroConst.MAX_RORATE_ANGLE then
				var_15_3 = HeroConst.MAX_RORATE_ANGLE
			end

			arg_10_0.lastRotateY_ = var_15_1 + var_15_3
			arg_10_0.lastDeltaX_ = arg_15_0
			var_15_0.localRotation = Quaternion.RotateTowards(var_15_0.localRotation, Quaternion.Euler(arg_10_0.startRot_.x, var_15_1 + var_15_3, arg_10_0.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function var_0_0.IndexItem(arg_16_0, arg_16_1, arg_16_2)
	arg_16_2:Show(arg_16_0.heroIDList_[arg_16_1])
	arg_16_2:SetSelectState(arg_16_0.heroID_)
	arg_16_2:RegistCallBack(function(arg_17_0)
		arg_16_0:ChangeHeroID(arg_17_0)
	end)
end

function var_0_0.ChangeDanceID(arg_18_0, arg_18_1)
	if arg_18_0.danceID_ == arg_18_1 then
		return
	end

	arg_18_0.danceID_ = arg_18_1

	arg_18_0:UpdateAni()
end

function var_0_0.ChangeHeroID(arg_19_0, arg_19_1)
	if arg_19_0.heroID_ == arg_19_1 then
		return
	end

	arg_19_0.heroID_ = arg_19_1

	arg_19_0.uiList_:Refresh()
	arg_19_0:UpdateView()
end

function var_0_0.UpdateView(arg_20_0)
	arg_20_0:UpdateHeroModel()
	arg_20_0:UpdateAni()
end

function var_0_0.UpdateHeroModel(arg_21_0)
	if arg_21_0.entityID_ and arg_21_0.entityID_ ~= 0 then
		arg_21_0:StopSeq()
		DormIllu.RemoveDanceHero(arg_21_0.entityID_)

		arg_21_0.entityID_ = 0
	end

	arg_21_0.entityID_ = DormIllu.GetDanceHero(arg_21_0.heroID_)

	Dorm.DormEntityManager.PutEntityAt(arg_21_0.entityID_, Vector3.New(500.37, 1.29, 3.36))
end

function var_0_0.UpdateAni(arg_22_0)
	if arg_22_0.danceID_ ~= 0 then
		local var_22_0 = IdolDanceDIYActionCfg[arg_22_0.danceID_].anime_action

		if arg_22_0.entityID_ and arg_22_0.entityID_ ~= 0 and var_22_0 then
			arg_22_0:StopSeq()

			local var_22_1 = arg_22_0:GetSequenceActionInfoFromActionItem(var_22_0)

			arg_22_0:AppendActionTurn(arg_22_0.entityID_, var_22_1)
		end

		arg_22_0.infoPage_:UpdateView(arg_22_0.danceID_)
	end
end

local function var_0_1(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:Now()
	local var_23_1 = (arg_23_1.startTime or 0) + var_23_0
	local var_23_2

	if arg_23_1.endTime then
		var_23_2 = var_23_0 + arg_23_1.endTime
	end

	return var_23_1, var_23_2
end

function var_0_0.StopSeq(arg_24_0)
	Dorm.DormEntityManager.StopAllCmd(arg_24_0.entityID_)

	if arg_24_0.task then
		arg_24_0.task:Abort()

		arg_24_0.task = nil
	end
end

function var_0_0.AppendActionTurn(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = DormCharacterActionManager.frameTaskRunner
	local var_25_1, var_25_2 = var_0_1(var_25_0, arg_25_2)
	local var_25_3

	if var_25_2 then
		var_25_3 = var_25_2 - var_25_1
	end

	arg_25_0.task = var_25_0:NewTask()

	arg_25_0.task:WaitUntil(function()
		return var_25_0:Now() >= var_25_1
	end):Then(function(arg_27_0)
		if arg_25_2.onStart then
			arg_25_2:onStart()
		end

		Dorm.DormEntityManager.StopAllCmd(arg_25_1)

		local var_27_0 = arg_25_2.action
		local var_27_1, var_27_2 = DanceGame.MakeCtxForAction(arg_25_1, arg_25_1, var_27_0)

		if var_27_2 then
			if var_25_3 == nil then
				var_25_3 = var_27_2.duration
				var_25_2 = var_25_1 + var_25_3
			else
				var_27_2 = DanceGame.GetSeqAlignedToRoundDuration(var_27_2, var_25_3)
			end

			var_27_1.curActionTask = DormCharacterInteractBehaviour.MakeInteractTask(var_27_2, var_27_1)

			DormUtils.SetEntityInteractContext(arg_25_1, var_27_1)
			Dorm.DormEntityManager.SendInteractToEntityCMD(arg_25_1, arg_25_1, true)
		end
	end):WaitUntil(function()
		if var_25_3 > 0 and arg_25_2.onUpdate then
			local var_28_0 = (var_25_0:Now() - var_25_1) / var_25_3

			arg_25_2:onUpdate(var_28_0, var_25_1, var_25_2)
		end

		return var_25_2 == nil or var_25_0:Now() >= var_25_2
	end):Then(function()
		DanceGameController.SetEntityAnimeSpeed(arg_25_1, 1)
	end)
	arg_25_0.task:Start(true)
	arg_25_0.task:SetOnAbort(function()
		if arg_25_2.onAbort then
			arg_25_2:onAbort()
		end
	end)
	arg_25_0.task:SetOnComplete(function()
		if not arg_25_0.danceID_ or arg_25_0.danceID_ == 0 then
			return
		end

		local var_31_0 = IdolDanceDIYActionCfg[arg_25_0.danceID_].anime_action
		local var_31_1 = arg_25_0:GetSequenceActionInfoFromActionItem(var_31_0)

		arg_25_0:AppendActionTurn(arg_25_0.entityID_, var_31_1)
	end)

	return arg_25_0.task
end

function var_0_0.GetSequenceActionInfoFromActionItem(arg_32_0, arg_32_1)
	return {
		actionID = arg_32_0.danceID_,
		action = arg_32_1,
		onStart = function(arg_33_0)
			arg_32_0:OnPreviewStart()
		end,
		onUpdate = function(arg_34_0, arg_34_1)
			arg_32_0:OnPreviewUpdate(arg_34_1)
		end,
		onAbort = function(arg_35_0)
			arg_32_0:OnPreviewEnd()
		end,
		onComplete = function(arg_36_0)
			arg_32_0:OnPreviewEnd()
		end
	}
end

function var_0_0.SetPlayState(arg_37_0, arg_37_1)
	arg_37_0.playController_:SetSelectedState(arg_37_1 and "on" or "off")
end

function var_0_0.OnPreviewStart(arg_38_0)
	arg_38_0:SetPlayState(true)

	arg_38_0.progress_.fillAmount = 0
end

function var_0_0.OnPreviewUpdate(arg_39_0, arg_39_1)
	arg_39_0.progress_.fillAmount = arg_39_1
end

function var_0_0.OnPreviewEnd(arg_40_0)
	arg_40_0:SetPlayState(false)

	arg_40_0.progress_.fillAmount = 0
end

return var_0_0
