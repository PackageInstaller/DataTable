local var_0_0 = class("ChargeJPUserAgreeLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "ChargeJPUserAgreeUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initUIText()

	return
end

function var_0_0.didEnter(arg_3_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)

	local var_3_0 = arg_3_0.contentStr or ""

	setText(arg_3_0.scrollText, var_3_0)
	scrollTo(arg_3_0.scrollRect, 0, 1)

	return
end

function var_0_0.willExit(arg_4_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_4_0._tf)

	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.contentStr = arg_5_0.contextData.contentStr and arg_5_0.contextData.contentStr.content

	return
end

function var_0_0.initUIText(arg_6_0)
	return
end

function var_0_0.findUI(arg_7_0)
	arg_7_0.bg = arg_7_0._tf:Find("bg")
	arg_7_0.closeBtn = arg_7_0._tf:Find("window/top/btnBack")
	arg_7_0.scrollRect = arg_7_0._tf:Find("container/scrollrect")
	arg_7_0.scrollText = arg_7_0.scrollRect:Find("content/Text")

	return
end

function var_0_0.addListener(arg_8_0)
	onButton(arg_8_0, arg_8_0.bg, function()
		arg_8_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0.closeBtn, function()
		arg_8_0:closeView()

		return
	end, SFX_CANCEL)

	return
end

return var_0_0
