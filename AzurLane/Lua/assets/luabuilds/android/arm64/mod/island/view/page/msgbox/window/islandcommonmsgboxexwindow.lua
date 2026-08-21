local var_0_0 = class("IslandCommonMsgboxEXWindow", import(".IslandCommonMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandCommonMsgBoxEX"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.titleTxt = arg_2_0.rtTitle:GetComponent(typeof(Text))
	arg_2_0.contentTxt = arg_2_0.rtContext:GetComponent("RichText")
	arg_2_0.cancelTxt = arg_2_0.rtCancelText:GetComponent(typeof(Text))
	arg_2_0.confirmTxt = arg_2_0.rtConfirmText:GetComponent(typeof(Text))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()
		existCall(arg_3_0.onNo)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		arg_3_0:Hide()
		existCall(arg_3_0.onYes)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShow(arg_7_0)
	if arg_7_0.settings.rawIconDic then
		for iter_7_0, iter_7_1 in pairs(arg_7_0.settings.rawIconDic) do
			arg_7_0.contentTxt:AddSprite(iter_7_0, iter_7_1)
		end
	end

	local var_7_0 = arg_7_0.titleTxt

	var_7_0.text = arg_7_0.settings.title or i18n("island_msg_info")
	arg_7_0.contentTxt.text = arg_7_0.settings.content or ""
	arg_7_0.contentTxt.alignment = arg_7_0.settings.alignment or TextAnchor.MiddleCenter
	arg_7_0.onYes = arg_7_0.settings.onYes
	arg_7_0.onNo = arg_7_0.settings.onNo
	arg_7_0.onHide = arg_7_0.settings.onHide

	arg_7_0:FlushBtn(arg_7_0.settings)

	return
end

function var_0_0.FlushBtn(arg_8_0, arg_8_1)
	setActive(arg_8_0.cancelBtn, not arg_8_1.hideNo)

	arg_8_0.confirmBtn.sizeDelta = Vector2(arg_8_1.hideNo and 880 or 420, arg_8_0.confirmBtn.sizeDelta.y)

	local var_8_0 = arg_8_0.cancelTxt

	if arg_8_1.noText then
		var_8_0.text = arg_8_1.noText or i18n("word_cancel")

		local var_8_1 = arg_8_0.confirmTxt

		if arg_8_1.yesText then
			var_8_1.text = arg_8_1.yesText or i18n("word_ok")

			return
		end
	end
end

function var_0_0.OnHide(arg_9_0)
	arg_9_0.onYes = nil
	arg_9_0.onNo = nil

	if arg_9_0.onHide then
		arg_9_0.onHide()

		arg_9_0.onHide = nil
	end

	return
end

function var_0_0.GetMsgBoxMgr(arg_10_0)
	return arg_10_0.view
end

function var_0_0.OnDestroy(arg_11_0)
	return
end

return var_0_0
