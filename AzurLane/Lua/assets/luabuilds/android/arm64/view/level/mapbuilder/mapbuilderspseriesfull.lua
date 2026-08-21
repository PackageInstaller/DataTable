local var_0_0 = class("MapBuilderSPSeriesFull", import(".MapBuilderSPSeries"))

function var_0_0.GetType(arg_1_0)
	return MapBuilder.TYPESPSERIESFULL
end

function var_0_0.getUIName(arg_2_0)
	return "LevelSelectSPFullUI"
end

function var_0_0.OnInit(arg_3_0)
	var_0_0.super.OnInit(arg_3_0)

	arg_3_0.progressText = arg_3_0._tf:Find("Story/Desc/Digit")
	arg_3_0.mapSwitchList = arg_3_0._tf:Find("Battle/MapItems/List")

	return
end

function var_0_0.UpdateButtons(arg_4_0)
	var_0_0.super.UpdateButtons(arg_4_0)

	if arg_4_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE then
		arg_4_0:UpdateSwitchMapButtons()
	else
		arg_4_0.sceneParent:HideBtns()
	end

	return
end

function var_0_0.OnHide(arg_5_0)
	arg_5_0.sceneParent:HideBtns()
	var_0_0.super.OnHide(arg_5_0)

	return
end

function var_0_0.UpdateBattle(arg_6_0)
	local var_6_0 = getProxy(ChapterProxy)
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.displayChapterIDs) do
		local var_6_2 = var_6_0:getChapterById(iter_6_1)

		if var_6_2:isUnlock() or var_6_2:activeAlways() then
			table.insert({}, var_6_2)
		end
	end

	table.clear(arg_6_0.chapterTFsById)
	UIItemList.StaticAlign(arg_6_0.itemHolder, arg_6_0.chapterTpl, #{}, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_7_0 = var_6_1[arg_7_1 + 1]

		arg_6_0:UpdateMapItem(arg_7_2, var_6_1[arg_7_1 + 1])

		arg_7_2.name = "Chapter_" .. var_7_0.id
		arg_6_0.chapterTFsById[var_7_0.id] = arg_7_2

		return
	end)

	return
end

function var_0_0.UpdateSwitchMapButtons(arg_8_0)
	local var_8_0 = arg_8_0.contextData.map
	local var_8_1 = arg_8_0.contextData.map:isRemaster()
	local var_8_2 = var_8_1 and getProxy(ChapterProxy):getRemasterMaps(var_8_0.remasterId) or getProxy(ChapterProxy):getMapsByActivities(var_8_0:getConfig("on_activity"))

	UIItemList.StaticAlign(arg_8_0.mapSwitchList, arg_8_0.mapSwitchList:GetChild(0), #_.select(var_8_2, function(arg_9_0)
		return arg_9_0:getMapType() ~= Map.ACTIVITY_HARD
	end), function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_10_0 = var_0[arg_10_1 + 1]
		local var_10_1 = var_0[arg_10_1 + 1]:getMapType()

		setActive(arg_10_2:Find("Unselect"), var_0[arg_10_1 + 1].id ~= var_8_0.id)
		setActive(arg_10_2:Find("Selected"), var_10_0.id == var_8_0.id)

		local var_10_2
		local var_10_3 = var_10_0:getConfig("map_name")

		if #(var_10_3 or "") > 0 then
			var_10_2 = i18n(var_10_3)
		elseif var_10_1 == Map.ACT_EXTRA then
			var_10_2 = var_10_0:getChapters()[1]:IsSpChapter() and i18n("levelscene_mapselect_sp") or i18n("levelscene_mapselect_ex")
		else
			local var_10_4 = var_10_0.id % 10

			assert(var_10_0.id % 10 == 1 or var_10_4 == 2)

			var_10_2 = i18n("levelscene_mapselect_part" .. var_10_4)
		end

		if var_10_1 == Map.ACT_EXTRA then
			local var_10_5 = var_10_0:getChapters()[1]

			if var_10_5:IsSpChapter() then
				local var_10_7 = arg_10_2:Find("Tip")
				local var_10_8

				if var_10_0.id ~= var_8_0.id then
					var_10_8 = getProxy(ChapterProxy):IsActivitySPChapterActive(pg.expedition_data_by_map[var_10_5:getConfig("map")].on_activity)

					if var_10_8 then
						var_10_8 = SettingsProxy.IsShowActivityMapSPTip()
					end
				else
					var_10_8 = false
				end

				if false then
					var_10_8 = true
				end

				var_10_6(var_10_7, var_10_8)
			end
		end

		setText(arg_10_2:Find("Unselect/Text"), var_10_2)
		setText(arg_10_2:Find("Selected/Text"), var_10_2)

		local var_10_9, var_10_10 = var_10_0:isUnlock()
		local var_10_11

		if var_10_9 then
			var_10_11 = PlayerPrefs.GetInt("MapFirstUnlock" .. var_10_0.id .. "_" .. getProxy(PlayerProxy):getRawData().id, 0) == 0
		end

		setActive(arg_10_2:Find("Unselect/Lock"), not var_10_9 or var_10_11)
		onButton(arg_8_0, arg_10_2, function()
			if var_10_0.id == var_8_0.id then
				return
			end

			if var_10_9 then
				arg_8_0:emit(LevelUIConst.SET_MAP, var_10_0.id)
			else
				pg.TipsMgr.GetInstance():ShowTips(var_10_10)
			end

			return
		end, SFX_PANEL)

		return
	end)

	local var_8_4 = arg_8_0.sceneParent.actExtraRank
	local var_8_5 = var_8_0:getConfig("type") == Map.ACT_EXTRA and _.any(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_EXTRA_CHAPTER_RANK), function(arg_12_0)
		if not arg_12_0 or arg_12_0:isEnd() then
			return
		end

		local var_12_0 = arg_12_0:getConfig("config_data")[1]

		return _.any(var_8_0:getChapters(), function(arg_13_0)
			if not arg_13_0:IsEXChapter() then
				return false
			end

			return table.contains(arg_13_0:getConfig("boss_expedition_id"), var_12_0)
		end)
	end) or false

	if false then
		var_8_5 = true
	end

	var_8_3(var_8_4, var_8_5)
	setActive(arg_8_0.sceneParent.actExchangeShopBtn, not ActivityConst.HIDE_PT_PANELS and not var_8_1 and arg_8_0.sceneParent:IsActShopActive())

	local var_8_7 = arg_8_0.sceneParent.ptTotal
	local var_8_8 = not ActivityConst.HIDE_PT_PANELS and not var_8_1 and arg_8_0.sceneParent.ptActivity and not arg_8_0.sceneParent.ptActivity:isEnd() or false

	if false then
		var_8_8 = true
	end

	var_8_6(var_8_7, var_8_8)
	arg_8_0.sceneParent:updateActivityRes()
	arg_8_0.sceneParent:updateCountDown()

	return
end

function var_0_0.PlayEnterAnim(arg_14_0)
	local var_14_0 = arg_14_0.contextData.map:isRemaster() and getProxy(ChapterProxy):getRemasterMaps(arg_14_0.contextData.map.remasterId) or getProxy(ChapterProxy):getMapsByActivities(arg_14_0.contextData.map:getConfig("on_activity"))

	UIItemList.StaticAlign(arg_14_0.mapSwitchList, arg_14_0.mapSwitchList:GetChild(0), #_.select(var_14_0, function(arg_15_0)
		return arg_15_0:getMapType() ~= Map.ACTIVITY_HARD
	end), function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_16_0 = var_0[arg_16_1 + 1]
		local var_16_1, var_16_2 = var_0[arg_16_1 + 1]:isUnlock()
		local var_16_3 = getProxy(PlayerProxy):getRawData().id
		local var_16_4

		if var_16_1 then
			var_16_4 = PlayerPrefs.GetInt("MapFirstUnlock" .. var_16_0.id .. "_" .. var_16_3, 0) == 0
		end

		setActive(arg_16_2:Find("Unselect/Lock"), not var_16_1 or var_16_4)

		if var_16_4 then
			quickPlayAnimation(arg_16_2:Find("Unselect"), "anim_spfullui_unlock")
			PlayerPrefs.SetInt("MapFirstUnlock" .. var_16_0.id .. "_" .. var_16_3, 1)
		end

		return
	end)

	return
end

return var_0_0
