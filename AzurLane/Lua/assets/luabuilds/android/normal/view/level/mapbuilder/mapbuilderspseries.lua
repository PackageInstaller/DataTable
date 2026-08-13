class = var_0_10000

local var_0_0 = "MapBuilderSPSeries"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MapBuilder"))

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

	return var_1_10001.TYPESPSERIES
end

function var_0_1.getUIName(arg_2_0)
	return "LevelSelectSPSeriesUI"
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

	arg_4_0.storyNodeTpl = var_1.Find(var_4_6, "tpl")
	setActive = var_1

	var_1(arg_4_0.storyNodeTpl, false)

	local var_4_7 = arg_4_0._tf

	arg_4_0.progressText = var_1.Find(var_4_7, "Story/Desc/Text")

	local var_4_8 = arg_4_0._tf

	arg_4_0.storyAward = var_1.Find(var_4_8, "Story/Award")
	arg_4_0.activeItems = {}
	arg_4_0.displayChapterIDs = {}
	arg_4_0.chapterTFsById = {}
	arg_4_0.storyNodeTFsById = {}

	local var_4_9 = arg_4_0
	local var_4_10 = arg_4_0.bind

	LevelUIConst = var_3

	var_4_10(var_4_9, var_3.SWITCH_SPCHAPTER_DIFFICULTY, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_4_0

		var_2.SwitchChapter(var_5_0, arg_5_1)

		return
	end)

	onButton = var_4_10

	local var_4_11 = arg_4_0
	local var_4_12 = arg_4_0.battleLayer
	local var_4_13 = var_3.Find(var_4_12, "Story/Switch")

	local function var_4_14()
		local var_6_0 = arg_4_0

		var_0.SetDisplayMode(var_6_0, var_0_1.DISPLAY.STORY)

		return
	end

	SFX_PANEL = var_5

	var_4_10(var_4_11, var_4_13, var_4_14, var_5)

	onButton = var_4_10

	local var_4_15 = arg_4_0
	local var_4_16 = arg_4_0.storyLayer
	local var_4_17 = var_3.Find(var_4_16, "Battle/Switch")

	local function var_4_18()
		local var_7_0 = arg_4_0

		var_0.SetDisplayMode(var_7_0, var_0_1.DISPLAY.BATTLE)

		return
	end

	SFX_PANEL = var_5

	var_4_10(var_4_15, var_4_17, var_4_18, var_5)

	setText = var_4_10

	local var_4_19 = arg_4_0.storyLayer
	local var_4_20 = var_2.Find(var_4_19, "Desc/Desc")

	i18n = var_4_19

	var_4_10(var_4_20, var_4_19("series_enemy_storyreward"))

	return
end

function var_0_1.OnShow(arg_8_0)
	var_0_1.super.OnShow(arg_8_0)

	setActive = var_1

	local var_8_0 = arg_8_0.sceneParent.mainLayer

	var_1(var_2.Find(var_8_0, "title_chapter_lines"), true)

	setActive = var_1

	local var_8_1 = arg_8_0.sceneParent.topChapter

	var_1(var_2.Find(var_8_1, "title_chapter"), true)

	setActive = var_1

	local var_8_2 = arg_8_0.sceneParent.topChapter

	var_1(var_2.Find(var_8_2, "type_chapter"), true)

	arg_8_0.needFocusStory = true

	return
end

function var_0_1.UpdateButtons(arg_9_0)
	var_0_1.super.UpdateButtons(arg_9_0)

	local var_9_0 = arg_9_0.contextData.map
	local var_9_1, var_9_2 = var_1.isActivity(var_9_0)
	local var_9_3 = arg_9_0.contextData.map
	local var_9_4 = var_3.isRemaster(var_9_3)
	local var_9_5 = arg_9_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE

	setActive = var_5

	local var_9_6 = arg_9_0.sceneParent.actExchangeShopBtn

	ActivityConst = var_1_10007

	if not var_1_10007.HIDE_PT_PANELS then
		if var_9_5 then
			::label_9_0::

			if not var_9_4 then
				local var_9_8

				if var_9_2 then
					::label_9_1::

					local var_9_7 = arg_9_0.sceneParent

					var_9_8 = var_7.IsActShopActive(var_9_7)

					if false then
						var_9_8 = false
					end

					if false then
						var_9_8 = true
					end
				end

				var_5(var_9_6, var_9_8)

				if arg_9_0.contextData.map then
					getProxy = var_5
					ActivityProxy = var_9_6

					local var_9_9 = var_5(var_9_6)
					local var_9_10 = var_5.getActivityById
					local var_9_11 = arg_9_0.contextData.map
					local var_9_12

					if not var_9_10(var_9_9, var_7.getConfig(var_9_11, "on_activity")) then
						var_9_12 = nil
					end

					local var_9_13 = var_9_12 and not var_9_12:isEnd() and var_9_12:GetConfigClientSetting("PTID")
					local var_9_14 = arg_9_0.sceneParent
					local var_9_15 = var_7.updatePtActivity

					underscore = var_1_10009

					local var_9_16 = var_1_10009.detect

					getProxy = var_1_10010
					ActivityProxy = var_1_10011

					local var_9_17 = var_1_10010(var_1_10011)
					local var_9_18 = var_10.getActivitiesByType

					ActivityConst = var_1_10012

					var_9_15(var_9_14, var_9_16(var_9_18(var_9_17, var_1_10012.ACTIVITY_TYPE_PT_RANK), function(arg_10_0)
						return arg_10_0:getConfig("config_id") == var_9_13
					end))

					setActive = var_9_15

					local var_9_19 = arg_9_0.sceneParent.ptTotal

					ActivityConst = var_9

					if not var_9.HIDE_PT_PANELS and not var_9_4 then
						local var_9_21

						if var_9_2 and arg_9_0.sceneParent.ptActivity then
							local var_9_20 = arg_9_0.sceneParent.ptActivity

							if not var_9.isEnd(var_9_20) then
								var_9_21 = var_9_5

								goto label_9_3
							end

							var_9_21 = false

							if false then
								var_9_21 = true
							end
						end

						::label_9_3::

						var_9_15(var_9_19, var_9_21)

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

	var_1_10001(var_2.Find(var_11_0, "title_chapter_lines"), false)

	setActive = var_1_10001

	local var_11_1 = arg_11_0.sceneParent.topChapter

	var_1_10001(var_2.Find(var_11_1, "title_chapter"), false)

	setActive = var_1_10001

	local var_11_2 = arg_11_0.sceneParent.topChapter

	var_1_10001(var_2.Find(var_11_2, "type_chapter"), false)

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
	ActivityProxy = var_3

	local var_12_0 = var_2(var_3)

	arg_12_0.activity = var_2.getActivityById(var_12_0, arg_12_1:getConfig("on_activity"))
	getProxy = var_2
	PlayerProxy = var_12_0

	local var_12_1 = var_2(var_12_0)
	local var_12_2 = var_2.getRawData(var_12_1).id
	local var_12_3 = arg_12_1
	local var_12_4 = arg_12_1.getConfig(var_12_3, "chapterGroups")

	_ = var_12_3
	arg_12_0.chapterGroups = var_12_3.map(var_12_4, function(arg_13_0)
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
	arg_12_0.storyNodesDict = {}
	ipairs = var_4

	local var_12_5 = arg_12_0.activity

	for iter_12_0, iter_12_1 in var_4(var_5.getConfig(var_12_5, "config_client").storys) do
		local var_12_6 = arg_12_0.storyNodesDict

		BossRushStoryNode = var_1_10010
		var_12_6[iter_12_1] = var_1_10010.New({
			id = iter_12_1
		})
		var_1_10010 = arg_12_0.storyHolder

		local var_12_7 = var_9.Find

		tostring = var_11

		local var_12_8

		if not var_12_7(var_1_10010, var_11(iter_12_1)) then
			cloneTplTo = var_12_8
			var_12_8 = var_12_8(arg_12_0.storyNodeTpl, arg_12_0.storyHolder, iter_12_1)
		end

		local var_12_9 = arg_12_0.storyNodesDict[iter_12_1]

		var_1_10010 = var_1_10010.getConfigTable(var_12_9)
		setLocalPosition = var_12_9

		local var_12_10 = var_12_8
		local var_12_11 = {}

		tonumber = var_1_10014
		var_12_11.x = 0 * var_1_10014(var_1_10010.pos_x)
		tonumber = var_1_10014
		var_12_11.y = 1080 * var_1_10014(var_1_10010.pos_y)

		var_12_9(var_12_10, var_12_11)
	end

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

	local var_17_1 = var_17_0

	if not var_17_0.getConfig(var_17_1, "on_activity") or var_2 == 0 then
		return
	end

	getProxy = var_17_1
	ActivityProxy = var_4

	local var_17_2 = var_17_1(var_4)

	if not var_3.getActivityById(var_17_2, var_2) or var_4:isEnd() then
		return
	end

	local var_17_3 = var_4

	if not var_4.GetConfigClientSetting(var_17_3, "PTID") then
		return
	end

	underscore = var_17_3

	local var_17_4 = var_17_3.detect
	local var_17_5 = var_3
	local var_17_6 = var_3.getActivitiesByType

	ActivityConst = var_1_10009

	if not var_17_4(var_17_6(var_17_5, var_1_10009.ACTIVITY_TYPE_PT_RANK), function(arg_18_0)
		return arg_18_0 and not arg_18_0:isEnd() and arg_18_0:getConfig("config_id") == var_0
	end) then
		return
	end

	tonumber = var_7

	if not var_7(var_6:getConfig("config_id")) then
		return
	end

	Drop = var_8

	local var_17_7 = var_8.New
	local var_17_8 = {}

	DROP_TYPE_RESOURCE = var_10
	var_17_8.type = var_10
	var_17_8.id = var_7

	local var_17_9 = var_17_7(var_17_8)

	arg_17_0.bonusPtIconPath = var_8.getIcon(var_17_9)

	return
end

function var_0_1.SetDisplayMode(arg_19_0, arg_19_1)
	if arg_19_1 == arg_19_0.contextData.displayMode then
		return
	end

	arg_19_0.contextData.displayMode = arg_19_1

	arg_19_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_20_0)
	string = var_1_10001

	local var_20_0 = var_1_10001.split
	local var_20_1 = arg_20_0.contextData.map
	local var_20_2 = var_20_0(var_2.getConfig(var_20_1, "name"), "||")

	if arg_20_0.contextData.displayMode == var_0_1.DISPLAY.STORY then
		string = var_2
		var_20_2 = var_2.split(var_20_2[1], "·")
		setText = var_2

		local var_20_3 = arg_20_0.sceneParent.chapterName
		local var_20_4 = var_20_2[1]

		i18n = var_1_10005

		var_2(var_20_3, var_20_4 .. var_1_10005("levelscene_title_story"))
	else
		setText = var_2

		var_2(arg_20_0.sceneParent.chapterName, var_20_2[1])
	end

	local var_20_5 = arg_20_0.contextData.map
	local var_20_6 = var_2.getMapTitleNumber(var_20_5)
	local var_20_7 = arg_20_0.sceneParent.loader

	var_3.GetSpriteQuiet(var_20_7, "chapterno", "chapter" .. var_20_6, arg_20_0.sceneParent.chapterNoTitle, true)

	local var_20_8 = arg_20_0.contextData
	local var_20_9

	if not arg_20_0.contextData.displayMode then
		var_20_9 = var_0_1.DISPLAY.BATTLE
	end

	var_20_8.displayMode = var_20_9

	var_0_1.super.UpdateView(arg_20_0)

	local var_20_10 = arg_20_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE

	setActive = var_4

	local var_20_11 = arg_20_0._tf

	var_4(var_5.Find(var_20_11, "Battle"), var_20_10)

	setActive = var_4

	local var_20_12 = arg_20_0._tf

	var_4(var_5.Find(var_20_12, "Story"), not var_20_10)

	getProxy = var_4
	ChapterProxy = var_5

	local var_20_13 = var_4(var_5)
	local var_20_14 = var_4.IsActivitySPChapterActive
	local var_20_15 = arg_20_0.contextData.map
	local var_20_16

	if var_20_14(var_20_13, var_6.getConfig(var_20_15, "on_activity")) then
		SettingsProxy = var_20_16
		var_20_16 = var_20_16.IsShowActivityMapSPTip()
	end

	setActive = var_20_13

	local var_20_17 = arg_20_0.battleLayer

	var_20_13(var_6.Find(var_20_17, "Story/BattleTip"), false)

	setActive = var_20_13

	local var_20_18 = arg_20_0.storyLayer

	var_20_13(var_6.Find(var_20_18, "Battle/BattleTip"), var_20_16)
	arg_20_0:UpdateStoryTask()

	if var_20_10 then
		arg_20_0:UpdateBonusPtIconPath()
		arg_20_0:UpdateBattle()

		local var_20_19 = arg_20_0.sceneParent

		var_5.SwitchMapBG(var_20_19, arg_20_0.contextData.map)

		local var_20_20 = arg_20_0.sceneParent

		var_5.PlayBGM(var_20_20)
	else
		arg_20_0:UpdateStory()
		arg_20_0:SwitchStoryMapAndBGM()
	end

	arg_20_0:TrySubmitTask()

	return
end

function var_0_1.UpdateBattle(arg_21_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10002

	local var_21_0 = var_1_10001(var_1_10002)
	local var_21_1 = arg_21_0.displayChapterIDs
	local var_21_2 = {}

	ipairs = var_1_10004

	for iter_21_0, iter_21_1 in var_1_10004(var_21_1) do
		local var_21_3 = var_21_0
		local var_21_4 = var_21_0.getChapterById(var_21_3, iter_21_1)

		table = var_21_3

		var_21_3.insert(var_21_2, var_21_4)
	end

	table = var_4

	var_4.clear(arg_21_0.chapterTFsById)

	UIItemList = var_4

	var_4.StaticAlign(arg_21_0.itemHolder, arg_21_0.chapterTpl, #var_21_2, function(arg_22_0, arg_22_1, arg_22_2)
		UIItemList = var_2_10003

		if arg_22_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_22_0 = var_21_2[arg_22_1 + 1]
		local var_22_1 = arg_21_0

		var_4.UpdateMapItem(var_22_1, arg_22_2, var_22_0)

		arg_22_2.name = "Chapter_" .. var_22_0.id
		arg_21_0.chapterTFsById[var_22_0.id] = arg_22_2

		return
	end)

	return
end

function var_0_1.HideFloat(arg_23_0)
	var_0_1.super.HideFloat(arg_23_0)

	setActive = var_1

	var_1(arg_23_0.itemHolder, false)

	return
end

function var_0_1.ShowFloat(arg_24_0)
	var_0_1.super.ShowFloat(arg_24_0)

	setActive = var_1

	var_1(arg_24_0.itemHolder, true)

	return
end

function var_0_1.UpdateMapItem(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_2
	local var_25_1 = arg_25_2.getConfigTable(var_25_0)

	warning = var_25_0

	var_25_0(0 * var_25_1.pos_x, 1080 * var_25_1.pos_y)

	setLocalPosition = var_25_0

	var_25_0(arg_25_1, {
		x = 0 * var_25_1.pos_x,
		y = 1080 * var_25_1.pos_y
	})

	findTF = var_25_0

	local var_25_2 = var_25_0(arg_25_1, "main")

	setActive = var_5

	var_5(var_25_2, true)

	findTF = var_5

	local var_25_3 = var_5(var_25_2, "circle/fordark")

	findTF = var_6

	local var_25_4 = var_6(var_25_2, "info/bk/fordark")

	setActive = var_7

	var_7(var_25_3, var_25_1.icon_outline == 1)

	setActive = var_7

	var_7(var_25_4, var_25_1.icon_outline == 1)

	local var_25_5 = arg_25_0.chapterGroupDict[arg_25_2.id]

	assert = var_8

	var_8(var_25_5)

	local var_25_6 = {
		"Lock",
		"Normal",
		"Hard"
	}
	local var_25_7 = 1

	if arg_25_2:isUnlock() then
		var_25_7 = 2

		if #var_25_5.list > 1 then
			table = var_10
			var_25_7 = var_10.indexof(var_25_5.list, arg_25_2.id) + 1
		elseif arg_25_2:IsSpChapter() or arg_25_2:IsEXChapter() then
			var_25_7 = 3
		else
			local var_25_8 = arg_25_0.contextData.map

			if var_10.isHardMap(var_25_8) then
				var_25_7 = 3
			end
		end
	end

	findTF = var_10

	local var_25_9 = var_10(var_25_2, "circle/bk")

	ipairs = var_11

	for iter_25_0, iter_25_1 in var_11(var_25_6) do
		setActive = var_1_10016

		var_1_10016(var_25_9:Find(iter_25_1), iter_25_0 == var_25_7)
	end

	findTF = var_11

	local var_25_10 = var_11(var_25_2, "circle/clear_flag")

	findTF = var_12

	local var_25_11 = var_12(var_25_2, "circle/lock")

	findTF = var_13

	local var_25_12 = var_13(var_25_2, "circle/progress")

	findTF = var_14

	local var_25_13 = var_14(var_25_2, "circle/progress_text")

	findTF = var_15

	local var_25_14 = var_15(var_25_2, "circle/stars")

	string = var_16

	local var_25_15 = var_16.split(var_25_1.name, "|")

	setText = var_17
	findTF = var_18

	var_17(var_18(var_25_2, "info/bk/title_form/title_index"), var_25_1.chapter_name .. "  ")

	setText = var_17
	findTF = var_18

	var_17(var_18(var_25_2, "info/bk/title_form/title"), var_25_15[1])

	setText = var_17
	findTF = var_18

	local var_25_16 = var_18(var_25_2, "info/bk/title_form/title_en")
	local var_25_17

	if not var_25_15[2] then
		var_25_17 = ""
	end

	var_17(var_25_16, var_25_17)

	setFillAmount = var_17

	var_17(var_25_12, arg_25_2.progress / 100)

	setText = var_17

	local var_25_18 = var_25_13

	string = var_19

	var_17(var_25_18, var_19.format("%d%%", arg_25_2.progress))

	setActive = var_17

	var_17(var_25_14, arg_25_2:existAchieve())

	if arg_25_2:existAchieve() then
		ipairs = var_17

		for iter_25_2, iter_25_3 in var_17(arg_25_2.achieves) do
			ChapterConst = var_1_10022
			var_1_10022 = var_1_10022.IsAchieved(iter_25_3)

			local var_25_19 = var_25_14:GetChild(iter_25_2 - 1)

			var_1_10023 = var_1_10023.Find(var_25_19, "light")
			setActive = var_25_19

			var_25_19(var_1_10023, var_1_10022)

			ipairs = var_25_19

			for iter_25_4, iter_25_5 in var_25_19(var_25_6) do
				if iter_25_5 ~= "Lock" then
					setActive = var_1_10029

					var_1_10029(var_1_10023:Find(iter_25_5), iter_25_4 == var_25_7)
				end
			end
		end
	end

	findTF = var_17

	local var_25_20 = var_17(var_25_2, "info/bk/BG")

	ipairs = var_18

	for iter_25_6, iter_25_7 in var_18(var_25_6) do
		setActive = var_1_10023

		var_1_10023(var_25_20:Find(iter_25_7), iter_25_6 == var_25_7)
	end

	setActive = var_18
	findTF = var_19

	var_18(var_19(var_25_2, "HardEffect"), var_25_7 == 3)

	local var_25_21 = not arg_25_2.active and arg_25_2:isClear()
	local var_25_22, var_25_23

	if not arg_25_2.active then
		var_25_22 = arg_25_2
		var_25_23 = not arg_25_2.isUnlock(var_25_22)
	else
		var_25_23 = false
	end

	if false then
		var_25_23 = true
	end

	setActive = var_25_22

	var_25_22(var_25_10, var_25_21)

	setActive = var_25_22

	var_25_22(var_25_11, var_25_23)

	setActive = var_25_22

	var_25_22(var_25_13, not var_25_21 and not var_25_23)
	arg_25_0:DeleteTween("fighting" .. arg_25_2.id)

	findTF = var_20

	local var_25_24 = var_20(var_25_2, "circle/fighting")

	setText = var_21
	findTF = var_22

	local var_25_25 = var_22(var_25_24, "Text")

	i18n = var_23

	var_21(var_25_25, var_23("tag_level_fighting"))

	findTF = var_21

	local var_25_26 = var_21(var_25_2, "circle/oni")

	setText = var_22
	findTF = var_23

	local var_25_27 = var_23(var_25_26, "Text")

	i18n = var_24

	var_22(var_25_27, var_24("tag_level_oni"))

	findTF = var_22

	local var_25_28 = var_22(var_25_2, "circle/narrative")

	setText = var_23
	findTF = var_24

	local var_25_29 = var_24(var_25_28, "Text")

	i18n = var_25

	var_23(var_25_29, var_25("tag_level_narrative"))

	setActive = var_23

	var_23(var_25_24, false)

	setActive = var_23

	var_23(var_25_26, false)

	setActive = var_23

	var_23(var_25_28, false)

	local var_25_30
	local var_25_31

	if arg_25_2:getConfig("chapter_tag") == 1 then
		var_25_30 = var_25_28
	end

	if arg_25_2.active then
		var_25_30 = arg_25_2:existOni() and var_25_26 or var_25_24
	end

	local var_25_34

	if var_25_30 then
		setActive = var_25_34

		var_25_34(var_25_30, true)

		GetOrAddComponent = var_25_34

		local var_25_32 = var_25_34(var_25_30, "CanvasGroup")

		var_25_32.alpha = 1

		local var_25_33 = arg_25_0

		var_25_34 = arg_25_0.RecordTween

		local var_25_35 = "fighting" .. arg_25_2.id

		LeanTween = var_28

		local var_25_36 = var_28.alphaCanvas(var_25_32, 0, 0.5)
		local var_25_37 = var_28.setFrom(var_25_36, 1)
		local var_25_38 = var_28.setEase

		LeanTweenType = var_30

		local var_25_39 = var_25_38(var_25_37, var_30.easeInOutSine)

		var_25_34(var_25_33, var_25_35, var_28.setLoopPingPong(var_25_39).uniqueId)
	end

	findTF = var_25_34

	local var_25_40 = var_25_34(var_25_2, "triesLimit")
	local var_25_41 = arg_25_2
	local var_25_42 = arg_25_2.isTriesLimit(var_25_41)

	setActive = var_25_41

	var_25_41(var_25_40, var_25_42)

	if var_25_42 then
		local var_25_43 = arg_25_2:getConfig("count") - arg_25_2:getTodayDefeatCount() .. "/" .. var_27

		setText = var_29

		local var_25_44 = var_25_40
		local var_25_45 = var_25_40.Find(var_25_44, "label")

		i18n = var_25_44

		var_29(var_25_45, var_25_44("levelScene_chapter_count_tip"))

		setText = var_29

		local var_25_46 = var_25_40
		local var_25_47 = var_25_40.Find(var_25_46, "Text")

		setColorStr = var_25_46

		local var_25_48 = var_25_43

		if var_27 <= arg_25_2:getTodayDefeatCount() then
			COLOR_RED = var_33

			if not var_33 then
				COLOR_GREEN = var_33
			end

			var_29(var_25_47, var_25_46(var_25_48, var_33))

			pg = var_29

			local var_25_49 = var_29.expedition_data_by_map
			local var_25_50 = arg_25_2
			local var_25_51 = var_25_49[arg_25_2.getConfig(var_25_50, "map")].on_activity

			getProxy = var_30
			ChapterProxy = var_25_50

			local var_25_52 = var_30(var_25_50)
			local var_25_53

			if var_30.IsActivitySPChapterActive(var_25_52, var_25_51) then
				SettingsProxy = var_25_53
				var_25_53 = var_25_53.IsShowActivityMapSPTip()
			end

			setActive = var_25_52

			var_25_52(var_25_40:Find("TipRect"), var_25_53)

			local var_25_54 = arg_25_2
			local var_25_55 = arg_25_2.GetDailyBonusQuota(var_25_54)

			findTF = var_25_54

			local var_25_56 = var_25_54(var_25_2, "mark")
			local var_25_57 = var_28.Find(var_25_56, "bonus")
			local var_25_58 = var_29.Find(var_25_57, "icon")

			findTF = var_25_57

			local var_25_59 = var_25_57(var_29, "icon/Image")

			setActive = var_32

			var_32(var_29, var_25_55)

			setActive = var_32

			var_32(var_28, var_25_55)

			local var_25_60, var_25_61

			if var_25_58 then
				setActive = var_32
				var_25_60 = var_25_58
				var_25_61 = var_25_55 and arg_25_0.bonusPtIconPath

				var_32(var_25_60, var_25_61)
			end

			if var_25_55 then
				var_25_60 = var_28

				local var_25_62 = var_28.GetComponent

				typeof = var_25_61
				CanvasGroup = var_1_10035

				local var_25_63 = var_25_62(var_25_60, var_25_61(var_1_10035))

				var_25_60 = arg_25_2:GetDailyBonusIconName()

				local var_25_64 = arg_25_0.sceneParent.loader

				var_34.GetSprite(var_25_64, "ui/levelmainscene_atlas", var_25_60, var_29)

				if var_25_58 and arg_25_0.bonusPtIconPath then
					if var_25_59 then
						GetImageSpriteFromAtlasAsync = var_34

						var_34(arg_25_0.bonusPtIconPath, "", var_25_59, true)
					else
						GetImageSpriteFromAtlasAsync = var_34

						var_34(arg_25_0.bonusPtIconPath, "", var_25_58, true)
					end
				end

				LeanTween = var_34

				local var_25_65 = var_34.cancel

				go = var_25_64

				var_25_65(var_25_64(var_28), true)

				local var_25_66 = var_28.anchoredPosition.y

				var_25_63.alpha = 0
				LeanTween = var_35

				local var_25_67 = var_35.value

				go = var_36

				local var_25_68 = var_25_67(var_36(var_28), 0, 1, 0.2)
				local var_25_69 = var_35.setOnUpdate

				System = var_1_10037

				local var_25_70 = var_25_69(var_25_68, var_1_10037.Action_float(function(arg_26_0)
					var_25_63.alpha = arg_26_0

					local var_26_0 = var_0.anchoredPosition

					var_26_0.y = var_25_66 * arg_26_0
					var_0.anchoredPosition = var_26_0

					return
				end))
				local var_25_71 = var_35.setOnComplete

				System = var_1_10037

				local var_25_72 = var_25_71(var_25_70, var_1_10037.Action(function()
					var_25_63.alpha = 1

					local var_27_0 = var_0.anchoredPosition

					var_27_0.y = var_25_66
					var_0.anchoredPosition = var_27_0

					return
				end))
				local var_25_73 = var_35.setEase

				LeanTweenType = var_1_10037

				local var_25_74 = var_25_73(var_25_72, var_1_10037.easeOutSine)

				var_35.setDelay(var_25_74, 0.7)
			end

			local var_25_75 = arg_25_2.id

			onButton = var_25_60

			local var_25_76 = arg_25_0
			local var_25_77 = var_25_2

			local function var_25_78()
				local var_28_0 = arg_25_0

				var_0.TryOpenChapterInfo(var_28_0, var_25_75, nil, var_25_5.list)

				return
			end

			SFX_UI_WEIGHANCHOR_SELECT = var_1_10037

			var_25_60(var_25_76, var_25_77, var_25_78, var_1_10037)
			arg_25_0:PlayerLevelTplAnimation(arg_25_1, {
				status = var_25_6[var_25_7],
				chapterVO = arg_25_2
			})

			return
		end
	end
end

function var_0_1.PlayerLevelTplAnimation(arg_29_0, arg_29_1, arg_29_2)
	return
end

function var_0_1.SwitchChapter(arg_30_0, arg_30_1)
	if not arg_30_0.chapterGroupDict[arg_30_1] then
		return
	end

	if var_2.list[var_2.index] == arg_30_1 then
		return
	end

	table = var_4
	var_2.index = var_4.indexof(var_2.list, arg_30_1)

	local var_30_0 = var_2.list[1]

	getProxy = var_6
	PlayerProxy = var_1_10007

	local var_30_1 = var_6(var_1_10007)
	local var_30_2 = var_6.getRawData(var_30_1).id

	PlayerPrefs = var_30_1

	var_30_1.SetInt("spchapter_selected_" .. var_30_2 .. "_" .. var_30_0, var_4)

	local var_30_3 = arg_30_0.chapterTFsById[var_3]

	arg_30_0.chapterTFsById[var_3] = nil
	arg_30_0.chapterTFsById[arg_30_1] = var_30_3

	arg_30_0:UpdateChapterTF(arg_30_1)

	return
end

function var_0_1.UpdateChapterTF(arg_31_0, arg_31_1)
	if not arg_31_0.chapterGroupDict[arg_31_1] then
		return
	end

	if arg_31_0.chapterTFsById[arg_31_1] then
		getProxy = var_1_10004
		ChapterProxy = var_1_10005

		local var_31_0 = var_1_10004(var_1_10005)
		local var_31_1 = var_4.getChapterById(var_31_0, arg_31_1)

		arg_31_0:UpdateMapItem(var_3, var_31_1)
	end

	return
end

function var_0_1.UpdateStory(arg_32_0)
	local var_32_0 = {}

	pg = var_1_10002

	local var_32_1 = var_1_10002.NewStoryMgr.GetInstance()
	local var_32_2 = 0
	local var_32_3 = 0

	pairs = var_1_10005

	for iter_32_0, iter_32_1 in var_1_10005(arg_32_0.storyNodesDict) do
		local var_32_4 = arg_32_0.storyHolder
		local var_32_5 = var_10.Find

		tostring = var_1_10012

		local var_32_6 = var_32_5(var_32_4, var_1_10012(iter_32_1.id))

		var_1_10012 = iter_32_1

		local var_32_7 = iter_32_1.IsActive(var_1_10012, arg_32_0.activity, arg_32_0.sceneParent.ptActivity)

		setActive = var_1_10012

		var_1_10012(var_32_6, var_32_7)

		setText = var_1_10012

		var_1_10012(var_32_6:Find("main/char/bg/Text"), iter_32_1:GetName())

		local var_32_8 = iter_32_1

		var_1_10012 = iter_32_1.IsReaded(var_32_8)
		setActive = var_32_8

		var_32_8(var_32_6:Find("main/char"), not var_1_10012)

		setActive = var_32_8

		var_32_8(var_32_6:Find("main/talk"), var_1_10012)

		onButton = var_32_8

		var_32_8(arg_32_0, var_32_6, function()
			if var_1_10012 then
				return
			end

			local var_33_0 = iter_32_1
			local var_33_1 = var_0.GetStory(var_33_0)
			local var_33_2 = arg_32_0

			var_1.PlayStory(var_33_2, var_33_1, function()
				local var_34_0 = arg_32_0

				var_0.UpdateView(var_34_0)

				return
			end)

			return
		end)

		var_32_2 = var_32_2 + (var_1_10012 and 1 or 0)
		var_32_3 = var_32_3 + 1
	end

	setText = var_5

	var_5(arg_32_0.progressText, var_32_2 .. "/" .. var_32_3)

	setActive = var_5

	local var_32_9 = arg_32_0.storyAward

	tobool = var_7

	var_5(var_32_9, var_7(arg_32_0.storyTask))

	if arg_32_0.storyTask then
		local var_32_10 = arg_32_0.storyTask
		local var_32_11 = var_5.getConfig(var_32_10, "award_display")

		Drop = var_32_10

		local var_32_12 = var_32_10.Create(var_32_11[1])

		updateDrop = var_7

		local var_32_13 = arg_32_0.storyAward

		var_7(var_8.GetChild(var_32_13, 0), var_32_12)

		local var_32_14 = arg_32_0.storyTask
		local var_32_15 = var_7.getTaskStatus(var_32_14)

		setActive = var_32_14

		local var_32_16 = arg_32_0.storyAward

		var_32_14(var_9.Find(var_32_16, "get"), var_32_15 == 1)

		setActive = var_32_14

		local var_32_17 = arg_32_0.storyAward

		var_32_14(var_9.Find(var_32_17, "got"), var_32_15 == 2)

		onButton = var_32_14

		var_32_14(arg_32_0, arg_32_0.storyAward, function()
			local var_35_0 = arg_32_0
			local var_35_1 = var_0.emit

			BaseUI = var_2_10002

			var_35_1(var_35_0, var_2_10002.ON_DROP, var_32_12)

			return
		end)
	end

	return
end

function var_0_1.SwitchStoryMapAndBGM(arg_36_0)
	local var_36_0 = arg_36_0.data
	local var_36_1 = var_1.getConfig(var_36_0, "default_background")
	local var_36_2 = arg_36_0.data
	local var_36_3 = var_2.getConfig(var_36_2, "default_bgm")
	local var_36_4

	underscore = var_4

	local var_36_5 = var_4.keys(arg_36_0.storyNodesDict)

	table = var_5

	var_5.sort(var_36_5)

	for iter_36_0 = 1, #var_36_5 do
		local var_36_6 = arg_36_0.storyNodesDict[var_36_5[iter_36_0]]

		if var_9.IsReaded(var_36_6) then
			defaultValue = var_10
			var_36_1 = var_10(var_9:GetCleanBG(), var_36_1)
			defaultValue = var_10
			var_36_3 = var_10(var_9:GetCleanBGM(), var_36_3)
			defaultValue = var_10
			var_36_4 = var_10(var_9:GetCleanAnimator(), var_36_4)
		else
			break
		end
	end

	local var_36_7 = arg_36_0.sceneParent

	var_5.SwitchBG(var_36_7, {
		{
			bgPrefix = "bg",
			BG = var_36_1,
			Animator = var_36_4
		}
	})

	pg = var_5

	local var_36_8 = var_5.BgmMgr.GetInstance()

	var_5.Push(var_36_8, arg_36_0.__cname, var_36_3)

	return
end

function var_0_1.TrySubmitTask(arg_37_0)
	underscore = var_1_10001

	local var_37_0 = var_1_10001.all

	underscore = var_1_10002

	if var_37_0(var_1_10002.values(arg_37_0.storyNodesDict), function(arg_38_0)
		return arg_38_0:IsReaded()
	end) and arg_37_0.storyTask then
		local var_37_1 = arg_37_0.storyTask

		if var_1.getTaskStatus(var_37_1) == 1 then
			local var_37_2 = arg_37_0
			local var_37_3 = arg_37_0.emit

			LevelMediator2 = var_3

			var_37_3(var_37_2, var_3.ON_SUBMIT_TASK, arg_37_0.storyTask.id)

			return
		end
	end

	return
end

function var_0_1.TryOpenChapter(arg_39_0, arg_39_1)
	if arg_39_0.chapterTFsById[arg_39_1] then
		local var_39_0 = var_2
		local var_39_1 = var_2.Find(var_39_0, "main")

		triggerButton = var_39_0

		var_39_0(var_39_1)
	end

	return
end

function var_0_1.PlayStory(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	if not arg_40_1 then
		existCall = var_1_10004

		return var_1_10004(arg_40_2)
	end

	pg = var_1_10004

	local var_40_0 = var_1_10004.NewStoryMgr.GetInstance()
	local var_40_1 = var_4.IsPlayed(var_40_0, arg_40_1)

	seriesAsync = var_40_0

	var_40_0({
		function(arg_41_0)
			if var_40_1 and not arg_40_3 then
				return arg_41_0()
			end

			tonumber = var_1

			if var_1(arg_40_1) and var_1 > 0 then
				local var_41_0 = arg_40_0
				local var_41_1 = var_2.emit

				LevelMediator2 = var_2_10004

				var_41_1(var_41_0, var_2_10004.ON_PERFORM_COMBAT, var_1, nil, var_40_1)
			else
				local var_41_2 = var_0

				var_2.Play(var_41_2, arg_40_1, arg_41_0, arg_40_3)
			end

			return
		end,
		function(arg_42_0, ...)
			existCall = var_2_10001

			var_2_10001(arg_40_2, ...)

			return
		end
	})

	return
end

function var_0_1.UpdateStoryTask(arg_43_0)
	local var_43_0 = arg_43_0.activity
	local var_43_1 = var_1.getConfig(var_43_0, "config_client").task_id

	getProxy = var_43_0
	TaskProxy = var_3

	local var_43_2 = var_43_0(var_3)

	if not var_2.getTaskVO(var_43_2, var_43_1) then
		errorMsg = var_43_2

		var_43_2("Missing Activity Task ID : " .. var_43_1)
	end

	print = var_43_2

	var_43_2(var_43_1)

	if not var_2 then
		::label_43_0::

		Task = var_43_2
		var_43_2 = var_43_2.New({
			id = var_43_1
		})
	end

	arg_43_0.storyTask = var_43_2

	return
end

function var_0_1.OnSubmitTaskDone(arg_44_0)
	arg_44_0:UpdateView()

	return
end

function var_0_1.OnDestroy(arg_45_0)
	return
end

return var_0_1
