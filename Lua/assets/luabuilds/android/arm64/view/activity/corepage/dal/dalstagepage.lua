local var_0_0 = class("DALStagePage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.AD = arg_1_0._tf:Find("AD")
	arg_1_0.tabs = arg_1_0.AD:Find("tabs")
	arg_1_0.tabsList = arg_1_0.tabs.transform.childCount

	setText(arg_1_0.AD:Find("headline_bg/Text (Legacy)"), i18n("DAL_story_tip"))

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	arg_2_0.taskProxy = getProxy(TaskProxy)
	arg_2_0.config_data = arg_2_0.activity:getConfig("config_data")
	arg_2_0.config_client = arg_2_0.activity:getConfig("config_client").story

	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	for iter_3_0 = 1, #arg_3_0.config_data do
		local var_3_0 = arg_3_0.taskProxy:getTaskVO(arg_3_0.config_data[iter_3_0]):getTaskStatus()

		SetActive(arg_3_0.AD:Find("tabs/" .. iter_3_0 .. "/got_red"), var_3_0 == 2)
		SetActive(arg_3_0.AD:Find("tabs/" .. iter_3_0 .. "/red"), var_3_0 == 1)

		if var_3_0 == 2 then
			local var_3_1 = pg.NewStoryMgr.GetInstance()

			if not var_3_1:IsPlayed(arg_3_0.config_client[iter_3_0][1]) then
				local var_3_2, var_3_3 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_3_0.config_client[iter_3_0][1])

				pg.m02:sendNotification(GAME.STORY_UPDATE_LIST, {
					storyIds = {
						var_3_2
					},
					callback = callback
				})
			end
		end
	end

	local var_3_4 = -1

	for iter_3_1 = 0, arg_3_0.tabsList - 1 do
		onToggle(arg_3_0, arg_3_0.tabs:GetChild(iter_3_1), function(arg_4_0)
			if arg_4_0 then
				if var_3_4 ~= iter_3_1 then
					arg_3_0:OnUpdata(iter_3_1 + 1)
				end

				var_3_4 = iter_3_1
			end

			return
		end, SFX_PANEL)
	end

	triggerToggle(arg_3_0.tabs:Find("1"), true)

	return
end

function var_0_0.OnUpdata(arg_5_0, arg_5_1)
	setText(arg_5_0.AD:Find("id"), "0" .. arg_5_1)
	setText(arg_5_0.AD:Find("id/Text"), i18n("dal_story_tip_name_en_" .. arg_5_1))
	setText(arg_5_0.AD:Find("go/name"), i18n("text_goto"))
	setImageSprite(arg_5_0.AD:Find("Image"), LoadSprite("ui/DALStagePage_atlas", arg_5_1), true)

	local var_5_0 = arg_5_0.taskProxy:getTaskVO(arg_5_0.config_data[arg_5_1])

	setText(arg_5_0.AD:Find("Image/lock/Text"), var_5_0:getConfig("desc"))
	setText(arg_5_0.AD:Find("Text"), var_5_0:getConfig("name"))

	local var_5_1 = var_5_0:getConfig("award_display")[1]

	updateDrop(arg_5_0.AD:Find("award"), {
		type = var_5_1[1],
		id = var_5_1[2],
		count = var_5_1[3]
	})
	onButton(arg_5_0, arg_5_0.AD:Find("award/icon_mask"), function()
		arg_5_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_5_2 = var_5_0:getTaskStatus()

	SetActive(arg_5_0.AD:Find("award/lock"), var_5_2 == 2)
	SetActive(arg_5_0.AD:Find("play"), var_5_2 == 1 and not arg_5_0.IsPlayeds)
	SetActive(arg_5_0.AD:Find("go"), var_5_2 == 0)
	SetActive(arg_5_0.AD:Find("Image/lock"), var_5_2 == 0)
	onButton(arg_5_0, arg_5_0.AD:Find("play"), function()
		pg.NewStoryMgr.GetInstance():Play(arg_5_0.config_client[arg_5_1][1], function()
			arg_5_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_5_0)

			return
		end, true)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.AD:Find("go"), function()
		arg_5_0:emit(ActivityMediator.ON_TASK_GO, var_5_0)

		return
	end, SFX_PANEL)

	if var_5_2 == 0 then
		setText(arg_5_0.AD:Find("rule"), i18n("dal_story_tip1"))
	elseif var_5_2 == 1 then
		setText(arg_5_0.AD:Find("rule"), i18n("dal_story_tip2"))
	elseif var_5_2 == 2 then
		setText(arg_5_0.AD:Find("rule"), i18n("dal_story_tip3"))
	end

	return
end

return var_0_0
