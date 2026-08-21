local var_0_0 = class("SecretsAbyssSkinMagazinePage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.items = arg_1_0.bg:Find("page/items")
	arg_1_0.rtTask = arg_1_0.bg:Find("page/task")
	arg_1_0.countTF = arg_1_0.rtTask:Find("count")
	arg_1_0.rtAward = arg_1_0.rtTask:Find("IconTpl")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.taskProxy = getProxy(TaskProxy)
	arg_2_0.taskList = arg_2_0.activity:getConfig("config_data")
	arg_2_0.totalCnt = #arg_2_0.taskList

	return
end

local var_0_1 = 146
local var_0_2 = 540

function var_0_0.RefreshData(arg_3_0)
	local var_3_0 = pg.TimeMgr.GetInstance()

	arg_3_0.unlockCnt = (var_3_0:DiffDay(arg_3_0.activity:getStartTime(), var_3_0:GetServerTime()) + 1) * arg_3_0.activity:getConfig("config_id")
	arg_3_0.unlockCnt = math.min(arg_3_0.unlockCnt, arg_3_0.totalCnt)
	arg_3_0.remainCnt = arg_3_0.usedCnt >= arg_3_0.totalCnt and 0 or arg_3_0.unlockCnt - arg_3_0.usedCnt

	return
end

function var_0_0.OnFirstFlush(arg_4_0)
	arg_4_0.usedCnt = arg_4_0.activity:getData1()

	arg_4_0:RefreshData()

	arg_4_0.index = #arg_4_0.taskList

	for iter_4_0 = 1, #arg_4_0.taskList do
		local var_4_0 = arg_4_0.taskProxy:getTaskVO(arg_4_0.taskList[iter_4_0])

		if not var_4_0:isReceive() then
			arg_4_0.index = iter_4_0

			break
		end
	end

	for iter_4_1 = 1, arg_4_0.items.childCount do
		local var_4_1 = arg_4_0.items:GetChild(iter_4_1 - 1)
		local var_4_2 = var_4_1:GetComponent(typeof(LayoutElement))

		if iter_4_1 == arg_4_0.index then
			var_4_2.preferredWidth = var_0_2 or var_0_1

			setImageAlpha(var_4_1:Find("window/Image"), iter_4_1 == arg_4_0.index and 0 or 1)
			setImageAlpha(var_4_1:Find("window/main"), 1)
			onButton(arg_4_0, var_4_1, function()
				arg_4_0:SelectPage(iter_4_1)

				return
			end, SFX_PANEL)
		end
	end

	local var_4_3 = {}

	var_4_3.type, var_4_3.id, var_4_3.count = unpack(arg_4_0.taskProxy:getTaskVO(arg_4_0.taskList[arg_4_0.index]):getConfig("award_display")[1])

	updateDrop(arg_4_0.rtAward, {})
	onButton(arg_4_0, arg_4_0.rtAward:Find("get"), function()
		arg_4_0:emit(ActivityMediator.ON_TASK_SUBMIT, arg_4_0.taskProxy:getTaskVO(arg_4_0.taskList[arg_4_0.index]))

		return
	end, SFX_CONFIRM)
	onButton(arg_4_0, arg_4_0.rtAward, function()
		arg_4_0:emit(BaseUI.ON_DROP, var_4_3)

		return
	end)

	local var_4_4 = arg_4_0.activity:getConfig("config_client").firstStory

	if var_4_4 then
		pg.NewStoryMgr.GetInstance():Play(var_4_4)
	end

	return
end

function var_0_0.OnUpdateFlush(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.taskList) do
		({})[iter_8_1] = tobool(arg_8_0.taskProxy:getFinishTaskById(iter_8_1))

		local var_8_1

		if ({})[iter_8_1] then
			var_8_0 = var_8_0 + 1
			var_8_1 = arg_8_0.items:GetChild(iter_8_0 - 1)
		end

		setActive(var_8_1:Find("window/got"), ({})[iter_8_1])
	end

	if arg_8_0.usedCnt ~= var_8_0 then
		arg_8_0.usedCnt = var_8_0
		arg_8_0.activity.data1 = arg_8_0.usedCnt

		getProxy(ActivityProxy):updateActivity(arg_8_0.activity)
	end

	arg_8_0:RefreshData()
	setText(arg_8_0.countTF, arg_8_0.remainCnt)

	local var_8_2 = ({})[arg_8_0.taskList[arg_8_0.index]]

	setActive(arg_8_0.rtAward:Find("got"), ({})[arg_8_0.taskList[arg_8_0.index]])
	setActive(arg_8_0.rtAward:Find("get"), arg_8_0.remainCnt > 0 and not var_8_2)

	local var_8_3 = arg_8_0.activity:getConfig("config_client").story

	for iter_8_2, iter_8_3 in ipairs(arg_8_0.taskList) do
		if arg_8_0.taskProxy:getFinishTaskById(iter_8_3) and checkExist(var_8_3, {
			iter_8_2
		}, {
			1
		}) then
			pg.NewStoryMgr.GetInstance():Play(var_8_3[iter_8_2][1])
		end
	end

	return
end

function var_0_0.SelectPage(arg_9_0, arg_9_1)
	if arg_9_0.index == arg_9_1 then
		return
	end

	arg_9_0.index = arg_9_1

	local var_9_0 = arg_9_0.LTList or {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		LeanTween.cancel(iter_9_1)
	end

	arg_9_0.LTList = {}

	for iter_9_2 = 1, arg_9_0.items.childCount do
		local var_9_1 = arg_9_0.items:GetChild(iter_9_2 - 1)
		local var_9_2 = var_9_1:Find("window/Image")
		local var_9_3 = var_9_1:Find("window/main")
		local var_9_4 = var_9_1:GetComponent(typeof(LayoutElement)).preferredWidth

		if iter_9_2 == arg_9_1 then
			local var_9_5 = var_0_2 or var_0_1

			if var_9_4 ~= var_9_5 then
				local var_9_6 = math.abs(var_9_5 - var_9_4) / 2000
				local var_9_7 = LeanTween.value(go(var_9_1), var_9_4, var_9_5, var_9_6):setEase(LeanTweenType.easeOutSine)

				table.insert(arg_9_0.LTList, var_9_7:setOnUpdate(System.Action_float(function(arg_10_0)
					var_0.preferredWidth = arg_10_0

					return
				end)).uniqueId)

				local var_9_8 = LeanTween.alpha(var_9_1:Find("window/Image"), iter_9_2 == arg_9_1 and 0 or 1, var_9_6)

				table.insert(arg_9_0.LTList, var_9_8:setEase(LeanTweenType.easeOutSine).uniqueId)
			end
		end
	end

	local var_9_9 = arg_9_0.taskProxy:getTaskVO(arg_9_0.taskList[arg_9_0.index])
	local var_9_10 = {}

	var_9_10.type, var_9_10.id, var_9_10.count = unpack(var_9_9:getConfig("award_display")[1])

	updateDrop(arg_9_0.rtAward, {})

	local var_9_11 = var_9_9:isReceive()

	setActive(arg_9_0.rtAward:Find("got"), var_9_11)
	setActive(arg_9_0.rtAward:Find("get"), arg_9_0.remainCnt > 0 and not var_9_11)
	setActive(arg_9_0.rtTask, false)
	setActive(arg_9_0.rtTask, true)

	return
end

function var_0_0.OnDestroy(arg_11_0)
	local var_11_0 = arg_11_0.LTList or {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		LeanTween.cancel(iter_11_1)
	end

	return
end

return var_0_0
