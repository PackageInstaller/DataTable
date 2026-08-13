class = var_0_10000

local var_0_0 = "CoreURExchangeTemplatePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))

var_0_1.SP_FIRST = 1
var_0_1.SP_DAILY = 2
var_0_1.RANDOM_DAILY = 3
var_0_1.CHALLANGE = 4
var_0_1.MINI_GAME = 5
var_0_1.SHOP_BUY = 6
var_0_1.GO_TASK = 7
var_0_1.MINI_GAME_ACT = 8

function var_0_1.OnInit(arg_1_0)
	getProxy = var_1_10001
	ShopsProxy = var_1_10003
	arg_1_0.shopProxy = var_1_10001(var_1_10003)
	getProxy = var_1
	PlayerProxy = var_1_10003
	arg_1_0.playerProxy = var_1(var_1_10003)
	getProxy = var_1
	TaskProxy = var_1_10003
	arg_1_0.taskProxy = var_1(var_1_10003)
	getProxy = var_1
	ShopsProxy = var_1_10003
	arg_1_0.shopProxy = var_1(var_1_10003)

	local var_1_0 = arg_1_0._tf

	arg_1_0._tasksTF = var_1.Find(var_1_0, "AD/tasks")

	local var_1_1 = arg_1_0._tf

	arg_1_0._taskTpl = var_1.Find(var_1_1, "AD/task_tpl")

	local var_1_2 = arg_1_0._tf

	arg_1_0._ptTip = var_1.Find(var_1_2, "pt_tip")

	local var_1_3 = arg_1_0._ptTip

	arg_1_0._tipText = var_1.Find(var_1_3, "bg/Text")

	local var_1_4 = arg_1_0._tf

	arg_1_0._btnSimulate = var_1.Find(var_1_4, "AD/btn_simulate")

	local var_1_5 = arg_1_0._tf

	arg_1_0._btnExchange = var_1.Find(var_1_5, "AD/btn_exchange")

	local var_1_6 = arg_1_0._tf

	arg_1_0._btnHelp = var_1.Find(var_1_6, "AD/btn_help")

	local var_1_7 = arg_1_0._tf

	arg_1_0._ptText = var_1.Find(var_1_7, "AD/icon/pt")
	UIItemList = var_1
	arg_1_0.uilist = var_1.New(arg_1_0._tasksTF, arg_1_0._taskTpl)
	setActive = var_1

	var_1(arg_1_0._taskTpl, false)

	local var_1_8 = arg_1_0._tf

	arg_1_0._msgBox = var_1.Find(var_1_8, "msg_box")

	local var_1_9 = arg_1_0._tf

	arg_1_0._msgBoxBtnCancel = var_1.Find(var_1_9, "msg_box/btn_cancel")

	local var_1_10 = arg_1_0._tf

	arg_1_0._msgBoxBtnConfirm = var_1.Find(var_1_10, "msg_box/btn_confirm")

	local var_1_11 = arg_1_0._tf

	arg_1_0._msgBoxLabel = var_1.Find(var_1_11, "msg_box/label/text_cn")

	local var_1_12 = arg_1_0._tf

	arg_1_0._msgBoxItem = var_1.Find(var_1_12, "msg_box/item/IconTpl")

	local var_1_13 = arg_1_0._tf

	arg_1_0._msgBoxItemName = var_1.Find(var_1_13, "msg_box/item/name")

	local var_1_14 = arg_1_0._tf

	arg_1_0._msgBoxItemDesc = var_1.Find(var_1_14, "msg_box/item/desc")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity

	arg_2_0.config = var_1.getConfig(var_2_0, "config_client")
	arg_2_0.taskConfig = arg_2_0.config.taskConfig
	arg_2_0.ptId = arg_2_0.config.ptId
	arg_2_0.uPtId = arg_2_0.config.uPtId
	arg_2_0.goodsId = arg_2_0.config.goodsId
	arg_2_0.shopId = arg_2_0.config.shopId
	arg_2_0.length = #arg_2_0.goodsId + 1

	local var_2_1 = arg_2_0.shopProxy

	arg_2_0.actShop = var_1.getActivityShopById(var_2_1, arg_2_0.shopId)

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	setText = var_1_10001

	local var_3_0 = arg_3_0._tipText

	i18n = var_1_10004

	var_1_10001(var_3_0, var_1_10004("UrExchange_Pt_NotEnough"))

	getProxy = var_1_10001
	ActivityProxy = var_3_0

	local var_3_1 = var_1_10001(var_3_0)

	arg_3_0.isLinkActOpen = var_1.getActivityById(var_3_1, arg_3_0.config.activitytime) and not var_1:isEnd()
	setActive = var_2

	var_2(arg_3_0._tasksTF, arg_3_0.isLinkActOpen)

	local var_3_2 = arg_3_0.uilist

	var_2.make(var_3_2, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_3_0

			var_3.UpdateTask(var_4_0, arg_4_1, arg_4_2)
		end

		return
	end)

	onButton = var_2

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._btnSimulate

	local function var_3_5()
		local var_5_1

		if arg_3_0.config.expedition == 0 then
			pg = var_5_1

			local var_5_0 = var_5_1.TipsMgr.GetInstance()

			var_5_1 = var_5_1.ShowTips
			i18n = var_2_10003

			var_5_1(var_5_0, var_2_10003("tech_simulate_closed"))
		else
			i18n = var_5_1

			local var_5_2 = var_5_1("blueprint_simulation_confirm")

			pg = var_2_10001

			local var_5_3 = var_2_10001.MsgboxMgr.GetInstance()

			var_1.ShowMsgBox(var_5_3, {
				content = var_5_2,
				onYes = function()
					local var_6_0 = arg_3_0
					local var_6_1 = var_0.emit

					ActivityMediator = var_3_10003

					local var_6_2 = var_3_10003.ON_SIMULATION_COMBAT
					local var_6_3 = {
						warnMsg = "tech_simulate_quit",
						stageId = arg_3_0.config.expedition
					}

					local function var_6_4()
						return
					end

					SFX_PANEL = var_3_10006

					var_6_1(var_6_0, var_6_2, var_6_3, var_6_4, var_3_10006)

					return
				end
			})
		end

		return
	end

	SFX_CONFIRM = var_1_10007

	var_2(var_3_3, var_3_4, var_3_5, var_1_10007)

	onButton = var_2

	var_2(arg_3_0, arg_3_0._msgBoxBtnCancel, function()
		local var_8_0 = arg_3_0

		var_0.closeMsgBox(var_8_0)

		return
	end)

	onButton = var_2

	var_2(arg_3_0, arg_3_0._msgBox, function()
		local var_9_0 = arg_3_0

		var_0.closeMsgBox(var_9_0)

		return
	end)

	onButton = var_2

	var_2(arg_3_0, arg_3_0._msgBoxBtnConfirm, function()
		local var_10_0 = arg_3_0

		var_0.closeMsgBox(var_10_0)

		local var_10_1 = arg_3_0
		local var_10_2 = var_0.emit

		ActivityMediator = var_2_10003

		var_10_2(var_10_1, var_2_10003.ON_ACT_SHOPPING, arg_3_0.shopId, 1, arg_3_0.curGoods.id, 1)

		pg = var_10_2

		local var_10_3 = var_10_2.GameTrackerMgr.GetInstance()
		local var_10_4 = var_0.Record

		GameTrackerBuilder = var_3

		var_10_4(var_10_3, var_3.BuildUrRedeem(arg_3_0.curGoods.commodity_id, 2))

		return
	end)

	onButton = var_2

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._btnExchange

	local function var_3_8()
		local var_11_0

		if arg_3_0.canExchange then
			Drop = var_11_0
			var_11_0 = var_11_0.Create({
				arg_3_0.curGoods.commodity_type,
				arg_3_0.curGoods.commodity_id,
				1
			})
			updateDrop = var_2_10001

			var_2_10001(arg_3_0._msgBoxItem, var_11_0)

			setText = var_2_10001

			var_2_10001(arg_3_0._msgBoxItemName, var_11_0:getName())

			setText = var_2_10001

			var_2_10001(arg_3_0._msgBoxItemDesc, var_11_0.desc)

			pg = var_2_10001

			local var_11_1 = var_2_10001.UIMgr.GetInstance()

			var_2_10001.BlurPanel(var_11_1, arg_3_0._msgBox)

			setActive = var_2_10001

			var_2_10001(arg_3_0._msgBox, true)

			var_2_10001 = arg_3_0
			var_2_10001.isMsgBoxShow = true
		else
			setActive = var_11_0

			var_11_0(arg_3_0._ptTip, true)

			local var_11_2 = arg_3_0

			LeanTween = var_2_10001

			local var_11_3 = var_2_10001.delayedCall
			local var_11_4 = 1

			System = var_2_10004
			var_11_2.leantween = var_11_3(var_11_4, var_2_10004.Action(function()
				setActive = var_3_10000

				var_3_10000(arg_3_0._ptTip, false)

				return
			end)).uniqueId
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_3_6, var_3_7, var_3_8, var_1_10007)

	onButton = var_2

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0._btnHelp

	local function var_3_11()
		pg = var_2_10000

		local var_13_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_13_1 = var_0.ShowMsgBox
		local var_13_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_13_2.type = var_2_10004
		i18n = var_2_10004
		var_13_2.helps = var_2_10004("UrExchange_Pt_help")

		var_13_1(var_13_0, var_13_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_3_9, var_3_10, var_3_11, var_1_10007)

	return
end

function var_0_1.CheckSingleTask(arg_14_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)
	local var_14_1

	if not var_1.getTaskById(var_14_0, arg_14_0) then
		var_14_1 = var_1:getFinishTaskById(arg_14_0)
	end

	if var_14_1 then
		return var_14_1:getTaskStatus()
	else
		return -1
	end

	return
end

var_0_1.taskTypeDic = {
	[var_0_1.SP_FIRST] = function(arg_15_0, arg_15_1)
		local var_15_0 = (var_0_1.CheckSingleTask(arg_15_1[1]) == 2 and 1 or 0) .. "/1"

		local function var_15_1()
			local var_16_0 = arg_15_0
			local var_16_1 = var_0.emit

			ActivityMediator = var_2_10003

			local var_16_2 = var_2_10003.EVENT_GO_SCENE

			SCENE = var_2_10004

			local var_16_3 = var_2_10004.TASK
			local var_16_4 = {}

			TaskScene = var_2_10006
			var_16_4.page = var_2_10006.PAGE_TYPE_ACT
			var_16_4.targetId = arg_15_1[1]

			var_16_1(var_16_0, var_16_2, var_16_3, var_16_4)

			return
		end

		return var_15_0, var_2 ~= 1 and var_15_1 or nil
	end,
	[var_0_1.SP_DAILY] = function(arg_17_0, arg_17_1)
		local function var_17_0()
			local var_18_0 = arg_17_0
			local var_18_1 = var_0.emit

			ActivityMediator = var_2_10003

			local var_18_2 = var_2_10003.EVENT_GO_SCENE

			SCENE = var_2_10004

			local var_18_3 = var_2_10004.LEVEL
			local var_18_4 = {}

			pg = var_2_10006
			var_18_4.mapIdx = var_2_10006.chapter_template[arg_17_1[1]].map

			var_18_1(var_18_0, var_18_2, var_18_3, var_18_4)

			return
		end

		getProxy = var_1_10003
		ChapterProxy = var_1_10005

		local var_17_1 = var_1_10003(var_1_10005)
		local var_17_2 = var_3.getChapterById(var_17_1, arg_17_1[1])
		local var_17_3

		if var_3.isUnlock(var_17_2) and var_3:isPlayerLVUnlock() then
			var_17_3 = not var_3:enoughTimes2Start()
		end

		return var_17_3 and "1/1" or "0/1", not var_17_3 and var_17_0 or nil
	end,
	[var_0_1.RANDOM_DAILY] = function(arg_19_0, arg_19_1)
		local var_19_0

		local function var_19_1()
			local var_20_0 = arg_19_0
			local var_20_1 = var_0.emit

			ActivityMediator = var_2_10003

			local var_20_2 = var_2_10003.EVENT_GO_SCENE

			SCENE = var_2_10004

			local var_20_3 = var_2_10004.TASK
			local var_20_4 = {}

			TaskScene = var_2_10006
			var_20_4.page = var_2_10006.PAGE_TYPE_ACT
			var_20_4.targetId = var_19_0

			var_20_1(var_20_0, var_20_2, var_20_3, var_20_4)

			return
		end

		local var_19_2 = 0
		local var_19_3 = 0

		pairs = var_1_10006

		for iter_19_0, iter_19_1 in var_1_10006(arg_19_1) do
			if var_0_1.CheckSingleTask(iter_19_1) == 2 then
				var_19_3 = var_19_3 + 1
			elseif var_11 == 1 or var_11 == 0 then
				var_19_2 = var_19_2 + 1
				var_19_0 = iter_19_1
			end
		end

		local var_19_4 = var_19_2 + var_19_3

		return var_19_3 .. "/" .. var_19_4, var_19_2 ~= 0 and var_19_1 or nil
	end,
	[var_0_1.CHALLANGE] = function(arg_21_0, arg_21_1)
		local var_21_0 = 0
		local var_21_1

		pairs = var_1_10004

		for iter_21_0, iter_21_1 in var_1_10004(arg_21_1) do
			var_21_0 = var_21_0 + (var_0_1.CheckSingleTask(iter_21_1) == 2 and 1 or 0)

			if var_9 == 0 then
				var_21_1 = var_21_1 or iter_21_1
			end
		end

		local var_21_2 = var_21_0 .. "/" .. #arg_21_1

		local function var_21_3()
			local var_22_0 = arg_21_0
			local var_22_1 = var_0.emit

			ActivityMediator = var_2_10003

			local var_22_2 = var_2_10003.EVENT_GO_SCENE

			SCENE = var_2_10004

			local var_22_3 = var_2_10004.TASK
			local var_22_4 = {}

			TaskScene = var_2_10006
			var_22_4.page = var_2_10006.PAGE_TYPE_ACT
			var_22_4.targetId = var_21_1

			var_22_1(var_22_0, var_22_2, var_22_3, var_22_4)

			return
		end

		return var_21_2, var_21_0 ~= #arg_21_1 and var_21_3 or nil
	end,
	[var_0_1.MINI_GAME] = function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_1[1]

		getProxy = var_1_10003
		MiniGameProxy = var_1_10005

		local var_23_1 = var_1_10003(var_1_10005)
		local var_23_2 = var_3.GetHubByGameId(var_23_1, var_23_0).count == 0

		local function var_23_3()
			local var_24_0 = arg_23_0
			local var_24_1 = var_0.emit

			ActivityMediator = var_2_10003

			var_24_1(var_24_0, var_2_10003.GO_MINI_GAME, var_23_0)

			return
		end

		return var_23_2 and "1/1" or "0/1", not var_23_2 and var_23_3 or nil
	end,
	[var_0_1.SHOP_BUY] = function(arg_25_0, arg_25_1)
		local function var_25_0()
			local var_26_0 = arg_25_0
			local var_26_1 = var_0.emit

			ActivityMediator = var_2_10003

			local var_26_2 = var_2_10003.GO_SHOPS_LAYER
			local var_26_3 = {}

			NewShopsScene = var_2_10005
			var_26_3.warp = var_2_10005.TYPE_ACTIVITY
			var_26_3.actId = arg_25_0.shopId

			var_26_1(var_26_0, var_26_2, var_26_3)

			return
		end

		local var_25_1 = arg_25_0:GetGoodsResCnt(arg_25_1[1])

		pg = var_1_10004

		local var_25_2 = var_1_10004.activity_shop_template[arg_25_1[1]].num_limit
		local var_25_3 = var_25_1 == 0

		return var_25_2 - var_25_1 .. "/" .. var_25_2, not var_25_3 and var_25_0 or nil
	end,
	[var_0_1.GO_TASK] = function(arg_27_0, arg_27_1, arg_27_2)
		local function var_27_0()
			local var_28_0 = arg_27_0
			local var_28_1 = var_0.emit

			ActivityMediator = var_2_10003

			var_28_1(var_28_0, var_2_10003.EVENT_GO_SCENE, arg_27_2)

			return
		end

		local var_27_1 = #arg_27_1

		getProxy = var_1_10005
		TaskProxy = var_1_10007

		local var_27_2 = var_1_10005(var_1_10007)

		while var_27_1 > 0 do
			local var_27_3 = arg_27_1[var_27_1]
			local var_27_4

			if not var_27_2:getTaskById(var_27_3) then
				var_27_4 = var_27_2:getFinishTaskById(var_27_3)
			end

			if var_27_4 then
				if var_27_4:getTaskStatus() ~= 2 then
					var_27_1 = var_27_1 - 1
				end

				break
			end

			var_27_1 = var_27_1 - 1
		end

		return var_27_1 .. "/" .. #arg_27_1, var_27_0
	end,
	[var_0_1.MINI_GAME_ACT] = function(arg_29_0, arg_29_1, arg_29_2)
		local var_29_0 = arg_29_1[1]
		local var_29_1 = arg_29_1[2]

		getProxy = var_1_10005
		MiniGameProxy = var_1_10007

		local var_29_2 = var_1_10005(var_1_10007)
		local var_29_3 = var_5.GetHubByGameId(var_29_2, var_29_0).count == 0

		local function var_29_4()
			pg = var_2_10000

			local var_30_0 = var_2_10000.m02
			local var_30_1 = var_0.sendNotification

			GAME = var_2_10003

			local var_30_2 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			var_30_1(var_30_0, var_30_2, var_2_10004.ACTIVITY, {
				id = var_29_1
			})

			return
		end

		return var_29_3 and "1/1" or "0/1", not var_29_3 and var_29_4 or nil
	end
}

function var_0_1.UpdateTask(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_0.isLinkActOpen then
		return
	end

	local var_31_0 = arg_31_1 + 1
	local var_31_1 = arg_31_0.taskConfig[var_31_0][1]
	local var_31_2 = arg_31_0.taskConfig[var_31_0][2]
	local var_31_3 = arg_31_0.taskConfig[var_31_0][3]
	local var_31_4 = arg_31_0.taskConfig[var_31_0][4]
	local var_31_5, var_31_6 = var_0_1.taskTypeDic[var_31_1](arg_31_0, var_31_3, var_31_4)

	setText = var_10

	var_10(arg_31_2:Find("name"), var_31_2)

	setText = var_10

	var_10(arg_31_2:Find("count"), var_31_5)

	setActive = var_10

	var_10(arg_31_2:Find("complete"), var_31_6 == nil)

	setActive = var_10

	var_10(arg_31_2:Find("btn_go"), var_31_6 ~= nil)

	if var_31_6 then
		onButton = var_10

		var_10(arg_31_0, arg_31_2:Find("btn_go"), function()
			var_31_6()

			pg = var_0

			local var_32_0 = var_0.GameTrackerMgr.GetInstance()
			local var_32_1 = var_0.Record

			GameTrackerBuilder = var_2_10003

			var_32_1(var_32_0, var_2_10003.BuildUrJump(var_31_1))

			return
		end)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_33_0)
	arg_33_0:UpdateExchangeStatus()

	local var_33_0 = arg_33_0.uilist

	var_1.align(var_33_0, #arg_33_0.taskConfig)
	arg_33_0:UpdatePtCount()

	setActive = var_1

	local var_33_1 = arg_33_0._btnExchange

	var_1(var_3.Find(var_33_1, "red"), arg_33_0.canExchange)

	setGray = var_1

	var_1(arg_33_0._btnExchange, arg_33_0.exchangeState == 3, false)

	local var_33_2 = arg_33_0._btnExchange

	var_1.GetComponent(var_33_2, "Image").raycastTarget = arg_33_0.exchangeState ~= 3

	return
end

function var_0_1.GetGoodsResCnt(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0.actShop
	local var_34_1 = var_2.GetCommodityById(var_34_0, arg_34_1)

	return var_2.GetPurchasableCnt(var_34_1)
end

function var_0_1.UpdateExchangeStatus(arg_35_0)
	local var_35_0 = arg_35_0.playerProxy

	arg_35_0.player = var_1.getData(var_35_0)

	local var_35_1 = arg_35_0.player

	arg_35_0.ptCount = var_1.getResource(var_35_1, arg_35_0.uPtId)
	_ = var_1
	arg_35_0.restExchange = var_1.reduce(arg_35_0.goodsId, 0, function(arg_36_0, arg_36_1)
		local var_36_0 = arg_35_0.actShop
		local var_36_1 = var_2.GetCommodityById(var_36_0, arg_36_1)

		return arg_36_0 + var_2.GetPurchasableCnt(var_36_1)
	end)
	arg_35_0.exchangeState = arg_35_0.length - arg_35_0.restExchange

	if arg_35_0.exchangeState < arg_35_0.length then
		pg = var_1

		local var_35_2

		if not var_1.activity_shop_template[arg_35_0.goodsId[arg_35_0.exchangeState]] then
			var_35_2 = nil
		end

		arg_35_0.curGoods = var_35_2
		arg_35_0.canExchange = arg_35_0.exchangeState < arg_35_0.length and arg_35_0.ptCount >= arg_35_0.curGoods.resource_num

		return
	end
end

function var_0_1.UpdatePtCount(arg_37_0)
	local var_37_0 = (arg_37_0.exchangeState < arg_37_0.length and arg_37_0.ptCount < arg_37_0.curGoods.resource_num and "<color=red>" or "<color=#3689DE>") .. arg_37_0.ptCount .. "</color>/" .. (arg_37_0.exchangeState == 3 and "--" or arg_37_0.curGoods.resource_num)

	i18n = var_4

	local var_37_1 = var_37_0 .. var_4("UrExchange_Pt_charges", arg_37_0.restExchange)

	setText = var_37_0

	var_37_0(arg_37_0._ptText, var_37_1)

	return
end

function var_0_1.OnDestroy(arg_38_0)
	eachChild = var_1_10001

	var_1_10001(arg_38_0._tasksTF, function(arg_39_0)
		Destroy = var_2_10001

		var_2_10001(arg_39_0)

		return
	end)

	return
end

function var_0_1.IsShowingPopWindow(arg_40_0)
	return arg_40_0.isMsgBoxShow
end

function var_0_1.ClosePopWindow(arg_41_0)
	arg_41_0:closeMsgBox()

	return
end

function var_0_1.closeMsgBox(arg_42_0)
	arg_42_0.isMsgBoxShow = false
	pg = var_1

	local var_42_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_42_0, arg_42_0._msgBox)

	setActive = var_1

	var_1(arg_42_0._msgBox, false)

	return
end

return var_0_1
