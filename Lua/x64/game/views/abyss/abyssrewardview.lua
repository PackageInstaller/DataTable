local var_0_0 = class("AbyssRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Abyss/AbyssRewardUI"
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

	arg_5_0.ispassController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "ispass")
	arg_5_0.empty1Controller_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "empty1")
	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.list_, AbyssRewardItemView)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.idList_[arg_6_1]
	local var_6_1 = AbyssCfg[var_6_0]

	arg_6_2:SetData(arg_6_1, var_6_1.level)
end

function var_0_0.OnAbyssRefresh(arg_7_0)
	JumpTools.OpenPageByJump("/abyssMain", {
		refresh = true
	})
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.receiveallBtn_, nil, function()
		local var_9_0 = AbyssData:GetCanGetLayers()

		if #var_9_0 > 0 then
			AbyssAction.GetLayerBonus(var_9_0)
		end
	end)
end

function var_0_0.AddEventListeners(arg_10_0)
	arg_10_0:RegistEventListener(ABYSS_LAYER_BONUS_GET, function(arg_11_0)
		arg_10_0:UpdateView()
	end)
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_0.OnBehind(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0:AddEventListeners()
	arg_15_0:UpdateView()
	arg_15_0:StartTimer()
	arg_15_0:OnTimer()
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:RemoveAllEventListener()
	arg_16_0:StopTimer()
	manager.windowBar:HideBar()
end

function var_0_0.StartTimer(arg_17_0)
	if arg_17_0.timer_ == nil then
		arg_17_0.timer_ = Timer.New(function()
			arg_17_0:OnTimer()
		end, 1, -1)
	end

	arg_17_0.timer_:Start()
end

function var_0_0.OnTimer(arg_19_0)
	arg_19_0.timeLabel_.text = manager.time:GetLostTimeStr(AbyssData:GetRefreshTimestamp(), nil, true)
end

function var_0_0.StopTimer(arg_20_0)
	if arg_20_0.timer_ then
		arg_20_0.timer_:Stop()

		arg_20_0.timer_ = nil
	end
end

function var_0_0.UpdateView(arg_21_0)
	arg_21_0:UpdateList()

	arg_21_0.passLabel_.text = GetI18NText(AbyssData:GetMaxLayer())

	if #AbyssData:GetCanGetLayers() > 0 then
		arg_21_0.ispassController_:SetSelectedState("true")
	else
		arg_21_0.ispassController_:SetSelectedState("noreward")
	end
end

function var_0_0.UpdateList(arg_22_0)
	arg_22_0.idList_ = {}

	table.insertto(arg_22_0.idList_, AbyssData:GetCurrentIdList(), 1)
	table.sort(arg_22_0.idList_, function(arg_23_0, arg_23_1)
		local var_23_0 = arg_22_0:GetBonusStatus(arg_23_0)
		local var_23_1 = arg_22_0:GetBonusStatus(arg_23_1)

		if var_23_0 ~= var_23_1 then
			return var_23_0 < var_23_1
		end

		return arg_23_0 < arg_23_1
	end)

	if AbyssData:GetMaxLayer() > 0 then
		arg_22_0.empty1Controller_:SetSelectedState("normal")
	else
		arg_22_0.empty1Controller_:SetSelectedState("empty")
	end

	arg_22_0.uiList_:StartScroll(#arg_22_0.idList_)
end

function var_0_0.GetBonusStatus(arg_24_0, arg_24_1)
	local var_24_0 = AbyssCfg[arg_24_1].level

	if AbyssData:IsLayerBonusGet(var_24_0) then
		return 3
	elseif var_24_0 <= AbyssData:GetMaxLayer() then
		return 1
	else
		return 2
	end
end

function var_0_0.OnMainHomeViewTop(arg_25_0)
	return
end

function var_0_0.Dispose(arg_26_0)
	if arg_26_0.uiList_ then
		arg_26_0.uiList_:Dispose()

		arg_26_0.uiList_ = nil
	end

	arg_26_0:StopTimer()
	var_0_0.super.Dispose(arg_26_0)
end

return var_0_0
