class = var_0_10000

local var_0_0 = "GatewayNoticeLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "GatewayNoticeUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.trFrame = var_1.Find(var_2_0, "frame")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "frame/title")

	arg_2_0.txtTitle = var_1.GetComponent(var_2_2, "Text")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/content")

	arg_2_0.txtContent = var_1.GetComponent(var_2_4, "RichText")

	local var_2_5 = arg_2_0._tf

	arg_2_0.btnBack = var_1.Find(var_2_5, "frame/title_pop/btnBack")

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.btnBack, function()
		local var_4_0 = arg_3_0

		var_0.showNext(var_4_0)

		return
	end)

	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	return
end

function var_0_1.updateNotices(arg_5_0, arg_5_1)
	arg_5_0.notices = arg_5_1

	arg_5_0:showNext()

	return
end

function var_0_1.showNext(arg_6_0)
	if arg_6_0.notice then
		local var_6_0 = arg_6_0.notice

		var_1.markAsRead(var_6_0)
	end

	if #arg_6_0.notices > 0 then
		table = var_1
		arg_6_0.notice = var_1.remove(arg_6_0.notices, 1)
		arg_6_0.txtTitle.text = arg_6_0.notice.title
		arg_6_0.txtContent.text = arg_6_0.notice.content

		local var_6_1 = arg_6_0.trFrame
		local var_6_2 = var_1.GetComponent(var_6_1, "CanvasGroup")

		LeanTween = var_2

		local var_6_3 = var_2.cancel

		go = var_1_10004

		var_6_3(var_1_10004(arg_6_0.trFrame))

		LeanTween = var_6_3

		local var_6_4 = var_6_3.value

		go = var_1_10004
		var_1_10004 = var_6_4(var_1_10004(arg_6_0.trFrame), 0, 1, 0.3)

		local var_6_5 = var_2.setEase

		LeanTweenType = var_5
		var_1_10004 = var_6_5(var_1_10004, var_5.easeOutBack)

		local var_6_6 = var_2.setOnUpdate

		System = var_5

		var_6_6(var_1_10004, var_5.Action_float(function(arg_7_0)
			var_6_2.alpha = arg_7_0

			local var_7_0 = arg_6_0.trFrame

			Vector3 = var_2_10002

			local var_7_1 = var_2_10002(0.8, 0.8, 1)

			Vector3 = var_2_10003
			var_7_0.localScale = var_7_1 + var_2_10003(0.2, 0.2, 0) * arg_7_0

			return
		end))

		pg = var_6_6
		var_1_10004 = var_6_6.CriMgr.GetInstance()

		local var_6_7 = var_2.PlaySoundEffect_V3

		SFX_PANEL = var_5

		var_6_7(var_1_10004, var_5)
	else
		local var_6_8 = arg_6_0
		local var_6_9 = arg_6_0.emit

		BaseUI = var_1_10004

		var_6_9(var_6_8, var_1_10004.ON_CLOSE)

		pg = var_6_9

		local var_6_10 = var_6_9.CriMgr.GetInstance()
		local var_6_11 = var_1.PlaySoundEffect_V3

		SFX_CANCEL = var_4

		var_6_11(var_6_10, var_4)
	end

	return
end

function var_0_1.willExit(arg_8_0)
	LeanTween = var_1_10001

	local var_8_0 = var_1_10001.cancel

	go = var_1_10003

	var_8_0(var_1_10003(arg_8_0.trFrame))

	pg = var_8_0

	local var_8_1 = var_8_0.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_8_1, arg_8_0._tf)

	return
end

return var_0_1
