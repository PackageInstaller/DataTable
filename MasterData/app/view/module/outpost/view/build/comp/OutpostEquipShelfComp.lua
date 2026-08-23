local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostEquipShelfComp = class("OutpostEquipShelfComp", require("app.fairyGUI.outpost.UI_OutpostEquipShelfComp"))

function OutpostEquipShelfComp:ctor()
	self.getSharedTrans(self, "enter_scaleOut", "CommonCardCellList", self)

	self._equip = nil
end

function OutpostEquipShelfComp:updateShelfComp(arg_2_1)
	self._equip = arg_2_1.equip

	local var_2_0 = arg_2_1.equip:getCfg()

	self.m_itemComp:updateItemCell({
		res = g.core.common.Path:getOutpostEquipIcon(var_2_0.res),
		name = var_2_0.name,
		quality = var_2_0.quality
	})
	self.m_costResComp:updateByTVS({
		type = var_0_0.EXCHANGE_ITEM_TYPE,
		value = var_0_0.KNIGHT_COIN_ID,
		size = var_2_0.gold
	})

	if var_2_0.equip_type ~= var_0_0.EquipType.ARMS then
		self.m_equip:setVisible(false)
	else
		self.m_placeLoader:setURL("ui://outpost/pic_hxsz_zhiye" .. var_2_0.profession)
		self.m_equip:setVisible(true)
	end

	self.m_numTxt:setText(arg_2_1.order.num)
	self.m_starComp:initStar({
		gap = -20,
		style = 1,
		index = arg_2_1.equip:getStarIndex(),
		num = arg_2_1.equip:getStar()
	})
	self:newSchedule(handler(self, self._updateCostCompPos), 0)
end

function OutpostEquipShelfComp:_updateCostCompPos()
	local var_3_0 = self.m_costResComp:getSize()

	var_3_0.width = var_3_0.width - 60

	local var_3_1 = self.m_costResComp:getPosition()

	var_3_1.x = (self:getSize().width - var_3_0.width) / 4 + 12

	self.m_costResComp:setPosition(var_3_1)
end

function OutpostEquipShelfComp:_getOwnNum()
	return g.core.model.User.outpostData:getBagData():getOwnNum({
		type = var_0_0.EXCHANGE_ITEM_TYPE,
		value = var_0_0.KNIGHT_COIN_ID,
		size = self._equip:getCfg().gold
	})
end

return OutpostEquipShelfComp
