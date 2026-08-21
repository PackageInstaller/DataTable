local var_0_0 = class("MapBuilderAtelierYumia", import(".MapBuilderSPSeriesFull"))

function var_0_0.GetType(arg_1_0)
	return MapBuilder.TYPEATELIERYUMIA
end

function var_0_0.getUIName(arg_2_0)
	return "LevelSelectAtelierYumia"
end

function var_0_0.SetDisplayMode(arg_3_0, arg_3_1)
	var_0_0.super.SetDisplayMode(arg_3_0, arg_3_1)

	if arg_3_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE then
		quickPlayAnimation(arg_3_0._tf, "Anim_LevelSelectAtelierYumia_Battle_In")
	else
		quickPlayAnimation(arg_3_0._tf, "Anim_LevelSelectAtelierYumia_In")
	end

	return
end

function var_0_0.PlayerLevelTplAnimation(arg_4_0, arg_4_1, arg_4_2)
	quickPlayAnimation(arg_4_1, switch(arg_4_2.status, {
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

function var_0_0.UpdateStory(arg_8_0)
	local var_8_1 = pg.NewStoryMgr.GetInstance()
	local var_8_2 = 0
	local var_8_3 = 0

	for iter_8_0, iter_8_1 in pairs(arg_8_0.storyNodesDict) do
		local var_8_4 = arg_8_0.storyHolder:Find(tostring(iter_8_1.id))
		local var_8_5 = iter_8_1:IsActive(arg_8_0.activity, arg_8_0.sceneParent.ptActivity)
		local var_8_6 = iter_8_1:IsReaded()

		if not _G.isActive(var_8_4) and var_8_5 then
			setActive(var_8_4, var_8_5)
			quickPlayAnimation(var_8_4, switch(iter_8_1:GetType(), {
				[BossRushStoryNode.NODE_TYPE.NORMAL] = function()
					return "Anim_LevelSelectAtelierYumia_storytpl_In"
				end,
				[BossRushStoryNode.NODE_TYPE.BATTLE] = function()
					return "Anim_LevelSelectAtelierYumia_bettletpl_In"
				end,
				[BossRushStoryNode.NODE_TYPE.LOCATION] = function()
					return "Anim_LevelSelectAtelierYumia_Item_Lock_In"
				end
			}, function()
				assert(false)

				return
			end))
		else
			setActive(var_8_4, var_8_5)
		end

		if iter_8_1:GetType() ~= BossRushStoryNode.NODE_TYPE.LOCATION then
			var_8_2 = var_8_2 + (var_8_6 and 1 or 0)
			var_8_3 = var_8_3 + 1
		end

		if var_8_5 then
			local var_8_8 = iter_8_1:GetParams("item_lock")
			local var_8_9 = var_8_8 and Drop.Create(var_8_8[2]) or nil
			local var_8_10 = var_8_9 and var_8_9.count > var_8_9:getOwnedCount() and "item_lock" or switch(iter_8_1:GetType(), {
				[BossRushStoryNode.NODE_TYPE.NORMAL] = function()
					return "story"
				end,
				[BossRushStoryNode.NODE_TYPE.BATTLE] = function()
					return "battle"
				end,
				[BossRushStoryNode.NODE_TYPE.LOCATION] = function()
					return "location"
				end
			})

			eachChild(var_8_4, function(arg_16_0, arg_16_1)
				setActive(arg_16_0, arg_16_0.name == var_8_10)

				return
			end)
			switch(var_8_10, {
				story = function(arg_17_0)
					setText(arg_17_0:Find("name/Text"), iter_8_1:GetName())
					onButton(arg_8_0, arg_17_0, function()
						if var_8_6 then
							return
						end

						arg_8_0:PlayStory(iter_8_1:GetStory(), function()
							arg_8_0:UpdateView()

							return
						end)

						return
					end)

					return
				end,
				battle = function(arg_20_0)
					setText(arg_20_0:Find("name/Text"), iter_8_1:GetName())
					onButton(arg_8_0, arg_20_0, function()
						if var_8_6 then
							return
						end

						arg_8_0:PlayStory(iter_8_1:GetStory(), function()
							arg_8_0:UpdateView()

							return
						end)

						return
					end)

					return
				end,
				location = function(arg_23_0)
					setText(arg_23_0:Find("name/Text"), iter_8_1:GetName())
					GetImageSpriteFromAtlasAsync("ui/levelselectatelieryumia_atlas", "yumia_story_" .. iter_8_0, arg_23_0:Find("name/Image"), false)

					return
				end,
				item_lock = function(arg_24_0)
					setText(arg_24_0:Find("name/Text"), i18n("yumia_storymode_tip1", var_8_9:getName()))
					updateDrop(arg_24_0:Find("IconTpl"), var_8_9)
					setText(arg_24_0:Find("IconTpl/count"), string.format("<color=#23ffedff>%d</color>/%d", var_8_9:getOwnedCount(), var_8_9.count))
					onButton(arg_8_0, arg_24_0, function()
						pg.TipsMgr.GetInstance():ShowTips(i18n("yumia_storymode_tip2"))

						return
					end, SFX_UI_CLICK)

					return
				end
			}, function()
				warning("error state without any display:", var_8_10)

				return
			end, var_8_4:Find(var_8_10))
		end
	end

	setText(arg_8_0.progressText, var_8_2 .. "/" .. var_8_3)
	setActive(arg_8_0.storyAward, tobool(arg_8_0.storyTask))

	if arg_8_0.storyTask then
		updateDrop(arg_8_0.storyAward:GetChild(0), (Drop.Create(arg_8_0.storyTask:getConfig("award_display")[1])))

		local var_8_11 = arg_8_0.storyTask:getTaskStatus()

		setActive(arg_8_0.storyAward:Find("get"), var_8_11 == 1)
		setActive(arg_8_0.storyAward:Find("got"), var_8_11 == 2)
		onButton(arg_8_0, arg_8_0.storyAward, function()
			arg_8_0:emit(BaseUI.ON_DROP, var_0)

			return
		end)
	end

	return
end

function var_0_0.UpdateButtons(arg_28_0)
	var_0_0.super.UpdateButtons(arg_28_0)
	setActive(arg_28_0.sceneParent.actAtelierYumiaBuffBtn, arg_28_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE and arg_28_0.contextData.map.configId == 1940002)

	return
end

return var_0_0
