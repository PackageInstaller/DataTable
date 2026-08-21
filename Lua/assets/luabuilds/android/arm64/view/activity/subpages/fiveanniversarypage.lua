local var_0_0 = class("FiveAnniversaryPage", import("...base.BaseActivityPage"))
local var_0_1 = 42
local var_0_2 = {}
local var_0_3 = 3.5
local var_0_4 = 1
local var_0_5 = 6
local var_0_6 = SCENE.BACKHILL_CAMPUSFESTIVAL_2022

function var_0_0.OnInit(arg_1_0)
	arg_1_0.hideIndex = {}
	arg_1_0.scrollAble = false

	local var_1_0 = findTF(arg_1_0._tf, "BtnList")

	var_0_2 = PLATFORM_CODE == PLATFORM_CH and {
		2,
		3,
		5,
		8
	} or PLATFORM_CODE == PLATFORM_CHT and {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10,
		11
	} or {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10
	}

	if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_CHT then
		arg_1_0.hideIndex = {}
		arg_1_0.scrollAble = true
		var_1_0.anchoredPosition = Vector2(-11, -20)
		var_1_0.sizeDelta = Vector2(1437, 90)
	elseif PLATFORM_CODE == PLATFORM_US then
		arg_1_0.hideIndex = {
			1,
			2,
			5,
			6
		}
		arg_1_0.scrollAble = false
		var_1_0.anchoredPosition = Vector2(678, -20)
		var_1_0.sizeDelta = Vector2(1186, 90)
	else
		arg_1_0.hideIndex = {
			5,
			6
		}
		arg_1_0.scrollAble = false
		var_1_0.anchoredPosition = Vector2(115, -20)
		var_1_0.sizeDelta = Vector2(1186, 90)
	end

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

	for iter_2_0 = 0, arg_2_0.btnContainer.childCount / 3 - 1 do
		arg_2_0.btnList1[iter_2_0 + 1] = arg_2_0.btnContainer:GetChild(iter_2_0)
	end

	arg_2_0.btnList2 = {}

	for iter_2_1 = arg_2_0.btnContainer.childCount / 3, 2 * (arg_2_0.btnContainer.childCount / 3) - 1 do
		arg_2_0.btnList2[#arg_2_0.btnList2 + 1] = arg_2_0.btnContainer:GetChild(iter_2_1)
	end

	arg_2_0.btnList3 = {}

	for iter_2_2 = arg_2_0.btnContainer.childCount / 3 * 2, 3 * (arg_2_0.btnContainer.childCount / 3) - 1 do
		arg_2_0.btnList3[#arg_2_0.btnList3 + 1] = arg_2_0.btnContainer:GetChild(iter_2_2)
	end

	for iter_2_3 = 1, arg_2_0.btnContainer.childCount / 3 * 3 do
		if table.contains(arg_2_0.hideIndex, (iter_2_3 - 1) % var_0_5 + 1) or not arg_2_0.scrollAble and iter_2_3 > var_0_5 then
			setActive(arg_2_0.btnContainer:GetChild(iter_2_3 - 1), false)
		end
	end

	arg_2_0.gridLayoutGroupCom = GetComponent(arg_2_0.btnContainer, "GridLayoutGroup")

	return
end

function var_0_0.initData(arg_3_0)
	arg_3_0.paintCount = #var_0_2
	arg_3_0.curPaintIndex = 1
	arg_3_0.paintSwitchTime = var_0_4
	arg_3_0.paintStaticTime = var_0_3
	arg_3_0.paintStaticCountValue = 0
	arg_3_0.paintPathPrefix = "clutter/"
	arg_3_0.paintNamePrefix = "fivea"
	arg_3_0.btnCount = arg_3_0.btnContainer.childCount / 3
	arg_3_0.btnSpeed = 50
	arg_3_0.btnSizeX = arg_3_0.gridLayoutGroupCom.cellSize.x
	arg_3_0.btnMarginX = arg_3_0.gridLayoutGroupCom.spacing.x
	arg_3_0.moveLength = (arg_3_0.btnCount - #arg_3_0.hideIndex) * (arg_3_0.btnSizeX + arg_3_0.btnMarginX)
	arg_3_0.startAnchoredPosX = arg_3_0.btnContainer.anchoredPosition.x

	return
end

function var_0_0.switchNextPaint(arg_4_0)
	arg_4_0.frameTimer:Stop()
	setImageSprite(arg_4_0.paintBackTF, LoadSprite(arg_4_0.paintPathPrefix .. arg_4_0.paintNamePrefix .. var_0_2[arg_4_0.curPaintIndex % arg_4_0.paintCount + 1], arg_4_0.paintNamePrefix .. var_0_2[arg_4_0.curPaintIndex % arg_4_0.paintCount + 1]))
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
	onButton(arg_7_0, arg_7_0.skinShopBtn, function()
		arg_7_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	arg_7_0:initPaint()
	arg_7_0:initBtnList(arg_7_0.btnList1)
	arg_7_0:initBtnList(arg_7_0.btnList2)
	arg_7_0:initBtnList(arg_7_0.btnList3)
	arg_7_0:initTimer()

	return
end

function var_0_0.initPaint(arg_9_0)
	setImageSprite(arg_9_0.paintFrontTF, LoadSprite(arg_9_0.paintPathPrefix .. arg_9_0.paintNamePrefix .. var_0_2[(arg_9_0.curPaintIndex - 1) % arg_9_0.paintCount + 1], arg_9_0.paintNamePrefix .. var_0_2[(arg_9_0.curPaintIndex - 1) % arg_9_0.paintCount + 1]))
	setImageSprite(arg_9_0.paintBackTF, LoadSprite(arg_9_0.paintPathPrefix .. arg_9_0.paintNamePrefix .. var_0_2[(arg_9_0.curPaintIndex - 1) % arg_9_0.paintCount + 1], arg_9_0.paintNamePrefix .. var_0_2[(arg_9_0.curPaintIndex - 1) % arg_9_0.paintCount + 1]))

	return
end

function var_0_0.initBtnList(arg_10_0, arg_10_1)
	for iter_10_0 = 1, #arg_10_1 do
		arg_10_0:initBtnEvent(arg_10_1[iter_10_0], iter_10_0)
	end

	return
end

function var_0_0.initBtnEvent(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 == 1 then
		onButton(arg_11_0, arg_11_1, function()
			arg_11_0:emit(ActivityMediator.GO_PRAY_POOL)

			return
		end, SFX_PANEL)
	elseif arg_11_2 == 2 then
		onButton(arg_11_0, arg_11_1, function()
			if PLATFORM_CODE == PLATFORM_CHT then
				arg_11_0:emit(ActivityMediator.SELECT_ACTIVITY, 41327)
			else
				arg_11_0:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.ACTIVITY_TYPE_RETURN_AWARD_ID5)
			end

			return
		end, SFX_PANEL)
	elseif arg_11_2 == 3 then
		onButton(arg_11_0, arg_11_1, function()
			if PLATFORM_CODE == PLATFORM_CHT then
				arg_11_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SIXTH_ANNIVERSARY_JP)
			else
				arg_11_0:emit(ActivityMediator.EVENT_GO_SCENE, var_0_6)
			end

			return
		end, SFX_PANEL)
	elseif arg_11_2 == 4 then
		onButton(arg_11_0, arg_11_1, function()
			if PLATFORM_CODE == PLATFORM_CHT then
				arg_11_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SIXTH_ANNIVERSARY_JP_DARK)
			else
				arg_11_0:emit(ActivityMediator.GO_MINI_GAME, var_0_1)
			end

			return
		end, SFX_PANEL)
	elseif arg_11_2 == 5 then
		onButton(arg_11_0, arg_11_1, function()
			arg_11_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SUMMARY)

			return
		end, SFX_PANEL)
	elseif arg_11_2 == 6 then
		onButton(arg_11_0, arg_11_1, function()
			arg_11_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CHARGE, {
				wrap = ChargeScene.TYPE_DIAMOND
			})

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.initTimer(arg_18_0)
	local var_18_0 = 0.016666666666666666

	arg_18_0.paintStaticCountValue = 0
	arg_18_0.frameTimer = Timer.New(function()
		arg_18_0.paintStaticCountValue = arg_18_0.paintStaticCountValue + var_18_0

		if arg_18_0.paintStaticCountValue >= arg_18_0.paintStaticTime then
			arg_18_0.paintStaticCountValue = 0

			arg_18_0:switchNextPaint()
		end

		return
	end, 0.016666666666666666, -1, false)

	arg_18_0.frameTimer:Start()

	if arg_18_0.scrollAble then
		arg_18_0.frameTimer2 = Timer.New(function()
			local var_20_0 = arg_18_0.btnContainer.anchoredPosition.x - arg_18_0.btnSpeed * var_18_0

			if arg_18_0.startAnchoredPosX - (arg_18_0.btnContainer.anchoredPosition.x - arg_18_0.btnSpeed * var_18_0) >= arg_18_0.moveLength then
				var_20_0 = arg_18_0.btnContainer.anchoredPosition.x + arg_18_0.moveLength
			end

			arg_18_0.btnContainer.anchoredPosition = Vector3(var_20_0, 0, 0)

			return
		end, 0.016666666666666666, -1, false)

		arg_18_0.frameTimer2:Start()
	end

	return
end

function var_0_0.OnDestroy(arg_21_0)
	if arg_21_0.frameTimer then
		arg_21_0.frameTimer:Stop()

		arg_21_0.frameTimer = nil
	end

	if arg_21_0.frameTimer2 then
		arg_21_0.frameTimer2:Stop()

		arg_21_0.frameTimer2 = nil
	end

	return
end

return var_0_0
