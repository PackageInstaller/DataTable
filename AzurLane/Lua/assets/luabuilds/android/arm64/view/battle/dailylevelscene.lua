local var_0_0 = class("DailyLevelScene", import("..base.BaseUI"))
local var_0_3 = 101

function var_0_0.getUIName(arg_1_0)
	return "DailyLevelUI"
end

function var_0_0.ResUISettings(arg_2_0)
	return true
end

function var_0_0.init(arg_3_0)
	arg_3_0.blurPanel = arg_3_0._tf:Find("blur_panel")
	arg_3_0.topPanel = arg_3_0._tf:Find("blur_panel/adapt/top")
	arg_3_0.backBtn = arg_3_0.topPanel:Find("back_button")
	arg_3_0.listPanel = arg_3_0._tf:Find("list_panel")
	arg_3_0.content = arg_3_0.listPanel:Find("list")

	setActive(arg_3_0.content, true)

	arg_3_0.dailylevelTpl = arg_3_0:getTpl("list_panel/list/captertpl")
	arg_3_0.descPanel = arg_3_0._tf:Find("desc_panel")
	arg_3_0.selectedPanel = arg_3_0.descPanel:Find("selected")
	arg_3_0.descMain = arg_3_0.descPanel:Find("main_mask/main")
	arg_3_0.stageTpl = arg_3_0:getTpl("scrollview/content/stagetpl", arg_3_0.descMain)
	arg_3_0.stageScrollRect = arg_3_0.descMain:Find("scrollview"):GetComponent(typeof(ScrollRect))
	arg_3_0.stageContain = arg_3_0.descMain:Find("scrollview/content")
	arg_3_0.arrows = arg_3_0._tf:Find("arrows")
	arg_3_0.itemTpl = arg_3_0:getTpl("item_tpl")
	arg_3_0.selStageTF = arg_3_0.selectedPanel:Find("stagetpl/info")
	arg_3_0.selQuicklyTF = arg_3_0.selStageTF.parent:Find("quickly/bg")
	arg_3_0.selQuicklyTFSizeDeltaY = arg_3_0.selQuicklyTF.sizeDelta.y
	arg_3_0.descChallengeNum = arg_3_0.descMain:Find("challenge_count")
	arg_3_0.descChallengeText = arg_3_0.descChallengeNum:Find("Text")
	arg_3_0.challengeQuotaDaily = arg_3_0.descMain:Find("challenge_count/label")
	arg_3_0.challengeQuotaWeekly = arg_3_0.descMain:Find("challenge_count/week_label")
	arg_3_0.fleetEditView = arg_3_0._tf:Find("fleet_edit")
	arg_3_0.resource = arg_3_0._tf:Find("resource")
	arg_3_0.rightBtn = arg_3_0._tf:Find("arrows/arrow1")
	arg_3_0.leftBtn = arg_3_0._tf:Find("arrows/arrow2")

	arg_3_0:initItems()

	return
end

function var_0_0.getWeek()
	return (pg.TimeMgr.GetInstance():GetServerWeek())
end

function var_0_0.setDailyCounts(arg_5_0, arg_5_1)
	arg_5_0.dailyCounts = arg_5_1

	return
end

function var_0_0.setActivity(arg_6_0, arg_6_1)
	arg_6_0.bonusActivity = arg_6_1

	return
end

function var_0_0.setShips(arg_7_0, arg_7_1)
	arg_7_0.shipVOs = arg_7_1

	return
end

function var_0_0.updateRes(arg_8_0, arg_8_1)
	arg_8_0.player = arg_8_1

	return
end

function var_0_0.didEnter(arg_9_0)
	onButton(arg_9_0, arg_9_0._tf:Find("help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_daily_task.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.backBtn, function()
		if arg_9_0.descMode then
			if LeanTween.isTweening(go(arg_9_0.stageContain)) or LeanTween.isTweening(go(arg_9_0.selQuicklyTF)) then
				return
			end

			arg_9_0:enableDescMode(false)
		else
			arg_9_0:emit(var_0_0.ON_BACK)
		end

		return
	end, SFX_CANCEL)
	onButton(arg_9_0, arg_9_0.leftBtn, function()
		arg_9_0:flipToSpecificCard(arg_9_0:getNextCardId(true))

		return
	end)
	onButton(arg_9_0, arg_9_0.rightBtn, function()
		arg_9_0:flipToSpecificCard(arg_9_0:getNextCardId(false))

		return
	end)
	arg_9_0:displayDailyLevels()

	if arg_9_0.contextData.dailyLevelId then
		arg_9_0:tryOpenDesc(arg_9_0.contextData.dailyLevelId)
	else
		arg_9_0:enableDescMode(false)
	end

	arg_9_0:tryPlayGuide()
	arg_9_0:ShowGuildTaskTip()

	return
end

function var_0_0.initItems(arg_14_0)
	local var_14_0 = getProxy(DailyLevelProxy)

	var_14_0:setDailyTip(false)

	arg_14_0.dailyCounts = var_14_0:getRawData()
	arg_14_0.dailyLevelTFs = {}
	arg_14_0.dailyList = _.reverse(Clone(pg.expedition_daily_template.all))

	for iter_14_0 = #arg_14_0.dailyList, 1, -1 do
		if pg.expedition_daily_template[arg_14_0.dailyList[iter_14_0]].limit_period and type(pg.expedition_daily_template[arg_14_0.dailyList[iter_14_0]].limit_period) == "table" then
			local var_14_1 = pg.TimeMgr.GetInstance()

			if not var_14_1:inTime(pg.expedition_daily_template[arg_14_0.dailyList[iter_14_0]].limit_period) then
				table.remove(arg_14_0.dailyList, iter_14_0)
			end
		elseif pg.expedition_daily_template[arg_14_0.dailyList[iter_14_0]].insert_daily == 1 then
			table.remove(arg_14_0.dailyList, iter_14_0)
		end
	end

	arg_14_0:sortDailyList()
	arg_14_0:updateShowCenter()

	if arg_14_0.contextData.dailyLevelId then
		table.removebyvalue(arg_14_0.dailyList, arg_14_0.contextData.dailyLevelId)
		table.insert(arg_14_0.dailyList, math.ceil(#pg.expedition_daily_template.all / 2), arg_14_0.contextData.dailyLevelId)
	end

	for iter_14_1, iter_14_2 in pairs(arg_14_0.dailyList) do
		arg_14_0.dailyLevelTFs[iter_14_2] = cloneTplTo(arg_14_0.dailylevelTpl, arg_14_0.content, iter_14_2)
	end

	return
end

function var_0_0.sortDailyList(arg_15_0)
	if #arg_15_0.dailyList % 2 ~= 1 then
		table.insert(arg_15_0.dailyList, var_0_3)
	end

	table.sort(arg_15_0.dailyList, function(arg_16_0, arg_16_1)
		return tonumber(pg.expedition_daily_template[arg_16_0].sort) > tonumber(pg.expedition_daily_template[arg_16_1].sort)
	end)

	return
end

function var_0_0.updateShowCenter(arg_17_0)
	local var_17_0, var_17_1

	if not arg_17_0.dailyList or #arg_17_0.dailyList == 0 then
		do return end

		var_17_0 = math.ceil(#arg_17_0.dailyList / 2)
		var_17_1 = nil
	end

	for iter_17_0 = 1, #arg_17_0.dailyList do
		local var_17_2 = pg.expedition_daily_template[arg_17_0.dailyList[iter_17_0]]

		if pg.expedition_daily_template[arg_17_0.dailyList[iter_17_0]].show_with_count and var_17_2.show_with_count == 1 then
			if arg_17_0.dailyCounts then
				local var_17_3 = arg_17_0.dailyCounts[var_17_2.id] or 0

				if var_17_2.limit_time - var_17_3 > 0 then
					var_17_1 = var_17_1 or iter_17_0
				end
			end
		end
	end

	if var_17_1 then
		local var_17_4 = var_17_0 - var_17_1 < 0

		for iter_17_1 = 1, math.abs(var_17_0 - var_17_1) do
			if var_17_4 then
				table.insert(arg_17_0.dailyList, (table.remove(arg_17_0.dailyList, 1)))
			else
				table.insert(arg_17_0.dailyList, 1, (table.remove(arg_17_0.dailyList, #arg_17_0.dailyList)))
			end
		end
	end

	return
end

function var_0_0.displayDailyLevels(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.dailyLevelTFs) do
		arg_18_0:initDailyLevel(iter_18_0)
	end

	arg_18_0.content:GetComponent(typeof(EnhancelScrollView)).onCenterClick = function(arg_19_0)
		arg_18_0:tryOpenDesc(tonumber(arg_19_0.name))

		return
	end
	arg_18_0.centerAniItem = nil
	arg_18_0.centerCardId = nil
	arg_18_0.checkAniTimer = Timer.New(function()
		if not arg_18_0.descMode then
			local var_20_0
			local var_20_1

			for iter_20_0, iter_20_1 in pairs(arg_18_0.dailyLevelTFs) do
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

		for iter_20_2, iter_20_3 in pairs(arg_18_0.dailyLevelTFs) do
			local var_20_2 = iter_20_3.localScale.x >= 0.98

			if arg_18_0.centerAniItem == iter_20_3 and var_20_2 then
				return
			else
				if var_20_2 then
					arg_18_0.centerAniItem = iter_20_3
					arg_18_0.centerCardId = iter_20_2
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

	arg_18_0.checkAniTimer:Start()

	return
end

function var_0_0.tryOpenDesc(arg_21_0, arg_21_1)
	if table.contains(pg.expedition_daily_template[arg_21_1].weekday, tonumber(arg_21_0:getWeek())) then
		arg_21_0:openDailyDesc(arg_21_1)
	else
		pg.TipsMgr.GetInstance():ShowTips(pg.expedition_daily_template[arg_21_1].tips)
	end

	return
end

function var_0_0.CanOpenDailyLevel(arg_22_0)
	local var_22_0 = false

	if table.contains(pg.expedition_daily_template[arg_22_0].weekday, tonumber(var_0_0.getWeek())) then
		var_22_0 = true
	end

	return var_22_0, pg.expedition_daily_template[arg_22_0].tips
end

function var_0_0.getNextCardId(arg_23_0, arg_23_1)
	local var_23_0 = table.indexof(arg_23_0.dailyList, arg_23_0.centerCardId)

	if arg_23_1 then
		var_23_0 = var_23_0 - 1

		if var_23_0 <= 0 then
			var_23_0 = #arg_23_0.dailyList or var_23_0
		end
	else
		var_23_0 = var_23_0 + 1
		var_23_0 = var_23_0 > #arg_23_0.dailyList and 1 or var_23_0
	end

	return arg_23_0.dailyList[var_23_0]
end

function var_0_0.initDailyLevel(arg_24_0, arg_24_1)
	local var_24_0 = pg.expedition_daily_template[arg_24_1]
	local var_24_1 = arg_24_0.dailyLevelTFs[arg_24_1]
	local var_24_2 = table.contains(pg.expedition_daily_template[arg_24_1].weekday, tonumber(arg_24_0:getWeek()))

	if var_24_2 then
		arg_24_0.index = arg_24_1
	end

	setActive(findTF(var_24_1, "lock"), not var_24_2 and not table.isEmpty(var_24_0.weekday))
	setText(findTF(var_24_1, "name"), var_24_0.title)
	setActive(findTF(var_24_1, "time"), false)

	if arg_24_0.bonusActivity and not arg_24_0.bonusActivity:isEnd() then
		local var_24_3 = checkExist(underscore.detect(arg_24_0.bonusActivity:getConfig("config_data"), function(arg_25_0)
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

	arg_24_0:UpdateDailyLevelCnt(arg_24_1)

	return
end

function var_0_0.UpdateDailyLevelCnt(arg_27_0, arg_27_1)
	local var_27_0 = pg.expedition_daily_template[arg_27_1]
	local var_27_1 = findTF(arg_27_0.dailyLevelTFs[arg_27_1], "count")

	if var_27_0.limit_time == 0 then
		setText(var_27_1, "N/A")
	else
		setText(var_27_1, string.format("%d/%d", var_27_0.limit_time - var_27_2, var_27_0.limit_time))
	end

	setActive(var_27_1, var_27_0.limit_time > 0)

	return
end

function var_0_0.openDailyDesc(arg_28_0, arg_28_1)
	arg_28_0.curId = arg_28_1

	arg_28_0:enableDescMode(true)
	arg_28_0:displayStageList(arg_28_1)

	return
end

function var_0_0.UpdateDailyLevelCntForDescPanel(arg_29_0, arg_29_1)
	if pg.expedition_daily_template[arg_29_1].limit_time == 0 then
		setText(arg_29_0.descChallengeText, i18n("challenge_count_unlimit"))
	else
		setText(arg_29_0.descChallengeText, string.format("%d/%d", pg.expedition_daily_template[arg_29_1].limit_time - var_29_0, pg.expedition_daily_template[arg_29_1].limit_time))
	end

	return
end

function var_0_0.displayStageList(arg_30_0, arg_30_1)
	arg_30_0.dailyLevelId = arg_30_1
	arg_30_0.contextData.dailyLevelId = arg_30_0.dailyLevelId

	local var_30_0 = pg.expedition_daily_template[arg_30_1]

	arg_30_0:UpdateDailyLevelCntForDescPanel(arg_30_1)
	setActive(arg_30_0.challengeQuotaDaily, var_30_0.limit_type == 1)
	setActive(arg_30_0.challengeQuotaWeekly, var_30_0.limit_type == 2)
	removeAllChildren(arg_30_0.stageContain)

	arg_30_0.stageTFs = {}

	for iter_30_0, iter_30_1 in ipairs((_.sort(var_30_0.expedition_and_lv_limit_list, function(arg_31_0, arg_31_1)
		local var_31_0 = arg_31_0[2] <= arg_30_0.player.level and 1 or 0
		local var_31_1 = arg_31_1[2] <= arg_30_0.player.level and 1 or 0

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
		arg_30_0.stageTFs[iter_30_1[1]] = cloneTplTo(arg_30_0.stageTpl, arg_30_0.stageContain)

		arg_30_0:updateStage({
			id = iter_30_1[1],
			level = iter_30_1[2]
		})
	end

	return
end

function var_0_0.updateStageTF(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = pg.expedition_data_template[arg_32_2.id]

	setText(findTF(arg_32_1, "left_panel/name"), pg.expedition_data_template[arg_32_2.id].name)
	setText(findTF(arg_32_1, "left_panel/lv/Text"), "Lv." .. arg_32_2.level)

	local var_32_1 = arg_32_1:Find("mask")

	setActive(var_32_1, arg_32_2.level > arg_32_0.player.level)

	if arg_32_2.level > arg_32_0.player.level then
		setText(var_32_1:Find("msg/msg_contain/Text"), "Lv." .. arg_32_2.level .. " ")

		if PLATFORM_CODE == PLATFORM_US then
			var_32_1:Find("msg/msg_contain/Text"):SetAsLastSibling()
		end
	end

	local var_32_2 = UIItemList.New(arg_32_1:Find("scrollView/right_panel"), arg_32_0.itemTpl)

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
	setImageSprite(arg_32_1, getImageSprite(findTF(arg_32_0.resource, "normal_bg")))
	setActive(findTF(arg_32_1, "score"), false)
	onButton(arg_32_0, var_32_1, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("dailyLevel_unopened"))

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateStage(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0.stageTFs[arg_35_1.id]:Find("info")

	arg_35_0:updateStageTF(var_35_0, arg_35_1)
	onButton(arg_35_0, var_35_0, function()
		if getProxy(DailyLevelProxy):CanQuickBattle(arg_35_1.id) then
			local var_36_0 = arg_35_0.dailyCounts[arg_35_0.dailyLevelId] or 0

			if var_36_0 >= pg.expedition_daily_template[arg_35_0.dailyLevelId].limit_time then
				pg.TipsMgr.GetInstance():ShowTips(i18n("dailyLevel_restCount_notEnough"))

				return
			end

			if LeanTween.isTweening(go(arg_35_0.descMain)) or LeanTween.isTweening(go(arg_35_0.listPanel)) then
				return
			end

			arg_35_0:OnSelectStage(arg_35_1)
		else
			arg_35_0:OnOpenPreCombat(arg_35_1)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnOpenPreCombat(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.dailyCounts[arg_37_0.dailyLevelId] or 0

	if var_37_0 >= pg.expedition_daily_template[arg_37_0.dailyLevelId].limit_time then
		pg.TipsMgr.GetInstance():ShowTips(i18n("dailyLevel_restCount_notEnough"))

		return
	end

	setActive(arg_37_0.blurPanel, false)
	arg_37_0:emit(DailyLevelMediator.ON_STAGE, arg_37_1)

	return
end

function var_0_0.OnSelectStage(arg_38_0, arg_38_1)
	onButton(arg_38_0, arg_38_0.selectedPanel:Find("stagetpl/info"), function()
		arg_38_0:EnableOrDisable(arg_38_1, false)

		return
	end, SFX_PANEL)
	onButton(arg_38_0, arg_38_0.selectedPanel, function()
		arg_38_0:EnableOrDisable(arg_38_1, false)

		return
	end, SFX_PANEL)
	arg_38_0:EnableOrDisable(arg_38_1, true)

	return
end

function var_0_0.EnableOrDisable(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_0.stageTFs[arg_41_1.id]:Find("quickly")

	if LeanTween.isTweening(go(arg_41_0.stageContain)) or LeanTween.isTweening(go(arg_41_0.selQuicklyTF)) then
		return
	end

	local var_41_1 = -1 * arg_41_0.stageContain:GetComponent(typeof(VerticalLayoutGroup)).padding.top - arg_41_0.stageContain.parent:InverseTransformPoint(var_41_0.parent.position).y

	if arg_41_2 then
		arg_41_0:updateStageTF(arg_41_0.selStageTF, arg_41_1)
		arg_41_0:UpdateBattleBtn(arg_41_1)
		arg_41_0:DoSelectedAnimation(var_41_0, var_41_1, function()
			arg_41_0.selectedStage = arg_41_1

			return
		end)
	else
		arg_41_0:DoUnselectAnimtion(var_41_0, function()
			arg_41_0.selectedStage = nil

			return
		end)
	end

	return
end

function var_0_0.DoSelectedAnimation(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = math.abs(arg_44_2) / 2000

	seriesAsync({
		function(arg_45_0)
			arg_44_0.stageScrollRect.enabled = false

			pg.UIMgr.GetInstance():BlurPanel(arg_44_0.selectedPanel)

			arg_44_1.sizeDelta = Vector2(arg_44_1.sizeDelta.x, 0)

			setActive(arg_44_1, true)

			local var_45_0 = arg_44_0.stageContain.anchoredPosition

			arg_44_0.stageContainLposY = arg_44_0.stageContain.anchoredPosition.y
			arg_44_0.offsetY = arg_44_2

			LeanTween.value(go(arg_44_0.stageContain), arg_44_0.stageContain.anchoredPosition.y, arg_44_0.stageContain.anchoredPosition.y + arg_44_2, var_44_0):setOnUpdate(System.Action_float(function(arg_46_0)
				arg_44_0.stageContain.anchoredPosition = Vector3(var_45_0.x, arg_46_0, 0)

				local var_46_0 = arg_44_0.selectedPanel:InverseTransformPoint(arg_44_1.parent.position)

				arg_44_0.selStageTF.parent.localPosition = Vector3(var_46_0.x, var_46_0.y, 0)
				arg_44_0.selQuicklyTF.sizeDelta = Vector2(arg_44_0.selQuicklyTF.sizeDelta.x, 0)

				setActive(arg_44_0.selectedPanel, true)

				return
			end)):setEase(LeanTweenType.easeInOutCirc):setOnComplete(System.Action(arg_45_0))

			return
		end,
		function(arg_47_0)
			local var_47_0 = arg_44_1:GetComponent(typeof(LayoutElement))

			LeanTween.value(go(arg_44_0.selQuicklyTF), 0, arg_44_0.selQuicklyTFSizeDeltaY, 0.1):setOnUpdate(System.Action_float(function(arg_48_0)
				var_47_0.preferredHeight = arg_48_0
				arg_44_0.selQuicklyTF.sizeDelta = Vector2(arg_44_0.selQuicklyTF.sizeDelta.x, arg_48_0)

				return
			end)):setEase(LeanTweenType.easeInOutCirc):setOnComplete(System.Action(arg_47_0))

			return
		end
	}, arg_44_3)

	return
end

function var_0_0.DoUnselectAnimtion(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = arg_49_0.stageContain.anchoredPosition

	seriesAsync({
		function(arg_50_0)
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_49_0.selectedPanel, arg_49_0._tf)
			setActive(arg_49_0.selectedPanel, false)

			local var_50_0 = arg_49_1:GetComponent(typeof(LayoutElement))

			LeanTween.value(go(arg_49_0.selQuicklyTF), arg_49_0.selQuicklyTFSizeDeltaY, 0, 0.1):setOnUpdate(System.Action_float(function(arg_51_0)
				var_50_0.preferredHeight = arg_51_0
				arg_49_0.selQuicklyTF.sizeDelta = Vector2(arg_49_0.selQuicklyTF.sizeDelta.x, arg_51_0)

				return
			end)):setEase(LeanTweenType.easeInOutCirc):setOnComplete(System.Action(arg_50_0))

			return
		end,
		function(arg_52_0)
			LeanTween.value(go(arg_49_0.stageContain), var_49_0.y, var_49_0.y - arg_49_0.offsetY, 0.15):setOnUpdate(System.Action_float(function(arg_53_0)
				arg_49_0.stageContain.anchoredPosition = Vector3(var_49_0.x, arg_53_0, 0)

				return
			end)):setDelay(0.1):setEase(LeanTweenType.easeInOutCirc):setOnComplete(System.Action(arg_52_0))

			return
		end
	}, function()
		arg_49_0.stageScrollRect.enabled = true

		arg_49_2()

		return
	end)

	return
end

function var_0_0.UpdateBattleBtn(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0.selectedPanel:Find("stagetpl/info").parent:Find("quickly/bg")
	local var_55_1 = arg_55_0.dailyCounts[arg_55_0.dailyLevelId] or 0
	local var_55_2 = pg.expedition_daily_template[arg_55_0.dailyLevelId].limit_time - var_55_1
	local var_55_3 = var_55_0:Find("challenge")

	onButton(arg_55_0, var_55_3, function()
		arg_55_0:OnOpenPreCombat(arg_55_1)

		return
	end, SFX_PANEL)
	setText(var_55_3:Find("Text"), i18n("daily_level_quick_battle_label2"))

	local var_55_4 = var_55_0:Find("mult")

	onButton(arg_55_0, var_55_4, function()
		arg_55_0:OnQuickBattle(arg_55_1, var_55_2)

		return
	end, SFX_PANEL)

	local var_55_5 = var_55_0:Find("once")

	onButton(arg_55_0, var_55_5, function()
		arg_55_0:OnQuickBattle(arg_55_1, 1)

		return
	end, SFX_PANEL)
	setText(var_55_4:Find("label"), i18n("daily_level_quick_battle_label1", "   ", COLOR_WHITE))
	setText(var_55_4:Find("Text"), "<color=" .. COLOR_GREEN .. ">" .. math.max(1, var_55_2) .. "</color>")
	setText(var_55_5:Find("label"), i18n("daily_level_quick_battle_label3"))
	setText(var_55_5:Find("Text"), "")

	if var_55_2 == 0 then
		arg_55_0:EnableOrDisable(arg_55_1, false)
	end

	return
end

function var_0_0.OnQuickBattle(arg_59_0, arg_59_1, arg_59_2)
	if arg_59_2 <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("dailyLevel_restCount_notEnough"))

		return
	end

	if PlayerPrefs.GetInt("daily_level_quick_battle_tip", 0) == 0 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("dailyLevel_quickfinish"),
			onYes = function()
				arg_59_0:emit(DailyLevelMediator.ON_QUICK_BATTLE, arg_59_0.dailyLevelId, arg_59_1.id, arg_59_2)

				return
			end
		})
		PlayerPrefs.SetInt("daily_level_quick_battle_tip", 1)
		PlayerPrefs.Save()
	else
		arg_59_0:emit(DailyLevelMediator.ON_QUICK_BATTLE, arg_59_0.dailyLevelId, arg_59_1.id, arg_59_2)
	end

	return
end

function var_0_0.enableDescMode(arg_61_0, arg_61_1, arg_61_2)
	arg_61_0.descMode = arg_61_1

	setActive(arg_61_0._tf:Find("help_btn"), not arg_61_1)

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

	if arg_61_1 then
		(function()
			setActive(arg_61_0.listPanel, true)
			setActive(arg_61_0.content, true)
			setActive(arg_61_0.descPanel, arg_61_1)
			setActive(arg_61_0.arrows, not arg_61_1)

			return
		end)()
		;(function()
			for iter_64_0, iter_64_1 in pairs(arg_61_0.dailyLevelTFs) do
				setButtonEnabled(iter_64_1, not arg_61_1)

				if iter_64_0 ~= arg_61_0.curId then
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
		end)()
		;(function(arg_62_0, arg_62_1, arg_62_2)
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
		end)(arg_61_0.listPanel, -622, function()
			var_61_0(arg_61_0.descMain, 0, arg_61_2)

			return
		end)
	else
		if arg_61_0.selectedStage then
			arg_61_0:EnableOrDisable(arg_61_0.selectedStage, false)
		end

		;(function()
			setActive(arg_61_0.listPanel, true)
			setActive(arg_61_0.content, true)
			setActive(arg_61_0.descPanel, arg_61_1)
			setActive(arg_61_0.arrows, not arg_61_1)

			return
		end)()
		;(function()
			for iter_64_0, iter_64_1 in pairs(arg_61_0.dailyLevelTFs) do
				setButtonEnabled(iter_64_1, not arg_61_1)

				if iter_64_0 ~= arg_61_0.curId then
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
		end)()
		;(function(arg_62_0, arg_62_1, arg_62_2)
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
		end)(arg_61_0.listPanel, 0)
		;(function(arg_62_0, arg_62_1, arg_62_2)
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
		end)(arg_61_0.descMain, -1342, arg_61_2)
	end

	return
end

function var_0_0.flipToSpecificCard(arg_69_0, arg_69_1)
	local var_69_0 = arg_69_0.content:GetComponent(typeof(EnhancelScrollView))

	for iter_69_0, iter_69_1 in pairs(arg_69_0.dailyLevelTFs) do
		if arg_69_1 == iter_69_0 then
			var_69_0:SetHorizontalTargetItemIndex(iter_69_1:GetComponent(typeof(EnhanceItem)).scrollViewItemIndex)
		end
	end

	return
end

function var_0_0.tryPlayGuide(arg_70_0)
	pg.SystemGuideMgr.GetInstance():PlayDailyLevel(function()
		triggerButton(arg_70_0._tf:Find("help_btn"))

		return
	end)

	return
end

function var_0_0.ShowGuildTaskTip(arg_72_0)
	pg.GuildMsgBoxMgr.GetInstance():NotificationForDailyBattle()

	return
end

function var_0_0.clearTween(arg_73_0)
	if arg_73_0.tweens then
		cancelTweens(arg_73_0.tweens)
	end

	for iter_73_0, iter_73_1 in pairs(arg_73_0.dailyLevelTFs) do
		var_73_0(iter_73_1)
	end

	var_73_0(arg_73_0.listPanel)
	var_73_0(arg_73_0.descMain)

	return
end

function var_0_0.onBackPressed(arg_75_0)
	if arg_75_0.descMode then
		if LeanTween.isTweening(go(arg_75_0.stageContain)) or LeanTween.isTweening(go(arg_75_0.selQuicklyTF)) then
			return
		end

		arg_75_0:enableDescMode(false)

		return
	end

	var_0_0.super.onBackPressed(arg_75_0)

	return
end

function var_0_0.willExit(arg_76_0)
	if arg_76_0.selectedStage then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_76_0.selectedPanel, arg_76_0._tf)
	end

	arg_76_0:clearTween()

	if arg_76_0.checkAniTimer then
		arg_76_0.checkAniTimer:Stop()

		arg_76_0.checkAniTimer = nil
	end

	return
end

return var_0_0
