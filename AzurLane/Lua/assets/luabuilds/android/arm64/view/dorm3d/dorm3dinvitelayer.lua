class = var_0_10000

local var_0_0 = "Dorm3dInviteLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dInviteWindow"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rtInvitePanel = var_1.Find(var_2_0, "invite_panel")
	setText = var_1

	local var_2_1 = arg_2_0.rtInvitePanel
	local var_2_2 = var_3.Find(var_2_1, "window/Text")

	i18n = var_4

	var_1(var_2_2, var_4("dorm3d_invite_beach_tip"))

	setText = var_1

	local var_2_3 = arg_2_0.rtInvitePanel
	local var_2_4 = var_3.Find(var_2_3, "window/btn_confirm/Text")

	i18n = var_4

	var_1(var_2_4, var_4("text_confirm"))

	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.rtInvitePanel
	local var_2_7 = var_4.Find(var_2_6, "bg")

	local function var_2_8()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SFX_CANCEL = var_2_6

	var_1(var_2_5, var_2_7, var_2_8, var_2_6)

	onButton = var_1

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.rtInvitePanel
	local var_2_11 = var_4.Find(var_2_10, "window/btn_close")

	local function var_2_12()
		local var_4_0 = arg_2_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_2_10

	var_1(var_2_9, var_2_11, var_2_12, var_2_10)

	local var_2_13 = arg_2_0._tf

	arg_2_0.rtSelectPanel = var_1.Find(var_2_13, "select_panel")
	setText = var_1

	local var_2_14 = arg_2_0.rtSelectPanel
	local var_2_15 = var_3.Find(var_2_14, "window/character/title")

	i18n = var_4

	var_1(var_2_15, var_4("dorm3d_select_tip"))

	onButton = var_1

	local var_2_16 = arg_2_0
	local var_2_17 = arg_2_0.rtSelectPanel
	local var_2_18 = var_4.Find(var_2_17, "bg")

	local function var_2_19()
		local var_5_0 = arg_2_0

		var_0.HideSelectPanel(var_5_0)

		local var_5_1 = arg_2_0

		var_0.ShowInvitePanel(var_5_1)

		return
	end

	SFX_CANCEL = var_2_17

	var_1(var_2_16, var_2_18, var_2_19, var_2_17)

	setText = var_1

	local var_2_20 = arg_2_0.rtSelectPanel
	local var_2_21 = var_3.Find(var_2_20, "window/title/Text")

	i18n = var_2_18

	var_1(var_2_21, var_2_18("dorm3d_data_choose"))

	setText = var_1

	local var_2_22 = arg_2_0.rtSelectPanel
	local var_2_23 = var_3.Find(var_2_22, "window/bottom/container/btn_confirm/Text")

	i18n = var_4

	var_1(var_2_23, var_4("text_confirm"))

	i18n = var_1
	arg_2_0.selectCountTip = var_1("dorm3d_select_tip")

	return
end

function var_0_1.ShowInvitePanel(arg_6_0)
	GetImageSpriteFromAtlasAsync = var_1_10001

	local var_6_0 = "dorm3dselect/room_invite_"
	local var_6_1 = arg_6_0.room
	local var_6_2 = var_6_0 .. var_4.getConfig(var_6_1, "assets_prefix")
	local var_6_3 = ""
	local var_6_4 = arg_6_0.rtInvitePanel

	var_1_10001(var_6_2, var_6_3, var_5.Find(var_6_4, "window/Image"))

	setText = var_1_10001

	local var_6_5 = arg_6_0.rtInvitePanel
	local var_6_6 = var_3.Find(var_6_5, "window/Text")

	i18n = var_6_3

	local var_6_7 = "dorm3d_data_go"
	local var_6_8 = arg_6_0.room

	var_1_10001(var_6_6, var_6_3(var_6_7, var_7.getRoomName(var_6_8)))

	local var_6_9 = arg_6_0.room
	local var_6_10, var_6_11 = var_1.getInteractRange(var_6_9)
	local var_6_12 = arg_6_0.rtInvitePanel
	local var_6_13 = var_3.Find(var_6_12, "window/container")

	UIItemList = var_4

	var_4.StaticAlign(var_6_13, var_6_13:GetChild(0), var_6_11, function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_6_0.selectIds[arg_7_1]

			setActive = var_2_10004

			var_2_10004(arg_7_2:Find("empty"), not var_7_0)

			setActive = var_2_10004

			var_2_10004(arg_7_2:Find("ship"), var_7_0)

			if var_7_0 then
				pg = var_2_10004
				var_2_10004 = var_2_10004.dorm3d_resource.get_id_list_by_ship_group[var_7_0][1]
				GetImageSpriteFromAtlasAsync = var_2_10005
				pg = var_7

				var_2_10005(var_7.dorm3d_resource[var_2_10004].head_Icon, "", arg_7_2:Find("ship"), true)
			end

			onButton = var_2_10004

			local var_7_1 = arg_6_0
			local var_7_2 = arg_7_2

			local function var_7_3()
				local var_8_0 = arg_6_0

				var_0.HideInvitePanel(var_8_0)

				local var_8_1 = arg_6_0

				var_0.ShowSelectPanel(var_8_1)

				return
			end

			SFX_PANEL = var_9

			var_2_10004(var_7_1, var_7_2, var_7_3, var_9)

			if arg_7_1 == var_6_11 or not var_7_0 then
				getProxy = var_4
				PlayerProxy = var_7_1

				local var_7_4 = var_4(var_7_1)
				local var_7_5 = var_4.getRawData(var_7_4).id

				setActive = var_2_10005

				local var_7_6 = arg_7_2:Find("tip")

				PlayerPrefs = var_7_3

				var_2_10005(var_7_6, var_7_3.GetInt(var_7_5 .. "_dorm3dRoomInviteSuccess_" .. arg_6_0.room.id, 1) == 0)
			end
		end

		return
	end)

	onButton = var_4

	local var_6_14 = arg_6_0
	local var_6_15 = arg_6_0.rtInvitePanel
	local var_6_16 = var_7.Find(var_6_15, "window/btn_confirm")

	local function var_6_17()
		if #arg_6_0.selectIds < var_6_10 or #arg_6_0.selectIds > var_6_11 then
			pg = var_0

			local var_9_0 = var_0.TipsMgr.GetInstance()
			local var_9_1 = var_0.ShowTips

			i18n = var_2_10003

			var_9_1(var_9_0, var_2_10003("dorm3d_data_Invite_lack"))

			return
		end

		local var_9_2 = {}

		if #arg_6_0.selectIds >= 3 then
			ApartmentProxy = var_1

			if not var_1.CheckDeviceRAMEnough() then
				table = var_1

				var_1.insert(var_9_2, function(arg_10_0)
					pg = var_3_10001

					local var_10_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_10_1 = var_1.ShowMsgBox
					local var_10_2 = {}

					i18n = var_3_10005
					var_10_2.content = var_3_10005("drom3d_beach_memory_limit_tip")
					var_10_2.onYes = arg_10_0

					var_10_1(var_10_0, var_10_2)

					return
				end)
			end
		end

		table = var_1

		var_1.insert(var_9_2, function(arg_11_0)
			getProxy = var_3_10001
			ApartmentProxy = var_3_10003

			local var_11_0 = var_3_10001(var_3_10003)

			var_1.SetRoomInviteList(var_11_0, arg_6_0.room.id, arg_6_0.selectIds)
			arg_11_0()

			return
		end)

		seriesAsync = var_1

		var_1(var_9_2, function()
			local var_12_0 = arg_6_0
			local var_12_1 = var_0.emit

			Dorm3dInviteMediator = var_3_10003

			local var_12_2 = var_3_10003.ON_DORM
			local var_12_3 = {
				roomId = arg_6_0.room.id
			}

			underscore = var_5
			var_12_3.groupIds = var_5.rest(arg_6_0.selectIds, 1)

			var_12_1(var_12_0, var_12_2, var_12_3)

			return
		end)

		return
	end

	SFX_CONFIRM = var_6_15

	var_4(var_6_14, var_6_16, var_6_17, var_6_15)

	pg = var_4

	local var_6_18 = var_4.UIMgr.GetInstance()

	var_4.OverlayPanel(var_6_18, arg_6_0.rtInvitePanel, {
		force = true
	})

	setActive = var_4

	var_4(arg_6_0.rtInvitePanel, true)

	pg = var_4

	local var_6_19 = var_4.CriMgr.GetInstance()

	var_4.PlaySE_V3(var_6_19, "ui-dorm_sidebar")

	return
end

function var_0_1.HideInvitePanel(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_13_0, arg_13_0.rtInvitePanel, arg_13_0._tf)

	setActive = var_1

	var_1(arg_13_0.rtInvitePanel, false)

	return
end

function var_0_1.ShowSelectPanel(arg_14_0)
	local var_14_0 = arg_14_0.room
	local var_14_1 = var_1.getInviteList(var_14_0)
	local var_14_2 = arg_14_0.room
	local var_14_3, var_14_4 = var_2.getInteractRange(var_14_2)
	local var_14_5 = {}
	local var_14_6 = {}

	ipairs = var_1_10006

	for iter_14_0, iter_14_1 in var_1_10006(var_14_1) do
		if not arg_14_0.room.unlockCharacter[iter_14_1] then
			var_14_6[iter_14_1] = "lock"
		else
			getProxy = var_11
			ApartmentProxy = var_1_10013
			var_1_10013 = var_11(var_1_10013)

			if not var_11.getApartment(var_1_10013, iter_14_1) then
				var_14_6[iter_14_1] = "room"
			else
				Apartment = var_11
				var_1_10013 = var_11.New({
					ship_group = iter_14_1
				})

				if var_11.needDownload(var_1_10013) then
					var_14_6[iter_14_1] = "download"
				else
					var_14_6[iter_14_1] = nil
				end
			end
		end
	end

	getProxy = var_6
	PlayerProxy = var_8

	local var_14_7 = var_6(var_8)
	local var_14_8 = var_6.getRawData(var_14_7).id
	local var_14_9 = arg_14_0.rtSelectPanel
	local var_14_10 = var_7.Find(var_14_9, "window/character/container")

	UIItemList = var_14_7

	var_14_7.StaticAlign(var_14_10, var_14_10:GetChild(0), #var_14_1, function(arg_15_0, arg_15_1, arg_15_2)
		arg_15_1 = arg_15_1 + 1
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			local var_15_0 = var_14_1[arg_15_1]

			setActive = var_2_10004

			var_2_10004(arg_15_2:Find("base"), var_15_0)

			setActive = var_2_10004

			var_2_10004(arg_15_2:Find("empty"), not var_15_0)

			local var_15_6

			if not var_15_0 then
				arg_15_2.name = "null"
				setText = var_2_10004

				local var_15_1 = arg_15_2:Find("empty/Text")

				i18n = var_15_6

				var_2_10004(var_15_1, var_15_6("dorm3d_waiting"))
			else
				tostring = var_2_10004
				arg_15_2.name = var_2_10004(var_15_0)

				local var_15_2 = arg_14_0

				var_2_10004.UpdateSelectableCard(var_15_2, arg_15_2:Find("base"), var_15_0, function(arg_16_0)
					table = var_3_10001

					var_3_10001.removebyvalue(var_14_5, var_15_0, true)

					if arg_16_0 then
						table = var_1

						var_1.insert(var_14_5, var_15_0)
					end

					setText = var_1

					local var_16_0 = arg_14_0.rtSelectPanel

					var_1(var_3.Find(var_16_0, "window/bottom/title/Text"), arg_14_0.selectCountTip .. #var_14_5 .. "/" .. var_14_4)

					return
				end)

				triggerToggle = var_2_10004

				local var_15_3 = arg_15_2:Find("base")

				table = var_15_6

				var_2_10004(var_15_3, var_15_6.contains(arg_14_0.selectIds, var_15_0))

				setActive = var_2_10004

				var_2_10004(arg_15_2:Find("base/mask"), var_14_6[var_15_0])

				onButton = var_2_10004

				local var_15_4 = arg_14_0
				local var_15_5 = arg_15_2

				var_15_6 = arg_15_2.Find(var_15_5, "base/mask")

				local function var_15_7()
					if var_14_6[var_15_0] == "lock" then
						local var_17_0 = arg_14_0

						var_0.HideSelectPanel(var_17_0)

						local var_17_1 = arg_14_0
						local var_17_2 = var_0.emit

						Dorm3dInviteMediator = var_3_10003
						var_3_10003 = var_3_10003.OPEN_ROOM_UNLOCK_WINDOW

						local var_17_3 = arg_14_0.room

						var_17_2(var_17_1, var_3_10003, var_4.GetConfigID(var_17_3), var_15_0)
					elseif var_14_6[var_15_0] == "room" then
						pg = var_0

						local var_17_4 = var_0.TipsMgr.GetInstance()
						local var_17_5 = var_0.ShowTips

						i18n = var_3_10003

						var_17_5(var_17_4, var_3_10003("dorm3d_role_locked"))
					elseif var_14_6[var_15_0] == "download" then
						pg = var_0

						local var_17_6 = var_0.TipsMgr.GetInstance()
						local var_17_7 = var_0.ShowTips

						i18n = var_3_10003

						var_17_7(var_17_6, var_3_10003("dorm3d_guide_beach_tip"))
					end

					return
				end

				SFX_PANEL = var_15_5

				var_2_10004(var_15_4, var_15_6, var_15_7, var_15_5)

				eachChild = var_2_10004

				var_2_10004(arg_15_2:Find("base/operation"), function(arg_18_0)
					setActive = var_3_10001

					var_3_10001(arg_18_0, arg_18_0.name == var_14_6[var_15_0])

					return
				end)
			end

			setActive = var_2_10004

			local var_15_8 = arg_15_2:Find("tip")

			PlayerPrefs = var_15_6

			var_2_10004(var_15_8, var_15_6.GetInt(var_14_8 .. "_dorm3dRoomInviteSuccess_" .. arg_14_0.room.id .. "_" .. var_15_0, 1) == 0)

			PlayerPrefs = var_2_10004

			var_2_10004.SetInt(var_14_8 .. "_dorm3dRoomInviteSuccess_" .. arg_14_0.room.id .. "_" .. var_15_0, 1)
		end

		return
	end)

	PlayerPrefs = var_8

	var_8.SetInt(var_14_8 .. "_dorm3dRoomInviteSuccess_" .. arg_14_0.room.id, 1)

	onButton = var_8

	local var_14_11 = arg_14_0
	local var_14_12 = arg_14_0.rtSelectPanel
	local var_14_13 = var_11.Find(var_14_12, "window/bottom/container/btn_confirm")

	local function var_14_14()
		if #var_14_5 > var_14_4 then
			pg = var_0

			local var_19_0 = var_0.TipsMgr.GetInstance()
			local var_19_1 = var_0.ShowTips

			i18n = var_2_10003

			var_19_1(var_19_0, var_2_10003("dorm3d_data_Invite_lack"))

			return
		end

		arg_14_0.selectIds = var_14_5

		local var_19_2 = arg_14_0

		var_0.HideSelectPanel(var_19_2)

		local var_19_3 = arg_14_0

		var_0.ShowInvitePanel(var_19_3)

		return
	end

	SFX_CONFIRM = var_14_12

	var_8(var_14_11, var_14_13, var_14_14, var_14_12)

	pg = var_8

	local var_14_15 = var_8.UIMgr.GetInstance()
	local var_14_16 = var_8.OverlayPanel
	local var_14_17 = arg_14_0.rtSelectPanel
	local var_14_18 = {
		force = true
	}
	local var_14_19 = {}
	local var_14_20 = arg_14_0.rtSelectPanel

	var_14_19[1] = var_14.Find(var_14_20, "window")
	var_14_18.pbList = var_14_19

	var_14_16(var_14_15, var_14_17, var_14_18)

	setActive = var_14_16

	var_14_16(arg_14_0.rtSelectPanel, true)

	return
end

function var_0_1.UpdateSelectableCard(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	Apartment = var_1_10004

	local var_20_0 = var_1_10004.New({
		ship_group = arg_20_2
	})
	local var_20_1 = var_4.GetSkinModelID
	local var_20_2 = arg_20_0.room
	local var_20_3 = var_20_1(var_20_0, var_7.getConfig(var_20_2, "tag"))

	GetImageSpriteFromAtlasAsync = var_1_10005
	string = var_7

	var_1_10005(var_7.format("dorm3dselect/room_card_apartment_%d", var_20_3), "", arg_20_1:Find("Image"))

	GetImageSpriteFromAtlasAsync = var_1_10005
	string = var_7

	var_1_10005(var_7.format("dorm3dselect/room_card_apartment_name_%d", arg_20_2), "", arg_20_1:Find("name"))

	getProxy = var_1_10005
	ApartmentProxy = var_7

	local var_20_4 = var_1_10005(var_7)
	local var_20_5 = not var_5.getApartment(var_20_4, arg_20_2) or var_5:needDownload()

	setActive = var_20_4

	var_20_4(arg_20_1:Find("lock"), var_20_5)

	setActive = var_20_4

	var_20_4(arg_20_1:Find("mask"), var_20_5)

	setActive = var_20_4

	var_20_4(arg_20_1:Find("unlock"), not var_20_5)

	setActive = var_20_4

	var_20_4(arg_20_1:Find("favor_level"), var_5)

	if var_5 then
		setText = var_20_4

		var_20_4(arg_20_1:Find("favor_level/Text"), var_5.level)
	end

	onToggle = var_20_4

	local var_20_6 = arg_20_0
	local var_20_7 = arg_20_1

	local function var_20_8(arg_21_0)
		arg_20_3(arg_21_0)

		if arg_21_0 then
			if not var_0 then
				pg = var_1

				local var_21_0 = var_1.TipsMgr.GetInstance()
				local var_21_1 = var_1.ShowTips

				string = var_2_10004

				var_21_1(var_21_0, var_2_10004.format("need unlock apartment{%d}", arg_20_2))

				triggerToggle = var_21_1

				var_21_1(arg_20_1, false)
			else
				local var_21_2 = var_0

				if var_1.needDownload(var_21_2) then
					pg = var_1

					local var_21_3 = var_1.TipsMgr.GetInstance()
					local var_21_4 = var_1.ShowTips

					string = var_2_10004

					var_21_4(var_21_3, var_2_10004.format("need download resource{%d}", arg_20_2))

					triggerToggle = var_21_4

					var_21_4(arg_20_1, false)
				end
			end
		end

		return
	end

	SFX_UI_CLICK = var_12

	var_20_4(var_20_6, var_20_7, var_20_8, var_12)

	return
end

function var_0_1.HideSelectPanel(arg_22_0)
	pg = var_1_10001

	local var_22_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_22_0, arg_22_0.rtSelectPanel, arg_22_0._tf)

	setActive = var_1

	var_1(arg_22_0.rtSelectPanel, false)

	return
end

function var_0_1.UpdateRoom(arg_23_0, arg_23_1)
	arg_23_0.room = arg_23_1

	return
end

function var_0_1.didEnter(arg_24_0)
	underscore = var_1_10001

	local var_24_0 = var_1_10001.filter
	local var_24_1

	if not arg_24_0.contextData.groupIds then
		var_24_1 = {}
	end

	arg_24_0.selectIds = var_24_0(var_24_1, function(arg_25_0)
		local var_25_2

		if arg_24_0.room.unlockCharacter[arg_25_0] then
			tobool = var_25_2
			getProxy = var_2_10003
			ApartmentProxy = var_2_10005

			local var_25_0 = var_2_10003(var_2_10005)

			if var_25_2(var_3.getApartment(var_25_0, arg_25_0)) then
				Apartment = var_25_2

				local var_25_1 = var_25_2.New({
					ship_group = arg_25_0
				})

				var_25_2 = not var_25_2.needDownload(var_25_1)
			end
		end

		return var_25_2
	end)
	arg_24_0.contextData.groupIds = nil

	arg_24_0:ShowInvitePanel()

	return
end

function var_0_1.onBackPressed(arg_26_0)
	isActive = var_1_10001

	if var_1_10001(arg_26_0.rtSelectPanel) then
		arg_26_0:HideSelectPanel()
		arg_26_0:ShowInvitePanel()
	else
		arg_26_0:closeView()
	end

	return
end

function var_0_1.willExit(arg_27_0)
	isActive = var_1_10001

	if var_1_10001(arg_27_0.rtSelectPanel) then
		arg_27_0:HideSelectPanel()
	else
		arg_27_0:HideInvitePanel()
	end

	return
end

return var_0_1
