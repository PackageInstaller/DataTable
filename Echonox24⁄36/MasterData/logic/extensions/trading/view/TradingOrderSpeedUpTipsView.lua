-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/view/TradingOrderSpeedUpTipsView.lua

module("logic.extensions.trading.view.TradingOrderSpeedUpTipsView", package.seeall)

local M = class("TradingOrderSpeedUpTipsView", ViewComponent)
local kUseCountInterval = 60

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnClose = self:getBtn("small_tips_common_bg_1276053964")
	self._btnSpeedUp = self:getBtn("facility_speed_up_tips_2119221269")
	self._txtCostNum = self:getText("facility_speed_up_tips_478770252")
	self._imgCostIcon = self:getImage("facility_speed_up_tips_822935739")
	self._txtRemainTime = self:getText("facility_speed_up_tips_1489473258")
	self._txtSpeedUpProduct = self:getText("facility_speed_up_tips_445137701")
	self._btnMinus = self:getBtn("facility_speed_up_tips_-1580657469")
	self._btnAdd = self:getBtn("facility_speed_up_tips_-544755342")
	self._btnMax = self:getBtn("facility_speed_up_tips_1121477382")
	self._txtSpeedUpTime = self:getText("facility_speed_up_tips_561551609")
	self._refreshRemainTimer = SchedulerCtrl.New(self._refreshRemainTime, self)
	self._refreshCostTimer = SchedulerCtrl.New(self._refreshCost, self)
end

function M:destroyUI()
	self._refreshRemainTimer:clear()

	self._refreshRemainTimer = nil

	self._refreshCostTimer:clear()

	self._refreshCostTimer = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnSpeedUp:AddClickListener(self._onClickBtnSpeedUp, self)
	self._btnMinus:AddClickListener(self._onClickBtnMinus, self)
	self._btnAdd:AddClickListener(self._onClickBtnAdd, self)
	self._btnMax:AddClickListener(self._onClickBtnMax, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnSpeedUp:RemoveClickListener()
	self._btnMinus:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnMax:RemoveClickListener()
end

function M:_setEvents(isOn)
	if isOn then
		self._refreshRemainTimer:restart(1, true)
		self._refreshCostTimer:restart(kUseCountInterval, true)
		GlobalDispatcher:addEventListener(EventType.TRADING_ORDER_LIST, self._onOrderListChange, self)
		GlobalDispatcher:addEventListener(EventType.TRADING_POST_INFO, self._onPostInfoChange, self)
	else
		self._refreshRemainTimer:stop()
		self._refreshCostTimer:stop()
		GlobalDispatcher:removeEventListener(EventType.TRADING_ORDER_LIST, self._onOrderListChange, self)
		GlobalDispatcher:removeEventListener(EventType.TRADING_POST_INFO, self._onPostInfoChange, self)
	end
end

function M:onEnter()
	self._useCount = 0
	self._maxCostNum = 0

	self:initViews()
	self:_refreshRemainTime()
	self:_refreshCost()
	self:_setEvents(true)
end

function M:onExit()
	self:_setEvents(false)
end

function M:initViews()
	local itemId = TradingConfig.instance:getConstCoByKey("OrderSpeedUpCostItem").numValue
	local itemCo = BackpackConfig.instance:getItemInfoByItemId(itemId)

	IconLoader.setSprite(self._imgCostIcon, IconType.ItemIcon, itemCo.icon)
end

function M:_refreshRemainTime()
	local remainTime = TradingModel.instance:getRemainTime()
	local timeStr = TimeUtil.instance:numberToTime(remainTime, "h:m:s")

	self._txtRemainTime.text = timeStr

	local tradePostMo = TradingModel.instance:getTradePostMo()
	local co = TradingConfig.instance:getHouseCoByLevel(tradePostMo:getLevel())
	local dailyOrderIds = TradingModel.instance:getDailyOrder()
	local remainNum = co.maxDailyOrder - #dailyOrderIds

	if remainNum > 0 then
		local nextRemainTime = tradePostMo:getNextProductTimeStamp() - ServerTime.now()
		local perSpeedUpSec = TradingConfig.instance:getSpeedUpItemTime() * 60
		local useSpeedUpSec = self._useCount * perSpeedUpSec
		local extraTime = useSpeedUpSec - nextRemainTime
		local speedUpNum = 0

		if extraTime >= 0 then
			speedUpNum = math.floor(extraTime / tradePostMo:getProductCostSec()) + 1
			speedUpNum = math.min(remainNum, speedUpNum)
		end

		self._txtSpeedUpProduct.text = string.format("<color=#CFA96E>%s</color>/%s", speedUpNum, remainNum)
	else
		self._txtSpeedUpProduct.text = "0/0"

		self:close()
	end
end

function M:_refreshCost()
	self._maxCostNum = 0

	if not TradingModel.instance:getDailyOrderFull() then
		local remainTime = TradingModel.instance:getRemainTimeToDailyOrderFull()
		local perSpeedUpSec = TradingConfig.instance:getSpeedUpItemTime() * 60

		self._maxCostNum = math.ceil(remainTime / perSpeedUpSec)
	end

	local itemId = TradingConfig.instance:getConstCoByKey("OrderSpeedUpCostItem").numValue
	local itemCount = ItemModel.instance:getItemCountByItemId(itemId)

	self._maxCostNum = math.min(itemCount, self._maxCostNum)
	self._useCount = math.max(0, math.min(self._maxCostNum, self._useCount))

	self:_refreshCostView()
end

function M:_refreshCostView()
	self._txtCostNum.text = self._useCount

	local perSpeedUpSec = TradingConfig.instance:getSpeedUpItemTime() * 60
	local useSpeedUpSec = self._useCount * perSpeedUpSec
	local timeStr = TimeUtil.instance:numberToTime(useSpeedUpSec, "h:m:s")

	self._txtSpeedUpTime.text = timeStr
end

function M:_onClickBtnClose()
	self:close()
end

function M:_onClickBtnSpeedUp()
	if TradingModel.instance:getDailyOrderFull() then
		return
	end

	self:_refreshCost()

	if self._useCount > 0 then
		TradingAgent.instance:sendOrderSpeedUpRequest(self._useCount)
	else
		FloatWordMgr.instance:show(lang("tip_add_accelerate_material"))
	end
end

function M:_onClickBtnMinus()
	self._useCount = math.max(0, self._useCount - 1)

	self:_refreshRemainTime()
	self:_refreshCost()
end

function M:_onClickBtnAdd()
	self._useCount = math.min(self._maxCostNum, self._useCount + 1)

	self:_refreshRemainTime()
	self:_refreshCost()
end

function M:_onClickBtnMax()
	self._useCount = self._maxCostNum

	self:_refreshRemainTime()
	self:_refreshCost()
end

function M:_onOrderListChange()
	self:_refreshRemainTime()
	self:_refreshCost()
end

function M:_onPostInfoChange()
	self:_refreshRemainTime()
	self:_refreshCost()
end

return M
