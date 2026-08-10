local var_0_0 = class("ActivityPtView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityPtTools.GetMainUIName(arg_1_0.params_.activityID)
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

	arg_5_0.indexController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "index")
	arg_5_0.btns_ = {}
	arg_5_0.selectedControllers_ = {}

	for iter_5_0, iter_5_1 in ipairs(ActivityPtRepeatCfg.get_id_list_by_activity_id[arg_5_0.params_.activityID]) do
		table.insert(arg_5_0.btns_, arg_5_0["btn" .. iter_5_0 .. "_"])
		table.insert(arg_5_0.selectedControllers_, ControllerUtil.GetController(arg_5_0["btn" .. iter_5_0 .. "_"].transform, "status"))
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0.indexController_:AddSelectChangeListener(function(arg_7_0)
		arg_6_0:SelectIndex(arg_7_0)
	end)
	arg_6_0:AddBtnListener(arg_6_0.exchangeBtn_, nil, function()
		if arg_6_0:IsOpenSectionView() then
			JumpTools.Back()
			arg_6_0.indexController_:SetSelectedIndex(0)
		end

		local var_8_0 = ActivityShopCfg[arg_6_0.params_.activityID]
		local var_8_1 = {}

		for iter_8_0, iter_8_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[var_8_0.activity_theme]) do
			local var_8_2 = ActivityShopCfg[iter_8_1].shop_id
			local var_8_3 = ActivityData:GetActivityData(ShopListCfg[var_8_2].activity_id)

			if var_8_3 and var_8_3:IsActivitying() then
				table.insert(var_8_1, ActivityShopCfg[iter_8_1].shop_id)
			end
		end

		local var_8_4, var_8_5 = ShopTools.IsShopOpen(var_8_0.shop_id)

		if var_8_4 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = var_8_0.shop_id,
				showShops = var_8_1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_8_5 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_8_5 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.btns_) do
		arg_6_0:AddBtnListener(iter_6_1, nil, function()
			if not ActivityData:GetActivityData(arg_6_0.params_.activityID):IsActivitying() then
				ShowTips("SOLO_TIME_OVER")

				return
			end

			arg_6_0:EnterLevel(iter_6_0)
		end)
	end

	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		if arg_6_0:IsOpenSectionView() then
			JumpTools.Back()
			arg_6_0.indexController_:SetSelectedIndex(0)
		end
	end)

	if arg_6_0.eventTrigger_ then
		arg_6_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_11_0, arg_11_1)
			if arg_6_0:IsOpenSectionView() then
				JumpTools.Back()
			end

			arg_6_0.drag_ = true
		end))
		arg_6_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_12_0, arg_12_1)
			arg_6_0.drag_ = false
		end))
	end
end

function var_0_0.SelectIndex(arg_13_0, arg_13_1)
	if arg_13_1 == 0 then
		-- block empty
	end
end

function var_0_0.EnterLevel(arg_14_0, arg_14_1)
	arg_14_0.indexController_:SetSelectedIndex(arg_14_1)

	local var_14_0 = ActivityPtRepeatCfg.get_id_list_by_activity_id[arg_14_0.params_.activityID][arg_14_1]
	local var_14_1 = ActivityPtRepeatCfg[var_14_0].stage_id

	JumpTools.OpenPageByJump("activityPtSectionInfo", {
		index = arg_14_1,
		section = var_14_1,
		sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_GAME,
		activityID = arg_14_0.params_.activityID,
		repeat_id = var_14_0
	})
end

function var_0_0.AddEventListeners(arg_15_0)
	return
end

function var_0_0.OnTop(arg_16_0)
	arg_16_0:UpdateBar()
	arg_16_0.indexController_:SetSelectedIndex(0)
end

function var_0_0.OnBehind(arg_17_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:RegistBackCallBack(function()
		if arg_18_0:IsOpenSectionView() then
			JumpTools.Back()
			arg_18_0.indexController_:SetSelectedIndex(0)
		else
			JumpTools.Back()
		end
	end)

	local var_18_0 = ActivityPtTools.GetHelpKey(arg_18_0.params_.activityID)

	manager.windowBar:SetGameHelpKey(var_18_0)
end

function var_0_0.OnEnter(arg_20_0)
	if not arg_20_0.activityID_ or arg_20_0.activityID_ ~= arg_20_0.params_.activityID then
		arg_20_0.activityID_ = arg_20_0.params_.activityID

		arg_20_0:ReLoad()
	end

	arg_20_0:AddEventListeners()
	arg_20_0:PlayEnterVoice()
	saveData("activity_pt_" .. arg_20_0.params_.activityID, "opened", 1)

	local var_20_0 = RedPointConst.SUMMER_ACTIVITY_PT_OPEN .. "_" .. arg_20_0.params_.activityID

	manager.redPoint:setTip(var_20_0, 0)

	if arg_20_0.params_.index then
		arg_20_0.indexController_:SetSelectedIndex(arg_20_0.params_.index)
	end

	arg_20_0:RefreshTime()

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.selectedControllers_) do
		local var_20_1 = ActivityPtRepeatCfg.get_id_list_by_activity_id[arg_20_0.params_.activityID][iter_20_0]

		if SummerActivityPtData:GetLevelChallengeCount(var_20_1) > 0 then
			iter_20_1:SetSelectedIndex(1)
		else
			iter_20_1:SetSelectedIndex(0)
		end
	end
end

function var_0_0.ReLoad(arg_21_0)
	if arg_21_0.gameObject_ then
		arg_21_0:Dispose()
		Object.Destroy(arg_21_0.gameObject_)
	end

	local var_21_0 = Asset.Load(arg_21_0:UIName())

	arg_21_0.gameObject_ = Object.Instantiate(var_21_0, arg_21_0:UIParent())
	arg_21_0.transform_ = arg_21_0.gameObject_.transform

	arg_21_0:Init()
end

function var_0_0.PlayEnterVoice(arg_22_0)
	local var_22_0, var_22_1, var_22_2, var_22_3 = ActivityPtTools.GetEnterVoice(arg_22_0.params_.activityID)

	if var_22_0 then
		manager.audio:PlayEffect(var_22_1, var_22_2, var_22_3)
	end
end

function var_0_0.RefreshTime(arg_23_0)
	local var_23_0
	local var_23_1 = manager.time:GetServerTime()
	local var_23_2 = ActivityData:GetActivityData(arg_23_0.params_.activityID)
	local var_23_3 = var_23_2.startTime
	local var_23_4 = var_23_2.stopTime
	local var_23_5 = ActivityShopCfg[arg_23_0.params_.activityID].shop_id
	local var_23_6 = ActivityData:GetActivityData(ShopListCfg[var_23_5].activity_id).stopTime
	local var_23_7 = var_23_6 - var_23_1

	arg_23_0:StopTimer()

	if var_23_1 < var_23_3 and var_23_2:IsActivitying() == false then
		arg_23_0.timeLabel_.text = GetTips("SOLO_NOT_OPEN")
		arg_23_0.timer_ = Timer.New(function()
			var_23_0 = var_23_3 - manager.time:GetServerTime()

			if var_23_0 <= 0 then
				arg_23_0:StopTimer()
				arg_23_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_23_0.timer_:Start()
	elseif var_23_1 < var_23_4 or var_23_1 < var_23_6 then
		if var_23_1 < var_23_4 then
			arg_23_0.timeLabel_.text = manager.time:GetLostTimeStr2(var_23_4)
		else
			arg_23_0.timeLabel_.text = GetTips("TIME_OVER")
		end

		if arg_23_0.shopTimeGo_ then
			if var_23_7 <= GameSetting.time_remaining_show.value[1] * 86400 then
				arg_23_0.shopTimeLabel_.text = manager.time:GetLostTimeStr2(var_23_6)

				SetActive(arg_23_0.shopTimeGo_, true)
			else
				SetActive(arg_23_0.shopTimeGo_, false)
			end
		end

		arg_23_0.timer_ = Timer.New(function()
			var_23_1 = manager.time:GetServerTime()
			var_23_0 = var_23_4 - var_23_1
			var_23_7 = var_23_6 - var_23_1

			if var_23_0 <= 0 and var_23_7 <= 0 then
				arg_23_0:StopTimer()
				arg_23_0:RefreshTime()

				return
			end

			if var_23_1 < var_23_4 then
				arg_23_0.timeLabel_.text = manager.time:GetLostTimeStr2(var_23_4)
			else
				arg_23_0.timeLabel_.text = GetTips("TIME_OVER")
			end

			if arg_23_0.shopTimeGo_ then
				if var_23_7 <= GameSetting.time_remaining_show.value[1] * 86400 then
					arg_23_0.shopTimeLabel_.text = manager.time:GetLostTimeStr2(var_23_6)

					SetActive(arg_23_0.shopTimeGo_, true)
				else
					SetActive(arg_23_0.shopTimeGo_, false)
				end
			end
		end, 1, -1)

		arg_23_0.timer_:Start()
	else
		arg_23_0.timeLabel_.text = GetTips("TIME_OVER")
		arg_23_0.shopTimeLabel_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.StopTimer(arg_26_0)
	if arg_26_0.timer_ then
		arg_26_0.timer_:Stop()

		arg_26_0.timer_ = nil
	end
end

function var_0_0.OnExit(arg_27_0)
	arg_27_0:StopTimer()
	manager.audio:Stop("effect")
	arg_27_0.indexController_:SetSelectedState(-1)
	arg_27_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.OnMainHomeViewTop(arg_28_0)
	return
end

function var_0_0.IsOpenSectionView(arg_29_0)
	return arg_29_0:IsOpenRoute("activityPtSectionInfo")
end

function var_0_0.Dispose(arg_30_0)
	var_0_0.super.Dispose(arg_30_0)
end

return var_0_0
