local var_0_0 = class("DormSignTwoPage", import("view.base.BaseActivityPage"))

function var_0_0.getUIName(arg_1_0)
	return "DormSignTwoPage"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.bg = arg_2_0._tf:Find("AD")
	arg_2_0.items = arg_2_0.bg:Find("items")
	arg_2_0.uilist = UIItemList.New(arg_2_0.items, arg_2_0.items:Find("tpl"))
	arg_2_0.goBtn = arg_2_0.bg:Find("btn_go")
	arg_2_0.lockTF = arg_2_0.bg:Find("lock")

	return
end

function var_0_0.OnDataSetting(arg_3_0)
	arg_3_0.actTaskProxy = getProxy(ActivityTaskProxy)
	arg_3_0.taskGroup = underscore.flatten(arg_3_0.activity:getConfig("config_data"))
	arg_3_0.taskConfig = pg.task_data_template

	return
end

function var_0_0.UpdateTaskData(arg_4_0)
	arg_4_0.taskVOs = arg_4_0.actTaskProxy:getTaskById(arg_4_0.activity.id)
	arg_4_0.finishTaksVOs = arg_4_0.actTaskProxy:getFinishTaskById(arg_4_0.activity.id)
	arg_4_0.taskDic = {}

	_.each(arg_4_0.taskVOs, function(arg_5_0)
		arg_4_0.taskDic[arg_5_0.id] = arg_5_0

		return
	end)
	_.each(arg_4_0.finishTaksVOs, function(arg_6_0)
		arg_4_0.taskDic[arg_6_0.id] = arg_6_0

		return
	end)

	return
end

function var_0_0.OnFirstFlush(arg_7_0)
	arg_7_0.uilist:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventInit then
			local var_8_0 = Drop.Create(arg_7_0.taskConfig[arg_7_0.taskGroup[arg_8_1 + 1]].award_display[1])

			if arg_8_1 + 1 > 1 then
				updateDrop(arg_8_2:Find("item"), (Drop.Create(arg_7_0.taskConfig[arg_7_0.taskGroup[arg_8_1 + 1]].award_display[1])))
			end

			onButton(arg_7_0, arg_8_2, function()
				if arg_7_0.taskDic[var_0] and arg_7_0.taskDic[var_0]:getTaskStatus() == 1 and not arg_7_0.taskDic[var_0]:isOver() then
					arg_7_0:emit(ActivityMediator.ON_ACTIVITY_TASK_SUBMIT, {
						activityId = arg_7_0.activity.id,
						id = var_0
					})
				else
					arg_7_0:emit(BaseUI.ON_DROP, var_8_0)
				end

				return
			end, SFX_PANEL)
		elseif arg_8_0 == UIItemList.EventUpdate then
			setActive(arg_8_2:Find("got"), arg_7_0.taskDic[arg_7_0.taskGroup[arg_8_1 + 1]] and arg_7_0.taskDic[arg_7_0.taskGroup[arg_8_1 + 1]]:isOver())
			setActive(arg_8_2:Find("get_bg"), arg_7_0.taskDic[arg_7_0.taskGroup[arg_8_1 + 1]] and arg_7_0.taskDic[arg_7_0.taskGroup[arg_8_1 + 1]]:getTaskStatus() == 1 and not arg_7_0.taskDic[arg_7_0.taskGroup[arg_8_1 + 1]]:isOver())
		end

		return
	end)
	onButton(arg_7_0, arg_7_0.goBtn, function()
		arg_7_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.DORM3DSELECT)

		return
	end, SFX_PANEL)

	local var_7_0 = pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "SelectDorm3DMediator")

	setActive(arg_7_0.goBtn, var_7_0)
	setActive(arg_7_0.lockTF, not var_7_0)
	PlayerPrefs.SetString("DormSignTwoPage", var_0_0.GetDate())

	return
end

function var_0_0.OnUpdateFlush(arg_11_0)
	arg_11_0:UpdateTaskData()
	arg_11_0.uilist:align(#arg_11_0.taskGroup)

	return
end

function var_0_0.GetDate()
	return pg.TimeMgr.GetInstance():STimeDescC(pg.TimeMgr.GetInstance():GetServerTime(), "%Y/%m/%d")
end

function var_0_0.IsShowRed()
	return var_0_0.IsShowGoRed() or var_0_0.IsShowAwardRed()
end

function var_0_0.IsShowGoRed()
	return PlayerPrefs.GetString("DormSignTwoPage", "") ~= var_0_0.GetDate()
end

function var_0_0.IsShowAwardRed()
	return _.any(getProxy(ActivityTaskProxy):getTaskById(ActivityConst.DORM_SIGN_ID_2), function(arg_16_0)
		return arg_16_0:getTaskStatus() == 1
	end)
end

return var_0_0
