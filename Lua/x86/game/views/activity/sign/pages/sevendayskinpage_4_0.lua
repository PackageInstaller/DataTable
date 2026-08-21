ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("SevenDaySkinPage_4_0", ActivityMainBasePanel)

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
		local var_3_1 = SevenDaySkinItem_4_0.New(arg_3_0["btn_" .. iter_3_0], var_3_0[iter_3_0], iter_3_0)

		arg_3_0.items_[iter_3_0] = var_3_1

		arg_3_0.items_[iter_3_0]:RegisterClickFunc(function(arg_4_0, arg_4_1)
			arg_3_0:OnBtnSignClick(arg_4_0, arg_4_1)
		end)
	end

	arg_3_0.onSignHandler = handler(arg_3_0, arg_3_0.OnSignSuccess)
	arg_3_0.onClearHandler = handler(arg_3_0, arg_3_0.OnClearSuccess)
	arg_3_0.onReceiveSHeroHandler = handler(arg_3_0, arg_3_0.OnReceiveSHeroSuccess)
	arg_3_0.pageCon_ = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("page")
	arg_3_0.freeCon_ = arg_3_0.freeControllerEx_:GetController("received")
	arg_3_0.freeItemGo_ = CommonItemView.New(arg_3_0.freeItem_, true)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("ACTIVITY_4_0_SIGN_INSTRUSCTIONS")
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.signBtn_, nil, function()
		SevenDaySkinData_New:SetDlcReward(true)
		arg_5_0.pageCon_:SetSelectedIndex(0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.freeBtn_, nil, function()
		SevenDaySkinData_New:SetDlcReward(false)
		arg_5_0.pageCon_:SetSelectedIndex(1)
	end)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
		SevenDaySkinAction_New.ReceiveGiftSHero(arg_5_0.activityID_)
	end)
end

function var_0_0.OnEnter(arg_10_0)
	var_0_0.super.OnEnter(arg_10_0)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, arg_10_0.onClearHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, arg_10_0.onSignHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_RECEIVE_SHERO_SUCCESS, arg_10_0.onReceiveSHeroHandler)
	arg_10_0:BindRedPoint()

	arg_10_0.crossDay_ = false

	arg_10_0:RefreshView()
end

function var_0_0.RefreshTimeText(arg_11_0)
	if arg_11_0.timeText_ then
		arg_11_0.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(arg_11_0.stopTime_, true)
	end
end

function var_0_0.RefreshView(arg_12_0)
	arg_12_0.changePage_ = SevenDaySkinData_New:GetDlcReward()
	arg_12_0.data_ = SevenDaySkinData_New:GetActivityData(arg_12_0.activityID_)

	local var_12_0 = arg_12_0.data_.gift_reward

	if arg_12_0.changePage_ then
		arg_12_0.pageCon_:SetSelectedIndex(0)
	else
		arg_12_0.pageCon_:SetSelectedIndex(var_12_0 == 0 and 1 or 0)
	end

	arg_12_0.freeCon_:SetSelectedIndex(var_12_0 == 0 and 1 or 0)

	local var_12_1 = ActivityCumulativeSignCfg[arg_12_0.activityID_].gift_item_list[1]

	if not arg_12_0.itemData_ then
		arg_12_0.itemData_ = clone(ItemTemplateData)

		function arg_12_0.itemData_.clickFun(arg_13_0)
			ShowPopItem(POP_ITEM, {
				arg_13_0.id
			})
		end
	end

	arg_12_0.itemData_.id = var_12_1[1]
	arg_12_0.itemData_.number = var_12_1[2]

	arg_12_0.freeItemGo_:SetData(arg_12_0.itemData_)

	local var_12_2 = ItemCfg[arg_12_0.itemData_.id]

	arg_12_0.sItemNameTxt_.text = var_12_2.name
	arg_12_0.descText_.text = GetTips("ACTIVITY_4_0_SIGN_DESC")

	local var_12_3 = ActivityCfg[arg_12_0.activityID_]

	arg_12_0.titleTxt_.text = GetI18NText(var_12_3.remark)
	arg_12_0.leftTxt_.text = GetTips("SEVENDAY_SKIN_OPTIONAL_HERO")
	arg_12_0.rightTxt_.text = GetTips("SEVENDAY_SKIN_WELFARE_SIGNIN")

	arg_12_0:RefreshItems()
end

function var_0_0.RefreshItems(arg_14_0)
	arg_14_0.data_ = SevenDaySkinData_New:GetActivityData(arg_14_0.activityID_)

	local var_14_0 = arg_14_0.data_:SignRewardList()
	local var_14_1 = arg_14_0.data_.unlock_reward
	local var_14_2 = arg_14_0.data_.gain_reward
	local var_14_3 = #var_14_1 + #var_14_2
	local var_14_4 = arg_14_0.data_:ReSignNum()
	local var_14_5 = var_14_4 + var_14_3

	for iter_14_0 = 1, arg_14_0.maxDay_ do
		local var_14_6 = var_14_0[iter_14_0]
		local var_14_7 = var_14_4 > 0

		arg_14_0.items_[iter_14_0]:RefreshView(var_14_6, iter_14_0 <= var_14_3 and 1 or 0, iter_14_0 == var_14_3 + 1 and var_14_7 and true or false, var_14_5)
		arg_14_0.items_[iter_14_0]:RefreshGet(var_14_2)
	end
end

function var_0_0.OnBtnSignClick(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}

	table.insert(var_15_0, arg_15_1)

	if arg_15_2 then
		arg_15_0:ShowCheckDialog(arg_15_1)
	else
		SevenDaySkinAction_New.ReqSign(arg_15_0.activityID_, var_15_0)
	end
end

function var_0_0.ShowCheckDialog(arg_16_0, arg_16_1)
	local var_16_0 = ActivityCumulativeSignCfg[arg_16_0.activityID_].cost_item_list[1]
	local var_16_1 = var_16_0[2]
	local var_16_2 = var_16_0[1]
	local var_16_3 = CurrencyData:GetCurrencyNum(var_16_2)

	JumpTools.OpenPageByJump("popCostItem", {
		costId = var_16_2,
		costCount = var_16_1,
		content = string.format(GetTips("TIP_ITEM_COST"), ItemTools.getItemName(var_16_2), var_16_1, GetTips("WHETHER_TO_SUPPLEMENTARY_SIGN")),
		popCostCallBack = function()
			local var_17_0, var_17_1 = ActivityData:GetActivityTime(arg_16_0.activityID_)

			if var_17_1 <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			elseif arg_16_0.crossDay_ then
				ShowTips("SUPPLEMENTARY_SIGN_FAIL")

				arg_16_0.crossDay_ = false
			elseif var_16_3 < var_16_1 then
				local var_17_2 = var_16_1 - var_16_3

				ShopTools.DefaultOpenPopUp(var_17_2)
			else
				SevenDaySkinAction_New.ReqReSign(arg_16_0.activityID_, arg_16_1)
			end
		end
	})
end

function var_0_0.OnSignSuccess(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.rewards[1]
	local var_18_1 = var_18_0.convert_from

	if var_18_1.id and var_18_1.id > 0 then
		local var_18_2 = var_18_1.id

		if ItemCfg[var_18_2] and ItemCfg[var_18_2].type == ItemConst.ITEM_TYPE.HERO then
			getReward(formatRewardCfgList({
				var_18_0
			}))
		end
	elseif ItemCfg[var_18_0.id] and ItemCfg[var_18_0.id].type == ItemConst.ITEM_TYPE.HERO then
		getReward(formatRewardCfgList({
			var_18_0
		}))
	elseif ItemCfg[var_18_0.id] and ItemCfg[var_18_0.id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
		getReward(formatRewardCfgList({
			var_18_0
		}))
	elseif ItemCfg[var_18_0.id] and ItemCfg[var_18_0.id].type == ItemConst.ITEM_TYPE.SCENE then
		getReward(formatRewardCfgList({
			var_18_0
		}))
	else
		getReward(formatRewardCfgList({
			var_18_0
		}))
	end

	SevenDaySkinData_New:SetDlcReward(true)
	arg_18_0:RefreshView()

	arg_18_0.crossDay_ = false
end

function var_0_0.OnClearSuccess(arg_19_0)
	arg_19_0:RefreshView()

	arg_19_0.crossDay_ = true
end

function var_0_0.OnReceiveSHeroSuccess(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.rewards[1]

	getReward(formatRewardCfgList({
		var_20_0
	}), nil, function()
		arg_20_0:RefreshView()
	end)
end

function var_0_0.UpdateBar(arg_22_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		SevenDaySkinData_New:SetDlcReward(false)
		arg_22_0:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		SevenDaySkinData_New:SetDlcReward(false)
		arg_22_0:Go("/home", nil, nil, true)
	end)
end

function var_0_0.Show(arg_25_0, arg_25_1)
	SetActive(arg_25_0.gameObject_, arg_25_1)

	if arg_25_1 then
		arg_25_0:UpdatePreview()
		arg_25_0:RefreshView()
	end
end

function var_0_0.BindRedPoint(arg_26_0)
	manager.redPoint:bindUIandKey(arg_26_0.signBtn_.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN_NEWSIGN, arg_26_0.activityID_))
	manager.redPoint:bindUIandKey(arg_26_0.freeBtn_.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN_GIFT, arg_26_0.activityID_))
end

function var_0_0.UnBindRedPoint(arg_27_0)
	manager.redPoint:unbindUIandKey(arg_27_0.signBtn_.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN_NEWSIGN, arg_27_0.activityID_))
	manager.redPoint:unbindUIandKey(arg_27_0.freeBtn_.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN_GIFT, arg_27_0.activityID_))
end

function var_0_0.OnTop(arg_28_0)
	arg_28_0:UpdateBar()
end

function var_0_0.OnExit(arg_29_0)
	arg_29_0:UnBindRedPoint()
	var_0_0.super.OnExit(arg_29_0)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, arg_29_0.onClearHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, arg_29_0.onSignHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_RECEIVE_SHERO_SUCCESS, arg_29_0.onReceiveSHeroHandler)
end

function var_0_0.Dispose(arg_30_0)
	arg_30_0:RemoveAllListeners()

	for iter_30_0 = 1, #arg_30_0.items_ do
		arg_30_0.items_[iter_30_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_30_0)
end

return var_0_0
