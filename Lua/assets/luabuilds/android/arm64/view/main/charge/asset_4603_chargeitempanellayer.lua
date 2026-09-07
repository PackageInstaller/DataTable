local ChargeItemPanelLayer = class("ChargeItemPanelLayer", import("...base.BaseUI"))

function ChargeItemPanelLayer:getUIName()
	if self.contextData.panelConfig.extraItems then
		if self:ExistSkinExperienceItem(self.contextData.panelConfig.extraItems or {}) then
			do return "ChargeItem4SkinDiscountItemUI" end

			goto label_1_0
		end
	end

	do return "ChargeItemPanelUI" end

	::label_1_0::

	return
end

function ChargeItemPanelLayer:init()
	self:initData()
	self:findUI()
	self:addListener()
	self:initUIText()

	return
end

function ChargeItemPanelLayer:didEnter()
	self:updatePanel()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ChargeItemPanelLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function ChargeItemPanelLayer:initData()
	self.panelConfig = self.contextData.panelConfig

	return
end

function ChargeItemPanelLayer:initUIText()
	setText(self._tf:Find("window/button_container/button_cancel/Image"), i18n("text_cancel"))
	setText(self._tf:Find("window/button_container/button_ok/Image"), i18n("text_buy"))

	return
end

function ChargeItemPanelLayer:findUI()
	self.bg = self._tf:Find("back_sign")
	self.detailWindow = self._tf:Find("window")
	self.cancelBtn = self.detailWindow:Find("button_container/button_cancel")
	self.confirmBtn = self.detailWindow:Find("button_container/button_ok")
	self.detailName = self.detailWindow:Find("goods/mask/name/Text")
	self.detailIcon = self.detailWindow:Find("goods/icon")
	self.detailExtraDrop = self.detailWindow:Find("goods/extra_drop")
	self.detailRmb = self.detailWindow:Find("prince_bg/contain/icon_rmb")
	self.detailGem = self.detailWindow:Find("prince_bg/contain/icon_gem")
	self.detailGold = self.detailWindow:Find("prince_bg/contain/icon_gold")
	self.detailPrice = self.detailWindow:Find("prince_bg/contain/Text")
	self.detailTag = self.detailWindow:Find("goods/tag")
	self.detailTags = {}

	table.insert(self.detailTags, self.detailTag:Find("hot"))
	table.insert(self.detailTags, self.detailTag:Find("new"))
	table.insert(self.detailTags, self.detailTag:Find("advice"))
	table.insert(self.detailTags, self.detailTag:Find("double"))
	table.insert(self.detailTags, self.detailTag:Find("discount"))

	self.detailTagAdviceTF = self.detailTags[3]
	self.detailTagDoubleTF = self.detailTags[4]
	self.detailContain = self.detailWindow:Find("container")

	if self.detailContain then
		self.normal = self.detailContain:Find("normal_items")
		self.detailTip = self.normal:Find("Text")
		self.detailItem = self.normal:Find("item_tpl")
		self.extra = self.detailContain:Find("items")
		self.extraTip = self.extra:Find("Text")
		self.detailItemList = self.extra:Find("scrollview/list")
		self.extraDesc = self.detailContain:Find("Text")
	end

	self.detailNormalTip = self.detailWindow:Find("NormalTips")
	self.infoBtn = self.detailWindow:Find("prince_bg/info")

	return
end

function ChargeItemPanelLayer:addListener()
	onButton(self, self.bg, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		local var_11_0 = {}

		if self.panelConfig.limitArgs and type(self.panelConfig.limitArgs) == "table" then
			if self.panelConfig.limitArgs[1] and type(self.panelConfig.limitArgs[1]) == "table" and #self.panelConfig.limitArgs[1] >= 2 then
				local var_11_1, var_11_2 = unpack(self.panelConfig.limitArgs[1])

				if var_11_1 == "lv_70" and var_11_2 <= getProxy(PlayerProxy):getRawData().level then
					table.insert(var_11_0, function(arg_12_0)
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							content = i18n("lv70_package_tip"),
							onYes = arg_12_0
						})

						return
					end)
				end
			end
		end

		for iter_11_0, iter_11_1 in ipairs(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SKIN_COUPON_COUNTING)) do
			if not self.panelConfig.isChargeType then
				break
			end

			if not iter_11_1:isEnd() and table.contains(iter_11_1:getConfig("config_data")[1], self.panelConfig.commodity.id) then
				local var_11_3 = getProxy(ActivityProxy):getActivityById(Drop.New({
					type = DROP_TYPE_VITEM,
					id = iter_11_1:GetConfigClientSetting("item_id")
				}):getConfig("link_id"))

				if var_11_3 and not var_11_3:isEnd() then
					assert(var_11_3:getConfig("type") == ActivityConst.ACTIVITY_TYPE_SKIN_COUPON)

					local var_11_4, var_11_5 = var_11_3:GetOwnCount()
					local var_11_6 = iter_11_1:GetConfigClientSetting("gift_tip")[self.panelConfig.commodity.id][1]

					if var_11_6 then
						table.insert(var_11_0, function(arg_13_0)
							pg.MsgboxMgr.GetInstance():ShowMsgBox({
								content = i18n(var_11_6, var_11_4, var_11_5),
								onYes = arg_13_0
							})

							return
						end)
					else
						table.insert(var_11_0, function(arg_14_0)
							arg_14_0()

							return
						end)
					end
				end
			end
		end

		seriesAsync(var_11_0, function()
			existCall(self.panelConfig.onYes)
			self:closeView()

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function ChargeItemPanelLayer:updatePanel()
	local var_16_0 = self.panelConfig.icon
	local var_16_1 = self.panelConfig.name or ""
	local var_16_2 = self.panelConfig.tipBonus or ""
	local var_16_3 = self.panelConfig.bonusItem
	local var_16_4 = self.panelConfig.tipExtra or ""
	local var_16_5 = self.panelConfig.extraItems or {}
	local var_16_6

	if self.panelConfig.price then
		var_16_6 = self.panelConfig.price or 0
	end

	local var_16_7 = self.panelConfig.isChargeType
	local var_16_8 = self.panelConfig.isLocalPrice
	local var_16_9 = self.panelConfig.isMonthCard
	local var_16_10 = self.panelConfig.tagType
	local var_16_11 = self.panelConfig.extraDrop
	local var_16_12 = self.panelConfig.isForceGold
	local var_16_13 = self.panelConfig.infoTip or ""

	if self.detailNormalTip then
		setActive(self.detailNormalTip, self.panelConfig.normalTip)
	end

	if self.detailContain then
		setActive(self.detailContain, not self.panelConfig.normalTip)
	end

	if self.panelConfig.normalTip then
		if self.detailNormalTip:GetComponent("Text") then
			setText(self.detailNormalTip, self.panelConfig.normalTip)
		else
			setButtonText(self.detailNormalTip, self.panelConfig.normalTip)
		end
	end

	setActive(self.detailTag, var_16_10 > 0)

	if var_16_10 > 0 then
		for iter_16_0, iter_16_1 in ipairs(self.detailTags) do
			setActive(iter_16_1, iter_16_0 == var_16_10)
		end
	end

	GetImageSpriteFromAtlasAsync(var_16_0, "", self.detailIcon, false)
	setScrollText(self.detailName, var_16_1)

	if self.detailExtraDrop then
		setActive(self.detailExtraDrop, var_16_11)

		if var_16_11 then
			setText(self.detailExtraDrop:Find("Text"), i18n("battlepass_pay_acquire") .. "\n" .. var_16_11.count .. "x")
			updateDrop(self.detailExtraDrop:Find("item/IconTpl"), setmetatable({
				count = 1
			}, {
				__index = var_16_11
			}))
		end
	end

	if PLATFORM_CODE == PLATFORM_CHT then
		setActive(self.detailRmb, var_16_7 and not var_16_8)
	else
		setActive(self.detailRmb, var_16_7)
	end

	setActive(self.detailGem, not var_16_7 and not var_16_12)
	setActive(self.detailGold, not var_16_7 and not isActive(self.detailRmb) and not isActive(self.detailGem))
	setText(self.detailPrice, var_16_6)

	if self.extraDesc ~= nil then
		local var_16_14 = self.panelConfig.descExtra or ""

		setActive(self.extraDesc, #var_16_14 > 0)
		setText(self.extraDesc, var_16_14)
	end

	if self.detailContain then
		setActive(self.normal, var_16_9)

		if var_16_9 then
			updateDrop(self.detailItem, var_16_3)
			onButton(self, self.detailItem, function()
				return
			end, SFX_PANEL)

			local var_16_15, var_16_16 = contentWrap(var_16_3:getConfig("name"), 10, 2)

			if var_16_15 then
				var_16_16 = var_16_16 .. "..."
			end

			setText(self.detailItem:Find("name"), var_16_16)
			setText(self.detailTip, var_16_2)
		end

		setText(self.extraTip, var_16_4)

		if self:ExistSkinExperienceItem(var_16_5) then
			self:UpdateSkinDiscountItemItems(var_16_5)
		else
			self:UpdateItems(var_16_5)
		end
	end

	local var_16_17 = var_16_13 ~= ""

	setActive(self.infoBtn, var_16_13 ~= "")

	if var_16_17 then
		onButton(self, self.infoBtn, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = pg.gametip[var_16_13].tip
			})

			return
		end, SFX_PANEL)
	else
		removeOnButton(self.infoBtn)
	end

	return
end

function ChargeItemPanelLayer:UpdateItems(arg_19_1)
	UIItemList.StaticAlign(self.detailItemList, self.detailItem, #arg_19_1, function(arg_20_0, arg_20_1, arg_20_2)
		arg_20_1 = arg_20_1 + 1

		if arg_20_0 == UIItemList.EventUpdate then
			local var_20_0 = arg_19_1[arg_20_1]

			updateDrop(arg_20_2, arg_19_1[arg_20_1])

			local var_20_1, var_20_2 = contentWrap(arg_19_1[arg_20_1]:getConfig("name"), 8, 2)

			if var_20_1 then
				var_20_2 = var_20_2 .. "..."
			end

			setText(arg_20_2:Find("name"), var_20_2)
			onButton(self, arg_20_2, function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = true,
					type = MSGBOX_TYPE_SINGLE_ITEM,
					drop = var_20_0
				})

				return
			end, SFX_PANEL)
			setBlackMask(arg_20_2:Find("icon_bg"), arg_19_1[arg_20_1].got, {
				color = Color(0, 0, 0, 0.6)
			})
			setActive(arg_20_2:Find("got"), arg_19_1[arg_20_1].got)
			setActive(arg_20_2:Find("special"), arg_19_1[arg_20_1].special)
		end

		return
	end)

	return
end

function ChargeItemPanelLayer:UpdateSkinDiscountItemItems(arg_22_1)
	local var_22_0, var_22_1 = self:SplitItemAndSkinExperienceItem(arg_22_1)

	self:UpdateItems(var_22_0)

	local var_22_2 = UIItemList.New(self._tf:Find("window/container/bonus_gift/bg/scrollview/list"), self._tf:Find("window/container/normal_items/item_tpl"))

	var_22_2:make(function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == UIItemList.EventUpdate then
			self:UpdateItem(var_22_1[arg_23_1 + 1], arg_23_2)
		end

		return
	end)
	var_22_2:align(#var_22_1)
	setText(self._tf:Find("window/container/bonus_gift/bg/Text"), i18n("skin_discount_item_return_tip"))
	setText(self._tf:Find("window/container/bonus_gift/bg/label"), i18n("skin_discount_item_extra_bounds"))

	return
end

function ChargeItemPanelLayer:UpdateItem(arg_24_1, arg_24_2)
	local var_24_0 = Drop.Create({
		DROP_TYPE_ITEM,
		arg_24_1.id,
		arg_24_1.count
	})

	updateDrop(arg_24_2, var_24_0)
	setText(arg_24_2:Find("name"), shortenString(var_24_0:getName(), 4))
	onButton(self, arg_24_2, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			type = MSGBOX_TYPE_SINGLE_ITEM,
			drop = var_24_0
		})

		return
	end, SFX_PANEL)

	return
end

function ChargeItemPanelLayer:SplitItemAndSkinExperienceItem(arg_26_1)
	local var_26_0 = {}
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		if ChargeItemPanelLayer.IsSkinExperienceItem(iter_26_1) then
			table.insert(var_26_1, iter_26_1)
		else
			table.insert(var_26_0, iter_26_1)
		end
	end

	return var_26_0, var_26_1
end

function ChargeItemPanelLayer:IsSkinExperienceItem()
	if not isa(self, Drop) then
		self = Drop.New(self)
	end

	local var_27_1 = self:getConfigTable()

	return var_27_1 and var_27_1.usage == ItemUsage.USAGE_SKIN_EXP
end

function ChargeItemPanelLayer:ExistSkinExperienceItem(arg_28_1)
	return _.any(arg_28_1, function(arg_29_0)
		return ChargeItemPanelLayer.IsSkinExperienceItem(arg_29_0)
	end)
end

return ChargeItemPanelLayer
