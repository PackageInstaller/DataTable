class = var_0_10000

local var_0_0 = "MapBuilderSPFull"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MapBuilderSP"))

function var_0_1.GetType(arg_1_0)
	MapBuilder = var_1_10001

	return var_1_10001.TYPESPFULL
end

function var_0_1.getUIName(arg_2_0)
	return "LevelSelectSPFullUI"
end

function var_0_1.OnInit(arg_3_0)
	var_0_1.super.OnInit(arg_3_0)

	local var_3_0 = arg_3_0._tf

	arg_3_0.progressText = var_1.Find(var_3_0, "Story/Desc/Digit")

	local var_3_1 = arg_3_0._tf

	arg_3_0.mapSwitchList = var_1.Find(var_3_1, "Battle/MapItems/List")

	return
end

function var_0_1.UpdateButtons(arg_4_0)
	var_0_1.super.UpdateButtons(arg_4_0)

	local var_4_0 = arg_4_0:getMaps()
	local var_4_1 = {}
	local var_4_2 = arg_4_0.contextData.map
	local var_4_4

	if var_3.isRemaster(var_4_2) then
		local var_4_3 = arg_4_0.contextData.map

		var_4_4 = var_4_4.getRemaster(var_4_3)
		pg = var_1_10004
		var_4_1 = var_1_10004.re_map_template[var_4_4].drop_gain
	end

	setActive = var_4_4

	var_4_4(arg_4_0.sceneParent.eventContainer, #var_4_1 <= 0 and #var_4_0 <= 1)

	if arg_4_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE then
		arg_4_0:UpdateSwitchMapButtons()
	else
		local var_4_5 = arg_4_0.sceneParent

		var_4.HideBtns(var_4_5)
	end

	return
end

function var_0_1.OnHide(arg_5_0)
	local var_5_0 = arg_5_0.sceneParent

	var_1.HideBtns(var_5_0)
	var_0_1.super.OnHide(arg_5_0)

	return
end

function var_0_1.UpdateBattle(arg_6_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = arg_6_0.displayChapterIDs
	local var_6_2 = {}

	ipairs = var_1_10004

	for iter_6_0, iter_6_1 in var_1_10004(var_6_1) do
		local var_6_3 = var_6_0:getChapterById(iter_6_1)

		if var_9.isUnlock(var_6_3) or var_9:activeAlways() then
			table = var_10

			var_10.insert(var_6_2, var_9)
		end
	end

	table = var_4

	var_4.clear(arg_6_0.chapterTFsById)

	UIItemList = var_4

	var_4.StaticAlign(arg_6_0.itemHolder, arg_6_0.chapterTpl, #var_6_2, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_7_0 = var_6_2[arg_7_1 + 1]
		local var_7_1 = arg_6_0

		var_4.UpdateMapItem(var_7_1, arg_7_2, var_7_0)

		arg_7_2.name = "Chapter_" .. var_7_0.id
		arg_6_0.chapterTFsById[var_7_0.id] = arg_7_2

		return
	end)

	return
end

function var_0_1.UpdateSwitchMapButtons(arg_8_0)
	local var_8_0 = arg_8_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE
	local var_8_1 = arg_8_0.contextData.map
	local var_8_2, var_8_3 = var_2.isActivity(var_8_1)
	local var_8_4 = arg_8_0.contextData.map
	local var_8_5 = #arg_8_0:getMaps()

	if 1 < var_8_5 then
		UIItemList = var_8_5
		var_8_5 = var_8_5.StaticAlign

		local var_8_6 = arg_8_0.mapSwitchList
		local var_8_7 = arg_8_0.mapSwitchList

		var_8_5(var_8_6, var_9.GetChild(var_8_7, 0), #var_5, function(arg_9_0, arg_9_1, arg_9_2)
			UIItemList = var_2_10003

			if arg_9_0 ~= var_2_10003.EventUpdate then
				return
			end

			local var_9_0 = var_0[arg_9_1 + 1]
			local var_9_1 = var_3.getMapType(var_9_0)

			setActive = var_2_10005

			var_2_10005(arg_9_2:Find("Unselect"), var_3.id ~= var_8_4.id)

			setActive = var_2_10005

			var_2_10005(arg_9_2:Find("Selected"), var_3.id == var_8_4.id)

			local var_9_2
			local var_9_3 = #(var_3:getConfig("map_name") or "")

			if 0 < var_9_3 then
				i18n = var_9_3
				var_9_2 = var_9_3(var_6)
			else
				Map = var_9_3

				if var_9_1 == var_9_3.ACT_EXTRA then
					local var_9_4 = var_3:getChapters()[1]

					if var_9_3.IsSpChapter(var_9_4) then
						i18n = var_8
						var_9_2 = var_8("levelscene_mapselect_sp")
					else
						i18n = var_8
						var_9_2 = var_8("levelscene_mapselect_ex")
					end
				else
					var_9_3 = var_3.id % 10
					assert = var_8

					var_8(var_9_3 == 1 or var_9_3 == 2)

					i18n = var_8
					var_9_2 = var_8("levelscene_mapselect_part" .. var_9_3)
				end
			end

			Map = var_9_3

			if var_9_1 == var_9_3.ACT_EXTRA then
				local var_9_5 = var_3:getChapters()[1]

				if var_7.IsSpChapter(var_9_5) then
					pg = var_8

					local var_9_6 = var_8.expedition_data_by_map[var_7:getConfig("map")].on_activity

					setActive = var_9

					local var_9_7 = arg_9_2:Find("Tip")
					local var_9_9

					if var_3.id ~= var_8_4.id then
						getProxy = var_9_9
						ChapterProxy = var_14

						local var_9_8 = var_9_9(var_14)

						if var_9_9.IsActivitySPChapterActive(var_9_8, var_9_6) then
							SettingsProxy = var_9_9
							var_9_9 = var_9_9.IsShowActivityMapSPTip()
						end
					else
						var_9_9 = false
					end

					if false then
						var_9_9 = true
					end

					var_9(var_9_7, var_9_9)
				end
			end

			setText = var_7

			var_7(arg_9_2:Find("Unselect/Text"), var_9_2)

			setText = var_7

			local var_9_10 = arg_9_2

			var_7(arg_9_2.Find(var_9_10, "Selected/Text"), var_9_2)

			local var_9_11 = var_3
			local var_9_12, var_9_13 = var_3.isUnlock(var_9_11)

			getProxy = var_9_11
			PlayerProxy = var_9_10

			local var_9_14 = var_9_11(var_9_10)
			local var_9_15 = var_9.getRawData(var_9_14).id
			local var_9_16

			if var_9_12 then
				PlayerPrefs = var_9_14
				var_9_16 = var_9_14.GetInt("MapFirstUnlock" .. var_3.id .. "_" .. var_9_15, 0) == 0
			end

			setActive = var_9_14

			var_9_14(arg_9_2:Find("Unselect/Lock"), not var_9_12 or var_9_16)

			onButton = var_9_14

			local var_9_17 = arg_8_0
			local var_9_18 = arg_9_2

			local function var_9_19()
				if var_0.id == var_8_4.id then
					return
				end

				local var_10_1

				if var_9_12 then
					local var_10_0 = arg_8_0

					var_10_1 = var_10_1.emit
					LevelUIConst = var_3_10003

					var_10_1(var_10_0, var_3_10003.SET_MAP, var_0.id)
				else
					pg = var_10_1

					local var_10_2 = var_10_1.TipsMgr.GetInstance()

					var_0.ShowTips(var_10_2, var_9_13)
				end

				return
			end

			SFX_PANEL = var_16

			var_9_14(var_9_17, var_9_18, var_9_19, var_16)

			return
		end)
	else
		setActive = var_8_5
		var_1_10010 = arg_8_0._tf

		var_8_5(var_8.Find(var_1_10010, "Battle/MapItems"), false)
	end

	local var_8_8 = var_8_4:getConfig("type")

	setActive = var_7

	local var_8_9 = arg_8_0.sceneParent.actExtraRank

	Map = var_1_10010

	local var_8_11

	if var_8_8 == var_1_10010.ACT_EXTRA then
		_ = var_10

		local var_8_10 = var_10.any

		getProxy = var_1_10012
		ActivityProxy = var_1_10014
		var_1_10014 = var_1_10012(var_1_10014)
		var_1_10012 = var_1_10012.getActivitiesByType
		ActivityConst = var_1_10015
		var_8_11 = var_8_10(var_1_10012(var_1_10014, var_1_10015.ACTIVITY_TYPE_EXTRA_CHAPTER_RANK), function(arg_11_0)
			if not arg_11_0 or arg_11_0:isEnd() then
				return
			end

			local var_11_0 = arg_11_0:getConfig("config_data")[1]

			_ = var_2_10002

			local var_11_1 = var_2_10002.any
			local var_11_2 = var_8_4

			return var_11_1(var_4.getChapters(var_11_2), function(arg_12_0)
				if not arg_12_0:IsEXChapter() then
					return false
				end

				table = var_1

				return var_1.contains(arg_12_0:getConfig("boss_expedition_id"), var_11_0)
			end)
		end)
	else
		var_8_11 = false
	end

	if false then
		var_8_11 = true
	end

	var_7(var_8_9, var_8_11)

	setActive = var_7

	local var_8_12 = arg_8_0.sceneParent.actExchangeShopBtn

	ActivityConst = var_8_11

	local var_8_13

	if not var_8_11.HIDE_PT_PANELS then
		inRemasterMap = var_10

		if not var_10 then
			var_1_10012 = arg_8_0.sceneParent
			var_8_13 = var_10.IsActShopActive(var_1_10012)

			goto label_8_0
		end
	end

	var_8_13 = false

	if false then
		var_8_13 = true
	end

	::label_8_0::

	var_7(var_8_12, var_8_13)

	if arg_8_0.contextData.map then
		getProxy = var_7
		ActivityProxy = var_8_12

		local var_8_14 = var_7(var_8_12)
		local var_8_15 = var_7.getActivityById

		var_1_10012 = arg_8_0.contextData.map

		local var_8_16

		if not var_8_15(var_8_14, var_10.getConfig(var_1_10012, "on_activity")) then
			var_8_16 = nil
		end

		local var_8_17 = var_8_16 and not var_8_16:isEnd() and var_8_16:GetConfigClientSetting("PTID")
		local var_8_18 = arg_8_0.sceneParent
		local var_8_19 = var_9.updatePtActivity

		underscore = var_1_10012

		local var_8_20 = var_1_10012.detect

		getProxy = var_1_10014
		ActivityProxy = var_1_10016

		local var_8_21 = var_1_10014(var_1_10016)
		local var_8_22 = var_14.getActivitiesByType

		ActivityConst = var_1_10017

		var_8_19(var_8_18, var_8_20(var_8_22(var_8_21, var_1_10017.ACTIVITY_TYPE_PT_RANK), function(arg_13_0)
			return arg_13_0:getConfig("config_id") == var_8_17
		end))

		setActive = var_8_19

		local var_8_23 = arg_8_0.sceneParent.ptTotal

		ActivityConst = var_12

		if not var_12.HIDE_PT_PANELS then
			inRemasterMap = var_12

			if not var_12 then
				local var_8_25

				if var_8_3 and arg_8_0.sceneParent.ptActivity then
					local var_8_24 = arg_8_0.sceneParent.ptActivity

					if not var_12.isEnd(var_8_24) then
						var_8_25 = var_8_0

						goto label_8_2
					end

					var_8_25 = false

					if false then
						var_8_25 = true
					end
				end

				::label_8_2::

				var_8_19(var_8_23, var_8_25)

				local var_8_26 = arg_8_0.sceneParent

				var_9.updateCountDown(var_8_26)

				return
			end
		end
	end
end

function var_0_1.PlayEnterAnim(arg_14_0)
	local var_14_0 = arg_14_0.contextData.map
	local var_14_1

	if #arg_14_0:getMaps() > 1 then
		UIItemList = var_14_1
		var_14_1 = var_14_1.StaticAlign

		local var_14_2 = arg_14_0.mapSwitchList
		local var_14_3 = arg_14_0.mapSwitchList

		var_14_1(var_14_2, var_6.GetChild(var_14_3, 0), #var_2, function(arg_15_0, arg_15_1, arg_15_2)
			UIItemList = var_2_10003

			if arg_15_0 ~= var_2_10003.EventUpdate then
				return
			end

			local var_15_0 = var_0[arg_15_1 + 1]
			local var_15_1, var_15_2 = var_3.isUnlock(var_15_0)

			getProxy = var_15_0
			PlayerProxy = var_2_10008

			local var_15_3 = var_15_0(var_2_10008)
			local var_15_4 = var_6.getRawData(var_15_3).id
			local var_15_5

			if var_15_1 then
				PlayerPrefs = var_15_3
				var_15_5 = var_15_3.GetInt("MapFirstUnlock" .. var_3.id .. "_" .. var_15_4, 0) == 0
			end

			setActive = var_15_3

			var_15_3(arg_15_2:Find("Unselect/Lock"), not var_15_1 or var_15_5)

			if var_15_5 then
				quickPlayAnimation = var_15_3

				var_15_3(arg_15_2:Find("Unselect"), "anim_spfullui_unlock")

				PlayerPrefs = var_15_3

				var_15_3.SetInt("MapFirstUnlock" .. var_3.id .. "_" .. var_15_4, 1)
			end

			return
		end)
	else
		setActive = var_14_1

		local var_14_4 = arg_14_0._tf

		var_14_1(var_5.Find(var_14_4, "Battle/MapItems"), false)
	end

	return
end

function var_0_1.getMaps(arg_16_0)
	local var_16_0 = arg_16_0.contextData.map
	local var_16_1 = var_1.isRemaster(var_16_0)
	local var_16_2

	if var_16_1 then
		getProxy = var_16_0
		ChapterProxy = var_1_10006
		var_1_10006 = var_16_0(var_1_10006)
		var_16_2 = var_16_0.getRemasterMaps(var_1_10006, var_1.remasterId)
	else
		getProxy = var_16_0
		ChapterProxy = var_1_10006

		local var_16_3 = var_16_0(var_1_10006)

		var_16_2 = var_16_0.getMapsByActivities(var_16_3, var_1:getConfig("on_activity"))
	end

	_ = var_16_0

	return (var_16_0.select(var_16_2, function(arg_17_0)
		local var_17_0 = arg_17_0:getMapType()

		Map = var_2_10002

		return var_17_0 ~= var_2_10002.ACTIVITY_HARD
	end))
end

return var_0_1
