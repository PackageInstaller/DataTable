class = var_0_10000

local var_0_0 = "DailyLevelScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))
local var_0_2 = 3
local var_0_3 = 4
local var_0_4 = 101

function var_0_1.getUIName(arg_1_0)
	return "DailyLevelUI"
end

function var_0_1.ResUISettings(arg_2_0)
	return true
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.blurPanel = var_1.Find(var_3_0, "blur_panel")

	local var_3_1 = arg_3_0._tf

	arg_3_0.topPanel = var_1.Find(var_3_1, "blur_panel/adapt/top")

	local var_3_2 = arg_3_0.topPanel

	arg_3_0.backBtn = var_1.Find(var_3_2, "back_button")

	local var_3_3 = arg_3_0._tf

	arg_3_0.listPanel = var_1.Find(var_3_3, "list_panel")

	local var_3_4 = arg_3_0.listPanel

	arg_3_0.content = var_1.Find(var_3_4, "list")
	setActive = var_1

	var_1(arg_3_0.content, true)

	arg_3_0.dailylevelTpl = arg_3_0:getTpl("list_panel/list/captertpl")

	local var_3_5 = arg_3_0._tf

	arg_3_0.descPanel = var_1.Find(var_3_5, "desc_panel")

	local var_3_6 = arg_3_0.descPanel

	arg_3_0.selectedPanel = var_1.Find(var_3_6, "selected")

	local var_3_7 = arg_3_0.descPanel

	arg_3_0.descMain = var_1.Find(var_3_7, "main_mask/main")
	arg_3_0.stageTpl = arg_3_0:getTpl("scrollview/content/stagetpl", arg_3_0.descMain)

	local var_3_8 = arg_3_0.descMain
	local var_3_9 = var_1.Find(var_3_8, "scrollview")
	local var_3_10 = var_1.GetComponent

	typeof = var_3
	ScrollRect = var_4
	arg_3_0.stageScrollRect = var_3_10(var_3_9, var_3(var_4))

	local var_3_11 = arg_3_0.descMain

	arg_3_0.stageContain = var_1.Find(var_3_11, "scrollview/content")

	local var_3_12 = arg_3_0._tf

	arg_3_0.arrows = var_1.Find(var_3_12, "arrows")
	arg_3_0.itemTpl = arg_3_0:getTpl("item_tpl")

	local var_3_13 = arg_3_0.selectedPanel

	arg_3_0.selStageTF = var_1.Find(var_3_13, "stagetpl/info")

	local var_3_14 = arg_3_0.selStageTF.parent

	arg_3_0.selQuicklyTF = var_1.Find(var_3_14, "quickly/bg")
	arg_3_0.selQuicklyTFSizeDeltaY = arg_3_0.selQuicklyTF.sizeDelta.y

	local var_3_15 = arg_3_0.descMain

	arg_3_0.descChallengeNum = var_1.Find(var_3_15, "challenge_count")

	local var_3_16 = arg_3_0.descChallengeNum

	arg_3_0.descChallengeText = var_1.Find(var_3_16, "Text")

	local var_3_17 = arg_3_0.descMain

	arg_3_0.challengeQuotaDaily = var_1.Find(var_3_17, "challenge_count/label")

	local var_3_18 = arg_3_0.descMain

	arg_3_0.challengeQuotaWeekly = var_1.Find(var_3_18, "challenge_count/week_label")

	local var_3_19 = arg_3_0._tf

	arg_3_0.fleetEditView = var_1.Find(var_3_19, "fleet_edit")

	local var_3_20 = arg_3_0._tf

	arg_3_0.resource = var_1.Find(var_3_20, "resource")

	local var_3_21 = arg_3_0._tf

	arg_3_0.rightBtn = var_1.Find(var_3_21, "arrows/arrow1")

	local var_3_22 = arg_3_0._tf

	arg_3_0.leftBtn = var_1.Find(var_3_22, "arrows/arrow2")

	arg_3_0:initItems()

	return
end

function var_0_1.getWeek()
	pg = var_1_10000

	local var_4_0 = var_1_10000.TimeMgr.GetInstance()

	return (var_0.GetServerWeek(var_4_0))
end

function var_0_1.setDailyCounts(arg_5_0, arg_5_1)
	arg_5_0.dailyCounts = arg_5_1

	return
end

function var_0_1.setActivity(arg_6_0, arg_6_1)
	arg_6_0.bonusActivity = arg_6_1

	return
end

function var_0_1.setShips(arg_7_0, arg_7_1)
	arg_7_0.shipVOs = arg_7_1

	return
end

function var_0_1.updateRes(arg_8_0, arg_8_1)
	arg_8_0.player = arg_8_1

	return
end

function var_0_1.didEnter(arg_9_0)
	onButton = var_1_10001

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0._tf
	local var_9_2 = var_3.Find(var_9_1, "help_btn")

	local function var_9_3()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_10_2.type = var_2_10003
		pg = var_2_10003
		var_10_2.helps = var_2_10003.gametip.help_daily_task.tip

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_9_0, var_9_2, var_9_3, var_5)

	onButton = var_1_10001

	local var_9_4 = arg_9_0
	local var_9_5 = arg_9_0.backBtn

	local function var_9_6()
		if arg_9_0.descMode then
			LeanTween = var_0

			local var_11_0 = var_0.isTweening

			go = var_2_10001

			if not var_11_0(var_2_10001(arg_9_0.stageContain)) then
				LeanTween = var_0

				local var_11_1 = var_0.isTweening

				go = var_1

				if var_11_1(var_1(arg_9_0.selQuicklyTF)) then
					return
				end

				local var_11_2 = arg_9_0

				var_0.enableDescMode(var_11_2, false)

				if false then
					local var_11_3 = arg_9_0

					var_0.emit(var_11_3, var_0_1.ON_BACK)
				end

				return
			end
		end
	end

	SFX_CANCEL = var_5

	var_1_10001(var_9_4, var_9_5, var_9_6, var_5)

	onButton = var_1_10001

	var_1_10001(arg_9_0, arg_9_0.leftBtn, function()
		local var_12_0 = arg_9_0
		local var_12_1 = var_0.flipToSpecificCard
		local var_12_2 = arg_9_0

		var_12_1(var_12_0, var_2.getNextCardId(var_12_2, true))

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_9_0, arg_9_0.rightBtn, function()
		local var_13_0 = arg_9_0
		local var_13_1 = var_0.flipToSpecificCard
		local var_13_2 = arg_9_0

		var_13_1(var_13_0, var_2.getNextCardId(var_13_2, false))

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

function var_0_1.initItems(arg_14_0)
	getProxy = var_1_10001
	DailyLevelProxy = var_1_10002

	local var_14_0 = var_1_10001(var_1_10002)

	var_1.setDailyTip(var_14_0, false)

	arg_14_0.dailyCounts = var_1:getRawData()
	pg = var_2

	local var_14_1 = var_2.expedition_daily_template

	arg_14_0.dailyLevelTFs = {}
	_ = var_3

	local var_14_2 = var_3.reverse

	Clone = var_4
	arg_14_0.dailyList = var_14_2(var_4(var_14_1.all))

	for iter_14_0 = #arg_14_0.dailyList, 1, -1 do
		local var_14_3 = var_14_1[arg_14_0.dailyList[iter_14_0]].limit_period
		local var_14_4 = var_14_1[arg_14_0.dailyList[iter_14_0]].insert_daily

		if var_14_3 then
			type = var_1_10009

			if var_1_10009(var_14_3) == "table" then
				pg = var_1_10009

				local var_14_5 = var_1_10009.TimeMgr.GetInstance()

				if not var_1_10009.inTime(var_14_5, var_14_3) then
					table = var_14_5

					var_14_5.remove(arg_14_0.dailyList, iter_14_0)
				end

				goto label_14_0
			end
		end

		if var_14_4 == 1 then
			table = var_1_10009

			var_1_10009.remove(arg_14_0.dailyList, iter_14_0)
		end

		::label_14_0::
	end

	arg_14_0:sortDailyList()

	local var_14_6 = arg_14_0

	arg_14_0.updateShowCenter(var_14_6)

	local var_14_7

	if arg_14_0.contextData.dailyLevelId then
		var_14_7 = arg_14_0.contextData.dailyLevelId
		table = var_14_6

		var_14_6.removebyvalue(arg_14_0.dailyList, var_14_7)

		table = var_4

		local var_14_8 = var_4.insert
		local var_14_9 = arg_14_0.dailyList

		math = var_6

		var_14_8(var_14_9, var_6.ceil(#var_14_1.all / 2), var_14_7)
	end

	pairs = var_14_7

	for iter_14_1, iter_14_2 in var_14_7(arg_14_0.dailyList) do
		local var_14_10 = arg_14_0.dailyLevelTFs

		cloneTplTo = var_1_10009
		var_14_10[iter_14_2] = var_1_10009(arg_14_0.dailylevelTpl, arg_14_0.content, iter_14_2)
	end

	return
end

function var_0_1.sortDailyList(arg_15_0)
	if #arg_15_0.dailyList % 2 ~= 1 then
		table = var_1

		var_1.insert(arg_15_0.dailyList, var_0_4)
	end

	table = var_1

	var_1.sort(arg_15_0.dailyList, function(arg_16_0, arg_16_1)
		tonumber = var_2_10002
		pg = var_2_10003

		local var_16_0 = var_2_10002(var_2_10003.expedition_daily_template[arg_16_0].sort)

		tonumber = var_3
		pg = var_2_10004

		return var_16_0 > var_3(var_2_10004.expedition_daily_template[arg_16_1].sort)
	end)

	return
end

function var_0_1.updateShowCenter(arg_17_0)
	if not arg_17_0.dailyList or #arg_17_0.dailyList == 0 then
		return
	end

	local var_17_0 = #arg_17_0.dailyList

	pg = var_1_10002

	local var_17_1 = var_1_10002.expedition_daily_template

	math = var_1_10003

	local var_17_2 = var_1_10003.ceil(var_17_0 / 2)
	local var_17_3

	for iter_17_0 = 1, var_17_0 do
		if var_17_1[arg_17_0.dailyList[iter_17_0]].show_with_count and var_9.show_with_count == 1 then
			local var_17_4 = var_9.id
			local var_17_5

			if not arg_17_0.dailyCounts or not arg_17_0.dailyCounts[var_17_4] then
				var_17_5 = 0
			end

			if var_9.limit_time - var_17_5 > 0 then
				var_17_3 = var_17_3 or iter_17_0
			end
		end
	end

	if var_17_3 then
		local var_17_6 = var_17_2 - var_17_3 < 0 and true or false

		math = var_6

		local var_17_7 = var_6.abs(var_17_2 - var_17_3)

		for iter_17_1 = 1, var_17_7 do
			local var_17_8

			if var_17_6 then
				table = var_1_10012

				local var_17_9 = var_1_10012.remove(arg_17_0.dailyList, 1)

				table = var_1_10012

				var_1_10012.insert(arg_17_0.dailyList, var_17_9)
			else
				table = var_1_10012

				local var_17_10 = var_1_10012.remove(arg_17_0.dailyList, #arg_17_0.dailyList)

				table = var_1_10012

				var_1_10012.insert(arg_17_0.dailyList, 1, var_17_10)
			end
		end
	end

	return
end

function var_0_1.displayDailyLevels(arg_18_0)
	pairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(arg_18_0.dailyLevelTFs) do
		arg_18_0:initDailyLevel(iter_18_0)
	end

	local var_18_0 = arg_18_0.content
	local var_18_1 = var_1.GetComponent

	typeof = var_3
	EnhancelScrollView = iter_18_0
	var_18_1(var_18_0, var_3(iter_18_0)).onCenterClick = function(arg_19_0)
		local var_19_0 = arg_18_0
		local var_19_1 = var_1.tryOpenDesc

		tonumber = var_2_10003

		var_19_1(var_19_0, var_2_10003(arg_19_0.name))

		return
	end
	arg_18_0.centerAniItem = nil
	arg_18_0.centerCardId = nil
	Timer = var_2
	arg_18_0.checkAniTimer = var_2.New(function()
		local var_20_0

		if not arg_18_0.descMode then
			var_20_0 = nil

			local var_20_1

			pairs = var_2_10002

			for iter_20_0, iter_20_1 in var_2_10002(arg_18_0.dailyLevelTFs) do
				GetComponent = var_2_10007

				local var_20_2 = iter_20_1

				typeof = var_2_10009
				CanvasGroup = var_2_10010
				var_2_10007 = var_2_10007(var_20_2, var_2_10009(var_2_10010))
				var_2_10007.alpha = 1

				if not var_20_0 and not var_20_1 then
					var_20_0 = iter_20_1
					var_20_1 = iter_20_1
				elseif iter_20_1.anchoredPosition.x < var_20_0.anchoredPosition.x then
					var_20_0 = iter_20_1
				elseif iter_20_1.anchoredPosition.x > var_20_1.anchoredPosition.x then
					var_20_1 = iter_20_1
				end
			end

			GetComponent = var_2

			local var_20_3 = var_20_0

			typeof = var_4
			CanvasGroup = iter_20_0

			local var_20_4 = var_2(var_20_3, var_4(iter_20_0))

			var_20_4.alpha = 0.5
			GetComponent = var_20_4

			local var_20_5 = var_20_1

			typeof = var_4
			CanvasGroup = iter_20_0
			var_20_4(var_20_5, var_4(iter_20_0)).alpha = 0.5
		end

		pairs = var_20_0

		for iter_20_2, iter_20_3 in var_20_0(arg_18_0.dailyLevelTFs) do
			local var_20_6 = iter_20_3.localScale.x >= 0.98

			if arg_18_0.centerAniItem == iter_20_3 and var_20_6 then
				return
			else
				if var_20_6 then
					arg_18_0.centerAniItem = iter_20_3
					arg_18_0.centerCardId = iter_20_2
				end

				if iter_20_3:Find("icon/card") then
					local var_20_7 = var_7:Find("mask/char")
					local var_20_8 = var_8.GetComponent

					typeof = var_10
					Animator = var_2_10011

					local var_20_9 = var_20_8(var_20_7, var_10(var_2_10011))
					local var_20_10 = var_7
					local var_20_11 = var_7.Find(var_20_10, "effect")

					setActive = var_20_10

					var_20_10(var_20_11, var_20_6)

					if var_20_9 then
						var_20_9.speed = var_20_6 and 1 or 0
					end
				end
			end
		end

		return
	end, 0.1, -1)

	local var_18_2 = arg_18_0.checkAniTimer

	var_2.Start(var_18_2)

	return
end

function var_0_1.tryOpenDesc(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.dailyLevelTFs[arg_21_1]

	pg = var_1_10003

	local var_21_1 = var_1_10003.expedition_daily_template[arg_21_1]

	table = var_1_10004

	local var_21_2 = var_1_10004.contains
	local var_21_3 = var_21_1.weekday

	tonumber = var_1_10006

	if var_21_2(var_21_3, var_1_10006(arg_21_0:getWeek())) then
		arg_21_0:openDailyDesc(arg_21_1)
	else
		pg = var_4

		local var_21_4 = var_4.TipsMgr.GetInstance()

		var_4.ShowTips(var_21_4, var_21_1.tips)
	end

	return
end

function var_0_1.CanOpenDailyLevel(arg_22_0)
	pg = var_1_10001

	local var_22_0 = var_1_10001.expedition_daily_template[arg_22_0]
	local var_22_1 = false

	table = var_1_10003

	local var_22_2 = var_1_10003.contains
	local var_22_3 = var_22_0.weekday

	tonumber = var_1_10005

	if var_22_2(var_22_3, var_1_10005(var_0_1.getWeek())) then
		var_22_1 = true
	end

	return var_22_1, var_22_0.tips
end

function var_0_1.getNextCardId(arg_23_0, arg_23_1)
	table = var_1_10002

	local var_23_0 = var_1_10002.indexof(arg_23_0.dailyList, arg_23_0.centerCardId)

	if arg_23_1 then
		if var_23_0 - 1 <= 0 then
			var_23_0 = #arg_23_0.dailyList or var_23_0
		end
	else
		var_23_0 = var_23_0 + 1 > #arg_23_0.dailyList and 1 or var_23_0
	end

	return arg_23_0.dailyList[var_23_0]
end

function var_0_1.initDailyLevel(arg_24_0, arg_24_1)
	pg = var_1_10002

	local var_24_0 = var_1_10002.expedition_daily_template[arg_24_1]
	local var_24_1 = arg_24_0.dailyLevelTFs[arg_24_1]

	table = var_1_10004

	local var_24_2 = var_1_10004.contains
	local var_24_3 = var_24_0.weekday

	tonumber = var_1_10006

	if var_24_2(var_24_3, var_1_10006(arg_24_0:getWeek())) then
		arg_24_0.index = arg_24_1
	end

	setActive = var_24_3
	findTF = var_6

	local var_24_4 = var_6(var_24_1, "lock")
	local var_24_5

	if not var_4 then
		table = var_7
		var_24_5 = not var_7.isEmpty(var_24_0.weekday)
	else
		var_24_5 = false
	end

	if false then
		var_24_5 = true
	end

	var_24_3(var_24_4, var_24_5)

	setText = var_24_3
	findTF = var_24_4

	var_24_3(var_24_4(var_24_1, "name"), var_24_0.title)

	setActive = var_24_3
	findTF = var_6

	var_24_3(var_6(var_24_1, "time"), false)

	local var_24_9

	if arg_24_0.bonusActivity then
		local var_24_6 = arg_24_0.bonusActivity

		if not var_24_9.isEnd(var_24_6) then
			checkExist = var_24_9
			underscore = var_24_6

			local var_24_7 = var_24_6.detect
			local var_24_8 = arg_24_0.bonusActivity

			var_24_9 = var_24_9(var_24_7(var_7.getConfig(var_24_8, "config_data"), function(arg_25_0)
				return arg_25_0[1] == arg_24_1
			end), {
				2
			})
			setText = var_6

			local var_24_10 = var_24_1
			local var_24_11 = var_24_1.Find(var_24_10, "bonus/Text")

			i18n = var_24_10

			var_6(var_24_11, var_24_10("dailyLevel_bonus_activity"))

			setActive = var_6

			local var_24_12 = var_24_1
			local var_24_13 = var_24_1.Find(var_24_12, "bonus")

			tobool = var_24_12

			var_6(var_24_13, var_24_12(var_24_9))

			if var_24_9 then
				updateDrop = var_6

				local var_24_14 = var_24_1
				local var_24_15 = var_24_1.Find(var_24_14, "bonus/IconTpl")

				Drop = var_24_14

				var_6(var_24_15, var_24_14.Create(var_24_9))
			end

			goto label_24_0
		end
	end

	setActive = var_24_9

	var_24_9(var_24_1:Find("bonus"), false)

	::label_24_0::

	findTF = var_24_9

	local var_24_16 = var_24_9(var_24_1, "icon")

	PoolMgr = var_6

	local var_24_17 = var_6.GetInstance()

	var_6.GetPrefab(var_24_17, "dailyui/" .. var_24_0.pic, "", true, function(arg_26_0)
		tf = var_2_10001

		local var_26_0 = var_2_10001(arg_26_0)

		arg_26_0.SetParent(var_26_0, var_24_16, false)

		Vector3 = var_1
		arg_26_0.localPosition = var_1.zero
		arg_26_0.name = "card"

		return
	end)

	setText = var_6
	findTF = var_24_17

	var_6(var_24_17(var_24_1, "Text"), "")

	setActive = var_6
	findTF = var_7

	var_6(var_7(var_24_1, "lastTime"), false)

	Clone = var_6

	local var_24_18 = var_6(var_24_0.limit_period)
	local var_24_19
	local var_24_23

	if var_24_18 then
		type = var_8

		if var_8(var_24_18) == "table" then
			pg = var_8

			local var_24_20 = var_8.TimeMgr.GetInstance()

			if var_8.inTime(var_24_20, var_24_18) then
				pg = var_24_20

				local var_24_21 = var_24_20.TimeMgr.GetInstance()
				local var_24_22 = var_9.GetServerTime(var_24_21)

				pg = var_24_21
				var_24_23 = var_24_21.TimeMgr.GetInstance()
				var_24_19 = var_10.Table2ServerTime(var_24_23, {
					year = var_24_18[2][1][1],
					month = var_24_18[2][1][2],
					day = var_24_18[2][1][3],
					hour = var_24_18[2][2][1],
					min = var_24_18[2][2][2],
					sec = var_24_18[2][2][3]
				}) - var_24_22
			end
		end
	end

	if var_24_19 then
		local var_24_24 = ""
		local var_24_25 = ""
		local var_24_26

		if 0 < var_24_19 then
			math = var_24_26
			var_24_26 = var_24_26.floor
			tonumber = var_24_23
			var_24_24 = var_24_26(var_24_23(var_24_19) / 0)
			i18n = var_24_26
			var_24_25 = var_24_26("word_date")
		elseif 3600 <= var_24_19 then
			math = var_24_26
			var_24_26 = var_24_26.floor
			tonumber = var_24_23
			var_24_24 = var_24_26(var_24_23(var_24_19) / 16)
			i18n = var_24_26
			var_24_25 = var_24_26("word_hour")
		elseif 0 < var_24_19 then
			math = var_24_26
			var_24_26 = var_24_26.floor
			tonumber = var_24_23
			var_24_24 = var_24_26(var_24_23(var_24_19) / 60)
			i18n = var_24_26
			var_24_25 = var_24_26("word_minute")
		end

		setText = var_24_26
		findTF = var_24_23

		local var_24_27 = var_24_23(var_24_1, "lastTime/content/text")

		tostring = var_12

		var_24_26(var_24_27, var_12(var_24_24) .. " ")

		setText = var_24_26
		findTF = var_24_27

		local var_24_28 = var_24_27(var_24_1, "lastTime/content/word")

		tostring = var_12

		var_24_26(var_24_28, var_12(var_24_25))

		setActive = var_24_26
		findTF = var_24_28

		var_24_26(var_24_28(var_24_1, "lastTime"), true)
	end

	arg_24_0:UpdateDailyLevelCnt(arg_24_1)

	return
end

function var_0_1.UpdateDailyLevelCnt(arg_27_0, arg_27_1)
	pg = var_1_10002

	local var_27_0 = var_1_10002.expedition_daily_template[arg_27_1]
	local var_27_1 = arg_27_0.dailyLevelTFs[arg_27_1]

	findTF = var_1_10004

	local var_27_2 = var_1_10004(var_27_1, "count")
	local var_27_3

	if not arg_27_0.dailyCounts[arg_27_1] then
		var_27_3 = 0
	end

	if var_27_0.limit_time == 0 then
		setText = var_6

		var_6(var_27_2, "N/A")
	else
		setText = var_6

		local var_27_4 = var_27_2

		string = var_1_10008

		var_6(var_27_4, var_1_10008.format("%d/%d", var_27_0.limit_time - var_27_3, var_27_0.limit_time))
	end

	setActive = var_6

	var_6(var_27_2, var_27_0.limit_time > 0)

	return
end

function var_0_1.openDailyDesc(arg_28_0, arg_28_1)
	arg_28_0.curId = arg_28_1

	arg_28_0:enableDescMode(true)
	arg_28_0:displayStageList(arg_28_1)

	return
end

function var_0_1.UpdateDailyLevelCntForDescPanel(arg_29_0, arg_29_1)
	pg = var_1_10002

	local var_29_0 = var_1_10002.expedition_daily_template[arg_29_1]
	local var_29_1

	if not arg_29_0.dailyCounts[arg_29_1] then
		var_29_1 = 0
	end

	if var_29_0.limit_time == 0 then
		setText = var_4

		local var_29_2 = arg_29_0.descChallengeText

		i18n = var_1_10006

		var_4(var_29_2, var_1_10006("challenge_count_unlimit"))
	else
		setText = var_4

		local var_29_3 = arg_29_0.descChallengeText

		string = var_1_10006

		var_4(var_29_3, var_1_10006.format("%d/%d", var_29_0.limit_time - var_29_1, var_29_0.limit_time))
	end

	return
end

function var_0_1.displayStageList(arg_30_0, arg_30_1)
	arg_30_0.dailyLevelId = arg_30_1

	local var_30_0 = arg_30_0.contextData

	var_30_0.dailyLevelId = arg_30_0.dailyLevelId
	pg = var_30_0

	local var_30_1 = var_30_0.expedition_daily_template[arg_30_1]

	arg_30_0:UpdateDailyLevelCntForDescPanel(arg_30_1)

	setActive = var_3

	var_3(arg_30_0.challengeQuotaDaily, var_30_1.limit_type == 1)

	setActive = var_3

	var_3(arg_30_0.challengeQuotaWeekly, var_30_1.limit_type == 2)

	removeAllChildren = var_3

	var_3(arg_30_0.stageContain)

	arg_30_0.stageTFs = {}
	_ = var_3

	local var_30_2 = var_3.sort(var_30_1.expedition_and_lv_limit_list, function(arg_31_0, arg_31_1)
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
	end)

	ipairs = var_4

	for iter_30_0, iter_30_1 in var_4(var_30_2) do
		local var_30_3 = iter_30_1[1]
		local var_30_4 = iter_30_1[2]
		local var_30_5 = arg_30_0.stageTFs

		cloneTplTo = var_1_10012
		var_30_5[var_30_3] = var_1_10012(arg_30_0.stageTpl, arg_30_0.stageContain)

		local var_30_6 = {
			id = var_30_3,
			level = var_30_4
		}

		arg_30_0:updateStage(var_30_6)
	end

	return
end

function var_0_1.updateStageTF(arg_32_0, arg_32_1, arg_32_2)
	pg = var_1_10003

	local var_32_0 = var_1_10003.expedition_data_template[arg_32_2.id]

	setText = var_4
	findTF = var_1_10005

	var_4(var_1_10005(arg_32_1, "left_panel/name"), var_32_0.name)

	setText = var_4
	findTF = var_5

	var_4(var_5(arg_32_1, "left_panel/lv/Text"), "Lv." .. arg_32_2.level)

	local var_32_1 = arg_32_1
	local var_32_2 = arg_32_1.Find(var_32_1, "mask")

	setActive = var_32_1

	var_32_1(var_32_2, arg_32_2.level > arg_32_0.player.level)

	if arg_32_2.level > arg_32_0.player.level then
		setText = var_5

		var_5(var_32_2:Find("msg/msg_contain/Text"), "Lv." .. arg_32_2.level .. " ")

		PLATFORM_CODE = var_5
		PLATFORM_US = var_6

		if var_5 == var_6 then
			local var_32_3 = var_32_2:Find("msg/msg_contain/Text")

			var_5.SetAsLastSibling(var_32_3)
		end
	end

	UIItemList = var_5

	local var_32_4 = var_5.New(arg_32_1:Find("scrollView/right_panel"), arg_32_0.itemTpl)

	var_5.make(var_32_4, function(arg_33_0, arg_33_1, arg_33_2)
		UIItemList = var_2_10003

		if arg_33_0 == var_2_10003.EventUpdate then
			local var_33_0 = var_32_0.award_display[arg_33_1 + 1]

			updateDrop = var_4

			var_4(arg_33_2, {
				type = var_33_0[1],
				id = var_33_0[2],
				count = var_33_0[3]
			})

			setActive = var_4

			var_4(arg_33_2, arg_33_1 <= 3)
		end

		return
	end)
	var_5:align(#var_32_0.award_display)

	setImageSprite = var_6

	local var_32_5 = arg_32_1

	getImageSprite = var_8
	findTF = var_1_10009

	var_6(var_32_5, var_8(var_1_10009(arg_32_0.resource, "normal_bg")))

	setActive = var_6
	findTF = var_32_5

	var_6(var_32_5(arg_32_1, "score"), false)

	onButton = var_6

	local var_32_6 = arg_32_0
	local var_32_7 = var_32_2

	local function var_32_8()
		pg = var_2_10000

		local var_34_0 = var_2_10000.TipsMgr.GetInstance()
		local var_34_1 = var_0.ShowTips

		i18n = var_2_10002

		var_34_1(var_34_0, var_2_10002("dailyLevel_unopened"))

		return
	end

	SFX_PANEL = var_10

	var_6(var_32_6, var_32_7, var_32_8, var_10)

	return
end

function var_0_1.updateStage(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0.stageTFs[arg_35_1.id]
	local var_35_1 = var_2.Find(var_35_0, "info")

	arg_35_0:updateStageTF(var_35_1, arg_35_1)

	onButton = var_3

	local var_35_2 = arg_35_0
	local var_35_3 = var_35_1

	local function var_35_4()
		getProxy = var_2_10000
		DailyLevelProxy = var_2_10001

		local var_36_0 = var_2_10000(var_2_10001)

		if var_0.CanQuickBattle(var_36_0, arg_35_1.id) then
			pg = var_0

			local var_36_1 = var_0.expedition_daily_template[arg_35_0.dailyLevelId]
			local var_36_2

			if not arg_35_0.dailyCounts[arg_35_0.dailyLevelId] then
				var_36_2 = 0
			end

			local var_36_3

			if var_36_1.limit_time <= var_36_2 then
				pg = var_36_2
				var_36_3 = var_36_2.TipsMgr.GetInstance()
				var_36_2 = var_36_2.ShowTips
				i18n = var_2_10003

				var_36_2(var_36_3, var_2_10003("dailyLevel_restCount_notEnough"))

				return
			end

			LeanTween = var_36_2

			local var_36_4 = var_36_2.isTweening

			go = var_36_3

			if not var_36_4(var_36_3(arg_35_0.descMain)) then
				LeanTween = var_1

				local var_36_5 = var_1.isTweening

				go = var_2

				if var_36_5(var_2(arg_35_0.listPanel)) then
					return
				end

				local var_36_6 = arg_35_0

				var_1.OnSelectStage(var_36_6, arg_35_1)

				if false then
					local var_36_7 = arg_35_0

					var_0.OnOpenPreCombat(var_36_7, arg_35_1)
				end

				return
			end
		end
	end

	SFX_PANEL = var_1_10007

	var_3(var_35_2, var_35_3, var_35_4, var_1_10007)

	return
end

function var_0_1.OnOpenPreCombat(arg_37_0, arg_37_1)
	pg = var_1_10002

	local var_37_0 = var_1_10002.expedition_daily_template[arg_37_0.dailyLevelId]
	local var_37_1

	if not arg_37_0.dailyCounts[arg_37_0.dailyLevelId] then
		var_37_1 = 0
	end

	if var_37_1 >= var_37_0.limit_time then
		pg = var_37_1

		local var_37_2 = var_37_1.TipsMgr.GetInstance()

		var_37_1 = var_37_1.ShowTips
		i18n = var_1_10005

		var_37_1(var_37_2, var_1_10005("dailyLevel_restCount_notEnough"))

		return
	end

	setActive = var_37_1

	var_37_1(arg_37_0.blurPanel, false)

	local var_37_3 = arg_37_0
	local var_37_4 = arg_37_0.emit

	DailyLevelMediator = var_5

	var_37_4(var_37_3, var_5.ON_STAGE, arg_37_1)

	return
end

function var_0_1.OnSelectStage(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0.selectedPanel
	local var_38_1 = var_2.Find(var_38_0, "stagetpl/info")

	onButton = var_38_0

	local var_38_2 = arg_38_0
	local var_38_3 = var_38_1

	local function var_38_4()
		local var_39_0 = arg_38_0

		var_0.EnableOrDisable(var_39_0, arg_38_1, false)

		return
	end

	SFX_PANEL = var_1_10007

	var_38_0(var_38_2, var_38_3, var_38_4, var_1_10007)

	onButton = var_38_0

	local var_38_5 = arg_38_0
	local var_38_6 = arg_38_0.selectedPanel

	local function var_38_7()
		local var_40_0 = arg_38_0

		var_0.EnableOrDisable(var_40_0, arg_38_1, false)

		return
	end

	SFX_PANEL = var_1_10007

	var_38_0(var_38_5, var_38_6, var_38_7, var_1_10007)
	arg_38_0:EnableOrDisable(arg_38_1, true)

	return
end

function var_0_1.EnableOrDisable(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_0.stageTFs[arg_41_1.id]
	local var_41_1 = var_3.Find(var_41_0, "quickly")

	LeanTween = var_41_0

	local var_41_2 = var_41_0.isTweening

	go = var_5

	if not var_41_2(var_5(arg_41_0.stageContain)) then
		LeanTween = var_4

		local var_41_3 = var_4.isTweening

		go = var_5

		if var_41_3(var_5(arg_41_0.selQuicklyTF)) then
			return
		end

		local var_41_4 = arg_41_0.stageContain
		local var_41_5 = var_4.GetComponent

		typeof = var_6
		VerticalLayoutGroup = var_1_10007

		local var_41_6 = var_41_5(var_41_4, var_6(var_1_10007)).padding.top
		local var_41_7 = arg_41_0.stageContain.parent
		local var_41_8 = var_5.InverseTransformPoint(var_41_7, var_41_1.parent.position)
		local var_41_9 = -1 * var_41_6 - var_41_8.y

		if arg_41_2 then
			arg_41_0:updateStageTF(arg_41_0.selStageTF, arg_41_1)
			arg_41_0:UpdateBattleBtn(arg_41_1)
			arg_41_0:DoSelectedAnimation(var_41_1, var_41_9, function()
				arg_41_0.selectedStage = arg_41_1

				return
			end)
		else
			arg_41_0:DoUnselectAnimtion(var_41_1, function()
				arg_41_0.selectedStage = nil

				return
			end)
		end

		return
	end
end

function var_0_1.DoSelectedAnimation(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	math = var_1_10004

	local var_44_0 = var_1_10004.abs(arg_44_2) / 2000

	seriesAsync = var_5

	var_5({
		function(arg_45_0)
			local var_45_0 = arg_44_0.stageScrollRect

			var_45_0.enabled = false
			pg = var_45_0

			local var_45_1 = var_45_0.UIMgr.GetInstance()

			var_1.BlurPanel(var_45_1, arg_44_0.selectedPanel)

			local var_45_2 = arg_44_1

			Vector2 = var_45_1
			var_45_2.sizeDelta = var_45_1(arg_44_1.sizeDelta.x, 0)
			setActive = var_45_2

			var_45_2(arg_44_1, true)

			local var_45_3 = arg_44_0.stageContain.anchoredPosition

			arg_44_0.stageContainLposY = var_45_3.y

			local var_45_4 = arg_44_0

			var_45_4.offsetY = arg_44_2
			LeanTween = var_45_4

			local var_45_5 = var_45_4.value

			go = var_3

			local var_45_6 = var_45_5(var_3(arg_44_0.stageContain), var_45_3.y, var_45_3.y + arg_44_2, var_44_0)
			local var_45_7 = var_2.setOnUpdate

			System = var_4

			local var_45_8 = var_45_7(var_45_6, var_4.Action_float(function(arg_46_0)
				local var_46_0 = arg_44_0.stageContain

				Vector3 = var_3_10002
				var_46_0.anchoredPosition = var_3_10002(var_45_3.x, arg_46_0, 0)

				local var_46_1 = arg_44_0.selectedPanel
				local var_46_2 = var_1.InverseTransformPoint(var_46_1, arg_44_1.parent.position)
				local var_46_3 = arg_44_0.selStageTF.parent

				Vector3 = var_3
				var_46_3.localPosition = var_3(var_46_2.x, var_46_2.y, 0)

				local var_46_4 = arg_44_0.selQuicklyTF

				Vector2 = var_3
				var_46_4.sizeDelta = var_3(arg_44_0.selQuicklyTF.sizeDelta.x, 0)
				setActive = var_46_4

				var_46_4(arg_44_0.selectedPanel, true)

				return
			end))
			local var_45_9 = var_2.setEase

			LeanTweenType = var_4

			local var_45_10 = var_45_9(var_45_8, var_4.easeInOutCirc)
			local var_45_11 = var_2.setOnComplete

			System = var_4

			var_45_11(var_45_10, var_4.Action(arg_45_0))

			return
		end,
		function(arg_47_0)
			local var_47_0 = arg_44_1
			local var_47_1 = var_1.GetComponent

			typeof = var_2_10003
			LayoutElement = var_2_10004

			local var_47_2 = var_47_1(var_47_0, var_2_10003(var_2_10004))

			LeanTween = var_47_0

			local var_47_3 = var_47_0.value

			go = var_3

			local var_47_4 = var_47_3(var_3(arg_44_0.selQuicklyTF), 0, arg_44_0.selQuicklyTFSizeDeltaY, 0.1)
			local var_47_5 = var_2.setOnUpdate

			System = var_4

			local var_47_6 = var_47_5(var_47_4, var_4.Action_float(function(arg_48_0)
				var_47_2.preferredHeight = arg_48_0

				local var_48_0 = arg_44_0.selQuicklyTF

				Vector2 = var_3_10002
				var_48_0.sizeDelta = var_3_10002(arg_44_0.selQuicklyTF.sizeDelta.x, arg_48_0)

				return
			end))
			local var_47_7 = var_2.setEase

			LeanTweenType = var_4

			local var_47_8 = var_47_7(var_47_6, var_4.easeInOutCirc)
			local var_47_9 = var_2.setOnComplete

			System = var_4

			var_47_9(var_47_8, var_4.Action(arg_47_0))

			return
		end
	}, arg_44_3)

	return
end

function var_0_1.DoUnselectAnimtion(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = arg_49_0.stageContain.anchoredPosition

	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_50_0)
			pg = var_2_10001

			local var_50_0 = var_2_10001.UIMgr.GetInstance()

			var_1.UnOverlayPanel(var_50_0, arg_49_0.selectedPanel, arg_49_0._tf)

			setActive = var_1

			var_1(arg_49_0.selectedPanel, false)

			local var_50_1 = arg_49_1
			local var_50_2 = var_1.GetComponent

			typeof = var_3
			LayoutElement = var_4

			local var_50_3 = var_50_2(var_50_1, var_3(var_4))

			LeanTween = var_50_1

			local var_50_4 = var_50_1.value

			go = var_3

			local var_50_5 = var_50_4(var_3(arg_49_0.selQuicklyTF), arg_49_0.selQuicklyTFSizeDeltaY, 0, 0.1)
			local var_50_6 = var_2.setOnUpdate

			System = var_4

			local var_50_7 = var_50_6(var_50_5, var_4.Action_float(function(arg_51_0)
				var_50_3.preferredHeight = arg_51_0

				local var_51_0 = arg_49_0.selQuicklyTF

				Vector2 = var_3_10002
				var_51_0.sizeDelta = var_3_10002(arg_49_0.selQuicklyTF.sizeDelta.x, arg_51_0)

				return
			end))
			local var_50_8 = var_2.setEase

			LeanTweenType = var_4

			local var_50_9 = var_50_8(var_50_7, var_4.easeInOutCirc)
			local var_50_10 = var_2.setOnComplete

			System = var_4

			var_50_10(var_50_9, var_4.Action(arg_50_0))

			return
		end,
		function(arg_52_0)
			local var_52_0 = (var_49_0.y - arg_49_0.offsetY) / 2000

			LeanTween = var_2_10003

			local var_52_1 = var_2_10003.value

			go = var_2_10004

			local var_52_2 = var_52_1(var_2_10004(arg_49_0.stageContain), var_49_0.y, var_1, 0.15)
			local var_52_3 = var_3.setOnUpdate

			System = var_5

			local var_52_4 = var_52_3(var_52_2, var_5.Action_float(function(arg_53_0)
				local var_53_0 = arg_49_0.stageContain

				Vector3 = var_3_10002
				var_53_0.anchoredPosition = var_3_10002(var_49_0.x, arg_53_0, 0)

				return
			end))
			local var_52_5 = var_3.setDelay(var_52_4, 0.1)
			local var_52_6 = var_3.setEase

			LeanTweenType = var_5

			local var_52_7 = var_52_6(var_52_5, var_5.easeInOutCirc)
			local var_52_8 = var_3.setOnComplete

			System = var_5

			var_52_8(var_52_7, var_5.Action(arg_52_0))

			return
		end
	}, function()
		arg_49_0.stageScrollRect.enabled = true

		arg_49_2()

		return
	end)

	return
end

function var_0_1.UpdateBattleBtn(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0.selectedPanel
	local var_55_1 = var_2.Find(var_55_0, "stagetpl/info").parent
	local var_55_2 = var_3.Find(var_55_1, "quickly/bg")

	pg = var_55_1

	local var_55_3 = var_55_1.expedition_daily_template[arg_55_0.dailyLevelId].limit_time
	local var_55_4

	if not arg_55_0.dailyCounts[arg_55_0.dailyLevelId] then
		var_55_4 = 0
	end

	local var_55_5 = var_55_3 - var_55_4
	local var_55_6 = var_55_2
	local var_55_7 = var_55_2.Find(var_55_6, "challenge")

	onButton = var_55_6

	local var_55_8 = arg_55_0
	local var_55_9 = var_55_7

	local function var_55_10()
		local var_56_0 = arg_55_0

		var_0.OnOpenPreCombat(var_56_0, arg_55_1)

		return
	end

	SFX_PANEL = var_1_10012

	var_55_6(var_55_8, var_55_9, var_55_10, var_1_10012)

	setText = var_55_6

	local var_55_11 = var_55_7
	local var_55_12 = var_55_7.Find(var_55_11, "Text")

	i18n = var_55_11

	var_55_6(var_55_12, var_55_11("daily_level_quick_battle_label2"))

	local var_55_13 = var_55_2
	local var_55_14 = var_55_2.Find(var_55_13, "mult")

	onButton = var_55_13

	local var_55_15 = arg_55_0
	local var_55_16 = var_55_14

	local function var_55_17()
		local var_57_0 = arg_55_0

		var_0.OnQuickBattle(var_57_0, arg_55_1, var_55_5)

		return
	end

	SFX_PANEL = var_1_10013

	var_55_13(var_55_15, var_55_16, var_55_17, var_1_10013)

	local var_55_18 = var_55_2
	local var_55_19 = var_55_2.Find(var_55_18, "once")

	onButton = var_55_18

	local var_55_20 = arg_55_0
	local var_55_21 = var_55_19

	local function var_55_22()
		local var_58_0 = arg_55_0

		var_0.OnQuickBattle(var_58_0, arg_55_1, 1)

		return
	end

	SFX_PANEL = var_1_10014

	var_55_18(var_55_20, var_55_21, var_55_22, var_1_10014)

	setText = var_55_18

	local var_55_23 = var_55_14
	local var_55_24 = var_55_14.Find(var_55_23, "label")

	i18n = var_55_23

	local var_55_25 = "daily_level_quick_battle_label1"
	local var_55_26 = "   "

	COLOR_WHITE = var_1_10015

	var_55_18(var_55_24, var_55_23(var_55_25, var_55_26, var_1_10015))

	setText = var_55_18

	local var_55_27 = var_55_14:Find("Text")
	local var_55_28 = "<color="

	COLOR_GREEN = var_13

	local var_55_29 = ">"

	math = var_1_10015

	var_55_18(var_55_27, var_55_28 .. var_13 .. var_55_29 .. var_1_10015.max(1, var_55_5) .. "</color>")

	setText = var_55_18

	local var_55_30 = var_55_19
	local var_55_31 = var_55_19.Find(var_55_30, "label")

	i18n = var_55_30

	var_55_18(var_55_31, var_55_30("daily_level_quick_battle_label3"))

	setText = var_55_18

	var_55_18(var_55_19:Find("Text"), "")

	if var_55_5 == 0 then
		arg_55_0:EnableOrDisable(arg_55_1, false)
	end

	return
end

function var_0_1.OnQuickBattle(arg_59_0, arg_59_1, arg_59_2)
	local var_59_1

	if arg_59_2 <= 0 then
		pg = var_59_1

		local var_59_0 = var_59_1.TipsMgr.GetInstance()

		var_59_1 = var_59_1.ShowTips
		i18n = var_1_10005

		var_59_1(var_59_0, var_1_10005("dailyLevel_restCount_notEnough"))

		return
	end

	PlayerPrefs = var_59_1

	if var_59_1.GetInt("daily_level_quick_battle_tip", 0) == 0 then
		pg = var_4

		local var_59_2 = var_4.MsgboxMgr.GetInstance()
		local var_59_3 = var_4.ShowMsgBox

		var_1_10006 = {}
		i18n = var_1_10007
		var_1_10006.content = var_1_10007("dailyLevel_quickfinish")

		function var_1_10006.onYes()
			local var_60_0 = arg_59_0
			local var_60_1 = var_0.emit

			DailyLevelMediator = var_2_10002

			var_60_1(var_60_0, var_2_10002.ON_QUICK_BATTLE, arg_59_0.dailyLevelId, arg_59_1.id, arg_59_2)

			return
		end

		var_59_3(var_59_2, var_1_10006)

		PlayerPrefs = var_59_3

		var_59_3.SetInt("daily_level_quick_battle_tip", 1)

		PlayerPrefs = var_4

		var_4.Save()
	else
		local var_59_4 = arg_59_0
		local var_59_5 = arg_59_0.emit

		DailyLevelMediator = var_1_10006

		var_59_5(var_59_4, var_1_10006.ON_QUICK_BATTLE, arg_59_0.dailyLevelId, arg_59_1.id, arg_59_2)
	end

	return
end

function var_0_1.enableDescMode(arg_61_0, arg_61_1, arg_61_2)
	arg_61_0.descMode = arg_61_1
	setActive = var_1_10003

	local var_61_0 = arg_61_0._tf

	var_1_10003(var_4.Find(var_61_0, "help_btn"), not arg_61_1)

	local function var_61_1(arg_62_0, arg_62_1, arg_62_2)
		LeanTween = var_2_10003

		local var_62_0 = var_2_10003.isTweening

		go = var_2_10004

		local var_62_1

		if var_62_0(var_2_10004(arg_62_0)) then
			LeanTween = var_62_1
			var_62_1 = var_62_1.cancel
			go = var_4

			var_62_1(var_4(arg_62_0))
		end

		LeanTween = var_62_1

		local var_62_2 = var_62_1.moveX

		rtf = var_4

		local var_62_3 = var_62_2(var_4(arg_62_0), arg_62_1, 0.3)
		local var_62_4 = var_3.setEase

		LeanTweenType = var_5

		local var_62_5 = var_62_4(var_62_3, var_5.linear)
		local var_62_6 = var_3.setOnComplete

		System = var_5

		var_62_6(var_62_5, var_5.Action(function()
			if arg_62_2 then
				arg_62_2()
			end

			return
		end))

		return
	end

	local function var_61_2()
		pairs = var_2_10000

		for iter_64_0, iter_64_1 in var_2_10000(arg_61_0.dailyLevelTFs) do
			setButtonEnabled = var_2_10005

			var_2_10005(iter_64_1, not arg_61_1)

			if iter_64_0 ~= arg_61_0.curId then
				LeanTween = var_2_10005
				var_2_10005 = var_2_10005.isTweening
				go = var_6

				if var_2_10005(var_6(iter_64_1)) then
					LeanTween = var_2_10005
					var_2_10005 = var_2_10005.cancel
					go = var_6

					var_2_10005(var_6(iter_64_1))
				end

				GetComponent = var_2_10005

				local var_64_0 = iter_64_1

				typeof = var_7
				CanvasGroup = var_2_10008
				var_2_10005 = var_2_10005(var_64_0, var_7(var_2_10008))

				local var_64_1, var_64_2

				if arg_61_1 then
					LeanTween = var_64_1
					var_64_1 = var_64_1.value
					go = var_64_2
					var_64_2 = var_64_1(var_64_2(iter_64_1), 1, 0, 0.3)
					var_64_1 = var_64_1.setOnUpdate
					System = var_2_10008

					var_64_1(var_64_2, var_2_10008.Action_float(function(arg_65_0)
						var_2_10005.alpha = arg_65_0

						return
					end))
				else
					LeanTween = var_64_1

					local var_64_3 = var_64_1.value

					go = var_64_2

					local var_64_4 = var_64_3(var_64_2(iter_64_1), 0, 1, 0.3)
					local var_64_5 = var_6.setOnUpdate

					System = var_2_10008

					var_64_5(var_64_4, var_2_10008.Action_float(function(arg_66_0)
						var_2_10005.alpha = arg_66_0

						return
					end))
				end
			end
		end

		return
	end

	local function var_61_3()
		setActive = var_2_10000

		var_2_10000(arg_61_0.listPanel, true)

		setActive = var_2_10000

		var_2_10000(arg_61_0.content, true)

		setActive = var_2_10000

		var_2_10000(arg_61_0.descPanel, arg_61_1)

		setActive = var_2_10000

		var_2_10000(arg_61_0.arrows, not arg_61_1)

		return
	end

	if arg_61_1 then
		var_61_3()
		var_61_2()
		var_61_1(arg_61_0.listPanel, -622, function()
			var_61_1(arg_61_0.descMain, 0, arg_61_2)

			return
		end)
	else
		if arg_61_0.selectedStage then
			arg_61_0:EnableOrDisable(arg_61_0.selectedStage, false)
		end

		var_61_3()
		var_61_2()
		var_61_1(arg_61_0.listPanel, 0)
		var_61_1(arg_61_0.descMain, -1342, arg_61_2)
	end

	return
end

function var_0_1.flipToSpecificCard(arg_69_0, arg_69_1)
	local var_69_0 = arg_69_0.content
	local var_69_1 = var_2.GetComponent

	typeof = var_1_10004
	EnhancelScrollView = var_1_10005

	local var_69_2 = var_69_1(var_69_0, var_1_10004(var_1_10005))

	pairs = var_69_0

	for iter_69_0, iter_69_1 in var_69_0(arg_69_0.dailyLevelTFs) do
		if arg_69_1 == iter_69_0 then
			local var_69_3 = iter_69_1
			local var_69_4 = iter_69_1.GetComponent

			typeof = var_1_10010
			EnhanceItem = var_1_10011

			local var_69_5 = var_69_4(var_69_3, var_1_10010(var_1_10011))

			var_1_10010 = var_69_2

			var_69_2.SetHorizontalTargetItemIndex(var_1_10010, var_69_5.scrollViewItemIndex)
		end
	end

	return
end

function var_0_1.tryPlayGuide(arg_70_0)
	pg = var_1_10001

	local var_70_0 = var_1_10001.SystemGuideMgr.GetInstance()

	var_1.PlayDailyLevel(var_70_0, function()
		triggerButton = var_2_10000

		local var_71_0 = arg_70_0._tf

		var_2_10000(var_1.Find(var_71_0, "help_btn"))

		return
	end)

	return
end

function var_0_1.ShowGuildTaskTip(arg_72_0)
	pg = var_1_10001

	local var_72_0 = var_1_10001.GuildMsgBoxMgr.GetInstance()

	var_1.NotificationForDailyBattle(var_72_0)

	return
end

function var_0_1.clearTween(arg_73_0)
	if arg_73_0.tweens then
		cancelTweens = var_1

		var_1(arg_73_0.tweens)
	end

	local function var_73_0(arg_74_0)
		LeanTween = var_2_10001

		local var_74_0 = var_2_10001.isTweening

		go = var_2_10002

		if var_74_0(var_2_10002(arg_74_0)) then
			LeanTween = var_1

			local var_74_1 = var_1.cancel

			go = var_2

			var_74_1(var_2(arg_74_0))
		end

		return
	end

	pairs = var_1_10002

	for iter_73_0, iter_73_1 in var_1_10002(arg_73_0.dailyLevelTFs) do
		var_73_0(iter_73_1)
	end

	var_73_0(arg_73_0.listPanel)
	var_73_0(arg_73_0.descMain)

	return
end

function var_0_1.onBackPressed(arg_75_0)
	if arg_75_0.descMode then
		LeanTween = var_1

		local var_75_0 = var_1.isTweening

		go = var_1_10002

		if not var_75_0(var_1_10002(arg_75_0.stageContain)) then
			LeanTween = var_1

			local var_75_1 = var_1.isTweening

			go = var_2

			if var_75_1(var_2(arg_75_0.selQuicklyTF)) then
				return
			end

			arg_75_0:enableDescMode(false)

			do return end

			var_0_1.super.onBackPressed(arg_75_0)

			return
		end
	end
end

function var_0_1.willExit(arg_76_0)
	if arg_76_0.selectedStage then
		pg = var_1

		local var_76_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_76_0, arg_76_0.selectedPanel, arg_76_0._tf)
	end

	arg_76_0:clearTween()

	if arg_76_0.checkAniTimer then
		local var_76_1 = arg_76_0.checkAniTimer

		var_1.Stop(var_76_1)

		arg_76_0.checkAniTimer = nil
	end

	return
end

return var_0_1
