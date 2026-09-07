local AwardInfoLayer = class("AwardInfoLayer", import("..base.BaseUI"))

AwardInfoLayer.TITLE = {
	COMMANDER = "commander",
	RYZA = "ryza",
	ITEM = "item",
	SHIP = "ship",
	REVERT = "revert",
	ESCORT = "escort"
}

local var_0_1 = 0.15
local var_0_2 = 340
local var_0_3 = 564

function AwardInfoLayer:getUIName()
	return "AwardInfoUI"
end

function AwardInfoLayer:init()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.awards = _.select(self.contextData.items or {}, function(arg_3_0)
		return arg_3_0.type ~= DROP_TYPE_ICON_FRAME and arg_3_0.type ~= DROP_TYPE_CHAT_FRAME and arg_3_0.type ~= DROP_TYPE_LIVINGAREA_COVER
	end)
	self._itemsWindow = self._tf:Find("items")
	self.spriteMask = self._itemsWindow:Find("SpriteMask")
	self.title = self.contextData.title or AwardInfoLayer.TITLE.ITEM

	for iter_2_0, iter_2_1 in pairs(AwardInfoLayer.TITLE) do
		setActive(self._itemsWindow:Find("titles/title_" .. iter_2_1), self.title == iter_2_1)
	end

	if self.title == AwardInfoLayer.TITLE.COMMANDER then
		eachChild(self._itemsWindow:Find("titles/title_commander"), function(arg_4_0)
			setActive(arg_4_0, arg_4_0.name == self.contextData.titleExtra)

			return
		end)
	end

	local var_2_0 = {
		items_scroll = self._itemsWindow:Find("items_scroll/content"),
		ships = self._itemsWindow:Find("ships")
	}

	if self.title == AwardInfoLayer.TITLE.SHIP then
		self.container = var_2_0.ships
	else
		self.container = var_2_0.items_scroll

		scrollTo(self.container, nil, 1)

		self.windowLayout = self._itemsWindow:Find("items_scroll"):GetComponent(typeof(LayoutElement))
	end

	GetOrAddComponent(self.container, "CanvasGroup").alpha = 1

	for iter_2_2, iter_2_3 in pairs(var_2_0) do
		setActive(self._itemsWindow:Find(iter_2_2), self.container == iter_2_3)
	end

	setLocalScale(self._itemsWindow, Vector3(0.5, 0.5, 0.5))

	self.itemTpl = self._itemsWindow:Find("item_tpl")
	self.shipTpl = self._itemsWindow:Find("ship_tpl")
	self.extraBouns = self._itemsWindow:Find("titles/extra_bouns")

	setActive(self.extraBouns, self.contextData.extraBonus)

	self.continueBtn = self._tf:Find("items/close")

	local var_2_1 = self._tf:Find("decorations")

	if self.title == AwardInfoLayer.TITLE.SHIP then
		setLocalScale(var_2_1, Vector3.New(1.25, 1.25, 1))
	else
		setLocalScale(var_2_1, Vector3.one)
	end

	self.blinks = {}
	self.tweenItems = {}
	self.shipCardTpl = self._tf:Find("ShipCardTpl")

	self._tf:SetAsLastSibling()

	self.metaRepeatAwardTF = self._tf:Find("MetaShipRepeatAward")

	return
end

function AwardInfoLayer:doAnim(arg_5_1)
	LeanTween.scale(rtf(self._itemsWindow), Vector3(1, 1, 1), 0.15):setEase(LeanTweenType.linear):setOnComplete(System.Action(function()
		if self.exited then
			return
		end

		arg_5_1()

		return
	end))

	return
end

function AwardInfoLayer:playAnim(arg_7_1)
	local var_7_0 = {}

	for iter_7_0 = 1, #self.awards do
		table.insert(var_7_0, function(arg_8_0)
			setActive(self.container:GetChild(iter_7_0 - 1), true)

			if self.windowLayout then
				if iter_7_0 > 5 and self.windowLayout.preferredHeight ~= var_0_3 then
					self.windowLayout.preferredHeight = var_0_3

					self:updateSpriteMaskScale()
				end

				if iter_7_0 % 5 == 1 then
					scrollTo(self.container, nil, 0)
				end
			end

			self.tweeningId = LeanTween.delayedCall(var_0_1, System.Action(arg_8_0)).uniqueId

			return
		end)
	end

	seriesAsync(var_7_0, function()
		self.tweeningId = nil

		if arg_7_1 then
			arg_7_1()
		end

		return
	end)

	return
end

function AwardInfoLayer:didEnter()
	setActive(self.spriteMask, true)
	onButton(self, self._tf, function()
		self:checkPaintingRes(function()
			if self.tweeningId then
				LeanTween.cancel(self.tweeningId)

				self.tweeningId = nil
			end

			self:emit(AwardInfoLayer.ON_CLOSE)

			return
		end)

		return
	end, SFX_CANCEL, {
		noShip = not self.hasShip
	})
	onButton(self, self.continueBtn, function()
		triggerButton(self._tf)

		return
	end)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_GETITEM)

	local var_10_0 = {}

	table.insert(var_10_0, function(arg_14_0)
		self:doAnim(arg_14_0)

		return
	end)
	self:displayAwards()

	if self.contextData.animation then
		eachChild(self.container, function(arg_15_0)
			setActive(arg_15_0, false)

			return
		end)

		GetOrAddComponent(self.container, "CanvasGroup").alpha = 0

		table.insert(var_10_0, function(arg_16_0)
			GetOrAddComponent(self.container, "CanvasGroup").alpha = 1

			self:playAnim(arg_16_0)

			return
		end)
	end

	if self.windowLayout then
		if not self.contextData.animation and #self.awards > 5 then
			self.windowLayout.preferredHeight = var_0_3 or var_0_2
		end

		self:updateSpriteMaskScale()
	end

	seriesAsync(var_10_0, function()
		if self.exited then
			return
		end

		if self.contextData.closeOnCompleted then
			triggerButton(self._tf)
		end

		if self.enterCallback then
			self.enterCallback()

			self.enterCallback = nil
		end

		return
	end)

	if self.contextData.auto then
		self:AddCloseTimer()
	end

	return
end

function AwardInfoLayer:RemoveCloseTimer()
	if self.closeTimer then
		self.closeTimer:Stop()

		self.closeTimer = nil
	end

	return
end

function AwardInfoLayer:AddCloseTimer()
	self:RemoveCloseTimer()

	self.closeTimer = Timer.New(function()
		self:RemoveCloseTimer()
		triggerButton(self._tf)

		return
	end, self.contextData.auto or 2, 1)

	self.closeTimer:Start()

	return
end

function AwardInfoLayer:onUIAnimEnd(arg_21_1)
	self.enterCallback = arg_21_1

	return
end

function AwardInfoLayer:onBackPressed()
	if LeanTween.isTweening(go(self._itemsWindow)) then
		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(self._tf)

	return
end

local function var_0_4(arg_23_0, arg_23_1)
	local var_23_1 = Ship.New({
		configId = arg_23_1.id
	})

	var_23_1.virgin = arg_23_1.virgin

	setScrollText(findTF(arg_23_0, "content/info/name_mask/name"), var_23_1:GetColorName())
	flushShipCard(arg_23_0, var_23_1)
	setActive(findTF(arg_23_0, "content/front/new"), arg_23_1.virgin)

	return
end

function AwardInfoLayer:displayAwards()
	assert(#self.awards ~= 0, "items数量不能为0")
	removeAllChildren(self.container)

	for iter_24_0 = 1, #self.awards do
		if self.title ~= AwardInfoLayer.TITLE.SHIP then
			cloneTplTo(self.itemTpl, self.container)
		else
			setActive(cloneTplTo(self.shipCardTpl, cloneTplTo(self.shipTpl, self.container), "ship_tpl"), true)
		end
	end

	if self.title ~= AwardInfoLayer.TITLE.SHIP then
		for iter_24_1 = 1, #self.awards do
			local var_24_0 = self.container:GetChild(iter_24_1 - 1):Find("bg")
			local var_24_1 = self.awards[iter_24_1]

			if self.awards[iter_24_1].type == DROP_TYPE_SHIP then
				self.hasShip = true
			end

			updateDrop(var_24_0, self.awards[iter_24_1], {
				fromAwardLayer = true
			})
			setActive(findTF(var_24_0, "icon_bg/bonus"), self.awards[iter_24_1].riraty)
			setActive(findTF(var_24_0, "icon_bg/bonus_catchup"), self.awards[iter_24_1].catchupTag)
			setActive(findTF(var_24_0, "icon_bg/bonus_event"), self.awards[iter_24_1].catchupActTag)

			local var_24_2 = findTF(var_24_0, "name")
			local var_24_3 = findTF(var_24_0, "name_mask")

			setActive(var_24_2, false)
			setActive(var_24_3, true)
			setScrollText(findTF(var_24_0, "name_mask/name"), self.awards[iter_24_1].name or getText(var_24_2))
			onButton(self, var_24_0, function()
				if self.tweeningId then
					return
				end

				self:emit(AwardInfoMediator.ON_DROP, var_24_1)

				return
			end, SFX_PANEL)
		end
	else
		for iter_24_2 = 1, #self.awards do
			local var_24_5 = self.container:GetChild(iter_24_2 - 1):Find("ship_tpl")

			var_0_4(var_24_5, self.awards[iter_24_2])

			if self.awards[iter_24_2].reMetaSpecialItemVO then
				local var_24_6 = cloneTplTo(self.metaRepeatAwardTF, var_24_5)

				setLocalPosition(var_24_6, Vector3.zero)
				setLocalScale(var_24_6, Vector3.zero)

				local var_24_7 = var_24_6:Find("item_tpl/bg")

				updateDrop(var_24_7, self.awards[iter_24_2].reMetaSpecialItemVO)
				setActive(var_24_7:Find("name"), false)
				setActive(var_24_7:Find("name_mask"), true)
				var_24_7:Find("name_mask/name"):GetComponent("ScrollText"):SetText(self.awards[iter_24_2].reMetaSpecialItemVO.cfg.name)
				self:managedTween(LeanTween.delayedCall, function()
					self:managedTween(LeanTween.value, nil, go(var_24_6), 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_27_0)
						setLocalScale(var_24_6, {
							x = arg_27_0,
							y = arg_27_0
						})

						return
					end)):setOnComplete(System.Action(function()
						setLocalScale(var_24_6, Vector3.one)

						return
					end))

					return
				end, 0.3, nil)
			end

			if #self.awards > 5 then
				var_24_5.anchoredPosition = iter_24_2 <= 5 and Vector2.New(-50, 0) or Vector2.New(50, 0)
			end
		end
	end

	return
end

function AwardInfoLayer:ShowOrHideSpriteMask(arg_29_1)
	if isActive(self.spriteMask) == arg_29_1 then
		return
	end

	setActive(self.spriteMask, arg_29_1)

	return
end

function AwardInfoLayer:willExit()
	self:RemoveCloseTimer()
	setActive(self.spriteMask, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.title ~= AwardInfoLayer.TITLE.SHIP then
		for iter_30_0 = 0, self.container.childCount - 1 do
			clearDrop(self.container:GetChild(iter_30_0):Find("bg"))
		end
	end

	if self.blinks and #self.blinks > 0 then
		for iter_30_1, iter_30_2 in pairs(self.blinks) do
			if not IsNil(iter_30_2) then
				Destroy(iter_30_2)
			end
		end
	end

	if self.contextData.removeFunc then
		self.contextData.removeFunc()

		self.contextData.removeFunc = nil
	end

	return
end

function AwardInfoLayer:updateSpriteMaskScale()
	onNextTick(function()
		if self.exited then
			return
		end

		setLocalScale(self.spriteMask, Vector3(self.spriteMask.rect.width / WHITE_DOT_SIZE * PIXEL_PER_UNIT, self.spriteMask.rect.height / WHITE_DOT_SIZE * PIXEL_PER_UNIT, 1))

		return
	end)

	return
end

function AwardInfoLayer:checkPaintingRes(arg_33_1)
	PaintingGroupConst.PaintingDownload({
		isShowBox = false,
		paintingNameList = PaintingGroupConst.GetPaintingNameListForAwardList(self.awards),
		finishFunc = arg_33_1
	})

	return
end

return AwardInfoLayer
