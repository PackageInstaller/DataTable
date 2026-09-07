local WorldOverviewLayer = class("WorldOverviewLayer", import("..base.BaseUI"))

function WorldOverviewLayer:getUIName()
	return "WorldOverviewUI"
end

function WorldOverviewLayer:preload(arg_2_1)
	self:LoadAtlasOverall(arg_2_1)

	return
end

function WorldOverviewLayer:init()
	self.rtBg = self._tf:Find("bg")

	onButton(self, self.rtBg, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	setText(self._tf:Find("tip/Text"), i18n("click_back_tip"))

	self.rtTaskPanel = self._tf:Find("panel/middle/info_panel/task_panel")

	setActive(self.rtTaskPanel, false)
	setActive(self.rtTaskPanel:Find("btn_next"), false)

	self.entranceItemList = UIItemList.New(self.rtTaskPanel:Find("entrance_list/target_list"), self.rtTaskPanel:Find("entrance_list/target_tpl"))

	self.entranceItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			if self.entranceIds[arg_5_1] then
				setActive(arg_5_2:Find("Image"), true)
				setText(arg_5_2:Find("Text"), i18n("world_task_view1") .. nowWorld():GetEntrance(self.entranceIds[arg_5_1]):GetBaseMap():GetName())
			else
				setActive(arg_5_2:Find("Image"), true)
				setText(arg_5_2:Find("Text"), i18n("world_task_view1") .. i18n("world_task_view2"))
			end
		end

		return
	end)

	self.areaItemList = UIItemList.New(self.rtTaskPanel:Find("entrance_list/target_list"), self.rtTaskPanel:Find("entrance_list/target_tpl"))

	self.areaItemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_1 = arg_6_1 + 1

		if arg_6_0 == UIItemList.EventUpdate then
			if self.areaIds[arg_6_1] then
				setActive(arg_6_2:Find("Image"), true)
				setText(arg_6_2:Find("Text"), i18n("world_task_view1") .. pg.world_regions_data[self.areaIds[arg_6_1]].name)
			else
				setActive(arg_6_2:Find("Image"), true)
				setText(arg_6_2:Find("Text"), i18n("world_task_view1") .. i18n("world_task_view2"))
			end
		end

		return
	end)

	self.rtAchievementPanel = self._tf:Find("panel/middle/info_panel/achievement_panel")

	setActive(self.rtAchievementPanel, false)

	self.btnAchieve = self.rtAchievementPanel:Find("btn_all")

	onButton(self, self.btnAchieve, function()
		local var_7_0, var_7_1 = nowWorld():GetFinishAchievements()

		if #var_7_0 == 0 then
			pg.TipsMgr.GetInstance():ShowTips("without any award")
		else
			self:emit(WorldOverviewMediator.OnAchieveStar, var_7_0)
			self:closeView()
		end

		return
	end, SFX_CONFIRM)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function WorldOverviewLayer:didEnter()
	self.mode = self.contextData.info.mode

	if self.mode == "Task" then
		self.taskId = self.contextData.info.taskId

		self:UpdateTaskPanel()
	elseif self.mode == "Achievement" then
		self:UpdateAchievementPanel()
	else
		self.entranceIds = self.contextData.info.ids
	end

	self._tf:GetComponent("DftAniEvent"):SetEndEvent(function(arg_9_0)
		local var_9_0 = {}

		_.each(self.entranceIds, function(arg_10_0)
			var_9_0[arg_10_0] = true

			return
		end)

		if #self.entranceIds > 0 then
			self.wsAtlasOverall:UpdateTargetEntrance(self.entranceIds[1])
		end

		self.wsAtlasOverall:UpdateStaticMark(var_9_0, self:GetOverviewMark())
		self:DisplayAtlasOverall()

		if self.mode then
			setActive(self["rt" .. self.mode .. "Panel"], true)

			if self.mode == "Task" then
				eachChild(self.entranceItemList.container, function(arg_11_0)
					local var_11_0 = GetComponent(arg_11_0:Find("Text"), typeof(Typewriter))

					var_11_0:setSpeed(0.03)
					var_11_0:Play()

					return
				end)

				local var_9_1 = GetComponent(self.rtTaskPanel:Find("entrance_list/target_tpl"):Find("Text"), typeof(Typewriter))

				var_9_1:setSpeed(0.03)
				var_9_1:Play()
			end
		end

		return
	end)

	return
end

function WorldOverviewLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	if self.mode then
		setActive(self["rt" .. self.mode .. "Panel"], false)
	end

	self:HideAtlasOverall()
	self:DisposeAtlasOverall()

	return
end

function WorldOverviewLayer:GetOverviewMark()
	if self.mode == "Task" then
		if self.isTaskArea then
			return {
				"overview_port"
			}
		else
			return {
				"overview_task_port",
				"overview_task"
			}
		end
	elseif self.mode == "Achievement" then
		return {
			"overview_achievement",
			"overview_achievement"
		}
	else
		return {
			"overview_task_port",
			"overview_task"
		}
	end

	return
end

function WorldOverviewLayer:UpdateTaskPanel()
	local var_14_0 = nowWorld()
	local var_14_1 = var_14_0:GetTaskProxy():getTaskById(self.taskId)

	assert(var_14_1, "without this doing task: " .. self.taskId)

	local var_14_2 = self.rtTaskPanel:Find("task_info")

	GetImageSpriteFromAtlasAsync("ui/worldtaskfloatui_atlas", pg.WorldToastMgr.Type2PictrueName[var_14_1.config.type], var_14_2:Find("type"), true)
	setText(var_14_2:Find("name/Text"), var_14_1.config.name)

	local var_14_3 = var_14_1:GetFollowingAreaId()

	if var_14_3 then
		self.isTaskArea = true
		self.entranceIds = underscore.rest(var_14_0:GetAreaEntranceIds(var_14_3), 1)
		self.areaIds = {
			var_14_3
		}

		self.areaItemList:align(math.max(#self.areaIds, 1))
	else
		self.isTaskArea = false
		self.entranceIds = {
			var_14_1:GetFollowingEntrance()
		}

		self.entranceItemList:align(math.max(#self.entranceIds, 1))
	end

	local var_14_4 = self.rtTaskPanel:Find("entrance_list/target_tpl")

	setActive(var_14_4:Find("Image"), false)
	setText(var_14_4:Find("Text"), i18n("world_task_view2") .. var_14_0:GetActiveEntrance():GetBaseMap():GetName())

	return
end

function WorldOverviewLayer:UpdateAchievementPanel()
	local var_15_0 = nowWorld()
	local var_15_1, var_15_2, var_15_3 = var_15_0:CountAchievements()

	setText(self.rtAchievementPanel:Find("achievement_info/name/info/number"), var_15_1 + var_15_2 .. "/" .. var_15_3)

	local var_15_4, var_15_5 = var_15_0:GetFinishAchievements()
	local var_15_6 = 0

	for iter_15_0, iter_15_1 in ipairs(var_15_4) do
		var_15_6 = var_15_6 + #iter_15_1.star_list
	end

	local var_15_7 = self.rtAchievementPanel:Find("word_list/target_tpl")

	setActive(var_15_7:Find("Image"), true)
	setText(var_15_7:Find("Text"), i18n("world_target_count", "  " .. setColorStr(tostring(var_15_6), COLOR_YELLOW) .. "  "))

	self.entranceIds = var_15_5

	setActive(self.btnAchieve, pg.gameset.world_target_obtain.key_value <= #var_15_4)

	return
end

function WorldOverviewLayer:DisplayAtlasOverall()
	if self.wsAtlasOverall then
		setActive(self.wsAtlasOverall.tfEntity:Find("Plane"), false)
		self.wsAtlasOverall:ShowOrHide(true)
	end

	return
end

function WorldOverviewLayer:HideAtlasOverall()
	if self.wsAtlasOverall then
		self.wsAtlasOverall:ShowOrHide(false)
	end

	return
end

function WorldOverviewLayer:LoadAtlasOverall(arg_18_1)
	local var_18_0 = {}

	if not self.wsAtlasOverall then
		table.insert(var_18_0, function(arg_19_0)
			self.wsAtlasOverall = WSAtlasOverall.New()

			self.wsAtlasOverall:Setup()
			self.wsAtlasOverall:LoadScene(function()
				self.wsAtlasOverall:UpdateAtlas(nowWorld():GetAtlas())

				return arg_19_0()
			end)

			return
		end)
	end

	seriesAsync(var_18_0, function()
		return existCall(arg_18_1)
	end)

	return
end

function WorldOverviewLayer:DisposeAtlasOverall()
	if self.wsAtlasOverall then
		self.wsAtlasOverall:Dispose()

		self.wsAtlasOverall = nil
	end

	return
end

return WorldOverviewLayer
