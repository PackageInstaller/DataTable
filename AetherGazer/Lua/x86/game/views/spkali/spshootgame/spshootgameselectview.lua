local var_0_0 = class("SpShootGameSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_kailistartUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.activity_id = arg_6_0.params_ and arg_6_0.params_.activityID or ActivityConst.ACTIVITY_3_6_KALI_SHOOTGAME
	arg_6_0.remainTime = ActivityData:GetActivityRefreshTime(arg_6_0.params_.activityID)

	local var_6_0 = arg_6_0:GetNextrefreshTime()

	arg_6_0.texttimeText_.text = string.format(GetTips("TIME_DISPLAY_9"), manager.time:GetLostTimeStrWith2Unit(var_6_0))

	arg_6_0:UpdateTxt()

	arg_6_0.updateTimer_ = Timer.New(function()
		local var_7_0 = arg_6_0:GetNextrefreshTime()

		arg_6_0.texttimeText_.text = string.format(GetTips("TIME_DISPLAY_9"), manager.time:GetLostTimeStrWith2Unit(var_7_0))
	end, 1, -1, 1)

	arg_6_0.updateTimer_:Start()
end

function var_0_0.GetNextrefreshTime(arg_8_0)
	return manager.time:GetZeroTime() + REFRESH_CLOCK
end

function var_0_0.OnTop(arg_9_0)
	arg_9_0:RefreshBar()
end

function var_0_0.UpdateTxt(arg_10_0)
	local var_10_0 = SpShooGameData:GetActivityData(arg_10_0.activity_id)

	arg_10_0.textnum01Text_.text = SpKaliTool.GetNumDes(SpKaliTool.GetShootReward1NowAndMax(arg_10_0.activity_id))
	arg_10_0.textnum02Text_.text = SpKaliTool.GetNumDes(SpKaliTool.GetShootReward2NowAndMax(arg_10_0.activity_id))
	arg_10_0.icon3Img_.sprite = ItemTools.getItemSprite(SpKaliConst.ItemConst.coinID1)
	arg_10_0.icon4Img_.sprite = ItemTools.getItemSprite(SpKaliConst.ItemConst.coinID2)
end

function var_0_0.OnUpdateSkillInfo(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.skillIcon) do
		iter_11_1.fillAmount = arg_11_1[iter_11_0] or 1
	end
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
	arg_12_0:RemoveAllEventListener()

	if arg_12_0.updateTimer_ then
		arg_12_0.updateTimer_:Stop()

		arg_12_0.updateTimer_ = nil
	end
end

function var_0_0.RefreshBar(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		SpKaliConst.ItemConst.coinID1,
		SpKaliConst.ItemConst.coinID2
	})
	manager.windowBar:SetBarCanClick(SpKaliConst.ItemConst.coinID1, true)
	manager.windowBar:SetBarCanClick(SpKaliConst.ItemConst.coinID2, true)
	manager.windowBar:RegistBackCallBack(function()
		LuaExchangeHelper.GoToMain()
		DestroyLua()
	end)
end

function var_0_0.RegisterEvents(arg_15_0)
	return
end

function var_0_0.AddUIListener(arg_16_0)
	arg_16_0:AddBtnListener(arg_16_0.btnstartBtn_, nil, function()
		SpShootGameBridge.StartGameUI()
	end)
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
