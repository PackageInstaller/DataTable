class = var_0_10000

local var_0_0 = "Dorm3dRoomUnlockWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dRoomUnlockWindow"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bubbleContent = var_1.Find(var_2_0, "Window/Bubbles/content")

	local var_2_1 = arg_2_0._tf

	arg_2_0.bubbleTpl = var_1.Find(var_2_1, "Window/Bubbles/tpl")
	UIItemList = var_1
	arg_2_0.bubbleList = var_1.New(arg_2_0.bubbleContent, arg_2_0.bubbleTpl)
	BannerScrollRect4Dorm = var_1

	local var_2_2 = var_1.New
	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_3.Find(var_2_3, "Window/banner/mask/content")
	local var_2_5 = arg_2_0._tf

	arg_2_0.scrollSnap = var_2_2(var_2_4, var_4.Find(var_2_5, "Window/banner/dots"))
	setActive = var_1

	var_1(arg_2_0.bubbleTpl, false)

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "Window/Confirm")

	local function var_3_3()
		if arg_3_0.contextData.groupId then
			local var_4_0 = arg_3_0
			local var_4_1 = var_0.emit

			Dorm3dRoomUnlockWindowMediator = var_2_10003

			var_4_1(var_4_0, var_2_10003.ON_UNLOCK_ROOM_INVITE, arg_3_0.contextData.roomId, arg_3_0.contextData.groupId)
		else
			local var_4_2 = arg_3_0
			local var_4_3 = var_0.emit

			Dorm3dRoomUnlockWindowMediator = var_2_10003

			var_4_3(var_4_2, var_2_10003.ON_UNLOCK_DORM_ROOM, arg_3_0.contextData.roomId)
		end

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_4.Find(var_3_5, "Window/Cancel")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_3_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_3_5)

	onButton = var_1_10001

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0._tf

	var_1_10001(var_3_8, var_4.Find(var_3_9, "bg"), function()
		local var_6_0 = arg_3_0

		var_0.closeView(var_6_0)

		return
	end)

	setActive = var_1_10001

	local var_3_10 = arg_3_0._tf

	var_1_10001(var_3.Find(var_3_10, "Window/Title/unlock"), not arg_3_0.contextData.groupId)

	setActive = var_1_10001

	local var_3_11 = arg_3_0._tf

	var_1_10001(var_3.Find(var_3_11, "Window/Title/invite"), arg_3_0.contextData.groupId)

	local var_3_13, var_3_14

	if arg_3_0.contextData.groupId then
		getProxy = var_3_13
		ApartmentProxy = var_3

		local var_3_12 = var_3_13(var_3)

		var_3_13 = var_3_13.getRoom(var_3_12, arg_3_0.contextData.roomId)
		Apartment = var_1_10002
		var_1_10002 = var_1_10002.getGroupConfig
		var_3_14 = arg_3_0.contextData.groupId

		local var_3_15 = var_3_13

		var_1_10002 = var_1_10002(var_3_14, var_3_13.getConfig(var_3_15, "invite_cost"))
		CommonCommodity = var_3_12

		local var_3_16 = var_3_12.New

		var_3_11 = {
			id = var_1_10002
		}
		Goods = var_6

		local var_3_17 = var_3_16(var_3_11, var_6.TYPE_SHOPSTREET)
		local var_3_18

		var_3_14, var_3_11, var_3_18 = var_3.GetPrice(var_3_17)
		Drop = var_3_15

		local var_3_19 = var_3_15.New
		local var_3_20 = {}

		DROP_TYPE_RESOURCE = var_1_10010
		var_3_20.type = var_1_10010
		var_3_20.id = var_3:GetResType()
		var_3_20.count = var_3_14

		if var_3_19(var_3_20).count == 0 then
			setText = var_1_10008

			local var_3_21 = arg_3_0._tf

			var_1_10010 = var_1_10010.Find(var_3_21, "Window/Content")
			i18n = var_1_10011

			local var_3_22 = "dorm3d_invite_confirm_free"
			local var_3_23 = "<icon name=" .. var_3:GetResIcon() .. " w=1.1 h=1.1/>"
			local var_3_24 = var_3_18

			ShipGroup = var_16

			var_1_10008(var_1_10010, var_1_10011(var_3_22, var_3_23, var_3_24, var_16.getDefaultShipNameByGroupID(arg_3_0.contextData.groupId), var_3_13:getConfig("room")))
		elseif 0 < var_3_11 then
			setText = var_1_10008

			local var_3_25 = arg_3_0._tf

			var_1_10010 = var_1_10010.Find(var_3_25, "Window/Content")
			i18n = var_1_10011

			local var_3_26 = "dorm3d_invite_confirm_discount"
			local var_3_27 = "<icon name="
			local var_3_28 = var_3
			local var_3_29 = var_3_27 .. var_3.GetResIcon(var_3_28) .. " w=1.1 h=1.1/>"
			local var_3_30 = var_7.count
			local var_3_31 = var_3_18

			ShipGroup = var_3_28

			var_1_10008(var_1_10010, var_1_10011(var_3_26, var_3_29, var_3_30, var_3_31, var_3_28.getDefaultShipNameByGroupID(arg_3_0.contextData.groupId), var_3_13:getConfig("room")))
		else
			setText = var_1_10008

			local var_3_32 = arg_3_0._tf

			var_1_10010 = var_1_10010.Find(var_3_32, "Window/Content")
			i18n = var_1_10011

			local var_3_33 = "dorm3d_invite_confirm_original"
			local var_3_34 = "<icon name=" .. var_3:GetResIcon() .. " w=1.1 h=1.1/>"
			local var_3_35 = var_7.count

			ShipGroup = var_16

			var_1_10008(var_1_10010, var_1_10011(var_3_33, var_3_34, var_3_35, var_16.getDefaultShipNameByGroupID(arg_3_0.contextData.groupId), var_3_13:getConfig("room")))
		end

		setText = var_1_10008

		local var_3_36 = arg_3_0._tf

		var_1_10008(var_1_10010.Find(var_3_36, "Window/Download"), "")

		setActive = var_1_10008

		local var_3_37 = arg_3_0._tf

		var_1_10008(var_1_10010.Find(var_3_37, "Window/Preview"), false)

		Apartment = var_1_10008
		arg_3_0.bannerConfig = var_1_10008.getGroupConfig(arg_3_0.contextData.groupId, var_3_13:getConfig("invite_banner"))
		Apartment = var_1_10008
		arg_3_0.markConfig = var_1_10008.getGroupConfig(arg_3_0.contextData.groupId, var_3_13:getConfig("invite_mark"))
		var_1_10010 = arg_3_0

		arg_3_0.InitBanner(var_1_10010)

		var_1_10010 = arg_3_0

		arg_3_0.InitUIList(var_1_10010)
	else
		ApartmentRoom = var_3_13
		var_3_13 = var_3_13.New({
			id = arg_3_0.contextData.roomId
		})
		setText = var_1_10002

		local var_3_38 = arg_3_0._tf

		var_3_14 = var_3_14.Find(var_3_38, "Window/Content")
		i18n = var_3_11

		local var_3_39 = "dorm3d_beach_buy"

		table = var_1_10008

		local var_3_40 = var_1_10008.concat

		underscore = var_1_10010

		var_1_10002(var_3_14, var_3_11(var_3_39, var_3_40(var_1_10010.map(var_3_13:getConfig("unlock_item"), function(arg_7_0)
			Drop = var_2_10001

			local var_7_0 = var_2_10001.Create(arg_7_0)

			string = var_2_10002

			return var_2_10002.format("%s*%d", var_7_0:getName(), var_7_0.count)
		end)), var_3_13:getConfig("room")))

		var_3_14 = var_3_13

		local var_3_41

		if var_3_13.needDownload(var_3_14) then
			var_3_14 = var_3_13

			local var_3_42

			var_3_41, var_3_42 = var_3_13.getDownloadNeedSize(var_3_14)
			setText = var_3_14

			local var_3_43 = arg_3_0._tf
			local var_3_44 = var_6.Find(var_3_43, "Window/Download")

			i18n = var_3_39

			var_3_14(var_3_44, var_3_39("dorm3d_beach_download", var_3_42))
		else
			setText = var_3_41

			local var_3_45 = arg_3_0._tf

			var_3_41(var_3_14.Find(var_3_45, "Window/Download"), "")
		end

		GetImageSpriteFromAtlasAsync = var_3_41
		var_3_14 = "dorm3dbanner/"
		string = var_5
		var_3_14 = var_3_14 .. var_5.lower(var_3_13:getConfig("assets_prefix"))

		local var_3_46 = ""
		local var_3_47 = arg_3_0._tf

		var_3_41(var_3_14, var_3_46, var_6.Find(var_3_47, "Window/Preview/Image"))
	end

	setText = var_3_13

	local var_3_48 = arg_3_0._tf
	local var_3_49 = var_3.Find(var_3_48, "Window/Confirm/Text")

	i18n = var_3_14

	var_3_13(var_3_49, var_3_14("msgbox_text_confirm"))

	setText = var_3_13

	local var_3_50 = arg_3_0._tf
	local var_3_51 = var_3.Find(var_3_50, "Window/Cancel/Text")

	i18n = var_4

	var_3_13(var_3_51, var_4("msgbox_text_cancel"))

	pg = var_3_13

	local var_3_52 = var_3_13.UIMgr.GetInstance()

	var_1.OverlayPanel(var_3_52, arg_3_0._tf)

	return
end

function var_0_1.InitBanner(arg_8_0)
	for iter_8_0 = 1, #arg_8_0.bannerConfig do
		local var_8_0 = arg_8_0.scrollSnap
		local var_8_1 = var_5.AddChild(var_8_0)

		LoadImageSpriteAsync = var_1_10006

		var_1_10006("dorm3dbanner/" .. arg_8_0.bannerConfig[iter_8_0], var_8_1)
	end

	local var_8_2 = arg_8_0.scrollSnap

	var_1.SetUp(var_8_2)

	return
end

function var_0_1.InitUIList(arg_9_0)
	local var_9_0 = arg_9_0.bubbleList

	var_1.make(var_9_0, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventInit then
			local var_10_0 = arg_10_1 + 1
			local var_10_1 = arg_9_0.markConfig[var_10_0]

			LoadImageSpriteAtlasAsync = var_2_10005

			var_2_10005("ui/shoptip_atlas", "icon_" .. var_10_1, arg_10_2:Find("icon/icon"), true)

			setText = var_2_10005

			local var_10_2 = arg_10_2:Find("bubble/Text")

			i18n = var_8

			var_2_10005(var_10_2, var_8("dorm3d_shop_tag" .. var_10_1))

			setActive = var_2_10005

			var_2_10005(arg_10_2:Find("bubble"), false)

			onToggle = var_2_10005

			var_2_10005(arg_9_0, arg_10_2, function(arg_11_0)
				setActive = var_3_10001

				local var_11_0 = arg_10_2

				var_3_10001(var_3.Find(var_11_0, "icon/select"), arg_11_0)

				setActive = var_3_10001

				local var_11_1 = arg_10_2

				var_3_10001(var_3.Find(var_11_1, "icon/unselect"), not arg_11_0)

				setActive = var_3_10001

				local var_11_2 = arg_10_2

				var_3_10001(var_3.Find(var_11_2, "bubble"), arg_11_0)

				return
			end)
		end

		return
	end)

	local var_9_1 = arg_9_0.bubbleList

	var_1.align(var_9_1, #arg_9_0.markConfig)

	return
end

function var_0_1.willExit(arg_12_0)
	local var_12_0 = arg_12_0.scrollSnap

	var_1.Dispose(var_12_0)

	arg_12_0.scrollSnap = nil
	pg = var_1

	local var_12_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_12_1, arg_12_0._tf)

	return
end

return var_0_1
