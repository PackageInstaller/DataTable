class = var_0_10000

local var_0_0 = "LuminousUrExPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

var_0_1.SP_FIRST = 1
var_0_1.SP_DAILY = 2
var_0_1.RANDOM_DAILY = 3
var_0_1.CHALLANGE = 4
var_0_1.MINI_GAME = 5
var_0_1.SHOP_BUY = 6

local function var_0_2(...)
	if false then
		warning = var_1_10000

		var_1_10000(...)
	end

	return
end

function var_0_1.OnInit(arg_2_0)
	getProxy = var_1_10001
	ShopsProxy = var_1_10002
	arg_2_0.shopProxy = var_1_10001(var_1_10002)
	getProxy = var_1
	PlayerProxy = var_1_10002
	arg_2_0.playerProxy = var_1(var_1_10002)
	getProxy = var_1
	TaskProxy = var_1_10002
	arg_2_0.taskProxy = var_1(var_1_10002)
	getProxy = var_1
	ShopsProxy = var_1_10002
	arg_2_0.shopProxy = var_1(var_1_10002)

	local var_2_0 = arg_2_0._tf

	arg_2_0._tasksTF = var_1.Find(var_2_0, "AD/tasks")

	local var_2_1 = arg_2_0._tf

	arg_2_0._taskTpl = var_1.Find(var_2_1, "AD/task_tpl")

	local var_2_2 = arg_2_0._tf

	arg_2_0._ptTip = var_1.Find(var_2_2, "pt_tip")

	local var_2_3 = arg_2_0._ptTip

	arg_2_0._tipText = var_1.Find(var_2_3, "bg/Text")

	local var_2_4 = arg_2_0._tf

	arg_2_0._btnSimulate = var_1.Find(var_2_4, "AD/btn_simulate")

	local var_2_5 = arg_2_0._tf

	arg_2_0._btnExchange = var_1.Find(var_2_5, "AD/btn_exchange")

	local var_2_6 = arg_2_0._tf

	arg_2_0._btnHelp = var_1.Find(var_2_6, "AD/btn_help")

	local var_2_7 = arg_2_0._tf

	arg_2_0._ptText = var_1.Find(var_2_7, "AD/icon/pt")
	UIItemList = var_1
	arg_2_0.uilist = var_1.New(arg_2_0._tasksTF, arg_2_0._taskTpl)
	setActive = var_1

	var_1(arg_2_0._taskTpl, false)

	return
end

function var_0_1.OnDataSetting(arg_3_0)
	local var_3_0 = arg_3_0.activity

	arg_3_0.config = var_1.getConfig(var_3_0, "config_client")
	arg_3_0.taskConfig = arg_3_0.config.taskConfig
	arg_3_0.ptId = arg_3_0.config.ptId
	arg_3_0.uPtId = arg_3_0.config.uPtId
	arg_3_0.goodsId = arg_3_0.config.goodsId
	arg_3_0.shopId = arg_3_0.config.shopId
	arg_3_0.length = #arg_3_0.goodsId + 1

	local var_3_1 = arg_3_0.shopProxy

	arg_3_0.actShop = var_1.getActivityShopById(var_3_1, arg_3_0.shopId)

	return
end

function var_0_1.OnFirstFlush(arg_4_0)
	setText = var_1_10001

	local var_4_0 = arg_4_0._tipText

	i18n = var_1_10003

	var_1_10001(var_4_0, var_1_10003("UrExchange_Pt_NotEnough"))

	getProxy = var_1_10001
	ActivityProxy = var_4_0

	local var_4_1 = var_1_10001(var_4_0)
	local var_4_2

	var_4_2 = var_1.getActivityById(var_4_1, arg_4_0.config.activitytime) and not var_1:isEnd()
	arg_4_0.isLinkActOpen = var_4_2
	setActive = var_4_2

	var_4_2(arg_4_0._tasksTF, arg_4_0.isLinkActOpen)

	local var_4_3 = arg_4_0.uilist

	var_2.make(var_4_3, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_4_0

			var_3.UpdateTask(var_5_0, arg_5_1, arg_5_2)
		end

		return
	end)

	onButton = var_2

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0._btnSimulate

	local function var_4_6()
		local var_6_1

		if arg_4_0.config.expedition == 0 then
			pg = var_6_1

			local var_6_0 = var_6_1.TipsMgr.GetInstance()

			var_6_1 = var_6_1.ShowTips
			i18n = var_2_10002

			var_6_1(var_6_0, var_2_10002("tech_simulate_closed"))
		else
			i18n = var_6_1

			local var_6_2 = var_6_1("blueprint_simulation_confirm")

			pg = var_1

			local var_6_3 = var_1.MsgboxMgr.GetInstance()

			var_1.ShowMsgBox(var_6_3, {
				content = var_6_2,
				onYes = function()
					local var_7_0 = arg_4_0
					local var_7_1 = var_0.emit

					ActivityMediator = var_3_10002

					local var_7_2 = var_3_10002.ON_SIMULATION_COMBAT
					local var_7_3 = {
						warnMsg = "tech_simulate_quit",
						stageId = arg_4_0.config.expedition
					}

					local function var_7_4()
						return
					end

					SFX_PANEL = var_3_10005

					var_7_1(var_7_0, var_7_2, var_7_3, var_7_4, var_3_10005)

					return
				end
			})
		end

		return
	end

	SFX_CONFIRM = var_1_10006

	var_2(var_4_4, var_4_5, var_4_6, var_1_10006)

	onButton = var_2

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0._btnExchange

	local function var_4_9()
		local var_9_1

		if arg_4_0.canExchange then
			pg = var_9_1

			local var_9_0 = var_9_1.MsgboxMgr.GetInstance()

			var_9_1 = var_9_1.ShowMsgBox

			local var_9_2 = {
				yesText = "text_exchange"
			}

			MSGBOX_TYPE_SINGLE_ITEM = var_2_10003
			var_9_2.type = var_2_10003
			Drop = var_2_10003
			var_9_2.drop = var_2_10003.Create({
				arg_4_0.curGoods.commodity_type,
				arg_4_0.curGoods.commodity_id,
				1
			})

			function var_9_2.onYes()
				local var_10_0 = arg_4_0.curGoods
				local var_10_1 = arg_4_0
				local var_10_2 = var_1.emit

				ActivityMediator = var_3_10003

				var_10_2(var_10_1, var_3_10003.ON_ACT_SHOPPING, arg_4_0.shopId, 1, arg_4_0.curGoods.id, 1, function()
					if arg_4_0._tf then
						IsNil = var_0

						if not var_0(arg_4_0._tf) then
							local var_11_0 = arg_4_0

							var_0.OnUpdateFlush(var_11_0)
						end
					end

					return
				end)

				pg = var_10_2

				local var_10_3 = var_10_2.GameTrackerMgr.GetInstance()
				local var_10_4 = var_1.Record

				GameTrackerBuilder = var_3

				var_10_4(var_10_3, var_3.BuildUrRedeem(var_10_0.commodity_id, 2))

				return
			end

			var_9_1(var_9_0, var_9_2)
		else
			setActive = var_9_1

			var_9_1(arg_4_0._ptTip, true)

			local var_9_3 = arg_4_0

			LeanTween = var_1

			local var_9_4 = var_1.delayedCall
			local var_9_5 = 1

			System = var_2_10003
			var_9_3.leantween = var_9_4(var_9_5, var_2_10003.Action(function()
				setActive = var_3_10000

				var_3_10000(arg_4_0._ptTip, false)

				return
			end)).uniqueId
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_4_7, var_4_8, var_4_9, var_1_10006)

	onButton = var_2

	local var_4_10 = arg_4_0
	local var_4_11 = arg_4_0._btnHelp

	local function var_4_12()
		pg = var_2_10000

		local var_13_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_13_1 = var_0.ShowMsgBox
		local var_13_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_13_2.type = var_2_10003
		i18n = var_2_10003
		var_13_2.helps = var_2_10003("UrExchange_Pt_help")

		var_13_1(var_13_0, var_13_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_4_10, var_4_11, var_4_12, var_1_10006)

	return
end

function var_0_1.CheckSingleTask(arg_14_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002

	local var_14_0 = var_1_10001(var_1_10002)
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

			ActivityMediator = var_2_10002

			local var_16_2 = var_2_10002.EVENT_GO_SCENE

			SCENE = var_2_10003

			local var_16_3 = var_2_10003.TASK
			local var_16_4 = {}

			TaskScene = var_2_10005
			var_16_4.page = var_2_10005.PAGE_TYPE_ACT
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

			ActivityMediator = var_2_10002

			local var_18_2 = var_2_10002.EVENT_GO_SCENE

			SCENE = var_2_10003

			local var_18_3 = var_2_10003.LEVEL
			local var_18_4 = {}

			pg = var_2_10005
			var_18_4.mapIdx = var_2_10005.chapter_template[arg_17_1[1]].map

			var_18_1(var_18_0, var_18_2, var_18_3, var_18_4)

			return
		end

		getProxy = var_1_10003
		ChapterProxy = var_1_10004

		local var_17_1 = var_1_10003(var_1_10004)
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

			ActivityMediator = var_2_10002

			local var_20_2 = var_2_10002.EVENT_GO_SCENE

			SCENE = var_2_10003

			local var_20_3 = var_2_10003.TASK
			local var_20_4 = {}

			TaskScene = var_2_10005
			var_20_4.page = var_2_10005.PAGE_TYPE_ACT
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

			ActivityMediator = var_2_10002

			local var_22_2 = var_2_10002.EVENT_GO_SCENE

			SCENE = var_2_10003

			local var_22_3 = var_2_10003.TASK
			local var_22_4 = {}

			TaskScene = var_2_10005
			var_22_4.page = var_2_10005.PAGE_TYPE_ACT
			var_22_4.targetId = var_21_1

			var_22_1(var_22_0, var_22_2, var_22_3, var_22_4)

			return
		end

		return var_21_2, var_21_0 ~= #arg_21_1 and var_21_3 or nil
	end,
	[var_0_1.MINI_GAME] = function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_1[1]

		getProxy = var_1_10003
		MiniGameProxy = var_1_10004

		local var_23_1 = var_1_10003(var_1_10004)
		local var_23_2 = var_3.GetHubByGameId(var_23_1, var_23_0).count == 0

		local function var_23_3()
			local var_24_0 = arg_23_0
			local var_24_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_24_1(var_24_0, var_2_10002.GO_MINI_GAME, var_23_0)

			return
		end

		return var_23_2 and "1/1" or "0/1", not var_23_2 and var_23_3 or nil
	end,
	[var_0_1.SHOP_BUY] = function(arg_25_0, arg_25_1)
		local function var_25_0()
			local var_26_0 = arg_25_0
			local var_26_1 = var_0.emit

			ActivityMediator = var_2_10002

			local var_26_2 = var_2_10002.GO_SHOPS_LAYER
			local var_26_3 = {}

			NewShopsScene = var_2_10004
			var_26_3.warp = var_2_10004.TYPE_ACTIVITY
			var_26_3.actId = arg_25_0.shopId

			var_26_1(var_26_0, var_26_2, var_26_3)

			return
		end

		local var_25_1 = arg_25_0
		local var_25_2 = arg_25_0.GetGoodsResCnt(var_25_1, arg_25_1[1])

		pg = var_25_1

		local var_25_3 = var_25_1.activity_shop_template[arg_25_1[1]].num_limit
		local var_25_4 = var_25_2 == 0

		return var_25_3 - var_25_2 .. "/" .. var_25_3, not var_25_4 and var_25_0 or nil
	end
}

function var_0_1.UpdateTask(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_0.isLinkActOpen then
		return
	end

	local var_27_0 = arg_27_1 + 1
	local var_27_1 = arg_27_0.taskConfig[var_27_0][1]
	local var_27_2 = arg_27_0.taskConfig[var_27_0][2]
	local var_27_3 = arg_27_0.taskConfig[var_27_0][3]
	local var_27_4, var_27_5 = var_0_1.taskTypeDic[var_27_1](arg_27_0, var_27_3)

	setText = var_9

	var_9(arg_27_2:Find("name"), var_27_2)

	setText = var_9

	var_9(arg_27_2:Find("count"), var_27_4)

	setActive = var_9

	var_9(arg_27_2:Find("complete"), var_27_5 == nil)

	setActive = var_9

	var_9(arg_27_2:Find("btn_go"), var_27_5 ~= nil)

	if var_27_5 then
		onButton = var_9

		var_9(arg_27_0, arg_27_2:Find("btn_go"), function()
			var_27_5()

			pg = var_0

			local var_28_0 = var_0.GameTrackerMgr.GetInstance()
			local var_28_1 = var_0.Record

			GameTrackerBuilder = var_2_10002

			var_28_1(var_28_0, var_2_10002.BuildUrJump(var_27_1))

			return
		end)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_29_0)
	arg_29_0:UpdateExchangeStatus()

	local var_29_0 = arg_29_0.uilist

	var_1.align(var_29_0, #arg_29_0.taskConfig)
	arg_29_0:UpdatePtCount()

	setActive = var_1

	local var_29_1 = arg_29_0._btnExchange

	var_1(var_2.Find(var_29_1, "red"), arg_29_0.canExchange)

	setGray = var_1

	var_1(arg_29_0._btnExchange, arg_29_0.exchangeState == 3, false)

	local var_29_2 = arg_29_0._btnExchange

	var_1.GetComponent(var_29_2, "Image").raycastTarget = arg_29_0.exchangeState ~= 3

	return
end

function var_0_1.GetGoodsResCnt(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.actShop
	local var_30_1 = var_2.GetCommodityById(var_30_0, arg_30_1)

	return var_2.GetPurchasableCnt(var_30_1)
end

function var_0_1.updateTaskLayers(arg_31_0)
	arg_31_0:OnUpdateFlush()

	return
end

function var_0_1.UpdateExchangeStatus(arg_32_0)
	local var_32_0 = arg_32_0.playerProxy

	arg_32_0.player = var_1.getData(var_32_0)

	local var_32_1 = arg_32_0.player

	arg_32_0.ptCount = var_1.getResource(var_32_1, arg_32_0.uPtId)
	_ = var_1
	arg_32_0.restExchange = var_1.reduce(arg_32_0.goodsId, 0, function(arg_33_0, arg_33_1)
		local var_33_0 = arg_32_0.actShop
		local var_33_1 = var_2.GetCommodityById(var_33_0, arg_33_1)

		return arg_33_0 + var_2.GetPurchasableCnt(var_33_1)
	end)
	arg_32_0.exchangeState = arg_32_0.length - arg_32_0.restExchange

	if arg_32_0.exchangeState < arg_32_0.length then
		pg = var_1

		local var_32_2

		if not var_1.activity_shop_template[arg_32_0.goodsId[arg_32_0.exchangeState]] then
			var_32_2 = nil
		end

		arg_32_0.curGoods = var_32_2
		arg_32_0.canExchange = arg_32_0.exchangeState < arg_32_0.length and arg_32_0.ptCount >= arg_32_0.curGoods.resource_num

		return
	end
end

function var_0_1.UpdatePtCount(arg_34_0)
	local var_34_0 = (arg_34_0.exchangeState < arg_34_0.length and arg_34_0.ptCount < arg_34_0.curGoods.resource_num and "<color=red>" or "<color=#3689DE>") .. arg_34_0.ptCount .. "</color>/" .. (arg_34_0.exchangeState == 3 and "--" or arg_34_0.curGoods.resource_num)

	i18n = var_4

	local var_34_1 = var_34_0 .. var_4("UrExchange_Pt_charges", arg_34_0.restExchange)

	setText = var_34_0

	var_34_0(arg_34_0._ptText, var_34_1)

	return
end

function var_0_1.OnDestroy(arg_35_0)
	eachChild = var_1_10001

	var_1_10001(arg_35_0._tasksTF, function(arg_36_0)
		Destroy = var_2_10001

		var_2_10001(arg_36_0)

		return
	end)

	return
end

return var_0_1
