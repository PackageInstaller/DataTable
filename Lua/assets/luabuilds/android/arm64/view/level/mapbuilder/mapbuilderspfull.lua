local var_0_0 = class("MapBuilderSPFull", import(".MapBuilderSP"))

function var_0_0.GetType(arg_1_0)
	return MapBuilder.TYPESPFULL
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

	local var_4_0 = arg_4_0:getMaps()
	local var_4_1 = {}

	if arg_4_0.contextData.map:isRemaster() then
		var_4_1 = pg.re_map_template[arg_4_0.contextData.map:getRemaster()].drop_gain
	end

	setActive(arg_4_0.sceneParent.eventContainer, #var_4_1 <= 0 and #var_4_0 <= 1)

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
	local var_8_0 = arg_8_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE
	local var_8_1, var_8_2 = arg_8_0.contextData.map:isActivity()
	local var_8_3 = arg_8_0.contextData.map
	local var_8_4 = arg_8_0:getMaps()
	local var_8_5, var_8_6

	if #var_8_4 > 1 then
		UIItemList.StaticAlign(arg_8_0.mapSwitchList, arg_8_0.mapSwitchList:GetChild(0), #var_8_4, function(arg_9_0, arg_9_1, arg_9_2)
			if arg_9_0 ~= UIItemList.EventUpdate then
				return
			end

			local var_9_0 = var_8_4[arg_9_1 + 1]
			local var_9_1 = var_8_4[arg_9_1 + 1]:getMapType()

			setActive(arg_9_2:Find("Unselect"), var_8_4[arg_9_1 + 1].id ~= var_8_3.id)
			setActive(arg_9_2:Find("Selected"), var_9_0.id == var_8_3.id)

			local var_9_2
			local var_9_3 = var_9_0:getConfig("map_name")

			if #(var_9_3 or "") > 0 then
				var_9_2 = i18n(var_9_3)
			elseif var_9_1 == Map.ACT_EXTRA then
				var_9_2 = var_9_0:getChapters()[1]:IsSpChapter() and i18n("levelscene_mapselect_sp") or i18n("levelscene_mapselect_ex")
			else
				local var_9_4 = var_9_0.id % 10

				assert(var_9_0.id % 10 == 1 or var_9_4 == 2)

				var_9_2 = i18n("levelscene_mapselect_part" .. var_9_4)
			end

			if var_9_1 == Map.ACT_EXTRA then
				local var_9_5 = var_9_0:getChapters()[1]

				if var_9_5:IsSpChapter() then
					local var_9_7 = arg_9_2:Find("Tip")
					local var_9_8

					if var_9_0.id ~= var_8_3.id then
						var_9_8 = getProxy(ChapterProxy):IsActivitySPChapterActive(pg.expedition_data_by_map[var_9_5:getConfig("map")].on_activity)

						if var_9_8 then
							var_9_8 = SettingsProxy.IsShowActivityMapSPTip()
						end
					else
						var_9_8 = false
					end

					if false then
						var_9_8 = true
					end

					var_9_6(var_9_7, var_9_8)
				end
			end

			setText(arg_9_2:Find("Unselect/Text"), var_9_2)
			setText(arg_9_2:Find("Selected/Text"), var_9_2)

			local var_9_9, var_9_10 = var_9_0:isUnlock()
			local var_9_11

			if var_9_9 then
				var_9_11 = PlayerPrefs.GetInt("MapFirstUnlock" .. var_9_0.id .. "_" .. getProxy(PlayerProxy):getRawData().id, 0) == 0
			end

			setActive(arg_9_2:Find("Unselect/Lock"), not var_9_9 or var_9_11)
			onButton(arg_8_0, arg_9_2, function()
				if var_9_0.id == var_8_3.id then
					return
				end

				if var_9_9 then
					arg_8_0:emit(LevelUIConst.SET_MAP, var_9_0.id)
				else
					pg.TipsMgr.GetInstance():ShowTips(var_9_10)
				end

				return
			end, SFX_PANEL)

			return
		end)
	else
		setActive(arg_8_0._tf:Find("Battle/MapItems"), false)

		var_8_5 = setActive
		var_8_6 = arg_8_0.sceneParent.actExtraRank
	end

	local var_8_7 = var_8_3:getConfig("type") == Map.ACT_EXTRA and _.any(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_EXTRA_CHAPTER_RANK), function(arg_11_0)
		if not arg_11_0 or arg_11_0:isEnd() then
			return
		end

		local var_11_0 = arg_11_0:getConfig("config_data")[1]

		return _.any(var_8_3:getChapters(), function(arg_12_0)
			if not arg_12_0:IsEXChapter() then
				return false
			end

			return table.contains(arg_12_0:getConfig("boss_expedition_id"), var_11_0)
		end)
	end) or false

	if false then
		var_8_7 = true
	end

	var_8_5(var_8_6, var_8_7)
	setActive(arg_8_0.sceneParent.actExchangeShopBtn, not ActivityConst.HIDE_PT_PANELS and not inRemasterMap and arg_8_0.sceneParent:IsActShopActive())

	if arg_8_0.contextData.map then
		local var_8_8 = getProxy(ActivityProxy):getActivityById(arg_8_0.contextData.map:getConfig("on_activity")) or nil
		local var_8_9 = var_8_8 and not var_8_8:isEnd() and var_8_8:GetConfigClientSetting("PTID")

		arg_8_0.sceneParent:updatePtActivity(underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_RANK), function(arg_13_0)
			return arg_13_0:getConfig("config_id") == var_8_9
		end))

		local var_8_11 = arg_8_0.sceneParent.ptTotal

		if not ActivityConst.HIDE_PT_PANELS and not inRemasterMap then
			local var_8_12

			if var_8_2 then
				::label_8_0::

				var_8_12 = arg_8_0.sceneParent.ptActivity

				if arg_8_0.sceneParent.ptActivity then
					if not arg_8_0.sceneParent.ptActivity:isEnd() then
						var_8_12 = var_8_0

						goto label_8_1
					end

					var_8_12 = false and true
				end
			end

			::label_8_1::

			var_8_10(var_8_11, var_8_12)
			arg_8_0.sceneParent:updateCountDown()

			return
		end
	end
end

function var_0_0.PlayEnterAnim(arg_14_0)
	local var_14_1 = arg_14_0:getMaps()

	if #var_14_1 > 1 then
		UIItemList.StaticAlign(arg_14_0.mapSwitchList, arg_14_0.mapSwitchList:GetChild(0), #var_14_1, function(arg_15_0, arg_15_1, arg_15_2)
			if arg_15_0 ~= UIItemList.EventUpdate then
				return
			end

			local var_15_0 = var_14_1[arg_15_1 + 1]
			local var_15_1, var_15_2 = var_14_1[arg_15_1 + 1]:isUnlock()
			local var_15_3 = getProxy(PlayerProxy):getRawData().id
			local var_15_4

			if var_15_1 then
				var_15_4 = PlayerPrefs.GetInt("MapFirstUnlock" .. var_15_0.id .. "_" .. var_15_3, 0) == 0
			end

			setActive(arg_15_2:Find("Unselect/Lock"), not var_15_1 or var_15_4)

			if var_15_4 then
				quickPlayAnimation(arg_15_2:Find("Unselect"), "anim_spfullui_unlock")
				PlayerPrefs.SetInt("MapFirstUnlock" .. var_15_0.id .. "_" .. var_15_3, 1)
			end

			return
		end)
	else
		setActive(arg_14_0._tf:Find("Battle/MapItems"), false)
	end

	return
end

function var_0_0.getMaps(arg_16_0)
	local var_16_0 = arg_16_0.contextData.map:isRemaster() and getProxy(ChapterProxy):getRemasterMaps(arg_16_0.contextData.map.remasterId) or getProxy(ChapterProxy):getMapsByActivities(arg_16_0.contextData.map:getConfig("on_activity"))

	return (_.select(var_16_0, function(arg_17_0)
		return arg_17_0:getMapType() ~= Map.ACTIVITY_HARD
	end))
end

return var_0_0
