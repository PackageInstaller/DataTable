ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("SevenDaySkinPage_5_2", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return ActivityCumulativeSignCfg[arg_1_0.activityID_].ui_path
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.onClearHandler = handler(arg_3_0, arg_3_0.OnClearSuccess)
	arg_3_0.onReceiveSHeroHandler = handler(arg_3_0, arg_3_0.OnReceiveSHeroSuccess)
	arg_3_0.freeCon_ = arg_3_0.freeControllerEx_:GetController("received")
	arg_3_0.freeItemGo_ = CommonItemView.New(arg_3_0.freeItem_, true)
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.infoBtn_, nil, function()
		local var_5_0 = ActivityToggleCfg.get_id_list_by_activity_id[arg_4_0.activityID_][1]
		local var_5_1 = ActivityToggleCfg[var_5_0]

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetI18NText(var_5_1.desc or "")
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		SevenDaySkinAction_New.ReceiveGiftSHero(arg_4_0.activityID_)
	end)
end

function var_0_0.OnEnter(arg_7_0)
	var_0_0.super.OnEnter(arg_7_0)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, arg_7_0.onClearHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_RECEIVE_SHERO_SUCCESS, arg_7_0.onReceiveSHeroHandler)
	arg_7_0:BindRedPoint()
	arg_7_0:RefreshView()
end

function var_0_0.RefreshTimeText(arg_8_0)
	if arg_8_0.timeText_ then
		arg_8_0.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(arg_8_0.stopTime_, true)
	end
end

function var_0_0.RefreshView(arg_9_0)
	arg_9_0.data_ = SevenDaySkinData_New:GetActivityData(arg_9_0.activityID_)

	local var_9_0 = ActivityCumulativeSignCfg[arg_9_0.activityID_]
	local var_9_1 = arg_9_0.data_.gift_reward
	local var_9_2 = var_9_0.gift_item_list[1]

	if not arg_9_0.itemData_ then
		arg_9_0.itemData_ = clone(ItemTemplateData)

		function arg_9_0.itemData_.clickFun(arg_10_0)
			ShowPopItem(POP_ITEM, {
				arg_10_0.id
			})
		end
	end

	arg_9_0.itemData_.id = var_9_2[1]
	arg_9_0.itemData_.number = var_9_2[2]

	arg_9_0.freeItemGo_:SetData(arg_9_0.itemData_)
	arg_9_0.freeCon_:SetSelectedIndex(var_9_1 == 0 and 1 or 0)

	local var_9_3 = ItemCfg[arg_9_0.itemData_.id]

	arg_9_0.sItemNameTxt_.text = var_9_3 and var_9_3.name or ""

	local var_9_4 = ActivityToggleCfg.get_id_list_by_activity_id[arg_9_0.activityID_][1]
	local var_9_5 = ActivityToggleCfg[var_9_4]

	arg_9_0.descText_.text = GetI18NText(var_9_5.desc or "")
	arg_9_0.titleTxt_.text = GetI18NText(var_9_5.name or "")
end

function var_0_0.OnClearSuccess(arg_11_0)
	arg_11_0:RefreshView()
end

function var_0_0.OnReceiveSHeroSuccess(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.rewards[1]

	getReward(formatRewardCfgList({
		var_12_0
	}), nil, function()
		arg_12_0:RefreshView()
	end)
end

function var_0_0.UpdateBar(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		SevenDaySkinData_New:SetDlcReward(false)
		arg_14_0:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		SevenDaySkinData_New:SetDlcReward(false)
		arg_14_0:Go("/home", nil, nil, true)
	end)
end

function var_0_0.Show(arg_17_0, arg_17_1)
	SetActive(arg_17_0.gameObject_, arg_17_1)

	if arg_17_1 then
		arg_17_0:UpdatePreview()
		arg_17_0:RefreshView()
	end
end

function var_0_0.BindRedPoint(arg_18_0)
	manager.redPoint:bindUIandKey(arg_18_0.receiveBtn_.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN_GIFT, arg_18_0.activityID_))
end

function var_0_0.UnBindRedPoint(arg_19_0)
	manager.redPoint:unbindUIandKey(arg_19_0.receiveBtn_.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN_GIFT, arg_19_0.activityID_))
end

function var_0_0.OnTop(arg_20_0)
	arg_20_0:UpdateBar()
end

function var_0_0.OnExit(arg_21_0)
	arg_21_0:UnBindRedPoint()
	var_0_0.super.OnExit(arg_21_0)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, arg_21_0.onClearHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_RECEIVE_SHERO_SUCCESS, arg_21_0.onReceiveSHeroHandler)
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0:RemoveAllListeners()

	if arg_22_0.freeItemGo_ then
		arg_22_0.freeItemGo_:Dispose()

		arg_22_0.freeItemGo_ = nil
	end

	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
