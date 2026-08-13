class = var_0_10000

local var_0_0 = "AuctionGameLoginPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.sign = var_1.Find(var_1_1, "sign")

	local var_1_2 = arg_1_0.bg

	arg_1_0.playerInfo = var_1.Find(var_1_2, "playerInfo")

	local var_1_3 = arg_1_0.playerInfo

	arg_1_0.playerFrame = var_1.Find(var_1_3, "frame")

	local var_1_4 = arg_1_0.playerInfo

	arg_1_0.playerIcon = var_1.Find(var_1_4, "frame/icon")

	local var_1_5 = arg_1_0.playerInfo

	arg_1_0.playerName = var_1.Find(var_1_5, "name")

	local var_1_6 = arg_1_0.playerInfo

	arg_1_0.playerCount = var_1.Find(var_1_6, "count")
	arg_1_0.items = {}

	for iter_1_0 = 1, arg_1_0.sign.childCount do
		local var_1_7 = arg_1_0
		local var_1_8 = arg_1_0.getItem(var_1_7, iter_1_0)

		table = var_1_7

		var_1_7.insert(arg_1_0.items, var_1_8)
	end

	local var_1_9 = arg_1_0.bg

	arg_1_0.btnGet = var_1.Find(var_1_9, "btnGet")
	setText = var_1

	local var_1_10 = arg_1_0.btnGet
	local var_1_11 = var_2.Find(var_1_10, "text")

	i18n = var_1_10

	var_1(var_1_11, var_1_10("auction_signin_collect"))

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002
	arg_2_0.taskProxy = var_1_10001(var_1_10002)

	local var_2_0 = arg_2_0.activity

	arg_2_0.taskGroup = var_1.getConfig(var_2_0, "config_data")

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.btnGet, function()
		local var_4_0 = {}

		getProxy = var_2_10001
		PlayerProxy = var_2_10002

		local var_4_1 = var_2_10001(var_2_10002)
		local var_4_2 = var_1.getRawData(var_4_1)

		pg = var_4_1

		local var_4_3 = var_4_1.gameset.urpt_chapter_max.description[1]

		LOCK_UR_SHIP = var_2_10004

		if var_2_10004 then
			var_2_10004 = 0
		else
			getProxy = var_2_10004
			BagProxy = var_2_10005

			local var_4_4 = var_2_10004(var_2_10005)

			var_2_10004 = var_2_10004.GetLimitCntById(var_4_4, var_4_3)
		end

		local var_4_5 = arg_3_0
		local var_4_6, var_4_7 = var_5.checkCanGetList(var_4_5)

		table = var_2_10007

		if var_2_10007.isEmpty(var_4_7) then
			return
		end

		Task = var_7

		local var_4_8, var_4_9 = var_7.StaticJudgeOverflow(var_4_2.gold, var_4_2.oil, var_2_10004, true, true, var_4_6)

		if var_4_8 then
			table = var_9

			var_9.insert(var_4_0, function(arg_5_0)
				pg = var_3_10001

				local var_5_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_5_1 = var_1.ShowMsgBox
				local var_5_2 = {}

				MSGBOX_TYPE_ITEM_BOX = var_3_10004
				var_5_2.type = var_3_10004
				i18n = var_3_10004
				var_5_2.content = var_3_10004("award_max_warning")
				var_5_2.items = var_4_9
				var_5_2.onYes = arg_5_0

				var_5_1(var_5_0, var_5_2)

				return
			end)
		end

		seriesAsync = var_9

		var_9(var_4_0, function()
			local var_6_0 = arg_3_0
			local var_6_1 = var_0.emit

			ActivityMediator = var_3_10002

			var_6_1(var_6_0, var_3_10002.ON_TASK_SUBMIT_ONESTEP, var_4_7)

			return
		end)

		return
	end)

	return
end

function var_0_1.checkCanGetList(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = {}

	local function var_7_2(arg_8_0)
		ipairs = var_2_10001

		for iter_8_0, iter_8_1 in var_2_10001(var_7_0) do
			if iter_8_1[1] == arg_8_0[1] and iter_8_1[2] == arg_8_0[2] then
				iter_8_1[3] = iter_8_1[3] + arg_8_0[3]

				return
			end
		end

		table = var_1

		var_1.insert(var_7_0, {
			arg_8_0[1],
			arg_8_0[2],
			arg_8_0[3]
		})

		return
	end

	ipairs = var_1_10004

	for iter_7_0, iter_7_1 in var_1_10004(arg_7_0.taskGroup[1]) do
		local var_7_3 = arg_7_0.taskProxy
		local var_7_4, var_7_5

		if var_9.getTaskById(var_7_3, iter_7_1) then
			::label_7_0::

			var_7_4 = var_9
			var_7_5 = var_9.getTaskStatus(var_7_4) == 1
		end

		if var_7_5 then
			pg = var_7_4

			local var_7_6 = var_7_4.task_data_template[iter_7_1]

			ipairs = var_1_10012

			for iter_7_2, iter_7_3 in var_1_10012(var_7_6.award_display) do
				var_7_2(iter_7_3)
			end

			table = var_1_10012

			var_1_10012.insert(var_7_1, {
				id = iter_7_1
			})
		end
	end

	return var_7_0, var_7_1
end

function var_0_1.OnUpdateFlush(arg_9_0)
	if not arg_9_0.activity or not arg_9_0.taskGroup then
		return
	end

	local var_9_0 = arg_9_0.activity

	arg_9_0.nday = var_1.getNDay(var_9_0)

	local var_9_1 = arg_9_0

	arg_9_0.setPlayerInfo(var_9_1)

	local var_9_2 = false

	ipairs = var_9_1

	for iter_9_0, iter_9_1 in var_9_1(arg_9_0.items) do
		local var_9_3 = arg_9_0.taskGroup[1][iter_9_0]

		pg = var_1_10008
		var_1_10008 = var_1_10008.task_data_template[var_9_3]
		Drop = var_1_10009
		var_1_10009 = var_1_10009.Create(var_1_10008.award_display[1])
		updateDrop = var_10

		var_10(iter_9_1.item, var_1_10009)

		onButton = var_10

		local var_9_4 = arg_9_0
		local var_9_5 = iter_9_1.frame

		local function var_9_6()
			local var_10_0 = arg_9_0
			local var_10_1 = var_0.emit

			BaseUI = var_2_10002

			var_10_1(var_10_0, var_2_10002.ON_DROP, var_1_10009)

			return
		end

		SFX_PANEL = var_1_10014

		var_10(var_9_4, var_9_5, var_9_6, var_1_10014)

		local var_9_7 = arg_9_0.taskProxy
		local var_9_9

		if not var_10.getTaskById(var_9_7, var_9_3) then
			local var_9_8 = arg_9_0.taskProxy

			var_9_9 = var_10.getFinishTaskById(var_9_8, var_9_3)
		end

		local var_9_10 = not not var_9_9
		local var_9_11 = var_9_9 and var_9_9:getTaskStatus() == 1
		local var_9_12

		if var_9_9 then
			::label_9_0::

			var_1_10014 = var_9_9
			var_9_12 = var_9_9.getTaskStatus(var_1_10014) == 2
		end

		var_9_2 = var_9_2 or var_9_11
		setActive = var_1_10014

		var_1_10014(iter_9_1.lock, not var_9_10)

		setActive = var_1_10014

		var_1_10014(iter_9_1.get, var_9_11 and not var_9_12)

		setActive = var_1_10014

		var_1_10014(iter_9_1.got, var_9_12)

		onButton = var_1_10014

		local var_9_13 = arg_9_0
		local var_9_14 = iter_9_1.get

		local function var_9_15()
			local var_11_0 = {}
			local var_11_1 = var_1_10008.award_display

			getProxy = var_2_10002
			PlayerProxy = var_2_10003

			local var_11_2 = var_2_10002(var_2_10003)
			local var_11_3 = var_2.getRawData(var_11_2)

			pg = var_11_2

			local var_11_4 = var_11_2.gameset.urpt_chapter_max.description[1]

			LOCK_UR_SHIP = var_2_10005

			if var_2_10005 then
				var_2_10005 = 0
			else
				getProxy = var_2_10005
				BagProxy = var_2_10006
				var_2_10006 = var_2_10005(var_2_10006)
				var_2_10005 = var_2_10005.GetLimitCntById(var_2_10006, var_11_4)
			end

			Task = var_2_10006

			local var_11_5, var_11_6 = var_2_10006.StaticJudgeOverflow(var_11_3.gold, var_11_3.oil, var_2_10005, true, true, var_11_1)

			if var_11_5 then
				table = var_8

				var_8.insert(var_11_0, function(arg_12_0)
					pg = var_3_10001

					local var_12_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_12_1 = var_1.ShowMsgBox
					local var_12_2 = {}

					MSGBOX_TYPE_ITEM_BOX = var_3_10004
					var_12_2.type = var_3_10004
					i18n = var_3_10004
					var_12_2.content = var_3_10004("award_max_warning")
					var_12_2.items = var_11_6
					var_12_2.onYes = arg_12_0

					var_12_1(var_12_0, var_12_2)

					return
				end)
			end

			seriesAsync = var_8

			var_8(var_11_0, function()
				local var_13_0 = arg_9_0
				local var_13_1 = var_0.emit

				ActivityMediator = var_3_10002

				var_13_1(var_13_0, var_3_10002.ON_TASK_SUBMIT, var_9_9)

				return
			end)

			return
		end

		SFX_PANEL = var_1_10018

		var_1_10014(var_9_13, var_9_14, var_9_15, var_1_10018)
	end

	setGray = var_2

	var_2(arg_9_0.btnGet, not var_9_2)

	return
end

function var_0_1.getItem(arg_14_0, arg_14_1)
	if arg_14_0.items[arg_14_1] then
		return arg_14_0.items[arg_14_1]
	end

	local var_14_0 = {}
	local var_14_1 = arg_14_0.sign
	local var_14_2 = var_3.GetChild(var_14_1, arg_14_1 - 1)

	var_14_0.item = var_3.Find(var_14_2, "item")
	var_14_0.frame = var_3:Find("frame")
	var_14_0.got = var_3:Find("got")
	var_14_0.get = var_3:Find("get")
	var_14_0.lock = var_3:Find("lock")

	return var_14_0
end

function var_0_1.setPlayerInfo(arg_15_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_15_0 = var_1_10001(var_1_10002)
	local var_15_1 = var_1.getRawData(var_15_0)
	local var_15_2 = var_1.GetShipPhantomMarks(var_15_1)[1]

	getProxy = var_15_1
	BayProxy = var_1_10004

	local var_15_3 = var_15_1(var_1_10004)
	local var_15_4 = var_3.GetShipPhantom(var_15_3, var_15_2)

	GetImageSpriteFromAtlasAsync = var_15_3

	var_15_3("SquareIcon/" .. var_15_4:getPainting(), "", arg_15_0.playerIcon)

	setText = var_15_3

	var_15_3(arg_15_0.playerName, var_1.name)

	setText = var_15_3

	local var_15_5 = arg_15_0.playerCount

	StringHelper = var_6

	local var_15_6 = var_6.ForamtNumberK

	AuctionGameTools = var_7

	var_15_3(var_15_5, var_15_6(var_7.GetCurrencyCnt()))

	return
end

function var_0_1.OnDestroy(arg_16_0)
	if arg_16_0.iconView then
		local var_16_0 = arg_16_0.iconView

		var_1.Dispose(var_16_0)

		arg_16_0.iconView = nil
	end

	return
end

return var_0_1
