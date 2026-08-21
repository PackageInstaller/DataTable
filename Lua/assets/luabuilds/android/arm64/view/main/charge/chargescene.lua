local var_0_0 = class("ChargeScene", import("...base.BaseUI"))

var_0_0.TYPE_DIAMOND = 1
var_0_0.TYPE_GIFT = 2
var_0_0.TYPE_ITEM = 3
var_0_0.TYPE_PICK = 4

function var_0_0.getUIName(arg_1_0)
	return "ChargeShopUI"
end

function var_0_0.onBackPressed(arg_2_0)
	arg_2_0:closeView()

	return
end

function var_0_0.preload(arg_3_0, arg_3_1)
	local var_3_0 = getProxy(ShopsProxy)

	if getProxy(ShopsProxy):ShouldRefreshChargeList() then
		pg.m02:sendNotification(GAME.GET_CHARGE_LIST, {
			callback = function()
				local var_4_0 = var_3_0:getFirstChargeList()
				local var_4_1 = var_3_0:getChargedList()
				local var_4_2 = var_3_0:GetNormalList()
				local var_4_3 = var_3_0:GetNormalGroupList()

				if var_4_0 then
					arg_3_0:setFirstChargeIds(var_4_0)
				end

				if var_4_1 then
					arg_3_0:setChargedList(var_4_1)
				end

				if var_4_2 then
					arg_3_0:setNormalList(var_4_2)
				end

				if var_4_3 then
					arg_3_0:setNormalGroupList(var_4_3)
				end

				arg_3_1()

				return
			end
		})
	else
		(function()
			local var_4_0 = var_3_0:getFirstChargeList()
			local var_4_1 = var_3_0:getChargedList()
			local var_4_2 = var_3_0:GetNormalList()
			local var_4_3 = var_3_0:GetNormalGroupList()

			if var_4_0 then
				arg_3_0:setFirstChargeIds(var_4_0)
			end

			if var_4_1 then
				arg_3_0:setChargedList(var_4_1)
			end

			if var_4_2 then
				arg_3_0:setNormalList(var_4_2)
			end

			if var_4_3 then
				arg_3_0:setNormalGroupList(var_4_3)
			end

			arg_3_1()

			return
		end)()
	end

	return
end

function var_0_0.setPlayer(arg_5_0, arg_5_1)
	arg_5_0.player = arg_5_1

	return
end

function var_0_0.setFirstChargeIds(arg_6_0, arg_6_1)
	arg_6_0.firstChargeIds = arg_6_1

	return
end

function var_0_0.setChargedList(arg_7_0, arg_7_1)
	arg_7_0.chargedList = arg_7_1

	return
end

function var_0_0.setNormalList(arg_8_0, arg_8_1)
	arg_8_0.normalList = arg_8_1

	return
end

function var_0_0.setNormalGroupList(arg_9_0, arg_9_1)
	arg_9_0.normalGroupList = arg_9_1

	arg_9_0:addRefreshTimer(GetZeroTime())

	return
end

function var_0_0.ResUISettings(arg_10_0)
	return true
end

function var_0_0.init(arg_11_0)
	arg_11_0.blurPanel = arg_11_0._tf:Find("blur_panel")
	arg_11_0.top = arg_11_0.blurPanel:Find("adapt/top")
	arg_11_0.frame = arg_11_0._tf:Find("frame")
	arg_11_0.viewContainer = arg_11_0._tf:Find("viewContainer")
	arg_11_0.bg = arg_11_0._tf:Find("viewContainer/bg")
	arg_11_0.painting = arg_11_0._tf:Find("frame/painting")
	arg_11_0.chat = arg_11_0._tf:Find("viewContainer/chat")
	arg_11_0.chatText = arg_11_0.chat:Find("Text")
	arg_11_0.switchBtn = arg_11_0._tf:Find("blur_panel/adapt/switch_btn")
	arg_11_0.skinShopBtn = arg_11_0._tf:Find("blur_panel/adapt/skin_btn")

	local var_11_0 = LOCK_SKIN_SHOP_ENTER and getProxy(PlayerProxy):getData().level < LOCK_SKIN_SHOP_ENTER_LEVEL

	setActive(arg_11_0.skinShopBtn, not var_11_0)

	arg_11_0.itemToggle = arg_11_0.viewContainer:Find("toggle_list/item_toggle")
	arg_11_0.giftToggle = arg_11_0.viewContainer:Find("toggle_list/gift_toggle")
	arg_11_0.diamondToggle = arg_11_0.viewContainer:Find("toggle_list/diamond_toggle")
	arg_11_0.giftTip = arg_11_0.giftToggle:Find("tip")
	arg_11_0.pickToggle = arg_11_0.viewContainer:Find("toggle_list/pick_toggle")
	arg_11_0.pickTip = arg_11_0.pickToggle:Find("tip")
	arg_11_0.chargeTipWindow = ChargeTipWindow.New(arg_11_0._tf, arg_11_0.event)

	setText(arg_11_0.diamondToggle:Find("light/title"), i18n("shop_diamond_title"))
	setText(arg_11_0.diamondToggle:Find("dark/title"), i18n("shop_diamond_title"))
	setText(arg_11_0.giftToggle:Find("light/title"), i18n("shop_gift_title"))
	setText(arg_11_0.giftToggle:Find("dark/title"), i18n("shop_gift_title"))
	setText(arg_11_0.itemToggle:Find("light/title"), i18n("shop_item_title"))
	setText(arg_11_0.itemToggle:Find("dark/title"), i18n("shop_item_title"))
	setText(arg_11_0.pickToggle:Find("light/title"), i18n("shop_akashi_pick_title"))
	setText(arg_11_0.pickToggle:Find("dark/title"), i18n("shop_akashi_pick_title"))

	arg_11_0.linkTitle = {
		arg_11_0.top:Find("title/title_diamond"),
		arg_11_0.top:Find("title/title_gift"),
		arg_11_0.top:Find("title/title_item"),
		arg_11_0.top:Find("title/title_pick")
	}
	arg_11_0.toggleList = {
		arg_11_0.diamondToggle,
		arg_11_0.giftToggle,
		arg_11_0.itemToggle,
		arg_11_0.pickToggle
	}

	if Live2dConst.GetLive2DArm32MatchAble() then
		local var_11_1 = Ship.New({
			configId = 312011
		}):getPainting()

		LoadPaintingPrefabAsync(arg_11_0.painting, var_11_1, var_11_1, "mainNormal", function()
			arg_11_0.loading = false

			return
		end)
	else
		arg_11_0:createLive2D()
	end

	arg_11_0.live2dTimer = Timer.New(function()
		local var_13_0 = pg.ChargeShipTalkInfo.Actions[math.random(#pg.ChargeShipTalkInfo.Actions)]

		if arg_11_0:checkBuyDone(var_13_0.action) then
			arg_11_0:displayShipWord(nil, false, var_13_0.dialog_index)
		end

		return
	end, 20, -1)

	arg_11_0.live2dTimer:Start()
	arg_11_0:jpUIInit()
	arg_11_0:blurView()
	arg_11_0:initSubView()

	return
end

function var_0_0.didEnter(arg_14_0)
	setActive(arg_14_0.chat, false)
	onButton(arg_14_0, arg_14_0.top:Find("back_button"), function()
		arg_14_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_14_0, arg_14_0.painting, function()
		arg_14_0:displayShipWord()
		arg_14_0:emit(ChargeMediator.CLICK_MING_SHI)

		return
	end, SFX_PANEL)

	for iter_14_0 = 1, #arg_14_0.toggleList do
		onToggle(arg_14_0, arg_14_0.toggleList[iter_14_0], function(arg_17_0)
			setActive(var_0:Find("dark"), not arg_17_0)

			if arg_17_0 then
				arg_14_0:switchSubView(iter_14_0)
			end

			return
		end, SFX_PANEL)
	end

	onButton(arg_14_0, arg_14_0.switchBtn, function()
		arg_14_0:emit(ChargeMediator.SWITCH_TO_SHOP, {
			warp = NewShopsScene.TYPE_SHOP_STREET
		})
		arg_14_0:stopCV()

		return
	end, SFX_PANEL)
	onButton(arg_14_0, arg_14_0.skinShopBtn, function()
		arg_14_0:emit(ChargeMediator.ON_SKIN_SHOP)

		return
	end, SFX_PANEL)
	arg_14_0:updateNoRes()

	if arg_14_0.contextData.wrap ~= nil then
		arg_14_0:switchSubViewByTogger(arg_14_0.contextData.wrap)

		arg_14_0.contextData.wrap = nil
	else
		arg_14_0:switchSubViewByTogger(ChargeScene.TYPE_DIAMOND)
	end

	arg_14_0:jpUIEnter()

	return
end

function var_0_0.OnChargeSuccess(arg_20_0, arg_20_1)
	arg_20_0.chargeTipWindow:ExecuteAction("Show", arg_20_1)

	return
end

function var_0_0.willExit(arg_21_0)
	arg_21_0:unBlurView()

	if arg_21_0.chargeTipWindow then
		arg_21_0.chargeTipWindow:Destroy()

		arg_21_0.chargeTipWindow = nil
	end

	if arg_21_0.heartsTimer then
		arg_21_0.heartsTimer:Stop()

		arg_21_0.heartsTimer = nil
	end

	if arg_21_0.live2dChar then
		arg_21_0.live2dChar:Dispose()
	end

	if arg_21_0.live2dTimer then
		arg_21_0.live2dTimer:Stop()

		arg_21_0.live2dTimer = nil
	end

	if arg_21_0.giftShopView then
		arg_21_0.giftShopView:OnDestroy()
	end

	arg_21_0:stopCV()

	return
end

function var_0_0.initSubView(arg_22_0)
	arg_22_0.subViewContainer = arg_22_0.viewContainer:Find("SubView")
	arg_22_0.diamondShopView = ChargeDiamondShopView.New(arg_22_0.subViewContainer, arg_22_0.event, arg_22_0.contextData)
	arg_22_0.giftShopView = ChargeGiftShopView.New(arg_22_0.subViewContainer, arg_22_0.event, arg_22_0.contextData)
	arg_22_0.itemShopView = ChargeItemShopView.New(arg_22_0.subViewContainer, arg_22_0.event, arg_22_0.contextData)
	arg_22_0.pickShopView = ChargePickShopView.New(arg_22_0.subViewContainer, arg_22_0.event, arg_22_0.contextData)
	arg_22_0.curSubViewNum = 0
	arg_22_0.subViewList = {
		[ChargeScene.TYPE_DIAMOND] = arg_22_0.diamondShopView,
		[ChargeScene.TYPE_GIFT] = arg_22_0.giftShopView,
		[ChargeScene.TYPE_ITEM] = arg_22_0.itemShopView,
		[ChargeScene.TYPE_PICK] = arg_22_0.pickShopView
	}

	return
end

function var_0_0.switchSubView(arg_23_0, arg_23_1)
	if arg_23_1 == arg_23_0.curSubViewNum then
		return
	end

	arg_23_0.subViewList[arg_23_1]:setGoodData(arg_23_0.firstChargeIds, arg_23_0.chargedList, arg_23_0.normalList, arg_23_0.normalGroupList)
	arg_23_0.subViewList[arg_23_1]:Reset()
	arg_23_0.subViewList[arg_23_1]:Load()

	if arg_23_0.subViewList[arg_23_0.curSubViewNum] then
		arg_23_0.subViewList[arg_23_0.curSubViewNum]:Destroy()
	end

	arg_23_0.curSubViewNum = arg_23_1

	if PLATFORM_CODE == PLATFORM_JP then
		setActive(arg_23_0.userAgreeBtn3, arg_23_1 == var_0_0.TYPE_DIAMOND)
		setActive(arg_23_0.userAgreeBtn4, arg_23_1 == var_0_0.TYPE_DIAMOND)
	end

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.linkTitle) do
		setActive(iter_23_1, iter_23_0 == arg_23_1)
	end

	return
end

function var_0_0.switchSubViewByTogger(arg_24_0, arg_24_1)
	triggerToggle(arg_24_0.toggleList[arg_24_1], true)

	return
end

function var_0_0.updateCurSubView(arg_25_0)
	arg_25_0.subViewList[arg_25_0.curSubViewNum]:setGoodData(arg_25_0.firstChargeIds, arg_25_0.chargedList, arg_25_0.normalList, arg_25_0.normalGroupList)
	arg_25_0.subViewList[arg_25_0.curSubViewNum]:reUpdateAll()

	return
end

function var_0_0.updateNoRes(arg_26_0, arg_26_1)
	if not arg_26_1 then
		arg_26_1 = arg_26_0.contextData.noRes
	else
		arg_26_0.contextData.noRes = arg_26_1
	end

	if not arg_26_1 or #arg_26_1 <= 0 then
		return
	end

	arg_26_0.contextData.noRes = {}

	local var_26_0 = getProxy(BagProxy):getData()
	local var_26_1 = ""

	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		if iter_26_1[2] > 0 then
			local var_26_2 = arg_26_1[iter_26_0]
			local var_26_3 = iter_26_1[3]

			if iter_26_1[1] == 59001 then
				arg_26_1[iter_26_0][2] = iter_26_1[3] - arg_26_0.player.gold

				goto label_26_0
			end

			::label_26_0::

			if var_26_0[iter_26_1[1]] then
				do
					local var_26_4 = var_26_0[iter_26_1[1]].count or 0

					var_26_2[2] = var_26_3 - var_26_4
				end

				if arg_26_1[iter_26_0][2] > 0 then
					table.insert(arg_26_0.contextData.noRes, arg_26_1[iter_26_0])
				end
			end
		end
	end

	for iter_26_2, iter_26_3 in ipairs(arg_26_0.contextData.noRes) do
		var_26_1 = var_26_1 .. i18n(iter_26_3[1] == 59001 and "text_noRes_info_tip" or "text_noRes_info_tip2", Item.getConfigData(iter_26_3[1]).name, iter_26_3[2])

		if iter_26_2 < #arg_26_0.contextData.noRes then
			var_26_1 = var_26_1 .. i18n("text_noRes_info_tip_link")
		end
	end

	if var_26_1 == "" then
		arg_26_0:displayShipWord(i18n("text_shop_enoughRes_tip"), false)
	else
		arg_26_0:displayShipWord(i18n("text_shop_noRes_tip", var_26_1), true)
	end

	return
end

function var_0_0.displayShipWord(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if not arg_27_0.chatFlag then
		if not arg_27_1 and arg_27_0.contextData.noRes and #arg_27_0.contextData.noRes > 0 then
			setActive(arg_27_0.chat, false)

			arg_27_0.chat.transform.localScale = Vector3(0, 0, 1)
		end

		arg_27_0.chatFlag = true

		if not arg_27_0.isInitChatPosition then
			arg_27_0.isInitChatPosition = true

			arg_27_0:InitChatPosition()
		end

		setActive(arg_27_0.chat, true)

		local var_27_0 = arg_27_3 or math.random(1, (arg_27_0.player:getChargeLevel()))
		local var_27_1 = arg_27_3 and pg.pay_level_award[var_27_0].dialog or arg_27_1 or pg.pay_level_award[var_27_0].dialog

		if not arg_27_1 then
			arg_27_0:playCV(var_27_0)
		end

		setText(arg_27_0.chatText, var_27_1)

		local var_27_2 = arg_27_0.chatText:GetComponent(typeof(Text))

		var_27_2.alignment = #var_27_2.text > CHAT_POP_STR_LEN_SHORT and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

		;(function()
			local var_28_0 = 3

			LeanTween.scale(rtf(arg_27_0.chat.gameObject), Vector3.New(1, 1, 1), 0.3):setFrom(Vector3.New(0, 0, 0)):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
				if not arg_27_2 then
					LeanTween.scale(rtf(arg_27_0.chat.gameObject), Vector3.New(0, 0, 1), var_0):setEase(LeanTweenType.easeInBack):setDelay(var_0 + var_28_0):setOnComplete(System.Action(function()
						arg_27_0.chatFlag = nil

						setActive(arg_27_0.chat, false)

						if arg_27_0.contextData.noRes and #arg_27_0.contextData.noRes > 0 then
							arg_27_0:updateNoRes()
						end

						return
					end))
				else
					arg_27_0.chatFlag = nil
				end

				return
			end))

			return
		end)()
	end

	return
end

function var_0_0.InitChatPosition(arg_31_0)
	local var_31_0 = arg_31_0.chat.parent:InverseTransformPoint((arg_31_0.painting.parent:TransformPoint(arg_31_0.painting.localPosition + Vector3(-21, -176, 0))))

	arg_31_0.chat.localPosition = Vector3(var_31_0.x, var_31_0.y, 0)

	return
end

function var_0_0.playHeartEffect(arg_32_0)
	if arg_32_0.heartsTimer then
		arg_32_0.heartsTimer:Stop()
	end

	setActive(arg_32_0.painting:Find("heartsfly"), true)

	arg_32_0.heartsTimer = Timer.New(function()
		setActive(var_0, false)

		return
	end, 1, 1)

	arg_32_0.heartsTimer:Start()

	return
end

function var_0_0.createLive2D(arg_34_0)
	arg_34_0.live2dChar = Live2DPainting.New(Live2DPainting.GenerateData({
		ship = Ship.New({
			configId = 312011
		}),
		offset = {
			0,
			0,
			0,
			75
		},
		position = Vector3(0, 0, 0),
		parent = arg_34_0._tf:Find("frame/painting/live2d")
	}), function(arg_35_0)
		arg_35_0:setSortingLayer(LayerWeightConst.L2D_DEFAULT_LAYER)

		return
	end)

	return
end

function var_0_0.checkBuyDone(arg_36_0, arg_36_1)
	if not arg_36_0.live2dChar or not arg_36_0.live2dChar:IsLoaded() then
		return
	end

	local var_36_0

	if type(arg_36_1) == "string" then
		var_36_0 = arg_36_1 == "damonds" and "diamond" or arg_36_1
	else
		local var_36_1 = pg.shop_template[arg_36_1]

		if pg.shop_template[arg_36_1] and var_36_1.effect_args and type(var_36_1.effect_args) == "table" then
			for iter_36_0, iter_36_1 in ipairs(var_36_1.effect_args) do
				if iter_36_1 == 1 then
					var_36_0 = "gold"
				end
			end
		end
	end

	local var_36_2 = arg_36_0.preAniName == "gold" or arg_36_0.preAniName == "diamond"
	local var_36_3 = var_36_0 == "gold" or var_36_0 == "diamond"
	local var_36_4 = (arg_36_0.preAniName == "gold" or arg_36_0.preAniName == "diamond") and var_36_3 or not var_36_2

	var_36_4 = var_36_0 and arg_36_0.preAniName ~= var_36_0 and var_36_4

	if var_36_4 then
		arg_36_0.preAniName = var_36_0

		arg_36_0.live2dChar:TriggerAction(var_36_0, nil, true)
	end

	return var_36_4
end

function var_0_0.playCV(arg_37_0, arg_37_1)
	local var_37_0

	if pg.pay_level_award[arg_37_1] and pg.pay_level_award[arg_37_1].cv_key ~= "" then
		var_37_0 = "event:/cv/chargeShop/" .. pg.pay_level_award[arg_37_1].cv_key
	end

	if var_37_0 then
		arg_37_0:stopCV()

		arg_37_0._currentVoice = var_37_0

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_37_0)
	end

	return
end

function var_0_0.stopCV(arg_38_0)
	if arg_38_0._currentVoice then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(arg_38_0._currentVoice)
	end

	arg_38_0._currentVoice = nil

	return
end

function var_0_0.blurView(arg_39_0)
	pg.UIMgr.GetInstance():OverlayPanel(arg_39_0.viewContainer, {
		pbList = {
			arg_39_0.viewContainer:Find("blurBg")
		}
	})

	return
end

function var_0_0.unBlurView(arg_40_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_40_0.viewContainer, arg_40_0.frame)

	return
end

function var_0_0.jpUIInit(arg_41_0)
	if PLATFORM_CODE ~= PLATFORM_JP then
		return
	end

	arg_41_0.userAgreeBtn3 = arg_41_0._tf:Find("frame/raw1Btn")
	arg_41_0.userAgreeBtn4 = arg_41_0._tf:Find("frame/raw2Btn")

	return
end

function var_0_0.jpUIEnter(arg_42_0)
	if PLATFORM_CODE ~= PLATFORM_JP then
		return
	end

	onButton(arg_42_0, arg_42_0.userAgreeBtn3, function()
		arg_42_0:emit(ChargeMediator.OPEN_USER_AGREE, require("ShareCfg.UserAgreement3") or "")

		return
	end, SFX_PANEL)
	onButton(arg_42_0, arg_42_0.userAgreeBtn4, function()
		arg_42_0:emit(ChargeMediator.OPEN_USER_AGREE, require("ShareCfg.UserAgreement4") or "")

		return
	end, SFX_PANEL)

	return
end

function var_0_0.addRefreshTimer(arg_45_0, arg_45_1)
	(function()
		if arg_45_0.refreshTimer then
			arg_45_0.refreshTimer:Stop()

			arg_45_0.refreshTimer = nil
		end

		return
	end)()

	arg_45_0.refreshTimer = Timer.New(function()
		local var_47_0 = arg_45_1 + 1 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_47_0 <= 0 then
			var_0()
			arg_45_0:emit(ChargeMediator.GET_CHARGE_LIST)
		else
			local var_47_1 = pg.TimeMgr.GetInstance():DescCDTime(var_47_0)
		end

		return
	end, 1, -1)

	arg_45_0.refreshTimer:Start()
	arg_45_0.refreshTimer.func()

	return
end

function var_0_0.checkFreeGiftTag(arg_48_0)
	TagTipHelper.FreeGiftTag({
		arg_48_0.giftTip
	})

	return
end

return var_0_0
