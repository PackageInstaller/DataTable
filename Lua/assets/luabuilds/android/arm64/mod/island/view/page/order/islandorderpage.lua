local var_0_0 = class("IslandOrderPage", import("...base.IslandBasePage"))

var_0_0.ON_UPDADE = "IslandOrderPage:ON_UPDADE"

function var_0_0.getUIName(arg_1_0)
	return "IslandOrderUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.backBtn = arg_2_0._tf:Find("top/back")
	arg_2_0.favorBtn = arg_2_0._tf:Find("top/favor_bg")
	arg_2_0.levelTxt = arg_2_0._tf:Find("top/favor_bg/level"):GetComponent(typeof(Text))
	arg_2_0.expTxt = arg_2_0._tf:Find("top/favor_bg/Text"):GetComponent(typeof(Text))
	arg_2_0.charTr = arg_2_0._tf:Find("bottom/char")
	arg_2_0.chatTxt = arg_2_0.charTr:Find("dialogue/Text"):GetComponent(typeof(Text))
	arg_2_0.trendBtn = arg_2_0._tf:Find("trend_btn")
	arg_2_0.trendIco = arg_2_0.trendBtn:Find("difficulty"):GetComponent(typeof(Image))
	arg_2_0.trendTxt = arg_2_0.trendBtn:Find("Text"):GetComponent(typeof(Text))
	arg_2_0.orderContainer = arg_2_0._tf:Find("map")
	arg_2_0.upgradePage = IslandOrderUpgradePage.New(arg_2_0._parentTf)
	arg_2_0.countTxt = arg_2_0._tf:Find("count_bg/Text"):GetComponent(typeof(Text))
	arg_2_0.orderTplPool = OrderTplPool.New(arg_2_0._tf:Find("root/orderTpl"), 3, 6)
	arg_2_0.orderTpls = {}
	arg_2_0.timers = {}
	arg_2_0.disappearTimers = {}

	setActive(arg_2_0.charTr, false)
	setText(arg_2_0._tf:Find("top/title/Text"), i18n("island_order_title"))

	return
end

function var_0_0.OnHide(arg_3_0)
	if arg_3_0.upgradePage:GetLoaded() then
		arg_3_0.upgradePage:Destroy()
		arg_3_0.upgradePage:Reset()
	end

	return
end

function var_0_0.OnInit(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf:Find("top/title/help"), function()
		arg_4_0:ShowMsgBox({
			type = IslandMsgBox.TYPE_WHITOUT_BTN,
			content = i18n("island_helpbtn_order")
		})

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.backBtn, function()
		arg_4_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.favorBtn, function()
		arg_4_0:OpenPage(IslandOrderLevelInfoPage)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.trendBtn, function()
		arg_4_0:ShowMsgBox({
			type = IslandMsgBox.TYPE_ORDER_TENDENCY,
			title = i18n("island_order_difficulty"),
			selected = getProxy(IslandProxy):GetIsland():GetOrderAgency():GetTendency(),
			onYes = function(arg_9_0)
				arg_4_0:emit(IslandMediator.SET_ORDER_TENDENCY, arg_9_0)

				return
			end
		})

		return
	end, SFX_PANEL)
	arg_4_0:UpdateFavorBtn()

	return
end

function var_0_0.UpdateFavorBtn(arg_10_0)
	setActive(arg_10_0.favorBtn, getProxy(IslandProxy):GetIsland():GetOrderAgency():ExpSystemIsOpen())

	return
end

function var_0_0.AddListeners(arg_11_0)
	arg_11_0:AddListener(GAME.ISLAND_SUBMIT_ORDER_DONE, arg_11_0.OnSubmitOrder)
	arg_11_0:AddListener(GAME.ISLAND_REPLACE_ORDER_DONE, arg_11_0.OnReplaceOrder)
	arg_11_0:AddListener(IslandOrderAgency.GEN_NEW_ORDER, arg_11_0.OnGenNewOrder)
	arg_11_0:AddListener(IslandOrderAgency.UDPATE_ORDER, arg_11_0.OnFlushOrder)
	arg_11_0:AddListener(GAME.ISLAND_SET_ORDER_TENDENCY_DONE, arg_11_0.OnOrderTendencyChanged)
	arg_11_0:AddListener(IslandScene.ON_CHECK_ORDER_EXP_AWARD, arg_11_0.OnCheckOrderExpAward)
	arg_11_0:AddListener(var_0_0.ON_UPDADE, arg_11_0.OnUpgrade)
	arg_11_0:AddListener(IslandOrderAgency.ORDER_FINISH_UPDATE, arg_11_0.OnUpdateFinishCnt)
	arg_11_0:AddListener(GAME.ISLAND_USE_TICKET_DONE, arg_11_0.OnUseTicketDone)
	arg_11_0:AddListener(IslandAblityAgency.UNLOCK_SYSTEM, arg_11_0.OnUnlockSystem)

	return
end

function var_0_0.RemoveListeners(arg_12_0)
	arg_12_0:RemoveListener(GAME.ISLAND_SUBMIT_ORDER_DONE, arg_12_0.OnSubmitOrder)
	arg_12_0:RemoveListener(GAME.ISLAND_REPLACE_ORDER_DONE, arg_12_0.OnReplaceOrder)
	arg_12_0:RemoveListener(GAME.ISLAND_SET_ORDER_TENDENCY_DONE, arg_12_0.OnOrderTendencyChanged)
	arg_12_0:RemoveListener(IslandOrderAgency.GEN_NEW_ORDER, arg_12_0.OnGenNewOrder)
	arg_12_0:RemoveListener(IslandOrderAgency.UDPATE_ORDER, arg_12_0.OnFlushOrder)
	arg_12_0:RemoveListener(var_0_0.ON_UPDADE, arg_12_0.OnUpgrade)
	arg_12_0:RemoveListener(IslandOrderAgency.ORDER_FINISH_UPDATE, arg_12_0.OnUpdateFinishCnt)
	arg_12_0:RemoveListener(GAME.ISLAND_USE_TICKET_DONE, arg_12_0.OnUseTicketDone)
	arg_12_0:RemoveListener(IslandAblityAgency.UNLOCK_SYSTEM, arg_12_0.OnUnlockSystem)

	return
end

function var_0_0.OnUnlockSystem(arg_13_0)
	arg_13_0:UpdateFavorBtn()
	arg_13_0:CheckOrderExpAward()

	return
end

function var_0_0.OnReset(arg_14_0)
	arg_14_0:Flush()

	return
end

function var_0_0.OnUpgrade(arg_15_0, arg_15_1)
	arg_15_0.upgradePage:ExecuteAction("Show", arg_15_1.level, arg_15_1.callback)

	return
end

function var_0_0.OnOrderTendencyChanged(arg_16_0)
	arg_16_0:UpdateTrendBtn((getProxy(IslandProxy):GetIsland():GetOrderAgency()))

	return
end

function var_0_0.OnSubmitOrder(arg_17_0, arg_17_1)
	local var_17_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency()

	arg_17_0:UpdateExpPanel(var_17_0)
	arg_17_0:UpdateOrderState(arg_17_1.slotId)
	arg_17_0:UpdateCount(var_17_0)

	local var_17_1 = arg_17_0.orderTpls or {}

	for iter_17_0, iter_17_1 in pairs(var_17_1) do
		arg_17_0:UpdateOrderState(iter_17_0)
	end

	return
end

function var_0_0.OnReplaceOrder(arg_18_0, arg_18_1)
	arg_18_0:UpdateOrderState(arg_18_1.slotId)

	return
end

function var_0_0.OnGenNewOrder(arg_19_0, arg_19_1)
	arg_19_0:UpdateOrderState(arg_19_1.slotId)

	return
end

function var_0_0.OnFlushOrder(arg_20_0, arg_20_1)
	arg_20_0:UpdateOrderState(arg_20_1.slotId)

	return
end

function var_0_0.OnUseTicketDone(arg_21_0, arg_21_1)
	if arg_21_1.type == IslandUseTicketCommand.TYPES.ORDER_CD then
		arg_21_0:UpdateOrderState(arg_21_1.id)
	end

	return
end

function var_0_0.OnCheckOrderExpAward(arg_22_0)
	arg_22_0:CheckOrderExpAward()

	return
end

function var_0_0.OnUpdateFinishCnt(arg_23_0)
	local var_23_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency()

	arg_23_0:UpdateCount(var_23_0)
	arg_23_0:UpdateExpPanel(var_23_0)

	return
end

function var_0_0.Show(arg_24_0)
	var_0_0.super.Show(arg_24_0)
	arg_24_0:Flush()

	return
end

function var_0_0.Flush(arg_25_0)
	local var_25_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency()

	arg_25_0:UpdateExpPanel(var_25_0)
	arg_25_0:GenOrderList(var_25_0)
	arg_25_0:TriggerOrder(var_25_0)
	arg_25_0:UpdateTrendBtn(var_25_0)
	arg_25_0:UpdateCount(var_25_0)
	arg_25_0:CheckOrderExpAward()

	return
end

function var_0_0.UpdateCount(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1:GetMaxFinishCount()

	arg_26_0.countTxt.text = i18n("island_order_leftCnt_tip") .. var_26_0 - arg_26_1:GetFinishCnt() .. "/" .. var_26_0

	return
end

function var_0_0.UpdateTrendBtn(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1:GetTendency()

	arg_27_0.trendTxt.text = IslandOrderSlot.TENDENCY2CN(var_27_0)
	arg_27_0.trendIco.sprite = GetSpriteFromAtlas("ui/IslandOrderUI_atlas", ({
		"icon_common",
		"icon_easy",
		"icon_hard"
	})[var_27_0 + 1])

	return
end

function var_0_0.CheckOrderExpAward(arg_28_0)
	local var_28_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency()

	if not var_28_0:ExpSystemIsOpen() then
		arg_28_0:CheckGuide()

		return
	end

	for iter_28_0, iter_28_1 in ipairs((var_28_0:GetAllCanGetAwardList())) do
		table.insert({}, function(arg_29_0)
			arg_28_0:emit(IslandMediator.ON_GET_ORDER_EXP_AWARD, iter_28_1, arg_29_0)

			return
		end)
	end

	seriesAsync({}, function()
		arg_28_0:CheckGuide()

		return
	end)

	return
end

function var_0_0.CheckGuide(arg_31_0)
	if getProxy(IslandProxy):GetIsland():GetTaskAgency():GetTask(IslandGuideChecker.ORDER_TASK_ID) then
		onDelayTick(function()
			local var_32_0 = getProxy(IslandProxy):GetIsland():GetInventoryAgency()

			if underscore.all(IslandGuideChecker.ORDER_NEED_ITEMS, function(arg_33_0)
				return var_32_0:GetOwnCount(arg_33_0[1]) >= arg_33_0[2]
			end) then
				local var_32_1 = {
					1,
					2
				}

				if not {
					1,
					2
				} then
					var_32_1 = {
						1,
						3
					}
				end

				IslandGuideChecker.CheckGuideWithArgs("ISLAND_GUIDE_7", IslandGuideChecker.FINISH_TYPE.ON_GUIDE, nil, var_32_1)

				return
			end
		end, 0.2)
	end

	return
end

function var_0_0.TriggerOrder(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1:GetSlots()
	local var_34_1 = var_34_0[arg_34_1:GetCacheSelectedId()]

	if var_34_1 and not var_34_1:IsEmpty() then
		if arg_34_0.orderTpls[var_34_1.id] then
			triggerButton(arg_34_0.orderTpls[var_34_1.id])
		end
	else
		local var_34_2

		for iter_34_0, iter_34_1 in pairs(var_34_0) do
			if not iter_34_1:IsEmpty() then
				var_34_2 = iter_34_1

				break
			end
		end

		if var_34_2 then
			if arg_34_0.orderTpls[var_34_2.id] then
				triggerButton(arg_34_0.orderTpls[var_34_2.id])
			end
		end
	end

	return
end

function var_0_0.GenOrderList(arg_35_0, arg_35_1)
	arg_35_0:ReturnOrderTplList()

	for iter_35_0, iter_35_1 in pairs((arg_35_1:GetSlots())) do
		arg_35_0:NewOrderTpl(iter_35_1.id)
		arg_35_0:UpdateOrderState(iter_35_1.id)
	end

	return
end

function var_0_0.NewOrderTpl(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0.orderTplPool:Dequeue()

	setParent(var_36_0, arg_36_0.orderContainer)

	arg_36_0.orderTpls[arg_36_1] = var_36_0

	return var_36_0
end

function var_0_0.ReturnOrderTplList(arg_37_0)
	for iter_37_0, iter_37_1 in pairs(arg_37_0.orderTpls) do
		arg_37_0.orderTplPool:Enqueue(iter_37_1)
	end

	arg_37_0.orderTpls = {}

	return
end

function var_0_0.UpdateOrderState(arg_38_0, arg_38_1)
	local var_38_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency():GetSlot(arg_38_1)
	local var_38_1 = arg_38_0.orderTpls[arg_38_1] or arg_38_0:NewOrderTpl(arg_38_1)

	arg_38_0:RemoveLoadingTimer(arg_38_1)
	arg_38_0:RemoveDisappearTimer(arg_38_1)
	arg_38_0:ShowDiaglog(var_38_0)

	if not var_38_0 or var_38_0:IsEmpty() then
		removeOnButton(var_38_1)
		setActive(var_38_1, false)

		return
	end

	var_38_1.transform.localPosition = var_38_0:GetPosition()

	setActive(var_38_1, true)
	onButton(arg_38_0, var_38_1, function()
		arg_38_0:ClickOrder(var_38_1, var_38_0)

		arg_38_0.selected = var_38_1

		return
	end, SFX_PANEL)

	local var_38_2 = var_38_0:GetOrder()

	setActive(var_38_1.transform:Find("bg_urgent"), var_38_2:IsUrgency())
	setActive(var_38_1.transform:Find("bg_act"), var_38_2:IsActivity())

	local var_38_3 = arg_38_0.selected and arg_38_0.selected == var_38_1

	setActive(var_38_1.transform:Find("sel"), var_38_3)
	setActive(var_38_1.transform:Find("finish"), (var_38_0:CanSubmit()))
	setActive(var_38_1.transform:Find("easy"), var_38_2:GetTendency() == IslandOrderSlot.TENDENCY_TYPE_EASY)
	setActive(var_38_1.transform:Find("hard"), var_38_2:GetTendency() == IslandOrderSlot.TENDENCY_TYPE_HARD)

	local var_38_4 = var_38_0:IsLoading()

	setActive(var_38_1.transform:Find("icon"), not var_38_4)
	setActive(var_38_1.transform:Find("loading"), var_38_4)
	setActive(var_38_1.transform:Find("bg/progress"), not var_38_4)
	GetImageSpriteFromAtlasAsync("island/IslandShipIcon/" .. var_38_2:GetRoleIcon(), "", var_38_1.transform:Find("icon"))

	if var_38_4 then
		arg_38_0:AddLoadingTimer(var_38_1, var_38_0)
	end

	if var_38_2:IsUrgency() then
		arg_38_0:AddDisappearTimer(var_38_1, var_38_0)
	end

	return
end

function var_0_0.AddDisappearTimer(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0:RemoveDisappearTimer(arg_40_2.id)

	if arg_40_2:GetDisappearTime() <= pg.TimeMgr.GetInstance():GetServerTime() then
		return
	end

	arg_40_0.disappearTimers[arg_40_2.id] = Timer.New(function()
		local var_41_9000
		local var_41_0 = var_0 - pg.TimeMgr.GetInstance().GetServerTime(var_41_9000)

		setText(arg_40_1.transform:Find("bg_urgent/time_label/Text"), (pg.TimeMgr.GetInstance():DescCDTime(var_41_0)))

		if var_41_0 < 0 then
			arg_40_0:UpdateOrderState(arg_40_2.id)
		end

		return
	end, 1, -1)

	arg_40_0.disappearTimers[arg_40_2.id].func()
	arg_40_0.disappearTimers[arg_40_2.id]:Start()

	return
end

function var_0_0.RemoveDisappearTimer(arg_42_0, arg_42_1)
	if arg_42_0.disappearTimers[arg_42_1] then
		arg_42_0.disappearTimers[arg_42_1]:Stop()

		arg_42_0.disappearTimers[arg_42_1] = nil
	end

	return
end

function var_0_0.ClickOrder(arg_43_0, arg_43_1, arg_43_2)
	arg_43_0:OpenPage(IslandOrderDescPage, arg_43_2)
	arg_43_0:ShowDiaglog(arg_43_2)
	getProxy(IslandProxy):GetIsland():GetOrderAgency():SetCacheSelectedId(arg_43_2.id)

	if arg_43_0.selected then
		setActive(arg_43_0.selected.transform:Find("sel"), false)
	end

	setActive(arg_43_1.transform:Find("sel"), true)

	return
end

function var_0_0.ShowDiaglog(arg_44_0, arg_44_1)
	if not arg_44_1 or not arg_44_1:GetOrder() or arg_44_1:IsEmpty() or arg_44_1:IsLoading() then
		setActive(arg_44_0.charTr, false)

		return
	end

	local var_44_0 = arg_44_1:GetOrder()

	setActive(arg_44_0.charTr, true)
	GetImageSpriteFromAtlasAsync("island/IslandShipIconHalf/" .. var_44_0:GetRoleIcon(), "", arg_44_0.charTr)

	arg_44_0.chatTxt.text = var_44_0:GetDesc()

	return
end

function var_0_0.AddLoadingTimer(arg_45_0, arg_45_1, arg_45_2)
	local function var_45_0()
		arg_45_0:UpdateOrderState(arg_45_2.id)

		return
	end

	local var_45_1 = arg_45_2:GetCanSubmitTime()
	local var_45_2 = arg_45_2:GetTotalTime()
	local var_45_3 = Timer.New(function()
		local var_47_0 = var_45_1 - pg.TimeMgr.GetInstance():GetServerTime()

		setText(arg_45_1.transform:Find("loading/time_label/Text"), pg.TimeMgr.GetInstance():DescCDTime(var_47_0))
		setFillAmount(arg_45_1.transform:Find("loading/progress"), 1 - var_47_0 / var_45_2)

		if var_47_0 <= 0 then
			var_45_0()
		end

		return
	end, 1, -1)

	var_45_3:Start()
	var_45_3.func()

	arg_45_0.timers[arg_45_2.id] = var_45_3

	return
end

function var_0_0.RemoveLoadingTimer(arg_48_0, arg_48_1)
	if arg_48_0.timers[arg_48_1] then
		arg_48_0.timers[arg_48_1]:Stop()

		arg_48_0.timers[arg_48_1] = nil
	end

	return
end

function var_0_0.RemoveAllLoadingTimer(arg_49_0)
	for iter_49_0, iter_49_1 in pairs(arg_49_0.timers) do
		iter_49_1:Stop()
	end

	for iter_49_2, iter_49_3 in pairs(arg_49_0.disappearTimers) do
		iter_49_3:Stop()
	end

	arg_49_0.disappearTimers = {}
	arg_49_0.timers = {}

	return
end

function var_0_0.UpdateExpPanel(arg_50_0, arg_50_1)
	arg_50_0.levelTxt.text = arg_50_1:GetLevel()
	arg_50_0.expTxt.text = arg_50_1:IsMaxLevel() and "MAX" or arg_50_1:GetExp() .. "/" .. math.max(1, arg_50_1:GetNextTargetExp())

	return
end

function var_0_0.OnDestroy(arg_51_0)
	if arg_51_0.upgradePage:GetLoaded() then
		arg_51_0.upgradePage:Destroy()

		arg_51_0.upgradePage = nil
	end

	if arg_51_0.orderTplPool then
		arg_51_0.orderTplPool:Dispose()

		arg_51_0.orderTplPool = nil
	end

	arg_51_0:RemoveAllLoadingTimer()

	return
end

return var_0_0
