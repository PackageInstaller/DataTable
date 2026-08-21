local var_0_0 = class("Dorm3dRoomUnlockWindow", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dRoomUnlockWindow"
end

function var_0_0.init(arg_2_0)
	arg_2_0.bubbleContent = arg_2_0._tf:Find("Window/Bubbles/content")
	arg_2_0.bubbleTpl = arg_2_0._tf:Find("Window/Bubbles/tpl")
	arg_2_0.bubbleList = UIItemList.New(arg_2_0.bubbleContent, arg_2_0.bubbleTpl)
	arg_2_0.scrollSnap = BannerScrollRect4Dorm.New(arg_2_0._tf:Find("Window/banner/mask/content"), arg_2_0._tf:Find("Window/banner/dots"))

	setActive(arg_2_0.bubbleTpl, false)

	return
end

function var_0_0.didEnter(arg_3_0)
	local var_3_9000

	onButton(arg_3_0, arg_3_0._tf:Find("Window/Confirm"), function()
		if arg_3_0.contextData.groupId then
			arg_3_0:emit(Dorm3dRoomUnlockWindowMediator.ON_UNLOCK_ROOM_INVITE, arg_3_0.contextData.roomId, arg_3_0.contextData.groupId)
		else
			arg_3_0:emit(Dorm3dRoomUnlockWindowMediator.ON_UNLOCK_DORM_ROOM, arg_3_0.contextData.roomId)
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("Window/Cancel"), function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("bg"), function()
		arg_3_0:closeView()

		return
	end)
	setActive(arg_3_0._tf:Find("Window/Title/unlock"), not arg_3_0.contextData.groupId)
	setActive(arg_3_0._tf:Find("Window/Title/invite"), arg_3_0.contextData.groupId)

	if arg_3_0.contextData.groupId then
		local var_3_0 = getProxy(ApartmentProxy)
		local var_3_1 = var_3_0.getRoom(var_3_9000, arg_3_0.contextData.roomId)
		local var_3_2 = CommonCommodity.New({
			id = Apartment.getGroupConfig(arg_3_0.contextData.groupId, var_3_1:getConfig("invite_cost"))
		}, Goods.TYPE_SHOPSTREET)
		local var_3_3, var_3_4, var_3_5 = var_3_2.GetPrice(var_3_0)
		local var_3_6 = Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = var_3_2:GetResType(),
			count = var_3_3
		})

		if var_3_6.count == 0 then
			setText(arg_3_0._tf:Find("Window/Content"), i18n("dorm3d_invite_confirm_free", "<icon name=" .. var_3_2:GetResIcon() .. " w=1.1 h=1.1/>", var_3_5, ShipGroup.getDefaultShipNameByGroupID(arg_3_0.contextData.groupId), var_3_1:getConfig("room")))
		elseif var_3_4 > 0 then
			setText(arg_3_0._tf:Find("Window/Content"), i18n("dorm3d_invite_confirm_discount", "<icon name=" .. var_3_2:GetResIcon() .. " w=1.1 h=1.1/>", var_3_6.count, var_3_5, ShipGroup.getDefaultShipNameByGroupID(arg_3_0.contextData.groupId), var_3_1:getConfig("room")))
		else
			setText(arg_3_0._tf:Find("Window/Content"), i18n("dorm3d_invite_confirm_original", "<icon name=" .. var_3_2:GetResIcon() .. " w=1.1 h=1.1/>", var_3_6.count, ShipGroup.getDefaultShipNameByGroupID(arg_3_0.contextData.groupId), var_3_1:getConfig("room")))
		end

		setText(arg_3_0._tf:Find("Window/Download"), "")
		setActive(arg_3_0._tf:Find("Window/Preview"), false)

		arg_3_0.bannerConfig = Apartment.getGroupConfig(arg_3_0.contextData.groupId, var_3_1:getConfig("invite_banner"))
		arg_3_0.markConfig = Apartment.getGroupConfig(arg_3_0.contextData.groupId, var_3_1:getConfig("invite_mark"))

		arg_3_0:InitBanner()
		arg_3_0:InitUIList()
	else
		local var_3_7 = ApartmentRoom.New({
			id = arg_3_0.contextData.roomId
		})

		setText(arg_3_0._tf:Find("Window/Content"), i18n("dorm3d_beach_buy", table.concat(underscore.map(var_3_7:getConfig("unlock_item"), function(arg_7_0)
			local var_7_0 = Drop.Create(arg_7_0)

			return string.format("%s*%d", var_7_0:getName(), var_7_0.count)
		end)), var_3_7:getConfig("room")))

		if var_3_7:needDownload() then
			local var_3_8, var_3_9 = var_3_7:getDownloadNeedSize()

			setText(arg_3_0._tf:Find("Window/Download"), i18n("dorm3d_beach_download", var_3_9))
		else
			setText(arg_3_0._tf:Find("Window/Download"), "")
		end

		GetImageSpriteFromAtlasAsync("dorm3dbanner/" .. string.lower(var_3_7:getConfig("assets_prefix")), "", arg_3_0._tf:Find("Window/Preview/Image"))
	end

	setText(arg_3_0._tf:Find("Window/Confirm/Text"), i18n("msgbox_text_confirm"))
	setText(arg_3_0._tf:Find("Window/Cancel/Text"), i18n("msgbox_text_cancel"))
	pg.UIMgr.GetInstance():OverlayPanel(arg_3_0._tf)

	return
end

function var_0_0.InitBanner(arg_8_0)
	for iter_8_0 = 1, #arg_8_0.bannerConfig do
		LoadImageSpriteAsync("dorm3dbanner/" .. arg_8_0.bannerConfig[iter_8_0], (arg_8_0.scrollSnap:AddChild()))
	end

	arg_8_0.scrollSnap:SetUp()

	return
end

function var_0_0.InitUIList(arg_9_0)
	arg_9_0.bubbleList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventInit then
			LoadImageSpriteAtlasAsync("ui/shoptip_atlas", "icon_" .. arg_9_0.markConfig[arg_10_1 + 1], arg_10_2:Find("icon/icon"), true)
			setText(arg_10_2:Find("bubble/Text"), i18n("dorm3d_shop_tag" .. arg_9_0.markConfig[arg_10_1 + 1]))
			setActive(arg_10_2:Find("bubble"), false)
			onToggle(arg_9_0, arg_10_2, function(arg_11_0)
				setActive(arg_10_2:Find("icon/select"), arg_11_0)
				setActive(arg_10_2:Find("icon/unselect"), not arg_11_0)
				setActive(arg_10_2:Find("bubble"), arg_11_0)

				return
			end)
		end

		return
	end)
	arg_9_0.bubbleList:align(#arg_9_0.markConfig)

	return
end

function var_0_0.willExit(arg_12_0)
	arg_12_0.scrollSnap:Dispose()

	arg_12_0.scrollSnap = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_12_0._tf)

	return
end

return var_0_0
