local var_0_0 = class("AnniversaryNineHwahJahSkinPage", import("view.activity.CorePage.OutPost.OutPostOmenPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("bg")
	arg_1_0.dayTF = arg_1_0.bg:Find("total_progress/day")
	arg_1_0.maxDayTF = arg_1_0.bg:Find("total_progress/max_day")
	arg_1_0.item = arg_1_0.bg:Find("item")
	arg_1_0.items = arg_1_0.bg:Find("items")
	arg_1_0.uilist = UIItemList.New(arg_1_0.items, arg_1_0.item)
	arg_1_0.btnDetail = arg_1_0.bg:Find("btn_detail")
	arg_1_0.txtDetail = arg_1_0.btnDetail:Find("detail")
	arg_1_0.btnStory = arg_1_0.bg:Find("btn_story")
	arg_1_0.taskWindow = AnniversaryNineHwahJahTaskWindow.New(arg_1_0._tf, arg_1_0.event)

	setActive(arg_1_0.item, false)

	arg_1_0.progressLabel = arg_1_0.bg:Find("total_progress/label_1")

	setText(arg_1_0.progressLabel, i18n("Outpost_20250904_Progress"))
	setText(arg_1_0.txtDetail, i18n("Outpost_20260514_Detail"))

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	arg_2_0:playStory()

	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	arg_3_0.nday = arg_3_0:getTaskIdx(arg_3_0.activity)

	arg_3_0:PlayStory()

	if arg_3_0.dayTF then
		setText(arg_3_0.dayTF, arg_3_0.nday)
		setText(arg_3_0.maxDayTF, "/" .. #arg_3_0.taskGroup)
	end

	arg_3_0.uilist:align(#arg_3_0.taskGroup[arg_3_0.nday])

	if arg_3_0.taskWindow:isShowing() then
		arg_3_0.taskWindow:ExecuteAction("Show", arg_3_0.activity)
	end

	return
end

function var_0_0.UpdateTask(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2:Find("item")
	local var_4_1 = arg_4_0.taskProxy:getTaskById(arg_4_0.taskGroup[arg_4_0.nday][arg_4_1 + 1]) or arg_4_0.taskProxy:getFinishTaskById(arg_4_0.taskGroup[arg_4_0.nday][arg_4_1 + 1])

	assert(var_4_1, "without this task by id: " .. arg_4_0.taskGroup[arg_4_0.nday][arg_4_1 + 1])
	updateDrop(var_4_0, (Drop.Create(var_4_1:getConfig("award_display")[1])))
	onButton(arg_4_0, var_4_0, function()
		arg_4_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_4_2 = var_4_1:getProgress()
	local var_4_3 = var_4_1:getConfig("target_num")
	local var_4_4 = var_4_1:getConfig("desc")

	if utf8.len(var_4_4) >= 11 then
		setScrollText(arg_4_2:Find("mask/description"), var_4_4)
	else
		setText(arg_4_2:Find("mask/description"), var_4_4)
	end

	local var_4_5, var_4_6 = arg_4_0:GetProgressColor()
	local var_4_7

	var_4_7 = var_4_5 and setColorStr(var_4_2, var_4_5) or var_4_2

	local var_4_8

	var_4_8 = var_4_6 and setColorStr("/" .. var_4_3, var_4_6) or "/" .. var_4_3

	setText(arg_4_2:Find("progressText"), var_4_7 .. var_4_8)
	setSlider(arg_4_2:Find("progress"), 0, var_4_3, var_4_2)

	local var_4_9 = arg_4_2:Find("go_btn")
	local var_4_10 = arg_4_2:Find("get_btn")
	local var_4_11 = arg_4_2:Find("got_btn")
	local var_4_12 = var_4_1:getTaskStatus()

	setActive(var_4_9, var_4_12 == 0)
	setActive(var_4_10, var_4_12 == 1)
	setActive(var_4_11, var_4_12 == 2)
	onButton(arg_4_0, var_4_9, function()
		arg_4_0:emit(ActivityMediator.ON_TASK_GO, var_4_1)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, var_4_10, function()
		local var_7_0 = var_4_1:getConfig("award_display")
		local var_7_1 = getProxy(PlayerProxy):getRawData()
		local var_7_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
		local var_7_3, var_7_4 = Task.StaticJudgeOverflow(var_7_1.gold, var_7_1.oil, var_7_2, true, true, var_7_0)

		if var_7_3 then
			table.insert({}, function(arg_8_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_7_4,
					onYes = arg_8_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			arg_4_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_4_1)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.playStory(arg_10_0)
	arg_10_0.storyList = arg_10_0.activity:getConfig("config_client").story

	if not pg.NewStoryMgr.GetInstance():IsPlayed(arg_10_0.storyList[1][1]) then
		local var_10_0, var_10_1 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_10_0.storyList[1][1])

		pg.m02:sendNotification(GAME.STORY_UPDATE_LIST, {
			storyIds = {
				var_10_0
			}
		})
	end

	return
end

return var_0_0
