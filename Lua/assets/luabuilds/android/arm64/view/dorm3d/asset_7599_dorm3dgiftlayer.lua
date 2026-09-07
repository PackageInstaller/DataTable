local Dorm3dGiftLayer = class("Dorm3dGiftLayer", import("view.base.BaseUI"))

function Dorm3dGiftLayer:getUIName()
	return "Dorm3dGiftUI"
end

function Dorm3dGiftLayer:init()
	onButton(self, self._tf:Find("btn_back"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	self.rtGiftPanel = self._tf:Find("gift_panel")

	for iter_2_0, iter_2_1 in ipairs({
		"all",
		"normal",
		"pro"
	}) do
		onToggle(self, self.rtGiftPanel:Find("content/toggles/" .. iter_2_1), function(arg_4_0)
			if arg_4_0 then
				if self.afterFirst then
					quickPlayAnimation(self.rtGiftPanel, "anim_dorm3d_giftui_change")
				else
					self.afterFirst = true
				end

				self:UpdateSelectToggle(iter_2_1)
			end

			return
		end, SFX_PANEL)
	end

	local var_2_0 = self.rtGiftPanel:Find("content/view/container")

	self.giftItemList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	self.giftItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			self:UpdateGift(arg_5_2, self.filterGiftIds[arg_5_1])
		end

		return
	end)

	self.showedGiftRecords = {}

	onScroll(self, var_2_0, function(arg_6_0)
		self:OnGiftListScroll(arg_6_0)

		return
	end)

	self.btnConfirm = self.rtGiftPanel:Find("bottom/btn_confirm")

	onButton(self, self.btnConfirm, function()
		self:ConfirmGiveGifts()

		return
	end, SFX_CONFIRM)

	self.rtInfoWindow = self._tf:Find("info_window")

	onButton(self, self.rtInfoWindow:Find("bg"), function()
		self:HideInfoWindow()

		return
	end, SFX_CANCEL)
	onButton(self, self.rtInfoWindow:Find("panel/title/btn_close"), function()
		self:HideInfoWindow()

		return
	end, SFX_CANCEL)

	self.rtLackWindow = self._tf:Find("lack_window")

	onButton(self, self.rtLackWindow:Find("bg"), function()
		self:HideLackWindow()

		return
	end, SFX_CANCEL)
	onButton(self, self.rtLackWindow:Find("panel/title/btn_close"), function()
		self:HideLackWindow()

		return
	end, SFX_CANCEL)
	self:TempOverlayPanelPB(self.rtGiftPanel, {
		pbList = {
			self.rtGiftPanel
		},
		baseCamera = self.contextData.baseCamera
	})

	return
end

function Dorm3dGiftLayer:SetApartment(arg_12_1)
	self.apartment = arg_12_1
	self.giftIds = self.apartment:getGiftIds()
	self.proxy = getProxy(ApartmentProxy)

	return
end

function Dorm3dGiftLayer:didEnter()
	triggerToggle(self.rtGiftPanel:Find("content/toggles/all"), true)
	self:UpdateConfirmBtn()

	return
end

function Dorm3dGiftLayer:UpdateSelectToggle(arg_14_1)
	if self.toggleState == arg_14_1 then
		return
	end

	self.toggleState = arg_14_1

	self:UpdateFilterGiftIds()
	self.giftItemList:align(#self.filterGiftIds)

	return
end

function Dorm3dGiftLayer:UpdateFilterGiftIds()
	self.filterGiftIds = underscore.filter(self.giftIds, function(arg_16_0)
		local var_16_0 = pg.dorm3d_gift[arg_16_0]

		if pg.dorm3d_gift[arg_16_0].hide_if_not_owned == 1 and self.proxy:getGiftCount(arg_16_0) <= 0 then
			return false
		end

		return self.toggleState == "all" or self.toggleState == "normal" == (var_16_0.ship_group_id == 0)
	end)

	table.sort(self.filterGiftIds, CompareFuncs({
		function(arg_17_0)
			return (self.proxy:getGiftCount(arg_17_0) > 0 and -1 or 1) * (pg.dorm3d_gift[arg_17_0].ship_group_id == 0 and 1 or 2)
		end,
		function(arg_18_0)
			return Dorm3dGift.IsSingleGiveGift(arg_18_0) and self.proxy:isGiveGiftDone(arg_18_0) and 1 or 0
		end,
		function(arg_19_0)
			return arg_19_0
		end
	}))

	if self.selectGiftId and not table.indexof(self.filterGiftIds, self.selectGiftId) then
		self.selectGiftId = nil
		self.selectGiftCount = nil

		self:UpdateConfirmBtn()
	end

	return
end

function Dorm3dGiftLayer:UpdateGift(arg_20_1, arg_20_2, arg_20_3)
	arg_20_1.name = arg_20_2

	local var_20_0 = arg_20_1:Find("base")
	local var_20_1 = Drop.New({
		type = DROP_TYPE_DORM3D_GIFT,
		id = arg_20_2,
		count = self.proxy:getGiftCount(arg_20_2)
	})

	updateCustomDrop(var_20_0:Find("Dorm3dIconTpl"), var_20_1)
	setText(var_20_0:Find("info/name"), var_20_1:getName())

	local var_20_2 = var_20_1:getConfig("ship_group_id") ~= 0

	setActive(var_20_0:Find("mark"), var_20_2)
	setActive(var_20_0:Find("bg/normal"), not var_20_2)
	setActive(var_20_0:Find("bg/pro"), var_20_2)
	setText(var_20_0:Find("info/Text"), i18n("dorm3d_gift_owner_num") .. string.format("%d", var_20_1.count))
	setActive(var_20_0:Find("info/overtime"), Dorm3dGift.IsExpireSoon(arg_20_2))

	local var_20_3 = var_20_0:Find("info/effect")

	setActive(var_20_3:Find("favor"), true)
	setText(var_20_3:Find("favor/number"), "+" .. pg.dorm3d_favor_trigger[var_20_1.cfg.favor_trigger_id].num)
	setActive(var_20_3:Find("story"), pg.dorm3d_gift[arg_20_2].unlock_dialogue_id ~= 0)
	onButton(self, var_20_0:Find("info/btn_info"), function()
		self:OpenLackWindow(var_20_1)

		return
	end, SFX_PANEL)

	local var_20_4 = Dorm3dGift.New({
		configId = arg_20_2
	})
	local var_20_5 = Dorm3dGift.IsSingleGiveGift(arg_20_2) and self.proxy:isGiveGiftDone(arg_20_2)
	local var_20_6 = var_20_4:GetShopID()

	setActive(var_20_0:Find("info/lack"), var_20_6 ~= 0)

	if var_20_6 ~= 0 then
		local var_20_7 = CommonCommodity.New({
			id = var_20_6
		}, Goods.TYPE_SHOPSTREET)
		local var_20_8, var_20_9, var_20_10 = var_20_7:GetPrice()
		local var_20_11 = Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = var_20_7:GetResType(),
			count = var_20_8
		})

		setActive(var_20_0:Find("info/lack/tip"), var_20_2 and not var_20_5 and Dorm3dGift.GetViewedFlag(arg_20_2) == 0)

		local var_20_12
		local var_20_13 = 0

		_.each(var_20_4:getConfig("shop_id"), function(arg_22_0)
			if pg.shop_template[arg_22_0].group_type == 2 then
				var_20_13 = math.max(pg.shop_template[arg_22_0].group_limit, var_20_13)
			end

			return
		end)

		if 0 > 0 then
			local var_20_14 = {}

			var_20_14[1] = getProxy(ApartmentProxy):GetGiftShopCount(var_20_4:GetConfigID())
			var_20_14[2] = 0
			var_20_12 = var_20_14
		end

		onButton(self, var_20_0:Find("info/lack"), function()
			Dorm3dGift.SetViewedFlag(arg_20_2)
			setActive(var_20_0:Find("info/lack/tip"), false)

			if not var_20_4:CheckBuyLimit() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_shop_gift_owned"))

				return
			end

			self:emit(Dorm3dGiftMediator.SHOW_SHOPPING_CONFIRM_WINDOW, {
				content = {
					icon = "<icon name=" .. var_20_7:GetResIcon() .. " w=1.1 h=1.1/>",
					off = var_20_9,
					cost = var_20_11.count,
					old = var_20_10,
					name = var_20_1:getConfig("name"),
					weekLimit = var_20_12
				},
				tip = i18n("dorm3d_shop_gift_tip"),
				drop = var_20_4,
				groupId = self.apartment:GetConfigID(),
				onYes = function()
					self:emit(GAME.SHOPPING, {
						silentTip = true,
						count = 1,
						shopId = var_20_6
					})

					return
				end
			})

			return
		end, SFX_PANEL)
	end

	setActive(arg_20_1:Find("mask"), var_20_5)
	setText(arg_20_1:Find("mask/Image/Text"), i18n("dorm3d_already_gifted"))

	local function var_20_15(arg_25_0)
		self.selectGiftCount = arg_25_0

		setText(arg_20_1:Find("base/PageUtil/Text"), arg_25_0)
		setGray(arg_20_1:Find("base/PageUtil/Add"), arg_25_0 >= math.min(20, var_20_1.count))
		setGray(arg_20_1:Find("base/PageUtil/Minus"), arg_25_0 <= 1)

		return
	end

	;(function()
		local var_26_0 = math.min(20, var_20_1.count)

		pressPersistTrigger(arg_20_1:Find("base/PageUtil/Minus"), 0.5, function()
			local var_27_0 = self.selectGiftCount - 1

			var_27_0 = self.selectGiftCount - 1 <= 0 and self.selectGiftCount or var_27_0

			var_20_15(var_27_0)

			return
		end, nil, true, true, 0.1, SFX_PANEL)
		pressPersistTrigger(arg_20_1:Find("base/PageUtil/Add"), 0.5, function()
			local var_28_0 = self.selectGiftCount + 1

			var_28_0 = self.selectGiftCount + 1 > var_26_0 and var_26_0 or var_28_0

			var_20_15(var_28_0)

			return
		end, nil, true, true, 0.1, SFX_PANEL)

		return
	end)()
	onToggle(self, arg_20_1, function(arg_29_0)
		if arg_29_0 then
			self.selectGiftId = arg_20_2

			self:UpdateConfirmBtn()
			var_20_15(math.min(1, var_20_1.count))
		elseif self.selectGiftId == arg_20_2 then
			self.selectGiftId = nil

			self:UpdateConfirmBtn()
		end

		setActive(arg_20_1:Find("base/PageUtil"), arg_29_0)

		return
	end, SFX_PANEL)
	setToggleEnabled(arg_20_1, not var_20_5)
	triggerToggle(arg_20_1, arg_20_3)

	return
end

function Dorm3dGiftLayer:SingleUpdateGift(arg_30_1)
	self:UpdateFilterGiftIds()
	self.giftItemList:align(#self.filterGiftIds)

	local var_30_0 = table.indexof(self.filterGiftIds, arg_30_1)

	if var_30_0 then
		self:UpdateGift(self.giftItemList.container:GetChild(var_30_0 - 1), arg_30_1, true)
	end

	return
end

function Dorm3dGiftLayer:OnGiftListScroll(arg_31_1)
	local var_31_0 = self.rtGiftPanel:Find("content/view/container")
	local var_31_1 = GetComponent(var_31_0, typeof(VerticalLayoutGroup))
	local var_31_2 = var_31_0:GetChild(0).rect.height + var_31_1.spacing

	for iter_31_0 = math.max(1, (math.floor((var_31_0.anchoredPosition.y - var_31_1.padding.top) / var_31_2))), math.min(#self.filterGiftIds, (math.ceil((var_31_0.anchoredPosition.y + var_31_0.rect.height - var_31_1.padding.top) / var_31_2))) do
		if not self.showedGiftRecords[self.filterGiftIds[iter_31_0]] then
			self.showedGiftRecords[self.filterGiftIds[iter_31_0]] = true

			local var_31_3 = Dorm3dGift.SetViewedFlag(self.filterGiftIds[iter_31_0])
		end
	end

	return
end

function Dorm3dGiftLayer:UpdateConfirmBtn()
	setButtonEnabled(self.btnConfirm, tobool(self.selectGiftId))

	return
end

function Dorm3dGiftLayer:ConfirmGiveGifts()
	if self.proxy:getGiftCount(self.selectGiftId) == 0 then
		if Dorm3dGift.IsSingleGiveGift(self.selectGiftId) and self.proxy:isGiveGiftDone(self.selectGiftId) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_shop_gift_already_given"))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_shop_gift_not_owned"))
		end

		return
	end

	local var_33_0 = {}

	if self.apartment:isMaxFavor() then
		table.insert(var_33_0, function(arg_34_0)
			pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_MSGBOX, {
				contentText = i18n("dorm3d_gift_favor_max"),
				onConfirm = arg_34_0
			})

			return
		end)
	else
		local var_33_1 = self.apartment.favor + pg.dorm3d_favor_trigger[pg.dorm3d_gift[self.selectGiftId].favor_trigger_id].num * self.selectGiftCount - self.apartment:getMaxFavor()

		if var_33_1 > 0 then
			table.insert(var_33_0, function(arg_35_0)
				pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_MSGBOX, {
					contentText = i18n("dorm3d_gift_favor_exceed", var_33_1),
					onConfirm = arg_35_0
				})

				return
			end)
		end
	end

	seriesAsync(var_33_0, function()
		self:emit(Dorm3dGiftMediator.GIVE_GIFT, self.selectGiftId, self.selectGiftCount)

		return
	end)

	return
end

function Dorm3dGiftLayer:AfterGiveGift(arg_37_1)
	local var_37_0 = table.indexof(self.filterGiftIds, arg_37_1.giftId)

	if var_37_0 then
		quickPlayAnimation(self.giftItemList.container:GetChild(var_37_0 - 1), "anim_dorm3d_giftui_Select")
	end

	local var_37_1 = pg.dorm3d_gift[arg_37_1.giftId]
	local var_37_2 = {}
	local var_37_3 = Apartment.getGroupConfig(self.apartment.configId, pg.dorm3d_gift[arg_37_1.giftId].reply_dialogue_id)

	if var_37_3 and ApartmentProxy.CheckUnlockConfig(pg.dorm3d_dialogue_group[var_37_3].unlock) then
		table.insert(var_37_2, function(arg_38_0)
			self:emit(Dorm3dGiftMediator.DO_TALK, var_37_3, arg_38_0)

			return
		end)
	end

	if var_37_1.unlock_dialogue_id > 0 then
		table.insert(var_37_2, function(arg_39_0)
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_gift_story_unlock"))
			arg_39_0()

			return
		end)
	end

	seriesAsync(var_37_2, function()
		self:CheckLevelUp()

		return
	end)

	return
end

function Dorm3dGiftLayer:CheckLevelUp()
	if self.apartment:canLevelUp() then
		self:emit(Dorm3dRoomMediator.FAVOR_LEVEL_UP, self.apartment.configId)
	end

	return
end

function Dorm3dGiftLayer:OpenInfoWindow(arg_42_1)
	local var_42_0 = self.rtInfoWindow:Find("panel")

	setText(var_42_0:Find("title/Text"), i18n("words_information"))
	updateCustomDrop(var_42_0:Find("middle/Dorm3dIconTpl"), arg_42_1)
	setActive(var_42_0:Find("middle/Dorm3dIconTpl/mark"), arg_42_1:getConfig("ship_group_id") ~= 0)
	setText(var_42_0:Find("middle/Text"), "???")
	onButton(self, var_42_0:Find("bottom/btn_buy"), function()
		pg.TipsMgr.GetInstance():ShowTips("without shop config")

		return
	end, SFX_CONFIRM)
	setActive(self.rtInfoWindow, true)
	self:OverlayPanel(self.rtInfoWindow)

	return
end

function Dorm3dGiftLayer:HideInfoWindow()
	setActive(self.rtInfoWindow, false)
	self:UnOverlayPanel(self.rtInfoWindow, self._tf)

	return
end

function Dorm3dGiftLayer:OpenLackWindow(arg_45_1)
	local var_45_0 = self.rtLackWindow:Find("panel")

	setText(var_45_0:Find("title/Text"), i18n("child_msg_title_detail"))
	updateCustomDrop(var_45_0:Find("middle/Dorm3dIconTpl"), arg_45_1)
	setActive(var_45_0:Find("middle/Dorm3dIconTpl/mark"), arg_45_1:getConfig("ship_group_id") ~= 0)
	setText(var_45_0:Find("middle/info/name"), arg_45_1:getName())
	setText(var_45_0:Find("middle/info/count"), string.format("count:<color=#39bfff>%d</color>", arg_45_1.count))
	setText(var_45_0:Find("middle/info/desc"), arg_45_1:getConfig("display"))
	setText(var_45_0:Find("line/lack/Text"), "lack")

	local var_45_1 = ItemTipPanel.GetDropLackConfig(arg_45_1)
	local var_45_2

	if var_45_1 then
		var_45_2 = var_45_1.description or {}
	end

	local var_45_3 = var_45_0:Find("bottom/container")

	UIItemList.StaticAlign(var_45_3, var_45_3:Find("tpl"), #var_45_2, function(arg_46_0, arg_46_1, arg_46_2)
		arg_46_1 = arg_46_1 + 1

		if arg_46_0 == UIItemList.EventUpdate then
			local var_46_0, var_46_1, var_46_2 = unpack(var_45_2[arg_46_1])

			setText(arg_46_2:Find("Text"), var_46_0)
			setText(arg_46_2:Find("btn_go/Text"), i18n("feast_res_window_go_label"))

			local var_46_3, var_46_4, var_46_5 = unpack(var_45_1)
			local var_46_6, var_46_7 = unpack(var_46_4)
			local var_46_8 = #var_46_6 > 0

			if var_46_5 and var_46_5 ~= 0 then
				var_46_8 = var_46_8 and getProxy(ActivityProxy):IsActivityNotEnd(var_46_5)
			end

			setActive(arg_46_2:Find("btn_go"), var_46_8)
			onButton(self, arg_46_2:Find("btn_go"), function()
				ItemTipPanel.ConfigGoScene(var_46_6, var_46_7, function()
					self:closeView()

					return
				end)

				return
			end, SFX_PANEL)
		end

		return
	end)
	setActive(self.rtLackWindow, true)
	self:OverlayPanel(self.rtLackWindow)

	return
end

function Dorm3dGiftLayer:HideLackWindow()
	setActive(self.rtLackWindow, false)
	self:UnOverlayPanel(self.rtLackWindow, self._tf)

	return
end

function Dorm3dGiftLayer:onBackPressed()
	if isActive(self.rtInfoWindow) then
		self:HideInfoWindow()

		return
	end

	if isActive(self.rtLackWindow) then
		self:HideLackWindow()

		return
	end

	Dorm3dGiftLayer.super.onBackPressed(self)

	return
end

function Dorm3dGiftLayer:willExit()
	if isActive(self.rtInfoWindow) then
		self:HideInfoWindow()
	end

	if isActive(self.rtLackWindow) then
		self:HideLackWindow()
	end

	self:TempUnOverlayPanelPB(self.rtGiftPanel, self._tf)

	return
end

return Dorm3dGiftLayer
