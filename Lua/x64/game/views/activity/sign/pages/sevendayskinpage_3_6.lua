ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("SevenDaySkinPage_3_6", ActivityMainBasePanel)

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
		local var_3_1 = SevenDaySkinItem_3_6.New(arg_3_0["btn_" .. iter_3_0], var_3_0[iter_3_0], iter_3_0)

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

	arg_7_0.crossDay_ = false
	arg_7_0.data_ = SevenDaySkinData_New:GetActivityData(arg_7_0.activityID_)

	arg_7_0:RefreshView()
end

function var_0_0.RefreshTimeText(arg_8_0)
	if arg_8_0.timeText_ then
		arg_8_0.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(arg_8_0.stopTime_, true)
	end
end

function var_0_0.RefreshView(arg_9_0)
	local var_9_0 = ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[arg_9_0.activityID_][1]]

	arg_9_0.descText_.text = var_9_0.desc

	local var_9_1 = ActivityCfg[arg_9_0.activityID_]

	arg_9_0.titleTxt_.text = var_9_0.name

	arg_9_0:RefreshItems()
end

function var_0_0.RefreshItems(arg_10_0)
	arg_10_0.data_ = SevenDaySkinData_New:GetActivityData(arg_10_0.activityID_)

	local var_10_0 = arg_10_0.data_:SignRewardList()
	local var_10_1 = arg_10_0.data_.unlock_reward
	local var_10_2 = arg_10_0.data_.gain_reward
	local var_10_3 = #var_10_1 + #var_10_2
	local var_10_4 = arg_10_0.data_:ReSignNum()
	local var_10_5 = var_10_4 + var_10_3

	for iter_10_0 = 1, arg_10_0.maxDay_ do
		local var_10_6 = var_10_0[iter_10_0]
		local var_10_7 = var_10_4 > 0

		arg_10_0.items_[iter_10_0]:RefreshView(var_10_6, iter_10_0 <= var_10_3 and 1 or 0, iter_10_0 == var_10_3 + 1 and var_10_7 and true or false, var_10_5)
		arg_10_0.items_[iter_10_0]:RefreshGet(var_10_2)
	end
end

function var_0_0.OnBtnSignClick(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}

	table.insert(var_11_0, arg_11_1)

	if arg_11_2 then
		arg_11_0:ShowCheckDialog(arg_11_1)
	else
		SevenDaySkinAction_New.ReqSign(arg_11_0.activityID_, var_11_0)
	end
end

function var_0_0.ShowCheckDialog(arg_12_0, arg_12_1)
	local var_12_0 = ActivityCumulativeSignCfg[arg_12_0.activityID_].cost_item_list[1]
	local var_12_1 = var_12_0[2]
	local var_12_2 = var_12_0[1]
	local var_12_3 = CurrencyData:GetCurrencyNum(var_12_2)

	JumpTools.OpenPageByJump("popCostItem", {
		costId = var_12_2,
		costCount = var_12_1,
		content = string.format(GetTips("TIP_ITEM_COST"), ItemTools.getItemName(var_12_2), var_12_1, GetTips("WHETHER_TO_SUPPLEMENTARY_SIGN")),
		popCostCallBack = function()
			local var_13_0, var_13_1 = ActivityData:GetActivityTime(arg_12_0.activityID_)

			if var_13_1 <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			elseif arg_12_0.crossDay_ then
				ShowTips("SUPPLEMENTARY_SIGN_FAIL")

				arg_12_0.crossDay_ = false
			elseif var_12_3 < var_12_1 then
				local var_13_2 = var_12_1 - var_12_3

				ShopTools.DefaultOpenPopUp(var_13_2)
			else
				SevenDaySkinAction_New.ReqReSign(arg_12_0.activityID_, arg_12_1)
			end
		end
	})
end

function var_0_0.OnSignSuccess(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.rewards[1]
	local var_14_1 = var_14_0.convert_from

	if var_14_1.id and var_14_1.id > 0 then
		local var_14_2 = var_14_1.id

		if ItemCfg[var_14_2] and ItemCfg[var_14_2].type == ItemConst.ITEM_TYPE.HERO then
			getReward(formatRewardCfgList({
				var_14_0
			}))
		end
	elseif ItemCfg[var_14_0.id] and ItemCfg[var_14_0.id].type == ItemConst.ITEM_TYPE.HERO then
		getReward(formatRewardCfgList({
			var_14_0
		}))
	else
		getReward(formatRewardCfgList({
			var_14_0
		}))
	end

	arg_14_0:RefreshView()

	arg_14_0.crossDay_ = false
end

function var_0_0.OnClearSuccess(arg_15_0)
	arg_15_0:RefreshView()

	arg_15_0.crossDay_ = true
end

function var_0_0.UpdateBar(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnTop(arg_17_0)
	arg_17_0:UpdateBar()
end

function var_0_0.OnExit(arg_18_0)
	var_0_0.super.OnExit(arg_18_0)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, arg_18_0.onClearHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, arg_18_0.onSignHandler)
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:RemoveAllListeners()

	for iter_19_0 = 1, #arg_19_0.items_ do
		arg_19_0.items_[iter_19_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
