class = var_0_10000

local var_0_0 = var_0_10000("IslandHistoryPage")
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
	ActivityConst = var_1_10003
	arg_1_0.activityId = var_1_10003.ISLAND_TASK_ID
	getProxy = var_3
	ActivityTaskProxy = var_1_10005

	local var_1_0 = var_3(var_1_10005)

	arg_1_0.finishTasks = var_3.getFinishTasksByActId(var_1_0, arg_1_0.activityId)
	pg = var_3

	local var_1_1

	if not var_3.activity_template[arg_1_0.activityId].config_client.map_event_list then
		var_1_1 = {}
	end

	arg_1_0.mapDataList = var_1_1
	findTF = var_1_1
	arg_1_0.pageItemContent = var_1_1(arg_1_0.historyPage, "selectPanel/page")
	findTF = var_3
	arg_1_0.pageItemTpl = var_3(arg_1_0.historyPage, "selectPanel/page/pageItemTpl")
	setActive = var_3

	var_3(arg_1_0.pageItemTpl, false)

	findTF = var_3
	arg_1_0.mapPic = var_3(arg_1_0.historyPage, "pic")
	findTF = var_3
	arg_1_0.mapTitle = var_3(arg_1_0.historyPage, "title/desc")
	findTF = var_3
	arg_1_0.taskDesc = var_3(arg_1_0.historyPage, "taskDesc")
	setText = var_3

	local var_1_2 = arg_1_0.taskDesc

	i18n = var_6
	IslandTaskScene = var_1_10008

	var_3(var_1_2, var_6(var_1_10008.island_history_desc))

	arg_1_0.pageItemTfs = {}

	for iter_1_0 = 1, var_0_1 do
		local var_1_3 = iter_1_0

		tf = var_1_4
		instantiate = var_1_10010

		local var_1_4 = var_1_4(var_1_10010(arg_1_0.pageItemTpl))

		setParent = var_1_10009

		var_1_10009(var_1_4, arg_1_0.pageItemContent)

		setActive = var_1_10009

		var_1_10009(var_1_4, true)

		onButton = var_1_10009

		local var_1_5 = arg_1_0.event
		local var_1_6 = var_1_4

		local function var_1_7()
			local var_2_0 = arg_1_0

			var_0.selectedPage(var_2_0, var_1_3)

			return
		end

		SFX_UI_CLICK = var_1_10014

		var_1_10009(var_1_5, var_1_6, var_1_7, var_1_10014)

		table = var_1_10009

		var_1_10009.insert(arg_1_0.pageItemTfs, var_1_4)
	end

	arg_1_0.startIndex = 0
	arg_1_0.taskList = {}
	findTF = var_3
	arg_1_0.listConent = var_3(arg_1_0.historyPage, "listPanel/viewcontent/content")
	findTF = var_3
	arg_1_0.taskListTpl = var_3(arg_1_0.historyPage, "listPanel/viewcontent/content/listTpl")
	setActive = var_3

	var_3(arg_1_0.taskListTpl, false)

	findTF = var_3
	arg_1_0.gotTf = var_3(arg_1_0.historyPage, "got")
	findTF = var_3
	arg_1_0.finalAward = var_3(arg_1_0.historyPage, "finalAward")

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

		setText = var_1_10006
		findTF = var_1_10008
		var_1_10008 = var_1_10008(arg_4_0.pageItemTfs[iter_4_0], "num")
		tostring = var_1_10009

		var_1_10006(var_1_10008, var_1_10009(var_4_0))

		setActive = var_1_10006
		findTF = var_1_10008
		var_1_10008 = var_1_10008(arg_4_0.pageItemTfs[iter_4_0], "lock")
		var_1_10009 = #arg_4_0.mapDataList < var_4_0

		var_1_10006(var_1_10008, var_1_10009)

		setActive = var_1_10006
		var_1_10008 = arg_4_0.pageItemTfs[iter_4_0]
		var_1_10009 = var_4_0 <= #arg_4_0.mapDataList

		var_1_10006(var_1_10008, var_1_10009)

		setActive = var_1_10006
		findTF = var_1_10008

		var_1_10006(var_1_10008(arg_4_0.pageItemTfs[iter_4_0], "selected"), false)

		setColorStr = var_1_10006
		var_1_10006 = var_1_10006(var_4_0, "#c57053")
		setText = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(arg_4_0.pageItemTfs[iter_4_0], "num"), var_1_10006)
	end

	return
end

function var_0_0.updatePage(arg_5_0, arg_5_1)
	local var_5_0

	if arg_5_0.selectedPageItem then
		setActive = var_3
		findTF = var_1_10005

		var_3(var_1_10005(arg_5_0.selectedPageItem, "selected"), false)

		setColorStr = var_3

		local var_5_1 = var_3(arg_5_0.selectedIndex, "#c57053")

		setText = var_3
		findTF = var_1_10005

		var_3(var_1_10005(arg_5_0.selectedPageItem, "num"), var_5_1)
	end

	arg_5_0.selectedPageItem = arg_5_0.pageItemTfs[arg_5_1]
	arg_5_0.selectedIndex = arg_5_1
	setActive = var_3
	findTF = var_1_10005

	var_3(var_1_10005(arg_5_0.selectedPageItem, "selected"), true)

	setColorStr = var_3

	local var_5_2 = var_3(arg_5_0.selectedIndex, "#84412A")

	setText = var_3
	findTF = var_5

	var_3(var_5(arg_5_0.selectedPageItem, "num"), var_5_2)

	return
end

function var_0_0.updateMap(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1 + arg_6_0.startIndex

	arg_6_0.showMapId = arg_6_0.mapDataList[var_6_0]
	pg = var_3
	arg_6_0.mapIndex = var_3.activity_map_event_list[arg_6_0.showMapId].area
	setImageSprite = var_4

	local var_6_1 = arg_6_0.mapPic

	LoadSprite = var_1_10007
	IslandTaskScene = var_1_10009

	var_4(var_6_1, var_1_10007(var_1_10009.ui_atlas, "map_" .. arg_6_0.mapIndex), true)

	setImageSprite = var_4

	local var_6_2 = arg_6_0.mapTitle

	LoadSprite = var_7
	IslandTaskScene = var_9

	var_4(var_6_2, var_7(var_9.ui_atlas, "map_" .. arg_6_0.mapIndex .. "_desc"), true)

	arg_6_0.taskDatas = var_3.open_task

	if #arg_6_0.taskDatas - #arg_6_0.taskList > 0 then
		arg_6_0:addTaskList(var_4)
	end

	local var_6_3 = true

	for iter_6_0 = 1, #arg_6_0.taskList do
		local var_6_4 = arg_6_0.taskList[iter_6_0]
		local var_6_5, var_6_6

		if iter_6_0 <= #arg_6_0.taskDatas then
			setActive = var_6_5

			var_6_5(var_6_4, true)

			pg = var_6_5
			var_6_5 = var_6_5.task_data_template[arg_6_0.taskDatas[iter_6_0]]
			setText = var_6_6
			findTF = var_14

			var_6_6(var_14(var_6_4, "text"), var_6_5.name)

			var_6_6 = arg_6_0:checkTaskFinish(var_6_5.id)

			if var_6_3 and var_6_6 ~= var_6_3 then
				var_6_3 = false
			end

			setActive = var_13
			findTF = var_15

			var_13(var_15(var_6_4, "tag/complete"), var_6_6)
		else
			setActive = var_6_5

			var_6_5(var_6_4, false)
		end
	end

	getProxy = var_6
	SixthAnniversaryIslandProxy = var_8

	local var_6_7 = var_6(var_8)
	local var_6_8 = var_6.GetNode(var_6_7, arg_6_0.showMapId)
	local var_6_9 = var_6.IsCompleted(var_6_8)

	print = var_7

	local var_6_10 = "mapId :"
	local var_6_11 = arg_6_0.showMapId
	local var_6_12 = " get flag = "

	tostring = var_6_6

	var_7(var_6_10 .. var_6_11 .. var_6_12 .. var_6_6(var_6_9))

	setActive = var_7

	var_7(arg_6_0.finalAward, var_6_3 and not var_6_9)

	setActive = var_7

	var_7(arg_6_0.gotTf, var_6_3 and var_6_9)

	setLocalPosition = var_7
	findTF = var_9

	local var_6_13 = var_9(arg_6_0.historyPage, "finalAward")

	Vector3 = var_10

	var_7(var_6_13, var_10(var_0_2[arg_6_0.mapIndex][1], var_0_2[arg_6_0.mapIndex][2], var_0_2[arg_6_0.mapIndex][3]))

	setLocalEulerAngles = var_7
	findTF = var_6_13

	local var_6_14 = var_6_13(arg_6_0.historyPage, "finalAward/arrow")

	Vector3 = var_10

	var_7(var_6_14, var_10(var_0_3[arg_6_0.mapIndex][1], var_0_3[arg_6_0.mapIndex][2], var_0_3[arg_6_0.mapIndex][3]))

	return
end

function var_0_0.addTaskList(arg_7_0, arg_7_1)
	for iter_7_0 = 1, arg_7_1 do
		tf = var_1_10006
		instantiate = var_1_10008
		var_1_10006 = var_1_10006(var_1_10008(arg_7_0.taskListTpl))
		setActive = var_1_10007

		var_1_10007(var_1_10006, false)

		setParent = var_1_10007

		var_1_10007(var_1_10006, arg_7_0.listConent)

		table = var_1_10007

		var_1_10007.insert(arg_7_0.taskList, var_1_10006)
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
	setActive = var_1_10002

	var_1_10002(arg_9_0.historyPage, arg_9_1)

	return
end

function var_0_0.dispose(arg_10_0)
	return
end

return var_0_0
