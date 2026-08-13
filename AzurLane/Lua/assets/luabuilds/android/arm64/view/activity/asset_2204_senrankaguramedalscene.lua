class = var_0_10000

local var_0_0 = "SenrankaguraMedalScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))
local var_0_2
local var_0_3
local var_0_4 = 4
local var_0_5 = "shan_luan_task_help"
local var_0_6 = "shan_luan_task_help"

function var_0_1.getUIName(arg_1_0)
	return "SenrankaguraMedalUI"
end

function var_0_1.GetTaskCountAble()
	ActivityConst = var_1_10000

	local var_2_0 = var_1_10000.SENRANKAGURA_TASK_ID

	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_2_1 = var_1_10001(var_1_10003)

	if not var_1.getActivityById(var_2_1, var_2_0) then
		return false
	end

	pg = var_1_10002

	local var_2_2 = var_1_10002.activity_template[var_2_0].config_client.player_task
	local var_2_3 = {}
	local var_2_4 = 0

	ipairs = var_1_10005

	for iter_2_0, iter_2_1 in var_1_10005(var_2_2) do
		ipairs = var_1_10010

		for iter_2_2, iter_2_3 in var_1_10010(iter_2_1) do
			table = var_1_10015

			var_1_10015.insert(var_2_3, iter_2_3)
		end
	end

	local var_2_5

	local function var_2_6(arg_3_0)
		if not arg_3_0 then
			return true
		end

		getProxy = var_2_10001
		TaskProxy = var_2_10003

		local var_3_0 = var_2_10001(var_2_10003)
		local var_3_1 = var_1.getTaskById(var_3_0, arg_3_0)

		getProxy = var_2_10002
		TaskProxy = var_4

		local var_3_2 = var_2_10002(var_4)
		local var_3_3 = var_2.getFinishTaskById(var_3_2, arg_3_0)

		if not var_3_1 and not var_3_3 then
			return false
		end

		pg = var_3_0

		local var_3_4 = var_3_0.task_data_template[arg_3_0].activity_client_config.before

		if var_3_1 and var_3_1:getTaskStatus() <= 0 then
			return false
		end

		return var_2_6(var_3_4)
	end

	for iter_2_4 = 1, #var_2_3 do
		local var_2_7 = var_2_3[iter_2_4]

		getProxy = var_1_10011
		TaskProxy = iter_2_2
		iter_2_2 = var_1_10011(iter_2_2)

		if var_1_10011.getTaskById(iter_2_2, var_2_7) then
			pg = var_1_10012
			var_1_10012 = var_1_10012.task_data_template[var_2_7].activity_client_config.before

			if var_1_10011:getTaskStatus() == 1 then
				pg = iter_2_2

				if not iter_2_2.task_data_template[var_2_7].activity_client_config.before then
					var_2_4 = var_2_4 + 1
				elseif var_2_6(iter_2_2) then
					var_2_4 = var_2_4 + 1
				end
			end
		end
	end

	return var_2_4 > 0, var_2_4
end

function var_0_1.init(arg_4_0)
	ActivityConst = var_1_10001
	arg_4_0.activityId = var_1_10001.SENRANKAGURA_TASK_ID
	getProxy = var_1
	ActivityProxy = var_1_10003

	local var_4_0 = var_1(var_1_10003)

	arg_4_0.taskActivity = var_1.getActivityById(var_4_0, arg_4_0.activityId)
	pg = var_1
	arg_4_0.taskIds = var_1.activity_template[arg_4_0.activityId].config_client.player_task
	arg_4_0.taskCount = 0
	arg_4_0.allTasksIds = {}
	ipairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0.taskIds) do
		arg_4_0.taskCount = arg_4_0.taskCount + #iter_4_1
		ipairs = var_1_10006

		for iter_4_2, iter_4_3 in var_1_10006(iter_4_1) do
			table = var_1_10011

			var_1_10011.insert(arg_4_0.allTasksIds, iter_4_3)
		end
	end

	arg_4_0.openTaskFlag = arg_4_0.contextData.task
	pg = var_1
	arg_4_0.buffs = var_1.activity_template[arg_4_0.activityId].config_client.buff
	pg = var_1
	arg_4_0.ptId = var_1.activity_template[arg_4_0.activityId].config_client.pt_id
	pg = var_1
	arg_4_0.ptName = var_1.player_resource[arg_4_0.ptId].name
	arg_4_0.ptMaxNum = #arg_4_0.allTasksIds
	var_0_2 = #arg_4_0.taskIds
	var_0_3 = #arg_4_0.buffs
	arg_4_0.taskListDatas = {}

	for iter_4_4 = 1, #arg_4_0.taskIds do
		local var_4_1 = arg_4_0.taskIds[iter_4_4]

		var_1_10006 = {}
		ipairs = var_1_10007

		for iter_4_5, iter_4_6 in var_1_10007(var_4_1) do
			var_1_10014 = arg_4_0

			arg_4_0.initTaskListIds(var_1_10014, iter_4_6, var_1_10006)
		end

		arg_4_0:sortListDatas(var_1_10006)

		table = var_1_10007

		var_1_10007.insert(arg_4_0.taskListDatas, var_1_10006)
	end

	findTF = var_1

	local var_4_2 = var_1(arg_4_0._tf, "ad")

	findTF = var_2
	arg_4_0.btnDetail = var_2(var_4_2, "btnDetail")
	findTF = var_2
	arg_4_0.btnBack = var_2(var_4_2, "frame/btnBack")
	findTF = var_2
	arg_4_0.btnHelp = var_2(var_4_2, "frame/btnHelp")
	findTF = var_2
	arg_4_0.btnHome = var_2(var_4_2, "frame/btnHome")
	findTF = var_2
	arg_4_0.hxTf = var_2(var_4_2, "hx")
	setActive = var_2

	local var_4_3 = arg_4_0.hxTf

	PLATFORM_CODE = var_5
	PLATFORM_CH = var_1_10006

	var_2(var_4_3, var_5 == var_1_10006)

	onButton = var_2

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.btnDetail

	local function var_4_6()
		local var_5_0 = arg_4_0

		if var_0.getMedalGetAble(var_5_0) then
			pg = var_0

			local var_5_1 = var_0.m02
			local var_5_2 = var_0.sendNotification

			GAME = var_2_10003
			var_2_10003 = var_2_10003.ACTIVITY_OPERATION

			local var_5_3 = {
				cmd = 1
			}

			ActivityConst = var_2_10005
			var_5_3.activity_id = var_2_10005.SENRANKAGURA_MEDAL_ID

			var_5_2(var_5_1, var_2_10003, var_5_3)
		elseif arg_4_0.taskActivity then
			local var_5_4 = arg_4_0

			var_0.openDetailPane(var_5_4)
		else
			pg = var_0

			local var_5_5 = var_0.TipsMgr.GetInstance()
			local var_5_6 = var_0.ShowTips

			i18n = var_2_10003

			var_5_6(var_5_5, var_2_10003("challenge_end_tip"))
		end

		return
	end

	SOUND_BACK = var_1_10007

	var_2(var_4_4, var_4_5, var_4_6, var_1_10007)

	onButton = var_2

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0.btnBack

	local function var_4_9()
		local var_6_0 = arg_4_0

		var_0.closeView(var_6_0)

		return
	end

	SOUND_BACK = var_1_10007

	var_2(var_4_7, var_4_8, var_4_9, var_1_10007)

	onButton = var_2

	local var_4_10 = arg_4_0
	local var_4_11 = arg_4_0.btnHome

	local function var_4_12()
		local var_7_0 = arg_4_0
		local var_7_1 = var_0.emit

		BaseUI = var_2_10003

		var_7_1(var_7_0, var_2_10003.ON_HOME)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_2(var_4_10, var_4_11, var_4_12, var_1_10007)

	onButton = var_2

	local var_4_13 = arg_4_0
	local var_4_14 = arg_4_0.btnHelp

	local function var_4_15()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_8_2.type = var_2_10004
		pg = var_2_10004
		var_8_2.helps = var_2_10004.gametip[var_0_5].tip

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_2(var_4_13, var_4_14, var_4_15, var_1_10007)

	arg_4_0.btnPlayers = {}

	for iter_4_7 = 1, var_0_2 do
		local var_4_16 = iter_4_7

		findTF = var_1_10007
		var_1_10007 = var_1_10007(var_4_2, "player/" .. iter_4_7)
		GetComponent = var_1_10008
		findTF = var_10

		local var_4_17 = var_10(var_1_10007, "img")

		typeof = var_11
		Image = var_13
		var_1_10008 = var_1_10008(var_4_17, var_11(var_13))
		var_1_10008.alphaHitTestMinimumThreshold = 0.5

		local var_4_18

		if arg_4_0.taskActivity then
			onButton = var_9
			var_4_18 = arg_4_0

			local var_4_19 = var_1_10007

			local function var_4_20()
				local var_9_0 = arg_4_0

				var_0.openTaskPanel(var_9_0, iter_4_7)

				return
			end

			SFX_CONFIRM = var_1_10014

			var_9(var_4_18, var_4_19, var_4_20, var_1_10014)
		end

		setActive = var_9
		findTF = var_4_18

		var_9(var_4_18(var_1_10007, "redTip"), false)

		table = var_9

		var_9.insert(arg_4_0.btnPlayers, var_1_10007)
	end

	findTF = var_2

	local var_4_21 = var_2(arg_4_0._tf, "pop")

	findTF = var_3
	arg_4_0.detailPanel = var_3(var_4_21, "detailPanel")
	setActive = var_3

	var_3(arg_4_0.detailPanel, false)
	arg_4_0:initDetailPanel()

	findTF = var_3
	arg_4_0.taskPanel = var_3(var_4_21, "taskPanel")
	setActive = var_3

	var_3(arg_4_0.taskPanel, false)
	arg_4_0:initTaskPanel()

	findTF = var_3
	arg_4_0.submitPanel = var_3(var_4_21, "submitPanel")
	setActive = var_3

	var_3(arg_4_0.submitPanel, false)
	arg_4_0:initSubmitPanel()

	return
end

function var_0_1.didEnter(arg_10_0)
	arg_10_0:updateUI()

	if arg_10_0.taskActivity and arg_10_0.openTaskFlag then
		arg_10_0.openTaskFlag = false

		arg_10_0:openTaskPanel()
	end

	return
end

function var_0_1.updateUI(arg_11_0)
	local var_11_0 = arg_11_0:getMedalGetAble()

	setActive = var_1_10002
	findTF = var_1_10004

	var_1_10002(var_1_10004(arg_11_0.btnDetail, "detail"), not var_11_0 and arg_11_0.taskActivity)

	setActive = var_1_10002
	findTF = var_4

	var_1_10002(var_4(arg_11_0.btnDetail, "get"), var_11_0)

	getProxy = var_1_10002
	ActivityProxy = var_4

	local var_11_1 = var_1_10002(var_4)
	local var_11_2 = var_2.getActivityById

	ActivityConst = var_6

	local var_11_3 = var_11_2(var_11_1, var_6.SENRANKAGURA_MEDAL_ID).data2_list
	local var_11_4 = var_3:GetPicturePuzzleIds()

	for iter_11_0 = 1, #arg_11_0.btnPlayers do
		var_1_10010 = var_11_4[iter_11_0]

		local var_11_5 = arg_11_0.btnPlayers[iter_11_0]

		setActive = var_1_10012
		findTF = var_1_10014
		var_1_10014 = var_1_10014(var_11_5, "medal/icon")
		table = var_1_10015

		var_1_10012(var_1_10014, var_1_10015.contains(var_11_3, var_1_10010))

		setActive = var_1_10012
		findTF = var_1_10014
		var_1_10014 = var_1_10014(var_11_5, "img/got")
		table = var_1_10015

		var_1_10012(var_1_10014, var_1_10015.contains(var_11_3, var_1_10010))
	end

	getProxy = var_6
	ActivityProxy = var_8

	local var_11_6 = var_6(var_8)
	local var_11_7 = var_6.getActivityById

	ActivityConst = var_1_10010

	local var_11_8 = var_11_7(var_11_6, var_1_10010.SENRANKAGURA_MEDAL_ID).data1_list
	local var_11_9 = var_7.data2_list
	local var_11_10 = false

	for iter_11_1 = 1, #var_11_8 do
		if not var_11_10 then
			table = var_1_10015

			if not var_1_10015.contains(var_11_9, var_11_8[iter_11_1]) then
				var_11_10 = true
				pg = var_1_10015
				var_1_10017 = var_1_10015.m02
				var_1_10015 = var_1_10015.sendNotification
				GAME = var_1_10018

				var_1_10015(var_1_10017, var_1_10018.MEMORYBOOK_UNLOCK, {
					id = var_11_8[iter_11_1],
					actId = var_7.id
				})
			end
		end
	end

	if arg_11_0.taskActivity then
		local var_11_11 = arg_11_0:getGetAbleTask()
		local var_11_12 = {}

		for iter_11_2 = 1, #arg_11_0.taskIds do
			var_1_10017 = iter_11_2
			ipairs = var_1_10018

			for iter_11_3, iter_11_4 in var_1_10018(arg_11_0.taskIds[iter_11_2]) do
				table = var_1_10023

				if var_1_10023.contains(var_11_11, iter_11_4) then
					if not var_11_12[var_1_10017] then
						var_11_12[var_1_10017] = 1
					else
						var_11_12[var_1_10017] = var_11_12[var_1_10017] + 1
					end
				end
			end
		end

		for iter_11_5 = 1, #arg_11_0.btnPlayers do
			setActive = var_1_10017
			findTF = var_1_10019

			var_1_10017(var_1_10019(arg_11_0.btnPlayers[iter_11_5], "redTip"), var_11_12[iter_11_5] ~= nil)
		end

		arg_11_0:updateDetailPanel()
		arg_11_0:updateTask()
	end

	return
end

function var_0_1.getMedalGetAble(arg_12_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_12_0 = var_1_10001(var_1_10003)
	local var_12_1 = var_1.getActivityById

	ActivityConst = var_1_10005

	local var_12_2 = var_12_1(var_12_0, var_1_10005.SENRANKAGURA_MEDAL_ID).data1_list
	local var_12_3 = var_2.data2_list
	local var_12_4 = var_2:GetPicturePuzzleIds()

	if #var_12_3 == #var_12_4 and var_2.data1 ~= 1 then
		return true
	end

	return false
end

function var_0_1.openDetailPane(arg_13_0)
	setActive = var_1_10001

	var_1_10001(arg_13_0.detailPanel, true)

	return
end

function var_0_1.initDetailPanel(arg_14_0)
	findTF = var_1_10001
	arg_14_0.detailSlider = var_1_10001(arg_14_0.detailPanel, "ad/progressSlider")
	findTF = var_1
	arg_14_0.detailClose = var_1(arg_14_0.detailPanel, "ad/btnClose")
	onButton = var_1

	local var_14_0 = arg_14_0

	findTF = var_4

	local var_14_1 = var_4(arg_14_0.detailPanel, "ad/black")

	local function var_14_2()
		setActive = var_2_10000

		var_2_10000(arg_14_0.detailPanel, false)

		return
	end

	SOUND_BACK = var_14_4

	var_1(var_14_0, var_14_1, var_14_2, var_14_4)

	onButton = var_1

	var_1(arg_14_0, arg_14_0.detailClose, function()
		setActive = var_2_10000

		var_2_10000(arg_14_0.detailPanel, false)

		return
	end)

	findTF = var_1
	arg_14_0.detailProgressTipContent = var_1(arg_14_0.detailPanel, "ad/progressDetail")
	findTF = var_1
	arg_14_0.detailProgressTipTpl = var_1(arg_14_0.detailPanel, "ad/progressDetail/tipTpl")
	setActive = var_1

	var_1(arg_14_0.detailProgressTipTpl, false)

	findTF = var_1

	local var_14_3 = var_1(arg_14_0.detailPanel, "ad/progressDetail").sizeDelta.x

	arg_14_0.medalTfs = {}

	for iter_14_0 = 1, var_0_2 do
		table = var_14_4

		local var_14_4 = var_14_4.insert

		var_1_10008 = arg_14_0.medalTfs
		findTF = var_1_10009

		var_14_4(var_1_10008, var_1_10009(arg_14_0.detailPanel, "ad/medals/" .. iter_14_0))
	end

	for iter_14_1 = 1, var_0_3 do
		var_14_4 = arg_14_0.buffs[iter_14_1].pt[1]
		tf = var_14_5
		instantiate = var_1_10009

		local var_14_5 = var_14_5(var_1_10009(arg_14_0.detailProgressTipTpl))

		setImageSprite = var_1_10008
		findTF = var_1_10010
		var_1_10010 = var_1_10010(var_14_5, "num")
		GetSpriteFromAtlas = var_11

		var_1_10008(var_1_10010, var_11("ui/senrankaguramedalui_atlas", "buff_" .. iter_14_1), true)

		setImageSprite = var_1_10008
		findTF = var_1_10010
		var_1_10010 = var_1_10010(var_14_5, "count")
		GetSpriteFromAtlas = var_11

		var_1_10008(var_1_10010, var_11("ui/senrankaguramedalui_atlas", "buff_count_" .. iter_14_1), true)

		Vector3 = var_1_10008
		var_14_5.anchoredPosition = var_1_10008(var_14_4 / arg_14_0.ptMaxNum * var_14_3, 0, 0)
		SetParent = var_1_10008

		var_1_10008(var_14_5, arg_14_0.detailProgressTipContent)

		SetActive = var_1_10008

		var_1_10008(var_14_5, true)
	end

	arg_14_0.detailBuffTfs = {}

	for iter_14_2 = 1, var_0_4 do
		findTF = var_14_4
		var_14_4 = var_14_4(arg_14_0.detailPanel, "ad/buff/" .. iter_14_2)
		table = var_14_5

		var_14_5.insert(arg_14_0.detailBuffTfs, var_14_4)
	end

	findTF = var_2
	arg_14_0.detailProgressDesc = var_2(arg_14_0.detailPanel, "ad/progressDesc")
	findTF = var_2
	arg_14_0.detailLevelDesc = var_2(arg_14_0.detailPanel, "ad/levelDesc")

	return
end

function var_0_1.updateDetailPanel(arg_17_0)
	local var_17_0 = arg_17_0:getPtNum()
	local var_17_1 = arg_17_0:getBuildLv(var_17_0)
	local var_17_2

	if var_17_1 ~= 0 then
		var_17_2 = arg_17_0.buffs[var_17_1].benefit
	end

	for iter_17_0 = 1, var_0_4 do
		local var_17_3

		if var_17_2 then
			var_1_10009 = var_17_2[iter_17_0]
			pg = var_1_10010
			var_17_3 = var_1_10010.benefit_buff_template[var_1_10009].desc
		else
			i18n = var_1_10009
			var_17_3 = var_1_10009("shan_luan_task_buff_default")
		end

		var_1_10009 = arg_17_0.detailBuffTfs[iter_17_0]
		setText = var_1_10010
		findTF = var_1_10012

		var_1_10010(var_1_10012(var_1_10009, "desc"), var_17_3)
	end

	setSlider = var_4

	var_4(arg_17_0.detailSlider, 0, arg_17_0.ptMaxNum, var_17_0)

	getProxy = var_4
	ActivityProxy = var_6

	local var_17_4 = var_4(var_6)
	local var_17_5 = var_4.getActivityById

	ActivityConst = var_8

	local var_17_6 = var_17_5(var_17_4, var_8.SENRANKAGURA_MEDAL_ID).data1_list
	local var_17_7 = var_5.data2_list
	local var_17_8 = var_5:GetPicturePuzzleIds()

	for iter_17_1 = 1, #arg_17_0.medalTfs do
		local var_17_9 = arg_17_0.medalTfs[iter_17_1]
		local var_17_10 = var_17_8[iter_17_1]

		setActive = var_1_10015
		findTF = var_1_10017
		var_1_10017 = var_1_10017(var_17_9, "icon")
		table = var_1_10018

		var_1_10015(var_1_10017, var_1_10018.contains(var_17_7, var_17_10))
	end

	setText = var_9
	findTF = var_11

	local var_17_11 = var_11(arg_17_0.detailProgressDesc, "desc")

	i18n = iter_17_1

	var_9(var_17_11, iter_17_1("shan_luan_task_progress_tip", arg_17_0:getTaskCompleteCount() .. "/" .. arg_17_0.taskCount))

	setText = var_9
	findTF = var_17_11

	local var_17_12 = var_17_11(arg_17_0.detailLevelDesc, "desc")

	i18n = var_12

	var_9(var_17_12, var_12("shan_luan_task_level_tip", "Lv." .. var_17_1))

	return
end

function var_0_1.getTaskCompleteCount(arg_18_0)
	local var_18_0 = 0
	local var_18_1 = arg_18_0:getActiveTask()

	ipairs = var_1_10003

	for iter_18_0, iter_18_1 in var_1_10003(var_18_1) do
		local var_18_2 = arg_18_0:getTask(iter_18_1)

		if var_8.getTaskStatus(var_18_2) == 2 then
			var_18_0 = var_18_0 + 1
		else
			print = var_8

			var_8()
		end
	end

	return var_18_0
end

function var_0_1.getPtNum(arg_19_0)
	local var_19_0 = 0

	if arg_19_0.ptId then
		getProxy = var_2
		PlayerProxy = var_1_10004
		var_1_10004 = var_2(var_1_10004)
		var_19_0 = var_2.getData(var_1_10004)[arg_19_0.ptName] or 0
	else
		getProxy = var_2
		ActivityProxy = var_1_10004

		local var_19_1 = var_2(var_1_10004)
		local var_19_2 = var_2.getActivityByType

		ActivityConst = var_1_10005

		local var_19_3 = var_19_2(var_19_1, var_1_10005.ACTIVITY_TYPE_BUILDING_BUFF_2)

		var_19_0 = var_2.GetBuildingLevelSum(var_19_3)
	end

	if var_19_0 > arg_19_0.ptMaxNum then
		var_19_0 = arg_19_0.ptMaxNum
	end

	return var_19_0
end

function var_0_1.getBuildLv(arg_20_0, arg_20_1)
	local var_20_0 = 0

	for iter_20_0 = #arg_20_0.buffs, 1, -1 do
		var_20_0 = arg_20_1 >= arg_20_0.buffs[iter_20_0].pt[1] and var_20_0 < iter_20_0 and iter_20_0 or var_20_0
	end

	return var_20_0
end

function var_0_1.initTaskListIds(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0

	pg = var_1_10004

	local var_21_1 = var_1_10004.task_data_template[arg_21_1].activity_client_config.before

	pg = var_4

	local var_21_2

	if not var_4.task_data_template[arg_21_1].activity_client_config.special then
		var_21_2 = false
	end

	local var_21_3 = {
		id = arg_21_1,
		before = var_21_1,
		special = var_21_2
	}

	ipairs = var_1_10006

	for iter_21_0, iter_21_1 in var_1_10006(arg_21_2) do
		ipairs = var_1_10011

		for iter_21_2, iter_21_3 in var_1_10011(iter_21_1) do
			if iter_21_3.id == var_21_1 then
				table = var_16

				var_16.insert(iter_21_1, var_21_3)

				return
			elseif iter_21_3.before == arg_21_1 then
				table = var_16

				var_16.insert(iter_21_1, var_21_3)

				return
			end
		end
	end

	table = var_6

	var_6.insert(arg_21_2, {
		var_21_3
	})

	return
end

function var_0_1.initTaskPanel(arg_22_0)
	findTF = var_1_10001

	local var_22_0 = var_1_10001(arg_22_0.taskPanel, "ad/frame/btnBack")

	findTF = var_1_10002

	local var_22_1 = var_1_10002(arg_22_0.taskPanel, "ad/frame/btnHelp")

	findTF = var_3

	local var_22_2 = var_3(arg_22_0.taskPanel, "ad/frame/btnHome")

	onButton = var_4

	local var_22_3 = arg_22_0
	local var_22_4 = var_22_0

	local function var_22_5()
		setActive = var_2_10000

		var_2_10000(arg_22_0.taskPanel, false)

		return
	end

	SOUND_BACK = var_1_10009

	var_4(var_22_3, var_22_4, var_22_5, var_1_10009)

	onButton = var_4

	local var_22_6 = arg_22_0
	local var_22_7 = var_22_2

	local function var_22_8()
		local var_24_0 = arg_22_0
		local var_24_1 = var_0.emit

		BaseUI = var_2_10003

		var_24_1(var_24_0, var_2_10003.ON_HOME)

		return
	end

	SFX_CONFIRM = var_1_10009

	var_4(var_22_6, var_22_7, var_22_8, var_1_10009)

	onButton = var_4

	local var_22_9 = arg_22_0
	local var_22_10 = var_22_1

	local function var_22_11()
		pg = var_2_10000

		local var_25_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_25_1 = var_0.ShowMsgBox
		local var_25_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_25_2.type = var_2_10004
		pg = var_2_10004
		var_25_2.helps = var_2_10004.gametip[var_0_6].tip

		var_25_1(var_25_0, var_25_2)

		return
	end

	SFX_CONFIRM = var_1_10009

	var_4(var_22_9, var_22_10, var_22_11, var_1_10009)

	arg_22_0.taskTagTfs = {}
	findTF = var_4

	local var_22_12 = var_4(arg_22_0.taskPanel, "ad/tag/content")

	findTF = var_5

	local var_22_13 = var_5(arg_22_0.taskPanel, "ad/tag/content/tagTpl")

	setActive = var_6

	var_6(var_22_13, false)

	for iter_22_0 = 1, var_0_2 do
		local var_22_14 = iter_22_0

		tf = var_1_10011
		instantiate = var_1_10013
		var_1_10011 = var_1_10011(var_1_10013(var_22_13))
		setImageSprite = var_1_10012
		findTF = var_1_10014
		var_1_10014 = var_1_10014(var_1_10011, "icon")
		GetSpriteFromAtlas = var_15

		var_1_10012(var_1_10014, var_15("ui/senrankaguramedalui_atlas", "player_icon_" .. iter_22_0), true)

		SetParent = var_1_10012

		var_1_10012(var_1_10011, var_22_12)

		setActive = var_1_10012

		var_1_10012(var_1_10011, true)

		table = var_1_10012

		var_1_10012.insert(arg_22_0.taskTagTfs, var_1_10011)

		onButton = var_1_10012
		var_1_10014 = arg_22_0

		local var_22_15 = var_1_10011

		local function var_22_16()
			local var_26_0 = arg_22_0

			var_0.taskSelectTag(var_26_0, var_22_14, true)

			return
		end

		SFX_CONFIRM = var_17

		var_1_10012(var_1_10014, var_22_15, var_22_16, var_17)
	end

	findTF = var_6
	arg_22_0.taskButtonTpl = var_6(arg_22_0.taskPanel, "ad/taskButtonTpl")
	arg_22_0.taskList = {}
	findTF = var_6

	local var_22_17 = var_6(arg_22_0.taskPanel, "ad/task/content")

	findTF = var_7
	arg_22_0.taskDragTf = var_7(arg_22_0.taskPanel, "ad/task/drag")
	findTF = var_7

	local var_22_18 = var_7(arg_22_0.taskPanel, "ad/taskTpl")

	findTF = var_8

	local var_22_19 = var_8(arg_22_0.taskPanel, "ad/taskButtonTpl")

	setActive = var_9

	var_9(var_22_18, false)

	setActive = var_9

	var_9(var_22_19, false)

	arg_22_0.taskGroups = {}

	for iter_22_1 = 1, var_0_2 do
		local var_22_20 = {}

		var_1_10014 = arg_22_0.taskListDatas[iter_22_1]

		for iter_22_2 = 1, #var_1_10014 do
			tf = var_1_10019
			instantiate = var_1_10021
			var_1_10019 = var_1_10019(var_1_10021(var_22_18))
			setParent = var_1_10020

			var_1_10020(var_1_10019, var_22_17)

			setActive = var_1_10020

			var_1_10020(var_1_10019, true)

			var_1_10020 = var_1_10014[iter_22_2]
			var_1_10021 = {}
			ipairs = var_22

			for iter_22_3, iter_22_4 in var_22(var_1_10020) do
				tf = var_1_10027
				instantiate = var_1_10029
				var_1_10027 = var_1_10027(var_1_10029(var_22_19))
				Vector2 = var_1_10028
				var_1_10027.anchoredPosition = var_1_10028(iter_22_4.pos[1] * 325 + iter_22_4.pos[2] * 90, iter_22_4.pos[2] * 190)

				local var_22_21

				if iter_22_4.special then
					if iter_22_4.pos[2] ~= 0 then
						setImageSprite = var_1_10029
						findTF = var_22_21
						var_22_21 = var_22_21(var_1_10027, "get")
						GetSpriteFromAtlas = var_1_10032

						var_1_10029(var_22_21, var_1_10032("ui/senrankaguramedalui_atlas", "task_get_" .. 4), true)

						setImageSprite = var_1_10029
						findTF = var_22_21
						var_22_21 = var_22_21(var_1_10027, "got")
						GetSpriteFromAtlas = var_1_10032

						var_1_10029(var_22_21, var_1_10032("ui/senrankaguramedalui_atlas", "task_got_" .. 4), true)
					else
						setImageSprite = var_1_10029
						findTF = var_22_21
						var_22_21 = var_22_21(var_1_10027, "get")
						GetSpriteFromAtlas = var_1_10032

						var_1_10029(var_22_21, var_1_10032("ui/senrankaguramedalui_atlas", "task_get_" .. 2), true)

						setImageSprite = var_1_10029
						findTF = var_22_21
						var_22_21 = var_22_21(var_1_10027, "got")
						GetSpriteFromAtlas = var_1_10032

						var_1_10029(var_22_21, var_1_10032("ui/senrankaguramedalui_atlas", "task_got_" .. 2), true)
					end
				elseif not var_1_10028 and iter_22_4.pos[2] ~= 0 then
					setImageSprite = var_1_10029
					findTF = var_22_21

					local var_22_22 = var_22_21(var_1_10027, "get")

					GetSpriteFromAtlas = var_1_10032

					var_1_10029(var_22_22, var_1_10032("ui/senrankaguramedalui_atlas", "task_get_" .. 3), true)

					setImageSprite = var_1_10029
					findTF = var_22_22

					local var_22_23 = var_22_22(var_1_10027, "got")

					GetSpriteFromAtlas = var_1_10032

					var_1_10029(var_22_23, var_1_10032("ui/senrankaguramedalui_atlas", "task_got_" .. 3), true)
				end

				setActive = var_1_10029

				var_1_10029(var_1_10027, true)

				SetParent = var_1_10029

				var_1_10029(var_1_10027, var_1_10019)

				table = var_1_10029

				var_1_10029.insert(var_1_10021, {
					tf = var_1_10027,
					data = iter_22_4
				})

				onButton = var_1_10029

				local var_22_24 = arg_22_0

				var_1_10032 = var_1_10027

				local function var_22_25()
					local var_27_0 = arg_22_0

					var_0.openSubmitPanel(var_27_0, iter_22_4)

					return
				end

				SFX_CONFIRM = var_1_10034

				var_1_10029(var_22_24, var_1_10032, var_22_25, var_1_10034)
			end

			var_22_20.listTf = var_1_10019
			var_22_20.taskDic = var_1_10021
		end

		table = var_15

		var_15.insert(arg_22_0.taskGroups, var_22_20)
	end

	findTF = var_9
	arg_22_0.taskButtonTpl = var_9(arg_22_0.taskPanel, "ad/buttonTpl")
	findTF = var_9
	arg_22_0.taskBtnGetAll = var_9(arg_22_0.taskPanel, "ad/btnGetAll")
	onButton = var_9

	local var_22_26 = arg_22_0
	local var_22_27 = arg_22_0.taskBtnGetAll

	local function var_22_28()
		local var_28_0 = arg_22_0

		if var_0.getGetAbleTask(var_28_0) and #var_0 > 0 then
			local var_28_1 = arg_22_0
			local var_28_2 = var_1.emit

			SenrankaguraMedalMediator = var_2_10004

			var_28_2(var_28_1, var_2_10004.SUBMIT_TASK_ALL, var_0)
		end

		return
	end

	SFX_CONFIRM = var_1_10014

	var_9(var_22_26, var_22_27, var_22_28, var_1_10014)

	return
end

function var_0_1.updateTask(arg_29_0)
	for iter_29_0 = 1, #arg_29_0.taskGroups do
		local var_29_0 = arg_29_0.taskGroups[iter_29_0].taskDic

		ipairs = var_1_10007

		for iter_29_1, iter_29_2 in var_1_10007(var_29_0) do
			local var_29_1 = iter_29_2.tf
			local var_29_2 = arg_29_0
			local var_29_3 = arg_29_0.getTask(var_29_2, iter_29_2.data.id)

			setActive = var_1_10014
			findTF = var_1_10016

			var_1_10014(var_1_10016(var_29_1, "lock"), false)

			setActive = var_1_10014
			findTF = var_1_10016

			var_1_10014(var_1_10016(var_29_1, "getAble"), false)

			setActive = var_1_10014
			findTF = var_1_10016

			var_1_10014(var_1_10016(var_29_1, "get"), false)

			setActive = var_1_10014
			findTF = var_1_10016

			var_1_10014(var_1_10016(var_29_1, "got"), false)

			if var_29_3 then
				var_1_10016 = arg_29_0

				local var_29_4

				if arg_29_0.checkTaskBeforeComplete(var_1_10016, var_29_3:getConfig("activity_client_config").before) then
					var_29_4 = var_29_3

					if var_29_3.getTaskStatus(var_29_4) == 0 then
						setActive = var_29_2
						findTF = var_29_4

						var_29_2(var_29_4(var_29_1, "get"), true)
					else
						var_29_4 = var_29_3

						if var_29_3.getTaskStatus(var_29_4) == 1 then
							setActive = var_29_2
							findTF = var_29_4

							var_29_2(var_29_4(var_29_1, "get"), true)

							setActive = var_29_2
							findTF = var_29_4

							var_29_2(var_29_4(var_29_1, "getAble"), true)
						else
							var_29_4 = var_29_3

							if var_29_3.getTaskStatus(var_29_4) == 2 then
								setActive = var_29_2
								findTF = var_29_4

								var_29_2(var_29_4(var_29_1, "got"), true)
							end
						end
					end
				else
					setActive = var_29_2
					findTF = var_29_4

					var_29_2(var_29_4(var_29_1, "lock"), true)

					setActive = var_29_2
					findTF = var_17

					var_29_2(var_17(var_29_1, "get"), true)
				end
			else
				setActive = var_1_10014
				findTF = var_1_10016

				var_1_10014(var_1_10016(var_29_1, "lock"), true)

				setActive = var_1_10014
				findTF = var_1_10016

				var_1_10014(var_1_10016(var_29_1, "get"), true)
			end
		end
	end

	if #arg_29_0:getGetAbleTask() > 0 then
		setActive = var_2

		var_2(arg_29_0.taskBtnGetAll, true)
	else
		setActive = var_2

		var_2(arg_29_0.taskBtnGetAll, false)
	end

	for iter_29_3 = 1, #arg_29_0.taskGroups do
		local var_29_5 = arg_29_0.taskGroups[iter_29_3].taskDic
		local var_29_6 = arg_29_0.taskGroups[iter_29_3].listTf

		ipairs = var_1_10008

		for iter_29_4, iter_29_5 in var_1_10008(var_29_5) do
			local var_29_7 = iter_29_5.data.pos
			local var_29_8 = iter_29_5.data.before
			local var_29_9 = iter_29_5.tf

			setActive = var_1_10016
			findTF = var_1_10018

			var_1_10016(var_1_10018(var_29_9, "line/back"), false)

			setActive = var_1_10016
			findTF = var_1_10018

			var_1_10016(var_1_10018(var_29_9, "line/bottom"), false)

			setActive = var_1_10016
			findTF = var_1_10018

			var_1_10016(var_1_10018(var_29_9, "line/top"), false)

			var_1_10018 = var_29_9

			var_29_9.SetAsFirstSibling(var_1_10018)

			if not var_29_8 then
				setActive = var_1_10016
				findTF = var_1_10018

				var_1_10016(var_1_10018(var_29_9, "line"), false)

				goto label_29_0
			end

			var_1_10018 = arg_29_0
			var_1_10016 = arg_29_0.getTaskPos(var_1_10018, var_29_8)

			local var_29_10 = arg_29_0:getTask(var_29_8)

			if arg_29_0:checkTaskBeforeComplete(var_29_8) then
				Color = var_1_10018

				if not var_1_10018.New(0.9921568627450981, 0.9647058823529412, 0.8666666666666667) then
					Color = var_1_10018
					var_1_10018 = var_1_10018.New(0.48627450980392156, 0.35294117647058826, 0.2901960784313726)
				end

				if var_1_10016[1] < var_29_7[1] then
					setActive = var_19
					findTF = var_21

					var_19(var_21(var_29_9, "line/back"), true)

					setImageColor = var_19
					findTF = var_21

					var_19(var_21(var_29_9, "line/back"), var_1_10018)
				elseif var_1_10016[2] < var_29_7[2] then
					setActive = var_19
					findTF = var_21

					var_19(var_21(var_29_9, "line/bottom"), true)

					setImageColor = var_19
					findTF = var_21

					var_19(var_21(var_29_9, "line/bottom"), var_1_10018)
				else
					setActive = var_19
					findTF = var_21

					var_19(var_21(var_29_9, "line/top"), true)

					setImageColor = var_19
					findTF = var_21

					var_19(var_21(var_29_9, "line/top"), var_1_10018)
				end

				setActive = var_19
				findTF = var_21

				var_19(var_21(var_29_9, "line"), true)

				::label_29_0::
			end
		end
	end

	return
end

function var_0_1.checkTaskBeforeComplete(arg_30_0, arg_30_1)
	if not arg_30_1 then
		return true
	end

	local var_30_0 = arg_30_0:getTaskGroupData(arg_30_1).before

	if not arg_30_0:getTask(arg_30_1) then
		return true
	end

	if var_4:getTaskStatus() == 0 then
		return false
	end

	if var_4:getTaskStatus() >= 1 then
		return arg_30_0:checkTaskBeforeComplete(var_30_0)
	end

	return true
end

function var_0_1.getTaskGroupData(arg_31_0, arg_31_1)
	for iter_31_0 = 1, #arg_31_0.taskGroups do
		local var_31_0 = arg_31_0.taskGroups[iter_31_0].taskDic

		ipairs = var_1_10007

		for iter_31_1, iter_31_2 in var_1_10007(var_31_0) do
			if iter_31_2.data.id == arg_31_1 then
				return iter_31_2.data
			end
		end
	end

	return nil
end

function var_0_1.getTaskPos(arg_32_0, arg_32_1)
	for iter_32_0 = 1, #arg_32_0.taskGroups do
		local var_32_0 = arg_32_0.taskGroups[iter_32_0].taskDic

		ipairs = var_1_10007

		for iter_32_1, iter_32_2 in var_1_10007(var_32_0) do
			if iter_32_2.data.id == arg_32_1 then
				return iter_32_2.data.pos
			end
		end
	end

	return nil
end

function var_0_1.getTask(arg_33_0, arg_33_1)
	getProxy = var_1_10002
	TaskProxy = var_1_10004

	local var_33_0 = var_1_10002(var_1_10004)
	local var_33_1

	if var_33_0:getTaskById(arg_33_1) then
		return var_3
	end

	if var_33_0:getFinishTaskById(arg_33_1) then
		return var_3
	end

	return nil
end

function var_0_1.getGetAbleTask(arg_34_0)
	local var_34_0 = {}

	getProxy = var_1_10002
	TaskProxy = var_1_10004

	local var_34_1 = var_1_10002(var_1_10004)
	local var_34_2 = arg_34_0:getActiveTask()

	for iter_34_0 = 1, #var_34_2 do
		if var_34_1:getTaskById(var_34_2[iter_34_0]) and var_8:getTaskStatus() == 1 then
			table = var_9

			var_9.insert(var_34_0, var_8.id)
		end
	end

	return var_34_0
end

function var_0_1.getActiveTask(arg_35_0)
	local var_35_0 = {}

	for iter_35_0 = 1, #arg_35_0.taskGroups do
		local var_35_1 = arg_35_0.taskGroups[iter_35_0].taskDic

		ipairs = var_1_10007

		for iter_35_1, iter_35_2 in var_1_10007(var_35_1) do
			if not iter_35_2.data.before then
				table = var_12

				var_12.insert(var_35_0, iter_35_2.data.id)
			elseif arg_35_0:checkTaskBeforeComplete(iter_35_2.data.before) then
				table = var_1_10013

				var_1_10013.insert(var_35_0, iter_35_2.data.id)
			end
		end
	end

	return var_35_0
end

function var_0_1.taskSelectTag(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = 0

	if arg_36_0.currentSelectIndex then
		math = var_4
		var_36_0 = var_4.abs(arg_36_0.currentSelectIndex - arg_36_1)
	end

	arg_36_0.currentSelectIndex = arg_36_1
	arg_36_0.currentSelectTag = arg_36_0.taskTagTfs[arg_36_1]
	arg_36_0.currentTaskDatas = arg_36_0.taskListDatas[arg_36_1]

	for iter_36_0 = 1, #arg_36_0.taskTagTfs do
		local var_36_1 = arg_36_0.taskTagTfs[iter_36_0]

		setActive = var_1_10009
		findTF = var_1_10011

		var_1_10009(var_1_10011(var_36_1, "select"), arg_36_0.currentSelectTag == var_36_1)
	end

	GetComponent = var_4
	findTF = var_6

	local var_36_2 = var_6(arg_36_0.taskPanel, "ad/task")

	typeof = iter_36_0
	ScrollRect = var_9
	arg_36_0.taskScrollRect = var_4(var_36_2, iter_36_0(var_9))

	local var_36_3 = var_0_2 - 1

	Vector2 = var_5

	local var_36_4 = var_5(arg_36_0.taskScrollRect.normalizedPosition.x, arg_36_0.taskScrollRect.normalizedPosition.y)

	if arg_36_2 then
		var_36_2 = arg_36_0.taskScrollRect.normalizedPosition.y

		local var_36_5 = (var_36_3 - (arg_36_1 - 1)) / var_36_3

		LeanTween = var_8

		local var_36_6 = var_8.isTweening

		go = var_1_10010

		local var_36_7

		if var_36_6(var_1_10010(arg_36_0._tf)) then
			LeanTween = var_36_7
			var_36_7 = var_36_7.cancel
			go = var_10

			var_36_7(var_10(arg_36_0._tf))
		end

		LeanTween = var_36_7

		local var_36_8 = var_36_7.value

		go = var_10

		local var_36_9 = var_36_8(var_10(arg_36_0._tf), var_36_2, var_36_5, 0.3 + var_36_0 * 0.1)
		local var_36_10 = var_8.setOnUpdate

		System = var_11

		var_36_10(var_36_9, var_11.Action_float(function(arg_37_0)
			var_36_4.y = arg_37_0
			arg_36_0.taskScrollRect.normalizedPosition = var_36_4

			local var_37_0 = arg_36_0.taskScrollRect.onValueChanged

			var_1.Invoke(var_37_0, var_36_4)

			return
		end))
	else
		scrollTo = var_36_2

		var_36_2(arg_36_0.taskScrollRect, 0, (var_36_3 - (arg_36_1 - 1)) / var_36_3)
	end

	return
end

function var_0_1.openTaskPanel(arg_38_0, arg_38_1)
	arg_38_1 = arg_38_1 or 1

	arg_38_0:taskSelectTag(arg_38_1, false)

	setActive = var_2

	var_2(arg_38_0.taskPanel, true)

	return
end

function var_0_1.sortListDatas(arg_39_0, arg_39_1)
	local var_39_0

	local function var_39_1(arg_40_0)
		ipairs = var_2_10001

		for iter_40_0, iter_40_1 in var_2_10001(var_39_0) do
			if iter_40_1[1] == arg_40_0[1] and iter_40_1[2] == arg_40_0[2] then
				return false
			end
		end

		return true
	end

	local function var_39_2(arg_41_0, arg_41_1)
		ipairs = var_2_10002

		for iter_41_0, iter_41_1 in var_2_10002(arg_41_1) do
			if iter_41_1.id == arg_41_0 then
				return iter_41_1
			end
		end

		return
	end

	for iter_39_0 = 1, #arg_39_1 do
		var_39_0 = {}

		local var_39_3 = arg_39_1[iter_39_0]
		local var_39_4

		for iter_39_1 = 1, #var_39_3 do
			local var_39_5
			local var_39_6

			if not var_39_3[iter_39_1].before then
				var_39_5 = {
					0,
					0
				}
			elseif var_16.before then
				var_39_6 = var_39_2(var_16.before, var_39_3)
				assert = var_1_10018

				var_1_10018(var_39_6, "找不到前置id.." .. var_16.before)

				var_1_10018 = var_39_6.pos

				local var_39_7 = {
					var_1_10018[1] + 1,
					var_1_10018[2]
				}

				for iter_39_2 = 1, 10 do
					if var_39_1(var_39_7) then
						break
					else
						if iter_39_2 == 1 then
							var_39_7[1] = var_39_7[1] - 1
						end

						if var_39_7[2] > 0 then
							var_39_7[2] = var_39_7[2] * -1
						else
							math = var_24
							var_39_7[2] = var_24.abs(var_39_7[2]) + 1
						end

						if var_1_10018[2] - var_39_7[2] > 1 then
							var_39_6.pos = {
								var_39_7[1],
								var_39_7[2]
							}
							var_39_7[1] = var_39_7[1] + 1
						end
					end

					assert = var_24

					var_24(iter_39_2 ~= 10, "任务分支超过10个")
				end

				var_39_5 = var_39_7
			end

			var_16.pos = var_39_5
			table = var_39_6

			var_39_6.insert(var_39_0, var_39_5)
		end
	end

	return
end

function var_0_1.openSubmitPanel(arg_42_0, arg_42_1)
	setActive = var_1_10002

	var_1_10002(arg_42_0.submitPanel, true)

	local var_42_0 = arg_42_0.currentSelectIndex

	setImageSprite = var_1_10003
	findTF = var_5

	local var_42_1 = var_5(arg_42_0.submitPanel, "icon/img")

	GetSpriteFromAtlas = var_1_10006

	var_1_10003(var_42_1, var_1_10006("ui/senrankaguramedalui_atlas", "player_icon_" .. var_42_0), true)

	local var_42_2 = arg_42_0
	local var_42_3 = arg_42_0.getTask(var_42_2, arg_42_1.id)
	local var_42_4 = arg_42_0:checkTaskBeforeComplete(arg_42_1.before)

	if var_42_3 then
		arg_42_0.selectTask = var_42_3
		setText = var_42_2
		findTF = var_7

		var_42_2(var_7(arg_42_0.submitPanel, "taskDesc"), var_42_3:getConfig("desc"))

		setText = var_42_2
		findTF = var_7

		local var_42_5 = var_7(arg_42_0.submitPanel, "img/taskName")
		local var_42_6 = var_42_3

		var_42_2(var_42_5, var_42_3.getConfig(var_42_6, "name"))

		local var_42_7 = var_42_3
		local var_42_8 = var_42_3.getProgress(var_42_7)
		local var_42_9 = var_42_3:getConfig("target_num")

		setText = var_42_7
		findTF = var_9

		local var_42_10 = var_9(arg_42_0.submitPanel, "progress/taskProgress")

		setColorStr = var_42_6

		local var_42_11 = var_42_6(var_42_8, "#C2695B")
		local var_42_12 = "/"

		setColorStr = var_12

		var_42_7(var_42_10, var_42_11 .. var_42_12 .. var_12(var_42_9, "#9D6B59"))

		local var_42_13 = var_42_3:getConfig("award_display")

		arg_42_0:setSubmitAward(var_42_13)

		setActive = var_8

		var_8(arg_42_0.submitGo, var_42_3:getTaskStatus() == 0 or not var_42_4)

		setActive = var_8

		var_8(arg_42_0.submitGet, var_42_3:getTaskStatus() == 1 and var_42_4)

		setActive = var_8

		var_8(arg_42_0.submitGot, var_42_3:getTaskStatus() == 2)
	end

	return
end

function var_0_1.initSubmitPanel(arg_43_0)
	findTF = var_1_10001
	arg_43_0.submitGet = var_1_10001(arg_43_0.submitPanel, "get")
	findTF = var_1
	arg_43_0.submitGot = var_1(arg_43_0.submitPanel, "got")
	findTF = var_1
	arg_43_0.submitGo = var_1(arg_43_0.submitPanel, "go")
	findTF = var_1
	arg_43_0.submitbtnBack = var_1(arg_43_0.submitPanel, "back")
	findTF = var_1
	arg_43_0.submitDisplayContent = var_1(arg_43_0.submitPanel, "itemDisplay/viewport/content")
	findTF = var_1
	arg_43_0.submitItemTpl = var_1(arg_43_0.submitPanel, "itemDisplay/viewport/content/item")
	setActive = var_1

	var_1(arg_43_0.submitItemTpl, false)

	findTF = var_1
	arg_43_0.submitItemDesc = var_1(arg_43_0.submitPanel, "itemDesc")
	arg_43_0.submitItems = {}
	onButton = var_1

	local var_43_0 = arg_43_0

	findTF = var_4

	local var_43_1 = var_4(arg_43_0.submitPanel, "black")

	local function var_43_2()
		setActive = var_2_10000

		var_2_10000(arg_43_0.submitPanel, false)

		return
	end

	SOUND_BACK = var_6

	var_1(var_43_0, var_43_1, var_43_2, var_6)

	onButton = var_1

	local var_43_3 = arg_43_0
	local var_43_4 = arg_43_0.submitbtnBack

	local function var_43_5()
		setActive = var_2_10000

		var_2_10000(arg_43_0.submitPanel, false)

		return
	end

	SOUND_BACK = var_6

	var_1(var_43_3, var_43_4, var_43_5, var_6)

	onButton = var_1

	local var_43_6 = arg_43_0
	local var_43_7 = arg_43_0.submitGet

	local function var_43_8()
		local var_46_1

		if arg_43_0.selectTask then
			local var_46_0 = arg_43_0

			var_46_1 = var_46_1.emit
			SenrankaguraMedalMediator = var_2_10003

			var_46_1(var_46_0, var_2_10003.SUBMIT_TASK, arg_43_0.selectTask.id)
		end

		setActive = var_46_1

		var_46_1(arg_43_0.submitPanel, false)

		return
	end

	SOUND_BACK = var_6

	var_1(var_43_6, var_43_7, var_43_8, var_6)

	onButton = var_1

	local var_43_9 = arg_43_0
	local var_43_10 = arg_43_0.submitGo

	local function var_43_11()
		setActive = var_2_10000

		var_2_10000(arg_43_0.submitPanel, false)

		if arg_43_0.selectTask then
			local var_47_0 = arg_43_0
			local var_47_1 = var_0.emit

			SenrankaguraMedalMediator = var_3

			var_47_1(var_47_0, var_3.TASK_GO, arg_43_0.selectTask)
		end

		return
	end

	SOUND_BACK = var_6

	var_1(var_43_9, var_43_10, var_43_11, var_6)

	setText = var_1
	findTF = var_43_9

	local var_43_12 = var_43_9(arg_43_0.submitPanel, "bg/txtDesc")

	i18n = var_43_10

	var_1(var_43_12, var_43_10("ryza_task_detail_content"))

	setText = var_1
	findTF = var_43_12

	local var_43_13 = var_43_12(arg_43_0.submitPanel, "bg/txtAward")

	i18n = var_4

	var_1(var_43_13, var_4("ryza_task_detail_award"))

	return
end

function var_0_1.setSubmitAward(arg_48_0, arg_48_1)
	if #arg_48_0.submitItems < #arg_48_1 then
		for iter_48_0 = 1, #arg_48_1 - #arg_48_0.submitItems do
			tf = var_1_10006
			instantiate = var_1_10008
			var_1_10006 = var_1_10006(var_1_10008(arg_48_0.submitItemTpl))
			setParent = var_1_10007

			var_1_10007(var_1_10006, arg_48_0.submitDisplayContent)

			table = var_1_10007

			var_1_10007.insert(arg_48_0.submitItems, var_1_10006)
		end
	end

	for iter_48_1 = 1, #arg_48_0.submitItems do
		local var_48_0 = arg_48_0.submitItems[iter_48_1]
		local var_48_1

		if iter_48_1 <= #arg_48_1 then
			var_48_1 = {
				type = arg_48_1[iter_48_1][1],
				id = arg_48_1[iter_48_1][2],
				count = arg_48_1[iter_48_1][3]
			}
			updateDrop = var_8

			var_8(var_48_0, var_48_1)

			onButton = var_8

			local var_48_2 = arg_48_0
			local var_48_3 = var_48_0

			local function var_48_4()
				local var_49_0 = arg_48_0
				local var_49_1 = var_0.emit

				BaseUI = var_2_10003

				var_49_1(var_49_0, var_2_10003.ON_DROP, var_48_1)

				return
			end

			SFX_PANEL = var_1_10013

			var_8(var_48_2, var_48_3, var_48_4, var_1_10013)

			setActive = var_8

			var_8(var_48_0, true)
		else
			setActive = var_48_1

			var_48_1(var_48_0, false)
		end
	end

	return
end

function var_0_1.willExit(arg_50_0)
	LeanTween = var_1_10001

	local var_50_0 = var_1_10001.isTweening

	go = var_1_10003

	if var_50_0(var_1_10003(arg_50_0._tf)) then
		LeanTween = var_1

		local var_50_1 = var_1.cancel

		go = var_3

		var_50_1(var_3(arg_50_0._tf))
	end

	return
end

return var_0_1
