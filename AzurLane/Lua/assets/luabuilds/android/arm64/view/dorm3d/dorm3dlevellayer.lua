local var_0_0 = class("Dorm3dLevelLayer", import("view.base.BaseUI"))

var_0_0.SERVER_TYPE = 1
var_0_0.CLIENT_TYPE = 2
var_0_0.STORY_TYPE = 3
var_0_0.NAME_MIN_SIZE = 4
var_0_0.NAME_SHORT_SIZE = 8
var_0_0.NAME_LONG_SIZE = 14
var_0_0.PLAYERPREFS_KEY = "Dorm3dLayer.playerprefs"

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dLevelUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.rtLevelPanel = arg_2_0._tf:Find("panel")

	onButton(arg_2_0, arg_2_0._tf:Find("btn_back"), function()
		arg_2_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0._tf:Find("bg"), function()
		arg_2_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0.rtLevelPanel:Find("bg/bottom/btn_time"), function()
		local var_5_0 = getDorm3dGameset("drom3d_time_unlock")[1]

		if var_5_0 > arg_2_0.apartment.level then
			pg.TipsMgr.GetInstance():ShowTips(i18n("apartment_level_unenough", var_5_0))

			return
		end

		arg_2_0:ShowTimeSelectWindow()

		return
	end, SFX_PANEL)

	arg_2_0.rtTimeSelectWindow = arg_2_0._tf:Find("TimeSelectWindow")

	onButton(arg_2_0, arg_2_0.rtTimeSelectWindow:Find("bg"), function()
		setActive(arg_2_0.rtTimeSelectWindow, false)
		arg_2_0:UnOverlayPanel(arg_2_0.rtTimeSelectWindow, arg_2_0._tf)

		return
	end, SFX_CANCEL)

	arg_2_0.rtRenameWindow = arg_2_0._tf:Find("RenameWindow")

	onButton(arg_2_0, arg_2_0.rtLevelPanel:Find("bg/left/rot"), function()
		arg_2_0:ShowRenameWindow()

		return
	end, SFX_PANEL)

	arg_2_0.callInput = arg_2_0.rtRenameWindow:Find("panel/input/nickname")

	onButton(arg_2_0, arg_2_0.rtRenameWindow:Find("panel/confirm"), function()
		local var_8_0 = getInputText(arg_2_0.callInput)

		if var_8_0 == "" then
			return
		end

		if not nameValidityCheck(var_8_0, var_0_0.NAME_MIN_SIZE, var_0_0.NAME_LONG_SIZE, {
			"spece_illegal_tip",
			"dorm3d_appellation_waring3",
			"dorm3d_appellation_waring2",
			"dorm3d_appellation_waring1"
		}) then
			setInputText(arg_2_0.callInput, arg_2_0.apartment:GetCallName())

			return
		end

		if var_8_0 == arg_2_0.apartment:GetCallName() then
			return
		end

		if arg_2_0.apartment:GetSetCallCd() > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_appellation_waring4"))

			return
		end

		if arg_2_0.renameReset then
			arg_2_0:emit(Dorm3dLevelMediator.RENAME_RESET, arg_2_0.apartment.configId)
		else
			arg_2_0:emit(Dorm3dLevelMediator.RENAME, arg_2_0.apartment.configId, var_8_0)
		end

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.rtRenameWindow:Find("panel/cancel"), function()
		arg_2_0:CloseRenameWindow()

		return
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0.rtRenameWindow:Find("panel/reset"), function()
		setInputText(arg_2_0.callInput, pg.dorm3d_dorm_template[arg_2_0.apartment.configId].default_appellation)

		arg_2_0.renameReset = true

		return
	end)

	arg_2_0.nameShort = arg_2_0.rtLevelPanel:Find("bg/left/rot/short")
	arg_2_0.nameLong = arg_2_0.rtLevelPanel:Find("bg/left/rot/long")
	arg_2_0.blurPanel = arg_2_0._tf:Find("blur")

	arg_2_0.callInput:GetComponent(typeof(InputField)).onValueChanged:AddListener(function()
		arg_2_0.renameReset = false

		return
	end)
	setActive(arg_2_0.rtLevelPanel:Find("bg/left/rot"), not var_0_0.IsLockNamed())
	arg_2_0:InitItemList()

	return
end

function var_0_0.SetApartment(arg_12_0, arg_12_1)
	arg_12_0.apartment = arg_12_1

	return
end

function var_0_0.InitItemList(arg_13_0)
	arg_13_0.rtLevelContainer = arg_13_0.rtLevelPanel:Find("bg/awards/content")
	arg_13_0.levelItemList = UIItemList.New(arg_13_0.rtLevelContainer, arg_13_0.rtLevelContainer:Find("tpl"))

	arg_13_0.levelItemList:make(function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_14_2:Find("items")
		local var_14_1 = {}

		for iter_14_0, iter_14_1 in pairs((arg_13_0.apartment:getFavorConfig("levelup_item", arg_14_1 + 1))) do
			table.insert({}, {
				type = var_0_0.SERVER_TYPE,
				data = iter_14_1
			})
		end

		local var_14_2 = false

		for iter_14_2, iter_14_3 in pairs((arg_13_0.apartment:getFavorConfig("levelup_client_item", arg_14_1 + 1))) do
			if iter_14_3[1] == Dorm3dIconHelper.DORM_STORY then
				table.insert({}, {
					type = var_0_0.STORY_TYPE,
					data = iter_14_3
				})

				var_14_2 = true
			else
				table.insert({}, {
					type = var_0_0.CLIENT_TYPE,
					data = iter_14_3
				})
			end
		end

		if arg_14_0 == UIItemList.EventInit then
			setActive(arg_14_2:Find("bg/normal"), not var_14_2)
			setActive(arg_14_2:Find("bg/special"), var_14_2)

			for iter_14_4 = 1, arg_14_2:Find("items").childCount do
				(function(arg_15_0)
					local var_15_0 = var_14_0:GetChild(arg_15_0 - 1)
					local var_15_1 = var_15_0:Find("item")
					local var_15_2 = var_15_1:Find("Dorm3dIconTpl")

					if arg_15_0 <= #var_14_1 then
						switch(var_14_1[arg_15_0].type, {
							[var_0_0.SERVER_TYPE] = function()
								setActive(var_15_2:Find("count"), true)
								updateCustomDrop(var_15_2, Drop.Create(var_14_1[arg_15_0].data), {
									style = "dorm"
								})
								onButton(arg_13_0, var_15_0, function()
									arg_13_0:emit(BaseUI.ON_NEW_DROP, {
										style = "dorm",
										drop = var_0
									})

									return
								end, SFX_PANEL)

								return
							end,
							[var_0_0.CLIENT_TYPE] = function()
								setActive(var_15_2:Find("count"), true)
								Dorm3dIconHelper.UpdateDorm3dIcon(var_15_2, var_14_1[arg_15_0].data)

								local var_18_0 = Dorm3dIconHelper.Data2Config(var_14_1[arg_15_0].data)

								onButton(arg_13_0, var_15_0, function()
									arg_13_0:emit(Dorm3dLevelMediator.ON_DROP_CLIENT, {
										data = var_14_1[arg_15_0].data
									})

									return
								end, SFX_PANEL)

								return
							end,
							[var_0_0.STORY_TYPE] = function()
								local var_20_0 = Dorm3dIconHelper.Data2Config(var_14_1[arg_15_0].data)

								setActive(var_15_1:Find("sp"), true)
								setActive(var_15_0:Find("story"), true)
								onButton(arg_13_0, var_15_0, function()
									arg_13_0:emit(Dorm3dLevelMediator.ON_DROP_CLIENT, {
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
				end)(iter_14_4)
			end
		elseif arg_14_0 == UIItemList.EventUpdate then
			local var_14_3 = arg_14_1 + 1 <= arg_13_0.apartment.level

			setActive(arg_14_2:Find("unlock"), arg_14_1 + 1 <= arg_13_0.apartment.level)
			setText(arg_14_2:Find("number"), string.format("<color=%s>%02d</color>", var_14_2 and "#FFFFFF" or var_14_3 and "#b6b1b7" or "#827d82", arg_14_1 + 1))

			if var_14_3 then
				setGray(arg_14_2:Find("items"), true, true)
			end
		end

		return
	end)

	return
end

function var_0_0.didEnter(arg_22_0)
	local var_22_0, var_22_1 = arg_22_0.apartment:getFavor()

	setText(arg_22_0.rtLevelPanel:Find("bg/favor/level"), string.format("Lv.%d : ", arg_22_0.apartment.level))

	if arg_22_0.apartment:isMaxFavor() then
		setText(arg_22_0.rtLevelPanel:Find("bg/favor/level/Text"), "MAX")
	else
		setText(arg_22_0.rtLevelPanel:Find("bg/favor/level/Text"), string.format("%d/%d", var_22_0, var_22_1))
	end

	setSlider(arg_22_0.rtLevelPanel:Find("bg/favor/progressBg/progress"), 0, var_22_1, var_22_0)
	arg_22_0.levelItemList:align(getDorm3dGameset("favor_level")[1])

	arg_22_0.rtLevelContainer:GetComponent(typeof(ScrollRect)).horizontalNormalizedPosition = 0

	local var_22_2 = arg_22_0.apartment.level >= getDorm3dGameset("drom3d_time_unlock")[1]

	setImageAlpha(arg_22_0.rtLevelPanel:Find("bg/bottom/btn_time"), not var_22_2 and 0.2 or 1)
	setActive(arg_22_0.rtLevelPanel:Find("bg/bottom/btn_time/lock"), not var_22_2)
	setText(arg_22_0.rtLevelPanel:Find("bg/left/rot/Text"), i18n("dorm3d_appellation_title"))
	setText(arg_22_0.rtRenameWindow:Find("panel/cancel/Text"), i18n("word_cancel"))
	setText(arg_22_0.rtRenameWindow:Find("panel/confirm/Text"), i18n("word_ok"))
	arg_22_0:UpdateName()
	arg_22_0:UpdateRed()

	return
end

function var_0_0.IsLockNamed()
	return PLATFORM_CODE ~= PLATFORM_CH and DORM_LOCK_NAMED
end

function var_0_0.IsShowRed()
	if var_0_0.IsLockNamed() then
		return false
	end

	return PlayerPrefs.GetInt(var_0_0.PLAYERPREFS_KEY, 0) == 0
end

function var_0_0.UpdateRed(arg_25_0)
	setActive(arg_25_0.rtLevelPanel:Find("bg/left/rot/red"), var_0_0.IsShowRed())
	arg_25_0:emit(Dorm3dLevelMediator.UPDATE_FAVOR_DISPLAY)

	return
end

function var_0_0.UpdateName(arg_26_0)
	local var_26_0 = arg_26_0.apartment:GetCallName()
	local var_26_1, var_26_2 = utf8_to_unicode(var_26_0)
	local var_26_3 = var_26_2 <= var_0_0.NAME_SHORT_SIZE

	setActive(arg_26_0.nameShort, var_26_2 <= var_0_0.NAME_SHORT_SIZE)
	setActive(arg_26_0.nameLong, not var_26_3)

	if var_26_3 then
		local var_26_5 = arg_26_0.nameShort:Find("Text") or arg_26_0.nameLong:Find("Text")

		var_26_4(var_26_5, var_26_0)

		return
	end
end

function var_0_0.ShowRenameWindow(arg_27_0)
	setActive(arg_27_0._tf:Find("bg"), false)
	setActive(arg_27_0._tf:Find("btn_back"), false)
	setActive(arg_27_0.rtLevelPanel, false)
	setActive(arg_27_0.rtRenameWindow, true)
	setActive(arg_27_0.blurPanel, true)
	arg_27_0:OverlayPanel(arg_27_0.blurPanel, {
		groupDelta = 1,
		pbList = {
			arg_27_0.blurPanel
		}
	})
	arg_27_0:OverlayPanel(arg_27_0.rtRenameWindow, {
		groupDelta = 1
	})
	setInputText(arg_27_0.callInput, arg_27_0.apartment:GetCallName())

	local var_27_0 = arg_27_0.apartment:GetSetCallCd()
	local var_27_1
	local var_27_2

	if var_27_0 > 3600 then
		var_27_1 = math.floor(var_27_0 / 16) .. i18n("word_hour")
	elseif var_27_0 > 60 then
		var_27_1 = math.floor(var_27_0 / 60) .. i18n("word_minute")
	else
		var_27_1 = var_27_0 .. i18n("word_second")
		var_27_2 = var_27_0 == 0 and i18n("dorm3d_appellation_interval") or i18n("dorm3d_appellation_cd", var_27_1)
	end

	setText(arg_27_0.rtRenameWindow:Find("panel/time"), var_27_2)
	PlayerPrefs.SetInt(var_0_0.PLAYERPREFS_KEY, 1)
	arg_27_0:UpdateRed()

	return
end

function var_0_0.CloseRenameWindow(arg_28_0)
	setActive(arg_28_0._tf:Find("bg"), true)
	setActive(arg_28_0._tf:Find("btn_back"), true)
	setActive(arg_28_0.rtLevelPanel, true)
	setActive(arg_28_0.rtRenameWindow, false)
	setActive(arg_28_0.blurPanel, false)
	arg_28_0:UnOverlayPanel(arg_28_0.blurPanel, arg_28_0._tf)
	arg_28_0:UnOverlayPanel(arg_28_0.rtRenameWindow, arg_28_0._tf)
	arg_28_0:UpdateName()

	return
end

function var_0_0.ShowTimeSelectWindow(arg_29_0)
	local var_29_0 = arg_29_0.rtTimeSelectWindow:Find("panel")

	setText(var_29_0:Find("title"), i18n("dorm3d_time_choose"))

	for iter_29_0, iter_29_1 in ipairs({
		"day",
		"night"
	}) do
		local var_29_1 = var_29_0:Find("content/" .. iter_29_1)

		setText(var_29_1:Find("now/Text"), i18n("dorm3d_now_time"))
		setActive(var_29_1:Find("now"), iter_29_0 == arg_29_0.contextData.timeIndex)
		onToggle(arg_29_0, var_29_1, function(arg_30_0)
			if arg_30_0 == true then
				arg_29_0.selectTimeIndex = iter_29_0
			end

			quickPlayAnimation(var_29_1, arg_30_0 and "anim_dorm3d_timeselect_click" or "anim_dorm3d_timeselect_unclick")

			return
		end, SFX_PANEL)
	end

	triggerToggle(var_29_0:Find("content"):GetChild(arg_29_0.contextData.timeIndex - 1), true)
	setText(var_29_0:Find("bottom/toggle_lock/Text"), i18n("dorm3d_is_auto_time"))
	onToggle(arg_29_0, var_29_0:Find("bottom/toggle_lock"), function(arg_31_0)
		if arg_31_0 then
			PlayerPrefs.SetInt(ApartmentProxy.GetTimePPName(arg_29_0.contextData.roomId), 0)
		else
			PlayerPrefs.SetInt(ApartmentProxy.GetTimePPName(arg_29_0.contextData.roomId), arg_29_0.contextData.timeIndex)
		end

		quickPlayAnimation(var_29_0:Find("bottom/toggle_lock"), arg_31_0 and "anim_dorm3d_timeselect_bottom_on" or "anim_dorm3d_timeselect_bottom_off")

		return
	end, SFX_PANEL)
	triggerToggle(var_29_0:Find("bottom/toggle_lock"), PlayerPrefs.GetInt(ApartmentProxy.GetTimePPName(arg_29_0.contextData.roomId), 1) == 0)
	onButton(arg_29_0, var_29_0:Find("bottom/btn_confirm"), function()
		warning(arg_29_0.contextData.timeIndex, arg_29_0.selectTimeIndex)
		pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_day_night_switching" .. arg_29_0.selectTimeIndex))

		if arg_29_0.contextData.timeIndex == arg_29_0.selectTimeIndex then
			return
		else
			if PlayerPrefs.GetInt(ApartmentProxy.GetTimePPName(arg_29_0.contextData.roomId), 1) ~= 0 then
				PlayerPrefs.SetInt(ApartmentProxy.GetTimePPName(arg_29_0.contextData.roomId), arg_29_0.selectTimeIndex)
			end

			triggerButton(arg_29_0.rtTimeSelectWindow:Find("bg"))
			arg_29_0:emit(Dorm3dLevelMediator.CHAMGE_TIME, arg_29_0.selectTimeIndex)
		end

		return
	end, SFX_CONFIRM)
	setActive(arg_29_0.rtTimeSelectWindow, true)
	arg_29_0:OverlayPanel(arg_29_0.rtTimeSelectWindow)

	return
end

function var_0_0.onBackPressed(arg_33_0)
	if isActive(arg_33_0.rtTimeSelectWindow) then
		triggerButton(arg_33_0.rtTimeSelectWindow:Find("bg"))
	elseif isActive(arg_33_0.rtRenameWindow) then
		triggerButton(arg_33_0.rtRenameWindow:Find("panel/cancel"))
	else
		var_0_0.super.onBackPressed(arg_33_0)
	end

	return
end

function var_0_0.willExit(arg_34_0)
	return
end

return var_0_0
