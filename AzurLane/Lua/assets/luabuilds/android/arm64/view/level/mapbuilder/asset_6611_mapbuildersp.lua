class = var_0_10000

local var_0_0 = "MapBuilderSP"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MapBuilder"))

import = var_0_10001

local var_0_2 = var_0_10001("Mgr/Pool/PoolPlural")

var_0_1.DISPLAY = {
	STORY = 2,
	BATTLE = 1
}
var_0_1.DIFFICULITY = {
	EASY = 1,
	HARD = 2
}

function var_0_1.GetType(arg_1_0)
	MapBuilder = var_1_10001

	return var_1_10001.TYPESP
end

function var_0_1.getUIName(arg_2_0)
	return "LevelSelectSPUI"
end

function var_0_1.OnLoaded(arg_3_0)
	setParent = var_1_10001

	var_1_10001(arg_3_0._tf, arg_3_0._parentTf)

	local var_3_0 = arg_3_0._tf

	var_1.SetSiblingIndex(var_3_0, 4)

	return
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.battleLayer = var_1.Find(var_4_0, "Battle")

	local var_4_1 = arg_4_0._tf

	arg_4_0.storyLayer = var_1.Find(var_4_1, "Story")

	local var_4_2 = arg_4_0._tf

	arg_4_0.top = var_1.Find(var_4_2, "Top")

	local var_4_3 = arg_4_0._tf

	arg_4_0.itemHolder = var_1.Find(var_4_3, "Battle/Nodes")

	local var_4_4 = arg_4_0.itemHolder

	arg_4_0.chapterTpl = var_1.Find(var_4_4, "LevelTpl")

	local var_4_5 = arg_4_0._tf

	arg_4_0.storyHolder = var_1.Find(var_4_5, "Story/Nodes")

	local var_4_6 = arg_4_0.storyHolder

	arg_4_0.storyContainer = var_1.Find(var_4_6, "Viewport/Content")
	arg_4_0.nodes = {}

	local var_4_7 = arg_4_0._tf

	arg_4_0.progressText = var_1.Find(var_4_7, "Story/Desc/Text")

	local var_4_8 = arg_4_0._tf

	arg_4_0.storyAward = var_1.Find(var_4_8, "Story/Award")

	local var_4_9 = arg_4_0._tf

	arg_4_0.storyNodeTpl = var_1.Find(var_4_9, "Story/NodeTemplate")

	local var_4_10 = arg_4_0._tf

	arg_4_0.oneLineTpl = var_1.Find(var_4_10, "Story/OneLine")

	local var_4_11 = arg_4_0._tf

	arg_4_0.branchHeadTpl = var_1.Find(var_4_11, "Story/BranchHead")

	local var_4_12 = arg_4_0._tf

	arg_4_0.branchCenterTpl = var_1.Find(var_4_12, "Story/BranchCenter")

	local var_4_13 = arg_4_0._tf

	arg_4_0.branchUpTpl = var_1.Find(var_4_13, "Story/BranchUp")

	local var_4_14 = arg_4_0._tf

	arg_4_0.branchDownTpl = var_1.Find(var_4_14, "Story/BranchDown")

	local var_4_15 = arg_4_0._tf

	arg_4_0.unionTailTpl = var_1.Find(var_4_15, "Story/UnionTail")

	local var_4_16 = arg_4_0._tf

	arg_4_0.unionCenterTpl = var_1.Find(var_4_16, "Story/UnionCenter")

	local var_4_17 = arg_4_0._tf

	arg_4_0.unionUpTpl = var_1.Find(var_4_17, "Story/UnionUp")

	local var_4_18 = arg_4_0._tf

	arg_4_0.unionDownTpl = var_1.Find(var_4_18, "Story/UnionDown")

	local var_4_19 = arg_4_0._tf

	arg_4_0.unreleasedNodeTpl = var_1.Find(var_4_19, "Story/UnreleasedNode")
	setActive = var_1

	var_1(arg_4_0.storyNodeTpl, false)

	setActive = var_1

	var_1(arg_4_0.oneLineTpl, false)

	setActive = var_1

	var_1(arg_4_0.branchHeadTpl, false)

	setActive = var_1

	var_1(arg_4_0.branchCenterTpl, false)

	setActive = var_1

	var_1(arg_4_0.branchUpTpl, false)

	setActive = var_1

	var_1(arg_4_0.branchDownTpl, false)

	setActive = var_1

	var_1(arg_4_0.unionTailTpl, false)

	setActive = var_1

	var_1(arg_4_0.unionCenterTpl, false)

	setActive = var_1

	var_1(arg_4_0.unionUpTpl, false)

	setActive = var_1

	var_1(arg_4_0.unionDownTpl, false)

	setActive = var_1

	var_1(arg_4_0.unreleasedNodeTpl, false)

	local var_4_20 = {}
	local var_4_21 = arg_4_0.storyNodeTpl
	local var_4_22 = var_0_2.New

	go = var_1_10005
	var_4_20[var_4_21] = var_4_22(var_1_10005(arg_4_0.storyNodeTpl), 0)

	local var_4_23 = arg_4_0.oneLineTpl
	local var_4_24 = var_0_2.New

	go = var_5
	var_4_20[var_4_23] = var_4_24(var_5(arg_4_0.oneLineTpl), 0)

	local var_4_25 = arg_4_0.branchHeadTpl
	local var_4_26 = var_0_2.New

	go = var_5
	var_4_20[var_4_25] = var_4_26(var_5(arg_4_0.branchHeadTpl), 0)

	local var_4_27 = arg_4_0.branchCenterTpl
	local var_4_28 = var_0_2.New

	go = var_5
	var_4_20[var_4_27] = var_4_28(var_5(arg_4_0.branchCenterTpl), 0)

	local var_4_29 = arg_4_0.branchUpTpl
	local var_4_30 = var_0_2.New

	go = var_5
	var_4_20[var_4_29] = var_4_30(var_5(arg_4_0.branchUpTpl), 0)

	local var_4_31 = arg_4_0.branchDownTpl
	local var_4_32 = var_0_2.New

	go = var_5
	var_4_20[var_4_31] = var_4_32(var_5(arg_4_0.branchDownTpl), 0)

	local var_4_33 = arg_4_0.unionTailTpl
	local var_4_34 = var_0_2.New

	go = var_5
	var_4_20[var_4_33] = var_4_34(var_5(arg_4_0.unionTailTpl), 0)

	local var_4_35 = arg_4_0.unionCenterTpl
	local var_4_36 = var_0_2.New

	go = var_5
	var_4_20[var_4_35] = var_4_36(var_5(arg_4_0.unionCenterTpl), 0)

	local var_4_37 = arg_4_0.unionUpTpl
	local var_4_38 = var_0_2.New

	go = var_5
	var_4_20[var_4_37] = var_4_38(var_5(arg_4_0.unionUpTpl), 0)

	local var_4_39 = arg_4_0.unionDownTpl
	local var_4_40 = var_0_2.New

	go = var_5
	var_4_20[var_4_39] = var_4_40(var_5(arg_4_0.unionDownTpl), 0)
	arg_4_0.pools = var_4_20
	arg_4_0.nodeTplWidth = arg_4_0.storyNodeTpl.rect.width
	arg_4_0.oneLineWidth = arg_4_0.oneLineTpl.rect.width
	arg_4_0.oneLineHeight = arg_4_0.oneLineTpl.rect.height
	arg_4_0.branchHeadWidth = arg_4_0.branchHeadTpl.rect.width
	arg_4_0.branchUpWidth = arg_4_0.branchUpTpl.rect.width
	arg_4_0.branchUpHeight = arg_4_0.branchUpTpl.rect.height
	arg_4_0.UnionTailWidth = arg_4_0.unionTailTpl.rect.width
	arg_4_0.activeItems = {}
	arg_4_0.displayChapterIDs = {}
	arg_4_0.chapterTFsById = {}
	arg_4_0.storyNodeTFsById = {}

	local var_4_41 = arg_4_0
	local var_4_42 = arg_4_0.bind

	LevelUIConst = var_4

	var_4_42(var_4_41, var_4.SWITCH_SPCHAPTER_DIFFICULTY, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_4_0

		var_2.SwitchChapter(var_5_0, arg_5_1)

		return
	end)

	onButton = var_4_42

	local var_4_43 = arg_4_0
	local var_4_44 = arg_4_0.battleLayer
	local var_4_45 = var_4.Find(var_4_44, "Mask/Story/Switch")

	local function var_4_46()
		local var_6_0 = arg_4_0

		var_0.SetDisplayMode(var_6_0, var_0_1.DISPLAY.STORY)

		arg_4_0.needFocusStory = true

		local var_6_1 = arg_4_0

		var_0.Move2UnlockStory(var_6_1)

		return
	end

	SFX_PANEL = var_4_44

	var_4_42(var_4_43, var_4_45, var_4_46, var_4_44)

	onButton = var_4_42

	local var_4_47 = arg_4_0
	local var_4_48 = arg_4_0.storyLayer
	local var_4_49 = var_4.Find(var_4_48, "Battle/Switch")

	local function var_4_50()
		local var_7_0 = arg_4_0

		var_0.SetDisplayMode(var_7_0, var_0_1.DISPLAY.BATTLE)

		return
	end

	SFX_PANEL = var_4_48

	var_4_42(var_4_47, var_4_49, var_4_50, var_4_48)

	setText = var_4_42

	local var_4_51 = arg_4_0.storyLayer
	local var_4_52 = var_3.Find(var_4_51, "Desc/Desc")

	i18n = var_4_49

	var_4_42(var_4_52, var_4_49("series_enemy_storyreward"))

	return
end

function var_0_1.OnShow(arg_8_0)
	var_0_1.super.OnShow(arg_8_0)

	setActive = var_1

	local var_8_0 = arg_8_0.sceneParent.mainLayer

	var_1(var_3.Find(var_8_0, "title_chapter_lines"), true)

	setActive = var_1

	local var_8_1 = arg_8_0.sceneParent.topChapter

	var_1(var_3.Find(var_8_1, "title_chapter"), true)

	setActive = var_1

	local var_8_2 = arg_8_0.sceneParent.topChapter

	var_1(var_3.Find(var_8_2, "type_chapter"), true)

	arg_8_0.needFocusStory = true

	return
end

function var_0_1.UpdateButtons(arg_9_0)
	var_0_1.super.UpdateButtons(arg_9_0)

	local var_9_0 = arg_9_0.contextData.map
	local var_9_1, var_9_2 = var_1.isActivity(var_9_0)
	local var_9_3 = arg_9_0.contextData.map

	if var_3.isRemaster(var_9_3) then
		local var_9_4 = arg_9_0.sceneParent

		var_4.updateRemasterInfo(var_9_4)
	end

	local var_9_5 = arg_9_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE

	setActive = var_5

	local var_9_6 = arg_9_0.sceneParent.actExchangeShopBtn

	ActivityConst = var_1_10008

	if not var_1_10008.HIDE_PT_PANELS then
		if var_9_5 then
			::label_9_0::

			if not var_3 then
				local var_9_7

				if var_9_2 then
					::label_9_1::

					var_1_10010 = arg_9_0.sceneParent
					var_9_7 = var_8.IsActShopActive(var_1_10010)

					if false then
						var_9_7 = false
					end

					if false then
						var_9_7 = true
					end
				end

				var_5(var_9_6, var_9_7)

				if arg_9_0.contextData.map then
					getProxy = var_5
					ActivityProxy = var_9_6

					local var_9_8 = var_5(var_9_6)
					local var_9_9 = var_5.getActivityById

					var_1_10010 = arg_9_0.contextData.map

					local var_9_10

					if not var_9_9(var_9_8, var_8.getConfig(var_1_10010, "on_activity")) then
						var_9_10 = nil
					end

					local var_9_11 = var_9_10 and not var_9_10:isEnd() and var_9_10:GetConfigClientSetting("PTID")
					local var_9_12 = arg_9_0.sceneParent
					local var_9_13 = var_7.updatePtActivity

					underscore = var_1_10010

					local var_9_14 = var_1_10010.detect

					getProxy = var_1_10012
					ActivityProxy = var_1_10014

					local var_9_15 = var_1_10012(var_1_10014)
					local var_9_16 = var_12.getActivitiesByType

					ActivityConst = var_1_10015

					var_9_13(var_9_12, var_9_14(var_9_16(var_9_15, var_1_10015.ACTIVITY_TYPE_PT_RANK), function(arg_10_0)
						return arg_10_0:getConfig("config_id") == var_9_11
					end))

					setActive = var_9_13

					local var_9_17 = arg_9_0.sceneParent.rightChapter

					var_9_13(var_9.Find(var_9_17, "event_btns/tickets"), var_3)

					local var_9_18 = arg_9_0.sceneParent

					var_7.updateRemasterTicket(var_9_18)

					setActive = var_7

					local var_9_19 = arg_9_0.sceneParent.ptTotal

					ActivityConst = var_10

					if not var_10.HIDE_PT_PANELS and not var_3 then
						local var_9_21

						if var_9_2 and arg_9_0.sceneParent.ptActivity then
							local var_9_20 = arg_9_0.sceneParent.ptActivity

							if not var_10.isEnd(var_9_20) then
								var_9_21 = var_9_5

								goto label_9_3
							end

							var_9_21 = false

							if false then
								var_9_21 = true
							end
						end

						::label_9_3::

						var_7(var_9_19, var_9_21)

						return
					end
				end
			end
		end
	end
end

function var_0_1.OnHide(arg_11_0)
	setActive = var_1_10001

	local var_11_0 = arg_11_0.sceneParent.mainLayer

	var_1_10001(var_3.Find(var_11_0, "title_chapter_lines"), false)

	setActive = var_1_10001

	local var_11_1 = arg_11_0.sceneParent.topChapter

	var_1_10001(var_3.Find(var_11_1, "title_chapter"), false)

	setActive = var_1_10001

	local var_11_2 = arg_11_0.sceneParent.topChapter

	var_1_10001(var_3.Find(var_11_2, "type_chapter"), false)

	setActive = var_1_10001

	var_1_10001(arg_11_0.sceneParent.ptTotal, false)

	setActive = var_1_10001

	var_1_10001(arg_11_0.sceneParent.actExchangeShopBtn, false)
	var_0_1.super.OnHide(arg_11_0)

	return
end

function var_0_1.UpdateMapVO(arg_12_0, arg_12_1)
	var_0_1.super.UpdateMapVO(arg_12_0, arg_12_1)

	getProxy = var_2
	ActivityProxy = var_4

	local var_12_0 = var_2(var_4)

	arg_12_0.activity = var_2.getActivityById(var_12_0, arg_12_1:getConfig("on_activity"))
	getProxy = var_2
	PlayerProxy = var_12_0

	local var_12_1 = var_2(var_12_0)
	local var_12_2 = var_2.getRawData(var_12_1).id
	local var_12_3 = arg_12_1:getConfig("chapterGroups")

	_ = var_12_1
	arg_12_0.chapterGroups = var_12_1.map(var_12_3, function(arg_13_0)
		local var_13_0 = arg_13_0[1]

		PlayerPrefs = var_2_10002

		local var_13_1 = var_2_10002.GetInt("spchapter_selected_" .. var_12_2 .. "_" .. var_13_0, var_0_1.DIFFICULITY.EASY)

		return {
			list = arg_13_0,
			index = var_13_1
		}
	end)
	arg_12_0.chapterGroupDict = {}
	_ = var_4

	var_4.each(arg_12_0.chapterGroups, function(arg_14_0)
		_ = var_2_10001

		var_2_10001.each(arg_14_0.list, function(arg_15_0)
			arg_12_0.chapterGroupDict[arg_15_0] = arg_14_0

			return
		end)

		return
	end)

	_ = var_4
	arg_12_0.displayChapterIDs = var_4.map(arg_12_0.chapterGroups, function(arg_16_0)
		return arg_16_0.list[arg_16_0.index]
	end)

	arg_12_0:BuildStoryTree()

	return
end

function var_0_1.UpdateBonusPtIconPath(arg_17_0)
	arg_17_0.bonusPtIconPath = nil

	local var_17_0

	if not arg_17_0.data then
		var_17_0 = arg_17_0.contextData.map
	end

	if not var_17_0 then
		return
	end

	if not var_17_0:getConfig("on_activity") or var_2 == 0 then
		return
	end

	getProxy = var_1_10003
	ActivityProxy = var_5

	local var_17_1 = var_1_10003(var_5)

	if not var_3.getActivityById(var_17_1, var_2) or var_4:isEnd() then
		return
	end

	local var_17_2 = var_4

	if not var_4.GetConfigClientSetting(var_17_2, "PTID") then
		return
	end

	underscore = var_17_1

	local var_17_3 = var_17_1.detect
	local var_17_4 = var_3
	local var_17_5 = var_3.getActivitiesByType

	ActivityConst = var_1_10011

	if not var_17_3(var_17_5(var_17_4, var_1_10011.ACTIVITY_TYPE_PT_RANK), function(arg_18_0)
		return arg_18_0 and not arg_18_0:isEnd() and arg_18_0:getConfig("config_id") == var_0
	end) then
		return
	end

	tonumber = var_17_2

	local var_17_6 = var_6

	if not var_17_2(var_6.getConfig(var_17_6, "config_id")) then
		return
	end

	Drop = var_8

	local var_17_7 = var_8.New
	local var_17_8 = {}

	DROP_TYPE_RESOURCE = var_17_6
	var_17_8.type = var_17_6
	var_17_8.id = var_7

	local var_17_9 = var_17_7(var_17_8)

	arg_17_0.bonusPtIconPath = var_8.getIcon(var_17_9)

	return
end

function var_0_1.BuildStoryTree(arg_19_0)
	local var_19_0 = arg_19_0.data

	arg_19_0.spStoryIDs = var_1.getConfig(var_19_0, "story_id")
	arg_19_0.spStoryNodeDict = {}
	arg_19_0.spStoryNodes = {}
	arg_19_0.spStoryUnreleasedNode = nil

	local var_19_1 = {}

	_ = var_1_10002

	var_1_10002.each(arg_19_0.spStoryIDs, function(arg_20_0)
		ActivitySpStoryNode = var_2_10001

		local var_20_0 = var_2_10001.New({
			configId = arg_20_0
		})
		local var_20_1 = var_1.GetType(var_20_0)

		ActivitySpStoryNode = var_3

		if var_20_1 ~= var_3.NODE_TYPE.UNRELEASED then
			arg_19_0.spStoryNodeDict[arg_20_0] = var_1

			local var_20_2 = arg_19_0.spStoryNodeDict[arg_20_0]
			local var_20_3

			if not var_19_1[var_20_2:GetPreEvent()] then
				var_20_3 = {}
			end

			table = var_4

			var_4.insert(var_20_3, arg_20_0)

			var_19_1[var_20_2:GetPreEvent()] = var_20_3
		else
			arg_19_0.spStoryUnreleasedNode = var_1
		end

		return
	end)

	local var_19_2 = 0

	local function var_19_3()
		if not var_19_1[var_19_2] then
			return
		end

		local var_21_0 = var_19_1[var_19_2]
		local var_21_1 = tailList
		local var_21_2

		_ = var_1

		local var_21_3 = var_1.each

		tailList = var_2_10003

		var_21_3(var_2_10003, function(arg_22_0)
			table = var_3_10001

			var_3_10001.insert(arg_19_0.spStoryNodes, arg_19_0.spStoryNodeDict[arg_22_0])

			if var_19_1[arg_22_0] then
				var_21_2 = true
				var_19_2 = arg_22_0
			end

			return
		end)

		return var_21_2
	end

	while var_19_3() do
		-- block empty
	end

	local var_19_4 = {}
	local var_19_5

	_ = var_1_10006

	var_1_10006.each(arg_19_0.spStoryNodes, function(arg_23_0)
		if #arg_23_0:GetPreNodes() == 0 then
			var_19_5 = arg_23_0

			return
		end

		_ = var_2

		var_2.each(var_1, function(arg_24_0)
			local var_24_0 = var_19_4
			local var_24_1

			if not var_19_4[arg_24_0] then
				var_24_1 = {}
			end

			var_24_0[arg_24_0] = var_24_1
			table = var_24_0

			var_24_0.insert(var_19_4[arg_24_0], arg_23_0)

			return
		end)

		return
	end)

	arg_19_0.storyTree = {
		root = var_19_5,
		childDict = var_19_4
	}

	return
end

function var_0_1.SetDisplayMode(arg_25_0, arg_25_1)
	if arg_25_1 == arg_25_0.contextData.displayMode then
		return
	end

	arg_25_0.contextData.displayMode = arg_25_1

	arg_25_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_26_0)
	local var_26_0 = arg_26_0.contextData.map

	string = var_1_10002

	local var_26_1 = var_1_10002.split(var_26_0:getConfig("name"), "||")

	if arg_26_0.contextData.displayMode == var_0_1.DISPLAY.STORY then
		string = var_3
		var_26_1 = var_3.split(var_26_1[1], "·")
		setText = var_3

		local var_26_2 = arg_26_0.sceneParent.chapterName
		local var_26_3 = var_26_1[1]

		i18n = var_7

		var_3(var_26_2, var_26_3 .. var_7("levelscene_title_story"))
	else
		setText = var_3

		var_3(arg_26_0.sceneParent.chapterName, var_26_1[1])
	end

	local var_26_4 = var_26_0:getMapTitleNumber()
	local var_26_5 = arg_26_0.sceneParent.loader

	var_4.GetSpriteQuiet(var_26_5, "chapterno", "chapter" .. var_26_4, arg_26_0.sceneParent.chapterNoTitle, true)

	local var_26_6 = arg_26_0.contextData
	local var_26_7

	if not arg_26_0.contextData.displayMode then
		var_26_7 = var_0_1.DISPLAY.BATTLE
	end

	var_26_6.displayMode = var_26_7

	var_0_1.super.UpdateView(arg_26_0)

	local var_26_8 = arg_26_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE

	setActive = var_5

	local var_26_9 = arg_26_0._tf

	var_5(var_7.Find(var_26_9, "Battle"), var_26_8)

	setActive = var_5

	local var_26_10 = arg_26_0._tf

	var_5(var_7.Find(var_26_10, "Story"), not var_26_8)

	getProxy = var_5
	ChapterProxy = var_7

	local var_26_11 = var_5(var_7)
	local var_26_12

	if var_5.IsActivitySPChapterActive(var_26_11, var_26_0:getConfig("on_activity")) then
		SettingsProxy = var_26_12
		var_26_12 = var_26_12.IsShowActivityMapSPTip()
	end

	setActive = var_6

	local var_26_13 = arg_26_0.battleLayer

	var_6(var_8.Find(var_26_13, "Mask/Story/BattleTip"), false)

	setActive = var_6

	local var_26_14 = arg_26_0.storyLayer

	var_6(var_8.Find(var_26_14, "Battle/BattleTip"), var_26_12)

	local var_26_15 = arg_26_0.battleLayer
	local var_26_16 = var_6.Find(var_26_15, "Mask")
	local var_26_17 = var_6.GetComponent

	typeof = var_9
	RectMask2D = var_11

	local var_26_18 = var_26_17(var_26_16, var_9(var_11))

	type = var_26_11

	if var_26_11(arg_26_0.spStoryIDs) ~= "table" or #arg_26_0.spStoryIDs == 0 then
		if var_26_0:isRemaster() then
			setActive = var_26_16

			local var_26_19 = arg_26_0.battleLayer

			var_26_16(var_10.Find(var_26_19, "Mask"), false)

			local var_26_20, var_26_21 = var_26_0:isActivity()
			local var_26_22 = var_26_0
			local var_26_23 = var_26_0.isSkirmish(var_26_22)
			local var_26_24 = var_26_0:isEscort()

			setActive = var_26_22

			local var_26_25 = arg_26_0.sceneParent.remasterBtn

			OPEN_REMASTER = var_1_10015
			var_1_10015 = var_1_10015 and (var_7 or not var_26_20 and not var_26_24 and not var_26_23)

			var_26_22(var_26_25, var_1_10015)
		else
			var_26_18.enabled = true
		end
	end

	arg_26_0:UpdateStoryTask()

	if var_26_8 then
		arg_26_0:UpdateBonusPtIconPath()
		arg_26_0:UpdateBattle()

		local var_26_26 = arg_26_0.sceneParent

		var_7.SwitchMapBG(var_26_26, arg_26_0.contextData.map)

		local var_26_27 = arg_26_0.sceneParent

		var_7.PlayBGM(var_26_27)
	else
		arg_26_0:UpdateStoryNodeStatus()
		arg_26_0:UpdateStory()
		arg_26_0:Move2UnlockStory()
		arg_26_0:SwitchStoryMapAndBGM()
	end

	arg_26_0:TrySubmitTask()

	return
end

function var_0_1.UpdateBattle(arg_27_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10003

	local var_27_0 = var_1_10001(var_1_10003)
	local var_27_1 = arg_27_0.displayChapterIDs
	local var_27_2 = {}

	ipairs = var_1_10004

	for iter_27_0, iter_27_1 in var_1_10004(var_27_1) do
		local var_27_3 = var_27_0:getChapterById(iter_27_1)

		table = var_1_10010

		var_1_10010.insert(var_27_2, var_27_3)
	end

	table = var_4

	var_4.clear(arg_27_0.chapterTFsById)

	UIItemList = var_4

	var_4.StaticAlign(arg_27_0.itemHolder, arg_27_0.chapterTpl, #var_27_2, function(arg_28_0, arg_28_1, arg_28_2)
		UIItemList = var_2_10003

		if arg_28_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_28_0 = var_27_2[arg_28_1 + 1]
		local var_28_1 = arg_27_0

		var_4.UpdateMapItem(var_28_1, arg_28_2, var_28_0)

		arg_28_2.name = "Chapter_" .. var_28_0.id
		arg_27_0.chapterTFsById[var_28_0.id] = arg_28_2

		return
	end)

	return
end

function var_0_1.HideFloat(arg_29_0)
	var_0_1.super.HideFloat(arg_29_0)

	setActive = var_1

	var_1(arg_29_0.itemHolder, false)

	return
end

function var_0_1.ShowFloat(arg_30_0)
	var_0_1.super.ShowFloat(arg_30_0)

	setActive = var_1

	var_1(arg_30_0.itemHolder, true)

	return
end

function var_0_1.UpdateMapItem(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_2
	local var_31_1 = arg_31_2.getConfigTable(var_31_0)

	setLocalPosition = var_1_10004

	var_1_10004(arg_31_1, {
		x = 0 * var_31_1.pos_x,
		y = 1080 * var_31_1.pos_y
	})

	findTF = var_1_10004

	local var_31_2 = var_1_10004(arg_31_1, "main")

	setActive = var_31_0

	var_31_0(var_31_2, true)

	findTF = var_31_0

	local var_31_3 = var_31_0(var_31_2, "circle/fordark")

	findTF = var_6

	local var_31_4 = var_6(var_31_2, "info/bk/fordark")

	setActive = var_7

	var_7(var_31_3, var_31_1.icon_outline == 1)

	setActive = var_7

	var_7(var_31_4, var_31_1.icon_outline == 1)

	local var_31_5 = arg_31_0.chapterGroupDict[arg_31_2.id]

	assert = var_8

	var_8(var_31_5)

	local var_31_6 = {
		"Lock",
		"Normal",
		"Hard"
	}
	local var_31_7 = 1
	local var_31_8

	if arg_31_2:isUnlock() then
		var_31_7 = 2
		var_31_8 = #var_31_5.list

		if 1 < var_31_8 then
			table = var_31_8
			var_31_7 = var_31_8.indexof(var_31_5.list, arg_31_2.id) + 1
		elseif arg_31_2:IsSpChapter() or arg_31_2:IsEXChapter() then
			var_31_7 = 3
		else
			local var_31_9 = arg_31_0.contextData.map

			if var_31_8.isHardMap(var_31_9) then
				var_31_7 = 3
			end
		end
	end

	findTF = var_31_8

	local var_31_10 = var_31_8(var_31_2, "circle/bk")

	ipairs = var_1_10011

	for iter_31_0, iter_31_1 in var_1_10011(var_31_6) do
		setActive = var_1_10016

		var_1_10016(var_31_10:Find(iter_31_1), iter_31_0 == var_31_7)
	end

	findTF = var_11

	local var_31_11 = var_11(var_31_2, "circle/clear_flag")

	findTF = var_12

	local var_31_12 = var_12(var_31_2, "circle/lock")

	findTF = var_13

	local var_31_13 = var_13(var_31_2, "circle/progress")

	findTF = var_14

	local var_31_14 = var_14(var_31_2, "circle/progress_text")

	findTF = var_15

	local var_31_15 = var_15(var_31_2, "circle/stars")

	string = var_16

	local var_31_16 = var_16.split(var_31_1.name, "|")

	setText = var_17
	findTF = var_19

	var_17(var_19(var_31_2, "info/bk/title_form/title_index"), var_31_1.chapter_name .. "  ")

	setText = var_17
	findTF = var_19

	var_17(var_19(var_31_2, "info/bk/title_form/title"), var_31_16[1])

	setText = var_17
	findTF = var_19

	local var_31_17 = var_19(var_31_2, "info/bk/title_form/title_en")
	local var_31_18

	if not var_31_16[2] then
		var_31_18 = ""
	end

	var_17(var_31_17, var_31_18)

	setFillAmount = var_17

	var_17(var_31_13, arg_31_2.progress / 100)

	setText = var_17

	local var_31_19 = var_31_14

	string = var_20

	var_17(var_31_19, var_20.format("%d%%", arg_31_2.progress))

	setActive = var_17

	local var_31_20 = var_31_15
	local var_31_21 = arg_31_2

	var_17(var_31_20, arg_31_2.existAchieve(var_31_21))

	if arg_31_2:existAchieve() then
		ipairs = var_17

		for iter_31_2, iter_31_3 in var_17(arg_31_2.achieves) do
			ChapterConst = var_31_21
			var_31_21 = var_31_21.IsAchieved(iter_31_3)

			local var_31_22 = var_31_15:GetChild(iter_31_2 - 1)
			local var_31_23 = var_31_23.Find(var_31_22, "light")

			setActive = var_24

			var_24(var_31_23, var_31_21)

			ipairs = var_24

			for iter_31_4, iter_31_5 in var_24(var_31_6) do
				if iter_31_5 ~= "Lock" then
					setActive = var_1_10029

					local var_31_24 = var_31_23:Find(iter_31_5)

					var_1_10032 = iter_31_4 == var_31_7

					var_1_10029(var_31_24, var_1_10032)
				end
			end
		end
	end

	findTF = var_17

	local var_31_25 = var_17(var_31_2, "info/bk/BG")

	ipairs = var_18

	for iter_31_6, iter_31_7 in var_18(var_31_6) do
		setActive = var_31_23

		var_31_23(var_31_25:Find(iter_31_7), iter_31_6 == var_31_7)
	end

	setActive = var_18
	findTF = var_20

	var_18(var_20(var_31_2, "HardEffect"), var_31_7 == 3)

	local var_31_26, var_31_27

	if not arg_31_2.active then
		var_31_26 = arg_31_2
		var_31_27 = arg_31_2.isClear(var_31_26)
	else
		var_31_27 = false
	end

	if false then
		var_31_27 = true
	end

	local var_31_28, var_31_29

	if not arg_31_2.active then
		var_31_28 = arg_31_2
		var_31_29 = not arg_31_2.isUnlock(var_31_28)
	else
		var_31_29 = false
	end

	if false then
		var_31_29 = true
	end

	setActive = var_31_26

	var_31_26(var_31_11, var_31_27)

	setActive = var_31_26

	var_31_26(var_31_12, var_31_29)

	setActive = var_31_26

	var_31_26(var_31_14, not var_31_27 and not var_31_29)
	arg_31_0:DeleteTween("fighting" .. arg_31_2.id)

	findTF = var_20

	local var_31_30 = var_20(var_31_2, "circle/fighting")

	setText = var_31_28
	findTF = var_23

	local var_31_31 = var_23(var_31_30, "Text")

	i18n = var_24

	var_31_28(var_31_31, var_24("tag_level_fighting"))

	findTF = var_31_28

	local var_31_32 = var_31_28(var_31_2, "circle/oni")

	setText = var_22
	findTF = var_24

	local var_31_33 = var_24(var_31_32, "Text")

	i18n = var_25

	var_22(var_31_33, var_25("tag_level_oni"))

	findTF = var_22

	local var_31_34 = var_22(var_31_2, "circle/narrative")

	setText = var_23
	findTF = var_25

	local var_31_35 = var_25(var_31_34, "Text")

	i18n = var_26

	var_23(var_31_35, var_26("tag_level_narrative"))

	setActive = var_23

	var_23(var_31_30, false)

	setActive = var_23

	var_23(var_31_32, false)

	setActive = var_23

	var_23(var_31_34, false)

	local var_31_36
	local var_31_37

	if arg_31_2:getConfig("chapter_tag") == 1 then
		var_31_36 = var_31_34
	end

	if arg_31_2.active then
		var_31_36 = arg_31_2:existOni() and var_31_32 or var_31_30
	end

	local var_31_40

	if var_31_36 then
		setActive = var_31_40

		var_31_40(var_31_36, true)

		GetOrAddComponent = var_31_40

		local var_31_38 = var_31_40(var_31_36, "CanvasGroup")

		var_31_38.alpha = 1

		local var_31_39 = arg_31_0

		var_31_40 = arg_31_0.RecordTween

		local var_31_41 = "fighting" .. arg_31_2.id

		LeanTween = var_29

		local var_31_42 = var_29.alphaCanvas(var_31_38, 0, 0.5)
		local var_31_43 = var_29.setFrom(var_31_42, 1)
		local var_31_44 = var_29.setEase

		LeanTweenType = var_1_10032

		local var_31_45 = var_31_44(var_31_43, var_1_10032.easeInOutSine)

		var_31_40(var_31_39, var_31_41, var_29.setLoopPingPong(var_31_45).uniqueId)
	end

	findTF = var_31_40

	local var_31_46 = var_31_40(var_31_2, "triesLimit")
	local var_31_47 = arg_31_2
	local var_31_48 = arg_31_2.isTriesLimit(var_31_47)

	setActive = var_27

	var_27(var_31_46, var_31_48)

	if var_31_48 then
		var_31_47 = arg_31_2:getConfig("count") - arg_31_2:getTodayDefeatCount() .. "/" .. var_27
		setText = var_29

		local var_31_49 = var_31_46:Find("label")

		i18n = var_1_10032

		var_29(var_31_49, var_1_10032("levelScene_chapter_count_tip"))

		setText = var_29

		local var_31_50 = var_31_46:Find("Text")

		setColorStr = var_32

		local var_31_51 = var_31_47

		var_1_10037 = arg_31_2

		if var_27 <= arg_31_2.getTodayDefeatCount(var_1_10037) then
			COLOR_RED = var_35

			if not var_35 then
				COLOR_GREEN = var_35
			end

			var_29(var_31_50, var_32(var_31_51, var_35))

			pg = var_29

			local var_31_52 = var_29.expedition_data_by_map
			local var_31_53 = arg_31_2
			local var_31_54 = var_31_52[arg_31_2.getConfig(var_31_53, "map")].on_activity

			getProxy = var_30
			ChapterProxy = var_31_53

			local var_31_55 = var_30(var_31_53)
			local var_31_56

			if var_30.IsActivitySPChapterActive(var_31_55, var_31_54) then
				SettingsProxy = var_31_56
				var_31_56 = var_31_56.IsShowActivityMapSPTip()
			end

			setActive = var_31_50

			var_31_50(var_31_46:Find("TipRect"), var_31_56)

			local var_31_57 = arg_31_2:GetDailyBonusQuota()

			findTF = var_31_47

			local var_31_58 = var_31_47(var_31_2, "mark")
			local var_31_59 = var_28.Find(var_31_58, "bonus")
			local var_31_60 = var_29.Find(var_31_59, "icon")

			findTF = var_31_58

			local var_31_61 = var_31_58(var_29, "icon/Image")

			setActive = var_31_59

			var_31_59(var_29, var_31_57)

			setActive = var_31_59

			var_31_59(var_28, var_31_57)

			local var_31_63

			if var_31_60 then
				setActive = var_31_59

				local var_31_62 = var_31_60

				var_31_63 = var_31_57 and arg_31_0.bonusPtIconPath

				var_31_59(var_31_62, var_31_63)
			end

			local var_31_67

			if var_31_57 then
				local var_31_64 = var_28
				local var_31_65 = var_28.GetComponent

				typeof = var_31_63
				CanvasGroup = var_1_10037

				local var_31_66 = var_31_65(var_31_64, var_31_63(var_1_10037))

				var_31_67 = arg_31_2:GetDailyBonusIconName()

				local var_31_68 = arg_31_0.sceneParent.loader

				var_34.GetSprite(var_31_68, "ui/levelmainscene_atlas", var_31_67, var_29)

				if var_31_60 and arg_31_0.bonusPtIconPath then
					if var_31_61 then
						GetImageSpriteFromAtlasAsync = var_34

						var_34(arg_31_0.bonusPtIconPath, "", var_31_61, true)
					else
						GetImageSpriteFromAtlasAsync = var_34

						var_34(arg_31_0.bonusPtIconPath, "", var_31_60, true)
					end
				end

				LeanTween = var_34

				local var_31_69 = var_34.cancel

				go = var_31_68

				var_31_69(var_31_68(var_28), true)

				local var_31_70 = var_28.anchoredPosition.y

				var_31_66.alpha = 0
				LeanTween = var_35

				local var_31_71 = var_35.value

				go = var_37

				local var_31_72 = var_31_71(var_37(var_28), 0, 1, 0.2)
				local var_31_73 = var_35.setOnUpdate

				System = var_1_10038

				local var_31_74 = var_31_73(var_31_72, var_1_10038.Action_float(function(arg_32_0)
					var_31_66.alpha = arg_32_0

					local var_32_0 = var_0.anchoredPosition

					var_32_0.y = var_31_70 * arg_32_0
					var_0.anchoredPosition = var_32_0

					return
				end))
				local var_31_75 = var_35.setOnComplete

				System = var_1_10038

				local var_31_76 = var_31_75(var_31_74, var_1_10038.Action(function()
					var_31_66.alpha = 1

					local var_33_0 = var_0.anchoredPosition

					var_33_0.y = var_31_70
					var_0.anchoredPosition = var_33_0

					return
				end))
				local var_31_77 = var_35.setEase

				LeanTweenType = var_1_10038

				local var_31_78 = var_31_77(var_31_76, var_1_10038.easeOutSine)

				var_35.setDelay(var_31_78, 0.7)
			end

			local var_31_79 = arg_31_2.id

			onButton = var_31_67

			local var_31_80 = arg_31_0
			local var_31_81 = var_31_2

			local function var_31_82()
				local var_34_0 = arg_31_0

				var_0.TryOpenChapterInfo(var_34_0, var_31_79, nil, var_31_5.list)

				return
			end

			SFX_UI_WEIGHANCHOR_SELECT = var_1_10038

			var_31_67(var_31_80, var_31_81, var_31_82, var_1_10038)

			return
		end
	end
end

function var_0_1.SwitchChapter(arg_35_0, arg_35_1)
	if not arg_35_0.chapterGroupDict[arg_35_1] then
		return
	end

	if var_2.list[var_2.index] == arg_35_1 then
		return
	end

	table = var_4
	var_2.index = var_4.indexof(var_2.list, arg_35_1)

	local var_35_0 = var_2.list[1]

	getProxy = var_6
	PlayerProxy = var_1_10008

	local var_35_1 = var_6(var_1_10008)
	local var_35_2 = var_6.getRawData(var_35_1).id

	PlayerPrefs = var_7

	var_7.SetInt("spchapter_selected_" .. var_35_2 .. "_" .. var_35_0, var_4)

	local var_35_3 = arg_35_0.chapterTFsById[var_3]

	arg_35_0.chapterTFsById[var_3] = nil
	arg_35_0.chapterTFsById[arg_35_1] = var_35_3

	arg_35_0:UpdateChapterTF(arg_35_1)

	return
end

function var_0_1.UpdateChapterTF(arg_36_0, arg_36_1)
	if not arg_36_0.chapterGroupDict[arg_36_1] then
		return
	end

	if arg_36_0.chapterTFsById[arg_36_1] then
		getProxy = var_1_10004
		ChapterProxy = var_1_10006

		local var_36_0 = var_1_10004(var_1_10006)
		local var_36_1 = var_4.getChapterById(var_36_0, arg_36_1)

		arg_36_0:UpdateMapItem(var_3, var_36_1)
	end

	return
end

function var_0_1.RecyclePools(arg_37_0)
	for iter_37_0 = #arg_37_0.activeItems, 1, -1 do
		local var_37_0 = arg_37_0.activeItems[iter_37_0]
		local var_37_1 = arg_37_0.pools[var_37_0.template]

		if var_37_0.template == arg_37_0.oneLineTpl then
			setSizeDelta = var_7

			var_7(var_37_0.active, {
				x = arg_37_0.oneLineWidth,
				y = arg_37_0.oneLineHeight
			})
		end

		var_37_1:Enqueue(var_37_0.active)
	end

	table = var_1

	var_1.clean(arg_37_0.activeItems)

	arg_37_0.storyNodeTFsById = {}

	return
end

local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3

function var_0_1.UpdateStoryNodeStatus(arg_38_0)
	local var_38_0 = 0
	local var_38_1 = 0

	pg = var_1_10003

	local var_38_2 = var_1_10003.NewStoryMgr.GetInstance()
	local var_38_3 = {}

	table = var_1_10005

	var_1_10005.Foreach(arg_38_0.spStoryIDs, function(arg_39_0, arg_39_1)
		var_38_3[arg_39_1] = {}

		return
	end)

	local var_38_4 = arg_38_0.spStoryNodes

	for iter_38_0 = 1, #var_38_4 do
		local var_38_5 = var_38_4[iter_38_0]
		local var_38_6 = var_10.GetConfigID(var_38_5)
		local var_38_7 = var_10:GetPreEvent()
		local var_38_8 = false
		local var_38_9 = var_38_7 == 0 and true or var_38_3[var_38_7].status == var_0_5
		local var_38_10 = var_0_3
		local var_38_11 = var_10:GetStoryName()
		local var_38_12 = false

		if var_38_11 and var_38_11 ~= "" then
			var_38_0 = var_38_0 + (var_38_2:IsPlayed(var_38_11) and 1 or 0)
			var_38_1 = var_38_1 + 1
		end

		if not var_38_12 and var_38_9 then
			local var_38_13 = {}

			_ = var_1_10018

			var_1_10018.each(var_10:GetUnlockConditions(), function(arg_40_0)
				local var_40_0 = true
				local var_40_1 = arg_40_0[1]

				ActivitySpStoryNode = var_2_10003

				if var_40_1 == var_2_10003.CONDITION.TIME then
					pg = var_40_1

					local var_40_2 = var_40_1.TimeMgr.GetInstance()

					var_40_1 = var_40_1.parseTimeFromConfig(var_40_2, arg_40_0[2])
					pg = var_3

					local var_40_3 = var_3.TimeMgr.GetInstance()

					var_40_0 = var_40_1 <= var_3.GetServerTime(var_40_3)
				else
					var_40_1 = arg_40_0[1]
					ActivitySpStoryNode = var_3

					if var_40_1 == var_3.CONDITION.PASSCHAPTER then
						var_40_1 = arg_40_0[2]
						_ = var_3
						var_40_0 = var_3.all(var_40_1, function(arg_41_0)
							getProxy = var_3_10001
							ChapterProxy = var_3_10003

							local var_41_0 = var_3_10001(var_3_10003)
							local var_41_1 = var_1.getChapterById(var_41_0, arg_41_0, true)

							return var_1.isClear(var_41_1)
						end)
					else
						var_40_1 = arg_40_0[1]
						ActivitySpStoryNode = var_3

						if var_40_1 == var_3.CONDITION.PT then
							var_40_1 = arg_40_0[2][1]

							local var_40_4 = arg_40_0[2][2]
							local var_40_5 = arg_40_0[2][3]
							local var_40_6 = 0

							DROP_TYPE_RESOURCE = var_2_10006

							if var_40_1 == var_2_10006 then
								getProxy = var_2_10006
								PlayerProxy = var_2_10008
								var_2_10008 = var_2_10006(var_2_10008)
								var_2_10008 = var_2_10006.getRawData(var_2_10008)
								var_40_6 = var_2_10006.getResource(var_2_10008, arg_40_0[2])
							else
								DROP_TYPE_ITEM = var_2_10006

								if var_40_1 == var_2_10006 then
									getProxy = var_2_10006
									BagProxy = var_2_10008

									local var_40_7 = var_2_10006(var_2_10008)

									var_40_6 = var_6.getItemCountById(var_40_7, var_40_4)
								end
							end

							var_40_0 = var_40_5 <= var_40_6
						end
					end
				end

				table = var_40_1

				var_40_1.insert(var_38_13, var_40_0)

				local var_40_8

				if var_38_9 then
					var_40_8 = var_40_0
				end

				var_38_9 = var_40_8

				return
			end)

			var_1_10018 = var_38_3[var_38_6]
			var_1_10018.conditionFinishedList = var_38_13
		end

		if var_38_12 then
			var_38_10 = var_0_5
		elseif var_38_9 then
			var_38_10 = var_0_4
		end

		var_38_3[var_38_6].status = var_38_10
	end

	arg_38_0.storyNodeStatus = var_38_3
	arg_38_0.storyReadCount, arg_38_0.storyReadMax = var_38_0, var_38_1

	return
end

function var_0_1.UpdateStory(arg_42_0)
	arg_42_0:RecyclePools()

	local var_42_0 = {
		"162443",
		"ffffff",
		"ffcb5a"
	}
	local var_42_1 = arg_42_0.data

	if var_2.getConfig(var_42_1, "story_inactive_color") and #var_2 > 0 then
		var_42_0[1] = var_2
	end

	local var_42_2 = 0
	local var_42_3 = 150
	local var_42_4 = 150
	local var_42_5 = {}
	local var_42_6 = {
		node = arg_42_0.storyTree.root
	}

	Vector2 = var_8
	var_42_6.nodePos = var_8.New(var_42_3, 0)
	var_42_5[1] = var_42_6

	local var_42_7 = arg_42_0.nodeTplWidth
	local var_42_8 = arg_42_0.oneLineWidth
	local var_42_9 = arg_42_0.branchHeadWidth
	local var_42_10 = arg_42_0.branchUpWidth
	local var_42_11 = arg_42_0.branchUpHeight
	local var_42_12 = arg_42_0.UnionTailWidth
	local var_42_13 = 75
	local var_42_14 = 82
	local var_42_15 = 32

	local function var_42_16()
		table = var_2_10000

		local var_43_0 = var_2_10000.remove(var_42_5, 1).node
		local var_43_1 = var_1.GetConfigID(var_43_0)

		;(function()
			local var_44_0 = arg_42_0
			local var_44_1 = var_0.DequeItem(var_44_0, arg_42_0.storyNodeTpl)

			var_44_1.name = var_43_1
			setAnchoredPosition = var_1

			var_1(var_44_1, var_0.nodePos)

			local var_44_2 = arg_42_0.storyNodeTFsById
			local var_44_3 = var_43_1
			local var_44_4 = {}

			tf = var_4
			var_44_4.nodeTF = var_4(var_44_1)
			var_44_2[var_44_3] = var_44_4

			return
		end)()

		local var_43_2

		if not arg_42_0.storyTree.childDict[var_43_1] then
			var_43_2 = {}
		end

		local var_43_15

		if #var_43_2 == 0 then
			var_42_2 = var_0.nodePos.x + var_42_7 + var_42_4
		elseif #var_43_2 == 1 then
			local var_43_3 = var_43_2[1]
			local var_43_4 = var_43_15.GetConfigID(var_43_3)
			local var_43_5 = arg_42_0

			var_2_10007 = var_2_10007.DequeItem(var_43_5, arg_42_0.oneLineTpl)
			string = var_43_3
			var_2_10007.name = var_43_3.format("Line%s_%s", var_43_1, var_43_4)
			setAnchoredPosition = var_8

			local var_43_6 = var_2_10007
			local var_43_7 = var_0.nodePos

			Vector2 = var_12

			var_8(var_43_6, var_43_7 + var_12.New(var_42_7 + var_42_15, 0))

			tf = var_8

			local var_43_8 = var_8(var_2_10007).anchoredPosition

			Vector2 = var_43_5

			local var_43_9 = var_43_8 + var_43_5.New(var_42_8 + var_42_13, 0)
			local var_43_10 = nextPos
			local var_43_11 = arg_42_0.storyNodeStatus[var_43_4].status

			eachChild = var_9

			var_9(var_2_10007, function(arg_45_0)
				setImageColor = var_3_10001

				local var_45_0 = arg_45_0

				Color = var_3_10004

				var_3_10001(var_45_0, var_3_10004.NewHex(var_42_0[var_43_11]))

				return
			end)

			table = var_9

			local var_43_12 = var_9.insert
			local var_43_13 = var_42_5
			local var_43_14 = {
				node = var_43_15
			}

			nextPos = var_2_10013
			var_43_14.nodePos = var_2_10013

			var_43_12(var_43_13, var_43_14)
		elseif #var_43_2 > 1 then
			var_43_15 = {}

			local var_43_16

			table = var_2_10007

			var_2_10007.Ipairs(var_43_2, function(arg_46_0, arg_46_1)
				local var_46_0 = 0
				local var_46_1 = arg_46_1

				local function var_46_2()
					var_46_0 = var_46_0 + 1

					local var_47_0 = arg_42_0.storyTree.childDict
					local var_47_1 = var_46_1

					if not var_47_0[var_1.GetConfigID(var_47_1)] then
						return false
					end

					assert = var_1

					var_1(#var_0 <= 1)

					if var_0[1] and #var_1:GetPreNodes() == 1 then
						var_46_1 = var_1

						return true
					else
						var_43_16 = var_1
					end

					return
				end

				while var_46_2() do
					-- block empty
				end

				var_43_15[arg_46_0] = var_46_0

				return
			end)

			_ = var_7

			local var_43_17 = var_7.max(var_43_15) * (var_42_7 + var_42_13 + var_42_15) + (var_7 - 1) * var_42_8
			local var_43_18 = var_0.nodePos

			Vector2 = var_10

			local var_43_19 = var_43_18 + var_10.New(var_42_7 + var_42_15, 0)

			;(function()
				local var_48_0 = arg_42_0
				local var_48_1 = var_0.DequeItem(var_48_0, arg_42_0.branchHeadTpl)

				setAnchoredPosition = var_3_10001

				var_3_10001(var_48_1, var_43_19)

				local var_48_2 = var_43_19

				Vector2 = var_48_0
				var_43_19 = var_48_2 + var_48_0.New(var_42_9, 0)

				local var_48_3 = arg_42_0.storyNodeStatus
				local var_48_4 = var_43_2[1]
				local var_48_5 = var_48_3[var_2.GetConfigID(var_48_4)].status

				eachChild = var_2

				var_2(var_48_1, function(arg_49_0)
					setImageColor = var_4_10001

					local var_49_0 = arg_49_0

					Color = var_4_10004

					var_4_10001(var_49_0, var_4_10004.NewHex(var_42_0[var_48_5]))

					return
				end)

				return
			end)()

			table = var_11

			var_11.Ipairs(var_43_2, function(arg_50_0, arg_50_1)
				local var_50_0 = var_42_8

				if var_43_15[arg_50_0] < var_0 then
					local var_50_1 = var_43_15[arg_50_0]

					var_50_0 = (var_43_17 - var_50_1 * (var_42_7 + var_42_13 + var_42_15)) / (var_50_1 + 1)
				end

				local var_50_2 = arg_50_1:GetConfigID()
				local var_50_3 = var_43_19

				;(function()
					local var_51_0
					local var_51_2

					if arg_50_0 == 1 then
						local var_51_1 = arg_42_0

						var_51_0 = var_51_2.DequeItem(var_51_1, arg_42_0.branchUpTpl)
						setAnchoredPosition = var_51_2

						var_51_2(var_51_0, var_50_3)

						var_51_2 = var_50_3
						Vector2 = var_4_10002
						var_50_3 = var_51_2 + var_4_10002.New(var_42_10, var_42_11)

						if var_43_15[arg_50_0] < var_0 then
							setSizeDelta = var_51_2

							var_51_2(var_51_0, {
								x = var_42_10 + var_50_0,
								y = var_42_11
							})

							tf = var_51_2

							local var_51_3 = var_51_2(var_51_0)

							var_51_2.x = var_51_2.Find(var_51_3, "Line_1").sizeDelta.x + var_50_0
							setSizeDelta = var_4_10002
							tf = var_4

							local var_51_4 = var_4(var_51_0)

							var_4_10002(var_4.Find(var_51_4, "Line_1"), var_51_2)

							var_4_10002 = var_50_3
							Vector2 = var_3
							var_50_3 = var_4_10002 + var_3.New(var_50_0, 0)
						end
					else
						if arg_50_0 == 3 or arg_50_0 == 2 and #var_43_2 == 2 then
							var_51_2 = arg_42_0.storyTree.childDict

							local var_51_5 = var_43_2[1]

							if var_51_2[var_4_10002.GetConfigID(var_51_5)] then
								local var_51_6 = arg_42_0

								var_51_0 = var_51_2.DequeItem(var_51_6, arg_42_0.branchDownTpl)
								setAnchoredPosition = var_51_2

								var_51_2(var_51_0, var_50_3)

								var_51_2 = var_50_3
								Vector2 = var_4_10002
								var_50_3 = var_51_2 + var_4_10002.New(var_42_10, -var_42_11)

								if var_43_15[arg_50_0] < var_0 then
									setSizeDelta = var_51_2

									var_51_2(var_51_0, {
										x = var_42_10 + var_50_0,
										y = var_42_11
									})

									tf = var_51_2

									local var_51_7 = var_51_2(var_51_0)

									var_51_2.x = var_51_2.Find(var_51_7, "Line_1").sizeDelta.x + var_50_0
									setSizeDelta = var_4_10002
									tf = var_4

									local var_51_8 = var_4(var_51_0)

									var_4_10002(var_4.Find(var_51_8, "Line_1"), var_51_2)

									var_4_10002 = var_50_3
									Vector2 = var_3
									var_50_3 = var_4_10002 + var_3.New(var_50_0, 0)
								end

								goto label_51_0
							end
						end

						local var_51_9 = arg_42_0

						var_51_0 = var_51_2.DequeItem(var_51_9, arg_42_0.branchCenterTpl)
						setAnchoredPosition = var_51_2

						var_51_2(var_51_0, var_50_3)

						var_51_2 = var_50_3
						Vector2 = var_4_10002
						var_50_3 = var_51_2 + var_4_10002.New(var_42_10, 0)

						if var_43_15[arg_50_0] < var_0 then
							tf = var_51_2
							var_51_2.x = var_51_2(var_51_0).sizeDelta.x + var_50_0
							setSizeDelta = var_2

							var_2(var_51_0, var_51_2)

							local var_51_10 = var_50_3

							Vector2 = var_3
							var_50_3 = var_51_10 + var_3.New(var_50_0, 0)
						end
					end

					::label_51_0::

					string = var_51_2
					var_51_0.name = var_51_2.format("Branch%s_%s", var_43_1, var_50_2)

					local var_51_11 = arg_42_0.storyNodeStatus[var_50_2].status

					eachChild = var_2

					var_2(var_51_0, function(arg_52_0)
						setImageColor = var_5_10001

						local var_52_0 = arg_52_0

						Color = var_5_10004

						var_5_10001(var_52_0, var_5_10004.NewHex(var_42_0[var_51_11]))

						return
					end)

					return
				end)()

				Vector2 = var_6
				var_50_3 = var_50_3 + var_6.New(var_42_13, 0)

				local var_50_4 = arg_42_0
				local var_50_5 = var_6.DequeItem(var_50_4, arg_42_0.storyNodeTpl)

				var_50_5.name = var_50_2
				setAnchoredPosition = var_3_10007

				var_3_10007(var_50_5, var_50_3)

				local var_50_6 = arg_42_0.storyNodeTFsById
				local var_50_7 = {}

				tf = var_9
				var_50_7.nodeTF = var_9(var_50_5)
				var_50_6[var_50_2] = var_50_7
				Vector2 = var_50_6
				var_50_3 = var_50_3 + var_50_6.New(var_42_7 + var_42_15, 0)

				local var_50_8 = arg_50_1
				local var_50_10

				if arg_42_0.storyTree.childDict[var_50_2] then
					local var_50_9 = arg_42_0.storyTree.childDict[var_50_2][1]

					function var_50_10()
						if not var_50_9 or var_50_9 == var_43_16 then
							return
						end

						local var_53_0 = arg_42_0
						local var_53_1 = var_0.DequeItem(var_53_0, arg_42_0.oneLineTpl)

						string = var_4_10001

						local var_53_2 = var_4_10001.format
						local var_53_3 = "Line%s_%s"
						local var_53_4 = var_50_8
						local var_53_5 = var_4.GetConfigID(var_53_4)
						local var_53_6 = var_50_9

						var_53_1.name = var_53_2(var_53_3, var_53_5, var_5.GetConfigID(var_53_6))
						setAnchoredPosition = var_1

						var_1(var_53_1, var_50_3)

						local var_53_7 = var_50_3

						Vector2 = var_53_0
						var_50_3 = var_53_7 + var_53_0.New(var_50_0 + var_42_13, 0)
						setSizeDelta = var_1

						var_1(var_53_1, {
							x = var_50_0,
							y = arg_42_0.oneLineHeight
						})

						local var_53_8 = arg_42_0.storyNodeStatus
						local var_53_9 = var_50_9
						local var_53_10 = var_53_8[var_2.GetConfigID(var_53_9)].status

						eachChild = var_2

						var_2(var_53_1, function(arg_54_0)
							setImageColor = var_5_10001

							local var_54_0 = arg_54_0

							Color = var_5_10004

							var_5_10001(var_54_0, var_5_10004.NewHex(var_42_0[var_53_10]))

							return
						end)

						local var_53_11 = arg_42_0
						local var_53_12 = var_2.DequeItem(var_53_11, arg_42_0.storyNodeTpl)
						local var_53_13 = var_50_9

						var_53_12.name = var_3.GetConfigID(var_53_13)
						setAnchoredPosition = var_3

						var_3(var_53_12, var_50_3)

						local var_53_14 = arg_42_0.storyNodeTFsById
						local var_53_15 = var_50_9
						local var_53_16 = var_4.GetConfigID(var_53_15)
						local var_53_17 = {}

						tf = var_53_15
						var_53_17.nodeTF = var_53_15(var_53_12)
						var_53_14[var_53_16] = var_53_17

						local var_53_18 = var_50_3

						Vector2 = var_53_16
						var_50_3 = var_53_18 + var_53_16.New(var_42_7 + var_42_15, 0)

						local var_53_19 = arg_42_0.storyTree.childDict
						local var_53_20 = var_50_9

						if not var_53_19[var_4.GetConfigID(var_53_20)] then
							return false
						end

						var_50_9, var_50_8 = var_3[1], var_50_9

						return true
					end

					while var_50_10() do
						-- block empty
					end
				end

				if var_43_16 then
					local var_50_11

					if arg_50_0 == 1 then
						local var_50_12 = arg_42_0

						var_50_11 = var_50_10.DequeItem(var_50_12, arg_42_0.unionUpTpl)
						setAnchoredPosition = var_50_10

						var_50_10(var_50_11, var_50_3)

						if var_43_15[arg_50_0] < var_0 then
							setSizeDelta = var_50_10

							var_50_10(var_50_11, {
								x = var_42_10 + var_50_0,
								y = var_42_11
							})

							tf = var_50_10

							local var_50_13 = var_50_10(var_50_11)

							var_50_10.x = var_50_10.Find(var_50_13, "Line_1").sizeDelta.x + var_50_0
							setSizeDelta = var_10
							tf = var_12

							local var_50_14 = var_12(var_50_11)

							var_10(var_12.Find(var_50_14, "Line_1"), var_50_10)

							Vector2 = var_10
							var_50_3 = var_50_3 + var_10.New(var_50_0, 0)
						end
					elseif arg_50_0 == 3 or arg_50_0 == 2 and #var_43_2 == 2 then
						local var_50_15 = arg_42_0

						var_50_11 = var_50_10.DequeItem(var_50_15, arg_42_0.unionDownTpl)
						setAnchoredPosition = var_50_10

						var_50_10(var_50_11, var_50_3)

						if var_43_15[arg_50_0] < var_0 then
							setSizeDelta = var_50_10

							var_50_10(var_50_11, {
								x = var_42_10 + var_50_0,
								y = var_42_11
							})

							tf = var_50_10

							local var_50_16 = var_50_10(var_50_11)

							var_50_10.x = var_50_10.Find(var_50_16, "Line_1").sizeDelta.x + var_50_0
							setSizeDelta = var_10
							tf = var_12

							local var_50_17 = var_12(var_50_11)

							var_10(var_12.Find(var_50_17, "Line_1"), var_50_10)

							Vector2 = var_10
							var_50_3 = var_50_3 + var_10.New(var_50_0, 0)
						end
					else
						local var_50_18 = arg_42_0

						var_50_11 = var_50_10.DequeItem(var_50_18, arg_42_0.unionCenterTpl)
						setAnchoredPosition = var_50_10

						var_50_10(var_50_11, var_50_3)

						if var_43_15[arg_50_0] < var_0 then
							tf = var_50_10
							var_50_10.x = var_50_10(var_50_11).sizeDelta.x + var_50_0
							setSizeDelta = var_10

							var_10(var_50_11, var_50_10)

							Vector2 = var_10
							var_50_3 = var_50_3 + var_10.New(var_50_0, 0)
						end
					end

					string = var_50_10

					local var_50_19 = var_50_10.format
					local var_50_20 = "Union%s_%s"
					local var_50_21 = var_50_8:GetConfigID()
					local var_50_22 = var_43_16

					var_50_11.name = var_50_19(var_50_20, var_50_21, var_13.GetConfigID(var_50_22))

					local var_50_23 = arg_42_0.storyNodeStatus
					local var_50_24 = var_43_16
					local var_50_25 = var_50_23[var_10.GetConfigID(var_50_24)].status

					eachChild = var_10

					var_10(var_50_11, function(arg_55_0)
						setImageColor = var_4_10001

						local var_55_0 = arg_55_0

						Color = var_4_10004

						var_4_10001(var_55_0, var_4_10004.NewHex(var_42_0[var_50_25]))

						return
					end)
				end

				return
			end)

			Vector2 = var_11
			var_43_19 = var_43_19 + var_11.New(var_43_17 + var_42_10, 0)

			if var_43_16 then
				(function()
					local var_56_0 = var_43_19

					Vector2 = var_3_10001
					var_43_19 = var_56_0 + var_3_10001.New(var_42_10, 0)

					local var_56_1 = arg_42_0
					local var_56_2 = var_0.DequeItem(var_56_1, arg_42_0.unionTailTpl)

					setAnchoredPosition = var_1

					var_1(var_56_2, var_43_19)

					local var_56_3 = var_43_19

					Vector2 = var_56_1
					var_43_19 = var_56_3 + var_56_1.New(var_42_12 + var_42_14, 0)

					local var_56_4 = arg_42_0.storyNodeStatus
					local var_56_5 = var_43_16
					local var_56_6 = var_56_4[var_2.GetConfigID(var_56_5)].status

					eachChild = var_2

					var_2(var_56_2, function(arg_57_0)
						setImageColor = var_4_10001

						local var_57_0 = arg_57_0

						Color = var_4_10004

						var_4_10001(var_57_0, var_4_10004.NewHex(var_42_0[var_56_6]))

						return
					end)

					return
				end)()

				table = var_12

				var_12.insert(var_42_5, {
					node = var_43_16,
					nodePos = var_43_19
				})
			else
				var_42_2 = var_43_19.x + var_42_4
			end
		end

		next = var_43_15

		return var_43_15(var_42_5)
	end

	while var_42_16() do
		-- block empty
	end

	setSizeDelta = var_17

	var_17(arg_42_0.storyContainer, {
		x = var_42_2
	})

	if arg_42_0.spStoryUnreleasedNode then
		cloneTplTo = var_17

		local var_42_17 = var_17(arg_42_0.unreleasedNodeTpl, arg_42_0.storyContainer)

		setAnchoredPosition = var_1_10018

		var_1_10018(var_42_17, {
			y = 0,
			x = var_42_2
		})

		setText = var_1_10018

		local var_42_18 = var_42_17:Find("text")
		local var_42_19 = arg_42_0.spStoryUnreleasedNode

		var_1_10018(var_42_18, var_21.GetDisplayName(var_42_19))

		ResourceMgr = var_1_10018

		local var_42_20 = var_1_10018.Inst
		local var_42_21 = var_18.getAssetAsync
		local var_42_22 = "ui/"
		local var_42_23 = arg_42_0.spStoryUnreleasedNode
		local var_42_24 = var_42_22 .. var_22.GetCleanAnimator(var_42_23)
		local var_42_25 = ""

		UnityEngine = var_42_19

		var_42_21(var_42_20, var_42_24, var_42_25, var_42_19.Events.UnityAction_UnityEngine_Object(function(arg_58_0)
			Instantiate = var_2_10001

			local var_58_0 = var_2_10001(arg_58_0)

			Vector3 = var_2_10002

			local var_58_1 = var_2_10002.New(-525, 0, 380)

			tf = var_3

			local var_58_2 = var_3(var_58_0)

			var_58_2.localPosition = var_58_1
			setParent = var_58_2

			var_58_2(var_58_0, var_42_17)

			return
		end), true, true)
	end

	local var_42_26 = arg_42_0.spStoryNodes

	for iter_42_0 = 1, #var_42_26 do
		local var_42_27 = var_42_26[iter_42_0]
		local var_42_28 = var_22.GetConfigID(var_42_27)
		local var_42_29 = arg_42_0.storyNodeStatus[var_42_28].status
		local var_42_30 = arg_42_0.storyNodeTFsById[var_42_28].nodeTF
		local var_42_31 = var_25.Find(var_42_30, "info/bk/title_form/title")
		local var_42_33

		if var_42_29 == var_0_3 then
			local var_42_32 = var_22

			var_42_33 = var_22.GetUnlockDesc(var_42_32)
			var_42_30 = ""
			type = var_42_32

			local var_42_34

			if var_42_32(var_42_33) == "table" then
				if not arg_42_0.storyNodeStatus[var_42_28].conditionFinishedList then
					var_42_34 = {}
				end

				var_42_30 = var_42_33[1] or ""
				ipairs = var_1_10030

				for iter_42_1, iter_42_2 in var_1_10030(var_42_33) do
					if not var_42_34[iter_42_1] then
						var_42_30 = iter_42_2 or ""

						break
					end
				end
			else
				var_42_30 = var_42_33 or ""
			end

			setScrollText = var_42_34

			local var_42_35 = var_42_31

			HXSet = var_1_10032

			var_42_34(var_42_35, var_1_10032.hxLan(var_42_30))

			setTextAlpha = var_42_34

			var_42_34(var_42_31, 0.5)
		else
			setScrollText = var_42_33

			local var_42_36 = var_42_31

			HXSet = var_1_10030

			var_42_33(var_42_36, var_1_10030.hxLan(var_22:GetDisplayName()))

			setTextAlpha = var_42_33

			var_42_33(var_42_31, 1)
		end

		local var_42_37 = var_22
		local var_42_38 = var_22.GetType(var_42_37)

		setActive = var_42_30
		var_1_10032 = var_25

		var_42_30(var_25.Find(var_1_10032, "circle/lock"), var_42_29 == var_0_3)

		if var_42_29 == var_0_3 then
			setActive = var_28
			var_1_10032 = var_25

			var_28(var_25.Find(var_1_10032, "circle/Story"), false)

			setActive = var_28
			var_1_10032 = var_25

			var_28(var_25.Find(var_1_10032, "circle/Battle"), false)

			setActive = var_28
			var_1_10032 = var_25

			var_28(var_25.Find(var_1_10032, "circle/Option"), false)

			setText = var_28
			var_1_10032 = var_25

			var_28(var_25.Find(var_1_10032, ""))
		else
			ActivitySpStoryNode = var_28

			if var_42_38 == var_28.NODE_TYPE.STORY then
				setActive = var_28
				var_1_10032 = var_25

				var_28(var_25.Find(var_1_10032, "circle/Option"), false)

				setActive = var_28
				var_1_10032 = var_25

				var_28(var_25.Find(var_1_10032, "circle/Story"), true)

				setActive = var_28
				var_1_10032 = var_25

				var_28(var_25.Find(var_1_10032, "circle/Battle"), false)

				setActive = var_28
				var_1_10032 = var_25

				var_28(var_25.Find(var_1_10032, "circle/Story/Done"), var_42_29 == var_0_5)
			else
				ActivitySpStoryNode = var_28

				if var_42_38 == var_28.NODE_TYPE.OPTION_BRANCH then
					setActive = var_28
					var_1_10032 = var_25

					var_28(var_25.Find(var_1_10032, "circle/Option"), true)

					setActive = var_28
					var_1_10032 = var_25

					var_28(var_25.Find(var_1_10032, "circle/Story"), false)

					setActive = var_28
					var_1_10032 = var_25

					var_28(var_25.Find(var_1_10032, "circle/Battle"), false)

					setActive = var_28
					var_1_10032 = var_25

					var_28(var_25.Find(var_1_10032, "circle/Option/Done"), var_42_29 == var_0_5)
				else
					ActivitySpStoryNode = var_28

					if var_42_38 == var_28.NODE_TYPE.BATTLE then
						setActive = var_28
						var_1_10032 = var_25

						var_28(var_25.Find(var_1_10032, "circle/Story"), false)

						setActive = var_28
						var_1_10032 = var_25

						var_28(var_25.Find(var_1_10032, "circle/Option"), false)

						setActive = var_28
						var_1_10032 = var_25
						var_1_10030 = var_25.Find(var_1_10032, "circle/Battle")
						ActivitySpStoryNode = var_31

						var_28(var_1_10030, var_42_38 == var_31.NODE_TYPE.BATTLE)

						setActive = var_28
						var_1_10032 = var_25

						var_28(var_25.Find(var_1_10032, "circle/Battle/Done"), var_42_29 == var_0_5)
					end
				end
			end
		end

		local var_42_39 = var_42_29 == var_0_5

		setActive = var_42_37

		var_42_37(var_25:Find("circle/progress"), var_42_39)

		if var_22:IsRecrew() == nil then
			setActive = var_1_10030

			var_1_10030(var_25:Find("recrew"), false)
		else
			setActive = var_1_10030

			var_1_10030(var_25:Find("recrew"), true)

			setActive = var_1_10030

			var_1_10030(var_25:Find("recrew/recrewed"), var_29)

			setActive = var_1_10030

			var_1_10030(var_25:Find("recrew/not_recrew"), not var_29)

			setText = var_1_10030
			var_1_10032 = var_25:Find("recrew/recrewed/label")
			i18n = var_33

			var_1_10030(var_1_10032, var_33("story_recrewed"))

			setText = var_1_10030
			var_1_10032 = var_25:Find("recrew/not_recrew/label")
			i18n = var_33

			var_1_10030(var_1_10032, var_33("story_not_recrew"))
		end

		onButton = var_1_10030

		var_1_10030(arg_42_0, var_25, function()
			if var_42_29 == var_0_3 then
				return
			end

			local var_59_0 = var_0
			local var_59_1 = var_0.GetStoryName(var_59_0)
			local var_59_2 = arg_42_0

			var_1.PlayStory(var_59_2, var_59_1, function()
				local var_60_0 = arg_42_0

				var_0.UpdateView(var_60_0)

				arg_42_0.needFocusStory = true

				local var_60_1 = arg_42_0

				var_0.Move2UnlockStory(var_60_1)

				return
			end, true)

			return
		end)
	end

	local var_42_40 = arg_42_0.storyReadCount
	local var_42_41 = arg_42_0.storyReadMax

	setText = var_20

	var_20(arg_42_0.progressText, var_42_40 .. "/" .. var_42_41)

	setActive = var_20

	local var_42_42 = arg_42_0.storyAward

	tobool = var_23

	var_20(var_42_42, var_23(arg_42_0.storyTask))

	if arg_42_0.storyTask then
		local var_42_43 = arg_42_0.storyTask
		local var_42_44 = var_20.getConfig(var_42_43, "award_display")

		Drop = iter_42_0

		local var_42_45 = iter_42_0.New({
			type = var_42_44[1][1],
			id = var_42_44[1][2],
			count = var_42_44[1][3]
		})

		updateDrop = var_42_43

		local var_42_46 = arg_42_0.storyAward

		var_42_43(var_24.GetChild(var_42_46, 0), var_42_45)

		local var_42_47 = arg_42_0.storyTask
		local var_42_48 = var_22.getTaskStatus(var_42_47)

		setActive = var_23

		local var_42_49 = arg_42_0.storyAward

		var_23(var_25.Find(var_42_49, "get"), var_42_48 == 1)

		setActive = var_23

		local var_42_50 = arg_42_0.storyAward

		var_23(var_25.Find(var_42_50, "got"), var_42_48 == 2)

		onButton = var_23

		var_23(arg_42_0, arg_42_0.storyAward, function()
			local var_61_0 = arg_42_0
			local var_61_1 = var_0.emit

			BaseUI = var_2_10003

			var_61_1(var_61_0, var_2_10003.ON_DROP, var_42_45)

			return
		end)
	end

	return
end

function var_0_1.DequeItem(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_0.pools[arg_62_1]
	local var_62_1 = var_2.Dequeue(var_62_0)

	table = var_1_10003

	var_1_10003.insert(arg_62_0.activeItems, {
		template = arg_62_1,
		active = var_62_1
	})

	setActive = var_3

	var_3(var_62_1, true)

	setParent = var_3

	var_3(var_62_1, arg_62_0.storyContainer)

	return var_62_1
end

function var_0_1.Move2UnlockStory(arg_63_0)
	if not arg_63_0.needFocusStory then
		return
	end

	arg_63_0.needFocusStory = nil

	local var_63_0 = arg_63_0.spStoryNodes
	local var_63_1

	for iter_63_0 = #var_63_0, 1, -1 do
		var_1_10010 = var_63_0[iter_63_0]

		local var_63_2 = var_7.GetConfigID(var_1_10010)
		local var_63_3 = arg_63_0.storyNodeStatus[var_63_2].status

		if var_0_3 < var_63_3 then
			var_63_1 = var_63_2

			break
		end
	end

	local var_63_4 = arg_63_0.storyNodeTFsById[var_63_1].nodeTF
	local var_63_5 = arg_63_0.storyNodeTpl.rect.width
	local var_63_6 = var_63_4.anchoredPosition.x + var_63_5 * 0.5 - arg_63_0.storyContainer.parent.rect.width * 0.5

	math = var_6

	local var_63_7 = var_6.clamp
	local var_63_8 = var_63_6
	local var_63_9 = 0

	math = var_1_10010

	local var_63_10 = var_63_7(var_63_8, var_63_9, var_1_10010.max(0, arg_63_0.storyContainer.rect.width - arg_63_0.storyContainer.parent.rect.width))

	setAnchoredPosition = var_6

	var_6(arg_63_0.storyContainer, {
		x = -var_63_10
	})

	return
end

function var_0_1.SwitchStoryMapAndBGM(arg_64_0)
	local var_64_0 = arg_64_0.data
	local var_64_1 = var_1.getConfig(var_64_0, "default_background")
	local var_64_2 = arg_64_0.data
	local var_64_3 = var_2.getConfig(var_64_2, "default_bgm")
	local var_64_4
	local var_64_5 = arg_64_0.spStoryNodes

	for iter_64_0 = 1, #var_64_5 do
		local var_64_6 = var_64_5[iter_64_0]
		local var_64_7 = var_9.GetConfigID(var_64_6)

		if arg_64_0.storyNodeStatus[var_64_7].status == var_0_5 then
			var_64_1, var_64_3 = var_9:GetCleanBG(), var_9:GetCleanBGM()
			var_64_4 = var_9:GetCleanAnimator()
		else
			break
		end
	end

	local var_64_8 = arg_64_0.sceneParent

	var_5.SwitchBG(var_64_8, {
		{
			bgPrefix = "bg",
			BG = var_64_1,
			Animator = var_64_4
		}
	})

	pg = var_5

	local var_64_9 = var_5.BgmMgr.GetInstance()

	var_5.Push(var_64_9, arg_64_0.__cname, var_64_3)

	return
end

function var_0_1.TrySubmitTask(arg_65_0)
	local var_65_0 = true

	ipairs = var_1_10002

	for iter_65_0, iter_65_1 in var_1_10002(arg_65_0.spStoryNodes) do
		if iter_65_1:GetStoryName() and var_7 ~= "" and var_65_0 then
			pg = var_1_10008

			local var_65_1 = var_1_10008.NewStoryMgr.GetInstance()

			var_65_0 = var_1_10008.IsPlayed(var_65_1, var_7)
		end

		if not var_65_0 then
			break
		end
	end

	if var_65_0 and arg_65_0.storyTask then
		local var_65_2 = arg_65_0.storyTask

		if var_2.getTaskStatus(var_65_2) == 1 then
			local var_65_3 = arg_65_0
			local var_65_4 = arg_65_0.emit

			LevelMediator2 = iter_65_0

			var_65_4(var_65_3, iter_65_0.ON_SUBMIT_TASK, arg_65_0.storyTask.id)

			return
		end
	end

	return
end

function var_0_1.PlayStory(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	if not arg_66_1 then
		existCall = var_1_10004

		return var_1_10004(arg_66_2)
	end

	pg = var_1_10004

	local var_66_0 = var_1_10004.NewStoryMgr.GetInstance()
	local var_66_1 = var_4.IsPlayed(var_66_0, arg_66_1)

	seriesAsync = var_1_10006

	var_1_10006({
		function(arg_67_0)
			if var_66_1 and not arg_66_3 then
				return arg_67_0()
			end

			tonumber = var_1

			if var_1(arg_66_1) and var_1 > 0 then
				local var_67_0 = arg_66_0
				local var_67_1 = var_2.emit

				LevelMediator2 = var_2_10005

				var_67_1(var_67_0, var_2_10005.ON_PERFORM_COMBAT, var_1, nil, var_66_1)
			else
				local var_67_2 = var_0

				var_2.PlayForAcivitySpStory(var_67_2, arg_66_1, arg_67_0, arg_66_3)
			end

			return
		end,
		function(arg_68_0, ...)
			existCall = var_2_10001

			var_2_10001(arg_66_2, ...)

			return
		end
	})

	return
end

function var_0_1.UpdateStoryTask(arg_69_0)
	local var_69_1

	if arg_69_0.activity then
		local var_69_0 = arg_69_0.activity

		var_69_1 = var_1.getConfig(var_69_0, "config_client").task_id
	end

	if not var_69_1 then
		return
	end

	getProxy = var_1_10002
	TaskProxy = var_1_10004

	local var_69_2 = var_1_10002(var_1_10004)
	local var_69_3

	if not var_2.getTaskVO(var_69_2, var_69_1) then
		Task = var_69_3
		var_69_3 = var_69_3.New({
			submit_time = 1,
			id = var_69_1
		})
	end

	arg_69_0.storyTask = var_69_3

	return
end

function var_0_1.OnSubmitTaskDone(arg_70_0)
	arg_70_0:UpdateView()

	return
end

function var_0_1.OnDestroy(arg_71_0)
	arg_71_0:RecyclePools()

	pairs = var_1

	for iter_71_0, iter_71_1 in var_1(arg_71_0.pools) do
		iter_71_1:Clear()
	end

	return
end

return var_0_1
