local var_0_0 = class("CityRebuildGameLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "CityRebuildGameUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.bg1 = arg_2_0._tf:Find("bgs/bg1")
	arg_2_0.bg2 = arg_2_0._tf:Find("bgs/bg2")
	arg_2_0.bg3 = arg_2_0._tf:Find("bgs/bg3")
	arg_2_0._ship = arg_2_0._tf:Find("ship")
	arg_2_0._ship2 = arg_2_0._tf:Find("ship2")
	arg_2_0.effect = arg_2_0._tf:Find("effect")
	arg_2_0.ui = arg_2_0._tf:Find("ui")
	arg_2_0.backBtn = arg_2_0.ui:Find("top/backBtn")
	arg_2_0.homeBtn = arg_2_0.ui:Find("top/homeBtn")
	arg_2_0.hpSlider = arg_2_0.ui:Find("top/hpSlider")
	arg_2_0.hp = arg_2_0.ui:Find("top/hp")
	arg_2_0.firstAwardList = UIItemList.New(arg_2_0.ui:Find("top/awardPanel/first/items"), arg_2_0.ui:Find("top/awardPanel/first/items/item"))
	arg_2_0.ptAwardCount = arg_2_0.ui:Find("top/awardPanel/others/count")
	arg_2_0.cityLevel = arg_2_0.ui:Find("left/cityLevel/Text")
	arg_2_0.battleLevel = arg_2_0.ui:Find("left/battleLevel/Text")
	arg_2_0.summaryPanel = arg_2_0.ui:Find("left/panel")
	arg_2_0.currentLevel = arg_2_0.ui:Find("top/currentLevel/Text")
	arg_2_0.enemyName = arg_2_0.ui:Find("top/enemyName")
	arg_2_0.resultBtn = arg_2_0.ui:Find("right/resultBtn")
	arg_2_0.bookBtn = arg_2_0.ui:Find("right/bookBtn")
	arg_2_0.taskBtn = arg_2_0.ui:Find("right/taskBtn")
	arg_2_0.previousLevelBtn = arg_2_0.ui:Find("right/previousLevelBtn")
	arg_2_0.nextLevelBtn = arg_2_0.ui:Find("right/nextLevelBtn")
	arg_2_0.damageAni = arg_2_0._tf:Find("damage"):GetComponent(typeof(Animation))
	arg_2_0.damageText = arg_2_0._tf:Find("damage/Text")
	arg_2_0.effect = arg_2_0._tf:Find("effect")
	arg_2_0.deadEffectList = {
		arg_2_0.effect:Find("xinnianyouxi_baozha"),
		arg_2_0.effect:Find("xinnianyouxi_baozha2"),
		arg_2_0.effect:Find("xinnianyouxi_baozha3")
	}

	setText(arg_2_0.ui:Find("left/cityLevel/title"), i18n("ninja_game_citylevel"))
	setText(arg_2_0.ui:Find("left/battleLevel/title"), i18n("ninja_game_wave"))
	setText(arg_2_0.summaryPanel:Find("buildingDPS"), i18n("ninja_game_citydmg"))
	setText(arg_2_0.summaryPanel:Find("charaDPS"), i18n("ninja_game_allydmg"))
	setText(arg_2_0.summaryPanel:Find("DPS"), i18n("ninja_game_dps"))
	setText(arg_2_0.summaryPanel:Find("time"), i18n("ninja_game_time"))
	setText(arg_2_0.summaryPanel:Find("pts"), i18n("ninja_game_income"))
	setText(arg_2_0.summaryPanel:Find("pt"), i18n("ninja_game_ptcount"))
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:InitData()
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.homeBtn, function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.bookBtn, function()
		arg_3_0:emit(CityRebuildGameMediator.OPEN_BOOK)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.taskBtn, function()
		arg_3_0:emit(CityRebuildGameMediator.OPEN_TASKS)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.previousLevelBtn, function()
		arg_3_0:emit(CityRebuildGameMediator.CHOOSE_LEVEL, arg_3_0.activityId, arg_3_0.cityRebuildData.curLevel - 1)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.nextLevelBtn, function()
		arg_3_0:emit(CityRebuildGameMediator.CHOOSE_LEVEL, arg_3_0.activityId, arg_3_0.cityRebuildData.curLevel + 1)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.resultBtn, function()
		arg_3_0:emit(CityRebuildGameMediator.RESULT, arg_3_0.activityId)

		return
	end, SFX_CANCEL)
	arg_3_0:BgScroll()
	arg_3_0:Refresh()

	return
end

function var_0_0.InitData(arg_11_0)
	arg_11_0.activityId = ActivityConst.NINJA_CITY_ACT_ID
	arg_11_0.cityRebuildProxy = getProxy(CityRebuildProxy)
	arg_11_0.cityRebuildData = arg_11_0.cityRebuildProxy:GetData(arg_11_0.activityId)

	if arg_11_0.cityRebuildData.startTime == 0 then
		arg_11_0:emit(CityRebuildGameMediator.INIT_TIME, arg_11_0.activityId)
	end

	return
end

function var_0_0.BgScroll(arg_12_0)
	arg_12_0.bg1.localScale = Vector3(0.66 * arg_12_0._tf.rect.height / 1080, 0.66 * arg_12_0._tf.rect.height / 1080, 0)
	arg_12_0.bg2.localScale = Vector3(0.66 * arg_12_0._tf.rect.height / 1080, 0.66 * arg_12_0._tf.rect.height / 1080, 0)
	arg_12_0.bg3.localScale = Vector3(0.66 * arg_12_0._tf.rect.height / 1080, 0.66 * arg_12_0._tf.rect.height / 1080, 0)

	LeanTween.value(go(arg_12_0.bg1), 0, arg_12_0.bg1.rect.width * (0.66 * arg_12_0._tf.rect.height / 1080), 20):setOnUpdate(System.Action_float(function(arg_13_0)
		arg_12_0.bg1.anchoredPosition = Vector2(arg_13_0, 0)

		return
	end)):setEase(LeanTweenType.linear):setLoopClamp()
	LeanTween.value(go(arg_12_0.bg2), 0, arg_12_0.bg2.rect.width * (0.66 * arg_12_0._tf.rect.height / 1080), 14):setOnUpdate(System.Action_float(function(arg_14_0)
		arg_12_0.bg2.anchoredPosition = Vector2(arg_14_0, 0)

		return
	end)):setEase(LeanTweenType.linear):setLoopClamp()
	LeanTween.value(go(arg_12_0.bg3), 0, arg_12_0.bg3.rect.width * (0.66 * arg_12_0._tf.rect.height / 1080), 10):setOnUpdate(System.Action_float(function(arg_15_0)
		arg_12_0.bg3.anchoredPosition = Vector2(arg_15_0, 0)

		return
	end)):setEase(LeanTweenType.linear):setLoopClamp()

	return
end

function var_0_0.Refresh(arg_16_0, arg_16_1)
	arg_16_0.cityRebuildData = arg_16_0.cityRebuildProxy:GetData(arg_16_0.activityId)

	if not arg_16_1 then
		arg_16_0:SetSpine()
	end

	setText(arg_16_0.cityLevel, "LV." .. arg_16_0.cityRebuildData.cityLevel)
	setText(arg_16_0.battleLevel, arg_16_0.cityRebuildData.maxChooseLevel)
	arg_16_0:SetLevelAndAward()
	arg_16_0:SetSummaryPanelAndHp()

	return
end

function var_0_0.SetSpine(arg_17_0)
	arg_17_0:ClearSpine()

	arg_17_0.prefab = pg.activity_ninja_enemy[arg_17_0.cityRebuildData.curLevel].model

	local var_17_0 = arg_17_0.prefab
	local var_17_1 = tonumber(pg.activity_ninja_enemy[arg_17_0.cityRebuildData.curLevel].scale)
	local var_17_2 = Vector3(-var_17_1, var_17_1, 1)
	local var_17_3 = Vector3(0, -328, 0)
	local var_17_4 = Vector3(-600, -328, 0)

	arg_17_0.aliveEnemy = 1

	PoolMgr.GetInstance():GetSpineChar(arg_17_0.prefab, true, function(arg_18_0)
		if var_17_0 ~= arg_17_0.prefab or var_17_0 == arg_17_0.loadedPrefab then
			PoolMgr.GetInstance():ReturnSpineChar(var_17_0, arg_18_0)

			return
		end

		arg_17_0.loadedPrefab = var_17_0
		arg_17_0.model = arg_18_0
		arg_17_0.model.transform.localScale = Vector3.one
		arg_17_0.model.transform.localPosition = Vector3.zero

		arg_17_0.model.transform:SetParent(arg_17_0._ship, false)

		arg_17_0._ship.localScale = var_17_2
		arg_17_0.anim = arg_17_0.model:GetComponent(typeof(SpineAnimUI))

		arg_17_0:WalkSpine(arg_17_0.model, arg_17_0.anim, arg_17_0._ship)

		return
	end)
	PoolMgr.GetInstance():GetSpineChar(arg_17_0.prefab, true, function(arg_19_0)
		if var_17_0 ~= arg_17_0.prefab or var_17_0 == arg_17_0.loadedPrefab2 then
			PoolMgr.GetInstance():ReturnSpineChar(var_17_0, arg_19_0)

			return
		end

		arg_17_0.loadedPrefab2 = var_17_0
		arg_17_0.model2 = arg_19_0
		arg_17_0.model2.transform.localScale = Vector3.one
		arg_17_0.model2.transform.localPosition = Vector3.zero

		arg_17_0.model2.transform:SetParent(arg_17_0._ship2, false)

		arg_17_0._ship2.localScale = var_17_2
		arg_17_0.anim2 = arg_17_0.model2:GetComponent(typeof(SpineAnimUI))

		return
	end)
	setActive(arg_17_0._ship, true)
	setActive(arg_17_0._ship2, false)

	return
end

function var_0_0.WalkSpine(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_1 and arg_20_2 then
		setActive(arg_20_3, true)

		local var_20_0 = Vector3(0, -4, 0)
		local var_20_1 = Vector3(-600, -4, 0)

		arg_20_2:SetAction("move", 0)
		LeanTween.value(arg_20_0._go, 0, 1, 0.5):setOnUpdate(System.Action_float(function(arg_21_0)
			arg_20_3.anchoredPosition3D = Vector3.Lerp(var_20_0, var_20_1, arg_21_0)

			return
		end))
	end

	return
end

function var_0_0.DeadSpine(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_1 and arg_22_2 then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0.deadEffectList) do
			if not isActive(iter_22_1) then
				setActive(arg_22_3, false)
				setActive(iter_22_1, true)
				arg_22_0:StartTimers(function()
					setActive(iter_22_1, false)
					arg_22_0.timerList["effect" .. iter_22_0]:Stop()

					arg_22_0.timerList["effect" .. iter_22_0] = nil

					return
				end, 2, "effect" .. iter_22_0)

				break
			end
		end
	end

	return
end

function var_0_0.ClearSpine(arg_24_0)
	if not IsNil(arg_24_0.model) then
		PoolMgr.GetInstance():ReturnSpineChar(arg_24_0.prefab, arg_24_0.model)

		arg_24_0.loadedPrefab = nil
	end

	if not IsNil(arg_24_0.model2) then
		PoolMgr.GetInstance():ReturnSpineChar(arg_24_0.prefab, arg_24_0.model2)

		arg_24_0.loadedPrefab2 = nil
	end

	return
end

function var_0_0.SetLevelAndAward(arg_25_0)
	local var_25_0 = pg.activity_ninja_enemy[arg_25_0.cityRebuildData.curLevel]

	setText(arg_25_0.currentLevel, arg_25_0.cityRebuildData.curLevel)
	setText(arg_25_0.enemyName, pg.activity_ninja_enemy[arg_25_0.cityRebuildData.curLevel].name)
	arg_25_0.firstAwardList:make(function(arg_26_0, arg_26_1, arg_26_2)
		if arg_26_0 == UIItemList.EventUpdate then
			updateDrop(arg_26_2:Find("mask/item"), {
				type = var_25_0.first_drop_show[arg_26_1 + 1][1],
				id = var_25_0.first_drop_show[arg_26_1 + 1][2],
				count = var_25_0.first_drop_show[arg_26_1 + 1][3]
			})
			onButton(arg_25_0, arg_26_2, function()
				arg_25_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_25_0.firstAwardList:align(#pg.activity_ninja_enemy[arg_25_0.cityRebuildData.curLevel].first_drop_show)
	setActive(arg_25_0.resultBtn:Find("count"), arg_25_0.cityRebuildData.summaryPt > 0)
	setText(arg_25_0.resultBtn:Find("count"), CityRebuildData.PtToShow(arg_25_0.cityRebuildData.summaryPt) .. "+")

	return
end

function var_0_0.SetSummaryPanelAndHp(arg_28_0)
	local var_28_0 = arg_28_0.cityRebuildData.buildings
	local var_28_1 = arg_28_0.cityRebuildData.roles
	local var_28_2 = arg_28_0.cityRebuildData.buffLevels
	local var_28_3 = arg_28_0.cityRebuildData.curLevel
	local var_28_4 = arg_28_0.cityRebuildData.curLevel % 5 == 0
	local var_28_5 = 0
	local var_28_6 = pg.activity_ninja_enemy[arg_28_0.cityRebuildData.curLevel].basic
	local var_28_8

	if arg_28_0.cityRebuildData.curLevel < 51 then
		local var_28_7 = var_28_4 and arg_28_0:GetParam(10) or 1

		var_28_5 = math.ceil(var_28_6 * (var_28_3 - 1 + arg_28_0:GetParam(9)^(var_28_3 - 1)) * var_28_7 * arg_28_0:GetParam(11)^(var_28_2[3] - 1))

		goto label_28_0

		var_28_8 = var_28_4 and arg_28_0:GetParam(10) or 1
	end

	var_28_5 = math.ceil(var_28_6 * (arg_28_0:GetParam(16) + arg_28_0:GetParam(9)^arg_28_0:GetParam(16) * arg_28_0:GetParam(13)^(var_28_3 - (arg_28_0:GetParam(16) + 1))) * var_28_8 * arg_28_0:GetParam(11)^(var_28_2[3] - 1))

	::label_28_0::

	local var_28_9 = math.ceil(arg_28_0:GetParam(14)^var_28_3 * arg_28_0:GetParam(15)^var_28_2[4])
	local var_28_10 = math.ceil((#var_28_0 + var_28_2[10] + (#var_28_0 + var_28_2[10]) * arg_28_0:GetParam(1)^(var_28_2[8] - 1) / arg_28_0:GetParam(2)) * arg_28_0:GetParam(3)^(var_28_2[9] - 1) + arg_28_0:GetParam(4) * var_28_2[7])
	local var_28_11 = math.ceil((#var_28_1 + var_28_2[5]) * arg_28_0:GetParam(5)^(var_28_2[1] - 1) + arg_28_0:GetParam(6) * var_28_2[2])
	local var_28_12 = var_28_10 + var_28_11
	local var_28_13 = math.ceil(var_28_5 / (var_28_10 + var_28_11))

	setText(arg_28_0.summaryPanel:Find("buildingDPS/Text"), var_28_10)
	setText(arg_28_0.summaryPanel:Find("charaDPS/Text"), var_28_11)
	setText(arg_28_0.summaryPanel:Find("DPS/Text"), var_28_12)
	setText(arg_28_0.summaryPanel:Find("time/Text"), var_28_13 .. "s")
	setText(arg_28_0.summaryPanel:Find("pts/Text"), "+" .. string.format("%.2f", var_28_9 / var_28_13) .. "/s")
	setText(arg_28_0.summaryPanel:Find("pt/Text"), (CityRebuildData.PtToShow(arg_28_0.cityRebuildData.pt)))
	setText(arg_28_0.ptAwardCount, CityRebuildData.PtToShow(var_28_9))

	local var_28_14 = var_28_5

	if arg_28_0.cityRebuildData.leftHp ~= 0 then
		var_28_14 = arg_28_0.cityRebuildData.leftHp
	end

	local var_28_15 = math.ceil(var_28_14 / var_28_12)

	setActive(arg_28_0.previousLevelBtn, var_28_3 > 1)

	local var_28_16 = pg.activity_ninja_enemy.all[#pg.activity_ninja_enemy.all] > arg_28_0.cityRebuildData.curLevel

	arg_28_0.canChangeNextLevel = arg_28_0.cityRebuildData.curLevel < arg_28_0.cityRebuildData.maxLevel + 1

	if not arg_28_0.canChangeNextLevel then
		local var_28_17 = pg.TimeMgr.GetInstance()

		arg_28_0.canChangeNextLevel = var_28_15 <= var_28_17:GetServerTime() - arg_28_0.cityRebuildData.startTime
	end

	local var_28_19 = arg_28_0.canChangeNextLevel and var_28_16

	var_28_18(arg_28_0.nextLevelBtn, var_28_19)
	setText(arg_28_0.damageText, "-" .. var_28_12)

	local var_28_20 = #tostring(var_28_12)
	local var_28_21 = 70

	if var_28_20 > 3 then
		var_28_21 = 67 + var_28_20
	end

	arg_28_0.damageText:GetComponent(typeof(Text)).fontSize = var_28_21

	local var_28_22 = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.cityRebuildData.buffs) do
		if not table.contains({}, pg.activity_ninja_buff[iter_28_1].battle_effect) then
			table.insert({}, pg.activity_ninja_buff[iter_28_1].battle_effect)
			table.insert({}, arg_28_0.effect:Find(pg.activity_ninja_buff[iter_28_1].battle_effect))
		end
	end

	arg_28_0.effectWaitingTime = 0
	arg_28_0.effectPlayingTime = 2
	arg_28_0.isPlayingEffect = false

	arg_28_0:RemoveTimer()
	arg_28_0:StartTimer(function()
		local var_29_0 = pg.TimeMgr.GetInstance():GetServerTime() - arg_28_0.cityRebuildData.startTime
		local var_29_1 = 0

		var_29_1 = var_29_0 >= var_28_15 and var_28_5 - (var_29_0 - var_28_15) % var_28_13 * var_28_12 or var_28_14 - var_29_0 * var_28_12

		setSlider(arg_28_0.hpSlider, 0, var_28_5, var_29_1)
		setText(arg_28_0.hp, CityRebuildData.PtToShow(var_29_1) .. "/<color=#b7b7b7>" .. CityRebuildData.PtToShow(var_28_5) .. "</color>")

		if not arg_28_0.canChangeNextLevel then
			arg_28_0.canChangeNextLevel = var_29_0 >= var_28_15

			if arg_28_0.canChangeNextLevel and var_28_16 then
				setActive(arg_28_0.nextLevelBtn, true)
			end
		end

		if var_29_1 == var_28_5 and var_29_0 >= var_28_15 then
			local var_29_2 = arg_28_0.model
			local var_29_3 = arg_28_0.anim
			local var_29_4 = arg_28_0._ship
			local var_29_5 = arg_28_0.model2
			local var_29_6 = arg_28_0.anim2
			local var_29_7 = arg_28_0._ship2

			if arg_28_0.aliveEnemy == 2 then
				var_29_2 = arg_28_0.model2
				var_29_3 = arg_28_0.anim2
				var_29_4 = arg_28_0._ship2
				var_29_5 = arg_28_0.model
				var_29_6 = arg_28_0.anim
				var_29_7 = arg_28_0._ship
			end

			arg_28_0.aliveEnemy = arg_28_0.aliveEnemy == 1 and 2 or 1

			arg_28_0:DeadSpine(var_29_2, var_29_3, var_29_4)
			arg_28_0:WalkSpine(var_29_5, var_29_6, var_29_7)
		end

		if arg_28_0.effectWaitingTime == 0 then
			arg_28_0.isPlayingEffect = true
			arg_28_0.effectWaitingTime = math.random(3)

			for iter_29_0, iter_29_1 in ipairs(var_28_22) do
				setActive(iter_29_1, true)
			end
		end

		if arg_28_0.effectPlayingTime == 0 then
			arg_28_0.isPlayingEffect = false
			arg_28_0.effectPlayingTime = 2

			for iter_29_2, iter_29_3 in ipairs(var_28_22) do
				setActive(iter_29_3, false)
			end
		end

		if arg_28_0.isPlayingEffect then
			arg_28_0.effectPlayingTime = arg_28_0.effectPlayingTime - 1
		else
			arg_28_0.effectWaitingTime = arg_28_0.effectWaitingTime - 1
		end

		arg_28_0.damageAni:Play("Anim_CityRebuildGameUI_damage")

		return
	end)

	return
end

function var_0_0.GetParam(arg_30_0, arg_30_1)
	if pg.gameset["ninja_Param" .. arg_30_1].key_value ~= 0 then
		return pg.gameset["ninja_Param" .. arg_30_1].key_value or tonumber(pg.gameset["ninja_Param" .. arg_30_1].description)
	end
end

function var_0_0.Summary(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = #tostring(arg_31_2)
	local var_31_1 = 1
	local var_31_3

	if var_31_0 < 3 then
		var_31_1 = 1
		var_31_3 = 1
	elseif var_31_0 < 5 then
		var_31_1 = 1
		var_31_3 = 2
	elseif var_31_0 < 7 then
		var_31_1 = 2
		var_31_3 = 3
	elseif var_31_0 < 9 then
		var_31_1 = 2
		var_31_3 = 4
	else
		var_31_1 = 3
		var_31_3 = 5
	end

	setActive(arg_31_0._tf:Find("resultEffect/" .. var_31_1), true)
	arg_31_0:StartTimers(function()
		setActive(arg_31_0._tf:Find("resultEffect/" .. var_31_1), false)
		arg_31_1()

		return
	end, var_31_3, "result")

	return
end

function var_0_0.StartTimer(arg_33_0, arg_33_1)
	arg_33_0.timer = Timer.New(arg_33_1, 1, -1)

	arg_33_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_34_0)
	if arg_34_0.timer then
		arg_34_0.timer:Stop()

		arg_34_0.timer = nil
	end

	return
end

function var_0_0.StartTimers(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	arg_35_0.timerList = arg_35_0.timerList or {}

	local var_35_0 = Timer.New(arg_35_1, arg_35_2, 1)

	var_35_0:Start()

	arg_35_0.timerList[arg_35_3] = var_35_0

	return
end

function var_0_0.RemoveAllTimers(arg_36_0)
	if arg_36_0.timerList then
		for iter_36_0, iter_36_1 in pairs(arg_36_0.timerList) do
			iter_36_1:Stop()
		end

		arg_36_0.timerList = {}
	end

	return
end

function var_0_0.willExit(arg_37_0)
	arg_37_0:ClearSpine()
	arg_37_0:RemoveTimer()
	arg_37_0:RemoveAllTimers()
	LeanTween.cancel(arg_37_0.bg1)
	LeanTween.cancel(arg_37_0.bg2)
	LeanTween.cancel(arg_37_0.bg3)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_37_0._tf)

	return
end

return var_0_0
