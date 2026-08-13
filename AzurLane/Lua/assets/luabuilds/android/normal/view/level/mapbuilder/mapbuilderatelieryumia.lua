class = var_0_10000

local var_0_0 = "MapBuilderAtelierYumia"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MapBuilderSPSeriesFull"))

function var_0_1.GetType(arg_1_0)
	MapBuilder = var_1_10001

	return var_1_10001.TYPEATELIERYUMIA
end

function var_0_1.getUIName(arg_2_0)
	return "LevelSelectAtelierYumia"
end

function var_0_1.SetDisplayMode(arg_3_0, arg_3_1)
	var_0_1.super.SetDisplayMode(arg_3_0, arg_3_1)

	if arg_3_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE then
		quickPlayAnimation = var_3

		var_3(arg_3_0._tf, "Anim_LevelSelectAtelierYumia_Battle_In")
	else
		quickPlayAnimation = var_3

		var_3(arg_3_0._tf, "Anim_LevelSelectAtelierYumia_In")
	end

	return
end

function var_0_1.PlayerLevelTplAnimation(arg_4_0, arg_4_1, arg_4_2)
	quickPlayAnimation = var_1_10003

	local var_4_0 = arg_4_1

	switch = var_1_10005

	var_1_10003(var_4_0, var_1_10005(arg_4_2.status, {
		Lock = function()
			return "Anim_LevelSelectAtelierYumia_LevelTplLock_In"
		end,
		Normal = function()
			return "Anim_LevelSelectAtelierYumia_LevelTpNormal_In"
		end,
		Hard = function()
			return "Anim_LevelSelectAtelierYumia_LevelTpHard_In"
		end
	}))

	return
end

function var_0_1.UpdateStory(arg_8_0)
	local var_8_0 = {}

	pg = var_1_10002

	local var_8_1 = var_1_10002.NewStoryMgr.GetInstance()
	local var_8_2 = 0
	local var_8_3 = 0

	pairs = var_1_10005

	for iter_8_0, iter_8_1 in var_1_10005(arg_8_0.storyNodesDict) do
		local var_8_4 = arg_8_0.storyHolder
		local var_8_5 = var_10.Find

		tostring = var_1_10012

		local var_8_6 = var_8_5(var_8_4, var_1_10012(iter_8_1.id))

		var_1_10012 = iter_8_1

		local var_8_7 = iter_8_1.IsActive(var_1_10012, arg_8_0.activity, arg_8_0.sceneParent.ptActivity)
		local var_8_8 = iter_8_1

		var_1_10012 = iter_8_1.IsReaded(var_8_8)
		_G = var_8_8

		if not var_8_8.isActive(var_8_6) and var_8_7 then
			setActive = var_13

			var_13(var_8_6, var_8_7)

			quickPlayAnimation = var_13

			local var_8_9 = var_8_6

			switch = var_15

			local var_8_10 = iter_8_1:GetType()
			local var_8_11 = {}

			BossRushStoryNode = var_1_10018
			var_8_11[var_1_10018.NODE_TYPE.NORMAL] = function()
				return "Anim_LevelSelectAtelierYumia_storytpl_In"
			end
			BossRushStoryNode = var_1_10018
			var_8_11[var_1_10018.NODE_TYPE.BATTLE] = function()
				return "Anim_LevelSelectAtelierYumia_bettletpl_In"
			end
			BossRushStoryNode = var_1_10018
			var_8_11[var_1_10018.NODE_TYPE.LOCATION] = function()
				return "Anim_LevelSelectAtelierYumia_Item_Lock_In"
			end

			var_13(var_8_9, var_15(var_8_10, var_8_11, function()
				assert = var_2_10000

				var_2_10000(false)

				return
			end))
		else
			setActive = var_13

			var_13(var_8_6, var_8_7)
		end

		local var_8_12 = iter_8_1
		local var_8_13 = iter_8_1.GetType(var_8_12)

		BossRushStoryNode = var_8_12

		if var_8_13 ~= var_8_12.NODE_TYPE.LOCATION then
			var_8_2 = var_8_2 + (var_1_10012 and 1 or 0)
			var_8_3 = var_8_3 + 1
		end

		if var_8_7 then
			local var_8_14
			local var_8_15 = iter_8_1

			if iter_8_1.GetParams(var_8_15, "item_lock") then
				Drop = var_8_15

				local var_8_16

				if not var_8_15.Create(var_14[2]) then
					var_8_16 = nil
				end

				local var_8_17

				if var_8_16 then
					var_8_17 = var_8_16.count
					var_1_10018 = var_8_16

					if var_8_17 > var_8_16.getOwnedCount(var_1_10018) then
						var_8_14 = "item_lock"

						goto label_8_0
					end
				end

				switch = var_8_17
				var_1_10018 = iter_8_1

				do
					local var_8_18 = iter_8_1.GetType(var_1_10018)

					var_1_10018 = {}
					BossRushStoryNode = var_1_10019
					var_1_10018[var_1_10019.NODE_TYPE.NORMAL] = function()
						return "story"
					end
					BossRushStoryNode = var_1_10019
					var_1_10018[var_1_10019.NODE_TYPE.BATTLE] = function()
						return "battle"
					end
					BossRushStoryNode = var_1_10019
					var_1_10018[var_1_10019.NODE_TYPE.LOCATION] = function()
						return "location"
					end
					var_8_14 = var_8_17(var_8_18, var_1_10018)
				end

				::label_8_0::

				eachChild = var_8_17

				var_8_17(var_8_6, function(arg_16_0, arg_16_1)
					setActive = var_2_10002

					var_2_10002(arg_16_0, arg_16_0.name == var_8_14)

					return
				end)

				switch = var_8_17

				var_8_17(var_8_14, {
					story = function(arg_17_0)
						setText = var_2_10001

						local var_17_0 = arg_17_0:Find("name/Text")
						local var_17_1 = iter_8_1

						var_2_10001(var_17_0, var_3.GetName(var_17_1))

						onButton = var_2_10001

						var_2_10001(arg_8_0, arg_17_0, function()
							if var_1_10012 then
								return
							end

							local var_18_0 = iter_8_1
							local var_18_1 = var_0.GetStory(var_18_0)
							local var_18_2 = arg_8_0

							var_1.PlayStory(var_18_2, var_18_1, function()
								local var_19_0 = arg_8_0

								var_0.UpdateView(var_19_0)

								return
							end)

							return
						end)

						return
					end,
					battle = function(arg_20_0)
						setText = var_2_10001

						local var_20_0 = arg_20_0:Find("name/Text")
						local var_20_1 = iter_8_1

						var_2_10001(var_20_0, var_3.GetName(var_20_1))

						onButton = var_2_10001

						var_2_10001(arg_8_0, arg_20_0, function()
							if var_1_10012 then
								return
							end

							local var_21_0 = iter_8_1
							local var_21_1 = var_0.GetStory(var_21_0)
							local var_21_2 = arg_8_0

							var_1.PlayStory(var_21_2, var_21_1, function()
								local var_22_0 = arg_8_0

								var_0.UpdateView(var_22_0)

								return
							end)

							return
						end)

						return
					end,
					location = function(arg_23_0)
						setText = var_2_10001

						local var_23_0 = arg_23_0:Find("name/Text")
						local var_23_1 = iter_8_1

						var_2_10001(var_23_0, var_3.GetName(var_23_1))

						GetImageSpriteFromAtlasAsync = var_2_10001

						var_2_10001("ui/levelselectatelieryumia_atlas", "yumia_story_" .. iter_8_0, arg_23_0:Find("name/Image"), false)

						return
					end,
					item_lock = function(arg_24_0)
						setText = var_2_10001

						local var_24_0 = arg_24_0
						local var_24_1 = arg_24_0.Find(var_24_0, "name/Text")

						i18n = var_24_0

						local var_24_2 = "yumia_storymode_tip1"
						local var_24_3 = var_8_16

						var_2_10001(var_24_1, var_24_0(var_24_2, var_5.getName(var_24_3)))

						updateDrop = var_2_10001

						var_2_10001(arg_24_0:Find("IconTpl"), var_8_16)

						setText = var_2_10001

						local var_24_4 = arg_24_0
						local var_24_5 = arg_24_0.Find(var_24_4, "IconTpl/count")

						string = var_24_4

						local var_24_6 = var_24_4.format
						local var_24_7 = "<color=#23ffedff>%d</color>/%d"
						local var_24_8 = var_8_16

						var_2_10001(var_24_5, var_24_6(var_24_7, var_5.getOwnedCount(var_24_8), var_8_16.count))

						onButton = var_2_10001

						local var_24_9 = arg_8_0
						local var_24_10 = arg_24_0

						local function var_24_11()
							pg = var_3_10000

							local var_25_0 = var_3_10000.TipsMgr.GetInstance()
							local var_25_1 = var_0.ShowTips

							i18n = var_3_10002

							var_25_1(var_25_0, var_3_10002("yumia_storymode_tip2"))

							return
						end

						SFX_UI_CLICK = var_5

						var_2_10001(var_24_9, var_24_10, var_24_11, var_5)

						return
					end
				}, function()
					warning = var_2_10000

					var_2_10000("error state without any display:", var_8_14)

					return
				end, var_8_6:Find(var_8_14))
			end
		end
	end

	setText = var_5

	var_5(arg_8_0.progressText, var_8_2 .. "/" .. var_8_3)

	setActive = var_5

	local var_8_19 = arg_8_0.storyAward

	tobool = var_7

	var_5(var_8_19, var_7(arg_8_0.storyTask))

	if arg_8_0.storyTask then
		local var_8_20 = arg_8_0.storyTask
		local var_8_21 = var_5.getConfig(var_8_20, "award_display")

		Drop = var_8_20

		local var_8_22 = var_8_20.Create(var_8_21[1])

		updateDrop = var_7

		local var_8_23 = arg_8_0.storyAward

		var_7(var_8.GetChild(var_8_23, 0), var_8_22)

		local var_8_24 = arg_8_0.storyTask
		local var_8_25 = var_7.getTaskStatus(var_8_24)

		setActive = var_8_24

		local var_8_26 = arg_8_0.storyAward

		var_8_24(var_9.Find(var_8_26, "get"), var_8_25 == 1)

		setActive = var_8_24

		local var_8_27 = arg_8_0.storyAward

		var_8_24(var_9.Find(var_8_27, "got"), var_8_25 == 2)

		onButton = var_8_24

		var_8_24(arg_8_0, arg_8_0.storyAward, function()
			local var_27_0 = arg_8_0
			local var_27_1 = var_0.emit

			BaseUI = var_2_10002

			var_27_1(var_27_0, var_2_10002.ON_DROP, var_8_22)

			return
		end)
	end

	return
end

function var_0_1.UpdateButtons(arg_28_0)
	var_0_1.super.UpdateButtons(arg_28_0)

	local var_28_0 = arg_28_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE

	setActive = var_2

	var_2(arg_28_0.sceneParent.actAtelierYumiaBuffBtn, var_28_0 and arg_28_0.contextData.map.configId == 1940002)

	return
end

return var_0_1
