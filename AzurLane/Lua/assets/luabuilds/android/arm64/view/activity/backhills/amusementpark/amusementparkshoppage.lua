local var_0_0 = class("AmusementParkShopPage", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "AmusementParkShopPage"
end

function var_0_0.init(arg_2_0)
	arg_2_0.goodsContainer = arg_2_0._tf:Find("Box/Container/Goods")
	arg_2_0.specialsContainer = arg_2_0._tf:Find("Box/Container/SpecialList")
	arg_2_0.specailsDecoration = arg_2_0._tf:Find("Box/Container/Specials")
	arg_2_0.specailsOtherDecoration = arg_2_0._tf:Find("Box/Container/SpecialsOther")

	setActive(arg_2_0.specailsOtherDecoration, false)

	arg_2_0.chat = arg_2_0._tf:Find("Box/Bubble")
	arg_2_0.chatText = arg_2_0.chat:Find("BubbleText")
	arg_2_0.chatClick = arg_2_0._tf:Find("Box/BubbleClick")
	arg_2_0.chatActive = false
	arg_2_0.pollText = {
		i18n("amusementpark_shop_carousel1"),
		i18n("amusementpark_shop_carousel2"),
		i18n("amusementpark_shop_carousel3"),
		i18n("amusementpark_shop_0")
	}
	arg_2_0.pollIndex = math.random(0, math.max(0, #arg_2_0.pollText - 1))
	arg_2_0.msgbox = arg_2_0._tf:Find("Msgbox")

	setActive(arg_2_0.msgbox, false)

	arg_2_0.contentText = arg_2_0.msgbox:Find("window/msg_panel/content"):GetComponent("RichText")

	return
end

function var_0_0.SetShop(arg_3_0, arg_3_1)
	arg_3_0.shop = arg_3_1

	return
end

function var_0_0.SetSpecial(arg_4_0, arg_4_1)
	arg_4_0.specialLists = arg_4_1

	return
end

function var_0_0.didEnter(arg_5_0)
	onButton(arg_5_0, arg_5_0._tf:Find("Top/Back"), function()
		arg_5_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_5_0, arg_5_0._tf:Find("Top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.amusementpark_shop_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.msgbox:Find("BG"), function()
		setActive(arg_5_0.msgbox, false)

		return
	end)
	onButton(arg_5_0, arg_5_0.msgbox:Find("window/button_container/Button1"), function()
		setActive(arg_5_0.msgbox, false)

		return
	end, SFX_CANCEL)
	onButton(arg_5_0, arg_5_0.chatClick, function()
		arg_5_0:SetActiveBubble(not arg_5_0.chatActive)

		return
	end)

	local var_5_0 = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = arg_5_0.shop:getResId()
	}):getIcon()

	arg_5_0.contentText:AddSprite(var_5_0, LoadSprite(var_5_0, ""))
	arg_5_0:UpdateView()
	arg_5_0:ShowEnterMsg()
	pg.UIMgr.GetInstance():OverlayPanel(arg_5_0._tf)

	return
end

function var_0_0.ShowEnterMsg(arg_11_0)
	if _.all(_.values(arg_11_0.shop.goods), function(arg_12_0)
		return not arg_12_0:canPurchase()
	end) then
		arg_11_0:ShowShipWord(i18n("amusementpark_shop_end"))

		return
	end

	arg_11_0:ShowShipWord(i18n("amusementpark_shop_enter"))

	return
end

function var_0_0.UpdateView(arg_13_0)
	local var_13_0 = getProxy(PlayerProxy):getRawData()[id2res((arg_13_0.shop:getResId()))] or 0

	setText(arg_13_0._tf:Find("Box/TicketText"), "X" .. var_13_0)
	arg_13_0:UpdateGoods()

	return
end

function var_0_0.UpdateGoods(arg_14_0)
	local var_14_0 = _.values(arg_14_0.shop.goods)

	table.sort(var_14_0, function(arg_15_0, arg_15_1)
		return arg_15_0.id < arg_15_1.id
	end)
	UIItemList.StaticAlign(arg_14_0.goodsContainer, arg_14_0.goodsContainer:GetChild(0), #var_14_0, function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_16_0 = var_14_0[arg_16_1 + 1]

		setActive(arg_16_2:Find("mask"), not var_14_0[arg_16_1 + 1]:canPurchase())
		updateDrop(arg_16_2, {
			type = var_16_0:getConfig("commodity_type"),
			id = var_16_0:getConfig("commodity_id"),
			count = var_16_0:getConfig("num")
		})
		setText(arg_16_2:Find("Price"), var_16_0:getConfig("resource_num"))
		onButton(arg_14_0, arg_16_2, function()
			arg_14_0:OnClickCommodity(var_16_0, function(arg_18_0, arg_18_1)
				arg_14_0:OnPurchase(var_16_0, arg_18_1)

				return
			end)

			return
		end, SFX_PANEL)

		return
	end)
	setActive(arg_14_0.specailsDecoration, #arg_14_0.specialLists > 0)
	setActive(arg_14_0.specailsOtherDecoration, #arg_14_0.specialLists <= 0)
	UIItemList.StaticAlign(arg_14_0.specialsContainer, arg_14_0.specialsContainer:GetChild(0), 3, function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_19_0 = arg_14_0.specialLists[arg_19_1 + 1]

		setActive(arg_19_2, arg_14_0.specialLists[arg_19_1 + 1])

		if not var_19_0 then
			return
		end

		setActive(arg_19_2:Find("mask"), var_19_0.HasGot)
		onButton(arg_14_0, arg_19_2, function()
			arg_14_0:emit(BaseUI.ON_DROP, var_19_0)

			return
		end, SFX_PANEL)

		return
	end)

	return
end

function var_0_0.CheckRes(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_1:canPurchase() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

		return false
	end

	local var_21_0 = Drop.New({
		type = arg_21_1:getConfig("resource_category"),
		id = arg_21_1:getConfig("resource_type")
	})

	if var_21_0:getOwnedCount() < arg_21_1:getConfig("resource_num") * arg_21_2 then
		arg_21_0:ShowMsgbox({
			useGO = true,
			content = i18n("amusementpark_shop_exchange"),
			onYes = function()
				arg_21_0:emit(AmusementParkShopMediator.GO_SCENE, SCENE.TASK)

				return
			end
		})

		return false
	end

	return true
end

function var_0_0.Purchase(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	arg_23_0:ShowMsgbox({
		content = i18n("amusementpark_shop_exchange2", arg_23_1:getConfig("resource_num") * arg_23_2, arg_23_1:getConfig("num") * arg_23_2, arg_23_3),
		onYes = function()
			if arg_23_0:CheckRes(arg_23_1, arg_23_2) then
				arg_23_4(arg_23_1, arg_23_2)
			end

			return
		end
	})

	return
end

function var_0_0.OnClickCommodity(arg_25_0, arg_25_1, arg_25_2)
	if not arg_25_0:CheckRes(arg_25_1, 1) then
		return
	end

	local var_25_0 = Drop.New({
		id = arg_25_1:getConfig("commodity_id"),
		type = arg_25_1:getConfig("commodity_type")
	})

	arg_25_0:Purchase(arg_25_1, 1, var_25_0:getConfig("name"), arg_25_2)

	return
end

function var_0_0.OnPurchase(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0:emit(AmusementParkShopMediator.ON_ACT_SHOPPING, arg_26_0.shop.activityId, 1, arg_26_1.id, arg_26_2)

	return
end

function var_0_0.ShowMsgbox(arg_27_0, arg_27_1)
	setActive(arg_27_0.msgbox, true)

	arg_27_0.contentText.text = arg_27_1.content

	local var_27_0 = arg_27_0.msgbox:Find("window/button_container/Button2")
	local var_27_1 = arg_27_0.msgbox:Find("window/button_container/Button3")
	local var_27_2 = arg_27_1.useGO

	setActive(var_27_0, not arg_27_1.useGO)
	setActive(var_27_1, var_27_2)
	onButton(arg_27_0, var_27_2 and var_27_1 or var_27_0, function()
		setActive(arg_27_0.msgbox, false)
		existCall(arg_27_1.onYes)

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.SetActiveBubble(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0.chatActive == tobool(arg_29_1) and not arg_29_2 then
		return
	end

	LeanTween.cancel(go(arg_29_0.chat))

	arg_29_0.chatActive = tobool(arg_29_1)

	if arg_29_1 then
		setActive(arg_29_0.chat, true)
		LeanTween.scale(arg_29_0.chat.gameObject, Vector3.New(1, 1, 1), 0.3):setFrom(Vector3.New(0, 0, 0)):setEase(LeanTweenType.easeOutBack)
	else
		setActive(arg_29_0.chat, true)
		LeanTween.scale(arg_29_0.chat.gameObject, Vector3.New(0, 0, 0), 0.3):setFrom(Vector3.New(1, 1, 1)):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
			setActive(arg_29_0.chat, false)

			return
		end))
	end

	return
end

function var_0_0.ShowShipWord(arg_31_0, arg_31_1)
	arg_31_0:SetActiveBubble(true, true)
	setText(arg_31_0.chatText, arg_31_1)
	arg_31_0:AddPollingChat()

	return
end

function var_0_0.AddPollingChat(arg_32_0)
	arg_32_0:StopPolling()

	arg_32_0.pollTimer = Timer.New(function()
		arg_32_0:ShowShipWord(arg_32_0.pollText[arg_32_0.pollIndex + 1])

		arg_32_0.pollIndex = (arg_32_0.pollIndex + 1) % #arg_32_0.pollText

		return
	end, 6)

	arg_32_0.pollTimer:Start()

	return
end

function var_0_0.StopPolling(arg_34_0)
	if not arg_34_0.pollTimer then
		return
	end

	arg_34_0.pollTimer:Stop()

	arg_34_0.pollTimer = nil

	return
end

function var_0_0.StopChat(arg_35_0)
	if LeanTween.isTweening(go(arg_35_0.chat)) then
		LeanTween.cancel(go(arg_35_0.chat))
	end

	setActive(arg_35_0.chat, false)

	return
end

function var_0_0.willExit(arg_36_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_36_0._tf)
	arg_36_0:StopPolling()

	return
end

function var_0_0.GetActivityShopTip()
	local var_37_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SHOP_PROGRESS_REWARD)

	if not var_37_0 or var_37_0:isEnd() then
		return
	end

	local var_37_1 = pg.activity_shop_template

	for iter_37_0, iter_37_1 in ipairs(pg.activity_shop_template.all) do
		if var_37_0.id == var_37_1[iter_37_1].activity then
			local var_37_2 = table.indexof(var_37_0.data1_list, iter_37_1)

			if var_37_2 then
				local var_37_3 = var_37_0.data2_list[var_37_2] or 0
				local var_37_4 = var_37_1[iter_37_1]
				local var_37_5 = Drop.New({
					type = var_37_1[iter_37_1].resource_category,
					id = var_37_1[iter_37_1].resource_type
				})
				local var_37_6 = var_37_5:getOwnedCount() >= var_37_1[iter_37_1].resource_num

				if (var_37_1[iter_37_1].num_limit == 0 or var_37_3 < var_37_4.num_limit) and var_37_6 then
					return true
				end
			end
		end
	end

	return false
end

return var_0_0
