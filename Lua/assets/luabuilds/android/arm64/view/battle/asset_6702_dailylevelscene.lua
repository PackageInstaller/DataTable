local DailyLevelScene = class("DailyLevelScene", import("..base.BaseUI"))
local var_0_3 = 101

function DailyLevelScene:getUIName()
	return "DailyLevelUI"
end

function DailyLevelScene:ResUISettings()
	return true
end

function DailyLevelScene:init()
	self.blurPanel = self._tf:Find("blur_panel")
	self.topPanel = self._tf:Find("blur_panel/adapt/top")
	self.backBtn = self.topPanel:Find("back_button")
	self.listPanel = self._tf:Find("list_panel")
	self.content = self.listPanel:Find("list")

	setActive(self.content, true)

	self.dailylevelTpl = self:getTpl("list_panel/list/captertpl")
	self.descPanel = self._tf:Find("desc_panel")
	self.selectedPanel = self.descPanel:Find("selected")
	self.descMain = self.descPanel:Find("main_mask/main")
	self.stageTpl = self:getTpl("scrollview/content/stagetpl", self.descMain)
	self.stageScrollRect = self.descMain:Find("scrollview"):GetComponent(typeof(ScrollRect))
	self.stageContain = self.descMain:Find("scrollview/content")
	self.arrows = self._tf:Find("arrows")
	self.itemTpl = self:getTpl("item_tpl")
	self.selStageTF = self.selectedPanel:Find("stagetpl/info")
	self.selQuicklyTF = self.selStageTF.parent:Find("quickly/bg")
	self.selQuicklyTFSizeDeltaY = self.selQuicklyTF.sizeDelta.y
	self.descChallengeNum = self.descMain:Find("challenge_count")
	self.descChallengeText = self.descChallengeNum:Find("Text")
	self.challengeQuotaDaily = self.descMain:Find("challenge_count/label")
	self.challengeQuotaWeekly = self.descMain:Find("challenge_count/week_label")
	self.fleetEditView = self._tf:Find("fleet_edit")
	self.resource = self._tf:Find("resource")
	self.rightBtn = self._tf:Find("arrows/arrow1")
	self.leftBtn = self._tf:Find("arrows/arrow2")

	self:initItems()

	return
end

function DailyLevelScene.getWeek()
	return (pg.TimeMgr.GetInstance():GetServerWeek())
end

function DailyLevelScene:setDailyCounts(arg_5_1)
	self.dailyCounts = arg_5_1

	return
end

function DailyLevelScene:setActivity(arg_6_1)
	self.bonusActivity = arg_6_1

	return
end

function DailyLevelScene:setShips(arg_7_1)
	self.shipVOs = arg_7_1

	return
end

function DailyLevelScene:updateRes(arg_8_1)
	self.player = arg_8_1

	return
end

function DailyLevelScene:didEnter()
	onButton(self, self._tf:Find("help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_daily_task.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		if self.descMode then
			if LeanTween.isTweening(go(self.stageContain)) or LeanTween.isTweening(go(self.selQuicklyTF)) then
				return
			end

			self:enableDescMode(false)
		else
			self:emit(DailyLevelScene.ON_BACK)
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.leftBtn, function()
		self:flipToSpecificCard(self:getNextCardId(true))

		return
	end)
	onButton(self, self.rightBtn, function()
		self:flipToSpecificCard(self:getNextCardId(false))

		return
	end)
	self:displayDailyLevels()

	if self.contextData.dailyLevelId then
		self:tryOpenDesc(self.contextData.dailyLevelId)
	else
		self:enableDescMode(false)
	end

	self:tryPlayGuide()
	self:ShowGuildTaskTip()

	return
end

function DailyLevelScene:initItems()
	local var_14_0 = getProxy(DailyLevelProxy)

	var_14_0:setDailyTip(false)

	self.dailyCounts = var_14_0:getRawData()
	self.dailyLevelTFs = {}
	self.dailyList = _.reverse(Clone(pg.expedition_daily_template.all))

	for iter_14_0 = #self.dailyList, 1, -1 do
		if pg.expedition_daily_template[self.dailyList[iter_14_0]].limit_period and type(pg.expedition_daily_template[self.dailyList[iter_14_0]].limit_period) == "table" then
			if not pg.TimeMgr.GetInstance():inTime(pg.expedition_daily_template[self.dailyList[iter_14_0]].limit_period) then
				table.remove(self.dailyList, iter_14_0)
			end
		elseif pg.expedition_daily_template[self.dailyList[iter_14_0]].insert_daily == 1 then
			table.remove(self.dailyList, iter_14_0)
		end
	end

	self:sortDailyList()
	self:updateShowCenter()

	if self.contextData.dailyLevelId then
		table.removebyvalue(self.dailyList, self.contextData.dailyLevelId)
		table.insert(self.dailyList, math.ceil(#pg.expedition_daily_template.all / 2), self.contextData.dailyLevelId)
	end

	for iter_14_1, iter_14_2 in pairs(self.dailyList) do
		self.dailyLevelTFs[iter_14_2] = cloneTplTo(self.dailylevelTpl, self.content, iter_14_2)
	end

	return
end

function DailyLevelScene:sortDailyList()
	if #self.dailyList % 2 ~= 1 then
		table.insert(self.dailyList, var_0_3)
	end

	table.sort(self.dailyList, function(arg_16_0, arg_16_1)
		return tonumber(pg.expedition_daily_template[arg_16_0].sort) > tonumber(pg.expedition_daily_template[arg_16_1].sort)
	end)

	return
end

function DailyLevelScene:updateShowCenter()
	local var_17_1
	local var_17_0

	if not self.dailyList or #self.dailyList == 0 then
		do return end

		var_17_0 = math.ceil(#self.dailyList / 2)
	end

	for iter_17_0 = 1, #self.dailyList do
		local var_17_2 = pg.expedition_daily_template[self.dailyList[iter_17_0]]

		if pg.expedition_daily_template[self.dailyList[iter_17_0]].show_with_count and var_17_2.show_with_count == 1 then
			if self.dailyCounts then
				if var_17_2.limit_time - (self.dailyCounts[var_17_2.id] or 0) > 0 then
					var_17_1 = var_17_1 or iter_17_0
				end
			end
		end
	end

	if var_17_1 then
		local var_17_4 = var_17_0 - var_17_1 < 0

		for iter_17_1 = 1, math.abs(var_17_0 - var_17_1) do
			if var_17_4 then
				table.insert(self.dailyList, (table.remove(self.dailyList, 1)))
			else
				table.insert(self.dailyList, 1, (table.remove(self.dailyList, #self.dailyList)))
			end
		end
	end

	return
end

function DailyLevelScene:displayDailyLevels()
	for iter_18_0, iter_18_1 in pairs(self.dailyLevelTFs) do
		self:initDailyLevel(iter_18_0)
	end

	self.content:GetComponent(typeof(EnhancelScrollView)).onCenterClick = function(self)
		self:tryOpenDesc(tonumber(self.name))

		return
	end
	self.centerAniItem = nil
	self.centerCardId = nil
	self.checkAniTimer = Timer.New(function()
		if not self.descMode then
			local var_20_0
			local var_20_1

			for iter_20_0, iter_20_1 in pairs(self.dailyLevelTFs) do
				GetComponent(iter_20_1, typeof(CanvasGroup)).alpha = 1

				if not var_20_0 and not var_20_1 then
					var_20_0 = iter_20_1
					var_20_1 = iter_20_1
				elseif iter_20_1.anchoredPosition.x < var_20_0.anchoredPosition.x then
					var_20_0 = iter_20_1
				elseif iter_20_1.anchoredPosition.x > var_20_1.anchoredPosition.x then
					var_20_1 = iter_20_1
				end
			end

			GetComponent(var_20_0, typeof(CanvasGroup)).alpha = 0.5
			GetComponent(var_20_1, typeof(CanvasGroup)).alpha = 0.5
		end

		for iter_20_2, iter_20_3 in pairs(self.dailyLevelTFs) do
			local var_20_2 = iter_20_3.localScale.x >= 0.98

			if self.centerAniItem == iter_20_3 and var_20_2 then
				return
			else
				if var_20_2 then
					self.centerAniItem = iter_20_3
					self.centerCardId = iter_20_2
				end

				local var_20_3 = iter_20_3:Find("icon/card")

				if var_20_3 then
					local var_20_4 = var_20_3:Find("mask/char"):GetComponent(typeof(Animator))

					setActive(var_20_3:Find("effect"), var_20_2)

					if var_20_4 then
						var_20_4.speed = var_20_2 and 1 or 0
					end
				end
			end
		end

		return
	end, 0.1, -1)

	self.checkAniTimer:Start()

	return
end

function DailyLevelScene:tryOpenDesc(arg_21_1)
	if table.contains(pg.expedition_daily_template[arg_21_1].weekday, tonumber(self:getWeek())) then
		self:openDailyDesc(arg_21_1)
	else
		pg.TipsMgr.GetInstance():ShowTips(pg.expedition_daily_template[arg_21_1].tips)
	end

	return
end

function DailyLevelScene:CanOpenDailyLevel()
	return not not table.contains(pg.expedition_daily_template[self].weekday, tonumber(DailyLevelScene.getWeek())), pg.expedition_daily_template[self].tips
end

function DailyLevelScene:getNextCardId(arg_23_1)
	local var_23_0 = table.indexof(self.dailyList, self.centerCardId)

	if arg_23_1 then
		var_23_0 = var_23_0 - 1

		if var_23_0 <= 0 then
			var_23_0 = #self.dailyList or var_23_0
		end
	else
		var_23_0 = var_23_0 + 1
		var_23_0 = var_23_0 > #self.dailyList and 1 or var_23_0
	end

	return self.dailyList[var_23_0]
end

function DailyLevelScene:initDailyLevel(arg_24_1)
	local var_24_0 = pg.expedition_daily_template[arg_24_1]
	local var_24_1 = self.dailyLevelTFs[arg_24_1]
	local var_24_2 = table.contains(pg.expedition_daily_template[arg_24_1].weekday, tonumber(self:getWeek()))

	if var_24_2 then
		self.index = arg_24_1
	end

	setActive(findTF(var_24_1, "lock"), not var_24_2 and not table.isEmpty(var_24_0.weekday))
	setText(findTF(var_24_1, "name"), var_24_0.title)
	setActive(findTF(var_24_1, "time"), false)

	if self.bonusActivity and not self.bonusActivity:isEnd() then
		local var_24_3 = checkExist(underscore.detect(self.bonusActivity:getConfig("config_data"), function(arg_25_0)
			return arg_25_0[1] == arg_24_1
		end), {
			2
		})

		setText(var_24_1:Find("bonus/Text"), i18n("dailyLevel_bonus_activity"))
		setActive(var_24_1:Find("bonus"), tobool(var_24_3))

		if var_24_3 then
			updateDrop(var_24_1:Find("bonus/IconTpl"), Drop.Create(var_24_3))
		end
	else
		setActive(var_24_1:Find("bonus"), false)
	end

	local var_24_4 = findTF(var_24_1, "icon")

	PoolMgr.GetInstance():GetPrefab("dailyui/" .. var_24_0.pic, "", true, function(arg_26_0)
		arg_26_0 = tf(arg_26_0)

		arg_26_0:SetParent(var_24_4, false)

		arg_26_0.localPosition = Vector3.zero
		arg_26_0.name = "card"

		return
	end)
	setText(findTF(var_24_1, "Text"), "")
	setActive(findTF(var_24_1, "lastTime"), false)

	local var_24_5 = Clone(var_24_0.limit_period)
	local var_24_6

	if var_24_5 and type(var_24_5) == "table" then
		if pg.TimeMgr.GetInstance():inTime(var_24_5) then
			var_24_6 = pg.TimeMgr.GetInstance():Table2ServerTime({
				year = var_24_5[2][1][1],
				month = var_24_5[2][1][2],
				day = var_24_5[2][1][3],
				hour = var_24_5[2][2][1],
				min = var_24_5[2][2][2],
				sec = var_24_5[2][2][3]
			}) - pg.TimeMgr.GetInstance():GetServerTime()
		end
	end

	if var_24_6 then
		local var_24_7 = ""
		local var_24_8 = ""

		if var_24_6 > 0 then
			var_24_7 = math.floor(tonumber(var_24_6) / 0)
			var_24_8 = i18n("word_date")
		elseif var_24_6 >= 3600 then
			var_24_7 = math.floor(tonumber(var_24_6) / 16)
			var_24_8 = i18n("word_hour")
		elseif var_24_6 > 0 then
			var_24_7 = math.floor(tonumber(var_24_6) / 60)
			var_24_8 = i18n("word_minute")
		end

		setText(findTF(var_24_1, "lastTime/content/text"), tostring(var_24_7) .. " ")
		setText(findTF(var_24_1, "lastTime/content/word"), tostring(var_24_8))
		setActive(findTF(var_24_1, "lastTime"), true)
	end

	self:UpdateDailyLevelCnt(arg_24_1)

	return
end

function DailyLevelScene:UpdateDailyLevelCnt(arg_27_1)
	local var_27_0 = pg.expedition_daily_template[arg_27_1]
	local var_27_1 = findTF(self.dailyLevelTFs[arg_27_1], "count")
	local var_27_2 = self.dailyCounts[arg_27_1] or 0

	if var_27_0.limit_time == 0 then
		setText(var_27_1, "N/A")
	else
		setText(var_27_1, string.format("%d/%d", var_27_0.limit_time - var_27_2, var_27_0.limit_time))
	end

	setActive(var_27_1, var_27_0.limit_time > 0)

	return
end

function DailyLevelScene:openDailyDesc(arg_28_1)
	self.curId = arg_28_1

	self:enableDescMode(true)
	self:displayStageList(arg_28_1)

	return
end

function DailyLevelScene:UpdateDailyLevelCntForDescPanel(arg_29_1)
	local var_29_0 = self.dailyCounts[arg_29_1] or 0

	if pg.expedition_daily_template[arg_29_1].limit_time == 0 then
		setText(self.descChallengeText, i18n("challenge_count_unlimit"))
	else
		setText(self.descChallengeText, string.format("%d/%d", pg.expedition_daily_template[arg_29_1].limit_time - var_29_0, pg.expedition_daily_template[arg_29_1].limit_time))
	end

	return
end

function DailyLevelScene:displayStageList(arg_30_1)
	self.dailyLevelId = arg_30_1
	self.contextData.dailyLevelId = self.dailyLevelId

	local var_30_0 = pg.expedition_daily_template[arg_30_1]

	self:UpdateDailyLevelCntForDescPanel(arg_30_1)
	setActive(self.challengeQuotaDaily, var_30_0.limit_type == 1)
	setActive(self.challengeQuotaWeekly, var_30_0.limit_type == 2)
	removeAllChildren(self.stageContain)

	self.stageTFs = {}

	for iter_30_0, iter_30_1 in ipairs((_.sort(var_30_0.expedition_and_lv_limit_list, function(arg_31_0, arg_31_1)
		local var_31_0 = arg_31_0[2] <= self.player.level and 1 or 0
		local var_31_1 = arg_31_1[2] <= self.player.level and 1 or 0

		if arg_31_0[2] == arg_31_1[2] then
			return arg_31_0[1] < arg_31_1[1]
		end

		if var_31_0 == var_31_1 then
			if var_31_0 == 1 then
				return arg_31_0[2] > arg_31_1[2]
			else
				return arg_31_0[2] < arg_31_1[2]
			end
		else
			return var_31_1 < var_31_0
		end

		return
	end))) do
		self.stageTFs[iter_30_1[1]] = cloneTplTo(self.stageTpl, self.stageContain)

		self:updateStage({
			id = iter_30_1[1],
			level = iter_30_1[2]
		})
	end

	return
end

function DailyLevelScene:updateStageTF(arg_32_1, arg_32_2)
	local var_32_0 = pg.expedition_data_template[arg_32_2.id]

	setText(findTF(arg_32_1, "left_panel/name"), pg.expedition_data_template[arg_32_2.id].name)
	setText(findTF(arg_32_1, "left_panel/lv/Text"), "Lv." .. arg_32_2.level)

	local var_32_1 = arg_32_1:Find("mask")

	setActive(var_32_1, arg_32_2.level > self.player.level)

	if arg_32_2.level > self.player.level then
		setText(var_32_1:Find("msg/msg_contain/Text"), "Lv." .. arg_32_2.level .. " ")

		if PLATFORM_CODE == PLATFORM_US then
			var_32_1:Find("msg/msg_contain/Text"):SetAsLastSibling()
		end
	end

	local var_32_2 = UIItemList.New(arg_32_1:Find("scrollView/right_panel"), self.itemTpl)

	var_32_2:make(function(arg_33_0, arg_33_1, arg_33_2)
		if arg_33_0 == UIItemList.EventUpdate then
			updateDrop(arg_33_2, {
				type = var_32_0.award_display[arg_33_1 + 1][1],
				id = var_32_0.award_display[arg_33_1 + 1][2],
				count = var_32_0.award_display[arg_33_1 + 1][3]
			})
			setActive(arg_33_2, arg_33_1 <= 3)
		end

		return
	end)
	var_32_2:align(#var_32_0.award_display)
	setImageSprite(arg_32_1, getImageSprite(findTF(self.resource, "normal_bg")))
	setActive(findTF(arg_32_1, "score"), false)
	onButton(self, var_32_1, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("dailyLevel_unopened"))

		return
	end, SFX_PANEL)

	return
end

function DailyLevelScene:updateStage(arg_35_1)
	local var_35_0 = self.stageTFs[arg_35_1.id]:Find("info")

	self:updateStageTF(var_35_0, arg_35_1)
	onButton(self, var_35_0, function()
		if getProxy(DailyLevelProxy):CanQuickBattle(arg_35_1.id) then
			if (self.dailyCounts[self.dailyLevelId] or 0) >= pg.expedition_daily_template[self.dailyLevelId].limit_time then
				pg.TipsMgr.GetInstance():ShowTips(i18n("dailyLevel_restCount_notEnough"))

				return
			end

			if LeanTween.isTweening(go(self.descMain)) or LeanTween.isTweening(go(self.listPanel)) then
				return
			end

			self:OnSelectStage(arg_35_1)
		else
			self:OnOpenPreCombat(arg_35_1)
		end

		return
	end, SFX_PANEL)

	return
end

function DailyLevelScene:OnOpenPreCombat(arg_37_1)
	if (self.dailyCounts[self.dailyLevelId] or 0) >= pg.expedition_daily_template[self.dailyLevelId].limit_time then
		pg.TipsMgr.GetInstance():ShowTips(i18n("dailyLevel_restCount_notEnough"))

		return
	end

	setActive(self.blurPanel, false)
	self:emit(DailyLevelMediator.ON_STAGE, arg_37_1)

	return
end

function DailyLevelScene:OnSelectStage(arg_38_1)
	onButton(self, self.selectedPanel:Find("stagetpl/info"), function()
		self:EnableOrDisable(arg_38_1, false)

		return
	end, SFX_PANEL)
	onButton(self, self.selectedPanel, function()
		self:EnableOrDisable(arg_38_1, false)

		return
	end, SFX_PANEL)
	self:EnableOrDisable(arg_38_1, true)

	return
end

function DailyLevelScene:EnableOrDisable(arg_41_1, arg_41_2)
	local var_41_0 = self.stageTFs[arg_41_1.id]:Find("quickly")

	if LeanTween.isTweening(go(self.stageContain)) or LeanTween.isTweening(go(self.selQuicklyTF)) then
		return
	end

	if arg_41_2 then
		self:updateStageTF(self.selStageTF, arg_41_1)
		self:UpdateBattleBtn(arg_41_1)
		self:DoSelectedAnimation(var_41_0, -1 * self.stageContain:GetComponent(typeof(VerticalLayoutGroup)).padding.top - self.stageContain.parent:InverseTransformPoint(var_41_0.parent.position).y, function()
			self.selectedStage = arg_41_1

			return
		end)
	else
		self:DoUnselectAnimtion(var_41_0, function()
			self.selectedStage = nil

			return
		end)
	end

	return
end

function DailyLevelScene:DoSelectedAnimation(arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = math.abs(arg_44_2) / 2000

	seriesAsync({
		function(arg_45_0)
			self.stageScrollRect.enabled = false

			pg.UIMgr.GetInstance():BlurPanel(self.selectedPanel)

			arg_44_1.sizeDelta = Vector2(arg_44_1.sizeDelta.x, 0)

			setActive(arg_44_1, true)

			local var_45_0 = self.stageContain.anchoredPosition

			self.stageContainLposY = self.stageContain.anchoredPosition.y
			self.offsetY = arg_44_2

			LeanTween.value(go(self.stageContain), self.stageContain.anchoredPosition.y, self.stageContain.anchoredPosition.y + arg_44_2, var_44_0):setOnUpdate(System.Action_float(function(arg_46_0)
				self.stageContain.anchoredPosition = Vector3(var_45_0.x, arg_46_0, 0)

				local var_46_0 = self.selectedPanel:InverseTransformPoint(arg_44_1.parent.position)

				self.selStageTF.parent.localPosition = Vector3(var_46_0.x, var_46_0.y, 0)
				self.selQuicklyTF.sizeDelta = Vector2(self.selQuicklyTF.sizeDelta.x, 0)

				setActive(self.selectedPanel, true)

				return
			end)):setEase(LeanTweenType.easeInOutCirc):setOnComplete(System.Action(arg_45_0))

			return
		end,
		function(arg_47_0)
			local var_47_0 = arg_44_1:GetComponent(typeof(LayoutElement))

			LeanTween.value(go(self.selQuicklyTF), 0, self.selQuicklyTFSizeDeltaY, 0.1):setOnUpdate(System.Action_float(function(arg_48_0)
				var_47_0.preferredHeight = arg_48_0
				self.selQuicklyTF.sizeDelta = Vector2(self.selQuicklyTF.sizeDelta.x, arg_48_0)

				return
			end)):setEase(LeanTweenType.easeInOutCirc):setOnComplete(System.Action(arg_47_0))

			return
		end
	}, arg_44_3)

	return
end

function DailyLevelScene:DoUnselectAnimtion(arg_49_1, arg_49_2)
	local var_49_0 = self.stageContain.anchoredPosition

	seriesAsync({
		function(arg_50_0)
			pg.UIMgr.GetInstance():UnOverlayPanel(self.selectedPanel, self._tf)
			setActive(self.selectedPanel, false)

			local var_50_0 = arg_49_1:GetComponent(typeof(LayoutElement))

			LeanTween.value(go(self.selQuicklyTF), self.selQuicklyTFSizeDeltaY, 0, 0.1):setOnUpdate(System.Action_float(function(arg_51_0)
				var_50_0.preferredHeight = arg_51_0
				self.selQuicklyTF.sizeDelta = Vector2(self.selQuicklyTF.sizeDelta.x, arg_51_0)

				return
			end)):setEase(LeanTweenType.easeInOutCirc):setOnComplete(System.Action(arg_50_0))

			return
		end,
		function(arg_52_0)
			LeanTween.value(go(self.stageContain), var_49_0.y, var_49_0.y - self.offsetY, 0.15):setOnUpdate(System.Action_float(function(arg_53_0)
				self.stageContain.anchoredPosition = Vector3(var_49_0.x, arg_53_0, 0)

				return
			end)):setDelay(0.1):setEase(LeanTweenType.easeInOutCirc):setOnComplete(System.Action(arg_52_0))

			return
		end
	}, function()
		self.stageScrollRect.enabled = true

		arg_49_2()

		return
	end)

	return
end

function DailyLevelScene:UpdateBattleBtn(arg_55_1)
	local var_55_0 = self.selectedPanel:Find("stagetpl/info").parent:Find("quickly/bg")
	local var_55_1 = pg.expedition_daily_template[self.dailyLevelId].limit_time - (self.dailyCounts[self.dailyLevelId] or 0)
	local var_55_2 = var_55_0:Find("challenge")

	onButton(self, var_55_2, function()
		self:OnOpenPreCombat(arg_55_1)

		return
	end, SFX_PANEL)
	setText(var_55_2:Find("Text"), i18n("daily_level_quick_battle_label2"))

	local var_55_3 = var_55_0:Find("mult")

	onButton(self, var_55_3, function()
		self:OnQuickBattle(arg_55_1, var_55_1)

		return
	end, SFX_PANEL)

	local var_55_4 = var_55_0:Find("once")

	onButton(self, var_55_4, function()
		self:OnQuickBattle(arg_55_1, 1)

		return
	end, SFX_PANEL)
	setText(var_55_3:Find("label"), i18n("daily_level_quick_battle_label1", "   ", COLOR_WHITE))
	setText(var_55_3:Find("Text"), "<color=" .. COLOR_GREEN .. ">" .. math.max(1, var_55_1) .. "</color>")
	setText(var_55_4:Find("label"), i18n("daily_level_quick_battle_label3"))
	setText(var_55_4:Find("Text"), "")

	if var_55_1 == 0 then
		self:EnableOrDisable(arg_55_1, false)
	end

	return
end

function DailyLevelScene:OnQuickBattle(arg_59_1, arg_59_2)
	if arg_59_2 <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("dailyLevel_restCount_notEnough"))

		return
	end

	if PlayerPrefs.GetInt("daily_level_quick_battle_tip", 0) == 0 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("dailyLevel_quickfinish"),
			onYes = function()
				self:emit(DailyLevelMediator.ON_QUICK_BATTLE, self.dailyLevelId, arg_59_1.id, arg_59_2)

				return
			end
		})
		PlayerPrefs.SetInt("daily_level_quick_battle_tip", 1)
		PlayerPrefs.Save()
	else
		self:emit(DailyLevelMediator.ON_QUICK_BATTLE, self.dailyLevelId, arg_59_1.id, arg_59_2)
	end

	return
end

function DailyLevelScene:enableDescMode(arg_61_1, arg_61_2)
	self.descMode = arg_61_1

	setActive(self._tf:Find("help_btn"), not arg_61_1)

	local function var_61_0(arg_62_0, arg_62_1, arg_62_2)
		if LeanTween.isTweening(go(arg_62_0)) then
			LeanTween.cancel(go(arg_62_0))
		end

		LeanTween.moveX(rtf(arg_62_0), arg_62_1, 0.3):setEase(LeanTweenType.linear):setOnComplete(System.Action(function()
			if arg_62_2 then
				arg_62_2()
			end

			return
		end))

		return
	end

	local function var_61_1()
		for iter_64_0, iter_64_1 in pairs(self.dailyLevelTFs) do
			setButtonEnabled(iter_64_1, not arg_61_1)

			if iter_64_0 ~= self.curId then
				if LeanTween.isTweening(go(iter_64_1)) then
					LeanTween.cancel(go(iter_64_1))
				end

				local var_64_0 = GetComponent(iter_64_1, typeof(CanvasGroup))

				if arg_61_1 then
					LeanTween.value(go(iter_64_1), 1, 0, 0.3):setOnUpdate(System.Action_float(function(arg_65_0)
						var_64_0.alpha = arg_65_0

						return
					end))
				else
					LeanTween.value(go(iter_64_1), 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_66_0)
						var_64_0.alpha = arg_66_0

						return
					end))
				end
			end
		end

		return
	end

	local function var_61_2()
		setActive(self.listPanel, true)
		setActive(self.content, true)
		setActive(self.descPanel, arg_61_1)
		setActive(self.arrows, not arg_61_1)

		return
	end

	if arg_61_1 then
		var_61_2()
		var_61_1()
		var_61_0(self.listPanel, -622, function()
			var_61_0(self.descMain, 0, arg_61_2)

			return
		end)
	else
		if self.selectedStage then
			self:EnableOrDisable(self.selectedStage, false)
		end

		var_61_2()
		var_61_1()
		var_61_0(self.listPanel, 0)
		var_61_0(self.descMain, -1342, arg_61_2)
	end

	return
end

function DailyLevelScene:flipToSpecificCard(arg_69_1)
	local var_69_0 = self.content:GetComponent(typeof(EnhancelScrollView))

	for iter_69_0, iter_69_1 in pairs(self.dailyLevelTFs) do
		if arg_69_1 == iter_69_0 then
			var_69_0:SetHorizontalTargetItemIndex(iter_69_1:GetComponent(typeof(EnhanceItem)).scrollViewItemIndex)
		end
	end

	return
end

function DailyLevelScene:tryPlayGuide()
	pg.SystemGuideMgr.GetInstance():PlayDailyLevel(function()
		triggerButton(self._tf:Find("help_btn"))

		return
	end)

	return
end

function DailyLevelScene:ShowGuildTaskTip()
	pg.GuildMsgBoxMgr.GetInstance():NotificationForDailyBattle()

	return
end

function DailyLevelScene:clearTween()
	if self.tweens then
		cancelTweens(self.tweens)
	end

	local function var_73_0(arg_74_0)
		if LeanTween.isTweening(go(arg_74_0)) then
			LeanTween.cancel(go(arg_74_0))
		end

		return
	end

	for iter_73_0, iter_73_1 in pairs(self.dailyLevelTFs) do
		var_73_0(iter_73_1)
	end

	var_73_0(self.listPanel)
	var_73_0(self.descMain)

	return
end

function DailyLevelScene:onBackPressed()
	if self.descMode then
		if LeanTween.isTweening(go(self.stageContain)) or LeanTween.isTweening(go(self.selQuicklyTF)) then
			return
		end

		self:enableDescMode(false)

		return
	end

	DailyLevelScene.super.onBackPressed(self)

	return
end

function DailyLevelScene:willExit()
	if self.selectedStage then
		pg.UIMgr.GetInstance():UnOverlayPanel(self.selectedPanel, self._tf)
	end

	self:clearTween()

	if self.checkAniTimer then
		self.checkAniTimer:Stop()

		self.checkAniTimer = nil
	end

	return
end

return DailyLevelScene
