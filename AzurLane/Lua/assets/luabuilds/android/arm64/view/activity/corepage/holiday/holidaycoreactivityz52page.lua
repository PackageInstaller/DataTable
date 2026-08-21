local var_0_0 = class("HolidayCoreActivityZ52Page", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.progTF = arg_1_0._tf:Find("bg/prog")
	arg_1_0.btnLock = arg_1_0._tf:Find("bg/btnLock")
	arg_1_0.lock = arg_1_0.btnLock:Find("lock")
	arg_1_0.btnGo = arg_1_0._tf:Find("bg/btnGo")
	arg_1_0.btnSign = arg_1_0._tf:Find("bg/btnSign")
	arg_1_0.tipSign = arg_1_0.btnSign:Find("tip")
	arg_1_0.remainTimes = arg_1_0.btnSign:Find("remainTimes")
	arg_1_0.prog = {}

	for iter_1_0 = 1, arg_1_0.progTF.childCount do
		arg_1_0.prog[iter_1_0] = arg_1_0:createProg(arg_1_0.progTF:Find("prog_" .. iter_1_0))
	end

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.curDay = 0
	arg_2_0.taskProxy = getProxy(TaskProxy)
	arg_2_0.taskGroup = underscore.flatten(arg_2_0.activity:getConfig("config_data"))
	arg_2_0.preStory = arg_2_0.activity:getConfig("config_client").preStory

	return updateActivityTaskStatus(arg_2_0.activity)
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.btnSign, function()
		if not arg_3_0.enableSign then
			return
		end

		seriesAsync({
			function(arg_5_0)
				local var_5_0 = arg_3_0.activity:getConfig("config_client").story

				if checkExist(var_5_0, {
					arg_3_0.curDay
				}, {
					1
				}) then
					pg.NewStoryMgr.GetInstance():Play(var_5_0[arg_3_0.curDay][1], arg_5_0)
				else
					arg_5_0()
				end

				return
			end,
			function(arg_6_0)
				if arg_3_0.curTaskVO and arg_3_0.curTaskVO:getTaskStatus() == 1 then
					arg_3_0:emit(ActivityMediator.ON_TASK_SUBMIT, arg_3_0.curTaskVO, arg_6_0)
				else
					arg_6_0()
				end

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.btnGo, function()
		if arg_3_0:isTargetLocking() then
			return
		end

		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.MALL_MAP)

		return
	end, SFX_PANEL)
	setText(arg_3_0.lock, i18n("20260514_story_unlock_tip"))

	return
end

function var_0_0.OnUpdateFlush(arg_8_0)
	arg_8_0.curDay = arg_8_0.activity.data3
	arg_8_0.enableSign = false

	local var_8_0 = arg_8_0:isAllSigned()
	local var_8_1 = arg_8_0:isTargetLocking()

	setActive(arg_8_0.btnSign, not var_8_0)
	setActive(arg_8_0.btnLock, var_8_1 and var_8_0)
	setActive(arg_8_0.btnGo, not var_8_1 and var_8_0)

	if not var_8_0 then
		arg_8_0.curTaskVO = arg_8_0.taskProxy:getTaskById(arg_8_0.taskGroup[arg_8_0.curDay]) or arg_8_0.taskProxy:getFinishTaskById(arg_8_0.taskGroup[arg_8_0.curDay])
		arg_8_0.remain = math.max(math.min(arg_8_0.activity:getDayIndex(), #arg_8_0.taskGroup) - arg_8_0.curDay, 0)

		if arg_8_0.curTaskVO:getTaskStatus() == 1 then
			arg_8_0.remain = arg_8_0.remain + 1
		end

		arg_8_0.enableSign = arg_8_0.remain > 0

		setText(arg_8_0.remainTimes, arg_8_0.remain)
	end

	if arg_8_0.enableSign then
		local var_8_2 = arg_8_0.curDay - 1 or arg_8_0.curDay

		for iter_8_0 = 1, var_8_2 do
			local var_8_3 = arg_8_0.prog[iter_8_0]

			setActive(arg_8_0.prog[iter_8_0].signed, iter_8_0 <= var_8_2)
			setActive(var_8_3.current, iter_8_0 == var_8_2 and not var_8_0)
		end

		setActive(arg_8_0.tipSign, arg_8_0.enableSign)
		setGray(arg_8_0.btnSign, not arg_8_0.enableSign, true)

		return
	end
end

function var_0_0.createProg(arg_9_0, arg_9_1)
	local var_9_0 = {
		current = arg_9_1:Find("current"),
		signed = arg_9_1:Find("signed")
	}

	setActive(var_9_0.current, false)
	setActive(var_9_0.signed, false)

	return var_9_0
end

function var_0_0.getTargetID(arg_10_0)
	return 50619
end

function var_0_0.isTargetLocking(arg_11_0)
	local var_11_0 = getProxy(ActivityProxy):getActivityById(arg_11_0:getTargetID())

	return not var_11_0 or var_11_0:isEnd()
end

function var_0_0.isAllSigned(arg_12_0)
	local var_12_0 = arg_12_0.taskProxy:getTaskById(arg_12_0.taskGroup[#arg_12_0.taskGroup]) or arg_12_0.taskProxy:getFinishTaskById(arg_12_0.taskGroup[#arg_12_0.taskGroup])

	return var_12_0 and var_12_0:getTaskStatus() == 2
end

return var_0_0
