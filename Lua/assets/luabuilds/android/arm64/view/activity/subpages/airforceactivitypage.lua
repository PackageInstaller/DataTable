local var_0_0 = class("AirForceActivityPage", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.btnBattle = arg_1_0.bg:Find("battle_btn")
	arg_1_0.iconAward = arg_1_0.bg:Find("award")
	arg_1_0.iconGot = arg_1_0.bg:Find("got_btn")
	arg_1_0.textStep = arg_1_0.bg:Find("step")
	arg_1_0.textCount = arg_1_0.bg:Find("count")
	arg_1_0.items = arg_1_0.bg:Find("items")
	arg_1_0.blur = arg_1_0._tf:Find("Blur")
	arg_1_0.window = arg_1_0.blur:Find("window")
	arg_1_0.textTitle = arg_1_0.window:Find("title")
	arg_1_0.textContent = arg_1_0.window:Find("content")

	setActive(arg_1_0.blur, false)

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.linkActivity = getProxy(ActivityProxy):getActivityById(arg_2_0.activity:getConfig("config_client").linkActID)
	arg_2_0.taskIds = arg_2_0.linkActivity:getConfig("config_data")

	local var_2_0 = _.map(arg_2_0.taskIds, function(arg_3_0)
		local var_3_0 = getProxy(TaskProxy):getTaskVO(arg_3_0)

		var_3_0 = var_3_0 or Task.New({
			id = arg_3_0
		})

		return var_3_0
	end)

	arg_2_0.summaryTask = _.detect(var_2_0, function(arg_4_0)
		return arg_4_0:getConfig("sub_type") == 90
	end)
	arg_2_0.subTasks = _.select(var_2_0, function(arg_5_0)
		return arg_5_0:getConfig("sub_type") ~= 90
	end)

	return
end

function var_0_0.TrySubmitTask(arg_6_0)
	if not arg_6_0.summaryTask then
		return
	end

	if arg_6_0.summaryTask:isFinish() and not arg_6_0.summaryTask:isReceive() then
		pg.m02:sendNotification(GAME.SUBMIT_TASK, arg_6_0.summaryTask.id)

		return true
	end

	return
end

function var_0_0.OnFirstFlush(arg_7_0)
	onButton(arg_7_0, arg_7_0.btnBattle, function()
		arg_7_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.AIRFORCE_DRAGONEMPERY)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.blur, function()
		arg_7_0:CloseWindow()
		arg_7_0:TrySubmitTask()

		return
	end)

	for iter_7_0 = 1, #arg_7_0.subTasks do
		onButton(arg_7_0, arg_7_0.items:GetChild(iter_7_0 - 1), function()
			if not arg_7_0.subTasks[iter_7_0]:isReceive() then
				pg.m02:sendNotification(GAME.SUBMIT_TASK, arg_7_0.subTasks[iter_7_0].id)
			end

			setText(arg_7_0.textTitle, i18n("airforce_title_" .. iter_7_0))
			setText(arg_7_0.textContent, i18n("airforce_desc_" .. iter_7_0))
			pg.UIMgr.GetInstance():OverlayPanel(arg_7_0.blur, {
				pbList = {
					arg_7_0.blur
				}
			})
			setActive(arg_7_0.blur, true)

			return
		end, SFX_PANEL)
	end

	local var_7_0 = arg_7_0.summaryTask:getConfig("award_display")[1]

	updateDrop(arg_7_0.iconAward, (Drop.New({
		type = var_7_0[1],
		id = var_7_0[2],
		count = var_7_0[3]
	})))
	onButton(arg_7_0, arg_7_0.iconAward, function()
		arg_7_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)
	arg_7_0:TrySubmitTask()

	return
end

function var_0_0.OnUpdateFlush(arg_12_0)
	local var_12_0 = 0

	for iter_12_0 = 1, #arg_12_0.subTasks do
		local var_12_1 = arg_12_0.subTasks[iter_12_0]:isReceive()
		local var_12_2 = arg_12_0.items:GetChild(iter_12_0 - 1)

		setActive(var_12_2:Find("viewed"), var_12_1)

		if var_12_1 then
			var_12_0 = var_12_0 + 1
		end
	end

	setText(arg_12_0.textStep, var_12_0 .. "/" .. #arg_12_0.subTasks)
	setText(arg_12_0.textCount, arg_12_0:GetFightCount())
	setActive(arg_12_0.iconGot, arg_12_0.summaryTask:isReceive())
	setActive(arg_12_0.btnBattle:Find("tip"), arg_12_0.activity:readyToAchieve())

	return
end

function var_0_0.GetFightCount(arg_13_0)
	local var_13_0 = 0

	for iter_13_0 = 1, arg_13_0.activity:GetLevelCount() do
		local var_13_1 = arg_13_0.activity:getKVPList(1, iter_13_0) or 0

		var_13_0 = var_13_0 + var_13_1
	end

	local var_13_2 = pg.TimeMgr.GetInstance()

	return math.min((var_13_2:DiffDay(arg_13_0.activity.data1, var_13_2:GetServerTime()) + 1) * arg_13_0.activity:GetPerDayCount(), (arg_13_0.activity:GetMaxProgress())) - var_13_0
end

function var_0_0.CloseWindow(arg_14_0)
	setActive(arg_14_0.blur, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_14_0.blur, arg_14_0._tf)

	return
end

function var_0_0.ShowOrHide(arg_15_0, arg_15_1)
	if not arg_15_1 and isActive(arg_15_0.blur) then
		arg_15_0:CloseWindow()
	end

	var_0_0.super.ShowOrHide(arg_15_0, arg_15_1)

	return
end

function var_0_0.OnDestroy(arg_16_0)
	if isActive(arg_16_0.blur) then
		arg_16_0:CloseWindow()
	end

	var_0_0.super.OnDestroy(arg_16_0)

	return
end

return var_0_0
