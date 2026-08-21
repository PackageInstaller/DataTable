local var_0_0 = class("HolidayVillaPage", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.signTF = arg_1_0.bg:Find("sign")
	arg_1_0.getBtn = arg_1_0.signTF:Find("get")
	arg_1_0.got = arg_1_0.signTF:Find("got")
	arg_1_0.getBtn_tip = arg_1_0.signTF:Find("get/tip")
	arg_1_0.countbg = arg_1_0.signTF:Find("count_bg")
	arg_1_0.countText = arg_1_0.signTF:Find("count_bg/count")
	arg_1_0.go = arg_1_0.signTF:Find("go_btn")
	arg_1_0.Notbtn = arg_1_0.signTF:Find("Not_unlocked")
	arg_1_0.list = {
		arg_1_0.signTF:Find("list/unfinished_1"),
		arg_1_0.signTF:Find("list/unfinished_2"),
		arg_1_0.signTF:Find("list/unfinished_3"),
		arg_1_0.signTF:Find("list/unfinished_4"),
		arg_1_0.signTF:Find("list/unfinished_5")
	}

	setActive(arg_1_0.go, false)
	setActive(arg_1_0.Notbtn, false)

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.nday = 0
	arg_2_0.taskProxy = getProxy(TaskProxy)
	arg_2_0.taskGroup = underscore.flatten(arg_2_0.activity:getConfig("config_data"))
	arg_2_0.preStory = arg_2_0.activity:getConfig("config_client").preStory

	return updateActivityTaskStatus(arg_2_0.activity)
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.getBtn, function()
		if not arg_3_0.remainCnt or arg_3_0.remainCnt <= 0 then
			return
		end

		seriesAsync({
			function(arg_5_0)
				local var_5_0 = arg_3_0.activity:getConfig("config_client").story

				if checkExist(var_5_0, {
					arg_3_0.nday
				}, {
					1
				}) then
					pg.NewStoryMgr.GetInstance():Play(var_5_0[arg_3_0.nday][1], arg_5_0)
				else
					arg_5_0()
				end

				return
			end,
			function(arg_6_0)
				if arg_3_0.curTaskVO:getTaskStatus() == 1 then
					arg_3_0:emit(ActivityMediator.ON_TASK_SUBMIT, arg_3_0.curTaskVO, arg_6_0)
				else
					arg_6_0()
				end

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.go, function()
		if arg_3_0:IsLockLiner() then
			return
		end

		arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.HOLIDAY_VILLA_MAP)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_8_0)
	arg_8_0.nday = arg_8_0.activity.data3

	local var_8_0 = arg_8_0:IsFinishSign()

	setActive(arg_8_0.got, false)
	setActive(arg_8_0.go, not arg_8_0:IsLockLiner() and var_8_0)
	setActive(arg_8_0.Notbtn, arg_8_0:IsLockLiner())

	if not var_8_0 then
		setActive(arg_8_0.Notbtn, false)

		arg_8_0.curTaskVO = arg_8_0.taskProxy:getTaskById(arg_8_0.taskGroup[arg_8_0.nday]) or arg_8_0.taskProxy:getFinishTaskById(arg_8_0.taskGroup[arg_8_0.nday])
		arg_8_0.remainCnt = math.min(arg_8_0.activity:getDayIndex(), #arg_8_0.taskGroup) - arg_8_0.nday

		if arg_8_0.curTaskVO:getTaskStatus() == 1 then
			arg_8_0.remainCnt = arg_8_0.remainCnt + 1
		end

		warning("self.remainCnt   :", arg_8_0.remainCnt)
		setActive(arg_8_0.getBtn_tip, arg_8_0.remainCnt > 0)
		setActive(arg_8_0.getBtn, arg_8_0.remainCnt > 0)
		setActive(arg_8_0.got, arg_8_0.remainCnt == 0)
		setActive(arg_8_0.countbg, true)
		setText(arg_8_0.countText, i18n("liner_sign_cnt_tip") .. arg_8_0.remainCnt)
	else
		setActive(arg_8_0.countbg, false)
		setActive(arg_8_0.getBtn, false)
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.list) do
		setActive(arg_8_0.list[iter_8_0]:Find("accomplish"), var_8_0 or iter_8_0 < arg_8_0.nday)
		setImageAlpha(iter_8_1, (var_8_0 or iter_8_0 < arg_8_0.nday) and 0 or 1)
		setActive(arg_8_0.list[iter_8_0]:Find("Check_point"), not var_8_0 and iter_8_0 == arg_8_0.nday)
	end

	return
end

function var_0_0.IsFinishSign(arg_9_0)
	local var_9_0 = arg_9_0.taskProxy:getTaskById(arg_9_0.taskGroup[#arg_9_0.taskGroup]) or arg_9_0.taskProxy:getFinishTaskById(arg_9_0.taskGroup[#arg_9_0.taskGroup])

	return var_9_0 and var_9_0:getTaskStatus() == 2
end

function var_0_0.IsLockLiner(arg_10_0)
	local var_10_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.HOLIDAY_ACT_ID)

	return not var_10_0 or var_10_0:isEnd()
end

return var_0_0
