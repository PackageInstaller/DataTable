class = var_0_10000

local var_0_0 = "AuctionGameTaskScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.TASK_TYPE = {
	DAILY = 1,
	CHALLENGE = 2
}

function var_0_1.getUIName(arg_1_0)
	return "AuctionGameTaskUI"
end

function var_0_1.init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiCloseBtn

	local function var_2_2()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	setText = var_1_10001

	local var_2_3 = arg_2_0.uiGetAllText

	i18n = var_2_1

	var_1_10001(var_2_3, var_2_1("auction_signin_collect"))

	onButton = var_1_10001

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.uiGetAllBtn

	local function var_2_6()
		local var_4_0 = {}

		pg = var_2_10001

		local var_4_1 = var_2_10001.NewGuideMgr.GetInstance()

		if var_1.IsBusy(var_4_1) then
			ipairs = var_1

			for iter_4_0, iter_4_1 in var_1(arg_2_0.dailyTaskList) do
				if iter_4_1:getTaskStatus() == 1 then
					table = var_6

					var_6.insert(var_4_0, iter_4_1.id)
				end
			end

			ipairs = var_1

			for iter_4_2, iter_4_3 in var_1(arg_2_0.challengeTaskList) do
				if iter_4_3:getTaskStatus() == 1 then
					table = var_6

					var_6.insert(var_4_0, iter_4_3.id)
				end
			end
		else
			ipairs = var_1

			for iter_4_4, iter_4_5 in var_1(arg_2_0.taskList) do
				if iter_4_5:getTaskStatus() == 1 then
					table = var_6

					var_6.insert(var_4_0, iter_4_5.id)
				end
			end
		end

		if #var_4_0 <= 0 then
			return
		end

		local var_4_2 = arg_2_0
		local var_4_3 = var_1.emit

		AuctionGameTaskMediator = var_2_10003

		var_4_3(var_4_2, var_2_10003.ON_ACTIVITY_TASK_SUBMIT_ONESTEP, arg_2_0.taskActivityID, var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_4, var_2_5, var_2_6, var_1_10005)

	onButton = var_1_10001

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0.uiDailyBtn

	local function var_2_9()
		local var_5_0 = arg_2_0

		var_0.OnSwitchBtn(var_5_0, var_0_1.TASK_TYPE.DAILY)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_7, var_2_8, var_2_9, var_1_10005)

	onButton = var_1_10001

	local var_2_10 = arg_2_0
	local var_2_11 = arg_2_0.uiChallengeBtn

	local function var_2_12()
		local var_6_0 = arg_2_0

		var_0.OnSwitchBtn(var_6_0, var_0_1.TASK_TYPE.CHALLENGE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_10, var_2_11, var_2_12, var_1_10005)

	setText = var_1_10001

	local var_2_13 = arg_2_0.uiDailyText

	i18n = var_2_11

	var_1_10001(var_2_13, var_2_11("auction_task_daily"))

	setText = var_1_10001

	local var_2_14 = arg_2_0.uiChallengeText

	i18n = var_3

	var_1_10001(var_2_14, var_3("auction_task_challenge"))

	arg_2_0.itemList = {}
	GetComponent = var_1
	arg_2_0.uiLScroll = var_1(arg_2_0.uiScroll, "LScrollRect")
	handler = var_1
	arg_2_0.onInitItemHandler = var_1(arg_2_0, arg_2_0.OnInitItem)
	handler = var_1
	arg_2_0.onUpdateItemHandler = var_1(arg_2_0, arg_2_0.OnUpdateItem)
	arg_2_0.uiLScroll.onInitItem = arg_2_0.onInitItemHandler
	arg_2_0.uiLScroll.onUpdateItem = arg_2_0.onUpdateItemHandler

	return
end

function var_0_1.didEnter(arg_7_0)
	arg_7_0:OverlayPanel(arg_7_0._tf, {})

	setPaintingPrefabAsync = var_1

	local var_7_0 = arg_7_0.uiPaintingTf

	pg = var_3

	var_1(var_7_0, var_3.ship_skin_template[900284].painting, "chuanwu", nil, {
		skinID = 900284
	})
	arg_7_0:OnSwitchBtn(var_0_1.TASK_TYPE.DAILY)

	return
end

function var_0_1.willExit(arg_8_0)
	arg_8_0:UnOverlayPanel(arg_8_0._tf)

	retPaintingPrefab = var_1

	local var_8_0 = arg_8_0.uiPaintingTf

	pg = var_3

	var_1(var_8_0, var_3.ship_skin_template[900284].painting)

	arg_8_0.uiLScroll.onInitItem = nil
	arg_8_0.uiLScroll.onUpdateItem = nil
	arg_8_0.onInitItemHandler = nil
	arg_8_0.onUpdateItemHandler = nil

	return
end

function var_0_1.OnSwitchBtn(arg_9_0, arg_9_1)
	if arg_9_1 == var_0_1.TASK_TYPE.DAILY then
		setTextColor = var_2

		local var_9_0 = arg_9_0.uiDailyText

		Color = var_1_10004

		var_2(var_9_0, var_1_10004.NewHex("#FFFFFF"))

		setTextColor = var_2

		local var_9_1 = arg_9_0.uiChallengeText

		Color = var_1_10004

		var_2(var_9_1, var_1_10004.NewHex("#393A3C"))

		setActive = var_2

		var_2(arg_9_0.uiDailySelectedGo, true)

		setActive = var_2

		var_2(arg_9_0.uiChallengeSelectedGo, false)
	else
		setTextColor = var_2

		local var_9_2 = arg_9_0.uiDailyText

		Color = var_1_10004

		var_2(var_9_2, var_1_10004.NewHex("#393A3C"))

		setTextColor = var_2

		local var_9_3 = arg_9_0.uiChallengeText

		Color = var_4

		var_2(var_9_3, var_4.NewHex("#FFFFFF"))

		setActive = var_2

		var_2(arg_9_0.uiDailySelectedGo, false)

		setActive = var_2

		var_2(arg_9_0.uiChallengeSelectedGo, true)
	end

	arg_9_0.selectedType = arg_9_1

	arg_9_0:RefreshUI()

	return
end

function var_0_1.GetTaskList(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = {}

	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_10_2 = var_1_10003(var_1_10004)
	local var_10_3 = var_3.getActivityByType

	ActivityConst = var_1_10006

	local var_10_4 = var_10_3(var_10_2, var_1_10006.ACTIVITY_TYPE_AUCTION_GAME)
	local var_10_5 = var_4.getConfig(var_10_4, "config_client").taskActID

	pg = var_10_4

	local var_10_6 = var_10_4.activity_template[var_10_5].config_data

	arg_10_0.taskActivityID = var_10_5
	getProxy = var_7
	TaskProxy = var_1_10008

	local var_10_7 = var_7(var_1_10008)

	ipairs = var_1_10008

	for iter_10_0, iter_10_1 in var_1_10008(var_10_6) do
		local var_10_8

		if not var_10_7:getTaskVO(iter_10_1) then
			Task = var_10_8
			var_10_8 = var_10_8.New({
				id = iter_10_1
			})
		end

		if var_10_8:IsActRoutineType() then
			table = var_14

			var_14.insert(var_10_0, var_10_8)
		else
			table = var_14

			var_14.insert(var_10_1, var_10_8)
		end
	end

	return var_10_0, var_10_1
end

function var_0_1.RefreshUI(arg_11_0)
	arg_11_0.dailyTaskList, arg_11_0.challengeTaskList = arg_11_0:GetTaskList()

	if arg_11_0.selectedType == var_0_1.TASK_TYPE.DAILY then
		arg_11_0.taskList = arg_11_0.dailyTaskList
		setGray = var_1

		var_1(arg_11_0.uiGetAllBtn, not arg_11_0:IsDailyTip())
	else
		arg_11_0.taskList = arg_11_0.challengeTaskList
		setGray = var_1

		var_1(arg_11_0.uiGetAllBtn, not arg_11_0:IsChallengeTip())
	end

	arg_11_0:Sort(arg_11_0.taskList)

	local var_11_0 = arg_11_0.uiLScroll

	var_1.SetTotalCount(var_11_0, #arg_11_0.taskList)

	setActive = var_1

	var_1(arg_11_0.uiDailyTipGo, arg_11_0:IsDailyTip())

	setActive = var_1

	var_1(arg_11_0.uiChallengeTipGo, arg_11_0:IsChallengeTip())

	return
end

function var_0_1.OnInitItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.itemList

	AuctionGameTaskItem = var_1_10003

	local var_12_1 = var_1_10003.New

	tf = var_1_10004
	var_12_0[arg_12_1] = var_12_1(var_1_10004(arg_12_1), arg_12_0)

	return
end

function var_0_1.OnUpdateItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0

	if arg_13_0.itemList[arg_13_2] == nil then
		arg_13_0:OnInitItem(arg_13_2)

		var_13_0 = arg_13_0.itemList[arg_13_2]
	end

	local var_13_1 = arg_13_0.taskList[arg_13_1 + 1]

	var_13_0:SetData(var_13_1)

	return
end

function var_0_1.Sort(arg_14_0)
	local function var_14_0(arg_15_0, arg_15_1, arg_15_2)
		return (function(arg_16_0)
			ipairs = var_3_10001

			for iter_16_0, iter_16_1 in var_3_10001(arg_15_2) do
				if arg_16_0 == iter_16_1 then
					return iter_16_0
				end
			end

			return
		end)(arg_15_0) < var_3(arg_15_1)
	end

	table = var_1_10002

	var_1_10002.sort(arg_14_0.taskList, function(arg_17_0, arg_17_1)
		if arg_17_0:getTaskStatus() == arg_17_1:getTaskStatus() then
			return arg_17_0.id < arg_17_1.id
		end

		return var_14_0(var_2, var_3, {
			1,
			0,
			2,
			-1
		})
	end)

	return
end

function var_0_1.IsDailyTip(arg_18_0)
	ipairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(arg_18_0.dailyTaskList) do
		if iter_18_1:getTaskStatus() == 1 then
			return true
		end
	end

	return false
end

function var_0_1.IsChallengeTip(arg_19_0)
	ipairs = var_1_10001

	for iter_19_0, iter_19_1 in var_1_10001(arg_19_0.challengeTaskList) do
		if iter_19_1:getTaskStatus() == 1 then
			return true
		end
	end

	return false
end

return var_0_1
