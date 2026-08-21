local var_0_0 = class("EquipSeizureView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Equip_Seizure/EquipSeizureUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.affixItemList_ = {}
	arg_3_0.updateHandler_ = handler(arg_3_0, arg_3_0.RefreshUI)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("EQUIP_SEIZURE_INFO")
	manager.redPoint:bindUIandKey(arg_4_0.pointBtn_.transform, RedPointConst.EQUIP_SEIZURE_REWARD)
	manager.notify:RegistListener(EQUIP_SEIZURE_UPDATE, arg_4_0.updateHandler_)
	arg_4_0:RefreshUI()
	EquipSeizureAction.OpenWindow()
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.notify:RemoveListener(EQUIP_SEIZURE_UPDATE, arg_5_0.updateHandler_)
	manager.redPoint:unbindUIandKey(arg_5_0.pointBtn_.transform, RedPointConst.EQUIP_SEIZURE_REWARD)
	arg_5_0:StopTimer()
	arg_5_0:StopRefreshTimer()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.updateHandler_ = nil

	for iter_6_0 = #arg_6_0.affixItemList_, 1, -1 do
		arg_6_0.affixItemList_[iter_6_0]:Dispose()

		arg_6_0.affixItemList_[iter_6_0] = nil
	end

	arg_6_0.affixItemList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.pointBtn_, nil, function()
		JumpTools.OpenPageByJump("equipSeizureReward", {})
	end)
	arg_7_0:AddBtnListener(arg_7_0.startBtn_, nil, function()
		arg_7_0:Go("/sectionSelectHero", {
			section = EquipSeizureData:GetStageID(),
			sectionType = BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE
		})
	end)
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.pointText_.text = EquipSeizureData:GetTodayMaxScore()
	arg_10_0.rateText_.text = string.format("x%s", EquipSeizureData:GetChallengeRate())

	local var_10_0 = EquipSeizureData:GetAffixIDList()

	for iter_10_0 = #arg_10_0.affixItemList_, #var_10_0 + 1, -1 do
		arg_10_0.affixItemList_[iter_10_0]:Dispose()

		arg_10_0.affixItemList_[iter_10_0] = nil
	end

	for iter_10_1 = 1, #var_10_0 do
		arg_10_0.affixItemList_[iter_10_1] = arg_10_0.affixItemList_[iter_10_1] or EquipSeizureAffixItem.New(arg_10_0.affixItem_, arg_10_0.affixParent_)

		arg_10_0.affixItemList_[iter_10_1]:SetData(var_10_0[iter_10_1])
	end

	arg_10_0:AddTimer()
	arg_10_0:AddRefreshTimer()
	arg_10_0:CheckMail()
end

function var_0_0.CheckMail(arg_11_0)
	if PlayerData:GetUnclaimed(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.EQUIP_SEIZURE) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function()
				PlayerAction.ReadUnclaimedMessage(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.EQUIP_SEIZURE)
			end
		})
	end
end

function var_0_0.AddTimer(arg_13_0)
	arg_13_0:StopTimer()

	arg_13_0.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:GetAffixRefreshTimestamp(), nil, true))
	arg_13_0.timer_ = Timer.New(function()
		arg_13_0.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:GetAffixRefreshTimestamp(), nil, true))
	end, 1, -1)

	arg_13_0.timer_:Start()
end

function var_0_0.StopTimer(arg_15_0)
	if arg_15_0.timer_ then
		arg_15_0.timer_:Stop()

		arg_15_0.timer_ = nil
	end
end

function var_0_0.AddRefreshTimer(arg_16_0)
	arg_16_0:StopRefreshTimer()

	arg_16_0.refreshText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:NextRefreshTimestamp(), nil, true))
	arg_16_0.refreshTimer_ = Timer.New(function()
		arg_16_0.refreshText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:NextRefreshTimestamp(), nil, true))
	end, 1, -1)

	arg_16_0.refreshTimer_:Start()
end

function var_0_0.StopRefreshTimer(arg_18_0)
	if arg_18_0.refreshTimer_ then
		arg_18_0.refreshTimer_:Stop()

		arg_18_0.refreshTimer_ = nil
	end
end

return var_0_0
