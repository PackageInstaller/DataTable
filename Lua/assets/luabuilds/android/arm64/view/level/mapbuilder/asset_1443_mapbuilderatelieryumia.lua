local MapBuilderAtelierYumia = class("MapBuilderAtelierYumia", import(".MapBuilderSPSeriesFull"))

function MapBuilderAtelierYumia:GetType()
	return MapBuilder.TYPEATELIERYUMIA
end

function MapBuilderAtelierYumia:getUIName()
	return "LevelSelectAtelierYumia"
end

function MapBuilderAtelierYumia:SetDisplayMode(arg_3_1)
	MapBuilderAtelierYumia.super.SetDisplayMode(self, arg_3_1)

	if self.contextData.displayMode == MapBuilderAtelierYumia.DISPLAY.BATTLE then
		quickPlayAnimation(self._tf, "Anim_LevelSelectAtelierYumia_Battle_In")
	else
		quickPlayAnimation(self._tf, "Anim_LevelSelectAtelierYumia_In")
	end

	return
end

function MapBuilderAtelierYumia:PlayerLevelTplAnimation(arg_4_1, arg_4_2)
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

function MapBuilderAtelierYumia:UpdateStory()
	local var_8_1 = pg.NewStoryMgr.GetInstance()
	local var_8_2 = 0
	local var_8_3 = 0

	for iter_8_0, iter_8_1 in pairs(self.storyNodesDict) do
		local var_8_4 = self.storyHolder:Find(tostring(iter_8_1.id))
		local var_8_5 = iter_8_1:IsActive(self.activity, self.sceneParent.ptActivity)
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
				story = function(self)
					setText(self:Find("name/Text"), iter_8_1:GetName())
					onButton(self, self, function()
						if var_8_6 then
							return
						end

						self:PlayStory(iter_8_1:GetStory(), function()
							self:UpdateView()

							return
						end)

						return
					end)

					return
				end,
				battle = function(self)
					setText(self:Find("name/Text"), iter_8_1:GetName())
					onButton(self, self, function()
						if var_8_6 then
							return
						end

						self:PlayStory(iter_8_1:GetStory(), function()
							self:UpdateView()

							return
						end)

						return
					end)

					return
				end,
				location = function(self)
					setText(self:Find("name/Text"), iter_8_1:GetName())
					GetImageSpriteFromAtlasAsync("ui/levelselectatelieryumia_atlas", "yumia_story_" .. iter_8_0, self:Find("name/Image"), false)

					return
				end,
				item_lock = function(self)
					setText(self:Find("name/Text"), i18n("yumia_storymode_tip1", var_8_9:getName()))
					updateDrop(self:Find("IconTpl"), var_8_9)
					setText(self:Find("IconTpl/count"), string.format("<color=#23ffedff>%d</color>/%d", var_8_9:getOwnedCount(), var_8_9.count))
					onButton(self, self, function()
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

	setText(self.progressText, var_8_2 .. "/" .. var_8_3)
	setActive(self.storyAward, tobool(self.storyTask))

	if self.storyTask then
		local var_8_11 = Drop.Create(self.storyTask:getConfig("award_display")[1])

		updateDrop(self.storyAward:GetChild(0), var_8_11)

		local var_8_12 = self.storyTask:getTaskStatus()

		setActive(self.storyAward:Find("get"), var_8_12 == 1)
		setActive(self.storyAward:Find("got"), var_8_12 == 2)
		onButton(self, self.storyAward, function()
			self:emit(BaseUI.ON_DROP, var_8_11)

			return
		end)
	end

	return
end

function MapBuilderAtelierYumia:UpdateButtons()
	MapBuilderAtelierYumia.super.UpdateButtons(self)
	setActive(self.sceneParent.actAtelierYumiaBuffBtn, self.contextData.displayMode == MapBuilderAtelierYumia.DISPLAY.BATTLE and self.contextData.map.configId == 1940002)

	return
end

return MapBuilderAtelierYumia
