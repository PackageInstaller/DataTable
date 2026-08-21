local var_0_0 = class("LaFeiUrExchangeTemplatePage", import(".TemplatePage.UrExchangeTemplatePage"))

var_0_0.SP_FIRST = 1
var_0_0.SP_DAILY = 2
var_0_0.RANDOM_DAILY = 3
var_0_0.CHALLANGE = 4
var_0_0.MINI_GAME = 5
var_0_0.SHOP_BUY = 6

local function var_0_1(...)
	if false then
		warning(...)
	end

	return
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.shopProxy = getProxy(ShopsProxy)
	arg_2_0.playerProxy = getProxy(PlayerProxy)
	arg_2_0.taskProxy = getProxy(TaskProxy)
	arg_2_0.shopProxy = getProxy(ShopsProxy)
	arg_2_0._tasksTF = arg_2_0._tf:Find("AD/tasks")
	arg_2_0._taskTpl = arg_2_0._tf:Find("AD/task_tpl")
	arg_2_0._ptTip = arg_2_0._tf:Find("pt_tip")
	arg_2_0._tipText = arg_2_0._ptTip:Find("bg/Text")
	arg_2_0._btnSimulate = arg_2_0._tf:Find("AD/btn_simulate")
	arg_2_0._btnExchange = arg_2_0._tf:Find("AD/btn_exchange")
	arg_2_0._btnHelp = arg_2_0._tf:Find("AD/btn_help")
	arg_2_0._ptText = arg_2_0._tf:Find("AD/icon/pt")
	arg_2_0.uilist = UIItemList.New(arg_2_0._tasksTF, arg_2_0._taskTpl)

	setActive(arg_2_0._taskTpl, false)

	return
end

function var_0_0.OnDataSetting(arg_3_0)
	arg_3_0.config = arg_3_0.activity:getConfig("config_client")
	arg_3_0.taskConfig = arg_3_0.config.taskConfig
	arg_3_0.ptId = arg_3_0.config.ptId
	arg_3_0.uPtId = arg_3_0.config.uPtId
	arg_3_0.goodsId = arg_3_0.config.goodsId
	arg_3_0.shopId = arg_3_0.config.shopId
	arg_3_0.length = #arg_3_0.goodsId + 1
	arg_3_0.actShop = arg_3_0.shopProxy:getActivityShopById(arg_3_0.shopId)

	return
end

function var_0_0.OnFirstFlush(arg_4_0)
	setText(arg_4_0._tipText, i18n("UrExchange_Pt_NotEnough"))

	local var_4_0 = getProxy(ActivityProxy):getActivityById(arg_4_0.config.activitytime)

	arg_4_0.isLinkActOpen = var_4_0 and not var_4_0:isEnd()

	setActive(arg_4_0._tasksTF, arg_4_0.isLinkActOpen)
	arg_4_0.uilist:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			arg_4_0:UpdateTask(arg_5_1, arg_5_2)
		end

		return
	end)
	onButton(arg_4_0, arg_4_0._btnSimulate, function()
		if arg_4_0.config.expedition == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tech_simulate_closed"))
		else
			({}).content = i18n("blueprint_simulation_confirm")
			;({}).onYes = function()
				arg_4_0:emit(ActivityMediator.ON_SIMULATION_COMBAT, {
					warnMsg = "tech_simulate_quit",
					stageId = arg_4_0.config.expedition
				}, function()
					return
				end, SFX_PANEL)

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox({})
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_4_0, arg_4_0._btnExchange, function()
		if arg_4_0.canExchange then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				yesText = "text_exchange",
				type = MSGBOX_TYPE_SINGLE_ITEM,
				drop = Drop.Create({
					arg_4_0.curGoods.commodity_type,
					arg_4_0.curGoods.commodity_id,
					1
				}),
				onYes = function()
					arg_4_0:emit(ActivityMediator.ON_ACT_SHOPPING, arg_4_0.shopId, 1, arg_4_0.curGoods.id, 1)
					pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildUrRedeem(arg_4_0.curGoods.commodity_id, 2))

					return
				end
			})
		else
			setActive(arg_4_0._ptTip, true)

			arg_4_0.leantween = LeanTween.delayedCall(1, System.Action(function()
				setActive(arg_4_0._ptTip, false)

				return
			end)).uniqueId
		end

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0._btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("UrExchange_Pt_help")
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.CheckSingleTask(arg_13_0)
	local var_13_0 = getProxy(TaskProxy)
	local var_13_1 = var_13_0:getTaskById(arg_13_0) or var_13_0:getFinishTaskById(arg_13_0)

	var_0_1(arg_13_0, var_13_1 == nil)

	if var_13_1 then
		return var_13_1:getTaskStatus()
	else
		return -1
	end

	return
end

var_0_0.taskTypeDic = {
	[var_0_0.SP_FIRST] = function(arg_14_0, arg_14_1)
		local var_14_0 = var_0_0.CheckSingleTask(arg_14_1[1]) == 2 and 1 or 0

		local function var_14_1()
			arg_14_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
				page = TaskScene.PAGE_TYPE_ACT,
				targetId = arg_14_1[1]
			})

			return
		end

		return var_14_0 .. "/1", var_14_0 ~= 1 and var_14_1 or nil
	end,
	[var_0_0.SP_DAILY] = function(arg_16_0, arg_16_1)
		local var_16_0 = getProxy(ChapterProxy):getChapterById(arg_16_1[1])
		local var_16_1 = var_16_0:isUnlock() and var_16_0:isPlayerLVUnlock() and not var_16_0:enoughTimes2Start()

		return var_16_1 and "1/1" or "0/1", not var_16_1 and function()
			arg_16_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.LEVEL, {
				mapIdx = pg.chapter_template[arg_16_1[1]].map
			})

			return
		end or nil
	end,
	[var_0_0.RANDOM_DAILY] = function(arg_18_0, arg_18_1)
		local var_18_0

		local function var_18_1()
			arg_18_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
				page = TaskScene.PAGE_TYPE_ACT,
				targetId = var_18_0
			})

			return
		end

		local var_18_2 = 0
		local var_18_3 = 0

		for iter_18_0, iter_18_1 in pairs(arg_18_1) do
			local var_18_4 = var_0_0.CheckSingleTask(iter_18_1)

			if var_18_4 == 2 then
				var_18_3 = var_18_3 + 1
			elseif var_18_4 == 1 or var_18_4 == 0 then
				var_18_2 = var_18_2 + 1
				var_18_0 = iter_18_1
			end
		end

		local var_18_5 = var_18_2 + var_18_3

		var_0_1(var_18_2, var_18_3, var_18_2 + var_18_3)

		return var_18_3 .. "/" .. var_18_5, var_18_2 ~= 0 and var_18_1 or nil
	end,
	[var_0_0.CHALLANGE] = function(arg_20_0, arg_20_1)
		local var_20_0 = 0
		local var_20_1

		for iter_20_0, iter_20_1 in pairs(arg_20_1) do
			local var_20_2 = var_0_0.CheckSingleTask(iter_20_1) == 2 and 1 or 0

			var_20_0 = var_20_0 + var_20_2

			if var_20_2 == 0 then
				var_20_1 = var_20_1 or iter_20_1
			end
		end

		local function var_20_3()
			arg_20_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
				page = TaskScene.PAGE_TYPE_ACT,
				targetId = var_20_1
			})

			return
		end

		return var_20_0 .. "/" .. #arg_20_1, var_20_0 ~= #arg_20_1 and var_20_3 or nil
	end,
	[var_0_0.MINI_GAME] = function(arg_22_0, arg_22_1)
		local var_22_0 = getProxy(MiniGameProxy):GetHubByGameId(arg_22_1[1]).count == 0

		local function var_22_1()
			arg_22_0:emit(ActivityMediator.GO_MINI_GAME, var_0)

			return
		end

		return var_22_0 and "1/1" or "0/1", not var_22_0 and var_22_1 or nil
	end,
	[var_0_0.SHOP_BUY] = function(arg_24_0, arg_24_1)
		local var_24_0 = arg_24_0:GetGoodsResCnt(arg_24_1[1])

		return pg.activity_shop_template[arg_24_1[1]].num_limit - var_24_0 .. "/" .. pg.activity_shop_template[arg_24_1[1]].num_limit, var_24_0 ~= 0 and function()
			arg_24_0:emit(ActivityMediator.GO_SHOPS_LAYER, {
				warp = NewShopsScene.TYPE_ACTIVITY,
				actId = arg_24_0.shopId
			})

			return
		end or nil
	end
}

function var_0_0.UpdateTask(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0

	if not arg_26_0.isLinkActOpen then
		do return end

		var_26_0 = arg_26_0.taskConfig[arg_26_1 + 1][1]
	end

	local var_26_1, var_26_2 = var_0_0.taskTypeDic[arg_26_0.taskConfig[arg_26_1 + 1][1]](arg_26_0, arg_26_0.taskConfig[arg_26_1 + 1][3])

	setText(arg_26_2:Find("name"), arg_26_0.taskConfig[arg_26_1 + 1][2])
	setText(arg_26_2:Find("count"), var_26_1)
	setActive(arg_26_2:Find("complete"), var_26_2 == nil)
	setActive(arg_26_2:Find("btn_go"), var_26_2 ~= nil)

	if var_26_2 then
		onButton(arg_26_0, arg_26_2:Find("btn_go"), function()
			var_26_2()
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildUrJump(var_26_0))

			return
		end)
	end

	return
end

function var_0_0.OnUpdateFlush(arg_28_0)
	var_0_1("updateFlush")
	arg_28_0:UpdateExchangeStatus()
	arg_28_0.uilist:align(#arg_28_0.taskConfig)
	arg_28_0:UpdatePtCount()
	setActive(arg_28_0._btnExchange:Find("red"), arg_28_0.canExchange)
	setGray(arg_28_0._btnExchange, arg_28_0.exchangeState == 3, false)

	arg_28_0._btnExchange:GetComponent("Image").raycastTarget = arg_28_0.exchangeState ~= 3

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

		var_0_1(arg_30_0.exchangeState, arg_30_0.curGoods, arg_30_0.canExchange)

		return
	end
end

function var_0_0.UpdatePtCount(arg_32_0)
	setText(arg_32_0._ptText, ((arg_32_0.exchangeState < arg_32_0.length and arg_32_0.ptCount < arg_32_0.curGoods.resource_num and "<color=red>" or "<color=#3689DE>") .. arg_32_0.ptCount .. "</color>/" .. (arg_32_0.exchangeState == 3 and "--" or arg_32_0.curGoods.resource_num)) .. i18n("UrExchange_Pt_charges", arg_32_0.restExchange))

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
