local CityRebuildGameLayer = class("CityRebuildGameLayer", import("view.base.BaseUI"))

function CityRebuildGameLayer:getUIName()
	return "CityRebuildGameUI"
end

function CityRebuildGameLayer:init()
	self.bg1 = self._tf:Find("bgs/bg1")
	self.bg2 = self._tf:Find("bgs/bg2")
	self.bg3 = self._tf:Find("bgs/bg3")
	self._ship = self._tf:Find("ship")
	self._ship2 = self._tf:Find("ship2")
	self.effect = self._tf:Find("effect")
	self.ui = self._tf:Find("ui")
	self.backBtn = self.ui:Find("top/backBtn")
	self.homeBtn = self.ui:Find("top/homeBtn")
	self.hpSlider = self.ui:Find("top/hpSlider")
	self.hp = self.ui:Find("top/hp")
	self.firstAwardList = UIItemList.New(self.ui:Find("top/awardPanel/first/items"), self.ui:Find("top/awardPanel/first/items/item"))
	self.ptAwardCount = self.ui:Find("top/awardPanel/others/count")
	self.cityLevel = self.ui:Find("left/cityLevel/Text")
	self.battleLevel = self.ui:Find("left/battleLevel/Text")
	self.summaryPanel = self.ui:Find("left/panel")
	self.currentLevel = self.ui:Find("top/currentLevel/Text")
	self.enemyName = self.ui:Find("top/enemyName")
	self.resultBtn = self.ui:Find("right/resultBtn")
	self.bookBtn = self.ui:Find("right/bookBtn")
	self.taskBtn = self.ui:Find("right/taskBtn")
	self.previousLevelBtn = self.ui:Find("right/previousLevelBtn")
	self.nextLevelBtn = self.ui:Find("right/nextLevelBtn")
	self.damageAni = self._tf:Find("damage"):GetComponent(typeof(Animation))
	self.damageText = self._tf:Find("damage/Text")
	self.effect = self._tf:Find("effect")
	self.deadEffectList = {
		self.effect:Find("xinnianyouxi_baozha"),
		self.effect:Find("xinnianyouxi_baozha2"),
		self.effect:Find("xinnianyouxi_baozha3")
	}

	setText(self.ui:Find("left/cityLevel/title"), i18n("ninja_game_citylevel"))
	setText(self.ui:Find("left/battleLevel/title"), i18n("ninja_game_wave"))
	setText(self.summaryPanel:Find("buildingDPS"), i18n("ninja_game_citydmg"))
	setText(self.summaryPanel:Find("charaDPS"), i18n("ninja_game_allydmg"))
	setText(self.summaryPanel:Find("DPS"), i18n("ninja_game_dps"))
	setText(self.summaryPanel:Find("time"), i18n("ninja_game_time"))
	setText(self.summaryPanel:Find("pts"), i18n("ninja_game_income"))
	setText(self.summaryPanel:Find("pt"), i18n("ninja_game_ptcount"))
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function CityRebuildGameLayer:didEnter()
	self:InitData()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.homeBtn, function()
		self:emit(CityRebuildGameLayer.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(self, self.bookBtn, function()
		self:emit(CityRebuildGameMediator.OPEN_BOOK)

		return
	end, SFX_CANCEL)
	onButton(self, self.taskBtn, function()
		self:emit(CityRebuildGameMediator.OPEN_TASKS)

		return
	end, SFX_CANCEL)
	onButton(self, self.previousLevelBtn, function()
		self:emit(CityRebuildGameMediator.CHOOSE_LEVEL, self.activityId, self.cityRebuildData.curLevel - 1)

		return
	end, SFX_CANCEL)
	onButton(self, self.nextLevelBtn, function()
		self:emit(CityRebuildGameMediator.CHOOSE_LEVEL, self.activityId, self.cityRebuildData.curLevel + 1)

		return
	end, SFX_CANCEL)
	onButton(self, self.resultBtn, function()
		self:emit(CityRebuildGameMediator.RESULT, self.activityId)

		return
	end, SFX_CANCEL)
	self:BgScroll()
	self:Refresh()

	return
end

function CityRebuildGameLayer:InitData()
	self.activityId = ActivityConst.NINJA_CITY_ACT_ID
	self.cityRebuildProxy = getProxy(CityRebuildProxy)
	self.cityRebuildData = self.cityRebuildProxy:GetData(self.activityId)

	if self.cityRebuildData.startTime == 0 then
		self:emit(CityRebuildGameMediator.INIT_TIME, self.activityId)
	end

	return
end

function CityRebuildGameLayer:BgScroll()
	self.bg1.localScale = Vector3(0.66 * self._tf.rect.height / 1080, 0.66 * self._tf.rect.height / 1080, 0)
	self.bg2.localScale = Vector3(0.66 * self._tf.rect.height / 1080, 0.66 * self._tf.rect.height / 1080, 0)
	self.bg3.localScale = Vector3(0.66 * self._tf.rect.height / 1080, 0.66 * self._tf.rect.height / 1080, 0)

	LeanTween.value(go(self.bg1), 0, self.bg1.rect.width * (0.66 * self._tf.rect.height / 1080), 20):setOnUpdate(System.Action_float(function(arg_13_0)
		self.bg1.anchoredPosition = Vector2(arg_13_0, 0)

		return
	end)):setEase(LeanTweenType.linear):setLoopClamp()
	LeanTween.value(go(self.bg2), 0, self.bg2.rect.width * (0.66 * self._tf.rect.height / 1080), 14):setOnUpdate(System.Action_float(function(arg_14_0)
		self.bg2.anchoredPosition = Vector2(arg_14_0, 0)

		return
	end)):setEase(LeanTweenType.linear):setLoopClamp()
	LeanTween.value(go(self.bg3), 0, self.bg3.rect.width * (0.66 * self._tf.rect.height / 1080), 10):setOnUpdate(System.Action_float(function(arg_15_0)
		self.bg3.anchoredPosition = Vector2(arg_15_0, 0)

		return
	end)):setEase(LeanTweenType.linear):setLoopClamp()

	return
end

function CityRebuildGameLayer:Refresh(arg_16_1)
	self.cityRebuildData = self.cityRebuildProxy:GetData(self.activityId)

	if not arg_16_1 then
		self:SetSpine()
	end

	setText(self.cityLevel, "LV." .. self.cityRebuildData.cityLevel)
	setText(self.battleLevel, self.cityRebuildData.maxChooseLevel)
	self:SetLevelAndAward()
	self:SetSummaryPanelAndHp()

	return
end

function CityRebuildGameLayer:SetSpine()
	self:ClearSpine()

	self.prefab = pg.activity_ninja_enemy[self.cityRebuildData.curLevel].model

	local var_17_0 = self.prefab
	local var_17_1 = tonumber(pg.activity_ninja_enemy[self.cityRebuildData.curLevel].scale)
	local var_17_2 = Vector3(-var_17_1, var_17_1, 1)
	local var_17_3 = Vector3(0, -328, 0)
	local var_17_4 = Vector3(-600, -328, 0)

	self.aliveEnemy = 1

	PoolMgr.GetInstance():GetSpineChar(self.prefab, true, function(arg_18_0)
		if var_17_0 ~= self.prefab or var_17_0 == self.loadedPrefab then
			PoolMgr.GetInstance():ReturnSpineChar(var_17_0, arg_18_0)

			return
		end

		self.loadedPrefab = var_17_0
		self.model = arg_18_0
		self.model.transform.localScale = Vector3.one
		self.model.transform.localPosition = Vector3.zero

		self.model.transform:SetParent(self._ship, false)

		self._ship.localScale = var_17_2
		self.anim = self.model:GetComponent(typeof(SpineAnimUI))

		self:WalkSpine(self.model, self.anim, self._ship)

		return
	end)
	PoolMgr.GetInstance():GetSpineChar(self.prefab, true, function(arg_19_0)
		if var_17_0 ~= self.prefab or var_17_0 == self.loadedPrefab2 then
			PoolMgr.GetInstance():ReturnSpineChar(var_17_0, arg_19_0)

			return
		end

		self.loadedPrefab2 = var_17_0
		self.model2 = arg_19_0
		self.model2.transform.localScale = Vector3.one
		self.model2.transform.localPosition = Vector3.zero

		self.model2.transform:SetParent(self._ship2, false)

		self._ship2.localScale = var_17_2
		self.anim2 = self.model2:GetComponent(typeof(SpineAnimUI))

		return
	end)
	setActive(self._ship, true)
	setActive(self._ship2, false)

	return
end

function CityRebuildGameLayer:WalkSpine(arg_20_1, arg_20_2, arg_20_3)
	if arg_20_1 and arg_20_2 then
		setActive(arg_20_3, true)

		local var_20_0 = Vector3(0, -4, 0)
		local var_20_1 = Vector3(-600, -4, 0)

		arg_20_2:SetAction("move", 0)
		LeanTween.value(self._go, 0, 1, 0.5):setOnUpdate(System.Action_float(function(arg_21_0)
			arg_20_3.anchoredPosition3D = Vector3.Lerp(var_20_0, var_20_1, arg_21_0)

			return
		end))
	end

	return
end

function CityRebuildGameLayer:DeadSpine(arg_22_1, arg_22_2, arg_22_3)
	if arg_22_1 and arg_22_2 then
		for iter_22_0, iter_22_1 in ipairs(self.deadEffectList) do
			if not isActive(iter_22_1) then
				setActive(arg_22_3, false)
				setActive(iter_22_1, true)
				self:StartTimers(function()
					setActive(iter_22_1, false)
					self.timerList["effect" .. iter_22_0]:Stop()

					self.timerList["effect" .. iter_22_0] = nil

					return
				end, 2, "effect" .. iter_22_0)

				break
			end
		end
	end

	return
end

function CityRebuildGameLayer:ClearSpine()
	if not IsNil(self.model) then
		PoolMgr.GetInstance():ReturnSpineChar(self.prefab, self.model)

		self.loadedPrefab = nil
	end

	if not IsNil(self.model2) then
		PoolMgr.GetInstance():ReturnSpineChar(self.prefab, self.model2)

		self.loadedPrefab2 = nil
	end

	return
end

function CityRebuildGameLayer:SetLevelAndAward()
	local var_25_0 = pg.activity_ninja_enemy[self.cityRebuildData.curLevel]

	setText(self.currentLevel, self.cityRebuildData.curLevel)
	setText(self.enemyName, pg.activity_ninja_enemy[self.cityRebuildData.curLevel].name)
	self.firstAwardList:make(function(arg_26_0, arg_26_1, arg_26_2)
		if arg_26_0 == UIItemList.EventUpdate then
			local var_26_0 = {
				type = var_25_0.first_drop_show[arg_26_1 + 1][1],
				id = var_25_0.first_drop_show[arg_26_1 + 1][2],
				count = var_25_0.first_drop_show[arg_26_1 + 1][3]
			}

			updateDrop(arg_26_2:Find("mask/item"), var_26_0)
			onButton(self, arg_26_2, function()
				self:emit(BaseUI.ON_DROP, var_26_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.firstAwardList:align(#pg.activity_ninja_enemy[self.cityRebuildData.curLevel].first_drop_show)
	setActive(self.resultBtn:Find("count"), self.cityRebuildData.summaryPt > 0)
	setText(self.resultBtn:Find("count"), CityRebuildData.PtToShow(self.cityRebuildData.summaryPt) .. "+")

	return
end

function CityRebuildGameLayer:SetSummaryPanelAndHp()
	local var_28_0 = self.cityRebuildData.buildings
	local var_28_1 = self.cityRebuildData.roles
	local var_28_2 = self.cityRebuildData.buffLevels
	local var_28_3 = self.cityRebuildData.curLevel
	local var_28_4 = self.cityRebuildData.curLevel % 5 == 0
	local var_28_5 = 0
	local var_28_6 = pg.activity_ninja_enemy[self.cityRebuildData.curLevel].basic

	var_28_5 = self.cityRebuildData.curLevel < 51 and math.ceil(var_28_6 * (var_28_3 - 1 + self:GetParam(9)^(var_28_3 - 1)) * (var_28_4 and self:GetParam(10) or 1) * self:GetParam(11)^(var_28_2[3] - 1)) or math.ceil(var_28_6 * (self:GetParam(16) + self:GetParam(9)^self:GetParam(16) * self:GetParam(13)^(var_28_3 - (self:GetParam(16) + 1))) * (var_28_4 and self:GetParam(10) or 1) * self:GetParam(11)^(var_28_2[3] - 1))

	local var_28_7 = math.ceil(self:GetParam(14)^var_28_3 * self:GetParam(15)^var_28_2[4])
	local var_28_8 = math.ceil((#var_28_0 + var_28_2[10] + (#var_28_0 + var_28_2[10]) * self:GetParam(1)^(var_28_2[8] - 1) / self:GetParam(2)) * self:GetParam(3)^(var_28_2[9] - 1) + self:GetParam(4) * var_28_2[7])
	local var_28_9 = math.ceil((#var_28_1 + var_28_2[5]) * self:GetParam(5)^(var_28_2[1] - 1) + self:GetParam(6) * var_28_2[2])
	local var_28_10 = var_28_8 + var_28_9
	local var_28_11 = math.ceil(var_28_5 / (var_28_8 + var_28_9))

	setText(self.summaryPanel:Find("buildingDPS/Text"), var_28_8)
	setText(self.summaryPanel:Find("charaDPS/Text"), var_28_9)
	setText(self.summaryPanel:Find("DPS/Text"), var_28_10)
	setText(self.summaryPanel:Find("time/Text"), var_28_11 .. "s")
	setText(self.summaryPanel:Find("pts/Text"), "+" .. string.format("%.2f", var_28_7 / var_28_11) .. "/s")
	setText(self.summaryPanel:Find("pt/Text"), (CityRebuildData.PtToShow(self.cityRebuildData.pt)))
	setText(self.ptAwardCount, CityRebuildData.PtToShow(var_28_7))

	local var_28_12 = var_28_5

	if self.cityRebuildData.leftHp ~= 0 then
		var_28_12 = self.cityRebuildData.leftHp
	end

	local var_28_13 = math.ceil(var_28_12 / var_28_10)

	setActive(self.previousLevelBtn, var_28_3 > 1)

	local var_28_14 = pg.activity_ninja_enemy.all[#pg.activity_ninja_enemy.all] > self.cityRebuildData.curLevel

	self.canChangeNextLevel = self.cityRebuildData.curLevel < self.cityRebuildData.maxLevel + 1 or var_28_13 <= pg.TimeMgr.GetInstance():GetServerTime() - self.cityRebuildData.startTime

	setActive(self.nextLevelBtn, self.canChangeNextLevel and var_28_14)
	setText(self.damageText, "-" .. var_28_10)

	local var_28_15 = #tostring(var_28_10)

	if var_28_15 > 3 then
		self.damageText:GetComponent(typeof(Text)).fontSize = 67 + var_28_15
	end

	local var_28_17 = {}
	local var_28_18 = {}

	for iter_28_0, iter_28_1 in ipairs(self.cityRebuildData.buffs) do
		if not table.contains(var_28_17, pg.activity_ninja_buff[iter_28_1].battle_effect) then
			table.insert(var_28_17, pg.activity_ninja_buff[iter_28_1].battle_effect)
			table.insert(var_28_18, self.effect:Find(pg.activity_ninja_buff[iter_28_1].battle_effect))
		end
	end

	self.effectWaitingTime = 0
	self.effectPlayingTime = 2
	self.isPlayingEffect = false

	self:RemoveTimer()
	self:StartTimer(function()
		local var_29_0 = pg.TimeMgr.GetInstance():GetServerTime() - self.cityRebuildData.startTime
		local var_29_1 = 0

		var_29_1 = var_29_0 >= var_28_13 and var_28_5 - (var_29_0 - var_28_13) % var_28_11 * var_28_10 or var_28_12 - var_29_0 * var_28_10

		setSlider(self.hpSlider, 0, var_28_5, var_29_1)
		setText(self.hp, CityRebuildData.PtToShow(var_29_1) .. "/<color=#b7b7b7>" .. CityRebuildData.PtToShow(var_28_5) .. "</color>")

		if not self.canChangeNextLevel then
			self.canChangeNextLevel = var_29_0 >= var_28_13

			if self.canChangeNextLevel and var_28_14 then
				setActive(self.nextLevelBtn, true)
			end
		end

		if var_29_1 == var_28_5 and var_29_0 >= var_28_13 then
			local var_29_2 = self.model
			local var_29_3 = self.anim
			local var_29_4 = self._ship
			local var_29_5 = self.model2
			local var_29_6 = self.anim2
			local var_29_7 = self._ship2

			if self.aliveEnemy == 2 then
				var_29_2 = self.model2
				var_29_3 = self.anim2
				var_29_4 = self._ship2
				var_29_5 = self.model
				var_29_6 = self.anim
				var_29_7 = self._ship
			end

			self.aliveEnemy = self.aliveEnemy == 1 and 2 or 1

			self:DeadSpine(var_29_2, var_29_3, var_29_4)
			self:WalkSpine(var_29_5, var_29_6, var_29_7)
		end

		if self.effectWaitingTime == 0 then
			self.isPlayingEffect = true
			self.effectWaitingTime = math.random(3)

			for iter_29_0, iter_29_1 in ipairs(var_28_18) do
				setActive(iter_29_1, true)
			end
		end

		if self.effectPlayingTime == 0 then
			self.isPlayingEffect = false
			self.effectPlayingTime = 2

			for iter_29_2, iter_29_3 in ipairs(var_28_18) do
				setActive(iter_29_3, false)
			end
		end

		if self.isPlayingEffect then
			self.effectPlayingTime = self.effectPlayingTime - 1
		else
			self.effectWaitingTime = self.effectWaitingTime - 1
		end

		self.damageAni:Play("Anim_CityRebuildGameUI_damage")

		return
	end)

	return
end

function CityRebuildGameLayer:GetParam(arg_30_1)
	return (pg.gameset["ninja_Param" .. arg_30_1].key_value ~= 0 or nil) and (pg.gameset["ninja_Param" .. arg_30_1].key_value or tonumber(pg.gameset["ninja_Param" .. arg_30_1].description))
end

function CityRebuildGameLayer:Summary(arg_31_1, arg_31_2)
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

	setActive(self._tf:Find("resultEffect/" .. var_31_1), true)
	self:StartTimers(function()
		setActive(self._tf:Find("resultEffect/" .. var_31_1), false)
		arg_31_1()

		return
	end, var_31_3, "result")

	return
end

function CityRebuildGameLayer:StartTimer(arg_33_1)
	self.timer = Timer.New(arg_33_1, 1, -1)

	self.timer:Start()

	return
end

function CityRebuildGameLayer:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function CityRebuildGameLayer:StartTimers(arg_35_1, arg_35_2, arg_35_3)
	self.timerList = self.timerList or {}

	local var_35_0 = Timer.New(arg_35_1, arg_35_2, 1)

	var_35_0:Start()

	self.timerList[arg_35_3] = var_35_0

	return
end

function CityRebuildGameLayer:RemoveAllTimers()
	if self.timerList then
		for iter_36_0, iter_36_1 in pairs(self.timerList) do
			iter_36_1:Stop()
		end

		self.timerList = {}
	end

	return
end

function CityRebuildGameLayer:willExit()
	self:ClearSpine()
	self:RemoveTimer()
	self:RemoveAllTimers()
	LeanTween.cancel(self.bg1)
	LeanTween.cancel(self.bg2)
	LeanTween.cancel(self.bg3)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return CityRebuildGameLayer
