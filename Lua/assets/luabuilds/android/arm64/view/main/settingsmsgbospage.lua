local var_0_0 = class("SettingsMsgBosPage", import("..base.BaseSubView"))

var_0_0.ALIGN_CENTER = 0
var_0_0.ALIGN_LEFT = 1

function var_0_0.getUIName(arg_1_0)
	return "SetttingMsgbox"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("window/top/btnBack")
	arg_2_0.textTr = arg_2_0._tf:Find("window/view/content/Text")
	arg_2_0.text = arg_2_0.textTr:GetComponent(typeof(Text))
	arg_2_0.scrollrect = arg_2_0._tf:Find("window/view/content")

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_6_0, arg_6_1, arg_6_2)
	pg.UIMgr.GetInstance():BlurPanel(arg_6_0._tf)
	var_0_0.super.Show(arg_6_0)

	arg_6_0.text.text = arg_6_1

	arg_6_0:UpdateLayout(arg_6_2 or var_0_0.ALIGN_CENTER)

	arg_6_0.scrollrect:GetComponent(typeof(ScrollRect)).verticalNormalizedPosition = 1

	arg_6_0._tf:SetAsLastSibling()

	return
end

function var_0_0.UpdateLayout(arg_7_0, arg_7_1)
	local var_7_0 = Vector2(0.5, 0.5)
	local var_7_1 = TextAnchor.MiddleCenter

	if arg_7_1 == var_0_0.ALIGN_LEFT then
		var_7_0 = Vector2(0, 1)
		var_7_1 = TextAnchor.UpperLeft
	end

	arg_7_0.textTr.pivot = var_7_0
	arg_7_0.text.alignment = var_7_1

	setAnchoredPosition(arg_7_0.textTr, {
		x = arg_7_0.textTr:GetComponent(typeof(LayoutElement)).preferredWidth * (var_7_0.x - 0.5)
	})

	return
end

function var_0_0.Hide(arg_8_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_8_0._tf, arg_8_0._parentTf)
	var_0_0.super.Hide(arg_8_0)

	arg_8_0.text.text = ""

	return
end

function var_0_0.OnDestroy(arg_9_0)
	arg_9_0:Hide()

	return
end

return var_0_0
