-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/view/TradingOrderRefreshView.lua

module("logic.extensions.trading.view.TradingOrderRefreshView", package.seeall)

local M = class("TradingOrderRefreshView", ViewComponent)

function M:buildUI()
	self._txtTitle = self:getText("message_tips_-1921776596")
	self._txtContent = self:getUIComponent("message_dialog_-858469084", UIComponentType.TextMeshProUGUI)
	self._btnRefresh = self:getBtn("6&btn_middle_-31477526")
	self._btnClose = self:getBtn("message_tips_1822196934")
	self._goConsume = self:getGo("message_tips_675828753")
	self._goBtn1 = self:getGo("4&btn_left_-1571983320")
	self._goBtn2 = self:getGo("5&btn_right_1251431307")
	self._txtPrice = self:getText("message_tips_-554235055")
	self._txtHint = self:getText("message_tips_15591811")
	self._imgIcon = self:getImage("message_tips_933011285")

	goutil.setActive(self._goBtn1, false)
	goutil.setActive(self._goBtn2, false)
	goutil.setActive(self._goConsume, true)
	goutil.setActive(self._btnRefresh.gameObject, true)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnRefresh:AddClickListener(self._onClickRefresh, self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
end

function M:unbindEvents()
	self._btnRefresh:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self._id = self:getFirstParam()
	self._orderIndex = self:getOpenParam()[2]

	self:setRefreshInfo()
end

function M:onExit()
	return
end

function M:onExitFinished()
	return
end

function M:setRefreshInfo()
	self._txtTitle.text = lang("tip_order_refresh")

	goutil.setActive(self._goConsume, not hadFreeCount)

	local refreshCost = TradingConfig.instance:getConstCoByKey("OrderRefreshCost").strValue
	local temp = StoreUtil.formatText(refreshCost)[1]
	local itemCo = BackpackConfig.instance:getItemInfoByItemId(temp.itemId)

	IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, itemCo.icon)

	self._txtPrice.text = temp.num

	local maxRefreshCount = TradingConfig.instance:getConstCoByKey("DailyOrderRefreshTimesMax").numValue
	local freeCount = TradingConfig.instance:getConstCoByKey("DailyOrderRefreshTimesFree").numValue
	local refreshCount = maxRefreshCount + freeCount - TradingModel.instance:getOrderRefreshTimes()
	local hadFreeCount = freeCount - TradingModel.instance:getOrderRefreshTimes() > 0
	local txtDefault = lang("tip_refresh_contiue_order")
	local txt1 = lang("tip_first_free")
	local txt2 = string.format(lang("tip_left_xx_num"), refreshCount)
	local countTxt = hadFreeCount and txt1 or txt2

	self._txtContent.text = txtDefault .. countTxt
	self._txtHint.text = ""
	self._canRefresh = hadFreeCount or refreshCount > 0

	goutil.setActive(self._imgIcon.gameObject, not hadFreeCount)
	goutil.setActive(self._txtPrice.gameObject, not hadFreeCount)
end

function M:_onClickRefresh()
	if not self._canRefresh then
		FloatWordMgr.instance:show(lang("tip_no_refresh_num"))

		return
	end

	TradingAgent.instance:sendRefreshDailyOrderRequest(self._orderIndex)
	self:close()
end

function M:_onClickBtnClose()
	self:close()
end

return M
