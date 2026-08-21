local var_0_0 = class("ActivityPermanentLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "ActivitySelectUI"
end

function var_0_0.onBackPressed(arg_2_0)
	arg_2_0:closeView()

	return
end

function var_0_0.onBackPressed(arg_3_0)
	if isActive(arg_3_0.rtMsgbox) then
		arg_3_0:hideMsgbox()
	else
		var_0_0.super.onBackPressed(arg_3_0)
	end

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0.bg = arg_4_0._tf:Find("bg_back")

	onButton(arg_4_0, arg_4_0.bg, function()
		arg_4_0:closeView()

		return
	end, SFX_CANCEL)

	arg_4_0.btnBack = arg_4_0._tf:Find("window/inner/top/back")

	onButton(arg_4_0, arg_4_0.btnBack, function()
		arg_4_0:closeView()

		return
	end, SFX_CANCEL)
	setText(arg_4_0._tf:Find("window/inner/top/back/Text"), i18n("activity_permanent_total"))

	arg_4_0.btnHelp = arg_4_0._tf:Find("window/inner/top/help")

	onButton(arg_4_0, arg_4_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("activity_permanent_help")
		})

		return
	end, SFX_PANEL)

	arg_4_0.content = arg_4_0._tf:Find("window/inner/content/scroll_rect")
	arg_4_0.itemList = UIItemList.New(arg_4_0.content, arg_4_0.content:Find("item"))

	local var_4_0 = getProxy(ActivityPermanentProxy)

	arg_4_0.itemList:make(function(arg_8_0, arg_8_1, arg_8_2)
		arg_8_1 = arg_8_1 + 1

		if arg_8_0 == UIItemList.EventUpdate then
			local var_8_0 = arg_4_0.ids[arg_8_1]

			setText(arg_8_2:Find("main/word/Text"), pg.activity_task_permanent[arg_4_0.ids[arg_8_1]].gametip)
			setText(arg_8_2:Find("main/Image/tip/Text"), pg.activity_task_permanent[arg_4_0.ids[arg_8_1]].gametip_extra)
			GetImageSpriteFromAtlasAsync("activitybanner/" .. pg.activity_task_permanent[arg_4_0.ids[arg_8_1]].banner_route, "", arg_8_2:Find("main/Image"))
			onButton(arg_4_0, arg_8_2:Find("main"), function()
				arg_4_0:showMsgbox(var_8_0)

				return
			end, SFX_PANEL)

			local var_8_1 = arg_8_2:Find("finish")
			local var_8_2 = GetOrAddComponent(var_8_1, typeof(CanvasGroup))

			if var_8_0 == arg_4_0.contextData.finishId then
				arg_4_0.childFinish = arg_8_2
				var_8_2.alpha = 0
			else
				var_8_2.alpha = 1
			end

			setText(var_8_1:Find("Image/Text"), i18n("activity_permanent_finished"))
			setActive(var_8_1, var_4_0:isActivityFinish(var_8_0))
		end

		return
	end)

	arg_4_0.rtMsgbox = arg_4_0._tf:Find("Msgbox")

	onButton(arg_4_0, arg_4_0.rtMsgbox:Find("bg"), function()
		arg_4_0:hideMsgbox()

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0.rtMsgbox:Find("window/top/btnBack"), function()
		arg_4_0:hideMsgbox()

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0.rtMsgbox:Find("window/button_container/custom_button_2"), function()
		arg_4_0:hideMsgbox()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.didEnter(arg_13_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_13_0._tf)
	arg_13_0.itemList:align(#arg_13_0.ids)

	if arg_13_0.childFinish then
		scrollTo(arg_13_0.content, nil, math.clamp(arg_13_0.childFinish.anchoredPosition.y / (arg_13_0.content.rect.height - arg_13_0.content:GetComponent(typeof(ScrollRect)).viewport.rect.height), 0, 1))
		arg_13_0:doFinishAnim(arg_13_0.childFinish)

		arg_13_0.childFinish = nil
	end

	if PlayerPrefs.GetInt("permanent_select", 0) ~= 1 then
		PlayerPrefs.SetInt("permanent_select", 1)
		triggerButton(arg_13_0.btnHelp)
	end

	return
end

function var_0_0.willExit(arg_14_0)
	if isActive(arg_14_0.rtMsgbox) then
		arg_14_0:hideMsgbox()
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_14_0._tf)

	if arg_14_0.ltId then
		LeanTween.cancel(arg_14_0.ltId)

		arg_14_0.ltId = nil
	end

	return
end

function var_0_0.setActivitys(arg_15_0, arg_15_1)
	arg_15_0.ids = arg_15_1

	local var_15_0 = getProxy(ActivityPermanentProxy)

	table.sort(arg_15_0.ids, function(arg_16_0, arg_16_1)
		local var_16_0 = var_15_0:isActivityFinish(arg_16_1)

		if var_15_0:isActivityFinish(arg_16_0) == var_16_0 then
			return arg_16_0 < arg_16_1
		else
			return var_16_0
		end

		return
	end)

	return
end

function var_0_0.doFinishAnim(arg_17_0, arg_17_1)
	arg_17_0.ltId = LeanTween.alphaCanvas(GetOrAddComponent(arg_17_1:Find("finish"), typeof(CanvasGroup)), 1, 1).uniqueId

	return
end

function var_0_0.showMsgbox(arg_18_0, arg_18_1)
	setText(arg_18_0.rtMsgbox:Find("window/button_container/custom_button_1/pic"), i18n("msgbox_text_confirm"))
	setText(arg_18_0.rtMsgbox:Find("window/button_container/custom_button_2/pic"), i18n("msgbox_text_cancel"))
	setText(arg_18_0.rtMsgbox:Find("window/top/bg/infomation/title"), i18n("words_information"))
	setText(arg_18_0.rtMsgbox:Find("window/msg_panel/content"), i18n("activity_permanent_tips1", pg.activity_task_permanent[arg_18_1].activity_name))
	setText(arg_18_0.rtMsgbox:Find("window/msg_panel/Text"), i18n("activity_permanent_tips4"))
	onButton(arg_18_0, arg_18_0.rtMsgbox:Find("window/button_container/custom_button_1"), function()
		arg_18_0:hideMsgbox()
		arg_18_0:emit(ActivityPermanentMediator.START_SELECT, arg_18_1)

		return
	end, SFX_CONFIRM)
	setActive(arg_18_0.rtMsgbox, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_18_0.rtMsgbox)

	return
end

function var_0_0.hideMsgbox(arg_20_0)
	setActive(arg_20_0.rtMsgbox, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_20_0.rtMsgbox)

	return
end

return var_0_0
