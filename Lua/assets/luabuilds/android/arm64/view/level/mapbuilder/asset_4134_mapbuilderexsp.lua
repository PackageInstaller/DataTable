local MapBuilderEXSP = class("MapBuilderEXSP", import(".MapBuilderSPSeriesFull"))

function MapBuilderEXSP:GetType()
	return MapBuilder.TYPEATELIERYUMIA
end

function MapBuilderEXSP:getUIName()
	return "LevelSelectEXSPUI"
end

function MapBuilderEXSP:OnInit()
	MapBuilderEXSP.super.OnInit(self)

	self.personalBtn = self._tf:Find("Story/PersonalCard")
	self.personalPage = SecretsAbyssPersonalPage.New(self._tf, self, {})

	onButton(self, self.personalBtn, function()
		self.personalPage:ExecuteAction("Show")

		return
	end)

	return
end

function MapBuilderEXSP:UpdateMapVO(arg_5_1)
	MapBuilderEXSP.super.UpdateMapVO(self, arg_5_1)

	if self.activity:getConfig("config_client").roll_task then
		self.personalPage:RegisterRandomCallback(function()
			self.sceneParent:emit(LevelMediator2.ON_UPDATE_LOWPRIORITY_TASK, self.activity:getConfig("config_client").roll_task)

			return
		end)
	end

	return
end

function MapBuilderEXSP:SetDisplayMode(arg_7_1)
	MapBuilderEXSP.super.SetDisplayMode(self, arg_7_1)

	if self.contextData.displayMode == MapBuilderEXSP.DISPLAY.BATTLE then
		quickPlayAnimation(self._tf, "Anim_LevelSelectAtelierYumia_Battle_In")
	else
		quickPlayAnimation(self._tf, "Anim_LevelSelectAtelierYumia_In")
	end

	return
end

function MapBuilderEXSP:PlayerLevelTplAnimation(arg_8_1, arg_8_2)
	quickPlayAnimation(arg_8_1, switch(arg_8_2.status, {
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

function MapBuilderEXSP:UpdateStory()
	local var_12_1 = pg.NewStoryMgr.GetInstance()
	local var_12_2 = 0
	local var_12_3 = 0
	local var_12_4 = {}

	for iter_12_0, iter_12_1 in pairs(self.storyNodesDict) do
		local var_12_5 = self.storyHolder:Find(tostring(iter_12_1.id))
		local var_12_6 = iter_12_1:IsActive(self.activity, self.ptActivity)
		local var_12_7 = iter_12_1:IsReaded()

		if not _G.isActive(var_12_5) and var_12_6 then
			setActive(var_12_5, var_12_6)
			quickPlayAnimation(var_12_5, switch(iter_12_1:GetType(), {
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
			setActive(var_12_5, var_12_6)
		end

		if iter_12_1:GetType() ~= BossRushStoryNode.NODE_TYPE.LOCATION then
			var_12_2 = var_12_2 + (var_12_7 and 1 or 0)
			var_12_3 = var_12_3 + 1

			if var_12_7 then
				table.insert(var_12_4, iter_12_1)
			end
		end

		if var_12_6 then
			local var_12_9 = iter_12_1:GetParams("item_lock")
			local var_12_10 = var_12_9 and Drop.Create(var_12_9[2]) or nil
			local var_12_11 = var_12_10 and var_12_10.count > var_12_10:getOwnedCount() and "item_lock" or switch(iter_12_1:GetType(), {
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

			eachChild(var_12_5, function(arg_20_0, arg_20_1)
				setActive(arg_20_0, arg_20_0.name == var_12_11)

				return
			end)
			switch(var_12_11, {
				story = function(self)
					setText(self:Find("name/Text"), iter_12_1:GetName())
					onButton(self, self, function()
						if var_12_7 then
							return
						end

						self:PlayStory(iter_12_1:GetStory(), function()
							self:UpdateView()
							self:CheckAutoShowPersonal()

							return
						end)

						return
					end)

					return
				end,
				battle = function(self)
					setText(self:Find("name/Text"), iter_12_1:GetName())
					onButton(self, self, function()
						if var_12_7 then
							return
						end

						self:PlayStory(iter_12_1:GetStory(), function()
							self:UpdateView()
							self:CheckAutoShowPersonal()

							return
						end)

						return
					end)

					return
				end,
				location = function(self)
					setText(self:Find("name/Text"), iter_12_1:GetName())

					if PLATFORM_CODE ~= PLATFORM_US then
						setActive(self:Find("en"), true)
						setText(self:Find("en"), iter_12_1:getConfig("en_name"))
					end

					return
				end
			}, function()
				warning("error state without any display:", var_12_11)

				return
			end, var_12_5:Find(var_12_11))
		end
	end

	setText(self.progressText, var_12_2 .. "/" .. var_12_3)
	setActive(self.storyAward, tobool(self.storyTask))

	if self.storyTask then
		local var_12_12 = Drop.Create(self.storyTask:getConfig("award_display")[1])

		updateDrop(self.storyAward:GetChild(0), var_12_12)

		local var_12_13 = self.storyTask:getTaskStatus()

		setActive(self.storyAward:Find("get"), var_12_13 == 1)
		setActive(self.storyAward:Find("got"), var_12_13 == 2)
		onButton(self, self.storyAward, function()
			self:emit(BaseUI.ON_DROP, var_12_12)

			return
		end)
	end

	table.sort(var_12_4, function(arg_30_0, arg_30_1)
		return arg_30_0:getConfig("id") < arg_30_1:getConfig("id")
	end)

	local var_12_14 = var_12_4[#var_12_4]
	local var_12_15
	local var_12_16 = #var_12_4 - 1

	while var_12_16 > 0 do
		if #self.personalPage:GetActivitySingleEventOption(var_12_4[var_12_16]) > 0 then
			var_12_15 = var_12_4[var_12_16]

			break
		end

		var_12_16 = var_12_16 - 1
	end

	if var_12_14 and #self.personalPage:GetActivitySingleEventOption(var_12_14) > 0 or var_12_15 and #self.personalPage:GetActivitySingleEventOption(var_12_15) > 0 then
		setActive(self.personalBtn, true)
	else
		setActive(self.personalBtn, false)
	end

	var_12_15 = var_12_15 and var_12_15 or var_12_14

	self.personalPage:SetBossRushNode(var_12_14, var_12_15)

	if var_12_2 == var_12_3 then
		self.personalPage:UnlockRandom()
	end

	if self.activity:getConfig("config_client").first_story then
		pg.NewStoryMgr.GetInstance():Play(self.activity:getConfig("config_client").first_story)
	end

	return
end

function MapBuilderEXSP:CheckAutoShowPersonal()
	if #self.personalPage:GetActivitySingleEventOption(self.personalPage:GetCurrentEvent()) > 0 then
		self.personalPage:SetUpgrade()
		self.personalPage:ExecuteAction("Show")
		self.personalPage:ExecuteAction("UpdateView")
	end

	return
end

MapBuilderEXSP.presonalRandomData = nil

return MapBuilderEXSP
