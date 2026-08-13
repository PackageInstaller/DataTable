class = var_0_10000

local var_0_0 = "BossRushVerZenkerScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.DISPLAY = {
	STORY = "Story",
	BATTLE = "Battle"
}

function var_0_1.getUIName(arg_1_0)
	return "BossRushVerZenkerUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_0, "Top")

	local var_2_1 = arg_2_0.top

	arg_2_0.ptBtn = var_1.Find(var_2_1, "right/pt")
	setText = var_1

	local var_2_2 = arg_2_0.ptBtn
	local var_2_3 = var_2.Find(var_2_2, "Text")

	i18n = var_2_2

	var_1(var_2_3, var_2_2("zengke_series_pt"))

	setText = var_1

	local var_2_4 = arg_2_0.ptBtn
	local var_2_5 = var_2.Find(var_2_4, "Text/en")

	i18n = var_2_4

	var_1(var_2_5, var_2_4("zengke_series_pt_small"))

	local var_2_6 = arg_2_0.ptBtn

	arg_2_0.ptText = var_1.Find(var_2_6, "value/Text")

	local var_2_7 = arg_2_0.ptBtn

	arg_2_0.ptTip = var_1.Find(var_2_7, "tip")

	local var_2_8 = arg_2_0.top

	arg_2_0.rankBtn = var_1.Find(var_2_8, "right/rank")
	setText = var_1

	local var_2_9 = arg_2_0.rankBtn
	local var_2_10 = var_2.Find(var_2_9, "Text")

	i18n = var_2_9

	var_1(var_2_10, var_2_9("zengke_series_rank"))

	setText = var_1

	local var_2_11 = arg_2_0.rankBtn
	local var_2_12 = var_2.Find(var_2_11, "Text/en")

	i18n = var_2_11

	var_1(var_2_12, var_2_11("zengke_series_rank_small"))

	local var_2_13 = arg_2_0.top

	arg_2_0.taskBtn = var_1.Find(var_2_13, "right/task")
	setText = var_1

	local var_2_14 = arg_2_0.taskBtn
	local var_2_15 = var_2.Find(var_2_14, "Text")

	i18n = var_2_14

	var_1(var_2_15, var_2_14("zengke_series_task"))

	setText = var_1

	local var_2_16 = arg_2_0.taskBtn
	local var_2_17 = var_2.Find(var_2_16, "Text/en")

	i18n = var_2_16

	var_1(var_2_17, var_2_16("zengke_series_task_small"))

	local var_2_18 = arg_2_0.taskBtn

	arg_2_0.taskTip = var_1.Find(var_2_18, "tip")
	arg_2_0.seriesNodes = {}
	eachChild = var_1

	local var_2_19 = arg_2_0._tf

	var_1(var_2.Find(var_2_19, "Battle/Nodes"), function(arg_3_0, arg_3_1)
		arg_2_0.seriesNodes[arg_3_0.name] = arg_3_0

		return
	end)

	arg_2_0.nodes = {}
	eachChild = var_1

	local var_2_20 = arg_2_0._tf

	var_1(var_2.Find(var_2_20, "Story/Nodes"), function(arg_4_0, arg_4_1)
		arg_2_0.nodes[arg_4_0.name] = arg_4_0

		return
	end)

	local var_2_21 = arg_2_0.top

	arg_2_0.storyAward = var_1.Find(var_2_21, "bottom/Award")

	local var_2_22 = arg_2_0.storyAward

	arg_2_0.progressText = var_1.Find(var_2_22, "desc")

	local var_2_23 = arg_2_0.top

	arg_2_0.switchToggle = var_1.Find(var_2_23, "bottom/switch_toggle")
	arg_2_0.ActionSequence = {}

	arg_2_0:UpdateRatioScale()

	pg = var_1

	local var_2_24 = var_1.CameraFixMgr.GetInstance()
	local var_2_25 = var_1.bind

	pg = var_3
	arg_2_0.camEventId = var_2_25(var_2_24, var_3.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_2_0

		var_2.UpdateRatioScale(var_5_0)

		return
	end)

	return
end

function var_0_1.SetActivity(arg_6_0, arg_6_1)
	arg_6_0.activity = arg_6_1

	return
end

function var_0_1.SetPtActivity(arg_7_0, arg_7_1)
	arg_7_0.ptActivity = arg_7_1
	ActivityPtData = var_1_10002
	arg_7_0.ptData = var_1_10002.New(arg_7_0.ptActivity)

	return
end

function var_0_1.didEnter(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.top
	local var_8_2 = var_3.Find(var_8_1, "top/back")

	local function var_8_3()
		local var_9_0 = arg_8_0

		var_0.closeView(var_9_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_8_0, var_8_2, var_8_3, var_5)

	onButton = var_1_10001

	local var_8_4 = arg_8_0
	local var_8_5 = arg_8_0.top
	local var_8_6 = var_3.Find(var_8_5, "top/home")

	local function var_8_7()
		local var_10_0 = arg_8_0

		var_0.quickExitFunc(var_10_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_8_4, var_8_6, var_8_7, var_5)

	onButton = var_1_10001

	local var_8_8 = arg_8_0
	local var_8_9 = arg_8_0.top
	local var_8_10 = var_3.Find(var_8_9, "top/help")

	local function var_8_11()
		pg = var_2_10000

		local var_11_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_11_1 = var_0.ShowMsgBox
		local var_11_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_11_2.type = var_2_10003
		i18n = var_2_10003
		var_11_2.helps = var_2_10003("zengke_series_help")

		var_11_1(var_11_0, var_11_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_8_8, var_8_10, var_8_11, var_5)

	onButton = var_1_10001

	local var_8_12 = arg_8_0
	local var_8_13 = arg_8_0.rankBtn

	local function var_8_14()
		local var_12_0 = arg_8_0
		local var_12_1 = var_0.emit

		BossRushVerZenkerMediator = var_2_10002

		var_12_1(var_12_0, var_2_10002.ON_EXTRA_RANK)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_8_12, var_8_13, var_8_14, var_5)

	onButton = var_1_10001

	local var_8_15 = arg_8_0
	local var_8_16 = arg_8_0.ptBtn

	local function var_8_17()
		local var_13_0 = arg_8_0
		local var_13_1 = var_0.emit

		BossRushVerZenkerMediator = var_2_10002

		local var_13_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_13_1(var_13_0, var_13_2, var_2_10003.ACTIVITY, {
			id = arg_8_0.ptActivity.id
		})

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_8_15, var_8_16, var_8_17, var_5)

	onButton = var_1_10001

	local var_8_18 = arg_8_0
	local var_8_19 = arg_8_0.taskBtn

	local function var_8_20()
		local var_14_0 = arg_8_0
		local var_14_1 = var_0.emit

		BossRushVerZenkerMediator = var_2_10002

		local var_14_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_14_1(var_14_0, var_14_2, var_2_10003.TASK)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_8_18, var_8_19, var_8_20, var_5)

	onToggle = var_1_10001

	local var_8_21 = arg_8_0
	local var_8_22 = arg_8_0.switchToggle
	local var_8_23 = var_3.Find(var_8_22, "Story")

	local function var_8_24(arg_15_0)
		if arg_15_0 then
			local var_15_0

			if arg_8_0.blockAnim then
				var_15_0 = arg_8_0
				var_15_0.blockAnim = false
			else
				quickPlayAnimation = var_15_0

				var_15_0(arg_8_0._tf, "anim_BRVZ_change")
			end

			local var_15_1 = arg_8_0

			var_1.SetDisplayMode(var_15_1, var_0_1.DISPLAY.STORY)
		end

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_8_21, var_8_23, var_8_24, var_5)

	onToggle = var_1_10001

	local var_8_25 = arg_8_0
	local var_8_26 = arg_8_0.switchToggle
	local var_8_27 = var_3.Find(var_8_26, "Battle")

	local function var_8_28(arg_16_0)
		if arg_16_0 then
			local var_16_0

			if arg_8_0.blockAnim then
				var_16_0 = arg_8_0
				var_16_0.blockAnim = false
			else
				quickPlayAnimation = var_16_0

				var_16_0(arg_8_0._tf, "anim_BRVZ_change")
			end

			local var_16_1 = arg_8_0

			var_1.SetDisplayMode(var_16_1, var_0_1.DISPLAY.BATTLE)
		end

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_8_25, var_8_27, var_8_28, var_5)

	arg_8_0.storyNodesDict = {}
	ipairs = var_1

	local var_8_29 = arg_8_0.activity

	for iter_8_0, iter_8_1 in var_1(var_2.getConfig(var_8_29, "config_client").storys) do
		local var_8_30 = arg_8_0.storyNodesDict

		BossRushStoryNode = var_1_10007
		var_8_30[iter_8_1] = var_1_10007.New({
			id = iter_8_1
		})
	end

	arg_8_0.blockAnim = true
	triggerToggle = var_1

	local var_8_31 = arg_8_0.switchToggle
	local var_8_32 = var_2.Find
	local var_8_33

	if not arg_8_0.contextData.displayMode then
		var_8_33 = var_0_1.DISPLAY.BATTLE
	end

	var_1(var_8_32(var_8_31, var_8_33), true)

	return
end

function var_0_1.getBGM(arg_17_0)
	if arg_17_0.contextData.displayMode ~= var_0_1.DISPLAY.STORY then
		return var_0_1.super.getBGM(arg_17_0)
	else
		local var_17_0 = arg_17_0.activity
		local var_17_1 = var_1.getConfig(var_17_0, "config_client").storybgm

		pg = var_17_0

		local var_17_2 = var_17_0.TimeMgr.GetInstance()
		local var_17_3 = var_2.GetServerHour(var_17_2)
		local var_17_4 = var_17_1[#var_17_1][2]

		ipairs = var_1_10004

		for iter_17_0, iter_17_1 in var_1_10004(var_17_1) do
			if var_17_3 < iter_17_1[1] then
				break
			else
				var_17_4 = iter_17_1[2]
			end
		end

		return var_17_4
	end

	return
end

function var_0_1.getBG(arg_18_0)
	if arg_18_0.contextData.displayMode ~= var_0_1.DISPLAY.STORY then
		local var_18_0 = arg_18_0.activity
		local var_18_1 = var_1.getConfig(var_18_0, "config_client").levelbg

		pg = var_18_0

		local var_18_2 = var_18_0.TimeMgr.GetInstance()
		local var_18_3 = var_2.GetServerHour(var_18_2)
		local var_18_4 = var_18_1[#var_18_1][2]

		ipairs = var_1_10004

		for iter_18_0, iter_18_1 in var_1_10004(var_18_1) do
			if var_18_3 < iter_18_1[1] then
				break
			else
				var_18_4 = iter_18_1[2]
			end
		end

		return var_18_4
	else
		local var_18_5 = arg_18_0.activity
		local var_18_6 = var_1.getConfig(var_18_5, "config_client").storybg
		local var_18_7

		pg = var_3

		local var_18_8 = var_3.NewStoryMgr.GetInstance()

		ipairs = var_1_10004

		for iter_18_2, iter_18_3 in var_1_10004(var_18_6) do
			if iter_18_3[1] == "default" or var_18_8:IsPlayed(iter_18_3[1]) then
				var_18_7 = iter_18_3[2]
			else
				break
			end
		end

		return var_18_7
	end

	return
end

function var_0_1.SetDisplayMode(arg_19_0, arg_19_1)
	arg_19_0.contextData.displayMode = arg_19_1

	arg_19_0:UpdateView()

	return
end

function var_0_1.UpdateRatioScale(arg_20_0, arg_20_1)
	local var_20_0

	ipairs = var_1_10003

	for iter_20_0, iter_20_1 in var_1_10003({
		"Mask",
		"Battle",
		"Story"
	}) do
		local var_20_1 = arg_20_0._tf
		local var_20_2 = var_8.Find(var_20_1, iter_20_1).rect.height

		var_20_0 = var_20_0 or 1440 < var_20_2 and var_20_2 / 1440 or 1
		setLocalScale = var_10

		var_10(var_8, {
			x = var_20_0,
			y = var_20_0
		})
	end

	return
end

function var_0_1.UpdateView(arg_21_0)
	local var_21_0 = arg_21_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE

	setActive = var_2

	local var_21_1 = arg_21_0._tf

	var_2(var_3.Find(var_21_1, "Battle"), var_21_0)

	setActive = var_2

	local var_21_2 = arg_21_0._tf

	var_2(var_3.Find(var_21_2, "Story"), not var_21_0)

	setActive = var_2

	var_2(arg_21_0.storyAward, not var_21_0)

	if var_21_0 then
		arg_21_0:UpdateBattle()
	else
		arg_21_0:UpdateStory()
	end

	arg_21_0:UpdateStoryTask()

	local var_21_3 = arg_21_0
	local var_21_4 = arg_21_0.getBG(var_21_3)

	eachChild = var_21_3

	local var_21_5 = arg_21_0._tf

	var_21_3(var_4.Find(var_21_5, "Mask"), function(arg_22_0, arg_22_1)
		setActive = var_2_10002

		var_2_10002(arg_22_0, arg_22_0.name == var_21_4 or arg_22_0.name == "FX")

		return
	end)
	arg_21_0:PlayBGM()

	setText = var_3

	var_3(arg_21_0.ptText, arg_21_0.ptActivity.data1)

	setActive = var_3

	local var_21_6 = arg_21_0.ptTip

	Activity = var_5

	var_3(var_21_6, var_5.IsActivityReady(arg_21_0.ptActivity))

	local var_21_7 = arg_21_0.contextData.displayMode

	arg_21_0:addbubbleMsgBoxList({
		function(arg_23_0)
			local var_23_0

			if var_21_7 == var_0_1.DISPLAY.BATTLE then
				local var_23_1 = arg_21_0.activity

				var_23_0 = var_2.getConfig(var_23_1, "config_client").openActivityStory
			elseif var_21_7 == var_0_1.DISPLAY.STORY then
				local var_23_2 = arg_21_0.activity

				var_23_0 = var_2.getConfig(var_23_2, "config_client").openStory
			end

			local var_23_3 = arg_21_0

			var_2.PlayStory(var_23_3, var_23_0, arg_23_0)

			return
		end,
		function(arg_24_0)
			underscore = var_2_10001

			local var_24_0 = var_2_10001.all

			underscore = var_2_10002

			if var_24_0(var_2_10002.values(arg_21_0.storyNodesDict), function(arg_25_0)
				return arg_25_0:IsReaded()
			end) and arg_21_0.storyTask then
				local var_24_1 = arg_21_0.storyTask

				if var_1.getTaskStatus(var_24_1) == 2 then
					local var_24_2 = arg_21_0.activity
					local var_24_3 = var_1.getConfig(var_24_2, "config_client").endStory
					local var_24_4 = arg_21_0

					var_2.PlayStory(var_24_4, var_24_3, arg_24_0)

					goto label_24_0
				end
			end

			arg_24_0()

			::label_24_0::

			return
		end
	})

	return
end

function var_0_1.UpdateBattle(arg_26_0)
	local var_26_0 = arg_26_0.activity

	ipairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(var_26_0:GetActiveSeriesIds()) do
		local var_26_1 = arg_26_0.seriesNodes

		tostring = var_1_10008

		local var_26_2 = var_26_1[var_1_10008(iter_26_1)]

		BossRushSeriesData = var_1_10008

		local var_26_3 = var_1_10008.New({
			id = iter_26_1,
			actId = var_26_0.id
		})
		local var_26_4 = var_1_10008.IsUnlock(var_26_3, var_26_0)

		setActive = var_26_3

		var_26_3(var_26_2, var_26_4)

		local var_26_5 = var_1_10008
		local var_26_6 = var_1_10008.GetType(var_26_5)

		setActive = var_26_5

		local var_26_7 = var_26_2
		local var_26_8 = var_26_2.Find(var_26_7, "blue")

		BossRushSeriesData = var_26_7

		var_26_5(var_26_8, var_26_6 == var_26_7.TYPE.NORMAL)

		setActive = var_26_5

		local var_26_9 = var_26_2
		local var_26_10 = var_26_2.Find(var_26_9, "red")

		BossRushSeriesData = var_26_9

		var_26_5(var_26_10, var_26_6 ~= var_26_9.TYPE.NORMAL)

		local var_26_11

		BossRushSeriesData = var_26_10

		if var_26_6 == var_26_10.TYPE.NORMAL then
			var_26_11 = var_26_2:Find("blue")
		else
			var_26_11 = var_26_2:Find("red")
		end

		setText = var_12

		var_12(var_26_11:Find("Text"), var_1_10008:GetName())

		setText = var_12

		local var_26_12 = var_26_11
		local var_26_13 = var_26_11.Find(var_26_12, "diff/Text")

		switch = var_26_12

		local var_26_14 = iter_26_1
		local var_26_15 = {
			[3001] = function()
				i18n = var_2_10000

				return var_2_10000("zengke_series_easy")
			end,
			[3002] = function()
				i18n = var_2_10000

				return var_2_10000("zengke_series_normal")
			end,
			[3003] = function()
				i18n = var_2_10000

				return var_2_10000("zengke_series_hard")
			end,
			[3004] = function()
				i18n = var_2_10000

				return var_2_10000("zengke_series_sp")
			end
		}

		local function var_26_16()
			i18n = var_2_10000

			return var_2_10000("zengke_series_ex")
		end

		var_26_15[3005] = var_26_16

		var_12(var_26_13, var_26_12(var_26_14, var_26_15))

		BossRushSeriesData = var_12

		local var_26_17 = var_26_6 == var_12.TYPE.SP

		setActive = var_26_13

		var_26_13(var_26_2:Find("times"), var_26_17)

		local var_26_18 = true
		local var_26_19, var_26_20

		if var_26_17 then
			if not var_26_0:GetUsedBonus()[iter_26_0] then
				var_26_19 = 0
			end

			var_26_18 = var_1_10008:GetMaxBonusCount() - var_26_19 > 0
			setText = var_16
			var_26_20 = var_26_2

			local var_26_21 = var_26_2.Find(var_26_20, "times/Text")

			i18n = var_26_20
			var_26_20 = var_26_20("series_enemy_SP_count")
			setColorStr = var_19
			math = var_1_10020

			var_16(var_26_21, var_26_20 .. var_19(var_1_10020.max(0, var_15 - var_26_19) .. "/" .. var_15, var_26_18 and "#6EE868" or "#7f7f7f"))
		end

		onButton = var_26_19

		local var_26_22 = arg_26_0
		local var_26_23 = var_26_2

		local function var_26_24()
			if not var_26_4 then
				local var_32_0 = var_1_10008
				local var_32_1 = var_0.GetPreSeriesId(var_32_0)

				BossRushSeriesData = var_32_0

				local var_32_2 = var_32_0.New({
					id = var_32_1
				})

				pg = var_2_10002

				local var_32_3 = var_2_10002.TipsMgr.GetInstance()

				var_2_10002 = var_2_10002.ShowTips
				i18n = var_2_10004

				var_2_10002(var_32_3, var_2_10004("series_enemy_unlock", var_32_2:GetName()))

				return
			end

			if not var_26_18 then
				pg = var_0

				local var_32_4 = var_0.TipsMgr.GetInstance()
				local var_32_5 = var_0.ShowTips

				i18n = var_2_10002

				var_32_5(var_32_4, var_2_10002("series_enemy_SP_error"))

				return
			end

			local var_32_6 = arg_26_0
			local var_32_7 = var_0.emit

			BossRushVerZenkerMediator = var_2_10002

			var_32_7(var_32_6, var_2_10002.ON_FLEET_SELECT, var_1_10008)

			return
		end

		SFX_PANEL = var_26_20

		var_26_19(var_26_22, var_26_23, var_26_24, var_26_20)
	end

	return
end

function var_0_1.UpdateStory(arg_33_0)
	pg = var_1_10001

	local var_33_0 = var_1_10001.NewStoryMgr.GetInstance()
	local var_33_1 = 0
	local var_33_2 = 0

	pairs = var_1_10004

	for iter_33_0, iter_33_1 in var_1_10004(arg_33_0.storyNodesDict) do
		local var_33_3 = arg_33_0.nodes

		tostring = var_1_10010

		local var_33_4 = var_33_3[var_1_10010(iter_33_1.id)]

		var_1_10011 = iter_33_1
		var_1_10010 = iter_33_1.IsActive(var_1_10011, arg_33_0.activity, arg_33_0.ptActivity)
		setActive = var_1_10011

		var_1_10011(var_33_4, var_1_10010)

		setText = var_1_10011

		var_1_10011(var_33_4:Find("main/char/bg/Text"), iter_33_1:GetName())

		var_33_1 = var_33_1 + (iter_33_1:IsReaded() and 1 or 0)
		var_33_2 = var_33_2 + 1
		setActive = var_12

		var_12(var_33_4:Find("main/char"), not var_1_10011)

		setActive = var_12

		var_12(var_33_4:Find("main/talk"), var_1_10011)

		onButton = var_12

		var_12(arg_33_0, var_33_4, function()
			if not var_1_10010 or var_1_10011 then
				return
			end

			local var_34_0 = iter_33_1
			local var_34_1 = var_0.GetStory(var_34_0)
			local var_34_2 = arg_33_0

			var_1.PlayStory(var_34_2, var_34_1, function()
				local var_35_0 = arg_33_0

				var_0.UpdateView(var_35_0)

				return
			end)

			return
		end)
	end

	setText = var_4

	local var_33_5 = arg_33_0.progressText

	i18n = var_6

	var_4(var_33_5, var_6("zengke_story_reward_count") .. var_33_1 .. "/" .. var_33_2)

	setActive = var_4

	local var_33_6 = arg_33_0.storyAward

	tobool = var_6

	var_4(var_33_6, var_6(arg_33_0.storyTask))

	if arg_33_0.storyTask then
		local var_33_7 = arg_33_0.storyTask
		local var_33_8 = var_4.getConfig(var_33_7, "award_display")

		Drop = var_33_7

		local var_33_9 = var_33_7.Create(var_33_8[1])
		local var_33_10 = arg_33_0.storyAward
		local var_33_11 = var_6.Find(var_33_10, "award_bg")

		updateDrop = var_33_10

		var_33_10(var_33_11:Find("IconTpl"), var_33_9)

		onButton = var_33_10

		local var_33_12 = arg_33_0
		local var_33_13 = var_33_11

		local function var_33_14()
			local var_36_0 = arg_33_0
			local var_36_1 = var_0.emit

			BaseUI = var_2_10002

			var_36_1(var_36_0, var_2_10002.ON_DROP, var_33_9)

			return
		end

		SFX_PANEL = var_1_10011

		var_33_10(var_33_12, var_33_13, var_33_14, var_1_10011)

		local var_33_15 = arg_33_0.storyTask
		local var_33_16 = var_7.getTaskStatus(var_33_15)

		setActive = var_33_15

		var_33_15(var_33_11:Find("get"), var_33_16 == 1)

		setActive = var_33_15

		var_33_15(var_33_11:Find("got"), var_33_16 == 2)
	end

	return
end

function var_0_1.PlayStory(arg_37_0, arg_37_1, arg_37_2)
	if not arg_37_1 then
		existCall = var_1_10003

		return var_1_10003(arg_37_2)
	end

	pg = var_1_10003

	local var_37_0 = var_1_10003.NewStoryMgr.GetInstance()
	local var_37_1 = var_3.IsPlayed(var_37_0, arg_37_1)

	seriesAsync = var_37_0

	var_37_0({
		function(arg_38_0)
			if var_37_1 then
				return arg_38_0()
			end

			tonumber = var_1

			if var_1(arg_37_1) and var_1 > 0 then
				local var_38_0 = arg_37_0
				local var_38_1 = var_2.emit

				BossRushVerZenkerMediator = var_2_10004

				var_38_1(var_38_0, var_2_10004.ON_PERFORM_COMBAT, var_1)
			else
				local var_38_2 = var_0

				var_2.Play(var_38_2, arg_37_1, arg_38_0)
			end

			return
		end
	}, arg_37_2)

	return
end

function var_0_1.UpdateStoryTask(arg_39_0)
	local var_39_0 = arg_39_0.activity
	local var_39_1 = var_1.getConfig(var_39_0, "config_client").tasks[1]

	getProxy = var_39_0
	TaskProxy = var_3

	local var_39_2 = var_39_0(var_3)
	local var_39_3

	if not var_2.getTaskVO(var_39_2, var_39_1) then
		Task = var_39_3
		var_39_3 = var_39_3.New({
			submit_time = 1,
			id = var_39_1
		})
	end

	arg_39_0.storyTask = var_39_3
	setActive = var_39_3

	local var_39_4 = arg_39_0.switchToggle
	local var_39_5 = var_3.Find(var_39_4, "Story/new")
	local var_39_6, var_39_7

	if arg_39_0.storyTask then
		var_39_6 = arg_39_0.storyTask
		var_39_7 = var_4.getTaskStatus(var_39_6) ~= 2
	end

	var_39_3(var_39_5, var_39_7)

	setActive = var_39_3

	local var_39_8 = arg_39_0.taskTip

	Activity = var_39_7

	local var_39_9 = var_39_7.IsActivityReady

	getProxy = var_39_6
	ActivityProxy = var_1_10006

	local var_39_10 = var_39_6(var_1_10006)
	local var_39_11 = var_5.getActivityById

	ActivityConst = var_1_10007

	var_39_3(var_39_8, var_39_9(var_39_11(var_39_10, var_1_10007.ZENGKEHAIJUNSHANGJIANG_TASK_ACT_ID)))

	local var_39_12 = arg_39_0.storyTask
	local var_39_13 = var_2.getConfig(var_39_12, "award_display")

	Drop = var_39_12

	local var_39_14 = var_39_12.Create(var_39_13[1])
	local var_39_15 = arg_39_0.storyAward
	local var_39_16 = var_4.Find(var_39_15, "award_bg")

	updateDrop = var_39_15

	var_39_15(var_39_16:Find("IconTpl"), var_39_14)

	onButton = var_39_15

	local var_39_17 = arg_39_0
	local var_39_18 = var_39_16

	local function var_39_19()
		local var_40_0 = arg_39_0
		local var_40_1 = var_0.emit

		BaseUI = var_2_10002

		var_40_1(var_40_0, var_2_10002.ON_DROP, var_39_14)

		return
	end

	SFX_PANEL = var_1_10009

	var_39_15(var_39_17, var_39_18, var_39_19, var_1_10009)

	local var_39_20 = arg_39_0.storyTask
	local var_39_21 = var_5.getTaskStatus(var_39_20)

	setActive = var_39_20

	var_39_20(var_39_16:Find("get"), var_39_21 == 1)

	setActive = var_39_20

	var_39_20(var_39_16:Find("got"), var_39_21 == 2)

	if var_39_21 == 1 then
		local var_39_22 = arg_39_0
		local var_39_23 = arg_39_0.emit

		BossRushVerZenkerMediator = var_8

		var_39_23(var_39_22, var_8.ON_TASK_SUBMIT, arg_39_0.storyTask)
	end

	return
end

function var_0_1.addbubbleMsgBoxList(arg_41_0, arg_41_1)
	local var_41_0 = #arg_41_0.ActionSequence == 0

	table = var_1_10003

	var_1_10003.insertto(arg_41_0.ActionSequence, arg_41_1)

	if not var_41_0 then
		return
	end

	arg_41_0:resumeBubble()

	return
end

function var_0_1.addbubbleMsgBox(arg_42_0, arg_42_1)
	local var_42_0 = #arg_42_0.ActionSequence == 0

	table = var_1_10003

	var_1_10003.insert(arg_42_0.ActionSequence, arg_42_1)

	if not var_42_0 then
		return
	end

	arg_42_0:resumeBubble()

	return
end

function var_0_1.resumeBubble(arg_43_0)
	if #arg_43_0.ActionSequence == 0 then
		return
	end

	local var_43_0

	;(function()
		if arg_43_0.ActionSequence[1] then
			var_0(function()
				table = var_3_10000

				var_3_10000.remove(arg_43_0.ActionSequence, 1)
				var_0()

				return
			end)
		end

		return
	end)()

	return
end

function var_0_1.CleanBubbleMsgbox(arg_46_0)
	table = var_1_10001

	var_1_10001.clean(arg_46_0.ActionSequence)

	return
end

function var_0_1.willExit(arg_47_0)
	if arg_47_0.camEventId then
		pg = var_1

		local var_47_0 = var_1.CameraFixMgr.GetInstance()

		var_1.disconnect(var_47_0, arg_47_0.camEventId)

		arg_47_0.camEventId = nil
	end

	return
end

return var_0_1
