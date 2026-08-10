local var_0_0 = class("VolumeSlayerView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return SlayerTools.GetSelectUIName(arg_1_0.params_.slayer_activity_id or 0)
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

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, VolumeSlayerItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_rewardBtn, nil, function()
		local var_6_0 = arg_5_0.regionList[arg_5_0.selectIndex]

		JumpTools.OpenPageByJump("hellaSlayerReward", {
			slayer_activity_id = arg_5_0.slayer_activity_id,
			region_activity_id = var_6_0
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_entrustBtn, nil, function()
		local var_7_0 = arg_5_0.regionList[arg_5_0.selectIndex]
		local var_7_1 = ActivitySlayerCfg[var_7_0]

		arg_5_0:Go("/sectionSelectHero", {
			section = var_7_1.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SLAYER,
			region_activity_id = var_7_0,
			activityID = arg_5_0.slayer_activity_id
		})
	end)
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_VOLUME_SLAYER_DESCRIPE")
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.slayer_activity_id = arg_9_0.params_.slayer_activity_id or 0

	local var_9_0 = ActivityCfg[arg_9_0.slayer_activity_id]

	arg_9_0.regionList = var_9_0 and var_9_0.sub_activity_list or {}

	if arg_9_0.params_.init_tag and not ActivityData:GetActivityIsOpen(arg_9_0.regionList[arg_9_0.selectIndex]) then
		arg_9_0.params_.init_tag = nil

		for iter_9_0, iter_9_1 in ipairs(arg_9_0.regionList) do
			if ActivityData:GetActivityIsOpen(iter_9_1) then
				arg_9_0.selectIndex = iter_9_0

				break
			end
		end
	end

	if arg_9_0.params_.region_activity_id then
		arg_9_0.selectIndex = table.indexof(arg_9_0.regionList, arg_9_0.params_.region_activity_id) or 1
		arg_9_0.params_.region_activity_id = nil
	end

	arg_9_0.selectIndex = arg_9_0.selectIndex or 1

	arg_9_0.list:StartScroll(#arg_9_0.regionList, arg_9_0.selectIndex, true)
	arg_9_0:RefreshSelecteRedPoint()

	arg_9_0.timer = Timer.New(function()
		arg_9_0:OnTimerEvent()
	end, 1, -1)

	arg_9_0.timer:Start()
	arg_9_0:Refresh()
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()

	if arg_11_0.timer then
		arg_11_0.timer:Stop()

		arg_11_0.timer = nil
	end
end

function var_0_0.OnTimerEvent(arg_12_0)
	local var_12_0 = arg_12_0.list:GetItemList()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		iter_12_1:RefreshTime()
	end
end

function var_0_0.IndexItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.regionList[arg_13_1]
	local var_13_1 = false

	if arg_13_1 == #arg_13_0.regionList then
		var_13_1 = true
	end

	arg_13_2:SetData(arg_13_1, arg_13_0.slayer_activity_id, var_13_0, var_13_1)
	arg_13_2:SetSelectedIndex(arg_13_0.selectIndex)
	arg_13_2:RegistCallBack(handler(arg_13_0, arg_13_0.SetSelectIndex))
end

function var_0_0.SetSelectIndex(arg_14_0, arg_14_1)
	if arg_14_1 == arg_14_0.selectIndex then
		return
	end

	if arg_14_1 ~= 0 then
		local var_14_0 = arg_14_0.regionList[arg_14_1]

		if not ActivityTools.GetActivityIsOpenWithTip(var_14_0, true) then
			return
		end
	end

	arg_14_0.selectIndex = arg_14_1

	arg_14_0:Refresh()
end

function var_0_0.Refresh(arg_15_0)
	local var_15_0 = arg_15_0.list:GetItemList()

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		iter_15_1:SetSelectedIndex(arg_15_0.selectIndex)
	end

	local var_15_1 = arg_15_0.regionList[arg_15_0.selectIndex]
	local var_15_2 = ActivitySlayerCfg[var_15_1]
	local var_15_3 = var_15_2 and var_15_2.buff_desc or {}
	local var_15_4 = ""

	for iter_15_2, iter_15_3 in ipairs(var_15_3) do
		var_15_4 = GetI18NText(var_15_4) .. GetI18NText(iter_15_3) .. "\n"
	end

	arg_15_0.m_buffDes.text = GetI18NText(var_15_4)

	local var_15_5 = var_15_2.stage_id
	local var_15_6 = BattleSlayerStageCfg[var_15_5]

	arg_15_0.m_title.text = GetI18NText(var_15_6.name)
	arg_15_0.m_des.text = GetI18NText(var_15_6.tips)

	local var_15_7 = SlayerAction.GetSlayerRewardState(arg_15_0.slayer_activity_id, var_15_1)

	manager.redPoint:SetRedPointIndependent(arg_15_0.m_rewardBtn.transform, var_15_7)
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.selectIndex = nil

	arg_16_0.list:Dispose()
	var_0_0.super.Dispose(arg_16_0)
end

function var_0_0.OnSlayerReward(arg_17_0)
	arg_17_0:Refresh()
end

function var_0_0.RefreshSelecteRedPoint(arg_18_0)
	if manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.SLYAER_REGIONS, arg_18_0.slayer_activity_id)) then
		local var_18_0 = ActivityCfg[arg_18_0.slayer_activity_id].sub_activity_list

		for iter_18_0, iter_18_1 in ipairs(var_18_0) do
			SlayerAction.SetSlayerRead(iter_18_1)
		end
	end
end

return var_0_0
