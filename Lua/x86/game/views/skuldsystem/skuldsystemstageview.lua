local var_0_0 = class("SkuldSystemStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Skuld/Activity_Skuld_StageUI"
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

	arg_4_0.curSectionIndex_ = 1
	arg_4_0.curLevelID_ = 0
	arg_4_0.selectLevelItemHandler_ = handler(arg_4_0, arg_4_0.OnSelectLevelItem)
	arg_4_0.btnController1_ = arg_4_0.btnCtrEx1_:GetController("select")
	arg_4_0.btnController2_ = arg_4_0.btnCtrEx2_:GetController("select")
	arg_4_0.btnController3_ = arg_4_0.btnCtrEx3_:GetController("select")
	arg_4_0.btnLockController1_ = arg_4_0.btnCtrEx1_:GetController("lock")
	arg_4_0.btnLockController2_ = arg_4_0.btnCtrEx2_:GetController("lock")
	arg_4_0.btnLockController3_ = arg_4_0.btnCtrEx3_:GetController("lock")
	arg_4_0.stageController_ = arg_4_0.stageCtrEx_:GetController("stage")

	for iter_4_0 = 1, 36 do
		arg_4_0["levelItem" .. iter_4_0 .. "_"] = SkuldSystemStageItem.New(arg_4_0["levelGo" .. iter_4_0 .. "_"], iter_4_0, SkuldStageCfg.all[iter_4_0], arg_4_0.selectLevelItemHandler_)
	end

	arg_4_0.trustItem_ = SkuldSystemTrustItem.New(arg_4_0.trustGo_)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.archiveCollectBtn_, nil, function()
		JumpTools.OpenPageByJump("stageArchiveCollect", {
			chapterID = arg_5_0.chapterID_
		})
	end)

	for iter_5_0 = 1, 3 do
		arg_5_0:AddBtnListener(arg_5_0["sectionBtn" .. iter_5_0 .. "_"], nil, function()
			local var_7_0 = false

			for iter_7_0, iter_7_1 in pairs(SkuldStageCfg.get_id_list_by_section[iter_5_0]) do
				if SkuldSystemData:GetLevelIDIsOpen(iter_7_1) then
					var_7_0 = true

					break
				end
			end

			if var_7_0 then
				arg_5_0.curSectionIndex_ = iter_5_0

				arg_5_0:TryToCloseSectionView()
				arg_5_0:RefreshUI()
				arg_5_0:RemoveTween()

				arg_5_0["scrollView" .. arg_5_0.curSectionIndex_ .. "_"].horizontal = true

				if arg_5_0.curScrollContent_.transform.localPosition.x > 0 then
					arg_5_0.curScrollContent_.transform.localPosition = Vector3.New(0, arg_5_0.curScrollContent_.transform.localPosition.y, arg_5_0.curScrollContent_.transform.localPosition.z)
				end
			elseif iter_5_0 == 2 then
				ShowTips("SKULD_SECTION_UNLOCK1")
			elseif iter_5_0 == 3 then
				ShowTips("SKULD_SECTION_UNLOCK2")
			end
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.bgbtn_, nil, function()
		arg_5_0:TryToCloseSectionView()
	end)
	arg_5_0.scrollEvent1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		arg_5_0:TryToCloseSectionView()
	end))
	arg_5_0.scrollEvent1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_10_0, arg_10_1)
		arg_5_0:TryToCloseSectionView()
	end))
	arg_5_0.scrollEvent2_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_11_0, arg_11_1)
		arg_5_0:TryToCloseSectionView()
	end))
	arg_5_0.scrollEvent2_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_12_0, arg_12_1)
		arg_5_0:TryToCloseSectionView()
	end))
	arg_5_0.scrollEvent3_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_13_0, arg_13_1)
		arg_5_0:TryToCloseSectionView()
	end))
	arg_5_0.scrollEvent3_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_14_0, arg_14_1)
		arg_5_0:TryToCloseSectionView()
	end))
	arg_5_0.scrollEvent4_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_15_0, arg_15_1)
		arg_5_0:TryToCloseSectionView()
	end))
	arg_5_0.scrollEvent4_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_16_0, arg_16_1)
		arg_5_0:TryToCloseSectionView()
	end))
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0.chapterID_ = 6010128
	arg_17_0.lastAudioID_ = 0

	local var_17_0 = SkuldSystemData:GetCacheStageViewInfo(arg_17_0.params_.isFinal)

	if var_17_0 ~= nil then
		arg_17_0.curSectionIndex_ = var_17_0.index
	else
		arg_17_0.curSectionIndex_ = 1
	end

	if arg_17_0.params_.isFinal then
		for iter_17_0 = 31, 36 do
			arg_17_0["levelItem" .. iter_17_0 .. "_"]:RefreshUI()
		end

		arg_17_0.stageController_:SetSelectedState("statespecial")

		arg_17_0.scrollView4_.horizontal = true
		arg_17_0.curScrollContent_ = arg_17_0.scrollContent4_
		arg_17_0.curSectionIndex_ = 4
	else
		arg_17_0["scrollView" .. arg_17_0.curSectionIndex_ .. "_"].horizontal = true

		arg_17_0.trustItem_:RefreshUI()
		arg_17_0.trustItem_:OnEnter()
		arg_17_0.trustItem_:SetCallBack(function()
			arg_17_0:TryToCloseSectionView()
		end)

		arg_17_0.curScrollContent_ = arg_17_0["scrollContent" .. arg_17_0.curSectionIndex_ .. "_"]

		arg_17_0:RefreshUI()
	end

	if var_17_0 ~= nil then
		if var_17_0.positionx > 0 then
			var_17_0.positionx = 0
		end

		arg_17_0.curScrollContent_.transform.localPosition = Vector3.New(var_17_0.positionx, var_17_0.positiony, var_17_0.positionz)
	end

	arg_17_0:RefreshAudio()
	arg_17_0:BindRedPoint()
end

function var_0_0.BindRedPoint(arg_19_0)
	manager.redPoint:bindUIandKey(arg_19_0.archiveCollectBtn_.transform, RedPointConst.SKULD_SYSTEM_ARCHIVE_ALL .. "_6010128")
end

function var_0_0.UnBindRedPoint(arg_20_0)
	manager.redPoint:unbindUIandKey(arg_20_0.archiveCollectBtn_.transform, RedPointConst.SKULD_SYSTEM_ARCHIVE_ALL .. "_6010128")
end

function var_0_0.OnEnterOver(arg_21_0)
	arg_21_0:PlayAni()
end

function var_0_0.PlayAni(arg_22_0)
	if arg_22_0.animator_ then
		arg_22_0.animator_:Play("Activity_Skuld_StageUI", -1, 0)
		arg_22_0.animator_:Update(0)
	end

	local var_22_0 = SkuldSystemData:GetLevelIDIsClear(1026)
	local var_22_1 = SkuldSystemData:GetLevelIDIsClear(1027)
	local var_22_2 = getData("skuldStageView", "hasViewAni")

	if arg_22_0.timer_ then
		arg_22_0.timer_:Stop()

		arg_22_0.timer_ = nil
	end

	arg_22_0.aniCallback_ = nil
	arg_22_0.timer_ = Timer.New(function()
		if arg_22_0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			if arg_22_0.timer_ ~= nil then
				arg_22_0.timer_:Stop()
			end

			if arg_22_0.aniCallback_ then
				arg_22_0.aniCallback_()
			end
		end
	end, 0.033, -1)

	if var_22_0 and not var_22_1 and not var_22_2 then
		arg_22_0.curSectionIndex_ = 3

		arg_22_0:RefreshUI()

		arg_22_0.curScrollContent_ = arg_22_0.scrollContent3_

		function arg_22_0.aniCallback_()
			arg_22_0.animator_:Play("bg", -1, 0)
			saveData("skuldStageView", "hasViewAni", true)

			function arg_22_0.aniCallback_()
				SetActive(arg_22_0.skuldGo_, false)
				arg_22_0.animator_:Play("normal", -1, 0)
				SetActive(arg_22_0.musicGo_, true)
				arg_22_0:UpdateBar()
			end

			arg_22_0.timer_:Start()
		end

		arg_22_0.timer_:Start()
		SetActive(arg_22_0.musicGo_, false)
		manager.windowBar:HideBar()
		SetActive(arg_22_0.skuldGo_, true)
		SetActive(arg_22_0.brokenBgGo_, true)
	elseif var_22_0 and not var_22_1 then
		SetActive(arg_22_0.skuldGo_, false)
		SetActive(arg_22_0.brokenBgGo_, true)

		function arg_22_0.aniCallback_()
			arg_22_0.animator_:Play("normal", -1, 0)
		end

		arg_22_0.timer_:Start()
	else
		SetActive(arg_22_0.skuldGo_, true)
		SetActive(arg_22_0.brokenBgGo_, false)

		function arg_22_0.aniCallback_()
			arg_22_0.animator_:Play("normal", -1, 0)
		end

		arg_22_0.timer_:Start()
	end
end

function var_0_0.UpdateBar(arg_28_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_28_0:IsOpenSectionView() then
			arg_28_0:TryToCloseSectionView()
		else
			JumpTools.Back()
		end
	end)
end

function var_0_0.OnTop(arg_30_0)
	arg_30_0:UpdateBar()

	if arg_30_0:IsOpenSectionView() then
		-- block empty
	else
		arg_30_0.curLevelID_ = 0
	end

	for iter_30_0 = 1, 36 do
		arg_30_0["levelItem" .. iter_30_0 .. "_"]:RefreshSelect(arg_30_0.curLevelID_)
	end
end

function var_0_0.RefreshUI(arg_31_0)
	for iter_31_0 = 1, 3 do
		if iter_31_0 == arg_31_0.curSectionIndex_ then
			arg_31_0["btnController" .. iter_31_0 .. "_"]:SetSelectedState("true")
		else
			arg_31_0["btnController" .. iter_31_0 .. "_"]:SetSelectedState("false")
		end

		local var_31_0 = false

		for iter_31_1, iter_31_2 in pairs(SkuldStageCfg.get_id_list_by_section[iter_31_0]) do
			if SkuldSystemData:GetLevelIDIsOpen(iter_31_2) then
				var_31_0 = true

				break
			end
		end

		if var_31_0 then
			arg_31_0["btnLockController" .. iter_31_0 .. "_"]:SetSelectedState("false")

			if SkuldSystemData:GetClientKey("IsPlaySectionUnlock" .. iter_31_0) then
				SetActive(arg_31_0["sectionAniGo" .. iter_31_0 .. "_"], false)
			else
				SetActive(arg_31_0["sectionAniGo" .. iter_31_0 .. "_"], true)
				arg_31_0["sectionAni" .. iter_31_0 .. "_"]:Play("stage_unlock")
				SkuldSystemAction.SendMark("IsPlaySectionUnlock" .. iter_31_0)
			end
		else
			SetActive(arg_31_0["sectionAniGo" .. iter_31_0 .. "_"], false)
			arg_31_0["btnLockController" .. iter_31_0 .. "_"]:SetSelectedState("true")
		end
	end

	arg_31_0.stageController_:SetSelectedState("stage0" .. arg_31_0.curSectionIndex_)

	for iter_31_3 = 1, 30 do
		arg_31_0["levelItem" .. iter_31_3 .. "_"]:RefreshUI()
	end
end

function var_0_0.OnExit(arg_32_0)
	arg_32_0:UnBindRedPoint()
	manager.windowBar:HideBar()
	arg_32_0.trustItem_:OnExit()
	arg_32_0:RemoveTween()

	local var_32_0 = {
		index = arg_32_0.curSectionIndex_,
		positionx = arg_32_0.curScrollContent_.transform.localPosition.x,
		positiony = arg_32_0.curScrollContent_.transform.localPosition.y,
		positionz = arg_32_0.curScrollContent_.transform.localPosition.z
	}

	if arg_32_0.timer_ then
		arg_32_0.timer_:Stop()

		arg_32_0.timer_ = nil
	end

	SkuldSystemData:CacheStageViewInfo(var_32_0, arg_32_0.params_.isFinal)
end

function var_0_0.OnSelectLevelItem(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_0.curLevelID_ == arg_33_2 then
		return
	end

	arg_33_0.curLevelID_ = arg_33_2

	for iter_33_0 = 1, 36 do
		arg_33_0["levelItem" .. iter_33_0 .. "_"]:RefreshSelect(arg_33_0.curLevelID_)
	end

	local var_33_0 = arg_33_0["levelItem" .. arg_33_1 .. "_"]

	if var_33_0 then
		local var_33_1 = -var_33_0.transform_.localPosition.x + arg_33_0.scrollViewTrans_.rect.width / 2 - var_33_0.transform_.rect.width / 2

		arg_33_0:RemoveTween()

		if arg_33_0.params_.isFinal then
			arg_33_0.scrollView4_.horizontal = false
			arg_33_0.curScrollContent_ = arg_33_0.scrollContent4_
		else
			arg_33_0["scrollView" .. arg_33_0.curSectionIndex_ .. "_"].horizontal = false
			arg_33_0.curScrollContent_ = arg_33_0["scrollContent" .. arg_33_0.curSectionIndex_ .. "_"]
		end

		arg_33_0.tween_ = LeanTween.value(arg_33_0.curScrollContent_, arg_33_0.curScrollContent_.transform.localPosition.x, var_33_1, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
			arg_33_0.curScrollContent_.transform.localPosition = Vector3(arg_34_0, 0, 0)
		end))
	elseif arg_33_0.params_.isFinal then
		arg_33_0.scrollView4_.horizontal = true
	else
		arg_33_0["scrollView" .. arg_33_0.curSectionIndex_ .. "_"].horizontal = true
	end
end

function var_0_0.RemoveTween(arg_35_0)
	if arg_35_0.tween_ then
		arg_35_0.tween_:setOnUpdate(nil)
		LeanTween.cancel(arg_35_0.curScrollContent_)

		arg_35_0.tween_ = nil
	end
end

function var_0_0.IsOpenSectionView(arg_36_0)
	return arg_36_0:IsOpenRoute("skuldSystemStageSectionView")
end

function var_0_0.TryToCloseSectionView(arg_37_0)
	if arg_37_0:IsOpenSectionView() then
		arg_37_0.curLevelID_ = 0

		for iter_37_0 = 1, 36 do
			arg_37_0["levelItem" .. iter_37_0 .. "_"]:RefreshSelect(arg_37_0.curLevelID_)
		end

		if arg_37_0.params_.isFinal then
			arg_37_0.scrollView4_.horizontal = true
		else
			arg_37_0["scrollView" .. arg_37_0.curSectionIndex_ .. "_"].horizontal = true
		end

		JumpTools.Back()
	end
end

function var_0_0.RefreshAudio(arg_38_0)
	local var_38_0 = ChapterTools.GetSkuildAudio()

	if arg_38_0.lastAudioID_ == var_38_0 then
		return
	end

	local var_38_1 = ChapterAudioCfg[var_38_0]

	manager.audio:PlayUIAudio(var_38_1.bgm_id)

	arg_38_0.bgmNameText_.text = var_38_1.name
	arg_38_0.lastAudioID_ = var_38_0
end

function var_0_0.Dispose(arg_39_0)
	if arg_39_0.timer_ then
		arg_39_0.timer_:Stop()

		arg_39_0.timer_ = nil
	end

	for iter_39_0 = 1, 36 do
		arg_39_0["levelItem" .. iter_39_0 .. "_"]:Dispose()
	end

	arg_39_0.trustItem_:Dispose()
	arg_39_0.super.Dispose(arg_39_0)
end

return var_0_0
