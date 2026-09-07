local MallOrderLayer = class("MallOrderLayer", import("view.base.BaseUI"))

MallOrderLayer.STATUS = {
	EMPTY = 5,
	COMPLETE = 4,
	WAIT = 1,
	PREPARE = 2,
	DOING = 3
}

function MallOrderLayer:getUIName()
	return "MallOrderUI"
end

function MallOrderLayer:init()
	onButton(self, self.uiBackBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.uiHomeBtn, function()
		self:quickExitFunc()

		return
	end, SOUND_BACK)
	onButton(self, self.uiHelpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.mall_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.uiStaffSureBtn, function()
		setActive(self.uiOrderPanel, true)
		setActive(self.uiStaffPanel, false)

		return
	end, SFX_PANEL)
	onButton(self, self.uiOrderBtnsTF:Find("staff"), function()
		setActive(self.uiOrderPanel, false)
		setActive(self.uiStaffPanel, true)
		self.scrollCom:SetTotalCount(#self.staffList)

		return
	end, SFX_PANEL)
	onButton(self, self.uiOrderBtnsTF:Find("start"), function()
		self:emit(MallOrderMediator.START_ORDER, self.activity.id, self.showId, self.selectedIds)

		return
	end, SFX_PANEL)
	onButton(self, self.uiOrderBtnsTF:Find("complete"), function()
		self:emit(MallOrderMediator.COMPLETE_ORDER, self.activity.id, self.showId)

		return
	end, SFX_PANEL)
	onButton(self, self.uiDialogueTF, function()
		setActive(self.uiDialogueTF, false)
		existCall(self.completeCb)

		self.completeCb = nil

		return
	end, SFX_PANEL)

	self.orderSlotUIList = UIItemList.New(self.uiOrderStaffTF, self.uiOrderStaffTF:Find("tpl"))

	self.orderSlotUIList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			self:UpdateOrderSlotTpl(arg_11_1, arg_11_2)
		end

		return
	end)

	self.staffSlotUIList = UIItemList.New(self.uiStaffContentTF, self.uiStaffContentTF:Find("tpl"))

	self.staffSlotUIList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			self:UpdateStaffSlotTpl(arg_12_1, arg_12_2)
		end

		return
	end)

	self.scrollCom = self.uiStaffScrollTF:GetComponent("LScrollRect")

	function self.scrollCom.onInitItem(arg_13_0)
		self:OnInitStaffItem(arg_13_0)

		return
	end

	function self.scrollCom.onUpdateItem(arg_14_0, arg_14_1)
		self:OnUpdateStaffItem(arg_14_0, arg_14_1)

		return
	end

	self.upgradeBox = MallUpgradeBox.New(self._tf, self.event, self.contextData)

	setText(self.uiTitleText, i18n("mall_title"))
	setText(self.uiTitleEnText, i18n("mall_title_en"))
	setText(self.uiOrderBtnsTF:Find("staff/Text"), i18n("mall_order_btn_staff"))
	setText(self.uiOrderBtnsTF:Find("start/Text"), i18n("mall_order_btn_start"))
	setText(self.uiOrderBtnsTF:Find("doing/Text"), i18n("mall_order_btn_doing"))
	setText(self.uiOrderBtnsTF:Find("complete/Text"), i18n("mall_order_btn_complete"))

	return
end

function MallOrderLayer:didEnter()
	self:UpdateData()
	self:UpdateView()
	triggerButton(self.uiStaffSureBtn)

	return
end

function MallOrderLayer:UpdateData()
	self.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)
	self.level = self.activity:GetLevelData().level
	self.orderData = self.activity:GetOrderData()
	self.selectedIds = self.selectedIds or Clone(self.orderData:GetStaffList())
	self.finishedIds = self.orderData:GetFinishedList()
	self.staffList = self.activity:GetStaffList()
	self.cards = {}

	return
end

function MallOrderLayer:ClearSelectedIds()
	self.selectedIds = nil

	return
end

function MallOrderLayer:UpdateView()
	setText(self.uiGoldText, self.activity:GetGold())

	self.status = self:GetStatus()
	self.paintName, self.showWord, self.showName = self:GetPaintingInfo()

	if self.paintName ~= "" then
		if checkABExist("painting/" .. self.paintName .. "_n") then
			self.paintingName = self.paintName .. "_n" or self.paintName
		end

		setPaintingPrefab(self.uiPaintTF, self.paintingName, "duihua")
		setText(self.uiOrderDescText, pg.activity_mall_custom_order[self.showId].desc)
		setText(self.uiOrderNameText, i18n("mall_order_char_header") .. self.showName)
	end

	local var_18_0 = self.status ~= MallOrderLayer.STATUS.WAIT and self.status ~= MallOrderLayer.STATUS.EMPTY

	setActive(self.uiOrderPanel:Find("content"), self.status ~= MallOrderLayer.STATUS.WAIT and self.status ~= MallOrderLayer.STATUS.EMPTY)
	setActive(self.uiOrderPanel:Find("empty"), not var_18_0)

	if var_18_0 then
		self:UpdateInfoPanel()
		self:StopNextTimer()
	else
		self:UpdateEmptyPanel()
	end

	self:CheckShowDialogue()

	return
end

function MallOrderLayer:GetStatus()
	if self.orderData:IsFinishedAll() then
		return MallOrderLayer.STATUS.EMPTY
	end

	self.showId = 0

	if self.orderData.id ~= 0 then
		self.showId = self.orderData.id

		return (pg.TimeMgr.GetInstance():GetServerTime() >= self.orderData:GetEndTime() or nil) and (MallOrderLayer.STATUS.COMPLETE or MallOrderLayer.STATUS.DOING)
	else
		self.showId = underscore.detect(pg.activity_mall_custom_order.all, function(arg_20_0)
			return not table.contains(self.finishedIds, arg_20_0)
		end)

		return (self.level >= pg.activity_mall_custom_order[self.showId].unlock_lv and self.activity:getDayIndex() >= pg.activity_mall_custom_order[self.showId].unlock_time or nil) and (MallOrderLayer.STATUS.PREPARE or MallOrderLayer.STATUS.WAIT)
	end

	return
end

function MallOrderLayer:GetPaintingInfo()
	local var_21_0 = pg.activity_mall_custom_order[self.showId]
	local var_21_1 = pg.ship_skin_template

	return switch(self.status, {
		[MallOrderLayer.STATUS.WAIT] = function()
			return "", "", ""
		end,
		[MallOrderLayer.STATUS.PREPARE] = function()
			return var_21_1[var_21_0.char].painting, var_21_0.word.intro_word[1], var_21_0.char_name or ""
		end,
		[MallOrderLayer.STATUS.DOING] = function()
			return var_21_1[var_21_0.char].painting, var_21_0.word.ongoing_word[1], var_21_0.char_name or ""
		end,
		[MallOrderLayer.STATUS.COMPLETE] = function()
			return var_21_1[var_21_0.char].painting, var_21_0.word.ongoing_word[1], var_21_0.char_name or ""
		end,
		[MallOrderLayer.STATUS.EMPTY] = function()
			return "", "", ""
		end
	})
end

function MallOrderLayer:CheckShowDialogue()
	setActive(self.uiPaintDialogueTF, false)

	if self.status ~= MallOrderLayer.STATUS.WAIT and self.status ~= MallOrderLayer.STATUS.EMPTY then
		setText(self.uiPaintDialogueTF:Find("Text"), self.showWord)
		setActive(self.uiPaintDialogueTF, true)
	end

	return
end

function MallOrderLayer:ShowCompleteDialogue(arg_28_1)
	self.completeCb = arg_28_1

	setPaintingPrefab(self.uiDialogueTF:Find("paint"), self.paintName, "duihua")
	setText(self.uiDialogueTF:Find("content/Text"), pg.activity_mall_custom_order[self.showId].word.finished_word[1])
	setActive(self.uiDialogueTF, true)

	return
end

function MallOrderLayer:UpdateInfoPanel()
	self.showConfig = pg.activity_mall_custom_order[self.showId]

	self:UpdateStaffAndTarget()
	self:UpdataOrderInfo()
	self:UpdateBtns()
	self:SetTotalCount()

	return
end

function MallOrderLayer:UpdateStaffAndTarget()
	self.targetNum, self.targetAttrs, self.curAttrs = 0, {}, {}

	for iter_30_0, iter_30_1 in ipairs(self.showConfig.order_need) do
		if iter_30_0 == 1 then
			self.targetNum = iter_30_1
		else
			table.insert(self.targetAttrs, iter_30_1)
			table.insert(self.curAttrs, 0)
		end
	end

	for iter_30_2, iter_30_3 in ipairs(self.selectedIds) do
		for iter_30_4, iter_30_5 in ipairs(self.activity:GetStaff(iter_30_3):GetAttrList()) do
			self.curAttrs[iter_30_4] = self.curAttrs[iter_30_4] + iter_30_5
		end
	end

	self:UpdateStaffAttrsCond(self.uiStaffAttrsCondTF)
	self.orderSlotUIList:align(self.targetNum)
	self.staffSlotUIList:align(self.targetNum)

	if isActive(self.uiStaffPanel) then
		self.scrollCom:SetTotalCount(#self.staffList)
	end

	self:CheckStartBtn()

	return
end

function MallOrderLayer:UpdateStaffAttrsCond(arg_31_1)
	local var_31_0 = arg_31_1:Find("desc")

	setText(var_31_0:Find("Text"), i18n("mall_order_need_attrs_header"))

	local var_31_1 = true

	self.needShowAttrIds = {}

	for iter_31_0, iter_31_1 in ipairs(self.targetAttrs) do
		local var_31_2 = iter_31_1 <= self.curAttrs[iter_31_0]

		if iter_31_1 > self.curAttrs[iter_31_0] then
			var_31_1 = false
		end

		setActive(var_31_0:Find("list/" .. iter_31_0), iter_31_1 > 0)

		if iter_31_1 > 0 then
			table.insert(self.needShowAttrIds, iter_31_0)
			setText(var_31_0:Find("list/" .. iter_31_0 .. "/Text"), setColorStr(self.curAttrs[iter_31_0], var_31_2 and "#4c9922" or "#df6126") .. "/" .. iter_31_1)
		end
	end

	setActive(arg_31_1:Find("unfinished"), not var_31_1)
	setActive(arg_31_1:Find("finished"), var_31_1)

	return
end

function MallOrderLayer:UpdataOrderInfo()
	local var_32_0 = underscore.map(self.showConfig.order_cost_show, function(arg_33_0)
		local var_33_0 = Drop.Create(arg_33_0)

		return {
			text = i18n("word_consume") .. var_33_0.count .. var_33_0:getName(),
			isReach = var_33_0:getOwnedCount() >= var_33_0.count
		}
	end)

	self:UpdateStaffAttrsCond(self.uiOrderAttrsCondTF)
	table.insert(var_32_0, 1, {
		text = i18n("mall_order_need_staff_header") .. setColorStr(#self.selectedIds, #self.selectedIds >= self.targetNum and "#4c9922" or "#df6126") .. "/" .. self.targetNum,
		isReach = #self.selectedIds >= self.targetNum
	})
	UIItemList.StaticAlign(self.uiOrderCostTF, self.uiOrderCostTF:Find("tpl"), #var_32_0, function(arg_34_0, arg_34_1, arg_34_2)
		if arg_34_0 == UIItemList.EventUpdate then
			setText(arg_34_2:Find("Text"), var_32_0[arg_34_1 + 1].text)
			setActive(arg_34_2:Find("unfinished"), not var_32_0[arg_34_1 + 1].isReach)
			setActive(arg_34_2:Find("finished"), var_32_0[arg_34_1 + 1].isReach)
		end

		return
	end)

	local var_32_1 = underscore.map(self.showConfig.order_reward_show, function(arg_35_0)
		local var_35_0 = Drop.Create(arg_35_0)

		return var_35_0:getName() .. "*" .. var_35_0.count
	end)

	UIItemList.StaticAlign(self.uiOrderAwardTF, self.uiOrderAwardTF:Find("tpl"), #var_32_1, function(arg_36_0, arg_36_1, arg_36_2)
		if arg_36_0 == UIItemList.EventUpdate then
			setText(arg_36_2:Find("Text"), var_32_1[arg_36_1 + 1])
		end

		return
	end)

	return
end

function MallOrderLayer:UpdateBtns()
	self:CheckStartBtn()
	setActive(self.uiOrderBtnsTF:Find("doing"), self.status == MallOrderLayer.STATUS.DOING)
	setActive(self.uiOrderBtnsTF:Find("complete"), self.status == MallOrderLayer.STATUS.COMPLETE)
	setActive(self.uiOrderBtnsTF:Find("time"), self.status == MallOrderLayer.STATUS.DOING or self.status == MallOrderLayer.STATUS.PREPARE)

	if self.status == MallOrderLayer.STATUS.PREPARE then
		setText(self.uiOrderBtnsTF:Find("time/Text"), pg.TimeMgr.GetInstance():DescCDTime(self.showConfig.cost_time))
	end

	if self.status == MallOrderLayer.STATUS.DOING then
		self:StartTimer()
	else
		self:StopTimer()
	end

	return
end

function MallOrderLayer:CheckStartBtn()
	if self.status == MallOrderLayer.STATUS.PREPARE then
		setActive(self.uiOrderBtnsTF:Find("start"), self:CanStart())
	else
		setActive(self.uiOrderBtnsTF:Find("start"), false)
	end

	return
end

function MallOrderLayer:CanStart()
	if #self.selectedIds ~= self.targetNum then
		return false
	end

	if self.activity:GetGold() < self.showConfig.order_cost_gold then
		return false
	end

	for iter_39_0, iter_39_1 in ipairs(self.targetAttrs) do
		if iter_39_1 > self.curAttrs[iter_39_0] then
			return false
		end
	end

	for iter_39_2, iter_39_3 in ipairs(MallOrder.GetCost(self.showId)) do
		if iter_39_3:getOwnedCount() < iter_39_3.count then
			return false
		end
	end

	return true
end

function MallOrderLayer:UpdateEmptyPanel()
	self:StopNextTimer()

	local var_40_0 = self.uiOrderPanel:Find("empty")
	local var_40_1 = var_40_0:Find("list/tip")

	setActive(var_40_1, self.status == MallOrderLayer.STATUS.EMPTY)

	local var_40_2 = var_40_0:Find("list/time")
	local var_40_3 = var_40_0:Find("list/level")

	if self.status == MallOrderLayer.STATUS.EMPTY then
		setText(var_40_1, i18n("mall_order_finished_all_tip"))
		setActive(var_40_2, false)
		setActive(var_40_3, false)
	else
		local var_40_4 = pg.activity_mall_custom_order[self.showId]

		if self.level < pg.activity_mall_custom_order[self.showId].unlock_lv then
			setText(var_40_3, i18n("mall_order_unlock_lv_tip", var_40_4.unlock_lv))
			setActive(var_40_3, true)
		else
			setActive(var_40_3, false)
		end

		local var_40_5 = var_40_4.unlock_time - self.activity:getDayIndex()

		if var_40_5 > 0 then
			setText(var_40_2:Find("Text"), i18n("mall_order_wait_tip"))
			self:StartNextTimer(var_40_5)
			setActive(var_40_2, true)
		else
			setActive(var_40_2, false)
		end
	end

	return
end

function MallOrderLayer:OnInitStaffItem(arg_41_1)
	local var_41_0 = MallStaffCard.New(arg_41_1)

	onButton(self, var_41_0._go, function()
		if self.status ~= MallOrderLayer.STATUS.PREPARE then
			return
		end

		if #self.selectedIds == self.targetNum then
			pg.TipsMgr.GetInstance():ShowTips(i18n("mall_staff_position_full_tip"))

			return
		end

		if table.contains(self.selectedIds, var_41_0.staff.id) then
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
							self.activity:SetFloorStaff(var_42_1.floorId, var_42_1.floorIdx, 0)
							MallStaffLayer.CheckUpdateFloorStaffs(self.activity, arg_43_0)

							return
						end
					})
				else
					arg_43_0()
				end

				return
			end
		}, function()
			table.insert(self.selectedIds, var_41_0.staff.id)
			self:UpdateInfoPanel()

			return
		end)

		return
	end, SFX_PANEL)

	self.cards[arg_41_1] = var_41_0

	return
end

function MallOrderLayer:OnUpdateStaffItem(arg_46_1, arg_46_2)
	if not self.cards[arg_46_2] then
		self:OnInitStaffItem(arg_46_2)
	end

	self.cards[arg_46_2]:Update(self.staffList[arg_46_1 + 1], self.selectedIds, false, self.needShowAttrIds)

	return
end

function MallOrderLayer:UpdateOrderSlotTpl(arg_47_1, arg_47_2)
	setActive(arg_47_2:Find("icon"), self.selectedIds[arg_47_1 + 1])

	if self.selectedIds[arg_47_1 + 1] then
		MallStaffCard.StaticUpdateIcon(arg_47_2:Find("icon"), self.activity:GetStaff(self.selectedIds[arg_47_1 + 1]).tid)
	end

	onButton(self, arg_47_2, function()
		if self.status ~= MallOrderLayer.STATUS.PREPARE then
			return
		end

		setActive(self.uiOrderPanel, false)
		setActive(self.uiStaffPanel, true)
		self:SetTotalCount()

		return
	end, SFX_PANEL)

	return
end

function MallOrderLayer:SetTotalCount()
	table.sort(self.staffList, CompareFuncs({
		function(arg_50_0)
			local var_50_0, var_50_1 = arg_50_0:GetStatusInfos()

			return var_50_0 == MallStaff.STATUS.FLOOR and 1 or 0
		end,
		function(arg_51_0)
			return -arg_51_0.id
		end
	}))

	if isActive(self.uiStaffPanel) then
		self.scrollCom:SetTotalCount(#self.staffList)
	end

	return
end

function MallOrderLayer:UpdateStaffSlotTpl(arg_52_1, arg_52_2)
	local var_52_0 = self.selectedIds[arg_52_1 + 1]

	setActive(arg_52_2:Find("icon"), self.selectedIds[arg_52_1 + 1])

	if self.selectedIds[arg_52_1 + 1] then
		MallStaffCard.StaticUpdateIcon(arg_52_2:Find("icon"), self.activity:GetStaff(self.selectedIds[arg_52_1 + 1]).tid)
	end

	onButton(self, arg_52_2:Find("icon"), function()
		table.removebyvalue(self.selectedIds, var_52_0)
		self:UpdateInfoPanel()

		return
	end, SFX_PANEL)

	return
end

function MallOrderLayer:ShowUpgradeBox(arg_54_1, arg_54_2, arg_54_3)
	self.upgradeBox:ExecuteAction("Show", arg_54_1, arg_54_2, arg_54_3)

	return
end

function MallOrderLayer:StartTimer()
	self:StopTimer()

	self.endTime = self.orderData:GetEndTime()
	self.timer = Timer.New(function()
		local var_56_0 = self.endTime - pg.TimeMgr.GetInstance():GetServerTime()

		setText(self.uiOrderBtnsTF:Find("time/Text"), pg.TimeMgr.GetInstance():DescCDTime(var_56_0))

		if var_56_0 <= 0 then
			self:UpdateData()
			self:UpdateView()
		end

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function MallOrderLayer:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function MallOrderLayer:StartNextTimer(arg_58_1)
	self:StopNextTimer()

	self.nextOrderTime = pg.TimeMgr.GetInstance():GetTimeToNextTime() + (arg_58_1 - 1) * 0
	self.nextTimer = Timer.New(function()
		local var_59_0 = self.nextOrderTime - pg.TimeMgr.GetInstance():GetServerTime()

		setText(self.uiOrderPanel:Find("empty/list/time/value"), pg.TimeMgr.GetInstance():DescCDTime(var_59_0))

		if var_59_0 <= 0 then
			self:UpdateData()
			self:UpdateView()
		end

		return
	end, 1, -1)

	self.nextTimer:Start()
	self.nextTimer.func()

	return
end

function MallOrderLayer:StopNextTimer()
	if self.nextTimer then
		self.nextTimer:Stop()

		self.nextTimer = nil
	end

	return
end

function MallOrderLayer:onBackPressed()
	if self.upgradeBox and self.upgradeBox:isShowing() then
		self.upgradeBox:ExecuteAction("Hide")

		return
	end

	MallOrderLayer.super.onBackPressed(self)

	return
end

function MallOrderLayer:willExit()
	existCall(self.contextData.onExit)

	self.contextData.onExit = nil

	if self.upgradeBox then
		self.upgradeBox:Destroy()

		self.upgradeBox = nil
	end

	ClearLScrollrect(self.scrollCom)

	for iter_62_0, iter_62_1 in pairs(self.cards) do
		iter_62_1:Dispose()
	end

	self.cards = {}

	self:StopTimer()
	self:StopNextTimer()

	return
end

return MallOrderLayer
