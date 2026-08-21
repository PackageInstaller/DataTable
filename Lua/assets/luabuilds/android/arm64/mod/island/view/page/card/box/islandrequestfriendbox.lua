local var_0_0 = class("IslandRequestFriendBox", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandRequestFriendBox"
end

function var_0_0.OnLoaded(arg_2_0)
	setText(arg_2_0._tf:Find("frame/title"), i18n("word_apply"))
	setText(arg_2_0._tf:Find("Text"), i18n("friend_request_msg_title"))

	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close")
	arg_2_0.requestBtn = arg_2_0._tf:Find("request")

	setText(arg_2_0.requestBtn:Find("Text"), i18n("word_apply"))

	arg_2_0.input = arg_2_0._tf:Find("InputField")

	setText(arg_2_0.input:Find("Placeholder"), i18n("friend_request_msg_placeholder"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.requestBtn, function()
		pg.m02:sendNotification(GAME.FRIEND_SEND_REQUEST, {
			id = arg_3_0.userId,
			msg = getInputText(arg_3_0.input)
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_6_0, arg_6_1)
	var_0_0.super.Show(arg_6_0)

	arg_6_0.userId = arg_6_1

	setInputText(arg_6_0.input, "")
	pg.UIMgr.GetInstance():BlurPanel(arg_6_0._tf)

	return
end

function var_0_0.Hide(arg_7_0)
	var_0_0.super.Hide(arg_7_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0._tf, arg_7_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_8_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_8_0._tf, arg_8_0._parentTf)

	return
end

return var_0_0
