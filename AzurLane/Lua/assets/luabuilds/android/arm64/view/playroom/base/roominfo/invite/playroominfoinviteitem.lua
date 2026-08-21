local var_0_0 = class("PlayRoomInfoInviteItem", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	setText(arg_2_0.uiOnlineText, i18n("island_btn_label_online"))

	return
end

function var_0_0.didEnter(arg_3_0, arg_3_1)
	setText(arg_3_0.uiNameText, arg_3_1.name)
	setText(arg_3_0.uiLevelText, arg_3_1.level)
	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = arg_3_1.icon
	}):getPrefab(), function(arg_4_0)
		arg_3_0.uiIcon.sprite = arg_4_0

		return
	end)

	local var_3_0 = arg_3_1:isOnline()

	setActive(arg_3_0.uiOnlineTf, var_3_0)
	setActive(arg_3_0.uiOfflineTf, not var_3_0)

	if not var_3_0 then
		setText(arg_3_0.uiOfflineText, getOfflineTimeStamp(arg_3_1.preOnLineTime))
	else
		setText(arg_3_0.uiOnlineText, i18n("island_btn_label_online"))
	end

	setText(arg_3_0.uiInviteText, i18n("island_btn_label_invitation"))
	setText(arg_3_0.uiCancelText, i18n("island_btn_label_invitation_already"))
	onButton(arg_3_0, arg_3_0.uiInviteBtn, function()
		arg_3_0:emit(PlayRoomInfoInviteMediator.ON_CLICK_INVITE, {
			id = arg_3_1.id
		})

		return
	end, SFX_PANEL)

	local var_3_1 = getProxy(PlayRoomProxy):GetInviteRecordByID(arg_3_1.id)

	setActive(arg_3_0.uiInviteBtn, var_3_1 == nil)
	setActive(arg_3_0.uiCancelBtn, var_3_1 ~= nil)

	return
end

function var_0_0.willExit(arg_6_0)
	arg_6_0:detach()

	return
end

return var_0_0
