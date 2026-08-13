class = var_0_10000

local var_0_0 = "UrExchangeTemplatePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseActivityPage"))

var_0_1.SP_FIRST = 1
var_0_1.SP_DAILY = 2
var_0_1.RANDOM_DAILY = 3
var_0_1.CHALLANGE = 4
var_0_1.MINI_GAME = 5
var_0_1.SHOP_BUY = 6

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

	local var_1_8 = arg_1_0._tf

	arg_1_0._resText = var_1.Find(var_1_8, "AD/icon/text")
	UIItemList = var_1
	arg_1_0.uilist = var_1.New(arg_1_0._tasksTF, arg_1_0._taskTpl)
	setActive = var_1

	var_1(arg_1_0._taskTpl, false)
	arg_1_0:InitDic()

	return
end

function var_0_1.InitDic(arg_2_0)
	arg_2_0.taskTypeDic = {
		[var_0_1.SP_FIRST] = function(arg_3_0, arg_3_1)
			local var_3_0 = (var_0_1.CheckSingleTask(arg_3_1[1]) == 2 and 1 or 0) .. "/1"

			local function var_3_1()
				local var_4_0 = arg_3_0
				local var_4_1 = var_0.emit

				ActivityMediator = var_3_10003

				local var_4_2 = var_3_10003.EVENT_GO_SCENE

				SCENE = var_3_10004

				local var_4_3 = var_3_10004.TASK
				local var_4_4 = {}

				TaskScene = var_3_10006
				var_4_4.page = var_3_10006.PAGE_TYPE_ACT
				var_4_4.targetId = arg_3_1[1]

				var_4_1(var_4_0, var_4_2, var_4_3, var_4_4)

				return
			end

			return var_3_0, var_2 ~= 1 and var_3_1 or nil
		end,
		[var_0_1.SP_DAILY] = function(arg_5_0, arg_5_1)
			getProxy = var_2_10002
			ChapterProxy = var_2_10004

			local var_5_0 = var_2_10002(var_2_10004)
			local var_5_1 = var_2.getChapterById(var_5_0, arg_5_1[1])

			local function var_5_2()
				local var_6_0 = var_5_1

				if var_0.isUnlock(var_6_0) then
					local var_6_1 = arg_5_0
					local var_6_2 = var_0.emit

					ActivityMediator = var_3_10003
					var_3_10003 = var_3_10003.EVENT_GO_SCENE
					SCENE = var_3_10004

					local var_6_3 = var_3_10004.LEVEL
					local var_6_4 = {}

					pg = var_3_10006
					var_6_4.mapIdx = var_3_10006.chapter_template[arg_5_1[1]].map

					var_6_2(var_6_1, var_3_10003, var_6_3, var_6_4)
				else
					local var_6_5 = arg_5_0
					local var_6_6 = var_0.emit

					ActivityMediator = var_3_10003

					var_6_6(var_6_5, var_3_10003.SPECIAL_BATTLE_OPERA)
				end

				return
			end

			local var_5_3

			if var_5_1:isUnlock() and var_5_1:isPlayerLVUnlock() then
				var_5_3 = not var_5_1:enoughTimes2Start()
			end

			return var_5_3 and "1/1" or "0/1", not var_5_3 and var_5_2 or nil
		end,
		[var_0_1.RANDOM_DAILY] = function(arg_7_0, arg_7_1)
			local var_7_0

			local function var_7_1()
				local var_8_0 = arg_7_0
				local var_8_1 = var_0.emit

				ActivityMediator = var_3_10003

				local var_8_2 = var_3_10003.EVENT_GO_SCENE

				SCENE = var_3_10004

				local var_8_3 = var_3_10004.TASK
				local var_8_4 = {}

				TaskScene = var_3_10006
				var_8_4.page = var_3_10006.PAGE_TYPE_ACT
				var_8_4.targetId = var_7_0

				var_8_1(var_8_0, var_8_2, var_8_3, var_8_4)

				return
			end

			local var_7_2 = 0
			local var_7_3 = 0

			pairs = var_2_10006

			for iter_7_0, iter_7_1 in var_2_10006(arg_7_1) do
				if var_0_1.CheckSingleTask(iter_7_1) == 2 then
					var_7_3 = var_7_3 + 1
				elseif var_11 == 1 or var_11 == 0 then
					var_7_2 = var_7_2 + 1
					var_7_0 = iter_7_1
				end
			end

			local var_7_4 = var_7_2 + var_7_3

			return var_7_3 .. "/" .. var_7_4, var_7_2 ~= 0 and var_7_1 or nil
		end,
		[var_0_1.CHALLANGE] = function(arg_9_0, arg_9_1)
			local var_9_0 = 0
			local var_9_1

			pairs = var_2_10004

			for iter_9_0, iter_9_1 in var_2_10004(arg_9_1) do
				var_9_0 = var_9_0 + (var_0_1.CheckSingleTask(iter_9_1) == 2 and 1 or 0)

				if var_9 == 0 then
					var_9_1 = var_9_1 or iter_9_1
				end
			end

			local var_9_2 = var_9_0 .. "/" .. #arg_9_1

			local function var_9_3()
				local var_10_0 = arg_9_0
				local var_10_1 = var_0.emit

				ActivityMediator = var_3_10003

				local var_10_2 = var_3_10003.EVENT_GO_SCENE

				SCENE = var_3_10004

				local var_10_3 = var_3_10004.TASK
				local var_10_4 = {}

				TaskScene = var_3_10006
				var_10_4.page = var_3_10006.PAGE_TYPE_ACT
				var_10_4.targetId = var_9_1

				var_10_1(var_10_0, var_10_2, var_10_3, var_10_4)

				return
			end

			return var_9_2, var_9_0 ~= #arg_9_1 and var_9_3 or nil
		end,
		[var_0_1.MINI_GAME] = function(arg_11_0, arg_11_1)
			local var_11_0 = arg_11_1[1]

			getProxy = var_2_10003
			MiniGameProxy = var_2_10005

			local var_11_1 = var_2_10003(var_2_10005)
			local var_11_2 = var_3.GetHubByGameId(var_11_1, var_11_0).count == 0

			local function var_11_3()
				local var_12_0 = arg_11_0
				local var_12_1 = var_0.emit

				ActivityMediator = var_3_10003

				var_12_1(var_12_0, var_3_10003.GO_MINI_GAME, var_11_0)

				return
			end

			return var_11_2 and "1/1" or "0/1", not var_11_2 and var_11_3 or nil
		end,
		[var_0_1.SHOP_BUY] = function(arg_13_0, arg_13_1)
			local function var_13_0()
				local var_14_0 = arg_13_0
				local var_14_1 = var_0.emit

				ActivityMediator = var_3_10003

				local var_14_2 = var_3_10003.GO_SHOPS_LAYER
				local var_14_3 = {}

				NewShopsScene = var_3_10005
				var_14_3.warp = var_3_10005.TYPE_ACTIVITY
				var_14_3.actId = arg_13_0.shopId

				var_14_1(var_14_0, var_14_2, var_14_3)

				return
			end

			local var_13_1 = arg_13_0:GetGoodsResCnt(arg_13_1[1])

			pg = var_2_10004

			local var_13_2 = var_2_10004.activity_shop_template[arg_13_1[1]].num_limit
			local var_13_3 = var_13_1 == 0

			return var_13_2 - var_13_1 .. "/" .. var_13_2, not var_13_3 and var_13_0 or nil
		end
	}

	return
end

function var_0_1.OnDataSetting(arg_15_0)
	local var_15_0 = arg_15_0.activity

	arg_15_0.config = var_1.getConfig(var_15_0, "config_client")
	arg_15_0.taskConfig = arg_15_0.config.taskConfig
	arg_15_0.ptId = arg_15_0.config.ptId
	arg_15_0.uPtId = arg_15_0.config.uPtId
	arg_15_0.goodsId = arg_15_0.config.goodsId
	arg_15_0.shopId = arg_15_0.config.shopId
	arg_15_0.length = #arg_15_0.goodsId + 1

	local var_15_1 = arg_15_0.shopProxy

	arg_15_0.actShop = var_1.getActivityShopById(var_15_1, arg_15_0.shopId)

	return
end

function var_0_1.OnFirstFlush(arg_16_0)
	setText = var_1_10001

	local var_16_0 = arg_16_0._tipText

	i18n = var_1_10004

	var_1_10001(var_16_0, var_1_10004("UrExchange_Pt_NotEnough"))

	getProxy = var_1_10001
	ActivityProxy = var_16_0

	local var_16_1 = var_1_10001(var_16_0)

	arg_16_0.isLinkActOpen = var_1.getActivityById(var_16_1, arg_16_0.config.activitytime) and not var_1:isEnd()
	setActive = var_2

	var_2(arg_16_0._tasksTF, arg_16_0.isLinkActOpen)

	local var_16_2 = arg_16_0.uilist

	var_2.make(var_16_2, function(arg_17_0, arg_17_1, arg_17_2)
		UIItemList = var_2_10003

		if arg_17_0 == var_2_10003.EventUpdate then
			local var_17_0 = arg_16_0

			var_3.UpdateTask(var_17_0, arg_17_1, arg_17_2)
		end

		return
	end)

	onButton = var_2

	local var_16_3 = arg_16_0
	local var_16_4 = arg_16_0._btnSimulate

	local function var_16_5()
		local var_18_1

		if arg_16_0.config.expedition == 0 then
			pg = var_18_1

			local var_18_0 = var_18_1.TipsMgr.GetInstance()

			var_18_1 = var_18_1.ShowTips
			i18n = var_2_10003

			var_18_1(var_18_0, var_2_10003("tech_simulate_closed"))
		else
			i18n = var_18_1

			local var_18_2 = var_18_1("blueprint_simulation_confirm")

			pg = var_2_10001

			local var_18_3 = var_2_10001.MsgboxMgr.GetInstance()

			var_1.ShowMsgBox(var_18_3, {
				content = var_18_2,
				onYes = function()
					local var_19_0 = arg_16_0
					local var_19_1 = var_0.emit

					ActivityMediator = var_3_10003

					local var_19_2 = var_3_10003.ON_SIMULATION_COMBAT
					local var_19_3 = {
						warnMsg = "tech_simulate_quit",
						stageId = arg_16_0.config.expedition
					}

					local function var_19_4()
						return
					end

					SFX_PANEL = var_3_10006

					var_19_1(var_19_0, var_19_2, var_19_3, var_19_4, var_3_10006)

					return
				end
			})
		end

		return
	end

	SFX_CONFIRM = var_1_10007

	var_2(var_16_3, var_16_4, var_16_5, var_1_10007)

	onButton = var_2

	local var_16_6 = arg_16_0
	local var_16_7 = arg_16_0._btnExchange

	local function var_16_8()
		local var_21_1

		if arg_16_0.canExchange then
			pg = var_21_1

			local var_21_0 = var_21_1.MsgboxMgr.GetInstance()

			var_21_1 = var_21_1.ShowMsgBox

			local var_21_2 = {
				yesText = "text_exchange"
			}

			MSGBOX_TYPE_SINGLE_ITEM = var_2_10004
			var_21_2.type = var_2_10004
			Drop = var_2_10004
			var_21_2.drop = var_2_10004.Create({
				arg_16_0.curGoods.commodity_type,
				arg_16_0.curGoods.commodity_id,
				1
			})

			function var_21_2.onYes()
				local var_22_0 = arg_16_0
				local var_22_1 = var_0.emit

				ActivityMediator = var_3_10003

				var_22_1(var_22_0, var_3_10003.ON_ACT_SHOPPING, arg_16_0.shopId, 1, arg_16_0.curGoods.id, 1)

				return
			end

			var_21_1(var_21_0, var_21_2)
		else
			setActive = var_21_1

			var_21_1(arg_16_0._ptTip, true)

			local var_21_3 = arg_16_0

			LeanTween = var_2_10001

			local var_21_4 = var_2_10001.delayedCall
			local var_21_5 = 1

			System = var_2_10004
			var_21_3.leantween = var_21_4(var_21_5, var_2_10004.Action(function()
				setActive = var_3_10000

				var_3_10000(arg_16_0._ptTip, false)

				return
			end)).uniqueId
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_16_6, var_16_7, var_16_8, var_1_10007)

	onButton = var_2

	local var_16_9 = arg_16_0
	local var_16_10 = arg_16_0._btnHelp

	local function var_16_11()
		pg = var_2_10000

		local var_24_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_24_1 = var_0.ShowMsgBox
		local var_24_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_24_2.type = var_2_10004
		i18n = var_2_10004
		var_24_2.helps = var_2_10004("UrExchange_Pt_help")

		var_24_1(var_24_0, var_24_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_16_9, var_16_10, var_16_11, var_1_10007)

	return
end

function var_0_1.CheckSingleTask(arg_25_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_25_0 = var_1_10001(var_1_10003)
	local var_25_1

	if not var_1.getTaskById(var_25_0, arg_25_0) then
		var_25_1 = var_1:getFinishTaskById(arg_25_0)
	end

	local var_25_2

	if not var_25_1 or not var_25_1:getTaskStatus() then
		var_25_2 = -1
	end

	return var_25_2
end

function var_0_1.UpdateTask(arg_26_0, arg_26_1, arg_26_2)
	if not arg_26_0.isLinkActOpen then
		return
	end

	local var_26_0 = arg_26_1 + 1

	unpack = var_1_10004

	local var_26_1, var_26_2, var_26_3 = var_1_10004(arg_26_0.taskConfig[var_26_0])
	local var_26_4, var_26_5 = arg_26_0.taskTypeDic[var_26_1](arg_26_0, var_26_3)

	setText = var_9

	var_9(arg_26_2:Find("name"), var_26_2)

	setText = var_9

	var_9(arg_26_2:Find("count"), var_26_4)

	setActive = var_9

	var_9(arg_26_2:Find("complete"), var_26_5 == nil)

	setActive = var_9

	var_9(arg_26_2:Find("btn_go"), var_26_5 ~= nil)

	if var_26_5 then
		onButton = var_9

		var_9(arg_26_0, arg_26_2:Find("btn_go"), function()
			var_26_5()

			pg = var_0

			local var_27_0 = var_0.GameTrackerMgr.GetInstance()
			local var_27_1 = var_0.Record

			GameTrackerBuilder = var_2_10003

			var_27_1(var_27_0, var_2_10003.BuildUrJump(var_26_1))

			return
		end)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_28_0)
	arg_28_0:UpdateExchangeStatus()

	local var_28_0 = arg_28_0.uilist

	var_1.align(var_28_0, #arg_28_0.taskConfig)
	arg_28_0:UpdatePtCount()

	setActive = var_1

	local var_28_1 = arg_28_0._btnExchange

	var_1(var_3.Find(var_28_1, "red"), arg_28_0.canExchange)

	setGray = var_1

	var_1(arg_28_0._btnExchange, arg_28_0.exchangeState == arg_28_0.length, false)

	local var_28_2 = arg_28_0._btnExchange

	var_1.GetComponent(var_28_2, "Image").raycastTarget = arg_28_0.exchangeState ~= arg_28_0.length

	return
end

function var_0_1.GetGoodsResCnt(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.actShop
	local var_29_1 = var_2.GetCommodityById(var_29_0, arg_29_1)

	return var_2.GetPurchasableCnt(var_29_1)
end

function var_0_1.UpdateExchangeStatus(arg_30_0)
	local var_30_0 = arg_30_0.playerProxy

	arg_30_0.player = var_1.getData(var_30_0)

	local var_30_1 = arg_30_0.player

	arg_30_0.ptCount = var_1.getResource(var_30_1, arg_30_0.uPtId)
	_ = var_1
	arg_30_0.restExchange = var_1.reduce(arg_30_0.goodsId, 0, function(arg_31_0, arg_31_1)
		local var_31_0 = arg_30_0.actShop
		local var_31_1 = var_2.GetCommodityById(var_31_0, arg_31_1)

		return arg_31_0 + var_2.GetPurchasableCnt(var_31_1)
	end)
	arg_30_0.exchangeState = arg_30_0.length - arg_30_0.restExchange

	if arg_30_0.exchangeState < arg_30_0.length then
		pg = var_1

		local var_30_2

		if not var_1.activity_shop_template[arg_30_0.goodsId[arg_30_0.exchangeState]] then
			var_30_2 = nil
		end

		arg_30_0.curGoods = var_30_2
		arg_30_0.canExchange = arg_30_0.exchangeState < arg_30_0.length and arg_30_0.ptCount >= arg_30_0.curGoods.resource_num

		return
	end
end

function var_0_1.UpdatePtCount(arg_32_0)
	setText = var_1_10001

	local var_32_0 = arg_32_0._ptText

	if arg_32_0.exchangeState < arg_32_0.length and arg_32_0.ptCount < arg_32_0.curGoods.resource_num then
		setColorStr = var_4
		var_1_10006 = arg_32_0.ptCount
		COLOR_RED = var_1_10007

		local var_32_1

		if not var_4(var_1_10006, var_1_10007) then
			var_32_1 = arg_32_0.ptCount
		end

		var_1_10001(var_32_0, var_32_1)

		setText = var_1_10001

		local var_32_2 = arg_32_0._resText
		local var_32_3 = "/"
		local var_32_4 = arg_32_0.exchangeState == 3 and "--" or arg_32_0.curGoods.resource_num

		i18n = var_1_10006

		var_1_10001(var_32_2, var_32_3 .. var_32_4 .. var_1_10006("UrExchange_Pt_charges", arg_32_0.restExchange))

		return
	end
end

function var_0_1.OnDestroy(arg_33_0)
	eachChild = var_1_10001

	var_1_10001(arg_33_0._tasksTF, function(arg_34_0)
		Destroy = var_2_10001

		var_2_10001(arg_34_0)

		return
	end)

	return
end

return var_0_1
