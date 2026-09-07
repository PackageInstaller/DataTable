local CityRebuildMapScene = class("CityRebuildMapScene", import("view.base.BaseUI"))

function CityRebuildMapScene:getUIName()
	return "CityRebuildMapUI"
end

function CityRebuildMapScene:init()
	self.ui = self._tf:Find("ui")
	self.backBtn = self.ui:Find("top/backBtn")
	self.helpBtn = self.ui:Find("top/helpBtn")
	self.homeBtn = self.ui:Find("top/homeBtn")
	self.cityLevel = self.ui:Find("left/cityLevel/Text")
	self.battleLevel = self.ui:Find("left/battleLevel/Text")
	self.battleBtn = self.ui:Find("right/battleBtn")
	self.taskBtn = self.ui:Find("right/taskBtn")
	self.bookBtn = self.ui:Find("right/bookBtn")
	self.storyBtn = self.ui:Find("right/storyBtn")
	self.award = self.ui:Find("left/award")
	self.charaList = UIItemList.New(self._tf:Find("charas"), self._tf:Find("charas/chara"))
	self.buildingList = UIItemList.New(self._tf:Find("buildings"), self._tf:Find("buildings/building"))
	self.storyList = UIItemList.New(self._tf:Find("stories"), self._tf:Find("stories/story"))

	setText(self.ui:Find("right/tip"), i18n("ninja_game_booktip"))
	setText(self.ui:Find("left/cityLevel/title"), i18n("ninja_game_citylevel"))
	setText(self.ui:Find("left/battleLevel/title"), i18n("ninja_game_wave"))

	return
end

function CityRebuildMapScene:didEnter()
	self:InitData()
	self:emit(CityRebuildMapMediator.GET_DATA, self.activityId)
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.homeBtn, function()
		self:emit(CityRebuildMapScene.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(self, self.battleBtn, function()
		self:emit(CityRebuildMapMediator.OPEN_BATTLE)

		return
	end, SFX_CANCEL)
	onButton(self, self.taskBtn, function()
		self:emit(CityRebuildMapMediator.OPEN_TASKS)

		return
	end, SFX_CANCEL)
	onButton(self, self.bookBtn, function()
		self:emit(CityRebuildMapMediator.OPEN_BOOK)

		return
	end, SFX_CANCEL)
	onButton(self, self.storyBtn, function()
		self:emit(CityRebuildMapMediator.OPEN_STORY)

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ninja_game_helper.tip
		})

		return
	end, SFX_PANEL)
	pg.NewStoryMgr.GetInstance():Play(pg.activity_ninja_city[1].story)

	return
end

function CityRebuildMapScene:InitData()
	self.activityId = ActivityConst.NINJA_CITY_ACT_ID
	self.cityRebuildProxy = getProxy(CityRebuildProxy)
	self.taskProxy = getProxy(TaskProxy)
	self.storyTaskId = pg.activity_template[self.activityId].config_client.task_id

	return
end

function CityRebuildMapScene:Refresh()
	self.cityRebuildData = self.cityRebuildProxy:GetData(self.activityId)

	setText(self.cityLevel, "LV." .. self.cityRebuildData.cityLevel)
	setText(self.battleLevel, self.cityRebuildData.maxChooseLevel)

	local var_12_0 = self.taskProxy:getTaskVO(self.storyTaskId)

	setText(self.award:Find("title"), var_12_0:getConfig("desc"))
	setText(self.award:Find("title/Text"), var_12_0:getProgress() .. "/" .. var_12_0:getTargetNumber())

	local var_12_1 = var_12_0:getConfig("award_display")[1]
	local var_12_2 = {
		type = var_12_1[1],
		id = var_12_1[2],
		count = var_12_1[3]
	}

	updateDrop(self.award:Find("IconTpl"), var_12_2)
	setActive(self.award:Find("got"), (var_12_0:isReceive()))
	onButton(self, self.award, function()
		self:emit(BaseUI.ON_DROP, var_12_2)

		return
	end, SFX_PANEL)
	self:SetCharaList()
	self:SetBuildingList()
	self:SetStoryList()

	for iter_12_0 = 2, 5 do
		setActive(self._tf:Find("bg/" .. iter_12_0), iter_12_0 > self.cityRebuildData.cityLevel)
	end

	setActive(self.bookBtn:Find("tip"), CityRebuildBookLayer.ShouldShowTip())
	setActive(self.taskBtn:Find("tip"), CityRebuildTasksLayer.ShouldShowTip())

	return
end

function CityRebuildMapScene:SetCharaList()
	self.charaList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			local var_15_0 = pg.activity_ninja_building[self.cityRebuildData.allCharaIds[arg_15_1 + 1]]
			local var_15_1 = self.cityRebuildData:IsRepairedOrRecruited(self.cityRebuildData.allCharaIds[arg_15_1 + 1])
			local var_15_2

			if var_15_1 then
				var_15_2 = var_15_0.icon[2] or var_15_0.icon[1]

				local var_15_3

				if var_15_1 then
					var_15_3 = var_15_0.pos[2] or var_15_0.pos[1]
				end
			end

			setActive(arg_15_2, var_15_2 ~= "")

			if var_15_2 ~= "" then
				GetImageSpriteFromAtlasAsync(var_15_2, "", arg_15_2)

				arg_15_2.anchoredPosition = Vector2(var_15_3[1], var_15_3[2])

				setActive(arg_15_2:Find("name"), false)
			end
		end

		return
	end)
	self.charaList:align(#self.cityRebuildData.allCharaIds)

	return
end

function CityRebuildMapScene:SetBuildingList()
	self.buildingList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			local var_17_0 = self.cityRebuildData.allBuildingIds[arg_17_1 + 1]
			local var_17_1 = pg.activity_ninja_building[self.cityRebuildData.allBuildingIds[arg_17_1 + 1]]
			local var_17_2 = self.cityRebuildData:IsRepairedOrRecruited(self.cityRebuildData.allBuildingIds[arg_17_1 + 1])
			local var_17_3 = self.cityRebuildData:IsUnlock(self.cityRebuildData.allBuildingIds[arg_17_1 + 1])
			local var_17_4

			if var_17_2 then
				var_17_4 = var_17_1.icon[2] or var_17_1.icon[1]

				local var_17_5

				if var_17_2 then
					var_17_5 = var_17_1.pos[2] or var_17_1.pos[1]
				end
			end

			setActive(arg_17_2, var_17_4 ~= "")

			if var_17_4 ~= "" then
				GetImageSpriteFromAtlasAsync(var_17_4, "", arg_17_2)

				arg_17_2.anchoredPosition = Vector2(var_17_5[1], var_17_5[2])

				setActive(arg_17_2:Find("name"), var_17_3)

				if var_17_3 then
					onButton(self, arg_17_2, function()
						self:emit(CityRebuildMapMediator.OPEN_BOOK, CityRebuildBookLayer.Building, var_17_0)

						return
					end, SFX_PANEL)
					setText(arg_17_2:Find("name/Text"), (var_17_2 or nil) and (var_17_1.name[2] or var_17_1.name[1]))
				end
			end
		end

		return
	end)
	self.buildingList:align(#self.cityRebuildData.allBuildingIds)

	return
end

function CityRebuildMapScene:SetStoryList()
	local var_19_0 = pg.activity_ninja_building.all

	self.storyList:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			local var_20_0

			if self.cityRebuildData:IsRepairedOrRecruited(var_19_0[arg_20_1 + 1]) then
				var_20_0 = pg.activity_ninja_building[var_19_0[arg_20_1 + 1]].story or ""
			end

			local var_20_1 = setActive
			local var_20_2 = arg_20_2
			local var_20_3 = var_20_0 ~= "" and not pg.NewStoryMgr.GetInstance():IsPlayed(var_20_0[1]) or false

			var_20_1(var_20_2, (false or nil) and true)

			if var_20_0 ~= "" then
				if not pg.NewStoryMgr.GetInstance():IsPlayed(var_20_0[1]) then
					GetImageSpriteFromAtlasAsync(var_20_0[2], "", arg_20_2:Find("icon"))

					arg_20_2.anchoredPosition = Vector2(var_20_0[3][1], var_20_0[3][2])

					onButton(self, arg_20_2, function()
						pg.NewStoryMgr.GetInstance():Play(var_20_0[1])

						return
					end, SFX_PANEL)
					setText(arg_20_2:Find("name/Text"), var_20_0[5])
				end
			end
		end

		return
	end)
	self.storyList:align(#pg.activity_ninja_building.all)

	return
end

function CityRebuildMapScene:willExit()
	return
end

return CityRebuildMapScene
