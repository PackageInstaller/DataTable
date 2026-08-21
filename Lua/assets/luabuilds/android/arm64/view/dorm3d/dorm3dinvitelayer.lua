local var_0_0 = class("Dorm3dInviteLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dInviteWindow"
end

function var_0_0.init(arg_2_0)
	arg_2_0.rtInvitePanel = arg_2_0._tf:Find("invite_panel")

	setText(arg_2_0.rtInvitePanel:Find("window/Text"), i18n("dorm3d_invite_beach_tip"))
	setText(arg_2_0.rtInvitePanel:Find("window/btn_confirm/Text"), i18n("text_confirm"))
	onButton(arg_2_0, arg_2_0.rtInvitePanel:Find("bg"), function()
		arg_2_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0.rtInvitePanel:Find("window/btn_close"), function()
		arg_2_0:closeView()

		return
	end, SFX_CANCEL)

	arg_2_0.rtSelectPanel = arg_2_0._tf:Find("select_panel")

	setText(arg_2_0.rtSelectPanel:Find("window/character/title"), i18n("dorm3d_select_tip"))
	onButton(arg_2_0, arg_2_0.rtSelectPanel:Find("bg"), function()
		arg_2_0:HideSelectPanel()
		arg_2_0:ShowInvitePanel()

		return
	end, SFX_CANCEL)
	setText(arg_2_0.rtSelectPanel:Find("window/title/Text"), i18n("dorm3d_data_choose"))
	setText(arg_2_0.rtSelectPanel:Find("window/bottom/container/btn_confirm/Text"), i18n("text_confirm"))

	arg_2_0.selectCountTip = i18n("dorm3d_select_tip")

	return
end

function var_0_0.ShowInvitePanel(arg_6_0)
	GetImageSpriteFromAtlasAsync("dorm3dselect/room_invite_" .. arg_6_0.room:getConfig("assets_prefix"), "", arg_6_0.rtInvitePanel:Find("window/Image"))
	setText(arg_6_0.rtInvitePanel:Find("window/Text"), i18n("dorm3d_data_go", arg_6_0.room:getRoomName()))

	local var_6_0, var_6_1 = arg_6_0.room:getInteractRange()
	local var_6_2 = arg_6_0.rtInvitePanel:Find("window/container")

	UIItemList.StaticAlign(var_6_2, var_6_2:GetChild(0), var_6_1, function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1

		if arg_7_0 == UIItemList.EventUpdate then
			setActive(arg_7_2:Find("empty"), not arg_6_0.selectIds[arg_7_1])
			setActive(arg_7_2:Find("ship"), arg_6_0.selectIds[arg_7_1])

			if arg_6_0.selectIds[arg_7_1] then
				GetImageSpriteFromAtlasAsync(pg.dorm3d_resource[pg.dorm3d_resource.get_id_list_by_ship_group[arg_6_0.selectIds[arg_7_1]][1]].head_Icon, "", arg_7_2:Find("ship"), true)
			end

			onButton(arg_6_0, arg_7_2, function()
				arg_6_0:HideInvitePanel()
				arg_6_0:ShowSelectPanel()

				return
			end, SFX_PANEL)

			if arg_7_1 == var_6_1 or not arg_6_0.selectIds[arg_7_1] then
				local var_7_0 = getProxy(PlayerProxy)

				setActive(arg_7_2:Find("tip"), PlayerPrefs.GetInt(var_7_0:getRawData().id .. "_dorm3dRoomInviteSuccess_" .. arg_6_0.room.id, 1) == 0)
			end
		end

		return
	end)
	onButton(arg_6_0, arg_6_0.rtInvitePanel:Find("window/btn_confirm"), function()
		if #arg_6_0.selectIds < var_6_0 or #arg_6_0.selectIds > var_6_1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_data_Invite_lack"))

			return
		end

		local var_9_0 = {}

		if #arg_6_0.selectIds >= 3 and not ApartmentProxy.CheckDeviceRAMEnough() then
			table.insert(var_9_0, function(arg_10_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("drom3d_beach_memory_limit_tip"),
					onYes = arg_10_0
				})

				return
			end)
		end

		table.insert(var_9_0, function(arg_11_0)
			getProxy(ApartmentProxy):SetRoomInviteList(arg_6_0.room.id, arg_6_0.selectIds)
			arg_11_0()

			return
		end)
		seriesAsync(var_9_0, function()
			arg_6_0:emit(Dorm3dInviteMediator.ON_DORM, {
				roomId = arg_6_0.room.id,
				groupIds = underscore.rest(arg_6_0.selectIds, 1)
			})

			return
		end)

		return
	end, SFX_CONFIRM)
	pg.UIMgr.GetInstance():OverlayPanel(arg_6_0.rtInvitePanel, {
		force = true
	})
	setActive(arg_6_0.rtInvitePanel, true)
	pg.CriMgr.GetInstance():PlaySE_V3("ui-dorm_sidebar")

	return
end

function var_0_0.HideInvitePanel(arg_13_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_13_0.rtInvitePanel, arg_13_0._tf)
	setActive(arg_13_0.rtInvitePanel, false)

	return
end

function var_0_0.ShowSelectPanel(arg_14_0)
	local var_14_0 = arg_14_0.room:getInviteList()
	local var_14_1, var_14_2 = arg_14_0.room:getInteractRange()
	local var_14_3 = {}
	local var_14_4 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if not arg_14_0.room.unlockCharacter[iter_14_1] then
			({})[iter_14_1] = "lock"
		else
			local var_14_5 = getProxy(ApartmentProxy)

			if not var_14_5:getApartment(iter_14_1) then
				({})[iter_14_1] = "room"
			else
				local var_14_6 = Apartment.New({
					ship_group = iter_14_1
				})

				if var_14_6:needDownload() then
					({})[iter_14_1] = "download"
				else
					({})[iter_14_1] = nil
				end
			end
		end
	end

	local var_14_7 = getProxy(PlayerProxy):getRawData().id
	local var_14_8 = arg_14_0.rtSelectPanel:Find("window/character/container")

	UIItemList.StaticAlign(var_14_8, var_14_8:GetChild(0), #var_14_0, function(arg_15_0, arg_15_1, arg_15_2)
		arg_15_1 = arg_15_1 + 1

		if arg_15_0 == UIItemList.EventUpdate then
			local var_15_0 = var_14_0[arg_15_1]

			setActive(arg_15_2:Find("base"), var_14_0[arg_15_1])
			setActive(arg_15_2:Find("empty"), not var_15_0)

			if not var_15_0 then
				arg_15_2.name = "null"

				setText(arg_15_2:Find("empty/Text"), i18n("dorm3d_waiting"))
			else
				arg_15_2.name = tostring(var_15_0)

				arg_14_0:UpdateSelectableCard(arg_15_2:Find("base"), var_15_0, function(arg_16_0)
					table.removebyvalue(var_14_3, var_15_0, true)

					if arg_16_0 then
						table.insert(var_14_3, var_15_0)
					end

					setText(arg_14_0.rtSelectPanel:Find("window/bottom/title/Text"), arg_14_0.selectCountTip .. #var_14_3 .. "/" .. var_14_2)

					return
				end)
				triggerToggle(arg_15_2:Find("base"), table.contains(arg_14_0.selectIds, var_15_0))
				setActive(arg_15_2:Find("base/mask"), var_14_4[var_15_0])
				onButton(arg_14_0, arg_15_2:Find("base/mask"), function()
					if var_14_4[var_15_0] == "lock" then
						arg_14_0:HideSelectPanel()
						arg_14_0:emit(Dorm3dInviteMediator.OPEN_ROOM_UNLOCK_WINDOW, arg_14_0.room:GetConfigID(), var_15_0)
					elseif var_14_4[var_15_0] == "room" then
						pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_role_locked"))
					elseif var_14_4[var_15_0] == "download" then
						pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_guide_beach_tip"))
					end

					return
				end, SFX_PANEL)
				eachChild(arg_15_2:Find("base/operation"), function(arg_18_0)
					setActive(arg_18_0, arg_18_0.name == var_14_4[var_15_0])

					return
				end)
			end

			setActive(arg_15_2:Find("tip"), PlayerPrefs.GetInt(var_14_7 .. "_dorm3dRoomInviteSuccess_" .. arg_14_0.room.id .. "_" .. var_15_0, 1) == 0)
			PlayerPrefs.SetInt(var_14_7 .. "_dorm3dRoomInviteSuccess_" .. arg_14_0.room.id .. "_" .. var_15_0, 1)
		end

		return
	end)
	PlayerPrefs.SetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dRoomInviteSuccess_" .. arg_14_0.room.id, 1)
	onButton(arg_14_0, arg_14_0.rtSelectPanel:Find("window/bottom/container/btn_confirm"), function()
		if #var_14_3 > var_14_2 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_data_Invite_lack"))

			return
		end

		arg_14_0.selectIds = var_14_3

		arg_14_0:HideSelectPanel()
		arg_14_0:ShowInvitePanel()

		return
	end, SFX_CONFIRM)
	pg.UIMgr.GetInstance():OverlayPanel(arg_14_0.rtSelectPanel, {
		force = true,
		pbList = {
			arg_14_0.rtSelectPanel:Find("window")
		}
	})
	setActive(arg_14_0.rtSelectPanel, true)

	return
end

function var_0_0.UpdateSelectableCard(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	GetImageSpriteFromAtlasAsync(string.format("dorm3dselect/room_card_apartment_%d", (Apartment.New({
		ship_group = arg_20_2
	}):GetSkinModelID(arg_20_0.room:getConfig("tag")))), "", arg_20_1:Find("Image"))
	GetImageSpriteFromAtlasAsync(string.format("dorm3dselect/room_card_apartment_name_%d", arg_20_2), "", arg_20_1:Find("name"))

	local var_20_0 = getProxy(ApartmentProxy):getApartment(arg_20_2)
	local var_20_1 = not var_20_0 or var_20_0:needDownload()

	setActive(arg_20_1:Find("lock"), var_20_1)
	setActive(arg_20_1:Find("mask"), var_20_1)
	setActive(arg_20_1:Find("unlock"), not var_20_1)
	setActive(arg_20_1:Find("favor_level"), var_20_0)

	if var_20_0 then
		setText(arg_20_1:Find("favor_level/Text"), var_20_0.level)
	end

	onToggle(arg_20_0, arg_20_1, function(arg_21_0)
		arg_20_3(arg_21_0)

		if arg_21_0 then
			if not var_20_0 then
				pg.TipsMgr.GetInstance():ShowTips(string.format("need unlock apartment{%d}", arg_20_2))
				triggerToggle(arg_20_1, false)
			elseif var_20_0:needDownload() then
				pg.TipsMgr.GetInstance():ShowTips(string.format("need download resource{%d}", arg_20_2))
				triggerToggle(arg_20_1, false)
			end
		end

		return
	end, SFX_UI_CLICK)

	return
end

function var_0_0.HideSelectPanel(arg_22_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_22_0.rtSelectPanel, arg_22_0._tf)
	setActive(arg_22_0.rtSelectPanel, false)

	return
end

function var_0_0.UpdateRoom(arg_23_0, arg_23_1)
	arg_23_0.room = arg_23_1

	return
end

function var_0_0.didEnter(arg_24_0)
	local var_24_0 = arg_24_0.contextData.groupIds or {}

	arg_24_0.selectIds = underscore.filter(var_24_0, function(arg_25_0)
		local var_25_0 = arg_24_0.room.unlockCharacter[arg_25_0]

		if arg_24_0.room.unlockCharacter[arg_25_0] then
			var_25_0 = tobool(getProxy(ApartmentProxy):getApartment(arg_25_0))

			if var_25_0 then
				var_25_0 = not Apartment.New({
					ship_group = arg_25_0
				}):needDownload()
			end
		end

		return var_25_0
	end)
	arg_24_0.contextData.groupIds = nil

	arg_24_0:ShowInvitePanel()

	return
end

function var_0_0.onBackPressed(arg_26_0)
	if isActive(arg_26_0.rtSelectPanel) then
		arg_26_0:HideSelectPanel()
		arg_26_0:ShowInvitePanel()
	else
		arg_26_0:closeView()
	end

	return
end

function var_0_0.willExit(arg_27_0)
	if isActive(arg_27_0.rtSelectPanel) then
		arg_27_0:HideSelectPanel()
	else
		arg_27_0:HideInvitePanel()
	end

	return
end

return var_0_0
