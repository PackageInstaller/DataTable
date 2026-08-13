class = var_0_10000

local var_0_0 = "MapBuilderSPSeries"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MapBuilder"))

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

	LevelUIConst = var_4

	var_4_10(var_4_9, var_4.SWITCH_SPCHAPTER_DIFFICULTY, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_4_0

		var_2.SwitchChapter(var_5_0, arg_5_1)

		return
	end)

	onButton = var_4_10

	local var_4_11 = arg_4_0
	local var_4_12 = arg_4_0.battleLayer
	local var_4_13 = var_4.Find(var_4_12, "Story/Switch")

	local function var_4_14()
		local var_6_0 = arg_4_0

		var_0.SetDisplayMode(var_6_0, var_0_1.DISPLAY.STORY)

		return
	end

	SFX_PANEL = var_4_12

	var_4_10(var_4_11, var_4_13, var_4_14, var_4_12)

	onButton = var_4_10

	local var_4_15 = arg_4_0
	local var_4_16 = arg_4_0.storyLayer
	local var_4_17 = var_4.Find(var_4_16, "Battle/Switch")

	local function var_4_18()
		local var_7_0 = arg_4_0

		var_0.SetDisplayMode(var_7_0, var_0_1.DISPLAY.BATTLE)

		return
	end

	SFX_PANEL = var_4_16

	var_4_10(var_4_15, var_4_17, var_4_18, var_4_16)

	setText = var_4_10

	local var_4_19 = arg_4_0.storyLayer
	local var_4_20 = var_3.Find(var_4_19, "Desc/Desc")

	i18n = var_4_17

	var_4_10(var_4_20, var_4_17("series_enemy_storyreward"))

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
	local var_9_4 = var_3.isRemaster(var_9_3)
	local var_9_5 = arg_9_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE

	setActive = var_5

	local var_9_6 = arg_9_0.sceneParent.actExchangeShopBtn

	ActivityConst = var_1_10008

	if not var_1_10008.HIDE_PT_PANELS then
		if var_9_5 then
			::label_9_0::

			if not var_9_4 then
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

					local var_9_17 = arg_9_0.sceneParent.ptTotal

					ActivityConst = var_10

					if not var_10.HIDE_PT_PANELS and not var_9_4 then
						local var_9_19

						if var_9_2 and arg_9_0.sceneParent.ptActivity then
							local var_9_18 = arg_9_0.sceneParent.ptActivity

							if not var_10.isEnd(var_9_18) then
								var_9_19 = var_9_5

								goto label_9_3
							end

							var_9_19 = false

							if false then
								var_9_19 = true
							end
						end

						::label_9_3::

						var_9_13(var_9_17, var_9_19)

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
	arg_12_0.storyNodesDict = {}
	ipairs = var_4

	local var_12_4 = arg_12_0.activity

	for iter_12_0, iter_12_1 in var_4(var_6.getConfig(var_12_4, "config_client").storys) do
		local var_12_5 = arg_12_0.storyNodesDict

		BossRushStoryNode = var_1_10010
		var_12_5[iter_12_1] = var_1_10010.New({
			id = iter_12_1
		})

		local var_12_6 = arg_12_0.storyHolder
		local var_12_7 = var_9.Find

		tostring = var_12

		local var_12_8

		if not var_12_7(var_12_6, var_12(iter_12_1)) then
			cloneTplTo = var_12_8
			var_12_8 = var_12_8(arg_12_0.storyNodeTpl, arg_12_0.storyHolder, iter_12_1)
		end

		local var_12_9 = arg_12_0.storyNodesDict[iter_12_1]

		var_1_10010 = var_1_10010.getConfigTable(var_12_9)
		setLocalPosition = var_12_6

		local var_12_10 = var_12_8
		local var_12_11 = {}

		tonumber = var_1_10015
		var_12_11.x = 0 * var_1_10015(var_1_10010.pos_x)
		tonumber = var_1_10015
		var_12_11.y = 1080 * var_1_10015(var_1_10010.pos_y)

		var_12_6(var_12_10, var_12_11)
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
	local var_20_2 = var_20_0(var_3.getConfig(var_20_1, "name"), "||")

	if arg_20_0.contextData.displayMode == var_0_1.DISPLAY.STORY then
		string = var_2
		var_20_2 = var_2.split(var_20_2[1], "·")
		setText = var_2

		local var_20_3 = arg_20_0.sceneParent.chapterName
		local var_20_4 = var_20_2[1]

		i18n = var_6

		var_2(var_20_3, var_20_4 .. var_6("levelscene_title_story"))
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

	var_4(var_6.Find(var_20_11, "Battle"), var_20_10)

	setActive = var_4

	local var_20_12 = arg_20_0._tf

	var_4(var_6.Find(var_20_12, "Story"), not var_20_10)

	getProxy = var_4
	ChapterProxy = var_6

	local var_20_13 = var_4(var_6)
	local var_20_14 = var_4.IsActivitySPChapterActive
	local var_20_15 = arg_20_0.contextData.map
	local var_20_16

	if var_20_14(var_20_13, var_7.getConfig(var_20_15, "on_activity")) then
		SettingsProxy = var_20_16
		var_20_16 = var_20_16.IsShowActivityMapSPTip()
	end

	setActive = var_5

	local var_20_17 = arg_20_0.battleLayer

	var_5(var_7.Find(var_20_17, "Story/BattleTip"), false)

	setActive = var_5

	local var_20_18 = arg_20_0.storyLayer

	var_5(var_7.Find(var_20_18, "Battle/BattleTip"), var_20_16)
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
	ChapterProxy = var_1_10003

	local var_21_0 = var_1_10001(var_1_10003)
	local var_21_1 = arg_21_0.displayChapterIDs
	local var_21_2 = {}

	ipairs = var_1_10004

	for iter_21_0, iter_21_1 in var_1_10004(var_21_1) do
		local var_21_3 = var_21_0:getChapterById(iter_21_1)

		table = var_1_10010

		var_1_10010.insert(var_21_2, var_21_3)
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

	warning = var_1_10004

	var_1_10004(0 * var_25_1.pos_x, 1080 * var_25_1.pos_y)

	setLocalPosition = var_1_10004

	var_1_10004(arg_25_1, {
		x = 0 * var_25_1.pos_x,
		y = 1080 * var_25_1.pos_y
	})

	findTF = var_1_10004

	local var_25_2 = var_1_10004(arg_25_1, "main")

	setActive = var_25_0

	var_25_0(var_25_2, true)

	findTF = var_25_0

	local var_25_3 = var_25_0(var_25_2, "circle/fordark")

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
	local var_25_8

	if arg_25_2:isUnlock() then
		var_25_7 = 2
		var_25_8 = #var_25_5.list

		if 1 < var_25_8 then
			table = var_25_8
			var_25_7 = var_25_8.indexof(var_25_5.list, arg_25_2.id) + 1
		elseif arg_25_2:IsSpChapter() or arg_25_2:IsEXChapter() then
			var_25_7 = 3
		else
			local var_25_9 = arg_25_0.contextData.map

			if var_25_8.isHardMap(var_25_9) then
				var_25_7 = 3
			end
		end
	end

	findTF = var_25_8

	local var_25_10 = var_25_8(var_25_2, "circle/bk")

	ipairs = var_1_10011

	for iter_25_0, iter_25_1 in var_1_10011(var_25_6) do
		setActive = var_1_10016

		var_1_10016(var_25_10:Find(iter_25_1), iter_25_0 == var_25_7)
	end

	findTF = var_11

	local var_25_11 = var_11(var_25_2, "circle/clear_flag")

	findTF = var_12

	local var_25_12 = var_12(var_25_2, "circle/lock")

	findTF = var_13

	local var_25_13 = var_13(var_25_2, "circle/progress")

	findTF = var_14

	local var_25_14 = var_14(var_25_2, "circle/progress_text")

	findTF = var_15

	local var_25_15 = var_15(var_25_2, "circle/stars")

	string = var_16

	local var_25_16 = var_16.split(var_25_1.name, "|")

	setText = var_17
	findTF = var_19

	var_17(var_19(var_25_2, "info/bk/title_form/title_index"), var_25_1.chapter_name .. "  ")

	setText = var_17
	findTF = var_19

	var_17(var_19(var_25_2, "info/bk/title_form/title"), var_25_16[1])

	setText = var_17
	findTF = var_19

	local var_25_17 = var_19(var_25_2, "info/bk/title_form/title_en")
	local var_25_18

	if not var_25_16[2] then
		var_25_18 = ""
	end

	var_17(var_25_17, var_25_18)

	setFillAmount = var_17

	var_17(var_25_13, arg_25_2.progress / 100)

	setText = var_17

	local var_25_19 = var_25_14

	string = var_20

	var_17(var_25_19, var_20.format("%d%%", arg_25_2.progress))

	setActive = var_17

	local var_25_20 = var_25_15
	local var_25_21 = arg_25_2

	var_17(var_25_20, arg_25_2.existAchieve(var_25_21))

	if arg_25_2:existAchieve() then
		ipairs = var_17

		for iter_25_2, iter_25_3 in var_17(arg_25_2.achieves) do
			ChapterConst = var_25_21
			var_25_21 = var_25_21.IsAchieved(iter_25_3)

			local var_25_22 = var_25_15:GetChild(iter_25_2 - 1)
			local var_25_23 = var_25_23.Find(var_25_22, "light")

			setActive = var_24

			var_24(var_25_23, var_25_21)

			ipairs = var_24

			for iter_25_4, iter_25_5 in var_24(var_25_6) do
				if iter_25_5 ~= "Lock" then
					setActive = var_1_10029

					local var_25_24 = var_25_23:Find(iter_25_5)

					var_1_10032 = iter_25_4 == var_25_7

					var_1_10029(var_25_24, var_1_10032)
				end
			end
		end
	end

	findTF = var_17

	local var_25_25 = var_17(var_25_2, "info/bk/BG")

	ipairs = var_18

	for iter_25_6, iter_25_7 in var_18(var_25_6) do
		setActive = var_25_23

		var_25_23(var_25_25:Find(iter_25_7), iter_25_6 == var_25_7)
	end

	setActive = var_18
	findTF = var_20

	var_18(var_20(var_25_2, "HardEffect"), var_25_7 == 3)

	local var_25_26, var_25_27

	if not arg_25_2.active then
		var_25_26 = arg_25_2
		var_25_27 = arg_25_2.isClear(var_25_26)
	else
		var_25_27 = false
	end

	if false then
		var_25_27 = true
	end

	local var_25_28, var_25_29

	if not arg_25_2.active then
		var_25_28 = arg_25_2
		var_25_29 = not arg_25_2.isUnlock(var_25_28)
	else
		var_25_29 = false
	end

	if false then
		var_25_29 = true
	end

	setActive = var_25_26

	var_25_26(var_25_11, var_25_27)

	setActive = var_25_26

	var_25_26(var_25_12, var_25_29)

	setActive = var_25_26

	var_25_26(var_25_14, not var_25_27 and not var_25_29)
	arg_25_0:DeleteTween("fighting" .. arg_25_2.id)

	findTF = var_20

	local var_25_30 = var_20(var_25_2, "circle/fighting")

	setText = var_25_28
	findTF = var_23

	local var_25_31 = var_23(var_25_30, "Text")

	i18n = var_24

	var_25_28(var_25_31, var_24("tag_level_fighting"))

	findTF = var_25_28

	local var_25_32 = var_25_28(var_25_2, "circle/oni")

	setText = var_22
	findTF = var_24

	local var_25_33 = var_24(var_25_32, "Text")

	i18n = var_25

	var_22(var_25_33, var_25("tag_level_oni"))

	findTF = var_22

	local var_25_34 = var_22(var_25_2, "circle/narrative")

	setText = var_23
	findTF = var_25

	local var_25_35 = var_25(var_25_34, "Text")

	i18n = var_26

	var_23(var_25_35, var_26("tag_level_narrative"))

	setActive = var_23

	var_23(var_25_30, false)

	setActive = var_23

	var_23(var_25_32, false)

	setActive = var_23

	var_23(var_25_34, false)

	local var_25_36
	local var_25_37

	if arg_25_2:getConfig("chapter_tag") == 1 then
		var_25_36 = var_25_34
	end

	if arg_25_2.active then
		var_25_36 = arg_25_2:existOni() and var_25_32 or var_25_30
	end

	local var_25_40

	if var_25_36 then
		setActive = var_25_40

		var_25_40(var_25_36, true)

		GetOrAddComponent = var_25_40

		local var_25_38 = var_25_40(var_25_36, "CanvasGroup")

		var_25_38.alpha = 1

		local var_25_39 = arg_25_0

		var_25_40 = arg_25_0.RecordTween

		local var_25_41 = "fighting" .. arg_25_2.id

		LeanTween = var_29

		local var_25_42 = var_29.alphaCanvas(var_25_38, 0, 0.5)
		local var_25_43 = var_29.setFrom(var_25_42, 1)
		local var_25_44 = var_29.setEase

		LeanTweenType = var_1_10032

		local var_25_45 = var_25_44(var_25_43, var_1_10032.easeInOutSine)

		var_25_40(var_25_39, var_25_41, var_29.setLoopPingPong(var_25_45).uniqueId)
	end

	findTF = var_25_40

	local var_25_46 = var_25_40(var_25_2, "triesLimit")
	local var_25_47 = arg_25_2
	local var_25_48 = arg_25_2.isTriesLimit(var_25_47)

	setActive = var_27

	var_27(var_25_46, var_25_48)

	if var_25_48 then
		var_25_47 = arg_25_2:getConfig("count") - arg_25_2:getTodayDefeatCount() .. "/" .. var_27
		setText = var_29

		local var_25_49 = var_25_46:Find("label")

		i18n = var_1_10032

		var_29(var_25_49, var_1_10032("levelScene_chapter_count_tip"))

		setText = var_29

		local var_25_50 = var_25_46:Find("Text")

		setColorStr = var_32

		local var_25_51 = var_25_47

		var_1_10037 = arg_25_2

		if var_27 <= arg_25_2.getTodayDefeatCount(var_1_10037) then
			COLOR_RED = var_35

			if not var_35 then
				COLOR_GREEN = var_35
			end

			var_29(var_25_50, var_32(var_25_51, var_35))

			pg = var_29

			local var_25_52 = var_29.expedition_data_by_map
			local var_25_53 = arg_25_2
			local var_25_54 = var_25_52[arg_25_2.getConfig(var_25_53, "map")].on_activity

			getProxy = var_30
			ChapterProxy = var_25_53

			local var_25_55 = var_30(var_25_53)
			local var_25_56

			if var_30.IsActivitySPChapterActive(var_25_55, var_25_54) then
				SettingsProxy = var_25_56
				var_25_56 = var_25_56.IsShowActivityMapSPTip()
			end

			setActive = var_25_50

			var_25_50(var_25_46:Find("TipRect"), var_25_56)

			local var_25_57 = arg_25_2:GetDailyBonusQuota()

			findTF = var_25_47

			local var_25_58 = var_25_47(var_25_2, "mark")
			local var_25_59 = var_28.Find(var_25_58, "bonus")
			local var_25_60 = var_29.Find(var_25_59, "icon")

			findTF = var_25_58

			local var_25_61 = var_25_58(var_29, "icon/Image")

			setActive = var_25_59

			var_25_59(var_29, var_25_57)

			setActive = var_25_59

			var_25_59(var_28, var_25_57)

			local var_25_63

			if var_25_60 then
				setActive = var_25_59

				local var_25_62 = var_25_60

				var_25_63 = var_25_57 and arg_25_0.bonusPtIconPath

				var_25_59(var_25_62, var_25_63)
			end

			local var_25_67

			if var_25_57 then
				local var_25_64 = var_28
				local var_25_65 = var_28.GetComponent

				typeof = var_25_63
				CanvasGroup = var_1_10037

				local var_25_66 = var_25_65(var_25_64, var_25_63(var_1_10037))

				var_25_67 = arg_25_2:GetDailyBonusIconName()

				local var_25_68 = arg_25_0.sceneParent.loader

				var_34.GetSprite(var_25_68, "ui/levelmainscene_atlas", var_25_67, var_29)

				if var_25_60 and arg_25_0.bonusPtIconPath then
					if var_25_61 then
						GetImageSpriteFromAtlasAsync = var_34

						var_34(arg_25_0.bonusPtIconPath, "", var_25_61, true)
					else
						GetImageSpriteFromAtlasAsync = var_34

						var_34(arg_25_0.bonusPtIconPath, "", var_25_60, true)
					end
				end

				LeanTween = var_34

				local var_25_69 = var_34.cancel

				go = var_25_68

				var_25_69(var_25_68(var_28), true)

				local var_25_70 = var_28.anchoredPosition.y

				var_25_66.alpha = 0
				LeanTween = var_35

				local var_25_71 = var_35.value

				go = var_37

				local var_25_72 = var_25_71(var_37(var_28), 0, 1, 0.2)
				local var_25_73 = var_35.setOnUpdate

				System = var_1_10038

				local var_25_74 = var_25_73(var_25_72, var_1_10038.Action_float(function(arg_26_0)
					var_25_66.alpha = arg_26_0

					local var_26_0 = var_0.anchoredPosition

					var_26_0.y = var_25_70 * arg_26_0
					var_0.anchoredPosition = var_26_0

					return
				end))
				local var_25_75 = var_35.setOnComplete

				System = var_1_10038

				local var_25_76 = var_25_75(var_25_74, var_1_10038.Action(function()
					var_25_66.alpha = 1

					local var_27_0 = var_0.anchoredPosition

					var_27_0.y = var_25_70
					var_0.anchoredPosition = var_27_0

					return
				end))
				local var_25_77 = var_35.setEase

				LeanTweenType = var_1_10038

				local var_25_78 = var_25_77(var_25_76, var_1_10038.easeOutSine)

				var_35.setDelay(var_25_78, 0.7)
			end

			local var_25_79 = arg_25_2.id

			onButton = var_25_67

			local var_25_80 = arg_25_0
			local var_25_81 = var_25_2

			local function var_25_82()
				local var_28_0 = arg_25_0

				var_0.TryOpenChapterInfo(var_28_0, var_25_79, nil, var_25_5.list)

				return
			end

			SFX_UI_WEIGHANCHOR_SELECT = var_1_10038

			var_25_67(var_25_80, var_25_81, var_25_82, var_1_10038)
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
	PlayerProxy = var_1_10008

	local var_30_1 = var_6(var_1_10008)
	local var_30_2 = var_6.getRawData(var_30_1).id

	PlayerPrefs = var_7

	var_7.SetInt("spchapter_selected_" .. var_30_2 .. "_" .. var_30_0, var_4)

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
		ChapterProxy = var_1_10006

		local var_31_0 = var_1_10004(var_1_10006)
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

		tostring = var_1_10013

		local var_32_6 = var_32_5(var_32_4, var_1_10013(iter_32_1.id))

		var_1_10013 = iter_32_1

		local var_32_7 = iter_32_1.IsActive(var_1_10013, arg_32_0.activity, arg_32_0.sceneParent.ptActivity)

		setActive = var_32_4

		var_32_4(var_32_6, var_32_7)

		setText = var_32_4

		var_32_4(var_32_6:Find("main/char/bg/Text"), iter_32_1:GetName())

		local var_32_8 = iter_32_1:IsReaded()

		setActive = var_1_10013

		var_1_10013(var_32_6:Find("main/char"), not var_32_8)

		setActive = var_1_10013

		var_1_10013(var_32_6:Find("main/talk"), var_32_8)

		onButton = var_1_10013

		var_1_10013(arg_32_0, var_32_6, function()
			if var_32_8 then
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

		var_1_10013 = var_32_8 and 1 or 0
		var_32_2 = var_32_2 + var_1_10013
		var_32_3 = var_32_3 + 1
	end

	setText = var_5

	var_5(arg_32_0.progressText, var_32_2 .. "/" .. var_32_3)

	setActive = var_5

	local var_32_9 = arg_32_0.storyAward

	tobool = var_8

	var_5(var_32_9, var_8(arg_32_0.storyTask))

	if arg_32_0.storyTask then
		local var_32_10 = arg_32_0.storyTask
		local var_32_11 = var_5.getConfig(var_32_10, "award_display")

		Drop = var_6

		local var_32_12 = var_6.Create(var_32_11[1])

		updateDrop = var_32_10

		local var_32_13 = arg_32_0.storyAward

		var_32_10(var_9.GetChild(var_32_13, 0), var_32_12)

		local var_32_14 = arg_32_0.storyTask
		local var_32_15 = var_7.getTaskStatus(var_32_14)

		setActive = var_8

		local var_32_16 = arg_32_0.storyAward

		var_8(var_10.Find(var_32_16, "get"), var_32_15 == 1)

		setActive = var_8

		local var_32_17 = arg_32_0.storyAward

		var_8(var_10.Find(var_32_17, "got"), var_32_15 == 2)

		onButton = var_8

		var_8(arg_32_0, arg_32_0.storyAward, function()
			local var_35_0 = arg_32_0
			local var_35_1 = var_0.emit

			BaseUI = var_2_10003

			var_35_1(var_35_0, var_2_10003.ON_DROP, var_32_12)

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

	underscore = var_36_2

	local var_36_5 = var_36_2.keys(arg_36_0.storyNodesDict)

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

	underscore = var_1_10003

	if var_37_0(var_1_10003.values(arg_37_0.storyNodesDict), function(arg_38_0)
		return arg_38_0:IsReaded()
	end) and arg_37_0.storyTask then
		local var_37_1 = arg_37_0.storyTask

		if var_1.getTaskStatus(var_37_1) == 1 then
			local var_37_2 = arg_37_0
			local var_37_3 = arg_37_0.emit

			LevelMediator2 = var_4

			var_37_3(var_37_2, var_4.ON_SUBMIT_TASK, arg_37_0.storyTask.id)

			return
		end
	end

	return
end

function var_0_1.TryOpenChapter(arg_39_0, arg_39_1)
	if arg_39_0.chapterTFsById[arg_39_1] then
		local var_39_0 = var_2:Find("main")

		triggerButton = var_1_10004

		var_1_10004(var_39_0)
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

	seriesAsync = var_1_10006

	var_1_10006({
		function(arg_41_0)
			if var_40_1 and not arg_40_3 then
				return arg_41_0()
			end

			tonumber = var_1

			if var_1(arg_40_1) and var_1 > 0 then
				local var_41_0 = arg_40_0
				local var_41_1 = var_2.emit

				LevelMediator2 = var_2_10005

				var_41_1(var_41_0, var_2_10005.ON_PERFORM_COMBAT, var_1, nil, var_40_1)
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

	getProxy = var_1_10002
	TaskProxy = var_4

	local var_43_2 = var_1_10002(var_4)

	if not var_2.getTaskVO(var_43_2, var_43_1) then
		errorMsg = var_43_0

		var_43_0("Missing Activity Task ID : " .. var_43_1)
	end

	print = var_43_0

	var_43_0(var_43_1)

	if not var_2 then
		::label_43_0::

		Task = var_43_0
		var_43_0 = var_43_0.New({
			id = var_43_1
		})
	end

	arg_43_0.storyTask = var_43_0

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
