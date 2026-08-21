local var_0_0 = class("DreamSignPage", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.lockNamed = PLATFORM_CODE == PLATFORM_CH and LOCK_NAMED
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.signTF = arg_1_0.bg:Find("sign")
	arg_1_0.items = arg_1_0.signTF:Find("items")
	arg_1_0.uilist = UIItemList.New(arg_1_0.items, arg_1_0.items:Find("tpl"))
	arg_1_0.signBtn = arg_1_0.signTF:Find("get")
	arg_1_0.goBtn = arg_1_0.signTF:Find("go")
	arg_1_0.lock = arg_1_0.signTF:Find("lock")
	arg_1_0.countText = arg_1_0.signBtn:Find("count")
	arg_1_0.signRed = arg_1_0.signBtn:Find("tip")
	arg_1_0.dreamRed = arg_1_0.goBtn:Find("tip")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.nday = 0
	arg_2_0.taskProxy = getProxy(TaskProxy)
	arg_2_0.taskGroup = underscore.flatten(arg_2_0.activity:getConfig("config_data"))
	arg_2_0.taskConfig = pg.task_data_template

	return updateActivityTaskStatus(arg_2_0.activity)
end

function var_0_0.OnFirstFlush(arg_3_0)
	arg_3_0.uilist:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventInit then
			updateDrop(arg_4_2:Find("item_mask/item"), (Drop.Create(arg_3_0.taskConfig[arg_3_0.taskGroup[arg_4_1 + 1]].award_display[1])))
			onButton(arg_3_0, arg_4_2, function()
				arg_3_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		elseif arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = arg_3_0.taskProxy:getTaskById(arg_3_0.taskGroup[arg_4_1 + 1]) or arg_3_0.taskProxy:getFinishTaskById(arg_3_0.taskGroup[arg_4_1 + 1])

			setActive(arg_4_2:Find("got"), arg_4_1 + 1 < arg_3_0.nday or var_4_0 and var_4_0:getTaskStatus() == 2)
		end

		return
	end)
	onButton(arg_3_0, arg_3_0.signBtn, function()
		if not arg_3_0.remainCnt or arg_3_0.remainCnt <= 0 then
			return
		end

		seriesAsync({
			function(arg_7_0)
				local var_7_0 = arg_3_0.activity:getConfig("config_client").story

				if checkExist(var_7_0, {
					arg_3_0.nday
				}, {
					1
				}) then
					pg.NewStoryMgr.GetInstance():Play(var_7_0[arg_3_0.nday][1], arg_7_0)
				else
					arg_7_0()
				end

				return
			end,
			function(arg_8_0)
				if arg_3_0.curTaskVO:getTaskStatus() == 1 then
					arg_3_0:emit(ActivityMediator.ON_TASK_SUBMIT, arg_3_0.curTaskVO, arg_8_0)
				else
					arg_8_0()
				end

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.goBtn, function()
		if arg_3_0:IsLock() then
			return
		end

		arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.DREAMLAND)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_10_0)
	arg_10_0.nday = arg_10_0.activity.data3
	arg_10_0.curTaskVO = arg_10_0.taskProxy:getTaskById(arg_10_0.taskGroup[arg_10_0.nday]) or arg_10_0.taskProxy:getFinishTaskById(arg_10_0.taskGroup[arg_10_0.nday])
	arg_10_0.remainCnt = math.min(arg_10_0.activity:getDayIndex(), #arg_10_0.taskGroup) - arg_10_0.nday

	if arg_10_0.curTaskVO:getTaskStatus() == 1 then
		arg_10_0.remainCnt = arg_10_0.remainCnt + 1
	end

	local var_10_0 = arg_10_0:IsFinishSign()

	setActive(arg_10_0.signBtn, not var_10_0)
	setActive(arg_10_0.goBtn, var_10_0)
	setActive(arg_10_0.lock, var_10_0 and arg_10_0:IsLock())
	setActive(arg_10_0.signRed, arg_10_0.remainCnt > 0)
	setActive(arg_10_0.dreamRed, DreamlandFullPreviewScene.DreamlandTip())
	setText(arg_10_0.countText, i18n("liner_sign_cnt_tip") .. arg_10_0.remainCnt)
	arg_10_0.uilist:align(#arg_10_0.taskGroup)

	return
end

function var_0_0.IsFinishSign(arg_11_0)
	local var_11_0 = arg_11_0.taskProxy:getTaskById(arg_11_0.taskGroup[#arg_11_0.taskGroup]) or arg_11_0.taskProxy:getFinishTaskById(arg_11_0.taskGroup[#arg_11_0.taskGroup])

	return var_11_0 and var_11_0:getTaskStatus() == 2
end

function var_0_0.IsLock(arg_12_0)
	local var_12_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.DREAMLAND_JP_ID)

	return not var_12_0 or var_12_0:isEnd()
end

return var_0_0
