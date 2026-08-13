class = var_0_10000

local var_0_0 = var_0_10000("IslandTaskPage")
local var_0_1 = {
	5,
	6,
	7,
	8
}
local var_0_2 = 4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.taskPage = arg_1_1
	arg_1_0.contextData = arg_1_2
	findTF = var_1_10005
	arg_1_0.taskItemTpl = var_1_10005(arg_1_3, "taskItemTpl")
	setActive = var_5

	var_5(arg_1_0.taskItemTpl, false)

	findTF = var_5
	arg_1_0.IconTpl = var_5(arg_1_3, "IconTpl")
	setActive = var_5

	var_5(arg_1_0.IconTpl, false)

	arg_1_0._event = arg_1_4
	arg_1_0.enterTaskId = nil
	arg_1_0.enterTaskIds = nil

	local var_1_0

	if arg_1_0.contextData.task_id then
		if not arg_1_0.contextData.task_id then
			var_1_0 = nil
		end

		arg_1_0.enterTaskId = var_1_0
	elseif arg_1_0.contextData.task_ids then
		if not arg_1_0.contextData.task_ids then
			var_1_0 = nil
		end

		arg_1_0.enterTaskIds = var_1_0
	end

	ActivityConst = var_1_0
	arg_1_0.activityId = var_1_0.ISLAND_TASK_ID
	pg = var_5

	local var_1_1

	if not var_5.activity_template[arg_1_0.activityId].config_client.hide_task then
		var_1_1 = {}
	end

	arg_1_0.hideTask = var_1_1
	arg_1_0.leanTweens = {}
	arg_1_0.exitFlag = false
	findTF = var_5
	arg_1_0.btnGetAll = var_5(arg_1_0.taskPage, "btnGetAll")
	findTF = var_5
	arg_1_0.taskTagPanel = var_5(arg_1_0.taskPage, "taskTagPanel")
	findTF = var_5
	arg_1_0.taskListPanel = var_5(arg_1_0.taskPage, "taskListPanel")
	findTF = var_5

	local var_1_2 = var_5(arg_1_0.taskPage, "taskListPanel/Content")

	arg_1_0.scrollRect = var_5.GetComponent(var_1_2, "LScrollRect")
	findTF = var_5
	arg_1_0.taskDetailPanel = var_5(arg_1_0.taskPage, "taskDetailPanel")
	findTF = var_5
	arg_1_0.detailTag = var_5(arg_1_0.taskDetailPanel, "tag")
	findTF = var_5
	arg_1_0.detailTitleText = var_5(arg_1_0.taskDetailPanel, "title/text")
	findTF = var_5
	arg_1_0.detailIcon = var_5(arg_1_0.taskDetailPanel, "icon/image")
	findTF = var_5
	arg_1_0.detailDescText = var_5(arg_1_0.taskDetailPanel, "desc/text")
	findTF = var_5
	arg_1_0.detaiProgressText = var_5(arg_1_0.taskDetailPanel, "progress/text")
	findTF = var_5
	arg_1_0.detailAwardContent = var_5(arg_1_0.taskDetailPanel, "awardDisplay/viewport/content")
	findTF = var_5
	arg_1_0.detailBtnGo = var_5(arg_1_0.taskDetailPanel, "btnGo")
	findTF = var_5
	arg_1_0.detailBtnGet = var_5(arg_1_0.taskDetailPanel, "btnGet")
	findTF = var_5
	arg_1_0.detailBtnSubmit = var_5(arg_1_0.taskDetailPanel, "btnSubmit")
	findTF = var_5
	arg_1_0.detailBtnDetail = var_5(arg_1_0.taskDetailPanel, "btnDetail")
	findTF = var_5
	arg_1_0.detailActive = var_5(arg_1_0.taskDetailPanel, "active")

	for iter_1_0 = 1, var_0_2 do
		findTF = var_1_10009
		var_1_10009 = var_1_10009(arg_1_0.taskTagPanel, "btn" .. iter_1_0)

		local var_1_3

		if iter_1_0 <= #var_0_1 then
			var_1_3 = var_0_1[iter_1_0]
			setText = var_1_10011
			findTF = var_13

			local var_1_4 = var_13(var_1_10009, "off/text")

			i18n = var_1_10014
			IslandTaskScene = var_16

			var_1_10011(var_1_4, var_1_10014(var_16.add_tages[var_1_3]))

			setText = var_1_10011
			findTF = var_1_4

			local var_1_5 = var_1_4(var_1_10009, "on/text")

			i18n = var_1_10014
			IslandTaskScene = var_16

			var_1_10011(var_1_5, var_1_10014(var_16.add_tages[var_1_3]))
		else
			setActive = var_1_3

			var_1_3(var_1_10009, false)
		end
	end

	setText = var_5
	findTF = var_7

	local var_1_6 = var_7(arg_1_0.taskDetailPanel, "desc/title")

	i18n = iter_1_0
	IslandTaskScene = var_10

	var_5(var_1_6, iter_1_0(var_10.ryza_task_detail_content))

	setText = var_5
	findTF = var_1_6

	local var_1_7 = var_1_6(arg_1_0.taskDetailPanel, "awardText/txt")

	i18n = var_8
	IslandTaskScene = var_10

	var_5(var_1_7, var_8(var_10.ryza_task_detail_award))

	arg_1_0.btnTags = {}

	for iter_1_1 = 1, var_0_2 do
		local var_1_8 = iter_1_1
		local var_1_9 = var_0_1[iter_1_1]

		findTF = var_1_10011
		var_1_10011 = var_1_10011(arg_1_0.taskTagPanel, "btn" .. var_1_8)
		onButton = var_1_10012

		var_1_10012(arg_1_0._event, var_1_10011, function()
			if arg_1_0.clickIndex then
				setActive = var_0
				findTF = var_2_10002

				var_0(var_2_10002(arg_1_0.btnTags[arg_1_0.clickIndex], "on"), false)

				if arg_1_0.clickIndex == var_1_8 then
					arg_1_0.clickIndex = nil
				else
					local var_2_0 = arg_1_0

					var_2_0.clickIndex = var_1_8
					setActive = var_2_0
					findTF = var_2_10002

					var_2_0(var_2_10002(arg_1_0.btnTags[arg_1_0.clickIndex], "on"), true)
				end
			else
				local var_2_1 = arg_1_0

				var_2_1.clickIndex = var_1_8
				setActive = var_2_1
				findTF = var_2_10002

				var_2_1(var_2_10002(arg_1_0.btnTags[arg_1_0.clickIndex], "on"), true)
			end

			local var_2_2 = arg_1_0
			local var_2_3

			if not arg_1_0.clickIndex or not var_0_1[arg_1_0.clickIndex] then
				var_2_3 = nil
			end

			var_2_2.tagId = var_2_3

			local var_2_4 = arg_1_0

			var_0.onClickTag(var_2_4, var_1_8)

			return
		end)

		table = var_1_10012

		var_1_10012.insert(arg_1_0.btnTags, var_1_10011)
	end

	function arg_1_0.scrollRect.onUpdateItem(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0

		var_2.onUpdateTaskItem(var_3_0, arg_3_0, arg_3_1)

		return
	end

	arg_1_0.iconTfs = {}
	arg_1_0.awards = {}
	onButton = var_5

	local var_1_10 = arg_1_0._event
	local var_1_11 = arg_1_0.btnGetAll

	local function var_1_12()
		local var_4_0 = arg_1_0.getAllTasks
		local var_4_1 = arg_1_0._event
		local var_4_2 = var_1.emit

		IslandTaskMediator = var_2_10004

		var_4_2(var_4_1, var_2_10004.SUBMIT_TASK_ALL, {
			activityId = arg_1_0.activityId,
			ids = var_4_0
		})

		return
	end

	SOUND_BACK = var_1_9

	var_5(var_1_10, var_1_11, var_1_12, var_1_9)

	onButton = var_5

	local var_1_13 = arg_1_0._event
	local var_1_14 = arg_1_0.detailBtnGo

	local function var_1_15()
		Task = var_2_10000

		local var_5_0 = var_2_10000.New(arg_1_0.selectTask)
		local var_5_1 = arg_1_0._event
		local var_5_2 = var_1.emit

		IslandTaskMediator = var_2_10004

		var_5_2(var_5_1, var_2_10004.TASK_GO, {
			taskVO = var_5_0
		})

		return
	end

	SOUND_BACK = var_1_9

	var_5(var_1_13, var_1_14, var_1_15, var_1_9)

	onButton = var_5

	local var_1_16 = arg_1_0._event
	local var_1_17 = arg_1_0.detailBtnSubmit

	local function var_1_18()
		local var_6_0 = arg_1_0.selectTask
		local var_6_1 = var_0.getConfig(var_6_0, "type")
		local var_6_2 = arg_1_0.selectTask

		if var_1.getConfig(var_6_2, "sub_type") == 1006 then
			local var_6_3 = arg_1_0._event
			local var_6_4 = var_2.emit

			IslandTaskScene = var_2_10005

			var_6_4(var_6_3, var_2_10005.OPEN_SUBMIT, arg_1_0.selectTask)
		else
			local var_6_5 = arg_1_0._event
			local var_6_6 = var_2.emit

			IslandTaskMediator = var_2_10005

			var_6_6(var_6_5, var_2_10005.SUBMIT_TASK, {
				activityId = arg_1_0.activityId,
				id = arg_1_0.selectTask.id
			})
		end

		return
	end

	SOUND_BACK = var_1_9

	var_5(var_1_16, var_1_17, var_1_18, var_1_9)

	onButton = var_5

	local var_1_19 = arg_1_0._event
	local var_1_20 = arg_1_0.detailBtnGet

	local function var_1_21()
		local var_7_0 = arg_1_0.selectTask
		local var_7_1 = var_0.getConfig(var_7_0, "type")
		local var_7_2 = arg_1_0.selectTask

		if var_1.getConfig(var_7_2, "sub_type") == 1006 then
			local var_7_3 = arg_1_0._event
			local var_7_4 = var_2.emit

			IslandTaskScene = var_2_10005

			var_7_4(var_7_3, var_2_10005.OPEN_SUBMIT, arg_1_0.selectTask)
		else
			local var_7_5 = arg_1_0._event
			local var_7_6 = var_2.emit

			IslandTaskMediator = var_2_10005

			var_7_6(var_7_5, var_2_10005.SUBMIT_TASK, {
				activityId = arg_1_0.activityId,
				id = arg_1_0.selectTask.id
			})
		end

		return
	end

	SOUND_BACK = var_1_9

	var_5(var_1_19, var_1_20, var_1_21, var_1_9)

	onButton = var_5

	local var_1_22 = arg_1_0._event
	local var_1_23 = arg_1_0.detailBtnDetail

	local function var_1_24()
		if arg_1_0.selectTask then
			tonumber = var_0

			local var_8_0 = arg_1_0.selectTask

			if var_0(var_2.getConfig(var_8_0, "target_id_2")) and 0 < var_0 then
				AtelierMaterial = var_1

				local var_8_1 = var_1.New
				local var_8_2 = {
					configId = var_0
				}
				local var_8_3 = arg_1_0.selectTask

				var_8_2.count = var_4.getConfig(var_8_3, "target_num")

				local var_8_4 = var_8_1(var_8_2)
				local var_8_5 = arg_1_0._event
				local var_8_6 = var_2.emit

				IslandTaskMediator = var_5

				var_8_6(var_8_5, var_5.SHOW_DETAIL, var_8_4)
			end
		end

		return
	end

	SOUND_BACK = var_1_9

	var_5(var_1_22, var_1_23, var_1_24, var_1_9)
	arg_1_0:updateTask()
	arg_1_0:onClickTag()

	return
end

function var_0_0.onUpdateTaskItem(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.exitFlag then
		return
	end

	local var_9_0 = arg_9_0.leanTweens

	var_9_0[arg_9_2] = arg_9_2
	table = var_9_0

	var_9_0.insert(arg_9_0.leanTweens, arg_9_2)

	GetComponent = var_3

	local var_9_1 = arg_9_2

	typeof = var_6
	CanvasGroup = var_1_10008

	local var_9_2 = var_3(var_9_1, var_6(var_1_10008))

	var_9_2.alpha = 0
	LeanTween = var_4

	local var_9_3 = var_4.value(arg_9_2, 0, 1, 0.3)
	local var_9_4 = var_4.setEase

	LeanTweenType = var_7

	local var_9_5 = var_9_4(var_9_3, var_7.linear)
	local var_9_6 = var_4.setOnUpdate

	System = var_7

	local var_9_7 = var_9_6(var_9_5, var_7.Action_float(function(arg_10_0)
		var_9_2.alpha = arg_10_0

		return
	end))
	local var_9_8 = var_4.setOnComplete

	System = var_7

	var_9_8(var_9_7, var_7.Action(function()
		arg_9_0.leanTweens[arg_9_2] = nil

		return
	end))

	arg_9_1 = arg_9_1 + 1

	local var_9_9 = arg_9_0.showTasks[arg_9_1].id
	local var_9_10 = var_4:getProgress()
	local var_9_11 = var_4:getConfig("name")
	local var_9_12 = var_4:getConfig("ryza_icon")
	local var_9_13 = var_4:isOver()
	local var_9_14 = var_4:isFinish()
	local var_9_15 = var_4
	local var_9_16 = var_4.isCircle(var_9_15)
	local var_9_17 = var_4:isDaily()

	setActive = var_9_15
	findTF = var_1_10015

	var_9_15(var_1_10015(arg_9_2, "selected"), arg_9_0.selectIndex == arg_9_1)

	setActive = var_9_15
	findTF = var_15

	var_9_15(var_15(arg_9_2, "typeNew"), var_4:isNew())

	setActive = var_9_15
	findTF = var_15

	local var_9_18 = var_15(arg_9_2, "typeCircle")
	local var_9_19

	if not var_4:isCircle() then
		var_9_19 = var_4:isDaily()
	end

	var_9_15(var_9_18, var_9_19)

	setActive = var_9_15
	findTF = var_9_18

	var_9_15(var_9_18(arg_9_2, "finish"), var_9_13)

	setActive = var_9_15
	findTF = var_15

	var_9_15(var_15(arg_9_2, "mask"), var_9_13)

	setActive = var_9_15
	findTF = var_15

	var_9_15(var_15(arg_9_2, "complete"), not var_9_13 and var_9_14 and not var_9_16)

	setText = var_9_15
	findTF = var_15

	local var_9_20 = var_15(arg_9_2, "desc/text")

	setColorStr = var_16
	shortenString = var_18

	var_9_15(var_9_20, var_16(var_18(var_9_11, 10), "#9D6B59"))

	if not var_9_12 or var_9_12 == 0 then
		var_9_12 = "attack"
	end

	setImageSprite = var_9_15
	findTF = var_9_20

	local var_9_21 = var_9_20(arg_9_2, "icon/image")

	LoadSprite = var_16
	IslandTaskScene = var_18

	var_9_15(var_9_21, var_16(var_18.icon_atlas, var_9_12))

	onButton = var_9_15

	local var_9_22 = arg_9_0._event

	tf = var_16

	var_9_15(var_9_22, var_16(arg_9_2), function()
		if arg_9_0.selectItem then
			setActive = var_0
			findTF = var_2_10002

			var_0(var_2_10002(arg_9_0.selectItem, "selected"), false)

			setText = var_0
			findTF = var_2_10002
			var_2_10002 = var_2_10002(arg_9_0.selectItem, "desc/text")
			setColorStr = var_3
			shortenString = var_5

			local var_12_0 = arg_9_0.selectTask

			var_0(var_2_10002, var_3(var_5(var_7.getConfig(var_12_0, "name"), 10), "#9D6B59"))
		end

		setActive = var_0
		findTF = var_2_10002

		var_0(var_2_10002(arg_9_2, "selected"), true)

		setText = var_0
		findTF = var_2

		local var_12_1 = var_2(arg_9_2, "desc/text")

		setColorStr = var_3
		shortenString = var_5

		var_0(var_12_1, var_3(var_5(var_9_11, 10), "#5C3E24"))

		arg_9_0.selectIndex = arg_9_1
		arg_9_0.selectItem = arg_9_2
		arg_9_0.selectTask = var_0

		local var_12_2 = arg_9_0

		var_0.updateDetail(var_12_2)

		return
	end)

	if arg_9_1 == 1 then
		triggerButton = var_9_15

		var_9_15(arg_9_2)

		arg_9_0.scrollIndex = nil
	end

	if arg_9_0.enterTaskId ~= nil and arg_9_0.enterTaskId > 0 then
		if var_9_9 == arg_9_0.enterTaskId then
			triggerButton = var_13

			var_13(arg_9_2)

			arg_9_0.enterTaskId = nil
			arg_9_0.scrollIndex = nil
		end
	elseif arg_9_0.enterTaskIds and #arg_9_0.enterTaskIds > 0 then
		ipairs = var_13

		for iter_9_0, iter_9_1 in var_13(arg_9_0.enterTaskIds) do
			if var_9_9 == iter_9_1 then
				triggerButton = var_18

				var_18(arg_9_2)

				arg_9_0.enterTaskIds = nil
				arg_9_0.scrollIndex = nil
			end
		end
	end

	return
end

function var_0_0.updateTask(arg_13_0, arg_13_1)
	arg_13_0.displayTask = {}
	arg_13_0.allDisplayTask = {}
	getProxy = var_2
	ActivityTaskProxy = var_1_10004

	local var_13_0 = var_2(var_1_10004)
	local var_13_1 = var_2.getTaskById(var_13_0, arg_13_0.activityId)

	arg_13_0.getAllTasks = {}

	for iter_13_0 = 1, #var_13_1 do
		local var_13_2 = var_13_1[iter_13_0].id

		table = var_1_10009

		if not var_1_10009.contains(arg_13_0.hideTask, var_13_2) then
			var_1_10011 = var_7
			var_1_10009 = var_7.getProgress(var_1_10011)
			var_1_10010 = var_7:getTarget()

			if not var_7:getConfig("ryza_type") or var_1_10011 <= 0 then
				var_1_10011 = 999
			end

			local var_13_3 = var_7:getConfig("type")
			local var_13_4 = var_7:getConfig("sub_type")

			if var_1_10011 > 0 then
				local var_13_5

				if not arg_13_0.displayTask[var_1_10011] then
					var_13_5 = arg_13_0.displayTask
					var_13_5[var_1_10011] = {}
				end

				table = var_13_5

				var_13_5.insert(arg_13_0.displayTask[var_1_10011], var_7)

				table = var_14

				var_14.insert(arg_13_0.allDisplayTask, var_7)

				if not var_7:isFinish() or var_7:isOver() or var_13_4 == 1006 then
					-- block empty
				else
					table = var_14

					var_14.insert(arg_13_0.getAllTasks, var_13_2)
				end
			end
		end
	end

	getProxy = var_3
	ActivityProxy = var_5

	local var_13_6 = var_3(var_5)
	local var_13_7 = var_3.getActivityById(var_13_6, arg_13_0.activityId)
	local var_13_8 = {}

	if var_13_7 then
		var_13_8 = var_13_7.data1_list
	end

	if var_13_8 then
		local var_13_9 = #var_13_8

		if 0 < var_13_9 then
			for iter_13_1 = 1, #var_13_8 do
				local var_13_10 = var_13_8[iter_13_1]

				ActivityTask = var_1_10010

				local var_13_11 = var_1_10010.New(arg_13_0.activityId, {
					progress = 0,
					id = var_13_10
				})

				var_1_10010.setOver(var_13_11)

				if var_1_10010:getConfig("ryza_type") > 0 then
					local var_13_12

					if not arg_13_0.displayTask[var_1_10011] then
						var_13_12 = arg_13_0.displayTask
						var_13_12[var_1_10011] = {}
					end

					table = var_13_12

					var_13_12.insert(arg_13_0.displayTask[var_1_10011], var_1_10010)

					table = var_12

					var_12.insert(arg_13_0.allDisplayTask, var_1_10010)
				end
			end
		end
	end

	local function var_13_13(arg_14_0, arg_14_1)
		if arg_14_0:isOver() and not arg_14_1:isOver() then
			return false
		elseif not arg_14_0:isOver() and arg_14_1:isOver() then
			return true
		end

		if arg_14_0:isFinish() and not arg_14_1:isFinish() then
			return true
		elseif not arg_14_0:isFinish() and arg_14_1:isFinish() then
			return false
		end

		if arg_14_0:isNew() and not arg_14_1:isNew() then
			return true
		elseif not arg_14_0:isNew() and arg_14_1:isNew() then
			return false
		end

		if arg_14_0.id > arg_14_1.id then
			return false
		elseif arg_14_0.id < arg_14_1.id then
			return true
		end

		return
	end

	pairs = var_6

	for iter_13_2, iter_13_3 in var_6(arg_13_0.displayTask) do
		table = var_1_10011

		var_1_10011.sort(iter_13_3, var_13_13)
	end

	table = var_6

	var_6.sort(arg_13_0.allDisplayTask, var_13_13)

	if arg_13_1 then
		arg_13_0:onClickTag()
	end

	if #arg_13_0.getAllTasks > 0 then
		setActive = var_6

		var_6(arg_13_0.btnGetAll, true)
	else
		setActive = var_6

		var_6(arg_13_0.btnGetAll, false)
	end

	return
end

function var_0_0.updateDetail(arg_15_0)
	local var_15_0 = arg_15_0.showTasks[arg_15_0.selectIndex].id
	local var_15_1 = var_1
	local var_15_2 = var_1.getProgress(var_15_1)
	local var_15_3 = var_1.target

	pg = var_15_1

	local var_15_4 = var_15_1.task_data_template[var_15_0]
	local var_15_5 = var_1:isFinish()
	local var_15_6 = var_1:isOver()
	local var_15_7 = var_1:isCircle()
	local var_15_8 = var_1:isSubmit()

	arg_15_0.awards = var_15_4.award_display

	local var_15_9 = var_15_4.desc
	local var_15_10 = var_15_4.ryza_icon
	local var_15_11 = var_1:getConfig("sub_type")

	if not var_15_10 or var_15_10 == 0 then
		var_15_10 = "attack"
	end

	if not var_15_8 and var_15_3 < var_15_2 then
		var_15_2 = var_15_3
	end

	setText = var_1_10013

	var_1_10013(arg_15_0.detailDescText, var_15_9)

	local var_15_13

	if not var_15_6 then
		setText = var_1_10013

		local var_15_12 = arg_15_0.detaiProgressText

		setColorStr = var_15_13
		var_15_13 = var_15_13(var_15_2, "#C2695B")

		local var_15_14 = " / "

		setColorStr = var_18

		var_1_10013(var_15_12, var_15_13 .. var_15_14 .. var_18(var_15_3, "#9D6B59"))
	else
		setText = var_1_10013

		var_1_10013(arg_15_0.detaiProgressText, "--/--")
	end

	setText = var_1_10013

	local var_15_15 = arg_15_0.detailTitleText

	shortenString = var_15_13

	var_1_10013(var_15_15, var_15_13(var_15_4.name, 11))

	setActive = var_1_10013

	var_1_10013(arg_15_0.detailBtnDetail, var_15_11 == 1006 and not var_15_5 and not var_15_6)

	setActive = var_1_10013

	var_1_10013(arg_15_0.detailBtnGo, not var_15_6 and not var_15_5 and var_15_11 ~= 1006)

	setActive = var_1_10013

	var_1_10013(arg_15_0.detailBtnGet, not var_15_6 and var_15_5 and not var_15_8)

	setActive = var_1_10013

	var_1_10013(arg_15_0.detailBtnSubmit, not var_15_6 and var_15_5 and var_15_8)

	setActive = var_1_10013

	var_1_10013(arg_15_0.detailActive, not var_15_6 and not var_15_5 and not var_15_7)

	setImageSprite = var_1_10013

	local var_15_16 = arg_15_0.detailIcon

	LoadSprite = var_16
	IslandTaskScene = var_18

	var_1_10013(var_15_16, var_16(var_18.icon_atlas, var_15_10))

	if #arg_15_0.iconTfs < #arg_15_0.awards then
		local var_15_17 = #arg_15_0.awards - #arg_15_0.iconTfs

		for iter_15_0 = 1, var_15_17 do
			tf = var_15_18
			Instantiate = var_1_10020

			local var_15_18 = var_15_18(var_1_10020(arg_15_0.IconTpl))

			setParent = var_19

			var_19(var_15_18, arg_15_0.detailAwardContent)

			setActive = var_19

			var_19(var_15_18, true)

			table = var_19

			var_19.insert(arg_15_0.iconTfs, var_15_18)
		end
	end

	for iter_15_1 = 1, #arg_15_0.iconTfs do
		local var_15_19

		if iter_15_1 <= #arg_15_0.awards then
			var_15_19 = arg_15_0.awards[iter_15_1]

			local var_15_20 = {
				type = var_15_19[1],
				id = var_15_19[2],
				count = var_15_19[3]
			}

			updateDrop = var_19

			var_19(arg_15_0.iconTfs[iter_15_1], var_15_20)

			onButton = var_19

			local var_15_21 = arg_15_0._event
			local var_15_22 = arg_15_0.iconTfs[iter_15_1]

			local function var_15_23()
				local var_16_0 = arg_15_0._event
				local var_16_1 = var_0.emit

				BaseUI = var_2_10003

				var_16_1(var_16_0, var_2_10003.ON_DROP, var_15_20)

				return
			end

			SFX_PANEL = var_1_10024

			var_19(var_15_21, var_15_22, var_15_23, var_1_10024)

			setActive = var_19

			var_19(arg_15_0.iconTfs[iter_15_1], true)
		else
			setActive = var_15_19

			var_15_19(arg_15_0.iconTfs[iter_15_1], false)
		end
	end

	return
end

function var_0_0.onClickTag(arg_17_0, arg_17_1)
	if arg_17_0.tagId and arg_17_0.tagId > 0 then
		if arg_17_0.displayTask[arg_17_0.tagId] and #arg_17_0.displayTask[arg_17_0.tagId] > 0 then
			arg_17_0.showTasks = arg_17_0.displayTask[arg_17_0.tagId]
		else
			triggerButton = var_2

			var_2(arg_17_0.btnTags[arg_17_1])

			return
		end
	else
		arg_17_0.showTasks = arg_17_0.allDisplayTask
	end

	if arg_17_0.enterTaskId and arg_17_0.enterTaskId > 0 then
		for iter_17_0 = 1, #arg_17_0.showTasks do
			if arg_17_0.showTasks[iter_17_0].id == arg_17_0.enterTaskId then
				arg_17_0.scrollIndex = iter_17_0
			end
		end
	end

	local var_17_0 = arg_17_0.scrollRect

	var_2.SetTotalCount(var_17_0, #arg_17_0.showTasks, 0)

	if arg_17_0.scrollIndex ~= nil then
		local var_17_1 = arg_17_0.scrollRect
		local var_17_2 = var_2.HeadIndexToValue(var_17_1, arg_17_0.scrollIndex - 1)
		local var_17_3 = arg_17_0.scrollRect

		var_3.ScrollTo(var_17_3, var_17_2)
	end

	return
end

function var_0_0.setActive(arg_18_0, arg_18_1)
	setActive = var_1_10002

	var_1_10002(arg_18_0.taskPage, arg_18_1)

	return
end

function var_0_0.dispose(arg_19_0)
	arg_19_0.exitFlag = true

	if arg_19_0.leanTweens and #arg_19_0.leanTweens > 0 then
		pairs = var_1

		for iter_19_0, iter_19_1 in var_1(arg_19_0.leanTweens) do
			LeanTween = var_1_10006

			if var_1_10006.isTweening(iter_19_1) then
				LeanTween = var_1_10006

				var_1_10006.cancel(iter_19_1)
			end
		end

		arg_19_0.leanTweens = {}
	end

	for iter_19_2 = 1, #arg_19_0.allDisplayTask do
		local var_19_0 = arg_19_0.allDisplayTask[iter_19_2]

		if var_5.isNew(var_19_0) then
			var_5:changeNew()
		end
	end

	return
end

return var_0_0
