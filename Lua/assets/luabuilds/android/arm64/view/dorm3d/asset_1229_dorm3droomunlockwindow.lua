local Dorm3dRoomUnlockWindow = class("Dorm3dRoomUnlockWindow", import("view.base.BaseUI"))

function Dorm3dRoomUnlockWindow:getUIName()
	return "Dorm3dRoomUnlockWindow"
end

function Dorm3dRoomUnlockWindow:init()
	self.bubbleContent = self._tf:Find("Window/Bubbles/content")
	self.bubbleTpl = self._tf:Find("Window/Bubbles/tpl")
	self.bubbleList = UIItemList.New(self.bubbleContent, self.bubbleTpl)
	self.scrollSnap = BannerScrollRect4Dorm.New(self._tf:Find("Window/banner/mask/content"), self._tf:Find("Window/banner/dots"))

	setActive(self.bubbleTpl, false)

	return
end

function Dorm3dRoomUnlockWindow:didEnter()
	onButton(self, self._tf:Find("Window/Confirm"), function()
		if self.contextData.groupId then
			self:emit(Dorm3dRoomUnlockWindowMediator.ON_UNLOCK_ROOM_INVITE, self.contextData.roomId, self.contextData.groupId)
		else
			self:emit(Dorm3dRoomUnlockWindowMediator.ON_UNLOCK_DORM_ROOM, self.contextData.roomId)
		end

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Window/Cancel"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("bg"), function()
		self:closeView()

		return
	end)
	setActive(self._tf:Find("Window/Title/unlock"), not self.contextData.groupId)
	setActive(self._tf:Find("Window/Title/invite"), self.contextData.groupId)

	if self.contextData.groupId then
		local var_3_0 = getProxy(ApartmentProxy)
		local var_3_1 = var_3_0:getRoom(self.contextData.roomId)
		local var_3_2 = CommonCommodity.New({
			id = Apartment.getGroupConfig(self.contextData.groupId, var_3_1:getConfig("invite_cost"))
		}, Goods.TYPE_SHOPSTREET)
		local var_3_3, var_3_4, var_3_5 = var_3_2.GetPrice(var_3_0)
		local var_3_6 = Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = var_3_2:GetResType(),
			count = var_3_3
		})

		if var_3_6.count == 0 then
			setText(self._tf:Find("Window/Content"), i18n("dorm3d_invite_confirm_free", "<icon name=" .. var_3_2:GetResIcon() .. " w=1.1 h=1.1/>", var_3_5, ShipGroup.getDefaultShipNameByGroupID(self.contextData.groupId), var_3_1:getConfig("room")))
		elseif var_3_4 > 0 then
			setText(self._tf:Find("Window/Content"), i18n("dorm3d_invite_confirm_discount", "<icon name=" .. var_3_2:GetResIcon() .. " w=1.1 h=1.1/>", var_3_6.count, var_3_5, ShipGroup.getDefaultShipNameByGroupID(self.contextData.groupId), var_3_1:getConfig("room")))
		else
			setText(self._tf:Find("Window/Content"), i18n("dorm3d_invite_confirm_original", "<icon name=" .. var_3_2:GetResIcon() .. " w=1.1 h=1.1/>", var_3_6.count, ShipGroup.getDefaultShipNameByGroupID(self.contextData.groupId), var_3_1:getConfig("room")))
		end

		setText(self._tf:Find("Window/Download"), "")
		setActive(self._tf:Find("Window/Preview"), false)

		self.bannerConfig = Apartment.getGroupConfig(self.contextData.groupId, var_3_1:getConfig("invite_banner"))
		self.markConfig = Apartment.getGroupConfig(self.contextData.groupId, var_3_1:getConfig("invite_mark"))

		self:InitBanner()
		self:InitUIList()
	else
		local var_3_7 = ApartmentRoom.New({
			id = self.contextData.roomId
		})

		setText(self._tf:Find("Window/Content"), i18n("dorm3d_beach_buy", table.concat(underscore.map(var_3_7:getConfig("unlock_item"), function(arg_7_0)
			local var_7_0 = Drop.Create(arg_7_0)

			return string.format("%s*%d", var_7_0:getName(), var_7_0.count)
		end)), var_3_7:getConfig("room")))

		if var_3_7:needDownload() then
			local var_3_8, var_3_9 = var_3_7:getDownloadNeedSize()

			setText(self._tf:Find("Window/Download"), i18n("dorm3d_beach_download", var_3_9))
		else
			setText(self._tf:Find("Window/Download"), "")
		end

		GetImageSpriteFromAtlasAsync("dorm3dbanner/" .. string.lower(var_3_7:getConfig("assets_prefix")), "", self._tf:Find("Window/Preview/Image"))
	end

	setText(self._tf:Find("Window/Confirm/Text"), i18n("msgbox_text_confirm"))
	setText(self._tf:Find("Window/Cancel/Text"), i18n("msgbox_text_cancel"))
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	return
end

function Dorm3dRoomUnlockWindow:InitBanner()
	for iter_8_0 = 1, #self.bannerConfig do
		LoadImageSpriteAsync("dorm3dbanner/" .. self.bannerConfig[iter_8_0], (self.scrollSnap:AddChild()))
	end

	self.scrollSnap:SetUp()

	return
end

function Dorm3dRoomUnlockWindow:InitUIList()
	self.bubbleList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventInit then
			LoadImageSpriteAtlasAsync("ui/shoptip_atlas", "icon_" .. self.markConfig[arg_10_1 + 1], arg_10_2:Find("icon/icon"), true)
			setText(arg_10_2:Find("bubble/Text"), i18n("dorm3d_shop_tag" .. self.markConfig[arg_10_1 + 1]))
			setActive(arg_10_2:Find("bubble"), false)
			onToggle(self, arg_10_2, function(arg_11_0)
				setActive(arg_10_2:Find("icon/select"), arg_11_0)
				setActive(arg_10_2:Find("icon/unselect"), not arg_11_0)
				setActive(arg_10_2:Find("bubble"), arg_11_0)

				return
			end)
		end

		return
	end)
	self.bubbleList:align(#self.markConfig)

	return
end

function Dorm3dRoomUnlockWindow:willExit()
	self.scrollSnap:Dispose()

	self.scrollSnap = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return Dorm3dRoomUnlockWindow
