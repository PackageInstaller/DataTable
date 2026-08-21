ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("SevenDaySkinPage_4_8", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return ActivityCumulativeSignCfg[arg_1_0.activityID_].ui_path
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.items_ = {}
	arg_3_0.maxDay_ = SevenDaySkinData_New:MaxSignDay(arg_3_0.activityID_)

	local var_3_0 = ActivityCumulativeSignCfg[arg_3_0.activityID_].config_list

	for iter_3_0 = 1, arg_3_0.maxDay_ do
		local var_3_1 = SevenDaySkinItem_4_8.New(arg_3_0["btn_" .. iter_3_0], var_3_0[iter_3_0], iter_3_0)

		arg_3_0.items_[iter_3_0] = var_3_1

		arg_3_0.items_[iter_3_0]:RegisterClickFunc(function(arg_4_0, arg_4_1)
			arg_3_0:OnBtnSignClick(arg_4_0, arg_4_1)
		end)
	end

	arg_3_0.onSignHandler = handler(arg_3_0, arg_3_0.OnSignSuccess)
	arg_3_0.onClearHandler = handler(arg_3_0, arg_3_0.OnClearSuccess)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("ACTIVITY_3_6_SIGN_INSTRUSCTIONS")
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	var_0_0.super.OnEnter(arg_7_0)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, arg_7_0.onClearHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, arg_7_0.onSignHandler)
	arg_7_0:BindRedPoint()

	arg_7_0.crossDay_ = false

	arg_7_0:RefreshView()
end

function var_0_0.RefreshTimeText(arg_8_0)
	if arg_8_0.timeText_ then
		arg_8_0.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(arg_8_0.stopTime_, true)
	end
end

function var_0_0.RefreshView(arg_9_0)
	arg_9_0.data_ = SevenDaySkinData_New:GetActivityData(arg_9_0.activityID_)

	local var_9_0 = arg_9_0.data_.gift_reward
	local var_9_1 = ActivityCumulativeSignCfg[arg_9_0.activityID_]

	if not arg_9_0.itemData_ then
		arg_9_0.itemData_ = clone(ItemTemplateData)

		function arg_9_0.itemData_.clickFun(arg_10_0)
			ShowPopItem(POP_ITEM, {
				arg_10_0.id
			})
		end
	end

	local var_9_2 = ActivityToggleCfg.get_id_list_by_activity_id[arg_9_0.activityID_][1]

	arg_9_0.descText_.text = GetI18NText(ActivityToggleCfg[var_9_2].desc)

	local var_9_3 = ActivityCfg[arg_9_0.activityID_]

	arg_9_0.titleTxt_.text = GetI18NText(ActivityToggleCfg[var_9_2].name)

	arg_9_0:RefreshItems()
end

function var_0_0.RefreshItems(arg_11_0)
	arg_11_0.data_ = SevenDaySkinData_New:GetActivityData(arg_11_0.activityID_)

	local var_11_0 = arg_11_0.data_:SignRewardList()
	local var_11_1 = arg_11_0.data_.unlock_reward
	local var_11_2 = arg_11_0.data_.gain_reward
	local var_11_3 = #var_11_1 + #var_11_2
	local var_11_4 = arg_11_0.data_:ReSignNum()
	local var_11_5 = var_11_4 + var_11_3

	for iter_11_0 = 1, arg_11_0.maxDay_ do
		local var_11_6 = var_11_0[iter_11_0]
		local var_11_7 = var_11_4 > 0

		arg_11_0.items_[iter_11_0]:RefreshView(var_11_6, iter_11_0 <= var_11_3 and 1 or 0, iter_11_0 == var_11_3 + 1 and var_11_7 and true or false, var_11_5)
		arg_11_0.items_[iter_11_0]:RefreshGet(var_11_2)
	end
end

function var_0_0.OnBtnSignClick(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}

	table.insert(var_12_0, arg_12_1)

	if arg_12_2 then
		arg_12_0:ShowCheckDialog(arg_12_1)
	else
		SevenDaySkinAction_New.ReqSign(arg_12_0.activityID_, var_12_0)
	end
end

function var_0_0.ShowCheckDialog(arg_13_0, arg_13_1)
	local var_13_0 = ActivityCumulativeSignCfg[arg_13_0.activityID_].cost_item_list[1]
	local var_13_1 = var_13_0[2]
	local var_13_2 = var_13_0[1]
	local var_13_3 = CurrencyData:GetCurrencyNum(var_13_2)

	JumpTools.OpenPageByJump("popCostItem", {
		costId = var_13_2,
		costCount = var_13_1,
		content = string.format(GetTips("TIP_ITEM_COST"), ItemTools.getItemName(var_13_2), var_13_1, GetTips("WHETHER_TO_SUPPLEMENTARY_SIGN")),
		popCostCallBack = function()
			local var_14_0, var_14_1 = ActivityData:GetActivityTime(arg_13_0.activityID_)

			if var_14_1 <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			elseif arg_13_0.crossDay_ then
				ShowTips("SUPPLEMENTARY_SIGN_FAIL")

				arg_13_0.crossDay_ = false
			elseif var_13_3 < var_13_1 then
				local var_14_2 = var_13_1 - var_13_3

				ShopTools.DefaultOpenPopUp(var_14_2)
			else
				SevenDaySkinAction_New.ReqReSign(arg_13_0.activityID_, arg_13_1)
			end
		end
	})
end

function var_0_0.OnSignSuccess(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.rewards[1]
	local var_15_1 = var_15_0.convert_from

	if var_15_1.id and var_15_1.id > 0 then
		local var_15_2 = var_15_1.id

		if ItemCfg[var_15_2] and ItemCfg[var_15_2].type == ItemConst.ITEM_TYPE.HERO then
			getReward(formatRewardCfgList({
				var_15_0
			}))
		end
	elseif ItemCfg[var_15_0.id] and ItemCfg[var_15_0.id].type == ItemConst.ITEM_TYPE.HERO then
		getReward(formatRewardCfgList({
			var_15_0
		}))
	elseif ItemCfg[var_15_0.id] and ItemCfg[var_15_0.id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
		getReward(formatRewardCfgList({
			var_15_0
		}))
	elseif ItemCfg[var_15_0.id] and ItemCfg[var_15_0.id].type == ItemConst.ITEM_TYPE.SCENE then
		getReward(formatRewardCfgList({
			var_15_0
		}))
	else
		getReward(formatRewardCfgList({
			var_15_0
		}))
	end

	SevenDaySkinData_New:SetDlcReward(true)
	arg_15_0:RefreshView()

	arg_15_0.crossDay_ = false
end

function var_0_0.OnClearSuccess(arg_16_0)
	arg_16_0:RefreshView()

	arg_16_0.crossDay_ = true
end

function var_0_0.UpdateBar(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		SevenDaySkinData_New:SetDlcReward(false)
		arg_17_0:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		SevenDaySkinData_New:SetDlcReward(false)
		arg_17_0:Go("/home", nil, nil, true)
	end)
end

function var_0_0.Show(arg_20_0, arg_20_1)
	SetActive(arg_20_0.gameObject_, arg_20_1)

	if arg_20_1 then
		arg_20_0:UpdatePreview()
		arg_20_0:RefreshView()
	end
end

function var_0_0.BindRedPoint(arg_21_0)
	return
end

function var_0_0.UnBindRedPoint(arg_22_0)
	return
end

function var_0_0.OnTop(arg_23_0)
	arg_23_0:UpdateBar()
end

function var_0_0.OnExit(arg_24_0)
	arg_24_0:UnBindRedPoint()
	var_0_0.super.OnExit(arg_24_0)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, arg_24_0.onClearHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, arg_24_0.onSignHandler)
end

function var_0_0.Dispose(arg_25_0)
	arg_25_0:RemoveAllListeners()

	for iter_25_0 = 1, #arg_25_0.items_ do
		arg_25_0.items_[iter_25_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_25_0)
end

return var_0_0
