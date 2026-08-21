local var_0_0 = class("HellaSlayerView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/HellaUI/Slayer/HellaSlayerUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, HellaSlayerItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_talentBtn, nil, function()
		local var_6_0 = ActivityTools.GetActivityTheme(arg_5_0.slayer_activity_id)
		local var_6_1 = TalentTreeTools.GetActivityIdByTheme(var_6_0)

		if var_6_1 then
			JumpTools.OpenPageByJump("/talentTree", {
				activityId = var_6_1
			})
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("hellaSlayerReward", {
			slayer_activity_id = arg_5_0.slayer_activity_id
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_bgBtn, nil, function()
		if arg_5_0:IsOpenSectionInfo() then
			arg_5_0:SetSelectIndex(0)
			JumpTools.Back()
		end
	end)
	arg_5_0.m_scrollEvent:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		if arg_5_0:IsOpenSectionInfo() then
			arg_5_0:SetSelectIndex(0)
			JumpTools.Back()
		end
	end))
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_HELLA_SLAYER_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function()
		if arg_10_0:IsOpenSectionInfo() then
			arg_10_0:SetSelectIndex(0)
		end

		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.slayer_activity_id = arg_12_0.params_.slayer_activity_id or 0

	local var_12_0 = ActivityCfg[arg_12_0.slayer_activity_id]

	arg_12_0.regionList = var_12_0 and var_12_0.sub_activity_list or {}
	arg_12_0.selectIndex = SlayerData:GetSelectIndex(arg_12_0.slayer_activity_id) or 0

	arg_12_0.list:StartScroll(#arg_12_0.regionList, arg_12_0.selectIndex > 0 and arg_12_0.selectIndex - 1 or 0)
	arg_12_0:SetSelectIndex(0)
	arg_12_0:RefreshSelecteRedPoint()
	manager.redPoint:bindUIandKey(arg_12_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, arg_12_0.slayer_activity_id))
	arg_12_0:RefrenTime()

	arg_12_0.timer = Timer.New(function()
		arg_12_0:OnTimerEvent()
	end, 1, -1)

	arg_12_0.timer:Start()
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:RemoveTween()
	manager.redPoint:unbindUIandKey(arg_14_0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, arg_14_0.slayer_activity_id))
	manager.windowBar:HideBar()

	if arg_14_0.timer then
		arg_14_0.timer:Stop()

		arg_14_0.timer = nil
	end
end

function var_0_0.OnTimerEvent(arg_15_0)
	arg_15_0:RefrenTime()

	local var_15_0 = arg_15_0.list:GetItemList()

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		iter_15_1:RefreshTime()
	end
end

function var_0_0.RefrenTime(arg_16_0)
	local var_16_0 = ActivityData:GetActivityData(arg_16_0.slayer_activity_id)

	if var_16_0 and var_16_0:IsActivitying() then
		arg_16_0.m_timeLab.text = manager.time:GetLostTimeStr(var_16_0.stopTime)
	else
		arg_16_0.m_timeLab.text = GetTips("TIME_OVER")
	end
end

function var_0_0.IndexItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.regionList[arg_17_1]
	local var_17_1 = false

	if arg_17_1 == #arg_17_0.regionList then
		var_17_1 = true
	end

	arg_17_2:SetData(arg_17_1, arg_17_0.slayer_activity_id, var_17_0, var_17_1)
	arg_17_2:SetSelectedIndex(arg_17_0.selectIndex)
	arg_17_2:RegistCallBack(handler(arg_17_0, arg_17_0.SetSelectIndex))
end

function var_0_0.SetSelectIndex(arg_18_0, arg_18_1)
	if arg_18_1 == arg_18_0.selectIndex then
		return
	end

	if arg_18_1 ~= 0 then
		local var_18_0 = arg_18_0.regionList[arg_18_1]

		if not ActivityData:GetActivityIsOpen(var_18_0) then
			local var_18_1 = ActivityData:GetActivityData(var_18_0)
			local var_18_2 = manager.time:GetServerTime()

			if var_18_1 and var_18_2 < var_18_1.startTime then
				ShowTips(string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(var_18_1.startTime)))
			else
				ShowTips("TIME_OVER")
			end

			return
		end

		SlayerData:SetSelectIndex(arg_18_0.slayer_activity_id, arg_18_1)
	end

	arg_18_0.selectIndex = arg_18_1

	local var_18_3 = arg_18_0.list:GetItemList()
	local var_18_4 = var_18_3[arg_18_0.selectIndex]

	if var_18_4 then
		local var_18_5 = -var_18_4.transform_.localPosition.x + arg_18_0.m_scrollViewTrans.rect.width / 2 - var_18_4.transform_.rect.width / 2

		arg_18_0.m_scrollCom.horizontal = false

		arg_18_0:RemoveTween()

		arg_18_0.tween_ = LeanTween.value(arg_18_0.m_scrollContent, arg_18_0.m_scrollContent.transform.localPosition.x, var_18_5, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
			arg_18_0.m_scrollContent.transform.localPosition = Vector3(arg_19_0, 0, 0)
		end))
	else
		arg_18_0.m_scrollCom.horizontal = true
	end

	for iter_18_0, iter_18_1 in pairs(var_18_3) do
		iter_18_1:SetSelectedIndex(arg_18_0.selectIndex)
	end

	if arg_18_0.selectIndex ~= 0 and arg_18_0.regionList[arg_18_0.selectIndex] then
		local var_18_6 = arg_18_0.regionList[arg_18_0.selectIndex]
		local var_18_7 = ActivitySlayerCfg[var_18_6].stage_id

		arg_18_0:Go("slayerSctionInfo", {
			sectionType = BattleConst.STAGE_TYPE_NEW.SLAYER,
			section = var_18_7,
			region_activity_id = var_18_6,
			slayer_activity_id = arg_18_0.slayer_activity_id
		})
	end
end

function var_0_0.RemoveTween(arg_20_0)
	if arg_20_0.tween_ then
		arg_20_0.tween_:setOnUpdate(nil)
		LeanTween.cancel(arg_20_0.m_scrollContent)

		arg_20_0.tween_ = nil
	end
end

function var_0_0.IsOpenSectionInfo(arg_21_0)
	return arg_21_0:IsOpenRoute("slayerSctionInfo")
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0.list:Dispose()
	var_0_0.super.Dispose(arg_22_0)
end

function var_0_0.RefreshSelecteRedPoint(arg_23_0)
	if manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.SLYAER_REGIONS, arg_23_0.slayer_activity_id)) then
		local var_23_0 = ActivityCfg[arg_23_0.slayer_activity_id].sub_activity_list

		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			SlayerAction.SetSlayerRead(iter_23_1)
		end
	end
end

return var_0_0
