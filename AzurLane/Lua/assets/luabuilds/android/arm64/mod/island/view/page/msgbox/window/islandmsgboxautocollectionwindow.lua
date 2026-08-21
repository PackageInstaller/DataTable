local var_0_0 = class("IslandMsgBoxAutoCollectionWindow", import(".IslandBaseMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandAutomaticCollectionMsgBox"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.confirmBtn = arg_2_0._tf:Find("container/btns/confirm")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("container/btns/cancel")
	arg_2_0.closeBtn = arg_2_0._tf:Find("container/close")
	arg_2_0.cancelTxt = arg_2_0._tf:Find("container/btns/cancel/Text"):GetComponent(typeof(Text))
	arg_2_0.confirmTxt = arg_2_0._tf:Find("container/btns/confirm/Text"):GetComponent(typeof(Text))
	arg_2_0.cancelTxt.text = i18n("word_cancel")
	arg_2_0.confirmTxt.text = i18n("word_ok")

	setText(arg_2_0.uigatherText, i18n("island_chara_gather_tag_1"))
	setText(arg_2_0.uimineText, i18n("island_chara_gather_tag_2"))

	arg_2_0.titleTxt = arg_2_0._tf:Find("container/title"):GetComponent(typeof(Text))
	arg_2_0.titleTxt.text = i18n("island_msg_info")

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.uigather, function()
		local var_6_0 = arg_3_0.selectTypeDic[IslandAutoCollectHelper.SelectType.Gather] or false
		local var_6_1 = not var_6_0

		arg_3_0.selectTypeDic[IslandAutoCollectHelper.SelectType.Gather] = not var_6_0

		setActive(arg_3_0.uigatherselected, var_6_1)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.uimine, function()
		local var_7_0 = arg_3_0.selectTypeDic[IslandAutoCollectHelper.SelectType.HandCollection] or false
		local var_7_1 = not var_7_0

		arg_3_0.selectTypeDic[IslandAutoCollectHelper.SelectType.HandCollection] = not var_7_0

		setActive(arg_3_0.uimineselected, var_7_1)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		local var_9_0 = IslandAutoCollectHelper.SelectType.None

		if arg_3_0.selectTypeDic[IslandAutoCollectHelper.SelectType.Gather] and arg_3_0.selectTypeDic[IslandAutoCollectHelper.SelectType.HandCollection] then
			var_9_0 = IslandAutoCollectHelper.SelectType.Both
		elseif arg_3_0.selectTypeDic[IslandAutoCollectHelper.SelectType.Gather] then
			var_9_0 = IslandAutoCollectHelper.SelectType.Gather
		elseif arg_3_0.selectTypeDic[IslandAutoCollectHelper.SelectType.HandCollection] then
			var_9_0 = IslandAutoCollectHelper.SelectType.HandCollection
		end

		arg_3_0.onYes(var_9_0, function()
			arg_3_0:Hide()

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShow(arg_11_0)
	arg_11_0.onYes = arg_11_0.settings.onYes
	arg_11_0.onNo = arg_11_0.settings.onNo
	arg_11_0.onHide = arg_11_0.settings.onHide
	arg_11_0.selectTypeDic = {}

	setActive(arg_11_0.uigatherselected, false)
	setActive(arg_11_0.uimineselected, false)

	return
end

function var_0_0.OnHide(arg_12_0)
	arg_12_0.onYes = nil
	arg_12_0.onNo = nil

	if arg_12_0.onHide then
		arg_12_0.onHide()

		arg_12_0.onHide = nil
	end

	return
end

return var_0_0
