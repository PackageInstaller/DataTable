local var_0_0 = table.insert
local var_0_1 = table.sort
local var_0_2 = g.core.common.Path
local BagNewEquipBagComp = class("BagNewEquipBagComp", require("app.fairyGUI.bagNew.UI_BagNewEquipBagComp"))

function BagNewEquipBagComp:ctor(arg_1_1)
	self._equipList = nil
	self._fragList = nil
	self._curTabIndex = 0
	self._isNotWear = false
	self._typeIndex = 0
	self._qualityIndex = 0
	self._equipData = {}
	self._curFragIndex = 0
	self._curSelectFragId = nil
	self._fragListColNum = 5

	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
	self.m_hideInWearBtn:addEventListener(fgui.UIEventType.Changed, handler(self, self._onHideInWearChange))
	self.m_sellBtn:addClickListener(handler(self, self._onClickSell))
	self.m_rebornBtn:addClickListener(handler(self, self._onRebornClick))
	self.m_equipList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._updateEquipInfo), 1)
	self.m_equipList:setVirtual(self)
	self.m_equipList:doFairyBatching(false)
	self.m_equipList:setItemRendererAsync1(handler(self, self._onEquipItemRenderer), 0.01, false)
	self.m_fragList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._updateFragInfo), 1)
	self.m_fragList:setVirtual(self)
	self.m_fragList:setItemRenderer(handler(self, self._onFragItemRenderer))

	self._params = arg_1_1

	self.m_rebornBtn:setVisible((g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.REBORN)))
	self:fitRedPoint()
end

function BagNewEquipBagComp:fitRedPoint()
	self.m_fitTitle:setText(self.m_fragBtn:getTitle())

	local var_2_0 = self.m_fitTitle:getSize().width

	if var_2_0 > 100 then
		var_2_0 = 100
	end

	self.m_redPointComp:setX(self.m_fitTitle:getX() + var_2_0)
end

function BagNewEquipBagComp:updateEquipSellSucListView()
	self:_refreshListView()
end

function BagNewEquipBagComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FRAGMENT_COMPOSE, handler(self, self._onRcvFragmentCompose), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SELL, handler(self, self._onRcvEquipSell), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, handler(self, self._onOpObjectUpdate), self)
	self:_refreshListView(true)
	self.m_redPointComp:setId(94)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
	self:_updateSellBtnRedPoint()
end

function BagNewEquipBagComp:_onRcvFragmentCompose(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = arg_5_4.num
	local var_5_1 = g.core.config.fragment_info.get(arg_5_4.id)

	if var_5_1.fragment_type == g.core.common.Goods.TYPE_EQUIP then
		self:_refreshListView()
		self:runFGAction((fgui.FSequence:create({
			fgui.FDelayTime:create(0.1),
			fgui.FCallFunc:create(function()
				local var_6_0 = {
					num = var_5_0,
					id = var_5_1.fragment_value,
					title = g.core.lang:get(300001),
					showComp = fgui.UIPackage:createObject("base_new", "BaseShowPopEquipComp")
				}

				var_6_0.hideTitle = true

				g.core.module.ModuleManager:showFeedBackTipsPop(var_6_0)
			end)
		})))
	end
end

function BagNewEquipBagComp:_updateEquipData()
	self._equipData = self:_getEquipList(self._typeIndex, self._qualityIndex, self._isNotWear, true)
	self._fragListData = {}

	for iter_7_0, iter_7_1 in ipairs((g.core.model.User.fragmentsData:getSpFragmentList(g.core.common.Goods.FRAGMENT.TYPE_EQUIP, {
		type = self._typeIndex,
		quality = self._qualityIndex
	}))) do
		local var_7_0 = g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_FRAGMENT,
			value = iter_7_1.id,
			size = iter_7_1.num
		})

		var_7_0.canBeComposed = var_7_0.size >= var_7_0.info.combine_num

		var_0_0(self._fragListData, var_7_0)
	end

	var_0_1(self._fragListData, function(arg_8_0, arg_8_1)
		if arg_8_0.canBeComposed ~= arg_8_1.canBeComposed then
			return arg_8_0.canBeComposed
		end

		return arg_8_0.info.quality > arg_8_1.info.quality
	end)
end

function BagNewEquipBagComp:_onRcvEquipSell()
	self:_refreshListView()
end

function BagNewEquipBagComp:_updateSellBtnRedPoint()
	if self.m_sellBtn.m_redPointComp then
		self.m_sellBtn.m_redPointComp:setShow(g.core.model.User.equipmentData:countEquipmentNum() >= g.core.model.User.equipmentData:getBagLimit())
	end
end

function BagNewEquipBagComp:_onOpObjectUpdate()
	self:_updateSellBtnRedPoint()
end

function BagNewEquipBagComp:_refreshListView(arg_12_1)
	self:_updateEquipNum()
	self:_updateEquipData()

	if self._curTabIndex == 0 then
		self:_updateEquipList(true, arg_12_1)
	else
		self:_updateFragList(true, arg_12_1)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp
		})
	end
end

function BagNewEquipBagComp:_updateEquipList(arg_13_1, arg_13_2)
	if self:_updateEmptyState(0) then
		return
	end

	self:_refreshEquipList(arg_13_2)

	if arg_13_1 then
		self:_updateEquipInfoByIndex((self:_selectEquipListIndex() or 0) + 1)
	end
end

function BagNewEquipBagComp:_onEquipItemRenderer(arg_14_1, arg_14_2)
	arg_14_2:update(self._equipData[arg_14_1 + 1])
end

function BagNewEquipBagComp:_updateFragList(arg_15_1, arg_15_2)
	if self:_updateEmptyState(1) then
		return
	end

	self:_refreshFragList(arg_15_2)

	if arg_15_1 then
		self:_updateFragInfoByIndex((self:_selectFragListIndex() or 1) + 1)
	end
end

function BagNewEquipBagComp:_onFragItemRenderer(arg_16_1, arg_16_2)
	arg_16_2:update((clone(self._fragListData[arg_16_1 + 1])))
end

function BagNewEquipBagComp:fitPosition()
	if not self._fited then
		self._fited = true

		local var_17_0 = self.m_equipList:getFromPool()
		local var_17_1 = var_17_0:getWidth()

		self.m_equipList:returnToPool(var_17_0)

		local var_17_2 = self.m_equipList:getWidth()
		local var_17_3 = self.m_equipList:getColumnGap()
		local var_17_4 = math.floor(var_17_2 / (var_17_1 + var_17_3))

		if var_17_2 - (var_17_4 * var_17_1 + var_17_3) >= var_17_1 + var_17_3 then
			var_17_4 = var_17_4 + 1
		end

		local var_17_5 = (var_17_2 - (var_17_1 + var_17_3) * var_17_4) / 4
		local var_17_6 = self.m_equipList:getX() + (var_17_2 - (var_17_1 + var_17_3) * var_17_4) / 4

		self.m_equipList:setX(var_17_6)
		self.m_fragList:setX(var_17_6)
		self.m_hideInWearBtn:setX(self.m_hideInWearBtn:getX() - var_17_5 * 2)
	end
end

function BagNewEquipBagComp:_refreshFragList(arg_18_1)
	self:fitPosition()
	self.m_fragList:setNumItems(#self._fragListData)

	if #self._fragListData > 0 then
		self.m_fragList:addSelection(self:_selectFragListIndex(), true)
	end

	if arg_18_1 then
		self.m_fragList:transitionShowCells("listIconUiScaleIn", 0.03, 1)
	end
end

function BagNewEquipBagComp:_refreshEquipList(arg_19_1)
	self:fitPosition()
	self.m_equipList:setNumItems(#self._equipData)

	if #self._equipData > 0 then
		self.m_equipList:addSelection(self:_selectEquipListIndex(), true)
	end

	if arg_19_1 then
		self.m_equipList:transitionShowCells("listIconUiScaleIn", 0.03, 1)
	end
end

function BagNewEquipBagComp:_updateEmptyState(arg_20_1)
	if self._curTabIndex == arg_20_1 then
		local var_20_0 = false

		var_20_0 = arg_20_1 == 0 and self._isEquipEmpty or #self._fragListData == 0

		self:setCtrlState("isEmpty", {
			index = var_20_0 and 1 or 0
		})

		if var_20_0 then
			-- block empty
		end

		return var_20_0
	else
		return false
	end
end

function BagNewEquipBagComp:_updateFragInfo(arg_21_1)
	self:_updateFragInfoByIndex(arg_21_1:getDataValue() + 1)
end

function BagNewEquipBagComp:_updateEquipInfo(arg_22_1)
	self:_updateEquipInfoByIndex(arg_22_1:getDataValue() + 1)
end

function BagNewEquipBagComp:_updateFragInfoByIndex(arg_23_1)
	if not next(self._fragListData) then
		return
	end

	if not self._fragListData[arg_23_1] then
		return
	end

	local var_23_0 = self._fragListData[arg_23_1]

	self._curFragIndex = arg_23_1

	local var_23_1 = var_23_0.size

	self._curSelectFragId = var_23_0.info.id

	local var_23_2 = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_EQUIP,
		value = var_23_0.info.id
	})
	local var_23_3 = g.core.config.fragment_info.get(var_23_0.info.id)

	self:_updateEquipInfoView({
		loaderUrl = var_0_2:getBagNewQualityBgPath(var_23_2.quality),
		icon = var_23_2.pic,
		title = var_23_3.name,
		progressTxt = var_23_1 .. "/" .. var_23_3.combine_num,
		canCompose = var_23_1 >= var_23_3.combine_num,
		good = var_23_2,
		fragData = var_23_0
	}, true)
end

function BagNewEquipBagComp:_updateEquipInfoByIndex(arg_24_1)
	if not next(self._equipData) then
		return
	end

	if not self._equipData[arg_24_1] then
		return
	end

	local var_24_0 = self._equipData[arg_24_1]

	self._curEquipIndex = arg_24_1

	local var_24_1 = var_24_0:getCfg()

	self._curSelectEquipId = var_24_0:getServerData().id

	local var_24_2 = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_EQUIP,
		value = var_24_1.id
	})
	local var_24_3 = var_24_0:getOwner()
	local var_24_4, var_24_5, var_24_6 = var_24_0:getEquipAttrAll()

	var_24_4.good = var_24_2
	var_24_5.good = var_24_2
	var_24_6.good = var_24_2

	self:_updateEquipInfoView({
		strengthAttrs = var_24_4,
		refineAttrs = var_24_5,
		equipId = self._curSelectEquipId,
		isWear = checkbool(var_24_3) and 1 or 0,
		equipData = var_24_0,
		loaderUrl = var_0_2:getBagNewQualityBgPath(var_24_2.quality),
		icon = var_24_2.pic,
		title = var_24_1.name
	}, false)
end

function BagNewEquipBagComp:_selectFragListIndex()
	if not self._curSelectFragId then
		return 0
	end

	for iter_25_0, iter_25_1 in ipairs(self._fragListData) do
		if iter_25_1.info.id == self._curSelectFragId then
			return iter_25_0 - 1
		end
	end

	self._curSelectFragId = nil

	return 0
end

function BagNewEquipBagComp:_selectEquipListIndex()
	if not self._curSelectEquipId then
		return 0
	end

	for iter_26_0, iter_26_1 in ipairs(self._equipData) do
		if iter_26_1:getServerData().id == self._curSelectEquipId then
			return iter_26_0 - 1
		end
	end

	self._curSelectEquipId = nil

	return 0
end

function BagNewEquipBagComp:_switchTabCtrl()
	self._curTabIndex = self.m_tabController:getSelectedIndex()

	if self._curTabIndex == 0 then
		self:_updateEquipList(true, true)
	else
		self:_updateFragList(true, true)
	end
end

function BagNewEquipBagComp:_onChangeTabCtrl()
	self:_switchTabCtrl()
end

function BagNewEquipBagComp:_onClickSell()
	if g.core.model.User.equipmentData:isHasSellEquipOrFrag(self._curTabIndex + 1) then
		self:addPopup(require("app.view.module.bagNew.view.equip.EquipSellPop").new(self._curTabIndex + 1))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(201547))
	end
end

function BagNewEquipBagComp:receiveCompEvent(arg_30_1, arg_30_2)
	if arg_30_1 == "EquipBagComp_checkbox" then
		self._isNotWear = arg_30_2.isSelected

		self:_refreshListView()
	elseif arg_30_1 == "EquipBagComp_pos" then
		self._typeIndex = arg_30_2.index

		self:_refreshListView()
	elseif arg_30_1 == "EquipBagComp_quality" then
		self._qualityIndex = arg_30_2.index

		self:_refreshListView()
	elseif arg_30_1 == "EquipBagCellComp_develop" then
		g.core.module.ModuleManager:pushModule(g.view.entrance.EQUIP_DEVELOP, 1, arg_30_2)
	end
end

function BagNewEquipBagComp:playEnterAnim()
	self.m_equipInfoComp:playEnterAnim()
end

function BagNewEquipBagComp:_checkCondition(arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	local var_32_0 = arg_32_4:getCfg()
	local var_32_1 = arg_32_2 or 0
	local var_32_3 = true

	if (arg_32_2 or 0) ~= 0 then
		if var_32_1 == 1 then
			var_32_3 = var_32_0.quality == g.core.const.ConstMgr.QUALITY_TYPE.GREEN or var_32_0.quality == g.core.const.ConstMgr.QUALITY_TYPE.BULE
		elseif var_32_1 == 2 then
			var_32_3 = var_32_0.quality == g.core.const.ConstMgr.QUALITY_TYPE.PURPLE
		elseif var_32_1 == 3 then
			var_32_3 = var_32_0.quality == g.core.const.ConstMgr.QUALITY_TYPE.ORANGE and var_32_0.rare == 0
		elseif var_32_1 == 4 then
			var_32_3 = var_32_0.quality == g.core.const.ConstMgr.QUALITY_TYPE.ORANGE and var_32_0.rare == 1
		end
	end

	return ((arg_32_1 or 0) == 0 or (arg_32_1 or 0) == var_32_0.type) and var_32_3 and (arg_32_3 or false or nil) and arg_32_4:getServerData().position == 0
end

function BagNewEquipBagComp:_getEquipList(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = g.core.model.User.equipmentData:getEquipList()
	local var_33_1 = {}

	if arg_33_1 == 0 and arg_33_2 == 0 and not arg_33_3 then
		for iter_33_0 = 1, #var_33_0.allIndex do
			if not var_33_0.allIndex[iter_33_0]:isInitEquipment() then
				table.insert(var_33_1, var_33_0.allIndex[iter_33_0])
			end
		end
	else
		for iter_33_1, iter_33_2 in ipairs(var_33_0.allIndex) do
			if self:_checkCondition(arg_33_1, arg_33_2, arg_33_3, iter_33_2) and not iter_33_2:isInitEquipment() then
				table.insert(var_33_1, iter_33_2)
			end
		end
	end

	if arg_33_4 then
		self:_sortAllEquip(var_33_1)
	end

	return var_33_1
end

function BagNewEquipBagComp:_sortAllEquip(arg_34_1)
	table.sort(arg_34_1, function(arg_35_0, arg_35_1)
		local var_35_0 = arg_35_0:getPosition()
		local var_35_1 = arg_35_1:getPosition()
		local var_35_2 = arg_35_0:getCfg()
		local var_35_3 = arg_35_1:getCfg()
		local var_35_4 = arg_35_0:getServerData()
		local var_35_5 = arg_35_1:getServerData()

		if var_35_0 ~= 0 and var_35_1 ~= 0 then
			return var_35_0 < var_35_1
		elseif var_35_0 == 0 and var_35_1 == 0 then
			if var_35_2.quality ~= var_35_3.quality then
				return var_35_2.quality > var_35_3.quality
			else
				local var_35_6 = var_35_4.magical_stage or 0
				local var_35_7 = var_35_5.magical_stage or 0

				if var_35_6 ~= var_35_7 then
					return var_35_7 < var_35_6
				end

				if var_35_4.level ~= var_35_5.level then
					return var_35_4.level > var_35_5.level
				end

				if var_35_4.refining_level ~= var_35_5.refining_level then
					return var_35_4.refining_level > var_35_5.refining_level
				end

				if var_35_4.glyph_level ~= var_35_5.glyph_level then
					return var_35_4.glyph_level > var_35_5.glyph_level
				end

				return var_35_2.id < var_35_3.id
			end
		else
			return var_35_1 < var_35_0
		end
	end)
end

function BagNewEquipBagComp:_onRebornClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.REBORN) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.REBORN, {
			index = require("app.view.module.reborn.const.RebornConst").SELECT_INDEX_MAP.EQUIP
		})
	end
end

function BagNewEquipBagComp:_onHideInWearChange()
	self._isNotWear = self.m_hideInWearBtn:isSelected()

	self:_updateEquipData()
	self:_updateEquipList(true)
	self.m_equipList:scrollToView(0, false)
end

function BagNewEquipBagComp:_updateEquipNum()
	local var_38_0 = #self:_getEquipList(0, 0, false)

	self._isEquipEmpty = var_38_0 == 0

	if not self._isEquipEmpty then
		self.m_bagNumComp:showNum(var_38_0, g.core.config.role_info.get(g.core.model.User:getLevel()).equipment_bag_num_client)
	end
end

function BagNewEquipBagComp:_updateEquipInfoView(arg_39_1, arg_39_2)
	self.m_equipInfoComp:updateEquipInfo(arg_39_1, arg_39_2)
end

return BagNewEquipBagComp
