local var_0_0 = class("AshSectionView", ReduxView)
local var_0_1 = {
	Third = 3,
	Second = 2,
	First = 1
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_EkChuah/EkChuah_Com/EkChuah_StageUI"
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

	arg_4_0.lineList_ = {}
	arg_4_0.missionItem_ = {}
	arg_4_0.tabController = arg_4_0.mainControllerEx_:GetController("SelectStage")
	arg_4_0.tab = {
		[var_0_1.First] = {
			controller = arg_4_0.area1Controller_:GetController("default")
		},
		[var_0_1.Second] = {
			controller = arg_4_0.area2Controller_:GetController("default")
		},
		[var_0_1.Third] = {
			controller = arg_4_0.area3Controller_:GetController("default")
		}
	}

	arg_4_0:BuildContext()
end

function var_0_0.BuildContext(arg_5_0)
	arg_5_0.curSelectTab = -1
	arg_5_0.curUseLine = 0
	arg_5_0.curUseItem = 0
	arg_5_0.selectChild = nil
	arg_5_0.isSelect = false
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.area1Btn_, nil, function()
		if arg_6_0.isSelect then
			arg_6_0:TryToCloseSectionView()

			return
		end

		arg_6_0:SwitchTab(var_0_1.First)
	end)
	arg_6_0:AddBtnListener(arg_6_0.area2Btn_, nil, function()
		if arg_6_0.isSelect then
			arg_6_0:TryToCloseSectionView()

			return
		end

		if not AshSystemData:CheckIsOpenArea(var_0_1.Second) then
			ShowTips("ASH_AREA_UNLOCK_TIP_1")

			return
		end

		arg_6_0:SwitchTab(var_0_1.Second)
	end)
	arg_6_0:AddBtnListener(arg_6_0.area3Btn_, nil, function()
		if arg_6_0.isSelect then
			arg_6_0:TryToCloseSectionView()

			return
		end

		if not AshSystemData:CheckIsOpenArea(var_0_1.Third) then
			ShowTips("ASH_AREA_UNLOCK_TIP_2")

			return
		end

		arg_6_0:SwitchTab(var_0_1.Third)
	end)
	arg_6_0:AddBtnListener(arg_6_0.limitedBtn_, nil, function()
		if arg_6_0.isSelect then
			arg_6_0:TryToCloseSectionView()

			return
		end

		JumpTools.OpenPageByJump("/ashPointView")
	end)
	arg_6_0:AddBtnListener(arg_6_0.bgbtn_, nil, function()
		arg_6_0:TryToCloseSectionView()
	end)
	arg_6_0.eventTrigger1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_12_0, arg_12_1)
		arg_6_0:TryToCloseSectionView()
	end))
	arg_6_0.eventTrigger1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_13_0, arg_13_1)
		arg_6_0:TryToCloseSectionView()
	end))
	arg_6_0.eventTrigger1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_14_0, arg_14_1)
		arg_6_0:TryToCloseSectionView()
	end))
	arg_6_0.eventTrigger1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_15_0, arg_15_1)
		arg_6_0:TryToCloseSectionView()
	end))
	arg_6_0.eventTrigger1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_16_0, arg_16_1)
		arg_6_0:TryToCloseSectionView()
	end))
	arg_6_0.eventTrigger1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_17_0, arg_17_1)
		arg_6_0:TryToCloseSectionView()
	end))
	arg_6_0.eventTrigger1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_18_0, arg_18_1)
		arg_6_0:TryToCloseSectionView()
	end))
	arg_6_0.eventTrigger1_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_19_0, arg_19_1)
		arg_6_0:TryToCloseSectionView()
	end))
end

function var_0_0.TryToCloseSectionView(arg_20_0)
	if arg_20_0:IsOpenSectionInfo() then
		arg_20_0.isSelect = false
		arg_20_0.scrollView1_.enabled = true

		arg_20_0.selectChild:RenderSelect(false)
		SetActive(arg_20_0.areaGo_, true)

		arg_20_0.selectChild = nil

		JumpTools.Back()
	end
end

function var_0_0.OnEnter(arg_21_0)
	local var_21_0 = AshSystemData:GetMomoTalkList()

	for iter_21_0 = 1, 4 do
		if not var_21_0[iter_21_0] then
			break
		end

		local var_21_1 = var_21_0[iter_21_0].unlockRate
		local var_21_2 = AshSystemData:GetHomologyRate()

		if var_21_1 and var_21_1 <= var_21_2 then
			local var_21_3 = "CowbotPlotUnlock" .. iter_21_0

			if not (getData("ash", var_21_3) or AshSystemData:IsMomotalkDone(var_21_0[iter_21_0].correlation_id)) then
				saveData("ash", var_21_3, true)
				AshSystemAction:ReadMomotalk(var_21_0[iter_21_0].correlation_id)

				arg_21_0.waitForInit_ = 0

				JumpTools.OpenPageByJump("stageAshMomoTalk", {
					isSelectEnter = true,
					customID = var_21_0[iter_21_0].correlation_id
				})

				return
			end
		end
	end

	local var_21_4 = PlayerData:GetStoryList()
	local var_21_5 = getData("ash", "end_avg") or var_21_4[GameSetting.ash_end_story.value[1]] == true

	if AshSystemData:GetEndStoryIsUnlock() and not var_21_5 then
		local var_21_6 = arg_21_0:GetCustomSceneController()

		if var_21_6 then
			var_21_6:ReleaseHero("1083ui_dynamic")
		end

		saveData("ash", "end_avg", true)

		local var_21_7 = GameSetting.ash_end_story.value[1]

		manager.story:StartStoryById(var_21_7, function()
			arg_21_0:OnEnterFunc()
		end)
	else
		arg_21_0:OnEnterFunc()
	end
end

function var_0_0.OnEnterFunc(arg_23_0)
	arg_23_0.activityID_ = ActivityConst.ACTIVITY_ASH_MAIN

	local var_23_0 = AshSystemData:GetCacheInfo()

	AshSystemData:SetCacheInfo(nil)

	if arg_23_0.params_.isBack or arg_23_0.params_.fromBattle then
		if var_23_0 then
			arg_23_0:SwitchTab(var_23_0.tab, true)

			arg_23_0.content1_.transform.localPosition = Vector3.New(var_23_0.positionx, var_23_0.positiony, var_23_0.positionz)

			arg_23_0:SelectStage(arg_23_0.missionItem_[var_23_0.index])
		end

		for iter_23_0 = 2, 3 do
			arg_23_0["area" .. iter_23_0 .. "Anim_"].enabled = false
		end

		if arg_23_0.params_.fromBattle then
			arg_23_0.params_.fromBattle = nil

			arg_23_0:ResetSelect()
		end
	elseif arg_23_0.params_.lastOpenArea then
		arg_23_0:SwitchTab(arg_23_0.params_.lastOpenArea, true)

		arg_23_0.params_.lastOpenArea = nil

		arg_23_0:ResetSelect()
	else
		arg_23_0:SwitchTab(var_0_1.First, true)
		arg_23_0:ResetSelect()
	end

	arg_23_0:RefreshLimitTime()
	arg_23_0:RefreshTask()
	arg_23_0:bindRed()
	AshSystemData:UpdateTaskRedPoint()
end

function var_0_0.ResetSelect(arg_24_0)
	SetActive(arg_24_0.areaGo_, true)

	arg_24_0.isSelect = false
	arg_24_0.scrollView1_.enabled = true

	if arg_24_0.selectChild then
		arg_24_0.selectChild:RenderSelect(false)
	end

	arg_24_0.selectChild = nil
end

function var_0_0.bindRed(arg_25_0)
	manager.redPoint:bindUIandKey(arg_25_0.limitedBtn_.transform, RedPointConst.ASH_ACTIVITY_RESIDENT_TASK .. ActivityConst.ACTIVITY_ASH_MAIN)
	manager.redPoint:bindUIandKey(arg_25_0.area1Btn_.transform, RedPointConst.ASH_ACTIVITY_SECTION_AREA .. 1)
	manager.redPoint:bindUIandKey(arg_25_0.area2Btn_.transform, RedPointConst.ASH_ACTIVITY_SECTION_AREA .. 2)
	manager.redPoint:bindUIandKey(arg_25_0.area3Btn_.transform, RedPointConst.ASH_ACTIVITY_SECTION_AREA .. 3)
end

function var_0_0.unbindRed(arg_26_0)
	manager.redPoint:unbindUIandKey(arg_26_0.limitedBtn_.transform)
	manager.redPoint:unbindUIandKey(arg_26_0.area1Btn_.transform)
	manager.redPoint:unbindUIandKey(arg_26_0.area2Btn_.transform)
	manager.redPoint:unbindUIandKey(arg_26_0.area3Btn_.transform)
end

function var_0_0.SwitchTab(arg_27_0, arg_27_1, arg_27_2)
	if not AshSystemData:CheckIsOpenArea(arg_27_1) then
		return
	end

	if arg_27_2 or arg_27_1 ~= arg_27_0.curSelectTab then
		arg_27_0.curSelectTab = arg_27_1

		arg_27_0.tabController:SetSelectedState("state" .. arg_27_1)
		arg_27_0.scrollView1_:StopMovement()

		arg_27_0.content1_.transform.localPosition = Vector3.New(0, arg_27_0.content1_.transform.localPosition.y, arg_27_0.content1_.transform.localPosition.z)

		arg_27_0:RenderSection()
		arg_27_0:RenderTab()
		arg_27_0.mainAnimator_:Play("UI_complete_cx 1", 0, 0)

		for iter_27_0, iter_27_1 in ipairs(arg_27_0.missionItem_) do
			iter_27_1:RefreshAnim()
		end
	end
end

function var_0_0.RenderTab(arg_28_0)
	for iter_28_0 = 1, 3 do
		SetActive(arg_28_0["lock" .. iter_28_0 .. "Obj_"], false)
	end

	for iter_28_1 = 1, 3 do
		if AshSystemData:CheckIsOpenArea(iter_28_1) then
			if arg_28_0.curSelectTab == iter_28_1 then
				arg_28_0.tab[iter_28_1].controller:SetSelectedState("select")
			else
				arg_28_0.tab[iter_28_1].controller:SetSelectedState("default")

				if iter_28_1 ~= 1 then
					local var_28_0 = "CowbotSectionTabLock" .. iter_28_1

					if not getData("ash", var_28_0) then
						FrameTimer.New(function()
							arg_28_0.aniTimer_ = Timer.New(function()
								if arg_28_0["area" .. iter_28_1 .. "Anim_"]:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
									if arg_28_0.aniTimer_ then
										arg_28_0.aniTimer_:Stop()

										arg_28_0.aniTimer_ = nil
									end

									saveData("ash", var_28_0, true)
									manager.ui:UIEventEnabled(true)
								end
							end, 0.033, -1)

							manager.ui:UIEventEnabled(false)

							arg_28_0["area" .. iter_28_1 .. "Anim_"].enabled = true

							SetActive(arg_28_0["lock" .. iter_28_1 .. "Obj_"], true)
							arg_28_0["area" .. iter_28_1 .. "Anim_"]:Play("stageGroup_unlock", 0, 0)
							arg_28_0.aniTimer_:Start()
						end, 1, 1):Start()
					end
				end
			end
		else
			arg_28_0.tab[iter_28_1].controller:SetSelectedState("lock")
		end
	end
end

function var_0_0.RenderSection(arg_31_0)
	arg_31_0:ResetAll()

	local var_31_0 = AshTools:GetTypeLevels(arg_31_0.curSelectTab)
	local var_31_1 = true
	local var_31_2 = -350
	local var_31_3 = 50
	local var_31_4 = -400
	local var_31_5 = 480
	local var_31_6 = 150
	local var_31_7 = true

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		if var_31_1 then
			var_31_1 = false
		else
			var_31_4 = var_31_4 + var_31_5
		end

		var_31_4 = var_31_4 + var_31_6
	end

	arg_31_0:CalculateWidth(var_31_4)

	local var_31_8 = 200
	local var_31_9 = true
	local var_31_10 = true

	for iter_31_2, iter_31_3 in ipairs(var_31_0) do
		if var_31_10 then
			var_31_10 = false
		else
			arg_31_0:InstLine():RefreshUI(Vector3.New(var_31_8 + var_31_5 / 2 - 5, var_31_2, 0), var_31_9 and true or false)

			var_31_8 = var_31_8 + var_31_5
		end

		arg_31_0:InstItem():RenderItem({
			level = iter_31_3,
			index = iter_31_2
		}, Vector3.New(var_31_8 + var_31_6 / 2, var_31_2 + (var_31_9 and -1 or 1) * var_31_3, 0))

		var_31_8 = var_31_8 + var_31_6
		var_31_9 = not var_31_9
	end

	local var_31_11 = 1

	for iter_31_4, iter_31_5 in ipairs(arg_31_0.missionItem_) do
		if iter_31_5:GetIsUnlock() then
			var_31_11 = iter_31_4
		else
			break
		end
	end

	local var_31_12 = arg_31_0.missionItem_[var_31_11]

	if not var_31_12 then
		return
	end

	local var_31_13 = -var_31_12.transform_.localPosition.x + arg_31_0.scrollViewTrans_.rect.width / 2 - var_31_12.transform_.rect.width / 2

	arg_31_0.content1_.transform.localPosition = Vector3(var_31_13, 0, 0)
end

function var_0_0.CalculateWidth(arg_32_0, arg_32_1)
	arg_32_0.contentTrans_.transform.sizeDelta = Vector2(arg_32_1 + arg_32_0.viewport_.rect.width / 2, 700)
end

function var_0_0.SelectStage(arg_33_0, arg_33_1)
	if arg_33_0.selectChild then
		arg_33_0.selectChild:RenderSelect(false)
	end

	arg_33_0.selectChild = arg_33_1

	if arg_33_0.selectChild then
		SetActive(arg_33_0.areaGo_, false)
		arg_33_0.selectChild:RenderSelect(true)
		arg_33_0:OnSelectLevelItem(arg_33_1)
	end
end

function var_0_0.RefreshTask(arg_34_0)
	local var_34_0 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id)
	local var_34_1 = GameSetting.skuld_trust_max.value[1]
	local var_34_2 = "%d/%d"

	arg_34_0.processTxt_.text = string.format(var_34_2, var_34_0, var_34_1)
	arg_34_0.progressImg_.fillAmount = var_34_0 / var_34_1
end

function var_0_0.RefreshLimitTime(arg_35_0)
	local var_35_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_ASH_LIMITED_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ASH_LIMITED_TASK) then
		SetActive(arg_35_0.limitedBtn_.gameObject, true)

		arg_35_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_35_0.stopTime)
	else
		SetActive(arg_35_0.limitedBtn_.gameObject, false)
	end

	arg_35_0:LimitStopTimer()

	if arg_35_0.limittimer_ == nil then
		arg_35_0.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(arg_35_0.activityID_) then
				arg_35_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_35_0.stopTime)
			else
				if manager.time:GetServerTime() < var_35_0.startTime then
					arg_35_0.limitTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_35_0.startTime))
				elseif manager.time:GetServerTime() > var_35_0.stopTime then
					arg_35_0.limitTimeTxt_.text = GetTips("TIME_OVER")
				end

				SetActive(arg_35_0.limitedBtn_.gameObject, false)
			end
		end, 1, -1)
	end

	arg_35_0.limittimer_:Start()
end

function var_0_0.LimitStopTimer(arg_37_0)
	if arg_37_0.limittimer_ then
		arg_37_0.limittimer_:Stop()

		arg_37_0.limittimer_ = nil
	end
end

function var_0_0.IsOpenSectionInfo(arg_38_0)
	return arg_38_0:IsOpenRoute("ashSectionBaseView")
end

function var_0_0.ResetAll(arg_39_0)
	arg_39_0.curUseLine = 0
	arg_39_0.curUseItem = 0
end

function var_0_0.InstLine(arg_40_0)
	local var_40_0 = #arg_40_0.lineList_

	arg_40_0.curUseLine = arg_40_0.curUseLine + 1

	if var_40_0 < arg_40_0.curUseLine then
		table.insert(arg_40_0.lineList_, AshSectionLineItem.New(arg_40_0.content1_.transform))
	end

	return arg_40_0.lineList_[arg_40_0.curUseLine]
end

function var_0_0.InstItem(arg_41_0)
	local var_41_0 = #arg_41_0.missionItem_

	arg_41_0.curUseItem = arg_41_0.curUseItem + 1

	if var_41_0 < arg_41_0.curUseItem then
		table.insert(arg_41_0.missionItem_, AshSectionItem.New(arg_41_0.content1_.transform, arg_41_0, handler(arg_41_0, arg_41_0.ResetSelect)))
	end

	return arg_41_0.missionItem_[arg_41_0.curUseItem]
end

function var_0_0.UpdateBar(arg_42_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnSelectLevelItem(arg_43_0, arg_43_1)
	if arg_43_1 then
		arg_43_0.isSelect = true
		arg_43_0.scrollView1_.enabled = false

		local var_43_0 = -arg_43_1.transform_.localPosition.x + arg_43_0.scrollViewTrans_.rect.width / 2 - arg_43_1.transform_.rect.width / 2

		arg_43_0:RemoveTween()

		arg_43_0.tween_ = LeanTween.value(arg_43_0.content1_, arg_43_0.content1_.transform.localPosition.x, var_43_0, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
			arg_43_0.content1_.transform.localPosition = Vector3(arg_44_0, 0, 0)
		end))
	end
end

function var_0_0.RemoveTween(arg_45_0)
	if arg_45_0.tween_ then
		arg_45_0.tween_:setOnUpdate(nil)
		LeanTween.cancel(arg_45_0.content1_)

		arg_45_0.tween_ = nil
	end
end

function var_0_0.OnTop(arg_46_0)
	if arg_46_0.waitForInit_ then
		arg_46_0.waitForInit_ = arg_46_0.waitForInit_ + 1

		if arg_46_0.waitForInit_ >= 2 then
			arg_46_0:OnEnterFunc()

			arg_46_0.waitForInit_ = nil
		end
	end

	arg_46_0:UpdateBar()
end

function var_0_0.OnBehind(arg_47_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_48_0)
	if arg_48_0.aniTimer_ then
		manager.ui:UIEventEnabled(true)
		arg_48_0.aniTimer_:Stop()

		arg_48_0.aniTimer_ = nil
	end

	arg_48_0:unbindRed()
	arg_48_0:RemoveTween()
	arg_48_0:LimitStopTimer()

	if arg_48_0.selectChild then
		local var_48_0 = {
			tab = arg_48_0.curSelectTab,
			index = arg_48_0.selectChild:GetIndex(),
			positionx = arg_48_0.content1_.transform.localPosition.x,
			positiony = arg_48_0.content1_.transform.localPosition.y,
			positionz = arg_48_0.content1_.transform.localPosition.z
		}

		AshSystemData:SetCacheInfo(var_48_0)
	end
end

function var_0_0.Dispose(arg_49_0)
	if arg_49_0.aniTimer_ then
		manager.ui:UIEventEnabled(true)
		arg_49_0.aniTimer_:Stop()

		arg_49_0.aniTimer_ = nil
	end

	arg_49_0:RemoveTween()
	arg_49_0:LimitStopTimer()
	arg_49_0.super.Dispose(arg_49_0)
end

return var_0_0
