local ChargeScene = class("ChargeScene", import("...base.BaseUI"))

ChargeScene.TYPE_DIAMOND = 1
ChargeScene.TYPE_GIFT = 2
ChargeScene.TYPE_ITEM = 3
ChargeScene.TYPE_PICK = 4

function ChargeScene:getUIName()
	return "ChargeShopUI"
end

function ChargeScene:onBackPressed()
	self:closeView()

	return
end

function ChargeScene:preload(arg_3_1)
	local var_3_0 = getProxy(ShopsProxy)

	local function var_3_1()
		local var_4_0 = var_3_0:getFirstChargeList()
		local var_4_1 = var_3_0:getChargedList()
		local var_4_2 = var_3_0:GetNormalList()
		local var_4_3 = var_3_0:GetNormalGroupList()

		if var_4_0 then
			self:setFirstChargeIds(var_4_0)
		end

		if var_4_1 then
			self:setChargedList(var_4_1)
		end

		if var_4_2 then
			self:setNormalList(var_4_2)
		end

		if var_4_3 then
			self:setNormalGroupList(var_4_3)
		end

		arg_3_1()

		return
	end

	if var_3_0:ShouldRefreshChargeList() then
		pg.m02:sendNotification(GAME.GET_CHARGE_LIST, {
			callback = var_3_1
		})
	else
		var_3_1()
	end

	return
end

function ChargeScene:setPlayer(arg_5_1)
	self.player = arg_5_1

	return
end

function ChargeScene:setFirstChargeIds(arg_6_1)
	self.firstChargeIds = arg_6_1

	return
end

function ChargeScene:setChargedList(arg_7_1)
	self.chargedList = arg_7_1

	return
end

function ChargeScene:setNormalList(arg_8_1)
	self.normalList = arg_8_1

	return
end

function ChargeScene:setNormalGroupList(arg_9_1)
	self.normalGroupList = arg_9_1

	self:addRefreshTimer(GetZeroTime())

	return
end

function ChargeScene:ResUISettings()
	return true
end

function ChargeScene:init()
	self.blurPanel = self._tf:Find("blur_panel")
	self.top = self.blurPanel:Find("adapt/top")
	self.frame = self._tf:Find("frame")
	self.viewContainer = self._tf:Find("viewContainer")
	self.bg = self._tf:Find("viewContainer/bg")
	self.painting = self._tf:Find("frame/painting")
	self.chat = self._tf:Find("viewContainer/chat")
	self.chatText = self.chat:Find("Text")
	self.switchBtn = self._tf:Find("blur_panel/adapt/switch_btn")
	self.skinShopBtn = self._tf:Find("blur_panel/adapt/skin_btn")

	setActive(self.skinShopBtn, not (LOCK_SKIN_SHOP_ENTER and getProxy(PlayerProxy):getData().level < LOCK_SKIN_SHOP_ENTER_LEVEL))

	self.itemToggle = self.viewContainer:Find("toggle_list/item_toggle")
	self.giftToggle = self.viewContainer:Find("toggle_list/gift_toggle")
	self.diamondToggle = self.viewContainer:Find("toggle_list/diamond_toggle")
	self.giftTip = self.giftToggle:Find("tip")
	self.pickToggle = self.viewContainer:Find("toggle_list/pick_toggle")
	self.pickTip = self.pickToggle:Find("tip")
	self.chargeTipWindow = ChargeTipWindow.New(self._tf, self.event)

	setText(self.diamondToggle:Find("light/title"), i18n("shop_diamond_title"))
	setText(self.diamondToggle:Find("dark/title"), i18n("shop_diamond_title"))
	setText(self.giftToggle:Find("light/title"), i18n("shop_gift_title"))
	setText(self.giftToggle:Find("dark/title"), i18n("shop_gift_title"))
	setText(self.itemToggle:Find("light/title"), i18n("shop_item_title"))
	setText(self.itemToggle:Find("dark/title"), i18n("shop_item_title"))
	setText(self.pickToggle:Find("light/title"), i18n("shop_akashi_pick_title"))
	setText(self.pickToggle:Find("dark/title"), i18n("shop_akashi_pick_title"))

	self.linkTitle = {
		self.top:Find("title/title_diamond"),
		self.top:Find("title/title_gift"),
		self.top:Find("title/title_item"),
		self.top:Find("title/title_pick")
	}
	self.toggleList = {
		self.diamondToggle,
		self.giftToggle,
		self.itemToggle,
		self.pickToggle
	}

	if Live2dConst.GetLive2DArm32MatchAble() then
		local var_11_0 = Ship.New({
			configId = 312011
		}):getPainting()

		LoadPaintingPrefabAsync(self.painting, var_11_0, var_11_0, "mainNormal", function()
			self.loading = false

			return
		end)
	else
		self:createLive2D()
	end

	self.live2dTimer = Timer.New(function()
		local var_13_0 = pg.ChargeShipTalkInfo.Actions[math.random(#pg.ChargeShipTalkInfo.Actions)]

		if self:checkBuyDone(var_13_0.action) then
			self:displayShipWord(nil, false, var_13_0.dialog_index)
		end

		return
	end, 20, -1)

	self.live2dTimer:Start()
	self:jpUIInit()
	self:blurView()
	self:initSubView()

	return
end

function ChargeScene:didEnter()
	setActive(self.chat, false)
	onButton(self, self.top:Find("back_button"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.painting, function()
		self:displayShipWord()
		self:emit(ChargeMediator.CLICK_MING_SHI)

		return
	end, SFX_PANEL)

	for iter_14_0 = 1, #self.toggleList do
		local var_14_0 = self.toggleList[iter_14_0]

		onToggle(self, self.toggleList[iter_14_0], function(arg_17_0)
			setActive(var_14_0:Find("dark"), not arg_17_0)

			if arg_17_0 then
				self:switchSubView(iter_14_0)
			end

			return
		end, SFX_PANEL)
	end

	onButton(self, self.switchBtn, function()
		self:emit(ChargeMediator.SWITCH_TO_SHOP, {
			warp = NewShopsScene.TYPE_SHOP_STREET
		})
		self:stopCV()

		return
	end, SFX_PANEL)
	onButton(self, self.skinShopBtn, function()
		self:emit(ChargeMediator.ON_SKIN_SHOP)

		return
	end, SFX_PANEL)
	self:updateNoRes()

	if self.contextData.wrap ~= nil then
		self:switchSubViewByTogger(self.contextData.wrap)

		self.contextData.wrap = nil
	else
		self:switchSubViewByTogger(ChargeScene.TYPE_DIAMOND)
	end

	self:jpUIEnter()

	return
end

function ChargeScene:OnChargeSuccess(arg_20_1)
	self.chargeTipWindow:ExecuteAction("Show", arg_20_1)

	return
end

function ChargeScene:willExit()
	self:unBlurView()

	if self.chargeTipWindow then
		self.chargeTipWindow:Destroy()

		self.chargeTipWindow = nil
	end

	if self.heartsTimer then
		self.heartsTimer:Stop()

		self.heartsTimer = nil
	end

	if self.live2dChar then
		self.live2dChar:Dispose()
	end

	if self.live2dTimer then
		self.live2dTimer:Stop()

		self.live2dTimer = nil
	end

	if self.giftShopView then
		self.giftShopView:OnDestroy()
	end

	self:stopCV()

	return
end

function ChargeScene:initSubView()
	self.subViewContainer = self.viewContainer:Find("SubView")
	self.diamondShopView = ChargeDiamondShopView.New(self.subViewContainer, self.event, self.contextData)
	self.giftShopView = ChargeGiftShopView.New(self.subViewContainer, self.event, self.contextData)
	self.itemShopView = ChargeItemShopView.New(self.subViewContainer, self.event, self.contextData)
	self.pickShopView = ChargePickShopView.New(self.subViewContainer, self.event, self.contextData)
	self.curSubViewNum = 0
	self.subViewList = {
		[ChargeScene.TYPE_DIAMOND] = self.diamondShopView,
		[ChargeScene.TYPE_GIFT] = self.giftShopView,
		[ChargeScene.TYPE_ITEM] = self.itemShopView,
		[ChargeScene.TYPE_PICK] = self.pickShopView
	}

	return
end

function ChargeScene:switchSubView(arg_23_1)
	if arg_23_1 == self.curSubViewNum then
		return
	end

	self.subViewList[arg_23_1]:setGoodData(self.firstChargeIds, self.chargedList, self.normalList, self.normalGroupList)
	self.subViewList[arg_23_1]:Reset()
	self.subViewList[arg_23_1]:Load()

	if self.subViewList[self.curSubViewNum] then
		self.subViewList[self.curSubViewNum]:Destroy()
	end

	self.curSubViewNum = arg_23_1

	if PLATFORM_CODE == PLATFORM_JP then
		setActive(self.userAgreeBtn3, arg_23_1 == ChargeScene.TYPE_DIAMOND)
		setActive(self.userAgreeBtn4, arg_23_1 == ChargeScene.TYPE_DIAMOND)
	end

	for iter_23_0, iter_23_1 in ipairs(self.linkTitle) do
		setActive(iter_23_1, iter_23_0 == arg_23_1)
	end

	return
end

function ChargeScene:switchSubViewByTogger(arg_24_1)
	triggerToggle(self.toggleList[arg_24_1], true)

	return
end

function ChargeScene:updateCurSubView()
	self.subViewList[self.curSubViewNum]:setGoodData(self.firstChargeIds, self.chargedList, self.normalList, self.normalGroupList)
	self.subViewList[self.curSubViewNum]:reUpdateAll()

	return
end

function ChargeScene:updateNoRes(arg_26_1)
	if not arg_26_1 then
		arg_26_1 = self.contextData.noRes
	else
		self.contextData.noRes = arg_26_1
	end

	if not arg_26_1 or #arg_26_1 <= 0 then
		return
	end

	self.contextData.noRes = {}

	local var_26_0 = getProxy(BagProxy):getData()
	local var_26_1 = ""

	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		if iter_26_1[2] > 0 then
			arg_26_1[iter_26_0][2] = iter_26_1[1] == 59001 and iter_26_1[3] - self.player.gold or iter_26_1[3] - ((var_26_0[iter_26_1[1]] or nil) and (var_26_0[iter_26_1[1]].count or 0))
		end

		if arg_26_1[iter_26_0][2] > 0 then
			table.insert(self.contextData.noRes, arg_26_1[iter_26_0])
		end
	end

	for iter_26_2, iter_26_3 in ipairs(self.contextData.noRes) do
		var_26_1 = var_26_1 .. i18n(iter_26_3[1] == 59001 and "text_noRes_info_tip" or "text_noRes_info_tip2", Item.getConfigData(iter_26_3[1]).name, iter_26_3[2])

		if iter_26_2 < #self.contextData.noRes then
			var_26_1 = var_26_1 .. i18n("text_noRes_info_tip_link")
		end
	end

	if var_26_1 == "" then
		self:displayShipWord(i18n("text_shop_enoughRes_tip"), false)
	else
		self:displayShipWord(i18n("text_shop_noRes_tip", var_26_1), true)
	end

	return
end

function ChargeScene:displayShipWord(arg_27_1, arg_27_2, arg_27_3)
	if not self.chatFlag then
		if not arg_27_1 and self.contextData.noRes and #self.contextData.noRes > 0 then
			setActive(self.chat, false)

			self.chat.transform.localScale = Vector3(0, 0, 1)
		end

		self.chatFlag = true

		if not self.isInitChatPosition then
			self.isInitChatPosition = true

			self:InitChatPosition()
		end

		setActive(self.chat, true)

		local var_27_0 = arg_27_3 or math.random(1, (self.player:getChargeLevel()))
		local var_27_1 = arg_27_3 and pg.pay_level_award[var_27_0].dialog or arg_27_1 or pg.pay_level_award[var_27_0].dialog

		if not arg_27_1 then
			self:playCV(var_27_0)
		end

		setText(self.chatText, var_27_1)

		local var_27_2 = self.chatText:GetComponent(typeof(Text))

		var_27_2.alignment = #var_27_2.text > CHAT_POP_STR_LEN_SHORT and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

		;(function()
			local var_28_0 = 3
			local var_28_1 = 0.3

			LeanTween.scale(rtf(self.chat.gameObject), Vector3.New(1, 1, 1), 0.3):setFrom(Vector3.New(0, 0, 0)):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
				if not arg_27_2 then
					LeanTween.scale(rtf(self.chat.gameObject), Vector3.New(0, 0, 1), var_28_1):setEase(LeanTweenType.easeInBack):setDelay(var_28_1 + var_28_0):setOnComplete(System.Action(function()
						self.chatFlag = nil

						setActive(self.chat, false)

						if self.contextData.noRes and #self.contextData.noRes > 0 then
							self:updateNoRes()
						end

						return
					end))
				else
					self.chatFlag = nil
				end

				return
			end))

			return
		end)()
	end

	return
end

function ChargeScene:InitChatPosition()
	local var_31_0 = self.chat.parent:InverseTransformPoint((self.painting.parent:TransformPoint(self.painting.localPosition + Vector3(-21, -176, 0))))

	self.chat.localPosition = Vector3(var_31_0.x, var_31_0.y, 0)

	return
end

function ChargeScene:playHeartEffect()
	if self.heartsTimer then
		self.heartsTimer:Stop()
	end

	local var_32_0 = self.painting:Find("heartsfly")

	setActive(var_32_0, true)

	self.heartsTimer = Timer.New(function()
		setActive(var_32_0, false)

		return
	end, 1, 1)

	self.heartsTimer:Start()

	return
end

function ChargeScene:createLive2D()
	self.live2dChar = Live2DPainting.New(Live2DPainting.GenerateData({
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
		parent = self._tf:Find("frame/painting/live2d")
	}), function(arg_35_0)
		arg_35_0:setSortingLayer(LayerWeightConst.L2D_DEFAULT_LAYER)

		return
	end)

	return
end

function ChargeScene:checkBuyDone(arg_36_1)
	if not self.live2dChar or not self.live2dChar:IsLoaded() then
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

	local var_36_2 = (self.preAniName == "gold" or self.preAniName == "diamond") and (var_36_0 == "gold" or var_36_0 == "diamond") or not (self.preAniName == "gold" or self.preAniName == "diamond")

	var_36_2 = var_36_0 and self.preAniName ~= var_36_0 and var_36_2

	if var_36_2 then
		self.preAniName = var_36_0

		self.live2dChar:TriggerAction(var_36_0, nil, true)
	end

	return var_36_2
end

function ChargeScene:playCV(arg_37_1)
	local var_37_0

	if pg.pay_level_award[arg_37_1] and pg.pay_level_award[arg_37_1].cv_key ~= "" then
		var_37_0 = "event:/cv/chargeShop/" .. pg.pay_level_award[arg_37_1].cv_key
	end

	if var_37_0 then
		self:stopCV()

		self._currentVoice = var_37_0

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_37_0)
	end

	return
end

function ChargeScene:stopCV()
	if self._currentVoice then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(self._currentVoice)
	end

	self._currentVoice = nil

	return
end

function ChargeScene:blurView()
	pg.UIMgr.GetInstance():OverlayPanel(self.viewContainer, {
		pbList = {
			self.viewContainer:Find("blurBg")
		}
	})

	return
end

function ChargeScene:unBlurView()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.viewContainer, self.frame)

	return
end

function ChargeScene:jpUIInit()
	if PLATFORM_CODE ~= PLATFORM_JP then
		return
	end

	self.userAgreeBtn3 = self._tf:Find("frame/raw1Btn")
	self.userAgreeBtn4 = self._tf:Find("frame/raw2Btn")

	return
end

function ChargeScene:jpUIEnter()
	if PLATFORM_CODE ~= PLATFORM_JP then
		return
	end

	onButton(self, self.userAgreeBtn3, function()
		self:emit(ChargeMediator.OPEN_USER_AGREE, require("ShareCfg.UserAgreement3") or "")

		return
	end, SFX_PANEL)
	onButton(self, self.userAgreeBtn4, function()
		self:emit(ChargeMediator.OPEN_USER_AGREE, require("ShareCfg.UserAgreement4") or "")

		return
	end, SFX_PANEL)

	return
end

function ChargeScene:addRefreshTimer(arg_45_1)
	local function var_45_0()
		if self.refreshTimer then
			self.refreshTimer:Stop()

			self.refreshTimer = nil
		end

		return
	end

	var_45_0()

	self.refreshTimer = Timer.New(function()
		local var_47_0 = arg_45_1 + 1 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_47_0 <= 0 then
			var_45_0()
			self:emit(ChargeMediator.GET_CHARGE_LIST)
		else
			local var_47_1 = pg.TimeMgr.GetInstance():DescCDTime(var_47_0)
		end

		return
	end, 1, -1)

	self.refreshTimer:Start()
	self.refreshTimer.func()

	return
end

function ChargeScene:checkFreeGiftTag()
	TagTipHelper.FreeGiftTag({
		self.giftTip
	})

	return
end

return ChargeScene
