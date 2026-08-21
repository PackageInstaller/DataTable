local var_0_0 = class("ActivityGodEaterGameRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_AFK/V4_2_GodEaterUI_AFK_BaseUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()

	arg_3_0.rewardList = {}
	arg_3_0.nowExp = 0
	arg_3_0.rewardNum = 0
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.activity_id = arg_5_0.param_ and arg_5_0.param_.activity_id or 343671

	arg_5_0:RefreshUI()
	arg_5_0:StopTimer()
	arg_5_0:UpdateItem()

	arg_5_0.timer = Timer.New(function()
		arg_5_0:UpdateItem()
	end, 1)

	arg_5_0.timer:Start()
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_TOWER_DEFENSE_DESC")
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0, var_8_1, var_8_2 = GodEaterTool.HubExpToLevel(GodEaterData.totalExp)
	local var_8_3 = ActivityGodEaterLevelCfg[var_8_0]

	arg_8_0.lvtextText_.text = "Lv" .. var_8_0
	arg_8_0.textnumText_.text = var_8_1 .. "/" .. var_8_2
	arg_8_0.fillImg_.fillAmount = var_8_1 / var_8_2
	arg_8_0.iconImg_.sprite = ItemTools.getItemSprite(CurrencyConst.ACTIVITY_GOD_EATER_HUB_EXP)

	local var_8_4 = GodEaterTool.GetGodAddNum()

	for iter_8_0, iter_8_1 in ipairs(var_8_3.reward_param) do
		if not arg_8_0.rewardList[iter_8_0] then
			arg_8_0.rewardList[iter_8_0] = GodEaterAwardItem.New(arg_8_0[string.format("benefititemTrs%s_", iter_8_0)].gameObject)
		end

		local var_8_5 = {
			reward_param = iter_8_1,
			now = var_8_1,
			max = var_8_2,
			second = var_8_3.interval_second,
			addedNum = var_8_4[iter_8_0].now
		}

		arg_8_0.rewardList[iter_8_0]:SetData(var_8_5)
	end
end

function var_0_0.UpdateItem(arg_9_0)
	local var_9_0, var_9_1, var_9_2 = GodEaterTool.HubExpToLevel(GodEaterData.totalExp)
	local var_9_3 = ActivityGodEaterLevelCfg[var_9_0]
	local var_9_4 = GodEaterTool.GetGodAddNum()

	for iter_9_0, iter_9_1 in ipairs(var_9_3.reward_param) do
		if not arg_9_0.rewardList[iter_9_0] then
			arg_9_0.rewardList[iter_9_0] = GodEaterAwardItem.New(arg_9_0[string.format("benefititemTrs%s_", iter_9_0)].gameObject)
		end

		local var_9_5 = {
			reward_param = iter_9_1,
			now = var_9_1,
			max = var_9_2,
			second = var_9_3.interval_second,
			addedNum = var_9_4[iter_9_0].now
		}

		if iter_9_1.id == CurrencyConst.ACTIVITY_GOD_EATER_HUB_EXP then
			arg_9_0.nowExp = var_9_4[iter_9_0].now
		else
			arg_9_0.rewardNum = var_9_4[iter_9_0].now
		end

		arg_9_0.rewardList[iter_9_0]:SetData(var_9_5)
	end
end

function var_0_0.AddUIListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.allbackBtn_, nil, function()
		arg_10_0:Back()
	end)
	arg_10_0:AddBtnListener(arg_10_0.btn01Btn_, nil, function()
		if arg_10_0.nowExp <= 0 and arg_10_0.rewardNum <= 0 then
			ShowTips(GetTips("CANTEEN_ADMITTED_NULL"))
		else
			local var_12_0 = arg_10_0.activity_id

			for iter_12_0, iter_12_1 in ipairs(arg_10_0.rewardList) do
				if iter_12_0 == #arg_10_0.rewardList then
					iter_12_1:ShowReceiveAnimation(function()
						GodEaterAction.DrawHudReward(var_12_0)
					end)
				else
					iter_12_1:ShowReceiveAnimation()
				end
			end
		end
	end)
end

function var_0_0.OnBehind(arg_14_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
	arg_15_0:StopTimer()
	arg_15_0:RemoveTween()
	manager.redPoint:unbindUIandKey(arg_15_0.rewardbtntrans_, RedPointConst.MARDUK_TOWERGAME_REWARD)
end

function var_0_0.RemoveTween(arg_16_0)
	return
end

function var_0_0.StopTimer(arg_17_0)
	if arg_17_0.timer then
		arg_17_0.timer:Stop()

		arg_17_0.timer = nil
	end
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.rewardList) do
		if iter_18_1 then
			iter_18_1:Dispose()
		end
	end
end

return var_0_0
