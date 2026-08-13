class = var_0_10000

local var_0_0 = "BossRushKurskScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

require = var_0_0

local var_0_2 = var_0_0("Mgr/Pool/PoolPlural")

var_0_1.DISPLAY = {
	STORY = 2,
	BATTLE = 1
}

function var_0_1.getUIName(arg_1_0)
	return "BossRushKurskUI"
end

function var_0_1.GetAtalsName(arg_2_0)
	return "ui/BossRushKurskUI_atlas"
end

function var_0_1.ResUISettings(arg_3_0)
	return true
end

function var_0_1.Ctor(arg_4_0)
	var_0_1.super.Ctor(arg_4_0)

	AutoLoader = var_1
	arg_4_0.loader = var_1.New()

	return
end

function var_0_1.preload(arg_5_0, arg_5_1)
	existCall = var_1_10002

	var_1_10002(arg_5_1)

	local var_5_0 = arg_5_0.loader

	var_2.LoadBundle(var_5_0, arg_5_0:GetAtalsName())

	return
end

function var_0_1.init(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.top = var_1.Find(var_6_0, "Top")

	local var_6_1 = arg_6_0._tf

	arg_6_0.map = var_1.Find(var_6_1, "Map")

	local var_6_2 = arg_6_0._tf
	local var_6_3 = var_1.Find(var_6_2, "Battle/Nodes")

	arg_6_0.seriesNodes = {}

	for iter_6_0 = 1, var_6_3.childCount do
		local var_6_4 = var_6_3
		local var_6_5 = var_6_3.GetChild(var_6_4, iter_6_0 - 1)

		isActive = var_6_4

		if var_6_4(var_6_5) then
			table = var_7

			var_7.insert(arg_6_0.seriesNodes, var_6_5)
		end
	end

	local var_6_6 = arg_6_0._tf

	arg_6_0.ptText = var_2.Find(var_6_6, "Battle/Reward/Text")
	arg_6_0.nodes = {}

	local var_6_7 = 1
	local var_6_8 = arg_6_0._tf

	for iter_6_1 = var_6_7, var_3.Find(var_6_8, "Map").childCount do
		local var_6_9 = arg_6_0._tf
		local var_6_10 = var_6.Find(var_6_9, "Map")
		local var_6_11 = var_6.GetChild(var_6_10, iter_6_1 - 1)

		arg_6_0.nodes[var_6_11.name] = {
			tfType = 1,
			trans = var_6_11
		}
	end

	local var_6_12 = 1
	local var_6_13 = arg_6_0._tf

	for iter_6_2 = var_6_12, var_3.Find(var_6_13, "Story/Nodes").childCount do
		local var_6_14 = arg_6_0._tf
		local var_6_15 = var_6.Find(var_6_14, "Story/Nodes")
		local var_6_16 = var_6.GetChild(var_6_15, iter_6_2 - 1)

		arg_6_0.nodes[var_6_16.name] = {
			tfType = 2,
			trans = var_6_16
		}
	end

	pg = var_6_12
	arg_6_0.pluralRoot = var_6_12.PoolMgr.GetInstance().root
	go = var_2

	local var_6_17 = arg_6_0._tf
	local var_6_18 = var_2(var_3.Find(var_6_17, "Link"))

	setActive = var_3

	var_3(var_6_18, false)

	arg_6_0.plural = var_0_2.New(var_6_18, 32)

	local var_6_19 = arg_6_0._tf

	arg_6_0.linksContainer = var_3.Find(var_6_19, "Links")
	arg_6_0.links = {}

	local var_6_20 = arg_6_0._tf

	arg_6_0.storyBar = var_3.Find(var_6_20, "Story/StoryBar")

	local var_6_21 = arg_6_0._tf

	arg_6_0.storyAward = var_3.Find(var_6_21, "Story/PassLevel/Award")
	arg_6_0.ActionSequence = {}
	setText = var_3

	local var_6_22 = arg_6_0._tf
	local var_6_23 = var_4.Find(var_6_22, "Battle/Rank/Title")

	i18n = var_6_22

	var_3(var_6_23, var_6_22("word_billboard"))

	setText = var_3

	local var_6_24 = arg_6_0._tf
	local var_6_25 = var_4.Find(var_6_24, "Battle/Reward/Title")

	i18n = var_6_24

	var_3(var_6_25, var_6_24("series_enemy_reward"))

	setText = var_3

	local var_6_26 = arg_6_0._tf
	local var_6_27 = var_4.Find(var_6_26, "Story/PassLevel/Title")

	i18n = var_6_26

	var_3(var_6_27, var_6_26("series_enemy_storyreward"))

	setText = var_3

	local var_6_28 = arg_6_0._tf
	local var_6_29 = var_4.Find(var_6_28, "Story/PassLevel/PT/Tips")

	i18n = var_6_28

	var_3(var_6_29, var_6_28("series_enemy_storyunlock"))

	return
end

function var_0_1.SetActivity(arg_7_0, arg_7_1)
	arg_7_0.activity = arg_7_1

	return
end

function var_0_1.SetPtActivity(arg_8_0, arg_8_1)
	arg_8_0.ptActivity = arg_8_1
	ActivityPtData = var_1_10002
	arg_8_0.ptData = var_1_10002.New(arg_8_0.ptActivity)

	return
end

function var_0_1.didEnter(arg_9_0)
	onButton = var_1_10001

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.top
	local var_9_2 = var_3.Find(var_9_1, "back_btn")

	local function var_9_3()
		local var_10_0 = arg_9_0

		var_0.onBackPressed(var_10_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_9_0, var_9_2, var_9_3, var_5)

	onButton = var_1_10001

	local var_9_4 = arg_9_0
	local var_9_5 = arg_9_0.top
	local var_9_6 = var_3.Find(var_9_5, "option")

	local function var_9_7()
		local var_11_0 = arg_9_0

		var_0.quickExitFunc(var_11_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_9_4, var_9_6, var_9_7, var_5)

	onButton = var_1_10001

	local var_9_8 = arg_9_0
	local var_9_9 = arg_9_0._tf
	local var_9_10 = var_3.Find(var_9_9, "Help")

	local function var_9_11()
		pg = var_2_10000

		local var_12_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_12_2.type = var_2_10003

		local var_12_3 = {}
		local var_12_4 = {}

		i18n = var_2_10005
		var_12_4.info = var_2_10005("series_enemy_help")
		var_12_3[1] = var_12_4
		var_12_2.helps = var_12_3

		var_12_1(var_12_0, var_12_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_9_8, var_9_10, var_9_11, var_5)

	onButton = var_1_10001

	local var_9_12 = arg_9_0
	local var_9_13 = arg_9_0._tf
	local var_9_14 = var_3.Find(var_9_13, "Battle/Rank")

	local function var_9_15()
		local var_13_0 = arg_9_0
		local var_13_1 = var_0.emit

		BossRushKurskMediator = var_2_10002

		var_13_1(var_13_0, var_2_10002.ON_EXTRA_RANK)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_9_12, var_9_14, var_9_15, var_5)

	onButton = var_1_10001

	local var_9_16 = arg_9_0
	local var_9_17 = arg_9_0._tf
	local var_9_18 = var_3.Find(var_9_17, "Battle/Reward")

	local function var_9_19()
		local var_14_0 = arg_9_0
		local var_14_1 = var_0.emit

		BossRushKurskMediator = var_2_10002

		var_14_1(var_14_0, var_2_10002.GO_ACT_SHOP, arg_9_0.ptData)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_9_16, var_9_18, var_9_19, var_5)

	onButton = var_1_10001

	local var_9_20 = arg_9_0
	local var_9_21 = arg_9_0._tf
	local var_9_22 = var_3.Find(var_9_21, "Battle/Story")

	local function var_9_23()
		local var_15_0 = arg_9_0

		var_0.SetDisplayMode(var_15_0, var_0_1.DISPLAY.STORY)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_9_20, var_9_22, var_9_23, var_5)

	onButton = var_1_10001

	local var_9_24 = arg_9_0
	local var_9_25 = arg_9_0._tf
	local var_9_26 = var_3.Find(var_9_25, "Story/Battle")

	local function var_9_27()
		local var_16_0 = arg_9_0

		var_0.SetDisplayMode(var_16_0, var_0_1.DISPLAY.BATTLE)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_9_24, var_9_26, var_9_27, var_5)

	local var_9_28 = arg_9_0.activity
	local var_9_29

	if not var_1.getConfig(var_9_28, "config_client").storys then
		var_9_29 = {}
	end

	arg_9_0.storyNodesDict = {}
	_ = var_2

	var_2.each(var_9_29, function(arg_17_0)
		local var_17_0 = arg_9_0.storyNodesDict

		BossRushStoryNode = var_2_10002
		var_17_0[arg_17_0] = var_2_10002.New({
			id = arg_17_0
		})

		return
	end)

	local var_9_30 = arg_9_0.activity
	local var_9_31

	if not var_2.getConfig(var_9_30, "config_client").tasks then
		var_9_31 = {}
	end

	if #var_9_31 > 0 then
		local var_9_32 = arg_9_0.activity
		local var_9_33 = var_3.getConfig(var_9_32, "config_client").tasks[1]

		getProxy = var_9_32
		TaskProxy = var_5

		local var_9_34 = var_9_32(var_5)
		local var_9_35

		if not var_4.getTaskVO(var_9_34, var_9_33) then
			Task = var_9_35
			var_9_35 = var_9_35.New({
				submitTime = 1,
				id = var_9_33
			})
		end

		arg_9_0.storyTask = var_9_35
	end

	local var_9_36

	if not arg_9_0.contextData.displayMode then
		BossRushKurskScene = var_9_36
		var_9_36 = var_9_36.DISPLAY.BATTLE
	end

	arg_9_0.contextData.displayMode = nil

	arg_9_0:SetDisplayMode(var_9_36)

	return
end

function var_0_1.getBGM(arg_18_0)
	pg = var_1_10001

	if not var_1_10001.voice_bgm[arg_18_0.__cname] then
		return nil
	end

	local var_18_0 = var_1.bgm
	local var_18_1 = "battle-deepecho"

	if arg_18_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE then
		return var_18_0
	elseif var_4 == var_0_1.DISPLAY.STORY then
		return var_18_1
	end

	return
end

function var_0_1.SetDisplayMode(arg_19_0, arg_19_1)
	if arg_19_1 == arg_19_0.contextData.displayMode then
		return
	end

	arg_19_0.contextData.displayMode = arg_19_1

	arg_19_0:PlayBGM()
	arg_19_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_20_0)
	local var_20_0 = arg_20_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE

	setActive = var_2

	local var_20_1 = arg_20_0._tf

	var_2(var_3.Find(var_20_1, "Battle"), var_20_0)

	setActive = var_2

	local var_20_2 = arg_20_0._tf

	var_2(var_3.Find(var_20_2, "Story"), not var_20_0)

	setActive = var_2

	local var_20_3 = arg_20_0._tf

	var_2(var_3.Find(var_20_3, "Links"), not var_20_0)
	arg_20_0:UpdateBattle()
	arg_20_0:UpdateStory()

	local var_20_4 = arg_20_0.contextData.displayMode

	arg_20_0:addbubbleMsgBoxList({
		function(arg_21_0)
			local var_21_0 = arg_20_0.activity

			if var_1.HasPassSeries(var_21_0, 1001) then
				pg = var_1

				local var_21_1 = var_1.SystemGuideMgr.GetInstance()

				var_1.PlayByGuideId(var_21_1, "NG0036", nil, arg_21_0)

				return
			end

			arg_21_0()

			return
		end,
		function(arg_22_0)
			local var_22_0

			if var_20_4 == var_0_1.DISPLAY.BATTLE then
				local var_22_1 = arg_20_0.activity

				var_22_0 = var_2.getConfig(var_22_1, "config_client").openActivityStory
			elseif var_20_4 == var_0_1.DISPLAY.STORY then
				local var_22_2 = arg_20_0.activity

				var_22_0 = var_2.getConfig(var_22_2, "config_client").openStory
			end

			local var_22_3 = arg_20_0

			var_2.PlayStory(var_22_3, var_22_0, arg_22_0)

			return
		end,
		function(arg_23_0)
			underscore = var_2_10001

			local var_23_0 = var_2_10001.all

			underscore = var_2_10002

			if var_23_0(var_2_10002.values(arg_20_0.storyNodesDict), function(arg_24_0)
				return arg_24_0:IsReaded()
			end) then
				local var_23_1 = arg_20_0.activity
				local var_23_2 = var_1.getConfig(var_23_1, "config_client").endStory
				local var_23_3 = arg_20_0

				var_2.PlayStory(var_23_3, var_23_2, function(arg_25_0)
					arg_23_0()

					if arg_25_0 then
						local var_25_0 = arg_20_0

						var_1.UpdateView(var_25_0)
					end

					return
				end)

				return
			end

			arg_23_0()

			return
		end
	})

	return
end

function var_0_1.UpdateBattle(arg_26_0)
	local var_26_0 = arg_26_0.activity
	local var_26_1 = var_1.GetActiveSeriesIds(var_26_0)

	table = var_26_0

	var_26_0.Foreach(arg_26_0.seriesNodes, function(arg_27_0, arg_27_1)
		local var_27_0 = var_26_1[arg_27_0]

		BossRushSeriesData = var_2_10003

		local var_27_1 = var_2_10003.New({
			id = var_27_0,
			actId = var_0.id
		})
		local var_27_2 = var_3.IsUnlock(var_27_1, var_0)

		setActive = var_27_1

		var_27_1(arg_27_1:Find("Pin/NameBG"), var_27_2)

		setActive = var_27_1

		var_27_1(arg_27_1:Find("Pin/Lock"), not var_27_2)

		setText = var_27_1

		var_27_1(arg_27_1:Find("Pin/ChapterName"), var_3:GetSeriesCode())

		setText = var_27_1

		var_27_1(arg_27_1:Find("Pin/NameBG/Name"), var_3:GetName())

		local var_27_3 = var_3
		local var_27_4 = var_3.GetType(var_27_3)

		BossRushSeriesData = var_27_3

		local var_27_5 = var_27_4 == var_27_3.TYPE.SP

		setActive = var_6

		var_6(arg_27_1:Find("Pin/NameBG/BonusCount"), var_27_2 and var_27_5)

		local var_27_6 = true
		local var_27_8

		if var_27_5 then
			local var_27_7 = var_0

			if not var_27_8.GetUsedBonus(var_27_7)[arg_27_0] then
				var_27_8 = 0
			end

			local var_27_9 = var_3
			local var_27_10 = var_3.GetMaxBonusCount(var_27_9)

			setText = var_27_9
			var_2_10011 = arg_27_1
			var_2_10011 = arg_27_1.Find(var_2_10011, "Pin/NameBG/BonusCount")

			local var_27_11 = var_10.GetChild(var_2_10011, 0)

			i18n = var_2_10011

			var_27_9(var_27_11, var_2_10011("series_enemy_SP_count"))

			setText = var_27_9
			var_2_10011 = arg_27_1
			var_2_10011 = arg_27_1.Find(var_2_10011, "Pin/NameBG/BonusCount")

			local var_27_12 = var_10.GetChild(var_2_10011, 1)

			math = var_2_10011

			var_27_9(var_27_12, var_2_10011.max(0, var_27_10 - var_27_8) .. "/" .. var_27_10)

			var_27_6 = var_27_10 - var_27_8 > 0
		end

		onButton = var_27_8

		local var_27_13 = arg_26_0
		local var_27_14 = arg_27_1

		local function var_27_15()
			if not var_27_2 then
				local var_28_0 = var_0
				local var_28_1 = var_0.GetPreSeriesId(var_28_0)

				BossRushSeriesData = var_28_0

				local var_28_2 = var_28_0.New({
					id = var_28_1
				})

				pg = var_3_10002

				local var_28_3 = var_3_10002.TipsMgr.GetInstance()

				var_3_10002 = var_3_10002.ShowTips
				i18n = var_3_10004

				var_3_10002(var_28_3, var_3_10004("series_enemy_unlock", var_28_2:GetName()))

				return
			end

			if not var_27_6 then
				pg = var_0

				local var_28_4 = var_0.TipsMgr.GetInstance()
				local var_28_5 = var_0.ShowTips

				i18n = var_3_10002

				var_28_5(var_28_4, var_3_10002("series_enemy_SP_error"))

				return
			end

			local var_28_6 = arg_26_0
			local var_28_7 = var_0.emit

			BossRushKurskMediator = var_3_10002

			var_28_7(var_28_6, var_3_10002.ON_FLEET_SELECT, var_0)

			return
		end

		SFX_PANEL = var_2_10011

		var_27_8(var_27_13, var_27_14, var_27_15, var_2_10011)

		return
	end)

	setActive = var_3

	local var_26_2 = arg_26_0._tf
	local var_26_3 = var_4.Find(var_26_2, "Battle/Reward/Tip")
	local var_26_4 = arg_26_0.ptData

	var_3(var_26_3, var_5.CanGetAward(var_26_4))

	setText = var_3

	var_3(arg_26_0.ptText, arg_26_0.ptActivity.data1)

	return
end

local var_0_3 = {
	"story_bar_green",
	"story_bar_yellow",
	"story_bar_purple"
}

function var_0_1.UpdateStory(arg_29_0)
	pg = var_1_10001

	local var_29_0 = var_1_10001.NewStoryMgr.GetInstance()
	local var_29_1 = 0
	local var_29_2 = 0
	local var_29_3
	local var_29_4
	local var_29_5 = arg_29_0

	arg_29_0.ReturnLinks(var_29_5)

	local var_29_6 = false

	table = var_29_5

	var_29_5.Foreach(arg_29_0.storyNodesDict, function(arg_30_0, arg_30_1)
		local var_30_0 = arg_29_0.nodes[arg_30_1:GetIconName()].trans
		local var_30_1 = arg_30_1:IsActive(arg_29_0.activity, arg_29_0.ptActivity)
		local var_30_2 = arg_30_1:IsReaded()
		local var_30_3 = arg_30_1
		local var_30_4 = arg_30_1.GetType(var_30_3)

		BossRushStoryNode = var_30_3

		local var_30_6

		if var_30_4 == var_30_3.NODE_TYPE.NORMAL then
			local var_30_5 = arg_29_0.loader

			var_30_6 = var_30_6.GetSprite

			local var_30_7 = arg_29_0

			var_30_6(var_30_5, var_8.GetAtalsName(var_30_7), var_30_1 and "story_green_active" or "story_green", var_30_0:GetChild(0), true)
		else
			BossRushStoryNode = var_30_6

			local var_30_9

			if var_30_4 == var_30_6.NODE_TYPE.EVENT then
				setActive = var_30_9

				var_30_9(var_30_0, var_30_1)

				local var_30_8 = arg_29_0.loader

				var_30_9 = var_30_9.GetSprite

				local var_30_10 = arg_29_0

				var_30_9(var_30_8, var_8.GetAtalsName(var_30_10), var_30_1 and "story_yellow_active" or "story_yellow", var_30_0:GetChild(0), true)
			else
				BossRushStoryNode = var_30_9

				if var_30_4 == var_30_9.NODE_TYPE.BATTLE then
					-- block empty
				end
			end
		end

		if var_30_1 then
			local var_30_11 = arg_29_0._tf
			local var_30_12 = var_6.Find(var_30_11, "Story")
			local var_30_13 = var_6.InverseTransformPoint(var_30_12, var_30_0.position)

			setAnchoredPosition = var_30_12

			var_30_12(arg_29_0.storyBar, var_30_13)

			setText = var_30_12

			local var_30_14 = arg_29_0.storyBar

			var_30_12(var_8.Find(var_30_14, "Text"), arg_30_1:GetName())

			local var_30_15 = arg_29_0.loader
			local var_30_16 = var_7.GetSprite
			local var_30_17 = arg_29_0

			var_30_16(var_30_15, var_9.GetAtalsName(var_30_17), var_0_3[var_30_4], arg_29_0.storyBar, true)

			onButton = var_30_16

			var_30_16(arg_29_0, arg_29_0.storyBar, function()
				local var_31_0 = arg_30_1
				local var_31_1 = var_0.GetStory(var_31_0)
				local var_31_2 = arg_29_0

				var_1.PlayStory(var_31_2, var_31_1, function()
					local var_32_0 = arg_29_0

					var_0.UpdateView(var_32_0)

					return
				end)

				return
			end)

			var_29_6 = true
		end

		local var_30_18 = arg_30_1:GetActiveLink()

		;(function()
			if var_30_18 == 0 or not var_30_2 then
				return
			end

			local var_33_0 = arg_29_0.storyNodesDict[var_30_18]
			local var_33_1 = arg_29_0.nodes[var_33_0:GetIconName()].trans
			local var_33_2 = arg_29_0.plural
			local var_33_3 = var_2.Dequeue(var_33_2)

			table = var_33_2

			local var_33_4 = var_33_2.insert
			local var_33_5 = arg_29_0.links

			go = var_3_10005

			var_33_4(var_33_5, var_3_10005(var_33_3))

			setActive = var_33_4

			var_33_4(var_33_3, true)

			setParent = var_33_4

			var_33_4(var_33_3, arg_29_0.linksContainer)

			local var_33_6 = arg_29_0.linksContainer
			local var_33_7 = var_3.InverseTransformPoint(var_33_6, var_30_0.position)
			local var_33_8 = arg_29_0.linksContainer
			local var_33_9 = var_4.InverseTransformPoint(var_33_8, var_33_1.position) - var_33_7

			Vector2 = var_6

			local var_33_10 = var_6.Magnitude(var_33_9)

			tf = var_7

			local var_33_11 = var_7(var_33_3)

			Vector2 = var_8
			var_33_11.sizeDelta = var_8(var_33_10, 2)
			tf = var_33_11

			local var_33_12 = var_33_11(var_33_3)

			var_33_12.anchoredPosition = var_33_7
			tf = var_33_12

			local var_33_13 = var_33_12(var_33_3)

			Quaternion = var_8

			local var_33_14 = var_8.FromToRotation

			Vector3 = var_9
			var_33_13.localRotation = var_33_14(var_9.right, var_33_9)

			return
		end)()

		local var_30_19 = arg_30_1
		local var_30_20 = arg_30_1.GetTriggers(var_30_19)

		_ = var_30_19

		var_30_19.each(var_30_20, function(arg_34_0)
			local var_34_0 = arg_34_0.type

			BossRushStoryNode = var_3_10002

			if var_34_0 == var_3_10002.TRIGGER_TYPE.PT_GOT then
				if var_30_1 then
					if var_29_4 then
						math = var_1

						local var_34_1

						if not var_1.max(arg_34_0.value, var_29_4) then
							var_34_1 = arg_34_0.value
						end

						var_29_4 = var_34_1

						goto label_34_0

						if var_29_3 then
							math = var_1

							do
								local var_34_2

								if not var_1.min(arg_34_0.value, var_29_3) then
									var_34_2 = arg_34_0.value
								end

								var_29_3 = var_34_2
							end

							::label_34_0::

							return
						end
					end
				end
			end
		end)

		return
	end)

	setText = var_7

	local var_29_7 = arg_29_0._tf

	var_7(var_8.Find(var_29_7, "Story/PassLevel/PT/Text"), arg_29_0.ptActivity.data1 .. "/" .. (var_29_3 or var_29_4 or ""))

	setText = var_7

	local var_29_8 = arg_29_0._tf
	local var_29_9 = var_8.Find(var_29_8, "Story/PassLevel/Values")

	var_7(var_8.GetChild(var_29_9, 0), var_29_1)

	setText = var_7

	local var_29_10 = arg_29_0._tf
	local var_29_11 = var_8.Find(var_29_10, "Story/PassLevel/Values")

	var_7(var_8.GetChild(var_29_11, 2), var_29_2)

	setActive = var_7

	var_7(arg_29_0.storyBar, var_29_6)

	setActive = var_7

	local var_29_12 = arg_29_0.storyAward

	tobool = var_9

	var_7(var_29_12, var_9(arg_29_0.storyTask))

	local var_29_14

	if arg_29_0.storyTask then
		local var_29_13 = arg_29_0.storyTask

		var_29_14 = var_29_14.getConfig(var_29_13, "award_display")

		local var_29_15 = {
			type = var_29_14[1][1],
			id = var_29_14[1][2],
			count = var_29_14[1][3]
		}

		updateDrop = var_9

		local var_29_16 = arg_29_0.storyAward
		local var_29_17 = var_10.Find(var_29_16, "Mask")

		var_9(var_10.GetChild(var_29_17, 0), var_29_15)

		onButton = var_9

		local var_29_18 = arg_29_0
		local var_29_19 = arg_29_0.storyAward
		local var_29_20 = var_11.Find(var_29_19, "Mask")

		var_9(var_29_18, var_11.GetChild(var_29_20, 0), function()
			local var_35_0 = arg_29_0
			local var_35_1 = var_0.emit

			BaseUI = var_2_10002

			var_35_1(var_35_0, var_2_10002.ON_DROP, var_29_15)

			return
		end)

		local var_29_21 = arg_29_0.storyTask
		local var_29_22 = var_9.getTaskStatus(var_29_21)

		setActive = var_29_21

		local var_29_23 = arg_29_0.storyAward

		var_29_21(var_11.Find(var_29_23, "Got"), var_29_22 == 2)

		if var_29_22 == 1 then
			local var_29_24 = arg_29_0
			local var_29_25 = arg_29_0.emit

			BossRushKurskMediator = var_12

			var_29_25(var_29_24, var_12.ON_TASK_SUBMIT, arg_29_0.storyTask)
		end
	end

	setActive = var_29_14

	local var_29_26 = arg_29_0._tf

	var_29_14(var_8.Find(var_29_26, "Battle/Story/New"), var_29_6)

	return
end

function var_0_1.ReturnLinks(arg_36_0, arg_36_1)
	ipairs = var_1_10002

	for iter_36_0, iter_36_1 in var_1_10002(arg_36_0.links) do
		local var_36_0 = arg_36_0.plural

		if not var_7.Enqueue(var_36_0, iter_36_1, arg_36_1) then
			setParent = var_36_0

			var_36_0(iter_36_1, arg_36_0.pluralRoot)
		end
	end

	table = var_2

	var_2.clean(arg_36_0.links)

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

				BossRushKurskMediator = var_2_10004

				var_38_1(var_38_0, var_2_10004.ON_PERFORM_COMBAT, var_1)
			else
				local var_38_2 = var_0

				var_2.Play(var_38_2, arg_37_1, arg_38_0)
			end

			return
		end,
		function(arg_39_0, ...)
			existCall = var_2_10001

			var_2_10001(arg_37_2, ...)

			return
		end
	})

	return
end

function var_0_1.UpdateTasks(arg_40_0, arg_40_1)
	_ = var_1_10002

	if var_1_10002.any(arg_40_1, function(arg_41_0)
		local var_41_0

		if arg_40_0.storyTask then
			var_41_0 = arg_40_0.storyTask.id == arg_41_0
		end

		return var_41_0
	end) then
		arg_40_0.storyTask.submitTime = 1

		arg_40_0:UpdateView()
	end

	return
end

function var_0_1.addbubbleMsgBoxList(arg_42_0, arg_42_1)
	local var_42_0 = #arg_42_0.ActionSequence == 0

	table = var_1_10003

	var_1_10003.insertto(arg_42_0.ActionSequence, arg_42_1)

	if not var_42_0 then
		return
	end

	arg_42_0:resumeBubble()

	return
end

function var_0_1.addbubbleMsgBox(arg_43_0, arg_43_1)
	local var_43_0 = #arg_43_0.ActionSequence == 0

	table = var_1_10003

	var_1_10003.insert(arg_43_0.ActionSequence, arg_43_1)

	if not var_43_0 then
		return
	end

	arg_43_0:resumeBubble()

	return
end

function var_0_1.resumeBubble(arg_44_0)
	if #arg_44_0.ActionSequence == 0 then
		return
	end

	local var_44_0

	;(function()
		if arg_44_0.ActionSequence[1] then
			var_0(function()
				table = var_3_10000

				var_3_10000.remove(arg_44_0.ActionSequence, 1)
				var_0()

				return
			end)
		end

		return
	end)()

	return
end

function var_0_1.CleanBubbleMsgbox(arg_47_0)
	table = var_1_10001

	var_1_10001.clean(arg_47_0.ActionSequence)

	return
end

function var_0_1.willExit(arg_48_0)
	arg_48_0:ReturnLinks(true)

	local var_48_0 = arg_48_0.loader

	var_1.Clear(var_48_0)
	var_0_1.super.willExit(arg_48_0)

	return
end

return var_0_1
