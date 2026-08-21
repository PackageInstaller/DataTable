local var_0_0 = class("HellaParkourEntrustView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/HellaUI/Parkour/HellaParkourEntrustUI"
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

	arg_4_0.entrustList = LuaList.New(handler(arg_4_0, arg_4_0.IndexEntrustItem), arg_4_0.m_entrustList, HellaParkourEntrustItem)
	arg_4_0.targetList = LuaList.New(handler(arg_4_0, arg_4_0.IndexTargetItem), arg_4_0.m_targetList, HellaParkourTargetItem)
	arg_4_0.specialTargetList = LuaList.New(handler(arg_4_0, arg_4_0.IndexSpecailTargetItem), arg_4_0.m_specialTargetList, HellaParkourTargetItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_rewardBtn, nil, function()
		local var_6_0 = arg_5_0.entrusts[arg_5_0.selectIndex]

		JumpTools.OpenPageByJump("hellaParkourReward", {
			parkour_activity_id = arg_5_0.parkour_activity_id,
			entrust_activity_id = var_6_0
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_entrustBtn, nil, function()
		local var_7_0 = arg_5_0.entrusts[arg_5_0.selectIndex]

		if not ActivityData:GetActivityIsOpen(var_7_0) then
			ShowTips("TIP_EXPIRED")

			return
		end

		local var_7_1 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.PARKOUR, var_7_0, arg_5_0.parkour_activity_id)

		BattleController.GetInstance():LaunchBattle(var_7_1)
	end)
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_HELLA_PARKOUR_DESCRIPE")
	arg_8_0:Refresh()
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.parkour_activity_id = arg_9_0.params_.parkour_activity_id or 0

	local var_9_0 = ActivityCfg[arg_9_0.parkour_activity_id]

	arg_9_0.entrusts = var_9_0 and var_9_0.sub_activity_list or {}

	ParkourAction.SetParkourRead(arg_9_0.parkour_activity_id)

	arg_9_0.timer = Timer.New(function()
		arg_9_0:OnTimerEvent()
	end, 1, -1)

	arg_9_0.timer:Start()

	if arg_9_0.params_.entrust_activity_id then
		local var_9_1 = table.indexof(arg_9_0.entrusts, arg_9_0.params_.entrust_activity_id)

		if var_9_1 and ActivityData:GetActivityIsOpen(arg_9_0.params_.entrust_activity_id) then
			arg_9_0:SetSelectIndex(var_9_1)
			arg_9_0.entrustList:StartScroll(#arg_9_0.entrusts, var_9_1)

			return
		end
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.entrusts) do
		if ActivityData:GetActivityIsOpen(iter_9_1) then
			arg_9_0:SetSelectIndex(iter_9_0)
			arg_9_0.entrustList:StartScroll(#arg_9_0.entrusts, iter_9_0)

			return
		end
	end

	arg_9_0:SetSelectIndex(1)
	arg_9_0.entrustList:StartScroll(#arg_9_0.entrusts)
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()

	arg_11_0.selectIndex = nil

	if arg_11_0.timer then
		arg_11_0.timer:Stop()

		arg_11_0.timer = nil
	end
end

function var_0_0.OnTimerEvent(arg_12_0)
	local var_12_0 = arg_12_0.entrustList:GetItemList()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		iter_12_1:RefreshTime()
	end
end

function var_0_0.Refresh(arg_13_0)
	local var_13_0 = arg_13_0.entrusts[arg_13_0.selectIndex]
	local var_13_1 = ActivityParkourCfg[var_13_0]

	arg_13_0.m_title.text = GetI18NText(var_13_1.name)
	arg_13_0.m_des.text = GetI18NText(var_13_1.desc)

	local var_13_2 = var_13_1.stage_id

	arg_13_0.targetData = BattleParkourStageCfg[var_13_2].three_star_need

	arg_13_0.targetList:StartScroll(3)
	arg_13_0.specialTargetList:StartScroll(1)

	local var_13_3 = manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_REWARD, var_13_0))

	manager.redPoint:SetRedPointIndependent(arg_13_0.m_rewardBtn.transform, var_13_3)
end

function var_0_0.IndexEntrustItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.entrusts[arg_14_1]

	arg_14_2:SetData(arg_14_1, var_14_0)
	arg_14_2:SetSelectedIndex(arg_14_0.selectIndex)
	arg_14_2:RegistCallBack(handler(arg_14_0, arg_14_0.SetSelectIndex))
end

function var_0_0.SetSelectIndex(arg_15_0, arg_15_1)
	if arg_15_1 == arg_15_0.selectIndex then
		return
	end

	if arg_15_1 ~= 0 then
		local var_15_0 = arg_15_0.entrusts[arg_15_1]

		if not ActivityData:GetActivityIsOpen(var_15_0) then
			local var_15_1 = ActivityData:GetActivityData(var_15_0)
			local var_15_2 = manager.time:GetServerTime()

			if var_15_1 and var_15_2 < var_15_1.startTime then
				ShowTips(string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(var_15_1.startTime)))
			else
				ShowTips("TIME_OVER")
			end

			arg_15_0.selectIndex = 1

			return
		end
	end

	arg_15_0.selectIndex = arg_15_1

	local var_15_3 = arg_15_0.entrustList:GetItemList()

	for iter_15_0, iter_15_1 in pairs(var_15_3) do
		iter_15_1:SetSelectedIndex(arg_15_0.selectIndex)
	end

	arg_15_0:Refresh()
end

function var_0_0.IndexTargetItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.targetData[arg_16_1]
	local var_16_1 = arg_16_0.entrusts[arg_16_0.selectIndex]

	arg_16_2:SetData(arg_16_1, var_16_1, var_16_0, false)
end

function var_0_0.IndexSpecailTargetItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1 + 3
	local var_17_1 = arg_17_0.targetData[var_17_0]
	local var_17_2 = arg_17_0.entrusts[arg_17_0.selectIndex]

	arg_17_2:SetData(var_17_0, var_17_2, var_17_1, true)
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.entrustList:Dispose()
	arg_18_0.targetList:Dispose()
	arg_18_0.specialTargetList:Dispose()
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
