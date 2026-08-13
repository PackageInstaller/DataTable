class = var_0_10000

local var_0_0 = "WorldOverviewLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "WorldOverviewUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	arg_2_0:LoadAtlasOverall(arg_2_1)

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.rtBg = var_1.Find(var_3_0, "bg")
	onButton = var_2

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.rtBg

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_2(var_3_1, var_3_2, var_3_3, var_1_10006)

	setText = var_2

	local var_3_4 = var_1
	local var_3_5 = var_1.Find(var_3_4, "tip/Text")

	i18n = var_3_4

	var_2(var_3_5, var_3_4("click_back_tip"))

	arg_3_0.rtTaskPanel = var_1:Find("panel/middle/info_panel/task_panel")
	setActive = var_2

	var_2(arg_3_0.rtTaskPanel, false)

	setActive = var_2

	local var_3_6 = arg_3_0.rtTaskPanel

	var_2(var_3.Find(var_3_6, "btn_next"), false)

	UIItemList = var_2

	local var_3_7 = var_2.New
	local var_3_8 = arg_3_0.rtTaskPanel
	local var_3_9 = var_3.Find(var_3_8, "entrance_list/target_list")
	local var_3_10 = arg_3_0.rtTaskPanel

	arg_3_0.entranceItemList = var_3_7(var_3_9, var_4.Find(var_3_10, "entrance_list/target_tpl"))

	local var_3_11 = arg_3_0.entranceItemList

	var_2.make(var_3_11, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_1

			if arg_3_0.entranceIds[arg_5_1] then
				nowWorld = var_5_1

				local var_5_0 = var_5_1()

				var_5_1 = var_5_1.GetEntrance(var_5_0, arg_3_0.entranceIds[arg_5_1])
				setActive = var_5_0

				var_5_0(arg_5_2:Find("Image"), true)

				setText = var_5_0

				local var_5_2 = arg_5_2
				local var_5_3 = arg_5_2.Find(var_5_2, "Text")

				i18n = var_5_2

				local var_5_4 = var_5_2("world_task_view1")
				local var_5_5 = var_5_1:GetBaseMap()

				var_5_0(var_5_3, var_5_4 .. var_7.GetName(var_5_5))
			else
				setActive = var_5_1

				var_5_1(arg_5_2:Find("Image"), true)

				setText = var_5_1

				local var_5_6 = arg_5_2
				local var_5_7 = arg_5_2.Find(var_5_6, "Text")

				i18n = var_5_6

				local var_5_8 = var_5_6("world_task_view1")

				i18n = var_6

				var_5_1(var_5_7, var_5_8 .. var_6("world_task_view2"))
			end
		end

		return
	end)

	UIItemList = var_2

	local var_3_12 = var_2.New
	local var_3_13 = arg_3_0.rtTaskPanel
	local var_3_14 = var_3.Find(var_3_13, "entrance_list/target_list")
	local var_3_15 = arg_3_0.rtTaskPanel

	arg_3_0.areaItemList = var_3_12(var_3_14, var_4.Find(var_3_15, "entrance_list/target_tpl"))

	local var_3_16 = arg_3_0.areaItemList

	var_2.make(var_3_16, function(arg_6_0, arg_6_1, arg_6_2)
		arg_6_1 = arg_6_1 + 1
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			if arg_3_0.areaIds[arg_6_1] then
				setActive = var_3

				var_3(arg_6_2:Find("Image"), true)

				setText = var_3

				local var_6_0 = arg_6_2
				local var_6_1 = arg_6_2.Find(var_6_0, "Text")

				i18n = var_6_0

				local var_6_2 = var_6_0("world_task_view1")

				pg = var_6

				var_3(var_6_1, var_6_2 .. var_6.world_regions_data[arg_3_0.areaIds[arg_6_1]].name)
			else
				setActive = var_3

				var_3(arg_6_2:Find("Image"), true)

				setText = var_3

				local var_6_3 = arg_6_2
				local var_6_4 = arg_6_2.Find(var_6_3, "Text")

				i18n = var_6_3

				local var_6_5 = var_6_3("world_task_view1")

				i18n = var_6

				var_3(var_6_4, var_6_5 .. var_6("world_task_view2"))
			end
		end

		return
	end)

	arg_3_0.rtAchievementPanel = var_1:Find("panel/middle/info_panel/achievement_panel")
	setActive = var_2

	var_2(arg_3_0.rtAchievementPanel, false)

	local var_3_17 = arg_3_0.rtAchievementPanel

	arg_3_0.btnAchieve = var_2.Find(var_3_17, "btn_all")
	onButton = var_2

	local var_3_18 = arg_3_0
	local var_3_19 = arg_3_0.btnAchieve

	local function var_3_20()
		nowWorld = var_2_10000

		local var_7_0 = var_2_10000()
		local var_7_1, var_7_2 = var_0.GetFinishAchievements(var_7_0)

		if #var_7_1 == 0 then
			pg = var_2

			local var_7_3 = var_2.TipsMgr.GetInstance()

			var_2.ShowTips(var_7_3, "without any award")
		else
			local var_7_4 = arg_3_0
			local var_7_5 = var_2.emit

			WorldOverviewMediator = var_2_10004

			var_7_5(var_7_4, var_2_10004.OnAchieveStar, var_7_1)

			local var_7_6 = arg_3_0

			var_2.closeView(var_7_6)
		end

		return
	end

	SFX_CONFIRM = var_6

	var_2(var_3_18, var_3_19, var_3_20, var_6)

	pg = var_2

	local var_3_21 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_3_21, arg_3_0._tf)

	return
end

function var_0_1.didEnter(arg_8_0)
	arg_8_0.mode = arg_8_0.contextData.info.mode

	if arg_8_0.mode == "Task" then
		arg_8_0.taskId = var_1.taskId

		arg_8_0:UpdateTaskPanel()
	elseif arg_8_0.mode == "Achievement" then
		arg_8_0:UpdateAchievementPanel()
	else
		arg_8_0.entranceIds = var_1.ids
	end

	local var_8_0 = arg_8_0._tf
	local var_8_1 = var_2.GetComponent(var_8_0, "DftAniEvent")

	var_2.SetEndEvent(var_8_1, function(arg_9_0)
		local var_9_0 = {}

		_ = var_2_10002

		var_2_10002.each(arg_8_0.entranceIds, function(arg_10_0)
			var_9_0[arg_10_0] = true

			return
		end)

		if #arg_8_0.entranceIds > 0 then
			local var_9_1 = arg_8_0.wsAtlasOverall

			var_2.UpdateTargetEntrance(var_9_1, arg_8_0.entranceIds[1])
		end

		local var_9_2 = arg_8_0.wsAtlasOverall
		local var_9_3 = var_2.UpdateStaticMark
		local var_9_4 = var_9_0
		local var_9_5 = arg_8_0

		var_9_3(var_9_2, var_9_4, var_5.GetOverviewMark(var_9_5))

		local var_9_6 = arg_8_0

		var_2.DisplayAtlasOverall(var_9_6)

		if arg_8_0.mode then
			setActive = var_2

			var_2(arg_8_0["rt" .. arg_8_0.mode .. "Panel"], true)

			if arg_8_0.mode == "Task" then
				eachChild = var_2

				var_2(arg_8_0.entranceItemList.container, function(arg_11_0)
					GetComponent = var_3_10001

					local var_11_0 = arg_11_0
					local var_11_1 = arg_11_0.Find(var_11_0, "Text")

					typeof = var_11_0
					Typewriter = var_4

					local var_11_2 = var_3_10001(var_11_1, var_11_0(var_4))

					var_1.setSpeed(var_11_2, 0.03)
					var_1:Play()

					return
				end)

				local var_9_7 = arg_8_0.rtTaskPanel
				local var_9_8 = var_2.Find(var_9_7, "entrance_list/target_tpl")

				GetComponent = var_9_7

				local var_9_9 = var_9_8
				local var_9_10 = var_9_8.Find(var_9_9, "Text")

				typeof = var_9_9
				Typewriter = var_6

				local var_9_11 = var_9_7(var_9_10, var_9_9(var_6))

				var_3.setSpeed(var_9_11, 0.03)
				var_3:Play()
			end
		end

		return
	end)

	return
end

function var_0_1.willExit(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_12_0, arg_12_0._tf, arg_12_0._parentTf)

	if arg_12_0.mode then
		setActive = var_1

		var_1(arg_12_0["rt" .. arg_12_0.mode .. "Panel"], false)
	end

	arg_12_0:HideAtlasOverall()
	arg_12_0:DisposeAtlasOverall()

	return
end

function var_0_1.GetOverviewMark(arg_13_0)
	if arg_13_0.mode == "Task" then
		if arg_13_0.isTaskArea then
			return {
				"overview_port"
			}
		else
			return {
				"overview_task_port",
				"overview_task"
			}
		end
	elseif arg_13_0.mode == "Achievement" then
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

function var_0_1.UpdateTaskPanel(arg_14_0)
	nowWorld = var_1_10001

	local var_14_0 = var_1_10001()
	local var_14_1 = var_1.GetTaskProxy(var_14_0)
	local var_14_2 = var_2.getTaskById(var_14_1, arg_14_0.taskId)

	assert = var_14_1

	var_14_1(var_14_2, "without this doing task: " .. arg_14_0.taskId)

	local var_14_3 = arg_14_0.rtTaskPanel
	local var_14_4 = var_3.Find(var_14_3, "task_info")

	GetImageSpriteFromAtlasAsync = var_14_3

	local var_14_5 = "ui/worldtaskfloatui_atlas"

	pg = var_6

	var_14_3(var_14_5, var_6.WorldToastMgr.Type2PictrueName[var_14_2.config.type], var_14_4:Find("type"), true)

	setText = var_14_3

	var_14_3(var_14_4:Find("name/Text"), var_14_2.config.name)

	if var_14_2:GetFollowingAreaId() then
		arg_14_0.isTaskArea = true
		underscore = var_5
		arg_14_0.entranceIds = var_5.rest(var_1:GetAreaEntranceIds(var_4), 1)
		arg_14_0.areaIds = {
			var_4
		}

		local var_14_6 = arg_14_0.areaItemList
		local var_14_7 = var_5.align

		math = var_7

		var_14_7(var_14_6, var_7.max(#arg_14_0.areaIds, 1))
	else
		arg_14_0.isTaskArea = false

		local var_14_8 = {}
		local var_14_9 = var_14_2

		var_14_8[1] = var_14_2.GetFollowingEntrance(var_14_9)
		arg_14_0.entranceIds = var_14_8

		local var_14_10 = arg_14_0.entranceItemList
		local var_14_11 = var_5.align

		math = var_14_9

		var_14_11(var_14_10, var_14_9.max(#arg_14_0.entranceIds, 1))
	end

	local var_14_12 = arg_14_0.rtTaskPanel
	local var_14_13 = var_5.Find(var_14_12, "entrance_list/target_tpl")
	local var_14_14 = var_1
	local var_14_15 = var_1.GetActiveEntrance(var_14_14)

	setActive = var_14_14

	var_14_14(var_14_13:Find("Image"), false)

	setText = var_14_14

	local var_14_16 = var_14_13
	local var_14_17 = var_14_13.Find(var_14_16, "Text")

	i18n = var_14_16

	local var_14_18 = var_14_16("world_task_view2")
	local var_14_19 = var_14_15:GetBaseMap()

	var_14_14(var_14_17, var_14_18 .. var_10.GetName(var_14_19))

	return
end

function var_0_1.UpdateAchievementPanel(arg_15_0)
	nowWorld = var_1_10001

	local var_15_0 = var_1_10001()
	local var_15_1, var_15_2, var_15_3 = var_1.CountAchievements(var_15_0)

	setText = var_1_10005

	local var_15_4 = arg_15_0.rtAchievementPanel

	var_1_10005(var_6.Find(var_15_4, "achievement_info/name/info/number"), var_15_1 + var_15_2 .. "/" .. var_15_3)

	local var_15_5, var_15_6 = var_1:GetFinishAchievements()
	local var_15_7 = 0

	ipairs = var_8

	for iter_15_0, iter_15_1 in var_8(var_15_5) do
		var_15_7 = var_15_7 + #iter_15_1.star_list
	end

	local var_15_8 = arg_15_0.rtAchievementPanel
	local var_15_9 = var_8.Find(var_15_8, "word_list/target_tpl")

	setActive = var_15_8

	var_15_8(var_15_9:Find("Image"), true)

	setText = var_15_8

	local var_15_10 = var_15_9
	local var_15_11 = var_15_9.Find(var_15_10, "Text")

	i18n = var_15_10

	local var_15_12 = "world_target_count"
	local var_15_13 = "  "

	setColorStr = var_1_10014
	tostring = var_1_10015

	local var_15_14 = var_1_10015(var_15_7)

	COLOR_YELLOW = var_16

	var_15_8(var_15_11, var_15_10(var_15_12, var_15_13 .. var_1_10014(var_15_14, var_16) .. "  "))

	arg_15_0.entranceIds = var_15_6
	pg = var_15_8

	local var_15_15 = var_15_8.gameset.world_target_obtain.key_value

	setActive = var_15_11

	var_15_11(arg_15_0.btnAchieve, var_15_15 <= #var_15_5)

	return
end

function var_0_1.DisplayAtlasOverall(arg_16_0)
	if arg_16_0.wsAtlasOverall then
		setActive = var_1

		local var_16_0 = arg_16_0.wsAtlasOverall.tfEntity

		var_1(var_2.Find(var_16_0, "Plane"), false)

		local var_16_1 = arg_16_0.wsAtlasOverall

		var_1.ShowOrHide(var_16_1, true)
	end

	return
end

function var_0_1.HideAtlasOverall(arg_17_0)
	if arg_17_0.wsAtlasOverall then
		local var_17_0 = arg_17_0.wsAtlasOverall

		var_1.ShowOrHide(var_17_0, false)
	end

	return
end

function var_0_1.LoadAtlasOverall(arg_18_0, arg_18_1)
	local var_18_0 = {}

	if not arg_18_0.wsAtlasOverall then
		table = var_3

		var_3.insert(var_18_0, function(arg_19_0)
			local var_19_0 = arg_18_0

			WSAtlasOverall = var_2_10002
			var_19_0.wsAtlasOverall = var_2_10002.New()

			local var_19_1 = arg_18_0.wsAtlasOverall

			var_1.Setup(var_19_1)

			local var_19_2 = arg_18_0.wsAtlasOverall

			var_1.LoadScene(var_19_2, function()
				local var_20_0 = arg_18_0.wsAtlasOverall
				local var_20_1 = var_0.UpdateAtlas

				nowWorld = var_3_10002

				local var_20_2 = var_3_10002()

				var_20_1(var_20_0, var_2.GetAtlas(var_20_2))

				return arg_19_0()
			end)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_18_0, function()
		existCall = var_2_10000

		return var_2_10000(arg_18_1)
	end)

	return
end

function var_0_1.DisposeAtlasOverall(arg_22_0)
	if arg_22_0.wsAtlasOverall then
		local var_22_0 = arg_22_0.wsAtlasOverall

		var_1.Dispose(var_22_0)

		arg_22_0.wsAtlasOverall = nil
	end

	return
end

return var_0_1
