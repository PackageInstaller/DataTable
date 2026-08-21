local var_0_0 = class("ThirdAnniversaryJPPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0:findUI()
	arg_1_0:initData()

	return
end

function var_0_0.findUI(arg_2_0)
	arg_2_0.paintBackTF = arg_2_0._tf:Find("Paints/PaintBack")
	arg_2_0.paintFrontTF = arg_2_0._tf:Find("Paints/PaintFront")
	arg_2_0.skinShopBtn = arg_2_0._tf:Find("BtnShop")
	arg_2_0.btnContainer = arg_2_0._tf:Find("BtnList/Viewport/Content")
	arg_2_0.btnList1 = {}

	for iter_2_0 = 0, arg_2_0.btnContainer.childCount / 2 - 1 do
		arg_2_0.btnList1[iter_2_0 + 1] = arg_2_0.btnContainer:GetChild(iter_2_0)
	end

	arg_2_0.btnList2 = {}

	for iter_2_1 = 5, 2 * (arg_2_0.btnContainer.childCount / 2) - 1 do
		arg_2_0.btnList2[#arg_2_0.btnList2 + 1] = arg_2_0.btnContainer:GetChild(iter_2_1)
	end

	arg_2_0.gridLayoutGroupCom = GetComponent(arg_2_0.btnContainer, "GridLayoutGroup")

	return
end

function var_0_0.initData(arg_3_0)
	arg_3_0.paintCount = 18
	arg_3_0.curPaintIndex = 1
	arg_3_0.paintSwitchTime = 1
	arg_3_0.paintStaticTime = 3.5
	arg_3_0.paintStaticCountValue = 0
	arg_3_0.paintPathPrefix = "thirdanniversaryjppage/"
	arg_3_0.paintNamePrefix = "paint"
	arg_3_0.btnCount = arg_3_0.btnContainer.childCount / 2
	arg_3_0.btnSpeed = 50
	arg_3_0.btnSizeX = arg_3_0.gridLayoutGroupCom.cellSize.x
	arg_3_0.btnMarginX = arg_3_0.gridLayoutGroupCom.spacing.x
	arg_3_0.moveLength = arg_3_0.btnCount * (arg_3_0.btnSizeX + arg_3_0.btnMarginX)
	arg_3_0.startAnchoredPosX = arg_3_0.btnContainer.anchoredPosition.x

	return
end

function var_0_0.switchNextPaint(arg_4_0)
	arg_4_0.frameTimer:Stop()
	setImageSprite(arg_4_0.paintBackTF, LoadSprite(arg_4_0.paintPathPrefix .. arg_4_0.paintNamePrefix .. arg_4_0.curPaintIndex % arg_4_0.paintCount + 1, arg_4_0.paintNamePrefix .. arg_4_0.curPaintIndex % arg_4_0.paintCount + 1))
	LeanTween.value(go(arg_4_0.paintFrontTF), 1, 0, arg_4_0.paintSwitchTime):setOnUpdate(System.Action_float(function(arg_5_0)
		setImageAlpha(arg_4_0.paintFrontTF, arg_5_0)
		setImageAlpha(arg_4_0.paintBackTF, 1 - arg_5_0)

		return
	end)):setOnComplete(System.Action(function()
		setImageFromImage(arg_4_0.paintFrontTF, arg_4_0.paintBackTF)
		setImageAlpha(arg_4_0.paintFrontTF, 1)
		setImageAlpha(arg_4_0.paintBackTF, 0)

		arg_4_0.curPaintIndex = var_0

		arg_4_0.frameTimer:Start()

		return
	end))

	return
end

function var_0_0.OnFirstFlush(arg_7_0)
	arg_7_0:initPaint()
	arg_7_0:initBtnList(arg_7_0.btnList1)
	arg_7_0:initBtnList(arg_7_0.btnList2)
	arg_7_0:initTimer()

	return
end

function var_0_0.initPaint(arg_8_0)
	setImageSprite(arg_8_0.paintFrontTF, LoadSprite(arg_8_0.paintPathPrefix .. arg_8_0.paintNamePrefix .. arg_8_0.curPaintIndex, arg_8_0.paintNamePrefix .. arg_8_0.curPaintIndex))
	setImageSprite(arg_8_0.paintBackTF, LoadSprite(arg_8_0.paintPathPrefix .. arg_8_0.paintNamePrefix .. (arg_8_0.curPaintIndex - 1) % arg_8_0.paintCount + 1, arg_8_0.paintNamePrefix .. (arg_8_0.curPaintIndex - 1) % arg_8_0.paintCount + 1))

	return
end

function var_0_0.initBtnList(arg_9_0, arg_9_1)
	onButton(arg_9_0, arg_9_1[1], function()
		arg_9_0:emit(ActivityMediator.GO_PRAY_POOL)

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_1[2], function()
		arg_9_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_1[3], function()
		arg_9_0:emit(ActivityMediator.SELECT_ACTIVITY, getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_RETURN_AWARD).id)

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_1[4], function()
		arg_9_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.THIRD_ANNIVERSARY_AKIBA)

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_1[5], function()
		arg_9_0:emit(ActivityMediator.SELECT_ACTIVITY, pg.activity_const.JIUJIU_ADVENTURE_ID.act_id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.initTimer(arg_15_0)
	local var_15_0 = 0.016666666666666666

	arg_15_0.paintStaticCountValue = 0
	arg_15_0.frameTimer = Timer.New(function()
		arg_15_0.paintStaticCountValue = arg_15_0.paintStaticCountValue + var_15_0

		if arg_15_0.paintStaticCountValue >= arg_15_0.paintStaticTime then
			arg_15_0.paintStaticCountValue = 0

			arg_15_0:switchNextPaint()
		end

		return
	end, 0.016666666666666666, -1, false)

	arg_15_0.frameTimer:Start()

	arg_15_0.frameTimer2 = Timer.New(function()
		local var_17_0 = arg_15_0.btnContainer.anchoredPosition.x - arg_15_0.btnSpeed * var_15_0

		if arg_15_0.startAnchoredPosX - (arg_15_0.btnContainer.anchoredPosition.x - arg_15_0.btnSpeed * var_15_0) >= arg_15_0.moveLength then
			var_17_0 = arg_15_0.btnContainer.anchoredPosition.x + arg_15_0.moveLength
		end

		arg_15_0.btnContainer.anchoredPosition = Vector3(var_17_0, 0, 0)

		return
	end, 0.016666666666666666, -1, false)

	arg_15_0.frameTimer2:Start()

	return
end

function var_0_0.OnDestroy(arg_18_0)
	if arg_18_0.frameTimer then
		arg_18_0.frameTimer:Stop()

		arg_18_0.frameTimer = nil
	end

	if arg_18_0.frameTimer2 then
		arg_18_0.frameTimer2:Stop()

		arg_18_0.frameTimer2 = nil
	end

	return
end

return var_0_0
