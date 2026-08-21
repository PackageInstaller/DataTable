local var_0_0 = class("NieRAutomataOmenPage", import("view.activity.CorePage.CoreLoginTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("bg")
	arg_1_0.introduction = arg_1_0.bg:Find("Introduction")
	arg_1_0.desc1 = arg_1_0.introduction:Find("desc1")
	arg_1_0.desc2 = arg_1_0.introduction:Find("desc2")
	arg_1_0.total = arg_1_0.bg:Find("total_progress")
	arg_1_0.dayTF = arg_1_0.total:Find("day")
	arg_1_0.maxDayTF = arg_1_0.total:Find("max_day")
	arg_1_0.btnDetail = arg_1_0.total:Find("btn_detail")
	arg_1_0.btnDetailText = arg_1_0.btnDetail:Find("detail")
	arg_1_0.item = arg_1_0.bg:Find("item")
	arg_1_0.items = arg_1_0.bg:Find("items")
	arg_1_0.uilist = UIItemList.New(arg_1_0.items, arg_1_0.item)
	arg_1_0.taskWindow = NieRAutomataOmenTaskWindow.New(arg_1_0._tf, arg_1_0.event)
	arg_1_0.finishAll = false

	setActive(arg_1_0.item, false)

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.taskProxy = getProxy(TaskProxy)
	arg_2_0.taskGroup = arg_2_0.activity:getConfig("config_client").unlock_task

	return updateActivityTaskStatus(arg_2_0.activity)
end

function var_0_0.OnFirstFlush(arg_3_0)
	var_0_0.super.OnFirstFlush(arg_3_0)
	setActive(arg_3_0.maxTF, #arg_3_0.taskGroup)
	setText(arg_3_0.btnDetailText, i18n("nier_a2_mission_detail"))
	onButton(arg_3_0, arg_3_0.btnDetail, function()
		arg_3_0.taskWindow:ExecuteAction("Show", arg_3_0.activity)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShowFlush(arg_5_0)
	var_0_0.super.OnShowFlush(arg_5_0)

	return
end

function var_0_0.GetTypewriterSpeed(arg_6_0)
	local var_6_0 = arg_6_0.activity:getConfig("config_client").typewriterSpeed

	return var_6_0 and var_6_0 or 0.1
end

function var_0_0.InvalidateWriter(arg_7_0)
	local var_7_0 = arg_7_0.writerToken or 0

	arg_7_0.writerToken = var_7_0 + 1

	if arg_7_0.desc1 then
		GetOrAddComponent(arg_7_0.desc1, typeof(Typewriter)).endFunc = nil
	end

	if arg_7_0.desc2 then
		GetOrAddComponent(arg_7_0.desc2, typeof(Typewriter)).endFunc = nil
	end

	return
end

function var_0_0.Playwriter(arg_8_0)
	arg_8_0:InvalidateWriter()

	local var_8_0 = arg_8_0.writerToken

	local function var_8_1()
		local var_9_0 = arg_8_0.writerToken == var_8_0 and arg_8_0._go and isActive(arg_8_0._go) or false

		if false then
			var_9_0 = true
		end

		return var_9_0
	end

	local var_8_2 = {}

	if not arg_8_0.finishAll then
		table.insert(var_8_2, function(arg_10_0)
			if not var_8_1() then
				return
			end

			local var_10_0 = GetOrAddComponent(arg_8_0.desc1, typeof(Typewriter))

			function var_10_0.endFunc()
				if not var_8_1() then
					return
				end

				arg_10_0()

				return
			end

			var_10_0:setSpeed(arg_8_0:GetTypewriterSpeed())
			var_10_0:Play()

			return
		end)
	else
		table.insert(var_8_2, function(arg_12_0)
			if not var_8_1() then
				return
			end

			local var_12_0 = checkExist(arg_8_0.activity:getConfig("config_client").story, {
				arg_8_0.nday
			}, {
				1
			})

			if var_12_0 then
				if not pg.NewStoryMgr.GetInstance():IsPlayed(var_12_0) then
					pg.NewStoryMgr.GetInstance():Play(var_12_0, function()
						if not var_8_1() then
							return
						end

						arg_12_0()

						return
					end)

					goto label_12_0
				end
			end

			arg_12_0()

			::label_12_0::

			return
		end)
	end

	table.insert(var_8_2, function(arg_14_0)
		if not var_8_1() then
			return
		end

		local var_14_0 = arg_8_0.desc2

		setActive(arg_8_0.desc2, true)

		local var_14_1 = GetOrAddComponent(var_14_0, typeof(Typewriter))

		function var_14_1.endFunc()
			if not var_8_1() then
				return
			end

			arg_14_0()

			return
		end

		var_14_1:setSpeed(arg_8_0:GetTypewriterSpeed())
		var_14_1:Play()

		return
	end)
	seriesAsync(var_8_2)

	return
end

function var_0_0.LocalFresh(arg_16_0, arg_16_1)
	local var_16_0

	arg_16_0.finishAll = arg_16_1 >= 7 and arg_16_0:lastFinish()

	if arg_16_0.finishAll then
		var_16_0 = i18n("nier_a2_text_block_day" .. "_fin")

		setActive(arg_16_0.desc1, false)
	else
		var_16_0 = i18n("nier_a2_text_block_day" .. arg_16_1)

		setText(arg_16_0.desc1, var_16_0[1].info)
	end

	setText(arg_16_0.desc2, var_16_0[2].info)
	setActive(arg_16_0.desc2, false)
	arg_16_0:Playwriter()

	return
end

function var_0_0.lastFinish(arg_17_0)
	local var_17_0 = getProxy(TaskProxy):getTaskVO(arg_17_0.taskGroup[#arg_17_0.taskGroup][1])
	local var_17_1 = getProxy(TaskProxy):getTaskVO(arg_17_0.taskGroup[#arg_17_0.taskGroup][2])

	return var_17_0:getTaskStatus() == 2 and var_17_1:getTaskStatus() == 2
end

function var_0_0.UpdateTask(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2:Find("item")
	local var_18_1 = arg_18_0.taskProxy:getTaskById(arg_18_0.taskGroup[arg_18_0.nday][arg_18_1 + 1]) or arg_18_0.taskProxy:getFinishTaskById(arg_18_0.taskGroup[arg_18_0.nday][arg_18_1 + 1])

	assert(var_18_1, "without this task by id: " .. arg_18_0.taskGroup[arg_18_0.nday][arg_18_1 + 1])
	updateDrop(var_18_0, (Drop.Create(var_18_1:getConfig("award_display")[1])))
	onButton(arg_18_0, var_18_0, function()
		arg_18_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_18_2 = var_18_1:getProgress()
	local var_18_3 = var_18_1:getConfig("target_num")
	local var_18_4 = var_18_1:getConfig("desc")

	if utf8.len(var_18_4) >= 11 then
		setScrollText(arg_18_2:Find("mask/description"), var_18_4)
	else
		setText(arg_18_2:Find("mask/description"), var_18_4)
	end

	local var_18_5, var_18_6 = arg_18_0:GetProgressColor()
	local var_18_7

	var_18_7 = var_18_5 and setColorStr(var_18_2, var_18_5) or var_18_2

	local var_18_8

	var_18_8 = var_18_6 and setColorStr("/" .. var_18_3, var_18_6) or "/" .. var_18_3

	setText(arg_18_2:Find("progressText"), var_18_7 .. var_18_8)
	setSlider(arg_18_2:Find("progress"), 0, var_18_3, var_18_2)

	local var_18_9 = arg_18_2:Find("go_btn")
	local var_18_10 = arg_18_2:Find("get_btn")
	local var_18_11 = arg_18_2:Find("got_btn")
	local var_18_12 = var_18_1:getTaskStatus()

	setActive(var_18_9, var_18_12 == 0)
	setActive(var_18_10, var_18_12 == 1)
	setActive(var_18_11, var_18_12 == 2)
	onButton(arg_18_0, var_18_9, function()
		arg_18_0:emit(ActivityMediator.ON_TASK_GO, var_18_1)

		return
	end, SFX_PANEL)
	onButton(arg_18_0, var_18_10, function()
		local var_21_0 = var_18_1:getConfig("award_display")
		local var_21_1 = getProxy(PlayerProxy):getRawData()
		local var_21_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
		local var_21_3, var_21_4 = Task.StaticJudgeOverflow(var_21_1.gold, var_21_1.oil, var_21_2, true, true, var_21_0)

		if var_21_3 then
			table.insert({}, function(arg_22_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_21_4,
					onYes = arg_22_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			arg_18_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_18_1)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_24_0)
	arg_24_0.nday = arg_24_0:getTaskIdx(arg_24_0.activity)

	if arg_24_0.dayTF then
		setText(arg_24_0.dayTF, arg_24_0.nday)
		setText(arg_24_0.maxDayTF, "/" .. #arg_24_0.taskGroup)
	end

	arg_24_0:LocalFresh(arg_24_0.nday)
	arg_24_0.uilist:align(#arg_24_0.taskGroup[arg_24_0.nday])

	if arg_24_0.taskWindow:isShowing() then
		arg_24_0.taskWindow:ExecuteAction("Show", arg_24_0.activity)
	end

	return
end

function var_0_0.getTaskIdx(arg_25_0, arg_25_1)
	local var_25_0 = 1
	local var_25_1 = math.min(arg_25_1:getNDay(), #arg_25_0.taskGroup)

	for iter_25_0 = 1, var_25_1 do
		if not true then
			break
		end

		var_25_0 = iter_25_0

		if iter_25_0 < var_25_1 then
			for iter_25_1, iter_25_2 in ipairs(arg_25_0.taskGroup[iter_25_0]) do
				local var_25_2

				if not arg_25_0:isTaskFinished(iter_25_2) then
					var_25_2 = false

					break
				end
			end
		end
	end

	return math.min(var_25_0, #arg_25_0.taskGroup)
end

function var_0_0.isTaskFinished(arg_26_0, arg_26_1)
	arg_26_0.taskProxy = arg_26_0.taskProxy or getProxy(TaskProxy)

	local var_26_0 = arg_26_0.taskProxy:getTaskById(arg_26_1) or arg_26_0.taskProxy:getFinishTaskById(arg_26_1)

	return var_26_0 and var_26_0:getTaskStatus() == 2
end

function var_0_0.GetProgressColor(arg_27_0)
	return "#ffbc46", "#52514a"
end

function var_0_0.OnHideFlush(arg_28_0)
	arg_28_0:InvalidateWriter()

	if arg_28_0.taskWindow:isShowing() then
		arg_28_0.taskWindow:Hide()
	end

	return
end

function var_0_0.OnDestroy(arg_29_0)
	arg_29_0:InvalidateWriter()

	if arg_29_0.taskWindow then
		arg_29_0.taskWindow:Hide()
		arg_29_0.taskWindow:Destroy()

		arg_29_0.taskWindow = nil
	end

	return
end

return var_0_0
