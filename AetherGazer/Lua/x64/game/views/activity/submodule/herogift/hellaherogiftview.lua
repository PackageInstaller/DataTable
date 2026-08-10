local var_0_0 = class("HellaHeroGiftView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/HellaUI/HellaHeroGiftUI"
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

	arg_4_0.receivedController = ControllerUtil.GetController(arg_4_0.transform_, "recevied")
	arg_4_0.item = CommonItem.New(arg_4_0.m_item)
	arg_4_0.item2 = CommonItem.New(arg_4_0.m_item2)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_btn, nil, function()
		if ActivityData:GetActivityIsOpen(arg_5_0.activity_id) then
			HeroGiftAction.QueryReceiveHeroGift(arg_5_0.activity_id)
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activity_id = ActivityConst.HELLA_HERO_GIFT

	arg_8_0:Refresh()

	if ActivityData:GetActivityIsOpen(arg_8_0.activity_id) then
		arg_8_0.timer = Timer.New(function()
			arg_8_0:OnTimerEvent()
		end, 1, -1)

		arg_8_0.timer:Start()
	end

	arg_8_0:OnTimerEvent()
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()

	if arg_10_0.timer then
		arg_10_0.timer:Stop()

		arg_10_0.timer = nil
	end
end

function var_0_0.OnTimerEvent(arg_11_0)
	local var_11_0 = ActivityData:GetActivityData(arg_11_0.activity_id)

	if var_11_0 and var_11_0:IsActivitying() then
		arg_11_0.m_timeLab.text = manager.time:GetLostTimeStr(var_11_0.stopTime)
	else
		arg_11_0.m_timeLab.text = GetTips("TIME_OVER")
	end
end

function var_0_0.Refresh(arg_12_0)
	if HeroGiftData:GetReceiveHeroGift(arg_12_0.activity_id) == 0 then
		arg_12_0.receivedController:SetSelectedIndex(0)
	else
		arg_12_0.receivedController:SetSelectedIndex(1)
	end

	local var_12_0 = ActivityHeroGiftCfg[arg_12_0.activity_id]

	if var_12_0 then
		arg_12_0:RefreshItem(var_12_0.reward[1], arg_12_0.item)
		arg_12_0:RefreshItem(var_12_0.reward[2], arg_12_0.item2)
	end
end

function var_0_0.RefreshItem(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 then
		arg_13_2:RefreshData(formatReward(arg_13_1))
		arg_13_2:RegistCallBack(function()
			ShowPopItem(POP_ITEM, arg_13_1)
		end)
		arg_13_2:Show(true)
	else
		arg_13_2:Show(false)
	end
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)

	if arg_15_0.item then
		arg_15_0.item:Dispose()

		arg_15_0.item = nil
	end

	if arg_15_0.item2 then
		arg_15_0.item2:Dispose()

		arg_15_0.item2 = nil
	end
end

function var_0_0.OnHeroGiftReward(arg_16_0)
	arg_16_0:Refresh()
end

return var_0_0
