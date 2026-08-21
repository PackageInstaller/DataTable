local var_0_0 = class("NewOrleansMapPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.item = arg_1_0.bg:Find("item")
	arg_1_0.itemMask = arg_1_0.item:Find("icon_mask")
	arg_1_0.gotaskBtn = arg_1_0.bg:Find("gotask")
	arg_1_0.gobattleBtn = arg_1_0.bg:Find("gobattle")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.taskIDList = _.flatten((arg_2_0.activity:getConfig("config_data")))
	arg_2_0.taskProxy = getProxy(TaskProxy)

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.gobattleBtn, function()
		local var_4_0 = getProxy(ActivityProxy):getActivityById(pg.activity_const.NEW_ORLEANS_Map_BATTLE.act_id)

		if not var_4_0 or var_4_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

			return
		end

		arg_3_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.gotaskBtn, function()
		local var_5_0 = getProxy(ActivityProxy):getActivityById(pg.activity_const.NEW_ORLEANS_Map_BATTLE.act_id)

		if not var_5_0 or var_5_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("challenge_end_tip"))

			return
		end

		arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
			page = "activity"
		})

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	local var_6_0 = arg_6_0.taskProxy:getTaskVO(arg_6_0.taskIDList[arg_6_0:findCurTaskIndex()])

	arg_6_0.curTaskVO = var_6_0

	local var_6_1 = var_6_0:getConfig("award_display")[1]

	updateDrop(arg_6_0.item, {
		type = var_6_1[1],
		id = var_6_1[2],
		count = var_6_1[3]
	})
	onButton(arg_6_0, arg_6_0.item, function()
		arg_6_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	setActive(arg_6_0.itemMask, var_6_0:getTaskStatus() == 2)

	return
end

function var_0_0.OnDestroy(arg_8_0)
	return
end

function var_0_0.findCurTaskIndex(arg_9_0)
	local var_9_0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.taskIDList) do
		local var_9_1 = arg_9_0.taskProxy:getTaskVO(iter_9_1)

		if var_9_1:getTaskStatus() <= 1 then
			var_9_0 = iter_9_0

			break
		elseif iter_9_0 == #arg_9_0.taskIDList then
			var_9_0 = iter_9_0
		end
	end

	return var_9_0
end

return var_0_0
