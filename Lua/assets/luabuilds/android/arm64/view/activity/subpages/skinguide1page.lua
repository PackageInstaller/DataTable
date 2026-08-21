local var_0_0 = class("SkinGuide1Page", import("...base.BaseActivityPage"))
local var_0_2 = {
	"xiafei",
	"weiyan",
	"kuersike",
	"deliyasite",
	"fuluoxiluofu"
}

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD/mask")
	arg_1_0.countTF = arg_1_0.bg:Find("rightPanel/count")
	arg_1_0.itemTpl = arg_1_0.bg:Find("itemTpl")

	setActive(arg_1_0.itemTpl, false)

	arg_1_0.items = arg_1_0.bg:Find("rightPanel/items")
	arg_1_0.countImg = arg_1_0.bg:Find("countImg")
	arg_1_0.paintings = arg_1_0.bg:Find("paintings")
	arg_1_0.paintingsSelected = arg_1_0.bg:Find("paintingsSelected")
	arg_1_0.descTf = arg_1_0.bg:Find("rightPanel/desc")
	arg_1_0.rightPanel = arg_1_0.bg:Find("rightPanel")
	arg_1_0.itemTfs = {}
	arg_1_0.selectedIndex = 1
	arg_1_0.paintingTfs = {}

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.taskProxy = getProxy(TaskProxy)
	arg_2_0.taskList = arg_2_0.activity:getConfig("config_data")
	arg_2_0.totalCnt = #arg_2_0.taskList

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	arg_3_0.usedCnt = arg_3_0.activity:getData1()
	arg_3_0.unlockCnt = pg.TimeMgr.GetInstance():DiffDay(arg_3_0.activity:getStartTime(), pg.TimeMgr.GetInstance():GetServerTime()) + 1
	arg_3_0.unlockCnt = arg_3_0.unlockCnt * tonumber(arg_3_0.activity:getConfig("config_id"))

	if arg_3_0.unlockCnt > arg_3_0.totalCnt then
		arg_3_0.unlockCnt = arg_3_0.totalCnt or arg_3_0.unlockCnt
		arg_3_0.remainCnt = arg_3_0.usedCnt >= arg_3_0.totalCnt and 0 or arg_3_0.unlockCnt - arg_3_0.usedCnt

		local var_3_0 = 1

		for iter_3_0 = 1, #arg_3_0.taskList do
			local var_3_1 = iter_3_0
			local var_3_2 = tf(instantiate(arg_3_0.itemTpl))

			setParent(var_3_2, arg_3_0.items)

			var_3_2.anchoredPosition = Vector2(0, 0)

			setActive(var_3_2, false)

			local var_3_3 = arg_3_0.taskProxy:getTaskById(arg_3_0.taskList[iter_3_0]) or arg_3_0.taskProxy:getFinishTaskById(arg_3_0.taskList[iter_3_0])
			local var_3_4 = var_3_3:getConfig("award_display")[1]

			updateDrop(findTF(var_3_2, "item"), {
				type = var_3_4[1],
				id = var_3_4[2],
				count = var_3_4[3]
			})
			onButton(arg_3_0, var_3_2, function()
				arg_3_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			table.insert(arg_3_0.itemTfs, var_3_2)
			onButton(arg_3_0, var_3_2:Find("get"), function()
				arg_3_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_3_3)

				return
			end, SFX_PANEL)

			local var_3_5 = findTF(arg_3_0.paintings, var_0_2[iter_3_0])

			table.insert(arg_3_0.paintingTfs, var_3_5)

			GetComponent(findTF(var_3_5, "normal"), typeof(Image)).alphaHitTestMinimumThreshold = 0.5

			onButton(arg_3_0, findTF(var_3_5, "normal"), function()
				arg_3_0:selectedChange(var_3_1)

				return
			end, SFX_PANEL)

			if var_3_3:getTaskStatus() == 1 and arg_3_0.remainCnt > 0 then
				var_3_0 = iter_3_0
			end
		end

		arg_3_0:updateUI()
		arg_3_0:selectedChange(var_3_0)

		return
	end
end

function var_0_0.selectedChange(arg_7_0, arg_7_1)
	for iter_7_0 = 1, #arg_7_0.itemTfs do
		setActive(arg_7_0.itemTfs[iter_7_0], iter_7_0 == arg_7_1)

		local var_7_0 = arg_7_0.paintingTfs[iter_7_0]

		setActive(findTF(arg_7_0.paintingTfs[iter_7_0], "name"), iter_7_0 == arg_7_1)
		setActive(findTF(var_7_0, "selected"), iter_7_0 == arg_7_1)
		setActive(findTF(var_7_0, "normal"), iter_7_0 ~= arg_7_1)

		local var_7_1 = arg_7_0.taskProxy:getTaskById(arg_7_0.taskList[iter_7_0]) or arg_7_0.taskProxy:getFinishTaskById(arg_7_0.taskList[iter_7_0])

		setActive(findTF(var_7_0, "mask"), not (var_7_1:getTaskStatus() == 2) or arg_7_1 == iter_7_0)

		if iter_7_0 == arg_7_1 then
			setParent(var_7_0, arg_7_0.paintingsSelected)
			var_7_0:SetAsLastSibling()
		else
			setParent(var_7_0, arg_7_0.paintings)
		end
	end

	if arg_7_0.selectedIndex ~= arg_7_1 then
		setActive(arg_7_0.rightPanel, false)
		setActive(arg_7_0.rightPanel, true)
	end

	arg_7_0.selectedIndex = arg_7_1

	return
end

function var_0_0.OnUpdateFlush(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.taskList) do
		if arg_8_0.taskProxy:getFinishTaskById(iter_8_1) ~= nil then
			var_8_0 = var_8_0 + 1
		end
	end

	if arg_8_0.usedCnt ~= var_8_0 then
		arg_8_0.usedCnt = var_8_0
		arg_8_0.activity.data1 = arg_8_0.usedCnt

		getProxy(ActivityProxy):updateActivity(arg_8_0.activity)
	end

	local var_8_1 = pg.TimeMgr.GetInstance()

	arg_8_0.unlockCnt = var_8_1:DiffDay(arg_8_0.activity:getStartTime(), pg.TimeMgr.GetInstance():GetServerTime()) + 1
	arg_8_0.unlockCnt = arg_8_0.unlockCnt * tonumber(arg_8_0.activity:getConfig("config_id"))

	if arg_8_0.unlockCnt > arg_8_0.totalCnt then
		arg_8_0.unlockCnt = arg_8_0.totalCnt or arg_8_0.unlockCnt
		arg_8_0.remainCnt = arg_8_0.usedCnt >= arg_8_0.totalCnt and 0 or arg_8_0.unlockCnt - arg_8_0.usedCnt

		setText(arg_8_0.countTF, tostring(arg_8_0.remainCnt))

		local var_8_2 = arg_8_0.activity:getConfig("config_client").story

		for iter_8_2, iter_8_3 in ipairs(arg_8_0.taskList) do
			if arg_8_0.taskProxy:getFinishTaskById(iter_8_3) and checkExist(var_8_2, {
				iter_8_2
			}, {
				1
			}) then
				pg.NewStoryMgr.GetInstance():Play(var_8_2[iter_8_2][1])
			end
		end

		arg_8_0:updateUI()

		return
	end
end

function var_0_0.updateUI(arg_9_0)
	for iter_9_0 = 1, #arg_9_0.itemTfs do
		local var_9_0 = arg_9_0.taskProxy:getTaskById(arg_9_0.taskList[iter_9_0]) or arg_9_0.taskProxy:getFinishTaskById(arg_9_0.taskList[iter_9_0])
		local var_9_1 = arg_9_0.itemTfs[iter_9_0]:Find("item")
		local var_9_2 = var_9_0:getTaskStatus()
		local var_9_3 = arg_9_0.itemTfs[iter_9_0]:Find("got")
		local var_9_4 = var_9_2 == 2

		setActive(arg_9_0.itemTfs[iter_9_0]:Find("get"), var_9_2 == 1 and arg_9_0.remainCnt > 0)
		setActive(var_9_3, var_9_4)

		local var_9_5 = arg_9_0.paintingTfs[iter_9_0]

		setActive(findTF(arg_9_0.paintingTfs[iter_9_0], "got"), var_9_4)
		setActive(findTF(var_9_5, "mask"), not var_9_4 or arg_9_0.selectedIndex == iter_9_0)
	end

	return
end

function var_0_0.OnShowFlush(arg_10_0)
	return
end

function var_0_0.OnDestroy(arg_11_0)
	return
end

return var_0_0
