local ChargeScene = class("ChargeScene", import("..base.BaseUI"))

function ChargeScene:getUIName()
	return "BackChargeUI"
end

function ChargeScene:init()
	return
end

function ChargeScene:didEnter()
	self.diamondPanel = findTF(self._tf, "frame/viewContainer/diamondPanel")
	self.blurPanel = self._tf:Find("blur_panel")
	self.detail = self.blurPanel:Find("detail")
	self.damondItems = {}

	setText(findTF(self._tf, "frame/viewContainer/leftPanel/desc"), i18n("Supplement_pay2"))
	setText(findTF(self._tf, "tip"), i18n("Supplement_pay5"))
	self:initDamonds()
	self:refundUpdate()

	return
end

function ChargeScene:refundUpdate()
	self:updateDamondsData()
	self:sortDamondItems()

	if #self.tempDamondVOs <= 0 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			hideNo = true,
			hideClose = true,
			content = i18n("Supplement_pay3"),
			onYes = function()
				Application.Quit()

				return
			end
		})
	end

	return
end

function ChargeScene:setPlayer(arg_6_1)
	self.player = arg_6_1

	return
end

function ChargeScene:setChargedList(arg_7_1)
	self.chargedList = arg_7_1

	return
end

function ChargeScene:initDamonds()
	self.diamondUIItemList = self:initDiamondList(self.diamondPanel)

	return
end

function ChargeScene:confirm(arg_9_1)
	if not arg_9_1 then
		return
	end

	self:emit(BackChargeMediator.CHARGE, arg_9_1.id)

	return
end

function ChargeScene:initDiamondList(arg_10_1)
	local function var_10_0(arg_11_0)
		local var_11_0 = BackChargeDiamondCard.New(arg_11_0, self)

		onButton(self, var_11_0.tr, function()
			self:confirm(var_11_0.goods)

			return
		end, SFX_PANEL)

		self.damondItems[arg_11_0] = var_11_0

		return
	end

	local function var_10_1(arg_13_0, arg_13_1)
		local var_13_0 = self.damondItems[arg_13_1]

		if not self.damondItems[arg_13_1] then
			var_10_0(arg_13_1)

			var_13_0 = self.damondItems[arg_13_1]
		end

		if self.tempDamondVOs[arg_13_0 + 1] then
			var_13_0:update(self.tempDamondVOs[arg_13_0 + 1], self.player, self.firstChargeIds)
		end

		return
	end

	local var_10_2 = UIItemList.New(arg_10_1:Find("content"), (arg_10_1:Find("ItemTpl")))

	var_10_2:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventInit then
			var_10_0(go(arg_14_2))
		elseif arg_14_0 == UIItemList.EventUpdate then
			var_10_1(arg_14_1, go(arg_14_2))
		end

		return
	end)

	return var_10_2
end

function ChargeScene:updateDamondsData()
	self.damondItemVOs = {}

	local var_15_1 = getProxy(PlayerProxy):getRefundInfo()
	local var_15_2 = getProxy(ServerProxy):getLastServer(getProxy(UserProxy):getData().uid)

	var_15_1 = var_15_1 or {}

	for iter_15_0 = 1, #var_15_1 do
		local var_15_3 = Goods.Create({
			shop_id = var_15_1[iter_15_0].shopId
		}, Goods.TYPE_CHARGE)

		var_15_3.buyTime = var_15_1[iter_15_0].buyTime
		var_15_3.refundTime = var_15_1[iter_15_0].refundTime

		table.insert(self.damondItemVOs, var_15_3)
	end

	return
end

function ChargeScene:sortDamondItems()
	if self.damondItemVOs == nil then
		return
	end

	self.tempDamondVOs = {}

	for iter_16_0, iter_16_1 in ipairs(self.damondItemVOs) do
		if iter_16_1:isChargeType() then
			iter_16_1:updateBuyCount(self:getBuyCount(self.chargedList, iter_16_1.id))
			table.insert(self.tempDamondVOs, iter_16_1)
		end
	end

	table.sort(self.tempDamondVOs, function(arg_17_0, arg_17_1)
		local var_17_0 = not table.contains(self.firstChargeIds, arg_17_0.id) and arg_17_0:firstPayDouble() and 1 or 0
		local var_17_1 = not table.contains(self.firstChargeIds, arg_17_1.id) and arg_17_1:firstPayDouble() and 1 or 0

		if 0 ~= 0 then
			return 0 < 0
		end

		local var_17_3 = arg_17_0:getConfig("tag") == 2 and 1 or 0
		local var_17_4 = arg_17_1:getConfig("tag") == 2 and 1 or 0

		if var_17_0 == var_17_1 and var_17_3 == var_17_4 then
			return arg_17_0.id < arg_17_1.id
		else
			return var_17_1 < var_17_0 or var_17_0 == var_17_1 and var_17_4 < var_17_3
		end

		return
	end)

	if page == ChargeScene.TYPE_DIAMOND then
		self.diamondUIItemList:align(#self.tempDamondVOs)
	elseif page == ChargeScene.TYPE_GIFT then
		self.giftRect:SetTotalCount(#self.tempDamondVOs, self.giftRect.value)
	end

	return
end

function ChargeScene:getBuyCount(arg_18_1, arg_18_2)
	if not arg_18_1 then
		return 0
	end

	return (arg_18_1[arg_18_2] or nil) and (arg_18_1[arg_18_2].buyCount or 0)
end

function ChargeScene:showItemDetail(arg_19_1)
	local var_19_0

	if arg_19_1.name then
		var_19_0 = arg_19_1.name or ""
	end

	local var_19_1 = arg_19_1.tipBonus or ""
	local var_19_2 = arg_19_1.bonusItem
	local var_19_3

	if arg_19_1.tipExtra then
		var_19_3 = arg_19_1.tipExtra or ""

		local var_19_4

		if arg_19_1.extraItems then
			var_19_4 = arg_19_1.extraItems or {}

			local var_19_5

			if arg_19_1.price then
				var_19_5 = arg_19_1.price or 0
			end
		end
	end

	local var_19_6 = arg_19_1.isChargeType
	local var_19_7 = arg_19_1.isMonthCard
	local var_19_8 = arg_19_1.tagType
	local var_19_9 = arg_19_1.normalTip

	setActive(self.detail:Find("window2"), arg_19_1.normalTip)
	setActive(self.detail:Find("window"), not var_19_9)
	self:bindDetailTF((var_19_9 or nil) and (self.detail:Find("window2") or self.detail:Find("window")))

	if self.detailNormalTip then
		setActive(self.detailNormalTip, var_19_9)
	end

	if self.detailContain then
		setActive(self.detailContain, not var_19_9)
	end

	if var_19_9 then
		if self.detailNormalTip:GetComponent("Text") then
			setText(self.detailNormalTip, var_19_9)
		else
			setButtonText(self.detailNormalTip, var_19_9)
		end
	end

	setActive(self.detailTag, var_19_8 > 0)

	if var_19_8 > 0 then
		for iter_19_0, iter_19_1 in ipairs(self.detailTags) do
			setActive(iter_19_1, iter_19_0 == var_19_8)
		end
	end

	self.detailIconTF.sprite = GetSpriteFromAtlas("chargeicon/1", "")

	LoadSpriteAsync(arg_19_1.icon, function(arg_20_0)
		if arg_20_0 then
			self.detailIconTF.sprite = arg_20_0
		end

		return
	end)
	setText(self.detailName, var_19_0)
	setActive(self.detailRmb, var_19_6)
	setActive(self.detailGem, not var_19_6)
	setText(self.detailPrice, var_19_5)

	if self.detailDescExtra ~= nil then
		setActive(self.detailDescExtra, arg_19_1.descExtra and arg_19_1.descExtra ~= "")
		setText(self.detailDescExtra, arg_19_1.descExtra or "")
	end

	if self.detailContain then
		SetActive(self.normal, var_19_7)

		if var_19_7 then
			updateDrop(self.detailItem, var_19_2)
			onButton(self, self.detailItem, function()
				self:emit(ChargeScene.ON_DROP, var_19_2)

				return
			end, SFX_PANEL)

			local var_19_11, var_19_12 = contentWrap(var_19_2:getConfig("name"), 10, 2)

			if var_19_11 then
				var_19_12 = var_19_12 .. "..."
			end

			setText(self.detailItem:Find("name"), var_19_12)
			setText(self.detailTip, var_19_1)
		end

		setText(self.detailTip2, var_19_3)

		for iter_19_2 = #var_19_4, self.detailItemList.childCount - 1 do
			Destroy(self.detailItemList:GetChild(iter_19_2))
		end

		for iter_19_3 = self.detailItemList.childCount, #var_19_4 - 1 do
			cloneTplTo(self.detailItem, self.detailItemList)
		end

		for iter_19_4 = 1, #var_19_4 do
			local var_19_13 = self.detailItemList:GetChild(iter_19_4 - 1)

			updateDrop(var_19_13, var_19_4[iter_19_4])

			local var_19_14, var_19_15 = contentWrap(var_19_4[iter_19_4]:getConfig("name"), 8, 2)

			if var_19_14 then
				var_19_15 = var_19_15 .. "..."
			end

			setText(var_19_13:Find("name"), var_19_15)
			onButton(self, var_19_13, function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = true,
					type = MSGBOX_TYPE_SINGLE_ITEM,
					drop = var_19_4[iter_19_4]
				})

				return
			end, SFX_PANEL)
		end
	end

	onButton(self, self.detail:Find("back_sign"), function()
		SetActive(self.detail, false)
		self:revertDetailBlur()

		return
	end, SFX_PANEL)
	onButton(self, self.detailWindow:Find("button_container/button_cancel"), function()
		SetActive(self.detail, false)
		self:revertDetailBlur()

		return
	end, SFX_PANEL)
	onButton(self, self.detailWindow:Find("button_container/button_ok"), arg_19_1.onYes or function()
		return
	end, SFX_PANEL)
	setActive(self.detail, true)
	pg.UIMgr.GetInstance():BlurPanel(self.blurPanel)

	return
end

function ChargeScene:bindDetailTF(arg_26_1)
	self.detailWindow = arg_26_1
	self.detailName = self.detailWindow:Find("goods/name")
	self.detailIcon = self.detailWindow:Find("goods/icon")
	self.detailIconTF = self.detailIcon:GetComponent(typeof(Image))
	self.detailRmb = self.detailWindow:Find("prince_bg/contain/icon_rmb")
	self.detailGem = self.detailWindow:Find("prince_bg/contain/icon_gem")
	self.detailPrice = self.detailWindow:Find("prince_bg/contain/Text")
	self.detailTag = self.detailWindow:Find("goods/tag")
	self.detailTags = {}

	table.insert(self.detailTags, self.detailTag:Find("hot"))
	table.insert(self.detailTags, self.detailTag:Find("new"))
	table.insert(self.detailTags, self.detailTag:Find("advice"))
	table.insert(self.detailTags, self.detailTag:Find("double"))
	table.insert(self.detailTags, self.detailTag:Find("discount"))

	self.detailTagDoubleTF = self.detailTag:Find("double")
	self.detailTagAdviceTF = self.detailTag:Find("advice")
	self.detailContain = self.detailWindow:Find("container")

	if self.detailContain then
		self.extra = self.detailWindow:Find("container/items")
		self.detailTip2 = self.extra:Find("Text")
		self.detailItemList = self.extra:Find("scrollview/list")
		self.normal = self.detailWindow:Find("container/normal_items")
		self.detailTip = self.normal:Find("Text")
		self.detailItem = self.normal:Find("item_tpl")
		self.detailDescExtra = self.detailWindow:Find("container/Text")
	end

	self.detailNormalTip = self.detailWindow:Find("NormalTips")

	return
end

function ChargeScene:revertDetailBlur()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.blurPanel, self._tf)

	return
end

function ChargeScene:willExit()
	self:revertDetailBlur()

	return
end

function ChargeScene:onBackPressed()
	return
end

return ChargeScene
