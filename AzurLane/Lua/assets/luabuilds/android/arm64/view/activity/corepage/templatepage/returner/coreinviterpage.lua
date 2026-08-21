local var_0_0 = class("CoreInviterPage")

var_0_0.REFRESH_TIME = 1800

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._event = arg_1_2
	arg_1_0._go = arg_1_1
	arg_1_0._tf = tf(arg_1_1)
	arg_1_0.ptTxt = arg_1_0._tf:Find("bg1/pt_panel/slider/Text"):GetComponent(typeof(Text))
	arg_1_0.phaseTotalTxt = arg_1_0._tf:Find("bg1/pt_panel/total_progress"):GetComponent(typeof(Text))
	arg_1_0.phaseTxt = arg_1_0._tf:Find("bg1/pt_panel/progress"):GetComponent(typeof(Text))
	arg_1_0.progress = arg_1_0._tf:Find("bg1/pt_panel/slider")
	arg_1_0.getBtn = arg_1_0._tf:Find("bg1/pt_panel/get")
	arg_1_0.awardTF = arg_1_0._tf:Find("bg1/pt_panel/item")
	arg_1_0.awardOverView = arg_1_0._tf:Find("bg1/pt_panel/award_overview")
	arg_1_0.bg = arg_1_0._tf:Find("bg"):GetComponent(typeof(Image))
	arg_1_0.returnerList = UIItemList.New(arg_1_0._tf:Find("bg1/returners/content"), arg_1_0._tf:Find("bg1/returners/content/tpl"))
	arg_1_0.help = arg_1_0._tf:Find("bg1/help")
	arg_1_0.pushBtn = arg_1_0._tf:Find("bg1/push_btn")
	arg_1_0.pushedBtn = arg_1_0._tf:Find("bg1/pushed_btn")
	arg_1_0.pushDisBtn = arg_1_0._tf:Find("bg1/push_btn_dis")
	arg_1_0.codeTxt = arg_1_0._tf:Find("bg1/code"):GetComponent(typeof(Text))
	arg_1_0.taskLockPanel = arg_1_0._tf:Find("bg1/task_lock_panel")

	setText(arg_1_0.taskLockPanel:Find("Text"), i18n("word_sell_lock"))

	arg_1_0.taskPanel = arg_1_0._tf:Find("bg1/task_panel")
	arg_1_0.taskItemTF = arg_1_0._tf:Find("bg1/task_panel/item")
	arg_1_0.taskProgress = arg_1_0._tf:Find("bg1/task_panel/progress")
	arg_1_0.taskDesc = arg_1_0._tf:Find("bg1/task_panel/desc")
	arg_1_0.taskGoBtn = arg_1_0._tf:Find("bg1/task_panel/go")
	arg_1_0.taskGotBtn = arg_1_0._tf:Find("bg1/task_panel/got")
	arg_1_0.taskGetBtn = arg_1_0._tf:Find("bg1/task_panel/get")
	arg_1_0.taskProgressTxt = arg_1_0._tf:Find("bg1/task_panel/p"):GetComponent(typeof(Text))

	setText(arg_1_0._tf:Find("bg1/pt_panel/title"), i18n("activity_return_reward_pt"))
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	onButton(arg_2_0, arg_2_0.getBtn, function()
		arg_2_0._event:emit(ActivityMediator.RETURN_AWARD_OP, {
			activity_id = arg_2_0.activity.id,
			cmd = ActivityConst.RETURN_AWARD_OP_GET_AWARD,
			arg1 = arg_2_0.nextTarget
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.awardOverView, function()
		arg_2_0._event:emit(ActivityMediator.RETURN_AWARD_OP, {
			cmd = ActivityConst.RETURN_AWARD_OP_SHOW_AWARD_OVERVIEW,
			arg1 = {
				blur = true,
				dropList = arg_2_0.config.drop_client,
				targets = arg_2_0.config.target,
				fetchList = arg_2_0.fetchList,
				count = arg_2_0.pt,
				resId = arg_2_0.config.pt
			}
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.pushBtn, function()
		if arg_2_0.isPush then
			return
		end

		if not arg_2_0.returners or #arg_2_0.returners >= 3 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("returner_max_count"))

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("returner_push_tip"),
			onYes = function()
				arg_2_0._event:emit(ActivityMediator.RETURN_AWARD_OP, {
					activity_id = arg_2_0.activity.id,
					cmd = ActivityConst.RETURN_AWARD_OP_PUSH_UID,
					arg1 = arg_2_0.code
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

	local var_7_0 = pg.TimeMgr.GetInstance():GetServerTime()

	if not ActivityMainScene.FetchReturnersTime or var_7_0 >= ActivityMainScene.FetchReturnersTime then
		ActivityMainScene.FetchReturnersTime = var_7_0 + var_0_0.REFRESH_TIME

		arg_7_0._event:emit(ActivityMediator.RETURN_AWARD_OP, {
			activity_id = arg_7_0.activity.id,
			cmd = ActivityConst.RETURN_AWARD_OP_GET_RETRUNERS
		})

		return
	end

	arg_7_0:UpdateData()
	arg_7_0:UpdateUI()
	arg_7_0:UpdateReturners()

	return
end

function var_0_0.getTotalPt(arg_8_0, arg_8_1)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.returners) do
		var_8_0 = var_8_0 + iter_8_1:getPt()
	end

	return var_8_0 + arg_8_1
end

function var_0_0.UpdateData(arg_9_0)
	arg_9_0.isPush = arg_9_0.activity.data2_list[1] == 1
	arg_9_0.code = getProxy(PlayerProxy):getRawData().id
	arg_9_0.fetchList = arg_9_0.activity.data1_list
	arg_9_0.config = pg.activity_template_headhunting[arg_9_0.activity.id]
	arg_9_0.targets = arg_9_0.config.target
	arg_9_0.nextIndex = -1

	for iter_9_0 = 1, #arg_9_0.targets do
		if not table.contains(arg_9_0.fetchList, arg_9_0.targets[iter_9_0]) then
			arg_9_0.nextIndex = iter_9_0

			break
		end
	end

	if arg_9_0.nextIndex == -1 then
		arg_9_0.fetchIndex = #arg_9_0.targets
		arg_9_0.nextIndex = #arg_9_0.targets
	else
		arg_9_0.fetchIndex = math.max(arg_9_0.nextIndex - 1, 0)
	end

	arg_9_0.drops = arg_9_0.config.drop_client
	arg_9_0.nextDrops = arg_9_0.config.drop_client[arg_9_0.nextIndex]
	arg_9_0.nextTarget = arg_9_0.targets[arg_9_0.nextIndex]
	arg_9_0.returners = arg_9_0.activity:getClientList()
	arg_9_0.pt = arg_9_0:getTotalPt(arg_9_0.activity.data3)

	setActive(arg_9_0.pushBtn, not arg_9_0.isPush and #arg_9_0.returners < 3)
	setActive(arg_9_0.pushedBtn, arg_9_0.isPush)
	setActive(arg_9_0.pushDisBtn, not arg_9_0.isPush and #arg_9_0.returners >= 3)

	return
end

function var_0_0.UpdateUI(arg_10_0)
	arg_10_0.codeTxt.text = arg_10_0.code
	arg_10_0.ptTxt.text = arg_10_0.pt .. "/" .. arg_10_0.nextTarget

	setActive(arg_10_0.getBtn, arg_10_0.fetchIndex ~= #arg_10_0.targets and arg_10_0.pt >= arg_10_0.nextTarget)

	arg_10_0.phaseTxt.text = arg_10_0.fetchIndex
	arg_10_0.phaseTotalTxt.text = #arg_10_0.targets

	setFillAmount(arg_10_0.progress, arg_10_0.pt / arg_10_0.nextTarget)
	updateDrop(arg_10_0.awardTF, {
		type = arg_10_0.nextDrops[1],
		id = arg_10_0.nextDrops[2],
		count = arg_10_0.nextDrops[3]
	})
	onButton(arg_10_0, arg_10_0.awardTF, function()
		arg_10_0._event:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	arg_10_0:UpdateTasks(pg.activity_template_headhunting[arg_10_0.activity.id].tasklist)

	return
end

function var_0_0.getTask(arg_12_0, arg_12_1)
	local var_12_0 = getProxy(TaskProxy)

	return var_12_0:getTaskById(arg_12_1) or var_12_0:getFinishTaskById(arg_12_1)
end

function var_0_0.UpdateTasks(arg_13_0, arg_13_1)
	if arg_13_0.isPush then
		local var_13_0 = getProxy(TaskProxy)
		local var_13_1 = 0

		for iter_13_0 = #arg_13_1, 1, -1 do
			if arg_13_0:getTask(arg_13_1[iter_13_0]) then
				var_13_1 = iter_13_0

				break
			end
		end

		local var_13_2 = arg_13_0:getTask(arg_13_1[var_13_1])

		if (not var_13_2 or var_13_2:isReceive()) and var_13_1 < arg_13_0.activity:getDayIndex() then
			if var_13_1 == #arg_13_1 and var_13_2 and var_13_2:isReceive() then
				arg_13_0:UpdateTaskTF(var_13_2)
			else
				arg_13_0._event:emit(ActivityMediator.RETURN_AWARD_OP, {
					activity_id = arg_13_0.activity.id,
					cmd = ActivityConst.RETURN_AWARD_OP_ACCEPT_TASK
				})
			end
		else
			assert(var_13_2)
			arg_13_0:UpdateTaskTF(var_13_2)
		end
	else
		setActive(arg_13_0.taskPanel, false)
		setActive(arg_13_0.taskLockPanel, true)
	end

	return
end

function var_0_0.UpdateTaskTF(arg_14_0, arg_14_1)
	setActive(arg_14_0.taskLockPanel, false)
	setActive(arg_14_0.taskPanel, true)

	local var_14_0 = arg_14_1:isFinish()
	local var_14_1 = arg_14_1:isReceive()

	setActive(arg_14_0.taskGoBtn, arg_14_1 and not var_14_0)
	setActive(arg_14_0.taskGotBtn, arg_14_1 and var_14_1)
	setActive(arg_14_0.taskGetBtn, arg_14_1 and var_14_0 and not var_14_1)

	local var_14_2 = arg_14_1:getConfig("award_display")[1]

	updateDrop(arg_14_0.taskItemTF, {
		type = var_14_2[1],
		id = var_14_2[2],
		count = var_14_2[3]
	})
	onButton(arg_14_0, arg_14_0.taskItemTF, function()
		arg_14_0._event:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	setFillAmount(arg_14_0.taskProgress, arg_14_1:getProgress() / arg_14_1:getConfig("target_num"))
	setText(arg_14_0.taskDesc, arg_14_1:getConfig("desc"))

	arg_14_0.taskProgressTxt.text = arg_14_1:getProgress() .. "/" .. arg_14_1:getConfig("target_num")

	onButton(arg_14_0, arg_14_0.taskGoBtn, function()
		arg_14_0._event:emit(ActivityMediator.ON_TASK_GO, arg_14_1)

		return
	end, SFX_PANEL)
	onButton(arg_14_0, arg_14_0.taskGetBtn, function()
		arg_14_0._event:emit(ActivityMediator.ON_TASK_SUBMIT, arg_14_1)

		return
	end, SFX_PANEL)

	return
end

local function var_0_1(arg_18_0, arg_18_1)
	LoadSpriteAsync("qicon/" .. arg_18_1:getPainting(), function(arg_19_0)
		if not IsNil(arg_18_0) then
			arg_18_0:GetComponent(typeof(Image)).sprite = arg_19_0
		end

		return
	end)
	UIItemList.New(arg_18_0:Find("starts"), arg_18_0:Find("starts/tpl")):align(arg_18_1:getStar())

	return
end

function var_0_0.UpdateReturners(arg_20_0)
	local var_20_0 = arg_20_0.returners

	arg_20_0.returnerList:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			if var_20_0[arg_21_1 + 1] then
				var_0_1(arg_21_2:Find("info/icon"), (Ship.New({
					configId = var_20_0[arg_21_1 + 1]:getIcon()
				})))
				setText(arg_21_2:Find("info/name"), var_20_0[arg_21_1 + 1]:getName())
				setText(arg_21_2:Find("info/pt/Text"), var_20_0[arg_21_1 + 1]:getPt())
			end

			setActive(arg_21_2:Find("empty"), not var_20_0[arg_21_1 + 1])
			setActive(arg_21_2:Find("info"), var_20_0[arg_21_1 + 1])
		end

		return
	end)
	arg_20_0.returnerList:align(2)

	return
end

function var_0_0.Dispose(arg_22_0)
	pg.DelegateInfo.Dispose(arg_22_0)

	arg_22_0.bg.sprite = nil

	return
end

return var_0_0
