local Dorm3dInviteLayer = class("Dorm3dInviteLayer", import("view.base.BaseUI"))

function Dorm3dInviteLayer:getUIName()
	return "Dorm3dInviteWindow"
end

function Dorm3dInviteLayer:init()
	self.rtInvitePanel = self._tf:Find("invite_panel")

	setText(self.rtInvitePanel:Find("window/Text"), i18n("dorm3d_invite_beach_tip"))
	setText(self.rtInvitePanel:Find("window/btn_confirm/Text"), i18n("text_confirm"))
	onButton(self, self.rtInvitePanel:Find("bg"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.rtInvitePanel:Find("window/btn_close"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	self.rtSelectPanel = self._tf:Find("select_panel")

	setText(self.rtSelectPanel:Find("window/character/title"), i18n("dorm3d_select_tip"))
	onButton(self, self.rtSelectPanel:Find("bg"), function()
		self:HideSelectPanel()
		self:ShowInvitePanel()

		return
	end, SFX_CANCEL)
	setText(self.rtSelectPanel:Find("window/title/Text"), i18n("dorm3d_data_choose"))
	setText(self.rtSelectPanel:Find("window/bottom/container/btn_confirm/Text"), i18n("text_confirm"))

	self.selectCountTip = i18n("dorm3d_select_tip")

	return
end

function Dorm3dInviteLayer:ShowInvitePanel()
	GetImageSpriteFromAtlasAsync("dorm3dselect/room_invite_" .. self.room:getConfig("assets_prefix"), "", self.rtInvitePanel:Find("window/Image"))
	setText(self.rtInvitePanel:Find("window/Text"), i18n("dorm3d_data_go", self.room:getRoomName()))

	local var_6_0, var_6_1 = self.room:getInteractRange()
	local var_6_2 = self.rtInvitePanel:Find("window/container")

	UIItemList.StaticAlign(var_6_2, var_6_2:GetChild(0), var_6_1, function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1

		if arg_7_0 == UIItemList.EventUpdate then
			setActive(arg_7_2:Find("empty"), not self.selectIds[arg_7_1])
			setActive(arg_7_2:Find("ship"), self.selectIds[arg_7_1])

			if self.selectIds[arg_7_1] then
				GetImageSpriteFromAtlasAsync(pg.dorm3d_resource[pg.dorm3d_resource.get_id_list_by_ship_group[self.selectIds[arg_7_1]][1]].head_Icon, "", arg_7_2:Find("ship"), true)
			end

			onButton(self, arg_7_2, function()
				self:HideInvitePanel()
				self:ShowSelectPanel()

				return
			end, SFX_PANEL)

			if arg_7_1 == var_6_1 or not self.selectIds[arg_7_1] then
				setActive(arg_7_2:Find("tip"), PlayerPrefs.GetInt(getProxy(PlayerProxy):getRawData().id .. "_dorm3dRoomInviteSuccess_" .. self.room.id, 1) == 0)
			end
		end

		return
	end)
	onButton(self, self.rtInvitePanel:Find("window/btn_confirm"), function()
		if #self.selectIds < var_6_0 or #self.selectIds > var_6_1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_data_Invite_lack"))

			return
		end

		local var_9_0 = {}

		if #self.selectIds >= 3 and not ApartmentProxy.CheckDeviceRAMEnough() then
			table.insert(var_9_0, function(arg_10_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("drom3d_beach_memory_limit_tip"),
					onYes = arg_10_0
				})

				return
			end)
		end

		table.insert(var_9_0, function(arg_11_0)
			getProxy(ApartmentProxy):SetRoomInviteList(self.room.id, self.selectIds)
			arg_11_0()

			return
		end)
		seriesAsync(var_9_0, function()
			self:emit(Dorm3dInviteMediator.ON_DORM, {
				roomId = self.room.id,
				groupIds = underscore.rest(self.selectIds, 1)
			})

			return
		end)

		return
	end, SFX_CONFIRM)
	pg.UIMgr.GetInstance():OverlayPanel(self.rtInvitePanel, {
		force = true
	})
	setActive(self.rtInvitePanel, true)
	pg.CriMgr.GetInstance():PlaySE_V3("ui-dorm_sidebar")

	return
end

function Dorm3dInviteLayer:HideInvitePanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.rtInvitePanel, self._tf)
	setActive(self.rtInvitePanel, false)

	return
end

function Dorm3dInviteLayer:ShowSelectPanel()
	local var_14_0 = self.room:getInviteList()
	local var_14_1, var_14_2 = self.room:getInteractRange()
	local var_14_3 = {}
	local var_14_4 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		var_14_4[iter_14_1] = not self.room.unlockCharacter[iter_14_1] and "lock" or not getProxy(ApartmentProxy):getApartment(iter_14_1) and "room" or Apartment.New({
			ship_group = iter_14_1
		}):needDownload() and "download" or nil
	end

	local var_14_5 = getProxy(PlayerProxy):getRawData().id
	local var_14_6 = self.rtSelectPanel:Find("window/character/container")

	UIItemList.StaticAlign(var_14_6, var_14_6:GetChild(0), #var_14_0, function(arg_15_0, arg_15_1, arg_15_2)
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

				self:UpdateSelectableCard(arg_15_2:Find("base"), var_15_0, function(arg_16_0)
					table.removebyvalue(var_14_3, var_15_0, true)

					if arg_16_0 then
						table.insert(var_14_3, var_15_0)
					end

					setText(self.rtSelectPanel:Find("window/bottom/title/Text"), self.selectCountTip .. #var_14_3 .. "/" .. var_14_2)

					return
				end)
				triggerToggle(arg_15_2:Find("base"), table.contains(self.selectIds, var_15_0))
				setActive(arg_15_2:Find("base/mask"), var_14_4[var_15_0])
				onButton(self, arg_15_2:Find("base/mask"), function()
					if var_14_4[var_15_0] == "lock" then
						self:HideSelectPanel()
						self:emit(Dorm3dInviteMediator.OPEN_ROOM_UNLOCK_WINDOW, self.room:GetConfigID(), var_15_0)
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

			setActive(arg_15_2:Find("tip"), PlayerPrefs.GetInt(var_14_5 .. "_dorm3dRoomInviteSuccess_" .. self.room.id .. "_" .. var_15_0, 1) == 0)
			PlayerPrefs.SetInt(var_14_5 .. "_dorm3dRoomInviteSuccess_" .. self.room.id .. "_" .. var_15_0, 1)
		end

		return
	end)
	PlayerPrefs.SetInt(var_14_5 .. "_dorm3dRoomInviteSuccess_" .. self.room.id, 1)
	onButton(self, self.rtSelectPanel:Find("window/bottom/container/btn_confirm"), function()
		if #var_14_3 > var_14_2 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_data_Invite_lack"))

			return
		end

		self.selectIds = var_14_3

		self:HideSelectPanel()
		self:ShowInvitePanel()

		return
	end, SFX_CONFIRM)
	pg.UIMgr.GetInstance():OverlayPanel(self.rtSelectPanel, {
		force = true,
		pbList = {
			self.rtSelectPanel:Find("window")
		}
	})
	setActive(self.rtSelectPanel, true)

	return
end

function Dorm3dInviteLayer:UpdateSelectableCard(arg_20_1, arg_20_2, arg_20_3)
	GetImageSpriteFromAtlasAsync(string.format("dorm3dselect/room_card_apartment_%d", (Apartment.New({
		ship_group = arg_20_2
	}):GetSkinModelID(self.room:getConfig("tag")))), "", arg_20_1:Find("Image"))
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

	onToggle(self, arg_20_1, function(arg_21_0)
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

function Dorm3dInviteLayer:HideSelectPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.rtSelectPanel, self._tf)
	setActive(self.rtSelectPanel, false)

	return
end

function Dorm3dInviteLayer:UpdateRoom(arg_23_1)
	self.room = arg_23_1

	return
end

function Dorm3dInviteLayer:didEnter()
	self.selectIds = underscore.filter(self.contextData.groupIds or {}, function(arg_25_0)
		local var_25_0 = self.room.unlockCharacter[arg_25_0]

		if self.room.unlockCharacter[arg_25_0] then
			var_25_0 = tobool(getProxy(ApartmentProxy):getApartment(arg_25_0))

			if var_25_0 then
				var_25_0 = not Apartment.New({
					ship_group = arg_25_0
				}):needDownload()
			end
		end

		return var_25_0
	end)
	self.contextData.groupIds = nil

	self:ShowInvitePanel()

	return
end

function Dorm3dInviteLayer:onBackPressed()
	if isActive(self.rtSelectPanel) then
		self:HideSelectPanel()
		self:ShowInvitePanel()
	else
		self:closeView()
	end

	return
end

function Dorm3dInviteLayer:willExit()
	if isActive(self.rtSelectPanel) then
		self:HideSelectPanel()
	else
		self:HideInvitePanel()
	end

	return
end

return Dorm3dInviteLayer
