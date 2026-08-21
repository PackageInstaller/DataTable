local var_0_0 = class("YidaliMainPage", import(".TemplatePage.PreviewTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)
	arg_1_0:initUI()

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)

	arg_2_0.fight = arg_2_0.btnList:Find("fight")

	onButton(arg_2_0, arg_2_0.fight, function()
		arg_2_0:emit(ActivityMediator.BATTLE_OPERA)

		return
	end, SFX_PANEL)

	arg_2_0.build = arg_2_0.btnList:Find("build")

	onButton(arg_2_0, arg_2_0.build, function()
		local var_4_0
		local var_4_1

		if arg_2_0.activity:getConfig("config_client") ~= "" then
			var_4_0 = arg_2_0.activity:getConfig("config_client").linkActID

			if var_4_0 then
				var_4_1 = getProxy(ActivityProxy):getActivityById(var_4_0)
			end
		end

		if not var_4_0 then
			arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
				projectName = BuildShipScene.PROJECTS.ACTIVITY
			})
		elseif var_4_1 and not var_4_1:isEnd() then
			arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
				projectName = BuildShipScene.PROJECTS.ACTIVITY
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))
		end

		return
	end, SFX_PANEL)
	arg_2_0:initData()
	arg_2_0:submitFinishedTask()

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	arg_5_0:updateAwardBtn()

	return
end

function var_0_0.initData(arg_6_0)
	arg_6_0.finalTaskID = arg_6_0.activity:getConfig("config_client")[1]
	arg_6_0.YDLtaskIDList = arg_6_0.activity:getConfig("config_data")
	arg_6_0.taskIDList = Clone(pg.task_data_template[arg_6_0.finalTaskID].target_id)
	arg_6_0.taskProxy = getProxy(TaskProxy)

	return
end

function var_0_0.initUI(arg_7_0)
	arg_7_0.awardTF = arg_7_0.bg:Find("Item")
	arg_7_0.activeTF = arg_7_0.awardTF:Find("Active")
	arg_7_0.finishedTF = arg_7_0.awardTF:Find("Finished")
	arg_7_0.achievedTF = arg_7_0.awardTF:Find("Achieved")

	setActive(arg_7_0.activeTF, false)
	setActive(arg_7_0.finishedTF, false)
	setActive(arg_7_0.achievedTF, false)

	arg_7_0.achievementBtn = arg_7_0.bg:Find("AchieveMentBtn")
	arg_7_0.subViewContainer = arg_7_0._tf:Find("SubViewContainer")

	return
end

function var_0_0.updateAwardBtn(arg_8_0)
	local var_8_0 = arg_8_0:getFinalTaskStatus()

	print("final taskid:" .. arg_8_0.finalTaskID)
	print("task status:" .. var_8_0)

	if var_8_0 == 0 then
		setActive(arg_8_0.activeTF, true)
		setActive(arg_8_0.finishedTF, false)
		setActive(arg_8_0.achievedTF, false)
	elseif var_8_0 == 1 then
		setActive(arg_8_0.activeTF, false)
		setActive(arg_8_0.finishedTF, true)
		setActive(arg_8_0.achievedTF, false)
		onButton(arg_8_0, arg_8_0.awardTF, function()
			arg_8_0:emit(ActivityMediator.ON_TASK_SUBMIT, (arg_8_0.taskProxy:getTaskVO(arg_8_0.finalTaskID)))

			return
		end, SFX_PANEL)
	elseif var_8_0 == 2 then
		setActive(arg_8_0.activeTF, false)
		setActive(arg_8_0.finishedTF, false)
		setActive(arg_8_0.achievedTF, true)
		onButton(arg_8_0, arg_8_0.awardTF, function()
			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.submitFinishedTask(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.YDLtaskIDList) do
		local var_11_0 = arg_11_0.taskProxy:getTaskById(iter_11_1)

		if var_11_0 and var_11_0:isFinish() and not var_11_0:isReceive() then
			print("!!!!!!!!!!!!!20190907!!!!!!!YDLtaskIDList emit:" .. iter_11_1)
			arg_11_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_11_0)
		end
	end

	return
end

function var_0_0.getFinalTaskStatus(arg_12_0)
	return arg_12_0.taskProxy:getTaskVO(arg_12_0.finalTaskID):getTaskStatus()
end

return var_0_0
