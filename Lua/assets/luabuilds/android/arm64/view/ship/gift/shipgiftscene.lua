local var_0_0 = class("ShipGiftScene", import("view.base.BaseUI"))
local var_0_1 = 0.3
local var_0_2 = 3

function var_0_0.getUIName(arg_1_0)
	return "ShipGiftUI"
end

function var_0_0.ResUISettings(arg_2_0)
	return true
end

function var_0_0.init(arg_3_0)
	arg_3_0.adapt = arg_3_0._tf:Find("adapt")
	arg_3_0.topPanel = arg_3_0._tf:Find("adapt/top")
	arg_3_0.backBtn = arg_3_0._tf:Find("adapt/top/back_btn")
	arg_3_0.homeBtn = arg_3_0._tf:Find("adapt/top/option")
	arg_3_0.bgTf = arg_3_0._tf:Find("bgGo")
	arg_3_0.imageGrass = arg_3_0._tf:Find("bgGo/ImageGrass")
	arg_3_0.character = arg_3_0._tf:Find("adapt/content")
	arg_3_0.chat = arg_3_0._tf:Find("adapt/content/chat")
	arg_3_0.chatBg = arg_3_0._tf:Find("adapt/content/chat/chatbgtop")
	arg_3_0.chatText = arg_3_0._tf:Find("adapt/content/chat/Text")
	rtf(arg_3_0.chat).localScale = Vector3.New(0, 0, 1)
	arg_3_0.initChatBgH = arg_3_0.chatBg.sizeDelta.y
	arg_3_0.initChatTextH = arg_3_0.chatText.sizeDelta.y
	arg_3_0.initfontSize = arg_3_0.chatText:GetComponent(typeof(Text)).fontSize
	arg_3_0.namePanel = arg_3_0._tf:Find("adapt/name")
	arg_3_0.shipName = arg_3_0._tf:Find("adapt/name/nameRect/name_mask/Text")
	arg_3_0.shipNameEn = arg_3_0._tf:Find("adapt/name/english_name")
	arg_3_0.starts = arg_3_0._tf:Find("adapt/name/stars")
	arg_3_0.shipInfoStarTpl = arg_3_0._tf:Find("adapt/name/star_tpl")
	arg_3_0.shipType = arg_3_0._tf:Find("adapt/name/type")
	arg_3_0.intimacyIcon = arg_3_0._tf:Find("adapt/intimacy/icon")
	arg_3_0.intimacyValueText = arg_3_0._tf:Find("adapt/intimacy/value")
	arg_3_0.intimacyAddValueText = GetComponent(arg_3_0._tf:Find("adapt/intimacy/addValue"), typeof(RectTransform))
	arg_3_0.painting = arg_3_0.adapt:Find("content/paint/fitter")
	arg_3_0.l2dParent = arg_3_0.adapt:Find("content/paint/live2d")
	arg_3_0.spineParent = arg_3_0.adapt:Find("content/paint/spinePainting")
	arg_3_0.effectParent = arg_3_0.adapt:Find("content/paint/effect")
	arg_3_0.intimacyAddValuePos = arg_3_0.intimacyAddValueText.localPosition
	arg_3_0.rightPanel = arg_3_0._tf:Find("adapt/right")
	arg_3_0.scrollRect = GetComponent(arg_3_0._tf:Find("adapt/right/scrollRect"), "LScrollRect")
	arg_3_0.giftBtn = arg_3_0._tf:Find("adapt/right/giftBtn")

	setText(arg_3_0._tf:Find("adapt/right/titlePanel/title/text"), i18n("ship_gift"))
	setText(arg_3_0.giftBtn:Find("label"), i18n("ship_gift2"))
	setActive(arg_3_0.intimacyAddValueText, false)

	arg_3_0.giftItemList = {}
	arg_3_0.anim = arg_3_0._tf:GetComponent(typeof(Animation))

	return
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0._tf:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_5_0)
		arg_4_0:closeView()

		return
	end)
	onButton(arg_4_0, arg_4_0.backBtn, function()
		arg_4_0.anim:Play("anim_ShipGiftUI_out")

		return
	end, SFX_CANEL)
	onButton(arg_4_0, arg_4_0.homeBtn, function()
		arg_4_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_CANEL)
	onButton(arg_4_0, arg_4_0.giftBtn, function()
		if arg_4_0.selectIndex == nil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("shipyard_gift_non_existent"))

			return
		end

		local var_8_0 = ShipGiftTools.GetShipNeedIntimacyValue(arg_4_0.shipVO)

		if var_8_0 == 0 then
			if arg_4_0.shipVO.propose then
				pg.TipsMgr.GetInstance():ShowTips(i18n("shipyard_favorability_max"))
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("shipyard_favorability_threshold"))
			end

			return
		end

		if arg_4_0.selectCnt == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("shipyard_gift_non_existent"))

			return
		end

		local var_8_1 = arg_4_0.selectCnt
		local var_8_2 = arg_4_0.giftList[arg_4_0.selectIndex + 1].id
		local var_8_3 = ShipGiftTools.GetItemIntimacyValue(arg_4_0.shipVO, arg_4_0.giftList[arg_4_0.selectIndex + 1]) * arg_4_0.selectCnt - var_8_0

		if var_8_3 > 0 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("shipyard_favorability_exceed", math.floor(var_8_3 / 100)),
				onYes = function()
					arg_4_0:emit(ShipGiftMediator.SHIP_GIFT, var_8_2, var_8_1, arg_4_0.shipVO.id)

					return
				end
			})
		else
			arg_4_0:emit(ShipGiftMediator.SHIP_GIFT, arg_4_0.giftList[arg_4_0.selectIndex + 1].id, var_8_1, arg_4_0.shipVO.id)
		end

		return
	end, SFX_PANEL)

	arg_4_0.scrollRect.onInitItem = handler(arg_4_0, arg_4_0.ScrollInit)
	arg_4_0.scrollRect.onUpdateItem = handler(arg_4_0, arg_4_0.ScrollUpdate)
	arg_4_0.scrollRect.onReturnItem = handler(arg_4_0, arg_4_0.ScrollReturn)
	arg_4_0.shipVO = getProxy(BayProxy):getShipById(arg_4_0.contextData.shipID)
	arg_4_0.giftList = ShipGiftTools.GetGiftList(arg_4_0.shipVO)
	arg_4_0.shipLoadClass = ShipLoad.New(function(arg_10_0)
		setParent(arg_10_0.transform, arg_4_0.painting)

		return
	end)

	arg_4_0.shipLoadClass:LoadShip(arg_4_0.contextData.shipID)
	arg_4_0:updatePreference()
	arg_4_0:RefreshUI()
	arg_4_0:OverlayPanel(arg_4_0.bgTf, {
		pbList = {
			arg_4_0.imageGrass
		}
	})
	arg_4_0:OverlayPanel(arg_4_0.adapt)

	arg_4_0.selectIndex = nil
	arg_4_0.eventList = {
		arg_4_0:bind(ShipGiftItem.SELECT_ITEM, handler(arg_4_0, arg_4_0.OnSelectItem)),
		arg_4_0:bind(ShipGiftItem.REFRESH_USE_ITEM_CNT, handler(arg_4_0, arg_4_0.OnRefreshUseItemCnt))
	}

	return
end

function var_0_0.willExit(arg_11_0)
	arg_11_0:StopPreVoice()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.eventList) do
		arg_11_0:disconnect(iter_11_1)
	end

	arg_11_0.eventList = nil

	arg_11_0:StopWaitClickTimer()
	arg_11_0:StopAutoClickTimer()
	ClearLScrollrect(arg_11_0.scrollRect)

	for iter_11_2, iter_11_3 in pairs(arg_11_0.giftItemList) do
		iter_11_3:willExit()
	end

	arg_11_0.giftItemList = nil

	arg_11_0.shipLoadClass:Dispose()

	arg_11_0.shipLoadClass = nil

	arg_11_0:UnOverlayPanel(arg_11_0.bgTf, arg_11_0._tf)
	arg_11_0:UnOverlayPanel(arg_11_0.adapt, arg_11_0._tf)

	return
end

function var_0_0.ScrollInit(arg_12_0, arg_12_1)
	arg_12_0.giftItemList[arg_12_1] = ShipGiftItem.New(arg_12_1, arg_12_0)

	return
end

function var_0_0.ScrollUpdate(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0.giftItemList[arg_13_2] then
		-- block empty
	end

	ShipGiftItem.New(arg_13_2, arg_13_0):didEnter(arg_13_0.shipVO, arg_13_0.giftList[arg_13_1 + 1], arg_13_1, arg_13_0.selectCnt, arg_13_0.selectIndex)

	return
end

function var_0_0.ScrollReturn(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0.giftItemList[arg_14_2] then
		-- block empty
	end

	ShipGiftItem.New(arg_14_2, arg_14_0):willExit()

	return
end

function var_0_0.RefreshScroll(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.giftItemList) do
		iter_15_1:RefreshUI(arg_15_0.selectIndex, arg_15_0.selectCnt)
	end

	return
end

function var_0_0.RefreshUI(arg_16_0)
	setImageSprite(arg_16_0.intimacyIcon, GetSpriteFromAtlas("energy", arg_16_0.shipVO:getIntimacyIcon()), true)

	local var_16_0, var_16_1 = arg_16_0.shipVO:getIntimacyDetail()

	setText(arg_16_0.intimacyValueText, var_16_1)
	arg_16_0.scrollRect:SetTotalCount(#arg_16_0.giftList)

	return
end

function var_0_0.updatePreference(arg_17_0)
	setScrollText(arg_17_0.shipName, (arg_17_0.shipVO:getName()))
	setText(arg_17_0.shipNameEn, arg_17_0.shipVO:getConfigTable().english_name)
	removeAllChildren(arg_17_0.starts)

	local var_17_0 = arg_17_0.shipVO:getStar()

	for iter_17_0 = 1, arg_17_0.shipVO:getMaxStar() do
		local var_17_1 = cloneTplTo(arg_17_0.shipInfoStarTpl, arg_17_0.starts, "star_" .. iter_17_0)

		setActive(var_17_1:Find("star_tpl"), iter_17_0 <= var_17_0)
		setActive(var_17_1:Find("empty_star_tpl"), true)
	end

	setImageSprite(arg_17_0.shipType, GetSpriteFromAtlas("shiptype", arg_17_0.shipVO:getShipType()), true)

	return
end

function var_0_0.OnGiftSuccess(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.giftList[arg_18_0.selectIndex + 1]
	local var_18_1 = ShipGiftTools.GetItemFavoriteState(arg_18_0.shipVO, arg_18_0.giftList[arg_18_0.selectIndex + 1])

	if var_18_1 == ShipGiftConst.GIFT_FAVORITE_STATE.HATE then
		arg_18_0:displayShipWord("gift_dislike", true)
		ShipExpressionHelper.SetExpression(arg_18_0.painting:GetChild(0), arg_18_0.shipVO:getPainting(), "gift_dislike")
	else
		arg_18_0:displayShipWord("gift_prefer", true)
		ShipExpressionHelper.SetExpression(arg_18_0.painting:GetChild(0), arg_18_0.shipVO:getPainting(), "gift_prefer")
	end

	local var_18_3 = (arg_18_0.selectCnt - arg_18_1) * ShipGiftTools.GetItemIntimacyValue(arg_18_0.shipVO, var_18_0)

	if var_18_3 > 0 then
		setText(arg_18_0.intimacyAddValueText, string.format("+%s", var_18_3 / 100))
		arg_18_0:PlayAddValueAnimation()
		setActive(arg_18_0.intimacyAddValueText, true)
	else
		setActive(arg_18_0.intimacyAddValueText, false)
	end

	arg_18_0:StopWaitClickTimer()

	arg_18_0.waitClickTimer = FrameTimer.New(function()
		if Input.anyKeyDown then
			arg_18_0:ClickBackGift()
		end

		return
	end, 1, -1)

	arg_18_0.waitClickTimer:Start()
	arg_18_0:StopAutoClickTimer()

	arg_18_0.autoClickTimer = Timer.New(function()
		arg_18_0:ClickBackGift()

		return
	end, 1.5, 1)

	arg_18_0.autoClickTimer:Start()

	if var_18_3 > 0 then
		arg_18_0:emit(ShipGiftMediator.ADD_SHIP_INTIMACY, arg_18_0.shipVO, var_18_3)
	end

	arg_18_0.shipVO = getProxy(BayProxy):getShipById(arg_18_0.contextData.shipID)
	arg_18_0.giftList = ShipGiftTools.GetGiftList(arg_18_0.shipVO)
	arg_18_0.selectIndex = nil
	arg_18_0.selectCnt = 0

	arg_18_0:RefreshUI()

	local var_18_4 = var_18_1 == ShipGiftConst.GIFT_FAVORITE_STATE.HATE

	eachChild(arg_18_0.adapt:Find("VX"), function(arg_21_0, arg_21_1)
		setActive(arg_21_0, not var_18_4)

		return
	end)
	arg_18_0.anim:Play("anim_ShipGiftUI_success")

	return
end

function var_0_0.displayShipWord(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_2 or not arg_22_0.chatFlag then
		arg_22_0.chatFlag = true
		arg_22_0.chat.localScale = Vector3.zero

		setActive(arg_22_0.chat, true)

		local var_22_0, var_22_1, var_22_2 = ShipWordHelper.GetWordAndCV(arg_22_0.shipVO:getSkinId(), arg_22_1, nil, nil, (arg_22_0.shipVO:getCVIntimacy()))

		if var_22_2 == "" then
			var_22_2 = arg_22_1 == "gift_dislike" and arg_22_0.shipVO:getName() .. i18n("gift_giving_dislike") or arg_22_0.shipVO:getName() .. i18n("gift_giving_prefer")
		end

		local var_22_3 = arg_22_0.chatText:GetComponent(typeof(Text))

		if PLATFORM_CODE ~= PLATFORM_US then
			setText(arg_22_0.chatText, SwitchSpecialChar(var_22_2))
		else
			var_22_3.fontSize = arg_22_0.initfontSize

			setTextEN(arg_22_0.chatText, var_22_2)

			while var_22_3.preferredHeight > arg_22_0.initChatTextH do
				var_22_3.fontSize = var_22_3.fontSize - 2

				setTextEN(arg_22_0.chatText, var_22_2)

				if var_22_3.fontSize < 20 then
					break
				end
			end
		end

		var_22_3.alignment = #var_22_3.text > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

		local var_22_4 = var_22_3.preferredHeight + 120

		arg_22_0.chatBg.sizeDelta = var_22_3.preferredHeight + 120 > arg_22_0.initChatBgH and Vector2.New(arg_22_0.chatBg.sizeDelta.x, var_22_4) or Vector2.New(arg_22_0.chatBg.sizeDelta.x, arg_22_0.initChatBgH)

		local var_22_5 = var_0_2

		local function var_22_6()
			if arg_22_0.chatFlag then
				if arg_22_0.chatani1Id then
					LeanTween.cancel(arg_22_0.chatani1Id)
				end

				if arg_22_0.chatani2Id then
					LeanTween.cancel(arg_22_0.chatani2Id)
				end
			end

			local var_23_0 = arg_22_0

			var_23_0.chatani1Id = LeanTween.scale(rtf(arg_22_0.chat.gameObject), Vector3.New(1, 1, 1), var_0_1):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
				arg_22_0.chatani2Id = LeanTween.scale(rtf(arg_22_0.chat.gameObject), Vector3.New(0, 0, 1), var_0_1):setEase(LeanTweenType.easeInBack):setDelay(var_0_1 + var_22_5):setOnComplete(System.Action(function()
					arg_22_0.chatFlag = nil

					return
				end)).uniqueId

				return
			end)).uniqueId

			return
		end

		if var_22_1 then
			arg_22_0:StopPreVoice()
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_22_1, function(arg_26_0)
				if arg_26_0 then
					var_22_5 = arg_26_0:GetLength() * 0.001
				end

				var_22_6()

				return
			end)

			arg_22_0.preVoiceContent = var_22_1
		else
			(function()
				if arg_22_0.chatFlag then
					if arg_22_0.chatani1Id then
						LeanTween.cancel(arg_22_0.chatani1Id)
					end

					if arg_22_0.chatani2Id then
						LeanTween.cancel(arg_22_0.chatani2Id)
					end
				end

				local var_23_0 = arg_22_0

				var_23_0.chatani1Id = LeanTween.scale(rtf(arg_22_0.chat.gameObject), Vector3.New(1, 1, 1), var_0_1):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
					arg_22_0.chatani2Id = LeanTween.scale(rtf(arg_22_0.chat.gameObject), Vector3.New(0, 0, 1), var_0_1):setEase(LeanTweenType.easeInBack):setDelay(var_0_1 + var_22_5):setOnComplete(System.Action(function()
						arg_22_0.chatFlag = nil

						return
					end)).uniqueId

					return
				end)).uniqueId

				return
			end)()
		end
	end

	return
end

function var_0_0.StopPreVoice(arg_27_0)
	if arg_27_0.preVoiceContent ~= nil then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(arg_27_0.preVoiceContent)
	end

	return
end

function var_0_0.ShowPanel(arg_28_0)
	arg_28_0.anim:Play("anim_ShipGiftUI_success_re")

	return
end

function var_0_0.PlayAddValueAnimation(arg_29_0)
	setActive(arg_29_0.intimacyAddValueText, true)

	arg_29_0.intimacyAddValueText.localPosition = Vector2(arg_29_0.intimacyAddValuePos.x, arg_29_0.intimacyAddValuePos.y)

	arg_29_0:managedTween(LeanTween.moveY, nil, arg_29_0.intimacyAddValueText, arg_29_0.intimacyAddValuePos.y + 20, 0.35):setOnComplete(System.Action(function()
		setActive(arg_29_0.intimacyAddValueText, false)

		return
	end))

	return
end

function var_0_0.ClickBackGift(arg_31_0)
	arg_31_0:StopWaitClickTimer()
	arg_31_0:StopAutoClickTimer()
	arg_31_0:ShowPanel()
	ShipExpressionHelper.SetExpression(arg_31_0.painting:GetChild(0), arg_31_0.shipVO:getPainting())

	return
end

function var_0_0.StopWaitClickTimer(arg_32_0)
	if arg_32_0.waitClickTimer then
		arg_32_0.waitClickTimer:Stop()

		arg_32_0.waitClickTimer = nil
	end

	return
end

function var_0_0.StopAutoClickTimer(arg_33_0)
	if arg_33_0.autoClickTimer then
		arg_33_0.autoClickTimer:Stop()

		arg_33_0.autoClickTimer = nil
	end

	return
end

function var_0_0.OnSelectItem(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0.selectIndex = arg_34_2
	arg_34_0.selectCnt = ShipGiftTools.GetNeedMinCnt(arg_34_0.shipVO, arg_34_0.giftList[arg_34_2 + 1])

	arg_34_0:RefreshScroll()

	return
end

function var_0_0.OnRefreshUseItemCnt(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0.selectCnt = arg_35_2

	return
end

function var_0_0.onBackPressed(arg_36_0)
	if arg_36_0.waitClickTimer then
		arg_36_0:ClickBackGift()

		return
	end

	var_0_0.super.onBackPressed(arg_36_0)

	return
end

return var_0_0
