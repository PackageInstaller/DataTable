class = var_0_10000

local var_0_0 = "ClueBookLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

pg = var_0_0

local var_0_2 = var_0_0.activity_clue

pg = var_2

local var_0_3 = var_2.activity_clue_group

pg = var_3

local var_0_4 = var_3.activity_clue_ending

function var_0_1.getUIName(arg_1_0)
	return "ClueBookUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "frame/close")

	local var_2_1 = {}
	local var_2_2 = arg_2_0._tf

	var_2_1[1] = var_2.Find(var_2_2, "frame/toggles/sitePageTg")

	local var_2_3 = arg_2_0._tf

	var_2_1[2] = var_2.Find(var_2_3, "frame/toggles/charaPageTg")

	local var_2_4 = arg_2_0._tf

	var_2_1[3] = var_2.Find(var_2_4, "frame/toggles/endingPageTg")

	local var_2_5 = arg_2_0._tf

	var_2_1[4] = var_2.Find(var_2_5, "frame/toggles/storyPageTg")
	arg_2_0.pageTgs = var_2_1

	local var_2_6 = arg_2_0._tf

	arg_2_0.pages = var_1.Find(var_2_6, "frame/pages")

	local var_2_7 = arg_2_0.pages

	arg_2_0.sitePage = var_1.Find(var_2_7, "sitePage")

	local var_2_8 = arg_2_0.pages

	arg_2_0.charaPage = var_1.Find(var_2_8, "charaPage")

	local var_2_9 = arg_2_0.pages

	arg_2_0.endingPage = var_1.Find(var_2_9, "endingPage")

	local var_2_10 = arg_2_0.pages

	arg_2_0.storyPage = var_1.Find(var_2_10, "storyPage")

	local var_2_11 = arg_2_0._tf

	arg_2_0.award = var_1.Find(var_2_11, "frame/award")
	setText = var_1

	local var_2_12 = arg_2_0.pageTgs[1]
	local var_2_13 = var_2.Find(var_2_12, "Text")

	i18n = var_2_12

	var_1(var_2_13, var_2_12("clue_title_1"))

	setText = var_1

	local var_2_14 = arg_2_0.pageTgs[1]
	local var_2_15 = var_2.Find(var_2_14, "selected/Text")

	i18n = var_2_14

	var_1(var_2_15, var_2_14("clue_title_1"))

	setText = var_1

	local var_2_16 = arg_2_0.pageTgs[2]
	local var_2_17 = var_2.Find(var_2_16, "Text")

	i18n = var_2_16

	var_1(var_2_17, var_2_16("clue_title_2"))

	setText = var_1

	local var_2_18 = arg_2_0.pageTgs[2]
	local var_2_19 = var_2.Find(var_2_18, "selected/Text")

	i18n = var_2_18

	var_1(var_2_19, var_2_18("clue_title_2"))

	setText = var_1

	local var_2_20 = arg_2_0.pageTgs[3]
	local var_2_21 = var_2.Find(var_2_20, "Text")

	i18n = var_2_20

	var_1(var_2_21, var_2_20("clue_title_3"))

	setText = var_1

	local var_2_22 = arg_2_0.pageTgs[3]
	local var_2_23 = var_2.Find(var_2_22, "selected/Text")

	i18n = var_2_22

	var_1(var_2_23, var_2_22("clue_title_3"))

	setText = var_1

	local var_2_24 = arg_2_0.pageTgs[4]
	local var_2_25 = var_2.Find(var_2_24, "Text")

	i18n = var_2_24

	var_1(var_2_25, var_2_24("clue_title_4"))

	setText = var_1

	local var_2_26 = arg_2_0.pageTgs[4]
	local var_2_27 = var_2.Find(var_2_26, "selected/Text")

	i18n = var_2_26

	var_1(var_2_27, var_2_26("clue_title_4"))

	for iter_2_0 = 1, 3 do
		setText = var_1_10005

		local var_2_28 = arg_2_0.sitePage
		local var_2_29 = var_6.Find(var_2_28, "right/Viewport/Content/siteGroup" .. iter_2_0 .. "/goBtn/Text")

		i18n = var_2_28

		var_1_10005(var_2_29, var_2_28("clue_task_goto"))
	end

	setText = var_1

	local var_2_30 = arg_2_0.charaPage
	local var_2_31 = var_2.Find(var_2_30, "right/goBtn/Text")

	i18n = var_2_30

	var_1(var_2_31, var_2_30("clue_task_goto"))

	setText = var_1

	local var_2_32 = arg_2_0.award
	local var_2_33 = var_2.Find(var_2_32, "doing/Text")

	i18n = var_2_32

	var_1(var_2_33, var_2_32("clue_get"))

	setText = var_1

	local var_2_34 = arg_2_0.award
	local var_2_35 = var_2.Find(var_2_34, "get/Text")

	i18n = var_2_34

	var_1(var_2_35, var_2_34("clue_get"))

	setText = var_1

	local var_2_36 = arg_2_0.award
	local var_2_37 = var_2.Find(var_2_36, "got/Text")

	i18n = var_2_36

	var_1(var_2_37, var_2_36("clue_got"))

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:InitData()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.StopBgm(var_4_0)

		local var_4_1 = arg_3_0

		var_0.closeView(var_4_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_3.Find(var_3_4, "mask")

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.StopBgm(var_5_0)

		local var_5_1 = arg_3_0

		var_0.closeView(var_5_1)

		return
	end

	SFX_PANEL = var_5

	var_1(var_3_3, var_3_5, var_3_6, var_5)
	arg_3_0:InitView()
	arg_3_0:UpdateView()

	pg = var_1

	local var_3_7 = var_1.BgmMgr.GetInstance()

	var_1.Push(var_3_7, arg_3_0.__cname, arg_3_0.bgm)

	pg = var_1

	local var_3_8 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_8, arg_3_0._tf)

	return
end

function var_0_1.InitData(arg_6_0)
	ActivityConst = var_1_10001
	arg_6_0.activityId = var_1_10001.Valleyhospital_ACT_ID
	ActivityConst = var_1
	arg_6_0.taskActivityId = var_1.Valleyhospital_TASK_ID
	getProxy = var_1
	ActivityProxy = var_1_10002

	local var_6_0 = var_1(var_1_10002)

	arg_6_0.activity = var_1.getActivityById(var_6_0, arg_6_0.activityId)
	getProxy = var_1
	TaskProxy = var_6_0
	arg_6_0.taskProxy = var_1(var_6_0)

	local var_6_1 = arg_6_0.activity

	arg_6_0.clueSite = var_1.getConfig(var_6_1, "config_client").clue_site
	arg_6_0.clueChara = var_1.clue_chara
	arg_6_0.clueEnding = var_1.clue_ending
	arg_6_0.story = var_1.story
	arg_6_0.storyTaskId = var_1.storyTaskId
	arg_6_0.afterStory = var_1.afterStory
	arg_6_0.bgm = var_1.bgm2

	local var_6_2 = arg_6_0.contextData.indexInfo
	local var_6_3

	if not arg_6_0.contextData.indexInfo.pageIndex then
		var_6_3 = 1
	end

	var_6_2.pageIndex = var_6_3

	local var_6_4 = arg_6_0.contextData.indexInfo
	local var_6_5

	if not arg_6_0.contextData.indexInfo.subPageSiteIndex then
		var_6_5 = 1
	end

	var_6_4.subPageSiteIndex = var_6_5

	local var_6_6 = arg_6_0.contextData.indexInfo
	local var_6_7

	if not arg_6_0.contextData.indexInfo.subPageCharaIndex then
		var_6_7 = 1
	end

	var_6_6.subPageCharaIndex = var_6_7

	local var_6_8 = arg_6_0.contextData.indexInfo
	local var_6_9

	if not arg_6_0.contextData.indexInfo.subPageEndingIndex then
		var_6_9 = 1
	end

	var_6_8.subPageEndingIndex = var_6_9
	arg_6_0.endingIndex = 1
	arg_6_0.storyIndex = 1
	getProxy = var_2
	PlayerProxy = var_6_9

	local var_6_10 = var_2(var_6_9)

	arg_6_0.playerId = var_2.getRawData(var_6_10).id
	PlayerPrefs = var_2
	arg_6_0.investigatingGroupId = var_2.GetInt("investigatingGroupId_" .. arg_6_0.activityId .. "_" .. arg_6_0.playerId)

	return
end

function var_0_1.InitView(arg_7_0)
	ipairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.pageTgs) do
		setActive = var_1_10006

		var_1_10006(iter_7_1:Find("selected"), arg_7_0.contextData.indexInfo.pageIndex == iter_7_0)

		onToggle = var_1_10006

		local var_7_0 = arg_7_0
		local var_7_1 = iter_7_1

		local function var_7_2(arg_8_0)
			if arg_8_0 then
				arg_7_0.contextData.indexInfo.pageIndex = iter_7_0

				for iter_8_0 = 0, arg_7_0.pages.childCount - 1 do
					setActive = var_2_10005

					local var_8_0 = arg_7_0.pages

					var_2_10005(var_6.GetChild(var_8_0, iter_8_0), iter_8_0 == iter_7_0 - 1)

					setActive = var_2_10005

					local var_8_1 = arg_7_0.pageTgs[iter_8_0 + 1]

					var_2_10005(var_6.Find(var_8_1, "tip"), var_0_1.ShouldShowTip(iter_8_0 + 1))

					setActive = var_2_10005

					local var_8_2 = arg_7_0.pageTgs[iter_8_0 + 1]

					var_2_10005(var_6.Find(var_8_2, "selected"), arg_7_0.contextData.indexInfo.pageIndex == iter_8_0 + 1)
				end

				if iter_7_0 == 1 then
					local var_8_3 = arg_7_0

					var_1.ShowSitePage(var_8_3)
				elseif iter_7_0 == 2 then
					local var_8_4 = arg_7_0

					var_1.ShowCharaPage(var_8_4)
				elseif iter_7_0 == 3 then
					local var_8_5 = arg_7_0

					var_1.ShowEndingPage(var_8_5)
				elseif iter_7_0 == 4 then
					local var_8_6 = arg_7_0

					var_1.ShowStoryPage(var_8_6)
				end
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_7_0, var_7_1, var_7_2, var_1_10010)
	end

	return
end

function var_0_1.UpdateView(arg_9_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_9_0.pageTgs[arg_9_0.contextData.indexInfo.pageIndex], true)

	return
end

function var_0_1.SetClueGroup(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = var_0_3[arg_10_1]
	local var_10_1 = var_0_2.get_id_list_by_group[arg_10_1]
	local var_10_2 = {
		var_0_2[var_10_1[1]],
		var_0_2[var_10_1[2]],
		var_0_2[var_10_1[3]]
	}
	local var_10_3 = {}
	local var_10_4 = arg_10_0.taskProxy
	local var_10_5 = var_7.getTaskVO

	tonumber = var_1_10009

	local var_10_6 = var_10_5(var_10_4, var_1_10009(var_10_2[3].task_id))
	local var_10_7 = var_7.getProgress(var_10_6)

	for iter_10_0 = 1, 3 do
		local var_10_8 = arg_10_0.taskProxy
		local var_10_9 = var_12.getFinishTaskById

		tonumber = var_1_10014
		var_10_3[iter_10_0] = var_10_9(var_10_8, var_1_10014(var_10_2[iter_10_0].task_id))
	end

	setText = var_8

	var_8(arg_10_2:Find("title/Text"), var_10_0.title)

	setActive = var_8

	local var_10_10 = arg_10_2:Find("title/Text")
	local var_10_11

	if not var_10_3[1] and not var_10_3[2] then
		var_10_11 = var_10_3[3]
	end

	var_8(var_10_10, var_10_11)

	setActive = var_8

	var_8(arg_10_2:Find("title/lock"), not var_10_3[1] and not var_10_3[2] and not var_10_3[3])

	LoadImageSpriteAsync = var_8

	var_8("cluepictures/" .. var_10_0.pic, arg_10_2:Find("picture"), false)

	setActive = var_8

	var_8(arg_10_2:Find("picture/lock"), not var_10_3[1] and not var_10_3[2] and not var_10_3[3])

	local var_10_12 = false

	for iter_10_1 = 1, 3 do
		if var_10_3[iter_10_1] then
			setText = var_13

			var_13(arg_10_2:Find("clue" .. iter_10_1), var_10_2[iter_10_1].desc)
		elseif arg_10_0.investigatingGroupId == arg_10_1 then
			setText = var_13

			local var_10_13 = arg_10_2:Find("clue" .. iter_10_1)
			local var_10_14 = "<color=#858593>"
			local var_10_15 = var_10_2[iter_10_1].unlock_desc
			local var_10_16 = var_10_2[iter_10_1].unlock_num

			i18n = var_1_10018

			var_13(var_10_13, var_10_14 .. var_10_15 .. var_10_16 .. var_1_10018("clue_task_tip", var_10_7) .. "</color>")
		elseif not var_10_12 then
			var_10_12 = true
			setText = var_13

			local var_10_17 = arg_10_2:Find("clue" .. iter_10_1)
			local var_10_18 = "<color=#858593>"
			local var_10_19 = var_10_2[iter_10_1].unlock_desc
			local var_10_20 = var_10_2[iter_10_1].unlock_num

			i18n = var_1_10018

			var_13(var_10_17, var_10_18 .. var_10_19 .. var_10_20 .. var_1_10018("clue_task_tip", var_10_7) .. "</color>")
		else
			setText = var_13

			var_13(arg_10_2:Find("clue" .. iter_10_1), "<color=#858593>？？？</color>")
		end
	end

	setActive = var_9

	var_9(arg_10_2:Find("goBtn"), not var_10_3[1] or not var_10_3[2] or not var_10_3[3])

	setActive = var_9

	var_9(arg_10_2:Find("goBtn/selected"), arg_10_0.investigatingGroupId == arg_10_1)

	onButton = var_9

	local var_10_21 = arg_10_0
	local var_10_22 = arg_10_2:Find("goBtn")

	local function var_10_23()
		local var_11_0 = arg_10_0

		var_11_0.investigatingGroupId = arg_10_1
		PlayerPrefs = var_11_0

		var_11_0.SetInt("investigatingGroupId_" .. arg_10_0.activityId .. "_" .. arg_10_0.playerId, arg_10_1)

		setActive = var_0

		local var_11_1 = arg_10_2

		var_0(var_1.Find(var_11_1, "goBtn/selected"), true)

		if arg_10_0.contextData.indexInfo.pageIndex == 1 then
			local var_11_2 = arg_10_0

			var_0.ShowSitePage(var_11_2)
		elseif arg_10_0.contextData.indexInfo.pageIndex == 2 then
			local var_11_3 = arg_10_0

			var_0.ShowCharaPage(var_11_3)
		end

		local var_11_4 = arg_10_0

		var_0.OpenChapter(var_11_4, arg_10_1)

		return
	end

	SFX_PANEL = var_13

	var_9(var_10_21, var_10_22, var_10_23, var_13)

	return
end

function var_0_1.SetAward(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.taskProxy
	local var_12_1 = var_3.getTaskVO(var_12_0, arg_12_1)
	local var_12_2 = var_3.getConfig(var_12_1, "award_display")[1]
	local var_12_3 = {
		type = var_12_2[1],
		id = var_12_2[2],
		count = var_12_2[3]
	}

	updateDrop = var_6

	local var_12_4 = arg_12_0.award

	var_6(var_7.Find(var_12_4, "mask/IconTpl"), var_12_3)

	onButton = var_6

	local var_12_5 = arg_12_0
	local var_12_6 = arg_12_0.award
	local var_12_7 = var_8.Find(var_12_6, "mask")

	local function var_12_8()
		local var_13_0 = arg_12_0
		local var_13_1 = var_0.emit

		BaseUI = var_2_10002

		var_13_1(var_13_0, var_2_10002.ON_DROP, var_12_3)

		return
	end

	SFX_PANEL = var_10

	var_6(var_12_5, var_12_7, var_12_8, var_10)

	local var_12_9 = var_3
	local var_12_10 = var_3.getTaskStatus(var_12_9)

	setText = var_12_9

	local var_12_11 = arg_12_0.award

	var_12_9(var_8.Find(var_12_11, "Text"), var_3:getConfig("desc"))

	setActive = var_12_9

	local var_12_12 = arg_12_0.award

	var_12_9(var_8.Find(var_12_12, "mask/IconTpl/mask"), var_12_10 == 2)

	setActive = var_12_9

	local var_12_13 = arg_12_0.award

	var_12_9(var_8.Find(var_12_13, "doing"), var_12_10 == 0)

	setActive = var_12_9

	local var_12_14 = arg_12_0.award

	var_12_9(var_8.Find(var_12_14, "get"), var_12_10 == 1)

	setActive = var_12_9

	local var_12_15 = arg_12_0.award

	var_12_9(var_8.Find(var_12_15, "got"), var_12_10 == 2)

	if arg_12_2 then
		onButton = var_12_9

		local var_12_16 = arg_12_0
		local var_12_17 = arg_12_0.award
		local var_12_18 = var_9.Find(var_12_17, "get")

		local function var_12_19()
			local var_14_0 = arg_12_0
			local var_14_1 = var_0.emit

			ClueBookMediator = var_2_10002

			var_14_1(var_14_0, var_2_10002.ON_TASK_SUBMIT_ONESTEP, arg_12_0.taskActivityId, {
				arg_12_1
			}, function(arg_15_0)
				if arg_15_0 then
					arg_12_2()
				end

				return
			end)

			return
		end

		SFX_PANEL = var_11

		var_12_9(var_12_16, var_12_18, var_12_19, var_11)
	else
		onButton = var_12_9

		local var_12_20 = arg_12_0
		local var_12_21 = arg_12_0.award
		local var_12_22 = var_9.Find(var_12_21, "get")

		local function var_12_23()
			local var_16_0 = {}
			local var_16_1 = var_0
			local var_16_2 = var_1.getConfig(var_16_1, "award_display")

			getProxy = var_16_1
			PlayerProxy = var_3

			local var_16_3 = var_16_1(var_3)
			local var_16_4 = var_2.getRawData(var_16_3)

			pg = var_16_3

			local var_16_5 = var_16_3.gameset.urpt_chapter_max.description[1]

			LOCK_UR_SHIP = var_2_10005

			if var_2_10005 then
				var_2_10005 = 0
			else
				getProxy = var_2_10005
				BagProxy = var_2_10006
				var_2_10006 = var_2_10005(var_2_10006)
				var_2_10005 = var_2_10005.GetLimitCntById(var_2_10006, var_16_5)
			end

			Task = var_2_10006

			local var_16_6, var_16_7 = var_2_10006.StaticJudgeOverflow(var_16_4.gold, var_16_4.oil, var_2_10005, true, true, var_16_2)

			if var_16_6 then
				table = var_8

				var_8.insert(var_16_0, function(arg_17_0)
					pg = var_3_10001

					local var_17_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_17_1 = var_1.ShowMsgBox
					local var_17_2 = {}

					MSGBOX_TYPE_ITEM_BOX = var_3_10004
					var_17_2.type = var_3_10004
					i18n = var_3_10004
					var_17_2.content = var_3_10004("award_max_warning")
					var_17_2.items = var_16_7
					var_17_2.onYes = arg_17_0

					var_17_1(var_17_0, var_17_2)

					return
				end)
			end

			seriesAsync = var_8

			var_8(var_16_0, function()
				local var_18_0 = arg_12_0
				local var_18_1 = var_0.emit

				ClueBookMediator = var_3_10002

				var_18_1(var_18_0, var_3_10002.ON_TASK_SUBMIT_ONESTEP, arg_12_0.taskActivityId, {
					arg_12_1
				})

				return
			end)

			return
		end

		SFX_PANEL = var_11

		var_12_9(var_12_20, var_12_22, var_12_23, var_11)
	end

	return
end

function var_0_1.ShowSitePage(arg_19_0)
	UIItemList = var_1_10001

	local var_19_0 = var_1_10001.New
	local var_19_1 = arg_19_0.sitePage
	local var_19_2 = var_2.Find(var_19_1, "left/Viewport/Content")
	local var_19_3 = arg_19_0.sitePage
	local var_19_4 = var_19_0(var_19_2, var_3.Find(var_19_3, "left/Viewport/Content/pageTg"))

	var_1.make(var_19_4, function(arg_20_0, arg_20_1, arg_20_2)
		UIItemList = var_2_10003

		if arg_20_0 == var_2_10003.EventUpdate then
			local var_20_0 = arg_19_0.clueSite[arg_20_1 + 1]

			tonumber = var_4

			local var_20_1 = var_4(var_0_3[var_20_0[1]].task_id)
			local var_20_2 = arg_19_0.taskProxy
			local var_20_3 = var_5.getTaskVO(var_20_2, var_20_1)
			local var_20_4 = var_5.getTaskStatus(var_20_3)

			setText = var_20_3

			local var_20_5 = arg_20_2:Find("Text")
			local var_20_6 = "PAGE  "

			string = var_9

			var_20_3(var_20_5, var_20_6 .. var_9.format("%02d", arg_20_1 + 1))

			setText = var_20_3

			local var_20_7 = arg_20_2:Find("selected/Text")
			local var_20_8 = "PAGE  "

			string = var_9

			var_20_3(var_20_7, var_20_8 .. var_9.format("%02d", arg_20_1 + 1))

			setActive = var_20_3

			var_20_3(arg_20_2:Find("Text"), arg_19_0.contextData.indexInfo.subPageSiteIndex ~= arg_20_1 + 1)

			setActive = var_20_3

			var_20_3(arg_20_2:Find("selected"), arg_19_0.contextData.indexInfo.subPageSiteIndex == arg_20_1 + 1)

			setActive = var_20_3

			var_20_3(arg_20_2:Find("completed"), var_20_4 == 2)

			setActive = var_20_3

			var_20_3(arg_20_2:Find("tip"), var_20_4 == 1)

			onToggle = var_20_3

			local var_20_9 = arg_19_0
			local var_20_10 = arg_20_2

			local function var_20_11(arg_21_0)
				if arg_21_0 then
					arg_19_0.contextData.indexInfo.subPageSiteIndex = arg_20_1 + 1

					for iter_21_0 = 1, #arg_19_0.clueSite do
						setActive = var_3_10005

						local var_21_0 = arg_19_0.sitePage
						local var_21_1 = var_6.Find(var_21_0, "left/Viewport/Content")
						local var_21_2 = var_6.GetChild(var_21_1, iter_21_0 - 1)

						var_3_10005(var_6.Find(var_21_2, "Text"), arg_19_0.contextData.indexInfo.subPageSiteIndex ~= iter_21_0)

						setActive = var_3_10005

						local var_21_3 = arg_19_0.sitePage
						local var_21_4 = var_6.Find(var_21_3, "left/Viewport/Content")
						local var_21_5 = var_6.GetChild(var_21_4, iter_21_0 - 1)

						var_3_10005(var_6.Find(var_21_5, "selected"), arg_19_0.contextData.indexInfo.subPageSiteIndex == iter_21_0)
					end

					for iter_21_1 = 1, 3 do
						local var_21_6 = var_20_0[iter_21_1]
						local var_21_7 = arg_19_0
						local var_21_8 = var_6.SetClueGroup
						local var_21_9 = var_21_6
						local var_21_10 = arg_19_0.sitePage

						var_21_8(var_21_7, var_21_9, var_9.Find(var_21_10, "right/Viewport/Content/siteGroup" .. iter_21_1))
					end

					local var_21_11 = arg_19_0

					var_1.SetAward(var_21_11, var_20_1)
				end

				return
			end

			SFX_PANEL = var_10

			var_20_3(var_20_9, var_20_10, var_20_11, var_10)

			if arg_19_0.contextData.indexInfo.subPageSiteIndex == arg_20_1 + 1 then
				triggerToggle = var_6

				var_6(arg_20_2, true)
			end
		end

		return
	end)
	var_1:align(#arg_19_0.clueSite)

	return
end

function var_0_1.ShowCharaPage(arg_22_0)
	UIItemList = var_1_10001

	local var_22_0 = var_1_10001.New
	local var_22_1 = arg_22_0.charaPage
	local var_22_2 = var_2.Find(var_22_1, "left/Viewport/Content")
	local var_22_3 = arg_22_0.charaPage
	local var_22_4 = var_22_0(var_22_2, var_3.Find(var_22_3, "left/Viewport/Content/pageTg"))

	var_1.make(var_22_4, function(arg_23_0, arg_23_1, arg_23_2)
		UIItemList = var_2_10003

		if arg_23_0 == var_2_10003.EventUpdate then
			local var_23_0 = arg_22_0.clueChara[arg_23_1 + 1][1]

			tonumber = var_4

			local var_23_1 = var_4(var_0_3[var_23_0].task_id)
			local var_23_2 = arg_22_0.taskProxy
			local var_23_3 = var_5.getTaskVO(var_23_2, var_23_1)
			local var_23_4 = var_5.getTaskStatus(var_23_3)
			local var_23_5 = arg_22_0

			if var_6.GetGroupClueCompleteCount(var_23_5, var_23_0) == 0 then
				setText = var_23_5

				var_23_5(arg_23_2:Find("Text"), "？？？")

				setText = var_23_5

				var_23_5(arg_23_2:Find("selected/Text"), "？？？")
			else
				setText = var_23_5

				var_23_5(arg_23_2:Find("Text"), var_0_3[var_23_0].title)

				setText = var_23_5

				var_23_5(arg_23_2:Find("selected/Text"), var_0_3[var_23_0].title)
			end

			setActive = var_23_5

			var_23_5(arg_23_2:Find("Text"), arg_22_0.contextData.indexInfo.subPageCharaIndex ~= arg_23_1 + 1)

			setActive = var_23_5

			var_23_5(arg_23_2:Find("selected"), arg_22_0.contextData.indexInfo.subPageCharaIndex == arg_23_1 + 1)

			setActive = var_23_5

			var_23_5(arg_23_2:Find("Text/completed"), var_23_4 == 2)

			setActive = var_23_5

			var_23_5(arg_23_2:Find("selected/Text/completed"), var_23_4 == 2)

			setActive = var_23_5

			var_23_5(arg_23_2:Find("tip"), var_23_4 == 1)

			onToggle = var_23_5

			local var_23_6 = arg_22_0
			local var_23_7 = arg_23_2

			local function var_23_8(arg_24_0)
				if arg_24_0 then
					arg_22_0.contextData.indexInfo.subPageCharaIndex = arg_23_1 + 1

					for iter_24_0 = 1, #arg_22_0.clueChara do
						setActive = var_3_10005

						local var_24_0 = arg_22_0.charaPage
						local var_24_1 = var_6.Find(var_24_0, "left/Viewport/Content")
						local var_24_2 = var_6.GetChild(var_24_1, iter_24_0 - 1)

						var_3_10005(var_6.Find(var_24_2, "Text"), arg_22_0.contextData.indexInfo.subPageCharaIndex ~= iter_24_0)

						setActive = var_3_10005

						local var_24_3 = arg_22_0.charaPage
						local var_24_4 = var_6.Find(var_24_3, "left/Viewport/Content")
						local var_24_5 = var_6.GetChild(var_24_4, iter_24_0 - 1)

						var_3_10005(var_6.Find(var_24_5, "selected"), arg_22_0.contextData.indexInfo.subPageCharaIndex == iter_24_0)
					end

					local var_24_6 = arg_22_0
					local var_24_7 = var_1.SetClueGroup
					local var_24_8 = var_23_0
					local var_24_9 = arg_22_0.charaPage

					var_24_7(var_24_6, var_24_8, var_4.Find(var_24_9, "right"))

					local var_24_10 = arg_22_0

					var_1.SetAward(var_24_10, var_23_1)
				end

				return
			end

			SFX_PANEL = var_2_10011

			var_23_5(var_23_6, var_23_7, var_23_8, var_2_10011)

			if arg_22_0.contextData.indexInfo.subPageCharaIndex == arg_23_1 + 1 then
				triggerToggle = var_7

				var_7(arg_23_2, true)
			end
		end

		return
	end)
	var_1:align(#arg_22_0.clueChara)

	onScroll = var_2

	local var_22_5 = arg_22_0
	local var_22_6 = arg_22_0.charaPage

	var_2(var_22_5, var_4.Find(var_22_6, "left"), function(arg_25_0)
		setActive = var_2_10001

		local var_25_0 = arg_22_0.charaPage

		var_2_10001(var_2.Find(var_25_0, "triangle"), arg_25_0.y > 0.01)

		return
	end)

	return
end

function var_0_1.GetGroupClueCompleteCount(arg_26_0, arg_26_1)
	local var_26_0 = var_0_2.get_id_list_by_group[arg_26_1]
	local var_26_1 = {
		var_0_2[var_26_0[1]],
		var_0_2[var_26_0[2]],
		var_0_2[var_26_0[3]]
	}
	local var_26_2 = 0

	for iter_26_0 = 1, 3 do
		local var_26_3 = arg_26_0.taskProxy
		local var_26_4 = var_9.getFinishTaskById

		tonumber = var_1_10011

		if var_26_4(var_26_3, var_1_10011(var_26_1[iter_26_0].task_id)) then
			var_26_2 = var_26_2 + 1
		end
	end

	return var_26_2
end

function var_0_1.ShowEndingPage(arg_27_0)
	UIItemList = var_1_10001

	local var_27_0 = var_1_10001.New
	local var_27_1 = arg_27_0.endingPage
	local var_27_2 = var_2.Find(var_27_1, "left/Viewport/Content")
	local var_27_3 = arg_27_0.endingPage
	local var_27_4 = var_27_0(var_27_2, var_3.Find(var_27_3, "left/Viewport/Content/pageTg"))

	var_1.make(var_27_4, function(arg_28_0, arg_28_1, arg_28_2)
		UIItemList = var_2_10003

		if arg_28_0 == var_2_10003.EventUpdate then
			local var_28_0 = arg_27_0.clueEnding[arg_28_1 + 1][1]
			local var_28_1 = arg_27_0.clueEnding[arg_28_1 + 1][2]
			local var_28_2 = arg_27_0.taskProxy
			local var_28_3 = var_5.getTaskVO(var_28_2, var_28_1)
			local var_28_4 = var_5.getTaskStatus(var_28_3)

			setText = var_28_3

			var_28_3(arg_28_2:Find("Text"), var_0_4[var_28_0[#var_28_0]].title2)

			setText = var_28_3

			var_28_3(arg_28_2:Find("selected/Text"), var_0_4[var_28_0[#var_28_0]].title2)

			setActive = var_28_3

			var_28_3(arg_28_2:Find("Text"), arg_27_0.contextData.indexInfo.subPageEndingIndex ~= arg_28_1 + 1)

			setActive = var_28_3

			var_28_3(arg_28_2:Find("selected"), arg_27_0.contextData.indexInfo.subPageEndingIndex == arg_28_1 + 1)

			setActive = var_28_3

			var_28_3(arg_28_2:Find("Text/completed"), var_28_4 == 2)

			setActive = var_28_3

			var_28_3(arg_28_2:Find("selected/Text/completed"), var_28_4 == 2)

			local var_28_5 = false
			local var_28_6

			if var_28_4 == 1 then
				var_28_5 = true
			else
				var_28_6 = true

				for iter_28_0 = 1, #var_28_0 do
					local var_28_7 = var_28_0[iter_28_0]
					local var_28_8 = var_0_4[var_28_7]
					local var_28_9 = arg_27_0.taskProxy
					local var_28_10 = var_14.getTaskVO

					tonumber = var_2_10016
					var_2_10016 = var_28_10(var_28_9, var_2_10016(var_28_8.task_id))

					if var_14.getTaskStatus(var_2_10016) == 1 and var_28_6 then
						var_28_5 = true
					end

					if var_15 ~= 2 then
						var_28_6 = false
					end
				end
			end

			setActive = var_28_6

			var_28_6(arg_28_2:Find("tip"), var_28_5)

			onToggle = var_28_6

			local var_28_11 = arg_27_0
			local var_28_12 = arg_28_2

			local function var_28_13(arg_29_0)
				if arg_29_0 then
					arg_27_0.contextData.indexInfo.subPageEndingIndex = arg_28_1 + 1

					for iter_29_0 = 1, #arg_27_0.clueEnding do
						setActive = var_3_10005

						local var_29_0 = arg_27_0.endingPage
						local var_29_1 = var_6.Find(var_29_0, "left/Viewport/Content")
						local var_29_2 = var_6.GetChild(var_29_1, iter_29_0 - 1)

						var_3_10005(var_6.Find(var_29_2, "Text"), arg_27_0.contextData.indexInfo.subPageEndingIndex ~= iter_29_0)

						setActive = var_3_10005

						local var_29_3 = arg_27_0.endingPage
						local var_29_4 = var_6.Find(var_29_3, "left/Viewport/Content")
						local var_29_5 = var_6.GetChild(var_29_4, iter_29_0 - 1)

						var_3_10005(var_6.Find(var_29_5, "selected"), arg_27_0.contextData.indexInfo.subPageEndingIndex == iter_29_0)
					end

					table = var_1

					var_1.sort(var_28_0, function(arg_30_0, arg_30_1)
						local var_30_0 = var_0_4[arg_30_0]
						local var_30_1 = var_0_4[arg_30_1]

						return var_30_0.unlock_pre < var_30_1.unlock_pre
					end)

					local var_29_6 = true

					for iter_29_1 = 1, #var_28_0 do
						local var_29_7 = var_28_0[iter_29_1]
						local var_29_8 = var_0_4[var_29_7]
						local var_29_9 = arg_27_0.taskProxy
						local var_29_10 = var_8.getTaskVO

						tonumber = var_3_10010
						var_3_10010 = var_29_10(var_29_9, var_3_10010(var_29_8.task_id))

						local var_29_11 = var_8.getTaskStatus(var_3_10010)

						setActive = var_3_10010

						local var_29_12 = arg_27_0.endingPage

						var_3_10010(var_11.Find(var_29_12, "right/ending" .. iter_29_1 .. "/icon"), var_29_6)

						setActive = var_3_10010

						local var_29_13 = arg_27_0.endingPage

						var_3_10010(var_11.Find(var_29_13, "right/ending" .. iter_29_1 .. "/selected"), arg_27_0.endingIndex == iter_29_1)

						setActive = var_3_10010

						local var_29_14 = arg_27_0.endingPage

						var_3_10010(var_11.Find(var_29_14, "right/ending" .. iter_29_1 .. "/lock"), not var_29_6)

						setActive = var_3_10010

						local var_29_15 = arg_27_0.endingPage

						var_3_10010(var_11.Find(var_29_15, "right/ending" .. iter_29_1 .. "/tip"), var_29_11 == 1 and var_29_6)

						local var_29_16 = arg_27_0.endingPage
						local var_29_17 = var_3_10010.Find(var_29_16, "right/ending" .. iter_29_1)

						var_3_10010 = var_3_10010.GetComponent
						typeof = var_12
						CanvasGroup = var_13
						var_3_10010 = var_3_10010(var_29_17, var_12(var_13))
						var_3_10010.alpha = var_29_6 and 1 or 0.8

						if var_29_6 then
							setText = var_3_10010

							local var_29_18 = arg_27_0.endingPage

							var_3_10010(var_11.Find(var_29_18, "right/ending" .. iter_29_1 .. "/title"), var_29_8.title)

							onToggle = var_3_10010

							local var_29_19 = arg_27_0
							local var_29_20 = arg_27_0.endingPage
							local var_29_21 = var_12.Find(var_29_20, "right/ending" .. iter_29_1)

							local function var_29_22(arg_31_0)
								if arg_31_0 then
									arg_27_0.endingIndex = iter_29_1

									for iter_31_0 = 1, #var_28_0 do
										setActive = var_4_10005

										local var_31_0 = arg_27_0.endingPage

										var_4_10005(var_6.Find(var_31_0, "right/ending" .. iter_31_0 .. "/selected"), iter_31_0 == arg_27_0.endingIndex)
									end

									local var_31_1 = var_29_8.clue
									local var_31_2 = var_29_8.locate

									setText = var_3

									local var_31_3 = arg_27_0.endingPage

									var_3(var_4.Find(var_31_3, "middle/titleBg/Text"), var_29_8.title2)

									setText = var_3

									local var_31_4 = arg_27_0.endingPage

									var_3(var_4.Find(var_31_4, "middle/endingDetail/Viewport/Content/detail"), var_29_8.desc)

									onScroll = var_3

									local var_31_5 = arg_27_0
									local var_31_6 = arg_27_0.endingPage

									var_3(var_31_5, var_5.Find(var_31_6, "middle/endingDetail"), function(arg_32_0)
										setActive = var_5_10001

										local var_32_0 = arg_27_0.endingPage

										var_5_10001(var_2.Find(var_32_0, "middle/triangle"), arg_32_0.y > 0.01)

										return
									end)

									setActive = var_3

									local var_31_7 = arg_27_0.endingPage

									var_3(var_4.Find(var_31_7, "right/combine"), var_29_11 == 1)

									onButton = var_3

									local var_31_8 = arg_27_0
									local var_31_9 = arg_27_0.endingPage
									local var_31_10 = var_5.Find(var_31_9, "right/combine")

									local function var_31_11()
										local var_33_0 = arg_27_0
										local var_33_1 = var_0.emit

										ClueBookMediator = var_5_10002

										local var_33_2 = var_5_10002.ON_TASK_SUBMIT_ONESTEP
										local var_33_3 = arg_27_0.taskActivityId
										local var_33_4 = {}

										tonumber = var_5_10005
										var_33_4[1] = var_5_10005(var_29_8.task_id)

										var_33_1(var_33_0, var_33_2, var_33_3, var_33_4)

										return
									end

									SFX_PANEL = var_7

									var_3(var_31_8, var_31_10, var_31_11, var_7)

									setActive = var_3

									local var_31_12 = arg_27_0.endingPage

									var_3(var_4.Find(var_31_12, "middle/cluePanel"), var_29_11 ~= 2)

									if var_29_11 ~= 2 then
										UIItemList = var_3

										local var_31_13 = var_3.New
										local var_31_14 = arg_27_0.endingPage
										local var_31_15 = var_4.Find(var_31_14, "middle/cluePanel")
										local var_31_16 = arg_27_0.endingPage
										local var_31_17 = var_31_13(var_31_15, var_5.Find(var_31_16, "middle/cluePanel/clueGroup"))

										var_3.make(var_31_17, function(arg_34_0, arg_34_1, arg_34_2)
											UIItemList = var_5_10003

											if arg_34_0 == var_5_10003.EventUpdate then
												local var_34_0 = var_31_1[arg_34_1 + 1]
												local var_34_1 = var_31_2[arg_34_1 + 1][1]
												local var_34_2 = var_31_2[arg_34_1 + 1][2]
												local var_34_3 = var_31_2[arg_34_1 + 1][3]
												local var_34_4

												if var_29_8.type == 1 then
													var_34_4 = var_0_3[var_34_0]

													for iter_34_0 = 1, 4 do
														setActive = var_5_10012
														var_5_10014 = arg_34_2
														var_5_10013 = arg_34_2.Find(var_5_10014, "" .. iter_34_0)
														var_5_10014 = var_34_1 == iter_34_0

														var_5_10012(var_5_10013, var_5_10014)
													end

													setActive = var_5_10008

													var_5_10008(arg_34_2:Find("ending"), false)

													var_5_10008 = arg_34_2:GetChild(var_34_1 - 1)

													local var_34_5 = arg_27_0
													local var_34_6 = var_9.GetGroupClueCompleteCount(var_34_5, var_34_0)
													local var_34_7 = var_5_10008
													local var_34_8 = var_5_10008.GetComponent

													typeof = var_5_10012
													CanvasGroup = var_5_10013

													local var_34_9 = var_34_8(var_34_7, var_5_10012(var_5_10013))

													var_34_9.alpha = var_34_6 == 0 and 0.4 or 1

													if var_34_6 == 0 then
														setText = var_34_9
														var_5_10012 = var_5_10008

														var_34_9(var_5_10008.Find(var_5_10012, "name/Text"), "？？？")
													else
														setText = var_34_9
														var_5_10012 = var_5_10008

														var_34_9(var_5_10008.Find(var_5_10012, "name/Text"), var_34_4.title)
													end

													setText = var_34_9
													var_5_10012 = var_5_10008

													var_34_9(var_5_10008.Find(var_5_10012, "progress"), var_34_6 .. "/3")

													setActive = var_34_9
													var_5_10012 = var_5_10008

													local var_34_10 = var_5_10008.Find(var_5_10012, "progress")

													var_5_10012 = var_34_6 == 1 or var_34_6 == 2

													var_34_9(var_34_10, var_5_10012)

													setActive = var_34_9
													var_5_10012 = var_5_10008

													local var_34_11 = var_5_10008.Find(var_5_10012, "complete")

													var_5_10012 = var_34_6 == 3

													var_34_9(var_34_11, var_5_10012)

													onButton = var_34_9

													local var_34_12 = arg_27_0

													var_5_10012 = arg_34_2

													local function var_34_13()
														local var_35_0 = arg_27_0
														local var_35_1 = var_0.emit

														ClueBookMediator = var_6_10002

														var_35_1(var_35_0, var_6_10002.OPEN_SINGLE_CLUE_GROUP, var_34_0)

														return
													end

													SFX_PANEL = var_5_10014

													var_34_9(var_34_12, var_5_10012, var_34_13, var_5_10014)
												else
													var_34_4 = var_0_4[var_34_0]
													setText = var_5_10008

													var_5_10008(arg_34_2:Find("ending/name"), var_34_4.title2)

													for iter_34_1 = 1, 4 do
														setActive = var_5_10012

														var_5_10012(arg_34_2:Find("" .. iter_34_1), false)
													end

													setActive = var_8

													var_8(arg_34_2:Find("ending"), true)

													for iter_34_2 = 1, 3 do
														setActive = var_5_10012

														var_5_10012(arg_34_2:Find("ending/icon" .. iter_34_2), arg_34_1 + 1 == iter_34_2)
													end

													onButton = var_8

													local var_34_14 = arg_27_0
													local var_34_15 = arg_34_2

													local function var_34_16()
														triggerToggle = var_6_10000

														local var_36_0 = arg_27_0.endingPage

														var_6_10000(var_1.Find(var_36_0, "right/ending" .. arg_34_1 + 1), true)

														return
													end

													SFX_PANEL = var_5_10012

													var_8(var_34_14, var_34_15, var_34_16, var_5_10012)
												end

												Vector2 = var_34_4
												arg_34_2.anchoredPosition = var_34_4(var_34_2[1], var_34_2[2])
												Vector3 = var_7
												arg_34_2.localScale = var_7(var_34_3, var_34_3, 1)
											end

											return
										end)
										var_3:align(#var_31_1)
									end
								end

								return
							end

							SFX_PANEL = var_14

							var_3_10010(var_29_19, var_29_21, var_29_22, var_14)
						else
							var_3_10010 = "64646a"

							if iter_29_1 == #var_28_0 then
								var_3_10010 = "6683cf"
							end

							setText = var_11

							local var_29_23 = arg_27_0.endingPage

							var_11(var_12.Find(var_29_23, "right/ending" .. iter_29_1 .. "/title"), "<color=#" .. var_3_10010 .. ">" .. var_29_8.title .. "</color>")

							removeOnToggle = var_11

							local var_29_24 = arg_27_0.endingPage

							var_11(var_12.Find(var_29_24, "right/ending" .. iter_29_1))
						end

						if var_29_11 ~= 2 then
							var_29_6 = false
						end
					end

					triggerToggle = var_2

					local var_29_25 = arg_27_0.endingPage

					var_2(var_3.Find(var_29_25, "right/ending" .. arg_27_0.endingIndex), true)

					local var_29_26 = arg_27_0

					var_2.SetAward(var_29_26, var_28_1)
				end

				return
			end

			SFX_PANEL = iter_28_0

			var_28_6(var_28_11, var_28_12, var_28_13, iter_28_0)

			if arg_27_0.contextData.indexInfo.subPageEndingIndex == arg_28_1 + 1 then
				triggerToggle = var_7

				var_7(arg_28_2, true)
			end
		end

		return
	end)
	var_1:align(#arg_27_0.clueEnding)

	return
end

function var_0_1.ShowStoryPage(arg_37_0)
	(function()
		setText = var_2_10000

		local var_38_0 = arg_37_0.storyPage

		var_2_10000(var_1.Find(var_38_0, "pageIndex/Text"), arg_37_0.storyIndex .. "/2")

		setActive = var_2_10000

		local var_38_1 = arg_37_0.storyPage

		var_2_10000(var_1.Find(var_38_1, "leftBtn"), arg_37_0.storyIndex == 2)

		setActive = var_2_10000

		local var_38_2 = arg_37_0.storyPage

		var_2_10000(var_1.Find(var_38_2, "rightBtn"), arg_37_0.storyIndex == 1)

		setActive = var_2_10000

		local var_38_3 = arg_37_0.storyPage

		var_2_10000(var_1.Find(var_38_3, "subPages/page1"), arg_37_0.storyIndex == 1)

		setActive = var_2_10000

		local var_38_4 = arg_37_0.storyPage

		var_2_10000(var_1.Find(var_38_4, "subPages/page2"), arg_37_0.storyIndex == 2)

		return
	end)()

	onButton = var_2

	local var_37_0 = arg_37_0
	local var_37_1 = arg_37_0.storyPage
	local var_37_2 = var_4.Find(var_37_1, "leftBtn")

	local function var_37_3()
		arg_37_0.storyIndex = 1

		var_0()

		return
	end

	SFX_PANEL = var_6

	var_2(var_37_0, var_37_2, var_37_3, var_6)

	onButton = var_2

	local var_37_4 = arg_37_0
	local var_37_5 = arg_37_0.storyPage
	local var_37_6 = var_4.Find(var_37_5, "rightBtn")

	local function var_37_7()
		arg_37_0.storyIndex = 2

		var_0()

		return
	end

	SFX_PANEL = var_6

	var_2(var_37_4, var_37_6, var_37_7, var_6)

	for iter_37_0 = 1, #arg_37_0.story do
		local var_37_8

		if iter_37_0 <= 5 then
			local var_37_9 = arg_37_0.storyPage
			local var_37_10 = var_7.Find(var_37_9, "subPages/page1")

			var_37_8 = var_7.GetChild(var_37_10, iter_37_0 - 1)
		else
			local var_37_11 = arg_37_0.storyPage
			local var_37_12 = var_7.Find(var_37_11, "subPages/page2")

			var_37_8 = var_7.GetChild(var_37_12, iter_37_0 - 6)
		end

		local var_37_13 = arg_37_0.story[iter_37_0][1]
		local var_37_14 = var_7[2]
		local var_37_15 = var_7[3]
		local var_37_16 = var_7[4]
		local var_37_17 = arg_37_0.taskProxy
		local var_37_18 = var_12.getTaskVO(var_37_17, var_37_15)
		local var_37_19 = var_12.getTaskStatus(var_37_18)

		if var_37_13 == 1 then
			setText = var_37_18

			local var_37_20 = var_37_8
			local var_37_21 = var_37_8.Find(var_37_20, "lock/Text")

			i18n = var_37_20

			var_37_18(var_37_21, var_37_20("clue_lock_tip1"))
		else
			setText = var_37_18

			local var_37_22 = var_37_8
			local var_37_23 = var_37_8.Find(var_37_22, "lock/Text")

			i18n = var_37_22

			var_37_18(var_37_23, var_37_22("clue_lock_tip2", var_0_4[var_37_14].title))
		end

		setActive = var_37_18

		var_37_18(var_37_8:Find("lock"), var_37_19 == 0)

		setActive = var_37_18

		var_37_18(var_37_8:Find("canGet"), var_37_19 == 1)

		local var_37_24 = var_37_8
		local var_37_25 = var_37_8.GetComponent

		typeof = var_16
		CanvasGroup = var_17

		local var_37_26 = var_37_25(var_37_24, var_16(var_17))

		var_37_26.alpha = var_37_19 == 0 and 0.4 or 1

		if var_37_19 == 1 then
			onButton = var_37_26

			local var_37_27 = arg_37_0
			local var_37_28 = var_37_8

			local function var_37_29()
				local var_41_0 = arg_37_0
				local var_41_1 = var_0.emit

				ClueBookMediator = var_2_10002

				var_41_1(var_41_0, var_2_10002.ON_TASK_SUBMIT_ONESTEP, arg_37_0.taskActivityId, {
					var_37_15
				}, function(arg_42_0)
					if arg_42_0 then
						pg = var_3_10001

						local var_42_0 = var_3_10001.NewStoryMgr.GetInstance()

						var_1.Play(var_42_0, var_37_16)
					end

					return
				end)

				return
			end

			SFX_PANEL = var_1_10018

			var_37_26(var_37_27, var_37_28, var_37_29, var_1_10018)
		elseif var_37_19 == 2 then
			onButton = var_37_26

			local var_37_30 = arg_37_0
			local var_37_31 = var_37_8

			local function var_37_32()
				pg = var_2_10000

				local var_43_0 = var_2_10000.NewStoryMgr.GetInstance()

				var_0.Play(var_43_0, var_37_16, nil, true)

				return
			end

			SFX_PANEL = var_1_10018

			var_37_26(var_37_30, var_37_31, var_37_32, var_1_10018)
		else
			removeOnButton = var_37_26

			var_37_26(var_37_8)
		end
	end

	arg_37_0:SetAward(arg_37_0.storyTaskId, function()
		pg = var_2_10000

		local var_44_0 = var_2_10000.NewStoryMgr.GetInstance()

		var_0.Play(var_44_0, arg_37_0.afterStory)

		return
	end)

	return
end

function var_0_1.OpenChapter(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0
	local var_45_1 = arg_45_0.emit

	ClueBookMediator = var_1_10004

	var_45_1(var_45_0, var_1_10004.OPEN_CLUE_JUMP, arg_45_1)

	return
end

function var_0_1.willExit(arg_46_0)
	return
end

function var_0_1.onBackPressed(arg_47_0)
	arg_47_0:StopBgm()
	arg_47_0:closeView()

	return
end

function var_0_1.ShouldShowTip(arg_48_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_48_0 = var_1_10001(var_1_10002)
	local var_48_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	local var_48_2 = var_48_1(var_48_0, var_1_10003.Valleyhospital_ACT_ID)

	getProxy = var_48_0
	TaskProxy = var_3

	local var_48_3 = var_48_0(var_3)
	local var_48_4 = var_48_2:getConfig("config_client").clue_site
	local var_48_5 = var_3.clue_chara
	local var_48_6 = var_3.clue_ending
	local var_48_7 = var_3.story
	local var_48_8 = var_3.storyTaskId

	if not arg_48_0 or arg_48_0 == 1 then
		for iter_48_0 = 1, #var_48_4 do
			local var_48_9 = var_48_4[iter_48_0]

			tonumber = var_1_10014
			var_1_10014 = var_1_10014(var_0_3[var_48_9[1]].task_id)

			local var_48_10 = var_48_3:getTaskVO(var_1_10014)

			if var_15.getTaskStatus(var_48_10) == 1 then
				return true
			end
		end
	end

	if not arg_48_0 or arg_48_0 == 2 then
		for iter_48_1 = 1, #var_48_5 do
			local var_48_11 = var_48_5[iter_48_1][1]

			tonumber = var_1_10014
			var_1_10014 = var_1_10014(var_0_3[var_48_11].task_id)

			local var_48_12 = var_48_3:getTaskVO(var_1_10014)

			if var_15.getTaskStatus(var_48_12) == 1 then
				return true
			end
		end
	end

	if not arg_48_0 or arg_48_0 == 3 then
		for iter_48_2 = 1, #var_48_6 do
			local var_48_13 = var_48_6[iter_48_2][1]
			local var_48_14 = var_48_6[iter_48_2][2]
			local var_48_15 = var_48_3:getTaskVO(var_48_14)

			if var_15.getTaskStatus(var_48_15) == 1 then
				return true
			end

			local var_48_16 = true

			for iter_48_3 = 1, #var_48_13 do
				local var_48_17 = var_48_13[iter_48_3]
				local var_48_18 = var_0_4[var_48_17]
				local var_48_19 = var_48_3
				local var_48_20 = var_48_3.getTaskVO

				tonumber = var_1_10025
				var_1_10025 = var_48_20(var_48_19, var_1_10025(var_48_18.task_id))

				if var_23.getTaskStatus(var_1_10025) == 1 and var_48_16 then
					return true
				end

				if var_24 ~= 2 then
					var_48_16 = false
				end
			end
		end
	end

	if not arg_48_0 or arg_48_0 == 4 then
		local var_48_21 = var_48_3:getTaskVO(var_48_8)

		if var_9.getTaskStatus(var_48_21) == 1 then
			return true
		end

		for iter_48_4 = 1, #var_48_7 do
			local var_48_22 = var_48_7[iter_48_4][3]
			local var_48_23 = var_48_3:getTaskVO(var_48_22)

			if var_16.getTaskStatus(var_48_23) == 1 then
				return true
			end
		end
	end

	return false
end

return var_0_1
