-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/view/RoomActiveDialogTipsView.lua

module("logic.extensions.housemain.view.RoomActiveDialogTipsView", package.seeall)

local M = class("RoomActiveDialogTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._txtTitle = self:getText("message_tips_-1921776596")
	self._txtConent = self:getUIComponent("message_dialog_-858469084", UIComponentType.TextMeshProUGUI)
	self._goPriceRoot = self:getGo("message_tips_675828753")
	self._goPriceItem = self:getGo("message_tips_-2131721215")

	goutil.setActive(self._goPriceRoot, false)
	goutil.setActive(self._goPriceItem, false)

	self._btnClose = UIComponentType.ButtonAdapter(self:getGo("message_tips_1822196934"))
	self._btnCancel = Astral.SimpleLuaComponentContainer.Add(self:getGo("4&btn_left_-1571983320"), CommButton)
	self._btnConfirm = Astral.SimpleLuaComponentContainer.Add(self:getGo("5&btn_right_1251431307"), CommButton)
end

function M:destroyUI()
	self._txtTitle = nil
	self._txtConent = nil
	self._goPriceRoot = nil
	self._goPriceItem = nil
	self._btnClose = nil
	self._btnCancel = nil
	self._btnConfirm = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function M:onEnter()
	self:_setEvent(true)

	local info = self:getFirstParam()

	self._roomId = info.roomId
	self._focus = info.focus
	self._callBackFunc = info.callBackFunc
	self._callBackHandler = info.callBackHandler

	local content = string.format(lang("tip_cost_s"), HouseMainUtil.getActiveZoneCostStr(self._roomId))

	self:setTitle(lang("tip_title"))
	self:setContent(string.format(lang("tip_charging_device"), content))
	self:setCost(self._roomId)
end

function M:onExit()
	self:_setEvent(false)

	self._roomId = nil

	self:_clearPriceItemClone()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.JUMP_VIEW_EVENT, self.handleJumpViewEvent, self)
	else
		GlobalDispatcher:removeEventListener(EventType.JUMP_VIEW_EVENT, self.handleJumpViewEvent, self)
	end
end

function M:handleJumpViewEvent(e, jumpId)
	if not SystemJumpController.instance:canJump(jumpId) then
		return
	end

	self:close()
end

function M:_onClickClose()
	self:close()
end

function M:_onClickCancel()
	self:close()
end

function M:_onClickConfirm()
	local info = {}

	info.roomId = self._roomId
	info.focus = self._focus
	info.callBackFunc = self._callBackFunc
	info.callBackHandler = self._callBackHandler

	HouseDispatcher:dispatchEvent(HouseEventType.TRY_ACTIVE_ROOM, info)
	self:close()
end

function M:setTitle(title)
	self._txtTitle.text = title
end

function M:setContent(content)
	self._txtConent.text = content
end

function M:setCost(roomId)
	local cost = {}
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, roomId)

	if roomCO then
		cost = roomCO.activeCost
	else
		printError(string.format("无法找到[%s],zoneId[%d]的配置", ConfigName.HouseZone, roomId))
	end

	self:setTopCurrency(roomId, cost)
end

function M:setPriceShow(costItemLst)
	local len = costItemLst and #costItemLst or 0
	local show = len > 0

	self._priceItem = {}

	if show then
		local index = 1

		while len > #self._priceItem do
			local tmpGo = goutil.cloneAndSetParent(self._goPriceItem, self._goPriceRoot.transform)

			table.insert(self._priceItem, tmpGo)
			self:_updatePriceItemShow(tmpGo, costItemLst[index])

			index = index + 1
		end
	end

	goutil.setActive(self._goPriceRoot, show)
end

function M:_updatePriceItemShow(go, item)
	local imgIcon = goutil.findChildImageComponent(go, "imgIcon")
	local txtNum = goutil.findChildTextComponent(go, "txtValue")
	local txtHint = goutil.findChildTextComponent(go, "txtValue/txtHint")
	local itemId = item.id
	local itemReqNum = item.num
	local itemCo = BackpackConfig.instance:getItemInfoByItemId(itemId)

	if itemCo then
		IconLoader.setSprite(imgIcon, IconType.ItemIcon, itemCo.icon)
	else
		printError(string.format("无法找到道具[%s]的配置", itemId))
	end

	local nowCount = ItemModel.instance:getItemCountByItemId(itemId)
	local enough = nowCount >= item.num

	txtHint.text = ""
	txtNum.text = enough and itemReqNum or string.format("<color=#ff3e48>%d</color>", itemReqNum)

	goutil.setActive(go, true)
end

function M:_clearPriceItemClone()
	local len = self._priceItem and #self._priceItem or 0

	if len > 0 then
		for i = len, 1, -1 do
			local go = self._priceItem[i]

			goutil.destroy(go)
		end
	end
end

function M:setTopCurrency(roomId, costItemLst)
	self:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, HouseMainEnum.RoomActiveMoneyShowType[roomId])
end

return M
