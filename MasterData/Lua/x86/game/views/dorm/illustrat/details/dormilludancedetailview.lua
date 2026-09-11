local DormIlluDanceDetailView = class("DormIlluDanceDetailView", ReduxView)

function DormIlluDanceDetailView:UIName()
	return "Widget/BackHouseUI/IdolDance/IdolDanceIllustrateDanceDetailsUI"
end

function DormIlluDanceDetailView:UIParent()
	return manager.ui.uiMain.transform
end

function DormIlluDanceDetailView:Init()
	self:InitUI()
end

function DormIlluDanceDetailView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function DormIlluDanceDetailView:OnBehind()
	manager.windowBar:HideBar()
end

function DormIlluDanceDetailView:OnEnter()
	if self.infoPage_ then
		self.infoPage_:OnEnter(self.params_.danceID)
	end

	self.uiList_:StartScroll(#self.heroIDList_)
	self.uiList_:Refresh()

	if self.heroID_ == 0 then
		self:ChangeHeroID(self.heroIDList_[0] or 1084)
	end

	self:UpdateHeroModel()
	self:ChangeDanceID(self.params_.danceID)

	self.danceIDList_ = self.params_.danceIDList
	self.doneAniList_ = {}

	manager.ui:SetMainCameraCom("CinemachineBrain", false)
	manager.ui:SetMainCamera("hero")
end

function DormIlluDanceDetailView:OnExit()
	if self.infoPage_ then
		self.infoPage_:OnExit()
	end

	if self.entityID_ and self.entityID_ ~= 0 then
		self:StopSeq()
		DormIllu.RemoveDanceHero(self.entityID_)

		self.entityID_ = 0
	end

	self.danceID_ = 0

	manager.ui:ResetMainCamera()
end

function DormIlluDanceDetailView:Dispose()
	if self.infoPage_ then
		self.infoPage_:Dispose()

		self.infoPage_ = nil
	end

	if self.uiList_ then
		self.uiList_:Dispose()
	end

	if self.entityID_ and self.entityID_ ~= 0 then
		DormIllu.RemoveDanceHero(self.entityID_)

		self.entityID_ = 0
	end

	DormIlluDanceDetailView.super.Dispose(self)
end

function DormIlluDanceDetailView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.playController_ = self.playControllerEx_:GetController("play")
	self.infoPage_ = DormIlluDanceDetailInfoView.New(self.danceInfoSubView_)
	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.heroList_, DormDanceHeroItem)
	self.danceIDList_ = {}
	self.danceID_ = 0
	self.heroIDList_ = IdolTraineeData:GetIdolHeroList()
	self.heroID_ = 0
end

function DormIlluDanceDetailView:AddUIListener()
	self:AddBtnListener(self.playBtn_, nil, function()
		if self.task and not self.task:IsAborted() then
			self:StopSeq()
		else
			self:UpdateAni()
		end
	end)
	self:AddBtnListener(self.leftBtn_, nil, function()
		local var_12_0 = 0

		for iter_12_0, iter_12_1 in ipairs(self.danceIDList_) do
			if iter_12_1 == self.danceID_ then
				var_12_0 = iter_12_0 == 1 and self.danceIDList_[#self.danceIDList_] or self.danceIDList_[iter_12_0 - 1]
			end
		end

		self:ChangeDanceID(var_12_0)
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		local var_13_0 = 0

		for iter_13_0, iter_13_1 in ipairs(self.danceIDList_) do
			if iter_13_1 == self.danceID_ then
				var_13_0 = iter_13_0 == #self.danceIDList_ and self.danceIDList_[1] or self.danceIDList_[iter_13_0 + 1]
			end
		end

		self:ChangeDanceID(var_13_0)
	end)
	self:AddDragListener(self.backGo_, function()
		local var_14_0 = Dorm.DormEntityManager.GetTransform(self.entityID_)

		self.startRot_ = var_14_0 and var_14_0.localEulerAngles or Vector3.zero
		self.lastRotateY_ = nil
		self.lastDeltaX_ = 0
	end, function(arg_15_0, arg_15_1)
		local var_15_0 = Dorm.DormEntityManager.GetTransform(self.entityID_)

		if var_15_0 then
			local var_15_1 = self.lastRotateY_ or var_15_0.localEulerAngles.y
			local var_15_2 = var_15_1 + (arg_15_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_15_1

			if var_15_1 + (arg_15_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_15_1 < -HeroConst.MAX_RORATE_ANGLE then
				var_15_2 = -HeroConst.MAX_RORATE_ANGLE
			elseif var_15_1 + (arg_15_0 - (self.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_15_1 > HeroConst.MAX_RORATE_ANGLE then
				var_15_2 = HeroConst.MAX_RORATE_ANGLE
			end

			self.lastRotateY_ = var_15_1 + var_15_2
			self.lastDeltaX_ = arg_15_0
			var_15_0.localRotation = Quaternion.RotateTowards(var_15_0.localRotation, Quaternion.Euler(self.startRot_.x, var_15_1 + var_15_2, self.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function DormIlluDanceDetailView:IndexItem(arg_16_1, arg_16_2)
	arg_16_2:Show(self.heroIDList_[arg_16_1])
	arg_16_2:SetSelectState(self.heroID_)
	arg_16_2:RegistCallBack(function(arg_17_0)
		self:ChangeHeroID(arg_17_0)
	end)
end

function DormIlluDanceDetailView:ChangeDanceID(arg_18_1)
	if self.danceID_ == arg_18_1 then
		return
	end

	self.danceID_ = arg_18_1

	self:UpdateAni()
end

function DormIlluDanceDetailView:ChangeHeroID(arg_19_1)
	if self.heroID_ == arg_19_1 then
		return
	end

	self.heroID_ = arg_19_1

	self.uiList_:Refresh()
	self:UpdateView()
end

function DormIlluDanceDetailView:UpdateView()
	self:UpdateHeroModel()
	self:UpdateAni()
end

function DormIlluDanceDetailView:UpdateHeroModel()
	if self.entityID_ and self.entityID_ ~= 0 then
		self:StopSeq()
		DormIllu.RemoveDanceHero(self.entityID_)

		self.entityID_ = 0
	end

	self.entityID_ = DormIllu.GetDanceHero(self.heroID_)

	Dorm.DormEntityManager.PutEntityAt(self.entityID_, Vector3.New(500.37, 1.29, 3.36))
end

function DormIlluDanceDetailView:UpdateAni()
	if self.danceID_ ~= 0 then
		if self.entityID_ and self.entityID_ ~= 0 and IdolDanceDIYActionCfg[self.danceID_].anime_action then
			self:StopSeq()
			self:AppendActionTurn(self.entityID_, (self:GetSequenceActionInfoFromActionItem(IdolDanceDIYActionCfg[self.danceID_].anime_action)))
		end

		self.infoPage_:UpdateView(self.danceID_)
	end
end

local function var_0_1(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:Now()

	return (arg_23_1.startTime or 0) + var_23_0, (arg_23_1.endTime or nil) and var_23_0 + arg_23_1.endTime
end

function DormIlluDanceDetailView:StopSeq()
	Dorm.DormEntityManager.StopAllCmd(self.entityID_)

	if self.task then
		self.task:Abort()

		self.task = nil
	end
end

function DormIlluDanceDetailView:AppendActionTurn(arg_25_1, arg_25_2)
	local var_25_0 = DormCharacterActionManager.frameTaskRunner
	local var_25_1, var_25_2 = var_0_1(DormCharacterActionManager.frameTaskRunner, arg_25_2)
	local var_25_3

	if var_25_2 then
		var_25_3 = var_25_2 - var_25_1
	end

	self.task = DormCharacterActionManager.frameTaskRunner:NewTask()

	self.task:WaitUntil(function()
		return var_25_0:Now() >= var_25_1
	end):Then(function(arg_27_0)
		if arg_25_2.onStart then
			arg_25_2:onStart()
		end

		Dorm.DormEntityManager.StopAllCmd(arg_25_1)

		local var_27_0, var_27_1 = DanceGame.MakeCtxForAction(arg_25_1, arg_25_1, arg_25_2.action)

		if var_27_1 then
			if var_25_3 == nil then
				var_25_3 = var_27_1.duration
				var_25_2 = var_25_1 + var_25_3
			else
				var_27_1 = DanceGame.GetSeqAlignedToRoundDuration(var_27_1, var_25_3)
			end

			var_27_0.curActionTask = DormCharacterInteractBehaviour.MakeInteractTask(var_27_1, var_27_0)

			DormUtils.SetEntityInteractContext(arg_25_1, var_27_0)
			Dorm.DormEntityManager.SendInteractToEntityCMD(arg_25_1, arg_25_1, true)
		end
	end):WaitUntil(function()
		if var_25_3 > 0 and arg_25_2.onUpdate then
			arg_25_2:onUpdate((var_25_0:Now() - var_25_1) / var_25_3, var_25_1, var_25_2)
		end

		return var_25_2 == nil or var_25_0:Now() >= var_25_2
	end):Then(function()
		DanceGameController.SetEntityAnimeSpeed(arg_25_1, 1)
	end)
	self.task:Start(true)
	self.task:SetOnAbort(function()
		if arg_25_2.onAbort then
			arg_25_2:onAbort()
		end
	end)
	self.task:SetOnComplete(function()
		if not self.danceID_ or self.danceID_ == 0 then
			return
		end

		self:AppendActionTurn(self.entityID_, (self:GetSequenceActionInfoFromActionItem(IdolDanceDIYActionCfg[self.danceID_].anime_action)))
	end)

	return self.task
end

function DormIlluDanceDetailView:GetSequenceActionInfoFromActionItem(arg_32_1)
	return {
		actionID = self.danceID_,
		action = arg_32_1,
		onStart = function(arg_33_0)
			self:OnPreviewStart()
		end,
		onUpdate = function(arg_34_0, arg_34_1)
			self:OnPreviewUpdate(arg_34_1)
		end,
		onAbort = function(arg_35_0)
			self:OnPreviewEnd()
		end,
		onComplete = function(arg_36_0)
			self:OnPreviewEnd()
		end
	}
end

function DormIlluDanceDetailView:SetPlayState(arg_37_1)
	self.playController_:SetSelectedState(arg_37_1 and "on" or "off")
end

function DormIlluDanceDetailView:OnPreviewStart()
	self:SetPlayState(true)

	self.progress_.fillAmount = 0
end

function DormIlluDanceDetailView:OnPreviewUpdate(arg_39_1)
	self.progress_.fillAmount = arg_39_1
end

function DormIlluDanceDetailView:OnPreviewEnd()
	self:SetPlayState(false)

	self.progress_.fillAmount = 0
end

return DormIlluDanceDetailView
