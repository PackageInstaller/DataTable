local var_0_0 = class("MallOrderLayer", import("view.base.BaseUI"))

var_0_0.STATUS = {
	EMPTY = 5,
	COMPLETE = 4,
	WAIT = 1,
	PREPARE = 2,
	DOING = 3
}

function var_0_0.getUIName(arg_1_0)
	return "MallOrderUI"
end

function var_0_0.init(arg_2_0)
	onButton(arg_2_0, arg_2_0.uiBackBtn, function()
		arg_2_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiHomeBtn, function()
		arg_2_0:quickExitFunc()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiHelpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.mall_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiStaffSureBtn, function()
		setActive(arg_2_0.uiOrderPanel, true)
		setActive(arg_2_0.uiStaffPanel, false)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiOrderBtnsTF:Find("staff"), function()
		setActive(arg_2_0.uiOrderPanel, false)
		setActive(arg_2_0.uiStaffPanel, true)
		arg_2_0.scrollCom:SetTotalCount(#arg_2_0.staffList)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiOrderBtnsTF:Find("start"), function()
		arg_2_0:emit(MallOrderMediator.START_ORDER, arg_2_0.activity.id, arg_2_0.showId, arg_2_0.selectedIds)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiOrderBtnsTF:Find("complete"), function()
		arg_2_0:emit(MallOrderMediator.COMPLETE_ORDER, arg_2_0.activity.id, arg_2_0.showId)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiDialogueTF, function()
		setActive(arg_2_0.uiDialogueTF, false)
		existCall(arg_2_0.completeCb)

		arg_2_0.completeCb = nil

		return
	end, SFX_PANEL)

	arg_2_0.orderSlotUIList = UIItemList.New(arg_2_0.uiOrderStaffTF, arg_2_0.uiOrderStaffTF:Find("tpl"))

	arg_2_0.orderSlotUIList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			arg_2_0:UpdateOrderSlotTpl(arg_11_1, arg_11_2)
		end

		return
	end)

	arg_2_0.staffSlotUIList = UIItemList.New(arg_2_0.uiStaffContentTF, arg_2_0.uiStaffContentTF:Find("tpl"))

	arg_2_0.staffSlotUIList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			arg_2_0:UpdateStaffSlotTpl(arg_12_1, arg_12_2)
		end

		return
	end)

	arg_2_0.scrollCom = arg_2_0.uiStaffScrollTF:GetComponent("LScrollRect")

	function arg_2_0.scrollCom.onInitItem(arg_13_0)
		arg_2_0:OnInitStaffItem(arg_13_0)

		return
	end

	function arg_2_0.scrollCom.onUpdateItem(arg_14_0, arg_14_1)
		arg_2_0:OnUpdateStaffItem(arg_14_0, arg_14_1)

		return
	end

	arg_2_0.upgradeBox = MallUpgradeBox.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)

	setText(arg_2_0.uiTitleText, i18n("mall_title"))
	setText(arg_2_0.uiTitleEnText, i18n("mall_title_en"))
	setText(arg_2_0.uiOrderBtnsTF:Find("staff/Text"), i18n("mall_order_btn_staff"))
	setText(arg_2_0.uiOrderBtnsTF:Find("start/Text"), i18n("mall_order_btn_start"))
	setText(arg_2_0.uiOrderBtnsTF:Find("doing/Text"), i18n("mall_order_btn_doing"))
	setText(arg_2_0.uiOrderBtnsTF:Find("complete/Text"), i18n("mall_order_btn_complete"))

	return
end

function var_0_0.didEnter(arg_15_0)
	arg_15_0:UpdateData()
	arg_15_0:UpdateView()
	triggerButton(arg_15_0.uiStaffSureBtn)

	return
end

function var_0_0.UpdateData(arg_16_0)
	arg_16_0.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)
	arg_16_0.level = arg_16_0.activity:GetLevelData().level
	arg_16_0.orderData = arg_16_0.activity:GetOrderData()
	arg_16_0.selectedIds = arg_16_0.selectedIds or Clone(arg_16_0.orderData:GetStaffList())
	arg_16_0.finishedIds = arg_16_0.orderData:GetFinishedList()
	arg_16_0.staffList = arg_16_0.activity:GetStaffList()
	arg_16_0.cards = {}

	return
end

function var_0_0.ClearSelectedIds(arg_17_0)
	arg_17_0.selectedIds = nil

	return
end

function var_0_0.UpdateView(arg_18_0)
	setText(arg_18_0.uiGoldText, arg_18_0.activity:GetGold())

	arg_18_0.status = arg_18_0:GetStatus()
	arg_18_0.paintName, arg_18_0.showWord, arg_18_0.showName = arg_18_0:GetPaintingInfo()

	if arg_18_0.paintName ~= "" then
		if checkABExist("painting/" .. arg_18_0.paintName .. "_n") then
			arg_18_0.paintingName = arg_18_0.paintName .. "_n" or arg_18_0.paintName

			setPaintingPrefab(arg_18_0.uiPaintTF, arg_18_0.paintingName, "duihua")
			setText(arg_18_0.uiOrderDescText, pg.activity_mall_custom_order[arg_18_0.showId].desc)
			setText(arg_18_0.uiOrderNameText, i18n("mall_order_char_header") .. arg_18_0.showName)

			local var_18_0 = arg_18_0.status ~= var_0_0.STATUS.WAIT and arg_18_0.status ~= var_0_0.STATUS.EMPTY

			setActive(arg_18_0.uiOrderPanel:Find("content"), arg_18_0.status ~= var_0_0.STATUS.WAIT and arg_18_0.status ~= var_0_0.STATUS.EMPTY)
			setActive(arg_18_0.uiOrderPanel:Find("empty"), not var_18_0)

			if var_18_0 then
				arg_18_0:UpdateInfoPanel()
				arg_18_0:StopNextTimer()
			else
				arg_18_0:UpdateEmptyPanel()
			end

			arg_18_0:CheckShowDialogue()

			return
		end
	end
end

function var_0_0.GetStatus(arg_19_0)
	if arg_19_0.orderData:IsFinishedAll() then
		return var_0_0.STATUS.EMPTY
	end

	arg_19_0.showId = 0

	if arg_19_0.orderData.id ~= 0 then
		arg_19_0.showId = arg_19_0.orderData.id

		if pg.TimeMgr.GetInstance():GetServerTime() >= arg_19_0.orderData:GetEndTime() then
			do return var_0_0.STATUS.COMPLETE or var_0_0.STATUS.DOING end

			local var_19_1 = pg.activity_mall_custom_order[arg_19_0.showId]

			goto label_19_0

			arg_19_0.showId = underscore.detect(pg.activity_mall_custom_order.all, function(arg_20_0)
				return not table.contains(arg_19_0.finishedIds, arg_20_0)
			end)

			::label_19_0::

			if arg_19_0.level >= pg.activity_mall_custom_order[arg_19_0.showId].unlock_lv and arg_19_0.activity:getDayIndex() >= var_19_1.unlock_time then
				do
					return var_0_0.STATUS.PREPARE or var_0_0.STATUS.WAIT
				end

				return
			end
		end
	end
end

function var_0_0.GetPaintingInfo(arg_21_0)
	local var_21_0 = pg.activity_mall_custom_order[arg_21_0.showId]
	local var_21_1 = pg.ship_skin_template

	return switch(arg_21_0.status, {
		[var_0_0.STATUS.WAIT] = function()
			return "", "", ""
		end,
		[var_0_0.STATUS.PREPARE] = function()
			local var_23_0 = var_21_0.char_name or ""

			return var_21_1[var_21_0.char].painting, var_21_0.word.intro_word[1], var_23_0
		end,
		[var_0_0.STATUS.DOING] = function()
			local var_24_0 = var_21_0.char_name or ""

			return var_21_1[var_21_0.char].painting, var_21_0.word.ongoing_word[1], var_24_0
		end,
		[var_0_0.STATUS.COMPLETE] = function()
			local var_25_0 = var_21_0.char_name or ""

			return var_21_1[var_21_0.char].painting, var_21_0.word.ongoing_word[1], var_25_0
		end,
		[var_0_0.STATUS.EMPTY] = function()
			return "", "", ""
		end
	})
end

function var_0_0.CheckShowDialogue(arg_27_0)
	setActive(arg_27_0.uiPaintDialogueTF, false)

	if arg_27_0.status ~= var_0_0.STATUS.WAIT and arg_27_0.status ~= var_0_0.STATUS.EMPTY then
		setText(arg_27_0.uiPaintDialogueTF:Find("Text"), arg_27_0.showWord)
		setActive(arg_27_0.uiPaintDialogueTF, true)
	end

	return
end

function var_0_0.ShowCompleteDialogue(arg_28_0, arg_28_1)
	arg_28_0.completeCb = arg_28_1

	setPaintingPrefab(arg_28_0.uiDialogueTF:Find("paint"), arg_28_0.paintName, "duihua")
	setText(arg_28_0.uiDialogueTF:Find("content/Text"), pg.activity_mall_custom_order[arg_28_0.showId].word.finished_word[1])
	setActive(arg_28_0.uiDialogueTF, true)

	return
end

function var_0_0.UpdateInfoPanel(arg_29_0)
	arg_29_0.showConfig = pg.activity_mall_custom_order[arg_29_0.showId]

	arg_29_0:UpdateStaffAndTarget()
	arg_29_0:UpdataOrderInfo()
	arg_29_0:UpdateBtns()
	arg_29_0:SetTotalCount()

	return
end

function var_0_0.UpdateStaffAndTarget(arg_30_0)
	arg_30_0.targetNum, arg_30_0.targetAttrs, arg_30_0.curAttrs = 0, {}, {}

	for iter_30_0, iter_30_1 in ipairs(arg_30_0.showConfig.order_need) do
		if iter_30_0 == 1 then
			arg_30_0.targetNum = iter_30_1
		else
			table.insert(arg_30_0.targetAttrs, iter_30_1)
			table.insert(arg_30_0.curAttrs, 0)
		end
	end

	for iter_30_2, iter_30_3 in ipairs(arg_30_0.selectedIds) do
		local var_30_0 = arg_30_0.activity:GetStaff(iter_30_3)

		for iter_30_4, iter_30_5 in ipairs(var_30_0:GetAttrList()) do
			arg_30_0.curAttrs[iter_30_4] = arg_30_0.curAttrs[iter_30_4] + iter_30_5
		end
	end

	arg_30_0:UpdateStaffAttrsCond(arg_30_0.uiStaffAttrsCondTF)
	arg_30_0.orderSlotUIList:align(arg_30_0.targetNum)
	arg_30_0.staffSlotUIList:align(arg_30_0.targetNum)

	if isActive(arg_30_0.uiStaffPanel) then
		arg_30_0.scrollCom:SetTotalCount(#arg_30_0.staffList)
	end

	arg_30_0:CheckStartBtn()

	return
end

function var_0_0.UpdateStaffAttrsCond(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1:Find("desc")

	setText(var_31_0:Find("Text"), i18n("mall_order_need_attrs_header"))

	local var_31_1 = true

	arg_31_0.needShowAttrIds = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.targetAttrs) do
		local var_31_2 = iter_31_1 <= arg_31_0.curAttrs[iter_31_0]

		if iter_31_1 > arg_31_0.curAttrs[iter_31_0] then
			var_31_1 = false
		end

		setActive(var_31_0:Find("list/" .. iter_31_0), iter_31_1 > 0)

		if iter_31_1 > 0 then
			table.insert(arg_31_0.needShowAttrIds, iter_31_0)
			setText(var_31_0:Find("list/" .. iter_31_0 .. "/Text"), setColorStr(arg_31_0.curAttrs[iter_31_0], var_31_2 and "#4c9922" or "#df6126") .. "/" .. iter_31_1)
		end
	end

	setActive(arg_31_1:Find("unfinished"), not var_31_1)
	setActive(arg_31_1:Find("finished"), var_31_1)

	return
end

function var_0_0.UpdataOrderInfo(arg_32_0)
	local var_32_0 = underscore.map(arg_32_0.showConfig.order_cost_show, function(arg_33_0)
		local var_33_0 = Drop.Create(arg_33_0)

		return {
			text = i18n("word_consume") .. var_33_0.count .. var_33_0:getName(),
			isReach = var_33_0:getOwnedCount() >= var_33_0.count
		}
	end)

	arg_32_0:UpdateStaffAttrsCond(arg_32_0.uiOrderAttrsCondTF)
	table.insert(var_32_0, 1, {
		text = i18n("mall_order_need_staff_header") .. setColorStr(#arg_32_0.selectedIds, #arg_32_0.selectedIds >= arg_32_0.targetNum and "#4c9922" or "#df6126") .. "/" .. arg_32_0.targetNum,
		isReach = #arg_32_0.selectedIds >= arg_32_0.targetNum
	})
	UIItemList.StaticAlign(arg_32_0.uiOrderCostTF, arg_32_0.uiOrderCostTF:Find("tpl"), #var_32_0, function(arg_34_0, arg_34_1, arg_34_2)
		if arg_34_0 == UIItemList.EventUpdate then
			setText(arg_34_2:Find("Text"), var_32_0[arg_34_1 + 1].text)
			setActive(arg_34_2:Find("unfinished"), not var_32_0[arg_34_1 + 1].isReach)
			setActive(arg_34_2:Find("finished"), var_32_0[arg_34_1 + 1].isReach)
		end

		return
	end)
	UIItemList.StaticAlign(arg_32_0.uiOrderAwardTF, arg_32_0.uiOrderAwardTF:Find("tpl"), #underscore.map(arg_32_0.showConfig.order_reward_show, function(arg_35_0)
		local var_35_0 = Drop.Create(arg_35_0)

		return var_35_0:getName() .. "*" .. var_35_0.count
	end), function(arg_36_0, arg_36_1, arg_36_2)
		if arg_36_0 == UIItemList.EventUpdate then
			setText(arg_36_2:Find("Text"), var_0[arg_36_1 + 1])
		end

		return
	end)

	return
end

function var_0_0.UpdateBtns(arg_37_0)
	arg_37_0:CheckStartBtn()
	setActive(arg_37_0.uiOrderBtnsTF:Find("doing"), arg_37_0.status == var_0_0.STATUS.DOING)
	setActive(arg_37_0.uiOrderBtnsTF:Find("complete"), arg_37_0.status == var_0_0.STATUS.COMPLETE)
	setActive(arg_37_0.uiOrderBtnsTF:Find("time"), arg_37_0.status == var_0_0.STATUS.DOING or arg_37_0.status == var_0_0.STATUS.PREPARE)

	if arg_37_0.status == var_0_0.STATUS.PREPARE then
		setText(arg_37_0.uiOrderBtnsTF:Find("time/Text"), pg.TimeMgr.GetInstance():DescCDTime(arg_37_0.showConfig.cost_time))
	end

	if arg_37_0.status == var_0_0.STATUS.DOING then
		arg_37_0:StartTimer()
	else
		arg_37_0:StopTimer()
	end

	return
end

function var_0_0.CheckStartBtn(arg_38_0)
	if arg_38_0.status == var_0_0.STATUS.PREPARE then
		setActive(arg_38_0.uiOrderBtnsTF:Find("start"), arg_38_0:CanStart())
	else
		setActive(arg_38_0.uiOrderBtnsTF:Find("start"), false)
	end

	return
end

function var_0_0.CanStart(arg_39_0)
	if #arg_39_0.selectedIds ~= arg_39_0.targetNum then
		return false
	end

	if arg_39_0.activity:GetGold() < arg_39_0.showConfig.order_cost_gold then
		return false
	end

	for iter_39_0, iter_39_1 in ipairs(arg_39_0.targetAttrs) do
		if iter_39_1 > arg_39_0.curAttrs[iter_39_0] then
			return false
		end
	end

	for iter_39_2, iter_39_3 in ipairs(MallOrder.GetCost(arg_39_0.showId)) do
		if iter_39_3:getOwnedCount() < iter_39_3.count then
			return false
		end
	end

	return true
end

function var_0_0.UpdateEmptyPanel(arg_40_0)
	arg_40_0:StopNextTimer()

	local var_40_0 = arg_40_0.uiOrderPanel:Find("empty")
	local var_40_1 = var_40_0:Find("list/tip")

	setActive(var_40_1, arg_40_0.status == var_0_0.STATUS.EMPTY)

	local var_40_2 = var_40_0:Find("list/time")
	local var_40_3 = var_40_0:Find("list/level")

	if arg_40_0.status == var_0_0.STATUS.EMPTY then
		setText(var_40_1, i18n("mall_order_finished_all_tip"))
		setActive(var_40_2, false)
		setActive(var_40_3, false)
	else
		local var_40_4 = pg.activity_mall_custom_order[arg_40_0.showId]

		if arg_40_0.level < pg.activity_mall_custom_order[arg_40_0.showId].unlock_lv then
			setText(var_40_3, i18n("mall_order_unlock_lv_tip", var_40_4.unlock_lv))
			setActive(var_40_3, true)
		else
			setActive(var_40_3, false)
		end

		local var_40_5 = var_40_4.unlock_time - arg_40_0.activity:getDayIndex()

		if var_40_5 > 0 then
			setText(var_40_2:Find("Text"), i18n("mall_order_wait_tip"))
			arg_40_0:StartNextTimer(var_40_5)
			setActive(var_40_2, true)
		else
			setActive(var_40_2, false)
		end
	end

	return
end

function var_0_0.OnInitStaffItem(arg_41_0, arg_41_1)
	local var_41_0 = MallStaffCard.New(arg_41_1)

	onButton(arg_41_0, var_41_0._go, function()
		if arg_41_0.status ~= var_0_0.STATUS.PREPARE then
			return
		end

		if #arg_41_0.selectedIds == arg_41_0.targetNum then
			pg.TipsMgr.GetInstance():ShowTips(i18n("mall_staff_position_full_tip"))

			return
		end

		if table.contains(arg_41_0.selectedIds, var_41_0.staff.id) then
			return
		end

		local var_42_0, var_42_1 = var_41_0.staff:GetStatusInfos()

		if var_42_0 == MallStaff.STATUS.ORDER then
			return
		end

		seriesAsync({
			function(arg_43_0)
				if var_42_0 == MallStaff.STATUS.FLOOR then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("mall_remove_floor_sure"),
						onYes = function()
							arg_41_0.activity:SetFloorStaff(var_42_1.floorId, var_42_1.floorIdx, 0)
							MallStaffLayer.CheckUpdateFloorStaffs(arg_41_0.activity, arg_43_0)

							return
						end
					})
				else
					arg_43_0()
				end

				return
			end
		}, function()
			table.insert(arg_41_0.selectedIds, var_41_0.staff.id)
			arg_41_0:UpdateInfoPanel()

			return
		end)

		return
	end, SFX_PANEL)

	arg_41_0.cards[arg_41_1] = var_41_0

	return
end

function var_0_0.OnUpdateStaffItem(arg_46_0, arg_46_1, arg_46_2)
	if not arg_46_0.cards[arg_46_2] then
		arg_46_0:OnInitStaffItem(arg_46_2)
	end

	arg_46_0.cards[arg_46_2]:Update(arg_46_0.staffList[arg_46_1 + 1], arg_46_0.selectedIds, false, arg_46_0.needShowAttrIds)

	return
end

function var_0_0.UpdateOrderSlotTpl(arg_47_0, arg_47_1, arg_47_2)
	setActive(arg_47_2:Find("icon"), arg_47_0.selectedIds[arg_47_1 + 1])

	if arg_47_0.selectedIds[arg_47_1 + 1] then
		MallStaffCard.StaticUpdateIcon(arg_47_2:Find("icon"), arg_47_0.activity:GetStaff(arg_47_0.selectedIds[arg_47_1 + 1]).tid)
	end

	onButton(arg_47_0, arg_47_2, function()
		if arg_47_0.status ~= var_0_0.STATUS.PREPARE then
			return
		end

		setActive(arg_47_0.uiOrderPanel, false)
		setActive(arg_47_0.uiStaffPanel, true)
		arg_47_0:SetTotalCount()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetTotalCount(arg_49_0)
	table.sort(arg_49_0.staffList, CompareFuncs({
		function(arg_50_0)
			local var_50_0, var_50_1 = arg_50_0:GetStatusInfos()

			return var_50_0 == MallStaff.STATUS.FLOOR and 1 or 0
		end,
		function(arg_51_0)
			return -arg_51_0.id
		end
	}))

	if isActive(arg_49_0.uiStaffPanel) then
		arg_49_0.scrollCom:SetTotalCount(#arg_49_0.staffList)
	end

	return
end

function var_0_0.UpdateStaffSlotTpl(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = arg_52_0.selectedIds[arg_52_1 + 1]

	setActive(arg_52_2:Find("icon"), arg_52_0.selectedIds[arg_52_1 + 1])

	if arg_52_0.selectedIds[arg_52_1 + 1] then
		MallStaffCard.StaticUpdateIcon(arg_52_2:Find("icon"), arg_52_0.activity:GetStaff(arg_52_0.selectedIds[arg_52_1 + 1]).tid)
	end

	onButton(arg_52_0, arg_52_2:Find("icon"), function()
		table.removebyvalue(arg_52_0.selectedIds, var_52_0)
		arg_52_0:UpdateInfoPanel()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.ShowUpgradeBox(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	arg_54_0.upgradeBox:ExecuteAction("Show", arg_54_1, arg_54_2, arg_54_3)

	return
end

function var_0_0.StartTimer(arg_55_0)
	arg_55_0:StopTimer()

	arg_55_0.endTime = arg_55_0.orderData:GetEndTime()
	arg_55_0.timer = Timer.New(function()
		local var_56_0 = arg_55_0.endTime - pg.TimeMgr.GetInstance():GetServerTime()

		setText(arg_55_0.uiOrderBtnsTF:Find("time/Text"), pg.TimeMgr.GetInstance():DescCDTime(var_56_0))

		if var_56_0 <= 0 then
			arg_55_0:UpdateData()
			arg_55_0:UpdateView()
		end

		return
	end, 1, -1)

	arg_55_0.timer:Start()
	arg_55_0.timer.func()

	return
end

function var_0_0.StopTimer(arg_57_0)
	if arg_57_0.timer then
		arg_57_0.timer:Stop()

		arg_57_0.timer = nil
	end

	return
end

function var_0_0.StartNextTimer(arg_58_0, arg_58_1)
	arg_58_0:StopNextTimer()

	arg_58_0.nextOrderTime = pg.TimeMgr.GetInstance():GetTimeToNextTime() + (arg_58_1 - 1) * 0
	arg_58_0.nextTimer = Timer.New(function()
		local var_59_0 = arg_58_0.nextOrderTime - pg.TimeMgr.GetInstance():GetServerTime()

		setText(arg_58_0.uiOrderPanel:Find("empty/list/time/value"), pg.TimeMgr.GetInstance():DescCDTime(var_59_0))

		if var_59_0 <= 0 then
			arg_58_0:UpdateData()
			arg_58_0:UpdateView()
		end

		return
	end, 1, -1)

	arg_58_0.nextTimer:Start()
	arg_58_0.nextTimer.func()

	return
end

function var_0_0.StopNextTimer(arg_60_0)
	if arg_60_0.nextTimer then
		arg_60_0.nextTimer:Stop()

		arg_60_0.nextTimer = nil
	end

	return
end

function var_0_0.onBackPressed(arg_61_0)
	if arg_61_0.upgradeBox and arg_61_0.upgradeBox:isShowing() then
		arg_61_0.upgradeBox:ExecuteAction("Hide")

		return
	end

	var_0_0.super.onBackPressed(arg_61_0)

	return
end

function var_0_0.willExit(arg_62_0)
	existCall(arg_62_0.contextData.onExit)

	arg_62_0.contextData.onExit = nil

	if arg_62_0.upgradeBox then
		arg_62_0.upgradeBox:Destroy()

		arg_62_0.upgradeBox = nil
	end

	ClearLScrollrect(arg_62_0.scrollCom)

	for iter_62_0, iter_62_1 in pairs(arg_62_0.cards) do
		iter_62_1:Dispose()
	end

	arg_62_0.cards = {}

	arg_62_0:StopTimer()
	arg_62_0:StopNextTimer()

	return
end

return var_0_0
