-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingReportSpeedupTipsView.lua

module("logic.extensions.containmentzone.view.FacilityHoldingReportSpeedupTipsView", package.seeall)

local M = class("FacilityHoldingReportSpeedupTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnCloseBg = self:getBtn("facility_holding_report_speedup_tips_-1106391706")
	self._btnClose = self:getBtn("facility_holding_report_speedup_tips_-124481158")
	self._btnConfirm = self:getBtn("facility_holding_report_speedup_tips_-768146884")
	self._imgUserItemIcon = self:getImage("facility_holding_report_speedup_tips_-477445345")
	self._txtUseItemCount = self:getText("facility_holding_report_speedup_tips_-1522681112")

	local longPressTriggerCfg = {
		0.6,
		0.2,
		0.01
	}

	self._txtRemainTime = self:getText("facility_holding_report_speedup_tips_-1040849243")
	self._txtSpeedUpReportCount = self:getText("facility_holding_report_speedup_tips_-1420049037")
	self._InputSpeedUpTime = self:getInput("facility_holding_report_speedup_tips_-1157194823")
	self._btnMax = self:getBtn("facility_holding_report_speedup_tips_-103039511")
	self._btnAdd = Astral.UILongPressTrigger.Get(self:getGo("facility_holding_report_speedup_tips_-63991725"))
	self._btnMinus = Astral.UILongPressTrigger.Get(self:getGo("facility_holding_report_speedup_tips_1218053496"))

	self._btnAdd:SetTriggerTime(longPressTriggerCfg)
	self._btnMinus:SetTriggerTime(longPressTriggerCfg)
end

function M:destroyUI()
	self._btnClose = nil
	self._btnCloseBg = nil
	self._btnConfirm = nil
	self._imgUserItemIcon = nil
	self._txtUseItemCount = nil
	self._txtRemainTime = nil
	self._txtSpeedUpReportCount = nil
	self._InputSpeedUpTime = nil
	self._btnMax = nil
	self._btnAdd = nil
	self._btnMinus = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCloseBg:AddClickListener(self._onClickClose, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnMax:AddClickListener(self._onClickMax, self)
	self._btnAdd:AddLongPressListener(self._onLongPressAdd, self, nil)
	self._btnMinus:AddLongPressListener(self._tryMinusOne, self, nil)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCloseBg:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnMax:RemoveClickListener()
	self._btnAdd:RemoveLongPressListener()
	self._btnMinus:RemoveLongPressListener()
end

function M:onEnter()
	self._waitForReply = false

	GlobalDispatcher:addEventListener(EventType.HOUSE_HOLD_SPEED_UP_REPLY, self._handleHouseHoldSpeedUpReply, self)

	self._curUseNum = 0

	local info = self:getFirstParam()

	self._roomId = info.roomId

	local useItemId = ContainmentConfig.instance:getConstByKey("ReportSpeedUpCostItem")
	local itemCo = BackpackConfig.instance:getItemInfoByItemId(useItemId)

	IconLoader.setSprite(self._imgUserItemIcon, IconType.ItemIcon, itemCo.icon)

	self._itemCount = ItemModel.instance:getItemCountByItemId(useItemId)
	self._itemSpeedUpMinute = ContainmentConfig.instance:getConstByKey("ReportSpeedUpMinute")
	self._runningReport = ContainmentModel.instance:getRunningReport(self._roomId)

	local lastRoomInfoUpdateTimeStamp = self._runningReport:getRunningReportUpdateTimeStamp()
	local nowTime = ServerTime.now()
	local offsetTime = nowTime - lastRoomInfoUpdateTimeStamp

	self._remainTime = self._runningReport:getRunningReportRemainSecond() - offsetTime
	self._remainTime = self._remainTime < 0 and 0 or self._remainTime

	self:_updateRemainTime(self._remainTime)
	settimer(1, self._timerReprotCountDown, self, true)

	if self._itemCount > 0 then
		self:_tryAddOne(false)
	else
		self:updateItemPreUseShow()
	end

	local roomInfoMo = ContainmentModel.instance:getRoomInfoById(self._roomId)
	local p_base = ContainmentConfig.instance:getConstByKey("BaseDefaultProduction")
	local p_hero = roomInfoMo:getProductHero()
	local p_house_multi = roomInfoMo:getProductHouseRatio()
	local v_speed = (p_base + p_hero) * (1 + p_house_multi)

	print(string.format("<color=#00FFFF>收容室[%d]原体[%d],report[ %d ],failReport[ %d ],订单总耗时[%d]s,更新时间[%s],当前时间[%s],下次调度[%d]s,剩余时长[%d]s</color>", self._roomId, self._runningReport:getProtomerId(), roomInfoMo:getReportCount(), roomInfoMo:getFailReportCount(), self._runningReport:getRunningReportTotalSecond(), TimeUtil.instance:stampToDateStr(self._runningReport:getRunningReportUpdateTimeStamp()), TimeUtil.instance:stampToDateStr(nowTime), roomInfoMo:getScheduleTime(), self._runningReport:getRunningReportRemainSecond()))
	print(string.format("<color=#00FFFF>收容室[%d], 推算速度[%d]=(基础生产力[%d] + 角色生产力加成值[%d]) * (1 + 小屋生产力加成系数[%d])</color>", self._roomId, v_speed, p_base, p_hero, p_house_multi))
	print(string.format("<color=#00FFFF>收容室[%d]推算速度[%d]服务器下发速度[%d]</color>", self._roomId, v_speed, roomInfoMo:getProductSpeed()))
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.HOUSE_HOLD_SPEED_UP_REPLY, self._handleHouseHoldSpeedUpReply, self)
	removetimer(self._timerReprotCountDown, self)
end

function M:_timerReprotCountDown()
	self._remainTime = self._remainTime - 1

	self:_updateRemainTime(self._remainTime)
end

function M:_updateRemainTime(timeStamp)
	self._txtRemainTime.text = TextFormatter.formatClockTime(timeStamp)

	if timeStamp > 0 then
		self:updateItemPreUseShow()
	else
		print(string.format("订单推算已完成,加速界面自动关闭"))
		removetimer(self._timerReprotCountDown, self)
		self:close()
	end
end

function M:updateItemPreUseShow()
	self._txtUseItemCount.text = self._curUseNum

	local speedUpTime = self._curUseNum * self._itemSpeedUpMinute * 60

	self._txtSpeedUpReportCount.text = speedUpTime >= self._remainTime and "1" or "0"

	self._InputSpeedUpTime:SetText(TextFormatter.formatClockTime(speedUpTime))
end

function M:_handleHouseHoldSpeedUpReply()
	if self._waitForReply then
		self:close()
	end
end

function M:_onClickClose()
	if self._waitForReply then
		return
	end

	self:close()
end

function M:_onClickConfirm()
	if self._waitForReply then
		return
	end

	if self._curUseNum > 0 then
		self._waitForReply = true

		local maxItemCanUse = self:_getMaxItemCanUse()

		if maxItemCanUse < self._curUseNum then
			self._curUseNum = maxItemCanUse
		end

		ContainmentZoneAgent.instance:sendHoldSpeedUpRequest(self._roomId, self._curUseNum)
	else
		FloatWordMgr.instance:show(lang("t_prop_not_enough"))
		self:close()
	end
end

function M:_onClickMax()
	if self._waitForReply then
		return
	end

	self._curUseNum = self:_getMaxItemCanUse()

	self:updateItemPreUseShow()
end

function M:_getMaxItemCanUse()
	local protomerId = self._runningReport:getProtomerId()
	local protomerMo = ProtomerModel.instance:getProtomerInfo(protomerId)
	local p_need = protomerMo:getCfgProductivity()
	local p_cur = protomerMo:getProductivity()
	local p_need = p_need - p_cur
	local v_speed = self._runningReport:getRunningReportSpeed()
	local maxItem_limitByProcess = p_need / v_speed / self._itemSpeedUpMinute

	if maxItem_limitByProcess ~= math.ceil(maxItem_limitByProcess) then
		maxItem_limitByProcess = math.ceil(maxItem_limitByProcess)
	end

	if maxItem_limitByProcess >= self._itemCount then
		return self._itemCount
	else
		return maxItem_limitByProcess
	end
end

function M:_onLongPressAdd()
	if self._waitForReply then
		return
	end

	self:_tryAddOne(true)
end

function M:_tryAddOne(showToast)
	if self._curUseNum >= self._itemCount then
		return
	end

	local _readyNum = self._curUseNum + 1

	if _readyNum > self:_getMaxItemCanUse() then
		return
	end

	self._curUseNum = _readyNum

	self:updateItemPreUseShow()
end

function M:_tryMinusOne()
	if self._waitForReply then
		return
	end

	if self._curUseNum <= 1 then
		return
	end

	self._curUseNum = self._curUseNum - 1

	self:updateItemPreUseShow()
end

return M
