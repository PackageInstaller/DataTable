local var_0_0 = class("EducateMsgBoxLayer", import("..base.EducateBaseUI"))

var_0_0.TYPE_NORMAL = 1
var_0_0.TYPE_SINGLE_ITEM = 2

local var_0_1 = {
	[var_0_0.TYPE_NORMAL] = Vector2(924, 616),
	[var_0_0.TYPE_SINGLE_ITEM] = Vector2(1060, 628)
}
local var_0_2 = {
	[var_0_0.TYPE_NORMAL] = i18n("child_msg_title_tip"),
	[var_0_0.TYPE_SINGLE_ITEM] = i18n("child_msg_title_detail")
}

function var_0_0.getUIName(arg_1_0)
	return "EducateMsgBoxUI"
end

function var_0_0.init(arg_2_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf, {
		groupDelta = 3
	})

	arg_2_0.anim = arg_2_0._tf:Find("anim_root"):GetComponent(typeof(Animation))
	arg_2_0.animEvent = arg_2_0._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	arg_2_0.animEvent:SetEndEvent(function()
		arg_2_0:emit(var_0_0.ON_CLOSE)

		return
	end)

	arg_2_0._window = arg_2_0._tf:Find("anim_root/window")

	setActive(arg_2_0._window, true)

	arg_2_0._top = arg_2_0._window:Find("top")
	arg_2_0._titleText = arg_2_0._top:Find("title")
	arg_2_0._closeBtn = arg_2_0._top:Find("btnBack")
	arg_2_0._msgPanel = arg_2_0._window:Find("msg_panel")
	arg_2_0.contentText = arg_2_0._msgPanel:Find("content"):GetComponent("RichText")

	arg_2_0.contentText:AddSprite("gold", arg_2_0._tf:Find("res/gold"):GetComponent(typeof(Image)).sprite)

	arg_2_0._sigleItemPanel = arg_2_0._window:Find("single_item_panel")
	arg_2_0.singleItemTF = arg_2_0._sigleItemPanel:Find("item")
	arg_2_0.singleItemOwn = arg_2_0._sigleItemPanel:Find("own")
	arg_2_0.singleItemName = arg_2_0._sigleItemPanel:Find("display_panel/name")
	arg_2_0.singleItemDesc = arg_2_0._sigleItemPanel:Find("display_panel/desc/Text")
	arg_2_0._noBtn = arg_2_0._window:Find("button_container/no")

	setText(arg_2_0._noBtn:Find("pic"), i18n("word_cancel"))

	arg_2_0._yesBtn = arg_2_0._window:Find("button_container/yes")

	setText(arg_2_0._yesBtn:Find("pic"), i18n("word_ok"))

	return
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0:ShowMsgBox(arg_4_0.contextData)

	return
end

function var_0_0.ShowMsgBox(arg_5_0, arg_5_1)
	arg_5_0:commonSetting(arg_5_1)
	arg_5_0:showByType(arg_5_1)

	return
end

function var_0_0.commonSetting(arg_6_0, arg_6_1)
	arg_6_0.settings = arg_6_1

	local var_6_0 = arg_6_0.settings.type or var_0_0.TYPE_NORMAL

	arg_6_0._window.sizeDelta = var_0_1[var_6_0]

	setText(arg_6_0._titleText, var_0_2[var_6_0])
	setActive(arg_6_0._msgPanel, false)
	setActive(arg_6_0._sigleItemPanel, false)

	local var_6_1 = arg_6_0.settings.hideNo or false
	local var_6_2 = arg_6_0.settings.hideYes or false
	local var_6_3 = arg_6_0.settings.hideClose or false
	local var_6_4

	if not arg_6_0.settings.onYes then
		function var_6_4()
			return
		end
	end

	local var_6_5

	if not arg_6_0.settings.onNo then
		function var_6_5()
			return
		end
	end

	local var_6_6

	if not arg_6_0.settings.onClose then
		function var_6_6()
			return
		end
	end

	setActive(arg_6_0._noBtn, not var_6_1)
	onButton(arg_6_0, arg_6_0._noBtn, function()
		if var_6_5 then
			var_6_5()
		end

		arg_6_0:_close()

		return
	end, SFX_CANCEL)
	setActive(arg_6_0._yesBtn, not var_6_2)
	onButton(arg_6_0, arg_6_0._yesBtn, function()
		if var_6_4 then
			var_6_4()
		end

		arg_6_0:_close()

		return
	end, SFX_CANCEL)
	setActive(arg_6_0._closeBtn, not var_6_3)
	onButton(arg_6_0, arg_6_0._closeBtn, function()
		if var_6_6 then
			var_6_6()
		else
			var_6_5()
		end

		arg_6_0:_close()

		return
	end, SFX_CANCEL)
	onButton(arg_6_0, tf(arg_6_0._go):Find("anim_root/bg"), function()
		if var_6_6 then
			var_6_6()
		else
			var_6_5()
		end

		arg_6_0:_close()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.showByType(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.settings.type or var_0_0.TYPE_NORMAL

	switch(var_14_0, {
		[var_0_0.TYPE_NORMAL] = function()
			arg_14_0:showNormalMsgBox()

			return
		end,
		[var_0_0.TYPE_SINGLE_ITEM] = function()
			arg_14_0:showSingleItemBox()

			return
		end
	})

	return
end

function var_0_0.showNormalMsgBox(arg_17_0)
	setActive(arg_17_0._msgPanel, true)

	arg_17_0.contentText.text = arg_17_0.settings.content or ""

	return
end

function var_0_0.showSingleItemBox(arg_18_0)
	setActive(arg_18_0._sigleItemPanel, true)
	setActive(arg_18_0._noBtn, false)
	EducateHelper.UpdateDropShow(arg_18_0.singleItemTF, arg_18_0.settings.drop)

	local var_18_0 = EducateHelper.GetDropConfig(arg_18_0.settings.drop)
	local var_18_1 = var_18_0.name or ""

	setText(arg_18_0.singleItemName, var_18_1)

	if arg_18_0.settings.drop.type == EducateConst.DROP_TYPE_RES and var_18_0.id == EducateChar.RES_MOOD_ID then
		setText(arg_18_0.singleItemDesc, arg_18_0:getMoodDesc(var_18_0.desc))
	else
		local var_18_3 = var_18_0.desc or var_18_0.name or ""

		var_18_2(arg_18_0.singleItemDesc, var_18_3)
	end

	if arg_18_0.settings.drop.type == EducateConst.DROP_TYPE_ITEM then
		setText(arg_18_0.singleItemOwn, i18n("child_msg_owned", (getProxy(EducateProxy):GetItemCntById(var_18_0.id))))
		setActive(arg_18_0.singleItemOwn, true)
	else
		setActive(arg_18_0.singleItemOwn, false)
	end

	return
end

function var_0_0.getMoodDesc(arg_19_0, arg_19_1)
	return string.gsub(arg_19_1, "$1", i18n("child_mood_desc" .. getProxy(EducateProxy):GetCharData():GetMoodStage()))
end

function var_0_0._close(arg_20_0)
	arg_20_0.anim:Play("anim_educate_MsgBox_out")

	return
end

function var_0_0.onBackPressed(arg_21_0)
	arg_21_0:_close()

	return
end

function var_0_0.willExit(arg_22_0)
	arg_22_0.animEvent:SetEndEvent(nil)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_22_0._tf)

	if arg_22_0.contextData.onExit then
		arg_22_0.contextData.onExit()
	end

	return
end

return var_0_0
