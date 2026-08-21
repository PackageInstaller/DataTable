local var_0_0 = class("Spring23AnniversaryPage", import("...base.BaseActivityPage"))
local var_0_1 = 42
local var_0_2 = {}
local var_0_3 = 3.5
local var_0_4 = 1
local var_0_5 = 6
local var_0_6 = SCENE.NEWYEAR_BACKHILL_2023
local var_0_7 = "spring23a"

function var_0_0.OnInit(arg_1_0)
	arg_1_0.hideIndex = {}
	arg_1_0.scrollAble = false

	local var_1_0 = findTF(arg_1_0._tf, "BtnList")

	setActive(var_1_0, false)

	var_0_2 = PLATFORM_CODE == PLATFORM_CH and {
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
		11,
		12,
		13,
		14,
		15,
		16
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
		11,
		12,
		13,
		14,
		15,
		16
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
		10,
		11,
		12,
		13,
		14,
		15,
		16
	}

	if PLATFORM_CODE == PLATFORM_JP or PLATFORM_CODE == PLATFORM_CHT then
		arg_1_0.hideIndex = {}
		arg_1_0.scrollAble = true
		var_1_0.anchoredPosition = Vector2(-11, -20)
		var_1_0.sizeDelta = Vector2(1437, 90)
	elseif PLATFORM_CODE == PLATFORM_US then
		arg_1_0.hideIndex = {}
		arg_1_0.scrollAble = false
		var_1_0.anchoredPosition = Vector2(678, -20)
		var_1_0.sizeDelta = Vector2(1186, 90)
	else
		arg_1_0.hideIndex = {}
		arg_1_0.scrollAble = false
		var_1_0.anchoredPosition = Vector2(115, -20)
		var_1_0.sizeDelta = Vector2(1186, 90)
	end

	arg_1_0:findUI()

	return
end

function var_0_0.findUI(arg_2_0)
	arg_2_0.paintBackTF = arg_2_0._tf:Find("Paints/PaintBack")
	arg_2_0.paintFrontTF = arg_2_0._tf:Find("Paints/PaintFront")
	arg_2_0.skinShopBtn = arg_2_0._tf:Find("BtnShop")
	arg_2_0.btnGo = arg_2_0._tf:Find("BtnGo")
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
	arg_3_0.displayDatas = arg_3_0.activity:getConfig("config_client").display_link

	if arg_3_0.displayDatas and #arg_3_0.displayDatas then
		for iter_3_0 = 1, #arg_3_0.displayDatas do
			if arg_3_0.displayDatas[iter_3_0][2] and arg_3_0.displayDatas[iter_3_0][2] ~= 0 then
				local var_3_0, var_3_1 = pg.TimeMgr.GetInstance():inTime(pg.shop_template[arg_3_0.displayDatas[iter_3_0][2]].time)

				if not var_3_0 then
					table.insert({}, arg_3_0.displayDatas[iter_3_0][1])
				end
			end
		end
	end

	if {} and #{} > 0 then
		for iter_3_1 = #var_0_2, 1, -1 do
			if table.contains({}, var_0_2[iter_3_1]) then
				table.remove(var_0_2, iter_3_1)
			end
		end
	end

	arg_3_0.paintCount = #var_0_2
	arg_3_0.curPaintIndex = math.random(1, #var_0_2)
	arg_3_0.paintSwitchTime = var_0_4
	arg_3_0.paintStaticTime = var_0_3
	arg_3_0.paintStaticCountValue = 0
	arg_3_0.paintPathPrefix = "clutter/"
	arg_3_0.paintNamePrefix = var_0_7
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
	arg_7_0:initData()
	onButton(arg_7_0, arg_7_0.skinShopBtn, function()
		arg_7_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	onButton(arg_7_0, arg_7_0.btnGo, function()
		arg_7_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SPRING_FESTIVAL_BACKHILL_2023)

		return
	end)
	arg_7_0:initPaint()
	arg_7_0:initBtnList(arg_7_0.btnList1)
	arg_7_0:initBtnList(arg_7_0.btnList2)
	arg_7_0:initBtnList(arg_7_0.btnList3)
	arg_7_0:initTimer()

	return
end

function var_0_0.initPaint(arg_10_0)
	setImageSprite(arg_10_0.paintFrontTF, LoadSprite(arg_10_0.paintPathPrefix .. arg_10_0.paintNamePrefix .. var_0_2[(arg_10_0.curPaintIndex - 1) % arg_10_0.paintCount + 1], arg_10_0.paintNamePrefix .. var_0_2[(arg_10_0.curPaintIndex - 1) % arg_10_0.paintCount + 1]))
	setImageSprite(arg_10_0.paintBackTF, LoadSprite(arg_10_0.paintPathPrefix .. arg_10_0.paintNamePrefix .. var_0_2[(arg_10_0.curPaintIndex - 1) % arg_10_0.paintCount + 1], arg_10_0.paintNamePrefix .. var_0_2[(arg_10_0.curPaintIndex - 1) % arg_10_0.paintCount + 1]))

	return
end

function var_0_0.initBtnList(arg_11_0, arg_11_1)
	for iter_11_0 = 1, #arg_11_1 do
		arg_11_0:initBtnEvent(arg_11_1[iter_11_0], iter_11_0)
	end

	return
end

function var_0_0.initBtnEvent(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 == 1 then
		onButton(arg_12_0, arg_12_1, function()
			arg_12_0:emit(ActivityMediator.GO_PRAY_POOL)

			return
		end, SFX_PANEL)
	elseif arg_12_2 == 2 then
		onButton(arg_12_0, arg_12_1, function()
			arg_12_0:emit(ActivityMediator.SELECT_ACTIVITY, ActivityConst.ACTIVITY_TYPE_RETURN_AWARD_ID5)

			return
		end, SFX_PANEL)
	elseif arg_12_2 == 3 then
		onButton(arg_12_0, arg_12_1, function()
			arg_12_0:emit(ActivityMediator.EVENT_GO_SCENE, var_0_6)

			return
		end, SFX_PANEL)
	elseif arg_12_2 == 4 then
		onButton(arg_12_0, arg_12_1, function()
			arg_12_0:emit(ActivityMediator.GO_MINI_GAME, var_0_1)

			return
		end, SFX_PANEL)
	elseif arg_12_2 == 5 then
		onButton(arg_12_0, arg_12_1, function()
			arg_12_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SUMMARY)

			return
		end, SFX_PANEL)
	elseif arg_12_2 == 6 then
		onButton(arg_12_0, arg_12_1, function()
			arg_12_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CHARGE, {
				wrap = ChargeScene.TYPE_DIAMOND
			})

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.initTimer(arg_19_0)
	local var_19_0 = 0.016666666666666666

	arg_19_0.paintStaticCountValue = 0
	arg_19_0.frameTimer = Timer.New(function()
		arg_19_0.paintStaticCountValue = arg_19_0.paintStaticCountValue + var_19_0

		if arg_19_0.paintStaticCountValue >= arg_19_0.paintStaticTime then
			arg_19_0.paintStaticCountValue = 0

			arg_19_0:switchNextPaint()
		end

		return
	end, 0.016666666666666666, -1, false)

	arg_19_0.frameTimer:Start()

	if arg_19_0.scrollAble then
		arg_19_0.frameTimer2 = Timer.New(function()
			local var_21_0 = arg_19_0.btnContainer.anchoredPosition.x - arg_19_0.btnSpeed * var_19_0

			if arg_19_0.startAnchoredPosX - (arg_19_0.btnContainer.anchoredPosition.x - arg_19_0.btnSpeed * var_19_0) >= arg_19_0.moveLength then
				var_21_0 = arg_19_0.btnContainer.anchoredPosition.x + arg_19_0.moveLength
			end

			arg_19_0.btnContainer.anchoredPosition = Vector3(var_21_0, 0, 0)

			return
		end, 0.016666666666666666, -1, false)

		arg_19_0.frameTimer2:Start()
	end

	return
end

function var_0_0.OnDestroy(arg_22_0)
	if LeanTween.isTweening(go(arg_22_0.paintFrontTF)) then
		LeanTween.cancel(go(arg_22_0.paintFrontTF))
	end

	if arg_22_0.frameTimer then
		arg_22_0.frameTimer:Stop()

		arg_22_0.frameTimer = nil
	end

	if arg_22_0.frameTimer2 then
		arg_22_0.frameTimer2:Stop()

		arg_22_0.frameTimer2 = nil
	end

	return
end

return var_0_0
