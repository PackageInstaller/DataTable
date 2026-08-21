local var_0_0 = class("IslandHistoryPage")
local var_0_1 = 8
local var_0_2 = {
	{
		-291,
		-6
	},
	{
		-408,
		25
	},
	{
		0,
		0
	},
	{
		-428,
		157
	},
	{
		-341,
		15
	},
	{
		0,
		0
	},
	{
		-414,
		48
	},
	{
		0,
		0
	}
}
local var_0_3 = {
	{
		0,
		0,
		-118
	},
	{
		0,
		0,
		-172
	},
	{
		0,
		0,
		0
	},
	{
		0,
		0,
		-121
	},
	{
		0,
		0,
		-163
	},
	{
		0,
		0,
		0
	},
	{
		0,
		0,
		-256
	},
	{
		0,
		0,
		0
	}
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.historyPage = arg_1_1
	arg_1_0.event = arg_1_2
	arg_1_0.activityId = ActivityConst.ISLAND_TASK_ID
	arg_1_0.finishTasks = getProxy(ActivityTaskProxy):getFinishTasksByActId(arg_1_0.activityId)
	arg_1_0.mapDataList = pg.activity_template[arg_1_0.activityId].config_client.map_event_list or {}
	arg_1_0.pageItemContent = findTF(arg_1_0.historyPage, "selectPanel/page")
	arg_1_0.pageItemTpl = findTF(arg_1_0.historyPage, "selectPanel/page/pageItemTpl")

	setActive(arg_1_0.pageItemTpl, false)

	arg_1_0.mapPic = findTF(arg_1_0.historyPage, "pic")
	arg_1_0.mapTitle = findTF(arg_1_0.historyPage, "title/desc")
	arg_1_0.taskDesc = findTF(arg_1_0.historyPage, "taskDesc")

	setText(arg_1_0.taskDesc, i18n(IslandTaskScene.island_history_desc))

	arg_1_0.pageItemTfs = {}

	for iter_1_0 = 1, var_0_1 do
		local var_1_0 = iter_1_0
		local var_1_1 = tf(instantiate(arg_1_0.pageItemTpl))

		setParent(var_1_1, arg_1_0.pageItemContent)
		setActive(var_1_1, true)
		onButton(arg_1_0.event, var_1_1, function()
			arg_1_0:selectedPage(var_1_0)

			return
		end, SFX_UI_CLICK)
		table.insert(arg_1_0.pageItemTfs, var_1_1)
	end

	arg_1_0.startIndex = 0
	arg_1_0.taskList = {}
	arg_1_0.listConent = findTF(arg_1_0.historyPage, "listPanel/viewcontent/content")
	arg_1_0.taskListTpl = findTF(arg_1_0.historyPage, "listPanel/viewcontent/content/listTpl")

	setActive(arg_1_0.taskListTpl, false)

	arg_1_0.gotTf = findTF(arg_1_0.historyPage, "got")
	arg_1_0.finalAward = findTF(arg_1_0.historyPage, "finalAward")

	arg_1_0:initPageUI()
	arg_1_0:selectedPage(1)

	return
end

function var_0_0.selectedPage(arg_3_0, arg_3_1)
	if arg_3_0.startIndex + arg_3_1 > #arg_3_0.mapDataList then
		return
	end

	arg_3_0:updatePage(arg_3_1)
	arg_3_0:updateMap(arg_3_1)

	return
end

function var_0_0.initPageUI(arg_4_0)
	for iter_4_0 = 1, var_0_1 do
		local var_4_0 = arg_4_0.startIndex + iter_4_0

		setText(findTF(arg_4_0.pageItemTfs[iter_4_0], "num"), tostring(arg_4_0.startIndex + iter_4_0))
		setActive(findTF(arg_4_0.pageItemTfs[iter_4_0], "lock"), var_4_0 > #arg_4_0.mapDataList)
		setActive(arg_4_0.pageItemTfs[iter_4_0], var_4_0 <= #arg_4_0.mapDataList)
		setActive(findTF(arg_4_0.pageItemTfs[iter_4_0], "selected"), false)
		setText(findTF(arg_4_0.pageItemTfs[iter_4_0], "num"), (setColorStr(var_4_0, "#c57053")))
	end

	return
end

function var_0_0.updatePage(arg_5_0, arg_5_1)
	if arg_5_0.selectedPageItem then
		setActive(findTF(arg_5_0.selectedPageItem, "selected"), false)
		setText(findTF(arg_5_0.selectedPageItem, "num"), (setColorStr(arg_5_0.selectedIndex, "#c57053")))
	end

	arg_5_0.selectedPageItem = arg_5_0.pageItemTfs[arg_5_1]
	arg_5_0.selectedIndex = arg_5_1

	setActive(findTF(arg_5_0.selectedPageItem, "selected"), true)
	setText(findTF(arg_5_0.selectedPageItem, "num"), (setColorStr(arg_5_0.selectedIndex, "#84412A")))

	return
end

function var_0_0.updateMap(arg_6_0, arg_6_1)
	arg_6_0.showMapId = arg_6_0.mapDataList[arg_6_1 + arg_6_0.startIndex]
	arg_6_0.mapIndex = pg.activity_map_event_list[arg_6_0.showMapId].area

	setImageSprite(arg_6_0.mapPic, LoadSprite(IslandTaskScene.ui_atlas, "map_" .. arg_6_0.mapIndex), true)
	setImageSprite(arg_6_0.mapTitle, LoadSprite(IslandTaskScene.ui_atlas, "map_" .. arg_6_0.mapIndex .. "_desc"), true)

	arg_6_0.taskDatas = pg.activity_map_event_list[arg_6_0.showMapId].open_task

	if #arg_6_0.taskDatas - #arg_6_0.taskList > 0 then
		arg_6_0:addTaskList(#arg_6_0.taskDatas - #arg_6_0.taskList)
	end

	local var_6_0 = true

	for iter_6_0 = 1, #arg_6_0.taskList do
		if iter_6_0 <= #arg_6_0.taskDatas then
			setActive(arg_6_0.taskList[iter_6_0], true)
			setText(findTF(arg_6_0.taskList[iter_6_0], "text"), pg.task_data_template[arg_6_0.taskDatas[iter_6_0]].name)

			local var_6_1 = arg_6_0:checkTaskFinish(pg.task_data_template[arg_6_0.taskDatas[iter_6_0]].id)

			if var_6_0 and var_6_1 ~= var_6_0 then
				var_6_0 = false
			end

			setActive(findTF(arg_6_0.taskList[iter_6_0], "tag/complete"), var_6_1)
		else
			setActive(arg_6_0.taskList[iter_6_0], false)
		end
	end

	local var_6_2 = getProxy(SixthAnniversaryIslandProxy):GetNode(arg_6_0.showMapId):IsCompleted()

	print("mapId :" .. arg_6_0.showMapId .. " get flag = " .. tostring(var_6_2))
	setActive(arg_6_0.finalAward, var_6_0 and not var_6_2)
	setActive(arg_6_0.gotTf, var_6_0 and var_6_2)
	setLocalPosition(findTF(arg_6_0.historyPage, "finalAward"), Vector3(var_0_2[arg_6_0.mapIndex][1], var_0_2[arg_6_0.mapIndex][2], var_0_2[arg_6_0.mapIndex][3]))
	setLocalEulerAngles(findTF(arg_6_0.historyPage, "finalAward/arrow"), Vector3(var_0_3[arg_6_0.mapIndex][1], var_0_3[arg_6_0.mapIndex][2], var_0_3[arg_6_0.mapIndex][3]))

	return
end

function var_0_0.addTaskList(arg_7_0, arg_7_1)
	for iter_7_0 = 1, arg_7_1 do
		local var_7_0 = tf(instantiate(arg_7_0.taskListTpl))

		setActive(var_7_0, false)
		setParent(var_7_0, arg_7_0.listConent)
		table.insert(arg_7_0.taskList, var_7_0)
	end

	return
end

function var_0_0.checkTaskFinish(arg_8_0, arg_8_1)
	for iter_8_0 = 1, #arg_8_0.finishTasks do
		if arg_8_0.finishTasks[iter_8_0].id == arg_8_1 then
			return true
		end
	end

	return false
end

function var_0_0.setActive(arg_9_0, arg_9_1)
	setActive(arg_9_0.historyPage, arg_9_1)

	return
end

function var_0_0.dispose(arg_10_0)
	return
end

return var_0_0
