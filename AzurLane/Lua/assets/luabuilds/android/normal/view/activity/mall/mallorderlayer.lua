class = var_0_10000

local var_0_0 = "MallOrderLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.STATUS = {
	EMPTY = 5,
	COMPLETE = 4,
	WAIT = 1,
	PREPARE = 2,
	DOING = 3
}

function var_0_1.getUIName(arg_1_0)
	return "MallOrderUI"
end

function var_0_1.init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiBackBtn

	local function var_2_2()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.uiHomeBtn

	local function var_2_5()
		local var_4_0 = arg_2_0

		var_0.quickExitFunc(var_4_0)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10005)

	onButton = var_1_10001

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.uiHelpBtn

	local function var_2_8()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_5_2.type = var_2_10003
		pg = var_2_10003
		var_5_2.helps = var_2_10003.gametip.mall_help.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_6, var_2_7, var_2_8, var_1_10005)

	onButton = var_1_10001

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.uiStaffSureBtn

	local function var_2_11()
		setActive = var_2_10000

		var_2_10000(arg_2_0.uiOrderPanel, true)

		setActive = var_2_10000

		var_2_10000(arg_2_0.uiStaffPanel, false)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_9, var_2_10, var_2_11, var_1_10005)

	onButton = var_1_10001

	local var_2_12 = arg_2_0
	local var_2_13 = arg_2_0.uiOrderBtnsTF
	local var_2_14 = var_3.Find(var_2_13, "staff")

	local function var_2_15()
		setActive = var_2_10000

		var_2_10000(arg_2_0.uiOrderPanel, false)

		setActive = var_2_10000

		var_2_10000(arg_2_0.uiStaffPanel, true)

		local var_7_0 = arg_2_0.scrollCom

		var_0.SetTotalCount(var_7_0, #arg_2_0.staffList)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_2_12, var_2_14, var_2_15, var_5)

	onButton = var_1_10001

	local var_2_16 = arg_2_0
	local var_2_17 = arg_2_0.uiOrderBtnsTF
	local var_2_18 = var_3.Find(var_2_17, "start")

	local function var_2_19()
		local var_8_0 = arg_2_0
		local var_8_1 = var_0.emit

		MallOrderMediator = var_2_10002

		var_8_1(var_8_0, var_2_10002.START_ORDER, arg_2_0.activity.id, arg_2_0.showId, arg_2_0.selectedIds)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_2_16, var_2_18, var_2_19, var_5)

	onButton = var_1_10001

	local var_2_20 = arg_2_0
	local var_2_21 = arg_2_0.uiOrderBtnsTF
	local var_2_22 = var_3.Find(var_2_21, "complete")

	local function var_2_23()
		local var_9_0 = arg_2_0
		local var_9_1 = var_0.emit

		MallOrderMediator = var_2_10002

		var_9_1(var_9_0, var_2_10002.COMPLETE_ORDER, arg_2_0.activity.id, arg_2_0.showId)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_2_20, var_2_22, var_2_23, var_5)

	onButton = var_1_10001

	local var_2_24 = arg_2_0
	local var_2_25 = arg_2_0.uiDialogueTF

	local function var_2_26()
		setActive = var_2_10000

		var_2_10000(arg_2_0.uiDialogueTF, false)

		existCall = var_2_10000

		var_2_10000(arg_2_0.completeCb)

		arg_2_0.completeCb = nil

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_2_24, var_2_25, var_2_26, var_5)

	UIItemList = var_1_10001

	local var_2_27 = var_1_10001.New
	local var_2_28 = arg_2_0.uiOrderStaffTF
	local var_2_29 = arg_2_0.uiOrderStaffTF

	arg_2_0.orderSlotUIList = var_2_27(var_2_28, var_3.Find(var_2_29, "tpl"))

	local var_2_30 = arg_2_0.orderSlotUIList

	var_1.make(var_2_30, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_2_0

			var_3.UpdateOrderSlotTpl(var_11_0, arg_11_1, arg_11_2)
		end

		return
	end)

	UIItemList = var_1

	local var_2_31 = var_1.New
	local var_2_32 = arg_2_0.uiStaffContentTF
	local var_2_33 = arg_2_0.uiStaffContentTF

	arg_2_0.staffSlotUIList = var_2_31(var_2_32, var_3.Find(var_2_33, "tpl"))

	local var_2_34 = arg_2_0.staffSlotUIList

	var_1.make(var_2_34, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = arg_2_0

			var_3.UpdateStaffSlotTpl(var_12_0, arg_12_1, arg_12_2)
		end

		return
	end)

	local var_2_35 = arg_2_0.uiStaffScrollTF

	arg_2_0.scrollCom = var_1.GetComponent(var_2_35, "LScrollRect")

	function arg_2_0.scrollCom.onInitItem(arg_13_0)
		local var_13_0 = arg_2_0

		var_1.OnInitStaffItem(var_13_0, arg_13_0)

		return
	end

	local var_2_36 = arg_2_0.scrollCom

	function var_2_36.onUpdateItem(arg_14_0, arg_14_1)
		local var_14_0 = arg_2_0

		var_2.OnUpdateStaffItem(var_14_0, arg_14_0, arg_14_1)

		return
	end

	MallUpgradeBox = var_2_36
	arg_2_0.upgradeBox = var_2_36.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)
	setText = var_1

	local var_2_37 = arg_2_0.uiTitleText

	i18n = var_3

	var_1(var_2_37, var_3("mall_title"))

	setText = var_1

	local var_2_38 = arg_2_0.uiTitleEnText

	i18n = var_3

	var_1(var_2_38, var_3("mall_title_en"))

	setText = var_1

	local var_2_39 = arg_2_0.uiOrderBtnsTF
	local var_2_40 = var_2.Find(var_2_39, "staff/Text")

	i18n = var_2_39

	var_1(var_2_40, var_2_39("mall_order_btn_staff"))

	setText = var_1

	local var_2_41 = arg_2_0.uiOrderBtnsTF
	local var_2_42 = var_2.Find(var_2_41, "start/Text")

	i18n = var_2_41

	var_1(var_2_42, var_2_41("mall_order_btn_start"))

	setText = var_1

	local var_2_43 = arg_2_0.uiOrderBtnsTF
	local var_2_44 = var_2.Find(var_2_43, "doing/Text")

	i18n = var_2_43

	var_1(var_2_44, var_2_43("mall_order_btn_doing"))

	setText = var_1

	local var_2_45 = arg_2_0.uiOrderBtnsTF
	local var_2_46 = var_2.Find(var_2_45, "complete/Text")

	i18n = var_2_45

	var_1(var_2_46, var_2_45("mall_order_btn_complete"))

	return
end

function var_0_1.didEnter(arg_15_0)
	arg_15_0:UpdateData()
	arg_15_0:UpdateView()

	triggerButton = var_1

	var_1(arg_15_0.uiStaffSureBtn)

	return
end

function var_0_1.UpdateData(arg_16_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_16_0 = var_1_10001(var_1_10002)
	local var_16_1 = var_1.getActivityByType

	ActivityConst = var_1_10003
	arg_16_0.activity = var_16_1(var_16_0, var_1_10003.ACTIVITY_TYPE_MALL)

	local var_16_2 = arg_16_0.activity

	arg_16_0.level = var_1.GetLevelData(var_16_2).level

	local var_16_3 = arg_16_0.activity

	arg_16_0.orderData = var_1.GetOrderData(var_16_3)

	local var_16_5

	if not arg_16_0.selectedIds then
		Clone = var_16_5

		local var_16_4 = arg_16_0.orderData

		var_16_5 = var_16_5(var_2.GetStaffList(var_16_4))
	end

	arg_16_0.selectedIds = var_16_5

	local var_16_6 = arg_16_0.orderData

	arg_16_0.finishedIds = var_1.GetFinishedList(var_16_6)

	local var_16_7 = arg_16_0.activity

	arg_16_0.staffList = var_1.GetStaffList(var_16_7)
	arg_16_0.cards = {}

	return
end

function var_0_1.ClearSelectedIds(arg_17_0)
	arg_17_0.selectedIds = nil

	return
end

function var_0_1.UpdateView(arg_18_0)
	setText = var_1_10001

	local var_18_0 = arg_18_0.uiGoldText
	local var_18_1 = arg_18_0.activity

	var_1_10001(var_18_0, var_3.GetGold(var_18_1))

	arg_18_0.status = arg_18_0:GetStatus()
	arg_18_0.paintName, arg_18_0.showWord, arg_18_0.showName = arg_18_0:GetPaintingInfo()

	if arg_18_0.paintName ~= "" then
		checkABExist = var_1

		local var_18_2

		if not var_1("painting/" .. arg_18_0.paintName .. "_n") or not (arg_18_0.paintName .. "_n") then
			var_18_2 = arg_18_0.paintName
		end

		arg_18_0.paintingName = var_18_2
		setPaintingPrefab = var_18_2

		var_18_2(arg_18_0.uiPaintTF, arg_18_0.paintingName, "duihua")

		setText = var_18_2

		local var_18_3 = arg_18_0.uiOrderDescText

		pg = var_3

		var_18_2(var_18_3, var_3.activity_mall_custom_order[arg_18_0.showId].desc)

		setText = var_18_2

		local var_18_4 = arg_18_0.uiOrderNameText

		i18n = var_3

		var_18_2(var_18_4, var_3("mall_order_char_header") .. arg_18_0.showName)
	end

	local var_18_5 = arg_18_0.status ~= var_0_1.STATUS.WAIT and arg_18_0.status ~= var_0_1.STATUS.EMPTY

	setActive = var_2

	local var_18_6 = arg_18_0.uiOrderPanel

	var_2(var_3.Find(var_18_6, "content"), var_18_5)

	setActive = var_2

	local var_18_7 = arg_18_0.uiOrderPanel

	var_2(var_3.Find(var_18_7, "empty"), not var_18_5)

	if var_18_5 then
		arg_18_0:UpdateInfoPanel()
		arg_18_0:StopNextTimer()
	else
		arg_18_0:UpdateEmptyPanel()
	end

	arg_18_0:CheckShowDialogue()

	return
end

function var_0_1.GetStatus(arg_19_0)
	local var_19_0 = arg_19_0.orderData

	if var_1.IsFinishedAll(var_19_0) then
		return var_0_1.STATUS.EMPTY
	end

	arg_19_0.showId = 0

	local var_19_1

	if arg_19_0.orderData.id ~= 0 then
		arg_19_0.showId = arg_19_0.orderData.id
		pg = var_19_1
		var_19_0 = var_19_1.TimeMgr.GetInstance()
		var_19_1 = var_19_1.GetServerTime(var_19_0)

		local var_19_2 = arg_19_0.orderData

		if not (var_19_0.GetEndTime(var_19_2) <= var_19_1) or not var_0_1.STATUS.COMPLETE then
			var_19_1 = var_0_1.STATUS.DOING
		end

		do return var_19_1 end

		goto label_19_0
	end

	underscore = var_19_1

	local var_19_3 = var_19_1.detect

	pg = var_19_0
	arg_19_0.showId = var_19_3(var_19_0.activity_mall_custom_order.all, function(arg_20_0)
		table = var_2_10001

		return not var_2_10001.contains(arg_19_0.finishedIds, arg_20_0)
	end)
	pg = var_2

	local var_19_4 = var_2.activity_mall_custom_order[arg_19_0.showId]

	if arg_19_0.level >= var_19_4.unlock_lv then
		do
			local var_19_5 = arg_19_0.activity
			local var_19_6

			if not (var_3.getDayIndex(var_19_5) >= var_19_4.unlock_time) then
				var_19_6 = false
			else
				var_19_6 = true
			end

			local var_19_7

			if not var_19_6 or not var_0_1.STATUS.PREPARE then
				var_19_7 = var_0_1.STATUS.WAIT
			end

			return var_19_7
		end

		::label_19_0::

		return
	end
end

function var_0_1.GetPaintingInfo(arg_21_0)
	pg = var_1_10001

	local var_21_0 = var_1_10001.activity_mall_custom_order[arg_21_0.showId]

	pg = var_2

	local var_21_1 = var_2.ship_skin_template

	switch = var_1_10003

	return var_1_10003(arg_21_0.status, {
		[var_0_1.STATUS.WAIT] = function()
			return "", "", ""
		end,
		[var_0_1.STATUS.PREPARE] = function()
			local var_23_0 = var_21_1[var_21_0.char].painting
			local var_23_1 = var_21_0.word.intro_word[1]
			local var_23_2

			if not var_21_0.char_name then
				var_23_2 = ""
			end

			return var_23_0, var_23_1, var_23_2
		end,
		[var_0_1.STATUS.DOING] = function()
			local var_24_0 = var_21_1[var_21_0.char].painting
			local var_24_1 = var_21_0.word.ongoing_word[1]
			local var_24_2

			if not var_21_0.char_name then
				var_24_2 = ""
			end

			return var_24_0, var_24_1, var_24_2
		end,
		[var_0_1.STATUS.COMPLETE] = function()
			local var_25_0 = var_21_1[var_21_0.char].painting
			local var_25_1 = var_21_0.word.ongoing_word[1]
			local var_25_2

			if not var_21_0.char_name then
				var_25_2 = ""
			end

			return var_25_0, var_25_1, var_25_2
		end,
		[var_0_1.STATUS.EMPTY] = function()
			return "", "", ""
		end
	})
end

function var_0_1.CheckShowDialogue(arg_27_0)
	setActive = var_1_10001

	var_1_10001(arg_27_0.uiPaintDialogueTF, false)

	if arg_27_0.status ~= var_0_1.STATUS.WAIT and arg_27_0.status ~= var_0_1.STATUS.EMPTY then
		setText = var_1

		local var_27_0 = arg_27_0.uiPaintDialogueTF

		var_1(var_2.Find(var_27_0, "Text"), arg_27_0.showWord)

		setActive = var_1

		var_1(arg_27_0.uiPaintDialogueTF, true)
	end

	return
end

function var_0_1.ShowCompleteDialogue(arg_28_0, arg_28_1)
	arg_28_0.completeCb = arg_28_1
	setPaintingPrefab = var_1_10002

	local var_28_0 = arg_28_0.uiDialogueTF

	var_1_10002(var_3.Find(var_28_0, "paint"), arg_28_0.paintName, "duihua")

	pg = var_1_10002

	local var_28_1 = var_1_10002.activity_mall_custom_order[arg_28_0.showId].word.finished_word[1]

	setText = var_3

	local var_28_2 = arg_28_0.uiDialogueTF

	var_3(var_4.Find(var_28_2, "content/Text"), var_28_1)

	setActive = var_3

	var_3(arg_28_0.uiDialogueTF, true)

	return
end

function var_0_1.UpdateInfoPanel(arg_29_0)
	pg = var_1_10001
	arg_29_0.showConfig = var_1_10001.activity_mall_custom_order[arg_29_0.showId]

	arg_29_0:UpdateStaffAndTarget()
	arg_29_0:UpdataOrderInfo()
	arg_29_0:UpdateBtns()
	arg_29_0:SetTotalCount()

	return
end

function var_0_1.UpdateStaffAndTarget(arg_30_0)
	local var_30_0 = 0

	arg_30_0.targetAttrs, arg_30_0.curAttrs = {}, {}
	arg_30_0.targetNum = var_30_0
	ipairs = var_30_0

	for iter_30_0, iter_30_1 in var_30_0(arg_30_0.showConfig.order_need) do
		if iter_30_0 == 1 then
			arg_30_0.targetNum = iter_30_1
		else
			table = var_1_10006

			var_1_10006.insert(arg_30_0.targetAttrs, iter_30_1)

			table = var_1_10006

			var_1_10006.insert(arg_30_0.curAttrs, 0)
		end
	end

	ipairs = var_1

	for iter_30_2, iter_30_3 in var_1(arg_30_0.selectedIds) do
		local var_30_1 = arg_30_0.activity
		local var_30_2 = var_6.GetStaff(var_30_1, iter_30_3)

		ipairs = var_30_1

		for iter_30_4, iter_30_5 in var_30_1(var_30_2:GetAttrList()) do
			arg_30_0.curAttrs[iter_30_4] = arg_30_0.curAttrs[iter_30_4] + iter_30_5
		end
	end

	arg_30_0:UpdateStaffAttrsCond(arg_30_0.uiStaffAttrsCondTF)

	local var_30_3 = arg_30_0.orderSlotUIList

	var_1.align(var_30_3, arg_30_0.targetNum)

	local var_30_4 = arg_30_0.staffSlotUIList

	var_1.align(var_30_4, arg_30_0.targetNum)

	isActive = var_1

	if var_1(arg_30_0.uiStaffPanel) then
		local var_30_5 = arg_30_0.scrollCom

		var_1.SetTotalCount(var_30_5, #arg_30_0.staffList)
	end

	arg_30_0:CheckStartBtn()

	return
end

function var_0_1.UpdateStaffAttrsCond(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1
	local var_31_1 = arg_31_1.Find(var_31_0, "desc")

	setText = var_31_0

	local var_31_2 = var_31_1
	local var_31_3 = var_31_1.Find(var_31_2, "Text")

	i18n = var_31_2

	var_31_0(var_31_3, var_31_2("mall_order_need_attrs_header"))

	local var_31_4 = true

	arg_31_0.needShowAttrIds = {}
	ipairs = var_4

	for iter_31_0, iter_31_1 in var_4(arg_31_0.targetAttrs) do
		if not (iter_31_1 <= arg_31_0.curAttrs[iter_31_0]) then
			var_31_4 = false
		end

		setActive = var_1_10010

		var_1_10010(var_31_1:Find("list/" .. iter_31_0), iter_31_1 > 0)

		if 0 < iter_31_1 then
			table = var_1_10010

			var_1_10010.insert(arg_31_0.needShowAttrIds, iter_31_0)

			setColorStr = var_1_10010
			var_1_10010 = var_1_10010(arg_31_0.curAttrs[iter_31_0], var_9 and "#4c9922" or "#df6126") .. "/" .. iter_31_1
			setText = var_11

			var_11(var_31_1:Find("list/" .. iter_31_0 .. "/Text"), var_1_10010)
		end
	end

	setActive = var_4

	var_4(arg_31_1:Find("unfinished"), not var_31_4)

	setActive = var_4

	var_4(arg_31_1:Find("finished"), var_31_4)

	return
end

function var_0_1.UpdataOrderInfo(arg_32_0)
	underscore = var_1_10001

	local var_32_0 = var_1_10001.map(arg_32_0.showConfig.order_cost_show, function(arg_33_0)
		Drop = var_2_10001

		local var_33_0 = var_2_10001.Create(arg_33_0)
		local var_33_1 = {}

		i18n = var_2_10003
		var_33_1.text = var_2_10003("word_consume") .. var_33_0.count .. var_33_0:getName()
		var_33_1.isReach = var_33_0:getOwnedCount() >= var_33_0.count

		return var_33_1
	end)

	arg_32_0:UpdateStaffAttrsCond(arg_32_0.uiOrderAttrsCondTF)

	local var_32_1 = #arg_32_0.selectedIds
	local var_32_2 = arg_32_0.targetNum <= var_32_1

	setColorStr = var_3

	local var_32_3 = var_3(#arg_32_0.selectedIds, var_32_2 and "#4c9922" or "#df6126")

	i18n = var_4

	local var_32_4 = var_4("mall_order_need_staff_header") .. var_32_3 .. "/" .. arg_32_0.targetNum

	table = var_5

	var_5.insert(var_32_0, 1, {
		text = var_32_4,
		isReach = var_32_2
	})

	UIItemList = var_5

	local var_32_5 = var_5.StaticAlign
	local var_32_6 = arg_32_0.uiOrderCostTF
	local var_32_7 = arg_32_0.uiOrderCostTF

	var_32_5(var_32_6, var_7.Find(var_32_7, "tpl"), #var_32_0, function(arg_34_0, arg_34_1, arg_34_2)
		UIItemList = var_2_10003

		if arg_34_0 == var_2_10003.EventUpdate then
			setText = var_3

			var_3(arg_34_2:Find("Text"), var_32_0[arg_34_1 + 1].text)

			setActive = var_3

			var_3(arg_34_2:Find("unfinished"), not var_32_0[arg_34_1 + 1].isReach)

			setActive = var_3

			var_3(arg_34_2:Find("finished"), var_32_0[arg_34_1 + 1].isReach)
		end

		return
	end)

	underscore = var_32_5

	local var_32_8 = var_32_5.map(arg_32_0.showConfig.order_reward_show, function(arg_35_0)
		Drop = var_2_10001

		local var_35_0 = var_2_10001.Create(arg_35_0)

		return var_1.getName(var_35_0) .. "*" .. var_1.count
	end)

	UIItemList = var_6

	local var_32_9 = var_6.StaticAlign
	local var_32_10 = arg_32_0.uiOrderAwardTF
	local var_32_11 = arg_32_0.uiOrderAwardTF

	var_32_9(var_32_10, var_8.Find(var_32_11, "tpl"), #var_32_8, function(arg_36_0, arg_36_1, arg_36_2)
		UIItemList = var_2_10003

		if arg_36_0 == var_2_10003.EventUpdate then
			setText = var_3

			var_3(arg_36_2:Find("Text"), var_32_8[arg_36_1 + 1])
		end

		return
	end)

	return
end

function var_0_1.UpdateBtns(arg_37_0)
	arg_37_0:CheckStartBtn()

	setActive = var_1

	local var_37_0 = arg_37_0.uiOrderBtnsTF

	var_1(var_2.Find(var_37_0, "doing"), arg_37_0.status == var_0_1.STATUS.DOING)

	setActive = var_1

	local var_37_1 = arg_37_0.uiOrderBtnsTF

	var_1(var_2.Find(var_37_1, "complete"), arg_37_0.status == var_0_1.STATUS.COMPLETE)

	setActive = var_1

	local var_37_2 = arg_37_0.uiOrderBtnsTF

	var_1(var_2.Find(var_37_2, "time"), arg_37_0.status == var_0_1.STATUS.DOING or arg_37_0.status == var_0_1.STATUS.PREPARE)

	if arg_37_0.status == var_0_1.STATUS.PREPARE then
		setText = var_1

		local var_37_3 = arg_37_0.uiOrderBtnsTF
		local var_37_4 = var_2.Find(var_37_3, "time/Text")

		pg = var_37_3

		local var_37_5 = var_37_3.TimeMgr.GetInstance()

		var_1(var_37_4, var_3.DescCDTime(var_37_5, arg_37_0.showConfig.cost_time))
	end

	if arg_37_0.status == var_0_1.STATUS.DOING then
		arg_37_0:StartTimer()
	else
		arg_37_0:StopTimer()
	end

	return
end

function var_0_1.CheckStartBtn(arg_38_0)
	if arg_38_0.status == var_0_1.STATUS.PREPARE then
		setActive = var_1

		local var_38_0 = arg_38_0.uiOrderBtnsTF

		var_1(var_2.Find(var_38_0, "start"), arg_38_0:CanStart())
	else
		setActive = var_1

		local var_38_1 = arg_38_0.uiOrderBtnsTF

		var_1(var_2.Find(var_38_1, "start"), false)
	end

	return
end

function var_0_1.CanStart(arg_39_0)
	if #arg_39_0.selectedIds ~= arg_39_0.targetNum then
		return false
	end

	local var_39_0 = arg_39_0.activity

	if var_1.GetGold(var_39_0) < arg_39_0.showConfig.order_cost_gold then
		return false
	end

	ipairs = var_1

	for iter_39_0, iter_39_1 in var_1(arg_39_0.targetAttrs) do
		if iter_39_1 > arg_39_0.curAttrs[iter_39_0] then
			return false
		end
	end

	ipairs = var_1
	MallOrder = var_2

	for iter_39_2, iter_39_3 in var_1(var_2.GetCost(arg_39_0.showId)) do
		if iter_39_3:getOwnedCount() < iter_39_3.count then
			return false
		end
	end

	return true
end

function var_0_1.UpdateEmptyPanel(arg_40_0)
	arg_40_0:StopNextTimer()

	local var_40_0 = arg_40_0.uiOrderPanel
	local var_40_1 = var_1.Find(var_40_0, "empty")
	local var_40_2 = var_1.Find(var_40_1, "list/tip")

	setActive = var_40_1

	var_40_1(var_40_2, arg_40_0.status == var_0_1.STATUS.EMPTY)

	local var_40_3 = var_1:Find("list/time")
	local var_40_4 = var_1:Find("list/level")

	if arg_40_0.status == var_0_1.STATUS.EMPTY then
		setText = var_5

		local var_40_5 = var_40_2

		i18n = var_1_10007

		var_5(var_40_5, var_1_10007("mall_order_finished_all_tip"))

		setActive = var_5

		var_5(var_40_3, false)

		setActive = var_5

		var_5(var_40_4, false)
	else
		pg = var_5

		local var_40_6 = var_5.activity_mall_custom_order[arg_40_0.showId]

		if arg_40_0.level < var_40_6.unlock_lv then
			setText = var_6

			local var_40_7 = var_40_4

			i18n = var_1_10008

			var_6(var_40_7, var_1_10008("mall_order_unlock_lv_tip", var_40_6.unlock_lv))

			setActive = var_6

			var_6(var_40_4, true)
		else
			setActive = var_6

			var_6(var_40_4, false)
		end

		local var_40_8 = var_40_6.unlock_time
		local var_40_9 = arg_40_0.activity
		local var_40_10 = var_40_8 - var_7.getDayIndex(var_40_9)

		if 0 < var_40_10 then
			setText = var_7

			local var_40_11 = var_40_3
			local var_40_12 = var_40_3.Find(var_40_11, "Text")

			i18n = var_40_11

			var_7(var_40_12, var_40_11("mall_order_wait_tip"))
			arg_40_0:StartNextTimer(var_40_10)

			setActive = var_7

			var_7(var_40_3, true)
		else
			setActive = var_7

			var_7(var_40_3, false)
		end
	end

	return
end

function var_0_1.OnInitStaffItem(arg_41_0, arg_41_1)
	MallStaffCard = var_1_10002

	local var_41_0 = var_1_10002.New(arg_41_1)

	onButton = var_3

	local var_41_1 = arg_41_0
	local var_41_2 = var_41_0._go

	local function var_41_3()
		if arg_41_0.status ~= var_0_1.STATUS.PREPARE then
			return
		end

		local var_42_1

		if #arg_41_0.selectedIds == arg_41_0.targetNum then
			pg = var_42_1

			local var_42_0 = var_42_1.TipsMgr.GetInstance()

			var_42_1 = var_42_1.ShowTips
			i18n = var_2_10002

			var_42_1(var_42_0, var_2_10002("mall_staff_position_full_tip"))

			return
		end

		table = var_42_1

		if var_42_1.contains(arg_41_0.selectedIds, var_41_0.staff.id) then
			return
		end

		local var_42_2 = var_41_0.staff
		local var_42_3, var_42_4 = var_0.GetStatusInfos(var_42_2)

		MallStaff = var_2

		if var_42_3 == var_2.STATUS.ORDER then
			return
		end

		seriesAsync = var_2

		var_2({
			function(arg_43_0)
				local var_43_0 = var_42_3

				MallStaff = var_3_10002

				if var_43_0 == var_3_10002.STATUS.FLOOR then
					pg = var_43_0

					local var_43_1 = var_43_0.MsgboxMgr.GetInstance()
					local var_43_2 = var_1.ShowMsgBox
					local var_43_3 = {}

					i18n = var_3_10004
					var_43_3.content = var_3_10004("mall_remove_floor_sure")

					function var_43_3.onYes()
						local var_44_0 = arg_41_0.activity

						var_0.SetFloorStaff(var_44_0, var_42_4.floorId, var_42_4.floorIdx, 0)

						MallStaffLayer = var_0

						var_0.CheckUpdateFloorStaffs(arg_41_0.activity, arg_43_0)

						return
					end

					var_43_2(var_43_1, var_43_3)
				else
					arg_43_0()
				end

				return
			end
		}, function()
			table = var_3_10000

			var_3_10000.insert(arg_41_0.selectedIds, var_41_0.staff.id)

			local var_45_0 = arg_41_0

			var_0.UpdateInfoPanel(var_45_0)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_41_1, var_41_2, var_41_3, var_1_10007)

	arg_41_0.cards[arg_41_1] = var_41_0

	return
end

function var_0_1.OnUpdateStaffItem(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0

	if not arg_46_0.cards[arg_46_2] then
		arg_46_0:OnInitStaffItem(arg_46_2)

		var_46_0 = arg_46_0.cards[arg_46_2]
	end

	local var_46_1 = arg_46_0.staffList[arg_46_1 + 1]

	var_46_0:Update(var_46_1, arg_46_0.selectedIds, false, arg_46_0.needShowAttrIds)

	return
end

function var_0_1.UpdateOrderSlotTpl(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = arg_47_0.selectedIds[arg_47_1 + 1]

	setActive = var_47_2

	var_47_2(arg_47_2:Find("icon"), var_47_0)

	local var_47_2

	if var_47_0 then
		local var_47_1 = arg_47_0.activity

		var_47_2 = var_47_2.GetStaff(var_47_1, var_47_0)
		MallStaffCard = var_47_1

		var_47_1.StaticUpdateIcon(arg_47_2:Find("icon"), var_47_2.tid)
	end

	onButton = var_47_2

	local var_47_3 = arg_47_0
	local var_47_4 = arg_47_2

	local function var_47_5()
		if arg_47_0.status ~= var_0_1.STATUS.PREPARE then
			return
		end

		setActive = var_0

		var_0(arg_47_0.uiOrderPanel, false)

		setActive = var_0

		var_0(arg_47_0.uiStaffPanel, true)

		local var_48_0 = arg_47_0

		var_0.SetTotalCount(var_48_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_47_2(var_47_3, var_47_4, var_47_5, var_1_10008)

	return
end

function var_0_1.SetTotalCount(arg_49_0)
	table = var_1_10001

	local var_49_0 = var_1_10001.sort
	local var_49_1 = arg_49_0.staffList

	CompareFuncs = var_1_10003

	var_49_0(var_49_1, var_1_10003({
		function(arg_50_0)
			local var_50_0, var_50_1 = arg_50_0:GetStatusInfos()

			MallStaff = var_2_10003

			return var_50_0 == var_2_10003.STATUS.FLOOR and 1 or 0
		end,
		function(arg_51_0)
			return -arg_51_0.id
		end
	}))

	isActive = var_49_0

	if var_49_0(arg_49_0.uiStaffPanel) then
		local var_49_2 = arg_49_0.scrollCom

		var_1.SetTotalCount(var_49_2, #arg_49_0.staffList)
	end

	return
end

function var_0_1.UpdateStaffSlotTpl(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = arg_52_0.selectedIds[arg_52_1 + 1]

	setActive = var_52_2

	var_52_2(arg_52_2:Find("icon"), var_52_0)

	local var_52_2

	if var_52_0 then
		local var_52_1 = arg_52_0.activity

		var_52_2 = var_52_2.GetStaff(var_52_1, var_52_0)
		MallStaffCard = var_52_1

		var_52_1.StaticUpdateIcon(arg_52_2:Find("icon"), var_52_2.tid)
	end

	onButton = var_52_2

	local var_52_3 = arg_52_0
	local var_52_4 = arg_52_2:Find("icon")

	local function var_52_5()
		table = var_2_10000

		var_2_10000.removebyvalue(arg_52_0.selectedIds, var_52_0)

		local var_53_0 = arg_52_0

		var_0.UpdateInfoPanel(var_53_0)

		return
	end

	SFX_PANEL = var_8

	var_52_2(var_52_3, var_52_4, var_52_5, var_8)

	return
end

function var_0_1.ShowUpgradeBox(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = arg_54_0.upgradeBox

	var_4.ExecuteAction(var_54_0, "Show", arg_54_1, arg_54_2, arg_54_3)

	return
end

function var_0_1.StartTimer(arg_55_0)
	arg_55_0:StopTimer()

	local var_55_0 = arg_55_0.orderData

	arg_55_0.endTime = var_1.GetEndTime(var_55_0)
	Timer = var_1
	arg_55_0.timer = var_1.New(function()
		local var_56_0 = arg_55_0.endTime

		pg = var_2_10001

		local var_56_1 = var_2_10001.TimeMgr.GetInstance()
		local var_56_2 = var_56_0 - var_1.GetServerTime(var_56_1)

		setText = var_1

		local var_56_3 = arg_55_0.uiOrderBtnsTF
		local var_56_4 = var_2.Find(var_56_3, "time/Text")

		pg = var_56_3

		local var_56_5 = var_56_3.TimeMgr.GetInstance()

		var_1(var_56_4, var_3.DescCDTime(var_56_5, var_56_2))

		if var_56_2 <= 0 then
			local var_56_6 = arg_55_0

			var_1.UpdateData(var_56_6)

			local var_56_7 = arg_55_0

			var_1.UpdateView(var_56_7)
		end

		return
	end, 1, -1)

	local var_55_1 = arg_55_0.timer

	var_1.Start(var_55_1)
	arg_55_0.timer.func()

	return
end

function var_0_1.StopTimer(arg_57_0)
	if arg_57_0.timer then
		local var_57_0 = arg_57_0.timer

		var_1.Stop(var_57_0)

		arg_57_0.timer = nil
	end

	return
end

function var_0_1.StartNextTimer(arg_58_0, arg_58_1)
	arg_58_0:StopNextTimer()

	pg = var_2

	local var_58_0 = var_2.TimeMgr.GetInstance()

	arg_58_0.nextOrderTime = var_2.GetTimeToNextTime(var_58_0) + (arg_58_1 - 1) * 0
	Timer = var_2
	arg_58_0.nextTimer = var_2.New(function()
		local var_59_0 = arg_58_0.nextOrderTime

		pg = var_2_10001

		local var_59_1 = var_2_10001.TimeMgr.GetInstance()
		local var_59_2 = var_59_0 - var_1.GetServerTime(var_59_1)

		setText = var_1

		local var_59_3 = arg_58_0.uiOrderPanel
		local var_59_4 = var_2.Find(var_59_3, "empty/list/time/value")

		pg = var_59_3

		local var_59_5 = var_59_3.TimeMgr.GetInstance()

		var_1(var_59_4, var_3.DescCDTime(var_59_5, var_59_2))

		if var_59_2 <= 0 then
			local var_59_6 = arg_58_0

			var_1.UpdateData(var_59_6)

			local var_59_7 = arg_58_0

			var_1.UpdateView(var_59_7)
		end

		return
	end, 1, -1)

	local var_58_1 = arg_58_0.nextTimer

	var_2.Start(var_58_1)
	arg_58_0.nextTimer.func()

	return
end

function var_0_1.StopNextTimer(arg_60_0)
	if arg_60_0.nextTimer then
		local var_60_0 = arg_60_0.nextTimer

		var_1.Stop(var_60_0)

		arg_60_0.nextTimer = nil
	end

	return
end

function var_0_1.onBackPressed(arg_61_0)
	if arg_61_0.upgradeBox then
		local var_61_0 = arg_61_0.upgradeBox

		if var_1.isShowing(var_61_0) then
			local var_61_1 = arg_61_0.upgradeBox

			var_1.ExecuteAction(var_61_1, "Hide")

			return
		end
	end

	var_0_1.super.onBackPressed(arg_61_0)

	return
end

function var_0_1.willExit(arg_62_0)
	existCall = var_1_10001

	var_1_10001(arg_62_0.contextData.onExit)

	arg_62_0.contextData.onExit = nil

	if arg_62_0.upgradeBox then
		local var_62_0 = arg_62_0.upgradeBox

		var_1.Destroy(var_62_0)

		arg_62_0.upgradeBox = nil
	end

	ClearLScrollrect = var_1

	var_1(arg_62_0.scrollCom)

	pairs = var_1

	for iter_62_0, iter_62_1 in var_1(arg_62_0.cards) do
		iter_62_1:Dispose()
	end

	arg_62_0.cards = {}

	arg_62_0:StopTimer()
	arg_62_0:StopNextTimer()

	return
end

return var_0_1
