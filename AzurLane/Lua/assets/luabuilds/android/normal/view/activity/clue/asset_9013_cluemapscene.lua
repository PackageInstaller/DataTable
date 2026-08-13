class = var_0_10000

local var_0_0 = "ClueMapScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

pg = var_0_0

local var_0_2 = var_0_0.activity_single_enemy

pg = var_2

local var_0_3 = var_2.activity_clue

function var_0_1.getUIName(arg_1_0)
	return "ClueMapUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.ui = var_1.Find(var_2_0, "ui")

	local var_2_1 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_1, "ui/top/back_button")

	local var_2_2 = arg_2_0._tf

	arg_2_0.homeBtn = var_1.Find(var_2_2, "ui/top/home_button")

	local var_2_3 = {}
	local var_2_4 = arg_2_0._tf

	var_2_3[1] = var_2.Find(var_2_4, "bgs/bg1")

	local var_2_5 = arg_2_0._tf

	var_2_3[2] = var_2.Find(var_2_5, "bgs/bg2")

	local var_2_6 = arg_2_0._tf

	var_2_3[3] = var_2.Find(var_2_6, "bgs/bg3")
	arg_2_0.bgs = var_2_3

	local var_2_7 = {}
	local var_2_8 = arg_2_0._tf

	var_2_7[1] = var_2.Find(var_2_8, "ui/mapsSwitch/map1")

	local var_2_9 = arg_2_0._tf

	var_2_7[2] = var_2.Find(var_2_9, "ui/mapsSwitch/map2")

	local var_2_10 = arg_2_0._tf

	var_2_7[3] = var_2.Find(var_2_10, "ui/mapsSwitch/map3")
	arg_2_0.mapsSwitch = var_2_7

	local var_2_11 = {}
	local var_2_12 = arg_2_0._tf

	var_2_11[1] = var_2.Find(var_2_12, "ui/chapters/t1")

	local var_2_13 = arg_2_0._tf

	var_2_11[2] = var_2.Find(var_2_13, "ui/chapters/t2")

	local var_2_14 = arg_2_0._tf

	var_2_11[3] = var_2.Find(var_2_14, "ui/chapters/t3")

	local var_2_15 = arg_2_0._tf

	var_2_11[4] = var_2.Find(var_2_15, "ui/chapters/t4")
	arg_2_0.chapters = var_2_11

	local var_2_16 = arg_2_0._tf

	arg_2_0.chapterSp = var_1.Find(var_2_16, "ui/chapterSp")

	local var_2_17 = arg_2_0._tf

	arg_2_0.pt = var_1.Find(var_2_17, "ui/pt")

	local var_2_18 = arg_2_0._tf

	arg_2_0.explore = var_1.Find(var_2_18, "ui/exploreTarget")

	local var_2_19 = arg_2_0._tf

	arg_2_0.taskBtn = var_1.Find(var_2_19, "ui/taskBtn")

	local var_2_20 = arg_2_0._tf

	arg_2_0.bookBtn = var_1.Find(var_2_20, "ui/bookBtn")
	setText = var_1

	local var_2_21 = arg_2_0.pt
	local var_2_22 = var_2.Find(var_2_21, "total")

	i18n = var_2_21

	var_1(var_2_22, var_2_21("clue_pt_tip"))

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:InitData()
	arg_3_0:ShowResUI()
	arg_3_0:InitMapsSwitch()
	arg_3_0:UpdateCluePanel()

	setText = var_1

	local var_3_0 = arg_3_0.pt

	var_1(var_2.Find(var_3_0, "Text"), arg_3_0.ptData.count)

	onButton = var_1

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.closeBtn

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.StopBgm(var_4_0)

		local var_4_1 = arg_3_0

		var_0.closeView(var_4_1)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_1, var_3_2, var_3_3, var_1_10005)

	onButton = var_1

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.homeBtn

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_HOME)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_4, var_3_5, var_3_6, var_1_10005)

	setActive = var_1

	local var_3_7 = arg_3_0.taskBtn
	local var_3_8 = var_2.Find(var_3_7, "tip")

	ClueTasksLayer = var_3_7

	var_1(var_3_8, var_3_7.ShouldShowTip())

	onButton = var_1

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.taskBtn

	local function var_3_11()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		ClueMapMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.OPEN_CLUE_TASk, function()
			if arg_3_0._tf then
				setActive = var_0

				local var_7_0 = arg_3_0.taskBtn
				local var_7_1 = var_1.Find(var_7_0, "tip")

				ClueTasksLayer = var_7_0

				var_0(var_7_1, var_7_0.ShouldShowTip())

				local var_7_2 = arg_3_0

				getProxy = var_7_1
				ActivityProxy = var_2

				local var_7_3 = var_7_1(var_2)
				local var_7_4 = var_1.getActivityById

				ActivityConst = var_3
				var_7_2.ptActivity = var_7_4(var_7_3, var_3.Valleyhospital_PT_ACT_ID)

				local var_7_5 = arg_3_0

				ActivityPtData = var_1
				var_7_5.ptData = var_1.New(arg_3_0.ptActivity)
				setText = var_7_5

				local var_7_6 = arg_3_0.pt

				var_7_5(var_1.Find(var_7_6, "Text"), arg_3_0.ptData.count)

				local var_7_7 = arg_3_0

				getProxy = var_1
				ActivityProxy = var_2

				local var_7_8 = var_1(var_2)
				local var_7_9 = var_1.getActivityById

				ActivityConst = var_3
				var_7_7.activity = var_7_9(var_7_8, var_3.Valleyhospital_ACT_ID)
				setText = var_7_7

				local var_7_10 = arg_3_0.chapterSp

				var_7_7(var_1.Find(var_7_10, "ticket/count"), "X " .. arg_3_0.activity.data1)
			end

			return
		end)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_9, var_3_10, var_3_11, var_1_10005)

	setActive = var_1

	local var_3_12 = arg_3_0.bookBtn
	local var_3_13 = var_2.Find(var_3_12, "tip")

	ClueBookLayer = var_3_12

	var_1(var_3_13, var_3_12.ShouldShowTip())

	onButton = var_1

	local var_3_14 = arg_3_0
	local var_3_15 = arg_3_0.bookBtn

	local function var_3_16()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.emit

		ClueMapMediator = var_2_10002

		var_8_1(var_8_0, var_2_10002.OPEN_CLUE_BOOK, function()
			if arg_3_0._tf then
				local var_9_0 = arg_3_0

				var_0.UpdateCluePanel(var_9_0)

				setActive = var_0

				local var_9_1 = arg_3_0.bookBtn
				local var_9_2 = var_1.Find(var_9_1, "tip")

				ClueBookLayer = var_9_1

				var_0(var_9_2, var_9_1.ShouldShowTip())

				local var_9_3 = arg_3_0

				getProxy = var_9_2
				ActivityProxy = var_2

				local var_9_4 = var_9_2(var_2)
				local var_9_5 = var_1.getActivityById

				ActivityConst = var_3
				var_9_3.ptActivity = var_9_5(var_9_4, var_3.Valleyhospital_PT_ACT_ID)

				local var_9_6 = arg_3_0

				ActivityPtData = var_1
				var_9_6.ptData = var_1.New(arg_3_0.ptActivity)
				setText = var_9_6

				local var_9_7 = arg_3_0.pt

				var_9_6(var_1.Find(var_9_7, "Text"), arg_3_0.ptData.count)

				local var_9_8 = arg_3_0

				getProxy = var_1
				ActivityProxy = var_2

				local var_9_9 = var_1(var_2)
				local var_9_10 = var_1.getActivityById

				ActivityConst = var_3
				var_9_8.activity = var_9_10(var_9_9, var_3.Valleyhospital_ACT_ID)
				setText = var_9_8

				local var_9_11 = arg_3_0.chapterSp

				var_9_8(var_1.Find(var_9_11, "ticket/count"), "X " .. arg_3_0.activity.data1)
			end

			return
		end)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_14, var_3_15, var_3_16, var_1_10005)

	pg = var_1

	local var_3_17 = var_1.NewStoryMgr.GetInstance()

	var_1.Play(var_3_17, arg_3_0.enterStory)

	local var_3_18 = arg_3_0

	arg_3_0.SubmitClueTask(var_3_18)

	getProxy = var_1
	ContextProxy = var_3_18

	local var_3_19 = var_1(var_3_18)
	local var_3_20 = var_1.getContextByMediator

	ClueMapMediator = var_3

	if var_3_20(var_3_19, var_3).cleanChild and arg_3_0.contextData.bookOpen then
		triggerButton = var_2

		var_2(arg_3_0.bookBtn)
	end

	return
end

function var_0_1.InitData(arg_10_0)
	arg_10_0.easyChapters = {}
	arg_10_0.normalChapters = {}
	arg_10_0.hardChapters = {}
	arg_10_0.spChapter = nil
	ipairs = var_1

	for iter_10_0, iter_10_1 in var_1(var_0_2.all) do
		if var_0_2[iter_10_1].activity_type == 2 then
			if var_6.type == 1 then
				table = var_1_10007

				var_1_10007.insert(arg_10_0.easyChapters, var_6)
			elseif var_6.type == 2 then
				table = var_1_10007

				var_1_10007.insert(arg_10_0.normalChapters, var_6)
			elseif var_6.type == 3 then
				table = var_1_10007

				var_1_10007.insert(arg_10_0.hardChapters, var_6)
			elseif var_6.type == 4 then
				arg_10_0.spChapter = var_6
			end
		end
	end

	getProxy = var_1
	ActivityProxy = var_2

	local var_10_0 = var_1(var_2)
	local var_10_1 = var_1.getActivityById

	ActivityConst = var_3
	arg_10_0.activity = var_10_1(var_10_0, var_3.Valleyhospital_ACT_ID)
	getProxy = var_1
	ActivityProxy = var_10_0

	local var_10_2 = var_1(var_10_0)
	local var_10_3 = var_1.getActivityById

	ActivityConst = var_3
	arg_10_0.ptActivity = var_10_3(var_10_2, var_3.Valleyhospital_PT_ACT_ID)
	ActivityPtData = var_1
	arg_10_0.ptData = var_1.New(arg_10_0.ptActivity)

	local var_10_4 = arg_10_0.contextData

	defaultValue = var_2
	var_10_4.mapIndex = var_2(arg_10_0.contextData.mapIndex, 1)
	arg_10_0.submitGroupIds = {}
	arg_10_0.canSubmitTaskIds = {}
	arg_10_0.submitClueIds = {}
	pairs = var_1

	for iter_10_2, iter_10_3 in var_1(var_0_3.get_id_list_by_group) do
		local var_10_5 = false

		ipairs = var_1_10007

		for iter_10_4, iter_10_5 in var_1_10007(iter_10_3) do
			local var_10_6 = var_0_3[iter_10_5]

			tonumber = var_1_10013
			var_1_10013 = var_1_10013(var_10_6.task_id)
			getProxy = var_14
			TaskProxy = var_1_10015
			var_1_10015 = var_14(var_1_10015)

			local var_10_7 = var_14.getTaskVO(var_1_10015, var_1_10013)

			if var_14.getTaskStatus(var_10_7) == 1 then
				local var_10_8

				if not arg_10_0.canSubmitTaskIds[iter_10_2] then
					var_10_8 = arg_10_0.canSubmitTaskIds
					var_10_8[iter_10_2] = {}
					var_10_8 = arg_10_0.submitClueIds
					var_10_8[iter_10_2] = {}
				end

				table = var_10_8

				var_10_8.insert(arg_10_0.canSubmitTaskIds[iter_10_2], var_1_10013)

				table = var_16

				var_16.insert(arg_10_0.submitClueIds[iter_10_2], iter_10_5)

				var_10_5 = true
			end
		end

		if var_10_5 then
			table = var_1_10007

			var_1_10007.insert(arg_10_0.submitGroupIds, iter_10_2)
		end
	end

	local var_10_9 = arg_10_0.activity

	arg_10_0.enterStory = var_1.getConfig(var_10_9, "config_client").enterStory
	arg_10_0.bgms = var_1.bgm1

	return
end

function var_0_1.RefreshPtAndTicket(arg_11_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_11_0 = var_1_10001(var_1_10002)
	local var_11_1 = var_1.getActivityById

	ActivityConst = var_1_10003
	arg_11_0.ptActivity = var_11_1(var_11_0, var_1_10003.Valleyhospital_PT_ACT_ID)
	ActivityPtData = var_1
	arg_11_0.ptData = var_1.New(arg_11_0.ptActivity)
	setText = var_1

	local var_11_2 = arg_11_0.pt

	var_1(var_2.Find(var_11_2, "Text"), arg_11_0.ptData.count)

	getProxy = var_1
	ActivityProxy = var_2

	local var_11_3 = var_1(var_2)
	local var_11_4 = var_1.getActivityById

	ActivityConst = var_3
	arg_11_0.activity = var_11_4(var_11_3, var_3.Valleyhospital_ACT_ID)
	setText = var_1

	local var_11_5 = arg_11_0.chapterSp

	var_1(var_2.Find(var_11_5, "ticket/count"), "X " .. arg_11_0.activity.data1)

	return
end

function var_0_1.ShowResUI(arg_12_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_12_0 = var_1_10001(var_1_10002)
	local var_12_1 = var_1.getRawData(var_12_0)

	findTF = var_12_0

	local var_12_2 = var_12_0(arg_12_0._tf, "ui/top/res/gold/max")
	local var_12_3 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_12_0.goldMax = var_12_3(var_12_2, var_4(var_1_10005))
	findTF = var_2

	local var_12_4 = var_2(arg_12_0._tf, "ui/top/res/gold/Text")
	local var_12_5 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_12_0.goldValue = var_12_5(var_12_4, var_4(var_1_10005))
	findTF = var_2

	local var_12_6 = var_2(arg_12_0._tf, "ui/top/res/oil/max")
	local var_12_7 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_12_0.oilMax = var_12_7(var_12_6, var_4(var_1_10005))
	findTF = var_2

	local var_12_8 = var_2(arg_12_0._tf, "ui/top/res/oil/Text")
	local var_12_9 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_12_0.oilValue = var_12_9(var_12_8, var_4(var_1_10005))
	findTF = var_2

	local var_12_10 = var_2(arg_12_0._tf, "ui/top/res/gem/Text")
	local var_12_11 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_12_0.gemValue = var_12_11(var_12_10, var_4(var_1_10005))
	PlayerResUI = var_2

	var_2.StaticFlush(var_12_1, arg_12_0.goldMax, arg_12_0.goldValue, arg_12_0.oilMax, arg_12_0.oilValue, arg_12_0.gemValue)

	onButton = var_2

	local var_12_12 = arg_12_0

	findTF = var_4

	local var_12_13 = var_4(arg_12_0._tf, "ui/top/res/gold")

	local function var_12_14()
		pg = var_2_10000

		local var_13_0 = var_2_10000.playerResUI

		var_0.ClickGold(var_13_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_12_12, var_12_13, var_12_14, var_6)

	onButton = var_2

	local var_12_15 = arg_12_0

	findTF = var_12_13

	local var_12_16 = var_12_13(arg_12_0._tf, "ui/top/res/oil")

	local function var_12_17()
		pg = var_2_10000

		local var_14_0 = var_2_10000.playerResUI

		var_0.ClickOil(var_14_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_12_15, var_12_16, var_12_17, var_6)

	onButton = var_2

	local var_12_18 = arg_12_0

	findTF = var_12_16

	local var_12_19 = var_12_16(arg_12_0._tf, "ui/top/res/gem")

	local function var_12_20()
		pg = var_2_10000

		local var_15_0 = var_2_10000.playerResUI

		var_0.ClickGem(var_15_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_12_18, var_12_19, var_12_20, var_6)

	return
end

function var_0_1.UpdateCluePanel(arg_16_0)
	ActivityConst = var_1_10001

	local var_16_0 = var_1_10001.Valleyhospital_ACT_ID

	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_16_1 = var_1_10002(var_1_10003)
	local var_16_2 = var_2.getRawData(var_16_1).id

	PlayerPrefs = var_16_1

	local var_16_3 = var_16_1.GetInt("investigatingGroupId_" .. var_16_0 .. "_" .. var_16_2, 0)
	local var_16_4 = true
	local var_16_5
	local var_16_6 = 0
	local var_16_7

	if var_16_3 ~= 0 then
		var_16_7 = var_0_3.get_id_list_by_group[var_16_3]
		var_16_5 = {
			var_0_3[var_16_7[1]],
			var_0_3[var_16_7[2]],
			var_0_3[var_16_7[3]]
		}
		getProxy = var_8
		TaskProxy = var_9

		local var_16_8 = var_8(var_9)
		local var_16_9 = var_8.getTaskVO

		tonumber = var_10

		local var_16_10 = var_16_9(var_16_8, var_10(var_16_5[3].task_id))

		var_16_6 = var_8.getProgress(var_16_10)

		for iter_16_0 = 1, 3 do
			getProxy = var_1_10012
			TaskProxy = var_1_10013
			var_1_10013 = var_1_10012(var_1_10013)
			var_1_10012 = var_1_10012.getFinishTaskById
			tonumber = var_1_10014

			if not var_1_10012(var_1_10013, var_1_10014(var_16_5[iter_16_0].task_id)) then
				var_16_4 = false

				break
			end
		end
	end

	if var_16_4 then
		setText = var_16_7

		local var_16_11 = arg_16_0.explore
		local var_16_12 = var_8.Find(var_16_11, "target/Text")

		i18n = var_16_11

		var_16_7(var_16_12, var_16_11("clue_unselect_tip"))
	else
		setText = var_16_7

		local var_16_13 = arg_16_0.explore
		local var_16_14 = var_8.Find(var_16_13, "target/Text")
		local var_16_15 = var_16_5[1].unlock_desc
		local var_16_16 = var_16_5[1].unlock_num
		local var_16_17 = "/"
		local var_16_18 = var_16_5[2].unlock_num
		local var_16_19 = "/"
		local var_16_20 = var_16_5[3].unlock_num

		i18n = var_1_10015

		var_16_7(var_16_14, var_16_15 .. var_16_16 .. var_16_17 .. var_16_18 .. var_16_19 .. var_16_20 .. var_1_10015("clue_task_tip", var_16_6))
	end

	return
end

function var_0_1.InitMapsSwitch(arg_17_0)
	ipairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(arg_17_0.mapsSwitch) do
		onToggle = var_1_10006

		local var_17_0 = arg_17_0
		local var_17_1 = iter_17_1

		local function var_17_2(arg_18_0)
			if arg_18_0 then
				arg_17_0.contextData.mapIndex = iter_17_0

				for iter_18_0 = 1, 3 do
					setActive = var_2_10005

					var_2_10005(arg_17_0.bgs[iter_18_0], iter_18_0 == iter_17_0)

					var_2_10006 = arg_17_0.mapsSwitch[iter_18_0]
					var_2_10005 = var_2_10005.GetComponent
					typeof = var_7
					CanvasGroup = var_2_10008
					var_2_10005 = var_2_10005(var_2_10006, var_7(var_2_10008))
					var_2_10006 = iter_18_0 == iter_17_0 and 1 or 0.4
					var_2_10005.alpha = var_2_10006
				end

				if iter_17_0 == 1 then
					ipairs = var_1

					for iter_18_1, iter_18_2 in var_1(arg_17_0.chapters) do
						setActive = var_2_10006

						var_2_10006(iter_18_2:Find("dusk"), iter_17_0 == 2)

						setActive = var_2_10006

						var_2_10006(iter_18_2:Find("night"), iter_17_0 == 3)

						setActive = var_2_10006

						var_2_10006(iter_18_2:Find("title"), true)

						setActive = var_2_10006

						var_2_10006(iter_18_2:Find("title2"), false)

						onButton = var_2_10006

						local var_18_0 = arg_17_0
						local var_18_1 = iter_18_2

						local function var_18_2()
							local var_19_0 = arg_17_0

							var_0.OpenChapterLayer(var_19_0, arg_17_0.easyChapters[iter_18_1].id)

							return
						end

						SFX_PANEL = var_2_10010

						var_2_10006(var_18_0, var_18_1, var_18_2, var_2_10010)
					end
				elseif iter_17_0 == 2 then
					ipairs = var_1

					for iter_18_3, iter_18_4 in var_1(arg_17_0.chapters) do
						setActive = var_2_10006

						var_2_10006(iter_18_4:Find("dusk"), iter_17_0 == 2)

						setActive = var_2_10006

						var_2_10006(iter_18_4:Find("night"), iter_17_0 == 3)

						setActive = var_2_10006

						var_2_10006(iter_18_4:Find("title"), true)

						setActive = var_2_10006

						var_2_10006(iter_18_4:Find("title2"), false)

						onButton = var_2_10006

						local var_18_3 = arg_17_0
						local var_18_4 = iter_18_4

						local function var_18_5()
							local var_20_0 = arg_17_0

							var_0.OpenChapterLayer(var_20_0, arg_17_0.normalChapters[iter_18_3].id)

							return
						end

						SFX_PANEL = var_2_10010

						var_2_10006(var_18_3, var_18_4, var_18_5, var_2_10010)
					end
				else
					ipairs = var_1

					for iter_18_5, iter_18_6 in var_1(arg_17_0.chapters) do
						setActive = var_2_10006

						var_2_10006(iter_18_6:Find("dusk"), iter_17_0 == 2)

						setActive = var_2_10006

						var_2_10006(iter_18_6:Find("night"), iter_17_0 == 3)

						setActive = var_2_10006

						var_2_10006(iter_18_6:Find("title"), false)

						setActive = var_2_10006

						var_2_10006(iter_18_6:Find("title2"), true)

						onButton = var_2_10006

						local var_18_6 = arg_17_0
						local var_18_7 = iter_18_6

						local function var_18_8()
							local var_21_0 = arg_17_0

							var_0.OpenChapterLayer(var_21_0, arg_17_0.hardChapters[iter_18_5].id)

							return
						end

						SFX_PANEL = var_2_10010

						var_2_10006(var_18_6, var_18_7, var_18_8, var_2_10010)
					end
				end

				setActive = var_1

				local var_18_9 = arg_17_0.chapterSp

				var_1(var_2.Find(var_18_9, "dusk"), iter_17_0 == 2)

				setActive = var_1

				local var_18_10 = arg_17_0.chapterSp

				var_1(var_2.Find(var_18_10, "night"), iter_17_0 == 3)

				GetImageSpriteFromAtlasAsync = var_1
				pg = var_2

				local var_18_11 = var_2.item_virtual_data_statistics[arg_17_0.spChapter.enter_cost].icon
				local var_18_12 = ""
				local var_18_13 = arg_17_0.chapterSp

				var_1(var_18_11, var_18_12, var_4.Find(var_18_13, "ticket/icon"), false)

				local var_18_14 = arg_17_0

				getProxy = var_18_11
				ActivityProxy = var_18_12

				local var_18_15 = var_18_11(var_18_12)
				local var_18_16 = var_2.getActivityById

				ActivityConst = var_4
				var_18_14.activity = var_18_16(var_18_15, var_4.Valleyhospital_ACT_ID)
				setText = var_18_14

				local var_18_17 = arg_17_0.chapterSp

				var_18_14(var_2.Find(var_18_17, "ticket/count"), "X " .. arg_17_0.activity.data1)

				onButton = var_18_14

				local var_18_18 = arg_17_0
				local var_18_19 = arg_17_0.chapterSp

				local function var_18_20()
					local var_22_0 = arg_17_0

					var_0.OpenChapterLayer(var_22_0, arg_17_0.spChapter.id)

					return
				end

				SFX_PANEL = var_5

				var_18_14(var_18_18, var_18_19, var_18_20, var_5)

				pg = var_18_14

				local var_18_21 = var_18_14.BgmMgr.GetInstance()

				var_1.Push(var_18_21, arg_17_0.__cname, arg_17_0.bgms[arg_17_0.contextData.mapIndex])
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_17_0, var_17_1, var_17_2, var_1_10010)

		if arg_17_0.contextData.mapIndex == iter_17_0 then
			triggerToggle = var_1_10006

			var_1_10006(iter_17_1, true)
		end
	end

	return
end

function var_0_1.OpenChapterLayer(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0
	local var_23_1 = arg_23_0.emit

	ClueMapMediator = var_1_10004

	var_23_1(var_23_0, var_1_10004.OPEN_STAGE, arg_23_1)

	return
end

function var_0_1.SubmitClueTask(arg_24_0)
	if #arg_24_0.submitGroupIds > 0 then
		ActivityConst = var_1

		local var_24_0 = var_1.Valleyhospital_TASK_ID
		local var_24_1 = arg_24_0
		local var_24_2 = arg_24_0.emit

		ClueMapMediator = var_1_10004

		var_24_2(var_24_1, var_1_10004.ON_TASK_SUBMIT_ONESTEP, var_24_0, arg_24_0.canSubmitTaskIds[arg_24_0.submitGroupIds[1]], function(arg_25_0)
			if arg_25_0 then
				local var_25_0 = arg_24_0

				var_1.UpdateCluePanel(var_25_0)

				local var_25_1 = arg_24_0

				var_1.OpenSingleClueGroupPanel(var_25_1)
			end

			return
		end)

		table = var_24_2
		arg_24_0.showClueGroupId = var_24_2.remove(arg_24_0.submitGroupIds, 1)
	end

	return
end

function var_0_1.OpenSingleClueGroupPanel(arg_26_0)
	local var_26_0 = arg_26_0
	local var_26_1 = arg_26_0.emit

	ClueMapMediator = var_1_10003

	var_26_1(var_26_0, var_1_10003.OPEN_SINGLE_CLUE_GROUP, arg_26_0.showClueGroupId, arg_26_0.submitClueIds[arg_26_0.showClueGroupId], function()
		local var_27_0 = arg_26_0

		var_0.SubmitClueTask(var_27_0)

		local var_27_1 = arg_26_0

		var_0.UpdateCluePanel(var_27_1)

		setActive = var_0

		local var_27_2 = arg_26_0.bookBtn
		local var_27_3 = var_1.Find(var_27_2, "tip")

		ClueBookLayer = var_27_2

		var_0(var_27_3, var_27_2.ShouldShowTip())

		return
	end)

	return
end

function var_0_1.willExit(arg_28_0)
	return
end

function var_0_1.onBackPressed(arg_29_0)
	arg_29_0:StopBgm()
	arg_29_0:closeView()

	return
end

return var_0_1
