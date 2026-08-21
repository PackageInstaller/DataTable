local var_0_0 = class("CityRebuildMapScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "CityRebuildMapUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.ui = arg_2_0._tf:Find("ui")
	arg_2_0.backBtn = arg_2_0.ui:Find("top/backBtn")
	arg_2_0.helpBtn = arg_2_0.ui:Find("top/helpBtn")
	arg_2_0.homeBtn = arg_2_0.ui:Find("top/homeBtn")
	arg_2_0.cityLevel = arg_2_0.ui:Find("left/cityLevel/Text")
	arg_2_0.battleLevel = arg_2_0.ui:Find("left/battleLevel/Text")
	arg_2_0.battleBtn = arg_2_0.ui:Find("right/battleBtn")
	arg_2_0.taskBtn = arg_2_0.ui:Find("right/taskBtn")
	arg_2_0.bookBtn = arg_2_0.ui:Find("right/bookBtn")
	arg_2_0.storyBtn = arg_2_0.ui:Find("right/storyBtn")
	arg_2_0.award = arg_2_0.ui:Find("left/award")
	arg_2_0.charaList = UIItemList.New(arg_2_0._tf:Find("charas"), arg_2_0._tf:Find("charas/chara"))
	arg_2_0.buildingList = UIItemList.New(arg_2_0._tf:Find("buildings"), arg_2_0._tf:Find("buildings/building"))
	arg_2_0.storyList = UIItemList.New(arg_2_0._tf:Find("stories"), arg_2_0._tf:Find("stories/story"))

	setText(arg_2_0.ui:Find("right/tip"), i18n("ninja_game_booktip"))
	setText(arg_2_0.ui:Find("left/cityLevel/title"), i18n("ninja_game_citylevel"))
	setText(arg_2_0.ui:Find("left/battleLevel/title"), i18n("ninja_game_wave"))

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:InitData()
	arg_3_0:emit(CityRebuildMapMediator.GET_DATA, arg_3_0.activityId)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.homeBtn, function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.battleBtn, function()
		arg_3_0:emit(CityRebuildMapMediator.OPEN_BATTLE)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.taskBtn, function()
		arg_3_0:emit(CityRebuildMapMediator.OPEN_TASKS)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.bookBtn, function()
		arg_3_0:emit(CityRebuildMapMediator.OPEN_BOOK)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.storyBtn, function()
		arg_3_0:emit(CityRebuildMapMediator.OPEN_STORY)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ninja_game_helper.tip
		})

		return
	end, SFX_PANEL)
	pg.NewStoryMgr.GetInstance():Play(pg.activity_ninja_city[1].story)

	return
end

function var_0_0.InitData(arg_11_0)
	arg_11_0.activityId = ActivityConst.NINJA_CITY_ACT_ID
	arg_11_0.cityRebuildProxy = getProxy(CityRebuildProxy)
	arg_11_0.taskProxy = getProxy(TaskProxy)
	arg_11_0.storyTaskId = pg.activity_template[arg_11_0.activityId].config_client.task_id

	return
end

function var_0_0.Refresh(arg_12_0)
	arg_12_0.cityRebuildData = arg_12_0.cityRebuildProxy:GetData(arg_12_0.activityId)

	setText(arg_12_0.cityLevel, "LV." .. arg_12_0.cityRebuildData.cityLevel)
	setText(arg_12_0.battleLevel, arg_12_0.cityRebuildData.maxChooseLevel)

	local var_12_0 = arg_12_0.taskProxy:getTaskVO(arg_12_0.storyTaskId)

	setText(arg_12_0.award:Find("title"), var_12_0:getConfig("desc"))
	setText(arg_12_0.award:Find("title/Text"), var_12_0:getProgress() .. "/" .. var_12_0:getTargetNumber())

	local var_12_1 = var_12_0:getConfig("award_display")[1]

	updateDrop(arg_12_0.award:Find("IconTpl"), {
		type = var_12_1[1],
		id = var_12_1[2],
		count = var_12_1[3]
	})
	setActive(arg_12_0.award:Find("got"), (var_12_0:isReceive()))
	onButton(arg_12_0, arg_12_0.award, function()
		arg_12_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	arg_12_0:SetCharaList()
	arg_12_0:SetBuildingList()
	arg_12_0:SetStoryList()

	for iter_12_0 = 2, 5 do
		setActive(arg_12_0._tf:Find("bg/" .. iter_12_0), iter_12_0 > arg_12_0.cityRebuildData.cityLevel)
	end

	setActive(arg_12_0.bookBtn:Find("tip"), CityRebuildBookLayer.ShouldShowTip())
	setActive(arg_12_0.taskBtn:Find("tip"), CityRebuildTasksLayer.ShouldShowTip())

	return
end

function var_0_0.SetCharaList(arg_14_0)
	arg_14_0.charaList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			local var_15_0 = pg.activity_ninja_building[arg_14_0.cityRebuildData.allCharaIds[arg_15_1 + 1]]
			local var_15_1 = arg_14_0.cityRebuildData:IsRepairedOrRecruited(arg_14_0.cityRebuildData.allCharaIds[arg_15_1 + 1])

			if var_15_1 then
				local var_15_2 = var_15_0.icon[2] or var_15_0.icon[1]

				if var_15_1 then
					local var_15_3 = var_15_0.pos[2] or var_15_0.pos[1]

					setActive(arg_15_2, var_15_2 ~= "")

					if var_15_2 ~= "" then
						GetImageSpriteFromAtlasAsync(var_15_2, "", arg_15_2)

						arg_15_2.anchoredPosition = Vector2(var_15_3[1], var_15_3[2])

						setActive(arg_15_2:Find("name"), false)
					end

					return
				end
			end
		end
	end)
	arg_14_0.charaList:align(#arg_14_0.cityRebuildData.allCharaIds)

	return
end

function var_0_0.SetBuildingList(arg_16_0)
	arg_16_0.buildingList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			local var_17_0 = pg.activity_ninja_building[arg_16_0.cityRebuildData.allBuildingIds[arg_17_1 + 1]]
			local var_17_1 = arg_16_0.cityRebuildData:IsRepairedOrRecruited(arg_16_0.cityRebuildData.allBuildingIds[arg_17_1 + 1])
			local var_17_2 = arg_16_0.cityRebuildData:IsUnlock(arg_16_0.cityRebuildData.allBuildingIds[arg_17_1 + 1])

			if var_17_1 then
				local var_17_3 = var_17_0.icon[2] or var_17_0.icon[1]

				if var_17_1 then
					local var_17_4 = var_17_0.pos[2] or var_17_0.pos[1]

					setActive(arg_17_2, var_17_3 ~= "")

					if var_17_3 ~= "" then
						GetImageSpriteFromAtlasAsync(var_17_3, "", arg_17_2)

						arg_17_2.anchoredPosition = Vector2(var_17_4[1], var_17_4[2])

						setActive(arg_17_2:Find("name"), var_17_2)

						if var_17_2 then
							onButton(arg_16_0, arg_17_2, function()
								arg_16_0:emit(CityRebuildMapMediator.OPEN_BOOK, CityRebuildBookLayer.Building, var_0)

								return
							end, SFX_PANEL)

							local var_17_6 = arg_17_2:Find("name/Text")

							if var_17_1 then
								local var_17_7 = var_17_0.name[2] or var_17_0.name[1]

								var_17_5(var_17_6, var_17_7)

								return
							end
						end
					end
				end
			end
		end
	end)
	arg_16_0.buildingList:align(#arg_16_0.cityRebuildData.allBuildingIds)

	return
end

function var_0_0.SetStoryList(arg_19_0)
	local var_19_0 = pg.activity_ninja_building.all

	arg_19_0.storyList:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			if arg_19_0.cityRebuildData:IsRepairedOrRecruited(var_19_0[arg_20_1 + 1]) then
				local var_20_0 = pg.activity_ninja_building[var_19_0[arg_20_1 + 1]].story or ""
				local var_20_2 = arg_20_2
				local var_20_3 = var_20_0 ~= "" and not pg.NewStoryMgr.GetInstance():IsPlayed(var_20_0[1]) or false

				if false then
					var_20_3 = true
				end

				var_20_1(var_20_2, var_20_3)

				if var_20_0 ~= "" then
					if not pg.NewStoryMgr.GetInstance():IsPlayed(var_20_0[1]) then
						GetImageSpriteFromAtlasAsync(var_20_0[2], "", arg_20_2:Find("icon"))

						arg_20_2.anchoredPosition = Vector2(var_20_0[3][1], var_20_0[3][2])

						onButton(arg_19_0, arg_20_2, function()
							pg.NewStoryMgr.GetInstance():Play(var_20_0[1])

							return
						end, SFX_PANEL)
						setText(arg_20_2:Find("name/Text"), var_20_0[5])
					end
				end

				return
			end
		end
	end)
	arg_19_0.storyList:align(#pg.activity_ninja_building.all)

	return
end

function var_0_0.willExit(arg_22_0)
	return
end

return var_0_0
