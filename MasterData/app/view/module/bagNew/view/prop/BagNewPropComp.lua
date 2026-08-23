local BagNewPropComp = class("BagNewPropComp", require("app.fairyGUI.bagNew.UI_BagNewPropComp"))
local var_0_1 = g.core.model.User.itemsData
local var_0_2 = g.core.const.ConstMgr
local var_0_3 = g.core.common.ServerTime
local var_0_4 = g.core.config.item_info
local var_0_5 = g.core.config.expirable_item_info
local var_0_6 = g.core.common.Goods
local BagNewPropCfg = require("app.view.module.bagNew.const.BagNewPropCfg")

function BagNewPropComp:ctor()
	self._selectIndex = 1
	self._curClickIndex = 0
	self._defaultSelected = false

	self.m_bagList:setVirtual()
	self.m_bagList:setItemRenderer(handler(self, self._onItemRenderer))
	self:_addListeners()
end

function BagNewPropComp:onSelectAction()
	self:_getBagDatas()
	self:_refreshPropList(true)
	self.m_showInfoComp:updateView(self._data[self.m_bagList:getSelectedIndex() + 1])
end

function BagNewPropComp:_addListeners()
	self.m_bagList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickItem))
	self.m_rightTopSelectTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
	self:addListen(self.m_showInfoComp)
end

function BagNewPropComp:receiveCompEvent(arg_4_1)
	if arg_4_1 == BagNewPropCfg.EVENT.REFRESH_BAG_DATA then
		self:_onInfoCompRefresh()
	end
end

function BagNewPropComp:playEnterAnim()
	self.m_showInfoComp:playEnterAnim()
end

function BagNewPropComp:_onInfoCompRefresh()
	self:_getBagDatas()
	self:_refreshPropList()
	self:_initShowItemInfo(self._curClickIndex)
end

function BagNewPropComp:onLoad()
	self.m_rightTopSelectTabController:setSelectedIndex(self._selectIndex - 1)
	self:_getBagDatas()
	self:_refreshPropList(true)

	if not self._notFirstEnter then
		self._notFirstEnter = true

		self:_initShowItemInfo()
	end
end

function BagNewPropComp:_filterBagData()
	local var_8_0 = var_0_1:getBagList()

	for iter_8_0 = #var_8_0, 1, -1 do
		local var_8_1 = var_0_6:convert(var_8_0[iter_8_0])

		if var_8_1.type ~= var_0_6.TYPE_ITEM and var_8_1.type ~= var_0_6.TYPE_EXPIRABLE_ITEM then
			table.remove(var_8_0, iter_8_0)
		end
	end

	return var_8_0
end

function BagNewPropComp:_getBagDatas()
	local var_9_0 = {}
	local var_9_1 = {}
	local var_9_2 = {}
	local var_9_3 = {}
	local var_9_4 = self:_sortItemsData((self:_filterBagData()))

	for iter_9_0, iter_9_1 in pairs(var_9_4) do
		local var_9_5 = iter_9_1.type == var_0_6.TYPE_EXPIRABLE_ITEM and var_0_5.get(iter_9_1.value) or var_0_4.get(iter_9_1.value)

		if var_9_5.sort == 1 then
			table.insert(var_9_0, iter_9_1)
		elseif var_9_5.sort == 2 then
			table.insert(var_9_1, iter_9_1)
		elseif var_9_5.sort == 3 then
			table.insert(var_9_2, iter_9_1)
		elseif var_9_5.sort == 4 then
			table.insert(var_9_3, iter_9_1)
		end
	end

	self._bagDatas = {
		var_9_4,
		var_9_0,
		var_9_1,
		var_9_2,
		var_9_3
	}

	return self._bagDatas
end

function BagNewPropComp:_getData()
	self._data = self._bagDatas[self._selectIndex]

	return self._data
end

function BagNewPropComp:_onChangeTabCtrl()
	self._selectIndex = self.m_rightTopSelectTabController:getSelectedIndex() + 1
	self._curClickIndex = 0

	self:_refreshPropList()
	self:_initShowItemInfo()
end

function BagNewPropComp:_initShowItemInfo(arg_12_1)
	local var_12_0 = arg_12_1 or 0

	if #self._data <= (arg_12_1 or 0) then
		var_12_0 = 0
	end

	if self._data and #self._data > 0 then
		self.m_showInfoComp:setVisible(true)
		self.m_bagList:setSelectedIndex(var_12_0)
		self.m_showInfoComp:updateView(self._data[var_12_0 + 1])

		self._defaultSelected = true
	end
end

function BagNewPropComp:_onItemRenderer(arg_13_1, arg_13_2)
	if self._data and #self._data > 0 then
		arg_13_2:updateIcon(self._data[arg_13_1 + 1])
	end
end

function BagNewPropComp:_onClickItem(arg_14_1)
	local var_14_0 = arg_14_1:getDataValue()

	self._curClickIndex = var_14_0

	self.m_showInfoComp:setVisible(true)
	self.m_showInfoComp:updateView(self._data[var_14_0 + 1])
end

function BagNewPropComp:fitPosition()
	if not self._fited then
		self._fited = true

		local var_15_0 = self.m_bagList:getFromPool()
		local var_15_1 = var_15_0:getWidth()

		self.m_bagList:returnToPool(var_15_0)

		local var_15_2 = self.m_bagList:getWidth()
		local var_15_3 = self.m_bagList:getColumnGap()
		local var_15_4 = math.floor(var_15_2 / (var_15_1 + var_15_3))

		if var_15_2 - (var_15_4 * var_15_1 + var_15_3) >= var_15_1 + var_15_3 then
			var_15_4 = var_15_4 + 1
		end

		self.m_bagList:setX(self.m_bagList:getX() + (var_15_2 - (var_15_1 + var_15_3) * var_15_4) / 4)
	end
end

function BagNewPropComp:_refreshPropList(arg_16_1)
	local var_16_0 = self:_getData()

	self:fitPosition()

	if not var_16_0 or #var_16_0 <= 0 then
		self.m_bagList:setNumItems(0)
		self.m_showInfoComp:setVisible(false)
		self.m_unGetGroup:setVisible(true)
		self.m_bagList:setVisible(false)
	else
		self.m_bagList:setVisible(true)
		self.m_unGetGroup:setVisible(false)
		self.m_bagList:setNumItems(#var_16_0)

		if arg_16_1 then
			self.m_bagList:transitionShowCells("listIconUiScaleIn", 0.03, 1)
		end

		self.m_bagList:setSelectedIndex(0)
		self:_initSelectIndex()
	end
end

function BagNewPropComp:_initSelectIndex()
	if self._data then
		self._curClickIndex = #self._data <= self._curClickIndex and 0 or self._curClickIndex
	end

	self.m_bagList:setSelectedIndex(self._curClickIndex)
end

function BagNewPropComp:_sortItemsData(arg_18_1)
	if #arg_18_1 <= 0 then
		return {}
	end

	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		if iter_18_1.type == var_0_2.BAG_TYPE.ITEM then
			local var_18_2 = var_0_4.get(iter_18_1.value)

			if var_18_2.limited_time ~= 0 or iter_18_1.time and iter_18_1.time ~= 0 then
				if var_0_3:getLeftSeconds((var_18_2.limited_time ~= 0 or nil) and var_18_2.limited_time) < 0 then
					var_18_0[#var_18_0 + 1] = iter_18_0
				end
			end
		end
	end

	for iter_18_2 = #var_18_0, 1, -1 do
		table.remove(arg_18_1, var_18_0[iter_18_2])
	end

	local var_18_5 = 259200

	table.sort(arg_18_1, function(arg_19_0, arg_19_1)
		local var_19_0 = false
		local var_19_1 = false
		local var_19_2
		local var_19_3

		var_19_2 = arg_19_0.type == var_0_6.TYPE_EXPIRABLE_ITEM and var_0_5.get(arg_19_0.value) or var_0_4.get(arg_19_0.value)
		var_19_3 = arg_19_1.type == var_0_6.TYPE_EXPIRABLE_ITEM and var_0_5.get(arg_19_1.value) or var_0_4.get(arg_19_1.value)

		local var_19_4 = arg_19_0.time or 0
		local var_19_5 = arg_19_1.time or 0

		if var_19_2.limited_time ~= 0 or var_19_4 ~= 0 then
			if var_0_3:getLeftSeconds((var_19_2.limited_time ~= 0 or nil) and (var_19_2.limited_time or var_19_4)) <= var_18_5 then
				var_19_0 = true
			end
		end

		if var_19_3.limited_time ~= 0 or var_19_5 ~= 0 then
			if var_0_3:getLeftSeconds((var_19_3.limited_time ~= 0 or nil) and (var_19_3.limited_time or var_19_5)) <= var_18_5 then
				var_19_1 = true
			end
		end

		if var_19_0 ~= var_19_1 then
			return var_19_0
		end

		if var_19_2.quality ~= var_19_3.quality then
			return var_19_2.quality > var_19_3.quality
		end

		if var_19_2.sort ~= var_19_3.sort then
			return var_19_2.sort > var_19_3.sort
		end

		return var_19_2.id > var_19_3.id
	end)

	return arg_18_1
end

function BagNewPropComp:onUnload()
	g.core.model.User.bagData:clearNewObtain()
end

return BagNewPropComp
