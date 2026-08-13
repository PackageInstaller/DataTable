class = var_0_10000

local var_0_0 = "BossRushAlvitScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

var_0_1.DISPLAY = {
	STORY = 2,
	BATTLE = 1
}

function var_0_1.getUIName(arg_1_0)
	return "BossRushAlvitUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_0, "Top")

	local var_2_1 = arg_2_0.top

	arg_2_0.ptBtn = var_1.Find(var_2_1, "right/pt")

	local var_2_2 = arg_2_0.ptBtn

	arg_2_0.ptText = var_1.Find(var_2_2, "value/Text")

	local var_2_3 = arg_2_0.ptBtn

	arg_2_0.ptTip = var_1.Find(var_2_3, "tip")

	local var_2_4 = arg_2_0.top

	arg_2_0.rankBtn = var_1.Find(var_2_4, "right/rank")

	local var_2_5 = arg_2_0.top

	arg_2_0.taskBtn = var_1.Find(var_2_5, "right/task")

	local var_2_6 = arg_2_0.taskBtn

	arg_2_0.taskTip = var_1.Find(var_2_6, "tip")
	_ = var_1

	local var_2_7 = var_1.map

	_ = var_2_6

	local var_2_8 = var_2_6.range
	local var_2_9 = arg_2_0._tf

	arg_2_0.seriesNodes = var_2_7(var_2_8(var_5.Find(var_2_9, "Battle/Nodes").childCount), function(arg_3_0)
		local var_3_0 = arg_2_0._tf
		local var_3_1 = var_1.Find(var_3_0, "Battle/Nodes")

		return var_1.GetChild(var_3_1, arg_3_0 - 1)
	end)
	arg_2_0.nodes = {}

	local var_2_10 = 1
	local var_2_11 = arg_2_0._tf

	for iter_2_0 = var_2_10, var_2.Find(var_2_11, "Story/Nodes").childCount do
		local var_2_12 = arg_2_0._tf
		local var_2_13 = var_5.Find(var_2_12, "Story/Nodes")
		local var_2_14 = var_5.GetChild(var_2_13, iter_2_0 - 1)

		arg_2_0.nodes[var_2_14.name] = var_2_14
	end

	local var_2_15 = arg_2_0._tf

	arg_2_0.progressText = var_1.Find(var_2_15, "Story/Desc/Text")

	local var_2_16 = arg_2_0._tf

	arg_2_0.storyAward = var_1.Find(var_2_16, "Story/Award")
	arg_2_0.ActionSequence = {}

	return
end

function var_0_1.SetActivity(arg_4_0, arg_4_1)
	arg_4_0.activity = arg_4_1

	return
end

function var_0_1.SetPtActivity(arg_5_0, arg_5_1)
	arg_5_0.ptActivity = arg_5_1
	ActivityPtData = var_1_10002
	arg_5_0.ptData = var_1_10002.New(arg_5_0.ptActivity)

	return
end

function var_0_1.didEnter(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.top
	local var_6_2 = var_4.Find(var_6_1, "top/back")

	local function var_6_3()
		local var_7_0 = arg_6_0

		var_0.onBackPressed(var_7_0)

		return
	end

	SFX_CANCEL = var_6_1

	var_1_10001(var_6_0, var_6_2, var_6_3, var_6_1)

	onButton = var_1_10001

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.top
	local var_6_6 = var_4.Find(var_6_5, "top/home")

	local function var_6_7()
		local var_8_0 = arg_6_0

		var_0.quickExitFunc(var_8_0)

		return
	end

	SFX_PANEL = var_6_5

	var_1_10001(var_6_4, var_6_6, var_6_7, var_6_5)

	onButton = var_1_10001

	local var_6_8 = arg_6_0
	local var_6_9 = arg_6_0.rankBtn

	local function var_6_10()
		local var_9_0 = arg_6_0
		local var_9_1 = var_0.emit

		BossRushAlvitMediator = var_2_10003

		var_9_1(var_9_0, var_2_10003.ON_EXTRA_RANK)

		return
	end

	SFX_PANEL = var_6_5

	var_1_10001(var_6_8, var_6_9, var_6_10, var_6_5)

	onButton = var_1_10001

	local var_6_11 = arg_6_0
	local var_6_12 = arg_6_0.ptBtn

	local function var_6_13()
		local var_10_0 = arg_6_0
		local var_10_1 = var_0.emit

		BossRushAlvitMediator = var_2_10003

		local var_10_2 = var_2_10003.GO_SUBLAYER

		Context = var_2_10004

		local var_10_3 = var_2_10004.New
		local var_10_4 = {}

		ChildishnessSchoolPtMediator = var_2_10007
		var_10_4.mediator = var_2_10007
		ChildishnessSchoolPtPage = var_2_10007
		var_10_4.viewComponent = var_2_10007

		var_10_1(var_10_0, var_10_2, var_10_3(var_10_4))

		return
	end

	SFX_PANEL = var_6_5

	var_1_10001(var_6_11, var_6_12, var_6_13, var_6_5)

	onButton = var_1_10001

	local var_6_14 = arg_6_0
	local var_6_15 = arg_6_0.taskBtn

	local function var_6_16()
		local var_11_0 = arg_6_0
		local var_11_1 = var_0.emit

		BossRushAlvitMediator = var_2_10003

		local var_11_2 = var_2_10003.GO_SUBLAYER

		Context = var_2_10004

		local var_11_3 = var_2_10004.New
		local var_11_4 = {}

		ChildishnessSchoolTaskMediator = var_2_10007
		var_11_4.mediator = var_2_10007
		ChildishnessSchoolTaskPage = var_2_10007
		var_11_4.viewComponent = var_2_10007

		var_11_1(var_11_0, var_11_2, var_11_3(var_11_4))

		return
	end

	SFX_PANEL = var_6_5

	var_1_10001(var_6_14, var_6_15, var_6_16, var_6_5)

	onButton = var_1_10001

	local var_6_17 = arg_6_0
	local var_6_18 = arg_6_0._tf
	local var_6_19 = var_4.Find(var_6_18, "Battle/Story")

	local function var_6_20()
		local var_12_0 = arg_6_0

		var_0.SetDisplayMode(var_12_0, var_0_1.DISPLAY.STORY)

		return
	end

	SFX_PANEL = var_6_18

	var_1_10001(var_6_17, var_6_19, var_6_20, var_6_18)

	onButton = var_1_10001

	local var_6_21 = arg_6_0
	local var_6_22 = arg_6_0._tf
	local var_6_23 = var_4.Find(var_6_22, "Story/Battle")

	local function var_6_24()
		local var_13_0 = arg_6_0

		var_0.SetDisplayMode(var_13_0, var_0_1.DISPLAY.BATTLE)

		return
	end

	SFX_PANEL = var_6_22

	var_1_10001(var_6_21, var_6_23, var_6_24, var_6_22)

	local var_6_25 = arg_6_0.activity
	local var_6_26 = var_1.getConfig(var_6_25, "config_client").storys

	arg_6_0.storyNodesDict = {}
	_ = var_2

	var_2.each(var_6_26, function(arg_14_0)
		local var_14_0 = arg_6_0.storyNodesDict

		BossRushStoryNode = var_2_10002
		var_14_0[arg_14_0] = var_2_10002.New({
			id = arg_14_0
		})

		return
	end)
	arg_6_0:UpdateStoryTask()

	local var_6_27

	if not arg_6_0.contextData.displayMode then
		BossRushAlvitScene = var_6_27
		var_6_27 = var_6_27.DISPLAY.BATTLE
	end

	arg_6_0.contextData.displayMode = nil

	arg_6_0:SetDisplayMode(var_6_27)

	return
end

function var_0_1.getBGM(arg_15_0)
	pg = var_1_10001

	if not var_1_10001.voice_bgm[arg_15_0.__cname] then
		return nil
	end

	local var_15_0 = var_1.bgm
	local var_15_1 = "story-richang-11"

	if arg_15_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE then
		return var_15_0
	elseif var_4 == var_0_1.DISPLAY.STORY then
		return var_15_1
	end

	return
end

function var_0_1.SetDisplayMode(arg_16_0, arg_16_1)
	if arg_16_1 == arg_16_0.contextData.displayMode then
		return
	end

	arg_16_0.contextData.displayMode = arg_16_1

	arg_16_0:PlayBGM()
	arg_16_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_17_0)
	local var_17_0 = arg_17_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE

	setActive = var_2

	local var_17_1 = arg_17_0._tf

	var_2(var_4.Find(var_17_1, "Battle"), var_17_0)

	setActive = var_2

	local var_17_2 = arg_17_0._tf

	var_2(var_4.Find(var_17_2, "Story"), not var_17_0)
	arg_17_0:UpdateBattle()

	if not var_17_0 then
		arg_17_0:UpdateStory()
	end

	arg_17_0:UpdateTaskTip()

	local var_17_3 = arg_17_0.contextData.displayMode

	arg_17_0:addbubbleMsgBoxList({
		function(arg_18_0)
			local var_18_0

			if var_17_3 == var_0_1.DISPLAY.BATTLE then
				local var_18_1 = arg_17_0.activity

				var_18_0 = var_2.getConfig(var_18_1, "config_client").openActivityStory
			elseif var_17_3 == var_0_1.DISPLAY.STORY then
				local var_18_2 = arg_17_0.activity

				var_18_0 = var_2.getConfig(var_18_2, "config_client").openStory
			end

			local var_18_3 = arg_17_0

			var_2.PlayStory(var_18_3, var_18_0, arg_18_0)

			return
		end,
		function(arg_19_0)
			underscore = var_2_10001

			local var_19_0 = var_2_10001.all

			underscore = var_2_10003

			if var_19_0(var_2_10003.values(arg_17_0.storyNodesDict), function(arg_20_0)
				return arg_20_0:IsReaded()
			end) and arg_17_0.storyTask then
				local var_19_1 = arg_17_0.storyTask

				if var_1.getTaskStatus(var_19_1) == 2 then
					local var_19_2 = arg_17_0.activity
					local var_19_3 = var_1.getConfig(var_19_2, "config_client").endStory
					local var_19_4 = arg_17_0

					var_2.PlayStory(var_19_4, var_19_3, function(arg_21_0)
						arg_19_0()

						if arg_21_0 then
							local var_21_0 = arg_17_0

							var_1.UpdateView(var_21_0)
						end

						return
					end)

					return
				end
			end

			arg_19_0()

			return
		end
	})

	return
end

function var_0_1.UpdateBattle(arg_22_0)
	local var_22_0 = arg_22_0.activity
	local var_22_1 = var_1.GetActiveSeriesIds(var_22_0)

	table = var_1_10003

	var_1_10003.Foreach(arg_22_0.seriesNodes, function(arg_23_0, arg_23_1)
		local var_23_0 = var_22_1[arg_23_0]

		BossRushSeriesData = var_2_10003

		local var_23_1 = var_2_10003.New({
			id = var_23_0,
			actId = var_0.id
		})
		local var_23_2 = var_3.IsUnlock(var_23_1, var_0)

		setActive = var_5

		var_5(arg_23_1, var_23_2)

		local var_23_3 = var_3:GetType()

		BossRushSeriesData = var_23_1

		local var_23_4 = var_23_3 == var_23_1.TYPE.SP
		local var_23_5 = true
		local var_23_8

		if var_23_4 then
			local var_23_6 = var_0
			local var_23_7

			if not var_7.GetUsedBonus(var_23_6)[arg_23_0] then
				var_23_7 = 0
			end

			var_23_8 = var_3:GetMaxBonusCount()
			setText = var_23_6

			local var_23_9 = arg_23_1
			local var_23_10 = arg_23_1.Find(var_23_9, "count/Text")

			i18n = var_2_10012

			local var_23_11 = var_2_10012("series_enemy_SP_count")

			math = var_23_9

			var_23_6(var_23_10, var_23_11 .. var_23_9.max(0, var_23_8 - var_23_7) .. "/" .. var_23_8)

			var_23_5 = var_23_8 - var_23_7 > 0
		end

		local function var_23_12()
			if not var_23_2 then
				local var_24_0 = var_0
				local var_24_1 = var_0.GetPreSeriesId(var_24_0)

				BossRushSeriesData = var_3_10001

				local var_24_2 = var_3_10001.New({
					id = var_24_1
				})

				pg = var_24_0

				local var_24_3 = var_24_0.TipsMgr.GetInstance()
				local var_24_4 = var_2.ShowTips

				i18n = var_3_10005

				var_24_4(var_24_3, var_3_10005("series_enemy_unlock", var_24_2:GetName()))

				return
			end

			if not var_23_5 then
				pg = var_0

				local var_24_5 = var_0.TipsMgr.GetInstance()
				local var_24_6 = var_0.ShowTips

				i18n = var_3_10003

				var_24_6(var_24_5, var_3_10003("series_enemy_SP_error"))

				return
			end

			local var_24_7 = arg_22_0
			local var_24_8 = var_0.emit

			BossRushAlvitMediator = var_3_10003

			var_24_8(var_24_7, var_3_10003.ON_FLEET_SELECT, var_0)

			return
		end

		onButton = var_23_8

		local var_23_13 = arg_22_0
		local var_23_14 = arg_23_1
		local var_23_15 = arg_23_1.Find(var_23_14, "icon")

		local function var_23_16()
			var_23_12()

			return
		end

		SFX_PANEL = var_23_14

		var_23_8(var_23_13, var_23_15, var_23_16, var_23_14)

		onButton = var_23_8

		local var_23_17 = arg_22_0
		local var_23_18 = arg_23_1
		local var_23_19 = arg_23_1.Find(var_23_18, "text")

		local function var_23_20()
			var_23_12()

			return
		end

		SFX_PANEL = var_23_18

		var_23_8(var_23_17, var_23_19, var_23_20, var_23_18)

		return
	end)

	setText = var_3

	var_3(arg_22_0.ptText, arg_22_0.ptActivity.data1)

	setActive = var_3

	local var_22_2 = arg_22_0.ptTip

	Activity = var_6

	var_3(var_22_2, var_6.IsActivityReady(arg_22_0.ptActivity))

	setActive = var_3

	local var_22_3 = arg_22_0._tf
	local var_22_4 = var_5.Find(var_22_3, "Battle/Story/new")
	local var_22_6

	if arg_22_0.storyTask then
		local var_22_5 = arg_22_0.storyTask

		var_22_6 = var_6.getTaskStatus(var_22_5) ~= 2
	end

	var_3(var_22_4, var_22_6)

	return
end

function var_0_1.UpdateStory(arg_27_0)
	pg = var_1_10001

	local var_27_0 = var_1_10001.NewStoryMgr.GetInstance()
	local var_27_1 = 0
	local var_27_2 = 0

	table = var_1_10004

	var_1_10004.Foreach(arg_27_0.storyNodesDict, function(arg_28_0, arg_28_1)
		local var_28_0 = arg_27_0.nodes

		tostring = var_2_10003

		local var_28_1 = var_28_0[var_2_10003(arg_28_1.id)]

		isActive = var_3

		local var_28_2 = var_3(var_28_1)
		local var_28_3 = arg_28_1
		local var_28_5

		if arg_28_1.IsActive(var_28_3, arg_27_0.activity, arg_27_0.ptActivity) then
			if not var_28_2 then
				setActive = var_28_5

				var_28_5(var_28_1, true)
			end

			setActive = var_28_5

			var_28_5(var_28_1, true)

			if not var_28_2 then
				local var_28_4 = var_28_1

				var_28_5 = var_28_1.GetComponent
				typeof = var_8
				Animation = var_2_10010

				local var_28_6 = var_28_5(var_28_4, var_8(var_2_10010))

				var_28_5.Play(var_28_6, "anim_kinder_bossrush_story_tip")
			end
		else
			setActive = var_28_5

			var_28_5(var_28_1, false)
		end

		setText = var_28_5

		var_28_5(var_28_1:Find("main/Text"), arg_28_1:GetName())

		local var_28_7 = arg_28_1:GetType()

		BossRushStoryNode = var_28_3

		if var_28_7 == var_28_3.NODE_TYPE.NORMAL then
			setActive = var_6

			var_6(var_28_1:Find("tags/story"), true)

			setActive = var_6

			var_6(var_28_1:Find("tags/battle"), false)
		else
			BossRushStoryNode = var_6

			if var_28_7 == var_6.NODE_TYPE.EVENT then
				-- block empty
			else
				BossRushStoryNode = var_6

				if var_28_7 == var_6.NODE_TYPE.BATTLE then
					setActive = var_6

					var_6(var_28_1:Find("tags/story"), false)

					setActive = var_6

					var_6(var_28_1:Find("tags/battle"), true)
				end
			end
		end

		local var_28_8 = arg_28_1:IsReaded()

		var_27_1 = var_27_1 + (var_28_8 and 1 or 0)
		var_27_2 = var_27_2 + 1
		setActive = var_7

		var_7(var_28_1:Find("main"), not var_28_8)

		setActive = var_7

		var_7(var_28_1:Find("finish"), var_28_8)

		setActive = var_7

		var_7(var_28_1:Find("finish_tag"), var_28_8)

		onButton = var_7

		var_7(arg_27_0, var_28_1, function()
			if not var_0 or var_28_8 then
				return
			end

			local var_29_0 = arg_28_1
			local var_29_1 = var_0.GetStory(var_29_0)
			local var_29_2 = arg_27_0

			var_1.PlayStory(var_29_2, var_29_1, function()
				local var_30_0 = arg_27_0

				var_0.UpdateView(var_30_0)

				return
			end)

			return
		end)

		return
	end)

	setText = var_4

	var_4(arg_27_0.progressText, var_27_1 .. "/" .. var_27_2)

	setActive = var_4

	local var_27_3 = arg_27_0.storyAward

	tobool = var_7

	var_4(var_27_3, var_7(arg_27_0.storyTask))

	if arg_27_0.storyTask then
		local var_27_4 = arg_27_0.storyTask
		local var_27_5 = var_4.getConfig(var_27_4, "award_display")

		Drop = var_1_10005

		local var_27_6 = var_1_10005.New({
			type = var_27_5[1][1],
			id = var_27_5[1][2],
			count = var_27_5[1][3]
		})

		updateDrop = var_27_4

		local var_27_7 = arg_27_0.storyAward

		var_27_4(var_8.GetChild(var_27_7, 0), var_27_6)

		local var_27_8 = arg_27_0.storyTask
		local var_27_9 = var_6.getTaskStatus(var_27_8)

		setActive = var_27_13

		local var_27_10 = arg_27_0.storyAward

		var_27_13(var_9.Find(var_27_10, "get"), var_27_9 == 1)

		setActive = var_27_13

		local var_27_11 = arg_27_0.storyAward

		var_27_13(var_9.Find(var_27_11, "got"), var_27_9 == 2)

		local var_27_13

		if var_27_9 == 1 then
			local var_27_12 = arg_27_0

			var_27_13 = arg_27_0.emit
			BossRushAlvitMediator = var_10

			var_27_13(var_27_12, var_10.ON_TASK_SUBMIT, arg_27_0.storyTask)
		end

		onButton = var_27_13

		var_27_13(arg_27_0, arg_27_0.storyAward, function()
			local var_31_0 = arg_27_0
			local var_31_1 = var_0.emit

			BaseUI = var_2_10003

			var_31_1(var_31_0, var_2_10003.ON_DROP, var_27_6)

			return
		end)
	end

	return
end

function var_0_1.PlayStory(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_1 then
		existCall = var_1_10003

		return var_1_10003(arg_32_2)
	end

	pg = var_1_10003

	local var_32_0 = var_1_10003.NewStoryMgr.GetInstance()
	local var_32_1 = var_3.IsPlayed(var_32_0, arg_32_1)

	seriesAsync = var_1_10005

	var_1_10005({
		function(arg_33_0)
			if var_32_1 then
				return arg_33_0()
			end

			tonumber = var_1

			if var_1(arg_32_1) and var_1 > 0 then
				local var_33_0 = arg_32_0
				local var_33_1 = var_2.emit

				BossRushAlvitMediator = var_2_10005

				var_33_1(var_33_0, var_2_10005.ON_PERFORM_COMBAT, var_1)
			else
				local var_33_2 = var_0

				var_2.Play(var_33_2, arg_32_1, arg_33_0)
			end

			return
		end,
		function(arg_34_0, ...)
			existCall = var_2_10001

			var_2_10001(arg_32_2, ...)

			return
		end
	})

	return
end

function var_0_1.UpdateStoryTask(arg_35_0)
	local var_35_0 = arg_35_0.activity
	local var_35_1 = var_1.getConfig(var_35_0, "config_client").tasks[1]

	getProxy = var_1_10002
	TaskProxy = var_4

	local var_35_2 = var_1_10002(var_4)
	local var_35_3

	if not var_2.getTaskVO(var_35_2, var_35_1) then
		Task = var_35_3
		var_35_3 = var_35_3.New({
			submit_time = 1,
			id = var_35_1
		})
	end

	arg_35_0.storyTask = var_35_3

	return
end

function var_0_1.UpdateTaskTip(arg_36_0)
	setActive = var_1_10001

	local var_36_0 = arg_36_0.taskTip

	Activity = var_1_10004

	local var_36_1 = var_1_10004.IsActivityReady

	getProxy = var_1_10006
	ActivityProxy = var_1_10008

	local var_36_2 = var_1_10006(var_1_10008)
	local var_36_3 = var_6.getActivityById

	ActivityConst = var_1_10009

	var_1_10001(var_36_0, var_36_1(var_36_3(var_36_2, var_1_10009.ALVIT_TASK_ACT_ID)))

	return
end

function var_0_1.addbubbleMsgBoxList(arg_37_0, arg_37_1)
	local var_37_0 = #arg_37_0.ActionSequence == 0

	table = var_1_10003

	var_1_10003.insertto(arg_37_0.ActionSequence, arg_37_1)

	if not var_37_0 then
		return
	end

	arg_37_0:resumeBubble()

	return
end

function var_0_1.addbubbleMsgBox(arg_38_0, arg_38_1)
	local var_38_0 = #arg_38_0.ActionSequence == 0

	table = var_1_10003

	var_1_10003.insert(arg_38_0.ActionSequence, arg_38_1)

	if not var_38_0 then
		return
	end

	arg_38_0:resumeBubble()

	return
end

function var_0_1.resumeBubble(arg_39_0)
	if #arg_39_0.ActionSequence == 0 then
		return
	end

	local var_39_0

	;(function()
		if arg_39_0.ActionSequence[1] then
			var_0(function()
				table = var_3_10000

				var_3_10000.remove(arg_39_0.ActionSequence, 1)
				var_0()

				return
			end)
		end

		return
	end)()

	return
end

function var_0_1.onBackPressed(arg_42_0)
	local var_42_0 = arg_42_0
	local var_42_1 = arg_42_0.emit

	BossRushAlvitMediator = var_1_10004

	local var_42_2 = var_1_10004.GO_SCENE

	SCENE = var_1_10005

	var_42_1(var_42_0, var_42_2, var_1_10005.KINDERGARTEN, {
		isBack = true
	})

	return
end

function var_0_1.CleanBubbleMsgbox(arg_43_0)
	table = var_1_10001

	var_1_10001.clean(arg_43_0.ActionSequence)

	return
end

return var_0_1
