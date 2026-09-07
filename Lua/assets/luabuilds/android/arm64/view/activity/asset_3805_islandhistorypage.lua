local IslandHistoryPage = class("IslandHistoryPage")
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

function IslandHistoryPage:Ctor(arg_1_1, arg_1_2)
	self.historyPage = arg_1_1
	self.event = arg_1_2
	self.activityId = ActivityConst.ISLAND_TASK_ID
	self.finishTasks = getProxy(ActivityTaskProxy):getFinishTasksByActId(self.activityId)
	self.mapDataList = pg.activity_template[self.activityId].config_client.map_event_list or {}
	self.pageItemContent = findTF(self.historyPage, "selectPanel/page")
	self.pageItemTpl = findTF(self.historyPage, "selectPanel/page/pageItemTpl")

	setActive(self.pageItemTpl, false)

	self.mapPic = findTF(self.historyPage, "pic")
	self.mapTitle = findTF(self.historyPage, "title/desc")
	self.taskDesc = findTF(self.historyPage, "taskDesc")

	setText(self.taskDesc, i18n(IslandTaskScene.island_history_desc))

	self.pageItemTfs = {}

	for iter_1_0 = 1, var_0_1 do
		local var_1_0 = iter_1_0
		local var_1_1 = tf(instantiate(self.pageItemTpl))

		setParent(var_1_1, self.pageItemContent)
		setActive(var_1_1, true)
		onButton(self.event, var_1_1, function()
			self:selectedPage(var_1_0)

			return
		end, SFX_UI_CLICK)
		table.insert(self.pageItemTfs, var_1_1)
	end

	self.startIndex = 0
	self.taskList = {}
	self.listConent = findTF(self.historyPage, "listPanel/viewcontent/content")
	self.taskListTpl = findTF(self.historyPage, "listPanel/viewcontent/content/listTpl")

	setActive(self.taskListTpl, false)

	self.gotTf = findTF(self.historyPage, "got")
	self.finalAward = findTF(self.historyPage, "finalAward")

	self:initPageUI()
	self:selectedPage(1)

	return
end

function IslandHistoryPage:selectedPage(arg_3_1)
	if self.startIndex + arg_3_1 > #self.mapDataList then
		return
	end

	self:updatePage(arg_3_1)
	self:updateMap(arg_3_1)

	return
end

function IslandHistoryPage:initPageUI()
	for iter_4_0 = 1, var_0_1 do
		local var_4_0 = self.startIndex + iter_4_0

		setText(findTF(self.pageItemTfs[iter_4_0], "num"), tostring(self.startIndex + iter_4_0))
		setActive(findTF(self.pageItemTfs[iter_4_0], "lock"), var_4_0 > #self.mapDataList)
		setActive(self.pageItemTfs[iter_4_0], var_4_0 <= #self.mapDataList)
		setActive(findTF(self.pageItemTfs[iter_4_0], "selected"), false)
		setText(findTF(self.pageItemTfs[iter_4_0], "num"), (setColorStr(var_4_0, "#c57053")))
	end

	return
end

function IslandHistoryPage:updatePage(arg_5_1)
	if self.selectedPageItem then
		setActive(findTF(self.selectedPageItem, "selected"), false)
		setText(findTF(self.selectedPageItem, "num"), (setColorStr(self.selectedIndex, "#c57053")))
	end

	self.selectedPageItem = self.pageItemTfs[arg_5_1]
	self.selectedIndex = arg_5_1

	setActive(findTF(self.selectedPageItem, "selected"), true)
	setText(findTF(self.selectedPageItem, "num"), (setColorStr(self.selectedIndex, "#84412A")))

	return
end

function IslandHistoryPage:updateMap(arg_6_1)
	self.showMapId = self.mapDataList[arg_6_1 + self.startIndex]
	self.mapIndex = pg.activity_map_event_list[self.showMapId].area

	setImageSprite(self.mapPic, LoadSprite(IslandTaskScene.ui_atlas, "map_" .. self.mapIndex), true)
	setImageSprite(self.mapTitle, LoadSprite(IslandTaskScene.ui_atlas, "map_" .. self.mapIndex .. "_desc"), true)

	self.taskDatas = pg.activity_map_event_list[self.showMapId].open_task

	if #self.taskDatas - #self.taskList > 0 then
		self:addTaskList(#self.taskDatas - #self.taskList)
	end

	local var_6_0 = true

	for iter_6_0 = 1, #self.taskList do
		if iter_6_0 <= #self.taskDatas then
			setActive(self.taskList[iter_6_0], true)
			setText(findTF(self.taskList[iter_6_0], "text"), pg.task_data_template[self.taskDatas[iter_6_0]].name)

			local var_6_1 = self:checkTaskFinish(pg.task_data_template[self.taskDatas[iter_6_0]].id)

			if var_6_0 and var_6_1 ~= var_6_0 then
				var_6_0 = false
			end

			setActive(findTF(self.taskList[iter_6_0], "tag/complete"), var_6_1)
		else
			setActive(self.taskList[iter_6_0], false)
		end
	end

	local var_6_2 = getProxy(SixthAnniversaryIslandProxy):GetNode(self.showMapId):IsCompleted()

	print("mapId :" .. self.showMapId .. " get flag = " .. tostring(var_6_2))
	setActive(self.finalAward, var_6_0 and not var_6_2)
	setActive(self.gotTf, var_6_0 and var_6_2)
	setLocalPosition(findTF(self.historyPage, "finalAward"), Vector3(var_0_2[self.mapIndex][1], var_0_2[self.mapIndex][2], var_0_2[self.mapIndex][3]))
	setLocalEulerAngles(findTF(self.historyPage, "finalAward/arrow"), Vector3(var_0_3[self.mapIndex][1], var_0_3[self.mapIndex][2], var_0_3[self.mapIndex][3]))

	return
end

function IslandHistoryPage:addTaskList(arg_7_1)
	for iter_7_0 = 1, arg_7_1 do
		local var_7_0 = tf(instantiate(self.taskListTpl))

		setActive(var_7_0, false)
		setParent(var_7_0, self.listConent)
		table.insert(self.taskList, var_7_0)
	end

	return
end

function IslandHistoryPage:checkTaskFinish(arg_8_1)
	for iter_8_0 = 1, #self.finishTasks do
		if self.finishTasks[iter_8_0].id == arg_8_1 then
			return true
		end
	end

	return false
end

function IslandHistoryPage:setActive(arg_9_1)
	setActive(self.historyPage, arg_9_1)

	return
end

function IslandHistoryPage:dispose()
	return
end

return IslandHistoryPage
