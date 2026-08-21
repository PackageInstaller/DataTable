local var_0_0 = class("UrExchangeTemplatePage", import("view.base.BaseActivityPage"))

var_0_0.SP_FIRST = 1
var_0_0.SP_DAILY = 2
var_0_0.RANDOM_DAILY = 3
var_0_0.CHALLANGE = 4
var_0_0.MINI_GAME = 5
var_0_0.SHOP_BUY = 6

function var_0_0.OnInit(arg_1_0)
	arg_1_0.shopProxy = getProxy(ShopsProxy)
	arg_1_0.playerProxy = getProxy(PlayerProxy)
	arg_1_0.taskProxy = getProxy(TaskProxy)
	arg_1_0.shopProxy = getProxy(ShopsProxy)
	arg_1_0._tasksTF = arg_1_0._tf:Find("AD/tasks")
	arg_1_0._taskTpl = arg_1_0._tf:Find("AD/task_tpl")
	arg_1_0._ptTip = arg_1_0._tf:Find("pt_tip")
	arg_1_0._tipText = arg_1_0._ptTip:Find("bg/Text")
	arg_1_0._btnSimulate = arg_1_0._tf:Find("AD/btn_simulate")
	arg_1_0._btnExchange = arg_1_0._tf:Find("AD/btn_exchange")
	arg_1_0._btnHelp = arg_1_0._tf:Find("AD/btn_help")
	arg_1_0._ptText = arg_1_0._tf:Find("AD/icon/pt")
	arg_1_0._resText = arg_1_0._tf:Find("AD/icon/text")
	arg_1_0.uilist = UIItemList.New(arg_1_0._tasksTF, arg_1_0._taskTpl)

	setActive(arg_1_0._taskTpl, false)
	arg_1_0:InitDic()

	return
end

function var_0_0.InitDic(arg_2_0)
	arg_2_0.taskTypeDic = {
		[var_0_0.SP_FIRST] = function(arg_3_0, arg_3_1)
			local var_3_0 = var_0_0.CheckSingleTask(arg_3_1[1]) == 2 and 1 or 0

			local function var_3_1()
				arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
					page = TaskScene.PAGE_TYPE_ACT,
					targetId = arg_3_1[1]
				})

				return
			end

			return var_3_0 .. "/1", var_3_0 ~= 1 and var_3_1 or nil
		end,
		[var_0_0.SP_DAILY] = function(arg_5_0, arg_5_1)
			local var_5_9000
			local var_5_0 = getProxy(ChapterProxy)
			local var_5_1 = var_5_0.getChapterById(var_5_9000, arg_5_1[1])

			local function var_5_2()
				if var_5_1:isUnlock() then
					arg_5_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.LEVEL, {
						mapIdx = pg.chapter_template[arg_5_1[1]].map
					})
				else
					arg_5_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)
				end

				return
			end

			local var_5_3 = var_5_1:isUnlock()

			if var_5_0 then
				var_5_3 = var_5_1:isPlayerLVUnlock()
				var_5_3 = var_5_3 and not var_5_1:enoughTimes2Start()
			end

			return var_5_3 and "1/1" or "0/1", not var_5_3 and var_5_2 or nil
		end,
		[var_0_0.RANDOM_DAILY] = function(arg_7_0, arg_7_1)
			local var_7_0

			local function var_7_1()
				arg_7_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
					page = TaskScene.PAGE_TYPE_ACT,
					targetId = var_7_0
				})

				return
			end

			local var_7_2 = 0
			local var_7_3 = 0

			for iter_7_0, iter_7_1 in pairs(arg_7_1) do
				local var_7_4 = var_0_0.CheckSingleTask(iter_7_1)

				if var_7_4 == 2 then
					var_7_3 = var_7_3 + 1
				elseif var_7_4 == 1 or var_7_4 == 0 then
					var_7_2 = var_7_2 + 1
					var_7_0 = iter_7_1
				end
			end

			return var_7_3 .. "/" .. var_7_2 + var_7_3, var_7_2 ~= 0 and var_7_1 or nil
		end,
		[var_0_0.CHALLANGE] = function(arg_9_0, arg_9_1)
			local var_9_0 = 0
			local var_9_1

			for iter_9_0, iter_9_1 in pairs(arg_9_1) do
				local var_9_2 = var_0_0.CheckSingleTask(iter_9_1) == 2 and 1 or 0

				var_9_0 = var_9_0 + var_9_2

				if var_9_2 == 0 then
					var_9_1 = var_9_1 or iter_9_1
				end
			end

			local function var_9_3()
				arg_9_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
					page = TaskScene.PAGE_TYPE_ACT,
					targetId = var_9_1
				})

				return
			end

			return var_9_0 .. "/" .. #arg_9_1, var_9_0 ~= #arg_9_1 and var_9_3 or nil
		end,
		[var_0_0.MINI_GAME] = function(arg_11_0, arg_11_1)
			local var_11_0 = getProxy(MiniGameProxy):GetHubByGameId(arg_11_1[1]).count == 0

			local function var_11_1()
				arg_11_0:emit(ActivityMediator.GO_MINI_GAME, var_0)

				return
			end

			return var_11_0 and "1/1" or "0/1", not var_11_0 and var_11_1 or nil
		end,
		[var_0_0.SHOP_BUY] = function(arg_13_0, arg_13_1)
			local var_13_0 = arg_13_0:GetGoodsResCnt(arg_13_1[1])

			return pg.activity_shop_template[arg_13_1[1]].num_limit - var_13_0 .. "/" .. pg.activity_shop_template[arg_13_1[1]].num_limit, var_13_0 ~= 0 and function()
				arg_13_0:emit(ActivityMediator.GO_SHOPS_LAYER, {
					warp = NewShopsScene.TYPE_ACTIVITY,
					actId = arg_13_0.shopId
				})

				return
			end or nil
		end
	}

	return
end

function var_0_0.OnDataSetting(arg_15_0)
	arg_15_0.config = arg_15_0.activity:getConfig("config_client")
	arg_15_0.taskConfig = arg_15_0.config.taskConfig
	arg_15_0.ptId = arg_15_0.config.ptId
	arg_15_0.uPtId = arg_15_0.config.uPtId
	arg_15_0.goodsId = arg_15_0.config.goodsId
	arg_15_0.shopId = arg_15_0.config.shopId
	arg_15_0.length = #arg_15_0.goodsId + 1
	arg_15_0.actShop = arg_15_0.shopProxy:getActivityShopById(arg_15_0.shopId)

	return
end

function var_0_0.OnFirstFlush(arg_16_0)
	setText(arg_16_0._tipText, i18n("UrExchange_Pt_NotEnough"))

	local var_16_0 = getProxy(ActivityProxy):getActivityById(arg_16_0.config.activitytime)

	arg_16_0.isLinkActOpen = var_16_0 and not var_16_0:isEnd()

	setActive(arg_16_0._tasksTF, arg_16_0.isLinkActOpen)
	arg_16_0.uilist:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			arg_16_0:UpdateTask(arg_17_1, arg_17_2)
		end

		return
	end)
	onButton(arg_16_0, arg_16_0._btnSimulate, function()
		if arg_16_0.config.expedition == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tech_simulate_closed"))
		else
			({}).content = i18n("blueprint_simulation_confirm")
			;({}).onYes = function()
				arg_16_0:emit(ActivityMediator.ON_SIMULATION_COMBAT, {
					warnMsg = "tech_simulate_quit",
					stageId = arg_16_0.config.expedition
				}, function()
					return
				end, SFX_PANEL)

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox({})
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_16_0, arg_16_0._btnExchange, function()
		if arg_16_0.canExchange then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				yesText = "text_exchange",
				type = MSGBOX_TYPE_SINGLE_ITEM,
				drop = Drop.Create({
					arg_16_0.curGoods.commodity_type,
					arg_16_0.curGoods.commodity_id,
					1
				}),
				onYes = function()
					arg_16_0:emit(ActivityMediator.ON_ACT_SHOPPING, arg_16_0.shopId, 1, arg_16_0.curGoods.id, 1)

					return
				end
			})
		else
			setActive(arg_16_0._ptTip, true)

			arg_16_0.leantween = LeanTween.delayedCall(1, System.Action(function()
				setActive(arg_16_0._ptTip, false)

				return
			end)).uniqueId
		end

		return
	end, SFX_PANEL)
	onButton(arg_16_0, arg_16_0._btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("UrExchange_Pt_help")
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.CheckSingleTask(arg_25_0)
	local var_25_0 = getProxy(TaskProxy)
	local var_25_1 = var_25_0:getTaskById(arg_25_0) or var_25_0:getFinishTaskById(arg_25_0)

	return var_25_1 and var_25_1:getTaskStatus() or -1
end

function var_0_0.UpdateTask(arg_26_0, arg_26_1, arg_26_2)
	if not arg_26_0.isLinkActOpen then
		return
	end

	local var_26_0, var_26_1, var_26_2 = unpack(arg_26_0.taskConfig[arg_26_1 + 1])
	local var_26_3, var_26_4 = arg_26_0.taskTypeDic[var_26_0](arg_26_0, var_26_2)

	setText(arg_26_2:Find("name"), var_26_1)
	setText(arg_26_2:Find("count"), var_26_3)
	setActive(arg_26_2:Find("complete"), var_26_4 == nil)
	setActive(arg_26_2:Find("btn_go"), var_26_4 ~= nil)

	if var_26_4 then
		onButton(arg_26_0, arg_26_2:Find("btn_go"), function()
			var_26_4()
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildUrJump(var_26_0))

			return
		end)
	end

	return
end

function var_0_0.OnUpdateFlush(arg_28_0)
	arg_28_0:UpdateExchangeStatus()
	arg_28_0.uilist:align(#arg_28_0.taskConfig)
	arg_28_0:UpdatePtCount()
	setActive(arg_28_0._btnExchange:Find("red"), arg_28_0.canExchange)
	setGray(arg_28_0._btnExchange, arg_28_0.exchangeState == arg_28_0.length, false)

	arg_28_0._btnExchange:GetComponent("Image").raycastTarget = arg_28_0.exchangeState ~= arg_28_0.length

	return
end

function var_0_0.GetGoodsResCnt(arg_29_0, arg_29_1)
	return arg_29_0.actShop:GetCommodityById(arg_29_1):GetPurchasableCnt()
end

function var_0_0.UpdateExchangeStatus(arg_30_0)
	arg_30_0.player = arg_30_0.playerProxy:getData()
	arg_30_0.ptCount = arg_30_0.player:getResource(arg_30_0.uPtId)
	arg_30_0.restExchange = _.reduce(arg_30_0.goodsId, 0, function(arg_31_0, arg_31_1)
		return arg_31_0 + arg_30_0.actShop:GetCommodityById(arg_31_1):GetPurchasableCnt()
	end)
	arg_30_0.exchangeState = arg_30_0.length - arg_30_0.restExchange

	if arg_30_0.exchangeState < arg_30_0.length then
		arg_30_0.curGoods = pg.activity_shop_template[arg_30_0.goodsId[arg_30_0.exchangeState]] or nil
		arg_30_0.canExchange = arg_30_0.exchangeState < arg_30_0.length and arg_30_0.ptCount >= arg_30_0.curGoods.resource_num

		return
	end
end

function var_0_0.UpdatePtCount(arg_32_0)
	local var_32_0 = arg_32_0.exchangeState < arg_32_0.length and arg_32_0.ptCount < arg_32_0.curGoods.resource_num and setColorStr(arg_32_0.ptCount, COLOR_RED) or arg_32_0.ptCount

	setText(arg_32_0._ptText, var_32_0)
	setText(arg_32_0._resText, "/" .. (arg_32_0.exchangeState == 3 and "--" or arg_32_0.curGoods.resource_num) .. i18n("UrExchange_Pt_charges", arg_32_0.restExchange))

	return
end

function var_0_0.OnDestroy(arg_33_0)
	eachChild(arg_33_0._tasksTF, function(arg_34_0)
		Destroy(arg_34_0)

		return
	end)

	return
end

return var_0_0
