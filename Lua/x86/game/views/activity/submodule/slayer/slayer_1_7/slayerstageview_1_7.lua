local var_0_0 = import("game.views.activity.Submodule.slayer.volume.VolumeSlayerView")
local var_0_1 = class("SplayerStageView_1_7", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.list = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.m_list, SlayerStageItem_1_7)
end

function var_0_1.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.m_entrustBtn, nil, function()
		local var_3_0 = arg_2_0.regionList[arg_2_0.selectIndex]
		local var_3_1 = ActivitySlayerCfg[var_3_0]

		arg_2_0:Go("/sectionSelectHero", {
			section = var_3_1.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SLAYER,
			region_activity_id = var_3_0,
			activityID = arg_2_0.slayer_activity_id
		})
	end)
end

function var_0_1.OnTop(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SOLO_SLAYER_DESCRIPE")
end

function var_0_1.OnEnter(arg_5_0)
	arg_5_0.slayer_activity_id = arg_5_0.params_.slayer_activity_id or 0

	local var_5_0 = ActivityCfg[arg_5_0.slayer_activity_id]

	arg_5_0.regionList = var_5_0 and var_5_0.sub_activity_list or {}

	if arg_5_0.params_.init_tag and not ActivityData:GetActivityIsOpen(arg_5_0.regionList[arg_5_0.selectIndex]) then
		arg_5_0.params_.init_tag = nil

		for iter_5_0, iter_5_1 in ipairs(arg_5_0.regionList) do
			if ActivityData:GetActivityIsOpen(iter_5_1) then
				arg_5_0.selectIndex = iter_5_0

				break
			end
		end
	end

	if arg_5_0.params_.region_activity_id then
		arg_5_0.selectIndex = table.indexof(arg_5_0.regionList, arg_5_0.params_.region_activity_id) or 1
		arg_5_0.params_.region_activity_id = nil
	else
		arg_5_0.selectIndex = SlayerData:GetSelectIndex(arg_5_0.slayer_activity_id) or 1
	end

	arg_5_0.list:StartScroll(#arg_5_0.regionList, arg_5_0.selectIndex, true)

	local var_5_1 = arg_5_0.regionList[arg_5_0.selectIndex]

	SlayerAction.SetSlayerRead(var_5_1)

	arg_5_0.timer = Timer.New(function()
		arg_5_0:OnTimerEvent()
	end, 1, -1)

	arg_5_0.timer:Start()
	arg_5_0:Refresh()
end

function var_0_1.Refresh(arg_7_0)
	local var_7_0 = arg_7_0.list:GetItemList()

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		iter_7_1:SetSelectedIndex(arg_7_0.selectIndex)
	end

	local var_7_1 = arg_7_0.regionList[arg_7_0.selectIndex]
	local var_7_2 = ActivitySlayerCfg[var_7_1]
	local var_7_3 = var_7_2 and var_7_2.buff_desc or {}
	local var_7_4 = ""

	for iter_7_2, iter_7_3 in ipairs(var_7_3) do
		var_7_4 = var_7_4 .. iter_7_3 .. "\n"
	end

	arg_7_0.m_buffDes.text = GetI18NText(var_7_4)

	local var_7_5 = var_7_2.stage_id
	local var_7_6 = BattleSlayerStageCfg[var_7_5]

	arg_7_0.m_title.text = GetI18NText(var_7_6.name)
	arg_7_0.m_des.text = GetI18NText(var_7_6.tips)

	arg_7_0:RefreshReward(var_7_1)
end

function var_0_1.RefreshReward(arg_8_0, arg_8_1)
	if arg_8_0.m_rewardView == nil then
		arg_8_0.m_rewardView = SlayerTools.GetRewardItemClass(arg_8_0.slayer_activity_id).New(arg_8_0.m_rewardPanelGo)
	end

	arg_8_0.m_rewardView:SetData(arg_8_0.slayer_activity_id, arg_8_1)
	arg_8_0.m_rewardView:SetActive(true)
end

function var_0_1.SetSelectIndex(arg_9_0, arg_9_1)
	if arg_9_1 == arg_9_0.selectIndex then
		return
	end

	if arg_9_1 ~= 0 then
		local var_9_0 = arg_9_0.regionList[arg_9_1]

		if not ActivityTools.GetActivityIsOpenWithTip(var_9_0, true) then
			return
		end

		SlayerAction.SetSlayerRead(var_9_0)
	end

	arg_9_0.selectIndex = arg_9_1

	arg_9_0:Refresh()
	SlayerData:SetSelectIndex(arg_9_0.slayer_activity_id, arg_9_1)
end

function var_0_1.Dispose(arg_10_0)
	arg_10_0.m_rewardView:Dispose()

	arg_10_0.m_rewardView = nil

	var_0_1.super.Dispose(arg_10_0)
end

return var_0_1
