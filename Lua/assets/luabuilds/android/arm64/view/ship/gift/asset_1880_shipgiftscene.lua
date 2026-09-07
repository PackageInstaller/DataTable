local ShipGiftScene = class("ShipGiftScene", import("view.base.BaseUI"))
local var_0_1 = 0.3
local var_0_2 = 3

function ShipGiftScene:getUIName()
	return "ShipGiftUI"
end

function ShipGiftScene:ResUISettings()
	return true
end

function ShipGiftScene:init()
	self.adapt = self._tf:Find("adapt")
	self.topPanel = self._tf:Find("adapt/top")
	self.backBtn = self._tf:Find("adapt/top/back_btn")
	self.homeBtn = self._tf:Find("adapt/top/option")
	self.bgTf = self._tf:Find("bgGo")
	self.imageGrass = self._tf:Find("bgGo/ImageGrass")
	self.character = self._tf:Find("adapt/content")
	self.chat = self._tf:Find("adapt/content/chat")
	self.chatBg = self._tf:Find("adapt/content/chat/chatbgtop")
	self.chatText = self._tf:Find("adapt/content/chat/Text")
	rtf(self.chat).localScale = Vector3.New(0, 0, 1)
	self.initChatBgH = self.chatBg.sizeDelta.y
	self.initChatTextH = self.chatText.sizeDelta.y
	self.initfontSize = self.chatText:GetComponent(typeof(Text)).fontSize
	self.namePanel = self._tf:Find("adapt/name")
	self.shipName = self._tf:Find("adapt/name/nameRect/name_mask/Text")
	self.shipNameEn = self._tf:Find("adapt/name/english_name")
	self.starts = self._tf:Find("adapt/name/stars")
	self.shipInfoStarTpl = self._tf:Find("adapt/name/star_tpl")
	self.shipType = self._tf:Find("adapt/name/type")
	self.intimacyIcon = self._tf:Find("adapt/intimacy/icon")
	self.intimacyValueText = self._tf:Find("adapt/intimacy/value")
	self.intimacyAddValueText = GetComponent(self._tf:Find("adapt/intimacy/addValue"), typeof(RectTransform))
	self.painting = self.adapt:Find("content/paint/fitter")
	self.l2dParent = self.adapt:Find("content/paint/live2d")
	self.spineParent = self.adapt:Find("content/paint/spinePainting")
	self.effectParent = self.adapt:Find("content/paint/effect")
	self.intimacyAddValuePos = self.intimacyAddValueText.localPosition
	self.rightPanel = self._tf:Find("adapt/right")
	self.scrollRect = GetComponent(self._tf:Find("adapt/right/scrollRect"), "LScrollRect")
	self.giftBtn = self._tf:Find("adapt/right/giftBtn")

	setText(self._tf:Find("adapt/right/titlePanel/title/text"), i18n("ship_gift"))
	setText(self.giftBtn:Find("label"), i18n("ship_gift2"))
	setActive(self.intimacyAddValueText, false)

	self.giftItemList = {}
	self.anim = self._tf:GetComponent(typeof(Animation))

	return
end

function ShipGiftScene:didEnter()
	self._tf:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_5_0)
		self:closeView()

		return
	end)
	onButton(self, self.backBtn, function()
		self.anim:Play("anim_ShipGiftUI_out")

		return
	end, SFX_CANEL)
	onButton(self, self.homeBtn, function()
		self:emit(ShipGiftScene.ON_HOME)

		return
	end, SFX_CANEL)
	onButton(self, self.giftBtn, function()
		if self.selectIndex == nil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("shipyard_gift_non_existent"))

			return
		end

		local var_8_0 = ShipGiftTools.GetShipNeedIntimacyValue(self.shipVO)

		if var_8_0 == 0 then
			if self.shipVO.propose then
				pg.TipsMgr.GetInstance():ShowTips(i18n("shipyard_favorability_max"))
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("shipyard_favorability_threshold"))
			end

			return
		end

		if self.selectCnt == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("shipyard_gift_non_existent"))

			return
		end

		local var_8_1 = self.selectCnt
		local var_8_2 = self.giftList[self.selectIndex + 1].id
		local var_8_3 = ShipGiftTools.GetItemIntimacyValue(self.shipVO, self.giftList[self.selectIndex + 1]) * self.selectCnt - var_8_0

		if var_8_3 > 0 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("shipyard_favorability_exceed", math.floor(var_8_3 / 100)),
				onYes = function()
					self:emit(ShipGiftMediator.SHIP_GIFT, var_8_2, var_8_1, self.shipVO.id)

					return
				end
			})
		else
			self:emit(ShipGiftMediator.SHIP_GIFT, self.giftList[self.selectIndex + 1].id, var_8_1, self.shipVO.id)
		end

		return
	end, SFX_PANEL)

	self.scrollRect.onInitItem = handler(self, self.ScrollInit)
	self.scrollRect.onUpdateItem = handler(self, self.ScrollUpdate)
	self.scrollRect.onReturnItem = handler(self, self.ScrollReturn)
	self.shipVO = getProxy(BayProxy):getShipById(self.contextData.shipID)
	self.giftList = ShipGiftTools.GetGiftList(self.shipVO)
	self.shipLoadClass = ShipLoad.New(function(arg_10_0)
		setParent(arg_10_0.transform, self.painting)

		return
	end)

	self.shipLoadClass:LoadShip(self.contextData.shipID)
	self:updatePreference()
	self:RefreshUI()
	self:OverlayPanel(self.bgTf, {
		pbList = {
			self.imageGrass
		}
	})
	self:OverlayPanel(self.adapt)

	self.selectIndex = nil
	self.eventList = {
		self:bind(ShipGiftItem.SELECT_ITEM, handler(self, self.OnSelectItem)),
		self:bind(ShipGiftItem.REFRESH_USE_ITEM_CNT, handler(self, self.OnRefreshUseItemCnt))
	}

	return
end

function ShipGiftScene:willExit()
	self:StopPreVoice()

	for iter_11_0, iter_11_1 in ipairs(self.eventList) do
		self:disconnect(iter_11_1)
	end

	self.eventList = nil

	self:StopWaitClickTimer()
	self:StopAutoClickTimer()
	ClearLScrollrect(self.scrollRect)

	for iter_11_2, iter_11_3 in pairs(self.giftItemList) do
		iter_11_3:willExit()
	end

	self.giftItemList = nil

	self.shipLoadClass:Dispose()

	self.shipLoadClass = nil

	self:UnOverlayPanel(self.bgTf, self._tf)
	self:UnOverlayPanel(self.adapt, self._tf)

	return
end

function ShipGiftScene:ScrollInit(arg_12_1)
	self.giftItemList[arg_12_1] = ShipGiftItem.New(arg_12_1, self)

	return
end

function ShipGiftScene:ScrollUpdate(arg_13_1, arg_13_2)
	if not self.giftItemList[arg_13_2] then
		-- block empty
	end

	ShipGiftItem.New(arg_13_2, self):didEnter(self.shipVO, self.giftList[arg_13_1 + 1], arg_13_1, self.selectCnt, self.selectIndex)

	return
end

function ShipGiftScene:ScrollReturn(arg_14_1, arg_14_2)
	if not self.giftItemList[arg_14_2] then
		-- block empty
	end

	ShipGiftItem.New(arg_14_2, self):willExit()

	return
end

function ShipGiftScene:RefreshScroll()
	for iter_15_0, iter_15_1 in pairs(self.giftItemList) do
		iter_15_1:RefreshUI(self.selectIndex, self.selectCnt)
	end

	return
end

function ShipGiftScene:RefreshUI()
	setImageSprite(self.intimacyIcon, GetSpriteFromAtlas("energy", self.shipVO:getIntimacyIcon()), true)

	local var_16_0, var_16_1 = self.shipVO:getIntimacyDetail()

	setText(self.intimacyValueText, var_16_1)
	self.scrollRect:SetTotalCount(#self.giftList)

	return
end

function ShipGiftScene:updatePreference()
	setScrollText(self.shipName, (self.shipVO:getName()))
	setText(self.shipNameEn, self.shipVO:getConfigTable().english_name)
	removeAllChildren(self.starts)

	local var_17_0 = self.shipVO:getStar()

	for iter_17_0 = 1, self.shipVO:getMaxStar() do
		local var_17_1 = cloneTplTo(self.shipInfoStarTpl, self.starts, "star_" .. iter_17_0)

		setActive(var_17_1:Find("star_tpl"), iter_17_0 <= var_17_0)
		setActive(var_17_1:Find("empty_star_tpl"), true)
	end

	setImageSprite(self.shipType, GetSpriteFromAtlas("shiptype", self.shipVO:getShipType()), true)

	return
end

function ShipGiftScene:OnGiftSuccess(arg_18_1)
	local var_18_0 = self.giftList[self.selectIndex + 1]
	local var_18_1 = ShipGiftTools.GetItemFavoriteState(self.shipVO, self.giftList[self.selectIndex + 1])

	if var_18_1 == ShipGiftConst.GIFT_FAVORITE_STATE.HATE then
		self:displayShipWord("gift_dislike", true)
		ShipExpressionHelper.SetExpression(self.painting:GetChild(0), self.shipVO:getPainting(), "gift_dislike")
	else
		self:displayShipWord("gift_prefer", true)
		ShipExpressionHelper.SetExpression(self.painting:GetChild(0), self.shipVO:getPainting(), "gift_prefer")
	end

	local var_18_3 = (self.selectCnt - arg_18_1) * ShipGiftTools.GetItemIntimacyValue(self.shipVO, var_18_0)

	if var_18_3 > 0 then
		setText(self.intimacyAddValueText, string.format("+%s", var_18_3 / 100))
		self:PlayAddValueAnimation()
		setActive(self.intimacyAddValueText, true)
	else
		setActive(self.intimacyAddValueText, false)
	end

	self:StopWaitClickTimer()

	self.waitClickTimer = FrameTimer.New(function()
		if Input.anyKeyDown then
			self:ClickBackGift()
		end

		return
	end, 1, -1)

	self.waitClickTimer:Start()
	self:StopAutoClickTimer()

	self.autoClickTimer = Timer.New(function()
		self:ClickBackGift()

		return
	end, 1.5, 1)

	self.autoClickTimer:Start()

	if var_18_3 > 0 then
		self:emit(ShipGiftMediator.ADD_SHIP_INTIMACY, self.shipVO, var_18_3)
	end

	self.shipVO = getProxy(BayProxy):getShipById(self.contextData.shipID)
	self.giftList = ShipGiftTools.GetGiftList(self.shipVO)
	self.selectIndex = nil
	self.selectCnt = 0

	self:RefreshUI()

	local var_18_4 = var_18_1 == ShipGiftConst.GIFT_FAVORITE_STATE.HATE

	eachChild(self.adapt:Find("VX"), function(arg_21_0, arg_21_1)
		setActive(arg_21_0, not var_18_4)

		return
	end)
	self.anim:Play("anim_ShipGiftUI_success")

	return
end

function ShipGiftScene:displayShipWord(arg_22_1, arg_22_2)
	if arg_22_2 or not self.chatFlag then
		self.chatFlag = true
		self.chat.localScale = Vector3.zero

		setActive(self.chat, true)

		local var_22_0, var_22_1, var_22_2 = ShipWordHelper.GetWordAndCV(self.shipVO:getSkinId(), arg_22_1, nil, nil, (self.shipVO:getCVIntimacy()))

		if var_22_2 == "" then
			var_22_2 = arg_22_1 == "gift_dislike" and self.shipVO:getName() .. i18n("gift_giving_dislike") or self.shipVO:getName() .. i18n("gift_giving_prefer")
		end

		local var_22_3 = self.chatText:GetComponent(typeof(Text))

		if PLATFORM_CODE ~= PLATFORM_US then
			setText(self.chatText, SwitchSpecialChar(var_22_2))
		else
			var_22_3.fontSize = self.initfontSize

			setTextEN(self.chatText, var_22_2)

			while var_22_3.preferredHeight > self.initChatTextH do
				var_22_3.fontSize = var_22_3.fontSize - 2

				setTextEN(self.chatText, var_22_2)

				if var_22_3.fontSize < 20 then
					break
				end
			end
		end

		var_22_3.alignment = #var_22_3.text > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter
		self.chatBg.sizeDelta = var_22_3.preferredHeight + 120 > self.initChatBgH and Vector2.New(self.chatBg.sizeDelta.x, var_22_3.preferredHeight + 120) or Vector2.New(self.chatBg.sizeDelta.x, self.initChatBgH)

		local var_22_4 = var_0_2

		local function var_22_5()
			if self.chatFlag then
				if self.chatani1Id then
					LeanTween.cancel(self.chatani1Id)
				end

				if self.chatani2Id then
					LeanTween.cancel(self.chatani2Id)
				end
			end

			self.chatani1Id = LeanTween.scale(rtf(self.chat.gameObject), Vector3.New(1, 1, 1), var_0_1):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
				self.chatani2Id = LeanTween.scale(rtf(self.chat.gameObject), Vector3.New(0, 0, 1), var_0_1):setEase(LeanTweenType.easeInBack):setDelay(var_0_1 + var_22_4):setOnComplete(System.Action(function()
					self.chatFlag = nil

					return
				end)).uniqueId

				return
			end)).uniqueId

			return
		end

		if var_22_1 then
			self:StopPreVoice()
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_22_1, function(arg_26_0)
				if arg_26_0 then
					var_22_4 = arg_26_0:GetLength() * 0.001
				end

				var_22_5()

				return
			end)

			self.preVoiceContent = var_22_1
		else
			var_22_5()
		end
	end

	return
end

function ShipGiftScene:StopPreVoice()
	if self.preVoiceContent ~= nil then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(self.preVoiceContent)
	end

	return
end

function ShipGiftScene:ShowPanel()
	self.anim:Play("anim_ShipGiftUI_success_re")

	return
end

function ShipGiftScene:PlayAddValueAnimation()
	setActive(self.intimacyAddValueText, true)

	self.intimacyAddValueText.localPosition = Vector2(self.intimacyAddValuePos.x, self.intimacyAddValuePos.y)

	self:managedTween(LeanTween.moveY, nil, self.intimacyAddValueText, self.intimacyAddValuePos.y + 20, 0.35):setOnComplete(System.Action(function()
		setActive(self.intimacyAddValueText, false)

		return
	end))

	return
end

function ShipGiftScene:ClickBackGift()
	self:StopWaitClickTimer()
	self:StopAutoClickTimer()
	self:ShowPanel()
	ShipExpressionHelper.SetExpression(self.painting:GetChild(0), self.shipVO:getPainting())

	return
end

function ShipGiftScene:StopWaitClickTimer()
	if self.waitClickTimer then
		self.waitClickTimer:Stop()

		self.waitClickTimer = nil
	end

	return
end

function ShipGiftScene:StopAutoClickTimer()
	if self.autoClickTimer then
		self.autoClickTimer:Stop()

		self.autoClickTimer = nil
	end

	return
end

function ShipGiftScene:OnSelectItem(arg_34_1, arg_34_2)
	self.selectIndex = arg_34_2
	self.selectCnt = ShipGiftTools.GetNeedMinCnt(self.shipVO, self.giftList[arg_34_2 + 1])

	self:RefreshScroll()

	return
end

function ShipGiftScene:OnRefreshUseItemCnt(arg_35_1, arg_35_2)
	self.selectCnt = arg_35_2

	return
end

function ShipGiftScene:onBackPressed()
	if self.waitClickTimer then
		self:ClickBackGift()

		return
	end

	ShipGiftScene.super.onBackPressed(self)

	return
end

return ShipGiftScene
