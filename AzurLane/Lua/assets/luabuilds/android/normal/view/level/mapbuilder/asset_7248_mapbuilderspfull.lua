class = var_0_10000

local var_0_0 = "MapBuilderSPFull"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MapBuilderSP"))

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
		pg = var_4_3
		var_4_1 = var_4_3.re_map_template[var_4_4].drop_gain
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
	ChapterProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)
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
	local var_8_5

	if #arg_8_0:getMaps() > 1 then
		UIItemList = var_8_5
		var_8_5 = var_8_5.StaticAlign

		local var_8_6 = arg_8_0.mapSwitchList

		var_1_10009 = arg_8_0.mapSwitchList

		var_8_5(var_8_6, var_8.GetChild(var_1_10009, 0), #var_5, function(arg_9_0, arg_9_1, arg_9_2)
			UIItemList = var_2_10003

			if arg_9_0 ~= var_2_10003.EventUpdate then
				return
			end

			local var_9_0 = var_0[arg_9_1 + 1]
			local var_9_1 = var_3.getMapType(var_9_0)

			setActive = var_9_0

			var_9_0(arg_9_2:Find("Unselect"), var_3.id ~= var_8_4.id)

			setActive = var_9_0

			var_9_0(arg_9_2:Find("Selected"), var_3.id == var_8_4.id)

			local var_9_2
			local var_9_3 = #(var_3:getConfig("map_name") or "")

			if 0 < var_9_3 then
				i18n = var_9_3
				var_9_2 = var_9_3(var_6)
			else
				Map = var_9_3

				local var_9_4

				if var_9_1 == var_9_3.ACT_EXTRA then
					var_9_4 = var_3

					local var_9_5 = var_3.getChapters(var_9_4)[1]

					if var_9_3.IsSpChapter(var_9_5) then
						i18n = var_9_4
						var_9_2 = var_9_4("levelscene_mapselect_sp")
					else
						i18n = var_9_4
						var_9_2 = var_9_4("levelscene_mapselect_ex")
					end
				else
					var_9_3 = var_3.id % 10
					assert = var_9_4

					var_9_4(var_9_3 == 1 or var_9_3 == 2)

					i18n = var_9_4
					var_9_2 = var_9_4("levelscene_mapselect_part" .. var_9_3)
				end
			end

			Map = var_9_3

			if var_9_1 == var_9_3.ACT_EXTRA then
				local var_9_6 = var_3:getChapters()[1]

				if var_7.IsSpChapter(var_9_6) then
					pg = var_8

					local var_9_7 = var_8.expedition_data_by_map[var_7:getConfig("map")].on_activity

					setActive = var_9
					var_2_10011 = arg_9_2

					local var_9_8 = arg_9_2.Find(var_2_10011, "Tip")

					if var_3.id ~= var_8_4.id then
						getProxy = var_2_10011
						ChapterProxy = var_12

						local var_9_9 = var_2_10011(var_12)

						if var_2_10011.IsActivitySPChapterActive(var_9_9, var_9_7) then
							SettingsProxy = var_2_10011
							var_2_10011 = var_2_10011.IsShowActivityMapSPTip()
						end
					else
						var_2_10011 = false
					end

					if false then
						var_2_10011 = true
					end

					var_9(var_9_8, var_2_10011)
				end
			end

			setText = var_7

			var_7(arg_9_2:Find("Unselect/Text"), var_9_2)

			setText = var_7

			var_7(arg_9_2:Find("Selected/Text"), var_9_2)

			local var_9_10, var_9_11 = var_3:isUnlock()

			getProxy = var_9
			PlayerProxy = var_10

			local var_9_12 = var_9(var_10)
			local var_9_13 = var_9.getRawData(var_9_12).id
			local var_9_14

			if var_9_10 then
				PlayerPrefs = var_2_10011
				var_9_14 = var_2_10011.GetInt("MapFirstUnlock" .. var_3.id .. "_" .. var_9_13, 0) == 0
			end

			setActive = var_2_10011

			var_2_10011(arg_9_2:Find("Unselect/Lock"), not var_9_10 or var_9_14)

			onButton = var_2_10011

			local var_9_15 = arg_8_0
			local var_9_16 = arg_9_2

			local function var_9_17()
				if var_0.id == var_8_4.id then
					return
				end

				local var_10_1

				if var_9_10 then
					local var_10_0 = arg_8_0

					var_10_1 = var_10_1.emit
					LevelUIConst = var_3_10002

					var_10_1(var_10_0, var_3_10002.SET_MAP, var_0.id)
				else
					pg = var_10_1

					local var_10_2 = var_10_1.TipsMgr.GetInstance()

					var_0.ShowTips(var_10_2, var_9_11)
				end

				return
			end

			SFX_PANEL = var_2_10015

			var_2_10011(var_9_15, var_9_16, var_9_17, var_2_10015)

			return
		end)
	else
		setActive = var_8_5

		local var_8_7 = arg_8_0._tf

		var_8_5(var_7.Find(var_8_7, "Battle/MapItems"), false)
	end

	local var_8_8 = var_8_4
	local var_8_9 = var_8_4.getConfig(var_8_8, "type")

	setActive = var_8_8

	local var_8_10 = arg_8_0.sceneParent.actExtraRank

	Map = var_1_10009

	local var_8_13

	if var_8_9 == var_1_10009.ACT_EXTRA then
		_ = var_9

		local var_8_11 = var_9.any

		getProxy = var_1_10010
		ActivityProxy = var_1_10011
		var_1_10011 = var_1_10010(var_1_10011)

		local var_8_12 = var_10.getActivitiesByType

		ActivityConst = var_1_10012
		var_8_13 = var_8_11(var_8_12(var_1_10011, var_1_10012.ACTIVITY_TYPE_EXTRA_CHAPTER_RANK), function(arg_11_0)
			if not arg_11_0 or arg_11_0:isEnd() then
				return
			end

			local var_11_0 = arg_11_0
			local var_11_1 = arg_11_0.getConfig(var_11_0, "config_data")[1]

			_ = var_11_0

			local var_11_2 = var_11_0.any
			local var_11_3 = var_8_4

			return var_11_2(var_3.getChapters(var_11_3), function(arg_12_0)
				if not arg_12_0:IsEXChapter() then
					return false
				end

				table = var_1

				return var_1.contains(arg_12_0:getConfig("boss_expedition_id"), var_11_1)
			end)
		end)
	else
		var_8_13 = false
	end

	if false then
		var_8_13 = true
	end

	var_8_8(var_8_10, var_8_13)

	setActive = var_8_8

	local var_8_14 = arg_8_0.sceneParent.actExchangeShopBtn

	ActivityConst = var_8_13

	local var_8_16

	if not var_8_13.HIDE_PT_PANELS then
		inRemasterMap = var_9

		if not var_9 then
			local var_8_15 = arg_8_0.sceneParent

			var_8_16 = var_9.IsActShopActive(var_8_15)

			goto label_8_0
		end
	end

	var_8_16 = false

	if false then
		var_8_16 = true
	end

	::label_8_0::

	var_8_8(var_8_14, var_8_16)

	if arg_8_0.contextData.map then
		getProxy = var_7
		ActivityProxy = var_8_14

		local var_8_17 = var_7(var_8_14)
		local var_8_18 = var_7.getActivityById
		local var_8_19 = arg_8_0.contextData.map
		local var_8_20

		if not var_8_18(var_8_17, var_9.getConfig(var_8_19, "on_activity")) then
			var_8_20 = nil
		end

		local var_8_21 = var_8_20 and not var_8_20:isEnd() and var_8_20:GetConfigClientSetting("PTID")
		local var_8_22 = arg_8_0.sceneParent
		local var_8_23 = var_9.updatePtActivity

		underscore = var_1_10011

		local var_8_24 = var_1_10011.detect

		getProxy = var_1_10012
		ActivityProxy = var_1_10013

		local var_8_25 = var_1_10012(var_1_10013)
		local var_8_26 = var_12.getActivitiesByType

		ActivityConst = var_1_10014

		var_8_23(var_8_22, var_8_24(var_8_26(var_8_25, var_1_10014.ACTIVITY_TYPE_PT_RANK), function(arg_13_0)
			return arg_13_0:getConfig("config_id") == var_8_21
		end))

		setActive = var_8_23

		local var_8_27 = arg_8_0.sceneParent.ptTotal

		ActivityConst = var_11

		if not var_11.HIDE_PT_PANELS then
			inRemasterMap = var_11

			if not var_11 then
				local var_8_29

				if var_8_3 and arg_8_0.sceneParent.ptActivity then
					local var_8_28 = arg_8_0.sceneParent.ptActivity

					if not var_11.isEnd(var_8_28) then
						var_8_29 = var_8_0

						goto label_8_2
					end

					var_8_29 = false

					if false then
						var_8_29 = true
					end
				end

				::label_8_2::

				var_8_23(var_8_27, var_8_29)

				local var_8_30 = arg_8_0.sceneParent

				var_9.updateCountDown(var_8_30)

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

		var_14_1(var_14_2, var_5.GetChild(var_14_3, 0), #var_2, function(arg_15_0, arg_15_1, arg_15_2)
			UIItemList = var_2_10003

			if arg_15_0 ~= var_2_10003.EventUpdate then
				return
			end

			local var_15_0 = var_0[arg_15_1 + 1]
			local var_15_1, var_15_2 = var_3.isUnlock(var_15_0)

			getProxy = var_2_10006
			PlayerProxy = var_2_10007

			local var_15_3 = var_2_10006(var_2_10007)
			local var_15_4 = var_6.getRawData(var_15_3).id
			local var_15_5

			if var_15_1 then
				PlayerPrefs = var_2_10008
				var_15_5 = var_2_10008.GetInt("MapFirstUnlock" .. var_3.id .. "_" .. var_15_4, 0) == 0
			end

			setActive = var_2_10008

			var_2_10008(arg_15_2:Find("Unselect/Lock"), not var_15_1 or var_15_5)

			if var_15_5 then
				quickPlayAnimation = var_2_10008

				var_2_10008(arg_15_2:Find("Unselect"), "anim_spfullui_unlock")

				PlayerPrefs = var_2_10008

				var_2_10008.SetInt("MapFirstUnlock" .. var_3.id .. "_" .. var_15_4, 1)
			end

			return
		end)
	else
		setActive = var_14_1

		local var_14_4 = arg_14_0._tf

		var_14_1(var_4.Find(var_14_4, "Battle/MapItems"), false)
	end

	return
end

function var_0_1.getMaps(arg_16_0)
	local var_16_0 = arg_16_0.contextData.map
	local var_16_1 = var_1.isRemaster(var_16_0)
	local var_16_2

	if var_16_1 then
		getProxy = var_1_10004
		ChapterProxy = var_1_10005
		var_1_10005 = var_1_10004(var_1_10005)
		var_16_2 = var_1_10004.getRemasterMaps(var_1_10005, var_1.remasterId)
	else
		getProxy = var_1_10004
		ChapterProxy = var_1_10005

		local var_16_3 = var_1_10004(var_1_10005)

		var_16_2 = var_1_10004.getMapsByActivities(var_16_3, var_1:getConfig("on_activity"))
	end

	_ = var_1_10004

	return (var_1_10004.select(var_16_2, function(arg_17_0)
		local var_17_0 = arg_17_0
		local var_17_1 = arg_17_0.getMapType(var_17_0)

		Map = var_17_0

		return var_17_1 ~= var_17_0.ACTIVITY_HARD
	end))
end

return var_0_1
