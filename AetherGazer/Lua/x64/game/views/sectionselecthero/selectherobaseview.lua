local var_0_0 = class("SelectHeroBaseView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:InitSubViewCfg()
	arg_3_0:InitCallback()
end

function var_0_0.InitSubViewCfg(arg_4_0)
	arg_4_0.dragPosition_ = {}
	arg_4_0.prepareToDrag_ = false
	arg_4_0.heroInfoItemList_ = {}
end

function var_0_0.InitCallback(arg_5_0)
	arg_5_0.cameraTransitionEndHandler_ = handler(arg_5_0, arg_5_0.OnCameraTransitionEnd)
	arg_5_0.heroModelLoadedHandler_ = handler(arg_5_0, arg_5_0.OnHeroModelLoaded)
	arg_5_0.changeHeroTeamHandler_ = handler(arg_5_0, arg_5_0.OnChangeHeroTeam)
end

function var_0_0.SetProxy(arg_6_0, arg_6_1)
	arg_6_0.sectionProxy_ = arg_6_1
	arg_6_0.canSwitchResctrictHeroList_ = {
		0,
		0,
		0
	}

	if arg_6_0.sectionProxy_.stageType and arg_6_0.sectionProxy_.stageID and arg_6_0.sectionProxy_.stageID ~= 0 then
		local var_6_0, var_6_1 = BattleStageTools.GetRestrictHeroList(arg_6_0.sectionProxy_.stageType, arg_6_0.sectionProxy_.stageID)

		if type(var_6_1) == "table" then
			arg_6_0.canSwitchResctrictHeroList_ = var_6_1
		end
	end

	arg_6_0.reserveParams_ = arg_6_1:GetReserveParams()

	arg_6_0:ProcessSubView()
end

function var_0_0.ProcessSubView(arg_7_0)
	arg_7_0:InitSubView()
	arg_7_0:TryReloadSubView()
	arg_7_0:ProcessSubViewParams()
end

function var_0_0.ProcessSubViewParams(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.heroInfoItemList_) do
		iter_8_1:SetProxy(arg_8_0.sectionProxy_)
	end
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:AddEventListener()
	arg_9_0:ResetTempData()
	arg_9_0:ResetUpdatePosFlag()
	arg_9_0:SubViewOnEnter()
end

function var_0_0.AddEventListener(arg_10_0)
	arg_10_0:RegistEventListener(RESERVE_CAMERA_SWITCH_END, arg_10_0.cameraTransitionEndHandler_)
	arg_10_0:RegistEventListener(SECTION_HERO_MODEL_LOADED, arg_10_0.heroModelLoadedHandler_)
	arg_10_0:RegistEventListener(SECTION_CHANGE_HERO_TEAM, arg_10_0.changeHeroTeamHandler_)
end

function var_0_0.ResetTempData(arg_11_0)
	arg_11_0.heroModel_ = {}
	arg_11_0.cacheHeroNumber_ = {
		1,
		2,
		3
	}
	arg_11_0.cacheHeroTeam_ = {}
	arg_11_0.heroTrialList_ = {}
	arg_11_0.needUpdatePosition_ = true
end

function var_0_0.SubViewOnEnter(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.heroInfoItemList_) do
		iter_12_1:OnEnter(iter_12_0)
	end
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:ResetDragParams()
	arg_13_0:RemoveAllEventListener()
	arg_13_0:SubViewOnExit()

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.heroInfoItemList_) do
		iter_13_1:OnExit()
	end

	arg_13_0:DestroyHeroModels()
	arg_13_0:StopUpdatePosTimer()
end

function var_0_0.SubViewOnExit(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.heroInfoItemList_) do
		iter_14_1:OnExit()
	end
end

function var_0_0.Dispose(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.heroInfoItemList_) do
		iter_15_1:Dispose()
	end

	arg_15_0.heroInfoItemList_ = nil
	arg_15_0.dragPosition_ = nil

	var_0_0.super.Dispose(arg_15_0)
end

function var_0_0.AddListener(arg_16_0)
	return
end

function var_0_0.BeginDragHero(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0.isDragging_ = false

	if not arg_17_0.prepareToDrag_ then
		return
	end

	if arg_17_0.selectIndex_ then
		return
	end

	if SectionSelectHeroScene.GetInstance():IsLoadingModel() then
		return
	end

	if not arg_17_0.sectionProxy_.forceChangePos then
		if arg_17_0.lockStateList_[arg_17_1] or arg_17_0.sectionProxy_.canChangeTeam ~= nil and arg_17_0.sectionProxy_.canChangeTeam == false then
			ShowTips("CAN_NOT_CHANGE_HERO")

			return
		end

		if arg_17_0.lockStateList_[arg_17_1] or arg_17_0.sectionProxy_.canHeroDrag ~= nil and arg_17_0.sectionProxy_.canHeroDrag == false then
			ShowTips("NOT_DRAG_CHANGE_HERO")

			return
		end

		if arg_17_0.canSwitchResctrictHeroList_[arg_17_1] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
			ShowTips("TEAM_ERROR_CHANGE")

			return
		end
	end

	arg_17_0.isDragging_ = true
	arg_17_0.selectIndex_ = arg_17_1
	arg_17_0.dragGo_ = arg_17_2
	arg_17_0.cacheSelectIndex_ = arg_17_1
	arg_17_0.cacheHeroNumber_ = {
		1,
		2,
		3
	}

	manager.notify:Invoke(SECTION_BEGIN_DRAG_HERO)
end

function var_0_0.DragHero(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if not arg_18_0.isDragging_ then
		return
	end

	arg_18_0:UpdateDragHeroInfoItemTransform(arg_18_1, arg_18_2, arg_18_3)
	arg_18_0:UpdateDragHeroModelTransform(arg_18_1, arg_18_2, arg_18_3)
	arg_18_0:TryModifyHeroPos()
end

function var_0_0.UpdateDragHeroInfoItemTransform(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_3.delta * manager.ui.canvasRate
	local var_19_1 = Vector3(var_19_0.x, 0, 0)
	local var_19_2 = arg_19_2.transform
	local var_19_3 = var_19_2:GetLocalPosition()

	var_19_2:SetLocalPosition(var_19_3 + var_19_1)

	local var_19_4 = manager.ui.uiCamera:WorldToScreenPoint(arg_19_2:GetPosition())
	local var_19_5 = false

	if var_19_4.x < arg_19_0.secondHeroScreenPos_.x then
		var_19_4.x = arg_19_0.secondHeroScreenPos_.x
		var_19_5 = true
	elseif var_19_4.x > arg_19_0.thirdHeroScreenPos_.x then
		var_19_4.x = arg_19_0.thirdHeroScreenPos_.x
		var_19_5 = true
	end

	if var_19_5 then
		local var_19_6, var_19_7 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(var_19_2.parent, var_19_4, manager.ui.uiCamera, nil)

		var_19_2:SetLocalPosition(var_19_7)
	end
end

function var_0_0.UpdateDragHeroModelTransform(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = manager.ui.uiCamera:WorldToScreenPoint(arg_20_2:GetPosition())
	local var_20_1 = arg_20_0:GetTargetDragDistance(var_20_0)
	local var_20_2 = SectionSelectHeroTools.GetModelOffsetPosition(var_20_0, arg_20_0.firstHeroScreenPos_, var_20_1)

	SectionSelectHeroScene.GetInstance():SetModelLocalPosition(arg_20_1, SectionSelectHeroConst.HeroModelTransform[1].position + var_20_2)

	local var_20_3 = SectionSelectHeroTools.GetModelOffsetRotation(var_20_0, arg_20_0.firstHeroScreenPos_, var_20_1)

	SectionSelectHeroScene.GetInstance():SetModelLocalRotation(arg_20_1, SectionSelectHeroConst.HeroModelTransform[1].rotation + var_20_3)
end

function var_0_0.TryModifyHeroPos(arg_21_0)
	local var_21_0 = SectionSelectHeroScene.GetInstance():GetModelLocalPosition(arg_21_0.selectIndex_)

	for iter_21_0 = 1, 3 do
		if math.abs(SectionSelectHeroConst.HeroModelTransform[iter_21_0].position.x - var_21_0.x) <= 0.6 and iter_21_0 ~= arg_21_0.cacheSelectIndex_ then
			if arg_21_0.sectionProxy_.forceChangePos and not arg_21_0.cacheHeroTeam_[iter_21_0] then
				return
			end

			if arg_21_0.cacheHeroTeam_[arg_21_0.cacheHeroNumber_[iter_21_0]] == 0 or arg_21_0.canSwitchResctrictHeroList_[arg_21_0.cacheHeroNumber_[iter_21_0]] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
				break
			end

			if not arg_21_0.sectionProxy_.forceChangePos and (arg_21_0.lockStateList_[arg_21_0.selectIndex_] or arg_21_0.lockStateList_[iter_21_0]) then
				return
			end

			local var_21_1 = SectionSelectHeroScene.GetInstance():GetModel(arg_21_0.cacheHeroNumber_[iter_21_0])

			SectionSelectHeroScene.GetInstance():UpdateModelTrans(var_21_1, arg_21_0.cacheSelectIndex_, true)

			local var_21_2 = arg_21_0.cacheHeroNumber_[iter_21_0]

			arg_21_0.cacheHeroNumber_[iter_21_0] = arg_21_0.cacheHeroNumber_[arg_21_0.cacheSelectIndex_]
			arg_21_0.cacheHeroNumber_[arg_21_0.cacheSelectIndex_] = var_21_2
			arg_21_0.cacheSelectIndex_ = iter_21_0

			break
		end
	end
end

function var_0_0.EndDragHero(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if not arg_22_0.isDragging_ then
		return
	end

	arg_22_0:ResetDragParams()
	arg_22_0:EndDrag(arg_22_1)
end

function var_0_0.ResetDragParams(arg_23_0)
	if not arg_23_0.isDragging_ then
		return
	end

	arg_23_0.dragGo_.transform.localPosition = arg_23_0.dragPosition_[arg_23_0.selectIndex_]
	arg_23_0.isDragging_ = false
	arg_23_0.selectIndex_ = nil
	arg_23_0.dragGo_ = nil
end

function var_0_0.EndDrag(arg_24_0, arg_24_1)
	local var_24_0 = {}

	for iter_24_0 = 1, 3 do
		var_24_0[iter_24_0] = arg_24_0.cacheHeroTeam_[arg_24_0.cacheHeroNumber_[iter_24_0]]
	end

	local var_24_1 = {}

	for iter_24_1, iter_24_2 in pairs(var_24_0) do
		local var_24_2 = 1

		for iter_24_3 = 1, 3 do
			if arg_24_0.cacheHeroTeam_[iter_24_3] == iter_24_2 then
				var_24_2 = iter_24_3

				break
			end
		end

		var_24_1[iter_24_1] = var_24_2
	end

	SectionSelectHeroScene.GetInstance():ReorderModelByPosList(var_24_1)
	arg_24_0:ChangeHeroTeam(var_24_0)
	arg_24_0:RefreshHeroTeam()
	arg_24_0:StartUpdateHeorInfoItemPos()
	OperationRecorder.Record(arg_24_0.class.__cname, "endDrag")
end

function var_0_0.ClickHero(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if not arg_25_3.dragging then
		if arg_25_0.selectIndex_ then
			return
		end

		if SectionSelectHeroScene.GetInstance():IsLoadingModel() then
			return
		end

		arg_25_0:RrocessClickHero(arg_25_1)
	end
end

function var_0_0.RrocessClickHero(arg_26_0, arg_26_1)
	manager.notify:Invoke(SECTION_CLICK_HERO, arg_26_1)
end

function var_0_0.Refresh(arg_27_0)
	arg_27_0:RefreshHeroTeam()
	arg_27_0:LoadHeroModels()
end

function var_0_0.RefreshHeroTeam(arg_28_0)
	arg_28_0:GetHeroTeam()
	arg_28_0:RefreshHeroInfoItem()
end

function var_0_0.RefreshHeroInfoItem(arg_29_0)
	for iter_29_0 = 1, 3 do
		arg_29_0.heroInfoItemList_[iter_29_0]:Refresh(iter_29_0)
	end
end

function var_0_0.ChangeHeroTeam(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1
	local var_30_1 = {}

	for iter_30_0, iter_30_1 in ipairs(arg_30_1) do
		local var_30_2 = table.keyof(arg_30_0.cacheHeroTeam_, iter_30_1)

		var_30_1[iter_30_0] = arg_30_0.heroTrialList_[var_30_2]
	end

	arg_30_0.sectionProxy_:ChangeHeroTeam(var_30_0, var_30_1)
end

function var_0_0.LoadHeroModels(arg_31_0)
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.cacheHeroTeam_) do
		if iter_31_1 == 0 then
			var_31_0[iter_31_0] = 0
		else
			var_31_0[iter_31_0] = arg_31_0:GetSkinCfg(iter_31_0).id
		end
	end

	SectionSelectHeroScene.GetInstance():LoadHeroModels(var_31_0, arg_31_0.sectionProxy_.heroInfoList)
end

function var_0_0.DestroyHeroModels(arg_32_0)
	SectionSelectHeroScene.GetInstance():DestroyModels()
end

function var_0_0.GetHeroTeam(arg_33_0)
	arg_33_0.cacheHeroTeam_, arg_33_0.lockStateList_, arg_33_0.lockList_, arg_33_0.heroTrialList_ = arg_33_0.sectionProxy_:GetHeroTeam()
end

function var_0_0.GetRaceEffect(arg_34_0)
	return arg_34_0.sectionProxy_:GetRaceEffect()
end

function var_0_0.CheckCanStartBattle(arg_35_0)
	local var_35_0 = true
	local var_35_1

	if SectionSelectHeroScene.GetInstance():IsLoadingModel() then
		var_35_0 = false
	end

	return var_35_0, var_35_1
end

function var_0_0.GetSkinCfg(arg_36_0, arg_36_1)
	return arg_36_0.sectionProxy_:CustomGetSkinCfg(arg_36_1, arg_36_0.cacheHeroTeam_[arg_36_1], arg_36_0.heroTrialList_[arg_36_1])
end

function var_0_0.GetHeroInfoItemClass(arg_37_0)
	return arg_37_0.sectionProxy_:GetHeroInfoItemClass()
end

function var_0_0.InitSubView(arg_38_0)
	if not arg_38_0.createdSubview_ then
		arg_38_0.createdSubview_ = true
		arg_38_0.heroInfoItemList_ = {}

		local var_38_0 = arg_38_0.heroInfoItemContentTrans_.childCount

		for iter_38_0 = 1, var_38_0 do
			local var_38_1 = arg_38_0.heroInfoItemContentTrans_:GetChild(iter_38_0 - 1).gameObject
			local var_38_2 = var_38_1.name
			local var_38_3 = string.split(var_38_2, "_")
			local var_38_4 = tonumber(var_38_3[#var_38_3])

			arg_38_0.heroInfoItemList_[var_38_4] = arg_38_0:GetHeroInfoItemClass().New(var_38_1, var_38_4)

			arg_38_0:InitHeroInfoItem(var_38_4)
		end
	end
end

function var_0_0.InitHeroInfoItem(arg_39_0, arg_39_1)
	arg_39_0.heroInfoItemList_[arg_39_1]:RegisterBeginDrag(handler(arg_39_0, arg_39_0.BeginDragHero))
	arg_39_0.heroInfoItemList_[arg_39_1]:RegisterDrag(handler(arg_39_0, arg_39_0.DragHero))
	arg_39_0.heroInfoItemList_[arg_39_1]:RegisterEndDrag(handler(arg_39_0, arg_39_0.EndDragHero))
	arg_39_0.heroInfoItemList_[arg_39_1]:RegistClick(handler(arg_39_0, arg_39_0.ClickHero))
end

function var_0_0.GetTargetDragDistance(arg_40_0, arg_40_1)
	local var_40_0

	if arg_40_1.x <= arg_40_0.firstHeroScreenPos_.x then
		var_40_0 = arg_40_0.f2SHeroScreenDistance_
	else
		var_40_0 = arg_40_0.f2THeroScreenDistance_
	end

	return var_40_0
end

function var_0_0.ResetUpdatePosFlag(arg_41_0)
	arg_41_0.isCameraTransitionEnd_ = false
	arg_41_0.isHeroModelLoaded_ = false
end

function var_0_0.OnCameraTransitionEnd(arg_42_0)
	arg_42_0.isCameraTransitionEnd_ = true

	if arg_42_0:CanUpdatePosition() then
		arg_42_0:UpdatePosition()
	end
end

function var_0_0.OnHeroModelLoaded(arg_43_0)
	arg_43_0.isHeroModelLoaded_ = true

	if arg_43_0:CanUpdatePosition() then
		arg_43_0:UpdatePosition()
	end
end

function var_0_0.OnChangeHeroTeam(arg_44_0)
	if arg_44_0:CanUpdatePosition() then
		arg_44_0:UpdatePosition()
	end
end

function var_0_0.CanUpdatePosition(arg_45_0)
	return arg_45_0.isCameraTransitionEnd_ and arg_45_0.isHeroModelLoaded_ and arg_45_0.needUpdatePosition_
end

function var_0_0.UpdatePosition(arg_46_0)
	arg_46_0:StopUpdatePosTimer()
	arg_46_0:StartUpdatePosTimer()
end

function var_0_0.StopUpdatePosTimer(arg_47_0)
	if arg_47_0.updatePosTimer_ then
		arg_47_0.updatePosTimer_:Stop()

		arg_47_0.updatePisTimer_ = nil
	end
end

function var_0_0.StartUpdatePosTimer(arg_48_0)
	arg_48_0.updatePosTimer_ = FrameTimer.New(handler(arg_48_0, arg_48_0.OnUpdatePosTimerEnd), 1, 1)

	arg_48_0.updatePosTimer_:Start()
end

function var_0_0.OnUpdatePosTimerEnd(arg_49_0)
	arg_49_0:StartUpdateHeorInfoItemPos()

	arg_49_0.needUpdatePosition_ = false
end

function var_0_0.StartUpdateHeorInfoItemPos(arg_50_0)
	for iter_50_0, iter_50_1 in ipairs(arg_50_0.heroInfoItemList_) do
		if not iter_50_1:UpdatePosition() then
			Debug.LogError("Culculate hero pos error, reculculate at next frame")
			arg_50_0:StartUpdatePosTimer()

			return
		end
	end

	arg_50_0:UpdateDragParams()
end

function var_0_0.UpdateDragParams(arg_51_0)
	for iter_51_0, iter_51_1 in ipairs(arg_51_0.heroInfoItemList_) do
		arg_51_0.dragPosition_[iter_51_0] = iter_51_1:GetOriginalDragPosition()
	end

	arg_51_0.firstHeroScreenPos_ = arg_51_0.heroInfoItemList_[1]:GetOriginalDragScreenPosition()
	arg_51_0.secondHeroScreenPos_ = arg_51_0.heroInfoItemList_[2]:GetOriginalDragScreenPosition()
	arg_51_0.thirdHeroScreenPos_ = arg_51_0.heroInfoItemList_[3]:GetOriginalDragScreenPosition()
	arg_51_0.f2SHeroScreenDistance_ = math.abs(arg_51_0.firstHeroScreenPos_.x - arg_51_0.secondHeroScreenPos_.x)
	arg_51_0.f2THeroScreenDistance_ = math.abs(arg_51_0.firstHeroScreenPos_.x - arg_51_0.thirdHeroScreenPos_.x)
	arg_51_0.prepareToDrag_ = true
end

function var_0_0.TryReloadSubView(arg_52_0)
	for iter_52_0, iter_52_1 in ipairs(arg_52_0.heroInfoItemList_) do
		if SectionSelectHeroTools.IsDiffViewClass(iter_52_1, arg_52_0.sectionProxy_:GetHeroInfoItemClass()) then
			iter_52_1 = SectionSelectHeroTools.ReloadView(iter_52_1, arg_52_0.sectionProxy_:GetHeroInfoItemClass())

			arg_52_0:InitHeroInfoItem(iter_52_0)
		end
	end

	arg_52_0:RebindController()
end

function var_0_0.RebindController(arg_53_0)
	for iter_53_0, iter_53_1 in ipairs(arg_53_0.heroInfoItemList_) do
		iter_53_1:RebindController()
	end
end

return var_0_0
