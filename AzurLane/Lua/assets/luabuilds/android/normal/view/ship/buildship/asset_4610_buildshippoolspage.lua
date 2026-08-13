class = var_0_10000

local var_0_0 = "BuildShipPoolsPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "BuildShipPoolsPageUI"
end

function var_0_1.RefreshActivityBuildPool(arg_2_0, arg_2_1)
	underscore = var_1_10002

	if var_1_10002.detect(arg_2_0.pools, function(arg_3_0)
		local var_3_0

		if arg_3_0:IsActivity() then
			var_3_0 = arg_3_0.activityId == arg_2_1.id
		end

		return var_3_0
	end) then
		arg_2_0:UpdateBuildPoolExchange(var_2)
		arg_2_0:UpdateTicket()
	end

	return
end

function var_0_1.RefreshFreeBuildActivity(arg_4_0)
	pairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.freeActTimer) do
		iter_4_1:Stop()
	end

	arg_4_0.freeActTimer = {}
	ipairs = var_1
	getProxy = var_2
	ActivityProxy = var_3

	local var_4_0 = var_2(var_3)
	local var_4_1 = var_2.getActivitiesByType

	ActivityConst = iter_4_0

	for iter_4_2, iter_4_3 in var_1(var_4_1(var_4_0, iter_4_0.ACTIVITY_TYPE_BUILD_FREE)) do
		if iter_4_3:isEnd() == false then
			local var_4_2 = arg_4_0.freeActTimer
			local var_4_3 = iter_4_3.id

			Timer = var_1_10008
			var_1_10008 = var_1_10008.New

			local function var_4_4()
				local var_5_0 = arg_4_0
				local var_5_1 = var_0.emit

				BuildShipMediator = var_2_10002

				var_5_1(var_5_0, var_2_10002.ON_UPDATE_ACT)

				return
			end

			local var_4_5 = iter_4_3.stopTime

			pg = var_1_10011

			local var_4_6 = var_1_10011.TimeMgr.GetInstance()

			var_4_2[var_4_3] = var_1_10008(var_4_4, var_4_5 - var_1_10011.GetServerTime(var_4_6))

			local var_4_7 = arg_4_0.freeActTimer[iter_4_3.id]

			var_6.Start(var_4_7)
		end
	end

	return
end

function var_0_1.RefreshRegularExchangeCount(arg_6_0)
	if arg_6_0.pool then
		arg_6_0:UpdateRegularBuildPoolExchange(arg_6_0.pool)
	end

	return
end

function var_0_1.OnLoaded(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.quickCount = var_1.Find(var_7_0, "gallery/res_items/item")

	local var_7_1 = arg_7_0.quickCount

	arg_7_0.useItemTF = var_1.Find(var_7_1, "Text")

	local var_7_2 = arg_7_0._tf

	arg_7_0.freeCount = var_1.Find(var_7_2, "gallery/res_items/ticket")

	local var_7_3 = arg_7_0.freeCount

	arg_7_0.ticketTF = var_1.Find(var_7_3, "Text")

	local var_7_4 = arg_7_0._tf

	arg_7_0.patingTF = var_1.Find(var_7_4, "painting")

	local var_7_5 = arg_7_0._tf

	arg_7_0.poolContainer = var_1.Find(var_7_5, "gallery/toggle_bg/bg/toggles")

	local var_7_6 = arg_7_0.poolContainer

	arg_7_0.newTpl = var_1.Find(var_7_6, "new")
	arg_7_0.newPoolTpls = {
		arg_7_0.newTpl
	}

	local var_7_7 = arg_7_0.poolContainer

	arg_7_0.specialTpl = var_1.Find(var_7_7, "special")
	arg_7_0.specialPoolTpls = {
		arg_7_0.specialTpl
	}

	local var_7_8 = arg_7_0.poolContainer

	arg_7_0.lightTpl = var_1.Find(var_7_8, "light")
	arg_7_0.lightPoolTpls = {
		arg_7_0.lightTpl
	}

	local var_7_9 = arg_7_0.poolContainer

	arg_7_0.heavyTpl = var_1.Find(var_7_9, "heavy")
	arg_7_0.heavyPoolTpls = {
		arg_7_0.heavyTpl
	}

	local var_7_10 = arg_7_0._tf

	arg_7_0.maskContainer = var_1.Find(var_7_10, "gallery/mask")

	local var_7_11 = arg_7_0._tf

	arg_7_0.buildPoolExchangeTF = var_1.Find(var_7_11, "gallery/exchange_bg")

	local var_7_12 = arg_7_0.buildPoolExchangeTF

	arg_7_0.buildPoolExchangeGetBtn = var_1.Find(var_7_12, "get")

	local var_7_13 = arg_7_0.buildPoolExchangeTF
	local var_7_14 = var_1.Find(var_7_13, "Text")
	local var_7_15 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_7_0.buildPoolExchangeTxt = var_7_15(var_7_14, var_3(var_1_10004))

	local var_7_16 = arg_7_0.buildPoolExchangeGetBtn

	arg_7_0.buildPoolExchangeGetBtnMark = var_1.Find(var_7_16, "mark")

	local var_7_17 = arg_7_0.buildPoolExchangeGetBtn
	local var_7_18 = var_1.Find(var_7_17, "Text")
	local var_7_19 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_7_0.buildPoolExchangeGetTxt = var_7_19(var_7_18, var_3(var_1_10004))

	local var_7_20 = arg_7_0.buildPoolExchangeTF
	local var_7_21 = var_1.Find(var_7_20, "name")
	local var_7_22 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_7_0.buildPoolExchangeName = var_7_22(var_7_21, var_3(var_1_10004))

	local var_7_23 = arg_7_0._tf

	arg_7_0.rtRegularExchange = var_1.Find(var_7_23, "gallery/exchange_ur_bg")
	setText = var_1

	local var_7_24 = arg_7_0.rtRegularExchange
	local var_7_25 = var_2.Find(var_7_24, "name/Text")

	i18n = var_7_24

	var_1(var_7_25, var_7_24("Normalbuild_URexchange_text1"))

	onButton = var_1

	local var_7_26 = arg_7_0
	local var_7_27 = arg_7_0.rtRegularExchange
	local var_7_28 = var_3.Find(var_7_27, "name/icon")

	local function var_7_29()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_8_2.type = var_2_10003
		i18n = var_2_10003
		var_8_2.helps = var_2_10003("Normalbuild_URexchange_help")

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_PANEL = var_5

	var_1(var_7_26, var_7_28, var_7_29, var_5)

	setText = var_1

	local var_7_30 = arg_7_0.rtRegularExchange
	local var_7_31 = var_2.Find(var_7_30, "count/name")

	i18n = var_7_30

	var_1(var_7_31, var_7_30("Normalbuild_URexchange_text2") .. ":")

	setText = var_1

	local var_7_32 = arg_7_0.rtRegularExchange
	local var_7_33 = var_2.Find(var_7_32, "show/Text")

	i18n = var_7_32

	var_1(var_7_33, var_7_32("Normalbuild_URexchange_text3"))

	setText = var_1

	local var_7_34 = arg_7_0.rtRegularExchange
	local var_7_35 = var_2.Find(var_7_34, "get/Text")

	i18n = var_7_34

	var_1(var_7_35, var_7_34("Normalbuild_URexchange_text4"))

	ipairs = var_1

	local var_7_36 = {}
	local var_7_37 = arg_7_0.rtRegularExchange

	var_7_36[1] = var_3.Find(var_7_37, "show")

	local var_7_38 = arg_7_0.rtRegularExchange

	var_7_36[2] = var_3.Find(var_7_38, "get")

	for iter_7_0, iter_7_1 in var_1(var_7_36) do
		onButton = var_1_10006

		local var_7_39 = arg_7_0
		local var_7_40 = iter_7_1

		local function var_7_41()
			local var_9_0 = arg_7_0
			local var_9_1 = var_0.emit

			BuildShipMediator = var_2_10002

			var_9_1(var_9_0, var_2_10002.ON_BUILDPOOL_UR_EXCHANGE)

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_7_39, var_7_40, var_7_41, var_1_10010)
	end

	local var_7_42 = arg_7_0._tf
	local var_7_43 = var_1.Find(var_7_42, "gallery/bg/type_intro/mask/title")

	arg_7_0.tipSTxt = var_1.GetComponent(var_7_43, "ScrollText")

	local var_7_44 = arg_7_0._tf

	arg_7_0.tipTime = var_1.Find(var_7_44, "gallery/bg/time_text")

	local var_7_45 = arg_7_0._tf

	arg_7_0.helpBtn = var_1.Find(var_7_45, "gallery/help_btn")

	local var_7_46 = arg_7_0._tf

	arg_7_0.testBtn = var_1.Find(var_7_46, "gallery/test_btn")

	local var_7_47 = arg_7_0._tf

	arg_7_0.prevArr = var_1.Find(var_7_47, "gallery/prev_arr")

	local var_7_48 = arg_7_0._tf

	arg_7_0.nextArr = var_1.Find(var_7_48, "gallery/next_arr")
	arg_7_0.activityTimer = {}
	arg_7_0.freeActTimer = {}

	return
end

function var_0_1.OnInit(arg_10_0)
	onButton = var_1_10001

	var_1_10001(arg_10_0, arg_10_0.quickCount, function()
		pg = var_2_10000

		local var_11_0 = var_2_10000.shop_template[61008]

		shoppingBatch = var_1

		var_1(61008, {
			id = var_11_0.effect_args[1]
		}, 9, "build_ship_quickly_buy_stone")

		return
	end)

	onButton = var_1_10001

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.helpBtn

	local function var_10_2()
		local var_12_0 = arg_10_0.pool
		local var_12_1 = var_0.getConfigTable(var_12_0)
		local var_12_2 = arg_10_0.contextData.helpWindow

		var_2.ExecuteAction(var_12_2, "Show", var_12_1, nil, var_0:IsActivity())

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_10_0, var_10_1, var_10_2, var_1_10005)

	return
end

function var_0_1.Flush(arg_13_0, arg_13_1, arg_13_2)
	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_13_0 = var_1_10003(var_1_10004)

	underscore = var_1_10004
	arg_13_0.pools = var_1_10004.filter(arg_13_1, function(arg_14_0)
		local var_14_0 = var_13_0
		local var_14_1 = var_1.getBuildPoolActivity(var_14_0, arg_14_0)

		tobool = var_14_0

		local var_14_2 = var_14_0(arg_13_2)

		if var_14_1 then
			local var_14_3 = var_14_1
			local var_14_4 = var_14_1.getConfig(var_14_3, "type")

			ActivityConst = var_14_3

			local var_14_5

			if var_14_4 ~= var_14_3.ACTIVITY_TYPE_NEWSERVER_BUILD then
				var_14_5 = false

				if false then
					var_14_5 = false
				end
			else
				var_14_5 = true
			end

			return var_14_2 == var_14_5
		end
	end)

	if #arg_13_0.pools > 4 then
		arg_13_0:AdjustToggleContainer()
	end

	local var_13_1 = {}
	local var_13_2 = arg_13_0
	local var_13_3 = arg_13_0.ActivePool(var_13_2)

	BuildShipScene = var_13_2

	local var_13_4 = var_13_2.buildShipActPoolId

	arg_13_0:RemoveAllTimer()

	eachChild = var_7

	var_7(arg_13_0.poolContainer, function(arg_15_0)
		setActive = var_2_10001

		var_2_10001(arg_15_0, false)

		return
	end)

	ipairs = var_7

	for iter_13_0, iter_13_1 in var_7(arg_13_0.pools) do
		local var_13_5 = iter_13_1:GetMark()
		local var_13_6 = arg_13_0
		local var_13_7 = arg_13_0.GetPoolTpl(var_13_6, var_13_5)

		setActive = var_13_6

		var_13_6(var_13_7, true)

		if iter_13_1:IsActivity() then
			arg_13_0:AddActivityTimer(iter_13_1)
		end

		local var_13_8 = var_13_7
		local var_13_9 = var_13_7.Find(var_13_8, "frame")

		removeOnToggle = var_13_8

		var_13_8(var_13_9)

		triggerToggle = var_13_8

		var_13_8(var_13_9, false)

		onToggle = var_13_8

		local var_13_10 = arg_13_0
		local var_13_11 = var_13_9

		local function var_13_12(arg_16_0)
			if arg_16_0 then
				local var_16_0 = arg_13_0

				var_1.SwitchPool(var_16_0, iter_13_1)
			end

			return
		end

		SFX_PANEL = var_1_10019

		var_13_8(var_13_10, var_13_11, var_13_12, var_1_10019)

		var_13_1[iter_13_1:GetPoolId()] = var_13_7
	end

	table = var_7

	var_7.sort(arg_13_0.pools, function(arg_17_0, arg_17_1)
		if arg_17_0:GetSortCode() == arg_17_1:GetSortCode() then
			return arg_17_0:GetPoolId() > arg_17_1:GetPoolId()
		else
			return var_3 < var_2
		end

		return
	end)

	ipairs = var_7

	for iter_13_2, iter_13_3 in var_7(arg_13_0.pools) do
		local var_13_13 = var_13_1[iter_13_3:GetPoolId()]

		var_12.SetAsFirstSibling(var_13_13)
	end

	local var_13_14 = arg_13_0
	local var_13_15 = arg_13_0.GetActivePool(var_13_14, var_13_3, var_13_4)

	triggerToggle = var_13_14

	local var_13_16 = var_13_1[var_13_15:GetPoolId()]

	var_13_14(var_9.Find(var_13_16, "frame"), true)

	local var_13_17
	local var_13_18
	local var_13_19 = arg_13_0.contextData

	var_13_19.projectName = nil
	scrollTo = var_13_19

	var_13_19(arg_13_0.poolContainer.parent, 0, 1)
	arg_13_0:RefreshFreeBuildActivity()
	arg_13_0:UpdateItem(arg_13_0.contextData.itemVO.count)

	onNextTick = var_8

	var_8(function()
		local var_18_0 = arg_13_0

		var_0.UpdateArr(var_18_0, #arg_13_0.pools)

		return
	end)

	return
end

local function var_0_2(arg_19_0)
	_ = var_1_10001

	local var_19_0 = var_1_10001.select(arg_19_0.pools, function(arg_20_0)
		local var_20_0 = arg_20_0
		local var_20_1 = arg_20_0.GetMark(var_20_0)

		BuildShipPool = var_20_0

		return var_20_1 == var_20_0.BUILD_POOL_MARK_NEW
	end)

	table = var_2

	var_2.sort(var_19_0, function(arg_21_0, arg_21_1)
		return arg_21_0:GetPoolId() < arg_21_1:GetPoolId()
	end)

	return var_19_0[1]
end

function var_0_1.GetActivePool(arg_22_0, arg_22_1, arg_22_2)
	if not arg_22_1 then
		return nil
	end

	local var_22_0

	BuildShipPool = var_1_10004

	if arg_22_1 == var_1_10004.BUILD_POOL_MARK_NEW then
		_ = var_4
		var_22_0 = var_4.detect(arg_22_0.pools, function(arg_23_0)
			return arg_23_0:GetPoolId() == arg_22_2
		end) or var_0_2(arg_22_0)
	else
		_ = var_4
		var_22_0 = var_4.detect(arg_22_0.pools, function(arg_24_0)
			return arg_24_0:GetMark() == arg_22_1
		end)
	end

	return var_22_0 or arg_22_0.pools[1]
end

function var_0_1.AdjustToggleContainer(arg_25_0)
	if not arg_25_0.isInit then
		local var_25_0 = arg_25_0.poolContainer.parent

		SetParent = var_1_10002

		var_1_10002(var_25_0, arg_25_0.maskContainer)

		local var_25_1 = 0.85
		local var_25_2 = var_25_0.sizeDelta * (1 + (1 - var_25_1))

		Vector3 = var_4
		var_25_0.localScale = var_4(var_25_1, var_25_1, 1)
		var_25_0.sizeDelta = var_25_2

		local var_25_3 = arg_25_0.poolContainer
		local var_25_4 = var_4.GetComponent

		typeof = var_6
		HorizontalLayoutGroup = var_7
		var_25_4(var_25_3, var_6(var_7)).padding.left = 60
		var_4.padding.right = 60
		var_4.padding.top = 0
		arg_25_0.isInit = true
	end

	return
end

function var_0_1.UpdateArr(arg_26_0, arg_26_1)
	if arg_26_1 <= 4 then
		setActive = var_2

		var_2(arg_26_0.prevArr, false)

		setActive = var_2

		var_2(arg_26_0.nextArr, false)

		return
	end

	getBounds = var_2

	local var_26_0 = var_2(arg_26_0.maskContainer)
	local var_26_1 = arg_26_0.poolContainer
	local var_26_2 = var_3.GetChild(var_26_1, 0)
	local var_26_3 = arg_26_0.poolContainer
	local var_26_4 = var_4.GetChild(var_26_3, arg_26_0.poolContainer.childCount - 1)

	onScroll = var_26_3

	var_26_3(arg_26_0, arg_26_0.poolContainer.parent, function(arg_27_0)
		getBounds = var_2_10001

		local var_27_0 = var_2_10001(var_26_2)

		getBounds = var_2

		local var_27_1 = var_2(var_26_4)

		setActive = var_3

		var_3(arg_26_0.prevArr, arg_27_0.x > 0.01)

		setActive = var_3

		var_3(arg_26_0.nextArr, arg_27_0.x < 0.99)

		return
	end)

	onButton = var_26_3

	local var_26_5 = arg_26_0
	local var_26_6 = arg_26_0.prevArr

	local function var_26_7()
		scrollTo = var_2_10000

		var_2_10000(arg_26_0.poolContainer.parent, 0, 1)

		return
	end

	SFX_PANEL = var_1_10009

	var_26_3(var_26_5, var_26_6, var_26_7, var_1_10009)

	onButton = var_26_3

	local var_26_8 = arg_26_0
	local var_26_9 = arg_26_0.nextArr

	local function var_26_10()
		scrollTo = var_2_10000

		var_2_10000(arg_26_0.poolContainer.parent, 1, 1)

		return
	end

	SFX_PANEL = var_1_10009

	var_26_3(var_26_8, var_26_9, var_26_10, var_1_10009)

	return
end

function var_0_1.GetPoolTpl(arg_30_0, arg_30_1)
	assert = var_1_10002

	var_1_10002(arg_30_0[arg_30_1 .. "PoolTpls"])

	if #arg_30_0[arg_30_1 .. "PoolTpls"] <= 0 then
		local var_30_0 = arg_30_0[arg_30_1 .. "Tpl"]
		local var_30_1 = var_3.GetSiblingIndex(var_30_0)

		Object = var_30_0

		local var_30_2 = var_30_0.Instantiate(var_3, arg_30_0.poolContainer).transform

		var_5.SetSiblingIndex(var_30_2, var_30_1 + 1)

		return var_5
	else
		table = var_3

		return var_3.remove(var_2, 1)
	end

	return
end

function var_0_1.ActivePool(arg_31_0)
	_ = var_1_10001

	local var_31_0 = var_1_10001.any(arg_31_0.pools, function(arg_32_0)
		return arg_32_0:IsActivity()
	end)

	getProxy = var_2
	ActivityProxy = var_3

	local var_31_1 = var_2(var_3)
	local var_31_2 = var_2.getActivityByType

	ActivityConst = var_1_10004

	local var_31_3 = var_31_2(var_31_1, var_1_10004.ACTIVITY_TYPE_BUILD)

	if arg_31_0.contextData.activity then
		local var_31_4 = arg_31_0.contextData.activity

		if 0 < var_31_4 then
			local var_31_5 = arg_31_0.contextData

			BuildShipPool = var_4
			var_31_5.projectName = var_4.BUILD_POOL_MARK_NEW
			getProxy = var_31_5
			ActivityProxy = var_4

			local var_31_6 = var_31_5(var_4)

			if var_3.getActivityById(var_31_6, arg_31_0.contextData.activity) then
				var_1_10005 = var_3

				if not var_3.isEnd(var_1_10005) then
					BuildShipScene = var_4
					var_4.buildShipActPoolId = var_3:getConfig("config_id")
				end
			end
		end
	end

	local var_31_7
	local var_31_8

	if arg_31_0.contextData.projectName then
		var_31_7 = arg_31_0.contextData.projectName
	else
		BuildShipScene = var_31_8

		if var_31_8.projectName then
			BuildShipScene = var_31_8
			var_31_8 = var_31_8.projectName
			BuildShipPool = var_1_10005

			if var_31_8 == var_1_10005.BUILD_POOL_MARK_NEW and not var_31_0 then
				BuildShipPool = var_31_8
				var_31_7 = var_31_8.BUILD_POOL_MARK_HEAVY
			else
				BuildShipScene = var_31_8
				var_31_7 = var_31_8.projectName
			end
		elseif var_31_0 then
			BuildShipPool = var_31_8
			var_31_7 = var_31_8.BUILD_POOL_MARK_NEW
		elseif var_31_3 and not var_31_3:isEnd() then
			local var_31_9 = var_31_3

			var_31_8 = var_31_3.getConfig(var_31_9, "config_client").id
			_ = var_31_9

			if not var_31_9.detect(arg_31_0.pools, function(arg_33_0)
				return arg_33_0.id == var_31_8
			end) or not var_5:GetMark() then
				::label_31_0::

				BuildShipPool = var_6
				var_31_7 = var_6.BUILD_POOL_MARK_HEAVY
			end
		elseif not arg_31_0.contextData.projectName then
			::label_31_1::

			BuildShipScene = var_31_8

			if not var_31_8.projectName then
				::label_31_2::

				BuildShipPool = var_31_8
				var_31_7 = var_31_8.BUILD_POOL_MARK_HEAVY
			end
		end
	end

	underscore = var_31_8

	if not var_31_8.any(arg_31_0.pools, function(arg_34_0)
		return arg_34_0:GetMark() == var_31_7
	end) then
		local var_31_10 = arg_31_0.pools[1]

		return var_4.GetMark(var_31_10)
	else
		return var_31_7
	end

	return
end

function var_0_1.UpdateItem(arg_35_0, arg_35_1)
	setText = var_1_10002

	var_1_10002(arg_35_0.useItemTF, arg_35_1)

	Canvas = var_1_10002

	var_1_10002.ForceUpdateCanvases()

	return
end

function var_0_1.UpdateTicket(arg_36_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_36_0 = var_1_10001(var_1_10002)

	if var_1.getBuildFreeActivityByBuildId(var_36_0, arg_36_0.pool.id) and not var_2:isEnd() then
		Drop = var_36_0
		var_36_0 = var_36_0.New

		local var_36_1 = {}

		DROP_TYPE_VITEM = var_1_10005
		var_36_1.type = var_1_10005
		var_36_1.id = var_2:getConfig("config_client")[1]
		var_36_1.count = var_2.data1
		var_36_0 = var_36_0(var_36_1)

		local var_36_2 = var_2.stopTime

		pg = var_5

		local var_36_3 = var_5.TimeMgr.GetInstance()
		local var_36_4 = var_36_2 - var_5.GetServerTime(var_36_3) < 0

		setActive = var_5

		local var_36_5 = arg_36_0.freeCount

		var_5(var_6.Find(var_36_5, "tip"), var_36_4 and var_36_0.count > 0)

		LoadImageSpriteAtlasAsync = var_5

		local var_36_6 = var_36_0:getConfig("icon")
		local var_36_7 = ""
		local var_36_8 = arg_36_0.freeCount

		var_5(var_36_6, var_36_7, var_8.Find(var_36_8, "icon"))

		setText = var_5

		var_5(arg_36_0.ticketTF, var_2.data1)

		onButton = var_5

		local var_36_9 = arg_36_0
		local var_36_10 = arg_36_0.freeCount

		local function var_36_11()
			local var_37_0 = arg_36_0
			local var_37_1 = var_0.emit

			BaseUI = var_2_10002

			var_37_1(var_37_0, var_2_10002.ON_DROP, var_36_0)

			return
		end

		SFX_PANEL = var_36_8

		var_5(var_36_9, var_36_10, var_36_11, var_36_8)

		local var_36_12 = arg_36_0._tf
		local var_36_13 = var_5.Find(var_36_12, "gallery/item_bg/ticket")

		LoadImageSpriteAtlasAsync = var_36_12

		var_36_12(var_36_0:getConfig("icon"), "", var_36_13:Find("icon"))

		setText = var_36_12

		var_36_12(var_36_13:Find("name"), var_36_0:getConfig("name"))

		setText = var_36_12

		local var_36_14 = var_36_13
		local var_36_15 = var_36_13.Find(var_36_14, "tip")

		i18n = var_36_14

		var_36_12(var_36_15, var_36_14("build_ticket_description"))
	end

	checkExist = var_36_0

	local var_36_16 = var_36_0(var_1:getBuildPoolActivity(arg_36_0.pool), {
		"getConfig",
		{
			"type"
		}
	})

	ActivityConst = var_4

	local var_36_17 = var_36_16 == var_4.ACTIVITY_TYPE_NEWSERVER_BUILD

	setText = var_4

	local var_36_18 = arg_36_0._tf
	local var_36_19 = var_5.Find(var_36_18, "gallery/prints/intro/text")

	if var_36_17 then
		i18n = var_36_18

		if not var_36_18("newserver_build_tip") then
			i18n = var_36_18
			var_36_18 = var_36_18("build_pools_intro")
		end

		var_4(var_36_19, var_36_18)

		setActive = var_4

		local var_36_20 = arg_36_0.freeCount

		tobool = var_36_18

		var_4(var_36_20, var_36_18(var_2))

		setActive = var_4

		var_4(arg_36_0.quickCount, not var_36_17)

		arg_36_0.useTicket = var_36_17 or var_2 and var_2.data1 > 0
		setActive = var_4

		local var_36_21 = arg_36_0._tf

		var_4(var_5.Find(var_36_21, "gallery/item_bg/item"), not arg_36_0.useTicket)

		setActive = var_4

		local var_36_22 = arg_36_0._tf

		var_4(var_5.Find(var_36_22, "gallery/item_bg/gold"), not arg_36_0.useTicket)

		setActive = var_4

		local var_36_23 = arg_36_0._tf

		var_4(var_5.Find(var_36_23, "gallery/item_bg/ticket"), arg_36_0.useTicket)

		return
	end
end

function var_0_1.SwitchPool(arg_38_0, arg_38_1)
	arg_38_0.pool = arg_38_1
	arg_38_0.buildPainting = nil
	getProxy = var_2
	ActivityProxy = var_1_10003

	local var_38_0 = var_2(var_1_10003)
	local var_38_1 = var_2.getBuildPoolActivity(var_38_0, arg_38_1)

	PLATFORM_CODE = var_38_0
	PLATFORM_CH = var_5

	if var_38_0 == var_5 and var_38_1 then
		arg_38_0.buildPainting = var_38_1:getConfig("config_client").build_painting
	end

	setActive = var_38_0

	local var_38_2 = arg_38_0.tipTime
	local var_38_3

	if var_38_1 then
		::label_38_0::

		var_1_10007 = var_38_1
		var_38_3 = var_38_1.isVariableTime(var_1_10007)
	end

	var_38_0(var_38_2, var_38_3)

	isActive = var_38_0

	if var_38_0(arg_38_0.tipTime) then
		pg = var_4

		local var_38_4 = var_4.TimeMgr.GetInstance()
		local var_38_5 = var_38_1:getStartTime()
		local var_38_6 = var_38_1.stopTime

		setText = var_1_10007

		var_1_10007(arg_38_0.tipTime, var_38_4:STimeDescC(var_38_5, "%Y.%m.%d") .. " - " .. var_38_4:STimeDescC(var_38_6, "%m.%d %H:%M"))
	end

	local var_38_7 = arg_38_1
	local var_38_8 = arg_38_1.GetMark(var_38_7)

	GetSpriteFromAtlas = var_38_7

	local var_38_9 = var_38_7("ui/BuildShipUI_atlas", "sub_title_" .. var_38_8)
	local var_38_10 = arg_38_0._tf
	local var_38_11 = var_6.Find(var_38_10, "gallery/bg/type")
	local var_38_12 = var_6.GetComponent

	typeof = var_8
	Image = var_1_10009
	var_38_12(var_38_11, var_8(var_1_10009)).sprite = var_38_9

	local var_38_13 = arg_38_1:getConfigTable()
	local var_38_14
	local var_38_15

	if arg_38_1:IsActivity() then
		var_38_14 = var_2:getBuildActivityCfgByID(var_38_13.id)
	else
		var_38_14 = var_2:getNoneActBuildActivityCfgByID(var_38_13.id)
	end

	HXSet = var_9

	local var_38_16 = var_9.HxPath
	local var_38_17

	if not var_38_14 or not var_38_14.bg then
		var_38_17 = "loadingbg/bg_" .. var_38_13.icon
	end

	local var_38_18 = var_38_16(var_38_17)

	LoadSprite = var_38_17

	local var_38_19 = var_38_17(var_38_18)
	local var_38_20 = var_38_14 and var_38_14.buildship_tip
	local var_38_21 = arg_38_0.tipSTxt
	local var_38_22 = var_11.SetText

	if var_38_20 then
		HXSet = var_1_10013

		if not var_1_10013.hxLan(var_38_20) then
			i18n = var_1_10013
			var_1_10013 = var_1_10013("buildship_" .. var_38_8 .. "_tip")
		end

		var_38_22(var_38_21, var_1_10013)

		local var_38_23 = arg_38_0._tf
		local var_38_24 = var_11.Find(var_38_23, "gallery/bg")
		local var_38_25 = var_11.GetComponent

		typeof = var_13
		Image = var_1_10014
		var_38_25(var_38_24, var_13(var_1_10014)).sprite = var_38_19

		local var_38_26 = arg_38_0._tf
		local var_38_27 = var_12.Find(var_38_26, "gallery/item_bg/item/Text")
		local var_38_28 = arg_38_0._tf
		local var_38_29 = var_13.Find(var_38_28, "gallery/item_bg/gold/Text")

		setText = var_38_28

		var_38_28(var_38_27, var_38_13.number_1)

		setText = var_38_28

		var_38_28(var_38_29, var_38_13.use_gold)
		arg_38_0:UpdateBuildPoolExchange(arg_38_1)
		arg_38_0:UpdateRegularBuildPoolExchange(arg_38_1)
		arg_38_0:UpdateTicket()
		arg_38_0:UpdateTestBtn(arg_38_1)
		arg_38_0:UpdateBuildPoolPaiting(arg_38_1)

		local var_38_30 = {}

		if arg_38_1:getConfig("exchange_count") > 0 then
			table = var_15

			var_15.insert(var_38_30, function(arg_39_0)
				getProxy = var_2_10001
				BuildShipProxy = var_2_10002

				local var_39_0 = var_2_10001(var_2_10002)
				local var_39_1 = var_1.getRegularExchangeCount(var_39_0)

				pg = var_39_0

				local var_39_2 = var_39_0.ship_data_create_exchange

				REGULAR_BUILD_POOL_EXCHANGE_ID = var_2_10003

				if not (var_39_1 < var_39_2[var_2_10003].exchange_request) then
					PlayerPrefs = var_39_1
					var_39_1 = var_39_1.GetString("REGULAR_BUILD_MAX_TIP", "")
					pg = var_2

					local var_39_3 = var_2.TimeMgr.GetInstance()

					if var_39_1 == var_2.CurrentSTimeDesc(var_39_3, "%Y/%m/%d") then
						arg_39_0()
					else
						pg = var_39_1

						local var_39_4 = var_39_1.MsgboxMgr.GetInstance()

						local function var_39_5(arg_40_0)
							PlayerPrefs = var_3_10001

							local var_40_0 = var_3_10001.SetString
							local var_40_1 = "REGULAR_BUILD_MAX_TIP"

							if arg_40_0 then
								pg = var_3_10003

								local var_40_2 = var_3_10003.TimeMgr.GetInstance()
								local var_40_3

								if not var_3.CurrentSTimeDesc(var_40_2, "%Y/%m/%d") then
									var_40_3 = ""
								end

								var_40_0(var_40_1, var_40_3)

								return
							end
						end

						local var_39_6 = var_39_4
						local var_39_7 = var_39_4.ShowMsgBox
						local var_39_8 = {
							showStopRemind = true
						}

						i18n = var_2_10006
						var_39_8.content = var_2_10006("Normalbuild_URexchange_warning3")
						i18n = var_6
						var_39_8.stopRamindContent = var_6("dont_remind_today")

						function var_39_8.onYes()
							var_39_5(var_39_4.stopRemindToggle.isOn)
							arg_39_0()

							return
						end

						function var_39_8.onNo()
							var_39_5(var_39_4.stopRemindToggle.isOn)

							return
						end

						var_39_7(var_39_6, var_39_8)
					end

					return
				end
			end)
		end

		onButton = var_15

		local var_38_31 = arg_38_0
		local var_38_32 = arg_38_0._tf
		local var_38_33 = var_17.Find(var_38_32, "gallery/start_btn")

		local function var_38_34()
			seriesAsync = var_2_10000

			var_2_10000(var_38_30, function()
				if arg_38_0.useTicket then
					local var_44_0 = var_0
					local var_44_1

					if not var_0.getBuildFreeActivityByBuildId(var_44_0, arg_38_0.pool.id) then
						var_44_1 = nil
					end

					if arg_38_0.useTicket and (not var_44_1 or var_44_1:isEnd()) then
						pg = var_1

						local var_44_2 = var_1.TipsMgr.GetInstance()
						local var_44_3 = var_1.ShowTips

						i18n = var_3_10003

						var_44_3(var_44_2, var_3_10003("common_activity_end"))

						return
					end

					local var_44_4 = arg_38_0.contextData.msgbox
					local var_44_5 = var_1.ExecuteAction
					local var_44_6 = "Show"

					if arg_38_0.useTicket then
						local var_44_7 = {
							buildType = "ticket"
						}

						Item = var_3_10005
						var_44_7.itemVO = var_3_10005.New({
							id = var_44_1:getConfig("config_client")[1],
							count = var_44_1.data1
						})
						var_44_7.buildPool = var_38_13
						MAX_BUILD_WORK_COUNT = var_5
						var_44_7.max = var_5 - arg_38_0.contextData.startCount

						function var_44_7.onConfirm(arg_45_0)
							local var_45_0 = arg_38_1

							if var_1.IsActivity(var_45_0) then
								local var_45_1 = arg_38_0
								local var_45_2 = var_1.emit

								BuildShipMediator = var_4_10003
								var_4_10003 = var_4_10003.ACT_ON_BUILD

								local var_45_3 = arg_38_1

								var_45_2(var_45_1, var_4_10003, var_4.GetActivityId(var_45_3), var_38_13.id, arg_45_0, true)
							else
								local var_45_4 = arg_38_0
								local var_45_5 = var_1.emit

								BuildShipMediator = var_4_10003

								var_45_5(var_45_4, var_4_10003.ON_BUILD, var_38_13.id, arg_45_0, true)
							end

							return
						end

						if not var_44_7 then
							var_44_7 = {
								buildType = "base",
								player = arg_38_0.contextData.player,
								itemVO = arg_38_0.contextData.itemVO,
								buildPool = var_38_13
							}
							MAX_BUILD_WORK_COUNT = var_5
							var_44_7.max = var_5 - arg_38_0.contextData.startCount

							function var_44_7.onConfirm(arg_46_0)
								local var_46_0 = arg_38_1

								if var_1.IsActivity(var_46_0) then
									local var_46_1 = arg_38_0
									local var_46_2 = var_1.emit

									BuildShipMediator = var_4_10003
									var_4_10003 = var_4_10003.ACT_ON_BUILD

									local var_46_3 = arg_38_1

									var_46_2(var_46_1, var_4_10003, var_4.GetActivityId(var_46_3), var_38_13.id, arg_46_0)
								else
									local var_46_4 = arg_38_0
									local var_46_5 = var_1.emit

									BuildShipMediator = var_4_10003

									var_46_5(var_46_4, var_4_10003.ON_BUILD, var_38_13.id, arg_46_0)
								end

								return
							end
						end

						var_44_5(var_44_4, var_44_6, var_44_7)

						return
					end
				end
			end)

			return
		end

		SFX_UI_BUILDING_STARTBUILDING = var_19

		var_15(var_38_31, var_38_33, var_38_34, var_19)

		BuildShipScene = var_15
		var_15.projectName = var_38_8

		if arg_38_1:IsActivity() then
			BuildShipScene = var_15
			var_15.buildShipActPoolId = arg_38_1:GetPoolId()
		end

		return
	end
end

local function var_0_3(arg_47_0)
	if not arg_47_0:IsActivity() then
		return false
	end

	pg = var_1

	return var_1.ship_data_create_exchange[arg_47_0:GetActivityId()] and #var_1.exchange_ship_id > 0
end

function var_0_1.UpdateBuildPoolPaiting(arg_48_0, arg_48_1)
	local var_48_0

	if arg_48_0.buildPainting then
		var_48_0 = arg_48_0.buildPainting
	elseif var_0_3(arg_48_1) then
		pg = var_3

		local var_48_1 = var_3.ship_data_create_exchange
		local var_48_2 = arg_48_1
		local var_48_3 = var_48_1[arg_48_1.GetActivityId(var_48_2)].exchange_ship_id[1]

		pg = var_4

		local var_48_4 = var_4.ship_data_statistics[var_48_3]

		assert = var_48_2

		var_48_2(var_48_4)

		pg = var_48_2
		var_48_0 = var_48_2.ship_skin_template[var_48_4.skin_id].painting
	else
		local var_48_5 = arg_48_0.contextData.falgShip

		var_48_0 = var_3.getPainting(var_48_5)
	end

	if arg_48_0.painting ~= var_48_0 then
		local function var_48_6()
			arg_48_0.painting = var_48_0

			local var_49_0 = arg_48_0

			var_0.Hx4Channel(var_49_0)

			return
		end

		arg_48_0:RevertHxChannel()

		if arg_48_0.buildPainting then
			setBuildPaintingPrefabAsync = var_4

			var_4(arg_48_0.patingTF, var_48_0, "build", var_48_6)
		else
			setPaintingPrefabAsync = var_4

			var_4(arg_48_0.patingTF, var_48_0, "build", var_48_6)
		end
	end

	return
end

local function var_0_4(arg_50_0)
	local var_50_0 = arg_50_0.patingTF

	if var_1.Find(var_50_0, "fitter").childCount <= 0 then
		return nil
	end

	local var_50_1 = var_1
	local var_50_2 = var_1.GetChild(var_50_1, 0)

	IsNil = var_50_1

	if var_50_1(var_50_2) then
		return nil
	end

	pg = var_3

	local var_50_3 = var_3.SdkMgr.GetInstance()
	local var_50_4 = var_3.GetChannelUIDIncludeHarmony(var_50_3)

	return (var_50_2:Find("build_hx_ch" .. var_50_4))
end

function var_0_1.Hx4Channel(arg_51_0)
	local var_51_0 = var_0_4(arg_51_0)

	IsNil = var_2

	if not var_2(var_51_0) then
		setActive = var_2

		local var_51_1 = var_51_0

		HXSet = var_1_10004

		var_2(var_51_1, var_1_10004.isHx())
	end

	return
end

function var_0_1.RevertHxChannel(arg_52_0)
	local var_52_0 = var_0_4(arg_52_0)

	IsNil = var_2

	if not var_2(var_52_0) then
		setActive = var_2

		var_2(var_52_0, false)
	end

	return
end

function var_0_1.UpdateBuildPoolExchange(arg_53_0, arg_53_1)
	local var_53_0
	local var_53_1
	local var_53_2
	local var_53_3 = arg_53_1

	if arg_53_1.IsActivity(var_53_3) then
		var_53_3 = arg_53_1

		local var_53_4 = arg_53_1.GetActivityId(var_53_3)

		pg = var_53_3

		if var_53_3.ship_data_create_exchange[var_53_4] then
			var_53_0 = var_53_3.exchange_request
			var_53_1 = var_53_3.exchange_available_times
			var_53_2 = var_53_3.exchange_ship_id[1]
		end
	end

	if var_53_0 and var_53_0 > 0 and var_53_1 and var_53_1 > 0 then
		local var_53_5 = arg_53_1:GetActivity().data1
		local var_53_6 = var_53_3.data2

		math = var_1_10009

		local var_53_7 = var_1_10009.min(var_53_1, var_53_6 + 1) * var_53_0
		local var_53_8 = arg_53_0.buildPoolExchangeTxt

		i18n = var_11
		var_53_8.text = var_11("build_count_tip") .. "<color=#FFDF48>" .. var_53_5 .. "</color>/" .. var_53_7

		local var_53_9 = var_53_6 < var_53_1 and var_53_7 <= var_53_5

		setActive = var_11

		var_11(arg_53_0.buildPoolExchangeGetBtnMark, var_53_9)

		local var_53_10 = arg_53_0.buildPoolExchangeGetTxt

		var_53_10.text = var_53_6 .. "/" .. var_53_1
		pg = var_53_10

		local var_53_11 = var_53_10.ship_data_statistics[var_53_2].name
		local var_53_12 = arg_53_0.buildPoolExchangeName

		SwitchSpecialChar = var_13
		var_53_12.text = var_13(var_53_11, true)
		pg = var_53_12

		local var_53_13 = var_53_12.ship_data_statistics[var_53_2].rarity

		eachChild = var_13

		local var_53_14 = arg_53_0.buildPoolExchangeTF

		var_13(var_14.Find(var_53_14, "bg"), function(arg_54_0)
			setActive = var_2_10001

			local var_54_0 = arg_54_0
			local var_54_1 = arg_54_0.name

			tostring = var_2_10004

			var_2_10001(var_54_0, var_54_1 == var_2_10004(var_53_13))

			return
		end)

		onButton = var_13

		local var_53_15 = arg_53_0
		local var_53_16 = arg_53_0.buildPoolExchangeTF

		local function var_53_17()
			if var_53_9 then
				local var_55_0 = arg_53_0
				local var_55_1 = var_0.emit

				BuildShipMediator = var_2_10002

				var_55_1(var_55_0, var_2_10002.ON_BUILDPOOL_EXCHANGE, var_53_3.id)
			end

			return
		end

		SFX_PANEL = var_1_10017

		var_13(var_53_15, var_53_16, var_53_17, var_1_10017)

		setGray = var_13

		var_13(arg_53_0.buildPoolExchangeGetBtn, not var_53_9, true)

		setButtonEnabled = var_13

		var_13(arg_53_0.buildPoolExchangeTF, var_53_9)
	else
		removeOnButton = var_53_3

		var_53_3(arg_53_0.buildPoolExchangeTF)
	end

	setActive = var_53_3

	var_53_3(arg_53_0.buildPoolExchangeTF, var_5)

	return
end

function var_0_1.UpdateRegularBuildPoolExchange(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_1:getConfig("exchange_count")
	local var_56_1 = 0 < var_56_0

	setActive = var_3

	var_3(arg_56_0.rtRegularExchange, var_56_1)

	if var_56_1 then
		getProxy = var_3
		BuildShipProxy = var_4

		local var_56_2 = var_3(var_4)
		local var_56_3 = var_3.getRegularExchangeCount(var_56_2)

		pg = var_56_2

		local var_56_4 = var_56_2.ship_data_create_exchange

		REGULAR_BUILD_POOL_EXCHANGE_ID = var_5

		local var_56_5 = var_56_4[var_5]

		setText = var_5

		local var_56_6 = arg_56_0.rtRegularExchange

		var_5(var_6.Find(var_56_6, "count/Text"), "<color=#FFDF48>" .. var_56_3 .. "</color>/" .. var_56_5.exchange_request)

		setActive = var_5

		local var_56_7 = arg_56_0.rtRegularExchange

		var_5(var_6.Find(var_56_7, "show"), var_56_3 < var_56_5.exchange_request)

		setActive = var_5

		local var_56_8 = arg_56_0.rtRegularExchange

		var_5(var_6.Find(var_56_8, "get"), var_56_3 >= var_56_5.exchange_request)
	end

	return
end

function var_0_1.UpdateTestBtn(arg_57_0, arg_57_1)
	local var_57_0 = false

	PLATFORM_CODE = var_1_10003
	PLATFORM_JP = var_1_10004

	if var_1_10003 ~= var_1_10004 and arg_57_1:IsActivity() and not arg_57_1:IsEnd() then
		local var_57_1 = arg_57_1

		if arg_57_1.GetStageId(var_57_1) then
			var_57_0 = true
			onButton = var_57_1

			local var_57_2 = arg_57_0
			local var_57_3 = arg_57_0.testBtn

			local function var_57_4()
				pg = var_2_10000

				local var_58_0 = var_2_10000.MsgboxMgr.GetInstance()
				local var_58_1 = var_0.ShowMsgBox
				local var_58_2 = {}

				i18n = var_2_10003
				var_58_2.content = var_2_10003("juese_tiyan")

				function var_58_2.onYes()
					local var_59_0 = arg_57_0
					local var_59_1 = var_0.emit

					BuildShipMediator = var_3_10002

					var_59_1(var_59_0, var_3_10002.SIMULATION_BATTLE, var_1_10003)

					return
				end

				var_58_1(var_58_0, var_58_2)

				return
			end

			SFX_PANEL = var_1_10008

			var_57_1(var_57_2, var_57_3, var_57_4, var_1_10008)
		end
	end

	setActive = var_1_10003

	var_1_10003(arg_57_0.testBtn, var_57_0)

	return
end

function var_0_1.AddActivityTimer(arg_60_0, arg_60_1)
	arg_60_0:RemoveActivityTimer(arg_60_1)

	if arg_60_1:IsActivity() then
		local var_60_0 = arg_60_1
		local var_60_1 = arg_60_1.GetActivity(var_60_0)

		assert = var_60_0

		var_60_0(var_60_1)

		local var_60_2 = var_60_1.stopTime

		pg = var_4

		local var_60_3 = var_4.TimeMgr.GetInstance()
		local var_60_4 = var_60_2 - var_4.GetServerTime(var_60_3)
		local var_60_5 = arg_60_0.activityTimer
		local var_60_6 = arg_60_1.id

		Timer = var_1_10006
		var_60_5[var_60_6] = var_1_10006.New(function()
			local var_61_0 = arg_60_0

			var_0.RemoveActivityTimer(var_61_0, arg_60_1)

			local var_61_1 = arg_60_0
			local var_61_2 = var_0.emit

			BuildShipMediator = var_2

			var_61_2(var_61_1, var_2.ON_UPDATE_ACT)

			return
		end, var_60_4, 1)

		local var_60_7 = arg_60_0.activityTimer[arg_60_1.id]

		var_4.Start(var_60_7)
	end

	return
end

function var_0_1.RemoveActivityTimer(arg_62_0, arg_62_1)
	if arg_62_0.activityTimer[arg_62_1.id] then
		local var_62_0 = arg_62_0.activityTimer[arg_62_1.id]

		var_2.Stop(var_62_0)

		arg_62_0.activityTimer[arg_62_1.id] = nil
	end

	return
end

function var_0_1.RemoveAllTimer(arg_63_0)
	pairs = var_1_10001

	for iter_63_0, iter_63_1 in var_1_10001(arg_63_0.activityTimer) do
		iter_63_1:Stop()
	end

	arg_63_0.activityTimer = {}
	pairs = var_1

	for iter_63_2, iter_63_3 in var_1(arg_63_0.freeActTimer) do
		iter_63_3:Stop()
	end

	arg_63_0.freeActTimer = {}

	return
end

function var_0_1.ShowOrHide(arg_64_0, arg_64_1)
	if arg_64_1 then
		arg_64_0:Show()
	else
		arg_64_0:Hide()
	end

	return
end

function var_0_1.OnDestroy(arg_65_0)
	arg_65_0:RevertHxChannel()
	arg_65_0:RemoveAllTimer()

	arg_65_0.activityTimer = nil

	return
end

return var_0_1
