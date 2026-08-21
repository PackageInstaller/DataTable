local var_0_0 = class("SVAchievement", import("view.base.BaseSubView"))

var_0_0.HideView = "SVAchievement.HideView"

function var_0_0.getUIName(arg_1_0)
	return "SVAchievement"
end

function var_0_0.OnLoaded(arg_2_0)
	return
end

function var_0_0.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf:Find("display")

	var_3_0.localScale = Vector3.New(arg_3_0._tf.rect.width / var_3_0.rect.width, arg_3_0._tf.rect.width / var_3_0.rect.width, 0)
	arg_3_0.rtDesc = var_3_0:Find("desc")
	arg_3_0.rtStar = arg_3_0.rtDesc:Find("star")

	onButton(arg_3_0, arg_3_0._tf, function()
		if arg_3_0.isClosing then
			return
		end

		arg_3_0:Hide()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.OnDestroy(arg_5_0)
	return
end

function var_0_0.Show(arg_6_0)
	setAnchoredPosition(arg_6_0.rtStar, Vector2.New(100, 0))
	setActive(arg_6_0.rtStar:Find("SVAstar"), false)
	pg.UIMgr.GetInstance():OverlayPanel(arg_6_0._tf)
	setActive(arg_6_0._tf, true)

	return
end

function var_0_0.Hide(arg_7_0)
	arg_7_0.isClosing = true

	local var_7_0 = arg_7_0.rtDesc:InverseTransformPoint(arg_7_0.starWorldPos)

	table.insert({}, function(arg_8_0)
		setActive(arg_7_0.rtStar:Find("SVAstar"), true)
		LeanTween.moveLocal(go(arg_7_0.rtStar), Vector3.New(var_7_0.x, var_7_0.y, 0), 0.5):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(arg_8_0))

		return
	end)
	table.insert({}, function(arg_9_0)
		Timer.New(arg_9_0, 1.1):Start()

		return
	end)
	seriesAsync({}, function()
		arg_7_0.isClosing = false

		pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0._tf, arg_7_0._parentTf)
		setActive(arg_7_0._tf, false)
		arg_7_0:emit(var_0_0.HideView)

		return
	end)

	return
end

function var_0_0.Setup(arg_11_0, arg_11_1, arg_11_2)
	setText(arg_11_0.rtDesc, arg_11_1.config.target_desc)

	arg_11_0.starWorldPos = arg_11_2

	return
end

return var_0_0
