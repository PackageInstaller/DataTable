local var_0_0 = class("VotingResulitAwardPage", import(".TemplatePage.SkinMagazineTemplatePage"))

var_0_0.EXPAND_WIDTH = 973
var_0_0.CLOSE_WIDTH = 216
var_0_0.DURATION_PARAMETER = 2500

function var_0_0.OnInit(arg_1_0)
	arg_1_0.items = arg_1_0._tf:Find("AD/items")
	arg_1_0.dicLT = {}

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.taskProxy = getProxy(TaskProxy)
	arg_2_0.taskList = arg_2_0.activity:getConfig("config_data")
	arg_2_0.totalCnt = #arg_2_0.taskList
	arg_2_0.usedCnt = underscore.reduce(arg_2_0.taskList, 0, function(arg_3_0, arg_3_1)
		return arg_3_0 + (arg_2_0.taskProxy:getFinishTaskById(arg_3_1) and 1 or 0)
	end)

	if arg_2_0.activity:getData1() ~= arg_2_0.usedCnt then
		arg_2_0.activity.data1 = arg_2_0.usedCnt

		getProxy(ActivityProxy):updateActivity(arg_2_0.activity)

		return true
	end

	local var_2_0 = pg.TimeMgr.GetInstance()

	arg_2_0.unlockCnt = (var_2_0:DiffDay(arg_2_0.activity:getStartTime(), var_2_0:GetServerTime()) + 1) * arg_2_0.activity:getConfig("config_id")
	arg_2_0.unlockCnt = math.min(arg_2_0.unlockCnt, arg_2_0.totalCnt)
	arg_2_0.remainCnt = arg_2_0.usedCnt >= arg_2_0.totalCnt and 0 or arg_2_0.unlockCnt - arg_2_0.usedCnt

	return
end

function var_0_0.OnFirstFlush(arg_4_0)
	arg_4_0.usedCnt = arg_4_0.activity:getData1()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.taskList) do
		local var_4_0 = arg_4_0.items:GetChild(iter_4_0 - 1)

		onButton(arg_4_0, var_4_0:Find("close"), function()
			if arg_4_0.index == iter_4_0 then
				return
			end

			arg_4_0:UpdateDisplay(iter_4_0)

			return
		end, SFX_PANEL)

		local var_4_1 = arg_4_0.taskProxy:getTaskVO(iter_4_1)
		local var_4_2 = Drop.Create(var_4_1:getConfig("award_display")[1])

		for iter_4_2, iter_4_3 in ipairs({
			"close",
			"expand"
		}) do
			local var_4_3 = var_4_0:Find(iter_4_3 .. "/IconTpl")

			updateDrop(var_4_3, var_4_2)
			setText(var_4_3:Find("get/tip/Text"), i18n("voting_page_reward"))
			onButton(arg_4_0, var_4_3, function()
				arg_4_0:emit(BaseUI.ON_DROP, var_4_2)

				return
			end, SFX_PANEL)
			onButton(arg_4_0, var_4_3:Find("get"), function()
				arg_4_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_4_1)

				return
			end, SFX_CONFIRM)
		end
	end

	arg_4_0:UpdateDisplay(1)

	local var_4_4 = arg_4_0.activity:getConfig("config_client").firstStory

	if var_4_4 then
		playStory(var_4_4)
	end

	return
end

function var_0_0.OnUpdateFlush(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.taskList) do
		local var_8_0 = arg_8_0.taskProxy:getTaskVO(iter_8_1)

		for iter_8_2, iter_8_3 in ipairs({
			"close",
			"expand"
		}) do
			local var_8_1 = arg_8_0.items:GetChild(iter_8_0 - 1):Find(iter_8_3 .. "/IconTpl")

			setActive(var_8_1:Find("get"), arg_8_0.remainCnt > 0 and not var_8_0:isReceive())
			setActive(var_8_1:Find("got"), var_8_0:isReceive())
		end
	end

	return
end

function var_0_0.UpdateDisplay(arg_9_0, arg_9_1)
	arg_9_0.index = arg_9_1

	for iter_9_0 = 1, #arg_9_0.taskList do
		local var_9_0 = arg_9_0.items:GetChild(iter_9_0 - 1)
		local var_9_1 = var_9_0:GetComponent(typeof(LayoutElement))

		setActive(var_9_0:Find("expand/IconTpl"), iter_9_0 == arg_9_0.index)

		var_9_1.flexibleWidth = iter_9_0 == arg_9_0.index and 1 or -1

		if iter_9_0 == arg_9_0.index then
			var_9_1.preferredWidth = var_0_0.EXPAND_WIDTH

			setActive(var_9_0:Find("close"), false)
		else
			local var_9_2 = {}

			if var_9_1.preferredWidth ~= var_0_0.CLOSE_WIDTH then
				if arg_9_0.dicLT[iter_9_0] then
					LeanTween.cancel(arg_9_0.dicLT[iter_9_0])

					arg_9_0.dicLT[iter_9_0] = nil
				end

				table.insert(var_9_2, function(arg_10_0)
					arg_9_0.dicLT[iter_9_0] = LeanTween.value(go(var_9_0), var_9_1.preferredWidth, arg_9_0.CLOSE_WIDTH, math.abs(var_9_1.preferredWidth - arg_9_0.CLOSE_WIDTH) / arg_9_0.DURATION_PARAMETER):setEase(LeanTweenType.easeOutSine):setOnUpdate(System.Action_float(function(arg_11_0)
						var_9_1.preferredWidth = arg_11_0

						return
					end)):setOnComplete(System.Action(arg_10_0)).uniqueId

					return
				end)
			end

			seriesAsync(var_9_2, function()
				arg_9_0.dicLT[iter_9_0] = nil

				setActive(var_9_0:Find("close"), true)

				return
			end)
		end
	end

	return
end

function var_0_0.OnDestroy(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.dicLT) do
		LeanTween.cancel(iter_13_1)
	end

	return
end

return var_0_0
