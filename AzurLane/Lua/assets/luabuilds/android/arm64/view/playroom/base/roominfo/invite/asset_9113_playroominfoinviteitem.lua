class = var_0_10000

local var_0_0 = "PlayRoomInfoInviteItem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.uiOnlineText

	i18n = var_1_10004

	var_1_10001(var_2_0, var_1_10004("island_btn_label_online"))

	return
end

function var_0_1.didEnter(arg_3_0, arg_3_1)
	setText = var_1_10002

	var_1_10002(arg_3_0.uiNameText, arg_3_1.name)

	setText = var_1_10002

	var_1_10002(arg_3_0.uiLevelText, arg_3_1.level)

	Ship = var_1_10002

	local var_3_0 = var_1_10002.New({
		configId = arg_3_1.icon
	})

	LoadSpriteAsync = var_1_10003

	var_1_10003("qicon/" .. var_3_0:getPrefab(), function(arg_4_0)
		arg_3_0.uiIcon.sprite = arg_4_0

		return
	end)

	local var_3_1 = arg_3_1
	local var_3_2 = arg_3_1.isOnline(var_3_1)

	setActive = var_4

	var_4(arg_3_0.uiOnlineTf, var_3_2)

	setActive = var_4

	var_4(arg_3_0.uiOfflineTf, not var_3_2)

	if not var_3_2 then
		setText = var_4

		local var_3_3 = arg_3_0.uiOfflineText

		getOfflineTimeStamp = var_7

		var_4(var_3_3, var_7(arg_3_1.preOnLineTime))
	else
		setText = var_4

		local var_3_4 = arg_3_0.uiOnlineText

		i18n = var_7

		var_4(var_3_4, var_7("island_btn_label_online"))
	end

	setText = var_4

	local var_3_5 = arg_3_0.uiInviteText

	i18n = var_7

	var_4(var_3_5, var_7("island_btn_label_invitation"))

	setText = var_4

	local var_3_6 = arg_3_0.uiCancelText

	i18n = var_7

	var_4(var_3_6, var_7("island_btn_label_invitation_already"))

	onButton = var_4

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.uiInviteBtn

	local function var_3_9()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		PlayRoomInfoInviteMediator = var_2_10003

		var_5_1(var_5_0, var_2_10003.ON_CLICK_INVITE, {
			id = arg_3_1.id
		})

		return
	end

	SFX_PANEL = var_9

	var_4(var_3_7, var_3_8, var_3_9, var_9)

	getProxy = var_4
	PlayRoomProxy = var_3_7

	local var_3_10 = var_4(var_3_7)
	local var_3_11 = var_4.GetInviteRecordByID(var_3_10, arg_3_1.id)

	setActive = var_3_1

	var_3_1(arg_3_0.uiInviteBtn, var_3_11 == nil)

	setActive = var_3_1

	var_3_1(arg_3_0.uiCancelBtn, var_3_11 ~= nil)

	return
end

function var_0_1.willExit(arg_6_0)
	arg_6_0:detach()

	return
end

return var_0_1
