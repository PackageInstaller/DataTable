local var_0_0 = class("ForcePlayerNameModificationPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "PlayerVitaeRenamePage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.content = arg_2_0._tf:Find("frame/border/tip"):GetComponent(typeof(Text))
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/queren")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("frame/cancel")
	arg_2_0.inputField = arg_2_0._tf:Find("frame/name_field")
	arg_2_0.prompt = arg_2_0._tf:Find("frame/border/prompt")

	setText(arg_2_0._tf:Find("frame/top/title_list/infomation/title"), i18n("change_player_name_title"))
	setText(arg_2_0._tf:Find("frame/name_field/Placeholder"), i18n("change_player_name_input_tip"))
	setText(arg_2_0.confirmBtn:Find("Image"), i18n("word_ok"))
	setActive(arg_2_0.cancelBtn, false)
	setAnchoredPosition(arg_2_0.confirmBtn, {
		x = -365
	})
	setAnchoredPosition(arg_2_0.inputField, {
		y = -30
	})
	setAnchoredPosition(arg_2_0.prompt, {
		y = 43
	})

	local var_2_0 = arg_2_0.prompt:GetComponent(typeof(Text))

	var_2_0.alignment = TextAnchor.MiddleCenter
	var_2_0.fontSize = 27
	var_2_0.lineSpacing = 0.8
	var_2_0.verticalOverflow = ReflectionHelp.RefGetField(typeof("UnityEngine.VerticalWrapMode"), "Overflow")

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		pg.m02:sendNotification(GAME.CHANGE_PLAYER_NAME, {
			type = 2,
			name = getInputText(arg_3_0.inputField),
			onSuccess = function()
				setInputText(arg_3_0.inputField, "")

				if arg_3_0.callback then
					arg_3_0.callback()
				end

				arg_3_0:Hide()

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_6_0, arg_6_1)
	arg_6_0.showing = true

	var_0_0.super.Show(arg_6_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_6_0._tf)
	setText(arg_6_0.prompt, (i18n("change_player_name_illegal", getProxy(PlayerProxy):getRawData().name)))

	arg_6_0.callback = arg_6_1

	return
end

function var_0_0.Hide(arg_7_0)
	if arg_7_0.showing then
		arg_7_0.showing = false

		pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0._tf, arg_7_0._parentTf)
		var_0_0.super.Hide(arg_7_0)

		arg_7_0.callback = nil
	end

	return
end

function var_0_0.OnDestroy(arg_8_0)
	arg_8_0:Hide()

	return
end

return var_0_0
