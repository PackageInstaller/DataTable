local var_0_0 = class("ActivityPushBoxMaterialView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/JapanRegionUI_2_10MaterialCollectionUI"
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

	arg_4_0.materialPreviewTbl_ = {
		"CAKE_INDEX_MATERIAL_1",
		"CAKE_INDEX_MATERIAL_2",
		"CAKE_INDEX_MATERIAL_3",
		"CAKE_INDEX_MATERIAL_4",
		"CAKE_INDEX_MATERIAL_5",
		"CAKE_INDEX_MATERIAL_6",
		"CAKE_INDEX_MATERIAL_7"
	}

	local var_4_0 = 0
	local var_4_1 = ActivityCelebrationOrderCfg.get_id_list_by_main_activity[arg_4_0.params_.activityID]

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		local var_4_2 = ActivityCelebrationOrderCfg[iter_4_1].index

		var_4_0 = var_4_2 < var_4_0 and var_4_0 or var_4_2
	end

	arg_4_0.eventItem_ = {}

	for iter_4_2 = 1, var_4_0 do
		if arg_4_0["eventItemGo_" .. iter_4_2] == nil then
			error("场景布置数量不足")
		end

		arg_4_0.eventItem_[iter_4_2] = ActivityPushBoxEventItem.New(arg_4_0["eventItemGo_" .. iter_4_2])

		arg_4_0.eventItem_[iter_4_2]:RegistClickFunc(function(arg_5_0, arg_5_1)
			arg_4_0:ClickEvent(arg_5_0, arg_5_1)
		end)
	end

	arg_4_0.materialGo_ = {}
	arg_4_0.materialTxt_ = {}
	arg_4_0.materialIcon_ = {}

	for iter_4_3 = 1, 3 do
		arg_4_0.materialGo_[iter_4_3] = arg_4_0["materialGo_" .. iter_4_3]
		arg_4_0.materialTxt_[iter_4_3] = arg_4_0["materialTxt_" .. iter_4_3]
		arg_4_0.materialIcon_[iter_4_3] = arg_4_0["materialIcon_" .. iter_4_3]
	end

	arg_4_0.idleCon_ = ControllerUtil.GetController(arg_4_0.transform_, "idle")
	arg_4_0.refreshCon_ = ControllerUtil.GetController(arg_4_0.transform_, "refresh")
	arg_4_0.materialCon_ = ControllerUtil.GetController(arg_4_0.transform_, "material")
	arg_4_0.sectionView_ = ActivityPushBoxSectionView.New(arg_4_0.scetionGo_)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:SetSelectItem(0)
		arg_6_0.sectionView_:Show(false)
		SetActive(arg_6_0.bgBtn_.gameObject, false)
	end)
	arg_6_0:AddBtnListener(arg_6_0.refreshBtn_, nil, function()
		local var_8_0 = ActivityPushBoxData:GetRefreshTime(arg_6_0.activityID_)

		if var_8_0 > 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ORDER_REFRESH_TIPS1") .. "\n" .. GetTips("ORDER_REFRESH_TIPS2") .. var_8_0,
				OkCallback = function()
					ActivityPushBoxAction.ResetEvent(arg_6_0.activityID_)
				end
			})
		end
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.activityID_ = arg_10_0.params_.activityID

	arg_10_0:RefreshData()
	arg_10_0:RefreshTime()
	arg_10_0:RefreshMaterial()
	arg_10_0:RefreshEventMap()
	arg_10_0.sectionView_:Show(false)
	SetActive(arg_10_0.bgBtn_.gameObject, false)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_BOX_FATIGUE .. "_" .. arg_10_0.activityID_, 0)
	arg_10_0:RegistEventListener(MATERIAL_MODIFY, handler(arg_10_0, arg_10_0.RefreshMaterial))
end

function var_0_0.RefreshData(arg_11_0)
	arg_11_0.activityData_ = ActivityData:GetActivityData(arg_11_0.activityID_)
	arg_11_0.startTime_ = arg_11_0.activityData_.startTime
	arg_11_0.stopTime_ = arg_11_0.activityData_.stopTime
end

function var_0_0.RefreshTime(arg_12_0)
	arg_12_0:StopTimer()

	local var_12_0 = manager.time:GetServerTime()

	if var_12_0 < arg_12_0.startTime_ then
		arg_12_0.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		arg_12_0.timer_ = Timer.New(function()
			if arg_12_0.startTime_ <= manager.time:GetServerTime() then
				arg_12_0:StopTimer()
				arg_12_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_12_0.timer_:Start()
	elseif var_12_0 < arg_12_0.stopTime_ then
		arg_12_0.timeLable_.text = manager.time:GetLostTimeStr2(arg_12_0.stopTime_)
		arg_12_0.timer_ = Timer.New(function()
			if arg_12_0.stopTime_ <= manager.time:GetServerTime() then
				arg_12_0:StopTimer()
				arg_12_0:RefreshTime()

				return
			end

			arg_12_0.timeLable_.text = manager.time:GetLostTimeStr2(arg_12_0.stopTime_)
		end, 1, -1)

		arg_12_0.timer_:Start()
	else
		arg_12_0.timeLable_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.StopTimer(arg_15_0)
	if arg_15_0.timer_ then
		arg_15_0.timer_:Stop()

		arg_15_0.timer_ = nil
	end
end

function var_0_0.RefreshMaterial(arg_16_0)
	local var_16_0 = ActivityPushBoxData:GetCurIndex(arg_16_0.activityID_)
	local var_16_1 = ActivityCelebrationCakeCfg.get_id_list_by_activity_id[arg_16_0.activityID_]
	local var_16_2

	if var_16_0 >= #var_16_1 then
		arg_16_0.materialListText_.text = GetTips(arg_16_0.materialPreviewTbl_[var_16_0])
		var_16_2 = ActivityCelebrationCakeCfg[var_16_1[var_16_0]]
	else
		arg_16_0.materialListText_.text = GetTips(arg_16_0.materialPreviewTbl_[var_16_0 + 1])
		var_16_2 = ActivityCelebrationCakeCfg[var_16_1[var_16_0 + 1]]
	end

	local var_16_3 = var_16_2.cost_list
	local var_16_4 = "<color=#FF0000>%d</color>"

	for iter_16_0, iter_16_1 in ipairs(var_16_3) do
		local var_16_5 = iter_16_1[1]
		local var_16_6 = iter_16_1[2]
		local var_16_7 = ItemTools.getItemNum(var_16_5)

		arg_16_0.materialIcon_[iter_16_0].sprite = ItemTools.getItemSprite(var_16_5)

		if var_16_6 <= var_16_7 then
			arg_16_0.materialTxt_[iter_16_0].text = var_16_7 .. "/" .. var_16_6
		else
			arg_16_0.materialTxt_[iter_16_0].text = string.format(var_16_4, var_16_7) .. "/" .. var_16_6
		end
	end

	arg_16_0.materialCon_:SetSelectedState(#var_16_3)
end

function var_0_0.RefreshEventMap(arg_17_0)
	local var_17_0 = ActivityPushBoxData:GetPushBoxEmptyList(arg_17_0.activityID_)
	local var_17_1 = ActivityPushBoxData:GetMapEventList(arg_17_0.activityID_)

	table.sort(var_17_1, function(arg_18_0, arg_18_1)
		local var_18_0 = ActivityCelebrationOrderCfg[arg_18_0]
		local var_18_1 = ActivityCelebrationOrderCfg[arg_18_1]

		return var_18_0.index < var_18_1.index
	end)

	local var_17_2 = 1

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.eventItem_) do
		if not var_17_1[var_17_2] then
			break
		end

		local var_17_3 = var_17_1[var_17_2]

		if iter_17_0 == ActivityCelebrationOrderCfg[var_17_3].index then
			iter_17_1:Show(true)
			iter_17_1:SetData(var_17_3)

			var_17_2 = var_17_2 + 1
		else
			iter_17_1:Show(false)
		end
	end

	local var_17_4 = var_17_1[#var_17_1]

	for iter_17_2 = ActivityCelebrationOrderCfg[var_17_4].index + 1, #arg_17_0.eventItem_ do
		arg_17_0.eventItem_[iter_17_2]:Show(false)
	end

	for iter_17_3, iter_17_4 in ipairs(var_17_0) do
		local var_17_5 = ActivityCelebrationOrderCfg[iter_17_4].index

		arg_17_0.eventItem_[var_17_5]:Show(true)
		arg_17_0.eventItem_[var_17_5]:RefreshCountDown(iter_17_4)
	end

	local var_17_6 = ActivityPushBoxData:GetRefreshTime(arg_17_0.activityID_)

	arg_17_0.refreshText_.text = GetTips("ACTIVITY_PUSH_BOX_REFRESH") .. var_17_6

	arg_17_0.refreshCon_:SetSelectedState(var_17_6 > 0 and "true" or "false")
	arg_17_0:SetSelectItem(0)
end

function var_0_0.SetSelectItem(arg_19_0, arg_19_1)
	arg_19_0.idleCon_:SetSelectedState(arg_19_1 == 0 and "true" or "false")

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.eventItem_) do
		iter_19_1:SetSelect(arg_19_1)
	end
end

function var_0_0.ClickEvent(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0:SetSelectItem(arg_20_1)
	arg_20_0.sectionView_:Show(true)
	arg_20_0.sectionView_:SetData(arg_20_1, arg_20_2)
	SetActive(arg_20_0.bgBtn_.gameObject, true)
end

function var_0_0.OnPushBoxMapRefresh(arg_21_0)
	arg_21_0.ani_:Play("JapanRegionUI_2_10MaterialCollectionUI", -1, 0)
	arg_21_0:RefreshEventMap()
	arg_21_0.sectionView_:Show(false)
end

function var_0_0.OnTop(arg_22_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		ACTIVITY_COIN
	})
	manager.windowBar:SetActivityId(ACTIVITY_COIN, arg_22_0.activityID_)
end

function var_0_0.OnExit(arg_23_0)
	arg_23_0:StopTimer()
	arg_23_0.sectionView_:OnExit()
	manager.windowBar:HideBar()

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.eventItem_) do
		iter_23_1:OnExit()
	end

	arg_23_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0:RemoveAllListeners()
	arg_24_0.sectionView_:Dispose()

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.eventItem_) do
		iter_24_1:Dispose()
	end

	arg_24_0.super.Dispose(arg_24_0)
end

return var_0_0
