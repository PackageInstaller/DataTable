local SelectHeroBaseView = class("SelectHeroBaseView", ReduxView)

function SelectHeroBaseView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SelectHeroBaseView:Init()
	self:InitUI()
	self:AddListener()
end

function SelectHeroBaseView:InitUI()
	self:BindCfgUI()
	self:InitSubViewCfg()
	self:InitCallback()
end

function SelectHeroBaseView:InitSubViewCfg()
	self.dragPosition_ = {}
	self.prepareToDrag_ = false
	self.heroInfoItemList_ = {}
end

function SelectHeroBaseView:InitCallback()
	self.cameraTransitionEndHandler_ = handler(self, self.OnCameraTransitionEnd)
	self.heroModelLoadedHandler_ = handler(self, self.OnHeroModelLoaded)
	self.changeHeroTeamHandler_ = handler(self, self.OnChangeHeroTeam)
end

function SelectHeroBaseView:SetProxy(arg_6_1)
	self.sectionProxy_ = arg_6_1
	self.canSwitchResctrictHeroList_ = {
		0,
		0,
		0
	}

	if self.sectionProxy_.stageType and self.sectionProxy_.stageID and self.sectionProxy_.stageID ~= 0 then
		local var_6_0, var_6_1 = BattleStageTools.GetRestrictHeroList(self.sectionProxy_.stageType, self.sectionProxy_.stageID)

		if type(var_6_1) == "table" then
			self.canSwitchResctrictHeroList_ = var_6_1
		end
	end

	self.reserveParams_ = arg_6_1:GetReserveParams()

	self:ProcessSubView()
end

function SelectHeroBaseView:ProcessSubView()
	self:InitSubView()
	self:TryReloadSubView()
	self:ProcessSubViewParams()
end

function SelectHeroBaseView:ProcessSubViewParams()
	for iter_8_0, iter_8_1 in ipairs(self.heroInfoItemList_) do
		iter_8_1:SetProxy(self.sectionProxy_)
	end
end

function SelectHeroBaseView:OnEnter()
	self:AddEventListener()
	self:ResetTempData()
	self:ResetUpdatePosFlag()
	self:SubViewOnEnter()
end

function SelectHeroBaseView:AddEventListener()
	self:RegistEventListener(RESERVE_CAMERA_SWITCH_END, self.cameraTransitionEndHandler_)
	self:RegistEventListener(SECTION_HERO_MODEL_LOADED, self.heroModelLoadedHandler_)
	self:RegistEventListener(SECTION_CHANGE_HERO_TEAM, self.changeHeroTeamHandler_)
end

function SelectHeroBaseView:ResetTempData()
	self.heroModel_ = {}
	self.cacheHeroNumber_ = {
		1,
		2,
		3
	}
	self.cacheHeroTeam_ = {}
	self.heroTrialList_ = {}
	self.needUpdatePosition_ = true
end

function SelectHeroBaseView:SubViewOnEnter()
	for iter_12_0, iter_12_1 in ipairs(self.heroInfoItemList_) do
		iter_12_1:OnEnter(iter_12_0)
	end
end

function SelectHeroBaseView:OnExit()
	self:ResetDragParams()
	self:RemoveAllEventListener()
	self:SubViewOnExit()

	for iter_13_0, iter_13_1 in ipairs(self.heroInfoItemList_) do
		iter_13_1:OnExit()
	end

	self:DestroyHeroModels()
	self:StopUpdatePosTimer()
end

function SelectHeroBaseView:SubViewOnExit()
	for iter_14_0, iter_14_1 in ipairs(self.heroInfoItemList_) do
		iter_14_1:OnExit()
	end
end

function SelectHeroBaseView:Dispose()
	for iter_15_0, iter_15_1 in ipairs(self.heroInfoItemList_) do
		iter_15_1:Dispose()
	end

	self.heroInfoItemList_ = nil
	self.dragPosition_ = nil

	SelectHeroBaseView.super.Dispose(self)
end

function SelectHeroBaseView:AddListener()
	return
end

function SelectHeroBaseView:BeginDragHero(arg_17_1, arg_17_2, arg_17_3)
	self.isDragging_ = false

	if not self.prepareToDrag_ then
		return
	end

	if self.selectIndex_ then
		return
	end

	if SectionSelectHeroScene.GetInstance():IsLoadingModel() then
		return
	end

	if not self.sectionProxy_.forceChangePos then
		if self.lockStateList_[arg_17_1] or self.sectionProxy_.canChangeTeam ~= nil and self.sectionProxy_.canChangeTeam == false then
			ShowTips("CAN_NOT_CHANGE_HERO")

			return
		end

		if self.lockStateList_[arg_17_1] or self.sectionProxy_.canHeroDrag ~= nil and self.sectionProxy_.canHeroDrag == false then
			ShowTips("NOT_DRAG_CHANGE_HERO")

			return
		end

		if self.canSwitchResctrictHeroList_[arg_17_1] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
			ShowTips("TEAM_ERROR_CHANGE")

			return
		end
	end

	self.isDragging_ = true
	self.selectIndex_ = arg_17_1
	self.dragGo_ = arg_17_2
	self.cacheSelectIndex_ = arg_17_1
	self.cacheHeroNumber_ = {
		1,
		2,
		3
	}

	manager.notify:Invoke(SECTION_BEGIN_DRAG_HERO)
end

function SelectHeroBaseView:DragHero(arg_18_1, arg_18_2, arg_18_3)
	if not self.isDragging_ then
		return
	end

	self:UpdateDragHeroInfoItemTransform(arg_18_1, arg_18_2, arg_18_3)
	self:UpdateDragHeroModelTransform(arg_18_1, arg_18_2, arg_18_3)
	self:TryModifyHeroPos()
end

function SelectHeroBaseView:UpdateDragHeroInfoItemTransform(arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_2.transform

	arg_19_2.transform:SetLocalPosition(arg_19_2.transform:GetLocalPosition() + Vector3((arg_19_3.delta * manager.ui.canvasRate).x, 0, 0))

	local var_19_1 = manager.ui.uiCamera:WorldToScreenPoint(arg_19_2:GetPosition())
	local var_19_2 = false

	if var_19_1.x < self.secondHeroScreenPos_.x then
		var_19_1.x = self.secondHeroScreenPos_.x
		var_19_2 = true
	elseif var_19_1.x > self.thirdHeroScreenPos_.x then
		var_19_1.x = self.thirdHeroScreenPos_.x
		var_19_2 = true
	end

	if var_19_2 then
		local var_19_3, var_19_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(var_19_0.parent, var_19_1, manager.ui.uiCamera, nil)

		var_19_0:SetLocalPosition(var_19_4)
	end
end

function SelectHeroBaseView:UpdateDragHeroModelTransform(arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = manager.ui.uiCamera:WorldToScreenPoint(arg_20_2:GetPosition())
	local var_20_1 = self:GetTargetDragDistance(var_20_0)

	SectionSelectHeroScene.GetInstance():SetModelLocalPosition(arg_20_1, SectionSelectHeroConst.HeroModelTransform[1].position + SectionSelectHeroTools.GetModelOffsetPosition(var_20_0, self.firstHeroScreenPos_, var_20_1))
	SectionSelectHeroScene.GetInstance():SetModelLocalRotation(arg_20_1, SectionSelectHeroConst.HeroModelTransform[1].rotation + SectionSelectHeroTools.GetModelOffsetRotation(var_20_0, self.firstHeroScreenPos_, var_20_1))
end

function SelectHeroBaseView:TryModifyHeroPos()
	local var_21_0 = SectionSelectHeroScene.GetInstance():GetModelLocalPosition(self.selectIndex_)

	for iter_21_0 = 1, 3 do
		if math.abs(SectionSelectHeroConst.HeroModelTransform[iter_21_0].position.x - var_21_0.x) <= 0.6 and iter_21_0 ~= self.cacheSelectIndex_ then
			if self.sectionProxy_.forceChangePos and not self.cacheHeroTeam_[iter_21_0] then
				return
			end

			if self.cacheHeroTeam_[self.cacheHeroNumber_[iter_21_0]] == 0 or self.canSwitchResctrictHeroList_[self.cacheHeroNumber_[iter_21_0]] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
				break
			end

			if not self.sectionProxy_.forceChangePos and (self.lockStateList_[self.selectIndex_] or self.lockStateList_[iter_21_0]) then
				return
			end

			SectionSelectHeroScene.GetInstance():UpdateModelTrans(SectionSelectHeroScene.GetInstance():GetModel(self.cacheHeroNumber_[iter_21_0]), self.cacheSelectIndex_, true)

			self.cacheHeroNumber_[iter_21_0] = self.cacheHeroNumber_[self.cacheSelectIndex_]
			self.cacheHeroNumber_[self.cacheSelectIndex_] = self.cacheHeroNumber_[iter_21_0]
			self.cacheSelectIndex_ = iter_21_0

			break
		end
	end
end

function SelectHeroBaseView:EndDragHero(arg_22_1, arg_22_2, arg_22_3)
	if not self.isDragging_ then
		return
	end

	self:ResetDragParams()
	self:EndDrag(arg_22_1)
end

function SelectHeroBaseView:ResetDragParams()
	if not self.isDragging_ then
		return
	end

	self.dragGo_.transform.localPosition = self.dragPosition_[self.selectIndex_]
	self.isDragging_ = false
	self.selectIndex_ = nil
	self.dragGo_ = nil
end

function SelectHeroBaseView:EndDrag(arg_24_1)
	local var_24_0 = {}

	for iter_24_0 = 1, 3 do
		var_24_0[iter_24_0] = self.cacheHeroTeam_[self.cacheHeroNumber_[iter_24_0]]
	end

	local var_24_1 = {}

	for iter_24_1, iter_24_2 in pairs(var_24_0) do
		local var_24_2 = 1

		for iter_24_3 = 1, 3 do
			if self.cacheHeroTeam_[iter_24_3] == iter_24_2 then
				var_24_2 = iter_24_3

				break
			end
		end

		var_24_1[iter_24_1] = var_24_2
	end

	SectionSelectHeroScene.GetInstance():ReorderModelByPosList(var_24_1)
	self:ChangeHeroTeam(var_24_0)
	self:RefreshHeroTeam()
	self:StartUpdateHeorInfoItemPos()
	OperationRecorder.Record(self.class.__cname, "endDrag")
end

function SelectHeroBaseView:ClickHero(arg_25_1, arg_25_2, arg_25_3)
	if not arg_25_3.dragging then
		if self.selectIndex_ then
			return
		end

		if SectionSelectHeroScene.GetInstance():IsLoadingModel() then
			return
		end

		self:RrocessClickHero(arg_25_1)
	end
end

function SelectHeroBaseView:RrocessClickHero(arg_26_1)
	manager.notify:Invoke(SECTION_CLICK_HERO, arg_26_1)
end

function SelectHeroBaseView:Refresh()
	self:RefreshHeroTeam()
	self:LoadHeroModels()
end

function SelectHeroBaseView:RefreshHeroTeam()
	self:GetHeroTeam()
	self:RefreshHeroInfoItem()
end

function SelectHeroBaseView:RefreshHeroInfoItem()
	for iter_29_0 = 1, 3 do
		self.heroInfoItemList_[iter_29_0]:Refresh(iter_29_0)
	end
end

function SelectHeroBaseView:ChangeHeroTeam(arg_30_1)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(arg_30_1) do
		var_30_0[iter_30_0] = self.heroTrialList_[table.keyof(self.cacheHeroTeam_, iter_30_1)]
	end

	self.sectionProxy_:ChangeHeroTeam(arg_30_1, var_30_0)
end

function SelectHeroBaseView:LoadHeroModels()
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in ipairs(self.cacheHeroTeam_) do
		var_31_0[iter_31_0] = iter_31_1 == 0 and 0 or self:GetSkinCfg(iter_31_0).id
	end

	SectionSelectHeroScene.GetInstance():LoadHeroModels(var_31_0, self.sectionProxy_.heroInfoList)
end

function SelectHeroBaseView:DestroyHeroModels()
	SectionSelectHeroScene.GetInstance():DestroyModels()
end

function SelectHeroBaseView:GetHeroTeam()
	self.cacheHeroTeam_, self.lockStateList_, self.lockList_, self.heroTrialList_ = self.sectionProxy_:GetHeroTeam()
end

function SelectHeroBaseView:GetRaceEffect()
	return self.sectionProxy_:GetRaceEffect()
end

function SelectHeroBaseView:CheckCanStartBattle()
	return not SectionSelectHeroScene.GetInstance():IsLoadingModel(), nil
end

function SelectHeroBaseView:GetSkinCfg(arg_36_1)
	return self.sectionProxy_:CustomGetSkinCfg(arg_36_1, self.cacheHeroTeam_[arg_36_1], self.heroTrialList_[arg_36_1])
end

function SelectHeroBaseView:GetHeroInfoItemClass()
	return self.sectionProxy_:GetHeroInfoItemClass()
end

function SelectHeroBaseView:InitSubView()
	local var_38_9000

	if not self.createdSubview_ then
		self.createdSubview_ = true
		self.heroInfoItemList_ = {}

		for iter_38_0 = 1, self.heroInfoItemContentTrans_.childCount do
			local var_38_0 = string.split(self.heroInfoItemContentTrans_:GetChild(iter_38_0 - 1).gameObject.name, "_")
			local var_38_1 = tonumber(var_38_0[var_38_9000])
			local var_38_2 = self:GetHeroInfoItemClass():New(var_38_1)

			self.heroInfoItemList_[var_38_1] = #var_38_0

			self:InitHeroInfoItem(var_38_1)
		end
	end
end

function SelectHeroBaseView:InitHeroInfoItem(arg_39_1)
	self.heroInfoItemList_[arg_39_1]:RegisterBeginDrag(handler(self, self.BeginDragHero))
	self.heroInfoItemList_[arg_39_1]:RegisterDrag(handler(self, self.DragHero))
	self.heroInfoItemList_[arg_39_1]:RegisterEndDrag(handler(self, self.EndDragHero))
	self.heroInfoItemList_[arg_39_1]:RegistClick(handler(self, self.ClickHero))
end

function SelectHeroBaseView:GetTargetDragDistance(arg_40_1)
	return arg_40_1.x <= self.firstHeroScreenPos_.x and self.f2SHeroScreenDistance_ or self.f2THeroScreenDistance_
end

function SelectHeroBaseView:ResetUpdatePosFlag()
	self.isCameraTransitionEnd_ = false
	self.isHeroModelLoaded_ = false
end

function SelectHeroBaseView:OnCameraTransitionEnd()
	self.isCameraTransitionEnd_ = true

	if self:CanUpdatePosition() then
		self:UpdatePosition()
	end
end

function SelectHeroBaseView:OnHeroModelLoaded()
	self.isHeroModelLoaded_ = true

	if self:CanUpdatePosition() then
		self:UpdatePosition()
	end
end

function SelectHeroBaseView:OnChangeHeroTeam()
	if self:CanUpdatePosition() then
		self:UpdatePosition()
	end
end

function SelectHeroBaseView:CanUpdatePosition()
	return self.isCameraTransitionEnd_ and self.isHeroModelLoaded_ and self.needUpdatePosition_
end

function SelectHeroBaseView:UpdatePosition()
	self:StopUpdatePosTimer()
	self:StartUpdatePosTimer()
end

function SelectHeroBaseView:StopUpdatePosTimer()
	if self.updatePosTimer_ then
		self.updatePosTimer_:Stop()

		self.updatePisTimer_ = nil
	end
end

function SelectHeroBaseView:StartUpdatePosTimer()
	self.updatePosTimer_ = FrameTimer.New(handler(self, self.OnUpdatePosTimerEnd), 1, 1)

	self.updatePosTimer_:Start()
end

function SelectHeroBaseView:OnUpdatePosTimerEnd()
	self:StartUpdateHeorInfoItemPos()

	self.needUpdatePosition_ = false
end

function SelectHeroBaseView:StartUpdateHeorInfoItemPos()
	for iter_50_0, iter_50_1 in ipairs(self.heroInfoItemList_) do
		if not iter_50_1:UpdatePosition() then
			Debug.LogError("Culculate hero pos error, reculculate at next frame")
			self:StartUpdatePosTimer()

			return
		end
	end

	self:UpdateDragParams()
end

function SelectHeroBaseView:UpdateDragParams()
	for iter_51_0, iter_51_1 in ipairs(self.heroInfoItemList_) do
		self.dragPosition_[iter_51_0] = iter_51_1:GetOriginalDragPosition()
	end

	self.firstHeroScreenPos_ = self.heroInfoItemList_[1]:GetOriginalDragScreenPosition()
	self.secondHeroScreenPos_ = self.heroInfoItemList_[2]:GetOriginalDragScreenPosition()
	self.thirdHeroScreenPos_ = self.heroInfoItemList_[3]:GetOriginalDragScreenPosition()
	self.f2SHeroScreenDistance_ = math.abs(self.firstHeroScreenPos_.x - self.secondHeroScreenPos_.x)
	self.f2THeroScreenDistance_ = math.abs(self.firstHeroScreenPos_.x - self.thirdHeroScreenPos_.x)
	self.prepareToDrag_ = true
end

function SelectHeroBaseView:TryReloadSubView()
	for iter_52_0, iter_52_1 in ipairs(self.heroInfoItemList_) do
		if SectionSelectHeroTools.IsDiffViewClass(iter_52_1, self.sectionProxy_:GetHeroInfoItemClass()) then
			iter_52_1 = SectionSelectHeroTools.ReloadView(iter_52_1, self.sectionProxy_:GetHeroInfoItemClass())

			self:InitHeroInfoItem(iter_52_0)
		end
	end

	self:RebindController()
end

function SelectHeroBaseView:RebindController()
	for iter_53_0, iter_53_1 in ipairs(self.heroInfoItemList_) do
		iter_53_1:RebindController()
	end
end

return SelectHeroBaseView
