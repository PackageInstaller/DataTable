local var_0_0 = class("SVGlobalBuff", import("view.base.BaseSubView"))

var_0_0.HideView = "SVGlobalBuff.HideView"

function var_0_0.getUIName(arg_1_0)
	return "SVGlobalBuff"
end

function var_0_0.OnLoaded(arg_2_0)
	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.rtFrame = arg_3_0._tf:Find("frame")
	arg_3_0.rtPanel = arg_3_0.rtFrame:Find("buff_panel/buff_bg")
	arg_3_0.rtInfo = arg_3_0.rtFrame:Find("buff_panel/info")

	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.OnDestroy(arg_5_0)
	return
end

function var_0_0.Show(arg_6_0)
	setLocalScale(arg_6_0.rtFrame, Vector3(0.5, 0.5, 0.5))
	LeanTween.cancel(go(arg_6_0.rtFrame))
	LeanTween.scale(arg_6_0.rtFrame, Vector3.one, 0.15)
	setActive(arg_6_0._tf, true)
	pg.UIMgr.GetInstance():BlurPanel(arg_6_0._tf)

	return
end

function var_0_0.Hide(arg_7_0)
	LeanTween.cancel(go(arg_7_0.rtFrame))
	setActive(arg_7_0._tf, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0._tf, arg_7_0._parentTf)
	arg_7_0:emit(var_0_0.HideView, arg_7_0.callback)

	return
end

function var_0_0.Setup(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.callback = arg_8_2

	eachChild(arg_8_0.rtPanel, function(arg_9_0)
		setActive(arg_9_0, arg_9_0.name == tostring(arg_8_1.id))

		return
	end)

	local var_8_0 = WorldBuff.New()

	var_8_0:Setup({
		id = arg_8_1.id,
		floor = arg_8_1.before
	})
	setText(arg_8_0.rtInfo:Find("name"), var_8_0.config.name)
	setText(arg_8_0.rtInfo:Find("value_before"), var_8_0:GetFloor())
	var_8_0:AddFloor(arg_8_1.floor)
	setText(arg_8_0.rtInfo:Find("value"), var_8_0:GetFloor())

	return
end

return var_0_0
