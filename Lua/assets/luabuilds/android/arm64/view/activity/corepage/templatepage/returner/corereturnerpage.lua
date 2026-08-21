local var_0_0 = class("CoreReturnerPage")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = tf(arg_1_1)
	arg_1_0._event = arg_1_2
	arg_1_0.bg = arg_1_0._tf:Find("bg"):GetComponent(typeof(Image))
	arg_1_0.input = arg_1_0._tf:Find("InputField")
	arg_1_0.inputPlaceholder = arg_1_0._tf:Find("InputField/Placeholder"):GetComponent(typeof(Text))
	arg_1_0.confirmBtn = arg_1_0._tf:Find("confim_btn")
	arg_1_0.taskUIlist = UIItemList.New(arg_1_0._tf:Find("task_list"), arg_1_0._tf:Find("task_list/tpl"))
	arg_1_0.totalProgress = arg_1_0._tf:Find("total_progress"):GetComponent(typeof(Text))
	arg_1_0.progress = arg_1_0._tf:Find("progress"):GetComponent(typeof(Text))
	arg_1_0.awrdOverviewBtn = arg_1_0._tf:Find("award_overview")
	arg_1_0.help = arg_1_0._tf:Find("help")
	arg_1_0.ptTxt = arg_1_0._tf:Find("pt"):GetComponent(typeof(Text))
	arg_1_0.matchBtn = arg_1_0._tf:Find("match_btn")
	arg_1_0.matchedBtn = arg_1_0._tf:Find("matched_btn")

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	onButton(arg_2_0, arg_2_0.confirmBtn, function()
		if arg_2_0.code ~= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("return_have_participated_in_act"))

			return
		end

		local var_3_0 = getInputText(arg_2_0.input)

		if not var_3_0 or var_3_0 == "" then
			return
		end

		if tonumber(var_3_0) > 2147483647 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_notExist"))

			return
		end

		arg_2_0._event:emit(ActivityMediator.RETURN_AWARD_OP, {
			activity_id = arg_2_0.activity.id,
			cmd = ActivityConst.RETURN_AWARD_OP_SET_RETRUNER,
			arg1 = tonumber(var_3_0)
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.awrdOverviewBtn, function()
		arg_2_0._event:emit(ActivityMediator.RETURN_AWARD_OP, {
			cmd = ActivityConst.RETURN_AWARD_OP_SHOW_RETURNER_AWARD_OVERVIEW,
			arg1 = {
				blur = true,
				tasklist = arg_2_0.config.task_list,
				ptId = pg.activity_template_headhunting[arg_2_0.activity.id].pt,
				totalPt = arg_2_0.pt,
				index = arg_2_0.taskIndex
			}
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.matchBtn, function()
		if arg_2_0.code ~= 0 then
			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("returner_match_tip"),
			onYes = function()
				arg_2_0._event:emit(ActivityMediator.RETURN_AWARD_OP, {
					activity_id = arg_2_0.activity.id,
					cmd = ActivityConst.RETURN_AWARD_OP_MATCH
				})

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Update(arg_7_0, arg_7_1)
	arg_7_0.activity = arg_7_1

	arg_7_0:UpdateData()

	if arg_7_0:ShouldAcceptTasks() then
		arg_7_0:AcceptTasks()
	else
		arg_7_0:UpdateTasks()
	end

	local var_7_0 = arg_7_0.code ~= 0

	if arg_7_0.code == 0 then
		arg_7_0.inputPlaceholder.text = i18n("input_returner_code")
	else
		arg_7_0.inputPlaceholder.text = arg_7_0.code

		setInputText(arg_7_0.input, "")
	end

	arg_7_0.input:GetComponent(typeof(InputField)).interactable = not var_7_0

	setActive(arg_7_0.matchBtn, not var_7_0)
	setActive(arg_7_0.matchedBtn, var_7_0)

	return
end

function var_0_0.ShouldAcceptTasks(arg_8_0)
	if arg_8_0.code == 0 then
		return false
	end

	local var_8_0, var_8_1, var_8_2

	if arg_8_0.taskIndex == 0 then
		do return true end

		var_8_0 = getProxy(TaskProxy)
		var_8_1 = _.all(arg_8_0.config.task_list[arg_8_0.taskIndex], function(arg_9_0)
			return var_8_0:getFinishTaskById(arg_9_0) ~= nil
		end)
		var_8_2 = _.all(arg_8_0.config.task_list[arg_8_0.taskIndex], function(arg_10_0)
			return var_8_0:getTaskById(arg_10_0) == nil and var_8_0:getFinishTaskById(arg_10_0) == nil
		end)
	end

	local var_8_3 = arg_8_0.taskIndex == #arg_8_0.config.task_list

	return var_8_2 or var_8_1 and not var_8_3 and var_8_4()
end

function var_0_0.AcceptTasks(arg_12_0)
	arg_12_0._event:emit(ActivityMediator.RETURN_AWARD_OP, {
		activity_id = arg_12_0.activity.id,
		cmd = ActivityConst.RETURN_AWARD_OP_RETURNER_GET_AWARD
	})

	return
end

function var_0_0.UpdateData(arg_13_0)
	arg_13_0.config = pg.activity_template_returnner[arg_13_0.activity.id]
	arg_13_0.code = arg_13_0.activity.data2
	arg_13_0.pt = arg_13_0.activity.data3
	arg_13_0.taskIndex = arg_13_0.activity.data4
	arg_13_0.ptTxt.text = arg_13_0.pt
	arg_13_0.day = pg.TimeMgr.GetInstance():DiffDay(arg_13_0.activity:getStartTime(), (pg.TimeMgr.GetInstance():GetServerTime())) + 1

	return
end

local function var_0_1(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2:getConfig("award_display")[1]

	updateDrop(arg_14_1:Find("item"), {
		type = var_14_0[1],
		id = var_14_0[2],
		count = var_14_0[3]
	})
	onButton(arg_14_0, arg_14_1:Find("item"), function()
		arg_14_0._event:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	setText(arg_14_1:Find("desc"), arg_14_2:getConfig("desc"))
	setFillAmount(arg_14_1:Find("slider"), arg_14_2:getProgress() / arg_14_2:getConfig("target_num"))

	local var_14_1 = arg_14_1:Find("go")
	local var_14_2 = arg_14_1:Find("get")

	setActive(var_14_1, not arg_14_2:isFinish())

	local var_14_3 = arg_14_2:isFinish() and not arg_14_2:isReceive()

	setActive(var_14_2, var_14_3)
	setActive(arg_14_1:Find("got"), arg_14_2:isReceive())
	onButton(arg_14_0, var_14_1, function()
		arg_14_0._event:emit(ActivityMediator.ON_TASK_GO, arg_14_2)

		return
	end, SFX_PANEL)
	onButton(arg_14_0, var_14_2, function()
		arg_14_0._event:emit(ActivityMediator.ON_TASK_SUBMIT, arg_14_2)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateTasks(arg_18_0)
	local var_18_0 = arg_18_0.config.task_list[arg_18_0.taskIndex] or {}

	arg_18_0.taskUIlist:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = getProxy(TaskProxy)
			local var_19_1 = var_19_0:getTaskById(var_18_0[arg_19_1 + 1]) or var_19_0:getFinishTaskById(var_18_0[arg_19_1 + 1])

			assert(var_19_1)
			var_0_1(arg_18_0, arg_19_2, var_19_1)
		end

		return
	end)
	arg_18_0.taskUIlist:align(#var_18_0)

	arg_18_0.totalProgress.text = #arg_18_0.config.task_list
	arg_18_0.progress.text = arg_18_0.taskIndex

	return
end

function var_0_0.Dispose(arg_20_0)
	pg.DelegateInfo.Dispose(arg_20_0)

	arg_20_0.bg.sprite = nil

	return
end

return var_0_0
