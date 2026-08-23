local var_0_0 = g.core.model.User.furnitureData
local var_0_1 = g.core.const.ConstMgr.FurnitureConst
local var_0_2 = g.core.config.furniture_limit_info
local var_0_3 = g.core.config.furniture_info
local FurnitureSubTypeComp = class("FurnitureSubTypeComp", require("app.fairyGUI.furniture.UI_FurnitureSubTypeComp"))

function FurnitureSubTypeComp:ctor()
	self._kindList = {}
	self._furnitureType = 1

	self.m_subItemList:setVirtual()
	self.m_subItemList:doFairyBatching(false)
	self.m_subItemList:setItemRenderer(handler(self, self._onSubItemListItemRenderer))
	self:_initListener()
	self:addListen(self.m_suitComp)

	self._curChooseSuitId = 0
end

function FurnitureSubTypeComp:_initListener()
	self.m_deleteBtn:addClickListener(handler(self, self._onClickDeleteBtn))
	self.m_saveBtn:addClickListener(handler(self, self._onClickSaveBtn))
	self.m_resetBtn:addClickListener(handler(self, self._onClickResetBtn))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_subItemList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickFurnitureItem))
end

function FurnitureSubTypeComp:_onTouchBegin(arg_3_1)
	arg_3_1:stopPropagation()
end

function FurnitureSubTypeComp:updateView(arg_4_1, arg_4_2, arg_4_3)
	self._curFloorId = arg_4_1
	self._furnitureType = arg_4_2
	self._allFurniture = arg_4_3
	self._kindList = var_0_0:getFurnitureItemDataByType(self._furnitureType, self._curChooseSuitId)

	local var_4_0 = self:_getCurPlaceNumByType()
	local var_4_1 = var_0_2.get(self._furnitureType).limit_num
	local var_4_2 = var_0_0:getSubTypeFurnitureOwnCount(self._furnitureType, self._curChooseSuitId) > 0

	if var_4_2 then
		self.m_subItemList:setNumItems(#self._kindList)
		self.m_subItemList:transitionShowCells("listCardAUiRightIn01", 0.06)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end, 0.3)
	end

	self.m_isNoneController:setSelectedIndex(var_4_2 and 0 or 1)

	if var_4_2 then
		self.m_haveCountTxt:setColor(g.core.common.Color.A8)
	else
		self.m_haveCountTxt:setColor(g.core.common.Color.A7)
	end

	self.m_haveCountTxt:setText(var_4_0 .. "/" .. var_4_1)

	self._isLimitCreate = var_4_0 == var_4_1

	if self._furnitureType == var_0_1.FURNITURE_TYPE.WALL or self._furnitureType == var_0_1.FURNITURE_TYPE.FLOOR or self._furnitureType == var_0_1.FURNITURE_TYPE.ROOM_BG then
		self._isLimitCreate = false
	end

	self:_checkSuitComp()
end

function FurnitureSubTypeComp:_getCurPlaceNumByType()
	local var_6_0 = 0

	if not self._allFurniture then
		return var_6_0
	end

	if #self._allFurniture > 0 then
		for iter_6_0, iter_6_1 in pairs(self._allFurniture) do
			if var_0_3.get(iter_6_1).type == self._furnitureType then
				var_6_0 = var_6_0 + 1
			end
		end
	end

	return var_6_0
end

function FurnitureSubTypeComp:_getCurPlaceNumById(arg_7_1)
	local var_7_0 = 0

	if not self._allFurniture then
		return var_7_0
	end

	if #self._allFurniture > 0 then
		for iter_7_0, iter_7_1 in pairs(self._allFurniture) do
			if iter_7_1 == arg_7_1 then
				var_7_0 = var_7_0 + 1
			end
		end
	end

	return var_7_0
end

function FurnitureSubTypeComp:getListData()
	local var_8_0 = {}

	for iter_8_0 = 1, #self._kindList do
		table.insert(var_8_0, {
			id = self._kindList[iter_8_0].id,
			num = self._kindList[iter_8_0].num - var_0_0:getOtherFloorPlaceCountById(self._curFloorId, self._kindList[iter_8_0].id) - self:_getCurPlaceNumById(self._kindList[iter_8_0].id)
		})
	end

	table.sort(var_8_0, function(arg_9_0, arg_9_1)
		if arg_9_0.num ~= arg_9_1.num then
			return arg_9_0.num > arg_9_1.num
		end

		if arg_9_0.id ~= arg_9_1.id then
			return arg_9_0.id > arg_9_1.id
		end
	end)

	return var_8_0
end

function FurnitureSubTypeComp:_onSubItemListItemRenderer(arg_10_1, arg_10_2)
	local var_10_0 = self:getListData()[arg_10_1 + 1]

	if var_10_0 then
		arg_10_2:updateView(var_10_0)
	end
end

function FurnitureSubTypeComp:_onClickFurnitureItem(arg_11_1)
	local var_11_0 = arg_11_1 and arg_11_1:getDataValue() or 0

	if self._isLimitCreate then
		g.core.module.ModuleManager:tip(g.core.lang:get(112531))

		return
	end

	local var_11_1 = self:getListData()[var_11_0 + 1]

	if var_11_1 then
		if var_11_1.num > 0 then
			self:dispatchCompEvent("CREATE_FURNITURE_OBJECT", var_11_1.id)
		else
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = g.core.common.Goods.TYPE_FURNITURE,
				value = var_11_1.id
			})
		end
	end
end

function FurnitureSubTypeComp:_onClickDeleteBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(112501),
		desc = g.core.lang:get(112502),
		onConfirm = function()
			self:dispatchCompEvent("CLICK_DELETE_ALL_BTN")
		end
	}))
end

function FurnitureSubTypeComp:_onClickSaveBtn()
	self:dispatchCompEvent("CLICK_SAVE_ALL_BTN")
end

function FurnitureSubTypeComp:_onClickResetBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(112505),
		desc = g.core.lang:get(112506),
		onConfirm = function()
			self:dispatchCompEvent("CLICK_RESET_ALL_BTN")
		end
	}))
end

function FurnitureSubTypeComp:receiveCompEvent(arg_17_1, arg_17_2)
	if arg_17_1 == "UPDATE_FURNITURE_LIST" then
		if arg_17_2 then
			self._curChooseSuitId = arg_17_2.suitId or 0
		end

		self:updateView(self._curFloorId, self._furnitureType, self._allFurniture)
	end
end

function FurnitureSubTypeComp:_checkSuitComp()
	self.m_suitComp:showSuitComp(false)
end

return FurnitureSubTypeComp
