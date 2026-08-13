class = var_0_10000

local var_0_0 = "MapBuilderSPSeriesRecrew"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MapBuilderSPSeriesFull"))

function var_0_1.GetType(arg_1_0)
	MapBuilder = var_1_10001

	return var_1_10001.TYPESPSERIESRECREW
end

function var_0_1.getUIName(arg_2_0)
	return "LevelSelectSPSeriesRecrewUI"
end

function var_0_1.UpdateStory(arg_3_0)
	local var_3_0 = {}

	pg = var_1_10002

	local var_3_1 = var_1_10002.NewStoryMgr.GetInstance()
	local var_3_2 = 0
	local var_3_3 = 0

	pairs = var_1_10005

	for iter_3_0, iter_3_1 in var_1_10005(arg_3_0.storyNodesDict) do
		local var_3_4 = arg_3_0.storyHolder
		local var_3_5 = var_10.Find

		tostring = var_1_10012

		local var_3_6 = var_3_5(var_3_4, var_1_10012(iter_3_1.id))

		var_1_10012 = iter_3_1

		local var_3_7 = iter_3_1.IsActive(var_1_10012, arg_3_0.activity, arg_3_0.sceneParent.ptActivity)

		setActive = var_1_10012

		var_1_10012(var_3_6, var_3_7)

		setText = var_1_10012

		var_1_10012(var_3_6:Find("main/char/bg/Text"), iter_3_1:GetName())

		setText = var_1_10012

		var_1_10012(var_3_6:Find("main/talk/bg/Text"), iter_3_1:GetName())

		local var_3_8 = iter_3_1

		var_1_10012 = iter_3_1.IsReaded(var_3_8)
		setActive = var_3_8

		var_3_8(var_3_6:Find("main/char"), not var_1_10012)

		setActive = var_3_8

		var_3_8(var_3_6:Find("main/talk"), var_1_10012)

		local var_3_9 = iter_3_1

		if iter_3_1.IsRecrew(var_3_9) == nil then
			setActive = var_3_9

			var_3_9(var_3_6:Find("main/recrew"), false)
		else
			setActive = var_3_9

			var_3_9(var_3_6:Find("main/recrew"), true)

			setActive = var_3_9

			var_3_9(var_3_6:Find("main/recrew/recrewed"), var_13)

			setActive = var_3_9

			var_3_9(var_3_6:Find("main/recrew/not_recrew"), not var_13)

			setText = var_3_9

			local var_3_10 = var_3_6
			local var_3_11 = var_3_6.Find(var_3_10, "main/recrew/recrewed/label")

			i18n = var_3_10

			var_3_9(var_3_11, var_3_10("story_recrewed"))

			setText = var_3_9

			local var_3_12 = var_3_6
			local var_3_13 = var_3_6.Find(var_3_12, "main/recrew/not_recrew/label")

			i18n = var_3_12

			var_3_9(var_3_13, var_3_12("story_not_recrew"))
		end

		onButton = var_3_9

		var_3_9(arg_3_0, var_3_6, function()
			local var_4_0 = iter_3_1
			local var_4_1 = var_0.GetParams

			BossRushStoryNode = var_2_10002

			local var_4_2

			var_4_2 = var_4_1(var_4_0, var_2_10002.REPEATABLE_KEY) and var_0[2]

			if var_1_10012 and not var_4_2 then
				return
			end

			local var_4_3 = iter_3_1
			local var_4_4 = var_2.GetStory(var_4_3)
			local var_4_5 = arg_3_0

			var_3.PlayStory(var_4_5, var_4_4, function()
				local var_5_0 = arg_3_0.activity

				if var_0[#var_0.getConfig(var_5_0, "config_client").storys] == iter_3_1.id and not var_1_10012 then
					pg = var_2

					local var_5_1 = var_2.MsgboxMgr.GetInstance()
					local var_5_2 = var_2.ShowMsgBox
					local var_5_3 = {}

					MSGBOX_TYPE_HELP = var_3_10005
					var_5_3.type = var_3_10005
					i18n = var_3_10005
					var_5_3.helps = var_3_10005("multiple_endings_tip")

					var_5_2(var_5_1, var_5_3)
				end

				local var_5_4 = arg_3_0

				var_2.UpdateView(var_5_4)

				return
			end, var_4_2)

			return
		end)

		var_3_2 = var_3_2 + (var_1_10012 and 1 or 0)
		var_3_3 = var_3_3 + 1
	end

	setText = var_5

	var_5(arg_3_0.progressText, var_3_2 .. "/" .. var_3_3)

	setActive = var_5

	local var_3_14 = arg_3_0.storyAward

	tobool = var_7

	var_5(var_3_14, var_7(arg_3_0.storyTask))

	if arg_3_0.storyTask then
		local var_3_15 = arg_3_0.storyTask
		local var_3_16 = var_5.getConfig(var_3_15, "award_display")

		Drop = var_3_15

		local var_3_17 = var_3_15.Create(var_3_16[1])

		updateDrop = var_7

		local var_3_18 = arg_3_0.storyAward

		var_7(var_8.GetChild(var_3_18, 0), var_3_17)

		local var_3_19 = arg_3_0.storyTask
		local var_3_20 = var_7.getTaskStatus(var_3_19)

		setActive = var_3_19

		local var_3_21 = arg_3_0.storyAward

		var_3_19(var_9.Find(var_3_21, "get"), var_3_20 == 1)

		setActive = var_3_19

		local var_3_22 = arg_3_0.storyAward

		var_3_19(var_9.Find(var_3_22, "got"), var_3_20 == 2)

		onButton = var_3_19

		var_3_19(arg_3_0, arg_3_0.storyAward, function()
			local var_6_0 = arg_3_0
			local var_6_1 = var_0.emit

			BaseUI = var_2_10002

			var_6_1(var_6_0, var_2_10002.ON_DROP, var_3_17)

			return
		end)
	end

	return
end

function var_0_1.SwitchStoryMapAndBGM(arg_7_0)
	local var_7_0 = arg_7_0.data
	local var_7_1 = var_1.getConfig(var_7_0, "default_background")
	local var_7_2 = arg_7_0.data
	local var_7_3 = var_2.getConfig(var_7_2, "default_bgm")
	local var_7_4 = arg_7_0.data
	local var_7_5 = var_3.getConfig(var_7_4, "ani_name")

	underscore = var_7_4

	local var_7_6 = var_7_4.keys(arg_7_0.storyNodesDict)

	table = var_5

	var_5.sort(var_7_6)

	for iter_7_0 = 1, #var_7_6 do
		local var_7_7 = arg_7_0.storyNodesDict[var_7_6[iter_7_0]]

		if var_9.IsReaded(var_7_7) then
			defaultValue = var_10
			var_7_1 = var_10(var_9:GetCleanBG(), var_7_1)
			defaultValue = var_10
			var_7_3 = var_10(var_9:GetCleanBGM(), var_7_3)
			defaultValue = var_10
			var_7_5 = var_10(var_9:GetCleanAnimator(), var_7_5)
		else
			break
		end
	end

	local var_7_8 = arg_7_0.sceneParent

	var_5.SwitchBG(var_7_8, {
		{
			bgPrefix = "bg",
			BG = var_7_1,
			Animator = var_7_5
		}
	})

	pg = var_5

	local var_7_9 = var_5.BgmMgr.GetInstance()

	var_5.Push(var_7_9, arg_7_0.__cname, var_7_3)

	return
end

return var_0_1
