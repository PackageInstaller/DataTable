local var_0_0 = class("CoreURExchangeTemplatePage", import("view.activity.CorePage.CoreActivityPage"))

var_0_0.SP_FIRST = 1
var_0_0.SP_DAILY = 2
var_0_0.RANDOM_DAILY = 3
var_0_0.CHALLANGE = 4
var_0_0.MINI_GAME = 5
var_0_0.SHOP_BUY = 6
var_0_0.GO_TASK = 7
var_0_0.MINI_GAME_ACT = 8

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
	arg_1_0.uilist = UIItemList.New(arg_1_0._tasksTF, arg_1_0._taskTpl)

	setActive(arg_1_0._taskTpl, false)

	arg_1_0._msgBox = arg_1_0._tf:Find("msg_box")
	arg_1_0._msgBoxBtnCancel = arg_1_0._tf:Find("msg_box/btn_cancel")
	arg_1_0._msgBoxBtnConfirm = arg_1_0._tf:Find("msg_box/btn_confirm")
	arg_1_0._msgBoxLabel = arg_1_0._tf:Find("msg_box/label/text_cn")
	arg_1_0._msgBoxItem = arg_1_0._tf:Find("msg_box/item/IconTpl")
	arg_1_0._msgBoxItemName = arg_1_0._tf:Find("msg_box/item/name")
	arg_1_0._msgBoxItemDesc = arg_1_0._tf:Find("msg_box/item/desc")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.config = arg_2_0.activity:getConfig("config_client")
	arg_2_0.taskConfig = arg_2_0.config.taskConfig
	arg_2_0.ptId = arg_2_0.config.ptId
	arg_2_0.uPtId = arg_2_0.config.uPtId
	arg_2_0.goodsId = arg_2_0.config.goodsId
	arg_2_0.shopId = arg_2_0.config.shopId
	arg_2_0.length = #arg_2_0.goodsId + 1
	arg_2_0.actShop = arg_2_0.shopProxy:getActivityShopById(arg_2_0.shopId)

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	setText(arg_3_0._tipText, i18n("UrExchange_Pt_NotEnough"))

	local var_3_0 = getProxy(ActivityProxy):getActivityById(arg_3_0.config.activitytime)

	arg_3_0.isLinkActOpen = var_3_0 and not var_3_0:isEnd()

	setActive(arg_3_0._tasksTF, arg_3_0.isLinkActOpen)
	arg_3_0.uilist:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateTask(arg_4_1, arg_4_2)
		end

		return
	end)
	onButton(arg_3_0, arg_3_0._btnSimulate, function()
		if arg_3_0.config.expedition == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tech_simulate_closed"))
		else
			({}).content = i18n("blueprint_simulation_confirm")
			;({}).onYes = function()
				arg_3_0:emit(ActivityMediator.ON_SIMULATION_COMBAT, {
					warnMsg = "tech_simulate_quit",
					stageId = arg_3_0.config.expedition
				}, function()
					return
				end, SFX_PANEL)

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox({})
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_3_0, arg_3_0._msgBoxBtnCancel, function()
		arg_3_0:closeMsgBox()

		return
	end)
	onButton(arg_3_0, arg_3_0._msgBox, function()
		arg_3_0:closeMsgBox()

		return
	end)
	onButton(arg_3_0, arg_3_0._msgBoxBtnConfirm, function()
		arg_3_0:closeMsgBox()
		arg_3_0:emit(ActivityMediator.ON_ACT_SHOPPING, arg_3_0.shopId, 1, arg_3_0.curGoods.id, 1)
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildUrRedeem(arg_3_0.curGoods.commodity_id, 2))

		return
	end)
	onButton(arg_3_0, arg_3_0._btnExchange, function()
		if arg_3_0.canExchange then
			local var_11_0 = Drop.Create({
				arg_3_0.curGoods.commodity_type,
				arg_3_0.curGoods.commodity_id,
				1
			})

			updateDrop(arg_3_0._msgBoxItem, var_11_0)
			setText(arg_3_0._msgBoxItemName, var_11_0:getName())
			setText(arg_3_0._msgBoxItemDesc, var_11_0.desc)
			pg.UIMgr.GetInstance():BlurPanel(arg_3_0._msgBox)
			setActive(arg_3_0._msgBox, true)

			arg_3_0.isMsgBoxShow = true
		else
			setActive(arg_3_0._ptTip, true)

			arg_3_0.leantween = LeanTween.delayedCall(1, System.Action(function()
				setActive(arg_3_0._ptTip, false)

				return
			end)).uniqueId
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("UrExchange_Pt_help")
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.CheckSingleTask(arg_14_0)
	local var_14_0 = getProxy(TaskProxy)
	local var_14_1 = var_14_0:getTaskById(arg_14_0) or var_14_0:getFinishTaskById(arg_14_0)

	if var_14_1 then
		return var_14_1:getTaskStatus()
	else
		return -1
	end

	return
end

var_0_0.taskTypeDic = {
	[var_0_0.SP_FIRST] = function(arg_15_0, arg_15_1)
		local var_15_0 = var_0_0.CheckSingleTask(arg_15_1[1]) == 2 and 1 or 0

		local function var_15_1()
			arg_15_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
				page = TaskScene.PAGE_TYPE_ACT,
				targetId = arg_15_1[1]
			})

			return
		end

		return var_15_0 .. "/1", var_15_0 ~= 1 and var_15_1 or nil
	end,
	[var_0_0.SP_DAILY] = function(arg_17_0, arg_17_1)
		local var_17_0 = getProxy(ChapterProxy):getChapterById(arg_17_1[1])
		local var_17_1 = var_17_0:isUnlock() and var_17_0:isPlayerLVUnlock() and not var_17_0:enoughTimes2Start()

		return var_17_1 and "1/1" or "0/1", not var_17_1 and function()
			arg_17_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.LEVEL, {
				mapIdx = pg.chapter_template[arg_17_1[1]].map
			})

			return
		end or nil
	end,
	[var_0_0.RANDOM_DAILY] = function(arg_19_0, arg_19_1)
		local var_19_0

		local function var_19_1()
			arg_19_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
				page = TaskScene.PAGE_TYPE_ACT,
				targetId = var_19_0
			})

			return
		end

		local var_19_2 = 0
		local var_19_3 = 0

		for iter_19_0, iter_19_1 in pairs(arg_19_1) do
			local var_19_4 = var_0_0.CheckSingleTask(iter_19_1)

			if var_19_4 == 2 then
				var_19_3 = var_19_3 + 1
			elseif var_19_4 == 1 or var_19_4 == 0 then
				var_19_2 = var_19_2 + 1
				var_19_0 = iter_19_1
			end
		end

		return var_19_3 .. "/" .. var_19_2 + var_19_3, var_19_2 ~= 0 and var_19_1 or nil
	end,
	[var_0_0.CHALLANGE] = function(arg_21_0, arg_21_1)
		local var_21_0 = 0
		local var_21_1

		for iter_21_0, iter_21_1 in pairs(arg_21_1) do
			local var_21_2 = var_0_0.CheckSingleTask(iter_21_1) == 2 and 1 or 0

			var_21_0 = var_21_0 + var_21_2

			if var_21_2 == 0 then
				var_21_1 = var_21_1 or iter_21_1
			end
		end

		local function var_21_3()
			arg_21_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
				page = TaskScene.PAGE_TYPE_ACT,
				targetId = var_21_1
			})

			return
		end

		return var_21_0 .. "/" .. #arg_21_1, var_21_0 ~= #arg_21_1 and var_21_3 or nil
	end,
	[var_0_0.MINI_GAME] = function(arg_23_0, arg_23_1)
		local var_23_0 = getProxy(MiniGameProxy):GetHubByGameId(arg_23_1[1]).count == 0

		local function var_23_1()
			arg_23_0:emit(ActivityMediator.GO_MINI_GAME, var_0)

			return
		end

		return var_23_0 and "1/1" or "0/1", not var_23_0 and var_23_1 or nil
	end,
	[var_0_0.SHOP_BUY] = function(arg_25_0, arg_25_1)
		local var_25_0 = arg_25_0:GetGoodsResCnt(arg_25_1[1])

		return pg.activity_shop_template[arg_25_1[1]].num_limit - var_25_0 .. "/" .. pg.activity_shop_template[arg_25_1[1]].num_limit, var_25_0 ~= 0 and function()
			arg_25_0:emit(ActivityMediator.GO_SHOPS_LAYER, {
				warp = NewShopsScene.TYPE_ACTIVITY,
				actId = arg_25_0.shopId
			})

			return
		end or nil
	end,
	[var_0_0.GO_TASK] = function(arg_27_0, arg_27_1, arg_27_2)
		local var_27_0 = #arg_27_1
		local var_27_1 = getProxy(TaskProxy)

		while var_27_0 > 0 do
			local var_27_2 = var_27_1:getTaskById(arg_27_1[var_27_0]) or var_27_1:getFinishTaskById(arg_27_1[var_27_0])

			if var_27_2 then
				if var_27_2:getTaskStatus() ~= 2 then
					var_27_0 = var_27_0 - 1
				end

				break
			end

			var_27_0 = var_27_0 - 1
		end

		return var_27_0 .. "/" .. #arg_27_1, function()
			arg_27_0:emit(ActivityMediator.EVENT_GO_SCENE, arg_27_2)

			return
		end
	end,
	[var_0_0.MINI_GAME_ACT] = function(arg_29_0, arg_29_1, arg_29_2)
		local var_29_0 = arg_29_1[2]
		local var_29_1 = getProxy(MiniGameProxy):GetHubByGameId(arg_29_1[1]).count == 0

		local function var_29_2()
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
				id = var_29_0
			})

			return
		end

		return var_29_1 and "1/1" or "0/1", not var_29_1 and var_29_2 or nil
	end
}

function var_0_0.UpdateTask(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0

	if not arg_31_0.isLinkActOpen then
		do return end

		var_31_0 = arg_31_0.taskConfig[arg_31_1 + 1][1]
	end

	local var_31_1, var_31_2 = var_0_0.taskTypeDic[arg_31_0.taskConfig[arg_31_1 + 1][1]](arg_31_0, arg_31_0.taskConfig[arg_31_1 + 1][3], arg_31_0.taskConfig[arg_31_1 + 1][4])

	setText(arg_31_2:Find("name"), arg_31_0.taskConfig[arg_31_1 + 1][2])
	setText(arg_31_2:Find("count"), var_31_1)
	setActive(arg_31_2:Find("complete"), var_31_2 == nil)
	setActive(arg_31_2:Find("btn_go"), var_31_2 ~= nil)

	if var_31_2 then
		onButton(arg_31_0, arg_31_2:Find("btn_go"), function()
			var_31_2()
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildUrJump(var_31_0))

			return
		end)
	end

	return
end

function var_0_0.OnUpdateFlush(arg_33_0)
	arg_33_0:UpdateExchangeStatus()
	arg_33_0.uilist:align(#arg_33_0.taskConfig)
	arg_33_0:UpdatePtCount()
	setActive(arg_33_0._btnExchange:Find("red"), arg_33_0.canExchange)
	setGray(arg_33_0._btnExchange, arg_33_0.exchangeState == 3, false)

	arg_33_0._btnExchange:GetComponent("Image").raycastTarget = arg_33_0.exchangeState ~= 3

	return
end

function var_0_0.GetGoodsResCnt(arg_34_0, arg_34_1)
	return arg_34_0.actShop:GetCommodityById(arg_34_1):GetPurchasableCnt()
end

function var_0_0.UpdateExchangeStatus(arg_35_0)
	arg_35_0.player = arg_35_0.playerProxy:getData()
	arg_35_0.ptCount = arg_35_0.player:getResource(arg_35_0.uPtId)
	arg_35_0.restExchange = _.reduce(arg_35_0.goodsId, 0, function(arg_36_0, arg_36_1)
		return arg_36_0 + arg_35_0.actShop:GetCommodityById(arg_36_1):GetPurchasableCnt()
	end)
	arg_35_0.exchangeState = arg_35_0.length - arg_35_0.restExchange

	if arg_35_0.exchangeState < arg_35_0.length then
		arg_35_0.curGoods = pg.activity_shop_template[arg_35_0.goodsId[arg_35_0.exchangeState]] or nil
		arg_35_0.canExchange = arg_35_0.exchangeState < arg_35_0.length and arg_35_0.ptCount >= arg_35_0.curGoods.resource_num

		return
	end
end

function var_0_0.UpdatePtCount(arg_37_0)
	setText(arg_37_0._ptText, ((arg_37_0.exchangeState < arg_37_0.length and arg_37_0.ptCount < arg_37_0.curGoods.resource_num and "<color=red>" or "<color=#3689DE>") .. arg_37_0.ptCount .. "</color>/" .. (arg_37_0.exchangeState == 3 and "--" or arg_37_0.curGoods.resource_num)) .. i18n("UrExchange_Pt_charges", arg_37_0.restExchange))

	return
end

function var_0_0.OnDestroy(arg_38_0)
	eachChild(arg_38_0._tasksTF, function(arg_39_0)
		Destroy(arg_39_0)

		return
	end)

	return
end

function var_0_0.IsShowingPopWindow(arg_40_0)
	return arg_40_0.isMsgBoxShow
end

function var_0_0.ClosePopWindow(arg_41_0)
	arg_41_0:closeMsgBox()

	return
end

function var_0_0.closeMsgBox(arg_42_0)
	arg_42_0.isMsgBoxShow = false

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_42_0._msgBox)
	setActive(arg_42_0._msgBox, false)

	return
end

return var_0_0
