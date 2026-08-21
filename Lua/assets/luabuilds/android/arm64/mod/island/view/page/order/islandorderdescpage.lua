local var_0_0 = class("IslandOrderDescPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandOrderDescUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.infoPanel = arg_2_0._tf:Find("info")
	arg_2_0.nameTxt = arg_2_0._tf:Find("info/name/Text"):GetComponent(typeof(Text))
	arg_2_0.consumeUIList = UIItemList.New(arg_2_0._tf:Find("info/subtitle_item/list"), arg_2_0._tf:Find("info/subtitle_item/list/tpl"))
	arg_2_0.awardUIList = UIItemList.New(arg_2_0._tf:Find("info/subtitle_reward/list"), arg_2_0._tf:Find("info/subtitle_reward/list/tpl"))
	arg_2_0.submitBtn = arg_2_0._tf:Find("info/btns/submit")
	arg_2_0.submitBtnMark = arg_2_0._tf:Find("info/btns/submit/mask")
	arg_2_0.replaceBtn = arg_2_0._tf:Find("info/btns/cancel")
	arg_2_0.speedUpBtn = arg_2_0._tf:Find("loading/submit")
	arg_2_0.loadingPanel = arg_2_0._tf:Find("loading")
	arg_2_0.loadingTimeTxt = arg_2_0.loadingPanel:Find("Text/time"):GetComponent(typeof(Text))

	setText(arg_2_0._tf:Find("info/btns/cancel/Text"), i18n("island_word_turndown"))
	setText(arg_2_0._tf:Find("info/btns/submit/Text"), i18n("island_word_sbumit"))
	setText(arg_2_0._tf:Find("loading/Text"), i18n("island_order_cd_tip"))
	setText(arg_2_0._tf:Find("loading/submit/Text"), i18n("island_word_speedup"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.replaceBtn, function()
		arg_3_0:emit(IslandMediator.ON_REPLACE_ORDER, arg_3_0.slot.id)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.submitBtn, function()
		local var_5_9000
		local var_5_0, var_5_1 = getProxy(IslandProxy):GetIsland():GetOrderAgency():CanSubmitOrder()

		if not var_5_0 then
			local var_5_2 = pg.TimeMgr.GetInstance()

			pg.TipsMgr.GetInstance().ShowTips(var_5_2, i18n("island_submit_order_cd_tip", (pg.TimeMgr.GetInstance():DescCDTime(var_5_1 - var_5_2.GetServerTime(var_5_9000)))))

			return
		end

		arg_3_0:emit(IslandMediator.ON_SUBMIT_ORDER, arg_3_0.slot.id)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.speedUpBtn, function()
		arg_3_0:OpenPage(IslandTicketUsePage, IslandUseTicketCommand.TYPES.ORDER_CD, arg_3_0.slot.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddListener(GAME.ISLAND_SUBMIT_ORDER_DONE, arg_7_0.OnSubmitOrder)
	arg_7_0:AddListener(GAME.ISLAND_REPLACE_ORDER_DONE, arg_7_0.OnReplaceOrder)
	arg_7_0:AddListener(IslandOrderAgency.GEN_NEW_ORDER, arg_7_0.OnGenNewOrder)
	arg_7_0:AddListener(IslandOrderAgency.UDPATE_ORDER, arg_7_0.OnFlushOrder)
	arg_7_0:AddListener(GAME.ISLAND_USE_TICKET_DONE, arg_7_0.OnUseTicketDone)

	return
end

function var_0_0.RemoveListeners(arg_8_0)
	arg_8_0:RemoveListener(GAME.ISLAND_SUBMIT_ORDER_DONE, arg_8_0.OnSubmitOrder)
	arg_8_0:RemoveListener(GAME.ISLAND_REPLACE_ORDER_DONE, arg_8_0.OnReplaceOrder)
	arg_8_0:RemoveListener(IslandOrderAgency.GEN_NEW_ORDER, arg_8_0.OnGenNewOrder)
	arg_8_0:RemoveListener(IslandOrderAgency.UDPATE_ORDER, arg_8_0.OnFlushOrder)
	arg_8_0:RemoveListener(GAME.ISLAND_USE_TICKET_DONE, arg_8_0.OnUseTicketDone)

	return
end

function var_0_0.OnSubmitOrder(arg_9_0, arg_9_1)
	arg_9_0:Flush((getProxy(IslandProxy):GetIsland():GetOrderAgency():GetSlot(arg_9_1.slotId)))

	return
end

function var_0_0.OnReplaceOrder(arg_10_0, arg_10_1)
	arg_10_0:Flush((getProxy(IslandProxy):GetIsland():GetOrderAgency():GetSlot(arg_10_1.slotId)))

	return
end

function var_0_0.OnFlushOrder(arg_11_0, arg_11_1)
	arg_11_0:TryFlushOrderInfo(arg_11_1.slotId)

	return
end

function var_0_0.OnUseTicketDone(arg_12_0, arg_12_1)
	if arg_12_1.type == IslandUseTicketCommand.TYPES.ORDER_CD then
		arg_12_0:TryFlushOrderInfo(arg_12_1.id)
	end

	return
end

function var_0_0.OnGenNewOrder(arg_13_0, arg_13_1)
	arg_13_0:TryFlushOrderInfo(arg_13_1.slotId)

	return
end

function var_0_0.TryFlushOrderInfo(arg_14_0, arg_14_1)
	local var_14_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency():GetSlot(arg_14_1)

	if not arg_14_0.slot then
		return
	end

	if arg_14_0.slot.id ~= var_14_0.id then
		return
	end

	arg_14_0:Flush(var_14_0)

	return
end

function var_0_0.Show(arg_15_0, arg_15_1)
	var_0_0.super.Show(arg_15_0)
	arg_15_0:Flush(arg_15_1)

	return
end

function var_0_0.Flush(arg_16_0, arg_16_1)
	arg_16_0.slot = arg_16_1

	if not arg_16_1 or arg_16_1:IsEmpty() then
		arg_16_0:Hide()

		return
	end

	local var_16_0 = arg_16_1:IsLoading()

	setActive(arg_16_0.infoPanel, not var_16_0)
	setActive(arg_16_0.loadingPanel, var_16_0)
	arg_16_0:RemoveSubmitCdTimer()
	arg_16_0:RemoveLoadingTimer()
	arg_16_0:RemoveDisappearTimer()

	if var_16_0 then
		arg_16_0:FlushLoadingPanel(arg_16_1)
	else
		arg_16_0:FlusInfoPanel(arg_16_1)
	end

	local var_16_1 = arg_16_1:GetOrder()

	if var_16_1:IsUrgency() then
		arg_16_0:AddDisappearTimer(arg_16_1)
	end

	return
end

function var_0_0.AddDisappearTimer(arg_17_0, arg_17_1)
	arg_17_0:RemoveDisappearTimer()

	if arg_17_1:GetDisappearTime() <= pg.TimeMgr.GetInstance():GetServerTime() then
		arg_17_0:Hide()

		return
	end

	arg_17_0.disappearTimer = Timer.New(function()
		if var_0 - pg.TimeMgr.GetInstance():GetServerTime() < 0 then
			arg_17_0:Hide()
		end

		return
	end, 1, -1)

	arg_17_0.disappearTimer.func()
	arg_17_0.disappearTimer:Start()

	return
end

function var_0_0.RemoveDisappearTimer(arg_19_0)
	if arg_19_0.disappearTimer then
		arg_19_0.disappearTimer:Stop()

		arg_19_0.disappearTimer = nil
	end

	return
end

function var_0_0.FlushLoadingPanel(arg_20_0, arg_20_1)
	local function var_20_0()
		arg_20_0.loadingTimeTxt.text = ""

		arg_20_0:Flush(arg_20_1)

		return
	end

	if arg_20_1:GetCanSubmitTime() <= pg.TimeMgr.GetInstance():GetServerTime() then
		(function()
			arg_20_0.loadingTimeTxt.text = ""

			arg_20_0:Flush(arg_20_1)

			return
		end)()

		return
	end

	arg_20_0.loadingTimer = Timer.New(function()
		local var_22_0 = var_0 - pg.TimeMgr.GetInstance():GetServerTime()

		arg_20_0.loadingTimeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_22_0)

		if var_22_0 < 0 then
			arg_20_0:RemoveLoadingTimer()
			var_20_0()
		end

		return
	end, 1, -1)

	arg_20_0.loadingTimer:Start()
	arg_20_0.loadingTimer.func()

	return
end

function var_0_0.RemoveLoadingTimer(arg_23_0)
	if arg_23_0.loadingTimer then
		arg_23_0.loadingTimer:Stop()

		arg_23_0.loadingTimer = nil
	end

	return
end

function var_0_0.FlusInfoPanel(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1:GetOrder()

	arg_24_0:FlushAwards(var_24_0)
	arg_24_0:FlushConsume(var_24_0)
	setActive(arg_24_0.replaceBtn, not var_24_0:IsUrgency())

	arg_24_0.nameTxt.text = var_24_0:GetRoleName()

	local var_24_1, var_24_2 = getProxy(IslandProxy):GetIsland():GetOrderAgency():CanSubmitOrder()

	setActive(arg_24_0.submitBtnMark, not var_24_0:CanFinish())

	if var_24_1 then
		arg_24_0:SetMaskFillAmount(arg_24_0.submitBtnMark, 1)

		return
	end

	local var_24_3 = pg.island_set.order_complete_refresh_time.key_value_int

	arg_24_0.submitTimer = Timer.New(function()
		local var_25_0 = var_24_2 - pg.TimeMgr.GetInstance():GetServerTime()

		arg_24_0:SetMaskFillAmount(arg_24_0.submitBtnMark, 1 - var_25_0 / var_24_3)

		if var_25_0 / var_24_3 <= 0 then
			arg_24_0:RemoveSubmitCdTimer()
		end

		return
	end, 1, -1)

	arg_24_0.submitTimer:Start()
	arg_24_0.submitTimer.func()

	return
end

function var_0_0.SetMaskFillAmount(arg_26_0, arg_26_1, arg_26_2)
	arg_26_1:GetComponent(typeof(RectMask2D)).padding = Vector4(arg_26_1.sizeDelta.x * arg_26_2, 0, 0, 0)

	return
end

function var_0_0.FlushAwards(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1:GetDisplayAwards()

	arg_27_0.awardUIList:make(function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_28_2, var_27_0[arg_28_1 + 1])
			onButton(arg_27_0, arg_28_2, function()
				arg_27_0:ShowMsgBox({
					title = i18n("island_word_desc"),
					type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
					dropData = var_0
				})

				return
			end)
		end

		return
	end)
	arg_27_0.awardUIList:align(#arg_27_1:GetDisplayAwards())

	return
end

function var_0_0.FlushConsume(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1:GetConsume()

	arg_30_0.consumeUIList:make(function(arg_31_0, arg_31_1, arg_31_2)
		if arg_31_0 == UIItemList.EventUpdate then
			local var_31_0 = var_30_0[arg_31_1 + 1]
			local var_31_1 = {
				count = 0,
				type = var_30_0[arg_31_1 + 1].type,
				id = var_30_0[arg_31_1 + 1].id
			}

			updateCustomDrop(arg_31_2:Find("tpl"), {
				count = 0,
				type = var_30_0[arg_31_1 + 1].type,
				id = var_30_0[arg_31_1 + 1].id
			})
			onButton(arg_30_0, arg_31_2, function()
				arg_30_0:ShowMsgBox({
					title = i18n("island_word_desc"),
					type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
					dropData = var_31_1
				})

				return
			end)
			setText(arg_31_2:Find("Text"), ({
				count = 0,
				type = var_30_0[arg_31_1 + 1].type,
				id = var_30_0[arg_31_1 + 1].id
			}).cfg.name)

			local var_31_2 = Drop.New({
				type = ({
					count = 0,
					type = var_30_0[arg_31_1 + 1].type,
					id = var_30_0[arg_31_1 + 1].id
				}).type,
				id = ({
					count = 0,
					type = var_30_0[arg_31_1 + 1].type,
					id = var_30_0[arg_31_1 + 1].id
				}).id
			}):getOwnedCount()
			local var_31_3 = var_31_2 >= var_31_0.count

			if var_31_2 >= var_31_0.count then
				setText(arg_31_2:Find("count"), var_31_2 .. "/" .. var_31_0.count)
			else
				setText(arg_31_2:Find("count"), setColorStr(var_31_2, COLOR_RED) .. "/" .. var_31_0.count)
			end

			setActive(arg_31_2:Find("finish"), var_31_3)
			setActive(arg_31_2:Find("line"), arg_31_1 + 1 ~= #var_30_0)
		end

		return
	end)
	arg_30_0.consumeUIList:align(#arg_30_1:GetConsume())

	return
end

function var_0_0.RemoveSubmitCdTimer(arg_33_0)
	if arg_33_0.submitTimer then
		arg_33_0.submitTimer:Stop()

		arg_33_0.submitTimer = nil
	end

	return
end

function var_0_0.OnDestroy(arg_34_0)
	arg_34_0:RemoveSubmitCdTimer()
	arg_34_0:RemoveLoadingTimer()
	arg_34_0:RemoveDisappearTimer()

	return
end

return var_0_0
