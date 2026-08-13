class = var_0_10000

local var_0_0 = "IslandActivityCheateTavernDailySignPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.View.page.activity.IslandBaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0.uiView

	arg_1_0.scrollCom = var_1.GetComponent(var_1_0, "LScrollRect")

	function arg_1_0.scrollCom.onInitItem(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.InitAward

		tf = var_2_10004

		var_2_1(var_2_0, var_2_10004(arg_2_0))

		return
	end

	local var_1_1 = arg_1_0.scrollCom

	function var_1_1.onUpdateItem(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.UpdateTask
		local var_3_2 = arg_3_0

		tf = var_2_10006

		var_3_1(var_3_0, var_3_2, var_2_10006(arg_3_1))

		return
	end

	onButton = var_1_1

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.uiGoBtn

	local function var_1_4()
		local var_4_0 = arg_1_0
		local var_4_1 = var_0.emit

		IslandMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.RECORD_PLAYER_POS)

		local var_4_2 = arg_1_0
		local var_4_3 = var_0.emit

		IslandMediator = var_3

		var_4_3(var_4_2, var_3.OPEN_PAGE, "IslandCheaterTavernPrepareMainPage")

		return
	end

	SFX_PANEL = var_1_10006

	var_1_1(var_1_2, var_1_3, var_1_4, var_1_10006)

	onButton = var_1_1

	var_1_1(arg_1_0, arg_1_0.uiRankBtn, function()
		local var_5_0 = arg_1_0
		local var_5_1 = var_0.emit

		BaseUI = var_2_10003

		local var_5_2 = var_2_10003.ON_ADD_SUBLAYER

		Context = var_2_10004

		local var_5_3 = var_2_10004.New
		local var_5_4 = {}

		PlayRoomRankScene = var_2_10007
		var_5_4.viewComponent = var_2_10007
		PlayRoomRankMediator = var_2_10007
		var_5_4.mediator = var_2_10007
		var_5_4.data = {
			gameType = 101
		}

		var_5_1(var_5_0, var_5_2, var_5_3(var_5_4))

		return
	end)

	setText = var_1_1

	local var_1_5 = arg_1_0.uiGoText

	i18n = var_4

	var_1_1(var_1_5, var_4("bar_ui_check1"))

	setText = var_1_1

	local var_1_6 = arg_1_0.uiGotText

	i18n = var_4

	var_1_1(var_1_6, var_4("bar_ui_check2"))

	return
end

function var_0_1.UpdateTaskData(arg_6_0)
	local var_6_0 = arg_6_0.actTaskProxy

	arg_6_0.taskVOs = var_1.getTaskById(var_6_0, arg_6_0.activity.id)

	local var_6_1 = arg_6_0.actTaskProxy

	arg_6_0.finishTaksVOs = var_1.getFinishTaskById(var_6_1, arg_6_0.activity.id)
	arg_6_0.taskDic = {}
	_ = var_1

	var_1.each(arg_6_0.taskVOs, function(arg_7_0)
		arg_6_0.taskDic[arg_7_0.id] = arg_7_0

		return
	end)

	_ = var_1

	var_1.each(arg_6_0.finishTaksVOs, function(arg_8_0)
		arg_6_0.taskDic[arg_8_0.id] = arg_8_0

		return
	end)

	return
end

function var_0_1.InitAward(arg_9_0, arg_9_1)
	return
end

function var_0_1.UpdateTask(arg_10_0, arg_10_1, arg_10_2)
	tf = var_1_10003

	local var_10_0 = var_1_10003(arg_10_2)
	local var_10_1 = arg_10_1 + 1
	local var_10_2 = arg_10_0.taskGroup[var_10_1]
	local var_10_3 = arg_10_0.taskDic[var_10_2]
	local var_10_4 = var_10_0:Find("IslandItemTpl")

	Drop = var_1_10008

	local var_10_5 = var_1_10008.Create(arg_10_0.taskConfig[var_10_2].award_display[1])

	if 1 <= var_10_1 then
		updateCustomDrop = var_9

		var_9(var_10_4, var_10_5, {
			style = "island"
		})

		onButton = var_9

		local var_10_6 = arg_10_0
		local var_10_7 = arg_10_2

		local function var_10_8()
			local var_11_0 = arg_10_0
			local var_11_1 = var_0.emit

			IslandMediator = var_2_10003

			local var_11_2 = var_2_10003.SHOW_MSG_BOX
			local var_11_3 = {}

			i18n = var_2_10005
			var_11_3.title = var_2_10005("island_word_desc")
			IslandMsgBox = var_5
			var_11_3.type = var_5.TYPE_COMMON_DROP_DESCRIBE
			var_11_3.dropData = var_10_5

			var_11_1(var_11_0, var_11_2, var_11_3)

			return
		end

		SFX_PANEL = var_1_10014

		var_9(var_10_6, var_10_7, var_10_8, var_1_10014)

		onButton = var_9

		local var_10_9 = arg_10_0
		local var_10_10 = var_10_0
		local var_10_11 = var_10_0.Find(var_10_10, "canget")

		local function var_10_12()
			pg = var_2_10000

			local var_12_0 = var_2_10000.m02
			local var_12_1 = var_0.sendNotification

			GAME = var_2_10003

			local var_12_2 = var_2_10003.SUBMIT_ACTIVITY_TASK
			local var_12_3 = {
				inIsland = true,
				act_id = arg_10_0.activity.id
			}
			local var_12_4 = arg_10_0

			var_12_3.task_ids = var_5.GetCanSubmitTaskIds(var_12_4)

			var_12_1(var_12_0, var_12_2, var_12_3)

			return
		end

		SFX_PANEL = var_10_10

		var_9(var_10_9, var_10_11, var_10_12, var_10_10)
	end

	setText = var_9

	local var_10_13 = var_10_0
	local var_10_14 = var_10_0.Find(var_10_13, "target")
	local var_10_15 = "Day"

	tostring = var_10_13

	var_9(var_10_14, var_10_15 .. var_10_13(var_10_1))

	setActive = var_9

	var_9(var_10_0:Find("got"), var_10_3 and var_10_3:isOver())

	setActive = var_9

	var_9(var_10_0:Find("canget"), var_10_3 and var_10_3:getTaskStatus() == 1 and not var_10_3:isOver())

	setActive = var_9

	var_9(var_10_0:Find("lock"), var_10_3 and var_10_3:getTaskStatus() == -1 and not var_10_3:isOver())

	return
end

function var_0_1.OnDataSetting(arg_13_0)
	getProxy = var_1_10001
	ActivityTaskProxy = var_1_10003
	arg_13_0.actTaskProxy = var_1_10001(var_1_10003)
	underscore = var_1

	local var_13_0 = var_1.flatten
	local var_13_1 = arg_13_0.activity

	arg_13_0.taskGroup = var_13_0(var_3.getConfig(var_13_1, "config_data"))
	pg = var_1
	arg_13_0.taskConfig = var_1.task_data_template

	return
end

function var_0_1.OnFirstFlush(arg_14_0)
	local var_14_0 = arg_14_0.scrollCom

	var_1.SetTotalCount(var_14_0, 5)

	return
end

function var_0_1.OnUpdateFlush(arg_15_0)
	arg_15_0:UpdateTaskData()

	local var_15_0 = arg_15_0.scrollCom

	var_1.SetTotalCount(var_15_0, 5)

	PlayRoomTools = var_1

	local var_15_1 = var_1.GetPtScrore(arg_15_0:GetGameType())

	setText = var_1_10002

	var_1_10002(arg_15_0.uiPtNum, var_15_1)

	PlayRoomTools = var_1_10002

	local var_15_2 = var_1_10002.GetPtScoreIcon(arg_15_0:GetGameType())

	GetImageSpriteFromAtlasAsync = var_3

	var_3("Island/IslandCheaterTavernIcon/" .. var_15_2, "", arg_15_0.uiPtIcon)

	return
end

function var_0_1.OnShowFlush(arg_16_0)
	return
end

function var_0_1.GetGameType(arg_17_0)
	return 101
end

function var_0_1.GetCanSubmitTaskIds(arg_18_0)
	local var_18_0 = {}

	ipairs = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10002(arg_18_0.taskVOs) do
		if iter_18_1:getTaskStatus() == 1 and not iter_18_1:isOver() then
			table = var_7

			var_7.insert(var_18_0, iter_18_1.id)
		end
	end

	return var_18_0
end

function var_0_1.OnDestroy(arg_19_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_19_0.scrollCom)

	return
end

return var_0_1
