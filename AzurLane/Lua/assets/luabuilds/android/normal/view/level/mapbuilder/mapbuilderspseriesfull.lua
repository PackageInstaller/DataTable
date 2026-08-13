class = var_0_10000

local var_0_0 = "MapBuilderSPSeriesFull"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MapBuilderSPSeries"))

function var_0_1.GetType(arg_1_0)
	MapBuilder = var_1_10001

	return var_1_10001.TYPESPSERIESFULL
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

	if arg_4_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE then
		arg_4_0:UpdateSwitchMapButtons()
	else
		local var_4_0 = arg_4_0.sceneParent

		var_2.HideBtns(var_4_0)
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
	local var_8_0 = arg_8_0.contextData.map
	local var_8_1 = var_1.isRemaster(var_8_0)
	local var_8_2

	if var_8_1 then
		getProxy = var_1_10004
		ChapterProxy = var_1_10005
		var_1_10005 = var_1_10004(var_1_10005)
		var_8_2 = var_1_10004.getRemasterMaps(var_1_10005, var_1.remasterId)
	else
		getProxy = var_1_10004
		ChapterProxy = var_1_10005

		local var_8_3 = var_1_10004(var_1_10005)

		var_8_2 = var_1_10004.getMapsByActivities(var_8_3, var_1:getConfig("on_activity"))
	end

	_ = var_1_10004

	local var_8_4 = var_1_10004.select(var_8_2, function(arg_9_0)
		local var_9_0 = arg_9_0
		local var_9_1 = arg_9_0.getMapType(var_9_0)

		Map = var_9_0

		return var_9_1 ~= var_9_0.ACTIVITY_HARD
	end)

	UIItemList = var_4

	local var_8_5 = var_4.StaticAlign
	local var_8_6 = arg_8_0.mapSwitchList
	local var_8_7 = arg_8_0.mapSwitchList

	var_8_5(var_8_6, var_6.GetChild(var_8_7, 0), #var_8_4, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_10_0 = var_8_4[arg_10_1 + 1]
		local var_10_1 = var_3.getMapType(var_10_0)

		setActive = var_10_0

		var_10_0(arg_10_2:Find("Unselect"), var_3.id ~= var_0.id)

		setActive = var_10_0

		var_10_0(arg_10_2:Find("Selected"), var_3.id == var_0.id)

		local var_10_2
		local var_10_3 = #(var_3:getConfig("map_name") or "")

		if 0 < var_10_3 then
			i18n = var_10_3
			var_10_2 = var_10_3(var_6)
		else
			Map = var_10_3

			local var_10_4

			if var_10_1 == var_10_3.ACT_EXTRA then
				var_10_4 = var_3

				local var_10_5 = var_3.getChapters(var_10_4)[1]

				if var_10_3.IsSpChapter(var_10_5) then
					i18n = var_10_4
					var_10_2 = var_10_4("levelscene_mapselect_sp")
				else
					i18n = var_10_4
					var_10_2 = var_10_4("levelscene_mapselect_ex")
				end
			else
				var_10_3 = var_3.id % 10
				assert = var_10_4

				var_10_4(var_10_3 == 1 or var_10_3 == 2)

				i18n = var_10_4
				var_10_2 = var_10_4("levelscene_mapselect_part" .. var_10_3)
			end
		end

		Map = var_10_3

		if var_10_1 == var_10_3.ACT_EXTRA then
			local var_10_6 = var_3:getChapters()[1]

			if var_7.IsSpChapter(var_10_6) then
				pg = var_8

				local var_10_7 = var_8.expedition_data_by_map[var_7:getConfig("map")].on_activity

				setActive = var_9
				var_2_10011 = arg_10_2

				local var_10_8 = arg_10_2.Find(var_2_10011, "Tip")

				if var_3.id ~= var_0.id then
					getProxy = var_2_10011
					ChapterProxy = var_12

					local var_10_9 = var_2_10011(var_12)

					if var_2_10011.IsActivitySPChapterActive(var_10_9, var_10_7) then
						SettingsProxy = var_2_10011
						var_2_10011 = var_2_10011.IsShowActivityMapSPTip()
					end
				else
					var_2_10011 = false
				end

				if false then
					var_2_10011 = true
				end

				var_9(var_10_8, var_2_10011)
			end
		end

		setText = var_7

		var_7(arg_10_2:Find("Unselect/Text"), var_10_2)

		setText = var_7

		var_7(arg_10_2:Find("Selected/Text"), var_10_2)

		local var_10_10, var_10_11 = var_3:isUnlock()

		getProxy = var_9
		PlayerProxy = var_10

		local var_10_12 = var_9(var_10)
		local var_10_13 = var_9.getRawData(var_10_12).id
		local var_10_14

		if var_10_10 then
			PlayerPrefs = var_2_10011
			var_10_14 = var_2_10011.GetInt("MapFirstUnlock" .. var_3.id .. "_" .. var_10_13, 0) == 0
		end

		setActive = var_2_10011

		var_2_10011(arg_10_2:Find("Unselect/Lock"), not var_10_10 or var_10_14)

		onButton = var_2_10011

		local var_10_15 = arg_8_0
		local var_10_16 = arg_10_2

		local function var_10_17()
			if var_0.id == var_0.id then
				return
			end

			local var_11_1

			if var_10_10 then
				local var_11_0 = arg_8_0

				var_11_1 = var_11_1.emit
				LevelUIConst = var_3_10002

				var_11_1(var_11_0, var_3_10002.SET_MAP, var_0.id)
			else
				pg = var_11_1

				local var_11_2 = var_11_1.TipsMgr.GetInstance()

				var_0.ShowTips(var_11_2, var_10_11)
			end

			return
		end

		SFX_PANEL = var_2_10015

		var_2_10011(var_10_15, var_10_16, var_10_17, var_2_10015)

		return
	end)

	local var_8_8 = var_1
	local var_8_9 = var_1.getConfig(var_8_8, "type")

	setActive = var_8_8

	local var_8_10 = arg_8_0.sceneParent.actExtraRank

	Map = var_7

	local var_8_14

	if var_8_9 == var_7.ACT_EXTRA then
		_ = var_7

		local var_8_11 = var_7.any

		getProxy = var_8
		ActivityProxy = var_1_10009

		local var_8_12 = var_8(var_1_10009)
		local var_8_13 = var_8.getActivitiesByType

		ActivityConst = var_1_10010
		var_8_14 = var_8_11(var_8_13(var_8_12, var_1_10010.ACTIVITY_TYPE_EXTRA_CHAPTER_RANK), function(arg_12_0)
			if not arg_12_0 or arg_12_0:isEnd() then
				return
			end

			local var_12_0 = arg_12_0
			local var_12_1 = arg_12_0.getConfig(var_12_0, "config_data")[1]

			_ = var_12_0

			local var_12_2 = var_12_0.any
			local var_12_3 = var_0

			return var_12_2(var_3.getChapters(var_12_3), function(arg_13_0)
				if not arg_13_0:IsEXChapter() then
					return false
				end

				table = var_1

				return var_1.contains(arg_13_0:getConfig("boss_expedition_id"), var_12_1)
			end)
		end)
	else
		var_8_14 = false
	end

	if false then
		var_8_14 = true
	end

	var_8_8(var_8_10, var_8_14)

	setActive = var_8_8

	local var_8_15 = arg_8_0.sceneParent.actExchangeShopBtn

	ActivityConst = var_8_14

	local var_8_17

	if not var_8_14.HIDE_PT_PANELS and not var_8_1 then
		local var_8_16 = arg_8_0.sceneParent

		var_8_17 = var_7.IsActShopActive(var_8_16)
	else
		var_8_17 = false
	end

	if false then
		var_8_17 = true
	end

	var_8_8(var_8_15, var_8_17)

	setActive = var_8_8

	local var_8_18 = arg_8_0.sceneParent.ptTotal

	ActivityConst = var_8_17

	local var_8_20

	if not var_8_17.HIDE_PT_PANELS and not var_8_1 then
		if arg_8_0.sceneParent.ptActivity then
			local var_8_19 = arg_8_0.sceneParent.ptActivity

			var_8_20 = not var_7.isEnd(var_8_19)
		end
	else
		var_8_20 = false
	end

	if false then
		var_8_20 = true
	end

	var_8_8(var_8_18, var_8_20)

	local var_8_21 = arg_8_0.sceneParent

	var_5.updateActivityRes(var_8_21)

	local var_8_22 = arg_8_0.sceneParent

	var_5.updateCountDown(var_8_22)

	return
end

function var_0_1.PlayEnterAnim(arg_14_0)
	local var_14_0 = arg_14_0.contextData.map
	local var_14_1 = var_1.isRemaster(var_14_0)
	local var_14_2

	if var_14_1 then
		getProxy = var_1_10004
		ChapterProxy = var_1_10005
		var_1_10005 = var_1_10004(var_1_10005)
		var_14_2 = var_1_10004.getRemasterMaps(var_1_10005, var_1.remasterId)
	else
		getProxy = var_1_10004
		ChapterProxy = var_1_10005

		local var_14_3 = var_1_10004(var_1_10005)

		var_14_2 = var_1_10004.getMapsByActivities(var_14_3, var_1:getConfig("on_activity"))
	end

	_ = var_1_10004

	local var_14_4 = var_1_10004.select(var_14_2, function(arg_15_0)
		local var_15_0 = arg_15_0
		local var_15_1 = arg_15_0.getMapType(var_15_0)

		Map = var_15_0

		return var_15_1 ~= var_15_0.ACTIVITY_HARD
	end)

	UIItemList = var_4

	local var_14_5 = var_4.StaticAlign
	local var_14_6 = arg_14_0.mapSwitchList
	local var_14_7 = arg_14_0.mapSwitchList

	var_14_5(var_14_6, var_6.GetChild(var_14_7, 0), #var_14_4, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_16_0 = var_14_4[arg_16_1 + 1]
		local var_16_1, var_16_2 = var_3.isUnlock(var_16_0)

		getProxy = var_2_10006
		PlayerProxy = var_2_10007

		local var_16_3 = var_2_10006(var_2_10007)
		local var_16_4 = var_6.getRawData(var_16_3).id
		local var_16_5

		if var_16_1 then
			PlayerPrefs = var_2_10008
			var_16_5 = var_2_10008.GetInt("MapFirstUnlock" .. var_3.id .. "_" .. var_16_4, 0) == 0
		end

		setActive = var_2_10008

		var_2_10008(arg_16_2:Find("Unselect/Lock"), not var_16_1 or var_16_5)

		if var_16_5 then
			quickPlayAnimation = var_2_10008

			var_2_10008(arg_16_2:Find("Unselect"), "anim_spfullui_unlock")

			PlayerPrefs = var_2_10008

			var_2_10008.SetInt("MapFirstUnlock" .. var_3.id .. "_" .. var_16_4, 1)
		end

		return
	end)

	return
end

return var_0_1
