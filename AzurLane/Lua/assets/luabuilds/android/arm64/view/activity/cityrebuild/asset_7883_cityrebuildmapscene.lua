class = var_0_10000

local var_0_0 = "CityRebuildMapScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "CityRebuildMapUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.ui = var_1.Find(var_2_0, "ui")

	local var_2_1 = arg_2_0.ui

	arg_2_0.backBtn = var_1.Find(var_2_1, "top/backBtn")

	local var_2_2 = arg_2_0.ui

	arg_2_0.helpBtn = var_1.Find(var_2_2, "top/helpBtn")

	local var_2_3 = arg_2_0.ui

	arg_2_0.homeBtn = var_1.Find(var_2_3, "top/homeBtn")

	local var_2_4 = arg_2_0.ui

	arg_2_0.cityLevel = var_1.Find(var_2_4, "left/cityLevel/Text")

	local var_2_5 = arg_2_0.ui

	arg_2_0.battleLevel = var_1.Find(var_2_5, "left/battleLevel/Text")

	local var_2_6 = arg_2_0.ui

	arg_2_0.battleBtn = var_1.Find(var_2_6, "right/battleBtn")

	local var_2_7 = arg_2_0.ui

	arg_2_0.taskBtn = var_1.Find(var_2_7, "right/taskBtn")

	local var_2_8 = arg_2_0.ui

	arg_2_0.bookBtn = var_1.Find(var_2_8, "right/bookBtn")

	local var_2_9 = arg_2_0.ui

	arg_2_0.storyBtn = var_1.Find(var_2_9, "right/storyBtn")

	local var_2_10 = arg_2_0.ui

	arg_2_0.award = var_1.Find(var_2_10, "left/award")
	UIItemList = var_1

	local var_2_11 = var_1.New
	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_3.Find(var_2_12, "charas")
	local var_2_14 = arg_2_0._tf

	arg_2_0.charaList = var_2_11(var_2_13, var_4.Find(var_2_14, "charas/chara"))
	UIItemList = var_1

	local var_2_15 = var_1.New
	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_3.Find(var_2_16, "buildings")
	local var_2_18 = arg_2_0._tf

	arg_2_0.buildingList = var_2_15(var_2_17, var_4.Find(var_2_18, "buildings/building"))
	UIItemList = var_1

	local var_2_19 = var_1.New
	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_3.Find(var_2_20, "stories")
	local var_2_22 = arg_2_0._tf

	arg_2_0.storyList = var_2_19(var_2_21, var_4.Find(var_2_22, "stories/story"))
	setText = var_1

	local var_2_23 = arg_2_0.ui
	local var_2_24 = var_3.Find(var_2_23, "right/tip")

	i18n = var_4

	var_1(var_2_24, var_4("ninja_game_booktip"))

	setText = var_1

	local var_2_25 = arg_2_0.ui
	local var_2_26 = var_3.Find(var_2_25, "left/cityLevel/title")

	i18n = var_4

	var_1(var_2_26, var_4("ninja_game_citylevel"))

	setText = var_1

	local var_2_27 = arg_2_0.ui
	local var_2_28 = var_3.Find(var_2_27, "left/battleLevel/title")

	i18n = var_4

	var_1(var_2_28, var_4("ninja_game_wave"))

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:InitData()

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.emit

	CityRebuildMapMediator = var_1_10004

	var_3_1(var_3_0, var_1_10004.GET_DATA, arg_3_0.activityId)

	onButton = var_3_1

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.backBtn

	local function var_3_4()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_3_1(var_3_2, var_3_3, var_3_4, var_1_10006)

	onButton = var_3_1

	local var_3_5 = arg_3_0
	local var_3_6 = arg_3_0.homeBtn

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_HOME)

		return
	end

	SFX_CANCEL = var_1_10006

	var_3_1(var_3_5, var_3_6, var_3_7, var_1_10006)

	onButton = var_3_1

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.battleBtn

	local function var_3_10()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		CityRebuildMapMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.OPEN_BATTLE)

		return
	end

	SFX_CANCEL = var_1_10006

	var_3_1(var_3_8, var_3_9, var_3_10, var_1_10006)

	onButton = var_3_1

	local var_3_11 = arg_3_0
	local var_3_12 = arg_3_0.taskBtn

	local function var_3_13()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		CityRebuildMapMediator = var_2_10003

		var_7_1(var_7_0, var_2_10003.OPEN_TASKS)

		return
	end

	SFX_CANCEL = var_1_10006

	var_3_1(var_3_11, var_3_12, var_3_13, var_1_10006)

	onButton = var_3_1

	local var_3_14 = arg_3_0
	local var_3_15 = arg_3_0.bookBtn

	local function var_3_16()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.emit

		CityRebuildMapMediator = var_2_10003

		var_8_1(var_8_0, var_2_10003.OPEN_BOOK)

		return
	end

	SFX_CANCEL = var_1_10006

	var_3_1(var_3_14, var_3_15, var_3_16, var_1_10006)

	onButton = var_3_1

	local var_3_17 = arg_3_0
	local var_3_18 = arg_3_0.storyBtn

	local function var_3_19()
		local var_9_0 = arg_3_0
		local var_9_1 = var_0.emit

		CityRebuildMapMediator = var_2_10003

		var_9_1(var_9_0, var_2_10003.OPEN_STORY)

		return
	end

	SFX_CANCEL = var_1_10006

	var_3_1(var_3_17, var_3_18, var_3_19, var_1_10006)

	onButton = var_3_1

	local var_3_20 = arg_3_0
	local var_3_21 = arg_3_0.helpBtn

	local function var_3_22()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_10_2.type = var_2_10004
		pg = var_2_10004
		var_10_2.helps = var_2_10004.gametip.ninja_game_helper.tip

		var_10_1(var_10_0, var_10_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_3_1(var_3_20, var_3_21, var_3_22, var_1_10006)

	pg = var_3_1

	local var_3_23 = var_3_1.NewStoryMgr.GetInstance()
	local var_3_24 = var_1.Play

	pg = var_3_21

	var_3_24(var_3_23, var_3_21.activity_ninja_city[1].story)

	return
end

function var_0_1.InitData(arg_11_0)
	ActivityConst = var_1_10001
	arg_11_0.activityId = var_1_10001.NINJA_CITY_ACT_ID
	getProxy = var_1
	CityRebuildProxy = var_1_10003
	arg_11_0.cityRebuildProxy = var_1(var_1_10003)
	getProxy = var_1
	TaskProxy = var_1_10003
	arg_11_0.taskProxy = var_1(var_1_10003)
	pg = var_1
	arg_11_0.storyTaskId = var_1.activity_template[arg_11_0.activityId].config_client.task_id

	return
end

function var_0_1.Refresh(arg_12_0)
	local var_12_0 = arg_12_0.cityRebuildProxy

	arg_12_0.cityRebuildData = var_1.GetData(var_12_0, arg_12_0.activityId)
	setText = var_1

	var_1(arg_12_0.cityLevel, "LV." .. arg_12_0.cityRebuildData.cityLevel)

	setText = var_1

	var_1(arg_12_0.battleLevel, arg_12_0.cityRebuildData.maxChooseLevel)

	local var_12_1 = arg_12_0.taskProxy
	local var_12_2 = var_1.getTaskVO(var_12_1, arg_12_0.storyTaskId)

	setText = var_1_10002

	local var_12_3 = arg_12_0.award

	var_1_10002(var_4.Find(var_12_3, "title"), var_12_2:getConfig("desc"))

	setText = var_1_10002

	local var_12_4 = arg_12_0.award

	var_1_10002(var_4.Find(var_12_4, "title/Text"), var_12_2:getProgress() .. "/" .. var_12_2:getTargetNumber())

	local var_12_5 = var_12_2:getConfig("award_display")[1]
	local var_12_6 = {
		type = var_12_5[1],
		id = var_12_5[2],
		count = var_12_5[3]
	}

	updateDrop = var_4

	local var_12_7 = arg_12_0.award

	var_4(var_6.Find(var_12_7, "IconTpl"), var_12_6)

	local var_12_8 = var_12_2:isReceive()

	setActive = var_5

	local var_12_9 = arg_12_0.award

	var_5(var_7.Find(var_12_9, "got"), var_12_8)

	onButton = var_5

	local var_12_10 = arg_12_0
	local var_12_11 = arg_12_0.award

	local function var_12_12()
		local var_13_0 = arg_12_0
		local var_13_1 = var_0.emit

		BaseUI = var_2_10003

		var_13_1(var_13_0, var_2_10003.ON_DROP, var_12_6)

		return
	end

	SFX_PANEL = var_10

	var_5(var_12_10, var_12_11, var_12_12, var_10)
	arg_12_0:SetCharaList()
	arg_12_0:SetBuildingList()
	arg_12_0:SetStoryList()

	for iter_12_0 = 2, 5 do
		local var_12_13 = arg_12_0._tf
		local var_12_14 = var_9.Find(var_12_13, "bg/" .. iter_12_0)

		setActive = var_10

		var_10(var_12_14, iter_12_0 > arg_12_0.cityRebuildData.cityLevel)
	end

	setActive = var_5

	local var_12_15 = arg_12_0.bookBtn
	local var_12_16 = var_7.Find(var_12_15, "tip")

	CityRebuildBookLayer = iter_12_0

	var_5(var_12_16, iter_12_0.ShouldShowTip())

	setActive = var_5

	local var_12_17 = arg_12_0.taskBtn
	local var_12_18 = var_7.Find(var_12_17, "tip")

	CityRebuildTasksLayer = var_8

	var_5(var_12_18, var_8.ShouldShowTip())

	return
end

function var_0_1.SetCharaList(arg_14_0)
	local var_14_0 = arg_14_0.charaList

	var_1.make(var_14_0, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			local var_15_0 = arg_14_0.cityRebuildData.allCharaIds[arg_15_1 + 1]

			pg = var_4

			local var_15_1 = var_4.activity_ninja_building[var_15_0]
			local var_15_2 = arg_14_0.cityRebuildData
			local var_15_3

			if not var_5.IsRepairedOrRecruited(var_15_2, var_15_0) or not var_15_1.icon[2] then
				var_15_3 = var_15_1.icon[1]
			end

			local var_15_4

			if not var_5 or not var_15_1.pos[2] then
				var_15_4 = var_15_1.pos[1]
			end

			setActive = var_8

			var_8(arg_15_2, var_15_3 ~= "")

			if var_15_3 ~= "" then
				GetImageSpriteFromAtlasAsync = var_8

				var_8(var_15_3, "", arg_15_2)

				Vector2 = var_8
				arg_15_2.anchoredPosition = var_8(var_15_4[1], var_15_4[2])
				setActive = var_8

				var_8(arg_15_2:Find("name"), false)
			end
		end

		return
	end)

	local var_14_1 = arg_14_0.charaList

	var_1.align(var_14_1, #arg_14_0.cityRebuildData.allCharaIds)

	return
end

function var_0_1.SetBuildingList(arg_16_0)
	local var_16_0 = arg_16_0.buildingList

	var_1.make(var_16_0, function(arg_17_0, arg_17_1, arg_17_2)
		UIItemList = var_2_10003

		if arg_17_0 == var_2_10003.EventUpdate then
			local var_17_0 = arg_16_0.cityRebuildData.allBuildingIds[arg_17_1 + 1]

			pg = var_4

			local var_17_1 = var_4.activity_ninja_building[var_17_0]
			local var_17_2 = arg_16_0.cityRebuildData
			local var_17_3 = var_5.IsRepairedOrRecruited(var_17_2, var_17_0)
			local var_17_4 = arg_16_0.cityRebuildData
			local var_17_5 = var_6.IsUnlock(var_17_4, var_17_0)
			local var_17_6

			if not var_17_3 or not var_17_1.icon[2] then
				var_17_6 = var_17_1.icon[1]
			end

			local var_17_7

			if not var_17_3 or not var_17_1.pos[2] then
				var_17_7 = var_17_1.pos[1]
			end

			setActive = var_9

			var_9(arg_17_2, var_17_6 ~= "")

			if var_17_6 ~= "" then
				GetImageSpriteFromAtlasAsync = var_9

				var_9(var_17_6, "", arg_17_2)

				Vector2 = var_9
				arg_17_2.anchoredPosition = var_9(var_17_7[1], var_17_7[2])
				setActive = var_9

				var_9(arg_17_2:Find("name"), var_17_5)

				if var_17_5 then
					onButton = var_9

					local var_17_8 = arg_16_0
					local var_17_9 = arg_17_2

					local function var_17_10()
						local var_18_0 = arg_16_0
						local var_18_1 = var_0.emit

						CityRebuildMapMediator = var_3_10003

						local var_18_2 = var_3_10003.OPEN_BOOK

						CityRebuildBookLayer = var_3_10004

						var_18_1(var_18_0, var_18_2, var_3_10004.Building, var_17_0)

						return
					end

					SFX_PANEL = var_14

					var_9(var_17_8, var_17_9, var_17_10, var_14)

					setText = var_9

					local var_17_11 = arg_17_2:Find("name/Text")
					local var_17_12

					if not var_17_3 or not var_17_1.name[2] then
						var_17_12 = var_17_1.name[1]
					end

					var_9(var_17_11, var_17_12)
				end
			end
		end

		return
	end)

	local var_16_1 = arg_16_0.buildingList

	var_1.align(var_16_1, #arg_16_0.cityRebuildData.allBuildingIds)

	return
end

function var_0_1.SetStoryList(arg_19_0)
	pg = var_1_10001

	local var_19_0 = var_1_10001.activity_ninja_building.all
	local var_19_1 = arg_19_0.storyList

	var_2.make(var_19_1, function(arg_20_0, arg_20_1, arg_20_2)
		UIItemList = var_2_10003

		if arg_20_0 == var_2_10003.EventUpdate then
			local var_20_0 = var_19_0[arg_20_1 + 1]

			pg = var_4

			local var_20_1 = var_4.activity_ninja_building[var_20_0]
			local var_20_2 = arg_19_0.cityRebuildData
			local var_20_3

			if not var_5.IsRepairedOrRecruited(var_20_2, var_20_0) or not var_20_1.story then
				var_20_3 = ""
			end

			setActive = var_20_2

			local var_20_4 = arg_20_2
			local var_20_6

			if var_20_3 ~= "" then
				pg = var_2_10010

				local var_20_5 = var_2_10010.NewStoryMgr.GetInstance()

				var_20_6 = not var_10.IsPlayed(var_20_5, var_20_3[1])
			else
				var_20_6 = false
			end

			if false then
				var_20_6 = true
			end

			var_20_2(var_20_4, var_20_6)

			if var_20_3 ~= "" then
				pg = var_20_2

				local var_20_7 = var_20_2.NewStoryMgr.GetInstance()

				if not var_7.IsPlayed(var_20_7, var_20_3[1]) then
					GetImageSpriteFromAtlasAsync = var_7

					local var_20_8 = var_20_3[2]
					local var_20_9 = ""
					local var_20_10 = arg_20_2

					var_7(var_20_8, var_20_9, arg_20_2.Find(var_20_10, "icon"))

					local var_20_11 = var_20_3[3]

					Vector2 = var_8
					arg_20_2.anchoredPosition = var_8(var_20_11[1], var_20_11[2])
					onButton = var_8

					local var_20_12 = arg_19_0
					local var_20_13 = arg_20_2

					local function var_20_14()
						pg = var_3_10000

						local var_21_0 = var_3_10000.NewStoryMgr.GetInstance()

						var_0.Play(var_21_0, var_20_3[1])

						return
					end

					SFX_PANEL = var_20_10

					var_8(var_20_12, var_20_13, var_20_14, var_20_10)

					setText = var_8

					var_8(arg_20_2:Find("name/Text"), var_20_3[5])
				end
			end
		end

		return
	end)

	local var_19_2 = arg_19_0.storyList

	var_2.align(var_19_2, #var_19_0)

	return
end

function var_0_1.willExit(arg_22_0)
	return
end

return var_0_1
