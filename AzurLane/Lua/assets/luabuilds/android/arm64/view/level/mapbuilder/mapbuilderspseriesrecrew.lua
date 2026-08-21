local var_0_0 = class("MapBuilderSPSeriesRecrew", import(".MapBuilderSPSeriesFull"))

function var_0_0.GetType(arg_1_0)
	return MapBuilder.TYPESPSERIESRECREW
end

function var_0_0.getUIName(arg_2_0)
	return "LevelSelectSPSeriesRecrewUI"
end

function var_0_0.UpdateStory(arg_3_0)
	local var_3_1 = pg.NewStoryMgr.GetInstance()
	local var_3_2 = 0
	local var_3_3 = 0

	for iter_3_0, iter_3_1 in pairs(arg_3_0.storyNodesDict) do
		local var_3_4 = arg_3_0.storyHolder:Find(tostring(iter_3_1.id))

		setActive(var_3_4, (iter_3_1:IsActive(arg_3_0.activity, arg_3_0.sceneParent.ptActivity)))
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

		onButton(arg_3_0, var_3_4, function()
			local var_4_0 = iter_3_1:GetParams(BossRushStoryNode.REPEATABLE_KEY)
			local var_4_1 = var_4_0 and var_4_0[2]

			if var_3_5 and not var_4_1 then
				return
			end

			arg_3_0:PlayStory(iter_3_1:GetStory(), function()
				local var_5_0 = arg_3_0.activity:getConfig("config_client").storys

				if var_5_0[#var_5_0] == iter_3_1.id and not var_3_5 then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						type = MSGBOX_TYPE_HELP,
						helps = i18n("multiple_endings_tip")
					})
				end

				arg_3_0:UpdateView()

				return
			end, var_4_1)

			return
		end)

		var_3_2 = var_3_2 + (var_3_5 and 1 or 0)
		var_3_3 = var_3_3 + 1
	end

	setText(arg_3_0.progressText, var_3_2 .. "/" .. var_3_3)
	setActive(arg_3_0.storyAward, tobool(arg_3_0.storyTask))

	if arg_3_0.storyTask then
		updateDrop(arg_3_0.storyAward:GetChild(0), (Drop.Create(arg_3_0.storyTask:getConfig("award_display")[1])))

		local var_3_7 = arg_3_0.storyTask:getTaskStatus()

		setActive(arg_3_0.storyAward:Find("get"), var_3_7 == 1)
		setActive(arg_3_0.storyAward:Find("got"), var_3_7 == 2)
		onButton(arg_3_0, arg_3_0.storyAward, function()
			arg_3_0:emit(BaseUI.ON_DROP, var_0)

			return
		end)
	end

	return
end

function var_0_0.SwitchStoryMapAndBGM(arg_7_0)
	local var_7_0 = arg_7_0.data:getConfig("default_background")
	local var_7_1 = arg_7_0.data:getConfig("default_bgm")
	local var_7_2 = arg_7_0.data:getConfig("ani_name")
	local var_7_3 = underscore.keys(arg_7_0.storyNodesDict)

	table.sort(var_7_3)

	for iter_7_0 = 1, #var_7_3 do
		if arg_7_0.storyNodesDict[var_7_3[iter_7_0]]:IsReaded() then
			var_7_0 = defaultValue(arg_7_0.storyNodesDict[var_7_3[iter_7_0]]:GetCleanBG(), var_7_0)
			var_7_1 = defaultValue(arg_7_0.storyNodesDict[var_7_3[iter_7_0]]:GetCleanBGM(), var_7_1)
			var_7_2 = defaultValue(arg_7_0.storyNodesDict[var_7_3[iter_7_0]]:GetCleanAnimator(), var_7_2)
		else
			break
		end
	end

	arg_7_0.sceneParent:SwitchBG({
		{
			bgPrefix = "bg",
			BG = var_7_0,
			Animator = var_7_2
		}
	})
	pg.BgmMgr.GetInstance():Push(arg_7_0.__cname, var_7_1)

	return
end

return var_0_0
