class = var_0_10000

local var_0_0 = "IslandOrderPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

var_0_1.ON_UPDADE = "IslandOrderPage:ON_UPDADE"

function var_0_1.getUIName(arg_1_0)
	return "IslandOrderUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "top/back")

	local var_2_1 = arg_2_0._tf

	arg_2_0.favorBtn = var_1.Find(var_2_1, "top/favor_bg")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "top/favor_bg/level")
	local var_2_4 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.levelTxt = var_2_4(var_2_3, var_3(var_1_10004))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "top/favor_bg/Text")
	local var_2_7 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.expTxt = var_2_7(var_2_6, var_3(var_1_10004))

	local var_2_8 = arg_2_0._tf

	arg_2_0.charTr = var_1.Find(var_2_8, "bottom/char")

	local var_2_9 = arg_2_0.charTr
	local var_2_10 = var_1.Find(var_2_9, "dialogue/Text")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.chatTxt = var_2_11(var_2_10, var_3(var_1_10004))

	local var_2_12 = arg_2_0._tf

	arg_2_0.trendBtn = var_1.Find(var_2_12, "trend_btn")

	local var_2_13 = arg_2_0.trendBtn
	local var_2_14 = var_1.Find(var_2_13, "difficulty")
	local var_2_15 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.trendIco = var_2_15(var_2_14, var_3(var_1_10004))

	local var_2_16 = arg_2_0.trendBtn
	local var_2_17 = var_1.Find(var_2_16, "Text")
	local var_2_18 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.trendTxt = var_2_18(var_2_17, var_3(var_1_10004))

	local var_2_19 = arg_2_0._tf

	arg_2_0.orderContainer = var_1.Find(var_2_19, "map")
	IslandOrderUpgradePage = var_1
	arg_2_0.upgradePage = var_1.New(arg_2_0._parentTf)

	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_1.Find(var_2_20, "count_bg/Text")
	local var_2_22 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.countTxt = var_2_22(var_2_21, var_3(var_1_10004))
	OrderTplPool = var_1

	local var_2_23 = var_1.New
	local var_2_24 = arg_2_0._tf

	arg_2_0.orderTplPool = var_2_23(var_2.Find(var_2_24, "root/orderTpl"), 3, 6)
	arg_2_0.orderTpls = {}
	arg_2_0.timers = {}
	arg_2_0.disappearTimers = {}
	setActive = var_1

	var_1(arg_2_0.charTr, false)

	setText = var_1

	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_2.Find(var_2_25, "top/title/Text")

	i18n = var_2_25

	var_1(var_2_26, var_2_25("island_order_title"))

	return
end

function var_0_1.OnHide(arg_3_0)
	local var_3_0 = arg_3_0.upgradePage

	if var_1.GetLoaded(var_3_0) then
		local var_3_1 = arg_3_0.upgradePage

		var_1.Destroy(var_3_1)

		local var_3_2 = arg_3_0.upgradePage

		var_1.Reset(var_3_2)
	end

	return
end

function var_0_1.OnInit(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_3.Find(var_4_1, "top/title/help")

	local function var_4_3()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		IslandMsgBox = var_2_10003
		var_5_2.type = var_2_10003.TYPE_WHITOUT_BTN
		i18n = var_3
		var_5_2.content = var_3("island_helpbtn_order")

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_0, var_4_2, var_4_3, var_5)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.backBtn

	local function var_4_6()
		local var_6_0 = arg_4_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_4, var_4_5, var_4_6, var_5)

	onButton = var_1_10001

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0.favorBtn

	local function var_4_9()
		local var_7_0 = arg_4_0
		local var_7_1 = var_0.OpenPage

		IslandOrderLevelInfoPage = var_2_10002

		var_7_1(var_7_0, var_2_10002)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_7, var_4_8, var_4_9, var_5)

	onButton = var_1_10001

	local var_4_10 = arg_4_0
	local var_4_11 = arg_4_0.trendBtn

	local function var_4_12()
		getProxy = var_2_10000
		IslandProxy = var_2_10001

		local var_8_0 = var_2_10000(var_2_10001)
		local var_8_1 = var_0.GetIsland(var_8_0)
		local var_8_2 = var_0.GetOrderAgency(var_8_1)
		local var_8_3 = var_0.GetTendency(var_8_2)
		local var_8_4 = arg_4_0
		local var_8_5 = var_2.ShowMsgBox
		local var_8_6 = {}

		IslandMsgBox = var_2_10005
		var_8_6.type = var_2_10005.TYPE_ORDER_TENDENCY
		i18n = var_5
		var_8_6.title = var_5("island_order_difficulty")
		var_8_6.selected = var_8_3

		function var_8_6.onYes(arg_9_0)
			local var_9_0 = arg_4_0
			local var_9_1 = var_1.emit

			IslandMediator = var_3_10003

			var_9_1(var_9_0, var_3_10003.SET_ORDER_TENDENCY, arg_9_0)

			return
		end

		var_8_5(var_8_4, var_8_6)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_10, var_4_11, var_4_12, var_5)
	arg_4_0:UpdateFavorBtn()

	return
end

function var_0_1.UpdateFavorBtn(arg_10_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_10_0 = var_1_10001(var_1_10002)
	local var_10_1 = var_1.GetIsland(var_10_0)
	local var_10_2 = var_1.GetOrderAgency(var_10_1)

	setActive = var_10_1

	var_10_1(arg_10_0.favorBtn, var_10_2:ExpSystemIsOpen())

	return
end

function var_0_1.AddListeners(arg_11_0)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.AddListener

	GAME = var_1_10003

	var_11_1(var_11_0, var_1_10003.ISLAND_SUBMIT_ORDER_DONE, arg_11_0.OnSubmitOrder)

	local var_11_2 = arg_11_0
	local var_11_3 = arg_11_0.AddListener

	GAME = var_3

	var_11_3(var_11_2, var_3.ISLAND_REPLACE_ORDER_DONE, arg_11_0.OnReplaceOrder)

	local var_11_4 = arg_11_0
	local var_11_5 = arg_11_0.AddListener

	IslandOrderAgency = var_3

	var_11_5(var_11_4, var_3.GEN_NEW_ORDER, arg_11_0.OnGenNewOrder)

	local var_11_6 = arg_11_0
	local var_11_7 = arg_11_0.AddListener

	IslandOrderAgency = var_3

	var_11_7(var_11_6, var_3.UDPATE_ORDER, arg_11_0.OnFlushOrder)

	local var_11_8 = arg_11_0
	local var_11_9 = arg_11_0.AddListener

	GAME = var_3

	var_11_9(var_11_8, var_3.ISLAND_SET_ORDER_TENDENCY_DONE, arg_11_0.OnOrderTendencyChanged)

	local var_11_10 = arg_11_0
	local var_11_11 = arg_11_0.AddListener

	IslandScene = var_3

	var_11_11(var_11_10, var_3.ON_CHECK_ORDER_EXP_AWARD, arg_11_0.OnCheckOrderExpAward)
	arg_11_0:AddListener(var_0_1.ON_UPDADE, arg_11_0.OnUpgrade)

	local var_11_12 = arg_11_0
	local var_11_13 = arg_11_0.AddListener

	IslandOrderAgency = var_3

	var_11_13(var_11_12, var_3.ORDER_FINISH_UPDATE, arg_11_0.OnUpdateFinishCnt)

	local var_11_14 = arg_11_0
	local var_11_15 = arg_11_0.AddListener

	GAME = var_3

	var_11_15(var_11_14, var_3.ISLAND_USE_TICKET_DONE, arg_11_0.OnUseTicketDone)

	local var_11_16 = arg_11_0
	local var_11_17 = arg_11_0.AddListener

	IslandAblityAgency = var_3

	var_11_17(var_11_16, var_3.UNLOCK_SYSTEM, arg_11_0.OnUnlockSystem)

	return
end

function var_0_1.RemoveListeners(arg_12_0)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.RemoveListener

	GAME = var_1_10003

	var_12_1(var_12_0, var_1_10003.ISLAND_SUBMIT_ORDER_DONE, arg_12_0.OnSubmitOrder)

	local var_12_2 = arg_12_0
	local var_12_3 = arg_12_0.RemoveListener

	GAME = var_3

	var_12_3(var_12_2, var_3.ISLAND_REPLACE_ORDER_DONE, arg_12_0.OnReplaceOrder)

	local var_12_4 = arg_12_0
	local var_12_5 = arg_12_0.RemoveListener

	GAME = var_3

	var_12_5(var_12_4, var_3.ISLAND_SET_ORDER_TENDENCY_DONE, arg_12_0.OnOrderTendencyChanged)

	local var_12_6 = arg_12_0
	local var_12_7 = arg_12_0.RemoveListener

	IslandOrderAgency = var_3

	var_12_7(var_12_6, var_3.GEN_NEW_ORDER, arg_12_0.OnGenNewOrder)

	local var_12_8 = arg_12_0
	local var_12_9 = arg_12_0.RemoveListener

	IslandOrderAgency = var_3

	var_12_9(var_12_8, var_3.UDPATE_ORDER, arg_12_0.OnFlushOrder)
	arg_12_0:RemoveListener(var_0_1.ON_UPDADE, arg_12_0.OnUpgrade)

	local var_12_10 = arg_12_0
	local var_12_11 = arg_12_0.RemoveListener

	IslandOrderAgency = var_3

	var_12_11(var_12_10, var_3.ORDER_FINISH_UPDATE, arg_12_0.OnUpdateFinishCnt)

	local var_12_12 = arg_12_0
	local var_12_13 = arg_12_0.RemoveListener

	GAME = var_3

	var_12_13(var_12_12, var_3.ISLAND_USE_TICKET_DONE, arg_12_0.OnUseTicketDone)

	local var_12_14 = arg_12_0
	local var_12_15 = arg_12_0.RemoveListener

	IslandAblityAgency = var_3

	var_12_15(var_12_14, var_3.UNLOCK_SYSTEM, arg_12_0.OnUnlockSystem)

	return
end

function var_0_1.OnUnlockSystem(arg_13_0)
	arg_13_0:UpdateFavorBtn()
	arg_13_0:CheckOrderExpAward()

	return
end

function var_0_1.OnReset(arg_14_0)
	arg_14_0:Flush()

	return
end

function var_0_1.OnUpgrade(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.upgradePage

	var_2.ExecuteAction(var_15_0, "Show", arg_15_1.level, arg_15_1.callback)

	return
end

function var_0_1.OnOrderTendencyChanged(arg_16_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_16_0 = var_1_10001(var_1_10002)
	local var_16_1 = var_1.GetIsland(var_16_0)
	local var_16_2 = var_1.GetOrderAgency(var_16_1)

	arg_16_0:UpdateTrendBtn(var_16_2)

	return
end

function var_0_1.OnSubmitOrder(arg_17_0, arg_17_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_17_0 = var_1_10002(var_1_10003)
	local var_17_1 = var_2.GetIsland(var_17_0)
	local var_17_2 = var_2.GetOrderAgency(var_17_1)

	arg_17_0:UpdateExpPanel(var_17_2)
	arg_17_0:UpdateOrderState(arg_17_1.slotId)
	arg_17_0:UpdateCount(var_17_2)

	pairs = var_3

	local var_17_3

	if not arg_17_0.orderTpls then
		var_17_3 = {}
	end

	for iter_17_0, iter_17_1 in var_3(var_17_3) do
		arg_17_0:UpdateOrderState(iter_17_0)
	end

	return
end

function var_0_1.OnReplaceOrder(arg_18_0, arg_18_1)
	arg_18_0:UpdateOrderState(arg_18_1.slotId)

	return
end

function var_0_1.OnGenNewOrder(arg_19_0, arg_19_1)
	arg_19_0:UpdateOrderState(arg_19_1.slotId)

	return
end

function var_0_1.OnFlushOrder(arg_20_0, arg_20_1)
	arg_20_0:UpdateOrderState(arg_20_1.slotId)

	return
end

function var_0_1.OnUseTicketDone(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.type

	IslandUseTicketCommand = var_1_10003

	if var_21_0 == var_1_10003.TYPES.ORDER_CD then
		arg_21_0:UpdateOrderState(arg_21_1.id)
	end

	return
end

function var_0_1.OnCheckOrderExpAward(arg_22_0)
	arg_22_0:CheckOrderExpAward()

	return
end

function var_0_1.OnUpdateFinishCnt(arg_23_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_23_0 = var_1_10001(var_1_10002)
	local var_23_1 = var_1.GetIsland(var_23_0)
	local var_23_2 = var_1.GetOrderAgency(var_23_1)

	arg_23_0:UpdateCount(var_23_2)
	arg_23_0:UpdateExpPanel(var_23_2)

	return
end

function var_0_1.Show(arg_24_0)
	var_0_1.super.Show(arg_24_0)
	arg_24_0:Flush()

	return
end

function var_0_1.Flush(arg_25_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_25_0 = var_1_10001(var_1_10002)
	local var_25_1 = var_1.GetIsland(var_25_0)
	local var_25_2 = var_1.GetOrderAgency(var_25_1)

	arg_25_0:UpdateExpPanel(var_25_2)
	arg_25_0:GenOrderList(var_25_2)
	arg_25_0:TriggerOrder(var_25_2)
	arg_25_0:UpdateTrendBtn(var_25_2)
	arg_25_0:UpdateCount(var_25_2)
	arg_25_0:CheckOrderExpAward()

	return
end

function var_0_1.UpdateCount(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1:GetMaxFinishCount()
	local var_26_1 = arg_26_1:GetFinishCnt()
	local var_26_2 = arg_26_0.countTxt

	i18n = var_1_10005
	var_26_2.text = var_1_10005("island_order_leftCnt_tip") .. var_26_0 - var_26_1 .. "/" .. var_26_0

	return
end

function var_0_1.UpdateTrendBtn(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1:GetTendency()
	local var_27_1 = arg_27_0.trendTxt

	IslandOrderSlot = var_1_10004
	var_27_1.text = var_1_10004.TENDENCY2CN(var_27_0)

	local var_27_2 = ({
		"icon_common",
		"icon_easy",
		"icon_hard"
	})[var_27_0 + 1]

	GetSpriteFromAtlas = var_5

	local var_27_3 = var_5("ui/IslandOrderUI_atlas", var_27_2)

	arg_27_0.trendIco.sprite = var_27_3

	return
end

function var_0_1.CheckOrderExpAward(arg_28_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_28_0 = var_1_10001(var_1_10002)
	local var_28_1 = var_1.GetIsland(var_28_0)
	local var_28_2 = var_1.GetOrderAgency(var_28_1)

	if not var_1.ExpSystemIsOpen(var_28_2) then
		arg_28_0:CheckGuide()

		return
	end

	local var_28_3 = var_1:GetAllCanGetAwardList()
	local var_28_4 = {}

	ipairs = var_1_10004

	for iter_28_0, iter_28_1 in var_1_10004(var_28_3) do
		table = var_1_10009

		var_1_10009.insert(var_28_4, function(arg_29_0)
			local var_29_0 = arg_28_0
			local var_29_1 = var_1.emit

			IslandMediator = var_2_10003

			var_29_1(var_29_0, var_2_10003.ON_GET_ORDER_EXP_AWARD, iter_28_1, arg_29_0)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_28_4, function()
		local var_30_0 = arg_28_0

		var_0.CheckGuide(var_30_0)

		return
	end)

	return
end

function var_0_1.CheckGuide(arg_31_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_31_0 = var_1_10001(var_1_10002)
	local var_31_1 = var_1.GetIsland(var_31_0)
	local var_31_2 = var_1.GetTaskAgency(var_31_1)
	local var_31_3 = var_1.GetTask

	IslandGuideChecker = var_1_10003

	if var_31_3(var_31_2, var_1_10003.ORDER_TASK_ID) then
		onDelayTick = var_31_2

		var_31_2(function()
			getProxy = var_2_10000
			IslandProxy = var_2_10001

			local var_32_0 = var_2_10000(var_2_10001)
			local var_32_1 = var_0.GetIsland(var_32_0)
			local var_32_2 = var_0.GetInventoryAgency(var_32_1)

			underscore = var_32_1

			local var_32_3 = var_32_1.all

			IslandGuideChecker = var_2_10002

			local var_32_4

			if not var_32_3(var_2_10002.ORDER_NEED_ITEMS, function(arg_33_0)
				local var_33_0 = var_32_2

				return var_1.GetOwnCount(var_33_0, arg_33_0[1]) >= arg_33_0[2]
			end) or not {
				1,
				2
			} then
				var_32_4 = {
					1,
					3
				}
			end

			IslandGuideChecker = var_3

			local var_32_5 = var_3.CheckGuideWithArgs
			local var_32_6 = "ISLAND_GUIDE_7"

			IslandGuideChecker = var_2_10005

			var_32_5(var_32_6, var_2_10005.FINISH_TYPE.ON_GUIDE, nil, var_32_4)

			return
		end, 0.2)
	end

	return
end

function var_0_1.TriggerOrder(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1:GetCacheSelectedId()

	if arg_34_1:GetSlots()[var_34_0] then
		var_1_10006 = var_4

		if not var_4.IsEmpty(var_1_10006) then
			if arg_34_0.orderTpls[var_4.id] then
				triggerButton = var_1_10006

				var_1_10006(var_5)
			end

			goto label_34_0
		end
	end

	do
		local var_34_1

		pairs = var_1_10006

		for iter_34_0, iter_34_1 in var_1_10006(var_3) do
			if not iter_34_1:IsEmpty() then
				var_34_1 = iter_34_1

				break
			end
		end

		if var_34_1 and arg_34_0.orderTpls[var_34_1.id] then
			triggerButton = var_7

			var_7(var_6)
		end
	end

	::label_34_0::

	return
end

function var_0_1.GenOrderList(arg_35_0, arg_35_1)
	arg_35_0:ReturnOrderTplList()

	local var_35_0 = arg_35_1
	local var_35_1 = arg_35_1.GetSlots(var_35_0)

	pairs = var_35_0

	for iter_35_0, iter_35_1 in var_35_0(var_35_1) do
		arg_35_0:NewOrderTpl(iter_35_1.id)
		arg_35_0:UpdateOrderState(iter_35_1.id)
	end

	return
end

function var_0_1.NewOrderTpl(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0.orderTplPool
	local var_36_1 = var_2.Dequeue(var_36_0)

	setParent = var_36_0

	var_36_0(var_36_1, arg_36_0.orderContainer)

	arg_36_0.orderTpls[arg_36_1] = var_36_1

	return var_36_1
end

function var_0_1.ReturnOrderTplList(arg_37_0)
	pairs = var_1_10001

	for iter_37_0, iter_37_1 in var_1_10001(arg_37_0.orderTpls) do
		local var_37_0 = arg_37_0.orderTplPool

		var_6.Enqueue(var_37_0, iter_37_1)
	end

	arg_37_0.orderTpls = {}

	return
end

function var_0_1.UpdateOrderState(arg_38_0, arg_38_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_38_0 = var_1_10002(var_1_10003)
	local var_38_1 = var_2.GetIsland(var_38_0)
	local var_38_2 = var_2.GetOrderAgency(var_38_1)
	local var_38_3 = var_2.GetSlot(var_38_2, arg_38_1)
	local var_38_4

	if not arg_38_0.orderTpls[arg_38_1] then
		var_38_4 = arg_38_0:NewOrderTpl(arg_38_1)
	end

	arg_38_0:RemoveLoadingTimer(arg_38_1)
	arg_38_0:RemoveDisappearTimer(arg_38_1)
	arg_38_0:ShowDiaglog(var_38_3)

	if not var_38_3 or var_38_3:IsEmpty() then
		removeOnButton = var_5

		var_5(var_38_4)

		setActive = var_5

		var_5(var_38_4, false)

		return
	end

	local var_38_5 = var_38_4.transform

	var_38_5.localPosition = var_38_3:GetPosition()
	setActive = var_38_5

	var_38_5(var_38_4, true)

	onButton = var_38_5

	local var_38_6 = arg_38_0
	local var_38_7 = var_38_4

	local function var_38_8()
		local var_39_0 = arg_38_0

		var_0.ClickOrder(var_39_0, var_38_4, var_38_3)

		arg_38_0.selected = var_38_4

		return
	end

	SFX_PANEL = var_1_10009

	var_38_5(var_38_6, var_38_7, var_38_8, var_1_10009)

	local var_38_9 = var_38_3:GetOrder()
	local var_38_10 = var_38_3
	local var_38_11 = var_38_3.CanSubmit(var_38_10)

	setActive = var_38_10

	local var_38_12 = var_38_4.transform

	var_38_10(var_8.Find(var_38_12, "bg_urgent"), var_38_9:IsUrgency())

	setActive = var_38_10

	local var_38_13 = var_38_4.transform

	var_38_10(var_8.Find(var_38_13, "bg_act"), var_38_9:IsActivity())

	setActive = var_38_10

	local var_38_14 = var_38_4.transform
	local var_38_15 = var_8.Find(var_38_14, "sel")
	local var_38_16

	if arg_38_0.selected then
		var_38_16 = arg_38_0.selected == var_38_4
	end

	var_38_10(var_38_15, var_38_16)

	setActive = var_38_10

	local var_38_17 = var_38_4.transform

	var_38_10(var_8.Find(var_38_17, "finish"), var_38_11)

	setActive = var_38_10

	local var_38_18 = var_38_4.transform
	local var_38_19 = var_8.Find(var_38_18, "easy")
	local var_38_20 = var_38_9
	local var_38_21 = var_38_9.GetTendency(var_38_20)

	IslandOrderSlot = var_38_20

	var_38_10(var_38_19, var_38_21 == var_38_20.TENDENCY_TYPE_EASY)

	setActive = var_38_10

	local var_38_22 = var_38_4.transform
	local var_38_23 = var_8.Find(var_38_22, "hard")
	local var_38_24 = var_38_9
	local var_38_25 = var_38_9.GetTendency(var_38_24)

	IslandOrderSlot = var_38_24

	var_38_10(var_38_23, var_38_25 == var_38_24.TENDENCY_TYPE_HARD)

	local var_38_26 = var_38_3
	local var_38_27 = var_38_3.IsLoading(var_38_26)

	setActive = var_38_26

	local var_38_28 = var_38_4.transform

	var_38_26(var_9.Find(var_38_28, "icon"), not var_38_27)

	setActive = var_38_26

	local var_38_29 = var_38_4.transform

	var_38_26(var_9.Find(var_38_29, "loading"), var_38_27)

	setActive = var_38_26

	local var_38_30 = var_38_4.transform

	var_38_26(var_9.Find(var_38_30, "bg/progress"), not var_38_27)

	local var_38_31 = var_38_9
	local var_38_32 = var_38_9.GetRoleIcon(var_38_31)

	GetImageSpriteFromAtlasAsync = var_38_31

	local var_38_33 = "island/IslandShipIcon/" .. var_38_32
	local var_38_34 = ""
	local var_38_35 = var_38_4.transform

	var_38_31(var_38_33, var_38_34, var_12.Find(var_38_35, "icon"))

	if var_38_27 then
		arg_38_0:AddLoadingTimer(var_38_4, var_38_3)
	end

	if var_38_9:IsUrgency() then
		arg_38_0:AddDisappearTimer(var_38_4, var_38_3)
	end

	return
end

function var_0_1.AddDisappearTimer(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0:RemoveDisappearTimer(arg_40_2.id)

	local var_40_0 = arg_40_2
	local var_40_1 = arg_40_2.GetDisappearTime(var_40_0)

	pg = var_40_0

	local var_40_2 = var_40_0.TimeMgr.GetInstance()

	if var_40_1 <= var_4.GetServerTime(var_40_2) then
		return
	end

	local var_40_3 = arg_40_0.disappearTimers
	local var_40_4 = arg_40_2.id

	Timer = var_1_10006
	var_40_3[var_40_4] = var_1_10006.New(function()
		pg = var_2_10000

		local var_41_0 = var_2_10000.TimeMgr.GetInstance()
		local var_41_1 = var_0.GetServerTime(var_41_0)
		local var_41_2 = var_40_1 - var_41_1

		pg = var_2_10002

		local var_41_3 = var_2_10002.TimeMgr.GetInstance()
		local var_41_4 = var_2.DescCDTime(var_41_3, var_41_2)

		setText = var_41_3

		local var_41_5 = arg_40_1.transform

		var_41_3(var_4.Find(var_41_5, "bg_urgent/time_label/Text"), var_41_4)

		if var_41_2 < 0 then
			local var_41_6 = arg_40_0

			var_3.UpdateOrderState(var_41_6, arg_40_2.id)
		end

		return
	end, 1, -1)

	arg_40_0.disappearTimers[arg_40_2.id].func()

	local var_40_5 = arg_40_0.disappearTimers[arg_40_2.id]

	var_4.Start(var_40_5)

	return
end

function var_0_1.RemoveDisappearTimer(arg_42_0, arg_42_1)
	if arg_42_0.disappearTimers[arg_42_1] then
		local var_42_0 = arg_42_0.disappearTimers[arg_42_1]

		var_2.Stop(var_42_0)

		arg_42_0.disappearTimers[arg_42_1] = nil
	end

	return
end

function var_0_1.ClickOrder(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0
	local var_43_1 = arg_43_0.OpenPage

	IslandOrderDescPage = var_1_10005

	var_43_1(var_43_0, var_1_10005, arg_43_2)

	local var_43_2 = arg_43_0

	arg_43_0.ShowDiaglog(var_43_2, arg_43_2)

	getProxy = var_3
	IslandProxy = var_43_2

	local var_43_3 = var_3(var_43_2)
	local var_43_4 = var_3.GetIsland(var_43_3)
	local var_43_5 = var_3.GetOrderAgency(var_43_4)

	var_3.SetCacheSelectedId(var_43_5, arg_43_2.id)

	if arg_43_0.selected then
		setActive = var_3

		local var_43_6 = arg_43_0.selected.transform

		var_3(var_4.Find(var_43_6, "sel"), false)
	end

	setActive = var_3

	local var_43_7 = arg_43_1.transform

	var_3(var_4.Find(var_43_7, "sel"), true)

	return
end

function var_0_1.ShowDiaglog(arg_44_0, arg_44_1)
	if not arg_44_1 or not arg_44_1:GetOrder() or arg_44_1:IsEmpty() or arg_44_1:IsLoading() then
		setActive = var_1_10002

		var_1_10002(arg_44_0.charTr, false)

		return
	end

	local var_44_0 = arg_44_1
	local var_44_1 = arg_44_1.GetOrder(var_44_0)

	setActive = var_44_0

	var_44_0(arg_44_0.charTr, true)

	local var_44_2 = var_44_1
	local var_44_3 = var_44_1.GetRoleIcon(var_44_2)

	GetImageSpriteFromAtlasAsync = var_44_2

	var_44_2("island/IslandShipIconHalf/" .. var_44_3, "", arg_44_0.charTr)

	arg_44_0.chatTxt.text = var_44_1:GetDesc()

	return
end

function var_0_1.AddLoadingTimer(arg_45_0, arg_45_1, arg_45_2)
	local function var_45_0()
		local var_46_0 = arg_45_0

		var_0.UpdateOrderState(var_46_0, arg_45_2.id)

		return
	end

	local var_45_1 = arg_45_2:GetCanSubmitTime()
	local var_45_2 = arg_45_2
	local var_45_3 = arg_45_2.GetTotalTime(var_45_2)

	Timer = var_45_2

	local var_45_4 = var_45_2.New(function()
		pg = var_2_10000

		local var_47_0 = var_2_10000.TimeMgr.GetInstance()
		local var_47_1 = var_0.GetServerTime(var_47_0)
		local var_47_2 = var_45_1 - var_47_1

		setText = var_2_10002

		local var_47_3 = arg_45_1.transform
		local var_47_4 = var_3.Find(var_47_3, "loading/time_label/Text")

		pg = var_47_3

		local var_47_5 = var_47_3.TimeMgr.GetInstance()

		var_2_10002(var_47_4, var_4.DescCDTime(var_47_5, var_47_2))

		setFillAmount = var_2_10002

		local var_47_6 = arg_45_1.transform

		var_2_10002(var_3.Find(var_47_6, "loading/progress"), 1 - var_47_2 / var_45_3)

		if var_47_2 <= 0 then
			var_45_0()
		end

		return
	end, 1, -1)

	var_6.Start(var_45_4)
	var_6.func()

	arg_45_0.timers[arg_45_2.id] = var_6

	return
end

function var_0_1.RemoveLoadingTimer(arg_48_0, arg_48_1)
	if arg_48_0.timers[arg_48_1] then
		local var_48_0 = arg_48_0.timers[arg_48_1]

		var_2.Stop(var_48_0)

		arg_48_0.timers[arg_48_1] = nil
	end

	return
end

function var_0_1.RemoveAllLoadingTimer(arg_49_0)
	pairs = var_1_10001

	for iter_49_0, iter_49_1 in var_1_10001(arg_49_0.timers) do
		iter_49_1:Stop()
	end

	pairs = var_1

	for iter_49_2, iter_49_3 in var_1(arg_49_0.disappearTimers) do
		iter_49_3:Stop()
	end

	arg_49_0.disappearTimers = {}
	arg_49_0.timers = {}

	return
end

function var_0_1.UpdateExpPanel(arg_50_0, arg_50_1)
	arg_50_0.levelTxt.text = arg_50_1:GetLevel()

	if arg_50_1:IsMaxLevel() then
		arg_50_0.expTxt.text = "MAX"
	else
		local var_50_0 = arg_50_1
		local var_50_1 = arg_50_1.GetExp(var_50_0)

		math = var_50_0

		local var_50_2 = var_50_0.max(1, arg_50_1:GetNextTargetExp())

		arg_50_0.expTxt.text = var_50_1 .. "/" .. var_50_2
	end

	return
end

function var_0_1.OnDestroy(arg_51_0)
	local var_51_0 = arg_51_0.upgradePage

	if var_1.GetLoaded(var_51_0) then
		local var_51_1 = arg_51_0.upgradePage

		var_1.Destroy(var_51_1)

		arg_51_0.upgradePage = nil
	end

	if arg_51_0.orderTplPool then
		local var_51_2 = arg_51_0.orderTplPool

		var_1.Dispose(var_51_2)

		arg_51_0.orderTplPool = nil
	end

	arg_51_0:RemoveAllLoadingTimer()

	return
end

return var_0_1
