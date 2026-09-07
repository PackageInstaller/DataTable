local Dorm3dLevelLayer = class("Dorm3dLevelLayer", import("view.base.BaseUI"))

Dorm3dLevelLayer.SERVER_TYPE = 1
Dorm3dLevelLayer.CLIENT_TYPE = 2
Dorm3dLevelLayer.STORY_TYPE = 3
Dorm3dLevelLayer.NAME_MIN_SIZE = 4
Dorm3dLevelLayer.NAME_SHORT_SIZE = 8
Dorm3dLevelLayer.NAME_LONG_SIZE = 14
Dorm3dLevelLayer.PLAYERPREFS_KEY = "Dorm3dLayer.playerprefs"

function Dorm3dLevelLayer:getUIName()
	return "Dorm3dLevelUI"
end

function Dorm3dLevelLayer:init()
	self.rtLevelPanel = self._tf:Find("panel")

	onButton(self, self._tf:Find("btn_back"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("bg"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.rtLevelPanel:Find("bg/bottom/btn_time"), function()
		local var_5_0 = getDorm3dGameset("drom3d_time_unlock")[1]

		if var_5_0 > self.apartment.level then
			pg.TipsMgr.GetInstance():ShowTips(i18n("apartment_level_unenough", var_5_0))

			return
		end

		self:ShowTimeSelectWindow()

		return
	end, SFX_PANEL)

	self.rtTimeSelectWindow = self._tf:Find("TimeSelectWindow")

	onButton(self, self.rtTimeSelectWindow:Find("bg"), function()
		setActive(self.rtTimeSelectWindow, false)
		self:UnOverlayPanel(self.rtTimeSelectWindow, self._tf)

		return
	end, SFX_CANCEL)

	self.rtRenameWindow = self._tf:Find("RenameWindow")

	onButton(self, self.rtLevelPanel:Find("bg/left/rot"), function()
		self:ShowRenameWindow()

		return
	end, SFX_PANEL)

	self.callInput = self.rtRenameWindow:Find("panel/input/nickname")

	onButton(self, self.rtRenameWindow:Find("panel/confirm"), function()
		local var_8_0 = getInputText(self.callInput)

		if var_8_0 == "" then
			return
		end

		if not nameValidityCheck(var_8_0, Dorm3dLevelLayer.NAME_MIN_SIZE, Dorm3dLevelLayer.NAME_LONG_SIZE, {
			"spece_illegal_tip",
			"dorm3d_appellation_waring3",
			"dorm3d_appellation_waring2",
			"dorm3d_appellation_waring1"
		}) then
			setInputText(self.callInput, self.apartment:GetCallName())

			return
		end

		if var_8_0 == self.apartment:GetCallName() then
			return
		end

		if self.apartment:GetSetCallCd() > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_appellation_waring4"))

			return
		end

		if self.renameReset then
			self:emit(Dorm3dLevelMediator.RENAME_RESET, self.apartment.configId)
		else
			self:emit(Dorm3dLevelMediator.RENAME, self.apartment.configId, var_8_0)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.rtRenameWindow:Find("panel/cancel"), function()
		self:CloseRenameWindow()

		return
	end, SFX_CANCEL)
	onButton(self, self.rtRenameWindow:Find("panel/reset"), function()
		setInputText(self.callInput, pg.dorm3d_dorm_template[self.apartment.configId].default_appellation)

		self.renameReset = true

		return
	end)

	self.nameShort = self.rtLevelPanel:Find("bg/left/rot/short")
	self.nameLong = self.rtLevelPanel:Find("bg/left/rot/long")
	self.blurPanel = self._tf:Find("blur")

	self.callInput:GetComponent(typeof(InputField)).onValueChanged:AddListener(function()
		self.renameReset = false

		return
	end)
	setActive(self.rtLevelPanel:Find("bg/left/rot"), not Dorm3dLevelLayer.IsLockNamed())
	self:InitItemList()

	return
end

function Dorm3dLevelLayer:SetApartment(arg_12_1)
	self.apartment = arg_12_1

	return
end

function Dorm3dLevelLayer:InitItemList()
	self.rtLevelContainer = self.rtLevelPanel:Find("bg/awards/content")
	self.levelItemList = UIItemList.New(self.rtLevelContainer, self.rtLevelContainer:Find("tpl"))

	self.levelItemList:make(function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_14_2:Find("items")
		local var_14_1 = {}

		for iter_14_0, iter_14_1 in pairs((self.apartment:getFavorConfig("levelup_item", arg_14_1 + 1))) do
			table.insert(var_14_1, {
				type = Dorm3dLevelLayer.SERVER_TYPE,
				data = iter_14_1
			})
		end

		local var_14_2 = false

		for iter_14_2, iter_14_3 in pairs((self.apartment:getFavorConfig("levelup_client_item", arg_14_1 + 1))) do
			if iter_14_3[1] == Dorm3dIconHelper.DORM_STORY then
				table.insert(var_14_1, {
					type = Dorm3dLevelLayer.STORY_TYPE,
					data = iter_14_3
				})

				var_14_2 = true
			else
				table.insert(var_14_1, {
					type = Dorm3dLevelLayer.CLIENT_TYPE,
					data = iter_14_3
				})
			end
		end

		if arg_14_0 == UIItemList.EventInit then
			setActive(arg_14_2:Find("bg/normal"), not var_14_2)
			setActive(arg_14_2:Find("bg/special"), var_14_2)

			local function var_14_3(arg_15_0)
				local var_15_0 = var_14_0:GetChild(arg_15_0 - 1)
				local var_15_1 = var_15_0:Find("item")
				local var_15_2 = var_15_1:Find("Dorm3dIconTpl")

				if arg_15_0 <= #var_14_1 then
					switch(var_14_1[arg_15_0].type, {
						[Dorm3dLevelLayer.SERVER_TYPE] = function()
							setActive(var_15_2:Find("count"), true)

							local var_16_0 = Drop.Create(var_14_1[arg_15_0].data)

							updateCustomDrop(var_15_2, var_16_0, {
								style = "dorm"
							})
							onButton(self, var_15_0, function()
								self:emit(BaseUI.ON_NEW_DROP, {
									style = "dorm",
									drop = var_16_0
								})

								return
							end, SFX_PANEL)

							return
						end,
						[Dorm3dLevelLayer.CLIENT_TYPE] = function()
							setActive(var_15_2:Find("count"), true)
							Dorm3dIconHelper.UpdateDorm3dIcon(var_15_2, var_14_1[arg_15_0].data)

							local var_18_0 = Dorm3dIconHelper.Data2Config(var_14_1[arg_15_0].data)

							onButton(self, var_15_0, function()
								self:emit(Dorm3dLevelMediator.ON_DROP_CLIENT, {
									data = var_14_1[arg_15_0].data
								})

								return
							end, SFX_PANEL)

							return
						end,
						[Dorm3dLevelLayer.STORY_TYPE] = function()
							local var_20_0 = Dorm3dIconHelper.Data2Config(var_14_1[arg_15_0].data)

							setActive(var_15_1:Find("sp"), true)
							setActive(var_15_0:Find("story"), true)
							onButton(self, var_15_0, function()
								self:emit(Dorm3dLevelMediator.ON_DROP_CLIENT, {
									data = var_14_1[arg_15_0].data
								})

								return
							end, SFX_PANEL)
							Dorm3dIconHelper.UpdateDorm3dIcon(var_15_2, var_14_1[arg_15_0].data)
							setText(var_15_0:Find("story/Text"), i18n("dorm3d_favor_level_story"))

							return
						end
					})
				else
					setActive(var_15_1, false)
					setActive(var_15_0:Find("empty"), true)
				end

				return
			end

			for iter_14_4 = 1, var_14_0.childCount do
				var_14_3(iter_14_4)
			end
		elseif arg_14_0 == UIItemList.EventUpdate then
			local var_14_4 = arg_14_1 + 1 <= self.apartment.level

			setActive(arg_14_2:Find("unlock"), arg_14_1 + 1 <= self.apartment.level)
			setText(arg_14_2:Find("number"), string.format("<color=%s>%02d</color>", var_14_2 and "#FFFFFF" or var_14_4 and "#b6b1b7" or "#827d82", arg_14_1 + 1))

			if var_14_4 then
				setGray(arg_14_2:Find("items"), true, true)
			end
		end

		return
	end)

	return
end

function Dorm3dLevelLayer:didEnter()
	local var_22_0, var_22_1 = self.apartment:getFavor()

	setText(self.rtLevelPanel:Find("bg/favor/level"), string.format("Lv.%d : ", self.apartment.level))

	if self.apartment:isMaxFavor() then
		setText(self.rtLevelPanel:Find("bg/favor/level/Text"), "MAX")
	else
		setText(self.rtLevelPanel:Find("bg/favor/level/Text"), string.format("%d/%d", var_22_0, var_22_1))
	end

	setSlider(self.rtLevelPanel:Find("bg/favor/progressBg/progress"), 0, var_22_1, var_22_0)
	self.levelItemList:align(getDorm3dGameset("favor_level")[1])

	self.rtLevelContainer:GetComponent(typeof(ScrollRect)).horizontalNormalizedPosition = 0

	local var_22_2 = self.apartment.level >= getDorm3dGameset("drom3d_time_unlock")[1]

	setImageAlpha(self.rtLevelPanel:Find("bg/bottom/btn_time"), not var_22_2 and 0.2 or 1)
	setActive(self.rtLevelPanel:Find("bg/bottom/btn_time/lock"), not var_22_2)
	setText(self.rtLevelPanel:Find("bg/left/rot/Text"), i18n("dorm3d_appellation_title"))
	setText(self.rtRenameWindow:Find("panel/cancel/Text"), i18n("word_cancel"))
	setText(self.rtRenameWindow:Find("panel/confirm/Text"), i18n("word_ok"))
	self:UpdateName()
	self:UpdateRed()

	return
end

function Dorm3dLevelLayer.IsLockNamed()
	return PLATFORM_CODE ~= PLATFORM_CH and DORM_LOCK_NAMED
end

function Dorm3dLevelLayer.IsShowRed()
	if Dorm3dLevelLayer.IsLockNamed() then
		return false
	end

	return PlayerPrefs.GetInt(Dorm3dLevelLayer.PLAYERPREFS_KEY, 0) == 0
end

function Dorm3dLevelLayer:UpdateRed()
	setActive(self.rtLevelPanel:Find("bg/left/rot/red"), Dorm3dLevelLayer.IsShowRed())
	self:emit(Dorm3dLevelMediator.UPDATE_FAVOR_DISPLAY)

	return
end

function Dorm3dLevelLayer:UpdateName()
	local var_26_0 = self.apartment:GetCallName()
	local var_26_1, var_26_2 = utf8_to_unicode(var_26_0)
	local var_26_3 = var_26_2 <= Dorm3dLevelLayer.NAME_SHORT_SIZE

	setActive(self.nameShort, var_26_2 <= Dorm3dLevelLayer.NAME_SHORT_SIZE)
	setActive(self.nameLong, not var_26_3)
	setText((var_26_3 or nil) and (self.nameShort:Find("Text") or self.nameLong:Find("Text")), var_26_0)

	return
end

function Dorm3dLevelLayer:ShowRenameWindow()
	setActive(self._tf:Find("bg"), false)
	setActive(self._tf:Find("btn_back"), false)
	setActive(self.rtLevelPanel, false)
	setActive(self.rtRenameWindow, true)
	setActive(self.blurPanel, true)
	self:OverlayPanel(self.blurPanel, {
		groupDelta = 1,
		pbList = {
			self.blurPanel
		}
	})
	self:OverlayPanel(self.rtRenameWindow, {
		groupDelta = 1
	})
	setInputText(self.callInput, self.apartment:GetCallName())

	local var_27_0 = self.apartment:GetSetCallCd()
	local var_27_1

	if var_27_0 > 3600 then
		var_27_1 = math.floor(var_27_0 / 16) .. i18n("word_hour")
	else
		if var_27_0 > 60 then
			var_27_1 = math.floor(var_27_0 / 60) .. i18n("word_minute")
		end

		local var_27_2

		do
			var_27_2 = var_27_0 == 0 and i18n("dorm3d_appellation_interval") or i18n("dorm3d_appellation_cd", var_27_0 .. i18n("word_second"))
		end
	end

	setText(self.rtRenameWindow:Find("panel/time"), var_27_2)
	PlayerPrefs.SetInt(Dorm3dLevelLayer.PLAYERPREFS_KEY, 1)
	self:UpdateRed()

	return
end

function Dorm3dLevelLayer:CloseRenameWindow()
	setActive(self._tf:Find("bg"), true)
	setActive(self._tf:Find("btn_back"), true)
	setActive(self.rtLevelPanel, true)
	setActive(self.rtRenameWindow, false)
	setActive(self.blurPanel, false)
	self:UnOverlayPanel(self.blurPanel, self._tf)
	self:UnOverlayPanel(self.rtRenameWindow, self._tf)
	self:UpdateName()

	return
end

function Dorm3dLevelLayer:ShowTimeSelectWindow()
	local var_29_0 = self.rtTimeSelectWindow:Find("panel")

	setText(var_29_0:Find("title"), i18n("dorm3d_time_choose"))

	for iter_29_0, iter_29_1 in ipairs({
		"day",
		"night"
	}) do
		local var_29_1 = var_29_0:Find("content/" .. iter_29_1)

		setText(var_29_1:Find("now/Text"), i18n("dorm3d_now_time"))
		setActive(var_29_1:Find("now"), iter_29_0 == self.contextData.timeIndex)
		onToggle(self, var_29_1, function(arg_30_0)
			if arg_30_0 == true then
				self.selectTimeIndex = iter_29_0
			end

			quickPlayAnimation(var_29_1, arg_30_0 and "anim_dorm3d_timeselect_click" or "anim_dorm3d_timeselect_unclick")

			return
		end, SFX_PANEL)
	end

	triggerToggle(var_29_0:Find("content"):GetChild(self.contextData.timeIndex - 1), true)
	setText(var_29_0:Find("bottom/toggle_lock/Text"), i18n("dorm3d_is_auto_time"))
	onToggle(self, var_29_0:Find("bottom/toggle_lock"), function(arg_31_0)
		if arg_31_0 then
			PlayerPrefs.SetInt(ApartmentProxy.GetTimePPName(self.contextData.roomId), 0)
		else
			PlayerPrefs.SetInt(ApartmentProxy.GetTimePPName(self.contextData.roomId), self.contextData.timeIndex)
		end

		quickPlayAnimation(var_29_0:Find("bottom/toggle_lock"), arg_31_0 and "anim_dorm3d_timeselect_bottom_on" or "anim_dorm3d_timeselect_bottom_off")

		return
	end, SFX_PANEL)
	triggerToggle(var_29_0:Find("bottom/toggle_lock"), PlayerPrefs.GetInt(ApartmentProxy.GetTimePPName(self.contextData.roomId), 1) == 0)
	onButton(self, var_29_0:Find("bottom/btn_confirm"), function()
		warning(self.contextData.timeIndex, self.selectTimeIndex)
		pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_day_night_switching" .. self.selectTimeIndex))

		if self.contextData.timeIndex == self.selectTimeIndex then
			return
		else
			if PlayerPrefs.GetInt(ApartmentProxy.GetTimePPName(self.contextData.roomId), 1) ~= 0 then
				PlayerPrefs.SetInt(ApartmentProxy.GetTimePPName(self.contextData.roomId), self.selectTimeIndex)
			end

			triggerButton(self.rtTimeSelectWindow:Find("bg"))
			self:emit(Dorm3dLevelMediator.CHAMGE_TIME, self.selectTimeIndex)
		end

		return
	end, SFX_CONFIRM)
	setActive(self.rtTimeSelectWindow, true)
	self:OverlayPanel(self.rtTimeSelectWindow)

	return
end

function Dorm3dLevelLayer:onBackPressed()
	if isActive(self.rtTimeSelectWindow) then
		triggerButton(self.rtTimeSelectWindow:Find("bg"))
	elseif isActive(self.rtRenameWindow) then
		triggerButton(self.rtRenameWindow:Find("panel/cancel"))
	else
		Dorm3dLevelLayer.super.onBackPressed(self)
	end

	return
end

function Dorm3dLevelLayer:willExit()
	return
end

return Dorm3dLevelLayer
