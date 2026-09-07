local MapBuilderSPSeriesRecrew = class("MapBuilderSPSeriesRecrew", import(".MapBuilderSPSeriesFull"))

function MapBuilderSPSeriesRecrew:GetType()
	return MapBuilder.TYPESPSERIESRECREW
end

function MapBuilderSPSeriesRecrew:getUIName()
	return "LevelSelectSPSeriesRecrewUI"
end

function MapBuilderSPSeriesRecrew:UpdateStory()
	local var_3_1 = pg.NewStoryMgr.GetInstance()
	local var_3_2 = 0
	local var_3_3 = 0

	for iter_3_0, iter_3_1 in pairs(self.storyNodesDict) do
		local var_3_4 = self.storyHolder:Find(tostring(iter_3_1.id))

		setActive(var_3_4, (iter_3_1:IsActive(self.activity, self.sceneParent.ptActivity)))
		setText(var_3_4:Find("main/char/bg/Text"), iter_3_1:GetName())
		setText(var_3_4:Find("main/talk/bg/Text"), iter_3_1:GetName())

		local var_3_5 = iter_3_1:IsReaded()

		setActive(var_3_4:Find("main/char"), not var_3_5)
		setActive(var_3_4:Find("main/talk"), var_3_5)

		local var_3_6 = iter_3_1:IsRecrew()

		if var_3_6 == nil then
			setActive(var_3_4:Find("main/recrew"), false)
		else
			setActive(var_3_4:Find("main/recrew"), true)
			setActive(var_3_4:Find("main/recrew/recrewed"), var_3_6)
			setActive(var_3_4:Find("main/recrew/not_recrew"), not var_3_6)
			setText(var_3_4:Find("main/recrew/recrewed/label"), i18n("story_recrewed"))
			setText(var_3_4:Find("main/recrew/not_recrew/label"), i18n("story_not_recrew"))
		end

		onButton(self, var_3_4, function()
			local var_4_0 = iter_3_1:GetParams(BossRushStoryNode.REPEATABLE_KEY)
			local var_4_1 = var_4_0 and var_4_0[2]

			if var_3_5 and not var_4_1 then
				return
			end

			self:PlayStory(iter_3_1:GetStory(), function()
				local var_5_0 = self.activity:getConfig("config_client").storys

				if var_5_0[#var_5_0] == iter_3_1.id and not var_3_5 then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_HELP,
						helps = i18n("multiple_endings_tip")
					})
				end

				self:UpdateView()

				return
			end, var_4_1)

			return
		end)

		var_3_2 = var_3_2 + (var_3_5 and 1 or 0)
		var_3_3 = var_3_3 + 1
	end

	setText(self.progressText, var_3_2 .. "/" .. var_3_3)
	setActive(self.storyAward, tobool(self.storyTask))

	if self.storyTask then
		local var_3_7 = Drop.Create(self.storyTask:getConfig("award_display")[1])

		updateDrop(self.storyAward:GetChild(0), var_3_7)

		local var_3_8 = self.storyTask:getTaskStatus()

		setActive(self.storyAward:Find("get"), var_3_8 == 1)
		setActive(self.storyAward:Find("got"), var_3_8 == 2)
		onButton(self, self.storyAward, function()
			self:emit(BaseUI.ON_DROP, var_3_7)

			return
		end)
	end

	return
end

function MapBuilderSPSeriesRecrew:SwitchStoryMapAndBGM()
	local var_7_0 = self.data:getConfig("default_background")
	local var_7_1 = self.data:getConfig("default_bgm")
	local var_7_2 = self.data:getConfig("ani_name")
	local var_7_3 = underscore.keys(self.storyNodesDict)

	table.sort(var_7_3)

	for iter_7_0 = 1, #var_7_3 do
		if self.storyNodesDict[var_7_3[iter_7_0]]:IsReaded() then
			var_7_0 = defaultValue(self.storyNodesDict[var_7_3[iter_7_0]]:GetCleanBG(), var_7_0)
			var_7_1 = defaultValue(self.storyNodesDict[var_7_3[iter_7_0]]:GetCleanBGM(), var_7_1)
			var_7_2 = defaultValue(self.storyNodesDict[var_7_3[iter_7_0]]:GetCleanAnimator(), var_7_2)
		else
			break
		end
	end

	self.sceneParent:SwitchBG({
		{
			bgPrefix = "bg",
			BG = var_7_0,
			Animator = var_7_2
		}
	})
	pg.BgmMgr.GetInstance():Push(self.__cname, var_7_1)

	return
end

return MapBuilderSPSeriesRecrew
